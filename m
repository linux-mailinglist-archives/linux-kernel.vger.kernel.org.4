Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7910A5F7F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJGU6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJGU6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5CA98D3;
        Fri,  7 Oct 2022 13:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D105461B7A;
        Fri,  7 Oct 2022 20:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5001C433D7;
        Fri,  7 Oct 2022 20:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665176319;
        bh=0Ri++Utl4ND+UYKdeMvHD0FVCQTnMKEWNeLQoR+ic+E=;
        h=From:To:Cc:Subject:Date:From;
        b=Otp7FOwDE4T27n96ZUAJqNvj2Y/PK3dzjGj4CpipOqZUjY9xd7MWzum+lr6e5GsHY
         0WBVAw49LcYf/p5zKj7TiLGSSiHUpbKPVNCIDRJ3/zocMxQtfj2DeioPRLgfM/AwuV
         6l9mS8udwj9ayaIRVLqiT4gntF/l+oA1e66O71bk8ARRx3weLvuzTsxenHWyfgbGj1
         VtE3nK2pz6vmr8ZVP9RqHCT81UsgdW+jhIL+7wySBs3tOmh48s98lDHD8M30A0hM73
         NtWGSQjQhERqoha7SYLL8ZziwyNiF42vZS1Rxb7WQ+xrL6vUaCnN1qrZdU1JFsinGs
         HnrS4EgHHaM9Q==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Fri,  7 Oct 2022 13:58:38 -0700
Message-Id: <20221007205838.744794-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

The following changes since commit 05d27090b6dc88bce71a608d1271536e582b73d1:

  clk: microchip: mpfs: make the rtc's ahb clock critical (2022-09-14 10:45:52 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to f9efefdba95a5110a1346bb03acdd8ff3cdf557f:

  Merge branches 'clk-baikal', 'clk-broadcom', 'clk-vc5' and 'clk-versaclock' into clk-next (2022-10-04 10:54:34 -0700)

----------------------------------------------------------------
Here's the main clk pull request for this merge window. We have some
late breaking reports that a patch series to rework clk rate range
support broke boot on some devices, so I've left that branch out of this
PR. Hopefully we can get to that next week, or punt on it and let it
bake another cycle. That means we don't really have any changes to the
core framework this time around besides a few typo fixes. Instead this
is all clk driver updates and fixes.

The usual suspects are here (again), with Qualcomm dominating the
diffstat. We look to have gained support for quite a few new Qualcomm
SoCs and Dmitry worked on updating many of the existing Qualcomm drivers
to use clk_parent_data. After that we have MediaTek drivers getting some
much needed updates, in particular to support GPU DVFS. There are also
quite a few Samsung clk driver patches, but that's mostly because there
was a maintainer change and so last release we missed some of those
patches.

Overall things look normal, but I'm slowly reviewing core framework code
nowadays and that shows given the rate range patches had to be yanked
last minute. Let's hope this situation changes soon.

New Drivers:
 - Support for Renesas VersaClock7 clock generator family
 - Add Spreadtrum UMS512 SoC clk support
 - New clock drivers for MediaTek Helio X10 MT6795
 - Display clks for Qualcomm SM6115, SM8450
 - GPU clks for Qualcomm SC8280XP
 - Qualcomm MSM8909 and SM6375 global and SMD RPM clk drivers

Deleted Drivers:
 - Remove DaVinci DM644x and DM646x clk driver support

Updates:
 - Convert Baikal-T1 CCU driver to platform driver
 - Split reset support out of primary Baikal-T1 CCU driver
 - Add some missing clks required for RPiVid Video Decoder on RaspberryPi
 - Mark PLLC critical on bcm2835
 - More devm helpers for fixed rate registration
 - Various PXA168 clk driver fixes
 - Add resets for MediaTek MT8195 PCIe and USB
 - Miscellaneous of_node_put() fixes
 - Nuke dt-bindings/clk path (again) by moving headers to dt-bindings/clock
 - Convert gpio-clk-gate binding to YAML
 - Various fixes to AMD/Xilinx Zynqmp clk driver
 - Graduate AMD/Xilinx "clocking wizard" driver from staging
 - Add missing DPI1_HDMI clock in MT8195 VDOSYS1
 - Clock driver changes to support GPU DVFS on MT8183, MT8192, MT8195
   - Fix GPU clock topology on MT8195
   - Propogate rate changes from GPU clock gate up the tree
   - Clock mux notifiers for GPU-related PLLs
 - Conversion of more "simple" drivers to mtk_clk_simple_probe()
 - Hook up mtk_clk_simple_remove() for "simple" MT8192 clock drivers
 - Fixes to previous |struct clk| to |struct clk_hw| conversion on MediaTek
 - Shrink MT8192 clock driver by deduplicating clock parent lists
 - Change order between 'sim_enet_root_clk' and 'enet_qos_root_clk'
   clocks for i.MX8MP
 - Drop unnecessary newline in i.MX8MM dt-bindings
 - Add more MU1 and SAI clocks dt-bindings Ids
 - Introduce slice busy bit check for i.MX93 composite clock
 - Introduce white list bit check for i.MX93 composite clock
 - Add new i.MX93 clock gate
 - Add MU1 and MU2 clocks to i.MX93 clock provider
 - Add SAI IPG clocks to i.MX93 clock provider
 - add generic clocks for U(S)ART available on SAMA5D2 SoCs
 - reset controller support for Polarfire clocks
 - .round_rate and .set rate support for clk-mpfs
 - code cleanup for clk-mpfs
 - PLL support for PolarFire SoC's Clock Conditioning Circuitry
 - Add watchdog, I2C, pin control/GPIO, and Ethernet clocks on R-Car V4H
 - Add SDHI, Timer (CMT/TMU), and SPI (MSIOF) clocks on R-Car S4-8
 - Add I2C clocks and resets on RZ/V2M
 - Document clock support for the RZ/Five SoC
 - mux-variant clock using the table variant to select parents
 - clock controller for the rv1126 soc
 - conversion of rk3128 to yaml and relicensing of the yaml bindings
   to gpl2+MIT (following dt-binding guildelines)
 - Exynos7885: add FSYS, TREX and MFC clock controllers
 - Exynos850: add IS and AUD (audio) clock controllers with bindings
 - ExynosAutov9: add FSYS clock controllers with bindings
 - ExynosAutov9: correct clock IDs in bindings of Peric 0 and 1 clock
   controllers, due to duplicated entries.  This is an acceptable ABI
   break: recently developed/added platform so without legacies, acked
   by known users/developers
 - ExynosAutov9: add few missing Peric 0/1 gates
 - ExynosAutov9: correct register offsets of few Peric 0/1 clocks
 - Minor code improvements (use of_device_get_match_data() helper, code
   style)
 - Add Krzysztof Kozlowski as co-maintainer of Samsung SoC clocks, as he
   already maintainers that architecture/platform
 - Keep Qualcomm GDSCs enabled when PWRSTS_RET flag is there, solving retention
   issues during suspend of USB on Qualcomm sc7180/sc7280 and SC8280XP
 - Qualcomm SM6115 and QCM2260 are moved to reuse PLL configuration
 - Qualcomm SDM660 SDCC1 moved to floor clk ops
 - Support for the APCS PLLs for Qualcomm IPQ8064, IPQ8074 and IPQ6018 was
   added/fixed
 - The Qualcomm MSM8996 CPU clocks are updated with support for ACD
 - Support for Qualcomm SDM670 GCC and RPMh clks was added
 - Transition to parent_data, parent_hws and use of ARRAY_SIZE() for
   num_parents was done for many Qualcomm SoCs
 - Support for per-reset defined delay on Qualcomm was introduced

