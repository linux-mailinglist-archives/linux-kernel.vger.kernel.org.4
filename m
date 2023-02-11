Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4D2692EE0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBKGkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBKGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:39:57 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5A91ABD3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:39:55 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id t5so6279941oiw.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F77cVAHOLN946EiQXgu7pUkEqGi9qC3ggnneOj2DPRg=;
        b=MuHnGp8BGgTKrl7rHQxeweKPBZ0Rd0U/h+CHceRfFq6GO6xVEYCLyo4nf3L3Ma39C5
         LfJyty3nt99zu2tjh8VCq1PmPVba8WklvbZJCyxsCrnWEDEi47u5JJvHXJOSoMdwOFG7
         ibxu7I/XZo10eL8opyDOS3G7NUShjy8UvMsYGFUF6RbchiqJpfek8GMrLEfKKKfYmyNR
         3ZGCN8P7CoEKFAtHG0v2hKb4DjYerYLU2wbLnxObqDsHp/E/8Euwj5p00xRYFLFy6zNk
         tHJFbKw1bwNFAC+wQpcfWDh54GQMFqHt3g6vz+MRBjNajELEARczcxCShwZyWfry47w6
         pBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F77cVAHOLN946EiQXgu7pUkEqGi9qC3ggnneOj2DPRg=;
        b=hzGyS/08Japl3/LpRLO9Umt1Bxzro5VQSaUymmIw2NfD2Ls+X/acL8alQ/EVsbnzSg
         vYViz/Mv4/TAyndkOx7W2+aJxJ/sXXyu/yKHsPYUa3Utqyu9DZcxJ60Eh2hISQCEsTef
         cIRYtZ2zo7SX04t6w/po85NatQpKa2pfLtNbMZMT8QVW1628EfBCuGFtofe3BFOTvDhX
         OKJ2bytxjVsols11V3aLeH+NNCoAm8DHfoJ9vomF2gLp8AEFIYOUZfRZvUmAHTEI54a8
         u004DIIWQobjRDRyP+a8OHbvwPmLF361b7aZr8DTEX2x7O6FVWHkhW0p/zSeqRWrqLNi
         FuHA==
X-Gm-Message-State: AO0yUKXfZIosA7geIHtwrNM6IHexWW036H8+bi6/OCLwMZpXfnRAhl6x
        SrYmy8/k3QtmAL1wVlot/dJr0A==
X-Google-Smtp-Source: AK7set8cLiDOOtHA7+YE7bblkQb5MmgAo0tbtORA9Eqovmdrn5zmNPV68XupaumVsRRCkp6C/RalWg==
X-Received: by 2002:a05:6808:b3a:b0:378:974b:4fe6 with SMTP id t26-20020a0568080b3a00b00378974b4fe6mr8628625oij.8.1676097594521;
        Fri, 10 Feb 2023 22:39:54 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id b13-20020aca220d000000b0037d743b5cb7sm798651oic.17.2023.02.10.22.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 22:39:54 -0800 (PST)
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
Subject: [PATCH 5/6] clk: samsung: exynos850: Add AUD and HSI main gate clocks
Date:   Sat, 11 Feb 2023 00:40:05 -0600
Message-Id: <20230211064006.14981-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211064006.14981-1-semen.protsenko@linaro.org>
References: <20230211064006.14981-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add main gate clocks for controlling AUD and HSI CMUs:
  - gout_aud_cmu_aud_pclk
  - gout_hsi_cmu_hsi_pclk

Those clocks were marked as CLK_IGNORE_UNUSED, as system hangs on
boot otherwise.

