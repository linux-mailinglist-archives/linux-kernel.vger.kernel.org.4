Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027506F220D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347237AbjD2B0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjD2B0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:26:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE322728;
        Fri, 28 Apr 2023 18:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9354614AD;
        Sat, 29 Apr 2023 01:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060D6C433D2;
        Sat, 29 Apr 2023 01:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682731556;
        bh=MxC1UykHAxln83LkkE2SWAQzjurlunmaVRTug2GOM1E=;
        h=From:To:Cc:Subject:Date:From;
        b=aWqLp9/KnGHdp/7tYls3y5cYatO5S2Qp4RBwlxmv7v49jaiNBvDMiiO3yfe0SeyYo
         Zy07OgmaqQf+q1SB5vcwxkSE/6LvRWbBC9sGCASccaGnJOa1fY0MdP65Qbii7SbLc7
         JiROKFF3x7SHnLsP1r9Pj9Uui9qGIc5k9bDnt9ssqmnu5ooNJD9qM7QW00dek4ucv0
         N5dbh/fvCFYp6FafaCZWMFNFlOlloFCakfOA6sjMCxVwcKVilcdd3seGpfQ6DE38ph
         IuzsTyKkC8JIyQwktGdC1In2a0upvpY5YlXzK26RNoW9FodVkxcY1eZxPREM0JHTOY
         VtcMDse/d+yFQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Fri, 28 Apr 2023 18:25:55 -0700
