import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:video_conferencing_application/resources/auth_methods.dart';
import 'package:video_conferencing_application/resources/firestone_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      String name =
          username.isNotEmpty ? username : _authMethods.user?.displayName ?? '';
      var jitsiMeet = JitsiMeet();
      var options = JitsiMeetConferenceOptions(
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: name,
          avatar: _authMethods.user?.photoURL,
          email: _authMethods.user?.email,
        ),
      );

      _firestoreMethods.addToMeetingHistory(roomName);

      jitsiMeet.join(options);
    } catch (error, stackTrace) {
      print("Error: $error");
      print("Stack trace: $stackTrace");
    }
  }
}