----------------------------------------------------------------
Adam Skladowski (3):
      dt-bindings: clock: add QCOM SM6115 display clock bindings
      clk: qcom: Add display clock controller driver for SM6115
      clk: qcom: gcc-sm6115: Override default Alpha PLL regs

Alex Helms (2):
      dt-bindings: Renesas versaclock7 device tree bindings
      clk: Renesas versaclock7 ccf device driver

Andi Kleen (1):
      clk: pistachio: Fix initconst confusion

Andrew Halaney (1):
      dt-bindings: clocks: qcom,gcc-sc8280xp: Fix typos

Andy Shevchenko (3):
      clk: Remove never used devm_of_clk_del_provider()
      clkdev: Remove never used devm_clk_release_clkdev()
      clkdev: Simplify devm_clk_hw_register_clkdev() function

AngeloGioacchino Del Regno (21):
      clk: mediatek: clk-mt8195-vdo0: Set rate on vdo0_dp_intf0_dp_intf's parent
      clk: mediatek: clk-mt8195-vdo1: Reparent and set rate on vdo1_dpintf's parent
      dt-bindings: reset: mt8195: Add resets for PCIE controllers
      clk: mediatek: mt8195: Add reset idx for PCIe0 and PCIe1
      clk: mediatek: mt8195-infra_ao: Set pwrmcu clocks as critical
      dt-bindings: reset: mt8195: Add resets for USB/PCIe t-phy port 1
      clk: mediatek: mt8195: Add reset idx for USB/PCIe T-PHY
      dt-bindings: mediatek: Document MT6795 system controllers bindings
      dt-bindings: clock: Add MediaTek Helio X10 MT6795 clock bindings
      dt-bindings: reset: Add bindings for MT6795 Helio X10 reset controllers
      dt-bindings: clock: mediatek: Add clock driver bindings for MT6795
      clk: mediatek: clk-apmixed: Remove unneeded __init annotation
      clk: mediatek: Export required symbols to compile clk drivers as module
      clk: mediatek: clk-apmixed: Add helper function to unregister ref2usb_tx
      clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers
      clk: mediatek: clk-mt8195-mfg: Reparent mfg_bg3d and propagate rate changes
      clk: mediatek: clk-mt8195-topckgen: Register mfg_ck_fast_ref as generic mux
      clk: mediatek: clk-mt8195-topckgen: Add GPU clock mux notifier
      clk: mediatek: clk-mt8195-topckgen: Drop univplls from mfg mux parents
      clk: mediatek: clk-mt8192-mfg: Propagate rate changes to parent
      clk: mediatek: clk-mt8192: Add clock mux notifier for mfg_pll_sel

Biju Das (1):
      clk: renesas: r9a07g044: Add conditional compilation for r9a07g044_cpg_info

Bjorn Andersson (3):
      Merge branch '1662005846-4838-1-git-send-email-quic_c_skakit@quicinc.com' into clk-for-6.1
      dt-bindings: clock: Add Qualcomm SC8280XP GPU binding
      clk: qcom: Add SC8280XP GPU clock controller

Chanho Park (8):
      dt-bindings: clock: exynosautov9: correct clock numbering of peric0/c1
      dt-bindings: clock: exynosautov9: add fys0 clock definitions
      dt-bindings: clock: exynosautov9: add fsys1 clock definitions
      dt-bindings: clock: exynosautov9: add schema for cmu_fsys0/1
      clk: samsung: exynosautov9: add missing gate clks for peric0/c1
      clk: samsung: exynosautov9: correct register offsets of peric0/c1
      clk: samsung: exynosautov9: add fsys0 clock support
      clk: samsung: exynosautov9: add fsys1 clock support

Chen-Yu Tsai (6):
      clk: mediatek: mt8183: mfgcfg: Propagate rate changes to parent
      clk: mediatek: mux: add clk notifier functions
      clk: mediatek: mt8183: Add clk mux notifier for MFG mux
      clk: mediatek: fix unregister function in mtk_clk_register_dividers cleanup
      clk: mediatek: Migrate remaining clk_unregister_*() to clk_hw_unregister_*()
      clk: mediatek: mt8192: deduplicate parent clock lists

Christian Marangi (7):
      dt-bindings: clock: add pcm reset for ipq806x lcc
      clk: qcom: lcc-ipq806x: add reset definition
      clk: qcom: lcc-ipq806x: convert to parent data
      clk: qcom: lcc-ipq806x: use ARRAY_SIZE for num_parents
      clk: qcom: clk-rcg2: add rcg2 mux ops
      clk: introduce (devm_)hw_register_mux_parent_data_table API
      clk: qcom: kpss-xcc: convert to parent data API

Cixi Geng (1):
      clk: sprd: Add clocks support for UMS512

Claudiu Beznea (2):
      clk: remove extra empty line
      clk: do not initialize ret

Clément Léger (1):
      clk: allow building lan966x as a module

Conor Dooley (16):
      dt-bindings: clock: gpio-gate-clock: Convert to json-schema
      dt-bindings: clk: microchip: mpfs: add reset controller support
      clk: microchip: mpfs: add reset controller
      reset: add polarfire soc reset support
      MAINTAINERS: add polarfire soc reset controller
      clk: microchip: mpfs: add MSS pll's set & round rate
      clk: microchip: mpfs: move id & offset out of clock structs
      clk: microchip: mpfs: simplify control reg access
      clk: microchip: mpfs: delete 2 line mpfs_clk_register_foo()
      clk: microchip: mpfs: convert cfg_clk to clk_divider
      clk: microchip: mpfs: convert periph_clk to clk_gate
      clk: microchip: mpfs: update module authorship & licencing
      dt-bindings: clk: rename mpfs-clkcfg binding
      dt-bindings: clk: document PolarFire SoC fabric clocks
      dt-bindings: clk: add PolarFire SoC fabric clock ids
      clk: microchip: add PolarFire SoC fabric clock support

