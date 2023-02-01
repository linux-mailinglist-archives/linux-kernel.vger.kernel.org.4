Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC025686E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjBASiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjBAShd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:37:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA9C80029
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:36:56 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z11so18670285ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 10:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLtLdPRWSgZacRyT66yu3XX23m1pMiw/Q9ZIEMzd6ww=;
        b=xqNZHviQ1HBZGF2HvVGhL4Xcf6rB3q+R0rA3CNqCTbZc5MDD7YE0V75OF5WWUIjQNX
         6xgfPzN5Q+grMmFTiQ/Ed7JDpNXPEWPGY4KmFFYEHST/70Ijdh2/mL73evHSs98gxCDM
         mqKKFJnH8XkNZE197HwI0zyOXVxmTQ4LUzoAdl3YBONS9ydsRCom88+4FDMwQM4VyUZQ
         d0n2/UtMJHReLVhP9JAzpBh9vBr9nHX812pB+i4S1W0mrdJPZUVNd/UYpi4cipQjg4Mp
         jT7w/l4ZXWsxG0LxVMXIc08TdX9eq/YmGjaiQc3olaL6sM+P1566G9P1n6Qa+Ff/9Dm0
         71wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLtLdPRWSgZacRyT66yu3XX23m1pMiw/Q9ZIEMzd6ww=;
        b=yYyfcXj/pjQVaKP6A9CtKZFBcjiTTf0y4+J+VgEW4/UqEfnbJi9st76oDwKGy5PEnQ
         CtNirb3CKbNbrUFsZrLewgnJQQ+x1ww5KK2oZRy8JU+H6ooTTQ180uoPCfUORuLjZHld
         eegzblHDUITDjUHLm+O3VEVuxcvkhtgDg67fmnrVNBb1NcIyGJuSi3oM6V4ZqLnzfCAA
         K2kwIq58TsQZpeX5ViJee8OGCSKyz8byNIDZV73z+rpH10mKInFstzzYv4SUTGZTQjE9
         z8NnjM63Fq0P/ql15+YofsQEeQ5Y5MNQ/xFxRCIRuNivIn5ESde5iEGfqv56WpAG47FM
         sKTw==
X-Gm-Message-State: AO0yUKWCmUlcASNmCKcJ9alNLxYFtSb0DWFp7OaQvrCWY7iYfcCi01nj
        mQgC2CqqpUomv0k3e8ru01oVdg==
X-Google-Smtp-Source: AK7set8E/a04n1N79P+kXSXfoYNx0Dsv0k3xyYkMl8GJAbb7280nO8pMw5CV3q7LgofH+fTclv5vnA==
X-Received: by 2002:a05:6402:1bc6:b0:499:bcd7:a968 with SMTP id ch6-20020a0564021bc600b00499bcd7a968mr3187295edb.22.1675276611459;
        Wed, 01 Feb 2023 10:36:51 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id t13-20020a50d70d000000b00458b41d9460sm10297508edi.92.2023.02.01.10.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:36:51 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v5 10/10] clk: qcom: Add GPU clock controller driver for SM6115
Date:   Wed,  1 Feb 2023 19:36:26 +0100
Message-Id: <20230201183626.351211-11-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201183626.351211-1-konrad.dybcio@linaro.org>
References: <20230201183626.351211-1-konrad.dybcio@linaro.org>
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

Add support for the GPU clock controller found on SM6115.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v4 -> v5:

- Use new SLEEP/WAKE helpers

 drivers/clk/qcom/Kconfig        |   9 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/gpucc-sm6115.c | 503 ++++++++++++++++++++++++++++++++
 3 files changed, 513 insertions(+)
 create mode 100644 drivers/clk/qcom/gpucc-sm6115.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index a5995ede04e9..825701084323 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -798,6 +798,15 @@ config SM_GCC_8550
 	  Say Y if you want to use peripheral devices such as UART,
 	  SPI, I2C, USB, SD/UFS, PCIe etc.
 
