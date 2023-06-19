Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48AF734AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjFSEJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjFSEJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:09:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD227136;
        Sun, 18 Jun 2023 21:09:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30adc51b65cso3045795f8f.0;
        Sun, 18 Jun 2023 21:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687147784; x=1689739784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4cDqLgnjeO8/PHbpEjSl3NPzIPpeeEqnA8amK7VqmU=;
        b=dTrjkApE9Bp6yvsnHGfTMHaPIHgQU68Bx4RnewArlftFMjC72fAaOhojkOXPesUscj
         KBdVHsHEAPQrtryp6UYMkTIBtIfWneG6z+EPeG37ImQtdUPwWuMXTsMZcUS70c/TxWA6
         5O1yKESZf1ayjRYX6rEyXfQpD1hdL0GCbIFsZ9X0oBDmtVHEsWphg0M9l+4OwsR4maz/
         /T2vLgCiof6BtCyZsNsykGWK+dD2dGz9rLOmPLKGnetEhAmZ/uxkeia/kgNqzHfdL5u1
         tJJr2BIy2/KkWaUxZXPw0JM14MIiQG3EM8rT9aoF7RpuHaWReb/cngL8nFQ8yCizCe7x
         nfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687147784; x=1689739784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4cDqLgnjeO8/PHbpEjSl3NPzIPpeeEqnA8amK7VqmU=;
        b=dYmbL1iJDvWNCwfQxexfhvtdB2JNMlR8OyslYxqBb33BN82kQMauTZki9PZwGec3K4
         4Rar9BsE9MRgBTCWvD5hn0tnRBnJZ0FgecFXCBBixCLZjELsWoRXKO5V8yAP89ch9h9E
         M/DH+cvYrLn/mnTDP4wZA+4ZaKNkV9hWaP7rbW10W6PbQRlfd3k78C+VnvNX/xPoew5E
         h/GHe8W7dZFk2sNbaEcjl8oy2kNJ81uvuDnWPUW3RZhkOkd/hvx76boTyPsr8k6QJu+v
         Q9ZYu23i6hv83Kg7DJBDHbzqLFZ0+/6t55FADKDJthQ/HabjITE/fwf3a9XmUks4JeCo
         8nww==
X-Gm-Message-State: AC+VfDxTwKcbonSoVujT6wZft2zO/auAOQwuMch+Vut+wMBq8Aq+fqhE
        qPN6NlajCWakAk/8PT7an2A09KgubSM=
X-Google-Smtp-Source: ACHHUZ6vnO9OSmH7IP8tW4a0zKUwpxCSj62f94izw2mFs8kWL5NCdfEeynUpXyp6EeLnyHqTGkgGIw==
X-Received: by 2002:a5d:4149:0:b0:311:1b83:e1e4 with SMTP id c9-20020a5d4149000000b003111b83e1e4mr8856371wrq.5.1687147783728;
        Sun, 18 Jun 2023 21:09:43 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d6e0e000000b003078354f774sm30004052wrz.36.2023.06.18.21.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 21:09:43 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com, yangshiji66@outlook.com
Subject: [PATCH v5 0/9] mips: ralink: add complete clock and reset driver for mtmips SoCs
Date:   Mon, 19 Jun 2023 06:09:32 +0200
Message-Id: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
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

Changes have been properly tested in: 
- RT5350 SoC based board (ALL5003 board)
- MT7620A SoC based board (Haier HW-L1W)
- MT7628AN SoC based board (Motorola MWR03)

All of them resulting in a working platform.

Dts files for these SoCs in-tree except MT7621 are incomplete. We are
planning to align with openWRT files at some point and add extra needed
changes. Hence I am not touching them at all in these series. If this is
a problem, please let me know and I will update them.

Talking about merging this series I'd like all of the patches going through
the MIPS tree if possible.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

Changes in v5:
- Address comments of Shiji Yang in v4.
- Make use 'of_find_compatible_node()' instead of 'of_find_node_by_name()' since
  node names must not be an ABI (Thanks Krzysztof!!!)
- Test this changes in mt7620a Soc based board and MT7628AN Soc based board (Thanks Shiji Yang!!!)

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
v4: https://lore.kernel.org/linux-clk/20230617052435.359177-1-sergio.paracuellos@gmail.com/T/#t
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

 .../bindings/clock/mediatek,mtmips-sysc.yaml  |   64 +
 MAINTAINERS                                   |    6 +
 arch/mips/include/asm/mach-ralink/mt7620.h    |   35 -
 arch/mips/include/asm/mach-ralink/rt288x.h    |   10 -
 arch/mips/include/asm/mach-ralink/rt305x.h    |   21 -
 arch/mips/include/asm/mach-ralink/rt3883.h    |    8 -
 arch/mips/ralink/clk.c                        |   61 +-
 arch/mips/ralink/common.h                     |    5 -
 arch/mips/ralink/mt7620.c                     |  226 ----
 arch/mips/ralink/of.c                         |    4 -
 arch/mips/ralink/reset.c                      |   61 -
 arch/mips/ralink/rt288x.c                     |   31 -
 arch/mips/ralink/rt305x.c                     |   78 --
 arch/mips/ralink/rt3883.c                     |   44 -
 drivers/clk/ralink/Kconfig                    |    7 +
 drivers/clk/ralink/Makefile                   |    1 +
 drivers/clk/ralink/clk-mtmips.c               | 1115 +++++++++++++++++
 17 files changed, 1245 insertions(+), 532 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
 create mode 100644 drivers/clk/ralink/clk-mtmips.c

-- 
2.25.1

