Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFB46A2747
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 05:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBYEpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 23:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBYEpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 23:45:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD57B6A7A4;
        Fri, 24 Feb 2023 20:45:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B748160A0B;
        Sat, 25 Feb 2023 04:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22DBC433D2;
        Sat, 25 Feb 2023 04:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677300344;
        bh=eQ8pj5NFlhQ0gkkp7p9nCOsRvHGVbEW1afxrLUhiwgw=;
        h=From:To:Cc:Subject:Date:From;
        b=Ej3NzsFSYgOJYfV660qR8WocXss6LlFhNUDSMql4bhS0LYgvuLf68I4swMa5uPhT0
         rkFS/8+KAmdhJqqE4whfnx/9sF+Olo6figxJaI42B2qfD4SU//8waN5/nTWzqVNYJW
         z8X9sINUECoU6YrRBLczkGsGd6DbbTOZnD5ITW9tsGPV1g+VO03wkfCsGJylCFTF7D
         ZuuFCuw6xksG+ADbWCyeblZeDkbdgVH8+yI+g6QXUV5yW0w30Vz7b4vc2GXjEhD/9v
         XFCz3MBEKbXDzpQXfrAsQ/i3k8xIVHuhEhZ29RwC1/sdx8nDDQFOupBtITsFsIKQP+
         bmgFlgY64P6ww==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Fri, 24 Feb 2023 20:45:42 -0800
