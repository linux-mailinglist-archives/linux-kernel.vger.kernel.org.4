Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20656ABA29
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCFJli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCFJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:41:33 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07B4233ED;
        Mon,  6 Mar 2023 01:41:28 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=0443564136=fe@dev.tdt.de>)
        id 1pZ7LO-000MJY-7a; Mon, 06 Mar 2023 10:41:22 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pZ7LN-000QiD-CT; Mon, 06 Mar 2023 10:41:21 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id DE7F4240049;
        Mon,  6 Mar 2023 10:41:20 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 55196240040;
        Mon,  6 Mar 2023 10:41:20 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id C593620E0D;
        Mon,  6 Mar 2023 10:41:19 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: [PATCH v8 0/3] leds: ledtrig-tty: add tty_led_mode xtension
Date:   Mon,  6 Mar 2023 10:41:10 +0100
Message-ID: <20230306094113.273988-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1678095682-2D6EF8D8-3A23565D/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here commes v8 of this series to add additional tty_led_modes.

v8:
Changes compared to the v7 patchset with
20230222083335.847655-1-fe@dev.tdt.de are.

* Update 'Documentation/ABI/testing/sysfs-class-led-trigger-tty'
  with the suggested changes.
* Use a meaningfull name for the Rx/Tx enum.
* Do not use C++ comments style

Add a new patch 'ledtrig-tty-fix-brightness-set' to fix an issue with
LEDs that are connected via GPIOs to the SOC with the device driver
'leds-gpio'. In my view, the wrong function is being used here. LEDs
that do not need and do not have a delayed call do not work with the
current implementation. Therefore, the 'led_set_brightness_nosleep'
function must be used.


v7:
Changes compared to the v5 patchset with
20230222075539.484878-1-fe@dev.tdt.de are.

Addressed review comments by Jiri Slaby are:

Thanks for the hint with the command 'make htmldocs SPHINXDIRS=3D"admin-g=
uide"'.
Unfortunately, I did not know that. I have now verified it also in the
browser. In my opinion, the list is now also displayed correctly in
the documentation.


v6:
Changes compared to the v5 patchset with
20230221081901.15557-1-fe@dev.tdt.de are.

Addressed review comments by kernel test robot are:

* fix Documentation/ABI/testing/sysfs-class-led-trigger-tty:9:
  WARNING: Unexpected indentation.
* fix Documentation/ABI/testing/sysfs-class-led-trigger-tty:9:
  WARNING: Block quote ends without a blank line; unexpected unindent.

Thanks to Jiri Slaby, who gave me the crucial hint of what I need to fix,
to possibly make the 'Kernel test robot' happy.


v5:
Changes compared to the v4 patchset with
20230220152038.3877596-1-fe@dev.tdt.de are.

Sorry for the inconvenience, but I sent the wrong patch for
ledtrig-tty.c in v4. The v5 patchset now includes all the changes I
specified in the v4 patchset.


v4:
Changes compared to the v3 patchset with
20230220093739.320478-1-fe@dev.tdt.de are.

Addressed review comments by Jiri Slaby are:

ledtrig-tty.c:
- Do not use __TTY_LED_MAX pattern us instead __TTY_LED_LAST =3D TTY_LED_=
RNG
- Move declartion and assignment into one singel line
- Use __TTY_LED_LAST pattern, to simplify tty_mode_show and
  tty_mode_store handling


v3:
Changes compared to the v2 patchset with
20230217094403.1574468-1-fe@dev.tdt.de are.

Addressed review comments by Greg K-H are:

tty.h:
- Fix first comment line and remark -%ENOTTY for the new function
  'tty_get_mget' to make a proper kernel doc.
- Add the return value -%ENOTTY again, I thought it was no longer needed.


v2:
Changes compared to the initial patchset with
20230213140638.620206-1-fe@dev.tdt.de are.

Addressed review comments by Jiri Slaby are:

tty.h:
- Fix compilation error because of wrong rebaseing
- Remove empty lines
- Use new 'tty_get_mget' in 'tty_tiocmget'

ledtrig-tty.c:
- Update commit description
- Use enum for tty_led_mod in struct ledtrig_tty_date
- Rename sysfs file from 'mode' to 'tty_led_mode'
- Change tty_led_mode show function to use loop instead of switch/case
- Change tty_led_mode store function to use loop instead of switch/case
- Check return value of function tty_get_mget

Florian Eckert (3):
  tty: new helper function tty_get_mget
  trigger: ledtrig-tty: add additional modes
  ledtrig-tty: call correct brightness set function

 .../ABI/testing/sysfs-class-led-trigger-tty   |  18 +++
 drivers/leds/trigger/ledtrig-tty.c            | 145 ++++++++++++++++--
 drivers/tty/tty_io.c                          |  28 +++-
 include/linux/tty.h                           |   1 +
 4 files changed, 171 insertions(+), 21 deletions(-)

--=20
2.30.2

