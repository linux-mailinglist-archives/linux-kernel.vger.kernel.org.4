Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2395F6C230D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCTUmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjCTUmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:42:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566A838E86;
        Mon, 20 Mar 2023 13:41:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id bc12so13245751plb.0;
        Mon, 20 Mar 2023 13:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679344899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkALHQCFG+C3/6EbCgaqcXTs7mWkVNlDLK3Ss/73Xio=;
        b=W4Yd0ngbXSAWA1z1wsrPDzqsW8VfzLrvcB8JQT+UzfHcZhmtCmuMya4IodOpxrcJCZ
         pqj7xW5FDHUdaKP53t+ndZLfuJ/eDGpCnCDwQS5ZeHokJsCN9PP0MZXdK/9akuuMzOoN
         rL75rmgGDo99khmBW6E5GejOMTFGaK/RY/IcEkcqPE/pZRAdtPoNybfgX0JdsJYzmNm3
         ZWamLXvnA3bOD7TaeV7W9AOSY5fdJ5kS/JUFa9mAHdEN3N9FLulloyEhYsXzA2uV2/cG
         P3IzwVDUcB/U+kQD7dpxUyB7E6poKkhd6lf5M3llFvkf/acptQPB1RWKc9Hv3/zwDzLE
         miZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkALHQCFG+C3/6EbCgaqcXTs7mWkVNlDLK3Ss/73Xio=;
        b=K5t0h2PnysrAYIwX5l36lY30A1lC/8B2rSLtWFZ0ANH/ERywSq9ssqgn/qhnFRr+Sq
         1FahqajqdQT/JIV7yVJUH/1vklk5j1wo7WZxXi5GG+mT9KlNW2FrWaceMdRWStOxo8Bf
         RQCJXy3cnLWkHtvQqQGE6xAeY7SEkrJHBI0iuC1EGF+oTZX1vQYk8IGTGZ3maSKle03k
         X7NJs3W5huJJc6mn1w/j4lDnyFHQd3aOTf5cjwHWM5nHygLUbA3KEfDtrEaAkD8NJtv8
         cMj6GgHb7iq1O/l3PK3Aj2QM8sc6g/eWS20PdzV/B8UzZt+kRpQVuzaDu1LObHBP2oiP
         KOkw==
X-Gm-Message-State: AO0yUKWya82oxFWYKEfCJropPHfAnSEbYnmA4UDnfcbf9A3tZq6eFEeD
        tLR6nSWMRt3y90bQHYlhJ5Q=
X-Google-Smtp-Source: AK7set839vciAiWmLIKxjdCr5X0rWeZqktnXf2aoMMmh0LsA5sp/hxZPjH/oNhjZKCpYrIxuuslUcw==
X-Received: by 2002:a17:90b:3e88:b0:234:b964:5703 with SMTP id rj8-20020a17090b3e8800b00234b9645703mr482092pjb.18.1679344899520;
        Mon, 20 Mar 2023 13:41:39 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090aa60300b0023b29b464f9sm6580943pjq.27.2023.03.20.13.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:41:39 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] clk: hisilicon: Add CRG driver for Hi3798MV100 SoC
Date:   Tue, 21 Mar 2023 04:40:38 +0800
Message-Id: <20230320204042.980708-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320204042.980708-1-mmyangfl@gmail.com>
References: <20230320204042.980708-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CRG driver for Hi3798MV100 SoC. CRG (Clock and Reset Generator) module
generates clock and reset signals used by other module blocks on SoC.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg-hi3798.c | 203 +++++++++++++++++++++++++++--
 1 file changed, 189 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index 0b29c01c6..3a8d70b7c 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -40,6 +40,9 @@
 #define HI3798_FIXED_166P5M		84
 #define HI3798_SDIO0_MUX			85
 #define HI3798_COMBPHY0_MUX		86
+#define HI3798_FIXED_3M				87
+#define HI3798_FIXED_15M			88
+#define HI3798_FIXED_83P3M			89
 
 #define HI3798_CRG_NR_CLKS			128
 
