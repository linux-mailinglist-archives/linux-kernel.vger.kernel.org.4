Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CC064BE46
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiLMVR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiLMVR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:17:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC79810B50;
        Tue, 13 Dec 2022 13:17:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DB04B81240;
        Tue, 13 Dec 2022 21:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C599C433EF;
        Tue, 13 Dec 2022 21:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670966270;
        bh=rTRlzBHYcGVC7KCKnox7tgAOtd5zSO9LjTkHrg+ETO8=;
        h=From:To:Cc:Subject:Date:From;
        b=nxmHlfjQF5mx4uvXtJdSAe0I5ccv891N/Tr/Sl13S1CL6jHC8ZU11YknNuEEroXDu
         nLR4xSB6ege+dYr/nB9FJhunmyctQ4dxY6aGd4c93WUgwr3uU+LxGSoVOkU6CPciLQ
         HT0Po4407YO95DvLpDPOaVSmsE8H+9thpkxT03HDFJ1jtu8xOZdOABeiaEeLHwAzyq
         wj6O3bE4PphpQ2VGPI3EpkAbxviJmsLFp/UOCsIoi8ZYtFdZ/wRpEnyTkJaeTb14oQ
         c0KNdqrQHz5HM7uO2GKGojuxw3YQ1WbJvespiMfdmGyoRWGtU96c5v2yh8fqadz8c8
         2YKaZ8dKh08Fg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Tue, 13 Dec 2022 13:17:49 -0800
