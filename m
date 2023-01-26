Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60D67CE66
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjAZOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAZOku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:40:50 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69BC618B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:40:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id me3so5583613ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7zcErxqlxqs6kCMd6LtTu3Ww8CQfRK8SEJg/YZ2bS8=;
        b=KIA+X1O8rDbJJRjKiRV+UktRHucHl2/RaKbeeecs4sfPVn8JGjzeOMQtB/v5BX7+Ii
         JFrVPu5IosqMW47jYFHIDQLHyBjOXLJWKkCPRG8otpBz0UBuDjItfRFr92yZHdJhps/8
         SM2xKjcB/pqTNc3tdUIOHDVpQwwm8Z98vQmjgQhsisCcL/LbBHzMy5CO76+Oz8+dNEid
         IpwGsFo9PEUFMWMBNNSBAV47nVsbHZxz8N3YY4Y85GNQ7N9Za3B4SjdWPiSIIW/wrq3z
         ME5CZaYFGmUlR98cmwf0UPf7Qzd0q4H2fmG8QqtjEK/5vssoltEUx9YuzTFdUcyCXQd9
         4Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7zcErxqlxqs6kCMd6LtTu3Ww8CQfRK8SEJg/YZ2bS8=;
        b=7+jZMiBigpP8cYtgqSicetGyuo6xangiFCkHeMOzsMcboG9fACwz/wbMS3LlCfwDZW
         RbByI5LX7WqcymJxG8XSl3uzi3YA7kXdXr9cxzJRBTW4PTPscAOnrVLL6cobHQq5vXH7
         K3lryAJKstWx+gWYy/j/rUQqWYwVZ1NIldSwZWALmLsEv84bctbd3iQUXP782cPg++0u
         /zanL+fp0fPsauylBEn3CAqZmjsf17dhFOdUsPKoyEVk+iGwdLPjEmMnnSjTz/kGYp5K
         mz8eOc6C7ZsernhRgvqHBCUGwZBUR0R76I/IE12RhUH1MsVrgNz9yuLzyFleuTPQF7z1
         ZjZQ==
X-Gm-Message-State: AFqh2ko4NPM2jKAhzlAJq0JslPTY6VXSnQe7tGWbSaAp+cw3F+lgG9ji
        MR+5cOdI1syYsZnJ2qU9vwYerQ==
X-Google-Smtp-Source: AMrXdXsXYC9ZSNByHYw628weMYfX3xwDM6OzV4jamZoxvUTepoG47rmZqheJmJdmcEYqFGk5p+6eVg==
X-Received: by 2002:a17:906:5e09:b0:7c1:727c:5f70 with SMTP id n9-20020a1709065e0900b007c1727c5f70mr36822136eju.46.1674744048399;
        Thu, 26 Jan 2023 06:40:48 -0800 (PST)
Received: from localhost.localdomain (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id s19-20020a1709060c1300b008699bacc03csm697547ejf.14.2023.01.26.06.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:40:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 2/6] clk: qcom: Add GPU clock controller driver for SM6125
Date:   Thu, 26 Jan 2023 15:40:29 +0100
Message-Id: <20230126144033.216206-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126144033.216206-1-konrad.dybcio@linaro.org>
References: <20230126144033.216206-1-konrad.dybcio@linaro.org>
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

Add support for the GPU clock controller found on SM6125.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/Kconfig        |   8 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/gpucc-sm6125.c | 444 ++++++++++++++++++++++++++++++++
 3 files changed, 453 insertions(+)
 create mode 100644 drivers/clk/qcom/gpucc-sm6125.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index ca6c7d2ada6c..ca2c83ecc6a6 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -798,6 +798,14 @@ config SM_GCC_8550
 	  Say Y if you want to use peripheral devices such as UART,
 	  SPI, I2C, USB, SD/UFS, PCIe etc.
 
+config SM_GPUCC_6125
+	tristate "SM6125 Graphics Clock Controller"
+	select SM_GCC_6125
+	help
+	  Support for the graphics clock controller on SM6125 devices.
+	  Say Y if you want to support graphics controller devices and
+	  functionality such as 3D graphics.
+
 config SM_GPUCC_6350
 	tristate "SM6350 Graphics Clock Controller"
 	select SM_GCC_6350
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index e41ea0efe8c4..14405ccf1992 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_SM_GCC_8250) += gcc-sm8250.o
 obj-$(CONFIG_SM_GCC_8350) += gcc-sm8350.o
 obj-$(CONFIG_SM_GCC_8450) += gcc-sm8450.o
 obj-$(CONFIG_SM_GCC_8550) += gcc-sm8550.o
