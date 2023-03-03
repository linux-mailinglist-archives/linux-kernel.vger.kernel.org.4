Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3305A6A9A70
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjCCPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCCPQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:16:39 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CEE1554D;
        Fri,  3 Mar 2023 07:16:22 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q23so1676925pgt.7;
        Fri, 03 Mar 2023 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677856582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrMn0SwpKPyx8iIIWVBsxNdVCt1aGQBV4CeIy3b7rNQ=;
        b=l4rHQ4gtdLbQ/zBuqFwiJPRCEHS5Lr226olBxaX5NHNmzQseDCUqI6Y68JKinig4lb
         0yflUxs5MAfAbwHhjaBRR9EBvNTyiwwcR1Ex1DmYO9GLPzROTqPo2t3vy2X1DhgOmfs/
         v4GKNE3YTYNnjRFTo+ZmWazPWeSwxeg4wOtnnSVOcALQ8c18ArdeRABSTYsAE/JpkwEE
         Sd/l08SgVyki2s2og55rOGjLhca+yPUZqt4O58OneNoUPpaI5zAEMIfe6Pf3BUPHm5OI
         8aij4WUmjMCpB28fRFYAVqkbUBRekp7mkoMsvrF3br4RmbpZBHOmzoanfgJJrI5ZeJn1
         lvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrMn0SwpKPyx8iIIWVBsxNdVCt1aGQBV4CeIy3b7rNQ=;
        b=VyLn4wyiMJA4qH7dzlyz8bl5Ws56nD4dTWaOTZLd/+m+DP7v0H59YZO/gRMhse1NFN
         t7MuAtZWLnuDlp18xVtgEyMpGQZOxbNg3l9pckV5YdiYRoFhXybq1SGL+eALOLj+fwUy
         eBaIbe50SzquO6bEBGWGiNcM3u43R0+KnPY4RV0bcaxSqlYwkiD2yRPVf9bQBlxDVEae
         ntkrO9qXMOmOgfBjf1vcBnGrnumyFdTgqRicTgUMSAa1HWz8J/uFYqHpjIrX0hMdhcp/
         2Ci62N+RKsIEdh0R4ofRpBCsPKdJeOPFgW/FdwHxKTDWKqYQ0ZkpVTWYQMwM26QvwJxn
         PIFg==
X-Gm-Message-State: AO0yUKUoFvQuvAuHByIfwXSKb6aRQxpqNHXRezHvWeDoGncvPXogjPPc
        EEDAYd3PHEK7uAUMKyBfrMM=
X-Google-Smtp-Source: AK7set9NMtdR3dGWqypqYSYbPUHxYAbFvdQ6mRRaZVIshBIZ/7aus+T1t9VanX6EHPC/M8w4j814Lg==
X-Received: by 2002:aa7:8f30:0:b0:5e8:6839:1f13 with SMTP id y16-20020aa78f30000000b005e868391f13mr2297215pfr.10.1677856582327;
        Fri, 03 Mar 2023 07:16:22 -0800 (PST)
Received: from y.ha.lan ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id p4-20020aa78604000000b005a8bdc18453sm1739721pfn.35.2023.03.03.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:16:21 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] clk: hisilicon: Add CRG driver for Hi3798MV100 SoC
Date:   Fri,  3 Mar 2023 23:14:13 +0800
Message-Id: <20230303151417.104321-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303151417.104321-1-mmyangfl@gmail.com>
References: <20230303151417.104321-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CRG driver for Hi3798MV100 SoC. CRG (Clock and Reset Generator) module
generates clock and reset signals used by other module blocks on SoC.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../devicetree/bindings/clock/hisi-crg.txt    |   2 +
 drivers/clk/hisilicon/crg-hi3798.c            | 193 ++++++++++++++++--
 include/dt-bindings/clock/histb-clock.h       |  11 +
 3 files changed, 192 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/hisi-crg.txt b/Documentation/devicetree/bindings/clock/hisi-crg.txt
