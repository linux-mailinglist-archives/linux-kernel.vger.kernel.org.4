Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242076C5111
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjCVQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCVQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:44:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D442E0F9;
        Wed, 22 Mar 2023 09:43:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d13so19088353pjh.0;
        Wed, 22 Mar 2023 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCKKSdNylNWsqggSGrLVk9/K5zjtOn+TRuqxjMkEz1M=;
        b=ea+BVXDuU7bYcl1YOKtgFY30n0xTewd99L0ao+Nthpwg6orM/+Eg2LqQdNwRjrizGF
         z9nTc13i0cE/YNrr2NO0gln7iDm5SxCwof8DIhvT4wlG+OoIjk5OLtXnnure+zFlFXO5
         4zufjsGSC/b/4cCVpycYCiBuQNR5ARnmTjx5tvjX/2VLzqWijCmG6ikZGQI210z/SGN1
         jdstykWlCjdVcOxzsFsonj5LzlgvGcmnWqPA6kHTPNiL2izzW+W/TUB3X7dzIWX05bAu
         Mo2O03LlmegInKdeXhFJSUaQx5EcPKJSDRJEFvN8zoFhuX0TVdZPWu8QY4uOrCeyO/ug
         7SIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCKKSdNylNWsqggSGrLVk9/K5zjtOn+TRuqxjMkEz1M=;
        b=AtscxIKFeEPSPR/wbuDrsfqrIxPkNWWQ8IxSM7Fh3+zCiaH4fsO1oR6ZmmmF3FfohU
         BDpTFI94jsCzLCz5np8wiCzShWICaW+kPWxyWcVyIrQ3bIDUCQO10zQfdrIsoQWNr64G
         afnYfCFaOZib5Grxl4CgUBYMHomOXcW7d4vMpeR3XkKG+FWriZI1zZ7I7wa++p+O8VkM
         9vVBiCv4fHpaqgJxkZ7lM1q7Cfzhml01ixNX5ceAYQfaTwT/uDHgaEc2Exu6ULCNxl/t
         NQJu0AAlxZFwfxqXPm9Oq6rgTjsQ76tdLxcrZwFNJ0cRAem5T2ey8ZiX3SdwPkscLggW
         itAA==
X-Gm-Message-State: AO0yUKUdTGSe+EuPId0ypUI5kDLZzgWPZWxihUMYInFnUHYwsMvkll/g
        jdyZlloJV9mls16a1N8tb7QUARLjgPJ+V6y7b70=
X-Google-Smtp-Source: AK7set/4REdBvE/bIrEMXqOoFLccqaqMehnbMB37lMYXGf2yv+DdWu+yXNGUR59m1NEUdiJuIGMR1w==
X-Received: by 2002:a05:6a20:6aa6:b0:d6:5fd9:6a99 with SMTP id bi38-20020a056a206aa600b000d65fd96a99mr63318pzb.18.1679503422275;
        Wed, 22 Mar 2023 09:43:42 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm10300830pfh.193.2023.03.22.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:43:42 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 9/9] clk: hisilicon: Add CRG driver for Hi3798MV100 SoC
Date:   Thu, 23 Mar 2023 00:41:57 +0800
Message-Id: <20230322164201.2454771-10-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322164201.2454771-1-mmyangfl@gmail.com>
References: <20230322164201.2454771-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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
 drivers/clk/hisilicon/crg-hi3798.c | 249 +++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)

diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index f329886c4..d083d49a5 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/histb-clock.h>
 
+#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -38,6 +39,9 @@
 #define HI3798_FIXED_166P5M		84
 #define HI3798_SDIO0_MUX			85
 #define HI3798_COMBPHY0_MUX		86
+#define HI3798_FIXED_3M				87
+#define HI3798_FIXED_15M			88
+#define HI3798_FIXED_83P3M			89
 
 #define HI3798_CRG_NR_CLKS			128
 
@@ -47,13 +51,16 @@ static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
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
@@ -61,6 +68,106 @@ static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
 	{ HI3798_FIXED_250M, "250m", NULL, 0, 250000000, },
 };
 
