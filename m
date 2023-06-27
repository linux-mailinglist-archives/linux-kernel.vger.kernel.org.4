Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B9773F3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 07:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjF0FLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 01:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjF0FL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D51734;
        Mon, 26 Jun 2023 22:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B310060FF5;
        Tue, 27 Jun 2023 05:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD73C433C8;
        Tue, 27 Jun 2023 05:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687842685;
        bh=LDj0pLnkt+8aYxlpd78wVZ3BzAFJ4PrASkunhUxfwr8=;
        h=From:To:Cc:Subject:Date:From;
        b=U+wA5+2itpdLUzk0e/OZWBd3sWTZTAGPy3IiksIsSxjI9TShP8EUqdg2T8EV2k9Gy
         ouASd7t2jqhIniho5bE3rc7TOSeqkFjGEhdchR4wUoy3B4BlXt97w1RSI8B4fcNnAt
         UFwk7lOWrhvIhZ7C7rGDkyLuG0JnuQ6y0nQSNt6WAd725nWC3ZZxzz2EbODuRyOoP8
         jZq+hFc2YhM2Tx1MKud5shae+98NLCURwk9sgw0Sgrb+W5rZ6GrLhP4RtM46dOxoN2
         B3u4S54QXZqxntnSad5a9ZTFYkZ7n3VxUwsKQlaHQlAZxZ0KIgnpjrj0mGaGYvQ4oa
         hWqrwfse0dqbw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Mon, 26 Jun 2023 22:11:23 -0700
Message-ID: <20230627051123.391865-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to b9a40506a2cb626da3f21c6d494a76879e3141d7:

  Merge branches 'clk-imx', 'clk-microchip', 'clk-cleanup', 'clk-bindings', 'clk-ti' and 'clk-kasprintf' into clk-next (2023-06-26 08:55:22 -0700)

----------------------------------------------------------------
This batch of clk driver updates for the merge window contains almost no new
SoC support. Instead there's a treewide patch series from Maxime that makes
clk_ops::determine_rate mandatory for muxes. Beyond that core framework change
we have the usual pile of clk driver updates such as migrating i2c drivers to
use .probe() again or YAMLfication of clk DT bindings so we can validate DTBs.
Overall the SoCs that got the most updates this time around in terms of
diffstat are the Amlogic and Mediatek drivers because they added new SoC
support or fixed up various drivers to have proper data.

In general things look kinda quiet. I suspect the core framework change may
still shake out some problems after the merge window, mostly because not
everyone tests linux-next where that series has been for some number of weeks.
I saw that there's at least one pending fix for Tegra that needs to be wrapped
up into a proper patch. I'll try to catch those bits before the window closes
so that -rc1 is bootable. More details below.

Core:
 - Make clk_ops::determine_rate mandatory for muxes

New Drivers:
 - Add amlogic a1 SoC family PLL and peripheral clock controller support

Updates:
 - Handle allocation failures from kasprintf() and friends
 - Migrate platform clk drivers to .remove_new()
 - Migrate i2c clk drivers to .probe() instead of .probe_new()
 - Remove CLK_SET_PARENT from all Mediatek MSDC core clocks
 - Add infra_ao reset support for Mediatek MT8188 SoCs
 - Align driver_data to i2c_device_id tables in some i2c clk drivers
 - Use device_get_match_data() in vc5 clk driver
 - New Kconfig symbol name (SOC_MICROCHIP_POLARFIRE) for Microchip FPGA clock
   drivers
 - Use of_property_read_bool() to read "microchip,pic32mzda-sosc" boolean DT
   property in clk-pic32mzda
 - Convert AT91 clock dt-bindings to YAML
 - Remove CLK_SET_RATE_PARENT flag from LDB clocks on i.MX6SX
 - Keep i.MX UART clocks enabled during kernel boot if earlycon is set
 - Drop imx_unregister_clocks() as there are no users anymore
 - Switch to _safe iterator on imx_clk_scu_unregister() to avoid use after free
 - Add determine_rate op to the imx8m composite clock
 - Use device managed API for iomap and kzalloc for i.MXRT1050, i.MX8MN,
   i.MX8MP and i.MX93 clock controller drivers
 - Add missing interrupt DT property for the i.MX8M clock controller
 - Re-add support for Exynos4212 clock controller because we are
   re-introducing the SoC in the mainline
 - Add CONFIG_OF dependency to Samsung clk Kconfig symbols to solve some
   objtool warnings
 - Preselect PLL MIPI as TCON0 parent for Allwinner A64 SoC
 - Convert the Renesas clock drivers to readl_poll_timeout_atomic()
 - Add PWM clock on Renesas R-Car V3U
 - Fix PLL5 on Renesas RZ/G2L and RZ/V2L