@@ -47,13 +50,16 @@ static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
 	{ HISTB_OSC_CLK, "clk_osc", NULL, 0, 24000000, },
 	{ HISTB_APB_CLK, "clk_apb", NULL, 0, 100000000, },
 	{ HISTB_AHB_CLK, "clk_ahb", NULL, 0, 200000000, },
+	{ HI3798_FIXED_3M, "3m", NULL, 0, 3000000, },
 	{ HI3798_FIXED_12M, "12m", NULL, 0, 12000000, },
+	{ HI3798_FIXED_15M, "15m", NULL, 0, 15000000, },
 	{ HI3798_FIXED_24M, "24m", NULL, 0, 24000000, },
 	{ HI3798_FIXED_25M, "25m", NULL, 0, 25000000, },
 	{ HI3798_FIXED_48M, "48m", NULL, 0, 48000000, },
 	{ HI3798_FIXED_50M, "50m", NULL, 0, 50000000, },
 	{ HI3798_FIXED_60M, "60m", NULL, 0, 60000000, },
 	{ HI3798_FIXED_75M, "75m", NULL, 0, 75000000, },
+	{ HI3798_FIXED_83P3M, "83p3m", NULL, 0, 83333333, },
 	{ HI3798_FIXED_100M, "100m", NULL, 0, 100000000, },
 	{ HI3798_FIXED_150M, "150m", NULL, 0, 150000000, },
 	{ HI3798_FIXED_166P5M, "166p5m", NULL, 0, 165000000, },
@@ -306,6 +312,183 @@ static void hi3798_sysctrl_clk_unregister(
 	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, crg->clk_data);
 }
 