+config SM_GPUCC_6115
+	tristate "SM6125 Graphics Clock Controller"
+	select SM_GCC_6115
+	depends on ARM64 || COMPILE_TEST
+	help
+	  Support for the graphics clock controller on SM6115 devices.
+	  Say Y if you want to support graphics controller devices and
+	  functionality such as 3D graphics.
+
 config SM_GPUCC_6125
 	tristate "SM6125 Graphics Clock Controller"
 	select SM_GCC_6125
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 5a1b65b2ac05..9f6b93698ef2 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_SM_GCC_8250) += gcc-sm8250.o
 obj-$(CONFIG_SM_GCC_8350) += gcc-sm8350.o
 obj-$(CONFIG_SM_GCC_8450) += gcc-sm8450.o
 obj-$(CONFIG_SM_GCC_8550) += gcc-sm8550.o
+obj-$(CONFIG_SM_GPUCC_6115) += gpucc-sm6115.o
 obj-$(CONFIG_SM_GPUCC_6125) += gpucc-sm6125.o
 obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
 obj-$(CONFIG_SM_GPUCC_6375) += gpucc-sm6375.o
diff --git a/drivers/clk/qcom/gpucc-sm6115.c b/drivers/clk/qcom/gpucc-sm6115.c
new file mode 100644
index 000000000000..c84727e8352d
--- /dev/null
+++ b/drivers/clk/qcom/gpucc-sm6115.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm6115-gpucc.h>
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
+};
+
+enum {
+	P_BI_TCXO,
+	P_GPLL0_OUT_MAIN,
+	P_GPLL0_OUT_MAIN_DIV,
+	P_GPU_CC_PLL0_OUT_AUX2,
+	P_GPU_CC_PLL0_OUT_MAIN,
+	P_GPU_CC_PLL1_OUT_AUX,
+	P_GPU_CC_PLL1_OUT_MAIN,
+};
+
+static struct pll_vco default_vco[] = {
+	{ 1000000000, 2000000000, 0 },
+};
+
+static struct pll_vco pll1_vco[] = {
+	{ 500000000, 1000000000, 2 },
+};
+
+static const struct alpha_pll_config gpu_cc_pll0_config = {
+	.l = 0x3e,
+	.alpha = 0,
+	.alpha_hi = 0x80,
+	.vco_val = 0x0 << 20,
+	.vco_mask = GENMASK(21, 20),
+	.alpha_en_mask = BIT(24),
+	.main_output_mask = BIT(0),
+	.aux_output_mask = BIT(1),
+	.aux2_output_mask = BIT(2),
+	.config_ctl_val = 0x4001055b,
+	.test_ctl_hi1_val = 0x1,
+};
+
+/* 1200MHz configuration */
+static struct clk_alpha_pll gpu_cc_pll0 = {
+	.offset = 0x0,
+	.vco_table = default_vco,
+	.num_vco = ARRAY_SIZE(default_vco),
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_pll0",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_gpu_cc_pll0_out_aux2[] = {
+	{ 0x0, 1 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv gpu_cc_pll0_out_aux2 = {
+	.offset = 0x0,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_gpu_cc_pll0_out_aux2,
+	.num_post_div = ARRAY_SIZE(post_div_table_gpu_cc_pll0_out_aux2),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpu_cc_pll0_out_aux2",
+		.parent_hws = (const struct clk_hw*[]) {
+			&gpu_cc_pll0.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_ops,
+	},
+};
+
+/* 640MHz configuration */
+static const struct alpha_pll_config gpu_cc_pll1_config = {
+	.l = 0x21,
+	.alpha = 0x55555555,
+	.alpha_hi = 0x55,
+	.alpha_en_mask = BIT(24),
+	.vco_val = 0x2 << 20,
+	.vco_mask = GENMASK(21, 20),
+	.main_output_mask = BIT(0),
+	.aux_output_mask = BIT(1),
+	.config_ctl_val = 0x4001055b,
+	.test_ctl_hi1_val = 0x1,
+};
+
+static struct clk_alpha_pll gpu_cc_pll1 = {
+	.offset = 0x100,
+	.vco_table = pll1_vco,
+	.num_vco = ARRAY_SIZE(pll1_vco),
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_pll1",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_gpu_cc_pll1_out_aux[] = {
+	{ 0x0, 1 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv gpu_cc_pll1_out_aux = {
+	.offset = 0x100,
+	.post_div_shift = 15,
+	.post_div_table = post_div_table_gpu_cc_pll1_out_aux,
+	.num_post_div = ARRAY_SIZE(post_div_table_gpu_cc_pll1_out_aux),
+	.width = 3,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpu_cc_pll1_out_aux",
+		.parent_hws = (const struct clk_hw*[]) {
+			&gpu_cc_pll1.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_ops,
+	},
+};
+
+static const struct parent_map gpu_cc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPU_CC_PLL0_OUT_MAIN, 1 },
+	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
+	{ P_GPLL0_OUT_MAIN, 5 },
+	{ P_GPLL0_OUT_MAIN_DIV, 6 },
+};
+
+static const struct clk_parent_data gpu_cc_parent_data_0[] = {
+	{ .index = P_BI_TCXO },
+	{ .hw = &gpu_cc_pll0.clkr.hw },
+	{ .hw = &gpu_cc_pll1.clkr.hw },
+	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
+	{ .index = DT_GCC_GPU_GPLL0_DIV_CLK_SRC },
+};
+
+static const struct parent_map gpu_cc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPU_CC_PLL0_OUT_AUX2, 2 },
+	{ P_GPU_CC_PLL1_OUT_AUX, 3 },
+	{ P_GPLL0_OUT_MAIN, 5 },
+};
+
+static const struct clk_parent_data gpu_cc_parent_data_1[] = {
+	{ .index = P_BI_TCXO },
+	{ .hw = &gpu_cc_pll0_out_aux2.clkr.hw },
+	{ .hw = &gpu_cc_pll1_out_aux.clkr.hw },
+	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
+};
+
+static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
+	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gpu_cc_gmu_clk_src = {
+	.cmd_rcgr = 0x1120,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gpu_cc_parent_map_0,
+	.freq_tbl = ftbl_gpu_cc_gmu_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpu_cc_gmu_clk_src",
+		.parent_data = gpu_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gpu_cc_gx_gfx3d_clk_src[] = {
+	F(320000000, P_GPU_CC_PLL1_OUT_AUX, 2, 0, 0),
+	F(465000000, P_GPU_CC_PLL1_OUT_AUX, 2, 0, 0),
+	F(600000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
+	F(745000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
+	F(820000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
+	F(900000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
+	F(950000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
+	F(980000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gpu_cc_gx_gfx3d_clk_src = {
+	.cmd_rcgr = 0x101c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gpu_cc_parent_map_1,
+	.freq_tbl = ftbl_gpu_cc_gx_gfx3d_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpu_cc_gx_gfx3d_clk_src",
+		.parent_data = gpu_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch gpu_cc_ahb_clk = {
+	.halt_reg = 0x1078,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1078,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_ahb_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_crc_ahb_clk = {
+	.halt_reg = 0x107c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x107c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_crc_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cx_gfx3d_clk = {
+	.halt_reg = 0x10a4,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x10a4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_cx_gfx3d_clk",
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpu_cc_gx_gfx3d_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cx_gmu_clk = {
+	.halt_reg = 0x1098,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1098,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_cx_gmu_clk",
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpu_cc_gmu_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cx_snoc_dvm_clk = {
+	.halt_reg = 0x108c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x108c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_cx_snoc_dvm_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cxo_aon_clk = {
+	.halt_reg = 0x1004,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_cxo_aon_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cxo_clk = {
+	.halt_reg = 0x109c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x109c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_cxo_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_gx_cxo_clk = {
+	.halt_reg = 0x1060,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1060,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_gx_cxo_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_gx_gfx3d_clk = {
+	.halt_reg = 0x1054,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x1054,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_gx_gfx3d_clk",
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpu_cc_gx_gfx3d_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_sleep_clk = {
+	.halt_reg = 0x1090,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1090,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_hlos1_vote_gpu_smmu_clk = {
+	.halt_reg = 0x5000,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x5000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			 .name = "gpu_cc_hlos1_vote_gpu_smmu_clk",
+			 .ops = &clk_branch2_ops,
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
+	.resets = (unsigned int []){ GPU_GX_BCR },
+	.reset_count = 1,
+	.pd = {
+		.name = "gpu_gx_gdsc",
+	},
+	.parent = &gpu_cx_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = CLAMP_IO | SW_RESET | VOTABLE,
+};
+
+static struct clk_regmap *gpu_cc_sm6115_clocks[] = {
+	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
+	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
+	[GPU_CC_CX_GFX3D_CLK] = &gpu_cc_cx_gfx3d_clk.clkr,
+	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
+	[GPU_CC_CX_SNOC_DVM_CLK] = &gpu_cc_cx_snoc_dvm_clk.clkr,
+	[GPU_CC_CXO_AON_CLK] = &gpu_cc_cxo_aon_clk.clkr,
+	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
+	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
+	[GPU_CC_GX_CXO_CLK] = &gpu_cc_gx_cxo_clk.clkr,
+	[GPU_CC_GX_GFX3D_CLK] = &gpu_cc_gx_gfx3d_clk.clkr,
+	[GPU_CC_GX_GFX3D_CLK_SRC] = &gpu_cc_gx_gfx3d_clk_src.clkr,
+	[GPU_CC_PLL0] = &gpu_cc_pll0.clkr,
+	[GPU_CC_PLL0_OUT_AUX2] = &gpu_cc_pll0_out_aux2.clkr,
+	[GPU_CC_PLL1] = &gpu_cc_pll1.clkr,
+	[GPU_CC_PLL1_OUT_AUX] = &gpu_cc_pll1_out_aux.clkr,
+	[GPU_CC_SLEEP_CLK] = &gpu_cc_sleep_clk.clkr,
+	[GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK] = &gpu_cc_hlos1_vote_gpu_smmu_clk.clkr,
+};
+
+static const struct qcom_reset_map gpu_cc_sm6115_resets[] = {
+	[GPU_GX_BCR] = { 0x1008 },
+};
+
+static struct gdsc *gpu_cc_sm6115_gdscs[] = {
+	[GPU_CX_GDSC] = &gpu_cx_gdsc,
+	[GPU_GX_GDSC] = &gpu_gx_gdsc,
+};
+
+static const struct regmap_config gpu_cc_sm6115_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x9000,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc gpu_cc_sm6115_desc = {
+	.config = &gpu_cc_sm6115_regmap_config,
+	.clks = gpu_cc_sm6115_clocks,
+	.num_clks = ARRAY_SIZE(gpu_cc_sm6115_clocks),
+	.resets = gpu_cc_sm6115_resets,
+	.num_resets = ARRAY_SIZE(gpu_cc_sm6115_resets),
+	.gdscs = gpu_cc_sm6115_gdscs,
+	.num_gdscs = ARRAY_SIZE(gpu_cc_sm6115_gdscs),
+};
+
+static const struct of_device_id gpu_cc_sm6115_match_table[] = {
+	{ .compatible = "qcom,sm6115-gpucc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpu_cc_sm6115_match_table);
+
+static int gpu_cc_sm6115_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &gpu_cc_sm6115_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_alpha_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
+	clk_alpha_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
+
+	/* Set recommended WAKEUP/SLEEP settings for the gpu_cc_cx_gmu_clk */
+	qcom_branch_set_wakeup(regmap, gpu_cc_cx_gmu_clk, 0xf);
+	qcom_branch_set_sleep(regmap, gpu_cc_cx_gmu_clk, 0xf);
+
+	qcom_branch_set_force_mem_core(regmap, gpu_cc_gx_gfx3d_clk, true);
+	qcom_branch_set_force_periph_on(regmap, gpu_cc_gx_gfx3d_clk, true);
+
+	return qcom_cc_really_probe(pdev, &gpu_cc_sm6115_desc, regmap);
+}
+
+static struct platform_driver gpu_cc_sm6115_driver = {
+	.probe = gpu_cc_sm6115_probe,
+	.driver = {
+		.name = "sm6115-gpucc",
+		.of_match_table = gpu_cc_sm6115_match_table,
+	},
+};
+module_platform_driver(gpu_cc_sm6115_driver);
+
+MODULE_DESCRIPTION("QTI GPU_CC SM6115 Driver");
+MODULE_LICENSE("GPL");
-- 
2.39.1