+struct hi3798_complex_clock {
+	unsigned int	id;
+	const char	*name;
+	const char	*parent_name;
+	unsigned long	flags;
+	unsigned long	offset;
+	u32		mask;
+	u32		value;
+};
+
+struct hi3798_clk_complex {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u32		mask;
+	u32		value;
+};
+
+#define to_complex_clk(_hw) container_of(_hw, struct hi3798_clk_complex, hw)
+
+static int hi3798_clk_complex_prepare(struct clk_hw *hw)
+{
+	struct hi3798_clk_complex *clk = to_complex_clk(hw);
+	u32 val;
+
+	val = readl_relaxed(clk->reg);
+	val &= ~(clk->mask);
+	val |= clk->value;
+	writel_relaxed(val, clk->reg);
+
+	return 0;
+}
+
+static void hi3798_clk_complex_unprepare(struct clk_hw *hw)
+{
+	struct hi3798_clk_complex *clk = to_complex_clk(hw);
+	u32 val;
+
+	val = readl_relaxed(clk->reg);
+	val &= ~(clk->mask);
+	writel_relaxed(val, clk->reg);
+}
+
+static int hi3798_clk_complex_is_prepared(struct clk_hw *hw)
+{
+	struct hi3798_clk_complex *clk = to_complex_clk(hw);
+	u32 val;
+
+	val = readl_relaxed(clk->reg);
+	return (val & clk->mask) == clk->value;
+}
+
+static const struct clk_ops hi3798_clk_complex_ops = {
+	.prepare = hi3798_clk_complex_prepare,
+	.unprepare = hi3798_clk_complex_unprepare,
+	.is_prepared = hi3798_clk_complex_is_prepared,
+};
+
+static int hi3798_clk_register_complex(struct device *dev,
+				       const void *clocks, int nums,
+				       struct hisi_clock_data *data)
+{
+	const struct hi3798_complex_clock *clks = clocks;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		struct hi3798_clk_complex *p_clk;
+		struct clk_init_data init;
+		int ret;
+
+		p_clk = devm_kzalloc(dev, sizeof(*p_clk), GFP_KERNEL);
+		if (!p_clk)
+			return -ENOMEM;
+
+		init.name = clks[i].name;
+		init.ops = &hi3798_clk_complex_ops;
+
+		init.flags = 0;
+		init.parent_names =
+			(clks[i].parent_name ? &clks[i].parent_name : NULL);
+		init.num_parents = (clks[i].parent_name ? 1 : 0);
+
+		p_clk->reg = base + clks[i].offset;
+		p_clk->mask = clks[i].mask;
+		p_clk->value = clks[i].value;
+		p_clk->hw.init = &init;
+
+		ret = devm_clk_hw_register(dev, &p_clk->hw);
+		if (ret) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			return ret;
+		}
+
+		data->clk_data->hws[clks[i].id] = &p_clk->hw;
+	}
+
+	return 0;
+}
+
 /* hi3798CV200 */
 
 static const char *const hi3798cv200_mmc_mux_p[] = {
@@ -225,11 +332,153 @@ static const struct hisi_clocks hi3798cv200_sysctrl_clks = {
 	.gate_clks_num = ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
 };
 
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
+static const struct hisi_clocks hi3798mv100_crg_clks = {
+	.nr = HI3798_CRG_NR_CLKS,
+	.fixed_rate_clks = hi3798_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3798_fixed_rate_clks),
+	.gate_clks = hi3798mv100_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3798mv100_gate_clks),
+	.mux_clks = hi3798mv100_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3798mv100_mux_clks),
+	.phase_clks = hi3798cv200_phase_clks,
+	.phase_clks_num = ARRAY_SIZE(hi3798cv200_phase_clks),
+	.customized_clks = hi3798mv100_complex_clks,
+	.customized_clks_num = ARRAY_SIZE(hi3798mv100_complex_clks),
+	.clk_register_customized = hi3798_clk_register_complex,
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
+static const struct hisi_clocks hi3798mv100_sysctrl_clks = {
+	.nr = HI3798_SYSCTRL_NR_CLKS,
+	.gate_clks = hi3798mv100_sysctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3798mv100_sysctrl_gate_clks),
+};
+
 static const struct of_device_id hi3798_crg_match_table[] = {
 	{ .compatible = "hisilicon,hi3798cv200-crg",
 		.data = &hi3798cv200_crg_clks },
 	{ .compatible = "hisilicon,hi3798cv200-sysctrl",
 		.data = &hi3798cv200_sysctrl_clks },
+	{ .compatible = "hisilicon,hi3798mv100-crg",
+		.data = &hi3798mv100_crg_clks },
+	{ .compatible = "hisilicon,hi3798mv100-sysctrl",
+		.data = &hi3798mv100_sysctrl_clks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3798_crg_match_table);
-- 
2.39.2