+/* hi3798MV100 */
+
+static const char *const hi3798mv100_mmc_mux_p[] = {
+		"75m", "100m", "50m", "15m" };
+static u32 hi3798mv100_mmc_mux_table[] = {0, 1, 2, 3};
+
+static struct hisi_mux_clock hi3798mv100_mux_clks[] = {
+	{ HI3798_MMC_MUX, "mmc_mux", hi3798mv100_mmc_mux_p,
+		ARRAY_SIZE(hi3798mv100_mmc_mux_p), CLK_SET_RATE_PARENT,
+		0xa0, 8, 2, 0, hi3798mv100_mmc_mux_table, },
+	{ HI3798_SDIO0_MUX, "sdio0_mux", hi3798mv100_mmc_mux_p,
+		ARRAY_SIZE(hi3798mv100_mmc_mux_p), CLK_SET_RATE_PARENT,
+		0x9c, 8, 2, 0, hi3798mv100_mmc_mux_table, },
+};
+
+static u32 mmc_phase_regvals[] = {0, 1, 2, 3, 4, 5, 6, 7};
+static u32 mmc_phase_degrees[] = {0, 45, 90, 135, 180, 225, 270, 315};
+
+static struct hisi_phase_clock hi3798mv100_phase_clks[] = {
+	{ HISTB_MMC_SAMPLE_CLK, "mmc_sample", "clk_mmc_ciu",
+		CLK_SET_RATE_PARENT, 0xa0, 12, 3, mmc_phase_degrees,
+		mmc_phase_regvals, ARRAY_SIZE(mmc_phase_regvals) },
+	{ HISTB_MMC_DRV_CLK, "mmc_drive", "clk_mmc_ciu",
+		CLK_SET_RATE_PARENT, 0xa0, 16, 3, mmc_phase_degrees,
+		mmc_phase_regvals, ARRAY_SIZE(mmc_phase_regvals) },
+};
+
+static const struct hisi_gate_clock hi3798mv100_gate_clks[] = {
+	/* NAND */
+	/* hi3798MV100 NAND driver does not get into mainline yet,
+	 * expose these clocks when it gets ready */
+	/* { HISTB_NAND_CLK, "clk_nand", "clk_apb",
+		CLK_SET_RATE_PARENT, 0x60, 0, 0, }, */
+	/* UART */
+	{ HISTB_UART1_CLK, "clk_uart1", "3m",
+		CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x68, 0, 0, },
+	{ HISTB_UART2_CLK, "clk_uart2", "83p3m",
+		CLK_SET_RATE_PARENT, 0x68, 4, 0, },
+	/* I2C */
+	{ HISTB_I2C0_CLK, "clk_i2c0", "clk_apb",
+		CLK_SET_RATE_PARENT, 0x6C, 4, 0, },
+	{ HISTB_I2C1_CLK, "clk_i2c1", "clk_apb",
+		CLK_SET_RATE_PARENT, 0x6C, 8, 0, },
+	{ HISTB_I2C2_CLK, "clk_i2c2", "clk_apb",
+		CLK_SET_RATE_PARENT, 0x6C, 12, 0, },
+	/* SPI */
+	{ HISTB_SPI0_CLK, "clk_spi0", "clk_apb",
+		CLK_SET_RATE_PARENT, 0x70, 0, 0, },
+	/* SDIO */
+	{ HISTB_SDIO0_BIU_CLK, "clk_sdio0_biu", "200m",
+		CLK_SET_RATE_PARENT, 0x9c, 0, 0, },
+	{ HISTB_SDIO0_CIU_CLK, "clk_sdio0_ciu", "sdio0_mux",
+		CLK_SET_RATE_PARENT, 0x9c, 1, 0, },
+	/* EMMC */
+	{ HISTB_MMC_BIU_CLK, "clk_mmc_biu", "200m",
+		CLK_SET_RATE_PARENT, 0xa0, 0, 0, },
+	{ HISTB_MMC_CIU_CLK, "clk_mmc_ciu", "mmc_mux",
+		CLK_SET_RATE_PARENT, 0xa0, 1, 0, },
+	/* USB2 */
+	{ HISTB_USB2_BUS_CLK, "clk_u2_bus", "clk_ahb",
+		CLK_SET_RATE_PARENT, 0xb8, 0, 0, },
+	{ HISTB_USB2_PHY_CLK, "clk_u2_phy", "60m",
+		CLK_SET_RATE_PARENT, 0xb8, 4, 0, },
+	{ HISTB_USB2_12M_CLK, "clk_u2_12m", "12m",
+		CLK_SET_RATE_PARENT, 0xb8, 2, 0 },
+	{ HISTB_USB2_48M_CLK, "clk_u2_48m", "48m",
+		CLK_SET_RATE_PARENT, 0xb8, 1, 0 },
+	{ HISTB_USB2_UTMI_CLK, "clk_u2_utmi", "60m",
+		CLK_SET_RATE_PARENT, 0xb8, 5, 0 },
+	{ HISTB_USB2_UTMI_CLK1, "clk_u2_utmi1", "60m",
+		CLK_SET_RATE_PARENT, 0xb8, 6, 0 },
+	{ HISTB_USB2_OTG_UTMI_CLK, "clk_u2_otg_utmi", "60m",
+		CLK_SET_RATE_PARENT, 0xb8, 3, 0 },
+	{ HISTB_USB2_PHY1_REF_CLK, "clk_u2_phy1_ref", "24m",
+		CLK_SET_RATE_PARENT, 0xbc, 0, 0 },
+	{ HISTB_USB2_PHY2_REF_CLK, "clk_u2_phy2_ref", "24m",
+		CLK_SET_RATE_PARENT, 0xbc, 2, 0 },
+	/* USB2 2 */
+	{ HISTB_USB2_2_BUS_CLK, "clk_u2_2_bus", "clk_ahb",
+		CLK_SET_RATE_PARENT, 0x198, 0, 0, },
+	{ HISTB_USB2_2_PHY_CLK, "clk_u2_2_phy", "60m",
+		CLK_SET_RATE_PARENT, 0x198, 4, 0, },
+	{ HISTB_USB2_2_12M_CLK, "clk_u2_2_12m", "12m",
+		CLK_SET_RATE_PARENT, 0x198, 2, 0 },
+	{ HISTB_USB2_2_48M_CLK, "clk_u2_2_48m", "48m",
+		CLK_SET_RATE_PARENT, 0x198, 1, 0 },
+	{ HISTB_USB2_2_UTMI_CLK, "clk_u2_2_utmi", "60m",
+		CLK_SET_RATE_PARENT, 0x198, 5, 0 },
+	{ HISTB_USB2_2_UTMI_CLK1, "clk_u2_2_utmi1", "60m",
+		CLK_SET_RATE_PARENT, 0x198, 6, 0 },
+	{ HISTB_USB2_2_OTG_UTMI_CLK, "clk_u2_2_otg_utmi", "60m",
+		CLK_SET_RATE_PARENT, 0x198, 3, 0 },
+	{ HISTB_USB2_2_PHY1_REF_CLK, "clk_u2_2_phy1_ref", "24m",
+		CLK_SET_RATE_PARENT, 0x190, 0, 0 },
+	{ HISTB_USB2_2_PHY2_REF_CLK, "clk_u2_2_phy2_ref", "24m",
+		CLK_SET_RATE_PARENT, 0x190, 2, 0 },
+	/* USB3 */
+	{ HISTB_USB3_BUS_CLK, "clk_u3_bus", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 0, 0 },
+	{ HISTB_USB3_UTMI_CLK, "clk_u3_utmi", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 4, 0 },
+	{ HISTB_USB3_PIPE_CLK, "clk_u3_pipe", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 3, 0 },
+	{ HISTB_USB3_SUSPEND_CLK, "clk_u3_suspend", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 2, 0 },
+	/* GPU */
+	{ HISTB_GPU_BUS_CLK, "clk_gpu", "200m",
+		CLK_SET_RATE_PARENT, 0xd4, 0, 0 },
+	/* FEPHY */
+	{ HISTB_FEPHY_CLK, "clk_fephy", "25m",
+		CLK_SET_RATE_PARENT, 0x120, 0, 0, },
+};
+
+static const struct hi3798_complex_clock hi3798mv100_complex_clks[] = {
+	{ HISTB_ETH0_MAC_CLK, "clk_mac0", NULL,
+		CLK_SET_RATE_PARENT, 0xcc, 0xf, 0xb, },
+	{ HISTB_GPU_CORE_CLK, "clk_gpu_gp", "200m",
+		CLK_SET_RATE_PARENT, 0xd4, 0x700, 0x700, },
+};
+
+static const struct hi3798_clks hi3798mv100_crg_clks = {
+	.gate_clks = hi3798mv100_gate_clks,
+	.gate_clks_nums = ARRAY_SIZE(hi3798mv100_gate_clks),
+	.mux_clks = hi3798mv100_mux_clks,
+	.mux_clks_nums = ARRAY_SIZE(hi3798mv100_mux_clks),
+	.phase_clks = hi3798mv100_phase_clks,
+	.phase_clks_nums = ARRAY_SIZE(hi3798mv100_phase_clks),
+	.complex_clks = hi3798mv100_complex_clks,
+	.complex_clks_nums = ARRAY_SIZE(hi3798mv100_complex_clks),
+};
+
+static struct hisi_clock_data *hi3798mv100_clk_register(
+				struct platform_device *pdev)
+{
+	return hi3798_clk_register(pdev, &hi3798mv100_crg_clks);
+}
+
+static void hi3798mv100_clk_unregister(struct platform_device *pdev)
+{
+	hi3798_clk_unregister(pdev, &hi3798mv100_crg_clks);
+}
+
+static const struct hisi_crg_funcs hi3798mv100_crg_funcs = {
+	.register_clks = hi3798mv100_clk_register,
+	.unregister_clks = hi3798mv100_clk_unregister,
+};
+
+static const struct hisi_gate_clock hi3798mv100_sysctrl_gate_clks[] = {
+	{ HISTB_IR_CLK, "clk_ir", "24m",
+		CLK_SET_RATE_PARENT, 0x48, 4, 0, },
+	{ HISTB_TIMER01_CLK, "clk_timer01", "24m",
+		CLK_SET_RATE_PARENT, 0x48, 6, 0, },
+	{ HISTB_UART0_CLK, "clk_uart0", "83p3m",
+		CLK_SET_RATE_PARENT, 0x48, 12, 0, },
+};
+
+static const struct hi3798_clks hi3798mv100_sysctrl_clks = {
+	.gate_clks = hi3798mv100_sysctrl_gate_clks,
+	.gate_clks_nums = ARRAY_SIZE(hi3798mv100_sysctrl_gate_clks),
+};
+
+static struct hisi_clock_data *hi3798mv100_sysctrl_clk_register(
+					struct platform_device *pdev)
+{
+	return hi3798_sysctrl_clk_register(pdev, &hi3798mv100_sysctrl_clks);
+}
+
+static void hi3798mv100_sysctrl_clk_unregister(struct platform_device *pdev)
+{
+	hi3798_sysctrl_clk_unregister(pdev, &hi3798mv100_sysctrl_clks);
+}
+
+static const struct hisi_crg_funcs hi3798mv100_sysctrl_funcs = {
+	.register_clks = hi3798mv100_sysctrl_clk_register,
+	.unregister_clks = hi3798mv100_sysctrl_clk_unregister,
+};
+
 /* hi3798CV200 */
 
 static const char *const hi3798cv200_mmc_mux_p[] = {
@@ -335,18 +518,6 @@ static struct hisi_mux_clock hi3798cv200_mux_clks[] = {
 		0x9c, 8, 2, 0, hi3798cv200_sdio_mux_table, },
 };
 