----------------------------------------------------------------
Adam Ford (1):
      clk: imx: composite-8m: Add imx8m_divider_determine_rate

Alexander Stein (2):
      clk: imx6ul: retain early UART clocks during kernel init
      dt-bindings: clock: imx8m: Add missing interrupt property

Andrew Davis (2):
      clk: keystone: syscon-clk: Allow the clock node to not be of type syscon
      dt-bindings: clock: ehrpwm: Remove unneeded syscon compatible

AngeloGioacchino Del Regno (5):
      clk: mediatek: mux: Stop forcing CLK_SET_RATE_PARENT flag
      clk: mediatek: Remove CLK_SET_PARENT from all MSDC core clocks
      clk: mediatek: clk-mtk: Grab iomem pointer for divider clocks
      clk: mediatek: clk-mt8173-apmixedsys: Fix return value for of_iomap() error
      clk: mediatek: clk-mt8173-apmixedsys: Fix iomap not released issue

Arnd Bergmann (1):
      clk: samsung: add CONFIG_OF dependency

Artur Weber (3):
      dt-bindings: clock: samsung,exynos: add Exynos4212 clock compatible
      clk: samsung: Add Exynos4212 compatible to CLKOUT driver
      clk: samsung: Re-add support for Exynos4212 CPU clock

Biju Das (1):
      clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write

Bosi Zhang (1):
      clk: mediatek: fix of_iomap memory leak

Chen-Yu Tsai (1):
      clk: mediatek: Enable all MT8192 clocks by default

Claudiu Beznea (11):
      dt-bindings: clocks: atmel,at91rm9200-pmc: convert to yaml
      dt-bindings: clocks: at91sam9x5-sckc: convert to yaml
      clk: vc5: check memory returned by kasprintf()
      clk: cdce925: check return value of kasprintf()
      clk: si5341: return error if one synth clock registration fails
      clk: si5341: check return value of {devm_}kasprintf()
      clk: si5341: free unused memory on probe failure
      clk: keystone: sci-clk: check return value of kasprintf()
      clk: ti: clkctrl: check return value of kasprintf()
      clk: clocking-wizard: check return value of devm_kasprintf()
      clk: fix typo in clk_hw_register_fixed_rate_parent_data() macro

Conor Dooley (1):
      clk: microchip: convert SOC_MICROCHIP_POLARFIRE to ARCH_MICROCHIP_POLARFIRE

Dan Carpenter (3):
      clk: imx: scu: use _safe list iterator to avoid a use after free
      clk: bcm: rpi: Fix off by one in raspberrypi_discover_clocks()
      clk: clocking-wizard: Fix Oops in clk_wzrd_register_divider()

Dmitry Rokosov (6):
      dt-bindings: clock: meson: add A1 PLL clock controller bindings
      dt-bindings: clock: meson: add A1 Peripherals clock controller bindings
      clk: meson: make pll rst bit as optional
      clk: meson: introduce new pll power-on sequence for A1 SoC family
      clk: meson: a1: add Amlogic A1 PLL clock controller driver
      clk: meson: a1: add Amlogic A1 Peripherals clock controller driver

Fabio Estevam (1):
      clk: imx: imx6sx: Remove CLK_SET_RATE_PARENT from the LDB clocks

Fei Shao (1):
      clk: Fix memory leak in devm_clk_notifier_register()

Geert Uytterhoeven (6):
      iopoll: Call cpu_relax() in busy loops
      iopoll: Do not use timekeeping in read_poll_timeout_atomic()
      Merge tag 'iopoll-busy-loop-timeout-tag' into renesas-clk-for-v6.5
      clk: renesas: cpg-mssr: Convert to readl_poll_timeout_atomic()
      clk: renesas: mstp: Convert to readl_poll_timeout_atomic()
      clk: renesas: rzg2l: Convert to readl_poll_timeout_atomic()

Hao Luo (1):
      clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe

