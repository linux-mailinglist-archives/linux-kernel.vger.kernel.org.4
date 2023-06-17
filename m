Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46169733E36
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjFQFYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjFQFYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:24:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802DB1FDD;
        Fri, 16 Jun 2023 22:24:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-519274f7b05so2023745a12.3;
        Fri, 16 Jun 2023 22:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686979476; x=1689571476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZaKN6gGmQ/oA4Z4nV3ooBnlset17m+/j+OKKJXvACI=;
        b=fBLve9yc16crS8VW0xoaUuUwbIIRMygsPb43FxmPrRxkav3yk9Xmgv+jqkBkIUdFya
         9bMPjK9FVcWlQt/2fwK3WQ78fUTke7QZ3+KYICDLTVA9TcxbCeC4MuNj+7smcjEn3j4p
         0kuZ0+CNzHxXVUsUfmFK6Myv2AI7zZGhVRHmIWFtjzljA/dP16c0HetPiOeP7uHOz5YJ
         AcRb+w+yh/uk+H2/uwLIXrRO/tSorlffgeVXKIv2UAUwsCS+ONEtcQrh/H0mYisAk+jz
         yIpaEV65fBorcT2yVDVs2D+k2+primGcwhXAr2vT7IsRB8L+rZVKX9lvvzbnqruD5a2g
         //jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979476; x=1689571476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZaKN6gGmQ/oA4Z4nV3ooBnlset17m+/j+OKKJXvACI=;
        b=VcxtB3I6dq4mQ54MxxzAUlgRO5jwcInIWBnjM0Gr2+qTM3/LGjTkeam/8TRwIrziqt
         YPcEHDrx3VMkm/xBZzGk0H0xIuEjh72D6FfRsX6ZqiY5SrEPnR/ybke8m9BBnoE4kKkw
         CX4+EpV+5TBI8DI9SbJfV6vMOd9V1E0DZ+0OQg/sjEE872M4eAzAD7CB8e8338xeYNV1
         xFNPe0Z6ggIsfQ/XoN3+WvjXmsiMVJPV7jS32kc6YipIm2cWE226nGn7gCgH77w9pnwq
         aJ2amPscQ2y6BY/el0I9jxLU5PD28hxEMEo8KTv/999phGcOdfkX3AwRF7k7LNDX5Jfk
         ZeoQ==
X-Gm-Message-State: AC+VfDx8rf2n/Uq6AS1xyQkqLhV38auvf7bgopemJkaqJVhHJn7GiMPM
        K4zxi2niB0pcsgZO29nGtFpGmzdV78Q=
X-Google-Smtp-Source: ACHHUZ6jKyuPUdrTXi1Qpz+ZEhzWkC/+3AorpK1bxsTvBPcyokHcmnGTxSWyo7rR4QfSLAD+AWlsgg==
X-Received: by 2002:a17:907:97d4:b0:94b:4a4:2836 with SMTP id js20-20020a17090797d400b0094b04a42836mr3929885ejc.69.1686979476340;
        Fri, 16 Jun 2023 22:24:36 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm25198228wrf.94.2023.06.16.22.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 22:24:35 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v4 0/9] [PATCH v3 0/9] mips: ralink: add complete clock and reset driver for mtmips SoCs
Date:   Sat, 17 Jun 2023 07:24:26 +0200
Message-Id: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

I am maintaining ralink as prefix for compatible strings after discussions
between Rob and Arinc in v2 of this series [1].

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

Changes in v4:
- Collect Reviewed-by and Acked-by tags.
- Pass proper data for 'ralink,rt3352-sysc' and 'ralink,rt3883-sysc' compatible string.

Changes in v3:
- Address Stephen comments in v2:
    + Drop unsused include '<linux/clk.h>'.
    + Add fixed and factor clocks when it makes sense.
    + Make 'mtmips_periph_clk_ops' named variable.
    + WARN_ON -> WARN_ON_ONCE.
    + Avoid CONFIG_USB dependent code. Introduce new 'mtmips_clk_regs_init'.
    + Don't validate the bindings in the driver.
    + Make const 'struct clk_init_data' used inside macros.
    + do_div -> div_u64.
    + Make use of dev_err_probe.

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

Previoous series:
v3: https://lore.kernel.org/linux-mips/20230616064735.GA6380@alpha.franken.de/T/#mafbc1704938b94a367c4b6240d9880a67be1f92f
v2: https://lore.kernel.org/linux-clk/CAMhs-H-BfZb3mD8E=LeJ4vT22uibQ1DnaZsfTrtRxSiv=8L5RA@mail.gmail.com/T/#t
v1: https://lore.kernel.org/linux-clk/20230320161823.1424278-1-sergio.paracuellos@gmail.com/T/#t

[0]: https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a302b06185@arinc9.com/T/#t
[1]: https://lore.kernel.org/linux-clk/CAMhs-H-BfZb3mD8E=LeJ4vT22uibQ1DnaZsfTrtRxSiv=8L5RA@mail.gmail.com/T/#mfe725b6e3382c6fb09736472a846cbbc84f264dc

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

 .../bindings/clock/mediatek,mtmips-sysc.yaml  |   65 +
 MAINTAINERS                                   |    6 +
 arch/mips/include/asm/mach-ralink/mt7620.h    |   35 -
 arch/mips/include/asm/mach-ralink/rt288x.h    |   10 -
 arch/mips/include/asm/mach-ralink/rt305x.h    |   21 -
 arch/mips/include/asm/mach-ralink/rt3883.h    |    8 -
 arch/mips/ralink/clk.c                        |   26 +-
 arch/mips/ralink/common.h                     |    5 -
 arch/mips/ralink/mt7620.c                     |  226 ----
 arch/mips/ralink/of.c                         |    4 -
 arch/mips/ralink/reset.c                      |   61 -
 arch/mips/ralink/rt288x.c                     |   31 -
 arch/mips/ralink/rt305x.c                     |   78 --
 arch/mips/ralink/rt3883.c                     |   44 -
 drivers/clk/ralink/Kconfig                    |    7 +
 drivers/clk/ralink/Makefile                   |    1 +
 drivers/clk/ralink/clk-mtmips.c               | 1134 +++++++++++++++++
 17 files changed, 1232 insertions(+), 530 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
 create mode 100644 drivers/clk/ralink/clk-mtmips.c

-- 
2.25.1

