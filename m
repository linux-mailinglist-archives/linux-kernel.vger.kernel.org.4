Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10078686E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjBAShe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBAShU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:37:20 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FF47FA0A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:36:49 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v13so18618246eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 10:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og3Oc91UlBG1GlMV+EWWkVOrWZ/L02m4dPMjrXYNZyw=;
        b=BN3Sawj+KgXWxL4tPCNWbYiwEBd9parliypO6KAZZyvUX09v8zffqF0H/hF6BH6k3+
         h99061XYs8SolRXuy36c/hen7Hm0DReN4UZysXhFk9yHdl4Ekcp8cOJoK3yicG+68itC
         hmyzBx4+nO9nHonpUIt7qdtGMTeT8McfLodvlJ2J7iJEtVjIyGDKxSsD662QGJgL8Gm2
         a3JaH/n4XrgApXXzDOi0LJ52PXnxtuNh8V26Ze0GC+qLgztDCOAsrJi4GUg1s5pzT7Sp
         QN952mwekQNoSMh868CkYjAfhDWtjb2+eVyqTb/OkvkAVwCqzbfVD3b5fYyRec1+52Mv
         /CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Og3Oc91UlBG1GlMV+EWWkVOrWZ/L02m4dPMjrXYNZyw=;
        b=VQGqcui2CavLxddezx5Ocwk48MfBitzK97Fen0H5GnLnZ+Ez3JYieainOCEiNYjvZT
         Ni8A+3YzmjO5AeRft4aE2bMbRsP/bM0gTgKaVbCi+WePMsp5WeC1/QsQOf8tyaEf9LCe
         elFoz+sIHGQDNbZK+LjSoZb5hu+RAiWy7ieR5rSt05oqCV7lWVoCO4DaV4pk5LqYrF2c
         qtWxgztzjVpz4C7Nzx0+frsejaidD3587my7xXU/jLCk1w/xdr328EdOmMxT/rMRDAnp
         fqiLXE6msZlPQvwbP5r1eEF2fEY0jC114NaEATP+56viFSdML8wPQPooZkCRBlyRNRm2
         ZCMg==
X-Gm-Message-State: AO0yUKVtw6YHj7Bb3wBCFu7NJtL7/fiRtVoawzxoq85d9uAFx2qMko8Z
        yNitepmBz1mL35wJuTDlS/G7pQ==
X-Google-Smtp-Source: AK7set9yumJUFQD/JmZWtdEoNcFRaHR1HskltEhIeMMgyMwDVL8QeTNJcsQQjMxe79SSs6Hfj7y1LQ==
X-Received: by 2002:a05:6402:160e:b0:4a2:4abb:8d2b with SMTP id f14-20020a056402160e00b004a24abb8d2bmr2929038edv.6.1675276601730;
        Wed, 01 Feb 2023 10:36:41 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id t13-20020a50d70d000000b00458b41d9460sm10297508edi.92.2023.02.01.10.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:36:41 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v5 06/10] clk: qcom: Add GPU clock controller driver for SM6125
Date:   Wed,  1 Feb 2023 19:36:22 +0100
Message-Id: <20230201183626.351211-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201183626.351211-1-konrad.dybcio@linaro.org>
References: <20230201183626.351211-1-konrad.dybcio@linaro.org>
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v4 -> v5:

- Use the new SLEEP/WAKE helpers

 drivers/clk/qcom/Kconfig        |   9 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/gpucc-sm6125.c | 424 ++++++++++++++++++++++++++++++++
 3 files changed, 434 insertions(+)
 create mode 100644 drivers/clk/qcom/gpucc-sm6125.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index ca6c7d2ada6c..4ee1bf151ee2 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -798,6 +798,15 @@ config SM_GCC_8550
 	  Say Y if you want to use peripheral devices such as UART,
 	  SPI, I2C, USB, SD/UFS, PCIe etc.
 
+config SM_GPUCC_6125
+	tristate "SM6125 Graphics Clock Controller"
+	select SM_GCC_6125
+	depends on ARM64 || COMPILE_TEST
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
index 000000000000..d4f1296a48ef
--- /dev/null
+++ b/drivers/clk/qcom/gpucc-sm6125.c
@@ -0,0 +1,424 @@
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&gpu_cc_gx_gfx3d_clk_src.clkr.hw,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&gpu_cc_gx_gfx3d_clk.clkr.hw,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&gpu_cc_gmu_clk_src.clkr.hw,
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
+
+	regmap = qcom_cc_map(pdev, &gpu_cc_sm6125_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_alpha_pll_configure(&gpu_cc_pll0_out_aux2, regmap, &gpu_pll0_config);
+	clk_alpha_pll_configure(&gpu_cc_pll1_out_aux2, regmap, &gpu_pll1_config);
+
+	/* Set recommended WAKEUP/SLEEP settings for the gpu_cc_cx_gmu_clk */
+	qcom_branch_set_wakeup(regmap, gpu_cc_cx_gmu_clk, 0xf);
+	qcom_branch_set_sleep(regmap, gpu_cc_cx_gmu_clk, 0xf);
+
+	qcom_branch_set_force_mem_core(regmap, gpu_cc_gx_gfx3d_clk, true);
+	qcom_branch_set_force_periph_on(regmap, gpu_cc_gx_gfx3d_clk, true);
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
+module_platform_driver(gpu_cc_sm6125_driver);
+
+MODULE_DESCRIPTION("QTI GPUCC SM6125 Driver");
+MODULE_LICENSE("GPL");
-- 
2.39.1

