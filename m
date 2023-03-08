Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4646B16AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCHXix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCHXid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:38:33 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C7580E0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:38:30 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id be16so416011oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678318710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhdSRqJaGfztHCYkWeNpp02lhvYbsG6+3kQCkkXc7Pc=;
        b=myK0jC+/mCPv7bj4QZjfKujIW7s5qz4C4CX+hrTsKV0Ed2EcuIjpHKLR2ZVa2Q0lKT
         1WDrcUgQmd+9rr7lZg1UzoTZmzQcwMIxwVhjJBlWSkAz5YDruoqRks2ox9oJfMkZ2AR/
         x0xYrt0Al4un/UhGeMGmiYZsHgSW9N1rCq75w7c6ENYcw4ldbAfM2HQCHzp7aSGKKiST
         jXDhQF+NMIxHO7JbBkl48Q42o5abcxJd6C2TGlUPdirgIJTZgQw5RxmdwLR+pv9TkQah
         3O/NFu1H/IH2BpSFtvvc2RLQfV7gXiE0mHh3nlgSFKVEgTqPul36zZvyYEBsPEX+uvKX
         XQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678318710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhdSRqJaGfztHCYkWeNpp02lhvYbsG6+3kQCkkXc7Pc=;
        b=DEeWCK6XmBAunDciA0wtDZX2sGQlLqFEu+Gbaec8eK7D5KqWMX3Z9nhjDRW13SAlJ/
         KwHNzy3qfHZF2xxUBLdfKVvPWu8XvWo85TtkHRoQXkMAyNc6opz5rNr5/bcyRauO204W
         GIsDJeKzIiSFZMf1wg3h79uPSYlXoXejiUx71FXYdxgHMg4LZdDLIdhMwKBxEMHURhbL
         7kElusSf/kLOAmTc2GRalMvMUO7Q1ttaBHs9iAU7nkP3wW5PISsz7xOLKXtz2ODGFRFU
         xzuk/8zRGJ43Iuap3Rlylr0aYI8pPTgRUAqmuyqvOHOpzlImX5ABewmmw3HtiAtm7w4X
         ldcQ==
X-Gm-Message-State: AO0yUKVKDe4Mw8UTgK0fAoxXRyMH3WfJTpVS529VYTCVX4IM06jQW2lj
        QV23f/C3OniU1JdyN/xD67xcfzNFpGWbPfVzqxpsBw==
X-Google-Smtp-Source: AK7set/5z392BFVptFZBGokctJdIkZ9WCLRF4yHopeCLA19ESHC4RJaazlSVqK2iAy92qLm8tsbZXA==
X-Received: by 2002:a05:6808:188:b0:384:232:2a4f with SMTP id w8-20020a056808018800b0038402322a4fmr7731504oic.4.1678318710527;
        Wed, 08 Mar 2023 15:38:30 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id f8-20020a9d2c08000000b00690dc5d9b9esm7021525otb.6.2023.03.08.15.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:38:30 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] clk: samsung: exynos850: Add suspend state for all CMUs
Date:   Wed,  8 Mar 2023 17:38:20 -0600
Message-Id: <20230308233822.31180-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308233822.31180-1-semen.protsenko@linaro.org>
References: <20230308233822.31180-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before entering suspend, some clocks must be set to some specific
configuration. For example, top-level MUX clocks in each CMU should be
switched to OSCCLK input, etc. This is needed by the firmware to
properly perform system suspend operation. Provide the suspend state for
mentioned clocks using 'suspend_regs' feature.

This patch was inspired by commit a766065279e2 ("clk: samsung:
exynos5433: Add suspend state for TOP, CPIF & PERIC CMUs").

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos850.c | 92 +++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index 98b23af7324d..5664d17bae83 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -186,6 +186,12 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_GAT_GATE_CLKCMU_PERI_UART,
 };
 
