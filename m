Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5969B64FD5A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 02:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiLRBGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 20:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLRBGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 20:06:41 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729677674;
        Sat, 17 Dec 2022 17:06:39 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C0F10240003;
        Sun, 18 Dec 2022 01:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1671325598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YStWod4/zbxwyTg2mUGlQ1V/5izn/bmZQdOBB5vAfdU=;
        b=kaN17TMSBG/oXJrrW5Us1xcHg6ei8FmnWx4JxiYLUI3oBsrAk5WExLvNXkLpGe9lZqltl1
        fluf+iPP8t2uG2kIX9wHsRBgOyRpklRIY4WqobTZOjPgc9GUds+yZg6YOuXvcFUXVmPfWT
        qwN6Tb6TLacuag7xkbm5NtDafsNc1HqeeFD4f3jRdoB3rCSHfEk6/na3a6+RL5BaP+bX1s
        2g/wMRyfCjul3bEm/PALVl58VwP7wwBCqf/m/U4IAQQNMHWJ7/MrSZzwJfmyUi3ZtkMtqW
        BieXVop4OULSojnyBTHG3KBJjfC90RoGFHnK4kuoZg6NF9ZlZNPC0bhq4L60kQ==
Date:   Sun, 18 Dec 2022 02:06:37 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 6.2
Message-ID: <Y55nnQv5htuJnuw2@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the RTC subsystem pull request for 6.2. Most of the changes are
a rework of the cmos driver by Rafael and fixes for issues found using
static checkers. The removal of a driver leads to a reduction of the
number of LOC of the subsystem.