-static u32 mmc_phase_regvals[] = {0, 1, 2, 3, 4, 5, 6, 7};
-static u32 mmc_phase_degrees[] = {0, 45, 90, 135, 180, 225, 270, 315};
-
-static struct hisi_phase_clock hi3798cv200_phase_clks[] = {
-	{ HISTB_MMC_SAMPLE_CLK, "mmc_sample", "clk_mmc_ciu",
-		CLK_SET_RATE_PARENT, 0xa0, 12, 3, mmc_phase_degrees,
-		mmc_phase_regvals, ARRAY_SIZE(mmc_phase_regvals) },
-	{ HISTB_MMC_DRV_CLK, "mmc_drive", "clk_mmc_ciu",
-		CLK_SET_RATE_PARENT, 0xa0, 16, 3, mmc_phase_degrees,
-		mmc_phase_regvals, ARRAY_SIZE(mmc_phase_regvals) },
-};
-
 static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 	/* UART */
 	{ HISTB_UART2_CLK, "clk_uart2", "75m",
@@ -448,8 +619,8 @@ static const struct hi3798_clks hi3798cv200_crg_clks = {
 	.gate_clks_nums = ARRAY_SIZE(hi3798cv200_gate_clks),
 	.mux_clks = hi3798cv200_mux_clks,
 	.mux_clks_nums = ARRAY_SIZE(hi3798cv200_mux_clks),
-	.phase_clks = hi3798cv200_phase_clks,
-	.phase_clks_nums = ARRAY_SIZE(hi3798cv200_phase_clks),
+	.phase_clks = hi3798mv100_phase_clks,
+	.phase_clks_nums = ARRAY_SIZE(hi3798mv100_phase_clks),
 };
 
 static struct hisi_clock_data *hi3798cv200_clk_register(
@@ -499,6 +670,10 @@ static const struct hisi_crg_funcs hi3798cv200_sysctrl_funcs = {
 };
 
 static const struct of_device_id hi3798_crg_match_table[] = {
+	{ .compatible = "hisilicon,hi3798mv100-crg",
+		.data = &hi3798mv100_crg_funcs },
+	{ .compatible = "hisilicon,hi3798mv100-sysctrl",
+		.data = &hi3798mv100_sysctrl_funcs },
 	{ .compatible = "hisilicon,hi3798cv200-crg",
 		.data = &hi3798cv200_crg_funcs },
 	{ .compatible = "hisilicon,hi3798cv200-sysctrl",
-- 
2.39.2