+obj-$(CONFIG_SM_GPUCC_6125) += gpucc-sm6125.o
 obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
 obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
 obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
diff --git a/drivers/clk/qcom/gpucc-sm6125.c b/drivers/clk/qcom/gpucc-sm6125.c
new file mode 100644
index 000000000000..34cd8459c121
--- /dev/null
+++ b/drivers/clk/qcom/gpucc-sm6125.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm6125-gpucc.h>
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
+#define CX_GMU_CBCR_SLEEP_MASK		0xf
+#define CX_GMU_CBCR_SLEEP_SHIFT		4
+#define CX_GMU_CBCR_WAKE_MASK		0xf
+#define CX_GMU_CBCR_WAKE_SHIFT		8
+
+enum {
+	DT_BI_TCXO,
+	DT_GCC_GPU_GPLL0_CLK_SRC,
+};
+
+enum {
+	P_BI_TCXO,
+	P_GPLL0_OUT_MAIN,
+	P_GPU_CC_PLL0_2X_CLK,
+	P_GPU_CC_PLL0_OUT_AUX2,
+	P_GPU_CC_PLL1_OUT_AUX,
+	P_GPU_CC_PLL1_OUT_AUX2,
+};
+
+static struct pll_vco gpu_cc_pll_vco[] = {
+	{ 1000000000, 2000000000, 0 },
+	{ 500000000,  1000000000, 2 },
+};
+
+/* 1020MHz configuration */
+static const struct alpha_pll_config gpu_pll0_config = {
+	.l = 0x35,
+	.config_ctl_val = 0x4001055b,
+	.alpha_hi = 0x20,
+	.alpha = 0x00,
+	.alpha_en_mask = BIT(24),
+	.vco_val = 0x0 << 20,
+	.vco_mask = 0x3 << 20,
+	.aux2_output_mask = BIT(2),
+};
+
+/* 930MHz configuration */
+static const struct alpha_pll_config gpu_pll1_config = {
+	.l = 0x30,
+	.config_ctl_val = 0x4001055b,
+	.alpha_hi = 0x70,
+	.alpha = 0x00,
+	.alpha_en_mask = BIT(24),
+	.vco_val = 0x2 << 20,
+	.vco_mask = 0x3 << 20,
+	.aux2_output_mask = BIT(2),
+};
+
+static struct clk_alpha_pll gpu_cc_pll0_out_aux2 = {
+	.offset = 0x0,
+	.vco_table = gpu_cc_pll_vco,
+	.num_vco = ARRAY_SIZE(gpu_cc_pll_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_pll0_out_aux2",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gpu_cc_pll1_out_aux2 = {
+	.offset = 0x100,
+	.vco_table = gpu_cc_pll_vco,
+	.num_vco = ARRAY_SIZE(gpu_cc_pll_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_pll1_out_aux2",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static const struct parent_map gpu_cc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPLL0_OUT_MAIN, 5 },
+};
+
+static const struct clk_parent_data gpu_cc_parent_data_0[] = {
+	{ .index = DT_BI_TCXO },
+	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
+};
+
+static const struct parent_map gpu_cc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPU_CC_PLL0_OUT_AUX2, 2 },
+	{ P_GPU_CC_PLL1_OUT_AUX2, 4 },
+};
+
+static const struct clk_parent_data gpu_cc_parent_data_1[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gpu_cc_pll0_out_aux2.clkr.hw },
+	{ .hw = &gpu_cc_pll1_out_aux2.clkr.hw },
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
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gpu_cc_gx_gfx3d_clk_src[] = {
+	F(320000000, P_GPU_CC_PLL1_OUT_AUX2, 2, 0, 0),
+	F(465000000, P_GPU_CC_PLL1_OUT_AUX2, 2, 0, 0),
+	F(600000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
+	F(745000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
+	F(820000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
+	F(900000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
+	F(950000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
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
+static struct clk_branch gpu_cc_cx_apb_clk = {
+	.halt_reg = 0x1088,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1088,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_cx_apb_clk",
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
+			.parent_data = &(const struct clk_parent_data) {
+				.hw = &gpu_cc_gx_gfx3d_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_data = &(const struct clk_parent_data) {
+				.hw = &gpu_cc_gx_gfx3d_clk.clkr.hw,
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
+			.parent_data = &(const struct clk_parent_data) {
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
+static struct clk_branch gpu_cc_hlos1_vote_gpu_smmu_clk = {
+	.halt_reg = 0x5000,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x5000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_hlos1_vote_gpu_smmu_clk",
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
+	.pd = {
+		.name = "gpu_gx_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct clk_regmap *gpu_cc_sm6125_clocks[] = {
+	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
+	[GPU_CC_CX_APB_CLK] = &gpu_cc_cx_apb_clk.clkr,
+	[GPU_CC_CX_GFX3D_CLK] = &gpu_cc_cx_gfx3d_clk.clkr,
+	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
+	[GPU_CC_CX_SNOC_DVM_CLK] = &gpu_cc_cx_snoc_dvm_clk.clkr,
+	[GPU_CC_CXO_AON_CLK] = &gpu_cc_cxo_aon_clk.clkr,
+	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
+	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
+	[GPU_CC_PLL0_OUT_AUX2] = &gpu_cc_pll0_out_aux2.clkr,
+	[GPU_CC_PLL1_OUT_AUX2] = &gpu_cc_pll1_out_aux2.clkr,
+	[GPU_CC_SLEEP_CLK] = &gpu_cc_sleep_clk.clkr,
+	[GPU_CC_GX_GFX3D_CLK] = &gpu_cc_gx_gfx3d_clk.clkr,
+	[GPU_CC_GX_GFX3D_CLK_SRC] = &gpu_cc_gx_gfx3d_clk_src.clkr,
+	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
+	[GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK] = &gpu_cc_hlos1_vote_gpu_smmu_clk.clkr,
+};
+
+static struct gdsc *gpucc_sm6125_gdscs[] = {
+	[GPU_CX_GDSC] = &gpu_cx_gdsc,
+	[GPU_GX_GDSC] = &gpu_gx_gdsc,
+};
+
+static const struct regmap_config gpu_cc_sm6125_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x9000,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc gpu_cc_sm6125_desc = {
+	.config = &gpu_cc_sm6125_regmap_config,
+	.clks = gpu_cc_sm6125_clocks,
+	.num_clks = ARRAY_SIZE(gpu_cc_sm6125_clocks),
+	.gdscs = gpucc_sm6125_gdscs,
+	.num_gdscs = ARRAY_SIZE(gpucc_sm6125_gdscs),
+};
+
+static const struct of_device_id gpu_cc_sm6125_match_table[] = {
+	{ .compatible = "qcom,sm6125-gpucc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpu_cc_sm6125_match_table);
+
+static int gpu_cc_sm6125_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+	unsigned int value, mask;
+
+	regmap = qcom_cc_map(pdev, &gpu_cc_sm6125_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_alpha_pll_configure(&gpu_cc_pll0_out_aux2, regmap, &gpu_pll0_config);
+	clk_alpha_pll_configure(&gpu_cc_pll1_out_aux2, regmap, &gpu_pll1_config);
+
+	/* Recommended WAKEUP/SLEEP settings for the gpu_cc_cx_gmu_clk */
+	mask = CX_GMU_CBCR_WAKE_MASK << CX_GMU_CBCR_WAKE_SHIFT;
+	mask |= CX_GMU_CBCR_SLEEP_MASK << CX_GMU_CBCR_SLEEP_SHIFT;
+	value = 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEEP_SHIFT;
+	regmap_update_bits(regmap, gpu_cc_cx_gmu_clk.clkr.enable_reg, mask, value);
+
+	/* Set up PERIPH/MEM retain on the GPU core clock */
+	regmap_update_bits(regmap, gpu_cc_gx_gfx3d_clk.halt_reg,
+			   (BIT(14) | BIT(13)), (BIT(14) | BIT(13)));
+
+	return qcom_cc_really_probe(pdev, &gpu_cc_sm6125_desc, regmap);
+}
+
+static struct platform_driver gpu_cc_sm6125_driver = {
+	.probe = gpu_cc_sm6125_probe,
+	.driver = {
+		.name = "gpucc-sm6125",
+		.of_match_table = gpu_cc_sm6125_match_table,
+	},
+};
+
+static int __init gpu_cc_sm6125_init(void)
+{
+	return platform_driver_register(&gpu_cc_sm6125_driver);
+}
+subsys_initcall(gpu_cc_sm6125_init);
+
+static void __exit gpu_cc_sm6125_exit(void)
+{
+	platform_driver_unregister(&gpu_cc_sm6125_driver);
+}
+module_exit(gpu_cc_sm6125_exit);
+
+MODULE_DESCRIPTION("QTI GPUCC SM6125 Driver");
+MODULE_LICENSE("GPL");
-- 
2.39.1