+static const struct samsung_clk_reg_dump top_suspend_regs[] = {
+	{ PLL_CON0_PLL_MMC, 0 },
+	{ PLL_CON0_PLL_SHARED0, 0 },
+	{ PLL_CON0_PLL_SHARED1, 0 },
+};
+
 /*
  * Do not provide PLL tables to core PLLs, as MANUAL_PLL_CTRL bit is not set
  * for those PLLs by default, so set_rate operation would fail.
@@ -489,6 +495,8 @@ static const struct samsung_cmu_info top_cmu_info __initconst = {
 	.nr_clk_ids		= TOP_NR_CLK,
 	.clk_regs		= top_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(top_clk_regs),
+	.suspend_regs		= top_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(top_suspend_regs),
 };
 
 static void __init exynos850_cmu_top_init(struct device_node *np)
@@ -547,6 +555,13 @@ static const unsigned long apm_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_APM_SYSREG_APM_PCLK,
 };
 
+static const struct samsung_clk_reg_dump apm_suspend_regs[] = {
+	{ PLL_CON0_MUX_CLKCMU_APM_BUS_USER, 0 },
+	{ PLL_CON0_MUX_CLK_RCO_APM_I3C_USER, 0 },
+	{ PLL_CON0_MUX_CLK_RCO_APM_USER, 0 },
+	{ PLL_CON0_MUX_DLL_USER, 0 },
+};
+
 /* List of parent clocks for Muxes in CMU_APM */
 PNAME(mout_apm_bus_user_p)	= { "oscclk_rco_apm", "dout_clkcmu_apm_bus" };
 PNAME(mout_rco_apm_i3c_user_p)	= { "oscclk_rco_apm", "clk_rco_i3c_pmic" };
@@ -629,6 +644,8 @@ static const struct samsung_cmu_info apm_cmu_info __initconst = {
 	.nr_clk_ids		= APM_NR_CLK,
 	.clk_regs		= apm_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(apm_clk_regs),
+	.suspend_regs		= apm_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(apm_suspend_regs),
 	.clk_name		= "dout_clkcmu_apm_bus",
 };
 
@@ -746,6 +763,12 @@ static const unsigned long aud_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_AUD_WDT_PCLK,
 };
 
+static const struct samsung_clk_reg_dump aud_suspend_regs[] = {
+	{ PLL_CON0_PLL_AUD, 0 },
+	{ PLL_CON0_MUX_CLKCMU_AUD_CPU_USER, 0 },
+	{ PLL_CON0_MUX_TICK_USB_USER, 0 },
+};
+
 /* List of parent clocks for Muxes in CMU_AUD */
 PNAME(mout_aud_pll_p)		= { "oscclk", "fout_aud_pll" };
 PNAME(mout_aud_cpu_user_p)	= { "oscclk", "dout_aud" };
@@ -912,6 +935,8 @@ static const struct samsung_cmu_info aud_cmu_info __initconst = {
 	.nr_clk_ids		= AUD_NR_CLK,
 	.clk_regs		= aud_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(aud_clk_regs),
+	.suspend_regs		= aud_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(aud_suspend_regs),
 	.clk_name		= "dout_aud",
 };
 
@@ -950,6 +975,12 @@ static const unsigned long cmgp_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_CMGP_USI_CMGP1_PCLK,
 };
 
+static const struct samsung_clk_reg_dump cmgp_suspend_regs[] = {
+	{ CLK_CON_MUX_CLK_CMGP_ADC, 0 },
+	{ CLK_CON_MUX_MUX_CLK_CMGP_USI_CMGP0, 0 },
+	{ CLK_CON_MUX_MUX_CLK_CMGP_USI_CMGP1, 0 },
+};
+
 /* List of parent clocks for Muxes in CMU_CMGP */
 PNAME(mout_cmgp_usi0_p)	= { "clk_rco_cmgp", "gout_clkcmu_cmgp_bus" };
 PNAME(mout_cmgp_usi1_p)	= { "clk_rco_cmgp", "gout_clkcmu_cmgp_bus" };
