Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F5A6AA86E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 07:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCDGgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 01:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCDGgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 01:36:41 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6787F3CE07;
        Fri,  3 Mar 2023 22:36:16 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso8309925pjb.2;
        Fri, 03 Mar 2023 22:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677911773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlS1x5ugqI61CHsnNZzsArkipQ0NY+s3OWzFbmJs1Kg=;
        b=OXZ7FX6kjkE2alofUDvNYIYfED+vwLu1lmnLDqp7BaHhtxiv3oljB26s57DRT7zCyn
         wf/DHiNxBJbpDEAHnYyadWPmvRNzxyk0k0ZPV2m8c1SPXCx4FzzpILiUQQR+1z3RhXWB
         uMKQgEt+kr3p2q51XT7eJnaXCFhrz18QIzB0AlFdlFSPmLLB84egrPyS5bt4zKuUDLOy
         BfHnFn1qr20rK90ndEIeQFBTU3zGgJ6SDlhYLpoC3Q7Hix+ObYnk6/3HVbVhzf9mkQQR
         Ic03AQcxHO6mb6GR0o28yVBcl954jhSgGeBLURF0RcmS5/qejYXbS+gt5O3zkj8Laip5
         GxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677911773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlS1x5ugqI61CHsnNZzsArkipQ0NY+s3OWzFbmJs1Kg=;
        b=jYg8ERgHsQDjZqPylgML+ivcVToX1OkWHIJaWCRU7IlIx0dtbXPfxtUgMwRscEzUsb
         /KVkfj9GdqoOSWum16mJrJ+/UIwS6lQZ5Cir6O3GVmIEnELgvK/YaOea/nEvH0hvFcHw
         OEt7mTRpY5l84GqMum6WnXSeE26ljpZAR+JV9dGs2Z4joWtMftnxrM7714PYmalPUexd
         AFOsgI3UECj9xwPRzVyKY9IR0G8XL/5kfOoUADh7cEMWoH2yPANA4n5b3Besy6bN3qBI
         /sha/M0T5w71EAN27Z4ZQD2EOAtU0j6DoUK5s9/p6yDOidxWO3u2F4Rbk0oS9m5+3ONm
         HnqQ==
X-Gm-Message-State: AO0yUKV+xmbR/gk2yNhKo7AMBIDvnyieflup8COUGXP7Vv8WbEltVnYP
        za1Z05/UZSTcfLSGV4JGyK/lgYdMfH0w4Sb/Ok8=
X-Google-Smtp-Source: AK7set8ostLc2Xa8zMKrmA0s7Z5oLf/kk4RW7qX9E0Ov1hfrkc5+dXY22CisjS4iQe6PZrB6T/3oCw==
X-Received: by 2002:a17:902:7d88:b0:19d:1d32:fc7 with SMTP id a8-20020a1709027d8800b0019d1d320fc7mr3541263plm.51.1677911773145;
        Fri, 03 Mar 2023 22:36:13 -0800 (PST)
Received: from y.ha.lan ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b0019aa6bf4450sm2520938plg.188.2023.03.03.22.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 22:36:12 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] clk: hisilicon: Add CRG driver for Hi3798MV100 SoC
Date:   Sat,  4 Mar 2023 14:33:29 +0800
Message-Id: <20230304063333.162309-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304063333.162309-1-mmyangfl@gmail.com>
References: <20230304063333.162309-1-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/crg-hi3798.c | 197 +++++++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index 8a6e978f3..ad10b3bb5 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -41,6 +41,7 @@
 #define HI3798_FIXED_3M				87
 #define HI3798_FIXED_15M			88
 #define HI3798_FIXED_83P3M			89
+#define HI3798_ETH_MUX			90
 
 #define HI3798_CRG_NR_CLKS			128
 
@@ -181,6 +182,182 @@ static void hi3798_sysctrl_clk_unregister(
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
+	/* hi3798MV100 NAND driver does not get into mainline yet,
+	 * expose these clocks when it gets ready */
+	/* { HISTB_NAND_CLK, "clk_nand", "clk_apb",
+		CLK_SET_RATE_PARENT, 0x60, 0, 0, }, */
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
+	/* hi3798MV100 Ethernet driver does not get into mainline yet,
+	 * expose these clocks when it gets ready */
+	{ HI3798_ETH_BUS_CLK, "clk_bus", NULL,
+		CLK_SET_RATE_PARENT, 0xcc, 0, 0, },
+	{ HI3798_ETH_PUB_CLK, "clk_pub", "eth_mux",
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
@@ -210,18 +387,6 @@ static struct hisi_mux_clock hi3798cv200_mux_clks[] = {
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
@@ -319,8 +484,8 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 };
 
 static const struct hi3798_crg_clks hi3798cv200_crg_clks_data = {
-	.phase_clks = hi3798cv200_phase_clks,
-	.phase_clks_nums = ARRAY_SIZE(hi3798cv200_phase_clks),
+	.phase_clks = hi3798mv100_phase_clks,
+	.phase_clks_nums = ARRAY_SIZE(hi3798mv100_phase_clks),
 	.mux_clks = hi3798cv200_mux_clks,
 	.mux_clks_nums = ARRAY_SIZE(hi3798cv200_mux_clks),
 	.gate_clks = hi3798cv200_gate_clks,
@@ -374,6 +539,10 @@ static const struct hisi_crg_funcs hi3798cv200_sysctrl_funcs = {
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