Message-ID: <20230429012555.2883350-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b065b23d3c3bc91f7e54f9bff4294a7bfbd2afb6:

  dt-bindings: clock: Add ipq9574 clock and reset definitions (2023-04-07 10:27:16 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to a9863979fbc25838bbe7c5badf538cedfc802f60:

  Merge branch 'clk-imx' into clk-next (2023-04-25 11:52:39 -0700)

----------------------------------------------------------------
Nothing looks out of the ordinary in this batch of clk driver updates. There
are a couple patches to the core clk framework, but they're all basically
cleanups or debugging aids. The driver updates and new additions are dominated
in the diffstat by Qualcomm and MediaTek drivers. Qualcomm gained a handful of
new drivers for various SoCs, and MediaTek gained a bunch of drivers for
MT8188. The MediaTek drivers are being modernized as well, so there are
updates all over that vendor's clk drivers. There's also a couple other new clk
drivers in here, for example the Starfive JH7110 SoC support is added.

Outside of the two major SoC vendors though, we have the usual collection of
non-critical fixes and cleanups to various clk drivers. It's good to see that
we're getting more cleanups and modernization patches. Maybe one day we'll be
able to properly split clk providers from clk consumers.

Core:
 - Print an informational message before disabling unused clks

New Drivers:
 - BCM63268 timer clock and reset controller
 - Frequency Hopping (FHCTL) on MediaTek MT6795, MT8173, MT8192 and
   MT8195 SoCs
 - Mediatek MT8188 SoC clk drivers
 - Clock driver for Sunplus SP7021 SoC
 - Clk driver support for Loongson-2 SoCs
 - Clock driver for Skyworks Si521xx I2C PCIe clock generators
 - Initial Starfive JH7110 clk/reset support
 - Global clock controller drivers for Qualcomm SM7150, IPQ9574, MSM8917 and IPQ5332 SoCs
 - GPU clock controller drivers for SM6115, SM6125, SM6375 and SA8775P SoCs

Updates:
 - Shrink size of clk_fractional_divider a little
 - Convert various clk drivers to devm_of_clk_add_hw_provider()
 - Convert platform clk drivers to remove_new()
 - Converted most Mediatek clock drivers to struct platform_driver
 - MediaTek clock drivers can be built as modules
 - Reimplement Loongson-1 clk driver with DT support
 - Migrate socfpga clk driver to of_clk_add_hw_provider()
 - Support for i3c clks on Aspeed ast2600 SoCs
 - Add clock generic devm_clk_hw_register_gate_parent_data
 - Add audiomix block control for i.MX8MP
 - Add support for determine_rate to i.MX composite-8m
 - Let the LCDIF Pixel clock of i.MX8MM and i.MX8MN set parent rate
 - Provide clock name in error message for clk-gpr-mux on get parent failure
 - Drop duplicate imx_clk_mux_flags macro
 - Register the i.MX8MP Media Disp2 Pix clock as bus clock
 - Add Media LDB root clock to i.MX8MP
 - Make i.MX8MP nand_usdhc_bus clock as non-critical
 - Fix the rate table for i.MX fracn-gppll
 - Disable HW control for the fracn-gppll in order to be controlled by
   register write
 - Add support for interger PLL in fracn-gppll
 - Add mcore_booted module parameter to i.MX93 provider
 - Add NIC, A55 and ARM PLL clocks to i.MX93
 - Fix i.MX8ULP XBAR_DIVBUS and AD_SLOW clock parents
 - Use "divider closest" clock type for PLL4_PFD dividers on i.MX8ULP to
   get more accurate clock rates
 - Mark the MU0_Bi and TPM5 clocks on i.MX8ULP as critical
 - Update some of the i.MX critical clocks flags to allow glitchless
   on-the-fly rate change.
 - Add I2C5 clock on Renesas R-Car V3H
 - Exynos850: Add CMU_G3D clock controller for the Mali GPU
 - Extract Exynos5433 (ARM64) clock controller power management code to
   common driver parts
 - Exynos850: make PMU_ALIVE_PCLK clock critical
 - Add Audio, thermal, camera (CSI-2), Image Signal Processor/Channel
   Selector (ISPCS), and video capture (VIN) clocks on Renesas R-Car V4H
 - Add video capture (VIN) clocks on Renesas R-Car V3H
 - Add Cortex-A53 System CPU (Z2) clocks on Renesas R-Car V3M and V3H
 - Support for Stromer Plus PLL on Qualcomm IPQ5332
 - Add a missing reset to Qualcomm QCM2290
 - Migrate Qualcomm IPQ4019 to clk_parent_data
 - Make USB GDSCs enter retention state when disabled on Qualcomm SM6375,
   MSM8996 and MSM8998 SoCs
 - Set floor rounding clk_ops for Qualcomm QCM2290 SDCC2 clk
 - Add two EMAC GDSCs on Qualcomm SC8280XP
 - Use shared rcg clk ops in Qualcomm SM6115 GCC
 - Park Qualcomm SM8350 PCIe PIPE clks when disabled
 - Add GDSCs to Qualcomm SC7280 LPASS audio clock controller
 - Add missing XO clocks to Qualcomm MSM8226 and MSM8974
 - Convert some Qualcomm clk DT bindings to YAML
 - Reparenting fix for the clock supplying camera modules on Rockchip rk3399
 - Mark more critical (bus-)clocks on Rockchip rk3588

----------------------------------------------------------------
Adam Ford (4):
      clk: imx: composite-8m: Add support to determine_rate
      clk: imx: Add imx8m_clk_hw_composite_flags macro
      clk: imx8mm: Let IMX8MM_CLK_LCDIF_PIXEL set parent rate
      clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate

Alexander Stein (4):
      clk: rs9: Check for vendor/device ID
      dt-bindings: clk: rs9: Add 9FGV0441
      clk: rs9: Support device specific dif bit calculation
      clk: rs9: Add support for 9FGV0441

Andrew Halaney (1):
      clk: qcom: gcc-sc8280xp: Add EMAC GDSCs

AngeloGioacchino Del Regno (61):
      clk: mediatek: fhctl: Add support for older fhctl register layout
      clk: mediatek: clk-pllfh: Export register/unregister/parse functions
      dt-bindings: clock: mediatek,mt8186-fhctl: Support MT6795, MT8173/92/95
      clk: mediatek: mt6795: Add support for frequency hopping through FHCTL
      clk: mediatek: mt8173: Add support for frequency hopping through FHCTL
      clk: mediatek: mt8192: Add support for frequency hopping through FHCTL
      clk: mediatek: mt8195: Add support for frequency hopping through FHCTL
      clk: mediatek: clk-mtk: Switch to device_get_match_data()
      clk: mediatek: clk-mtk: Introduce clk_mtk_pdev_{probe,remove}()
      clk: mediatek: Migrate to mtk_clk_pdev_probe() for multimedia clocks
      clk: mediatek: Add divider clocks to mtk_clk_simple_{probe,remove}()
      clk: mediatek: mt2712: Migrate topckgen/mcucfg to mtk_clk_simple_probe()
      clk: mediatek: mt2712: Compress clock arrays entries to 90 columns
      clk: mediatek: mt2712: Add error handling to clk_mt2712_apmixed_probe()
      clk: mediatek: mt2712: Move apmixedsys clock driver to its own file
      clk: mediatek: mt2712-apmixedsys: Add .remove() callback for module build
      clk: mediatek: mt2712: Change to use module_platform_driver macro
      clk: mediatek: mt8365: Move apmixedsys clock driver to its own file
      clk: mediatek: mt8365: Convert simple_gate to mtk_gate clocks
      clk: mediatek: mt8365: Join top_misc_mux_gates and top_misc_muxes arrays
      clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()
      clk: mediatek: mt8167: Compress GATE_TOPx macros
      clk: mediatek: mt8167: Move apmixedsys as platform_driver in new file
      clk: mediatek: mt8167: Remove __initconst annotation from arrays
      clk: mediatek: mt8167: Convert to mtk_clk_simple_{probe,remove}()
      clk: mediatek: mt8183: Move apmixedsys clock driver to its own file
      clk: mediatek: mt8183: Compress clocks arrays entries where possible
      clk: mediatek: mt8183: Convert all remaining clocks to common probe
      clk: mediatek: Consistently use GATE_MTK() macro
      clk: mediatek: mt7622: Properly use CLK_IS_CRITICAL flag
      clk: mediatek: mt7622: Move apmixedsys clock driver to its own file
      clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module build
      clk: mediatek: mt7622: Move infracfg to clk-mt7622-infracfg.c
      clk: mediatek: mt7622: Convert to platform driver and simple probe
      clk: mediatek: mt8516: Move apmixedsys clock driver to its own file
      clk: mediatek: mt8516: Convert to platform driver and simple probe
      clk: mediatek: mt8516: Allow building clock drivers as modules
      clk: mediatek: Propagate struct device with mtk_clk_register_dividers()
      clk: mediatek: mt7986-apmixed: Use PLL_AO flag to set critical clock
      clk: mediatek: mt7986-infracfg: Migrate to common probe mechanism
      clk: mediatek: mt7986-eth: Migrate to common probe mechanism
      clk: mediatek: mt8186-mcu: Migrate to common probe mechanism
      clk: mediatek: Switch to module_platform_driver() where possible
      clk: mediatek: Add MODULE_LICENSE() where missing
      clk: mediatek: mt2712: Change Kconfig options to allow module build
      clk: mediatek: Split MT8195 clock drivers and allow module build
      clk: mediatek: Allow building MT8192 non-critical clocks as modules
      clk: mediatek: Allow MT7622 clocks to be built as modules
      clk: mediatek: Allow all MT8167 clocks to be built as modules
      clk: mediatek: Allow all MT8183 clocks to be built as modules
      clk: mediatek: Allow building most MT6765 clock drivers as modules
      clk: mediatek: Allow building most MT6797 clock drivers as modules
      clk: mediatek: Split configuration options for MT8186 clock drivers
      clk: mediatek: mt8192: Move apmixedsys clock driver to its own file
      clk: mediatek: Kconfig: Allow module build for core mt8192 clocks
      clk: mediatek: Add MODULE_DEVICE_TABLE() where appropriate
      clk: mediatek: mt8135: Move apmixedsys to its own file
      clk: mediatek: mt8135: Properly use CLK_IS_CRITICAL flag
      clk: mediatek: mt8135-apmixedsys: Convert to platform_driver and module
      clk: mediatek: mt8135: Join root_clk_alias and top_divs arrays
      clk: mediatek: mt8135: Convert to simple probe and enable module build

Arnd Bergmann (2):
      clk: mediatek: mt81xx: Ensure fhctl code is available
      clk: tegra20: fix gcc-7 constant overflow warning

Bartosz Golaszewski (1):
      dt-bindings: clock: qcom: describe the GPUCC clock for SA8775P

Bjorn Andersson (6):
      Merge branch '20230208091340.124641-1-konrad.dybcio@linaro.org' into clk-for-6.4
      Merge branch '20230213165318.127160-2-danila@jiaxyga.com' into clk-for-6.4
      Merge branch '20230307062232.4889-1-quic_kathirav@quicinc.com' into clk-for-6.4
      Merge branch '20230223180935.60546-1-otto.pflueger@abscue.de' into clk-for-6.4
      Merge branch '20230316-topic-qcm_dispcc_reset-v1-1-dd3708853014@linaro.org' into clk-for-6.4
      Merge branch '20230316072940.29137-2-quic_devipriy@quicinc.com' into clk-for-6.4

Christian Marangi (2):
      dt-bindings: arm: msm: Convert and split kpss-acc driver Documentation to yaml
      dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml

Christophe JAILLET (5):
      clk: stm32h7: Remove an unused field in struct stm32_fractional_divider
      clk: Compute masks for fractional_divider clk when needed.
      clk: imx: Remove values for mmask and nmask in struct clk_fractional_divider
      clk: rockchip: Remove values for mmask and nmask in struct clk_fractional_divider
      clk: Remove mmask and nmask fields in struct clk_fractional_divider

Claudiu Beznea (1):
      clk: at91: clk-sam9x60-pll: fix return value check

Clément Léger (1):
      clk: add missing of_node_put() in "assigned-clocks" property parsing

Conor Dooley (2):
      clk: sifive: make SiFive clk drivers depend on ARCH_ symbols
      clk: microchip: fix potential UAF in auxdev release callback

Danila Tikhonov (2):
      dt-bindings: clock: Add SM7150 GCC clocks
      clk: qcom: Add Global Clock Controller (GCC) driver for SM7150

Dario Binacchi (1):
      clk: visconti: remove unused visconti_pll_provider::regmap

Devi Priya (1):
      clk: qcom: Add Global Clock Controller driver for IPQ9574

Dmitry Baryshkov (1):
      clk: qcom: gcc-sm8350: fix PCIe PIPE clocks handling

Emil Renner Berthing (11):
      clk: starfive: Factor out common JH7100 and JH7110 code
      clk: starfive: Rename clk-starfive-jh7100.h to clk-starfive-jh71x0.h
      clk: starfive: Rename "jh7100" to "jh71x0" for the common code
      reset: Create subdirectory for StarFive drivers
      reset: starfive: Factor out common JH71X0 reset code
      reset: starfive: Extract the common JH71X0 reset code
      reset: starfive: Rename "jh7100" to "jh71x0" for the common code
      reset: starfive: jh71x0: Use 32bit I/O on 32bit registers
      clk: starfive: Add StarFive JH7110 system clock driver
      clk: starfive: Add StarFive JH7110 always-on clock driver
      MAINTAINERS: generalise StarFive clk/reset entries

Garmin.Chang (19):
      dt-bindings: clock: mediatek: Add new MT8188 clock
      clk: mediatek: Add MT8188 apmixedsys clock support
      clk: mediatek: Add MT8188 topckgen clock support
      clk: mediatek: Add MT8188 peripheral clock support
      clk: mediatek: Add MT8188 infrastructure clock support
      clk: mediatek: Add MT8188 camsys clock support
      clk: mediatek: Add MT8188 ccusys clock support
      clk: mediatek: Add MT8188 imgsys clock support
      clk: mediatek: Add MT8188 ipesys clock support
      clk: mediatek: Add MT8188 mfgcfg clock support
      clk: mediatek: Add MT8188 vdecsys clock support
      clk: mediatek: Add MT8188 vdosys0 clock support
      clk: mediatek: Add MT8188 vdosys1 clock support
      clk: mediatek: Add MT8188 vencsys clock support
      clk: mediatek: Add MT8188 vppsys0 clock support
      clk: mediatek: Add MT8188 vppsys1 clock support
      clk: mediatek: Add MT8188 wpesys clock support
      clk: mediatek: Add MT8188 imp i2c wrapper clock support
      clk: mediatek: Add MT8188 adsp clock support

Geert Uytterhoeven (4):
      clk: renesas: r8a779g0: Add thermal clock
      clk: renesas: r8a77995: Fix VIN parent clock
      clk: renesas: r8a77970: Add Z2 clock
      clk: renesas: r8a77980: Add Z2 clock

Haibo Chen (1):
      clk: imx: imx8mp: change the 'nand_usdhc_bus' clock to non-critical

Hal Feng (4):
      clk: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
      reset: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
      reset: starfive: Add StarFive JH7110 reset driver
      clk: starfive: Delete the redundant dev_set_drvdata() in JH7110 clock drivers

Jacky Bai (5):
      clk: imx: fracn-gppll: Add 300MHz freq support for imx9
      clk: imx: imx8ulp: Add divider closest support to get more accurate clock rate
      clk: imx: imx8ulp: keep MU0_B clock enabled always
      clk: imx: imx8ulp: Add tpm5 clock as critical gate clock
      clk: imx: imx8ulp: update clk flag for system critical clock

Jeremy Kerr (6):
      clk: ast2600: allow empty entries in aspeed_g6_gates
      dt-bindings: clock: ast2600: Add top-level I3C clock
      clk: ast2600: Add full configs for I3C clocks
      dt-bindings: clock: ast2600: remove IC36 & I3C7 clock definitions
      clk: ast2600: Add comment about combined clock + reset handling
      dt-bindings: clock: ast2600: Expand comment on reset definitions

Kathiravan T (6):
      clk: qcom: Add STROMER PLUS PLL type for IPQ5332
      clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC
      clk: qcom: ipq5332: mark GPLL4 as ignore unused temporarily
      clk: qcom: apss-ipq-pll: refactor the driver to accommodate different PLL types
      dt-bindings: clock: qcom,a53pll: add IPQ5332 compatible
      clk: qcom: apss-ipq-pll: add support for IPQ5332

Keguang Zhang (4):
      dt-bindings: clock: Add Loongson-1 clock
      clk: loongson1: Remove the outdated driver
      clk: loongson1: Re-implement the clock driver
      MIPS: loongson32: Update the clock initialization

Konrad Dybcio (17):
      clk: qcom: branch: Add helper functions for setting retain bits
      clk: qcom: branch: Add helper functions for setting SLEEP/WAKE bits
      clk: qcom: branch: Move CBCR bits definitions to the header file
      clk: qcom: branch: Clean up branch enable registers
      clk: qcom: Add GPU clock controller driver for SM6125
      clk: qcom: Add GPU clock controller driver for SM6375
      clk: qcom: Add GPU clock controller driver for SM6115
      clk: qcom: gcc-qcm2290: Fix up gcc_sdcc2_apps_clk_src
      clk: qcom: gcc-sm6375: Update the .pwrsts for usb gdsc
      clk: qcom: gcc-msm8996: Update the .pwrsts for usb gdsc
      clk: qcom: gcc-msm8998: Update the .pwrsts for usb gdsc
      clk: Print an info line before disabling unused clocks
      dt-bindings: clock: dispcc-qcm2290: Add MDSS_CORE reset
      clk: qcom: dispcc-qcm2290: Add MDSS_CORE reset
      clk: qcom: gcc-sm6115: Mark RCGs shared where applicable
      clk: qcom: gpucc-sm6375: Configure CX_GDSC disable wait value
      clk: qcom: dispcc-qcm2290: Remove inexistent DSI1PHY clk

Krzysztof Kozlowski (3):
      Merge branch 'for-v6.4/clk-exynos850-dt-binding' into next/clk
      dt-bindings: mailbox: qcom,apcs-kpss-global: correct SDX55 clocks
      dt-bindings: mailbox: qcom,apcs-kpss-global: fix SDX55 'if' match

Kuninori Morimoto (1):
      clk: renesas: r8a779g0: Add Audio clocks

Lars-Peter Clausen (11):
      clk: axi-clkgen: Use managed `of_clk_add_hw_provider()`
      clk: axm5516: Use managed `of_clk_add_hw_provider()`
      clk: axs10x: Use managed `of_clk_add_hw_provider()`
      clk: cdce706: Use managed `of_clk_add_hw_provider()`
      clk: hsdk-pll: Use managed `of_clk_add_hw_provider()`
      clk: lmk04832: Use managed `of_clk_add_hw_provider()`
      clk: si514: Use managed `of_clk_add_hw_provider()`
      clk: si570: Use managed `of_clk_add_hw_provider()`
      clk: si5351: Use managed `of_clk_add_hw_provider()`
      clk: uniphier: Use managed `of_clk_add_hw_provider()`
      clk: qcom: rpm: Use managed `of_clk_add_hw_provider()`

Liu Ying (1):
      clk: imx: imx8mp: Add LDB root clock

Luca Weiss (2):
      clk: qcom: clk-krait: switch to .determine_rate
      clk: qcom: clk-hfpll: switch to .determine_rate

Lukas Bulwahn (1):
      MAINTAINERS: remove obsolete file entry in MIPS/LOONGSON1 ARCHITECTURE

Marco Pagani (6):
      clk: socfpga: use of_clk_add_hw_provider and improve error handling
      clk: socfpga: arria10: use of_clk_add_hw_provider and improve error handling
      clk: socfpga: use of_clk_add_hw_provider and improve error handling
      clk: socfpga: arria10: use of_clk_add_hw_provider and improve error handling
      clk: socfpga: use of_clk_add_hw_provider and improve error handling
      clk: socfpga: arria10: use of_clk_add_hw_provider and improve error handling

Marek Vasut (5):
      dt-bindings: clk: si521xx: Add Skyworks Si521xx I2C PCIe clock generators
      clk: si521xx: Clock driver for Skyworks Si521xx I2C PCIe clock generators
      clk: Introduce devm_clk_hw_register_gate_parent_data()
      clk: imx: imx8mp: Add audiomix block control
      dt-bindings: clock: imx8mp: Add audiomix block control

Minghao Chi (1):
      clock: milbeaut: use devm_platform_get_and_ioremap_resource()

Mohammad Rafi Shaik (1):
      clk: qcom: lpassaudiocc-sc7280: Add required gdsc power domain clks in lpass_cc_sc7280_desc

Nikita Yushchenko (1):
      clk: renesas: r8a77980: Add I2C5 clock

Niklas Söderlund (4):
      clk: renesas: r8a779g0: Add CSI-2 clocks
      clk: renesas: r8a779g0: Add ISPCS clocks
      clk: renesas: r8a779g0: Add VIN clocks
      clk: renesas: r8a77980: Add VIN clocks

Otto Pflüger (4):
      dt-bindings: clock: Add MSM8917 global clock controller
      dt-bindings: clock: qcom,rpmcc: Add MSM8917
      clk: qcom: Add global clock controller driver for MSM8917
      clk: qcom: smd-rpm: Add clocks for MSM8917

Peng Fan (10):
      clk: imx: drop duplicated macro
      clk: imx: imx8mp: correct DISP2 pixel clock type
      dt-bindings: clock: imx8mp: Add LDB clock entry
      clk: imx: fracn-gppll: fix the rate table
      clk: imx: fracn-gppll: disable hardware select control
      clk: imx: fracn-gppll: support integer pll
      clk: imx: imx93: add mcore_booted module paratemter
      dt-bindings: clock: imx93: add NIC, A55 and ARM PLL CLK
      clk: imx: imx93: Add nic and A55 clk
      clk: imx: imx8ulp: Fix XBAR_DIVBUS and AD_SLOW clock parents

Qin Jian (1):
      clk: Add Sunplus SP7021 clock driver

Quentin Schulz (1):
      clk: rockchip: rk3399: allow clk_cifout to force clk_cifout_src to reparent

Ralph Siemsen (4):
      clk: renesas: r9a06g032: Improve readability
      clk: renesas: r9a06g032: Drop unused fields
      clk: renesas: r9a06g032: Document structs
      clk: renesas: r9a06g032: Improve clock tables

Rayyan Ansari (1):
      clk: qcom: smd: Add XO RPM clocks for MSM8226/MSM8974

Rob Herring (2):
      clk: Use of_property_present() for testing DT property presence
      clk: ti: Use of_address_to_resource()

Robert Marko (5):
      dt-bindings: clock: split qcom,gcc-ipq4019 to separate file
      clk: qcom: gcc-ipq4019: convert XO and sleep clk to parent_data
      clk: qcom: gcc-ipq4019: move PLL clocks up
      clk: qcom: gcc-ipq4019: move pcnoc clocks up
      clk: qcom: gcc-ipq4019: convert to parent data

Sam Protsenko (10):
      clk: samsung: Remove np argument from samsung_clk_init()
      clk: samsung: Don't pass reg_base to samsung_clk_register_pll()
      clk: samsung: Set dev in samsung_clk_init()
      clk: samsung: clk-pll: Implement pll0818x PLL type
      clk: samsung: exynos850: Implement CMU_G3D domain
      clk: samsung: exynos850: Add AUD and HSI main gate clocks
      clk: samsung: Extract clocks registration to common function
      clk: samsung: Extract parent clock enabling to common function
      clk: samsung: exynos5433: Extract PM support to common ARM64 layer
      clk: samsung: exynos850: Make PMU_ALIVE_PCLK critical

Sebastian Reichel (1):
      clk: rockchip: rk3588: make gate linked clocks critical

Shazad Hussain (1):
      clk: qcom: add the GPUCC driver for sa8775p

Shubhrajyoti Datta (2):
      clk: zynqmp: pll: Remove the limit
      clocking-wizard: Support higher frequency accuracy

Srinivasa Rao Mandadapu (2):
      dt-bindings: clock: qcom,sc7280-lpasscc: Add qcom,adsp-pil-mode property
      clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration

Stefan Wahren (1):
      clk: imx: clk-gpr-mux: Provide clock name in error message

Stephen Boyd (16):
      clk: mediatek: Ensure fhctl code is available for COMMON_CLK_MT6795
      Merge tag 'renesas-clk-for-v6.4-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'samsung-clk-6.4' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      clk: mediatek: Use right match table, include mod_devicetable
      Merge tag 'riscv-jh7110-clk-reset-for-6.4' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into clk-starfive
      Merge tag 'renesas-clk-for-v6.4-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-imx-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      clk: starfive: Avoid casting iomem pointers
      Merge tag 'v6.4-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'qcom-clk-for-6.4' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge branches 'clk-cleanup', 'clk-aspeed', 'clk-dt', 'clk-renesas' and 'clk-skyworks' into clk-next
      Merge branches 'clk-mediatek', 'clk-sunplus', 'clk-loongson' and 'clk-socfpga' into clk-next
      Merge branches 'clk-xilinx', 'clk-broadcom' and 'clk-platform' into clk-next
      Merge branches 'clk-starfive', 'clk-fractional' and 'clk-devmof' into clk-next
      Merge branches 'clk-of', 'clk-samsung', 'clk-rockchip' and 'clk-qcom' into clk-next
      Merge branch 'clk-imx' into clk-next

Takeshi Kihara (1):
      clk: renesas: cpg-mssr: Update MSSR register range for R-Car V4H

Tom Rix (2):
      clk: qcom: remove unused variables gpucc_parent_data,map_2
      clk: mediatek: fhctl: Mark local variables static

Uwe Kleine-König (28):
      clk: samsung: Convert to platform remove callback returning void
      clk: qcom: Convert to platform remove callback returning void
      clk: renesas: Convert to platform remove callback returning void
      clk: tegra: Don't warn three times about failure to unregister
      clk: xilinx: Drop if block with always false condition
      clk: axs10x: Convert to platform remove callback returning void
      clk: bcm: Convert to platform remove callback returning void
      clk: axi-clkgen: Convert to platform remove callback returning void
      clk: axm5516: Convert to platform remove callback returning void
      clk: fixed-factor: Convert to platform remove callback returning void
      clk: fixed-mmio: Convert to platform remove callback returning void
      clk: fixed-rate: Convert to platform remove callback returning void
      clk: hsdk-pll: Convert to platform remove callback returning void
      clk: palmas: Convert to platform remove callback returning void
      clk: pwm: Convert to platform remove callback returning void
      clk: s2mps11: Convert to platform remove callback returning void
      clk: scpi: Convert to platform remove callback returning void
      clk: stm32mp1: Convert to platform remove callback returning void
      clk: hisilicon: Convert to platform remove callback returning void
      clk: keystone: Convert to platform remove callback returning void
      clk: mmp: Convert to platform remove callback returning void
      clk: mvebu: Convert to platform remove callback returning void
      clk: stm32: Convert to platform remove callback returning void
      clk: tegra: Convert to platform remove callback returning void
      clk: ti: Convert to platform remove callback returning void
      clk: uniphier: Convert to platform remove callback returning void
      clk: x86: Convert to platform remove callback returning void
      clk: xilinx: Convert to platform remove callback returning void

Varadarajan Narayanan (1):
      clk: qcom: clk-alpha-pll: Add support for Stromer PLLs

Yang Yingliang (1):
      clk: mediatek: clk-pllfh: fix missing of_node_put() in fhctl_parse_dt()

Yinbo Zhu (2):
      dt-bindings: clock: add loongson-2 boot clock index
      clk: clk-loongson2: add clock controller driver support

Yu Zhe (1):
      clk: remove unnecessary (void*) conversions

Álvaro Fernández Rojas (4):
      dt-bindings: clk: add BCM63268 timer clock definitions
      dt-bindings: reset: add BCM63268 timer reset definitions
      dt-bindings: clock: Add BCM63268 timer binding
      clk: bcm: Add BCM63268 timer clock and reset driver

 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt             |   49 -
 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt             |   44 -
 Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml |   40 +
 Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml            |   79 +
 Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml          |   45 +
 Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml      |    7 +-
 Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml      |   71 +
 Documentation/devicetree/bindings/clock/mediatek,mt8188-sys-clock.yaml  |   55 +
 Documentation/devicetree/bindings/clock/qcom,a53pll.yaml                |    1 +
 Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml           |   53 +
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8909.yaml           |   13 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml             |    2 -
 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml                 |    2 +
 Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml           |   72 +
 Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml              |   88 +
 Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml                 |    2 +
 Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml        |    7 +
 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml            |   52 +
 Documentation/devicetree/bindings/clock/renesas,9series.yaml            |    6 +
 Documentation/devicetree/bindings/clock/skyworks,si521xx.yaml           |   59 +
 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml    |    9 +-
 Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml           |   42 +
 MAINTAINERS                                                             |   17 +-
 arch/mips/include/asm/mach-loongson32/platform.h                        |    1 -
 arch/mips/loongson32/common/time.c                                      |    3 +-
 drivers/clk/Kconfig                                                     |   28 +
 drivers/clk/Makefile                                                    |    7 +-
 drivers/clk/at91/clk-sam9x60-pll.c                                      |    2 +-
 drivers/clk/axs10x/i2s_pll_clock.c                                      |    5 +-
 drivers/clk/axs10x/pll_clock.c                                          |   11 +-
 drivers/clk/bcm/Kconfig                                                 |    9 +
 drivers/clk/bcm/Makefile                                                |    1 +
 drivers/clk/bcm/clk-bcm2711-dvp.c                                       |    6 +-
 drivers/clk/bcm/clk-bcm63268-timer.c                                    |  216 ++
 drivers/clk/bcm/clk-bcm63xx-gate.c                                      |    6 +-
 drivers/clk/bcm/clk-raspberrypi.c                                       |    6 +-
 drivers/clk/clk-ast2600.c                                               |   67 +-
 drivers/clk/clk-axi-clkgen.c                                            |   12 +-
 drivers/clk/clk-axm5516.c                                               |    9 +-
 drivers/clk/clk-cdce706.c                                               |   11 +-
 drivers/clk/clk-conf.c                                                  |   12 +-
 drivers/clk/clk-fixed-factor.c                                          |    6 +-
 drivers/clk/clk-fixed-mmio.c                                            |    6 +-
 drivers/clk/clk-fixed-rate.c                                            |    6 +-
 drivers/clk/clk-fractional-divider.c                                    |   16 +-
 drivers/clk/clk-hsdk-pll.c                                              |   11 +-
 drivers/clk/clk-lmk04832.c                                              |    5 +-
 drivers/clk/clk-loongson1.c                                             |  303 +++
 drivers/clk/clk-loongson2.c                                             |  341 ++++
 drivers/clk/clk-milbeaut.c                                              |    4 +-
 drivers/clk/clk-palmas.c                                                |    5 +-
 drivers/clk/clk-pwm.c                                                   |    6 +-
 drivers/clk/clk-renesas-pcie.c                                          |   70 +-
 drivers/clk/clk-s2mps11.c                                               |    6 +-
 drivers/clk/clk-scpi.c                                                  |    5 +-
 drivers/clk/clk-si514.c                                                 |   10 +-
 drivers/clk/clk-si521xx.c                                               |  395 ++++
 drivers/clk/clk-si5351.c                                                |   10 +-
 drivers/clk/clk-si570.c                                                 |   14 +-
 drivers/clk/clk-sp7021.c                                                |  713 +++++++
 drivers/clk/clk-stm32h7.c                                               |    1 -
 drivers/clk/clk-stm32mp1.c                                              |    6 +-
 drivers/clk/clk.c                                                       |   10 +-
 drivers/clk/hisilicon/clk-hi3519.c                                      |    5 +-
 drivers/clk/hisilicon/clk-hi3559a.c                                     |    5 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c                                 |    5 +-
 drivers/clk/hisilicon/crg-hi3798cv200.c                                 |    5 +-
 drivers/clk/imx/Makefile                                                |    2 +-
 drivers/clk/imx/clk-composite-7ulp.c                                    |    4 -
 drivers/clk/imx/clk-composite-8m.c                                      |    7 +
 drivers/clk/imx/clk-composite-93.c                                      |    8 +-
 drivers/clk/imx/clk-fracn-gppll.c                                       |   91 +-
 drivers/clk/imx/clk-gpr-mux.c                                           |    3 +-
 drivers/clk/imx/clk-imx8mm.c                                            |    2 +-
 drivers/clk/imx/clk-imx8mn.c                                            |    2 +-
 drivers/clk/imx/clk-imx8mp-audiomix.c                                   |  277 +++
 drivers/clk/imx/clk-imx8mp.c                                            |    5 +-
 drivers/clk/imx/clk-imx8ulp.c                                           |   34 +-
 drivers/clk/imx/clk-imx93.c                                             |   19 +-
 drivers/clk/imx/clk.h                                                   |   23 +-
 drivers/clk/keystone/sci-clk.c                                          |    6 +-
 drivers/clk/loongson1/Makefile                                          |    4 -
 drivers/clk/loongson1/clk-loongson1b.c                                  |  118 --
 drivers/clk/loongson1/clk-loongson1c.c                                  |   95 -
 drivers/clk/loongson1/clk.c                                             |   41 -
 drivers/clk/loongson1/clk.h                                             |   15 -
 drivers/clk/mediatek/Kconfig                                            |  399 +++-
 drivers/clk/mediatek/Makefile                                           |   68 +-
 drivers/clk/mediatek/clk-fhctl.c                                        |   26 +-
 drivers/clk/mediatek/clk-fhctl.h                                        |    9 +-
 drivers/clk/mediatek/clk-mt2701-aud.c                                   |   45 +-
 drivers/clk/mediatek/clk-mt2701-bdp.c                                   |   25 +-
 drivers/clk/mediatek/clk-mt2701-eth.c                                   |   15 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c                                   |   15 +-
 drivers/clk/mediatek/clk-mt2701-hif.c                                   |   15 +-
 drivers/clk/mediatek/clk-mt2701-img.c                                   |   15 +-
 drivers/clk/mediatek/clk-mt2701-mm.c                                    |   56 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c                                  |   25 +-
 drivers/clk/mediatek/clk-mt2701.c                                       |   44 +-
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c                            |  168 ++
 drivers/clk/mediatek/clk-mt2712-bdp.c                                   |   15 +-
 drivers/clk/mediatek/clk-mt2712-img.c                                   |   15 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c                                |   15 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c                                   |   15 +-
 drivers/clk/mediatek/clk-mt2712-mm.c                                    |   66 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c                                  |   25 +-
 drivers/clk/mediatek/clk-mt2712-venc.c                                  |   15 +-
 drivers/clk/mediatek/clk-mt2712.c                                       | 1010 +++-------
 drivers/clk/mediatek/clk-mt6765-audio.c                                 |   25 +-
 drivers/clk/mediatek/clk-mt6765-cam.c                                   |   15 +-
 drivers/clk/mediatek/clk-mt6765-img.c                                   |   15 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c                                |   15 +-
 drivers/clk/mediatek/clk-mt6765-mm.c                                    |   15 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c                                |   15 +-
 drivers/clk/mediatek/clk-mt6765.c                                       |   82 +-
 drivers/clk/mediatek/clk-mt6779-aud.c                                   |    1 +
 drivers/clk/mediatek/clk-mt6779-cam.c                                   |    1 +
 drivers/clk/mediatek/clk-mt6779-img.c                                   |    1 +
 drivers/clk/mediatek/clk-mt6779-ipe.c                                   |    1 +
 drivers/clk/mediatek/clk-mt6779-mfg.c                                   |    1 +
 drivers/clk/mediatek/clk-mt6779-mm.c                                    |   25 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c                                  |    1 +
 drivers/clk/mediatek/clk-mt6779-venc.c                                  |    1 +
 drivers/clk/mediatek/clk-mt6779.c                                       |    1 +
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c                            |   64 +-
 drivers/clk/mediatek/clk-mt6795-infracfg.c                              |    1 +
 drivers/clk/mediatek/clk-mt6795-mfg.c                                   |    1 +
 drivers/clk/mediatek/clk-mt6795-mm.c                                    |   56 +-
 drivers/clk/mediatek/clk-mt6795-pericfg.c                               |    1 +
 drivers/clk/mediatek/clk-mt6795-topckgen.c                              |    1 +
 drivers/clk/mediatek/clk-mt6795-vdecsys.c                               |    1 +
 drivers/clk/mediatek/clk-mt6795-vencsys.c                               |    1 +
 drivers/clk/mediatek/clk-mt6797-img.c                                   |   15 +-
 drivers/clk/mediatek/clk-mt6797-mm.c                                    |   56 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c                                  |   25 +-
 drivers/clk/mediatek/clk-mt6797-venc.c                                  |   15 +-
 drivers/clk/mediatek/clk-mt6797.c                                       |   44 +-
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c                            |  152 ++
 drivers/clk/mediatek/clk-mt7622-aud.c                                   |   45 +-
 drivers/clk/mediatek/clk-mt7622-eth.c                                   |   25 +-
 drivers/clk/mediatek/clk-mt7622-hif.c                                   |   25 +-
 drivers/clk/mediatek/clk-mt7622-infracfg.c                              |  128 ++
 drivers/clk/mediatek/clk-mt7622.c                                       |  371 +---
 drivers/clk/mediatek/clk-mt7629-eth.c                                   |   22 +-
 drivers/clk/mediatek/clk-mt7629-hif.c                                   |   25 +-
 drivers/clk/mediatek/clk-mt7629.c                                       |   42 +-
 drivers/clk/mediatek/clk-mt7981-apmixed.c                               |    2 +
 drivers/clk/mediatek/clk-mt7981-eth.c                                   |    3 +-
 drivers/clk/mediatek/clk-mt7981-infracfg.c                              |    4 +-
 drivers/clk/mediatek/clk-mt7981-topckgen.c                              |    4 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c                               |    8 +-
 drivers/clk/mediatek/clk-mt7986-eth.c                                   |  112 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c                              |   90 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c                              |    4 +-
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c                            |  105 +
 drivers/clk/mediatek/clk-mt8135.c                                       |  268 +--
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c                            |  145 ++
 drivers/clk/mediatek/clk-mt8167-aud.c                                   |   46 +-
 drivers/clk/mediatek/clk-mt8167-img.c                                   |   50 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c                                |   50 +-
 drivers/clk/mediatek/clk-mt8167-mm.c                                    |   69 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c                                  |   57 +-
 drivers/clk/mediatek/clk-mt8167.c                                       |  382 +---
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c                            |   66 +-
 drivers/clk/mediatek/clk-mt8173-img.c                                   |    1 +
 drivers/clk/mediatek/clk-mt8173-infracfg.c                              |    1 +
 drivers/clk/mediatek/clk-mt8173-mm.c                                    |   82 +-
 drivers/clk/mediatek/clk-mt8173-pericfg.c                               |    1 +
 drivers/clk/mediatek/clk-mt8173-topckgen.c                              |    1 +
 drivers/clk/mediatek/clk-mt8173-vdecsys.c                               |    1 +
 drivers/clk/mediatek/clk-mt8173-vencsys.c                               |    1 +
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c                            |  195 ++
 drivers/clk/mediatek/clk-mt8183-audio.c                                 |    5 +-
 drivers/clk/mediatek/clk-mt8183-cam.c                                   |    5 +-
 drivers/clk/mediatek/clk-mt8183-img.c                                   |    5 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c                                  |    5 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c                                  |    5 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c                               |    5 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c                              |    5 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c                                |    5 +-
 drivers/clk/mediatek/clk-mt8183-mm.c                                    |   29 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c                                  |    5 +-
 drivers/clk/mediatek/clk-mt8183-venc.c                                  |    5 +-
 drivers/clk/mediatek/clk-mt8183.c                                       |  771 ++-----
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c                            |    6 +-
 drivers/clk/mediatek/clk-mt8186-cam.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8186-img.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c                          |    4 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c                              |    4 +-
 drivers/clk/mediatek/clk-mt8186-ipe.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8186-mcu.c                                   |   69 +-
 drivers/clk/mediatek/clk-mt8186-mdp.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8186-mfg.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8186-mm.c                                    |   59 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c                              |    4 +-
 drivers/clk/mediatek/clk-mt8186-vdec.c                                  |    4 +-
 drivers/clk/mediatek/clk-mt8186-venc.c                                  |    4 +-
 drivers/clk/mediatek/clk-mt8186-wpe.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c                         |   50 +
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c                            |  157 ++
 drivers/clk/mediatek/clk-mt8188-cam.c                                   |  120 ++
 drivers/clk/mediatek/clk-mt8188-ccu.c                                   |   50 +
 drivers/clk/mediatek/clk-mt8188-img.c                                   |  112 ++
 drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c                          |   82 +
 drivers/clk/mediatek/clk-mt8188-infra_ao.c                              |  199 ++
 drivers/clk/mediatek/clk-mt8188-ipe.c                                   |   52 +
 drivers/clk/mediatek/clk-mt8188-mfg.c                                   |   49 +
 drivers/clk/mediatek/clk-mt8188-peri_ao.c                               |   59 +
 drivers/clk/mediatek/clk-mt8188-topckgen.c                              | 1350 +++++++++++++
 drivers/clk/mediatek/clk-mt8188-vdec.c                                  |   92 +
 drivers/clk/mediatek/clk-mt8188-vdo0.c                                  |  107 +
 drivers/clk/mediatek/clk-mt8188-vdo1.c                                  |  154 ++
 drivers/clk/mediatek/clk-mt8188-venc.c                                  |   56 +
 drivers/clk/mediatek/clk-mt8188-vpp0.c                                  |  114 ++
 drivers/clk/mediatek/clk-mt8188-vpp1.c                                  |  109 +
 drivers/clk/mediatek/clk-mt8188-wpe.c                                   |  105 +
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c                            |  215 ++
 drivers/clk/mediatek/clk-mt8192-aud.c                                   |    5 +-
 drivers/clk/mediatek/clk-mt8192-cam.c                                   |    5 +-
 drivers/clk/mediatek/clk-mt8192-img.c                                   |    5 +-
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c                          |    5 +-
 drivers/clk/mediatek/clk-mt8192-ipe.c                                   |    5 +-
 drivers/clk/mediatek/clk-mt8192-mdp.c                                   |    5 +-
 drivers/clk/mediatek/clk-mt8192-mfg.c                                   |    5 +-
 drivers/clk/mediatek/clk-mt8192-mm.c                                    |   34 +-
 drivers/clk/mediatek/clk-mt8192-msdc.c                                  |    5 +-
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c                              |    5 +-
 drivers/clk/mediatek/clk-mt8192-vdec.c                                  |    5 +-
 drivers/clk/mediatek/clk-mt8192-venc.c                                  |    5 +-
 drivers/clk/mediatek/clk-mt8192.c                                       |  160 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c                            |   73 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c                            |    4 +-
 drivers/clk/mediatek/clk-mt8195-cam.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8195-ccu.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8195-img.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c                          |    4 +-
 drivers/clk/mediatek/clk-mt8195-infra_ao.c                              |    4 +-
 drivers/clk/mediatek/clk-mt8195-ipe.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8195-mfg.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8195-peri_ao.c                               |    4 +-
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c                              |    4 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c                              |    4 +-
 drivers/clk/mediatek/clk-mt8195-vdec.c                                  |    4 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c                                  |   59 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c                                  |   61 +-
 drivers/clk/mediatek/clk-mt8195-venc.c                                  |    4 +-
 drivers/clk/mediatek/clk-mt8195-vpp0.c                                  |   58 +-
 drivers/clk/mediatek/clk-mt8195-vpp1.c                                  |   58 +-
 drivers/clk/mediatek/clk-mt8195-wpe.c                                   |    4 +-
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c                            |  166 ++
 drivers/clk/mediatek/clk-mt8365-apu.c                                   |    3 +-
 drivers/clk/mediatek/clk-mt8365-cam.c                                   |    3 +-
 drivers/clk/mediatek/clk-mt8365-mfg.c                                   |    3 +-
 drivers/clk/mediatek/clk-mt8365-mm.c                                    |   42 +-
 drivers/clk/mediatek/clk-mt8365-vdec.c                                  |    3 +-
 drivers/clk/mediatek/clk-mt8365-venc.c                                  |    3 +-
 drivers/clk/mediatek/clk-mt8365.c                                       |  606 ++----
 drivers/clk/mediatek/clk-mt8516-apmixedsys.c                            |  122 ++
 drivers/clk/mediatek/clk-mt8516-aud.c                                   |   46 +-
 drivers/clk/mediatek/clk-mt8516.c                                       |  240 +--
 drivers/clk/mediatek/clk-mtk.c                                          |   82 +-
 drivers/clk/mediatek/clk-mtk.h                                          |    7 +-
 drivers/clk/mediatek/clk-pllfh.c                                        |   37 +-
 drivers/clk/mediatek/clk-pllfh.h                                        |    1 +
 drivers/clk/microchip/clk-mpfs.c                                        |    3 +-
 drivers/clk/mmp/clk-audio.c                                             |    6 +-
 drivers/clk/mvebu/armada-37xx-periph.c                                  |    6 +-
 drivers/clk/mvebu/armada-37xx-tbg.c                                     |    6 +-
 drivers/clk/mvebu/armada-37xx-xtal.c                                    |    6 +-
 drivers/clk/qcom/Kconfig                                                |   70 +
 drivers/clk/qcom/Makefile                                               |    8 +
 drivers/clk/qcom/apcs-msm8916.c                                         |    6 +-
 drivers/clk/qcom/apcs-sdx55.c                                           |    6 +-
 drivers/clk/qcom/apss-ipq-pll.c                                         |  116 +-
 drivers/clk/qcom/clk-alpha-pll.c                                        |  139 +-
 drivers/clk/qcom/clk-alpha-pll.h                                        |   14 +-
 drivers/clk/qcom/clk-branch.c                                           |   15 +-
 drivers/clk/qcom/clk-branch.h                                           |   44 +
 drivers/clk/qcom/clk-hfpll.c                                            |   14 +-
 drivers/clk/qcom/clk-krait.c                                            |   10 +-
 drivers/clk/qcom/clk-rpm.c                                              |   11 +-
 drivers/clk/qcom/clk-smd-rpm.c                                          |   37 +
 drivers/clk/qcom/dispcc-qcm2290.c                                       |   10 +-
 drivers/clk/qcom/gcc-ipq4019.c                                          | 1665 ++++++++-------
 drivers/clk/qcom/gcc-ipq5332.c                                          | 3824 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gcc-ipq9574.c                                          | 4248 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gcc-msm8917.c                                          | 3303 ++++++++++++++++++++++++++++++
 drivers/clk/qcom/gcc-msm8960.c                                          |    6 +-
 drivers/clk/qcom/gcc-msm8996.c                                          |    3 +-
 drivers/clk/qcom/gcc-msm8998.c                                          |    3 +-
 drivers/clk/qcom/gcc-qcm2290.c                                          |    3 +-
 drivers/clk/qcom/gcc-sc8280xp.c                                         |   18 +
 drivers/clk/qcom/gcc-sm6115.c                                           |   50 +-
 drivers/clk/qcom/gcc-sm6375.c                                           |    3 +-
 drivers/clk/qcom/gcc-sm7150.c                                           | 3048 ++++++++++++++++++++++++++++
 drivers/clk/qcom/gcc-sm8350.c                                           |   47 +-
 drivers/clk/qcom/gpucc-sa8775p.c                                        |  625 ++++++
 drivers/clk/qcom/gpucc-sm6115.c                                         |  503 +++++
 drivers/clk/qcom/gpucc-sm6125.c                                         |  424 ++++
 drivers/clk/qcom/gpucc-sm6375.c                                         |  458 +++++
 drivers/clk/qcom/lpassaudiocc-sc7280.c                                  |    2 +
 drivers/clk/qcom/lpasscc-sc7280.c                                       |   16 +-
 drivers/clk/renesas/r8a77970-cpg-mssr.c                                 |    1 +
 drivers/clk/renesas/r8a77980-cpg-mssr.c                                 |   18 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c                                 |    2 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c                                 |   24 +
 drivers/clk/renesas/r9a06g032-clocks.c                                  |  736 +++++--
 drivers/clk/renesas/rcar-usb2-clock-sel.c                               |    6 +-
 drivers/clk/renesas/renesas-cpg-mssr.c                                  |    8 +-
 drivers/clk/rockchip/clk-rk3399.c                                       |    2 +-
 drivers/clk/rockchip/clk-rk3588.c                                       |   42 +-
 drivers/clk/rockchip/clk.c                                              |    2 -
 drivers/clk/samsung/clk-exynos-arm64.c                                  |  229 ++-
 drivers/clk/samsung/clk-exynos-arm64.h                                  |    3 +
 drivers/clk/samsung/clk-exynos-audss.c                                  |    6 +-
 drivers/clk/samsung/clk-exynos-clkout.c                                 |    6 +-
 drivers/clk/samsung/clk-exynos4.c                                       |    6 +-
 drivers/clk/samsung/clk-exynos4412-isp.c                                |    3 +-
 drivers/clk/samsung/clk-exynos5250.c                                    |    5 +-
 drivers/clk/samsung/clk-exynos5420.c                                    |    5 +-
 drivers/clk/samsung/clk-exynos5433.c                                    |  157 +-
 drivers/clk/samsung/clk-exynos850.c                                     |  141 +-
 drivers/clk/samsung/clk-pll.c                                           |   12 +-
 drivers/clk/samsung/clk-pll.h                                           |    1 +
 drivers/clk/samsung/clk-s3c64xx.c                                       |    4 +-
 drivers/clk/samsung/clk-s5pv210.c                                       |    6 +-
 drivers/clk/samsung/clk.c                                               |   64 +-
 drivers/clk/samsung/clk.h                                               |   10 +-
 drivers/clk/sifive/Kconfig                                              |    6 +-
 drivers/clk/socfpga/clk-gate-a10.c                                      |   26 +-
 drivers/clk/socfpga/clk-gate.c                                          |   35 +-
 drivers/clk/socfpga/clk-periph-a10.c                                    |   22 +-
 drivers/clk/socfpga/clk-periph.c                                        |   26 +-
 drivers/clk/socfpga/clk-pll-a10.c                                       |   30 +-
 drivers/clk/socfpga/clk-pll.c                                           |   32 +-
 drivers/clk/sprd/common.c                                               |    2 +-
 drivers/clk/starfive/Kconfig                                            |   33 +-
 drivers/clk/starfive/Makefile                                           |    6 +-
 drivers/clk/starfive/clk-starfive-jh7100-audio.c                        |   74 +-
 drivers/clk/starfive/clk-starfive-jh7100.c                              |  716 ++-----
 drivers/clk/starfive/clk-starfive-jh7100.h                              |  112 --
 drivers/clk/starfive/clk-starfive-jh7110-aon.c                          |  154 ++
 drivers/clk/starfive/clk-starfive-jh7110-sys.c                          |  497 +++++
 drivers/clk/starfive/clk-starfive-jh7110.h                              |   11 +
 drivers/clk/starfive/clk-starfive-jh71x0.c                              |  333 +++
 drivers/clk/starfive/clk-starfive-jh71x0.h                              |  123 ++
 drivers/clk/stm32/clk-stm32mp13.c                                       |    6 +-
 drivers/clk/tegra/clk-dfll.c                                            |    5 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c                              |   17 +-
 drivers/clk/tegra/clk-tegra20.c                                         |   28 +-
 drivers/clk/ti/adpll.c                                                  |    6 +-
 drivers/clk/ti/clkctrl.c                                                |    6 +-
 drivers/clk/uniphier/clk-uniphier-core.c                                |   12 +-
 drivers/clk/visconti/pll.h                                              |    1 -
 drivers/clk/x86/clk-fch.c                                               |    7 +-
 drivers/clk/x86/clk-pmc-atom.c                                          |    5 +-
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c                              |  234 ++-
 drivers/clk/xilinx/xlnx_vcu.c                                           |    8 +-
 drivers/clk/zynqmp/pll.c                                                |    2 -
 drivers/reset/Kconfig                                                   |    8 +-
 drivers/reset/Makefile                                                  |    2 +-
 drivers/reset/reset-starfive-jh7100.c                                   |  173 --
 drivers/reset/starfive/Kconfig                                          |   20 +
 drivers/reset/starfive/Makefile                                         |    5 +
 drivers/reset/starfive/reset-starfive-jh7100.c                          |   74 +
 drivers/reset/starfive/reset-starfive-jh7110.c                          |   73 +
 drivers/reset/starfive/reset-starfive-jh71x0.c                          |  131 ++
 drivers/reset/starfive/reset-starfive-jh71x0.h                          |   14 +
 include/dt-bindings/clock/ast2600-clock.h                               |    5 +-
 include/dt-bindings/clock/bcm63268-clock.h                              |   13 +
 include/dt-bindings/clock/imx8mp-clock.h                                |    4 +-
 include/dt-bindings/clock/imx93-clock.h                                 |    6 +-
 include/dt-bindings/clock/loongson,ls1x-clk.h                           |   19 +
 include/dt-bindings/clock/loongson,ls2k-clk.h                           |    3 +-
 include/dt-bindings/clock/mediatek,mt8188-clk.h                         |  726 +++++++
 include/dt-bindings/clock/qcom,dispcc-qcm2290.h                         |    4 +
 include/dt-bindings/clock/qcom,gcc-msm8917.h                            |  190 ++
 include/dt-bindings/clock/qcom,gcc-sc8280xp.h                           |    2 +
 include/dt-bindings/clock/qcom,sa8775p-gpucc.h                          |   50 +
 include/dt-bindings/clock/qcom,sm7150-gcc.h                             |  186 ++
 include/dt-bindings/reset/bcm63268-reset.h                              |    4 +
 include/linux/clk-provider.h                                            |   21 +-
 include/soc/starfive/reset-starfive-jh71x0.h                            |   17 +
 383 files changed, 32338 insertions(+), 7632 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8188-sys-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/skyworks,si521xx.yaml
 create mode 100644 Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
 create mode 100644 drivers/clk/bcm/clk-bcm63268-timer.c
 create mode 100644 drivers/clk/clk-loongson1.c
 create mode 100644 drivers/clk/clk-loongson2.c
 create mode 100644 drivers/clk/clk-si521xx.c
 create mode 100644 drivers/clk/clk-sp7021.c
 create mode 100644 drivers/clk/imx/clk-imx8mp-audiomix.c
 delete mode 100644 drivers/clk/loongson1/Makefile
 delete mode 100644 drivers/clk/loongson1/clk-loongson1b.c
 delete mode 100644 drivers/clk/loongson1/clk-loongson1c.c
 delete mode 100644 drivers/clk/loongson1/clk.c
 delete mode 100644 drivers/clk/loongson1/clk.h
 create mode 100644 drivers/clk/mediatek/clk-mt2712-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt7622-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt7622-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8135-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8167-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-ccu.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-infra_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-peri_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-vdo0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-vdo1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-vpp0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-vpp1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8188-wpe.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8516-apmixedsys.c
 create mode 100644 drivers/clk/qcom/gcc-ipq5332.c
 create mode 100644 drivers/clk/qcom/gcc-ipq9574.c
 create mode 100644 drivers/clk/qcom/gcc-msm8917.c
 create mode 100644 drivers/clk/qcom/gcc-sm7150.c
 create mode 100644 drivers/clk/qcom/gpucc-sa8775p.c
 create mode 100644 drivers/clk/qcom/gpucc-sm6115.c
 create mode 100644 drivers/clk/qcom/gpucc-sm6125.c
 create mode 100644 drivers/clk/qcom/gpucc-sm6375.c
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh7100.h
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-aon.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-sys.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110.h
 create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
 delete mode 100644 drivers/reset/reset-starfive-jh7100.c
 create mode 100644 drivers/reset/starfive/Kconfig
 create mode 100644 drivers/reset/starfive/Makefile
 create mode 100644 drivers/reset/starfive/reset-starfive-jh7100.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh7110.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
 create mode 100644 include/dt-bindings/clock/loongson,ls1x-clk.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt8188-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8917.h
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-gpucc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-gcc.h
 create mode 100644 include/soc/starfive/reset-starfive-jh71x0.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