@@ -1015,6 +1046,8 @@ static const struct samsung_cmu_info cmgp_cmu_info __initconst = {
 	.nr_clk_ids		= CMGP_NR_CLK,
 	.clk_regs		= cmgp_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(cmgp_clk_regs),
+	.suspend_regs		= cmgp_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(cmgp_suspend_regs),
 	.clk_name		= "gout_clkcmu_cmgp_bus",
 };
 
@@ -1051,6 +1084,11 @@ static const unsigned long g3d_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_G3D_SYSREG_PCLK,
 };
 
+static const struct samsung_clk_reg_dump g3d_suspend_regs[] = {
+	{ PLL_CON0_PLL_G3D, 0 },
+	{ PLL_CON0_MUX_CLKCMU_G3D_SWITCH_USER, 0 },
+};
+
 /* List of parent clocks for Muxes in CMU_G3D */
 PNAME(mout_g3d_pll_p)		= { "oscclk", "fout_g3d_pll" };
 PNAME(mout_g3d_switch_user_p)	= { "oscclk", "dout_g3d_switch" };
@@ -1111,6 +1149,8 @@ static const struct samsung_cmu_info g3d_cmu_info __initconst = {
 	.nr_clk_ids		= G3D_NR_CLK,
 	.clk_regs		= g3d_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(g3d_clk_regs),
+	.suspend_regs		= g3d_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(g3d_suspend_regs),
 	.clk_name		= "dout_g3d_switch",
 };
 
@@ -1153,6 +1193,13 @@ static const unsigned long hsi_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_BUS_CLK_EARLY,
 };
 
+static const struct samsung_clk_reg_dump hsi_suspend_regs[] = {
+	{ PLL_CON0_MUX_CLKCMU_HSI_BUS_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_HSI_MMC_CARD_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_HSI_USB20DRD_USER, 0 },
+	{ CLK_CON_MUX_MUX_CLK_HSI_RTC, 0 },
+};
+
 /* List of parent clocks for Muxes in CMU_HSI */
 PNAME(mout_hsi_bus_user_p)	= { "oscclk", "dout_hsi_bus" };
 PNAME(mout_hsi_mmc_card_user_p)	= { "oscclk", "dout_hsi_mmc_card" };
@@ -1213,6 +1260,8 @@ static const struct samsung_cmu_info hsi_cmu_info __initconst = {
 	.nr_clk_ids		= HSI_NR_CLK,
 	.clk_regs		= hsi_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(hsi_clk_regs),
+	.suspend_regs		= hsi_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(hsi_suspend_regs),
 	.clk_name		= "dout_hsi_bus",
 };
 
@@ -1268,6 +1317,13 @@ static const unsigned long is_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_IS_SYSREG_PCLK,
 };
 
+static const struct samsung_clk_reg_dump is_suspend_regs[] = {
+	{ PLL_CON0_MUX_CLKCMU_IS_BUS_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_IS_GDC_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_IS_ITP_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_IS_VRA_USER, 0 },
+};
+
 /* List of parent clocks for Muxes in CMU_IS */
 PNAME(mout_is_bus_user_p)	= { "oscclk", "dout_is_bus" };
 PNAME(mout_is_itp_user_p)	= { "oscclk", "dout_is_itp" };
@@ -1345,6 +1401,8 @@ static const struct samsung_cmu_info is_cmu_info __initconst = {
 	.nr_clk_ids		= IS_NR_CLK,
 	.clk_regs		= is_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(is_clk_regs),
+	.suspend_regs		= is_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(is_suspend_regs),
 	.clk_name		= "dout_is_bus",
 };
 
@@ -1384,6 +1442,13 @@ static const unsigned long mfcmscl_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_MFCMSCL_SYSREG_PCLK,
 };
 
