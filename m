Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B06692EDF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBKGkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBKGj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:39:56 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6CCC65D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:39:53 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bd6so6262864oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lnwh8PvzH4M3fqQVoLT90tP2lhDK7TTHHkCgxq6i/js=;
        b=Ol6JWk7nCP20i/OqMHlNDkpa69RwMDOCqCohAXIm1V74QS7VxtD01TAflem6jRNV8v
         AjWaxemfOtP1iZPXfM4kFjAFbsuvcIjqpVSIX6eVOt7FSPHRaefnfTVx7iKGjBFKClFX
         k3ar/iZ8J3Hmj8mKjqTYrnMfjHSJhBkODhJLNY3dES/Y+3b/u1PTMebtQZIas0Ra6YdZ
         K7RnZNK3gIhnuyB4Fdigrp2idDAjT7xS6SLABgYi3qaw7OgiU+Qch7mkOKAkPWn3oSWt
         Aqhxzt5SP37oobrsvYIfGavADqykX0ihTJqhk5VjT09prNB1ypJ2jGr4BVh2qxx8alcb
         fiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lnwh8PvzH4M3fqQVoLT90tP2lhDK7TTHHkCgxq6i/js=;
        b=pRSnla6K3DkBLq2sJ64gcda7jspNqMQ6dPFXkg/GJXqYSTrcz8KuWdKlXCELxq4Lu/
         RcC4VeWmAs/jib2o5Q2RaewY75vQiSglNOnV585V9yvb/96kQ7LnjYtcFbkWfX0Fb4Xt
         Gv1UES6KHk5e3lcFzsZp8c96vb40/WkwLgpKXXfCGzdPH36rQootlwcyrN7aJPm3PGmB
         if1DViFQuOm88Udupioxf+ZgJk/nUOMrY6m3/a5OW7i8sbWcmKiG/HnAgQm9nhSH1veK
         iUBlsm1w5DitLZzGj41/eesMQnq+HIY2iQGGOz0Qz0uS/JU3Xhfx6yDr4Xj5dNwxLNm+
         2ykQ==
X-Gm-Message-State: AO0yUKVeeCG7eZdbKucKVY4FkPvP4HBxWtZYRcWkulPN1rBQN2TRdwgb
        ey86QCsv2XPq7c2EoflR/C3h7w==
X-Google-Smtp-Source: AK7set9DRIgVl+UtYocAPknZ9Hw1v5tMCSYSKv0gIfztAkSSZa5qclC3niu2jcB0QVPTd9W/iyVGDA==
X-Received: by 2002:aca:1015:0:b0:36d:ea30:7bdf with SMTP id 21-20020aca1015000000b0036dea307bdfmr7765530oiq.49.1676097593463;
        Fri, 10 Feb 2023 22:39:53 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id w17-20020a9d6751000000b0067781a9292asm2900899otm.2.2023.02.10.22.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 22:39:53 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Virag <virag.david003@gmail.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] clk: samsung: exynos850: Implement CMU_G3D domain
Date:   Sat, 11 Feb 2023 00:40:04 -0600
Message-Id: <20230211064006.14981-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211064006.14981-1-semen.protsenko@linaro.org>
References: <20230211064006.14981-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMU_G3D clock domain provides clocks for Mali-G52 GPU and bus clocks for
BLK_G3D.

This patch adds next clocks:
  - bus clocks in CMU_TOP for CMU_G3D
  - all internal CMU_G3D clocks
  - leaf clocks for GPU, TZPC (TrustZone Protection Controller) and
    SysReg

G3D_CMU_G3D clock was marked as CLK_IGNORE_UNUSED, as system hangs on
boot otherwise.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos850.c | 121 ++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index 541761e96aeb..a24eff42baae 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -36,6 +36,7 @@
 #define CLK_CON_MUX_MUX_CLKCMU_CORE_MMC_EMBD	0x101c
 #define CLK_CON_MUX_MUX_CLKCMU_CORE_SSS		0x1020
 #define CLK_CON_MUX_MUX_CLKCMU_DPU		0x1034
+#define CLK_CON_MUX_MUX_CLKCMU_G3D_SWITCH	0x1038
 #define CLK_CON_MUX_MUX_CLKCMU_HSI_BUS		0x103c
 #define CLK_CON_MUX_MUX_CLKCMU_HSI_MMC_CARD	0x1040
 #define CLK_CON_MUX_MUX_CLKCMU_HSI_USB20DRD	0x1044
