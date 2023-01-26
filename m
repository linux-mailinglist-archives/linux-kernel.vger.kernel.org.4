Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B2167D3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjAZSOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjAZSOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:14:01 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA9D6387F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:13:51 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id k4so1866462eje.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuG3Ei32ZNsTIsEpu4kVPCiUUm6DBJpnYYO4idSZvAM=;
        b=biftwpSs2MylXOqVlIKZX2qaYvMVGtaPlbaBbRdnVc0p2hLNPsRZjUMFA72co85ayo
         InfVttkXHP3vpfFEEdDfdqyKVR3asmzIxLrNN3zn5aWa4R9KzFWNvCkwhJ/qBtxUYcIl
         2U/Ucqhci07QAiZ4my4zTAhzOyPujWdrAKzsBOfXSHVq32zERNqnCpzzCqjQScyp9qHZ
         0mZ191ow+84WcQFTxEKnc7An7w2zw+ci6715R2SWIS4vlu30jybEf/IVa7n9lalJZWbz
         tcssuaKi00mqkty2voA/c4fxKmI0vzpJCEi4hWmAplnbW//3JTLv9guyx/or1vcFrplW
         8VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuG3Ei32ZNsTIsEpu4kVPCiUUm6DBJpnYYO4idSZvAM=;
        b=dCHgcfrGvOxWT4WcWtuqXPhYq9teWl55YWG9EWFPgRbT0GqsaLMKCzqu4BfIFDMM2W
         ey4D5JaFxXP9kLXZZOZ70Eedlo2e84tHcfGU9gVJ5PmbN+9Whd+lG8EEfv9wpg4bNOBu
         93hEjv7YmAqgTamEZp2SMlVWJRW++tLqlIWs6eZIOvZaWpX0OTC2krUb3T6Ug00zksBH
         LgA+j4vWGOmGQ8HmUIBI/0tbhz8sY4/rPmDr6kqQEQ1JJWZTFG0y/yFS2D8ugJHRd2CT
         GPn5/HoIX/wt0JruoH12nw7LBKipXrANB7xp2F/e4TnPKne+L0WvYT0ORjtNahH7q1+n
         tzaw==
X-Gm-Message-State: AO0yUKUd4bQPszilSCYM7jxuuVw3wrF6U7p7bVfkpsFGeJGlxYXE7vVh
        TcDdzVxQrEreRrxouc24u+IRWDSMU9wNHGgl
X-Google-Smtp-Source: AK7set/T1s9a7SyMJ78lcMaD/00G29DIaQj1svO8nQ0HsyyBGN55hWnSK+Ib72Z96772HYodD3bNbg==
X-Received: by 2002:a17:906:9719:b0:878:7921:9a94 with SMTP id k25-20020a170906971900b0087879219a94mr1803186ejx.16.1674756829845;
        Thu, 26 Jan 2023 10:13:49 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id k6-20020aa7d8c6000000b00487fc51c532sm1100416eds.33.2023.01.26.10.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 10:13:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 4/6] clk: qcom: Add GPU clock controller driver for SM6375
Date:   Thu, 26 Jan 2023 19:13:33 +0100
Message-Id: <20230126181335.12970-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126181335.12970-1-konrad.dybcio@linaro.org>
References: <20230126181335.12970-1-konrad.dybcio@linaro.org>
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

Add support for the GPU clock controller found on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:

- Add "depends on" (Krzysztof)

 drivers/clk/qcom/Kconfig        |   9 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/gpucc-sm6375.c | 480 ++++++++++++++++++++++++++++++++
 3 files changed, 490 insertions(+)
 create mode 100644 drivers/clk/qcom/gpucc-sm6375.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 4ee1bf151ee2..a5995ede04e9 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -807,6 +807,15 @@ config SM_GPUCC_6125
 	  Say Y if you want to support graphics controller devices and
 	  functionality such as 3D graphics.
 