+static const struct samsung_clk_reg_dump mfcmscl_suspend_regs[] = {
+	{ PLL_CON0_MUX_CLKCMU_MFCMSCL_JPEG_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_MFCMSCL_M2M_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_MFCMSCL_MCSC_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_MFCMSCL_MFC_USER, 0 },
+};
+
 /* List of parent clocks for Muxes in CMU_MFCMSCL */
 PNAME(mout_mfcmscl_mfc_user_p)	= { "oscclk", "dout_mfcmscl_mfc" };
 PNAME(mout_mfcmscl_m2m_user_p)	= { "oscclk", "dout_mfcmscl_m2m" };
@@ -1454,6 +1519,8 @@ static const struct samsung_cmu_info mfcmscl_cmu_info __initconst = {
 	.nr_clk_ids		= MFCMSCL_NR_CLK,
 	.clk_regs		= mfcmscl_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(mfcmscl_clk_regs),
+	.suspend_regs		= mfcmscl_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(mfcmscl_suspend_regs),
 	.clk_name		= "dout_mfcmscl_mfc",
 };
 
@@ -1532,6 +1599,13 @@ static const unsigned long peri_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_PERI_WDT_1_PCLK,
 };
 
+static const struct samsung_clk_reg_dump peri_suspend_regs[] = {
+	{ PLL_CON0_MUX_CLKCMU_PERI_BUS_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_PERI_HSI2C_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_PERI_SPI_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_PERI_UART_USER, 0 },
+};
+
 /* List of parent clocks for Muxes in CMU_PERI */
 PNAME(mout_peri_bus_user_p)	= { "oscclk", "dout_peri_bus" };
 PNAME(mout_peri_uart_user_p)	= { "oscclk", "dout_peri_uart" };
@@ -1629,6 +1703,8 @@ static const struct samsung_cmu_info peri_cmu_info __initconst = {
 	.nr_clk_ids		= PERI_NR_CLK,
 	.clk_regs		= peri_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(peri_clk_regs),
+	.suspend_regs		= peri_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(peri_suspend_regs),
 	.clk_name		= "dout_peri_bus",
 };
 
@@ -1676,6 +1752,14 @@ static const unsigned long core_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_CORE_SYSREG_CORE_PCLK,
 };
 
+static const struct samsung_clk_reg_dump core_suspend_regs[] = {
+	{ PLL_CON0_MUX_CLKCMU_CORE_BUS_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_CORE_CCI_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_CORE_MMC_EMBD_USER, 0 },
+	{ PLL_CON0_MUX_CLKCMU_CORE_SSS_USER, 0 },
+	{ CLK_CON_MUX_MUX_CLK_CORE_GIC, 0x1 },
+};
+
 /* List of parent clocks for Muxes in CMU_CORE */
 PNAME(mout_core_bus_user_p)		= { "oscclk", "dout_core_bus" };
 PNAME(mout_core_cci_user_p)		= { "oscclk", "dout_core_cci" };
@@ -1736,6 +1820,8 @@ static const struct samsung_cmu_info core_cmu_info __initconst = {
 	.nr_clk_ids		= CORE_NR_CLK,
 	.clk_regs		= core_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(core_clk_regs),
+	.suspend_regs		= core_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(core_suspend_regs),
 	.clk_name		= "dout_core_bus",
 };
 
@@ -1766,6 +1852,10 @@ static const unsigned long dpu_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_DPU_SYSREG_PCLK,
 };
 
+static const struct samsung_clk_reg_dump dpu_suspend_regs[] = {
+	{ PLL_CON0_MUX_CLKCMU_DPU_USER, 0 },
+};
+
 /* List of parent clocks for Muxes in CMU_DPU */
 PNAME(mout_dpu_user_p)		= { "oscclk", "dout_dpu" };
 
@@ -1810,6 +1900,8 @@ static const struct samsung_cmu_info dpu_cmu_info __initconst = {
 	.nr_clk_ids		= DPU_NR_CLK,
 	.clk_regs		= dpu_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(dpu_clk_regs),
+	.suspend_regs		= dpu_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(dpu_suspend_regs),
 	.clk_name		= "dout_dpu",
 };
 
-- 
2.39.2

