Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EEB64B85D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiLMP0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbiLMP0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:26:31 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35782BF4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:26:26 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y25so5440508lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p61H1g+N/0q0M691B8wtMp8S5WBMbHTjDAel7HUTJU=;
        b=jpP8WLOv4QKw/83zVuSToND945z/YCcrq9sXozy/6T53HJN9GaAYhpR37tSqQhluXf
         GoKK1YTizQ0FdwJLjdFqXsp3kUM6HaqYF0TklXuFA13Yzf1w4s3gbjeCl7RaamSid/R9
         wXgZXLymN3aR5mnvIZbFYyhzDYQwyfDRtGXxw+tzVIWM3BRRiXgiq8+1BVpwEWxT6sZ4
         dqxO1DL/dL1YpF+3jNL/cpZhAHqurVHM7ZfHC+It3GdmnvsjgyBduToyxLOYtqL+848E
         pC4OYM+qg91/Nf1EpbOShz8pFXAVweQPu01MyEpMje+gmd8/BccKWG0ySK0x1erFEmBu
         h9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p61H1g+N/0q0M691B8wtMp8S5WBMbHTjDAel7HUTJU=;
        b=rmgVrO4sFG3jdDLSNITKrjdPS+JGwfqX7R3SNSS2+h7XrfspVN5IQNTuSpMfd7u07q
         fYrahXCRPwZOpJcwhLy/p0gbJIJIE6aL6CtIKtXFtFKxJvQ/oWwWif4O4CfMTU0jkCiZ
         xeHrM+i63IzB9S69wIzcPkpo7F410q1qWlCkbLfGzSsaz6MQhsFLpSi1gVR7/HeJriF8
         EER84ymJrCQ85SljFV8jv4l20U2HYSvg1HPOhIkvqvRskLJNHs0rFRsR29XIW+Belg7R
         qrycBzxXWxu/qf677rCr+3WKFFiKlpt17dTx99t3l7oQn7VcypJQ/qdFXj53V54vQTtt
         yf1w==
X-Gm-Message-State: ANoB5plo2xok/IRu2Z5GRxra65ASXX96mj7Wflu+2medcrIXVybXJiso
        ZPq6rNcO7iyKJ6rHWmUtnJxDTw==
X-Google-Smtp-Source: AA0mqf7W7CWmDbKlSiAnOHFOOCBmMYfdZ8kxAxM/gD+bGIWSCorYTHxJaz4msrYoM5Hiby5OG6XrQA==
X-Received: by 2002:a05:6512:4029:b0:4b5:5da1:44c1 with SMTP id br41-20020a056512402900b004b55da144c1mr6785757lfb.11.1670945184280;
        Tue, 13 Dec 2022 07:26:24 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id s15-20020a056512214f00b004b58f51c7dcsm404149lfr.226.2022.12.13.07.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:26:23 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: qcom: Add camera clock controller driver for SM6350
Date:   Tue, 13 Dec 2022 16:26:16 +0100
Message-Id: <20221213152617.296426-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213152617.296426-1-konrad.dybcio@linaro.org>
References: <20221213152617.296426-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the camera clock controller found on SM6350.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/Kconfig        |    7 +
 drivers/clk/qcom/Makefile       |    1 +
 drivers/clk/qcom/camcc-sm6350.c | 1906 +++++++++++++++++++++++++++++++
 3 files changed, 1914 insertions(+)
 create mode 100644 drivers/clk/qcom/camcc-sm6350.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 6e2d41ad3263..7c74cb8bf153 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -627,6 +627,13 @@ config SDX_GCC_65
 	  Say Y if you want to use peripheral devices such as UART,
 	  SPI, I2C, USB, SD/UFS, PCIe etc.
 
+config SM_CAMCC_6350
+	tristate "SM6350 Camera Clock Controller"
+	select SM_GCC_6350
+	help
+	  Support for the camera clock controller on SM6350 devices.
+	  Say Y if you want to support camera devices and camera functionality.
+
 config SM_CAMCC_8250
 	tristate "SM8250 Camera Clock Controller"
 	select SM_GCC_8250
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 016192c86995..d121b520074c 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_SDM_LPASSCC_845) += lpasscc-sdm845.o
 obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
 obj-$(CONFIG_SDX_GCC_55) += gcc-sdx55.o
 obj-$(CONFIG_SDX_GCC_65) += gcc-sdx65.o
+obj-$(CONFIG_SM_CAMCC_6350) += camcc-sm6350.o
 obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
 obj-$(CONFIG_SM_CAMCC_8450) += camcc-sm8450.o
 obj-$(CONFIG_SM_DISPCC_6115) += dispcc-sm6115.o
diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/camcc-sm6350.c
new file mode 100644
index 000000000000..ea8600530046
--- /dev/null
+++ b/drivers/clk/qcom/camcc-sm6350.c
@@ -0,0 +1,1906 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm6350-camcc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "common.h"
+#include "gdsc.h"
+
+enum {
+	DT_BI_TCXO,
+};
+
+enum {
+	P_BI_TCXO,
+	P_CAMCC_PLL0_OUT_EVEN,
+	P_CAMCC_PLL0_OUT_MAIN,
+	P_CAMCC_PLL1_OUT_EVEN,
+	P_CAMCC_PLL1_OUT_MAIN,
+	P_CAMCC_PLL2_OUT_EARLY,
+	P_CAMCC_PLL2_OUT_MAIN,
+	P_CAMCC_PLL3_OUT_MAIN,
+};
+
+static struct pll_vco fabia_vco[] = {
+	{ 249600000, 2000000000, 0 },
+};
+
+/* 600MHz configuration */
+static const struct alpha_pll_config camcc_pll0_config = {
+	.l = 0x1f,
+	.alpha = 0x4000,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002067,
+	.test_ctl_val = 0x40000000,
+	.test_ctl_hi_val = 0x00000002,
+	.user_ctl_val = 0x00000101,
+	.user_ctl_hi_val = 0x00004805,
+};
+
+static struct clk_alpha_pll camcc_pll0 = {
+	.offset = 0x0,
+	.vco_table = fabia_vco,
+	.num_vco = ARRAY_SIZE(fabia_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_pll0",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_camcc_pll0_out_even[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv camcc_pll0_out_even = {
+	.offset = 0x0,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_camcc_pll0_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_camcc_pll0_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_pll0_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&camcc_pll0.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
+/* 808MHz configuration */
+static const struct alpha_pll_config camcc_pll1_config = {
+	.l = 0x2a,
+	.alpha = 0x1555,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002067,
+	.test_ctl_val = 0x40000000,
+	.test_ctl_hi_val = 0x00000000,
+	.user_ctl_val = 0x00000101,
+	.user_ctl_hi_val = 0x00004805,
+};
+
+static struct clk_alpha_pll camcc_pll1 = {
+	.offset = 0x1000,
+	.vco_table = fabia_vco,
+	.num_vco = ARRAY_SIZE(fabia_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_pll1",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_camcc_pll1_out_even[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv camcc_pll1_out_even = {
+	.offset = 0x1000,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_camcc_pll1_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_camcc_pll1_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_pll1_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&camcc_pll1.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
+/* 1920MHz configuration */
+static const struct alpha_pll_config camcc_pll2_config = {
+	.l = 0x64,
+	.alpha = 0x0,
+	.post_div_val = 0x3 << 8,
+	.post_div_mask = 0x3 << 8,
+	.aux_output_mask = BIT(1),
+	.main_output_mask = BIT(0),
+	.early_output_mask = BIT(3),
+	.config_ctl_val = 0x20000800,
+	.config_ctl_hi_val = 0x400003d2,
+	.test_ctl_val = 0x04000400,
+	.test_ctl_hi_val = 0x00004000,
+};
+
+static struct clk_alpha_pll camcc_pll2 = {
+	.offset = 0x2000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_AGERA],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_pll2",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_agera_ops,
+		},
+	},
+};
+
+static struct clk_fixed_factor camcc_pll2_out_early = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "camcc_pll2_out_early",
+		.parent_hws = (const struct clk_hw*[]){
+			&camcc_pll2.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
+static const struct clk_div_table post_div_table_camcc_pll2_out_main[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv camcc_pll2_out_main = {
+	.offset = 0x2000,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_camcc_pll2_out_main,
+	.num_post_div = ARRAY_SIZE(post_div_table_camcc_pll2_out_main),
+	.width = 2,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_AGERA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_pll2_out_main",
+		.parent_hws = (const struct clk_hw*[]){
+			&camcc_pll2.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_ops,
+	},
+};
+
+/* 384MHz configuration */
+static const struct alpha_pll_config camcc_pll3_config = {
+	.l = 0x14,
+	.alpha = 0x0,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002067,
+	.test_ctl_val = 0x40000000,
+	.test_ctl_hi_val = 0x00000002,
+	.user_ctl_val = 0x00000001,
+	.user_ctl_hi_val = 0x00014805,
+};
+
+static struct clk_alpha_pll camcc_pll3 = {
+	.offset = 0x3000,
+	.vco_table = fabia_vco,
+	.num_vco = ARRAY_SIZE(fabia_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_pll3",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static const struct parent_map camcc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data camcc_parent_data_0[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &camcc_pll0_out_even.clkr.hw },
+};
+
+static const struct parent_map camcc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_MAIN, 1 },
+	{ P_CAMCC_PLL1_OUT_EVEN, 3 },
+	{ P_CAMCC_PLL2_OUT_MAIN, 4 },
+};
+
+static const struct clk_parent_data camcc_parent_data_1[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &camcc_pll0.clkr.hw },
+	{ .hw = &camcc_pll1_out_even.clkr.hw },
+	{ .hw = &camcc_pll2_out_main.clkr.hw },
+};
+
+static const struct parent_map camcc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_MAIN, 1 },
+	{ P_CAMCC_PLL3_OUT_MAIN, 5 },
+};
+
+static const struct clk_parent_data camcc_parent_data_2[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &camcc_pll0.clkr.hw },
+	{ .hw = &camcc_pll3.clkr.hw },
+};
+
+static const struct parent_map camcc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL2_OUT_EARLY, 3 },
+};
+
+static const struct clk_parent_data camcc_parent_data_3[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &camcc_pll2_out_early.hw },
+};
+
+static const struct parent_map camcc_parent_map_4[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_MAIN, 1 },
+	{ P_CAMCC_PLL1_OUT_EVEN, 3 },
+};
+
+static const struct clk_parent_data camcc_parent_data_4[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &camcc_pll0.clkr.hw },
+	{ .hw = &camcc_pll1_out_even.clkr.hw },
+};
+
+static const struct parent_map camcc_parent_map_5[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_MAIN, 1 },
+	{ P_CAMCC_PLL1_OUT_EVEN, 3 },
+	{ P_CAMCC_PLL3_OUT_MAIN, 5 },
+};
+
+static const struct clk_parent_data camcc_parent_data_5[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &camcc_pll0.clkr.hw },
+	{ .hw = &camcc_pll1_out_even.clkr.hw },
+	{ .hw = &camcc_pll3.clkr.hw },
+};
+
+static const struct parent_map camcc_parent_map_6[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_MAIN, 1 },
+	{ P_CAMCC_PLL2_OUT_MAIN, 4 },
+};
+
+static const struct clk_parent_data camcc_parent_data_6[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &camcc_pll0.clkr.hw },
+	{ .hw = &camcc_pll2_out_main.clkr.hw },
+};
+
+static const struct parent_map camcc_parent_map_7[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_MAIN, 1 },
+	{ P_CAMCC_PLL1_OUT_MAIN, 2 },
+	{ P_CAMCC_PLL2_OUT_MAIN, 4 },
+};
+
+static const struct clk_parent_data camcc_parent_data_7[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &camcc_pll0.clkr.hw },
+	{ .hw = &camcc_pll1.clkr.hw },
+	{ .hw = &camcc_pll2_out_main.clkr.hw },
+};
+
+static const struct parent_map camcc_parent_map_8[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_MAIN, 1 },
+	{ P_CAMCC_PLL1_OUT_MAIN, 2 },
+};
+
+static const struct clk_parent_data camcc_parent_data_8[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &camcc_pll0.clkr.hw },
+	{ .hw = &camcc_pll1.clkr.hw },
+};
+
+static const struct parent_map camcc_parent_map_9[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL2_OUT_MAIN, 4 },
+};
+
+static const struct clk_parent_data camcc_parent_data_9[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &camcc_pll2_out_main.clkr.hw },
+};
+
+static const struct freq_tbl ftbl_camcc_bps_clk_src[] = {
+	F(200000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(320000000, P_CAMCC_PLL2_OUT_MAIN, 1.5, 0, 0),
+	F(404000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
+	F(480000000, P_CAMCC_PLL2_OUT_MAIN, 1, 0, 0),
+	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_bps_clk_src = {
+	.cmd_rcgr = 0x6010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_1,
+	.freq_tbl = ftbl_camcc_bps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_bps_clk_src",
+		.parent_data = camcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_cci_0_clk_src[] = {
+	F(37500000, P_CAMCC_PLL0_OUT_EVEN, 8, 0, 0),
+	F(50000000, P_CAMCC_PLL0_OUT_EVEN, 6, 0, 0),
+	F(100000000, P_CAMCC_PLL0_OUT_EVEN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_cci_0_clk_src = {
+	.cmd_rcgr = 0xf004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_cci_0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_cci_0_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_cci_1_clk_src = {
+	.cmd_rcgr = 0x10004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_cci_0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_cci_1_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_cphy_rx_clk_src[] = {
+	F(150000000, P_CAMCC_PLL0_OUT_MAIN, 4, 0, 0),
+	F(300000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
+	F(384000000, P_CAMCC_PLL3_OUT_MAIN, 1, 0, 0),
+	F(400000000, P_CAMCC_PLL0_OUT_MAIN, 1.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_cphy_rx_clk_src = {
+	.cmd_rcgr = 0x9064,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_2,
+	.freq_tbl = ftbl_camcc_cphy_rx_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_cphy_rx_clk_src",
+		.parent_data = camcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_csi0phytimer_clk_src[] = {
+	F(300000000, P_CAMCC_PLL0_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_csi0phytimer_clk_src = {
+	.cmd_rcgr = 0x5004,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_csi0phytimer_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_csi1phytimer_clk_src = {
+	.cmd_rcgr = 0x5028,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_csi1phytimer_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_csi2phytimer_clk_src = {
+	.cmd_rcgr = 0x504c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_csi2phytimer_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_csi3phytimer_clk_src = {
+	.cmd_rcgr = 0x5070,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_csi3phytimer_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_fast_ahb_clk_src[] = {
+	F(100000000, P_CAMCC_PLL0_OUT_MAIN, 6, 0, 0),
+	F(200000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(300000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
+	F(404000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_fast_ahb_clk_src = {
+	.cmd_rcgr = 0x603c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_4,
+	.freq_tbl = ftbl_camcc_fast_ahb_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_fast_ahb_clk_src",
+		.parent_data = camcc_parent_data_4,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_4),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_icp_clk_src[] = {
+	F(240000000, P_CAMCC_PLL0_OUT_MAIN, 2.5, 0, 0),
+	F(384000000, P_CAMCC_PLL3_OUT_MAIN, 1, 0, 0),
+	F(404000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
+	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_icp_clk_src = {
+	.cmd_rcgr = 0xe014,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_5,
+	.freq_tbl = ftbl_camcc_icp_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_icp_clk_src",
+		.parent_data = camcc_parent_data_5,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_5),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_ife_0_clk_src[] = {
+	F(240000000, P_CAMCC_PLL0_OUT_MAIN, 2.5, 0, 0),
+	F(320000000, P_CAMCC_PLL2_OUT_MAIN, 1.5, 0, 0),
+	F(404000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
+	F(480000000, P_CAMCC_PLL2_OUT_MAIN, 1, 0, 0),
+	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_ife_0_clk_src = {
+	.cmd_rcgr = 0x9010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_1,
+	.freq_tbl = ftbl_camcc_ife_0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_ife_0_clk_src",
+		.parent_data = camcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_ife_0_csid_clk_src = {
+	.cmd_rcgr = 0x903c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_2,
+	.freq_tbl = ftbl_camcc_cphy_rx_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_ife_0_csid_clk_src",
+		.parent_data = camcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_ife_1_clk_src = {
+	.cmd_rcgr = 0xa010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_1,
+	.freq_tbl = ftbl_camcc_ife_0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_ife_1_clk_src",
+		.parent_data = camcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_ife_1_csid_clk_src = {
+	.cmd_rcgr = 0xa034,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_2,
+	.freq_tbl = ftbl_camcc_cphy_rx_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_ife_1_csid_clk_src",
+		.parent_data = camcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_ife_2_clk_src = {
+	.cmd_rcgr = 0xb00c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_1,
+	.freq_tbl = ftbl_camcc_ife_0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_ife_2_clk_src",
+		.parent_data = camcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_ife_2_csid_clk_src = {
+	.cmd_rcgr = 0xb030,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_2,
+	.freq_tbl = ftbl_camcc_cphy_rx_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_ife_2_csid_clk_src",
+		.parent_data = camcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_ife_lite_clk_src[] = {
+	F(320000000, P_CAMCC_PLL2_OUT_MAIN, 1.5, 0, 0),
+	F(400000000, P_CAMCC_PLL0_OUT_MAIN, 1.5, 0, 0),
+	F(480000000, P_CAMCC_PLL2_OUT_MAIN, 1, 0, 0),
+	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_ife_lite_clk_src = {
+	.cmd_rcgr = 0xc004,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_6,
+	.freq_tbl = ftbl_camcc_ife_lite_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_ife_lite_clk_src",
+		.parent_data = camcc_parent_data_6,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_6),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_ife_lite_csid_clk_src = {
+	.cmd_rcgr = 0xc024,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_2,
+	.freq_tbl = ftbl_camcc_cphy_rx_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_ife_lite_csid_clk_src",
+		.parent_data = camcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_ipe_0_clk_src[] = {
+	F(240000000, P_CAMCC_PLL2_OUT_MAIN, 2, 0, 0),
+	F(320000000, P_CAMCC_PLL2_OUT_MAIN, 1.5, 0, 0),
+	F(404000000, P_CAMCC_PLL1_OUT_MAIN, 2, 0, 0),
+	F(538666667, P_CAMCC_PLL1_OUT_MAIN, 1.5, 0, 0),
+	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_ipe_0_clk_src = {
+	.cmd_rcgr = 0x7010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_7,
+	.freq_tbl = ftbl_camcc_ipe_0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_ipe_0_clk_src",
+		.parent_data = camcc_parent_data_7,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_7),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_jpeg_clk_src[] = {
+	F(66666667, P_CAMCC_PLL0_OUT_MAIN, 9, 0, 0),
+	F(133333333, P_CAMCC_PLL0_OUT_MAIN, 4.5, 0, 0),
+	F(200000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(404000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
+	F(480000000, P_CAMCC_PLL2_OUT_MAIN, 1, 0, 0),
+	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_jpeg_clk_src = {
+	.cmd_rcgr = 0xd004,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_1,
+	.freq_tbl = ftbl_camcc_jpeg_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_jpeg_clk_src",
+		.parent_data = camcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_lrme_clk_src[] = {
+	F(200000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(269333333, P_CAMCC_PLL1_OUT_MAIN, 3, 0, 0),
+	F(323200000, P_CAMCC_PLL1_OUT_MAIN, 2.5, 0, 0),
+	F(404000000, P_CAMCC_PLL1_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_lrme_clk_src = {
+	.cmd_rcgr = 0x11004,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_8,
+	.freq_tbl = ftbl_camcc_lrme_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_lrme_clk_src",
+		.parent_data = camcc_parent_data_8,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_mclk0_clk_src[] = {
+	F(19200000, P_CAMCC_PLL2_OUT_EARLY, 1, 1, 50),
+	F(24000000, P_CAMCC_PLL2_OUT_EARLY, 10, 1, 4),
+	F(64000000, P_CAMCC_PLL2_OUT_EARLY, 15, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_mclk0_clk_src = {
+	.cmd_rcgr = 0x4004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_3,
+	.freq_tbl = ftbl_camcc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_mclk0_clk_src",
+		.parent_data = camcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_3),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_mclk1_clk_src = {
+	.cmd_rcgr = 0x4024,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_3,
+	.freq_tbl = ftbl_camcc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_mclk1_clk_src",
+		.parent_data = camcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_3),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_mclk2_clk_src = {
+	.cmd_rcgr = 0x4044,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_3,
+	.freq_tbl = ftbl_camcc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_mclk2_clk_src",
+		.parent_data = camcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_3),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_mclk3_clk_src = {
+	.cmd_rcgr = 0x4064,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_3,
+	.freq_tbl = ftbl_camcc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_mclk3_clk_src",
+		.parent_data = camcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_3),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_mclk4_clk_src = {
+	.cmd_rcgr = 0x4084,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_3,
+	.freq_tbl = ftbl_camcc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_mclk4_clk_src",
+		.parent_data = camcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_3),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_slow_ahb_clk_src[] = {
+	F(80000000, P_CAMCC_PLL2_OUT_MAIN, 6, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_slow_ahb_clk_src = {
+	.cmd_rcgr = 0x6058,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_9,
+	.freq_tbl = ftbl_camcc_slow_ahb_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camcc_slow_ahb_clk_src",
+		.parent_data = camcc_parent_data_9,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_9),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch camcc_bps_ahb_clk = {
+	.halt_reg = 0x6070,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6070,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_bps_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_bps_areg_clk = {
+	.halt_reg = 0x6054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6054,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_bps_areg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_fast_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_bps_axi_clk = {
+	.halt_reg = 0x6038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6038,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_bps_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_bps_clk = {
+	.halt_reg = 0x6028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_bps_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_bps_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_camnoc_axi_clk = {
+	.halt_reg = 0x13004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x13004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_camnoc_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_cci_0_clk = {
+	.halt_reg = 0xf01c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xf01c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_cci_0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_cci_0_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_cci_1_clk = {
+	.halt_reg = 0x1001c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1001c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_cci_1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_cci_1_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_core_ahb_clk = {
+	.halt_reg = 0x14010,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x14010,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_core_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_cpas_ahb_clk = {
+	.halt_reg = 0x12004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x12004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_cpas_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csi0phytimer_clk = {
+	.halt_reg = 0x501c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x501c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_csi0phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_csi0phytimer_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csi1phytimer_clk = {
+	.halt_reg = 0x5040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_csi1phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_csi1phytimer_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csi2phytimer_clk = {
+	.halt_reg = 0x5064,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5064,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_csi2phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_csi2phytimer_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csi3phytimer_clk = {
+	.halt_reg = 0x5088,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5088,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_csi3phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_csi3phytimer_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csiphy0_clk = {
+	.halt_reg = 0x5020,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5020,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_csiphy0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csiphy1_clk = {
+	.halt_reg = 0x5044,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_csiphy1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csiphy2_clk = {
+	.halt_reg = 0x5068,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5068,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_csiphy2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csiphy3_clk = {
+	.halt_reg = 0x508c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x508c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_csiphy3_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_icp_clk = {
+	.halt_reg = 0xe02c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xe02c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_icp_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_icp_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_icp_ts_clk = {
+	.halt_reg = 0xe00c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xe00c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_icp_ts_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_0_axi_clk = {
+	.halt_reg = 0x9080,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9080,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_0_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_0_clk = {
+	.halt_reg = 0x9028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ife_0_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_0_cphy_rx_clk = {
+	.halt_reg = 0x907c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x907c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_0_cphy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_0_csid_clk = {
+	.halt_reg = 0x9054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9054,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_0_csid_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ife_0_csid_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_0_dsp_clk = {
+	.halt_reg = 0x9038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9038,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_0_dsp_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ife_0_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_1_axi_clk = {
+	.halt_reg = 0xa058,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa058,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_1_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_1_clk = {
+	.halt_reg = 0xa028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ife_1_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_1_cphy_rx_clk = {
+	.halt_reg = 0xa054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa054,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_1_cphy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_1_csid_clk = {
+	.halt_reg = 0xa04c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa04c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_1_csid_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ife_1_csid_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_1_dsp_clk = {
+	.halt_reg = 0xa030,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa030,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_1_dsp_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ife_1_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_2_axi_clk = {
+	.halt_reg = 0xb054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb054,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_2_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_2_clk = {
+	.halt_reg = 0xb024,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ife_2_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_2_cphy_rx_clk = {
+	.halt_reg = 0xb050,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb050,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_2_cphy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_2_csid_clk = {
+	.halt_reg = 0xb048,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_2_csid_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ife_2_csid_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_2_dsp_clk = {
+	.halt_reg = 0xb02c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb02c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_2_dsp_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ife_2_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_lite_clk = {
+	.halt_reg = 0xc01c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc01c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_lite_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ife_lite_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_lite_cphy_rx_clk = {
+	.halt_reg = 0xc044,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_lite_cphy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_lite_csid_clk = {
+	.halt_reg = 0xc03c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ife_lite_csid_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ife_lite_csid_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_0_ahb_clk = {
+	.halt_reg = 0x7040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ipe_0_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_0_areg_clk = {
+	.halt_reg = 0x703c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x703c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ipe_0_areg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_fast_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_0_axi_clk = {
+	.halt_reg = 0x7038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7038,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ipe_0_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_0_clk = {
+	.halt_reg = 0x7028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_ipe_0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_ipe_0_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_jpeg_clk = {
+	.halt_reg = 0xd01c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd01c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_jpeg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_jpeg_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_lrme_clk = {
+	.halt_reg = 0x1101c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1101c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_lrme_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_lrme_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_mclk0_clk = {
+	.halt_reg = 0x401c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x401c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_mclk0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_mclk0_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_mclk1_clk = {
+	.halt_reg = 0x403c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x403c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_mclk1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_mclk1_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_mclk2_clk = {
+	.halt_reg = 0x405c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x405c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_mclk2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_mclk2_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_mclk3_clk = {
+	.halt_reg = 0x407c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x407c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_mclk3_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_mclk3_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_mclk4_clk = {
+	.halt_reg = 0x409c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x409c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_mclk4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camcc_mclk4_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_soc_ahb_clk = {
+	.halt_reg = 0x1400c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1400c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_soc_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_sys_tmr_clk = {
+	.halt_reg = 0xe034,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xe034,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camcc_sys_tmr_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc bps_gdsc = {
+	.gdscr = 0x6004,
+	.pd = {
+		.name = "bps_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct gdsc ipe_0_gdsc = {
+	.gdscr = 0x7004,
+	.pd = {
+		.name = "ipe_0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct gdsc ife_0_gdsc = {
+	.gdscr = 0x9004,
+	.pd = {
+		.name = "ife_0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc ife_1_gdsc = {
+	.gdscr = 0xa004,
+	.pd = {
+		.name = "ife_1_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc ife_2_gdsc = {
+	.gdscr = 0xb004,
+	.pd = {
+		.name = "ife_2_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc titan_top_gdsc = {
+	.gdscr = 0x14004,
+	.pd = {
+		.name = "titan_top_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+struct clk_hw *camcc_sm6350_hws[] = {
+	[CAMCC_PLL2_OUT_EARLY] = &camcc_pll2_out_early.hw,
+};
+
+static struct clk_regmap *camcc_sm6350_clocks[] = {
+	[CAMCC_BPS_AHB_CLK] = &camcc_bps_ahb_clk.clkr,
+	[CAMCC_BPS_AREG_CLK] = &camcc_bps_areg_clk.clkr,
+	[CAMCC_BPS_AXI_CLK] = &camcc_bps_axi_clk.clkr,
+	[CAMCC_BPS_CLK] = &camcc_bps_clk.clkr,
+	[CAMCC_BPS_CLK_SRC] = &camcc_bps_clk_src.clkr,
+	[CAMCC_CAMNOC_AXI_CLK] = &camcc_camnoc_axi_clk.clkr,
+	[CAMCC_CCI_0_CLK] = &camcc_cci_0_clk.clkr,
+	[CAMCC_CCI_0_CLK_SRC] = &camcc_cci_0_clk_src.clkr,
+	[CAMCC_CCI_1_CLK] = &camcc_cci_1_clk.clkr,
+	[CAMCC_CCI_1_CLK_SRC] = &camcc_cci_1_clk_src.clkr,
+	[CAMCC_CORE_AHB_CLK] = &camcc_core_ahb_clk.clkr,
+	[CAMCC_CPAS_AHB_CLK] = &camcc_cpas_ahb_clk.clkr,
+	[CAMCC_CPHY_RX_CLK_SRC] = &camcc_cphy_rx_clk_src.clkr,
+	[CAMCC_CSI0PHYTIMER_CLK] = &camcc_csi0phytimer_clk.clkr,
+	[CAMCC_CSI0PHYTIMER_CLK_SRC] = &camcc_csi0phytimer_clk_src.clkr,
+	[CAMCC_CSI1PHYTIMER_CLK] = &camcc_csi1phytimer_clk.clkr,
+	[CAMCC_CSI1PHYTIMER_CLK_SRC] = &camcc_csi1phytimer_clk_src.clkr,
+	[CAMCC_CSI2PHYTIMER_CLK] = &camcc_csi2phytimer_clk.clkr,
+	[CAMCC_CSI2PHYTIMER_CLK_SRC] = &camcc_csi2phytimer_clk_src.clkr,
+	[CAMCC_CSI3PHYTIMER_CLK] = &camcc_csi3phytimer_clk.clkr,
+	[CAMCC_CSI3PHYTIMER_CLK_SRC] = &camcc_csi3phytimer_clk_src.clkr,
+	[CAMCC_CSIPHY0_CLK] = &camcc_csiphy0_clk.clkr,
+	[CAMCC_CSIPHY1_CLK] = &camcc_csiphy1_clk.clkr,
+	[CAMCC_CSIPHY2_CLK] = &camcc_csiphy2_clk.clkr,
+	[CAMCC_CSIPHY3_CLK] = &camcc_csiphy3_clk.clkr,
+	[CAMCC_FAST_AHB_CLK_SRC] = &camcc_fast_ahb_clk_src.clkr,
+	[CAMCC_ICP_CLK] = &camcc_icp_clk.clkr,
+	[CAMCC_ICP_CLK_SRC] = &camcc_icp_clk_src.clkr,
+	[CAMCC_ICP_TS_CLK] = &camcc_icp_ts_clk.clkr,
+	[CAMCC_IFE_0_AXI_CLK] = &camcc_ife_0_axi_clk.clkr,
+	[CAMCC_IFE_0_CLK] = &camcc_ife_0_clk.clkr,
+	[CAMCC_IFE_0_CLK_SRC] = &camcc_ife_0_clk_src.clkr,
+	[CAMCC_IFE_0_CPHY_RX_CLK] = &camcc_ife_0_cphy_rx_clk.clkr,
+	[CAMCC_IFE_0_CSID_CLK] = &camcc_ife_0_csid_clk.clkr,
+	[CAMCC_IFE_0_CSID_CLK_SRC] = &camcc_ife_0_csid_clk_src.clkr,
+	[CAMCC_IFE_0_DSP_CLK] = &camcc_ife_0_dsp_clk.clkr,
+	[CAMCC_IFE_1_AXI_CLK] = &camcc_ife_1_axi_clk.clkr,
+	[CAMCC_IFE_1_CLK] = &camcc_ife_1_clk.clkr,
+	[CAMCC_IFE_1_CLK_SRC] = &camcc_ife_1_clk_src.clkr,
+	[CAMCC_IFE_1_CPHY_RX_CLK] = &camcc_ife_1_cphy_rx_clk.clkr,
+	[CAMCC_IFE_1_CSID_CLK] = &camcc_ife_1_csid_clk.clkr,
+	[CAMCC_IFE_1_CSID_CLK_SRC] = &camcc_ife_1_csid_clk_src.clkr,
+	[CAMCC_IFE_1_DSP_CLK] = &camcc_ife_1_dsp_clk.clkr,
+	[CAMCC_IFE_2_AXI_CLK] = &camcc_ife_2_axi_clk.clkr,
+	[CAMCC_IFE_2_CLK] = &camcc_ife_2_clk.clkr,
+	[CAMCC_IFE_2_CLK_SRC] = &camcc_ife_2_clk_src.clkr,
+	[CAMCC_IFE_2_CPHY_RX_CLK] = &camcc_ife_2_cphy_rx_clk.clkr,
+	[CAMCC_IFE_2_CSID_CLK] = &camcc_ife_2_csid_clk.clkr,
+	[CAMCC_IFE_2_CSID_CLK_SRC] = &camcc_ife_2_csid_clk_src.clkr,
+	[CAMCC_IFE_2_DSP_CLK] = &camcc_ife_2_dsp_clk.clkr,
+	[CAMCC_IFE_LITE_CLK] = &camcc_ife_lite_clk.clkr,
+	[CAMCC_IFE_LITE_CLK_SRC] = &camcc_ife_lite_clk_src.clkr,
+	[CAMCC_IFE_LITE_CPHY_RX_CLK] = &camcc_ife_lite_cphy_rx_clk.clkr,
+	[CAMCC_IFE_LITE_CSID_CLK] = &camcc_ife_lite_csid_clk.clkr,
+	[CAMCC_IFE_LITE_CSID_CLK_SRC] = &camcc_ife_lite_csid_clk_src.clkr,
+	[CAMCC_IPE_0_AHB_CLK] = &camcc_ipe_0_ahb_clk.clkr,
+	[CAMCC_IPE_0_AREG_CLK] = &camcc_ipe_0_areg_clk.clkr,
+	[CAMCC_IPE_0_AXI_CLK] = &camcc_ipe_0_axi_clk.clkr,
+	[CAMCC_IPE_0_CLK] = &camcc_ipe_0_clk.clkr,
+	[CAMCC_IPE_0_CLK_SRC] = &camcc_ipe_0_clk_src.clkr,
+	[CAMCC_JPEG_CLK] = &camcc_jpeg_clk.clkr,
+	[CAMCC_JPEG_CLK_SRC] = &camcc_jpeg_clk_src.clkr,
+	[CAMCC_LRME_CLK] = &camcc_lrme_clk.clkr,
+	[CAMCC_LRME_CLK_SRC] = &camcc_lrme_clk_src.clkr,
+	[CAMCC_MCLK0_CLK] = &camcc_mclk0_clk.clkr,
+	[CAMCC_MCLK0_CLK_SRC] = &camcc_mclk0_clk_src.clkr,
+	[CAMCC_MCLK1_CLK] = &camcc_mclk1_clk.clkr,
+	[CAMCC_MCLK1_CLK_SRC] = &camcc_mclk1_clk_src.clkr,
+	[CAMCC_MCLK2_CLK] = &camcc_mclk2_clk.clkr,
+	[CAMCC_MCLK2_CLK_SRC] = &camcc_mclk2_clk_src.clkr,
+	[CAMCC_MCLK3_CLK] = &camcc_mclk3_clk.clkr,
+	[CAMCC_MCLK3_CLK_SRC] = &camcc_mclk3_clk_src.clkr,
+	[CAMCC_MCLK4_CLK] = &camcc_mclk4_clk.clkr,
+	[CAMCC_MCLK4_CLK_SRC] = &camcc_mclk4_clk_src.clkr,
+	[CAMCC_PLL0] = &camcc_pll0.clkr,
+	[CAMCC_PLL0_OUT_EVEN] = &camcc_pll0_out_even.clkr,
+	[CAMCC_PLL1] = &camcc_pll1.clkr,
+	[CAMCC_PLL1_OUT_EVEN] = &camcc_pll1_out_even.clkr,
+	[CAMCC_PLL2] = &camcc_pll2.clkr,
+	[CAMCC_PLL2_OUT_MAIN] = &camcc_pll2_out_main.clkr,
+	[CAMCC_PLL3] = &camcc_pll3.clkr,
+	[CAMCC_SLOW_AHB_CLK_SRC] = &camcc_slow_ahb_clk_src.clkr,
+	[CAMCC_SOC_AHB_CLK] = &camcc_soc_ahb_clk.clkr,
+	[CAMCC_SYS_TMR_CLK] = &camcc_sys_tmr_clk.clkr,
+};
+
+static struct gdsc *camcc_sm6350_gdscs[] = {
+	[BPS_GDSC] = &bps_gdsc,
+	[IPE_0_GDSC] = &ipe_0_gdsc,
+	[IFE_0_GDSC] = &ife_0_gdsc,
+	[IFE_1_GDSC] = &ife_1_gdsc,
+	[IFE_2_GDSC] = &ife_2_gdsc,
+	[TITAN_TOP_GDSC] = &titan_top_gdsc,
+};
+
+static const struct regmap_config camcc_sm6350_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x16000,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc camcc_sm6350_desc = {
+	.config = &camcc_sm6350_regmap_config,
+	.clk_hws = camcc_sm6350_hws,
+	.num_clk_hws = ARRAY_SIZE(camcc_sm6350_hws),
+	.clks = camcc_sm6350_clocks,
+	.num_clks = ARRAY_SIZE(camcc_sm6350_clocks),
+	.gdscs = camcc_sm6350_gdscs,
+	.num_gdscs = ARRAY_SIZE(camcc_sm6350_gdscs),
+};
+
+static const struct of_device_id camcc_sm6350_match_table[] = {
+	{ .compatible = "qcom,sm6350-camcc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, camcc_sm6350_match_table);
+
+static int camcc_sm6350_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &camcc_sm6350_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_fabia_pll_configure(&camcc_pll0, regmap, &camcc_pll0_config);
+	clk_fabia_pll_configure(&camcc_pll1, regmap, &camcc_pll1_config);
+	clk_agera_pll_configure(&camcc_pll2, regmap, &camcc_pll2_config);
+	clk_fabia_pll_configure(&camcc_pll3, regmap, &camcc_pll3_config);
+
+	return qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
+}
+
+static struct platform_driver camcc_sm6350_driver = {
+	.probe = camcc_sm6350_probe,
+	.driver = {
+		.name = "sm6350-camcc",
+		.of_match_table = camcc_sm6350_match_table,
+	},
+};
+
+static int __init camcc_sm6350_init(void)
+{
+	return platform_driver_register(&camcc_sm6350_driver);
+}
+subsys_initcall(camcc_sm6350_init);
+
+static void __exit camcc_sm6350_exit(void)
+{
+	platform_driver_unregister(&camcc_sm6350_driver);
+}
+module_exit(camcc_sm6350_exit);
+
+MODULE_DESCRIPTION("QTI CAMCC SM6350 Driver");
+MODULE_LICENSE("GPL");
-- 
2.39.0

