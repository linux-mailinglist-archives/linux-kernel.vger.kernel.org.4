Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC86EFC50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjDZVSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239967AbjDZVSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA3DDE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71ACA63030
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 21:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C837FC433D2;
        Wed, 26 Apr 2023 21:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682543908;
        bh=Ls96OemEaO7b0mdp0Ic4F9L9hudVBfWaYouJRvsuLxU=;
        h=Date:From:To:cc:Subject:From;
        b=E171L7ffpQoMPFT5DSrdE6LMazG3xbYUAm231FdNtw/NLx7khUJU/TD5f/EjK67FJ
         TqIaO0qyYZoDJVc0oPe/dS/TVFi38er8ktZRfwSyLXViLz/9W/vRTR+oNADQIxuZJ1
         bY9CrRppSUTZ1scvx7BOEMbQCqpWxHrnDadCSEah7PJpo8VdWjAYL4LzWy6hjmivEt
         /jVXsdu2/ON1bDMHzqQ1fVldwgnAOkEc6Xf9/WlKjZb1JkEuVmDoZQODJ53ukuy3iQ
         06KsS0McJp9IuND/1CNvZ9Jralwz3+SgK9r9SSAce+m2Zrp5zhxYkVvmultmr6wskk
         30Q0l3LGdtzfQ==
Date:   Wed, 26 Apr 2023 23:18:25 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.4
Message-ID: <nycvar.YFH.7.76.2304262313100.29760@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023042601

to receive HID subsystem queue for 6.4. Highlights:

=====
- import of bunch of HID selftests from out-of-tree hid-tools project
  (Benjamin Tissoires)
- drastically reducing Bluetooth disconnects on hid-nintendo driven 
  devices (Daniel J. Ogorchock)
- lazy initialization of battery interfaces in wacom driver (Jason 
  Gerecke)
- generic support for all Kye tablets (David Yang)
- proper rumble queue overrun handling in hid-nintendo (Daniel J. 
  Ogorchock)
- support for ADC measurement in logitech-hidpp driver (Bastien Nocera)
- reset GPIO support in i2c-hid (Hans de Goede)
- improved handling of generic "Digitizer" usage (Jason Gerecke)
- support for KEY_CAMERA_FOCUS (Feng Qi)
- quirks for Apple Geyser 3 and Apple Geyser 4 (Alex Henrie)
- assorted functional fixes and device ID additions
=====

Alex Henrie (2):
      HID: apple: Set the tilde quirk flag on the Geyser 4 and later
      HID: apple: Set the tilde quirk flag on the Geyser 3

Basavaraj Natikar (9):
      HID: amd_sfh: Correct the structure fields
      HID: amd_sfh: Correct the sensor enable and disable command
      HID: amd_sfh: Fix illuminance value
      HID: amd_sfh: Add support for shutdown operation
      HID: amd_sfh: Correct the stop all command
      HID: amd_sfh: Increase sensor command timeout for SFH1.1
      HID: amd_sfh: Handle "no sensors" enabled for SFH1.1
      HID: amd_sfh: Support for additional light sensor
      HID: amd_sfh: Fix max supported HID devices

Bastien Nocera (9):
      HID: logitech-hidpp: Don't use the USB serial for USB devices
      HID: logitech-hidpp: Reconcile USB and Unifying serials
      HID: logitech-hidpp: Simplify array length check
      HID: logitech-hidpp: Add support for ADC measurement feature
      HID: logitech-hidpp: Add Logitech G935 headset
      USB: core: Add wireless_status sysfs attribute
      USB: core: Add API to change the wireless_status
      HID: logitech-hidpp: Set wireless_status for G935 receiver
      USB: core: Fix docs warning caused by wireless_status feature

Benjamin Tissoires (11):
      selftests: hid: make vmtest rely on make
      selftests: hid: import hid-tools hid-core tests
      selftests: hid: import hid-tools hid-gamepad tests
      selftests: hid: import hid-tools hid-keyboards tests
      selftests: hid: import hid-tools hid-mouse tests
      selftests: hid: import hid-tools hid-multitouch and hid-tablets tests
      selftests: hid: import hid-tools wacom tests
      selftests: hid: import hid-tools hid-apple tests
      selftests: hid: import hid-tools hid-ite tests
      selftests: hid: import hid-tools hid-sony and hid-playstation tests
      selftests: hid: import hid-tools usb-crash tests

