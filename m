Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9715F026D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 03:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiI3BvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 21:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiI3BvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 21:51:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4325E511D;
        Thu, 29 Sep 2022 18:51:18 -0700 (PDT)
X-QQ-Spam: true
X-QQ-mid: bizesmtp72t1664502612t298uzz8
Received: from localhost.localdomain ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 09:50:10 +0800 (CST)
X-QQ-SSF: 01000000000000305000000A0000000
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 18/30] clk: starfive: Add StarFive JH7110 system clock driver
Date:   Fri, 30 Sep 2022 09:50:06 +0800
Message-Id: <20220930015006.25630-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add driver for the StarFive JH7110 system clock controller.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   9 +
 drivers/clk/starfive/Makefile                 |   2 +
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 648 ++++++++++++++++++
 drivers/clk/starfive/clk-starfive.h           |   2 +-
 4 files changed, 660 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-sys.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 4ff61eb941c8..c13096543a8b 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -20,3 +20,12 @@ config CLK_STARFIVE_JH7100_AUDIO
 	help
 	  Say Y or M here to support the audio clocks on the StarFive JH7100
 	  SoC.
+
+config CLK_STARFIVE_JH7110_SYS
+	bool "StarFive JH7110 system clock support"
+	depends on SOC_STARFIVE || COMPILE_TEST
+	select CLK_STARFIVE
+	default SOC_STARFIVE
+	help
+	  Say yes here to support the system clock controller on the
+	  StarFive JH7110 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index ddd04595516f..2bc126cc91f2 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -3,3 +3,5 @@ obj-$(CONFIG_CLK_STARFIVE)	+= clk-starfive.o
 
 obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
 obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