While at it, add missing PPMU (Performance Profiling Monitor Unit)
clocks for CMU_HSI.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos850.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index a24eff42baae..3d776d57cc8f 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -674,6 +674,7 @@ static const struct samsung_cmu_info apm_cmu_info __initconst = {
 #define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF4	0x2014
 #define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF5	0x2018
 #define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF6	0x201c
+#define CLK_CON_GAT_CLK_AUD_CMU_AUD_PCLK	0x2020
 #define CLK_CON_GAT_GOUT_AUD_ABOX_ACLK		0x2048
 #define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_SPDY	0x204c
 #define CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_ASB	0x2050
@@ -729,6 +730,7 @@ static const unsigned long aud_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF4,
 	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF5,
 	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF6,
+	CLK_CON_GAT_CLK_AUD_CMU_AUD_PCLK,
 	CLK_CON_GAT_GOUT_AUD_ABOX_ACLK,
 	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_SPDY,
 	CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_ASB,
@@ -848,6 +850,9 @@ static const struct samsung_div_clock aud_div_clks[] __initconst = {
 };
 
 static const struct samsung_gate_clock aud_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_AUD_CMU_AUD_PCLK, "gout_aud_cmu_aud_pclk",
+	     "dout_aud_busd",
+	     CLK_CON_GAT_CLK_AUD_CMU_AUD_PCLK, 21, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_GOUT_AUD_CA32_CCLK, "gout_aud_ca32_cclk", "mout_aud_cpu_hch",
 	     CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_CA32, 21, 0, 0),
 	GATE(CLK_GOUT_AUD_ASB_CCLK, "gout_aud_asb_cclk", "dout_aud_cpu_aclk",
@@ -1117,12 +1122,15 @@ static const struct samsung_cmu_info g3d_cmu_info __initconst = {
 #define PLL_CON0_MUX_CLKCMU_HSI_MMC_CARD_USER			0x0610
 #define PLL_CON0_MUX_CLKCMU_HSI_USB20DRD_USER			0x0620
 #define CLK_CON_MUX_MUX_CLK_HSI_RTC				0x1000
+#define CLK_CON_GAT_CLK_HSI_CMU_HSI_PCLK			0x2000
 #define CLK_CON_GAT_HSI_USB20DRD_TOP_I_RTC_CLK__ALV		0x2008
 #define CLK_CON_GAT_HSI_USB20DRD_TOP_I_REF_CLK_50		0x200c
 #define CLK_CON_GAT_HSI_USB20DRD_TOP_I_PHY_REFCLK_26		0x2010
 #define CLK_CON_GAT_GOUT_HSI_GPIO_HSI_PCLK			0x2018
 #define CLK_CON_GAT_GOUT_HSI_MMC_CARD_I_ACLK			0x2024
 #define CLK_CON_GAT_GOUT_HSI_MMC_CARD_SDCLKIN			0x2028
+#define CLK_CON_GAT_GOUT_HSI_PPMU_ACLK				0x202c
+#define CLK_CON_GAT_GOUT_HSI_PPMU_PCLK				0x2030
 #define CLK_CON_GAT_GOUT_HSI_SYSREG_HSI_PCLK			0x2038
 #define CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_ACLK_PHYCTRL_20	0x203c
 #define CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_BUS_CLK_EARLY		0x2040
@@ -1132,12 +1140,15 @@ static const unsigned long hsi_clk_regs[] __initconst = {
 	PLL_CON0_MUX_CLKCMU_HSI_MMC_CARD_USER,
 	PLL_CON0_MUX_CLKCMU_HSI_USB20DRD_USER,
 	CLK_CON_MUX_MUX_CLK_HSI_RTC,
+	CLK_CON_GAT_CLK_HSI_CMU_HSI_PCLK,
 	CLK_CON_GAT_HSI_USB20DRD_TOP_I_RTC_CLK__ALV,
 	CLK_CON_GAT_HSI_USB20DRD_TOP_I_REF_CLK_50,
 	CLK_CON_GAT_HSI_USB20DRD_TOP_I_PHY_REFCLK_26,
 	CLK_CON_GAT_GOUT_HSI_GPIO_HSI_PCLK,
 	CLK_CON_GAT_GOUT_HSI_MMC_CARD_I_ACLK,
 	CLK_CON_GAT_GOUT_HSI_MMC_CARD_SDCLKIN,
+	CLK_CON_GAT_GOUT_HSI_PPMU_ACLK,
+	CLK_CON_GAT_GOUT_HSI_PPMU_PCLK,
 	CLK_CON_GAT_GOUT_HSI_SYSREG_HSI_PCLK,
 	CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_ACLK_PHYCTRL_20,
 	CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_BUS_CLK_EARLY,
@@ -1163,6 +1174,9 @@ static const struct samsung_mux_clock hsi_mux_clks[] __initconst = {
 };
 
 static const struct samsung_gate_clock hsi_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_HSI_CMU_HSI_PCLK, "gout_hsi_cmu_hsi_pclk",
+	     "mout_hsi_bus_user",
+	     CLK_CON_GAT_CLK_HSI_CMU_HSI_PCLK, 21, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_GOUT_USB_RTC_CLK, "gout_usb_rtc", "mout_hsi_rtc",
 	     CLK_CON_GAT_HSI_USB20DRD_TOP_I_RTC_CLK__ALV, 21, 0, 0),
 	GATE(CLK_GOUT_USB_REF_CLK, "gout_usb_ref", "mout_hsi_usb20drd_user",
@@ -1177,6 +1191,10 @@ static const struct samsung_gate_clock hsi_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_MMC_CARD_SDCLKIN, "gout_mmc_card_sdclkin",
 	     "mout_hsi_mmc_card_user",
 	     CLK_CON_GAT_GOUT_HSI_MMC_CARD_SDCLKIN, 21, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_GOUT_HSI_PPMU_ACLK, "gout_hsi_ppmu_aclk", "mout_hsi_bus_user",
+	     CLK_CON_GAT_GOUT_HSI_PPMU_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_HSI_PPMU_PCLK, "gout_hsi_ppmu_pclk", "mout_hsi_bus_user",
+	     CLK_CON_GAT_GOUT_HSI_PPMU_PCLK, 21, 0, 0),
 	GATE(CLK_GOUT_SYSREG_HSI_PCLK, "gout_sysreg_hsi_pclk",
 	     "mout_hsi_bus_user",
 	     CLK_CON_GAT_GOUT_HSI_SYSREG_HSI_PCLK, 21, 0, 0),
-- 
2.39.1