The following changes since commit db4e955ae333567dea02822624106c0b96a2f84f:

  rtc: cmos: fix build on non-ACPI platforms (2022-10-18 22:36:54 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.2

for you to fetch changes up to e88f319a2546fd7772c726bf3a82a23b0859ddeb:

  rtc: ds1742: use devm_platform_get_and_ioremap_resource() (2022-12-15 23:34:31 +0100)

----------------------------------------------------------------
RTC for 6.2

Removed driver:
 - davinci

Drivers:
 - convert i2c drivers to .probe_new
 - fix spelling mistakes and duplicated words in comments
 - cmos: rework wake setup and ACPI event handling
 - cros-ec: Limit RTC alarm range to fix alarmtimer
 - ds1347: fix century register handling
 - efi: wakeup support
 - isl12022: temperature sensor support
 - pcf85063: fix read_alarm and clkout
 - pcf8523: use stop bit to detect invalid time
 - pcf8563: use RTC_FEATURE_ALARM
 - snvs: be more flexible on LPSRT reads
 - many static checker fixes

----------------------------------------------------------------
Alexander Stein (1):
      rtc: pcf85063: Fix reading alarm

Alexandre Belloni (2):
      rtc: rx6110: fix warning with !OF
      rtc: pcf85063: fix pcf85063_clkout_control

Arnd Bergmann (1):
      rtc: remove davinci rtc driver

Christophe JAILLET (1):
      rtc: Include <linux/kstrtox.h> when appropriate

GUO Zihua (1):
      rtc: mxc_v2: Add missing clk_disable_unprepare()

Gaosheng Cui (2):
      rtc: st-lpc: Add missing clk_disable_unprepare in st_rtc_probe()
      rtc: pic32: Move devm_rtc_allocate_device earlier in pic32_rtc_probe()

Guenter Roeck (1):
      rtc: cros-ec: Limit RTC alarm range if needed

Ian Abbott (1):
      rtc: ds1347: fix value written to century register

Jean Delvare (1):
      rtc: isl12026: drop obsolete dependency on COMPILE_TEST

Kees Cook (1):
      rtc: msc313: Fix function prototype mismatch in msc313_rtc_probe()

Marek Vasut (1):
      dt-bindings: rtc: m41t80: Convert text schema to YAML one

Minghao Chi (1):
      rtc: ds1742: use devm_platform_get_and_ioremap_resource()

Neil Armstrong (3):
      dt-bindings: rtc: qcom-pm8xxx: document qcom,pm8921-rtc as fallback of qcom,pm8018-rtc
      rtc: pm8xxx: drop unused pm8018 compatible
      dt-bindings: rtc: convert rtc-meson.txt to dt-schema

Rafael J. Wysocki (5):
      rtc: cmos: Call cmos_wake_setup() from cmos_do_probe()
      rtc: cmos: Call rtc_wake_setup() from cmos_do_probe()
      rtc: cmos: Eliminate forward declarations of some functions
      rtc: cmos: Rename ACPI-related functions
      rtc: cmos: Disable ACPI RTC event on removal

Rasmus Villemoes (1):
      rtc: isl12022: add support for temperature sensor

Riwen Lu (1):
      rtc: efi: Add wakeup support

Sebastian Reichel (2):
      dt-bindings: rtc: convert hym8563 bindings to json-schema
      rtc: rk808: reduce 'struct rk808' usage

Shang XiaoJing (1):
      rtc: class: Fix potential memleak in devm_rtc_allocate_device()

Stefan Eichenberger (1):
      rtc: snvs: Allow a time difference on clock register read

Uwe Kleine-König (8):
      rtc: abx80x: Convert to .probe_new()
      rtc: isl1208: Convert to .probe_new()
      rtc: m41t80: Convert to .probe_new()
      rtc: nct3018y: Convert to .probe_new()
      rtc: pcf2127: Convert to .probe_new()
      rtc: rs5c372: Convert to .probe_new()
      rtc: rv8803: Convert to .probe_new()
      rtc: rx8025: Convert to .probe_new()

Vincent Whitchurch (1):
      rtc: pcf8563: clear RTC_FEATURE_ALARM if no irq

Wadim Egorov (1):
      rtc: rv3028: Use IRQ flags obtained from device tree if available

Xiang wangx (1):
      rtc: at91rm9200: Fix syntax errors in comments

Yang Yingliang (2):
      rtc: ds1302: remove unnecessary spi_set_drvdata()
      rtc: s3c: Switch to use dev_err_probe() helper

Yushan Zhou (1):
      rtc: rzn1: Check return value in rzn1_rtc_probe

Zhang Jiaming (1):
      rtc: rs5c313: correct some spelling mistakes

Zhang Jianhua (1):
      rtc: fsl-ftm-alarm: Use module_platform_driver replace device_initcall

paulmn (1):
      rtc: pcf8523: fix for stop bit

shaomin Deng (1):
      rtc: remove duplicated words in comments

ye xingchen (2):
      rtc: s35390a: Remove the unneeded result variable
      rtc: ds1307: use sysfs_emit() to instead of scnprintf()

 .../bindings/rtc/amlogic,meson6-rtc.yaml           |  62 +++
 .../devicetree/bindings/rtc/haoyu,hym8563.txt      |  30 --
 .../devicetree/bindings/rtc/haoyu,hym8563.yaml     |  56 +++
 .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml   |  16 +-
 .../devicetree/bindings/rtc/rtc-m41t80.txt         |  39 --
 .../devicetree/bindings/rtc/rtc-meson.txt          |  35 --
 .../devicetree/bindings/rtc/st,m41t80.yaml         |  73 +++
 drivers/rtc/Kconfig                                |  12 +-
 drivers/rtc/Makefile                               |   1 -
 drivers/rtc/class.c                                |   4 +-
 drivers/rtc/interface.c                            |   2 +-
 drivers/rtc/rtc-abx80x.c                           |  37 +-
 drivers/rtc/rtc-at91rm9200.c                       |   2 +-
 drivers/rtc/rtc-bq32k.c                            |   1 +
 drivers/rtc/rtc-cmos.c                             | 378 +++++++--------
 drivers/rtc/rtc-cros-ec.c                          |  35 +-
 drivers/rtc/rtc-davinci.c                          | 512 ---------------------
 drivers/rtc/rtc-ds1302.c                           |   6 -
 drivers/rtc/rtc-ds1307.c                           |   4 +-
 drivers/rtc/rtc-ds1347.c                           |   2 +-
 drivers/rtc/rtc-ds1742.c                           |   3 +-
 drivers/rtc/rtc-efi.c                              |   2 +
 drivers/rtc/rtc-fsl-ftm-alarm.c                    |   7 +-
 drivers/rtc/rtc-isl12022.c                         |  94 ++++
 drivers/rtc/rtc-isl1208.c                          |   6 +-
 drivers/rtc/rtc-m41t80.c                           |  13 +-
 drivers/rtc/rtc-msc313.c                           |  12 +-
 drivers/rtc/rtc-mxc_v2.c                           |   4 +-
 drivers/rtc/rtc-nct3018y.c                         |   5 +-
 drivers/rtc/rtc-pcf2127.c                          |  22 +-
 drivers/rtc/rtc-pcf85063.c                         |  10 +-
 drivers/rtc/rtc-pcf8523.c                          |  20 +-
 drivers/rtc/rtc-pcf8563.c                          |   2 +
 drivers/rtc/rtc-pic32.c                            |   8 +-
 drivers/rtc/rtc-pm8xxx.c                           |   1 -
 drivers/rtc/rtc-rk808.c                            |  47 +-
 drivers/rtc/rtc-rs5c313.c                          |   6 +-
 drivers/rtc/rtc-rs5c372.c                          |  13 +-
 drivers/rtc/rtc-rv3028.c                           |  13 +-
 drivers/rtc/rtc-rv3029c2.c                         |   1 +
 drivers/rtc/rtc-rv8803.c                           |  30 +-
 drivers/rtc/rtc-rx6110.c                           |   2 +-
 drivers/rtc/rtc-rx8025.c                           |   7 +-
 drivers/rtc/rtc-rzn1.c                             |   4 +-
 drivers/rtc/rtc-s35390a.c                          |   6 +-
 drivers/rtc/rtc-s3c.c                              |  11 +-
 drivers/rtc/rtc-snvs.c                             |  16 +-
 drivers/rtc/rtc-st-lpc.c                           |   1 +
 drivers/rtc/sysfs.c                                |   1 +
 49 files changed, 674 insertions(+), 1000 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-m41t80.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/st,m41t80.yaml
 delete mode 100644 drivers/rtc/rtc-davinci.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