Dang Huynh (1):
      clk: qcom: sm6115: Select QCOM_GDSC

David Virag (2):
      clk: samsung: exynos7885: Implement CMU_FSYS domain
      clk: samsung: exynos7885: Add TREX clocks

Dmitry Baryshkov (34):
      dt-bindings: clk: qcom,gcc-*: use qcom,gcc.yaml
      dt-bindings: clock: separate bindings for MSM8916 GCC device
      clk: qcom: gcc-msm8916: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-msm8916: move GPLL definitions up
      clk: qcom: gcc-msm8916: move gcc_mss_q6_bimc_axi_clk down
      clk: qcom: gcc-msm8916: use parent_hws/_data instead of parent_names
      dt-bindings: clock: qcom,mmcc: fix clocks/clock-names definitions
      dt-bindings: clock: qcom,mmcc: define clocks/clock-names for MSM8996
      dt-bindings: clock: qcom,gcc-msm8660: separate GCC bindings for MSM8660
      clk: qcom: gcc-msm8660: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-msm8660: use parent_hws/_data instead of parent_names
      clk: qcom: a53-pll: convert to use parent_data rather than parent_names
      dt-bindings: clocks: qcom,gcc-apq8064: define clocks/-names properties
      dt-bindings: clocks: qcom,mmcc: define clocks/clock-names for MSM8960
      clk: qcom: gcc-msm8960: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-msm8960: use parent_hws/_data instead of parent_names
      clk: qcom: lcc-msm8960: use macros to implement mi2s clocks
      clk: qcom: lcc-msm8960: use parent_hws/_data instead of parent_names
      clk: qcom: mmcc-msm8960: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: mmcc-msm8960: move clock parent tables down
      clk: qcom: mmcc-msm8960: use parent_hws/_data instead of parent_names
      clk: qcom: cpu-8996: switch to devm_clk_notifier_register
      clk: qcom: cpu-8996: declare ACD clocks
      clk: qcom: cpu-8996: move ACD logic to clk_cpu_8996_pmux_determine_rate
      clk: qcom: cpu-8996: don't store parents in clk_cpu_8996_pmux
      clk: qcom: cpu-8996: use constant mask for pmux
      dt-bindings: clock: qcom: add bindings for dispcc on SM8450
      clk: qcom: alpha-pll: add support for power off mode for lucid evo PLL
      clk: qcom: Add support for Display Clock Controller on SM8450
      dt-bindings: clock: move qcom,gcc-msm8939 to qcom,gcc-msm8916.yaml
      clk: qcom: gcc-msm8939: use parent_hws where possible
      clk: qcom: gcc-msm8939: use ARRAY_SIZE instead of specifying num_parents
      clk: asm9260: use parent index to link the reference clock
      clk: fixed-rate: add devm_clk_hw_register_fixed_rate

Dom Cobley (1):
      clk: bcm: rpi: Add support for VEC clock

Doug Brown (12):
      clk: mmp: pxa168: add additional register defines
      clk: mmp: pxa168: fix incorrect dividers
      dt-bindings: marvell,pxa168: add clock ids for additional dividers
      clk: mmp: pxa168: add new clocks for peripherals
      clk: mmp: pxa168: fix const-correctness
      clk: mmp: pxa168: fix incorrect parent clocks
      clk: mmp: pxa168: add muxes for more peripherals
      clk: mmp: pxa168: fix GPIO clock enable bits
      dt-bindings: marvell,pxa168: add clock id for SDH3
      clk: mmp: pxa168: add clocks for SDH2 and SDH3
      dt-bindings: marvell,pxa168: add clock ids for SDH AXI clocks
      clk: mmp: pxa168: control shared SDH bits with separate clock

Elaine Zhang (1):
      clk: rockchip: Add MUXTBL variant

Fabien Parent (2):
      dt-bindings: clock: mediatek: add bindings for MT8365 SoC
      clk: mediatek: add driver for MT8365 SoC

Geert Uytterhoeven (4):
      clk: renesas: r8a779g0: Add watchdog clock
      clk: renesas: r8a779g0: Add I2C clocks
      clk: renesas: r8a779g0: Add PFC/GPIO clocks
      clk: renesas: r8a779g0: Add EtherAVB clocks

Heiko Stuebner (1):
      Merge branch 'v6.1-shared/clkids' into v6.1-clock/next