Message-Id: <20221213211749.4067995-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 830b3c68c1fb1e9176028d02ef86f3cf76aa2476:

  Linux 6.1 (2022-12-11 14:15:18 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 0e2c9884cbbae00f956d881848669790d73be43d:

  Merge branches 'clk-mediatek', 'clk-trace', 'clk-qcom' and 'clk-microchip' into clk-next (2022-12-12 11:13:28 -0800)

----------------------------------------------------------------
A pile of clk driver updates with a small tracepoint patch to the clk core this
time around. The core framework is effectively unchanged, with the majority of
the diff going to the Qualcomm clk driver directory because they added two 3k
line files that are almost all clk data (Abel Vesa from Linaro tried to shrink
the number of lines down, but it doesn't seem to be possible without
sacrificing readability). The second big driver this time around is the
Rockchip rk3588 clk and reset unit, at _only_ 2.5k lines.

Ignoring the big clk drivers from the familiar SoC vendors, there's just a
bunch of little clk driver updates and fixes throughout here. It's the usual
set of clk data fixups to describe proper parents, or add frequencies to
frequency tables, or plug memory leaks when function calls fail. Also, some
drivers are converted to use modern clk_hw APIs, which is always nice to see.
And data is deduplicated, leading to a smaller kernel Image. Overall this batch
has a larger collection of cleanups than it typically does. Maybe that means
there are less new SoCs right now that need supporting, and the focus has
shifted to quality and reliability. I can dream.

New Drivers:
 - Frequency hopping controller hardware on MediaTek MT8186
 - Global clock controller for Qualcomm SM8550
 - Display clock controller for Qualcomm SC8280XP
 - RPMh clock controller for Qualcomm QDU1000 and QRU1000 SoCs
 - CPU PLL on MStar/SigmaStar SoCs
 - Support for the clock and reset unit of the Rockchip rk3588

Updates:
 - Tracepoints for clk_rate_request structures
 - Debugfs support for fractional divider clk
 - Make MxL's CGU driver secure compatible
 - Ingenic JZ4755 SoC clk support
 - Support audio clks on X1000 SoCs
 - Remove flags from univ/main/syspll child fixed factor clocks across
   MediaTek platforms
 - Fix clock dependency for ADC on MediaTek MT7986
 - Fix parent for FlexSPI clock for i.MX93
 - Add USB suspend clock on i.MX8MP
 - Unmap anatop base on error for i.MX93 driver
 - Change enet clock parent to wakeup_axi_root for i.MX93
 - Drop LPIT1, LPIT2, TPM1 and TPM3 clocks for i.MX93
 - Mark HSIO bus clock and SYS_CNT clock as critical on i.MX93
 - Add 320MHz and 640MHz entries to PLL146x
 - Add audio shared gate and SAI clocks for i.MX8MP
 - Fix a possible memory leak in the error path of rockchip PLL creation
 - Fix header guard for V3S clocks
 - Add IR module clock for f1c100s
 - Correct the parent clocks for the (High Speed) Serial Communication
   Interfaces with FIFO ((H)SCIF) modules and the mixed-up Ethernet
   Switch clocks on Renesas R-Car S4-8
 - Add timer (TMU, CMT) and Cortex-A76 CPU core (Z0) clocks on Renesas
   R-Car V4H
 - Two PLL driver fixups for the Amlogic clk driver
 - Round SD clock rate to improve parent clock selection
 - Add Ethernet Switch and internal SASYNCPER clocks on Renesas R-Car
   S4-8
 - Add DMA (SYS-DMAC), SPI (MSIOF), external interrupt (INTC-EX) serial
   (SCIF), PWM (PWM and TPU), SDHI, and HyperFLASH/QSPI (RPC-IF) clocks
   on Renesas R-Car V4H
 - Add Multi-Function Timer Pulse Unit (MTU3a) clock and reset on
   Renesas RZ/G2L
 - Fix endless loop on Renesas RZ/N1
 - Correct the parent clocks for the High Speed Serial Communication
   Interfaces with FIFO (HSCIF) modules on the Renesas R-Car V4H SoC
   Note: HSCIF0 is used for the serial console on the White-Hawk
   development board
 - Various clk DT binding improvements and conversions to YAML
 - Qualcomm SM8150/SM8250 display clock controller cleaned up
 - Some missing clocks for Qualcomm SM8350 added
 - Qualcomm MSM8974 Global and Multimedia clock controllers transitioned
   to parent_data and parent_hws
 - Use parent_data and add network resets for Qualcomm IPQ8074
 - Qualcomm Krait clock controller modernized
 - Fix pm_runtime usage in Qualcomm SC7180 and SC7280 LPASS clock
   controllers
 - Enable retention mode on Qualcomm SM8250 USB GDSCs
 - Cleanup Qualcomm RPM and RPMh clock drivers to avoid duplicating
   clocks which definition could be shared between platforms
 - Various NULL pointer checks added for allocations

----------------------------------------------------------------
Abel Vesa (6):
      dt-bindings: clock: imx8mp: Add ids for the audio shared gate
      clk: imx8mp: Add audio shared gate
      dt-bindings: clock: Add SM8550 GCC clocks
      clk: qcom: gdsc: Increase status poll timeout
      clk: qcom: Add LUCID_OLE PLL type for SM8550
      clk: qcom: Add GCC driver for SM8550

Aidan MacDonald (6):
      clk: ingenic: Make PLL clock "od" field optional
      clk: ingenic: Make PLL clock enable_bit and stable_bit optional
      clk: ingenic: Add .set_rate_hook() for PLL clocks
      dt-bindings: ingenic,x1000-cgu: Add audio clocks
      clk: ingenic: Add X1000 audio clocks
      clk: ingenic: Minor cosmetic fixups for X1000

Alexander Stein (1):
      dt-bindings: clock: ti,cdce925: Convert to DT schema

Andre Przywara (1):
      clk: sunxi-ng: f1c100s: Add IR mod clock

Andy Shevchenko (3):
      clk: fractional-divider: Split out clk_fd_get_div() helper
      clk: fractional-divider: Show numerator and denominator in debugfs
      clk: fractional-divider: Regroup inclusions

AngeloGioacchino Del Regno (10):
      clk: mediatek: clk-mtk: Allow specifying flags on mtk_fixed_factor clocks
      clk: mediatek: mt8186-topckgen: Drop flags for main/univpll fixed factors
      clk: mediatek: mt8183: Compress top_divs array entries
      clk: mediatek: mt8183: Drop flags for sys/univpll fixed factors
      clk: mediatek: mt8173: Drop flags for main/sys/univpll fixed factors
      clk: mediatek: mt6795-topckgen: Drop flags for main/sys/univpll fixed factors
      clk: mediatek: mt8192: Drop flags for main/univpll fixed factors
      clk: mediatek: mt8195-topckgen: Drop flags for main/univpll fixed factors
      clk: mediatek: mt8186-mfg: Propagate rate changes to parent
      clk: mediatek: mt8186-topckgen: Add GPU clock mux notifier

Biju Das (2):
      clk: renesas: rzg2l: Support sd clk mux round operation
      clk: renesas: r9a07g044: Add MTU3a clock and reset entry

Bjorn Andersson (2):
      dt-bindings: clock: Add Qualcomm SC8280XP display clock bindings
      clk: qcom: Add SC8280XP display clock controller

Christian Marangi (8):
      clk: qcom: kpss-xcc: register it as clk provider
      clk: qcom: clk-krait: fix wrong div2 functions
      clk: qcom: krait-cc: use devm variant for clk notifier register
      clk: qcom: krait-cc: fix wrong parent order for secondary mux
      clk: qcom: krait-cc: also enable secondary mux and div clk
      clk: qcom: krait-cc: handle secondary mux sourcing out of acpu_aux
      clk: qcom: krait-cc: convert to devm_clk_hw_register
      clk: qcom: krait-cc: convert to parent_data API

Christophe JAILLET (1):
      clk: Remove a useless include

Conor Dooley (1):
      clk: microchip: enable the MPFS clk driver by default if SOC_MICROCHIP_POLARFIRE

Daniel Golle (1):
      clk: mediatek: fix dependency of MT7986 ADC clocks

Daniel Palmer (1):
      clk: mstar: msc313 cpupll clk driver

Dario Binacchi (9):
      clk: ti: change ti_clk_register[_omap_hw]() API
      clk: ti: dra7-atl: don't allocate `parent_names' variable
      clk: ti: fix typo in ti_clk_retry_init() code comment
      clk: imx8mn: rename vpu_pll to m7_alt_pll
      clk: imx: replace osc_hdmi with dummy
      clk: imx: rename video_pll1 to video_pll
      clk: imx8mn: fix imx8mn_sai2_sels clocks list
      clk: imx8mn: fix imx8mn_enet_phy_sels clocks list
      clk: imx: rename imx_obtain_fixed_clk_hw() to imx_get_clk_hw_by_name()

Dmitry Baryshkov (23):
      dt-bindings: clock: split qcom,gcc-sdm660 to the separate file
      dt-bindings: clock: qcom,gcc-ipq8064: add pll4 to used clocks
      clk: qcom: gcc-ipq806x: use parent_data for the last remaining entry
      clk: qcom: rpm: remove unused active-only clock names
      clk: qcom: rpm: drop separate active-only names
      clk: qcom: rpm: drop the _clk suffix completely
      clk: qcom: rpm: drop the platform from clock definitions
      clk: qcom: rpmh: group clock definitions together
      clk: qcom: rpmh: reuse common duplicate clocks
      clk: qcom: rpmh: drop all _ao names
      clk: qcom: rpmh: remove platform names from BCM clocks
      clk: qcom: rpmh: support separate symbol name for the RPMH clocks
      clk: qcom: rpmh: rename ARC clock data
      clk: qcom: rpmh: rename VRM clock data
      clk: qcom: rpmh: remove usage of platform name
      dt-bindings: clock: split qcom,gcc-msm8974,-msm8226 to the separate file
      dt-bindings: clocks: qcom,mmcc: define clocks/clock-names for MSM8974
      clk: qcom: gcc-msm8974: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-msm8974: move clock parent tables down
      clk: qcom: gcc-msm8974: use parent_hws/_data instead of parent_names
      clk: qcom: mmcc-msm8974: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: mmcc-msm8974: move clock parent tables down
      clk: qcom: mmcc-msm8974: use parent_hws/_data instead of parent_names

Douglas Anderson (3):
      clk: qcom: lpass-sc7280: Fix pm_runtime usage
      clk: qcom: lpass-sc7180: Fix pm_runtime usage
      clk: qcom: lpass-sc7180: Avoid an extra "struct dev_pm_ops"

Elaine Zhang (5):
      dt-bindings: clock: add rk3588 cru bindings
      clk: rockchip: add register offset of the cores select parent
      clk: rockchip: add pll type for RK3588
      clk: rockchip: allow additional mux options for cpu-clock frequency changes
      clk: rockchip: add clock controller for the RK3588

Geert Uytterhoeven (13):
      clk: renesas: r8a779g0: Add SYS-DMAC clocks
      clk: renesas: r8a779g0: Add MSIOF clocks
      clk: renesas: r8a779g0: Add INTC-EX clock
      Merge tag 'renesas-clk-fixes-for-v6.1-tag1'
      clk: renesas: r8a779g0: Add SCIF clocks
      clk: renesas: r8a779g0: Add PWM clock
      clk: renesas: r8a779g0: Add TPU clock
      clk: renesas: r8a779f0: Fix SD0H clock name
      clk: renesas: r8a779f0: Add SASYNCPER internal clock
      clk: renesas: r8a779g0: Add SDHI clocks
      clk: renesas: r8a779g0: Add RPC-IF clock
      clk: renesas: r8a779g0: Add Z0 clock support
      clk: renesas: r8a779f0: Fix Ethernet Switch clocks

Giulio Benetti (2):
      clk: imx: imxrt1050: fix IMXRT1050_CLK_LCDIF_APB offsets
      clk: imx: imxrt1050: add IMXRT1050_CLK_LCDIF_PIX clock gate

Haibo Chen (1):
      clk: imx93: correct the flexspi1 clock setting

Heiko Stuebner (1):
      Merge branch 'v6.2-shared/clockids' into v6.2-clk/next

Heiner Kallweit (2):
      clk: meson: pll: adjust timeout in meson_clk_pll_wait_lock()
      clk: meson: pll: add pcie lock retry workaround

Hui Tang (1):
      clk: microchip: check for null return of devm_kzalloc()

Jacky Bai (2):
      clk: imx: keep hsio bus clock always on
      clk: imx93: keep sys ctr clock always on

Johnson Wang (4):
      clk: mediatek: Export PLL operations symbols
      dt-bindings: clock: mediatek: Add new bindings of MediaTek frequency hopping
      clk: mediatek: Add new clock driver to handle FHCTL hardware
      clk: mediatek: Change PLL register API for MT8186

Jonathan Neuschäfer (1):
      clk: samsung: Fix reference to CLK_OF_DECLARE in comment

Konrad Dybcio (3):
      clk: qcom: dispcc-sm6350: Add CLK_OPS_PARENT_ENABLE to pixel&byte src
      dt-bindings: clock: add QCOM SM6375 display clock
      clk: qcom: Add display clock controller driver for SM6375

Kory Maincent (2):
      clk: spear: Fix CLCD clock definition on SPEAr600
      clk: spear: Fix SSP clock definition on SPEAr600

Krzysztof Kozlowski (6):
      dt-bindings: clock: qcom,sdm845-lpasscc: convert to dtschema
      dt-bindings: clock: qcom,aoncc-sm8250: fix compatible
      dt-bindings: clock: qcom,aoncc-sm8250: add missing audio clock
      dt-bindings: clock: qcom,audiocc-sm8250: add missing audio clock
      dt-bindings: clock: qcom,gcc-ipq8074: Use common GCC schema
      dt-bindings: clock: qcom: Clean-up titles and descriptions

Lad Prabhakar (5):
      clk: renesas: rzg2l: Fix typo in function name
      clk: renesas: r9a07g044: Drop WDT2 clock and reset entry
      clk: renesas: r9a07g043: Drop WDT2 clock and reset entry
      clk: renesas: rzg2l: Fix typo in struct rzg2l_cpg_priv kerneldoc
      clk: renesas: rzg2l: Don't assume all CPG_MOD clocks support PM

Li Jun (2):
      dt-bindings: clocks: imx8mp: Add ID for usb suspend clock
      clk: imx: imx8mp: add shared clk gate for usb suspend clk

Liam Beguin (4):
      clk: lmk04832: declare variables as const when possible
      clk: lmk04832: drop unnecessary semicolons
      clk: lmk04832: drop superfluous #include
      clk: lmk04832: fix kernel-doc warnings

Lin, Meng-Bo (1):
      clk: qcom: gcc-msm8939: Add rates to the GP clocks

Luca Weiss (2):
      dt-bindings: clock: Convert qcom,lcc to DT schema
      clk: qcom: rpmh: add support for SM6350 rpmh IPA clock

Manivannan Sadhasivam (1):
      clk: qcom: gcc-sm8250: Use retention mode for USB GDSCs

Marek Vasut (3):
      clk: stm32mp1: Staticize ethrx_src
      clk: renesas: r9a06g032: Repair grave increment error
      clk: imx: pll14xx: Add 320 MHz and 640 MHz entries for PLL146x

Martin Botka (1):
      clk: qcom: gcc-sm6125: Remove gpll7 from sdcc2_apps

Matti Vaittinen (1):
      clk: cdce925: simplify using devm_regulator_get_enable()

Maxime Ripard (2):
      clk: Store clk_core for clk_rate_request
      clk: Add trace events for rate requests

Melody Olvera (2):
      dt-bindings: clock: Add RPMHCC for QDU1000 and QRU1000
      clk: qcom: Add support for QDU1000 and QRU1000 RPMh clocks

Minghao Chi (1):
      clk: qcom: hfpll: use devm_platform_get_and_ioremap_resource()

Peng Fan (4):
      clk: imx93: unmap anatop base in error handling path
      clk: imx93: correct enet clock
      dt-bindings: clock: imx93: drop TPM1/3 LPIT1/2 entry
      clk: imx93: drop tpm1/3, lpit1/2 clk

Rahul Tanwar (5):
      clk: mxl: Switch from direct readl/writel based IO to regmap based IO
      clk: mxl: Remove redundant spinlocks
      clk: mxl: Add option to override gate clks
      clk: mxl: Fix a clk entry by adding relevant flags
      clk: mxl: syscon_node_to_regmap() returns error pointers

Randy Dunlap (1):
      clk: nomadik: correct struct name kernel-doc warning

Robert Foss (5):
      clk: qcom: dispcc-sm8250: Disable EDP_GTC for sm8350
      clk: qcom: dispcc-sm8250: Add RETAIN_FF_ENABLE flag for mdss_gdsc
      dt-bindings: clock: dispcc-sm8250: Add EDP_LINK_DIV_CLK_SRC index
      clk: qcom: dispcc-sm8250: Add missing EDP clocks for sm8350
      clk: qcom: dispcc-sm8250: Disable link_div_clk_src for sm8150

Robert Marko (7):
      clk: qcom: ipq8074: convert to parent data
      dt-bindings: clocks: qcom,gcc-ipq8074: allow XO and sleep clocks
      clk: qcom: reset: support resetting multiple bits
      dt-bindings: clock: qcom: ipq8074: add missing networking resets
      clk: qcom: ipq8074: add missing networking resets
      clk: qcom: ipq8074: populate fw_name for all parents
      clk: qcom: gcc-ipq4019: switch to devm_clk_notifier_register

Sebastian Reichel (4):
      dt-bindings: clock: add rk3588 clock definitions
      dt-bindings: reset: add rk3588 reset definitions
      clk: rockchip: simplify rockchip_clk_add_lookup
      clk: rockchip: add lookup table support

Siarhei Volkau (3):
      dt-bindings: ingenic: Add support for the JZ4755 CGU
      dt-bindings: clock: Add Ingenic JZ4755 CGU header
      clk: Add Ingenic JZ4755 CGU driver

Stephen Boyd (14):
      clk: xilinx: Drop duplicate depends on COMMON_CLK
      Merge tag 'renesas-clk-for-v6.2-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-meson-v6.2-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'renesas-clk-for-v6.2-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-6.2-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'v6.2-rockchip-clk-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'clk-imx-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'mtk-clk-for-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux into clk-mediatek
      Merge tag 'qcom-clk-for-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge tag 'clk-microchip-fixes-6.1-2' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-microchip
      Merge branches 'clk-x86', 'clk-xilinx', 'clk-cleanup', 'clk-mstar' and 'clk-ingenic' into clk-next
      Merge branches 'clk-bindings', 'clk-renesas', 'clk-amlogic', 'clk-allwinner' and 'clk-ti' into clk-next
      Merge branches 'clk-spear', 'clk-fract', 'clk-rockchip' and 'clk-imx' into clk-next
      Merge branches 'clk-mediatek', 'clk-trace', 'clk-qcom' and 'clk-microchip' into clk-next

Wei Li (1):
      clk: sunxi-ng: v3s: Correct the header guard of ccu-sun8i-v3s.h

Wolfram Sang (5):
      clk: renesas: r8a779a0: Fix SD0H clock name
      clk: renesas: r8a779f0: Fix HSCIF parent clocks
      clk: renesas: r8a779f0: Fix SCIF parent clocks
      clk: renesas: r8a779g0: Add TMU and SASYNCRT clocks
      clk: renesas: r8a779g0: Add CMT clocks

Xiu Jianfeng (5):
      clk: rockchip: Fix memory leak in rockchip_clk_register_pll()
      clk: visconti: Fix memory leak in visconti_register_pll()
      clk: samsung: Fix memory leak in _samsung_clk_register_pll()
      clk: st: Fix memory leak in st_of_quadfs_setup()
      clk: socfpga: Fix memory leak in socfpga_gate_init()

Yang Yingliang (2):
      clk: bulk: Use dev_err_probe() helper in __clk_bulk_get()
      clk: keystone: syscon-clk: Use dev_err_probe() helper

Yoshihiro Shimoda (1):
      clk: renesas: r8a779f0: Add Ethernet Switch clocks

 .../devicetree/bindings/clock/ingenic,cgu.yaml     |    2 +
 .../bindings/clock/mediatek,mt8186-fhctl.yaml      |   53 +
 .../devicetree/bindings/clock/qcom,a53pll.yaml     |    2 +-
 .../devicetree/bindings/clock/qcom,a7pll.yaml      |    2 +-
 .../bindings/clock/qcom,aoncc-sm8250.yaml          |   11 +-
 .../bindings/clock/qcom,audiocc-sm8250.yaml        |    7 +-
 .../bindings/clock/qcom,camcc-sm8250.yaml          |    6 +-
 .../bindings/clock/qcom,dispcc-sc8280xp.yaml       |   97 +
 .../bindings/clock/qcom,dispcc-sm6125.yaml         |    9 +-
 .../bindings/clock/qcom,dispcc-sm6350.yaml         |    8 +-
 .../bindings/clock/qcom,dispcc-sm8x50.yaml         |   14 +-
 .../bindings/clock/qcom,gcc-apq8064.yaml           |   18 +-
 .../bindings/clock/qcom,gcc-apq8084.yaml           |   10 +-
 .../bindings/clock/qcom,gcc-ipq8064.yaml           |   27 +-
 .../bindings/clock/qcom,gcc-ipq8074.yaml           |   40 +-
 .../bindings/clock/qcom,gcc-msm8660.yaml           |   12 +-
 .../bindings/clock/qcom,gcc-msm8909.yaml           |    9 +-
 .../bindings/clock/qcom,gcc-msm8916.yaml           |   16 +-
 .../bindings/clock/qcom,gcc-msm8974.yaml           |   61 +
 .../bindings/clock/qcom,gcc-msm8976.yaml           |    9 +-
 .../bindings/clock/qcom,gcc-msm8994.yaml           |    9 +-
 .../bindings/clock/qcom,gcc-msm8996.yaml           |    7 +-
 .../bindings/clock/qcom,gcc-msm8998.yaml           |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-other.yaml  |   38 +-
 .../bindings/clock/qcom,gcc-qcm2290.yaml           |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-qcs404.yaml |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-sc7280.yaml |    9 +-
 .../bindings/clock/qcom,gcc-sc8180x.yaml           |    9 +-
 .../bindings/clock/qcom,gcc-sc8280xp.yaml          |    7 +-
 .../devicetree/bindings/clock/qcom,gcc-sdm660.yaml |   61 +
 .../devicetree/bindings/clock/qcom,gcc-sdm845.yaml |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-sdx55.yaml  |    7 +-
 .../devicetree/bindings/clock/qcom,gcc-sdx65.yaml  |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-sm6115.yaml |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-sm6125.yaml |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-sm6350.yaml |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8150.yaml |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8350.yaml |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8450.yaml |    9 +-
 .../devicetree/bindings/clock/qcom,gcc.yaml        |    6 +-
 .../bindings/clock/qcom,gpucc-sdm660.yaml          |    4 +-
 .../bindings/clock/qcom,gpucc-sm8350.yaml          |    9 +-
 .../devicetree/bindings/clock/qcom,gpucc.yaml      |   22 +-
 .../devicetree/bindings/clock/qcom,lcc.txt         |   22 -
 .../devicetree/bindings/clock/qcom,lcc.yaml        |   86 +
 .../devicetree/bindings/clock/qcom,lpasscc.txt     |   26 -
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |   42 +-
 .../bindings/clock/qcom,msm8998-gpucc.yaml         |    8 +-
 .../devicetree/bindings/clock/qcom,q6sstopcc.yaml  |    2 +-
 .../bindings/clock/qcom,qcm2290-dispcc.yaml        |    8 +-
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sc7180-camcc.yaml          |    9 +-
 .../bindings/clock/qcom,sc7180-dispcc.yaml         |    8 +-
 .../bindings/clock/qcom,sc7180-lpasscorecc.yaml    |    9 +-
 .../devicetree/bindings/clock/qcom,sc7180-mss.yaml |    7 +-
 .../bindings/clock/qcom,sc7280-camcc.yaml          |    6 +-
 .../bindings/clock/qcom,sc7280-dispcc.yaml         |    8 +-
 .../bindings/clock/qcom,sc7280-lpasscc.yaml        |    9 +-
 .../bindings/clock/qcom,sc7280-lpasscorecc.yaml    |   12 +-
 .../bindings/clock/qcom,sdm845-camcc.yaml          |    8 +-
 .../bindings/clock/qcom,sdm845-dispcc.yaml         |    8 +-
 .../bindings/clock/qcom,sdm845-lpasscc.yaml        |   47 +
 .../bindings/clock/qcom,sm6115-dispcc.yaml         |    7 +-
 .../bindings/clock/qcom,sm6375-dispcc.yaml         |   54 +
 .../devicetree/bindings/clock/qcom,sm6375-gcc.yaml |    9 +-
 .../bindings/clock/qcom,sm8450-camcc.yaml          |    8 +-
 .../bindings/clock/qcom,sm8450-dispcc.yaml         |    7 +-
 .../devicetree/bindings/clock/qcom,sm8550-gcc.yaml |   62 +
 .../devicetree/bindings/clock/qcom,videocc.yaml    |   20 +-
 .../bindings/clock/rockchip,rk3588-cru.yaml        |   71 +
 .../devicetree/bindings/clock/ti,cdce925.txt       |   53 -
 .../devicetree/bindings/clock/ti,cdce925.yaml      |  103 +
 drivers/clk/clk-bulk.c                             |    6 +-
 drivers/clk/clk-cdce925.c                          |   21 +-
 drivers/clk/clk-fractional-divider.c               |   65 +-
 drivers/clk/clk-lmk04832.c                         |   41 +-
 drivers/clk/clk-nomadik.c                          |    2 +-
 drivers/clk/clk-stm32mp1.c                         |    2 +-
 drivers/clk/clk-versaclock5.c                      |    1 -
 drivers/clk/clk.c                                  |   32 +
 drivers/clk/imx/clk-imx6sll.c                      |    8 +-
 drivers/clk/imx/clk-imx6sx.c                       |   12 +-
 drivers/clk/imx/clk-imx6ul.c                       |    8 +-
 drivers/clk/imx/clk-imx7d.c                        |    4 +-
 drivers/clk/imx/clk-imx7ulp.c                      |   10 +-
 drivers/clk/imx/clk-imx8mm.c                       |   12 +-
 drivers/clk/imx/clk-imx8mn.c                       |  128 +-
 drivers/clk/imx/clk-imx8mp.c                       |   28 +-
 drivers/clk/imx/clk-imx8mq.c                       |   14 +-
 drivers/clk/imx/clk-imx93.c                        |   46 +-
 drivers/clk/imx/clk-imxrt1050.c                    |    5 +-
 drivers/clk/imx/clk-pll14xx.c                      |    2 +
 drivers/clk/imx/clk.c                              |    5 +-
 drivers/clk/imx/clk.h                              |    3 +-
 drivers/clk/ingenic/Kconfig                        |   10 +
 drivers/clk/ingenic/Makefile                       |    1 +
 drivers/clk/ingenic/cgu.c                          |   42 +-
 drivers/clk/ingenic/cgu.h                          |   17 +-
 drivers/clk/ingenic/jz4755-cgu.c                   |  346 ++
 drivers/clk/ingenic/x1000-cgu.c                    |  119 +-
 drivers/clk/keystone/syscon-clk.c                  |    9 +-
 drivers/clk/mediatek/Kconfig                       |    8 +
 drivers/clk/mediatek/Makefile                      |    1 +
 drivers/clk/mediatek/clk-fhctl.c                   |  244 ++
 drivers/clk/mediatek/clk-fhctl.h                   |   26 +
 drivers/clk/mediatek/clk-mt6795-topckgen.c         |   76 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c         |    2 +-
 drivers/clk/mediatek/clk-mt8173.c                  |   76 +-
 drivers/clk/mediatek/clk-mt8183.c                  |  216 +-
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c       |   66 +-
 drivers/clk/mediatek/clk-mt8186-mfg.c              |    5 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c         |   89 +-
 drivers/clk/mediatek/clk-mt8192.c                  |   76 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |   78 +-
 drivers/clk/mediatek/clk-mtk.c                     |    2 +-
 drivers/clk/mediatek/clk-mtk.h                     |    7 +-
 drivers/clk/mediatek/clk-pll.c                     |   84 +-
 drivers/clk/mediatek/clk-pll.h                     |   55 +
 drivers/clk/mediatek/clk-pllfh.c                   |  275 ++
 drivers/clk/mediatek/clk-pllfh.h                   |   82 +
 drivers/clk/meson/clk-pll.c                        |   21 +-
 drivers/clk/microchip/Kconfig                      |    3 +-
 drivers/clk/microchip/clk-mpfs-ccc.c               |    6 +
 drivers/clk/mstar/Kconfig                          |    7 +
 drivers/clk/mstar/Makefile                         |    1 +
 drivers/clk/mstar/clk-msc313-cpupll.c              |  220 ++
 drivers/clk/qcom/Kconfig                           |   26 +
 drivers/clk/qcom/Makefile                          |    3 +
 drivers/clk/qcom/clk-alpha-pll.c                   |   16 +
 drivers/clk/qcom/clk-alpha-pll.h                   |    5 +
 drivers/clk/qcom/clk-krait.c                       |    2 +
 drivers/clk/qcom/clk-rpm.c                         |  204 +-
 drivers/clk/qcom/clk-rpmh.c                        |  427 +--
 drivers/clk/qcom/dispcc-sc8280xp.c                 | 3218 +++++++++++++++++++
 drivers/clk/qcom/dispcc-sm6350.c                   |    4 +-
 drivers/clk/qcom/dispcc-sm6375.c                   |  610 ++++
 drivers/clk/qcom/dispcc-sm8250.c                   |   38 +-
 drivers/clk/qcom/gcc-ipq4019.c                     |   11 +-
 drivers/clk/qcom/gcc-ipq806x.c                     |    4 +-
 drivers/clk/qcom/gcc-ipq8074.c                     | 1795 +++++------
 drivers/clk/qcom/gcc-msm8939.c                     |   35 +
 drivers/clk/qcom/gcc-msm8974.c                     |  682 ++--
 drivers/clk/qcom/gcc-sm6125.c                      |    1 -
 drivers/clk/qcom/gcc-sm8250.c                      |    4 +-
 drivers/clk/qcom/gcc-sm8550.c                      | 3387 ++++++++++++++++++++
 drivers/clk/qcom/gdsc.c                            |    3 +-
 drivers/clk/qcom/hfpll.c                           |    4 +-
 drivers/clk/qcom/kpss-xcc.c                        |   13 +-
 drivers/clk/qcom/krait-cc.c                        |  236 +-
 drivers/clk/qcom/lpassaudiocc-sc7280.c             |   55 +-
 drivers/clk/qcom/lpasscorecc-sc7180.c              |   34 +-
 drivers/clk/qcom/mmcc-msm8974.c                    |  736 ++---
 drivers/clk/qcom/reset.c                           |    4 +-
 drivers/clk/qcom/reset.h                           |    1 +
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r8a779f0-cpg-mssr.c            |   28 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c            |   33 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |    3 +-
 drivers/clk/renesas/r9a07g043-cpg.c                |    5 -
 drivers/clk/renesas/r9a07g044-cpg.c                |   10 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |   49 +-
 drivers/clk/renesas/rzg2l-cpg.h                    |    4 +
 drivers/clk/rockchip/Kconfig                       |    8 +
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk-cpu.c                     |   69 +-
 drivers/clk/rockchip/clk-pll.c                     |  219 +-
 drivers/clk/rockchip/clk-rk3588.c                  | 2533 +++++++++++++++
 drivers/clk/rockchip/clk.c                         |   15 +-
 drivers/clk/rockchip/clk.h                         |   95 +-
 drivers/clk/rockchip/rst-rk3588.c                  |  857 +++++
 drivers/clk/rockchip/softrst.c                     |   34 +-
 drivers/clk/samsung/clk-exynos5-subcmu.c           |    4 +-
 drivers/clk/samsung/clk-pll.c                      |    1 +
 drivers/clk/socfpga/clk-gate.c                     |    5 +-
 drivers/clk/spear/spear6xx_clock.c                 |    8 +-
 drivers/clk/st/clkgen-fsyn.c                       |    5 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.h               |    6 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           |   11 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |    2 +-
 drivers/clk/ti/apll.c                              |    4 +-
 drivers/clk/ti/clk-dra7-atl.c                      |   16 +-
 drivers/clk/ti/clk.c                               |   36 +-
 drivers/clk/ti/clkctrl.c                           |    4 +-
 drivers/clk/ti/clock.h                             |   10 +-
 drivers/clk/ti/composite.c                         |    2 +-
 drivers/clk/ti/divider.c                           |    2 +-
 drivers/clk/ti/dpll.c                              |    4 +-
 drivers/clk/ti/fixed-factor.c                      |    2 +-
 drivers/clk/ti/gate.c                              |    6 +-
 drivers/clk/ti/interface.c                         |    7 +-
 drivers/clk/ti/mux.c                               |    6 +-
 drivers/clk/visconti/pll.c                         |    1 +
 drivers/clk/x86/Kconfig                            |    5 +-
 drivers/clk/x86/clk-cgu-pll.c                      |   23 +-
 drivers/clk/x86/clk-cgu.c                          |  106 +-
 drivers/clk/x86/clk-cgu.h                          |   46 +-
 drivers/clk/x86/clk-lgm.c                          |   18 +-
 drivers/clk/xilinx/Kconfig                         |    4 +-
 include/dt-bindings/clock/imx8mn-clock.h           |   24 +-
 include/dt-bindings/clock/imx8mp-clock.h           |   12 +-
 include/dt-bindings/clock/imx93-clock.h            |    4 -
 include/dt-bindings/clock/ingenic,jz4755-cgu.h     |   49 +
 include/dt-bindings/clock/ingenic,x1000-cgu.h      |    4 +
 include/dt-bindings/clock/qcom,dispcc-sc8280xp.h   |  100 +
 include/dt-bindings/clock/qcom,dispcc-sm8250.h     |    1 +
 include/dt-bindings/clock/qcom,gcc-ipq8074.h       |   14 +
 include/dt-bindings/clock/qcom,sm6375-dispcc.h     |   42 +
 include/dt-bindings/clock/qcom,sm8550-gcc.h        |  231 ++
 include/dt-bindings/clock/rk3399-cru.h             |    6 +-
 include/dt-bindings/clock/rockchip,rk3588-cru.h    |  766 +++++
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      |    2 +
 include/dt-bindings/reset/rockchip,rk3588-cru.h    |  754 +++++
 include/linux/clk-provider.h                       |    2 +
 include/trace/events/clk.h                         |   43 +
 216 files changed, 18584 insertions(+), 3500 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8974.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdm660.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,lcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/ti,cdce925.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti,cdce925.yaml
 create mode 100644 drivers/clk/ingenic/jz4755-cgu.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl.h
 create mode 100644 drivers/clk/mediatek/clk-pllfh.c
 create mode 100644 drivers/clk/mediatek/clk-pllfh.h
 create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c
 create mode 100644 drivers/clk/qcom/dispcc-sc8280xp.c
 create mode 100644 drivers/clk/qcom/dispcc-sm6375.c
 create mode 100644 drivers/clk/qcom/gcc-sm8550.c
 create mode 100644 drivers/clk/rockchip/clk-rk3588.c
 create mode 100644 drivers/clk/rockchip/rst-rk3588.c
 create mode 100644 include/dt-bindings/clock/ingenic,jz4755-cgu.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc8280xp.h
 create mode 100644 include/dt-bindings/clock/qcom,sm6375-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-gcc.h
 create mode 100644 include/dt-bindings/clock/rockchip,rk3588-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3588-cru.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