Message-Id: <20230225044543.502452-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8c8acefcee87957cb3564c7180e667f0403121f1:

  dt-bindings: clock: Add QDU1000 and QRU1000 GCC clocks (2023-01-18 20:46:43 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to b64baafa24d2c430513329daf5ebb821620d0c03:

  Merge branches 'clk-loongson' and 'clk-qcom' into clk-next (2023-02-23 11:04:25 -0800)

----------------------------------------------------------------
We have one small patch to the clk core this time around. It fixes a corner
case with the CLK_OPS_PARENT_ENABLE flag combined with clk_core_is_enabled()
where it hangs the system. We'll simply assume the clk is disabled if the
parent is disabled and the flag is set. Trying to turn on the parent to check
the enable state of the clk runs into system hangs at boot. We let this bake in
-next for a couple weeks to make sure there aren't any more issues because the
last attempt to fix this ran into hangs and had to be reverted.

Note: There were some more patches to the core framework around sync_state and
disabling unused clks, but I asked for that to be reverted from the qcom PR
because it isn't ready and we're still discussing the best solution on the
list.

Outside of the core clk framework, we have the usual collection of clk driver
updates and support for new SoCs (which seems to never stop). The dirstat is
dominated by Qualcomm because they added support for quite a few SoCs this time
around and also migrated quite a few of their drivers to clk_parent_data. The
other big diff is in the Mediatek clk drivers that saw a significant rework
this cycle to similarly modernize the code, and we'll see that work continue in
the next cycle as well. Nothing really jumps out as scary here, except that the
significant churn in parent data descriptions can have typos that go unnoticed.
More details below.

Core:
 - Honor CLK_OPS_PARENT_ENABLE in clk_core_is_enabled()

New Drivers:
 - Add a new clk-gpr-mux clock type and use it on i.MX6Q to add ENET ref
   clocks
 - Support for Mediatek MT7891 SoC clks
 - Support for many Qualcomm clk controllers:
   - QDU1000/QRU1000 global clock controller
   - SA8775P global clock controller
   - SM8550 TCSR and display clock controller
   - SM6350 clock controller
   - MSM8996 CBF and APCS clock controllers

Updates:
 - Various cleanups and improvements to Mediatek clk drivers to reduce
   code size and modernize the drivers
 - Support for Versa 5P49V60 clks
 - Disable R-Car H3 ES1.*, as it was only available to an internal
   development group and needed a lot of quirks and workarounds
 - Add PWM, Compare-Match Timer (TIM), USB, SDHI, and eMMC clocks and
   resets on Renesas RZ/V2M
 - Add display clocks on Renesas R-Car V4H
 - Add Camera Receiving Unit (CRU) clocks and resets on Renesas RZ/G2L
 - Free the imx_uart_clocks even if imx_register_uart_clocks returns early
 - Get the stdout clocks count from device tree on i.MX
 - Drop the clock count argument from imx_register_uart_clocks()
 - Keep the uart clocks on i.MX93 for when earlycon is used
 - Fix SPDX comment in i.MX6SLL clocks bindings header
 - Drop some unnecessary spaces from i.MX8ULP clocks bindings header
 - Add imx_obtain_fixed_of_clock() for allowing to add a clock that is
   not configured via devicetree
 - Fix the ENET1 gate configuration for i.MX6UL according to the
   reference manual
 - Add ENET refclock mux support for i.MX6UL
 - Add support for USB host/device configuration on Renesas RZ/N1
 - Add PLL2 programming support, and CAN-FD clocks on Renesas R-Car V4H
 - Add D1 CAN bus gates and resets for Allwinner
 - Mark D1 CPUX clock as critical on Allwinner
 - Reuse D1 driver for Allwinner R528/T113
 - Cleanup sunxi-ng Kconfig
 - Fix sunxi-ng kernel-doc issues
 - Model Allwinner H3/H5 DRAM clock as fixed clock
 - Use .determine_rate() instead of .round_rate() for the dualdiv, mpll,
   sclk-div and cpu-dyn-div amlogic clock drivers
 - DDR clocks were marked as critical in the proper clock driver for each
   AT91 SoC such that drivers/memory/atmel-sdramc.c to be deleted
   in the next releases as it only does clock enablement
 - Patch to avoid compiling dt-compat.o for all AT91 SoCs as only some of
   them may use it
 - Support synchronous power_off requests in the qcom GDSC driver for proper
   GPU power collapse
 - Drop test clocks from various Qualcomm clk drivers
 - Update parent references to use clk_parent_data/clk_hw in various Qualcomm clk drivers
 - Fixes for the Qualcomm MSM8996 CPU clock controller
 - Transition Qualcomm MSM8974 GCC off the externally defined sleep_clk
 - Add GDSCs in the global clock controller for Qualcomm QCS404
 - The SDCC core clocks on Qualcomm SM6115 are moved to floor_ops
 - Programming of clk_dis_wait for GPU CX GDSC on Qualcomm SC7180 and SDM845 are
   moved to use the recently introduced properties in the GDSC struct
 - Qualcomm's RPMh clock driver gains SM8550 and SA8775P clocks, and the IPA clock
   is added on a variety of platforms
 - De-duplicate identical clks in Qualcomm SMD RPM clk driver
 - Add a few missing clocks across msm8998, msm8992, msm8916, qcs404 to
   Qualcomm SDM RPM clk driver
 - Various Qualcomm clk drivers use devm_pm_runtime_enable() to simplify

----------------------------------------------------------------
Abel Vesa (7):
      dt-bindings: clock: Add SM8550 TCSR CC clocks
      dt-bindings: clock: Add RPMHCC for SM8550
      clk: qcom: rpmh: Add support for SM8550 rpmh clocks
      clk: qcom: Add TCSR clock driver for SM8550
      clk: Add generic sync_state callback for disabling unused clocks
      clk: qcom: sdm845: Use generic clk_sync_state_disable_unused callback
      MAINTAINERS: clk: imx: Add Peng Fan as reviewer

Akhil P Oommen (1):
      clk: qcom: gdsc: Support 'synced_poweroff' genpd flag

Alain Volmat (1):
      dt-bindings: clock: remove stih416 bindings

Alexey Khoroshilov (1):
      clk: renesas: cpg-mssr: Fix use after free if cpg_mssr_common_init() failed

András Szemző (1):
      clk: sunxi-ng: d1: Mark cpux clock as critical

AngeloGioacchino Del Regno (23):
      clk: mediatek: mt8192: Correctly unregister and free clocks on failure
      clk: mediatek: mt8192: Propagate struct device for gate clocks
      clk: mediatek: clk-gate: Propagate struct device with mtk_clk_register_gates()
      clk: mediatek: cpumux: Propagate struct device where possible
      clk: mediatek: clk-mtk: Propagate struct device for composites
      clk: mediatek: clk-mux: Propagate struct device for mtk-mux
      clk: mediatek: clk-mtk: Add dummy clock ops
      clk: mediatek: mt8173: Migrate to platform driver and common probe
      clk: mediatek: mt8173: Remove mtk_clk_enable_critical()
      clk: mediatek: mt8173: Break down clock drivers and allow module build
      clk: mediatek: Switch to mtk_clk_simple_probe() where possible
      clk: mediatek: clk-mtk: Extend mtk_clk_simple_probe()
      clk: mediatek: mt8173: Migrate pericfg/topckgen to mtk_clk_simple_probe()
      clk: mediatek: clk-mt8192: Move CLK_TOP_CSW_F26M_D2 in top_divs
      clk: mediatek: mt8192: Join top_adj_divs and top_muxes
      clk: mediatek: mt8186: Join top_adj_div and top_muxes
      clk: mediatek: clk-mt8183: Join top_aud_muxes and top_aud_divs
      clk: mediatek: clk-mtk: Register MFG notifier in mtk_clk_simple_probe()
      clk: mediatek: clk-mt8192: Migrate topckgen to mtk_clk_simple_probe()
      clk: mediatek: clk-mt8186-topckgen: Migrate to mtk_clk_simple_probe()
      clk: mediatek: clk-mt6795-topckgen: Migrate to mtk_clk_simple_probe()
      clk: mediatek: clk-mt7986-topckgen: Properly keep some clocks enabled
      clk: mediatek: clk-mt7986-topckgen: Migrate to mtk_clk_simple_probe()

Arnd Bergmann (3):
      clk: qcom: rpmh: remove duplicate IPA clock reference
      clk: qcom: gcc-qcs404: fix duplicate initializer warning
      clk: imx: fix compile testing imxrt1050

Bartosz Golaszewski (5):
      dt-bindings: clock: qcom-rpmhcc: document the clock for sa8775p
      clk: qcom: rpmh: add clocks for sa8775p
      dt-bindings: clock: Add Qualcomm SA8775P GCC
      clk: qcom: gcc-sa8775p: remove unused variables
      dt-bindings: clock: qcom,sa8775p-gcc: add the power-domains property

Biju Das (3):
      clk: renesas: r9a09g011: Add PWM clock and reset entries
      clk: renesas: r9a09g011: Add TIM clock and reset entries
      clk: renesas: r9a09g011: Add USB clock and reset entries

Bjorn Andersson (6):
      Merge tag '1672656511-1931-1-git-send-email-quic_akhilpo@quicinc.com' into clk-for-6.3
      Merge branch '20230104093450.3150578-2-abel.vesa@linaro.org' into clk-for-6.3
      clk: qcom: Remove need for clk_ignore_unused on sc8280xp
      Merge branch '20230103-topic-sm8550-upstream-dispcc-v3-1-8a03d348c572@linaro.org' into clk-for-6.3
      Merge branch '20230112204446.30236-2-quic_molvera@quicinc.com' into HEAD
      clk: qcom: Revert sync_state based clk_disable_unused

Bryan O'Donoghue (1):
      clk: qcom: smd-rpm: msm8936: Add PMIC gated RPM_SMD_XO_*

Chen-Yu Tsai (1):
      clk: Honor CLK_OPS_PARENT_ENABLE in clk_core_is_enabled()

Cixi Geng (1):
      clk: sprd: Add dependency for SPRD_UMS512_CLK

Claudiu Beznea (2):
      clk: at91: mark ddr clocks as critical
      clk: at91: do not compile dt-compat.c for sama7g5 and sam9x60

Daniel Golle (3):
      dt-bindings: clock: Add compatibles for MT7981
      dt-bindings: clock: mediatek: add mt7981 clock IDs
      clk: mediatek: add MT7981 clock support

Dmitry Baryshkov (100):
      dt-bindings: clock: qcom: gcc-qcs404: add two GDSC entries
      dt-bindings: clock: qcom: gcc-qcs404: switch to gcc.yaml
      dt-bindings: clock: qcom: gcc-qcs404: define clocks/clock-names for QCS404
      clk: qcom: gcc-qcs404: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-qcs404: disable gpll[04]_out_aux parents
      clk: qcom: gcc-qcs404: fix names of the DSI clocks used as parents
      clk: qcom: gcc-qcs404: fix the name of the HDMI PLL clock
      clk: qcom: gcc-qcs404: get rid of the test clock
      clk: qcom: gcc-qcs404: move PLL clocks up
      clk: qcom: gcc-qcs404: use parent_hws/_data instead of parent_names
      clk: qcom: gcc-qcs404: sort out the cxo clock
      clk: qcom: gcc-qcs404: add support for GDSCs
      dt-bindings: clocks: qcom: rpmcc: add LN_BB_CLK_PIN clocks
      clk: qcom: smd-rpm: enable pin-controlled ln_bb_clk clocks on qcs404
      clk: qcom: smd-rpm: remove duplication between MMXI and MMAXI defines
      clk: qcom: smd-rpm: remove duplication between qcs404 and qcm2290 clocks
      clk: qcom: smd-rpm: add missing ln_bb_clkN clocks
      clk: qcom: smd-rpm: use msm8998_ln_bb_clk2 for qcm2290 SoC
      clk: qcom: smd-rpm: rename msm8992_ln_bb_* clocks to qcs404_ln_bb_*
      clk: qcom: smd-rpm: remove duplication between sm6375 and sm6125 clocks
      clk: qcom: smd-rpm: add XO_BUFFER clock for each XO_BUFFER_PINCTRL clock
      clk: qcom: smd-rpm: drop the rpm_status_id field
      clk: qcom: smd-rpm: fix alignment of line breaking backslashes
      clk: qcom: smd-rpm: move clock definitions together
      clk: qcom: smd-rpm: rename some msm8974 active-only clocks
      clk: qcom: smd-rpm: simplify XO_BUFFER clocks definitions
      clk: qcom: smd-rpm: simplify SMD_RPM/_BRANCH/_QDSS clock definitions
      clk: qcom: smd-rpm: rename SMD_RPM_BRANCH clock symbols
      clk: qcom: smd-rpm: rename the qcm2290 rf_clk3 clocks
      clk: qcom: smd-rpm: rename SMD_RPM_BUS clocks
      clk: qcom: smd-rpm: remove usage of platform name
      clk: qcom: dispcc-sm8450: switch to parent_hws
      clk: qcom: dispcc-sc7180: switch to parent_hws
      clk: qcom: dispcc-sm6375: switch to parent_hws
      clk: qcom: camcc-sc7280: switch to parent_hws
      clk: qcom: camcc-sm8450: switch to parent_hws
      clk: qcom: gcc-msm8939: switch to parent_hws
      clk: qcom: gcc-msm8976: switch to parent_hws
      clk: qcom: gcc-sc7180: switch to parent_hws
      clk: qcom: gcc-sc7280: switch to parent_hws
      clk: qcom: gcc-sdx65: switch to parent_hws
      clk: qcom: gcc-sm6375: switch to parent_hws
      clk: qcom: gcc-sm8250: switch to parent_hws
      clk: qcom: gcc-sm8450: switch to parent_hws
      clk: qcom: gcc-sm8550: switch to parent_hws
      clk: qcom: gpucc-msm8998: switch to parent_hws
      clk: qcom: gpucc-sc7180: switch to parent_hws
      clk: qcom: lpasscc-sc7180: switch to parent_hws
      clk: qcom: dispcc-sm8250: switch to devm_pm_runtime_enable
      clk: qcom: dispcc-sm8450: switch to devm_pm_runtime_enable
      clk: qcom: lpasscc-sc7280: switch to devm_pm_runtime_enable
      clk: qcom: videocc-sm8250: switch to devm_pm_runtime_enable
      clk: qcom: dispcc-sm6115: use parent_hws for disp_cc_mdss_rot_clk
      clk: qcom: gcc-sm6375: use parent_hws for gcc_disp_gpll0_div_clk_src
      clk: qcom: clk-spmi-pmic-div: convert to use parent_data
      dt-bindings: clock: qcom,gcc-msm8998: drop core_bi_pll_test_se
      dt-bindings: clock: qcom,gcc-sdx55: drop core_bi_pll_test_se
      dt-bindings: clock: qcom,gcc-sdx65: drop core_bi_pll_test_se
      dt-bindings: clock: qcom,mmcc-msm8998: drop core_bi_pll_test_se
      dt-bindings: clock: qcom: gcc-sm8350: drop test clock
      dt-bindings: clock: qcom: gcc-sm8450: drop test clock
      clk: qcom: dispcc-qcm2290: get rid of test clock
      clk: qcom: gcc-msm8998: get rid of test clock
      clk: qcom: gcc-sc7180: get rid of test clock
      clk: qcom: gcc-sdx55: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-sdx55: get rid of test clock
      clk: qcom: mmcc-msm8998: get rid of test clock
      clk: qcom: gcc-msm8974: switch from sleep_clk_src to sleep_clk
      clk: qcom: rpmh: define IPA clocks where required
      dt-bindings: clock: qcom,gcc-apq8084: define clocks/clock-names
      dt-bindings: clock: qcom,gcc-apq8084: add GCC_MMSS_GPLL0_CLK_SRC
      dt-bindings: clock: qcom,mmcc: define clocks/clock-names for APQ8084
      clk: qcom: gcc-apq8084: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-apq8084: move PLL clocks up
      clk: qcom: gcc-apq8084: use parent_hws/_data instead of parent_names
      clk: qcom: gcc-apq8084: add GCC_MMSS_GPLL0_CLK_SRC
      clk: qcom: mmcc-apq8084: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: mmcc-apq8084: move clock parent tables down
      clk: qcom: mmcc-apq8084: remove spdm clocks
      clk: qcom: mmcc-apq8084: use parent_hws/_data instead of parent_names
      dt-bindings: clock: qcom,msm8996-apcc: add sys_apcs_aux clock
      clk: qcom: clk-alpha-pll: program PLL_TEST/PLL_TEST_U if required
      clk: qcom: cpu-8996: correct PLL programming
      clk: qcom: cpu-8996: fix the init clock rate
      clk: qcom: cpu-8996: support using GPLL0 as SMUX input
      clk: qcom: cpu-8996: skip ACD init if the setup is valid
      clk: qcom: cpu-8996: simplify the cpu_clk_notifier_cb
      clk: qcom: cpu-8996: setup PLLs before registering clocks
      clk: qcom: cpu-8996: move qcom_cpu_clk_msm8996_acd_init call
      clk: qcom: cpu-8996: fix PLL configuration sequence
      clk: qcom: cpu-8996: fix ACD initialization
      clk: qcom: cpu-8996: fix PLL clock ops
      clk: qcom: cpu-8996: change setup sequence to follow vendor kernel
      clk: qcom: add the driver for the MSM8996 APCS clocks
      dt-bindings: clock: qcom,msm8996-cbf: Describe the MSM8996 CBF clock controller
      clk: qcom: add msm8996 Core Bus Framework (CBF) support
      clk: qcom: smd-rpm: provide RPM_SMD_XO_CLK_SRC on MSM8996 platform
      clk: qcom: gpucc-sc7180: fix clk_dis_wait being programmed for CX GDSC
      clk: qcom: gpucc-sdm845: fix clk_dis_wait being programmed for CX GDSC
      dt-bindings: clock: Merge qcom,gpucc-sm8350 into qcom,gpucc.yaml

Fabien Poussin (1):
      clk: sunxi-ng: d1: Add CAN bus gates and resets

Geert Uytterhoeven (5):
      clk: renesas: r8a779g0: Fix OSC predividers
      clk: renesas: rcar-gen4: Restore PLL enum sort order
      clk: renesas: cpg-mssr: Remove superfluous check in resume code
      clk: renesas: r8a779g0: Add custom clock for PLL2
      clk: renesas: r8a779g0: Add CAN-FD clocks

Herve Codina (1):
      clk: renesas: r9a06g032: Handle h2mode setting based on USBF presence

Kevin Groeneveld (1):
      clk: imx: pll14xx: fix recalc_rate for negative kdiv

Konrad Dybcio (5):
      clk: qcom: gcc-sm6115: Use floor_ops for SDCC1/2 core clk
      dt-bindings: clock: add QCOM SM6350 camera clock bindings
      clk: qcom: Add camera clock controller driver for SM6350
      arm64: dts: qcom: sm8250: Pad addresses to 8 hex digits
      clk: qcom: camcc-sm6350: Make camcc_sm6350_hws static

Krzysztof Kozlowski (9):
      dt-bindings: clock: qcom,gcc-sc8280xp: document power domain
      dt-bindings: clock: qcom,spmi-clkdiv: convert to DT schema
      dt-bindings: clock: qcom,gcc-sm8350: drop core_bi_pll_test_se input
      clk: gcc-sm8150: drop PLL test clock
      clk: gcc-sm8350: drop PLL test clock
      dt-bindings: clock: qcom,videocc: correct clocks per variant
      dt-bindings: clock: qcom,camcc-sm8250: extend clocks and power domains
      dt-bindings: clock: qcom,sm8450-camcc: constrain required-opps
      clk: qcom: cpu-8996: add missing cputype include

Kuninori Morimoto (2):
      clk: renesas: r8a779a0: Tidy up DMAC name on SYS-DMAC
      clk: renesas: r8a779g0: Tidy up DMAC name on SYS-DMAC

Lad Prabhakar (1):
      clk: renesas: r9a07g044: Add clock and reset entries for CRU

Lars-Peter Clausen (3):
      clk: vc5: Use `clamp()` to restrict PLL range
      clk: vc5: Add support for 5P49V60
      dt-bindings: clock: versaclock5: Document 5P49V60 compatible string

Marcel Ziswiler (2):
      clk: imx6sll: add proper spdx license identifier
      dt-bindings: imx8ulp: clock: no spaces before tabs

Marek Vasut (1):
      clk: rs9: Drop unused pin_xin field

Marijn Suijten (1):
      clk: qcom: dispcc-sm6125: Fix compatible string to match bindings

Martin Blumenstingl (4):
      clk: meson: mpll: Switch from .round_rate to .determine_rate
      clk: meson: dualdiv: switch from .round_rate to .determine_rate
      clk: meson: sclk-div: switch from .round_rate to .determine_rate
      clk: meson: clk-cpu-dyndiv: switch from .round_rate to .determine_rate

Moudy Ho (2):
      dt-bindings: arm: mediatek: migrate MT8195 vppsys0/1 to mtk-mmsys driver
      clk: mediatek: remove MT8195 vppsys/0/1 simple_probe

Neil Armstrong (3):
      dt-bindings: clock: document SM8550 DISPCC clock controller
      clk: qcom: clk-alpha-pll: define alias of LUCID OLE reset ops to EVO reset ops
      clk: qcom: add SM8550 DISPCC driver

Oleksij Rempel (5):
      clk: imx: add clk-gpr-mux driver
      clk: imx6q: add ethernet refclock mux support
      clk: imx: add imx_obtain_fixed_of_clock()
      clk: imx6ul: fix enet1 gate configuration
      clk: imx6ul: add ethernet refclock mux support

Paul E. McKenney (1):
      drivers/clk: Remove "select SRCU"

Peng Fan (5):
      dt-bindings: clock: imx8m-clock: correct i.MX8MQ node name
      clk: imx: avoid memory leak
      clk: imx: get stdout clk count from device tree
      clk: imx: remove clk_count of imx_register_uart_clocks
      clk: imx: imx93: invoke imx_register_uart_clocks

Phil Edworthy (1):
      clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries

Randy Dunlap (1):
      clk: sunxi-ng: fix ccu_mmc_timing.c kernel-doc issues

Robert Marko (1):
      clk: qcom: ipq8074: populate fw_name for usb3phy-s

Samuel Holland (6):
      clk: sunxi-ng: h3/h5: Model H3 CLK_DRAM as a fixed clock
      clk: sunxi-ng: Avoid computing the rate twice
      clk: sunxi-ng: Remove duplicate ARCH_SUNXI dependencies
      clk: sunxi-ng: Move SoC driver conditions to dependencies
      clk: sunxi-ng: d1: Allow building for R528/T113
      dt-bindings: clock: Add D1 CAN bus gates and resets

Sergio Paracuellos (1):
      clk: ralink: fix 'mt7621_gate_is_enabled()' function

Shazad Hussain (1):
      clk: qcom: add the GCC driver for sa8775p

Stephen Boyd (12):
      Merge tag 'renesas-clk-for-v6.3-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-meson-v6.3-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'clk-microchip-6.3' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-microchip
      Merge tag 'renesas-clk-for-v6.3-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-6.3-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'clk-imx-6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'renesas-clk-for-v6.3-tag3' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'qcom-clk-for-6.3-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      clk: qcom: apcs-msm8986: Include bitfield.h for FIELD_PREP
      Merge branches 'clk-cleanup', 'clk-bindings', 'clk-renesas', 'clk-versa' and 'clk-amlogic' into clk-next
      Merge branches 'clk-microchip', 'clk-allwinner', 'clk-mediatek', 'clk-imx' and 'clk-core' into clk-next
      Merge branches 'clk-loongson' and 'clk-qcom' into clk-next

Taniya Das (1):
      clk: qcom: Add QDU1000 and QRU1000 GCC support

Tom Rix (1):
      clk: imx: set imx_clk_gpr_mux_ops storage-class-specifier to static

Tomi Valkeinen (1):
      clk: renesas: r8a779g0: Add display related clocks

Ulf Hansson (1):
      PM: domains: Allow a genpd consumer to require a synced power off

Wolfram Sang (1):
      clk: renesas: rcar-gen3: Disable R-Car H3 ES1.*

Yang Li (1):
      clk: mediatek: clk-mtk: Remove unneeded semicolon

Yang Yingliang (1):
      clk: qcom: krait-cc: fix wrong pointer passed to IS_ERR()

Yinbo Zhu (2):
      dt-bindings: clock: add loongson-2 clock include file
      dt-bindings: clock: add loongson-2 clock

 .../bindings/arm/mediatek/mediatek,ethsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,infracfg.yaml   |    1 +
 .../arm/mediatek/mediatek,mt8195-clock.yaml        |   16 -
 .../bindings/arm/mediatek/mediatek,sgmiisys.txt    |    2 +
 .../devicetree/bindings/clock/idt,versaclock5.yaml |    1 +
 .../devicetree/bindings/clock/imx8m-clock.yaml     |    2 +-
 .../bindings/clock/loongson,ls2k-clk.yaml          |   63 +
 .../bindings/clock/mediatek,apmixedsys.yaml        |    1 +
 .../bindings/clock/mediatek,topckgen.yaml          |    1 +
 .../bindings/clock/qcom,camcc-sm8250.yaml          |   20 +-
 .../bindings/clock/qcom,gcc-apq8084.yaml           |   44 +
 .../bindings/clock/qcom,gcc-msm8998.yaml           |    6 +-
 .../devicetree/bindings/clock/qcom,gcc-qcs404.yaml |   38 +-
 .../bindings/clock/qcom,gcc-sc8280xp.yaml          |    7 +
 .../devicetree/bindings/clock/qcom,gcc-sdx55.yaml  |    9 +-
 .../devicetree/bindings/clock/qcom,gcc-sdx65.yaml  |    8 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8350.yaml |    2 -
 .../bindings/clock/qcom,gpucc-sm8350.yaml          |   71 -
 .../devicetree/bindings/clock/qcom,gpucc.yaml      |    2 +
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |   46 +-
 .../bindings/clock/qcom,msm8996-apcc.yaml          |    6 +-
 .../bindings/clock/qcom,msm8996-cbf.yaml           |   53 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    2 +
 .../bindings/clock/qcom,sa8775p-gcc.yaml           |   84 +
 .../bindings/clock/qcom,sm6350-camcc.yaml          |   49 +
 .../bindings/clock/qcom,sm8450-camcc.yaml          |    1 +
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |  105 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |   55 +
 .../devicetree/bindings/clock/qcom,spmi-clkdiv.txt |   59 -
 .../bindings/clock/qcom,spmi-clkdiv.yaml           |   71 +
 .../devicetree/bindings/clock/qcom,videocc.yaml    |   59 +-
 MAINTAINERS                                        |    8 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |    8 +-
 drivers/base/power/domain.c                        |   26 +
 drivers/clk/Kconfig                                |    1 -
 drivers/clk/at91/Makefile                          |   16 +-
 drivers/clk/at91/at91rm9200.c                      |    2 +-
 drivers/clk/at91/at91sam9260.c                     |    2 +-
 drivers/clk/at91/at91sam9g45.c                     |   10 +-
 drivers/clk/at91/at91sam9n12.c                     |   12 +-
 drivers/clk/at91/at91sam9rl.c                      |    2 +-
 drivers/clk/at91/at91sam9x5.c                      |   17 +-
 drivers/clk/at91/clk-peripheral.c                  |    8 +-
 drivers/clk/at91/clk-system.c                      |    4 +-
 drivers/clk/at91/dt-compat.c                       |   25 +-
 drivers/clk/at91/pmc.h                             |    4 +-
 drivers/clk/at91/sam9x60.c                         |   20 +-
 drivers/clk/at91/sama5d2.c                         |   22 +-
 drivers/clk/at91/sama5d3.c                         |   20 +-
 drivers/clk/at91/sama5d4.c                         |   22 +-
 drivers/clk/at91/sama7g5.c                         |    4 +-
 drivers/clk/clk-renesas-pcie.c                     |    1 -
 drivers/clk/clk-versaclock5.c                      |   28 +-
 drivers/clk/clk.c                                  |   11 +
 drivers/clk/imx/Kconfig                            |    2 +-
 drivers/clk/imx/Makefile                           |    1 +
 drivers/clk/imx/clk-gpr-mux.c                      |  119 +
 drivers/clk/imx/clk-imx25.c                        |    2 +-
 drivers/clk/imx/clk-imx27.c                        |    2 +-
 drivers/clk/imx/clk-imx35.c                        |    2 +-
 drivers/clk/imx/clk-imx5.c                         |    6 +-
 drivers/clk/imx/clk-imx6q.c                        |   15 +-
 drivers/clk/imx/clk-imx6sl.c                       |    2 +-
 drivers/clk/imx/clk-imx6sll.c                      |    2 +-
 drivers/clk/imx/clk-imx6sx.c                       |    2 +-
 drivers/clk/imx/clk-imx6ul.c                       |   33 +-
 drivers/clk/imx/clk-imx7d.c                        |    2 +-
 drivers/clk/imx/clk-imx7ulp.c                      |    4 +-
 drivers/clk/imx/clk-imx8mm.c                       |    2 +-
 drivers/clk/imx/clk-imx8mn.c                       |    2 +-
 drivers/clk/imx/clk-imx8mp.c                       |    2 +-
 drivers/clk/imx/clk-imx8mq.c                       |    2 +-
 drivers/clk/imx/clk-imx8ulp.c                      |    2 +-
 drivers/clk/imx/clk-imx93.c                        |    2 +
 drivers/clk/imx/clk-imxrt1050.c                    |    4 +
 drivers/clk/imx/clk-pfd.c                          |    2 +
 drivers/clk/imx/clk-pll14xx.c                      |    2 +-
 drivers/clk/imx/clk-pllv3.c                        |    2 +
 drivers/clk/imx/clk.c                              |   31 +-
 drivers/clk/imx/clk.h                              |   12 +-
 drivers/clk/mediatek/Kconfig                       |   49 +-
 drivers/clk/mediatek/Makefile                      |   10 +-
 drivers/clk/mediatek/clk-cpumux.c                  |    8 +-
 drivers/clk/mediatek/clk-cpumux.h                  |    2 +-
 drivers/clk/mediatek/clk-gate.c                    |   23 +-
 drivers/clk/mediatek/clk-gate.h                    |    7 +-
 drivers/clk/mediatek/clk-mt2701-aud.c              |   31 +-
 drivers/clk/mediatek/clk-mt2701-eth.c              |   36 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c              |   56 +-
 drivers/clk/mediatek/clk-mt2701-hif.c              |   38 +-
 drivers/clk/mediatek/clk-mt2701-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt2701.c                  |   24 +-
 drivers/clk/mediatek/clk-mt2712-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt2712.c                  |   99 +-
 drivers/clk/mediatek/clk-mt6765.c                  |   13 +-
 drivers/clk/mediatek/clk-mt6779-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt6779.c                  |   59 +-
 drivers/clk/mediatek/clk-mt6795-infracfg.c         |    6 +-
 drivers/clk/mediatek/clk-mt6795-mm.c               |    3 +-
 drivers/clk/mediatek/clk-mt6795-pericfg.c          |    6 +-
 drivers/clk/mediatek/clk-mt6795-topckgen.c         |   84 +-
 drivers/clk/mediatek/clk-mt6797-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt6797.c                  |    7 +-
 drivers/clk/mediatek/clk-mt7622-aud.c              |   54 +-
 drivers/clk/mediatek/clk-mt7622-eth.c              |   82 +-
 drivers/clk/mediatek/clk-mt7622-hif.c              |   85 +-
 drivers/clk/mediatek/clk-mt7622.c                  |   26 +-
 drivers/clk/mediatek/clk-mt7629-eth.c              |    7 +-
 drivers/clk/mediatek/clk-mt7629-hif.c              |   85 +-
 drivers/clk/mediatek/clk-mt7629.c                  |   22 +-
 drivers/clk/mediatek/clk-mt7981-apmixed.c          |  102 +
 drivers/clk/mediatek/clk-mt7981-eth.c              |  118 +
 drivers/clk/mediatek/clk-mt7981-infracfg.c         |  207 +
 drivers/clk/mediatek/clk-mt7981-topckgen.c         |  422 ++
 drivers/clk/mediatek/clk-mt7986-eth.c              |   10 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c         |    7 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c         |  100 +-
 drivers/clk/mediatek/clk-mt8135.c                  |   18 +-
 drivers/clk/mediatek/clk-mt8167-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt8167-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c           |    2 +-
 drivers/clk/mediatek/clk-mt8167-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c             |    3 +-
 drivers/clk/mediatek/clk-mt8167.c                  |   12 +-
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c       |  157 +
 drivers/clk/mediatek/clk-mt8173-img.c              |   55 +
 drivers/clk/mediatek/clk-mt8173-infracfg.c         |  155 +
 drivers/clk/mediatek/clk-mt8173-mm.c               |   22 +-
 drivers/clk/mediatek/clk-mt8173-pericfg.c          |  122 +
 drivers/clk/mediatek/clk-mt8173-topckgen.c         |  653 +++
 drivers/clk/mediatek/clk-mt8173-vdecsys.c          |   57 +
 drivers/clk/mediatek/clk-mt8173-vencsys.c          |   64 +
 drivers/clk/mediatek/clk-mt8173.c                  | 1125 -----
 drivers/clk/mediatek/clk-mt8183-audio.c            |   27 +-
 drivers/clk/mediatek/clk-mt8183-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt8183.c                  |  130 +-
 drivers/clk/mediatek/clk-mt8186-mcu.c              |    3 +-
 drivers/clk/mediatek/clk-mt8186-mm.c               |    3 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c         |  112 +-
 drivers/clk/mediatek/clk-mt8192-aud.c              |   30 +-
 drivers/clk/mediatek/clk-mt8192-mm.c               |    3 +-
 drivers/clk/mediatek/clk-mt8192.c                  |  182 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c       |    3 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |    9 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c             |    3 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c             |    3 +-
 drivers/clk/mediatek/clk-mt8195-vpp0.c             |   58 +-
 drivers/clk/mediatek/clk-mt8195-vpp1.c             |   58 +-
 drivers/clk/mediatek/clk-mt8365-mm.c               |    5 +-
 drivers/clk/mediatek/clk-mt8365.c                  |   14 +-
 drivers/clk/mediatek/clk-mt8516-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt8516.c                  |   12 +-
 drivers/clk/mediatek/clk-mtk.c                     |  136 +-
 drivers/clk/mediatek/clk-mtk.h                     |   35 +-
 drivers/clk/mediatek/clk-mux.c                     |   14 +-
 drivers/clk/mediatek/clk-mux.h                     |    3 +-
 drivers/clk/meson/clk-cpu-dyndiv.c                 |    9 +-
 drivers/clk/meson/clk-dualdiv.c                    |   21 +-
 drivers/clk/meson/clk-mpll.c                       |   20 +-
 drivers/clk/meson/sclk-div.c                       |   11 +-
 drivers/clk/qcom/Kconfig                           |   40 +
 drivers/clk/qcom/Makefile                          |    7 +-
 drivers/clk/qcom/apcs-msm8996.c                    |   89 +
 drivers/clk/qcom/camcc-sc7280.c                    |  268 +-
 drivers/clk/qcom/camcc-sm6350.c                    | 1906 ++++++++
 drivers/clk/qcom/camcc-sm8450.c                    |  324 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |    5 +
 drivers/clk/qcom/clk-alpha-pll.h                   |    1 +
 drivers/clk/qcom/clk-cbf-8996.c                    |  315 ++
 drivers/clk/qcom/clk-cpu-8996.c                    |  146 +-
 drivers/clk/qcom/clk-rpmh.c                        |   56 +
 drivers/clk/qcom/clk-smd-rpm.c                     | 1445 +++---
 drivers/clk/qcom/clk-spmi-pmic-div.c               |   10 +-
 drivers/clk/qcom/dispcc-qcm2290.c                  |    6 -
 drivers/clk/qcom/dispcc-sc7180.c                   |    8 +-
 drivers/clk/qcom/dispcc-sm6115.c                   |    4 +-
 drivers/clk/qcom/dispcc-sm6125.c                   |    2 +-
 drivers/clk/qcom/dispcc-sm6375.c                   |    4 +-
 drivers/clk/qcom/dispcc-sm8250.c                   |    9 +-
 drivers/clk/qcom/dispcc-sm8450.c                   |  221 +-
 drivers/clk/qcom/dispcc-sm8550.c                   | 1807 ++++++++
 drivers/clk/qcom/gcc-apq8084.c                     | 1024 +++--
 drivers/clk/qcom/gcc-ipq8074.c                     |    4 +-
 drivers/clk/qcom/gcc-msm8939.c                     |   32 +-
 drivers/clk/qcom/gcc-msm8974.c                     |   10 +-
 drivers/clk/qcom/gcc-msm8976.c                     |   30 +-
 drivers/clk/qcom/gcc-msm8998.c                     |   13 -
 drivers/clk/qcom/gcc-qcs404.c                      |  842 ++--
 drivers/clk/qcom/gcc-qdu1000.c                     | 2653 +++++++++++
 drivers/clk/qcom/gcc-sa8775p.c                     | 4785 ++++++++++++++++++++
 drivers/clk/qcom/gcc-sc7180.c                      |   19 +-
 drivers/clk/qcom/gcc-sc7280.c                      |   10 +-
 drivers/clk/qcom/gcc-sdx55.c                       |   64 +-
 drivers/clk/qcom/gcc-sdx65.c                       |  109 +-
 drivers/clk/qcom/gcc-sm6115.c                      |    4 +-
 drivers/clk/qcom/gcc-sm6375.c                      |  257 +-
 drivers/clk/qcom/gcc-sm8150.c                      |   17 -
 drivers/clk/qcom/gcc-sm8250.c                      |   10 +-
 drivers/clk/qcom/gcc-sm8350.c                      |   15 -
 drivers/clk/qcom/gcc-sm8450.c                      |  236 +-
 drivers/clk/qcom/gcc-sm8550.c                      |  252 +-
 drivers/clk/qcom/gdsc.c                            |   11 +-
 drivers/clk/qcom/gpucc-msm8998.c                   |    8 +-
 drivers/clk/qcom/gpucc-sc7180.c                    |   11 +-
 drivers/clk/qcom/gpucc-sdm845.c                    |    7 +-
 drivers/clk/qcom/krait-cc.c                        |    4 +-
 drivers/clk/qcom/lpasscc-sc7280.c                  |   10 +-
 drivers/clk/qcom/lpasscorecc-sc7180.c              |   20 +-
 drivers/clk/qcom/mmcc-apq8084.c                    | 1189 ++---
 drivers/clk/qcom/mmcc-msm8998.c                    |   25 -
 drivers/clk/qcom/tcsrcc-sm8550.c                   |  192 +
 drivers/clk/qcom/videocc-sm8250.c                  |    9 +-
 drivers/clk/ralink/clk-mt7621.c                    |   10 +-
 drivers/clk/renesas/Kconfig                        |    2 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |  126 +-
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |    4 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c            |   37 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |   28 +
 drivers/clk/renesas/r9a07g044-cpg.c                |   26 +-
 drivers/clk/renesas/r9a09g011-cpg.c                |   73 +
 drivers/clk/renesas/rcar-gen3-cpg.c                |   17 +-
 drivers/clk/renesas/rcar-gen4-cpg.c                |  156 +
 drivers/clk/renesas/rcar-gen4-cpg.h                |    3 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |   35 +-
 drivers/clk/renesas/renesas-cpg-mssr.h             |   14 -
 drivers/clk/sprd/Kconfig                           |    2 +
 drivers/clk/sunxi-ng/Kconfig                       |   71 +-
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c               |   13 +-
 drivers/clk/sunxi-ng/ccu-sun20i-d1.h               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |   15 +-
 drivers/clk/sunxi-ng/ccu_mmc_timing.c              |    8 +-
 drivers/clk/sunxi-ng/ccu_mp.c                      |   11 +-
 drivers/clk/sunxi-ng/ccu_nk.c                      |    9 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                     |   10 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |   10 +-
 drivers/clk/sunxi-ng/ccu_nm.c                      |    9 +-
 include/dt-bindings/clock/imx6qdl-clock.h          |    4 +-
 include/dt-bindings/clock/imx6sll-clock.h          |    2 +-
 include/dt-bindings/clock/imx6ul-clock.h           |    7 +-
 include/dt-bindings/clock/imx8ulp-clock.h          |    4 +-
 include/dt-bindings/clock/loongson,ls2k-clk.h      |   29 +
 include/dt-bindings/clock/mediatek,mt7981-clk.h    |  215 +
 include/dt-bindings/clock/qcom,gcc-apq8084.h       |    1 +
 include/dt-bindings/clock/qcom,gcc-qcs404.h        |    4 +
 include/dt-bindings/clock/qcom,gcc-sm8350.h        |    1 -
 include/dt-bindings/clock/qcom,gcc-sm8450.h        |    1 -
 include/dt-bindings/clock/qcom,rpmcc.h             |    2 +
 include/dt-bindings/clock/qcom,sa8775p-gcc.h       |  320 ++
 include/dt-bindings/clock/qcom,sm6350-camcc.h      |  109 +
 include/dt-bindings/clock/qcom,sm8550-dispcc.h     |  101 +
 include/dt-bindings/clock/qcom,sm8550-tcsr.h       |   18 +
 include/dt-bindings/clock/stih416-clks.h           |   17 -
 include/dt-bindings/clock/sun20i-d1-ccu.h          |    2 +
 include/dt-bindings/reset/sun20i-d1-ccu.h          |    2 +
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |    6 +-
 include/linux/pm_domain.h                          |    5 +
 include/linux/soc/qcom/smd-rpm.h                   |    1 -
 257 files changed, 20454 insertions(+), 6317 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,msm8996-cbf.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,spmi-clkdiv.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,spmi-clkdiv.yaml
 create mode 100644 drivers/clk/imx/clk-gpr-mux.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-vdecsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-vencsys.c
 delete mode 100644 drivers/clk/mediatek/clk-mt8173.c
 create mode 100644 drivers/clk/qcom/apcs-msm8996.c
 create mode 100644 drivers/clk/qcom/camcc-sm6350.c
 create mode 100644 drivers/clk/qcom/clk-cbf-8996.c
 create mode 100644 drivers/clk/qcom/dispcc-sm8550.c
 create mode 100644 drivers/clk/qcom/gcc-qdu1000.c
 create mode 100644 drivers/clk/qcom/gcc-sa8775p.c
 create mode 100644 drivers/clk/qcom/tcsrcc-sm8550.c
 create mode 100644 include/dt-bindings/clock/loongson,ls2k-clk.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt7981-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm6350-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsr.h
 delete mode 100644 include/dt-bindings/clock/stih416-clks.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