+
+obj-$(CONFIG_CLK_STARFIVE_JH7110_SYS)	+= clk-starfive-jh7110-sys.o
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
new file mode 100644
index 000000000000..91ce17fae68c
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -0,0 +1,648 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH7110 System Clock Driver
+ *
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/starfive-jh7110-sys.h>
+
+#include "clk-starfive.h"
+
+/* external clocks */
+#define JH7110_SYSCLK_OSC			(JH7110_SYSCLK_END + 0)
+#define JH7110_SYSCLK_GMAC1_RMII_REFIN		(JH7110_SYSCLK_END + 1)
+#define JH7110_SYSCLK_GMAC1_RGMII_RXIN		(JH7110_SYSCLK_END + 2)
+#define JH7110_SYSCLK_I2STX_BCLK_EXT		(JH7110_SYSCLK_END + 3)
+#define JH7110_SYSCLK_I2STX_LRCK_EXT		(JH7110_SYSCLK_END + 4)
+#define JH7110_SYSCLK_I2SRX_BCLK_EXT		(JH7110_SYSCLK_END + 5)
+#define JH7110_SYSCLK_I2SRX_LRCK_EXT		(JH7110_SYSCLK_END + 6)
+#define JH7110_SYSCLK_TDM_EXT			(JH7110_SYSCLK_END + 7)
+#define JH7110_SYSCLK_MCLK_EXT			(JH7110_SYSCLK_END + 8)
+
+static const struct starfive_clk_data jh7110_sysclk_data[] __initconst = {
+	/* root */
+	STARFIVE__MUX(JH7110_SYSCLK_CPU_ROOT, "cpu_root", 2,
+		      JH7110_SYSCLK_OSC,
+		      JH7110_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_CPU_CORE, "cpu_core", 7,
+		      JH7110_SYSCLK_CPU_ROOT),
+	STARFIVE__DIV(JH7110_SYSCLK_CPU_BUS, "cpu_bus", 2,
+		      JH7110_SYSCLK_CPU_CORE),
+	STARFIVE__MUX(JH7110_SYSCLK_GPU_ROOT, "gpu_root", 2,
+		      JH7110_SYSCLK_PLL2_OUT,
+		      JH7110_SYSCLK_PLL1_OUT),
+	STARFIVE_MDIV(JH7110_SYSCLK_PERH_ROOT, "perh_root", 2, 2,
+		      JH7110_SYSCLK_PLL0_OUT,
+		      JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE__MUX(JH7110_SYSCLK_BUS_ROOT, "bus_root", 2,
+		      JH7110_SYSCLK_OSC,
+		      JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_NOCSTG_BUS, "nocstg_bus", 3,
+		      JH7110_SYSCLK_BUS_ROOT),
+	STARFIVE__DIV(JH7110_SYSCLK_AXI_CFG0, "axi_cfg0", 3,
+		      JH7110_SYSCLK_BUS_ROOT),
+	STARFIVE__DIV(JH7110_SYSCLK_STG_AXIAHB, "stg_axiahb", 2,
+		      JH7110_SYSCLK_AXI_CFG0),
+	STARFIVE_GATE(JH7110_SYSCLK_AHB0, "ahb0", CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_SYSCLK_AHB1, "ahb1", CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_STG_AXIAHB),
+	STARFIVE__DIV(JH7110_SYSCLK_APB_BUS_FUNC, "apb_bus_func", 8,
+		      JH7110_SYSCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_SYSCLK_APB0, "apb0", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_APB_BUS),
+	STARFIVE__DIV(JH7110_SYSCLK_PLL0_DIV2, "pll0_div2", 2,
+		      JH7110_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_PLL1_DIV2, "pll1_div2", 2,
+		      JH7110_SYSCLK_PLL1_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_PLL2_DIV2, "pll2_div2", 2,
+		      JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_AUDIO_ROOT, "audio_root", 8,
+		      JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_MCLK_INNER, "mclk_inner", 64,
+		      JH7110_SYSCLK_AUDIO_ROOT),
+	STARFIVE__MUX(JH7110_SYSCLK_MCLK, "mclk", 2,
+		      JH7110_SYSCLK_MCLK_INNER,
+		      JH7110_SYSCLK_MCLK_EXT),
+	STARFIVE_GATE(JH7110_SYSCLK_MCLK_OUT, "mclk_out", 0,
+		      JH7110_SYSCLK_MCLK_INNER),
+	STARFIVE_MDIV(JH7110_SYSCLK_ISP_2X, "isp_2x", 8, 2,
+		      JH7110_SYSCLK_PLL2_OUT,
+		      JH7110_SYSCLK_PLL1_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_ISP_AXI, "isp_axi", 4,
+		      JH7110_SYSCLK_ISP_2X),
+	STARFIVE_GDIV(JH7110_SYSCLK_GCLK0, "gclk0", 0, 62,
+		      JH7110_SYSCLK_PLL0_DIV2),
+	STARFIVE_GDIV(JH7110_SYSCLK_GCLK1, "gclk1", 0, 62,
+		      JH7110_SYSCLK_PLL1_DIV2),
+	STARFIVE_GDIV(JH7110_SYSCLK_GCLK2, "gclk2", 0, 62,
+		      JH7110_SYSCLK_PLL2_DIV2),
+	/* cores */
+	STARFIVE_GATE(JH7110_SYSCLK_CORE, "core_clk", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_CORE1, "core_clk1", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_CORE2, "core_clk2", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_CORE3, "core_clk3", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_CORE4, "core_clk4", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_DEBUG, "debug_clk", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_BUS),
+	STARFIVE__DIV(JH7110_SYSCLK_RTC_TOGGLE, "rtc_toggle", 6,
+		      JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE0, "trace_clk0", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE1, "trace_clk1", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE2, "trace_clk2", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE3, "trace_clk3", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE4, "trace_clk4", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE_COM, "trace_com", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_CPU_BUS),
+	/* noc */
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_CPU_AXI, "noc_bus_cpu_axi",
+		      CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_CPU_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_AXICFG0_AXI, "noc_bus_axicfg0_axi",
+		      CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_AXI_CFG0),
+	/* ddr */
+	STARFIVE__DIV(JH7110_SYSCLK_OSC_DIV2, "osc_div2", 2,
+		      JH7110_SYSCLK_OSC),
+	STARFIVE__DIV(JH7110_SYSCLK_PLL1_DIV4, "pll1_div4", 2,
+		      JH7110_SYSCLK_PLL1_DIV2),
+	STARFIVE__DIV(JH7110_SYSCLK_PLL1_DIV8, "pll1_div8", 2,
+		      JH7110_SYSCLK_PLL1_DIV4),
+	STARFIVE__MUX(JH7110_SYSCLK_DDR_BUS, "ddr_bus", 4,
+		      JH7110_SYSCLK_OSC_DIV2,
+		      JH7110_SYSCLK_PLL1_DIV2,
+		      JH7110_SYSCLK_PLL1_DIV4,
+		      JH7110_SYSCLK_PLL1_DIV8),
+	STARFIVE_GATE(JH7110_SYSCLK_DDR_AXI, "ddr_axi", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_DDR_BUS),
+	/* gpu */
+	STARFIVE__DIV(JH7110_SYSCLK_GPU_CORE, "gpu_core", 7,
+		      JH7110_SYSCLK_GPU_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_GPU_CORE_CLK, "gpu_core_clk", 0,
+		      JH7110_SYSCLK_GPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_GPU_SYS_CLK, "gpu_sys_clk", 0,
+		      JH7110_SYSCLK_AXI_CFG1),
+	STARFIVE_GATE(JH7110_SYSCLK_GPU_APB, "gpu_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GDIV(JH7110_SYSCLK_GPU_RTC_TOGGLE, "gpu_rtc_toggle", 0, 12,
+		      JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_GPU_AXI, "noc_bus_gpu_axi", 0,
+		      JH7110_SYSCLK_GPU_CORE),
+	/* isp */
+	STARFIVE_GATE(JH7110_SYSCLK_ISP_TOP_ISPCORE_2X,
+		      "isp_top_ispcore_2x", 0,
+		      JH7110_SYSCLK_ISP_2X),
+	STARFIVE_GATE(JH7110_SYSCLK_ISP_TOP_ISP_AXI, "isp_top_isp_axi", 0,
+		      JH7110_SYSCLK_ISP_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_ISP_AXI, "noc_bus_isp_axi",
+		      CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_ISP_AXI),
+	/* hifi4 */
+	STARFIVE__DIV(JH7110_SYSCLK_HIFI4_CORE, "hifi4_core", 15,
+		      JH7110_SYSCLK_BUS_ROOT),
+	STARFIVE__DIV(JH7110_SYSCLK_HIFI4_AXI, "hifi4_axi", 2,
+		      JH7110_SYSCLK_HIFI4_CORE),
+	/* axi_cfg1_dec */
+	STARFIVE_GATE(JH7110_SYSCLK_AXI_CFG1_DEC_MAIN, "axi_cfg1_dec_main",
+		      CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_AXI_CFG1),
+	STARFIVE_GATE(JH7110_SYSCLK_AXI_CFG1_DEC_AHB, "cfg1_dec_ahb",
+		      CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_AHB0),
+	/* vout */
+	STARFIVE_GATE(JH7110_SYSCLK_VOUT_SRC, "vout_src", 0,
+		      JH7110_SYSCLK_VOUT_ROOT),
+	STARFIVE__DIV(JH7110_SYSCLK_VOUT_AXI, "vout_axi", 7,
+		      JH7110_SYSCLK_VOUT_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_DISP_AXI, "noc_bus_disp_axi", 0,
+		      JH7110_SYSCLK_VOUT_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_VOUT_TOP_VOUT_AHB, "vout_top_vout_ahb", 0,
+		      JH7110_SYSCLK_AHB1),
+	STARFIVE_GATE(JH7110_SYSCLK_VOUT_TOP_VOUT_AXI, "vout_top_vout_axi", 0,
+		      JH7110_SYSCLK_VOUT_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK,
+		      "vout_top_hdmitx0_mclk", 0,
+		      JH7110_SYSCLK_MCLK),
+	STARFIVE__DIV(JH7110_SYSCLK_VOUT_TOP_MIPIPHY_REF,
+		      "vout_top_mipiphy_ref", 2,
+		      JH7110_SYSCLK_OSC),
+	/* jpegc */
+	STARFIVE__DIV(JH7110_SYSCLK_JPEGC_AXI, "jpegc_axi", 16,
+		      JH7110_SYSCLK_VENC_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_CODAJ12_AXI, "CODAJ12_axi", 0,
+		      JH7110_SYSCLK_JPEGC_AXI),
+	STARFIVE_GDIV(JH7110_SYSCLK_CODAJ12_CORE, "CODAJ12_core", 0, 16,
+		      JH7110_SYSCLK_VENC_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_CODAJ12_APB, "CODAJ12_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	/* vdec */
+	STARFIVE__DIV(JH7110_SYSCLK_VDEC_AXI, "vdec_axi", 7,
+		      JH7110_SYSCLK_BUS_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_WAVE511_AXI, "WAVE511_axi", 0,
+		      JH7110_SYSCLK_VDEC_AXI),
+	STARFIVE_GDIV(JH7110_SYSCLK_WAVE511_BPU, "WAVE511_bpu", 0, 7,
+		      JH7110_SYSCLK_BUS_ROOT),
+	STARFIVE_GDIV(JH7110_SYSCLK_WAVE511_VCE, "WAVE511_vce", 0, 7,
+		      JH7110_SYSCLK_VDEC_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_WAVE511_APB, "WAVE511_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_VDEC_JPG_ARB_JPG, "vdec_jpg_arb_jpg",
+		      CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_JPEGC_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_VDEC_JPG_ARB_MAIN, "vdec_jpg_arb_main",
+		      CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_VDEC_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_VDEC_AXI, "noc_bus_vdec_axi", 0,
+		      JH7110_SYSCLK_VDEC_AXI),
+	/* venc */
+	STARFIVE__DIV(JH7110_SYSCLK_VENC_AXI, "venc_axi", 15,
+		      JH7110_SYSCLK_VENC_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_WAVE420L_AXI, "wave420l_axi", 0,
+		      JH7110_SYSCLK_VENC_AXI),
+	STARFIVE_GDIV(JH7110_SYSCLK_WAVE420L_BPU, "wave420l_bpu", 0, 15,
+		      JH7110_SYSCLK_VENC_ROOT),
+	STARFIVE_GDIV(JH7110_SYSCLK_WAVE420L_VCE, "wave420l_vce", 0, 15,
+		      JH7110_SYSCLK_VENC_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_WAVE420L_APB, "wave420l_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_VENC_AXI, "noc_bus_venc_axi", 0,
+		      JH7110_SYSCLK_VENC_AXI),
+	/* intmem */
+	STARFIVE_GATE(JH7110_SYSCLK_AXI_CFG0_DEC_MAIN_DIV,
+		      "axi_cfg0_dec_main_div", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_AHB1),
+	STARFIVE_GATE(JH7110_SYSCLK_AXI_CFG0_DEC_MAIN, "axi_cfg0_dec_main",
+		      CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_AXI_CFG0),
+	STARFIVE_GATE(JH7110_SYSCLK_AXI_CFG0_DEC_HIFI4, "axi_cfg0_dec_hifi4",
+		      CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_HIFI4_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_AXIMEM2_128B_AXI, "aximem2_128b_axi",
+		      CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_AXI_CFG0),
+	/* qspi */
+	STARFIVE_GATE(JH7110_SYSCLK_QSPI_AHB, "qspi_ahb", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_AHB1),
+	STARFIVE_GATE(JH7110_SYSCLK_QSPI_APB, "qspi_apb", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE__DIV(JH7110_SYSCLK_QSPI_REF_SRC, "qspi_ref_src", 16,
+		      JH7110_SYSCLK_GMACUSB_ROOT),
+	STARFIVE_GMUX(JH7110_SYSCLK_QSPI_REF, "qspi_ref", CLK_IGNORE_UNUSED, 2,
+		      JH7110_SYSCLK_OSC,
+		      JH7110_SYSCLK_QSPI_REF_SRC),
+	/* sdio */
+	STARFIVE_GATE(JH7110_SYSCLK_SDIO0_AHB, "sdio0_ahb", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_AHB0),
+	STARFIVE_GATE(JH7110_SYSCLK_SDIO1_AHB, "sdio1_ahb", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_AHB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_SDIO0_SDCARD, "sdio0_sdcard",
+		      CLK_IGNORE_UNUSED, 15,
+		      JH7110_SYSCLK_AXI_CFG0),
+	STARFIVE_GDIV(JH7110_SYSCLK_SDIO1_SDCARD, "sdio1_sdcard",
+		      CLK_IGNORE_UNUSED, 15,
+		      JH7110_SYSCLK_AXI_CFG0),
+	/* stg */
+	STARFIVE__DIV(JH7110_SYSCLK_USB_125M, "usb_125m", 15,
+		      JH7110_SYSCLK_GMACUSB_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_STG_AXI, "noc_bus_stg_axi",
+		      CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_NOCSTG_BUS),
+	/* gmac1 */
+	STARFIVE_GATE(JH7110_SYSCLK_GMAC1_AHB, "gmac1_ahb", 0,
+		      JH7110_SYSCLK_AHB0),
+	STARFIVE_GATE(JH7110_SYSCLK_GMAC1_AXI, "gmac1_axi", 0,
+		      JH7110_SYSCLK_STG_AXIAHB),
+	STARFIVE__DIV(JH7110_SYSCLK_GMAC_SRC, "gmac_src", 7,
+		      JH7110_SYSCLK_GMACUSB_ROOT),
+	STARFIVE__DIV(JH7110_SYSCLK_GMAC1_GTXCLK, "gmac1_gtxclk", 15,
+		      JH7110_SYSCLK_GMACUSB_ROOT),
+	STARFIVE__DIV(JH7110_SYSCLK_GMAC1_RMII_RTX, "gmac1_rmii_rtx", 30,
+		      JH7110_SYSCLK_GMAC1_RMII_REFIN),
+	STARFIVE_GDIV(JH7110_SYSCLK_GMAC1_PTP, "gmac1_ptp", 0, 31,
+		      JH7110_SYSCLK_GMAC_SRC),
+	STARFIVE__MUX(JH7110_SYSCLK_GMAC1_RX, "gmac1_rx", 2,
+		      JH7110_SYSCLK_GMAC1_RGMII_RXIN,
+		      JH7110_SYSCLK_GMAC1_RMII_RTX),
+	STARFIVE__INV(JH7110_SYSCLK_GMAC1_RX_INV, "gmac1_rx_inv",
+		      JH7110_SYSCLK_GMAC1_RX),
+	STARFIVE_GMUX(JH7110_SYSCLK_GMAC1_TX, "gmac1_tx", 0, 2,
+		      JH7110_SYSCLK_GMAC1_GTXCLK,
+		      JH7110_SYSCLK_GMAC1_RMII_RTX),
+	STARFIVE__INV(JH7110_SYSCLK_GMAC1_TX_INV, "gmac1_tx_inv",
+		      JH7110_SYSCLK_GMAC1_TX),
+	STARFIVE_GATE(JH7110_SYSCLK_GMAC1_GTXC, "gmac1_gtxc", 0,
+		      JH7110_SYSCLK_GMAC1_GTXCLK),
+	/* gmac0 */
+	STARFIVE_GDIV(JH7110_SYSCLK_GMAC0_GTXCLK, "gmac0_gtxclk", 0, 15,
+		      JH7110_SYSCLK_GMACUSB_ROOT),
+	STARFIVE_GDIV(JH7110_SYSCLK_GMAC0_PTP, "gmac0_ptp", 0, 31,
+		      JH7110_SYSCLK_GMAC_SRC),
+	STARFIVE_GDIV(JH7110_SYSCLK_GMAC_PHY, "gmac_phy", 0, 31,
+		      JH7110_SYSCLK_GMAC_SRC),
+	STARFIVE__DIV(JH7110_SYSCLK_GMAC0_GTXC, "gmac0_gtxc", 32,
+		      JH7110_SYSCLK_GMAC0_GTXCLK),
+	/* sys misc */
+	STARFIVE_GATE(JH7110_SYSCLK_IOMUX, "iomux_pclk", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_MAILBOX, "mailbox_apb", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_INT_CTRL_APB, "int_ctrl_apb",
+		      CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_APB12),
+	/* can0 */
+	STARFIVE_GATE(JH7110_SYSCLK_CAN0_APB, "can0_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GDIV(JH7110_SYSCLK_CAN0_TIMER, "can0_timer", 0, 24,
+		      JH7110_SYSCLK_OSC),
+	STARFIVE_GDIV(JH7110_SYSCLK_CAN0_CAN, "can0_can", 0, 63,
+		      JH7110_SYSCLK_PERH_ROOT),
+	/* can1 */
+	STARFIVE_GATE(JH7110_SYSCLK_CAN1_APB, "can1_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GDIV(JH7110_SYSCLK_CAN1_TIMER, "can1_timer", 0, 24,
+		      JH7110_SYSCLK_OSC),
+	STARFIVE_GDIV(JH7110_SYSCLK_CAN1_CAN, "can1_can", 0, 63,
+		      JH7110_SYSCLK_PERH_ROOT),
+	/* pwm */
+	STARFIVE_GATE(JH7110_SYSCLK_PWM_APB, "pwm_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	/* wdt */
+	STARFIVE_GATE(JH7110_SYSCLK_WDT_APB, "wdt_apb", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_WDT_CORE, "wdt_core", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_OSC),
+	/* timer */
+	STARFIVE_GATE(JH7110_SYSCLK_TIMER_APB, "timer_apb", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_TIMER0, "timer0_clk", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_TIMER1, "timer1_clk", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_TIMER2, "timer2_clk", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_TIMER3, "timer3_clk", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_OSC),
+	/* temp sensor */
+	STARFIVE_GATE(JH7110_SYSCLK_TEMP_APB, "temp_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GDIV(JH7110_SYSCLK_TEMP_CORE, "temp_core", 0, 24,
+		      JH7110_SYSCLK_OSC),
+	/* spi */
+	STARFIVE_GATE(JH7110_SYSCLK_SPI0_APB, "spi0_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI1_APB, "spi1_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI2_APB, "spi2_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI3_APB, "spi3_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI4_APB, "spi4_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI5_APB, "spi5_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI6_APB, "spi6_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	/* i2c */
+	STARFIVE_GATE(JH7110_SYSCLK_I2C0_APB, "i2c0_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C1_APB, "i2c1_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C2_APB, "i2c2_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C3_APB, "i2c3_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C4_APB, "i2c4_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C5_APB, "i2c5_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C6_APB, "i2c6_apb", 0,
+		      JH7110_SYSCLK_APB12),
+	/* uart */
+	STARFIVE_GATE(JH7110_SYSCLK_UART0_APB, "uart0_apb", CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_UART0_CORE, "uart0_core",
+		      CLK_IGNORE_UNUSED,
+		      JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_UART1_APB, "uart1_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_UART1_CORE, "uart1_core", 0,
+		      JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_UART2_APB, "uart2_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_UART2_CORE, "uart2_core", 0,
+		      JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_UART3_APB, "uart3_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_UART3_CORE, "uart3_core", 0, 10,
+		      JH7110_SYSCLK_PERH_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_UART4_APB, "uart4_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_UART4_CORE, "uart4_core", 0, 10,
+		      JH7110_SYSCLK_PERH_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_UART5_APB, "uart5_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_UART5_CORE, "uart5_core", 0, 10,
+		      JH7110_SYSCLK_PERH_ROOT),
+	/* pwmdac */
+	STARFIVE_GATE(JH7110_SYSCLK_PWMDAC_APB, "pwmdac_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_PWMDAC_CORE, "pwmdac_core", 0, 256,
+		      JH7110_SYSCLK_AUDIO_ROOT),
+	/* spdif */
+	STARFIVE_GATE(JH7110_SYSCLK_SPDIF_APB, "spdif_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_SPDIF_CORE, "spdif_core", 0,
+		      JH7110_SYSCLK_MCLK),
+	/* i2stx0 */
+	STARFIVE_GATE(JH7110_SYSCLK_I2STX0_APB, "i2stx0_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_I2STX0_BCLK_MST, "i2stx0_bclk_mst", 0, 32,
+		      JH7110_SYSCLK_MCLK),
+	STARFIVE__INV(JH7110_SYSCLK_I2STX0_BCLK_MST_INV, "i2stx0_bclk_mst_inv",
+		      JH7110_SYSCLK_I2STX0_BCLK_MST),
+	STARFIVE_MDIV(JH7110_SYSCLK_I2STX0_LRCK_MST, "i2stx0_lrck_mst", 64, 2,
+		      JH7110_SYSCLK_I2STX0_BCLK_MST_INV,
+		      JH7110_SYSCLK_I2STX0_BCLK_MST),
+	STARFIVE__MUX(JH7110_SYSCLK_I2STX0_BCLK, "i2stx0_bclk",	2,
+		      JH7110_SYSCLK_I2STX0_BCLK_MST,
+		      JH7110_SYSCLK_I2STX_BCLK_EXT),
+	STARFIVE__INV(JH7110_SYSCLK_I2STX0_BCLK_INV, "i2stx0_bclk_inv",
+		      JH7110_SYSCLK_I2STX0_BCLK),
+	STARFIVE__MUX(JH7110_SYSCLK_I2STX0_LRCK, "i2stx0_lrck", 2,
+		      JH7110_SYSCLK_I2STX0_LRCK_MST,
+		      JH7110_SYSCLK_I2STX_LRCK_EXT),
+	/* i2stx1 */
+	STARFIVE_GATE(JH7110_SYSCLK_I2STX1_APB, "i2stx1_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_I2STX1_BCLK_MST, "i2stx1_bclk_mst", 0, 32,
+		      JH7110_SYSCLK_MCLK),
+	STARFIVE__INV(JH7110_SYSCLK_I2STX1_BCLK_MST_INV, "i2stx1_bclk_mst_inv",
+		      JH7110_SYSCLK_I2STX1_BCLK_MST),
+	STARFIVE_MDIV(JH7110_SYSCLK_I2STX1_LRCK_MST, "i2stx1_lrck_mst", 64, 2,
+		      JH7110_SYSCLK_I2STX1_BCLK_MST_INV,
+		      JH7110_SYSCLK_I2STX1_BCLK_MST),
+	STARFIVE__MUX(JH7110_SYSCLK_I2STX1_BCLK, "i2stx1_bclk", 2,
+		      JH7110_SYSCLK_I2STX1_BCLK_MST,
+		      JH7110_SYSCLK_I2STX_BCLK_EXT),
+	STARFIVE__INV(JH7110_SYSCLK_I2STX1_BCLK_INV, "i2stx1_bclk_inv",
+		      JH7110_SYSCLK_I2STX1_BCLK),
+	STARFIVE__MUX(JH7110_SYSCLK_I2STX1_LRCK, "i2stx1_lrck", 2,
+		      JH7110_SYSCLK_I2STX1_LRCK_MST,
+		      JH7110_SYSCLK_I2STX_LRCK_EXT),
+	/* i2srx */
+	STARFIVE_GATE(JH7110_SYSCLK_I2SRX_APB, "i2srx_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_I2SRX_BCLK_MST, "i2srx_bclk_mst", 0, 32,
+		      JH7110_SYSCLK_MCLK),
+	STARFIVE__INV(JH7110_SYSCLK_I2SRX_BCLK_MST_INV, "i2srx_bclk_mst_inv",
+		      JH7110_SYSCLK_I2SRX_BCLK_MST),
+	STARFIVE_MDIV(JH7110_SYSCLK_I2SRX_LRCK_MST, "i2srx_lrck_mst", 64, 2,
+		      JH7110_SYSCLK_I2SRX_BCLK_MST_INV,
+		      JH7110_SYSCLK_I2SRX_BCLK_MST),
+	STARFIVE__MUX(JH7110_SYSCLK_I2SRX_BCLK, "i2srx_bclk", 2,
+		      JH7110_SYSCLK_I2SRX_BCLK_MST,
+		      JH7110_SYSCLK_I2SRX_BCLK_EXT),
+	STARFIVE__INV(JH7110_SYSCLK_I2SRX_BCLK_INV, "i2srx_bclk_inv",
+		      JH7110_SYSCLK_I2SRX_BCLK),
+	STARFIVE__MUX(JH7110_SYSCLK_I2SRX_LRCK, "i2srx_lrck", 2,
+		      JH7110_SYSCLK_I2SRX_LRCK_MST,
+		      JH7110_SYSCLK_I2SRX_LRCK_EXT),
+	/* pdm */
+	STARFIVE_GDIV(JH7110_SYSCLK_PDM_DMIC, "pdm_dmic", 0, 64,
+		      JH7110_SYSCLK_MCLK),
+	STARFIVE_GATE(JH7110_SYSCLK_PDM_APB, "pdm_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	/* tdm */
+	STARFIVE_GATE(JH7110_SYSCLK_TDM_AHB, "tdm_ahb", 0,
+		      JH7110_SYSCLK_AHB0),
+	STARFIVE_GATE(JH7110_SYSCLK_TDM_APB, "tdm_apb", 0,
+		      JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_TDM_INTERNAL, "tdm_internal", 0, 64,
+		      JH7110_SYSCLK_MCLK),
+	STARFIVE__MUX(JH7110_SYSCLK_TDM_CLK_TDM, "tdm_clk_tdm", 2,
+		      JH7110_SYSCLK_TDM_INTERNAL,
+		      JH7110_SYSCLK_TDM_EXT),
+	STARFIVE__INV(JH7110_SYSCLK_TDM_CLK_TDM_N, "tdm_clk_tdm_n",
+		      JH7110_SYSCLK_TDM_CLK_TDM),
+	/* jtag */
+	STARFIVE__DIV(JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG,
+		      "jtag_certification_trng", 4,
+		      JH7110_SYSCLK_OSC),
+};
+
+static const struct {
+	const char *name;
+	const char *parent;
+	unsigned int mul;
+	unsigned int div;
+} jh7110_fixed_factor_clocks[JH7110_SYSCLK_END - JH7110_SYSCLK_PLL0_OUT] __initconst = {
+	[JH7110_SYSCLK_PLL0_OUT - JH7110_SYSCLK_PLL0_OUT] = {
+		"pll0_out", "osc", 625, 12 /* 24MHz -> 1250.0MHz */
+	},
+	[JH7110_SYSCLK_PLL1_OUT - JH7110_SYSCLK_PLL0_OUT] = {
+		"pll1_out", "osc", 533, 12 /* 24MHz -> 1066.0MHz */
+	},
+	[JH7110_SYSCLK_PLL2_OUT - JH7110_SYSCLK_PLL0_OUT] = {
+		"pll2_out", "osc", 256,  5 /* 24MHz -> 1228.8MHz */
+	},
+	[JH7110_SYSCLK_PCLK2_MUX_FUNC_PCLK - JH7110_SYSCLK_PLL0_OUT] = {
+		"u2_pclk_mux_func_pclk", "apb_bus_func", 1, 1
+	},
+	[JH7110_SYSCLK_U2_PCLK_MUX_PCLK - JH7110_SYSCLK_PLL0_OUT] = {
+		"u2_pclk_mux_pclk", "u2_pclk_mux_func_pclk", 1, 1
+	},
+	[JH7110_SYSCLK_APB_BUS - JH7110_SYSCLK_PLL0_OUT] = {
+		"apb_bus", "u2_pclk_mux_pclk", 1, 1
+	},
+	[JH7110_SYSCLK_AXI_CFG1 - JH7110_SYSCLK_PLL0_OUT] = {
+		"axi_cfg1", "isp_axi", 1, 1
+	},
+	[JH7110_SYSCLK_APB12 - JH7110_SYSCLK_PLL0_OUT] = {
+		"apb12", "apb_bus", 1, 1
+	},
+	[JH7110_SYSCLK_VOUT_ROOT - JH7110_SYSCLK_PLL0_OUT] = {
+		"vout_root", "pll2_out", 1, 1
+	},
+	[JH7110_SYSCLK_VENC_ROOT - JH7110_SYSCLK_PLL0_OUT] = {
+		"venc_root", "pll2_out", 1, 1
+	},
+	[JH7110_SYSCLK_VDEC_ROOT - JH7110_SYSCLK_PLL0_OUT] = {
+		"vdec_root", "pll0_out", 1, 1
+	},
+	[JH7110_SYSCLK_GMACUSB_ROOT - JH7110_SYSCLK_PLL0_OUT] = {
+		"gmacusb_root", "pll0_out", 1, 1
+	},
+};
+
+static struct clk_hw *jh7110_sysclk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct starfive_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < JH7110_SYSCLK_PLL0_OUT)
+		return &priv->reg[idx].hw;
+
+	if (idx < JH7110_SYSCLK_END)
+		return priv->pll[idx - JH7110_SYSCLK_PLL0_OUT];
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int __init jh7110_syscrg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int i, ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH7110_SYSCLK_PLL0_OUT),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	priv->regmap = syscon_node_to_regmap(priv->dev->of_node->parent);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(priv->dev, "failed to get regmap (error %ld)\n",
+			PTR_ERR(priv->regmap));
+		return PTR_ERR(priv->regmap);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(jh7110_fixed_factor_clocks); i++) {
+		priv->pll[i] =
+			devm_clk_hw_register_fixed_factor(&pdev->dev,
+							  jh7110_fixed_factor_clocks[i].name,
+							  jh7110_fixed_factor_clocks[i].parent,
+							  0,
+							  jh7110_fixed_factor_clocks[i].mul,
+							  jh7110_fixed_factor_clocks[i].div);
+		if (IS_ERR(priv->pll[i]))
+			return PTR_ERR(priv->pll[i]);
+	}
+
+	for (idx = 0; idx < JH7110_SYSCLK_PLL0_OUT; idx++) {
+		u32 max = jh7110_sysclk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh7110_sysclk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jh7110_sysclk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh7110_sysclk_data[idx].parents[i];
+
+			if (pidx < JH7110_SYSCLK_PLL0_OUT)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx < JH7110_SYSCLK_END)
+				parents[i].hw = priv->pll[pidx - JH7110_SYSCLK_PLL0_OUT];
+			else if (pidx == JH7110_SYSCLK_OSC)
+				parents[i].fw_name = "osc";
+			else if (pidx == JH7110_SYSCLK_GMAC1_RMII_REFIN)
+				parents[i].fw_name = "gmac1_rmii_refin";
+			else if (pidx == JH7110_SYSCLK_GMAC1_RGMII_RXIN)
+				parents[i].fw_name = "gmac1_rgmii_rxin";
+			else if (pidx == JH7110_SYSCLK_I2STX_BCLK_EXT)
+				parents[i].fw_name = "i2stx_bclk_ext";
+			else if (pidx == JH7110_SYSCLK_I2STX_LRCK_EXT)
+				parents[i].fw_name = "i2stx_lrck_ext";
+			else if (pidx == JH7110_SYSCLK_I2SRX_BCLK_EXT)
+				parents[i].fw_name = "i2srx_bclk_ext";
+			else if (pidx == JH7110_SYSCLK_I2SRX_LRCK_EXT)
+				parents[i].fw_name = "i2srx_lrck_ext";
+			else if (pidx == JH7110_SYSCLK_TDM_EXT)
+				parents[i].fw_name = "tdm_ext";
+			else if (pidx == JH7110_SYSCLK_MCLK_EXT)
+				parents[i].fw_name = "mclk_ext";
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	return devm_of_clk_add_hw_provider(&pdev->dev, jh7110_sysclk_get, priv);
+}
+
+static const struct of_device_id jh7110_syscrg_match[] = {
+	{ .compatible = "starfive,jh7110-clkgen-sys" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh7110_syscrg_driver = {
+	.driver = {
+		.name = "clk-starfive-jh7110-sys",
+		.of_match_table = jh7110_syscrg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jh7110_syscrg_driver, jh7110_syscrg_probe);
diff --git a/drivers/clk/starfive/clk-starfive.h b/drivers/clk/starfive/clk-starfive.h
index 99cf74e8cbde..b717bd033e26 100644
--- a/drivers/clk/starfive/clk-starfive.h
+++ b/drivers/clk/starfive/clk-starfive.h
@@ -103,7 +103,7 @@ struct starfive_clk {
 struct starfive_clk_priv {
 	struct device *dev;
 	struct regmap *regmap;
-	struct clk_hw *pll[3];
+	struct clk_hw *pll[12];
 	struct starfive_clk reg[];
 };
 
-- 
2.17.1