@@ -57,6 +58,7 @@
 #define CLK_CON_DIV_CLKCMU_CORE_MMC_EMBD	0x1828
 #define CLK_CON_DIV_CLKCMU_CORE_SSS		0x182c
 #define CLK_CON_DIV_CLKCMU_DPU			0x1840
+#define CLK_CON_DIV_CLKCMU_G3D_SWITCH		0x1844
 #define CLK_CON_DIV_CLKCMU_HSI_BUS		0x1848
 #define CLK_CON_DIV_CLKCMU_HSI_MMC_CARD		0x184c
 #define CLK_CON_DIV_CLKCMU_HSI_USB20DRD		0x1850
@@ -84,6 +86,7 @@
 #define CLK_CON_GAT_GATE_CLKCMU_CORE_MMC_EMBD	0x2024
 #define CLK_CON_GAT_GATE_CLKCMU_CORE_SSS	0x2028
 #define CLK_CON_GAT_GATE_CLKCMU_DPU		0x203c
+#define CLK_CON_GAT_GATE_CLKCMU_G3D_SWITCH	0x2040
 #define CLK_CON_GAT_GATE_CLKCMU_HSI_BUS		0x2044
 #define CLK_CON_GAT_GATE_CLKCMU_HSI_MMC_CARD	0x2048
 #define CLK_CON_GAT_GATE_CLKCMU_HSI_USB20DRD	0x204c
@@ -116,6 +119,7 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_MUX_MUX_CLKCMU_CORE_MMC_EMBD,
 	CLK_CON_MUX_MUX_CLKCMU_CORE_SSS,
 	CLK_CON_MUX_MUX_CLKCMU_DPU,
+	CLK_CON_MUX_MUX_CLKCMU_G3D_SWITCH,
 	CLK_CON_MUX_MUX_CLKCMU_HSI_BUS,
 	CLK_CON_MUX_MUX_CLKCMU_HSI_MMC_CARD,
 	CLK_CON_MUX_MUX_CLKCMU_HSI_USB20DRD,
@@ -137,6 +141,7 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_DIV_CLKCMU_CORE_MMC_EMBD,
 	CLK_CON_DIV_CLKCMU_CORE_SSS,
 	CLK_CON_DIV_CLKCMU_DPU,
+	CLK_CON_DIV_CLKCMU_G3D_SWITCH,
 	CLK_CON_DIV_CLKCMU_HSI_BUS,
 	CLK_CON_DIV_CLKCMU_HSI_MMC_CARD,
 	CLK_CON_DIV_CLKCMU_HSI_USB20DRD,
@@ -164,6 +169,7 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_GAT_GATE_CLKCMU_CORE_MMC_EMBD,
 	CLK_CON_GAT_GATE_CLKCMU_CORE_SSS,
 	CLK_CON_GAT_GATE_CLKCMU_DPU,
+	CLK_CON_GAT_GATE_CLKCMU_G3D_SWITCH,
 	CLK_CON_GAT_GATE_CLKCMU_HSI_BUS,
 	CLK_CON_GAT_GATE_CLKCMU_HSI_MMC_CARD,
 	CLK_CON_GAT_GATE_CLKCMU_HSI_USB20DRD,
@@ -216,6 +222,9 @@ PNAME(mout_core_mmc_embd_p)	= { "oscclk", "dout_shared0_div2",
 				    "oscclk", "oscclk" };
 PNAME(mout_core_sss_p)		= { "dout_shared0_div3", "dout_shared1_div3",
 				    "dout_shared0_div4", "dout_shared1_div4" };
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_G3D */
+PNAME(mout_g3d_switch_p)	= { "dout_shared0_div2", "dout_shared1_div2",
+				    "dout_shared0_div3", "dout_shared1_div3" };
 /* List of parent clocks for Muxes in CMU_TOP: for CMU_HSI */
 PNAME(mout_hsi_bus_p)		= { "dout_shared0_div2", "dout_shared1_div2" };
 PNAME(mout_hsi_mmc_card_p)	= { "oscclk", "dout_shared0_div2",
@@ -283,6 +292,10 @@ static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 	MUX(CLK_MOUT_DPU, "mout_dpu", mout_dpu_p,
 	    CLK_CON_MUX_MUX_CLKCMU_DPU, 0, 2),
 
+	/* G3D */
+	MUX(CLK_MOUT_G3D_SWITCH, "mout_g3d_switch", mout_g3d_switch_p,
+	    CLK_CON_MUX_MUX_CLKCMU_G3D_SWITCH, 0, 2),
+
 	/* HSI */
 	MUX(CLK_MOUT_HSI_BUS, "mout_hsi_bus", mout_hsi_bus_p,
 	    CLK_CON_MUX_MUX_CLKCMU_HSI_BUS, 0, 1),
@@ -357,6 +370,10 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
 	DIV(CLK_DOUT_DPU, "dout_dpu", "gout_dpu",
 	    CLK_CON_DIV_CLKCMU_DPU, 0, 4),
 
+	/* G3D */
+	DIV(CLK_DOUT_G3D_SWITCH, "dout_g3d_switch", "gout_g3d_switch",
+	    CLK_CON_DIV_CLKCMU_G3D_SWITCH, 0, 3),
+
 	/* HSI */
 	DIV(CLK_DOUT_HSI_BUS, "dout_hsi_bus", "gout_hsi_bus",
 	    CLK_CON_DIV_CLKCMU_HSI_BUS, 0, 4),
@@ -417,6 +434,10 @@ static const struct samsung_gate_clock top_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_DPU, "gout_dpu", "mout_dpu",
 	     CLK_CON_GAT_GATE_CLKCMU_DPU, 21, 0, 0),
 
