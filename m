Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729786A8DB3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCCACs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCACq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:02:46 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7453402F;
        Thu,  2 Mar 2023 16:02:43 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A3EC60009;
        Fri,  3 Mar 2023 00:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677801762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7yQWoPfC83EceW/gIsZXkXLk8Gi7pl3zy339VDelYow=;
        b=fJyzGt+6wn9Wkwg9AhaP0ITTfg7RS/J5f3mfn6fu8XtgpL/w9OpuIc842Ad1mGJfHDDtYB
        oPbJ+JO2nvBPJD1Oa59hK1rsiblfjvLfBh5bEf5+dw4FLuizPWcoUSVSefXJJD6fkrFL/N
        0cfh6+SatENb6Gpe9yOFI/7983yMmui4EWknRPVw0CWMK/uecgpW6g8lCofiQBg6yn2lw8
        jOpjmrNZNCJRKdUfnMn/LabNsVmUlylgNzT3uRbZiY2/hb/k8mRiNmALNYPkYS7sCIVRBL
        APVYjihHE/zobzcvV2IeIt7LgW6NIBsrlVkG6/zGseCC+nzjZtW8UF1pudnZmw==
Date:   Fri, 3 Mar 2023 01:02:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 6.3
Message-ID: <2023030300024180930d7a@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the RTC subsystem pull request for 6.3. A few drivers got some
nice cleanups and a new driver are making the bulk of the changes.

I had to merge rtc-6.2-fixes that you already have to apply the last two
patches.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.3

for you to fetch changes up to 3ca04951b004fa184ff84369448a37bf5df98a79:

  rtc: pm8xxx: add support for nvmem offset (2023-02-25 23:34:22 +0100)

----------------------------------------------------------------
RTC for 6.3

Subsystem:
 - allow rtc_read_alarm without read_alarm callback

New driver:
 - NXP BBNSM module RTC

Drivers:
 - use IRQ flags from fwnode when available
 - abx80x: nvmem support
 - brcmstb-waketimer: add non-wake alarm support
 - ingenic: provide CLK32K clock
 - isl12022: cleanups
 - moxart: switch to using gpiod API
 - pcf85363: allow setting quartz load
 - pm8xxx: cleanups and support for setting time
 - rv3028, rv3032: add ACPI support

----------------------------------------------------------------
Ahmad Fatoum (1):
      include/linux/bcd.h: provide bcd_is_valid() helper

Alexandre Belloni (16):
      rtc: ab-eoz9: use IRQ flags obtained from fwnode
      rtc: hym8563: use IRQ flags obtained from fwnode
      rtc: m41t80: use IRQ flags obtained from fwnode
      rtc: pcf2123: use IRQ flags obtained from fwnode
      rtc: pcf85063: use IRQ flags obtained from fwnode
      rtc: pcf8523: use IRQ flags obtained from fwnode
      rtc: pcf85363: use IRQ flags obtained fromfwnode
      rtc: pcf8563: use IRQ flags obtained from fwnode
      rtc: rv3029c2: use IRQ flags obtained from fwnode
      rtc: rv3032: use IRQ flags obtained from fwnode
      rtc: rv8803: use IRQ flags obtained from fwnode
      rtc: rx8010: use IRQ flags obtained from fwnode
      rtc: rv3028: add ACPI support
      rtc: rv3032: add ACPI support
      rtc: allow rtc_read_alarm without read_alarm callback
      Merge tag 'rtc-6.2-fixes' into rtc-next

Andy Shevchenko (6):
      rtc: isl12022: Get rid of unneeded private struct isl12022
      rtc: isl12022: Explicitly use __le16 type for ISL12022_REG_TEMP_L
      rtc: isl12022: Drop unneeded OF guards and of_match_ptr()
      rtc: isl12022: Join string literals back
      rtc: isl12022: sort header inclusion alphabetically
      rtc: rx6110: Remove unused of_gpio,h

Ard Biesheuvel (1):
      rtc: efi: Avoid spamming the log on RTC read failure

Arnd Bergmann (1):
      rtc: sunplus: fix format string for printing resource

Dmitry Torokhov (2):
      rtc: moxart: switch to using gpiod API
      dt-bindings: rtc: moxart: use proper names for gpio properties

Doug Berger (6):
      rtc: brcmstb-waketimer: introduce WKTMR_ALARM_EVENT flag
      rtc: brcmstb-waketimer: non-functional code changes
      rtc: brcmstb-waketimer: compensate for lack of wktmr disable
      rtc: brcmstb-waketimer: rename irq to wake_irq
      dt-bindings: rtc: brcm,brcmstb-waketimer: add alarm interrupt
      rtc: brcmstb-waketimer: allow use as non-wake alarm

Heiner Kallweit (1):
      dt-bindings: rtc: Convert Amlogic Meson vrtc controller binding

Hugo Villeneuve (1):
      dt-bindings: rtc: pcf2127: remove pca/pcf2129 from trivial RTC devices list

Jacky Bai (1):
      rtc: bbnsm: Add the bbnsm rtc support

Javier Carrasco (2):
      dt-bindings: rtc: nxp,pcf8563: move pcf85263/pcf85363 to a dedicated binding
      rtc: pcf85363: add support for the quartz-load-femtofarads property