index cc60b3d42..972c038c8 100644
--- a/Documentation/devicetree/bindings/clock/hisi-crg.txt
+++ b/Documentation/devicetree/bindings/clock/hisi-crg.txt
@@ -13,6 +13,8 @@ Required Properties:
   - "hisilicon,hi3516cv300-crg"
   - "hisilicon,hi3516cv300-sysctrl"
   - "hisilicon,hi3519-crg"
+  - "hisilicon,hi3798mv100-crg"
+  - "hisilicon,hi3798mv100-sysctrl"
   - "hisilicon,hi3798cv200-crg"
   - "hisilicon,hi3798cv200-sysctrl"
 
diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index 791d39e6a..095009c91 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -27,6 +27,7 @@
 #define HI3798_FIXED_300M			73
 #define HI3798_FIXED_400M			74
 #define HI3798_MMC_MUX			75
+#define HI3798_ETH_MUX			77
 #define HI3798_ETH_BUS0_CLK		78
 #define HI3798_ETH_BUS1_CLK		79
 #define HI3798_COMBPHY1_MUX		80
@@ -179,6 +180,178 @@ static void hi3798_sysctrl_clk_unregister(
 	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, crg->clk_data);
 }
 
+/* hi3798MV100 */
+
+static const char *const hi3798mv100_mmc_mux_p[] = {
+		"75m", "100m", "50m", "15m" };
+static u32 hi3798mv100_mmc_mux_table[] = {0, 1, 2, 3};
+
+static const char *const hi3798mv100_eth_mux_p[] = {
+		"83p3m" };
+static u32 hi3798mv100_eth_mux_table[] = {2};
+
+static struct hisi_mux_clock hi3798mv100_mux_clks[] = {
+	{ HI3798_MMC_MUX, "mmc_mux", hi3798mv100_mmc_mux_p,
+		ARRAY_SIZE(hi3798mv100_mmc_mux_p), CLK_SET_RATE_PARENT,
+		0xa0, 8, 2, 0, hi3798mv100_mmc_mux_table, },
+	{ HI3798_SDIO0_MUX, "sdio0_mux", hi3798mv100_mmc_mux_p,
+		ARRAY_SIZE(hi3798mv100_mmc_mux_p), CLK_SET_RATE_PARENT,
+		0x9c, 8, 2, 0, hi3798mv100_mmc_mux_table, },
+	{ HI3798_ETH_MUX, "eth_mux", hi3798mv100_eth_mux_p,
+		ARRAY_SIZE(hi3798mv100_eth_mux_p), CLK_SET_RATE_PARENT,
+		0xcc, 2, 2, 0, hi3798mv100_eth_mux_table, },
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
+	{ HISTB_NAND_CLK, "clk_nand", "clk_apb",
+		CLK_SET_RATE_PARENT, 0x60, 0, 0, },
+	/* UART */
+	{ HISTB_UART1_CLK, "clk_uart1", "3m",
+		CLK_SET_RATE_PARENT, 0x68, 0, 0, },
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
+	/* Ethernet */
+	{ HISTB_ETH_BUS_CLK, "clk_bus", NULL,
+		CLK_SET_RATE_PARENT, 0xcc, 0, 0, },
+	{ HISTB_ETH_PUB_CLK, "clk_pub", "eth_mux",
+		CLK_SET_RATE_PARENT, 0xcc, 1, 0, },
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
+};
+
+static const struct hi3798_crg_clks hi3798mv100_crg_clks_data = {
+	.phase_clks = hi3798mv100_phase_clks,
+	.phase_clks_nums = ARRAY_SIZE(hi3798mv100_phase_clks),
+	.mux_clks = hi3798mv100_mux_clks,
+	.mux_clks_nums = ARRAY_SIZE(hi3798mv100_mux_clks),
+	.gate_clks = hi3798mv100_gate_clks,
+	.gate_clks_nums = ARRAY_SIZE(hi3798mv100_gate_clks),
+};
+
+static struct hisi_clock_data *hi3798mv100_clk_register(
+				struct platform_device *pdev)
+{
+	return hi3798_clk_register(pdev, &hi3798mv100_crg_clks_data);
+}
+
+static void hi3798mv100_clk_unregister(struct platform_device *pdev)
+{
+	hi3798_clk_unregister(pdev, &hi3798mv100_crg_clks_data);
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
+static const struct hi3798_sysctrl_clks hi3798mv100_sysctrl_clks_data = {
+	.gate_clks = hi3798mv100_sysctrl_gate_clks,
+	.gate_clks_nums = ARRAY_SIZE(hi3798mv100_sysctrl_gate_clks),
+};
+
+static struct hisi_clock_data *hi3798mv100_sysctrl_clk_register(
+					struct platform_device *pdev)
+{
+	return hi3798_sysctrl_clk_register(pdev, &hi3798mv100_sysctrl_clks_data);
+}
+
+static void hi3798mv100_sysctrl_clk_unregister(struct platform_device *pdev)
+{
+	hi3798_sysctrl_clk_unregister(pdev, &hi3798mv100_sysctrl_clks_data);
+}
+
+static const struct hisi_crg_funcs hi3798mv100_sysctrl_funcs = {
+	.register_clks = hi3798mv100_sysctrl_clk_register,
+	.unregister_clks = hi3798mv100_sysctrl_clk_unregister,
+};
+
 /* hi3798CV200 */
 
 static const char *const hi3798cv200_mmc_mux_p[] = {
@@ -208,18 +381,6 @@ static struct hisi_mux_clock hi3798cv200_mux_clks[] = {
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
@@ -317,8 +478,8 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 };
 
 static const struct hi3798_crg_clks hi3798cv200_crg_clks_data = {
-	.phase_clks = hi3798cv200_phase_clks,
-	.phase_clks_nums = ARRAY_SIZE(hi3798cv200_phase_clks),
+	.phase_clks = hi3798mv100_phase_clks,
+	.phase_clks_nums = ARRAY_SIZE(hi3798mv100_phase_clks),
 	.mux_clks = hi3798cv200_mux_clks,
 	.mux_clks_nums = ARRAY_SIZE(hi3798cv200_mux_clks),
 	.gate_clks = hi3798cv200_gate_clks,
@@ -372,6 +533,10 @@ static const struct hisi_crg_funcs hi3798cv200_sysctrl_funcs = {
 };
 
 static const struct of_device_id hi3798_crg_match_table[] = {
+	{ .compatible = "hisilicon,hi3798mv100-crg",
+		.data = &hi3798mv100_crg_funcs },
+	{ .compatible = "hisilicon,hi3798mv100-sysctrl",
+		.data = &hi3798mv100_sysctrl_funcs },
 	{ .compatible = "hisilicon,hi3798cv200-crg",
 		.data = &hi3798cv200_crg_funcs },
 	{ .compatible = "hisilicon,hi3798cv200-sysctrl",
diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
index ed47c43c3..4fbf86e75 100644
--- a/include/dt-bindings/clock/histb-clock.h
+++ b/include/dt-bindings/clock/histb-clock.h
@@ -60,6 +60,17 @@
 #define HISTB_USB3_SUSPEND_CLK1		50
 #define HISTB_ETH_PUB_CLK			51
 #define HISTB_ETH_BUS_CLK			52
+#define HISTB_USB2_UTMI_CLK1		53
+#define HISTB_NAND_CLK			54
+#define HISTB_USB2_2_BUS_CLK		55
+#define HISTB_USB2_2_PHY_CLK		56
+#define HISTB_USB2_2_UTMI_CLK		57
+#define HISTB_USB2_2_UTMI_CLK1		58
+#define HISTB_USB2_2_12M_CLK		59
+#define HISTB_USB2_2_48M_CLK		60
+#define HISTB_USB2_2_OTG_UTMI_CLK		61
+#define HISTB_USB2_2_PHY1_REF_CLK		62
+#define HISTB_USB2_2_PHY2_REF_CLK		63
 
 /* clocks provided by mcu CRG */
 #define HISTB_MCE_CLK			1
-- 
2.39.1

