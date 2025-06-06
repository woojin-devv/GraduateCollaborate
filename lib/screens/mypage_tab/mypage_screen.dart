import 'package:flutter/material.dart';
import 'package:phonics/screens/mypage_tab/mypage_to_deleteaccount.dart';
import 'package:phonics/screens/mypage_tab/mypage_to_notice.dart';
import 'package:phonics/screens/mypage_tab/mypage_to_voicesetting.dart';
import '../library_tab/home_tab_screen.dart';
import '../home.dart';
import '../study_tab/study_tab.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'package:phonics/screens/mypage_tab/mypage_to_favoritebooks.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 4;

  //toggle
  bool isTopSelected = true;
  late AnimationController _toggleController;
  late Animation<double> _animation;

  //'확인' 버튼
  final TextEditingController _inputController = TextEditingController();
  final bool _isInputValid = false;

  @override
  void initState() {
    super.initState();
    _toggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation =
        CurvedAnimation(parent: _toggleController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _toggleController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    Widget page;
    switch (index) {
      case 0:
        page = const MyHomePage();
        break;
      case 1:
        page = const HomeTabScreen();
        break;
      case 2:
        page = const StudyScreen();
        break;
      // case 3:
      //   page = 책만들기();
      // break;
      case 4:
        page = const MypageScreen();
        break;
      default:
        page = const MyHomePage();
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerHeight = screenWidth * 0.69444444444;
    final double toggleHeight = screenWidth * 0.13125;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFEB),
      body: Stack(
        children: [
          // 배경 색을 위한 기본 Column 구조
          Column(
            children: [
              Container(
                height: containerHeight,
                color: const Color(0xffFDE047), // 상단 배경
              ),
              Expanded(
                child: Container(
                  color: const Color(0xffFFFFEB), // 하단 배경
                ),
              ),
            ],
          ),

          // 상단 고정 프로필
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: buildProfileContainer(),
          ),

          // 아래 스크롤 콘텐츠
          Positioned(
            top: containerHeight - toggleHeight / 2,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: toggleHeight / 2),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  _buildMenuSection(),
                  _buildMenuSection2(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          //토글 버튼
          Positioned(
            top: containerHeight - toggleHeight / 2,
            left: (screenWidth - screenWidth * 0.925) / 2,
            child: buildToggleButton(screenWidth),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  Widget _buildMenuSection() {
    double screenWidth = MediaQuery.of(context).size.width;
    double sectionWidth = screenWidth * 0.89722222222;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: sectionWidth,
        decoration: const BoxDecoration(
          color: Color(0xffFAFAD1),
          borderRadius: BorderRadius.all(Radius.circular(13)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('서비스'),
            Container(height: 1, color: const Color(0xffDFC7AB)),
            const SizedBox(height: 10),
            _buildMenuItem(
              '음성세팅',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MypageToVoicesetting()),
                );
              },
            ),
            _buildMenuItem(
              '찜한 책 목록',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MypageToFavoritebooks()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection2() {
    double screenWidth = MediaQuery.of(context).size.width;
    double sectionWidth = screenWidth * 0.89722222222;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: sectionWidth,
        decoration: const BoxDecoration(
          color: Color(0xffFAFAD1),
          borderRadius: BorderRadius.all(Radius.circular(13)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('개인정보 및 설정'),
            Container(height: 1, color: const Color(0xffDFC7AB)),
            const SizedBox(height: 10),
            _buildMenuItem(
              '공지사항',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MypageToNotice()),
                );
              },
            ),
            _buildMenuItem(
              '탈퇴하기',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MypageToDeleteaccount()),
                );
              },
            ),
            _buildMenuItem(
              '로그아웃',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MypageToDeleteaccount()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileContainer() {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerHeight = screenWidth * 0.69444444444;
    double profileDiameter = screenWidth * 0.25;

    return Stack(
      children: [
        Container(
          height: containerHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            color: Color(0xffFFDF5F),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const SizedBox(width: 20),
                Image.asset(
                  'assets/images/mypage/mypage_profile_mother.png',
                  width: profileDiameter,
                  height: profileDiameter,
                ),
                const SizedBox(width: 16),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Real Name',
                      style: TextStyle(
                        fontFamily: 'GyeonggiTitleVBold',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff525152),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '학부모 / 자녀 ',
                      style: TextStyle(
                        fontFamily: 'GyeonggiTitleLight',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xff525152),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Color(0xff525152)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        contentPadding: EdgeInsets.zero,
        dense: true,
        onTap: onTap, // 외부에서 받은 콜백 사용
      ),
    );
  }

  Widget buildToggleButton(double screenWidth) {
    double toggleWidth = screenWidth * 0.925;
    double toggleHeight = screenWidth * 0.13125;

    return Center(
      child: Container(
        width: toggleWidth,
        height: toggleHeight,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 2,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment:
                  isTopSelected ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: toggleWidth / 2,
                height: toggleHeight - 8,
                decoration: BoxDecoration(
                  color: const Color(0xffFAC632),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                // 학부모 탭 (왼쪽)
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (!isTopSelected) {
                        final tempController = TextEditingController();
                        bool isInputValid = false;

                        final result = await showModalBottomSheet<bool>(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          backgroundColor: Colors.white,
                          isDismissible: true,
                          isScrollControlled: true, // 키보드 올라와도 대응
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setModalState) {
                                return Padding(
                                  padding: MediaQuery.of(context)
                                      .viewInsets, // 키보드 대응
                                  child: Container(
                                    padding: const EdgeInsets.all(25),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '학부모 탭으로 넘어가기 위해, 아래의 단어를 입력해주세요.',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff363535),
                                            fontFamily: 'GyeonggiTitleLight',
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xffF1F1F1),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Text(
                                            '그루터기',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xff363535),
                                              fontFamily: 'GyeonggiTitleVBold',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        TextField(
                                          controller: tempController,
                                          autofocus: true,
                                          onChanged: (value) {
                                            setModalState(() {
                                              isInputValid =
                                                  value.trim() == '그루터기';
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: '위 텍스트를 입력해주세요.',
                                            filled: true,
                                            fillColor: const Color(0xffF2F2F2),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: !isInputValid &&
                                              tempController.text.isNotEmpty,
                                          child: const Text(
                                            '일치하지 않습니다.',
                                            style: TextStyle(
                                                color: Color(0xffD84040)),
                                          ),
                                        ),
                                        const SizedBox(height: 40),
                                        TextButton(
                                          onPressed: isInputValid
                                              ? () {
                                                  Navigator.pop(context, true);
                                                }
                                              : null,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            decoration: BoxDecoration(
                                              color: isInputValid
                                                  ? const Color(0xffFFFCC3)
                                                  : const Color(0xffF3F3F3),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              '확인',
                                              style: TextStyle(
                                                color: isInputValid
                                                    ? const Color(0xffA57444)
                                                    : const Color(0xffBCBCBC),
                                                fontFamily: 'GyeonggiTitleBold',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );

                        if (result == true) {
                          setState(() {
                            isTopSelected = true;
                            _toggleController.reverse();
                          });
                        } else {
                          setState(() {
                            isTopSelected = false;
                            _toggleController.forward();
                          });
                        }
                      }
                    },
                    child: Center(
                      child: Text(
                        '학부모',
                        style: TextStyle(
                          color: isTopSelected
                              ? const Color(0xff363535)
                              : const Color(0xffA5A5A5).withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),

                // 자녀 탭 (오른쪽)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isTopSelected = false;
                        _toggleController.forward();
                      });
                    },
                    child: Center(
                      child: Text(
                        '자녀',
                        style: TextStyle(
                          color: isTopSelected
                              ? const Color(0xffA5A5A5).withOpacity(0.5)
                              : const Color(0xff363535),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