Jai Luthra (2):
      dt-bindings: clock: Add binding documentation for TI Audio REFCLK
      clk: keystone: syscon-clk: Add support for audio refclk

Jiapeng Chong (1):
      clk: meson: pll: remove unneeded semicolon

Kai Ma (1):
      clk: imx: clk-imxrt1050: fix memory leak in imxrt1050_clocks_probe

Krzysztof Kozlowski (1):
      dt-bindings: clock: drop unneeded quotes and use absolute /schemas path

Lukas Bulwahn (1):
      MAINTAINERS: repair pattern in ARM/Amlogic Meson SoC CLOCK FRAMEWORK

Marek Szyprowski (1):
      clk: Fix best_parent_rate after moving code into a separate function

Marek Vasut (5):
      clk: vc5: Fix .driver_data content in i2c_device_id
      clk: vc7: Fix .driver_data content in i2c_device_id
      clk: rs9: Fix .driver_data content in i2c_device_id
      clk: vc5: Use device_get_match_data() instead of of_device_get_match_data()
      clk: vc7: Use device_get_match_data() instead of of_device_get_match_data()

Maxime Ripard (66):
      clk: Export clk_hw_forward_rate_request()
      clk: test: Fix type sign of rounded rate variables
      clk: lan966x: Remove unused round_rate hook
      clk: nodrv: Add a determine_rate hook
      clk: test: Add a determine_rate hook
      clk: actions: composite: Add a determine_rate hook for pass clk
      clk: at91: main: Add a determine_rate hook
      clk: at91: sckc: Add a determine_rate hook
      clk: berlin: div: Add a determine_rate hook
      clk: cdce706: Add a determine_rate hook
      clk: k210: pll: Add a determine_rate hook
      clk: k210: aclk: Add a determine_rate hook
      clk: k210: mux: Add a determine_rate hook
      clk: lmk04832: clkout: Add a determine_rate hook
      clk: lochnagar: Add a determine_rate hook
      clk: qoriq: Add a determine_rate hook
      clk: si5341: Add a determine_rate hook
      clk: stm32f4: mux: Add a determine_rate hook
      clk: vc5: mux: Add a determine_rate hook
      clk: vc5: clkout: Add a determine_rate hook
      clk: wm831x: clkout: Add a determine_rate hook
      clk: davinci: da8xx-cfgchip: Add a determine_rate hook
      clk: davinci: da8xx-cfgchip: Add a determine_rate hook
      clk: imx: busy: Add a determine_rate hook
      clk: imx: fixup-mux: Add a determine_rate hook
      clk: imx: scu: Add a determine_rate hook
      clk: mediatek: cpumux: Add a determine_rate hook
      clk: pxa: Add a determine_rate hook
      clk: renesas: r9a06g032: Add a determine_rate hook
      clk: socfpga: gate: Add a determine_rate hook
      clk: stm32: core: Add a determine_rate hook
      clk: tegra: bpmp: Add a determine_rate hook
      clk: tegra: super: Add a determine_rate hook
      clk: tegra: periph: Add a determine_rate hook
      clk: ux500: prcmu: Add a determine_rate hook
      clk: ux500: sysctrl: Add a determine_rate hook
      clk: versatile: sp810: Add a determine_rate hook
      drm/tegra: sor: Add a determine_rate hook
      phy: cadence: sierra: Add a determine_rate hook
      phy: cadence: torrent: Add a determine_rate hook
      phy: ti: am654-serdes: Add a determine_rate hook
      phy: ti: j721e-wiz: Add a determine_rate hook
      rtc: sun6i: Add a determine_rate hook
      ASoC: tlv320aic32x4: Add a determine_rate hook
      clk: actions: composite: div: Switch to determine_rate
      clk: actions: composite: fact: Switch to determine_rate
      clk: at91: smd: Switch to determine_rate
      clk: axi-clkgen: Switch to determine_rate
      clk: cdce706: divider: Switch to determine_rate
      clk: cdce706: clkout: Switch to determine_rate
      clk: si5341: Switch to determine_rate
      clk: si5351: pll: Switch to determine_rate
      clk: si5351: msynth: Switch to determine_rate
      clk: si5351: clkout: Switch to determine_rate
      clk: da8xx: clk48: Switch to determine_rate
      clk: imx: scu: Switch to determine_rate
      clk: ingenic: cgu: Switch to determine_rate
      clk: ingenic: tcu: Switch to determine_rate
      clk: sprd: composite: Switch to determine_rate
      clk: st: flexgen: Switch to determine_rate
      clk: stm32: composite: Switch to determine_rate
      clk: tegra: periph: Switch to determine_rate
      clk: tegra: super: Switch to determine_rate
      ASoC: tlv320aic32x4: pll: Switch to determine_rate
      ASoC: tlv320aic32x4: div: Switch to determine_rate
      clk: Forbid to register a mux without determine_rate