Johan Hovold (18):
      dt-bindings: rtc: qcom-pm8xxx: allow 'wakeup-source' property
      rtc: pm8xxx: fix set-alarm race
      rtc: pm8xxx: drop spmi error messages
      rtc: pm8xxx: use regmap_update_bits()
      rtc: pm8xxx: drop bogus locking
      rtc: pm8xxx: return IRQ_NONE on errors
      rtc: pm8xxx: drop unused register defines
      rtc: pm8xxx: use unaligned le32 helpers
      rtc: pm8xxx: clean up time and alarm debugging
      rtc: pm8xxx: rename struct device pointer
      rtc: pm8xxx: rename alarm irq variable
      rtc: pm8xxx: clean up comments
      rtc: pm8xxx: use u32 for timestamps
      rtc: pm8xxx: refactor read_time()
      rtc: pm8xxx: clean up local declarations
      rtc: pm8xxx: drop error messages
      dt-bindings: rtc: qcom-pm8xxx: add nvmem-cell offset
      rtc: pm8xxx: add support for nvmem offset

Paul Cercueil (4):
      dt-bindings: rtc: Add #clock-cells property
      rtc: jz4740: Use readl_poll_timeout
      rtc: jz4740: Use dev_err_probe()
      rtc: jz4740: Register clock provider for the CLK32K pin

Samuel Holland (1):
      rtc: sun6i: Always export the internal oscillator

Sascha Hauer (1):
      rtc: rv8803: invalidate date/time if alarm time is invalid

Sean Anderson (1):
      rtc: abx80x: Add nvmem support

Shanker Donthineni (1):
      rtc: efi: Enable SET/GET WAKEUP services as optional

Uwe Kleine-König (2):
      rtc: ds1307: Convert to i2c's .probe_new()
      rtc: max8907: Drop unused i2c include

WANG Xuerui (1):
      dt-bindings: rtc: Add Loongson LS2X RTC support

Wadim Egorov (1):
      dt-bindings: rtc: Move rv3028 from trivial-rtc.yaml into own schema file

 .../bindings/rtc/amlogic,meson-vrtc.yaml           |  44 ++
 .../bindings/rtc/brcm,brcmstb-waketimer.yaml       |  21 +-
 .../devicetree/bindings/rtc/ingenic,rtc.yaml       |  29 ++
 .../bindings/rtc/microcrystal,rv3028.yaml          |  54 +++
 .../devicetree/bindings/rtc/moxa,moxart-rtc.txt    |  12 +-
 .../devicetree/bindings/rtc/nxp,pcf2127.yaml       |   5 +-
 .../devicetree/bindings/rtc/nxp,pcf85363.yaml      |  60 +++
 .../devicetree/bindings/rtc/nxp,pcf8563.yaml       |   2 -
 .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml   |  14 +
 .../devicetree/bindings/rtc/rtc-meson-vrtc.txt     |  22 -
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   6 +-
 drivers/rtc/Kconfig                                |  14 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/interface.c                            |   2 +-
 drivers/rtc/rtc-ab-eoz9.c                          |   7 +-
 drivers/rtc/rtc-abx80x.c                           |  77 +++
 drivers/rtc/rtc-brcmstb-waketimer.c                | 152 ++++--
 drivers/rtc/rtc-ds1307.c                           |   6 +-
 drivers/rtc/rtc-efi.c                              |  50 +-
 drivers/rtc/rtc-hym8563.c                          |   7 +-
 drivers/rtc/rtc-isl12022.c                         |  93 ++--
 drivers/rtc/rtc-jz4740.c                           |  94 +++-
 drivers/rtc/rtc-m41t80.c                           |   7 +-
 drivers/rtc/rtc-max8907.c                          |   1 -
 drivers/rtc/rtc-moxart.c                           |  89 ++--
 drivers/rtc/rtc-nxp-bbnsm.c                        | 226 +++++++++
 drivers/rtc/rtc-pcf2123.c                          |   7 +-
 drivers/rtc/rtc-pcf85063.c                         |   7 +-
 drivers/rtc/rtc-pcf8523.c                          |   7 +-
 drivers/rtc/rtc-pcf85363.c                         |  44 +-
 drivers/rtc/rtc-pcf8563.c                          |   7 +-
 drivers/rtc/rtc-pm8xxx.c                           | 533 ++++++++++-----------
 drivers/rtc/rtc-rv3028.c                           |   7 +
 drivers/rtc/rtc-rv3029c2.c                         |   7 +-
 drivers/rtc/rtc-rv3032.c                           |  14 +-
 drivers/rtc/rtc-rv8803.c                           |  52 +-
 drivers/rtc/rtc-rx6110.c                           |   1 -
 drivers/rtc/rtc-rx8010.c                           |   8 +-
 drivers/rtc/rtc-sun6i.c                            |  16 +-
 drivers/rtc/rtc-sunplus.c                          |   4 +-
 include/linux/bcd.h                                |   4 +
 include/linux/efi.h                                |   3 +-
 42 files changed, 1261 insertions(+), 555 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt
 create mode 100644 drivers/rtc/rtc-nxp-bbnsm.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
