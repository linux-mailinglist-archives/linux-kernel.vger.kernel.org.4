Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0FD7452E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 00:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjGBWRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 18:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGBWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 18:17:03 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E8100;
        Sun,  2 Jul 2023 15:16:58 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688336216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w4s2krYhuJE9ZCRO1HxyzBWIvnCWzmZV6dhWNiyxy7M=;
        b=gcZavETklVy+FvU22leJdHbjR+HldnNdnvC43wet3NcSGBI2jAKATU/nyBJy02JLQ4iN4V
        BbTXs6QrR12F/mfNwzwuQiufDZ1FjTfrl0GG/wiA35KOB8Xx9/qWUtrbsgri1yqg5R1epj
        Kd46YfRAmU4KDis04fAazZ+VjgxXRB3c7jYXADZCTV3mXqCrj1nCIfZnZZX9l7Gss8PhZc
        kAPfYOCC1/uY0ho/YIpPGIUMRhykRgsM/b+WoGSRO0CwmWOrPaFlootYv4vTazC+jn+RC/
        Q0VSLcp0TIsbKKoJ/nIYDd5LZwKunc453CZN+u+CRVDUt9J4/RdgfsJPZhd9qg==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B0A860003;
        Sun,  2 Jul 2023 22:16:55 +0000 (UTC)
Date:   Mon, 3 Jul 2023 00:16:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 6.5
Message-ID: <20230702221655f454af0a@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the RTC subsystem pull request for 6.5. The isl1208 dirver was
reworked tobe able to work as part of an MFD. All the Loongson chips are
now supported through a new driver, the old one is removed.

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.5

for you to fetch changes up to 1b733a9ebc3d8011ca66ec6ff17f55a440358794:

  rtc: Add rtc driver for the Loongson family chips (2023-06-26 01:19:11 +0200)

----------------------------------------------------------------
RTC for 6.5

Subsystem:
 - Switch i2c drivers back to use .probe()
 - Constify pointers to hwmon_channel_info

New driver:
 - Loongson on chip RTC, replacing the Loongson 1 only driver

Drivers:
 - isl1208: cleanup and support for RAA215300
 - st-lpc: cleanups
 - stm32: fix wakeup

----------------------------------------------------------------
Alexandre Torgue (1):
      rtc: stm32: remove dedicated wakeup management

Biju Das (7):
      dt-bindings: rtc: isl1208: Convert to json-schema
      dt-bindings: rtc: isil,isl1208: Document clock and clock-names properties
      rtc: isl1208: Drop name variable
      rtc: isl1208: Make similar I2C and DT-based matching table
      rtc: isl1208: Drop enum isl1208_id and split isl1208_configs[]
      rtc: isl1208: Add isl1208_set_xtoscb()
      rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300

Binbin Zhou (3):
      dt-bindings: rtc: Split loongson,ls2x-rtc into SoC-based compatibles
      rtc: Remove the Loongson-1 RTC driver
      rtc: Add rtc driver for the Loongson family chips

Christophe JAILLET (2):
      rtc: st-lpc: Release some resources in st_rtc_probe() in case of error
      rtc: st-lpc: Simplify clk handling in st_rtc_probe()

Johannes Kirchmair (1):
      rtc: rv3028: make rv3028 probeable from userspace

Krzysztof Kozlowski (5):
      rtc: ab-eoz9: constify pointers to hwmon_channel_info
      rtc: ds3232: constify pointers to hwmon_channel_info
      rtc: isl12022: constify pointers to hwmon_channel_info
      rtc: rv3032: constify pointers to hwmon_channel_info
      dt-bindings: rtc: restrict node name suffixes

Niklas Schnelle (1):
      rtc: add HAS_IOPORT dependencies

Uwe Kleine-König (1):
      rtc: Switch i2c drivers back to use .probe()

 .../devicetree/bindings/rtc/isil,isl1208.txt       |  38 --
 .../devicetree/bindings/rtc/isil,isl1208.yaml      | 100 ++++++
 .../devicetree/bindings/rtc/loongson,rtc.yaml      |  57 +++
 Documentation/devicetree/bindings/rtc/rtc.yaml     |   2 +-
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   2 -
 drivers/rtc/Kconfig                                |  27 +-
 drivers/rtc/Makefile                               |   2 +-
 drivers/rtc/rtc-ab-b5ze-s3.c                       |   2 +-
 drivers/rtc/rtc-ab-eoz9.c                          |   4 +-
 drivers/rtc/rtc-abx80x.c                           |   2 +-
 drivers/rtc/rtc-bq32k.c                            |   2 +-
 drivers/rtc/rtc-ds1307.c                           |   2 +-
 drivers/rtc/rtc-ds1374.c                           |   2 +-
 drivers/rtc/rtc-ds1672.c                           |   2 +-
 drivers/rtc/rtc-ds3232.c                           |   4 +-
 drivers/rtc/rtc-em3027.c                           |   2 +-
 drivers/rtc/rtc-fm3130.c                           |   2 +-
 drivers/rtc/rtc-hym8563.c                          |   2 +-
 drivers/rtc/rtc-isl12022.c                         |   4 +-
 drivers/rtc/rtc-isl12026.c                         |   2 +-
 drivers/rtc/rtc-isl1208.c                          | 132 +++++--
 drivers/rtc/rtc-loongson.c                         | 397 +++++++++++++++++++++
 drivers/rtc/rtc-ls1x.c                             | 192 ----------
 drivers/rtc/rtc-m41t80.c                           |   2 +-
 drivers/rtc/rtc-max6900.c                          |   2 +-
 drivers/rtc/rtc-nct3018y.c                         |   2 +-
 drivers/rtc/rtc-pcf2127.c                          |   2 +-
 drivers/rtc/rtc-pcf85063.c                         |   2 +-
 drivers/rtc/rtc-pcf8523.c                          |   2 +-
 drivers/rtc/rtc-pcf85363.c                         |   2 +-
 drivers/rtc/rtc-pcf8563.c                          |   2 +-
 drivers/rtc/rtc-pcf8583.c                          |   2 +-
 drivers/rtc/rtc-rs5c372.c                          |   2 +-
 drivers/rtc/rtc-rv3028.c                           |   9 +-
 drivers/rtc/rtc-rv3029c2.c                         |   2 +-
 drivers/rtc/rtc-rv3032.c                           |   4 +-
 drivers/rtc/rtc-rv8803.c                           |   2 +-
 drivers/rtc/rtc-rx6110.c                           |   2 +-
 drivers/rtc/rtc-rx8010.c                           |   2 +-
 drivers/rtc/rtc-rx8025.c                           |   2 +-
 drivers/rtc/rtc-rx8581.c                           |   2 +-
 drivers/rtc/rtc-s35390a.c                          |   2 +-
 drivers/rtc/rtc-sd3078.c                           |   2 +-
 drivers/rtc/rtc-st-lpc.c                           |  16 +-
 drivers/rtc/rtc-stm32.c                            |  28 +-
 drivers/rtc/rtc-x1205.c                            |   2 +-
 46 files changed, 726 insertions(+), 350 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/loongson,rtc.yaml
 create mode 100644 drivers/rtc/rtc-loongson.c
 delete mode 100644 drivers/rtc/rtc-ls1x.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