Ian Nam (1):
      clk: zynqmp: Fix stack-out-of-bounds in strncpy`

Iskren Chernev (2):
      clk: qcom: gcc-sm6115: Move alpha pll bramo overrides
      clk: qcom: Merge alt alpha plls for qcm2260, sm6115

Ivan T. Ivanov (3):
      clk: bcm2835: Round UART input clock up
      clk: bcm: rpi: Add support HEVC clock
      clk: bcm: rpi: Handle pixel clock in firmware

Jagan Teki (3):
      clk: rockchip: Add dt-binding header for RV1126
      dt-bindings: clock: rockchip: Document RV1126 CRU
      clk: rockchip: Add clock controller support for RV1126 SoC

Jason Wang (1):
      clk: Fix comment typo

Jiangshan Yi (1):
      clk: davinci: pll: fix spelling typo in comment

Joel Stanley (1):
      clk: ast2600: BCLK comes from EPLL

Johan Hovold (4):
      clk: gcc-sc8280xp: keep PCIe power-domains always-on
      clk: gcc-sc8280xp: keep USB power-domains always-on
      clk: qcom: gdsc: add missing error handling
      clk: qcom: gcc-sc8280xp: use retention for USB power domains

Johan Jonker (2):
      dt-bindings: clock: convert rockchip,rk3128-cru.txt to YAML
      dt-bindings: clock: rockchip: change SPDX-License-Identifier

Julia Lawall (1):
      clk: nxp: fix typo in comment

Konrad Dybcio (7):
      dt-bindings: clock: qcom,rpmcc: Add compatible for SM6375
      dt-bindings: clock: qcom: rpmcc: Add BIMC_FREQ_LOG
      clk: qcom: smd: Add SM6375 clocks
      clk: qcom: alpha: Add support for programming the PLL_FSM_LEGACY_MODE bit
      dt-bindings: clock: add SM6375 QCOM global clock bindings
      clk: qcom: Add global clock controller driver for SM6375
      clk: qcom: gcc-sm6375: Remove unused variables

Krishna chaitanya chundru (1):
      clk: qcom: gcc-sc7280: Update the .pwrsts for PCIe GDSC

Krzysztof Kozlowski (4):
      Merge branch 'for-v6.0/samsung-clk-dt-bindings' into next/clk
      clk: samsung: MAINTAINERS: add Krzysztof Kozlowski
      dt-bindings: clock: drop minItems equal to maxItems
      dt-bindings: clock: qcom,a53pll: replace maintainer

Lad Prabhakar (1):
      dt-bindings: clock: renesas,rzg2l: Document RZ/Five SoC

Lars-Peter Clausen (2):
      clk: vc5: Check IO access results
      clk: vc5: Use regmap_{set,clear}_bits() where appropriate

Li Zhengyu (1):
      clk: qcom: clk-rpmh: Remove redundant if statement

Liang He (10):
      clk: nomadik: Add missing of_node_put()
      clk: meson: Hold reference returned by of_get_parent()
      clk: tegra: Add missing of_node_put()
      clk: st: Hold reference returned by of_get_parent()
      clk: oxnas: Hold reference returned by of_get_parent()
      clk: qoriq: Hold reference returned by of_get_parent()
      clk: at91: dt-compat: Hold reference returned by of_get_parent()
      clk: berlin: Add of_node_put() for of_get_parent()
      clk: sprd: Hold reference returned by of_get_parent()
      clk: ti: Balance of_node_get() calls for of_find_node_by_name()

Lin Yujun (1):
      clk: imx: scu: fix memleak on platform_device_add() fails

Luca Weiss (1):
      clk: qcom: gcc-sm6350: Update the .pwrsts for usb gdscs

Lukas Bulwahn (4):
      dt-bindings: clock: Move lochnagar.h to dt-bindings/clock
      dt-bindings: clock: Move versaclock.h to dt-bindings/clock
      clk: davinci: remove PLL and PSC clocks for DaVinci DM644x and DM646x
      MAINTAINERS: add header file to TI DAVINCI SERIES CLOCK DRIVER

Marcel Ziswiler (1):
      dt-bindings: clock: imx8mm: don't use multiple blank lines

Marijn Suijten (1):
      clk: qcom: gcc-sdm660: Use floor ops for SDCC1 clock

Markus Schneider-Pargmann (2):
      clk: mediatek: Provide mtk_devm_alloc_clk_data
      clk: mediatek: Export required common code symbols

Matthias Fend (2):
      dt-bindings: clock: vc5: Add 5P49V6975
      clk: vc5: Add support for IDT/Renesas VersaClock 5P49V6975

Maxime Ripard (1):
      clk: bcm2835: Make peripheral PLLC critical

Miaoqian Lin (4):
      clk: tegra: Fix refcount leak in tegra210_clock_init
      clk: tegra: Fix refcount leak in tegra114_clock_init
      clk: tegra20: Fix refcount leak in tegra20_clock_init
      clk: ti: dra7-atl: Fix reference leak in of_dra7_atl_clk_probe

Miles Chen (7):
      clk: mediatek: mt2701: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt2712: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt6765: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt6779: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt6797: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt8183: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt8192: add mtk_clk_simple_remove

Minghao Chi (CGEL ZTE) (1):
      clk: samsung: exynos-clkout: Use of_device_get_match_data()

Pablo Sun (2):
      dt-bindings: clk: mediatek: Add MT8195 DPI clocks
      clk: mediatek: add VDOSYS1 clock

Peng Fan (8):
      clk: imx8mp: tune the order of enet_qos_root_clk
      dt-bindings: clock: imx93-clock: add more MU/SAI clocks
      clk: imx: clk-composite-93: check slice busy
      clk: imx: clk-composite-93: check white_list
      clk: imx: add i.MX93 clk gate
      clk: imx93: switch to use new clk gate API
      clk: imx93: add MU1/2 clock
      clk: imx93: add SAI IPG clk

Phil Edworthy (1):
      clk: renesas: r9a09g011: Add IIC clock and reset entries

Quanyang Wang (1):
      clk: zynqmp: pll: rectify rate rounding in zynqmp_pll_round_rate

Rajendra Nayak (3):
      clk: qcom: gdsc: Fix the handling of PWRSTS_RET support
      clk: qcom: gcc-sc7180: Update the .pwrsts for usb gdsc
      clk: qcom: gcc-sc7280: Update the .pwrsts for usb gdscs

Richard Acayan (5):
      dt-bindings: clock: gcc-sdm845: add sdm670 global clocks
      clk: qcom: gcc-sdm845: use device tree match data
      clk: qcom: gcc-sdm845: add sdm670 global clock data
      dt-bindings: clock: add rpmhcc bindings for sdm670
      clk: qcom: rpmhcc: add sdm670 clocks

Robert Marko (6):
      clk: qcom: apss-ipq6018: fix apcs_alias0_clk_src
      clk: qcom: apss-ipq6018: mark apcs_alias0_core_clk as critical
      dt-bindings: clock: qcom,a53pll: add IPQ8074 compatible
      clk: qcom: apss-ipq-pll: use OF match data for Alpha PLL config
      clk: qcom: apss-ipq-pll: update IPQ6018 Alpha PLL config
      clk: qcom: apss-ipq-pll: add support for IPQ8074

Sam Protsenko (7):
      dt-bindings: clock: exynos850: Add Exynos850 CMU_AUD
      dt-bindings: clock: exynos850: Add Exynos850 CMU_IS
      dt-bindings: clock: exynos850: Add Exynos850 CMU_MFCMSCL
      clk: samsung: exynos850: Style fixes
      clk: samsung: exynos850: Implement CMU_AUD domain
      clk: samsung: exynos850: Implement CMU_IS domain
      clk: samsung: exynos850: Implement CMU_MFCMSCL domain

Samuel Holland (1):
      clk: sunxi-ng: d1: Limit PLL rates to stable ranges

Satya Priya (1):
      clk: qcom: lpass: Fix lpass audiocc probe

Serge Semin (8):
      clk: vc5: Fix 5P49V6901 outputs disabling when enabling FOD
      clk: baikal-t1: Fix invalid xGMAC PTP clock divider
      clk: baikal-t1: Add shared xGMAC ref/ptp clocks internal parent
      clk: baikal-t1: Add SATA internal ref clock buffer
      clk: baikal-t1: Move reset-controls code into a dedicated module
      dt-bindings: clk: baikal-t1: Add DDR/PCIe reset IDs
      clk: baikal-t1: Add DDR/PCIe directly controlled resets support
      clk: baikal-t1: Convert to platform device driver

Sergiu Moga (1):
      clk: at91: sama5d2: Add Generic Clocks for UART/USART

Shubhrajyoti Datta (9):
      clk: zynqmp: make bestdiv unsigned
      clk: zynqmp: Replaced strncpy() with strscpy()
      clk: zynqmp: Add a check for NULL pointer
      clk: zynqmp: Check the return type zynqmp_pm_query_data
      dt-bindings: add documentation of xilinx clocking wizard
      clk: clocking-wizard: Move clocking-wizard out
      clk: clocking-wizard: Rename nr-outputs to xlnx,nr-outputs
      clk: clocking-wizard: Fix the reconfig for 5.2
      clk: clocking-wizard: Update the compatible

Stefan Wahren (1):
      clk: bcm2835: fix bcm2835_clock_rate_from_divisor declaration

Stephan Gerhold (6):
      dt-bindings: clock: Add schema for MSM8909 GCC
      clk: qcom: Add driver for MSM8909 GCC
      clk: qcom: reset: Allow specifying custom reset delay
      clk: qcom: gcc-msm8909: Increase delay for USB PHY reset
      dt-bindings: clock: qcom,rpmcc: Add MSM8909
      clk: qcom: smd-rpm: Add clocks for MSM8909

Stephen Boyd (16):
      Merge tag 'samsung-clk-6.1' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      Merge tag 'v6.1-rockchip-clock1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'renesas-clk-for-v6.1-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'renesas-clk-for-v6.1-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-microchip-6.1' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-microchip
      Merge tag 'sunxi-clk-for-6.1-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'clk-imx-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'mtk-clk-for-6.1' of https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux into clk-mtk
      clk: clocking-wizard: Depend on HAS_IOMEM
      Merge tag 'qcom-clk-for-6.1' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      clk: qcom: gcc-sm6375: Ensure unsigned long type
      Merge branches 'clk-ofnode', 'clk-bindings', 'clk-cleanup', 'clk-zynq' and 'clk-xilinx' into clk-next
      Merge branches 'clk-samsung', 'clk-mtk', 'clk-rm', 'clk-ast' and 'clk-qcom' into clk-next
      Merge branches 'clk-rockchip', 'clk-renesas', 'clk-microchip', 'clk-allwinner' and 'clk-imx' into clk-next
      Merge branches 'clk-fixed-rate', 'clk-spreadtrum', 'clk-pxa' and 'clk-ti' into clk-next
      Merge branches 'clk-baikal', 'clk-broadcom', 'clk-vc5' and 'clk-versaclock' into clk-next

Taniya Das (5):
      dt-bindings: clock: Add "qcom,adsp-pil-mode" property
      dt-bindings: clock: Add resets for LPASS audio clock controller for SC7280
      dt-bindings: clock: Add support for external MCLKs for LPASS on SC7280
      clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon
      clk: qcom: lpass: Add support for resets & external mclk for SC7280

Wolfram Sang (5):
      clk: renesas: r8a779f0: Add SDH0 clock
      clk: renesas: r8a779f0: Add CMT clocks
      clk: renesas: r8a779f0: Add TMU and parent SASYNC clocks
      clk: move from strlcpy with unused retval to strscpy
      clk: renesas: r8a779f0: Add MSIOF clocks

Xiaoke Wang (1):
      clk: pxa: add a check for the return value of kzalloc()

Yang Yingliang (5):
      clk: sunxi-ng: sun8i-de2: Use dev_err_probe() helper
      clk: sunxi-ng: ccu-sun9i-a80-de: Use dev_err_probe() helper
      clk: sunxi-ng: ccu-sun9i-a80-usb: Use dev_err_probe() helper
      clk: davinci: cfgchip: Use dev_err_probe() helper
      clk: clocking-wizard: Use dev_err_probe() helper

Yassine Oudjana (8):
      clk: mediatek: gate: Export mtk_clk_register_gates_with_dev
      clk: mediatek: Use mtk_clk_register_gates_with_dev in simple probe
      clk: qcom: msm8996-cpu: Rename DIV_2_INDEX to SMUX_INDEX
      clk: qcom: msm8996-cpu: Statically define PLL dividers
      clk: qcom: msm8996-cpu: Unify cluster order
      clk: qcom: msm8996-cpu: Convert secondary muxes to clk_regmap_mux
      dt-bindings: clock: qcom,msm8996-apcc: Fix clocks
      clk: qcom: msm8996-cpu: Use parent_data/_hws for all clocks

Yihao Han (1):
      clk: clk-xgene: simplify if-if to if-else

Yuan Can (1):
      clk: clk-npcm7xx: Remove unused struct npcm7xx_clk_gate_data and npcm7xx_clk_div_fixed_data

ye xingchen (1):
      clk: mvebu: armada-37xx-tbg: Remove the unneeded result variable

 .../bindings/arm/mediatek/mediatek,infracfg.yaml   |    2 +
 .../bindings/arm/mediatek/mediatek,mmsys.yaml      |    1 +
 .../bindings/arm/mediatek/mediatek,pericfg.yaml    |    1 +
 .../bindings/clock/cirrus,cs2000-cp.yaml           |    1 -
 .../devicetree/bindings/clock/gpio-gate-clock.txt  |   21 -
 .../devicetree/bindings/clock/gpio-gate-clock.yaml |   42 +
 .../devicetree/bindings/clock/idt,versaclock5.yaml |    6 +-
 .../bindings/clock/mediatek,apmixedsys.yaml        |    1 +
 .../bindings/clock/mediatek,mt6795-clock.yaml      |   66 +
 .../bindings/clock/mediatek,mt6795-sys-clock.yaml  |   54 +
 .../bindings/clock/mediatek,mt8365-clock.yaml      |   42 +
 .../bindings/clock/mediatek,mt8365-sys-clock.yaml  |   47 +
 .../bindings/clock/mediatek,topckgen.yaml          |    1 +
 .../bindings/clock/microchip,mpfs-ccc.yaml         |   80 +
 ...rochip,mpfs.yaml => microchip,mpfs-clkcfg.yaml} |   19 +-
 .../devicetree/bindings/clock/qcom,a53pll.yaml     |    3 +-
 .../bindings/clock/qcom,gcc-apq8064.yaml           |    9 +
 .../bindings/clock/qcom,gcc-msm8660.yaml           |   54 +
 .../bindings/clock/qcom,gcc-msm8909.yaml           |   58 +
 .../bindings/clock/qcom,gcc-msm8916.yaml           |   66 +
 .../bindings/clock/qcom,gcc-msm8976.yaml           |   21 +-
 .../bindings/clock/qcom,gcc-msm8994.yaml           |   21 +-
 .../bindings/clock/qcom,gcc-msm8996.yaml           |   25 +-
 .../bindings/clock/qcom,gcc-msm8998.yaml           |   25 +-
 .../devicetree/bindings/clock/qcom,gcc-other.yaml  |    7 -
 .../bindings/clock/qcom,gcc-qcm2290.yaml           |   25 +-
 .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml |   25 +-
 .../devicetree/bindings/clock/qcom,gcc-sc7280.yaml |   21 +-
 .../bindings/clock/qcom,gcc-sc8180x.yaml           |   25 +-
 .../bindings/clock/qcom,gcc-sc8280xp.yaml          |   25 +-
 .../devicetree/bindings/clock/qcom,gcc-sdm845.yaml |   84 +-
 .../devicetree/bindings/clock/qcom,gcc-sdx55.yaml  |   21 +-
 .../devicetree/bindings/clock/qcom,gcc-sdx65.yaml  |   21 +-
 .../devicetree/bindings/clock/qcom,gcc-sm6115.yaml |   25 +-
 .../devicetree/bindings/clock/qcom,gcc-sm6125.yaml |   25 +-
 .../devicetree/bindings/clock/qcom,gcc-sm6350.yaml |   25 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8150.yaml |   25 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |   25 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8350.yaml |   21 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8450.yaml |   21 +-
 .../devicetree/bindings/clock/qcom,gpucc.yaml      |    2 +
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |  209 +-
 .../bindings/clock/qcom,msm8996-apcc.yaml          |   15 +-
 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |    2 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sm6115-dispcc.yaml         |   70 +
 .../devicetree/bindings/clock/qcom,sm6375-gcc.yaml |   52 +
 .../bindings/clock/qcom,sm8450-dispcc.yaml         |   98 +
 .../clock/renesas,rcar-usb2-clock-sel.yaml         |    2 -
 .../bindings/clock/renesas,rzg2l-cpg.yaml          |    2 +-
 .../bindings/clock/renesas,versaclock7.yaml        |   64 +
 .../bindings/clock/rockchip,px30-cru.yaml          |    2 +-
 .../bindings/clock/rockchip,rk3036-cru.yaml        |    2 +-
 .../bindings/clock/rockchip,rk3128-cru.txt         |   58 -
 ...ip,rk3036-cru.yaml => rockchip,rk3128-cru.yaml} |   34 +-
 .../bindings/clock/rockchip,rk3228-cru.yaml        |    2 +-
 .../bindings/clock/rockchip,rk3288-cru.yaml        |    2 +-
 .../bindings/clock/rockchip,rk3308-cru.yaml        |    2 +-
 .../bindings/clock/rockchip,rk3368-cru.yaml        |    2 +-
 .../bindings/clock/rockchip,rk3399-cru.yaml        |    2 +-
 .../bindings/clock/rockchip,rv1108-cru.yaml        |    2 +-
 .../bindings/clock/rockchip,rv1126-cru.yaml        |   62 +
 .../devicetree/bindings/clock/samsung,s2mps11.yaml |    1 -
 .../devicetree/bindings/clock/ti/gate.txt          |    2 +-
 .../devicetree/bindings/clock/ti/interface.txt     |    2 +-
 .../bindings/clock/xlnx,clocking-wizard.yaml       |   77 +
 .../devicetree/bindings/mfd/cirrus,lochnagar.yaml  |    2 +-
 MAINTAINERS                                        |   12 +-
 .../boot/dts/renesas/beacon-renesom-baseboard.dtsi |    2 +-
 .../arm64/boot/dts/renesas/beacon-renesom-som.dtsi |    2 +-
 drivers/clk/Kconfig                                |   11 +-
 drivers/clk/Makefile                               |    1 +
 drivers/clk/at91/dt-compat.c                       |  108 +-
 drivers/clk/at91/sama5d2.c                         |   10 +
 drivers/clk/baikal-t1/Kconfig                      |   12 +-
 drivers/clk/baikal-t1/Makefile                     |    1 +
 drivers/clk/baikal-t1/ccu-div.c                    |   84 +-
 drivers/clk/baikal-t1/ccu-div.h                    |   17 +-
 drivers/clk/baikal-t1/ccu-pll.h                    |    8 +
 drivers/clk/baikal-t1/ccu-rst.c                    |  217 ++
 drivers/clk/baikal-t1/ccu-rst.h                    |   67 +
 drivers/clk/baikal-t1/clk-ccu-div.c                |  260 +-
 drivers/clk/baikal-t1/clk-ccu-pll.c                |  123 +-
 drivers/clk/bcm/clk-bcm2835.c                      |   43 +-
 drivers/clk/bcm/clk-raspberrypi.c                  |   11 +
 drivers/clk/berlin/bg2.c                           |    5 +-
 drivers/clk/berlin/bg2q.c                          |    6 +-
 drivers/clk/clk-asm9260.c                          |   29 +-
 drivers/clk/clk-ast2600.c                          |    2 +-
 drivers/clk/clk-fixed-rate.c                       |   28 +-
 drivers/clk/clk-lan966x.c                          |    2 +-
 drivers/clk/clk-lochnagar.c                        |    2 +-
 drivers/clk/clk-nomadik.c                          |    5 +-
 drivers/clk/clk-npcm7xx.c                          |   29 -
 drivers/clk/clk-oxnas.c                            |    6 +-
 drivers/clk/clk-qoriq.c                            |   10 +-
 drivers/clk/clk-versaclock5.c                      |  163 +-
 drivers/clk/clk-versaclock7.c                      | 1311 ++++++++++
 drivers/clk/clk-xgene.c                            |    4 +-
 drivers/clk/clk.c                                  |   31 +-
 drivers/clk/clkdev.c                               |   60 +-
 drivers/clk/davinci/Makefile                       |    4 -
 drivers/clk/davinci/da8xx-cfgchip.c                |    3 +-
 drivers/clk/davinci/pll-dm644x.c                   |   81 -
 drivers/clk/davinci/pll-dm646x.c                   |   85 -
 drivers/clk/davinci/pll.c                          |   10 +-
 drivers/clk/davinci/pll.h                          |    6 -
 drivers/clk/davinci/psc-dm644x.c                   |   85 -
 drivers/clk/davinci/psc-dm646x.c                   |   82 -
 drivers/clk/davinci/psc.c                          |    6 -
 drivers/clk/davinci/psc.h                          |    6 -
 drivers/clk/imx/Makefile                           |    1 +
 drivers/clk/imx/clk-composite-93.c                 |  171 +-
 drivers/clk/imx/clk-gate-93.c                      |  199 ++
 drivers/clk/imx/clk-imx8mp.c                       |    2 +-
 drivers/clk/imx/clk-imx93.c                        |   30 +-
 drivers/clk/imx/clk-scu.c                          |    6 +-
 drivers/clk/imx/clk.h                              |    9 +-
 drivers/clk/mediatek/Kconfig                       |   87 +
 drivers/clk/mediatek/Makefile                      |   13 +
 drivers/clk/mediatek/clk-apmixed.c                 |   12 +-
 drivers/clk/mediatek/clk-cpumux.c                  |    2 +
 drivers/clk/mediatek/clk-gate.c                    |    1 +
 drivers/clk/mediatek/clk-mt2701-bdp.c              |   36 +-
 drivers/clk/mediatek/clk-mt2701-img.c              |   36 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c             |   36 +-
 drivers/clk/mediatek/clk-mt2712-bdp.c              |   34 +-
 drivers/clk/mediatek/clk-mt2712-img.c              |   34 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c           |   34 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c              |   34 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c             |   34 +-
 drivers/clk/mediatek/clk-mt2712-venc.c             |   34 +-
 drivers/clk/mediatek/clk-mt6765-audio.c            |   34 +-
 drivers/clk/mediatek/clk-mt6765-cam.c              |   33 +-
 drivers/clk/mediatek/clk-mt6765-img.c              |   33 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c           |   34 +-
 drivers/clk/mediatek/clk-mt6765-mm.c               |   33 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c           |   34 +-
 drivers/clk/mediatek/clk-mt6779-aud.c              |   29 +-
 drivers/clk/mediatek/clk-mt6779-cam.c              |   29 +-
 drivers/clk/mediatek/clk-mt6779-img.c              |   29 +-
 drivers/clk/mediatek/clk-mt6779-ipe.c              |   29 +-
 drivers/clk/mediatek/clk-mt6779-mfg.c              |   27 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c             |   29 +-
 drivers/clk/mediatek/clk-mt6779-venc.c             |   29 +-
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c       |  157 ++
 drivers/clk/mediatek/clk-mt6795-infracfg.c         |  151 ++
 drivers/clk/mediatek/clk-mt6795-mfg.c              |   50 +
 drivers/clk/mediatek/clk-mt6795-mm.c               |  132 +
 drivers/clk/mediatek/clk-mt6795-pericfg.c          |  160 ++
 drivers/clk/mediatek/clk-mt6795-topckgen.c         |  610 +++++
 drivers/clk/mediatek/clk-mt6795-vdecsys.c          |   55 +
 drivers/clk/mediatek/clk-mt6795-vencsys.c          |   50 +
 drivers/clk/mediatek/clk-mt6797-img.c              |   36 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c             |   36 +-
 drivers/clk/mediatek/clk-mt6797-venc.c             |   36 +-
 drivers/clk/mediatek/clk-mt8183-cam.c              |   27 +-
 drivers/clk/mediatek/clk-mt8183-img.c              |   27 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c             |   27 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c             |   27 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c          |   27 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c         |   27 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c           |   35 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c             |   27 +-
 drivers/clk/mediatek/clk-mt8183-venc.c             |   27 +-
 drivers/clk/mediatek/clk-mt8183.c                  |   28 +
 drivers/clk/mediatek/clk-mt8192-cam.c              |    1 +
 drivers/clk/mediatek/clk-mt8192-img.c              |    1 +
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c     |    1 +
 drivers/clk/mediatek/clk-mt8192-ipe.c              |    1 +
 drivers/clk/mediatek/clk-mt8192-mdp.c              |    1 +
 drivers/clk/mediatek/clk-mt8192-mfg.c              |    7 +-
 drivers/clk/mediatek/clk-mt8192-msdc.c             |    1 +
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c         |    1 +
 drivers/clk/mediatek/clk-mt8192-vdec.c             |    1 +
 drivers/clk/mediatek/clk-mt8192-venc.c             |    1 +
 drivers/clk/mediatek/clk-mt8192.c                  |  234 +-
 drivers/clk/mediatek/clk-mt8195-infra_ao.c         |   16 +-
 drivers/clk/mediatek/clk-mt8195-mfg.c              |    6 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |   46 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c             |    7 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c             |   17 +-
 drivers/clk/mediatek/clk-mt8365-apu.c              |   55 +
 drivers/clk/mediatek/clk-mt8365-cam.c              |   57 +
 drivers/clk/mediatek/clk-mt8365-mfg.c              |   63 +
 drivers/clk/mediatek/clk-mt8365-mm.c               |  112 +
 drivers/clk/mediatek/clk-mt8365-vdec.c             |   63 +
 drivers/clk/mediatek/clk-mt8365-venc.c             |   52 +
 drivers/clk/mediatek/clk-mt8365.c                  | 1155 +++++++++
 drivers/clk/mediatek/clk-mtk.c                     |   52 +-
 drivers/clk/mediatek/clk-mtk.h                     |    3 +
 drivers/clk/mediatek/clk-mux.c                     |   38 +
 drivers/clk/mediatek/clk-mux.h                     |   15 +
 drivers/clk/mediatek/reset.c                       |    1 +
 drivers/clk/meson/meson-aoclk.c                    |    5 +-
 drivers/clk/meson/meson-eeclk.c                    |    5 +-
 drivers/clk/meson/meson8b.c                        |    5 +-
 drivers/clk/microchip/Kconfig                      |    1 +
 drivers/clk/microchip/Makefile                     |    1 +
 drivers/clk/microchip/clk-mpfs-ccc.c               |  290 +++
 drivers/clk/microchip/clk-mpfs.c                   |  375 ++-
 drivers/clk/mmp/clk-of-pxa168.c                    |  113 +-
 drivers/clk/mvebu/armada-37xx-tbg.c                |    6 +-
 drivers/clk/mvebu/dove-divider.c                   |    2 +-
 drivers/clk/nxp/clk-lpc18xx-cgu.c                  |    2 +-
 drivers/clk/pistachio/clk.h                        |    4 +-
 drivers/clk/pxa/clk-pxa.c                          |    2 +
 drivers/clk/qcom/Kconfig                           |   47 +-
 drivers/clk/qcom/Makefile                          |    5 +
 drivers/clk/qcom/a53-pll.c                         |    4 +-
 drivers/clk/qcom/apss-ipq-pll.c                    |   33 +-
 drivers/clk/qcom/apss-ipq6018.c                    |   15 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |   66 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    8 +-
 drivers/clk/qcom/clk-cpu-8996.c                    |  329 +--
 drivers/clk/qcom/clk-rcg.h                         |    1 +
 drivers/clk/qcom/clk-rcg2.c                        |    7 +
 drivers/clk/qcom/clk-rpmh.c                        |   25 +-
 drivers/clk/qcom/clk-smd-rpm.c                     |   83 +-
 drivers/clk/qcom/dispcc-sm6115.c                   |  608 +++++
 drivers/clk/qcom/dispcc-sm8450.c                   | 1829 +++++++++++++
 drivers/clk/qcom/gcc-msm8660.c                     |  330 ++-
 drivers/clk/qcom/gcc-msm8909.c                     | 2731 ++++++++++++++++++++
 drivers/clk/qcom/gcc-msm8916.c                     | 1020 ++++----
 drivers/clk/qcom/gcc-msm8939.c                     |  552 ++--
 drivers/clk/qcom/gcc-msm8960.c                     |  436 ++--
 drivers/clk/qcom/gcc-qcm2290.c                     |   56 +-
 drivers/clk/qcom/gcc-sc7180.c                      |    2 +-
 drivers/clk/qcom/gcc-sc7280.c                      |    6 +-
 drivers/clk/qcom/gcc-sc8280xp.c                    |   20 +-
 drivers/clk/qcom/gcc-sdm660.c                      |    2 +-
 drivers/clk/qcom/gcc-sdm845.c                      |  400 ++-
 drivers/clk/qcom/gcc-sm6115.c                      |   48 +-
 drivers/clk/qcom/gcc-sm6350.c                      |    2 +-
 drivers/clk/qcom/{gcc-sm6115.c => gcc-sm6375.c}    | 2243 +++++++++-------
 drivers/clk/qcom/gdsc.c                            |   35 +-
 drivers/clk/qcom/gdsc.h                            |    5 +
 drivers/clk/qcom/gpucc-sc8280xp.c                  |  461 ++++
 drivers/clk/qcom/kpss-xcc.c                        |   26 +-
 drivers/clk/qcom/lcc-ipq806x.c                     |   84 +-
 drivers/clk/qcom/lcc-msm8960.c                     |  211 +-
 drivers/clk/qcom/lpassaudiocc-sc7280.c             |   66 +-
 drivers/clk/qcom/lpasscc-sc7280.c                  |   44 -
 drivers/clk/qcom/lpasscorecc-sc7280.c              |   33 +
 drivers/clk/qcom/mmcc-msm8960.c                    |  454 ++--
 drivers/clk/qcom/reset.c                           |    4 +-
 drivers/clk/qcom/reset.h                           |    1 +
 drivers/clk/renesas/r8a779f0-cpg-mssr.c            |   21 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c            |   14 +
 drivers/clk/renesas/r9a07g044-cpg.c                |    2 +
 drivers/clk/renesas/r9a09g011-cpg.c                |    4 +
 drivers/clk/rockchip/Kconfig                       |    7 +
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk-rv1126.c                  | 1138 ++++++++
 drivers/clk/rockchip/clk.c                         |   27 +-
 drivers/clk/rockchip/clk.h                         |   36 +
 drivers/clk/samsung/clk-exynos-clkout.c            |    6 +-
 drivers/clk/samsung/clk-exynos7885.c               |  207 +-
 drivers/clk/samsung/clk-exynos850.c                |  682 ++++-
 drivers/clk/samsung/clk-exynosautov9.c             |  401 ++-
 drivers/clk/sprd/Kconfig                           |    6 +
 drivers/clk/sprd/Makefile                          |    1 +
 drivers/clk/sprd/common.c                          |    9 +-
 drivers/clk/sprd/ums512-clk.c                      | 2202 ++++++++++++++++
 drivers/clk/st/clkgen-fsyn.c                       |    5 +-
 drivers/clk/st/clkgen-mux.c                        |    5 +-
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c               |    8 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |   28 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c            |   19 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c           |    9 +-
 drivers/clk/tegra/clk-bpmp.c                       |    2 +-
 drivers/clk/tegra/clk-tegra114.c                   |    1 +
 drivers/clk/tegra/clk-tegra124.c                   |    1 +
 drivers/clk/tegra/clk-tegra20.c                    |    1 +
 drivers/clk/tegra/clk-tegra210.c                   |    1 +
 drivers/clk/tegra/clk-tegra30.c                    |    1 +
 drivers/clk/ti/clk-dra7-atl.c                      |    9 +-
 drivers/clk/ti/clk.c                               |    5 +-
 drivers/clk/xilinx/Kconfig                         |   12 +
 drivers/clk/xilinx/Makefile                        |    1 +
 .../xilinx}/clk-xlnx-clock-wizard.c                |   35 +-
 drivers/clk/zynqmp/clkc.c                          |   19 +-
 drivers/clk/zynqmp/divider.c                       |    9 +-
 drivers/clk/zynqmp/pll.c                           |   31 +-
 drivers/reset/Kconfig                              |    7 +
 drivers/reset/Makefile                             |    2 +-
 drivers/reset/reset-mpfs.c                         |  157 ++
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/clocking-wizard/Kconfig            |   10 -
 drivers/staging/clocking-wizard/Makefile           |    2 -
 drivers/staging/clocking-wizard/TODO               |   13 -
 drivers/staging/clocking-wizard/dt-binding.txt     |   30 -
 include/dt-bindings/clock/imx93-clock.h            |    9 +-
 include/dt-bindings/{clk => clock}/lochnagar.h     |    0
 include/dt-bindings/clock/marvell,pxa168.h         |    6 +
 include/dt-bindings/clock/mediatek,mt6795-clk.h    |  275 ++
 include/dt-bindings/clock/mediatek,mt8365-clk.h    |  373 +++
 include/dt-bindings/clock/microchip,mpfs-clock.h   |   23 +
 include/dt-bindings/clock/mt8195-clk.h             |    4 +-
 include/dt-bindings/clock/qcom,gcc-msm8909.h       |  218 ++
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |    1 +
 include/dt-bindings/clock/qcom,gpucc-sc8280xp.h    |   35 +
 include/dt-bindings/clock/qcom,lcc-ipq806x.h       |    2 +
 include/dt-bindings/clock/qcom,rpmcc.h             |    1 +
 include/dt-bindings/clock/qcom,sm6115-dispcc.h     |   36 +
 include/dt-bindings/clock/qcom,sm6375-gcc.h        |  234 ++
 include/dt-bindings/clock/qcom,sm8450-dispcc.h     |  103 +
 include/dt-bindings/clock/rockchip,rv1126-cru.h    |  632 +++++
 include/dt-bindings/{clk => clock}/versaclock.h    |    0
 include/dt-bindings/reset/bt1-ccu.h                |    9 +
 include/dt-bindings/reset/mediatek,mt6795-resets.h |   53 +
 include/dt-bindings/reset/mt8195-resets.h          |    3 +
 include/linux/clk-provider.h                       |   66 +-
 include/linux/clk/davinci.h                        |    8 -
 include/linux/clkdev.h                             |    2 -
 include/linux/soc/qcom/smd-rpm.h                   |    1 +
 include/soc/microchip/mpfs.h                       |    8 +
 318 files changed, 25012 insertions(+), 5338 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
