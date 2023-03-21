Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F86C2965
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCUFAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCUFAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:00:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C01F222FB;
        Mon, 20 Mar 2023 22:00:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so8727703wmq.2;
        Mon, 20 Mar 2023 22:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679374837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OklcTY3hBC1t993899oN9Qj4d1kGtD0J0iejBVSGwVA=;
        b=dmy/hJ3FacMUpXRztV1zmkbViNNvRTsq77zoTi8X60Y2IY2c2tJXtXLPC+r4Ue23b0
         SVDIIaXzAs+o9yT75SzVObJtNP3tvhuXT6ETT3qzkev/AeTewopgZApfNK70/IFkgJn9
         cPGbKI4gAb1HwcfCAhTQAH/0npceO7xQnTjHoiPLQHczrLZJalol0Du8+rGmzg0n5Lam
         gtixWG4FWYoAD11WQRGZXmk7NqFPhX5vaHVBAbloxB54rX+tpmWK+yihA2DdEuXEPwvi
         d/kezUqMFnZkjdC1vnDridCMWDRiSsAKuhtJlKNnEYtVI3tyGKTId3pUp2RvfOuTFU6Z
         wuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679374837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OklcTY3hBC1t993899oN9Qj4d1kGtD0J0iejBVSGwVA=;
        b=zQa13U2Q58Xl54JjaR30/2OgUjwF3cVKLYfIgMEbmlFMJRNHYr4cdIttsMjHkQImp/
         mtHdd2eKLFTmMH4WverjwrSIUqa14yAwFu5aikHzFEsdAj63DLjI7Jt92iV83NJW2xc3
         x0+TYcJsI59ti4fK3NgjKiN/+0UV1Kivms73gxcxS1l/gq/VBTbu/kleaGepby7oBFcb
         3T64KO+59ZjfuA+wjQhjBuKMCc8Hl6I7YYLo+DxRFLkuSaKVJ3xQ8xZVYvPFLK9MMlEB
         QDkg89eb7Ge8FiknaoInPjRewJ3IuUsoWBNtv1+LUst228NCNRFANLmOlpsmMkRtd059
         WNVQ==
X-Gm-Message-State: AO0yUKV74v9Iw1DmAyN9DD79t/k1veVULvkmENIn6r4zbP8w4W9ykLIM
        zc8egVPl5FZHqSQ6+juXjuL3WES7AzI=
X-Google-Smtp-Source: AK7set/jwqom1SSftt3p9nlabfmOz29fmxNbFYFQQX+kEczQICKfVDjRyBAHRjeL51n+SecFAtD0hA==
X-Received: by 2002:a7b:ce0d:0:b0:3ed:ec34:f1 with SMTP id m13-20020a7bce0d000000b003edec3400f1mr1191136wmc.35.1679374837367;
        Mon, 20 Mar 2023 22:00:37 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b003eddefd8792sm6238432wmi.14.2023.03.20.22.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 22:00:36 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v2 0/9] mips: ralink: add complete clock and reset driver for mtmips SoCs
Date:   Tue, 21 Mar 2023 06:00:25 +0100
Message-Id: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

This patchset is a big effort to properly implement a clock and reset
driver for old ralink SoCs. This allow to properly define clocks in 
device tree and avoid to use fixed-clocks directly from 'arch/mips/ralink'
architecture directory code.

Device tree 'sysc' node will be both clock and reset provider using 
'clock-cells' and 'reset-cells' properties.

The ralink SoCs we are taking about are RT2880, RT3050, RT3052, RT3350,
RT3352, RT3883, RT5350, MT7620, MT7628 and MT7688. Mostly the code in
this new driver has been extracted from 'arch/mips/ralink' and cleanly
put using kernel clock and reset driver APIs. The clock plans for this
SoCs only talks about relation between CPU frequency and BUS frequency.
This relation is different depending on the particular SoC. CPU clock is
derived from XTAL frequencies.

 Depending on the SoC we have the following frequencies:
 * RT2880 SoC:
     - XTAL: 40 MHz.
     - CPU: 250, 266, 280 or 300 MHz.
     - BUS: CPU / 2 MHz.
  * RT3050, RT3052, RT3350:
     - XTAL: 40 MHz.
     - CPU: 320 or 384 MHz.
     - BUS: CPU / 3 MHz.
  * RT3352:
     - XTAL: 40 MHz.
     - CPU: 384 or 400 MHz.
     - BUS: CPU / 3 MHz.
     - PERIPH: 40 MHz.
  * RT3383:
     - XTAL: 40 MHz.
     - CPU: 250, 384, 480 or 500 MHz.
     - BUS: Depends on RAM Type and CPU:
       + RAM DDR2: 125. ELSE 83 MHz.
       + RAM DDR2: 128. ELSE 96 MHz.
       + RAM DDR2: 160. ELSE 120 MHz.
       + RAM DDR2: 166. ELSE 125 MHz.
  * RT5350:
      - XTAL: 40 MHz.
      - CPU: 300, 320 or 360 MHz.
      - BUS: CPU / 3, CPU / 4, CPU / 3 MHz.
      - PERIPH: 40 MHz.
  * MT7628 and MT7688:
     - XTAL: 20 MHz or 40 MHz.
     - CPU: 575 or 580 MHz.
     - BUS: CPU / 3.
     - PCMI2S: 480 MHz.
     - PERIPH: 40 MHz.
  * MT7620:
     - XTAL: 20 MHz or 40 MHz.
     - PLL: XTAL, 480, 600 MHz.
     - CPU: depends on PLL and some mult and dividers.
     - BUS: depends on PLL and some mult and dividers.
     - PERIPH: 40 or XTAL MHz.