+config SM_GPUCC_6375
+	tristate "SM6375 Graphics Clock Controller"
+	select SM_GCC_6375
+	depends on ARM64 || COMPILE_TEST
+	help
+	  Support for the graphics clock controller on SM6375 devices.
+	  Say Y if you want to support graphics controller devices and
+	  functionality such as 3D graphics.
+
 config SM_GPUCC_6350
 	tristate "SM6350 Graphics Clock Controller"
 	select SM_GCC_6350
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 14405ccf1992..5a1b65b2ac05 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -114,6 +114,7 @@ obj-$(CONFIG_SM_GCC_8450) += gcc-sm8450.o
 obj-$(CONFIG_SM_GCC_8550) += gcc-sm8550.o
 obj-$(CONFIG_SM_GPUCC_6125) += gpucc-sm6125.o
 obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
+obj-$(CONFIG_SM_GPUCC_6375) += gpucc-sm6375.o
 obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
 obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
 obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
diff --git a/drivers/clk/qcom/gpucc-sm6375.c b/drivers/clk/qcom/gpucc-sm6375.c
new file mode 100644
index 000000000000..9be3827acfae
--- /dev/null
+++ b/drivers/clk/qcom/gpucc-sm6375.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm6375-gpucc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+#include "clk-regmap-phy-mux.h"
+#include "gdsc.h"
+#include "reset.h"
+
+enum {
+	DT_BI_TCXO,
+	DT_GCC_GPU_GPLL0_CLK_SRC,
+	DT_GCC_GPU_GPLL0_DIV_CLK_SRC,
+	DT_GCC_GPU_SNOC_DVM_GFX_CLK,
+};
+
+enum {
+	P_BI_TCXO,
+	P_GCC_GPU_GPLL0_CLK_SRC,
+	P_GCC_GPU_GPLL0_DIV_CLK_SRC,
+	P_GPU_CC_PLL0_OUT_EVEN,
+	P_GPU_CC_PLL0_OUT_MAIN,
+	P_GPU_CC_PLL0_OUT_ODD,
+	P_GPU_CC_PLL1_OUT_EVEN,
+	P_GPU_CC_PLL1_OUT_MAIN,
+	P_GPU_CC_PLL1_OUT_ODD,
+};
+
+static struct pll_vco lucid_vco[] = {
+	{ 249600000, 2000000000, 0 },
+};
+
+/* 532MHz Configuration */
+static const struct alpha_pll_config gpucc_pll0_config = {
+	.l = 0x1b,
+	.alpha = 0xb555,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002261,
+	.config_ctl_hi1_val = 0x329a299c,
+	.user_ctl_val = 0x00000001,
+	.user_ctl_hi_val = 0x00000805,
+	.user_ctl_hi1_val = 0x00000000,
+};
+
+static struct clk_alpha_pll gpucc_pll0 = {
+	.offset = 0x0,
+	.vco_table = lucid_vco,
+	.num_vco = ARRAY_SIZE(lucid_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_pll0",
+			.parent_data = &(const struct clk_parent_data){
+				.index = P_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_ops,
+		},
+	},
+};
+
+/* 514MHz Configuration */
+static const struct alpha_pll_config gpucc_pll1_config = {
+	.l = 0x1a,
+	.alpha = 0xc555,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002261,
+	.config_ctl_hi1_val = 0x329a299c,
+	.user_ctl_val = 0x00000001,
+	.user_ctl_hi_val = 0x00000805,
+	.user_ctl_hi1_val = 0x00000000,
+};
+
+static struct clk_alpha_pll gpucc_pll1 = {
+	.offset = 0x100,
+	.vco_table = lucid_vco,
+	.num_vco = ARRAY_SIZE(lucid_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_pll1",
+			.parent_data = &(const struct clk_parent_data){
+				.index = P_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_ops,
+		},
+	},
+};
+
+static const struct parent_map gpucc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPU_CC_PLL0_OUT_MAIN, 1 },
+	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
+	{ P_GCC_GPU_GPLL0_CLK_SRC, 5 },
+	{ P_GCC_GPU_GPLL0_DIV_CLK_SRC, 6 },
+};
+
+static const struct clk_parent_data gpucc_parent_data_0[] = {
+	{ .index = P_BI_TCXO },
+	{ .hw = &gpucc_pll0.clkr.hw },
+	{ .hw = &gpucc_pll1.clkr.hw },
+	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
+	{ .index = DT_GCC_GPU_GPLL0_DIV_CLK_SRC },
+};
+
+static const struct parent_map gpucc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPU_CC_PLL0_OUT_EVEN, 1 },
+	{ P_GPU_CC_PLL0_OUT_ODD, 2 },
+	{ P_GPU_CC_PLL1_OUT_EVEN, 3 },
+	{ P_GPU_CC_PLL1_OUT_ODD, 4 },
+	{ P_GCC_GPU_GPLL0_CLK_SRC, 5 },
+};
+
+static const struct clk_parent_data gpucc_parent_data_1[] = {
+	{ .index = P_BI_TCXO },
+	{ .hw = &gpucc_pll0.clkr.hw },
+	{ .hw = &gpucc_pll0.clkr.hw },
+	{ .hw = &gpucc_pll1.clkr.hw },
+	{ .hw = &gpucc_pll1.clkr.hw },
+	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
+};
+
+static const struct parent_map gpucc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPU_GPLL0_CLK_SRC, 5 },
+	{ P_GCC_GPU_GPLL0_DIV_CLK_SRC, 6 },
+};
+
+static const struct clk_parent_data gpucc_parent_data_2[] = {
+	{ .index = P_BI_TCXO },
+	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
+	{ .index = DT_GCC_GPU_GPLL0_DIV_CLK_SRC },
+};
+
+static const struct freq_tbl ftbl_gpucc_gmu_clk_src[] = {
+	F(200000000, P_GCC_GPU_GPLL0_DIV_CLK_SRC, 1.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gpucc_gmu_clk_src = {
+	.cmd_rcgr = 0x1120,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gpucc_parent_map_0,
+	.freq_tbl = ftbl_gpucc_gmu_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpucc_gmu_clk_src",
+		.parent_data = gpucc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gpucc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gpucc_gx_gfx3d_clk_src[] = {
+	F(266000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
+	F(390000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
+	F(490000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
+	F(650000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
+	F(770000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
+	F(840000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
+	F(900000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gpucc_gx_gfx3d_clk_src = {
+	.cmd_rcgr = 0x101c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gpucc_parent_map_1,
+	.freq_tbl = ftbl_gpucc_gx_gfx3d_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpucc_gx_gfx3d_clk_src",
+		.parent_data = gpucc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gpucc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch gpucc_ahb_clk = {
+	.halt_reg = 0x1078,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1078,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_ahb_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpucc_cx_gfx3d_clk = {
+	.halt_reg = 0x10a4,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x10a4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_cx_gfx3d_clk",
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpucc_gx_gfx3d_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpucc_cx_gfx3d_slv_clk = {
+	.halt_reg = 0x10a8,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x10a8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_cx_gfx3d_slv_clk",
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpucc_gx_gfx3d_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpucc_cx_gmu_clk = {
+	.halt_reg = 0x1098,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1098,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_cx_gmu_clk",
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpucc_gmu_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpucc_cx_snoc_dvm_clk = {
+	.halt_reg = 0x108c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x108c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_cx_snoc_dvm_clk",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_GCC_GPU_SNOC_DVM_GFX_CLK,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpucc_cxo_aon_clk = {
+	.halt_reg = 0x1004,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_cxo_aon_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpucc_cxo_clk = {
+	.halt_reg = 0x109c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x109c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_cxo_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpucc_gx_cxo_clk = {
+	.halt_reg = 0x1060,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1060,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_gx_cxo_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpucc_gx_gfx3d_clk = {
+	.halt_reg = 0x1054,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1054,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_gx_gfx3d_clk",
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpucc_gx_gfx3d_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpucc_gx_gmu_clk = {
+	.halt_reg = 0x1064,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1064,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_gx_gmu_clk",
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpucc_gmu_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpucc_sleep_clk = {
+	.halt_reg = 0x1090,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x1090,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpucc_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc gpu_cx_gdsc = {
+	.gdscr = 0x106c,
+	.gds_hw_ctrl = 0x1540,
+	.pd = {
+		.name = "gpu_cx_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct gdsc gpu_gx_gdsc = {
+	.gdscr = 0x100c,
+	.clamp_io_ctrl = 0x1508,
+	.resets = (unsigned int []){ GPU_GX_BCR, GPU_ACD_BCR, GPU_GX_ACD_MISC_BCR },
+	.reset_count = 3,
+	.pd = {
+		.name = "gpu_gx_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = CLAMP_IO | SW_RESET | AON_RESET,
+};
+
+static struct clk_regmap *gpucc_sm6375_clocks[] = {
+	[GPU_CC_AHB_CLK] = &gpucc_ahb_clk.clkr,
+	[GPU_CC_CX_GFX3D_CLK] = &gpucc_cx_gfx3d_clk.clkr,
+	[GPU_CC_CX_GFX3D_SLV_CLK] = &gpucc_cx_gfx3d_slv_clk.clkr,
+	[GPU_CC_CX_GMU_CLK] = &gpucc_cx_gmu_clk.clkr,
+	[GPU_CC_CX_SNOC_DVM_CLK] = &gpucc_cx_snoc_dvm_clk.clkr,
+	[GPU_CC_CXO_AON_CLK] = &gpucc_cxo_aon_clk.clkr,
+	[GPU_CC_CXO_CLK] = &gpucc_cxo_clk.clkr,
+	[GPU_CC_GMU_CLK_SRC] = &gpucc_gmu_clk_src.clkr,
+	[GPU_CC_GX_CXO_CLK] = &gpucc_gx_cxo_clk.clkr,
+	[GPU_CC_GX_GFX3D_CLK] = &gpucc_gx_gfx3d_clk.clkr,
+	[GPU_CC_GX_GFX3D_CLK_SRC] = &gpucc_gx_gfx3d_clk_src.clkr,
+	[GPU_CC_GX_GMU_CLK] = &gpucc_gx_gmu_clk.clkr,
+	[GPU_CC_PLL0] = &gpucc_pll0.clkr,
+	[GPU_CC_PLL1] = &gpucc_pll1.clkr,
+	[GPU_CC_SLEEP_CLK] = &gpucc_sleep_clk.clkr,
+};
+
+static const struct qcom_reset_map gpucc_sm6375_resets[] = {
+	[GPU_GX_BCR] = { 0x1008 },
+	[GPU_ACD_BCR] = { 0x1160 },
+	[GPU_GX_ACD_MISC_BCR] = { 0x8004 },
+};
+
+static struct gdsc *gpucc_sm6375_gdscs[] = {
+	[GPU_CX_GDSC] = &gpu_cx_gdsc,
+	[GPU_GX_GDSC] = &gpu_gx_gdsc,
+};
+
+static const struct regmap_config gpucc_sm6375_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x9000,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc gpucc_sm6375_desc = {
+	.config = &gpucc_sm6375_regmap_config,
+	.clks = gpucc_sm6375_clocks,
+	.num_clks = ARRAY_SIZE(gpucc_sm6375_clocks),
+	.resets = gpucc_sm6375_resets,
+	.num_resets = ARRAY_SIZE(gpucc_sm6375_resets),
+	.gdscs = gpucc_sm6375_gdscs,
+	.num_gdscs = ARRAY_SIZE(gpucc_sm6375_gdscs),
+};
+
+static const struct of_device_id gpucc_sm6375_match_table[] = {
+	{ .compatible = "qcom,sm6375-gpucc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpucc_sm6375_match_table);
+
+static int gpucc_sm6375_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &gpucc_sm6375_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_lucid_pll_configure(&gpucc_pll0, regmap, &gpucc_pll0_config);
+	clk_lucid_pll_configure(&gpucc_pll1, regmap, &gpucc_pll1_config);
+
+	return qcom_cc_really_probe(pdev, &gpucc_sm6375_desc, regmap);
+}
+
+static struct platform_driver gpucc_sm6375_driver = {
+	.probe = gpucc_sm6375_probe,
+	.driver = {
+		.name = "gpucc-sm6375",
+		.of_match_table = gpucc_sm6375_match_table,
+	},
+};
+
+static int __init gpucc_sm6375_init(void)
+{
+	return platform_driver_register(&gpucc_sm6375_driver);
+}
+subsys_initcall(gpucc_sm6375_init);
+
+static void __exit gpucc_sm6375_exit(void)
+{
+	platform_driver_unregister(&gpucc_sm6375_driver);
+}
+module_exit(gpucc_sm6375_exit);
+
+MODULE_DESCRIPTION("QTI GPUCC SM6375 Driver");
+MODULE_LICENSE("GPL");
-- 
2.39.1