+	/* G3D */
+	GATE(CLK_GOUT_G3D_SWITCH, "gout_g3d_switch", "mout_g3d_switch",
+	     CLK_CON_GAT_GATE_CLKCMU_G3D_SWITCH, 21, 0, 0),
+
 	/* HSI */
 	GATE(CLK_GOUT_HSI_BUS, "gout_hsi_bus", "mout_hsi_bus",
 	     CLK_CON_GAT_GATE_CLKCMU_HSI_BUS, 21, 0, 0),
@@ -992,6 +1013,103 @@ static const struct samsung_cmu_info cmgp_cmu_info __initconst = {
 	.clk_name		= "gout_clkcmu_cmgp_bus",
 };
 
+/* ---- CMU_G3D ------------------------------------------------------------- */
+
+/* Register Offset definitions for CMU_G3D (0x11400000) */
+#define PLL_LOCKTIME_PLL_G3D			0x0000
+#define PLL_CON0_PLL_G3D			0x0100
+#define PLL_CON3_PLL_G3D			0x010c
+#define PLL_CON0_MUX_CLKCMU_G3D_SWITCH_USER	0x0600
+#define CLK_CON_MUX_MUX_CLK_G3D_BUSD		0x1000
+#define CLK_CON_DIV_DIV_CLK_G3D_BUSP		0x1804
+#define CLK_CON_GAT_CLK_G3D_CMU_G3D_PCLK	0x2000
+#define CLK_CON_GAT_CLK_G3D_GPU_CLK		0x2004
+#define CLK_CON_GAT_GOUT_G3D_TZPC_PCLK		0x200c
+#define CLK_CON_GAT_GOUT_G3D_GRAY2BIN_CLK	0x2010
+#define CLK_CON_GAT_GOUT_G3D_BUSD_CLK		0x2024
+#define CLK_CON_GAT_GOUT_G3D_BUSP_CLK		0x2028
+#define CLK_CON_GAT_GOUT_G3D_SYSREG_PCLK	0x202c
+
+
+static const unsigned long g3d_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_G3D,
+	PLL_CON0_PLL_G3D,
+	PLL_CON3_PLL_G3D,
+	PLL_CON0_MUX_CLKCMU_G3D_SWITCH_USER,
+	CLK_CON_MUX_MUX_CLK_G3D_BUSD,
+	CLK_CON_DIV_DIV_CLK_G3D_BUSP,
+	CLK_CON_GAT_CLK_G3D_CMU_G3D_PCLK,
+	CLK_CON_GAT_CLK_G3D_GPU_CLK,
+	CLK_CON_GAT_GOUT_G3D_TZPC_PCLK,
+	CLK_CON_GAT_GOUT_G3D_GRAY2BIN_CLK,
+	CLK_CON_GAT_GOUT_G3D_BUSD_CLK,
+	CLK_CON_GAT_GOUT_G3D_BUSP_CLK,
+	CLK_CON_GAT_GOUT_G3D_SYSREG_PCLK,
+};
+
+/* List of parent clocks for Muxes in CMU_G3D */
+PNAME(mout_g3d_pll_p)		= { "oscclk", "fout_g3d_pll" };
+PNAME(mout_g3d_switch_user_p)	= { "oscclk", "dout_g3d_switch" };
+PNAME(mout_g3d_busd_p)		= { "mout_g3d_pll", "mout_g3d_switch_user" };
+
+/*
+ * Do not provide PLL table to PLL_G3D, as MANUAL_PLL_CTRL bit is not set
+ * for that PLL by default, so set_rate operation would fail.
+ */
+static const struct samsung_pll_clock g3d_pll_clks[] __initconst = {
+	PLL(pll_0818x, CLK_FOUT_G3D_PLL, "fout_g3d_pll", "oscclk",
+	    PLL_LOCKTIME_PLL_G3D, PLL_CON3_PLL_G3D, NULL),
+};
+
+static const struct samsung_mux_clock g3d_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_G3D_PLL, "mout_g3d_pll", mout_g3d_pll_p,
+	    PLL_CON0_PLL_G3D, 4, 1),
+	MUX(CLK_MOUT_G3D_SWITCH_USER, "mout_g3d_switch_user",
+	    mout_g3d_switch_user_p,
+	    PLL_CON0_MUX_CLKCMU_G3D_SWITCH_USER, 4, 1),
+	MUX(CLK_MOUT_G3D_BUSD, "mout_g3d_busd", mout_g3d_busd_p,
+	    CLK_CON_MUX_MUX_CLK_G3D_BUSD, 0, 1),
+};
+
+static const struct samsung_div_clock g3d_div_clks[] __initconst = {
+	DIV(CLK_DOUT_G3D_BUSP, "dout_g3d_busp", "mout_g3d_busd",
+	    CLK_CON_DIV_DIV_CLK_G3D_BUSP, 0, 3),
+};
+
+static const struct samsung_gate_clock g3d_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_G3D_CMU_G3D_PCLK, "gout_g3d_cmu_g3d_pclk",
+	     "dout_g3d_busp",
+	     CLK_CON_GAT_CLK_G3D_CMU_G3D_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_G3D_GPU_CLK, "gout_g3d_gpu_clk", "mout_g3d_busd",
+	     CLK_CON_GAT_CLK_G3D_GPU_CLK, 21, 0, 0),
+	GATE(CLK_GOUT_G3D_TZPC_PCLK, "gout_g3d_tzpc_pclk", "dout_g3d_busp",
+	     CLK_CON_GAT_GOUT_G3D_TZPC_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_G3D_GRAY2BIN_CLK, "gout_g3d_gray2bin_clk",
+	     "mout_g3d_busd",
+	     CLK_CON_GAT_GOUT_G3D_GRAY2BIN_CLK, 21, 0, 0),
+	GATE(CLK_GOUT_G3D_BUSD_CLK, "gout_g3d_busd_clk", "mout_g3d_busd",
+	     CLK_CON_GAT_GOUT_G3D_BUSD_CLK, 21, 0, 0),
+	GATE(CLK_GOUT_G3D_BUSP_CLK, "gout_g3d_busp_clk", "dout_g3d_busp",
+	     CLK_CON_GAT_GOUT_G3D_BUSP_CLK, 21, 0, 0),
+	GATE(CLK_GOUT_G3D_SYSREG_PCLK, "gout_g3d_sysreg_pclk", "dout_g3d_busp",
+	     CLK_CON_GAT_GOUT_G3D_SYSREG_PCLK, 21, 0, 0),
+};
+
+static const struct samsung_cmu_info g3d_cmu_info __initconst = {
+	.pll_clks		= g3d_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(g3d_pll_clks),
+	.mux_clks		= g3d_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(g3d_mux_clks),
+	.div_clks		= g3d_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(g3d_div_clks),
+	.gate_clks		= g3d_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(g3d_gate_clks),
+	.nr_clk_ids		= G3D_NR_CLK,
+	.clk_regs		= g3d_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(g3d_clk_regs),
+	.clk_name		= "dout_g3d_switch",
+};
+
 /* ---- CMU_HSI ------------------------------------------------------------- */
 
 /* Register Offset definitions for CMU_HSI (0x13400000) */
@@ -1700,6 +1818,9 @@ static const struct of_device_id exynos850_cmu_of_match[] = {
 	}, {
 		.compatible = "samsung,exynos850-cmu-cmgp",
 		.data = &cmgp_cmu_info,
+	}, {
+		.compatible = "samsung,exynos850-cmu-g3d",
+		.data = &g3d_cmu_info,
 	}, {
 		.compatible = "samsung,exynos850-cmu-hsi",
 		.data = &hsi_cmu_info,
-- 
2.39.1