MT7620 is a bit more complex deriving CPU clock from a PLL and an bunch of
register reads and predividers. To derive CPU and BUS frequencies in the
MT7620 SoC 'mt7620_calc_rate()' helper is used.
In the case XTAL can have different frequencies and we need a different
clock frequency for peripherals 'periph' clock in introduced.
The rest of the peripherals present in the SoC just follow their parent
frequencies.

I am using 'mtmips' inside for ralink clock driver. This is aligned with
pinctrl series recently merged through pinctrl git tree [0].

Changes have been compile tested for:
- RT2880
- RT3883
- MT7620

Changes have been properly tested in RT5350 SoC based board (ALL5003 board)
resulting in a working platform.

Dts files for these SoCs in-tree except MT7621 are incomplete. We are
planning to align with openWRT files at some point and add extra needed
changes. Hence I am not touching them at all in these series. If this is
a problem, please let me know and I will update them.

Talking about merging this series I'd like all of the patches going through
the MIPS tree if possible.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

Changes in v2:
- Address bindings documentation changes pointed out by Krzysztof:
    + Rename the file into 'mediatek,mtmips-sysc.yaml'.
    + Redo commit subject and log message.
    + Order compatibles alphabetically.
    + Redo bindings description taking into account this is a system
      controller node which provides both clocks and resets to the world.
    + Drop label from example.
    + Use 'syscon' as node name in example.
    + Drop no sense 'ralink,rt2880-reset' compatible string 
- Squash patches 6 and 7 together as pointed out by Stephen Boyd.

Previous series:
v1: https://lore.kernel.org/linux-clk/20230320161823.1424278-1-sergio.paracuellos@gmail.com/T/#t

[0]: https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a302b06185@arinc9.com/T/#t

Sergio Paracuellos (9):
  dt-bindings: clock: add mtmips SoCs system controller
  clk: ralink: add clock and reset driver for MTMIPS SoCs
  mips: ralink: rt288x: remove clock related code
  mips: ralink: rt305x: remove clock related code
  mips: ralink: rt3883: remove clock related code
  mips: ralink: mt7620: remove clock related code
  mips: ralink: remove reset related code
  mips: ralink: get cpu rate from new driver code
  MAINTAINERS: add Mediatek MTMIPS Clock maintainer

 .../bindings/clock/mediatek,mtmips-sysc.yaml  |  65 ++
 MAINTAINERS                                   |   6 +
 arch/mips/include/asm/mach-ralink/mt7620.h    |  35 -
 arch/mips/include/asm/mach-ralink/rt288x.h    |  10 -
 arch/mips/include/asm/mach-ralink/rt305x.h    |  21 -
 arch/mips/include/asm/mach-ralink/rt3883.h    |   8 -
 arch/mips/ralink/clk.c                        |  26 +-
 arch/mips/ralink/common.h                     |   5 -
 arch/mips/ralink/mt7620.c                     | 226 ----
 arch/mips/ralink/of.c                         |   4 -
 arch/mips/ralink/reset.c                      |  61 --
 arch/mips/ralink/rt288x.c                     |  31 -
 arch/mips/ralink/rt305x.c                     |  78 --
 arch/mips/ralink/rt3883.c                     |  44 -
 drivers/clk/ralink/Kconfig                    |   7 +
 drivers/clk/ralink/Makefile                   |   1 +
 drivers/clk/ralink/clk-mtmips.c               | 985 ++++++++++++++++++
 17 files changed, 1083 insertions(+), 530 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
 create mode 100644 drivers/clk/ralink/clk-mtmips.c

-- 
2.25.1