Daniel J. Ogorchock (2):
      HID: nintendo: prevent rumble queue overruns
      HID: nintendo: fix rumble rate limiter

David Yang (5):
      HID: kye: Rewrite tablet descriptor fixup routine
      HID: kye: Generate tablet fixup descriptors on the fly
      HID: kye: Sort kye devices
      HID: kye: Add support for all kye tablets
      HID: kye: Fix rdesc for kye tablets

Hans de Goede (3):
      HID: i2c-hid-of: Consistenly use dev local variable in probe()
      HID: i2c-hid-of: Allow using i2c-hid-of on non OF platforms
      HID: i2c-hid-of: Add reset GPIO support to i2c-hid-of

Jason Gerecke (3):
      HID: Recognize "Digitizer" as a valid input application
      HID: wacom: Lazy-init batteries
      HID: wacom: generic: Set battery quirk only when we see battery data

Louis Morhet (2):
      HID: mcp2221: fix report layout for gpio get
      HID: mcp2221: fix get and get_direction for gpio

Ping Cheng (2):
      HID: wacom: insert timestamp to packed Bluetooth (BT) events
      HID: wacom: Set a default resolution for older tablets

Thomas Weiﬂschuh (4):
      HID: apple: explicitly include linux/leds.h
      HID: steelseries: explicitly include linux/leds.h
      HID: lg-g15: explicitly include linux/leds.h
      HID: asus: explicitly include linux/leds.h

fengqi (1):
      HID: add KEY_CAMERA_FOCUS event in HID