Patrick Delaunay (1):
      dt-bindings: rcc: stm32: Sync with u-boot copy for STM32MP13 SoC

Peng Fan (1):
      clk: imx: drop imx_unregister_clocks

Rob Herring (5):
      clk: microchip: Use of_property_read_bool() for boolean properties
      clk: mvebu: Use of_address_to_resource()
      MAINTAINERS: Add Marvell mvebu clock drivers
      clk: mvebu: Use of_get_cpu_hwid() to read CPU ID
      clk: mvebu: Iterate over possible CPUs instead of DT CPU nodes

Roman Beranek (1):
      clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux

Runyang Chen (2):
      dt-bindings: reset: mt8188: add thermal reset control bit
      clk: mediatek: reset: add infra_ao reset support for MT8188

Stephen Boyd (16):
      Merge tag 'renesas-clk-for-v6.5-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      clk: Move no reparent case into a separate function
      clk: Introduce clk_hw_determine_rate_no_reparent()
      Merge tag 'renesas-clk-for-v6.5-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-meson-v6.5-1' of https://github.com/BayLibre/clk-meson into clk-allwinner
      Merge tag 'sunxi-clk-for-6.5-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'samsung-clk-6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      clk: meson: a1: Staticize rtc clk
      ASoC: tlv320aic32x4: pll: Remove impossible condition in clk_aic32x4_pll_determine_rate()
      clk: sprd: composite: Simplify determine_rate implementation
      Merge tag 'clk-imx-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'clk-microchip-6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-microchip
      Merge tag 'clk-meson-v6.5-2' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge branches 'clk-platform', 'clk-i2c', 'clk-mediatek', 'clk-i2cid' and 'clk-vc5' into clk-next
      Merge branches 'clk-renesas', 'clk-determine-rate', 'clk-allwinner', 'clk-samsung' and 'clk-amlogic' into clk-next
      Merge branches 'clk-imx', 'clk-microchip', 'clk-cleanup', 'clk-bindings', 'clk-ti' and 'clk-kasprintf' into clk-next

Uwe Kleine-König (5):
      clk: mediatek: Make mtk_clk_simple_remove() return void
      clk: mediatek: Make mtk_clk_pdev_remove() return void
      clk: mediatek: Convert all remaining drivers to platform_driver's .remove_new()
      clk: Switch i2c drivers back to use .probe()
      clk: si521xx: Switch i2c driver back to use .probe()

Wolfram Sang (1):
      clk: renesas: r8a779a0: Add PWM clock

Yang Li (1):
      clk: sifive: Use devm_platform_ioremap_resource()

Yuan Can (1):
      clk: tegra: tegra124-emc: Fix potential memory leak

Yuxing Liu (1):
      clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()