weiliang1503 (1):
      HID: Ignore battery for ELAN touchscreen on ROG Flow X13 GV301RA

 Documentation/ABI/testing/sysfs-bus-usb            |   17 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c           |    1 +
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h              |    2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |   13 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h             |    1 +
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  |    4 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      |    2 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c      |   11 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c |   10 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h |    8 +-
 drivers/hid/hid-apple.c                            |   20 +-
 drivers/hid/hid-asus.c                             |    1 +
 drivers/hid/hid-ids.h                              |   10 +-
 drivers/hid/hid-input.c                            |   12 +
 drivers/hid/hid-kye.c                              |  924 ++++-----
 drivers/hid/hid-lg-g15.c                           |    1 +
 drivers/hid/hid-logitech-hidpp.c                   |  256 ++-
 drivers/hid/hid-mcp2221.c                          |    6 +-
 drivers/hid/hid-nintendo.c                         |   95 +-
 drivers/hid/hid-quirks.c                           |   14 +-
 drivers/hid/hid-steelseries.c                      |    1 +
 drivers/hid/i2c-hid/Kconfig                        |    6 +-
 drivers/hid/i2c-hid/i2c-hid-of.c                   |   38 +-
 drivers/hid/wacom_sys.c                            |   10 -
 drivers/hid/wacom_wac.c                            |   84 +-
 drivers/hid/wacom_wac.h                            |    1 +
 drivers/usb/core/message.c                         |   40 +
 drivers/usb/core/sysfs.c                           |   50 +
 drivers/usb/core/usb.h                             |    1 +
 include/linux/hid.h                                |    3 +-
 include/linux/usb.h                                |   16 +
 tools/testing/selftests/hid/Makefile               |   12 +
 tools/testing/selftests/hid/config                 |   11 +
 tools/testing/selftests/hid/hid-apple.sh           |    7 +
 tools/testing/selftests/hid/hid-core.sh            |    7 +
 tools/testing/selftests/hid/hid-gamepad.sh         |    7 +
 tools/testing/selftests/hid/hid-ite.sh             |    7 +
 tools/testing/selftests/hid/hid-keyboard.sh        |    7 +
 tools/testing/selftests/hid/hid-mouse.sh           |    7 +
 tools/testing/selftests/hid/hid-multitouch.sh      |    7 +
 tools/testing/selftests/hid/hid-sony.sh            |    7 +
 tools/testing/selftests/hid/hid-tablet.sh          |    7 +
 tools/testing/selftests/hid/hid-usb_crash.sh       |    7 +
 tools/testing/selftests/hid/hid-wacom.sh           |    7 +
 tools/testing/selftests/hid/run-hid-tools-tests.sh |   28 +
 tools/testing/selftests/hid/settings               |    3 +
 tools/testing/selftests/hid/tests/__init__.py      |    2 +
 tools/testing/selftests/hid/tests/base.py          |  345 ++++
 tools/testing/selftests/hid/tests/conftest.py      |   81 +
 .../selftests/hid/tests/descriptors_wacom.py       | 1360 +++++++++++++
 .../selftests/hid/tests/test_apple_keyboard.py     |  440 +++++
 tools/testing/selftests/hid/tests/test_gamepad.py  |  209 ++
 tools/testing/selftests/hid/tests/test_hid_core.py |  154 ++
 .../selftests/hid/tests/test_ite_keyboard.py       |  166 ++
 tools/testing/selftests/hid/tests/test_keyboard.py |  485 +++++
 tools/testing/selftests/hid/tests/test_mouse.py    |  977 +++++++++
 .../testing/selftests/hid/tests/test_multitouch.py | 2088 ++++++++++++++++++++
 tools/testing/selftests/hid/tests/test_sony.py     |  342 ++++
 tools/testing/selftests/hid/tests/test_tablet.py   |  872 ++++++++
 .../testing/selftests/hid/tests/test_usb_crash.py  |  103 +
 .../selftests/hid/tests/test_wacom_generic.py      |  844 ++++++++
 tools/testing/selftests/hid/vmtest.sh              |   25 +-
 62 files changed, 9657 insertions(+), 625 deletions(-)
 create mode 100755 tools/testing/selftests/hid/hid-apple.sh
 create mode 100755 tools/testing/selftests/hid/hid-core.sh
 create mode 100755 tools/testing/selftests/hid/hid-gamepad.sh
 create mode 100755 tools/testing/selftests/hid/hid-ite.sh
 create mode 100755 tools/testing/selftests/hid/hid-keyboard.sh
 create mode 100755 tools/testing/selftests/hid/hid-mouse.sh
 create mode 100755 tools/testing/selftests/hid/hid-multitouch.sh
 create mode 100755 tools/testing/selftests/hid/hid-sony.sh
 create mode 100755 tools/testing/selftests/hid/hid-tablet.sh
 create mode 100755 tools/testing/selftests/hid/hid-usb_crash.sh
 create mode 100755 tools/testing/selftests/hid/hid-wacom.sh
 create mode 100755 tools/testing/selftests/hid/run-hid-tools-tests.sh
 create mode 100644 tools/testing/selftests/hid/settings
 create mode 100644 tools/testing/selftests/hid/tests/__init__.py
 create mode 100644 tools/testing/selftests/hid/tests/base.py
 create mode 100644 tools/testing/selftests/hid/tests/conftest.py
 create mode 100644 tools/testing/selftests/hid/tests/descriptors_wacom.py
 create mode 100644 tools/testing/selftests/hid/tests/test_apple_keyboard.py
 create mode 100644 tools/testing/selftests/hid/tests/test_gamepad.py
 create mode 100644 tools/testing/selftests/hid/tests/test_hid_core.py
 create mode 100644 tools/testing/selftests/hid/tests/test_ite_keyboard.py
 create mode 100644 tools/testing/selftests/hid/tests/test_keyboard.py
 create mode 100644 tools/testing/selftests/hid/tests/test_mouse.py
 create mode 100644 tools/testing/selftests/hid/tests/test_multitouch.py
 create mode 100644 tools/testing/selftests/hid/tests/test_sony.py
 create mode 100644 tools/testing/selftests/hid/tests/test_tablet.py
 create mode 100644 tools/testing/selftests/hid/tests/test_usb_crash.py
 create mode 100644 tools/testing/selftests/hid/tests/test_wacom_generic.py

-- 
Jiri Kosina
SUSE Labs