Zhanhao Hu (1):
      clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_probe

 .../clock/amlogic,a1-peripherals-clkc.yaml         |   73 +
 .../bindings/clock/amlogic,a1-pll-clkc.yaml        |   59 +
 .../devicetree/bindings/clock/at91-clock.txt       |   58 -
 .../bindings/clock/atmel,at91rm9200-pmc.yaml       |  154 ++
 .../bindings/clock/atmel,at91sam9x5-sckc.yaml      |   70 +
 .../devicetree/bindings/clock/imx8m-clock.yaml     |    3 +
 .../devicetree/bindings/clock/ingenic,cgu.yaml     |    4 +-
 .../bindings/clock/renesas,r9a06g032-sysctrl.yaml  |    2 +-
 .../bindings/clock/samsung,exynos-clock.yaml       |    1 +
 .../bindings/clock/ti,am62-audio-refclk.yaml       |   43 +
 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml      |    5 +-
 MAINTAINERS                                        |    2 +
 drivers/clk/actions/owl-composite.c                |   35 +-
 drivers/clk/at91/clk-main.c                        |    1 +
 drivers/clk/at91/clk-smd.c                         |   29 +-
 drivers/clk/at91/sckc.c                            |    1 +
 drivers/clk/bcm/clk-raspberrypi.c                  |    4 +-
 drivers/clk/berlin/berlin2-div.c                   |    1 +
 drivers/clk/clk-axi-clkgen.c                       |   14 +-
 drivers/clk/clk-cdce706.c                          |   32 +-
 drivers/clk/clk-cdce925.c                          |   14 +-
 drivers/clk/clk-cs2000-cp.c                        |    2 +-
 drivers/clk/clk-k210.c                             |    3 +
 drivers/clk/clk-lan966x.c                          |   17 -
 drivers/clk/clk-lmk04832.c                         |    1 +
 drivers/clk/clk-lochnagar.c                        |    1 +
 drivers/clk/clk-max9485.c                          |    2 +-
 drivers/clk/clk-qoriq.c                            |    1 +
 drivers/clk/clk-renesas-pcie.c                     |    6 +-
 drivers/clk/clk-si514.c                            |    2 +-
 drivers/clk/clk-si521xx.c                          |    2 +-
 drivers/clk/clk-si5341.c                           |   59 +-
 drivers/clk/clk-si5351.c                           |   69 +-
 drivers/clk/clk-si544.c                            |    2 +-
 drivers/clk/clk-si570.c                            |    2 +-
 drivers/clk/clk-stm32f4.c                          |    1 +
 drivers/clk/clk-versaclock5.c                      |   52 +-
 drivers/clk/clk-versaclock7.c                      |    7 +-
 drivers/clk/clk-wm831x.c                           |    1 +
 drivers/clk/clk.c                                  |  111 +-
 drivers/clk/clk_test.c                             |  180 +-
 drivers/clk/davinci/da8xx-cfgchip.c                |   12 +-
 drivers/clk/imx/clk-busy.c                         |    1 +
 drivers/clk/imx/clk-composite-8m.c                 |   31 +
 drivers/clk/imx/clk-fixup-mux.c                    |    1 +
 drivers/clk/imx/clk-imx6sx.c                       |    8 +-
 drivers/clk/imx/clk-imx6ul.c                       |    2 +
 drivers/clk/imx/clk-imx8mn.c                       |    8 +-
 drivers/clk/imx/clk-imx8mp.c                       |   24 +-
 drivers/clk/imx/clk-imx93.c                        |   15 +-
 drivers/clk/imx/clk-imxrt1050.c                    |   22 +-
 drivers/clk/imx/clk-scu.c                          |   24 +-
 drivers/clk/imx/clk.c                              |    8 -
 drivers/clk/imx/clk.h                              |    1 -
 drivers/clk/ingenic/cgu.c                          |   15 +-
 drivers/clk/ingenic/tcu.c                          |   19 +-
 drivers/clk/keystone/sci-clk.c                     |    2 +
 drivers/clk/keystone/syscon-clk.c                  |   49 +-
 drivers/clk/mediatek/Kconfig                       |   12 +
 drivers/clk/mediatek/clk-cpumux.c                  |    1 +
 drivers/clk/mediatek/clk-mt2701-aud.c              |    6 +-
 drivers/clk/mediatek/clk-mt2701-bdp.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-eth.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c       |    6 +-
 drivers/clk/mediatek/clk-mt2712-bdp.c              |    2 +-
 drivers/clk/mediatek/clk-mt2712-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c           |    2 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt2712-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt2712-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt2712.c                  |    2 +-
 drivers/clk/mediatek/clk-mt6765-audio.c            |    2 +-
 drivers/clk/mediatek/clk-mt6765-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt6765-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c           |    2 +-
 drivers/clk/mediatek/clk-mt6765-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c           |    2 +-
 drivers/clk/mediatek/clk-mt6765.c                  |   20 +-
 drivers/clk/mediatek/clk-mt6779-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt6779-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt6779-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt6779-ipe.c              |    2 +-
 drivers/clk/mediatek/clk-mt6779-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt6779-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt6779-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt6779.c                  |   26 +-
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c       |    6 +-
 drivers/clk/mediatek/clk-mt6795-infracfg.c         |    6 +-
 drivers/clk/mediatek/clk-mt6795-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt6795-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt6795-pericfg.c          |    6 +-
 drivers/clk/mediatek/clk-mt6795-topckgen.c         |    2 +-
 drivers/clk/mediatek/clk-mt6795-vdecsys.c          |    2 +-
 drivers/clk/mediatek/clk-mt6795-vencsys.c          |    2 +-
 drivers/clk/mediatek/clk-mt6797-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt6797-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt6797-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c       |    6 +-
 drivers/clk/mediatek/clk-mt7622-aud.c              |    6 +-
 drivers/clk/mediatek/clk-mt7622-eth.c              |    2 +-
 drivers/clk/mediatek/clk-mt7622-hif.c              |    2 +-
 drivers/clk/mediatek/clk-mt7622-infracfg.c         |    6 +-
 drivers/clk/mediatek/clk-mt7622.c                  |    2 +-
 drivers/clk/mediatek/clk-mt7629-hif.c              |    2 +-
 drivers/clk/mediatek/clk-mt7981-eth.c              |    2 +-
 drivers/clk/mediatek/clk-mt7981-infracfg.c         |    2 +-
 drivers/clk/mediatek/clk-mt7981-topckgen.c         |   14 +-
 drivers/clk/mediatek/clk-mt7986-eth.c              |    2 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c         |    2 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c         |   14 +-
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c       |    6 +-
 drivers/clk/mediatek/clk-mt8135.c                  |    2 +-
 drivers/clk/mediatek/clk-mt8167-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt8167-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c           |    2 +-
 drivers/clk/mediatek/clk-mt8167-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8167.c                  |    2 +-
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c       |   13 +-
 drivers/clk/mediatek/clk-mt8173-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8173-infracfg.c         |    6 +-
 drivers/clk/mediatek/clk-mt8173-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8173-pericfg.c          |    2 +-
 drivers/clk/mediatek/clk-mt8173-topckgen.c         |   26 +-
 drivers/clk/mediatek/clk-mt8173-vdecsys.c          |    2 +-
 drivers/clk/mediatek/clk-mt8173-vencsys.c          |    2 +-
 drivers/clk/mediatek/clk-mt8183-audio.c            |    6 +-
 drivers/clk/mediatek/clk-mt8183-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8183-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c             |    2 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c             |    2 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c          |    2 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c         |    2 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c           |    2 +-
 drivers/clk/mediatek/clk-mt8183-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8183-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8183.c                  |   24 +-
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c       |    6 +-
 drivers/clk/mediatek/clk-mt8186-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c     |    2 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c         |    2 +-
 drivers/clk/mediatek/clk-mt8186-ipe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-mcu.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-mdp.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c         |   26 +-
 drivers/clk/mediatek/clk-mt8186-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8186-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8186-wpe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c    |    2 +-
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c       |    6 +-
 drivers/clk/mediatek/clk-mt8188-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-ccu.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c     |    2 +-
 drivers/clk/mediatek/clk-mt8188-infra_ao.c         |   26 +-
 drivers/clk/mediatek/clk-mt8188-ipe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-peri_ao.c          |    2 +-
 drivers/clk/mediatek/clk-mt8188-topckgen.c         |   46 +-
 drivers/clk/mediatek/clk-mt8188-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-vdo0.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-vdo1.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-vpp0.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-vpp1.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-wpe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c       |    6 +-
 drivers/clk/mediatek/clk-mt8192-aud.c              |    6 +-
 drivers/clk/mediatek/clk-mt8192-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c     |    2 +-
 drivers/clk/mediatek/clk-mt8192-ipe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-mdp.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8192-msdc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c         |    2 +-
 drivers/clk/mediatek/clk-mt8192-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8192-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8192.c                  |   25 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c       |    6 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c       |    6 +-
 drivers/clk/mediatek/clk-mt8195-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8195-ccu.c              |    2 +-
 drivers/clk/mediatek/clk-mt8195-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c     |    2 +-
 drivers/clk/mediatek/clk-mt8195-infra_ao.c         |    2 +-
 drivers/clk/mediatek/clk-mt8195-ipe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8195-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt8195-peri_ao.c          |    2 +-
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c         |    2 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |   52 +-
 drivers/clk/mediatek/clk-mt8195-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-vpp0.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-vpp1.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-wpe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8365-apu.c              |    2 +-
 drivers/clk/mediatek/clk-mt8365-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8365-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt8365-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8365-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8365-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8365.c                  |   40 +-
 drivers/clk/mediatek/clk-mt8516-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt8516.c                  |    2 +-
 drivers/clk/mediatek/clk-mtk.c                     |   25 +-
 drivers/clk/mediatek/clk-mtk.h                     |    4 +-
 drivers/clk/mediatek/clk-mux.c                     |    2 +-
 drivers/clk/meson/Kconfig                          |   20 +
 drivers/clk/meson/Makefile                         |    2 +
 drivers/clk/meson/a1-peripherals.c                 | 2243 ++++++++++++++++++++
 drivers/clk/meson/a1-peripherals.h                 |  113 +
 drivers/clk/meson/a1-pll.c                         |  356 ++++
 drivers/clk/meson/a1-pll.h                         |   47 +
 drivers/clk/meson/clk-pll.c                        |   47 +-
 drivers/clk/meson/clk-pll.h                        |    2 +
 drivers/clk/microchip/Kconfig                      |    4 +-
 drivers/clk/microchip/clk-pic32mzda.c              |    2 +-
 drivers/clk/mvebu/ap-cpu-clk.c                     |   16 +-
 drivers/clk/mvebu/armada_ap_cp_helper.c            |    8 +-
 drivers/clk/mvebu/clk-cpu.c                        |   14 +-
 drivers/clk/pxa/clk-pxa.c                          |    1 +
 drivers/clk/renesas/clk-mstp.c                     |   18 +-
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r9a06g032-clocks.c             |    1 +
 drivers/clk/renesas/renesas-cpg-mssr.c             |   31 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |   22 +-
 drivers/clk/renesas/rzg2l-cpg.h                    |    3 -
 drivers/clk/samsung/Kconfig                        |    1 +
 drivers/clk/samsung/clk-exynos-clkout.c            |    3 +
 drivers/clk/samsung/clk-exynos4.c                  |   44 +-
 drivers/clk/sifive/sifive-prci.c                   |    4 +-
 drivers/clk/socfpga/clk-gate.c                     |    1 +
 drivers/clk/sprd/composite.c                       |    9 +-
 drivers/clk/sprd/div.c                             |   14 +-
 drivers/clk/sprd/div.h                             |    5 -
 drivers/clk/st/clk-flexgen.c                       |   15 +-
 drivers/clk/stm32/clk-stm32-core.c                 |   33 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |   14 +-
 drivers/clk/tegra/clk-bpmp.c                       |    1 +
 drivers/clk/tegra/clk-periph.c                     |   17 +-
 drivers/clk/tegra/clk-super.c                      |   16 +-
 drivers/clk/tegra/clk-tegra124-emc.c               |    2 +
 drivers/clk/ti/clkctrl.c                           |    7 +
 drivers/clk/ux500/clk-prcmu.c                      |    1 +
 drivers/clk/ux500/clk-sysctrl.c                    |    1 +
 drivers/clk/versatile/clk-sp810.c                  |    1 +
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c         |    7 +-
 drivers/gpu/drm/tegra/sor.c                        |    1 +
 drivers/phy/cadence/phy-cadence-sierra.c           |    1 +
 drivers/phy/cadence/phy-cadence-torrent.c          |    1 +
 drivers/phy/ti/phy-am654-serdes.c                  |    1 +
 drivers/phy/ti/phy-j721e-wiz.c                     |    1 +
 drivers/rtc/rtc-sun6i.c                            |    1 +
 .../clock/amlogic,a1-peripherals-clkc.h            |  115 +
 include/dt-bindings/clock/amlogic,a1-pll-clkc.h    |   20 +
 include/dt-bindings/clock/stm32mp13-clks.h         |    6 +-
 include/dt-bindings/reset/mt8188-resets.h          |    5 +
 include/dt-bindings/reset/stm32mp13-resets.h       |    4 +-
 include/linux/clk-provider.h                       |    4 +-
 include/linux/iopoll.h                             |   24 +-
 sound/soc/codecs/tlv320aic32x4-clk.c               |   29 +-
 277 files changed, 4645 insertions(+), 841 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/at91-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/ti,am62-audio-refclk.yaml
 create mode 100644 drivers/clk/meson/a1-peripherals.c
 create mode 100644 drivers/clk/meson/a1-peripherals.h
 create mode 100644 drivers/clk/meson/a1-pll.c
 create mode 100644 drivers/clk/meson/a1-pll.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
