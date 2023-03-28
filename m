Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16E56CCAC3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjC1Tgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjC1Tgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:36:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437635BF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:36:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so4677387wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680032203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDnwPaVexo5B1g88nheOFvterzJspb//g6jFEqzt/ng=;
        b=wgyLqUJ68HRmOMltiSQ9yfkMkXTC9hRYe7JO4WK3DxU6Y1vEOyDvwl5rTXQwOen953
         wkP+DV0xIqUqnhf/XBbdDtnGTDHZhbf0dcSk7J10+FRdZKDXwmFb2DIcwpffA90BnReZ
         Mma/mm/352GFDGE5lZWbgh92XjqrKlkLtlQbgEhGE4LRyxz0UKeVmz2uLkuDD5CL2Jhl
         HeZrD5kkj1TUqg5St88jSxLouxdhZQGRYvjf7QIJBGEOqrAEeAAebZ0oW7Pugd2US+R5
         Qn0XnPQ00OsUjUTBQrM9xQJmCPn4DX6maQ97kEPjXIF45ocgJIFWUJh2si48GJcucTws
         WqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680032203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDnwPaVexo5B1g88nheOFvterzJspb//g6jFEqzt/ng=;
        b=nDX/RhOX+dIB0b8k6kIjyVn0WXeau1/lxfnrA1AMBSYkS8s19TCCYJwY2kevcdHENO
         blfgTkobdwu2sSqiXnIn6v3+TTLJnLceCYUMG6v+vhD6MphZS8LN6Fo+MwD+vpNF7Pr2
         K6qqA/whTVqM6Jpuo54C5P0e++IAQCnM+Ka/QsKZ78pjJ5QPII6DrtONEKyb6d6CB8B+
         cZcsvC2FejhSoz0rmlgWdd4826pI+q8bjMugLJ/XveQti66ZcEard1pszB9XvzH2kZv9
         t11wEZQ5xkIomHld4QsgfA4fi+i6arwMApZzRjNbBd3a6jWSvRayfuIsvmeHq0VpTU83
         7CQQ==
X-Gm-Message-State: AO0yUKWnh+Zvshs4Bu+7X0rBekY1RK2kOPqDTdTj1FNXDnzajpyFEV3y
        OlA/k2TB84D303pQCe7uIO64DA==
X-Google-Smtp-Source: AK7set8iApAGu94GcII/SNyCcrJaWTrpi7NPVlBjBWC6yFI/ofCxaqXtnrFU+u6nQvQWphS2OofKFA==
X-Received: by 2002:a05:600c:1d10:b0:3ee:f807:bcf2 with SMTP id l16-20020a05600c1d1000b003eef807bcf2mr12525525wms.3.1680032202780;
        Tue, 28 Mar 2023 12:36:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7b39:552d:b2f1:d7e8])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003eb5ce1b734sm18060544wmk.7.2023.03.28.12.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 12:36:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/7] clk: qcom: add the GPUCC driver for sa8775p
Date:   Tue, 28 Mar 2023 21:36:27 +0200
Message-Id: <20230328193632.226095-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230328193632.226095-1-brgl@bgdev.pl>
References: <20230328193632.226095-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shazad Hussain <quic_shazhuss@quicinc.com>

Add the clock driver for the Qualcomm Graphics Clock control module.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
[Bartosz: make ready for upstream]
Co-authored-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/clk/qcom/Kconfig         |   8 +
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/gpucc-sa8775p.c | 633 +++++++++++++++++++++++++++++++
 3 files changed, 642 insertions(+)
 create mode 100644 drivers/clk/qcom/gpucc-sa8775p.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 449bc8314d21..5e1919738aeb 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -437,6 +437,14 @@ config SA_GCC_8775P
 	  Say Y if you want to use peripheral devices such as UART, SPI,
 	  I2C, USB, UFS, SDCC, etc.
 
+config SA_GPUCC_8775P
+	tristate "SA8775P Graphics clock controller"
+	select SA_GCC_8775P
+	help
+	  Support for the graphics clock controller on SA8775P devices.
+	  Say Y if you want to support graphics controller devices and
+	  functionality such as 3D graphics.
+
 config SC_GCC_7180
 	tristate "SC7180 Global Clock Controller"
 	select QCOM_GDSC
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index c1adb427d1ef..525e0172a1ef 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_SC_DISPCC_7180) += dispcc-sc7180.o
 obj-$(CONFIG_SC_DISPCC_7280) += dispcc-sc7280.o
 obj-$(CONFIG_SC_DISPCC_8280XP) += dispcc-sc8280xp.o
 obj-$(CONFIG_SA_GCC_8775P) += gcc-sa8775p.o
+obj-$(CONFIG_SA_GPUCC_8775P) += gpucc-sa8775p.o
 obj-$(CONFIG_SC_GCC_7180) += gcc-sc7180.o
 obj-$(CONFIG_SC_GCC_7280) += gcc-sc7280.o
 obj-$(CONFIG_SC_GCC_8180X) += gcc-sc8180x.o
diff --git a/drivers/clk/qcom/gpucc-sa8775p.c b/drivers/clk/qcom/gpucc-sa8775p.c
new file mode 100644
index 000000000000..46d73bd0199b
--- /dev/null
+++ b/drivers/clk/qcom/gpucc-sa8775p.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "common.h"
+#include "reset.h"
+#include "gdsc.h"
+
+/* Need to match the order of clocks in DT binding */
+enum {
+	DT_IFACE,
+	DT_BI_TCXO,
+	DT_GCC_GPU_GPLL0_CLK_SRC,
+	DT_GCC_GPU_GPLL0_DIV_CLK_SRC,
+};
+
+enum {
+	P_BI_TCXO,
+	P_GPLL0_OUT_MAIN,
+	P_GPLL0_OUT_MAIN_DIV,
+	P_GPU_CC_PLL0_OUT_MAIN,
+	P_GPU_CC_PLL1_OUT_MAIN,
+};
+
+static const struct clk_parent_data parent_data_tcxo = { .index = DT_BI_TCXO };
+
+static const struct pll_vco lucid_evo_vco[] = {
+	{ 249600000, 2020000000, 0 },
+};
+
+/* 810MHz configuration */
+static struct alpha_pll_config gpu_cc_pll0_config = {
+	.l = 0x2a,
+	.alpha = 0x3000,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00182261,
+	.config_ctl_hi1_val = 0x32aa299c,
+	.user_ctl_val = 0x00000001,
+	.user_ctl_hi_val = 0x00400805,
+};
+
+static struct clk_alpha_pll gpu_cc_pll0 = {
+	.offset = 0x0,
+	.vco_table = lucid_evo_vco,
+	.num_vco = ARRAY_SIZE(lucid_evo_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_pll0",
+			.parent_data = &parent_data_tcxo,
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_evo_ops,
+		},
+	},
+};
+
+/* 1000MHz configuration */
+static struct alpha_pll_config gpu_cc_pll1_config = {
+	.l = 0x34,
+	.alpha = 0x1555,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00182261,
+	.config_ctl_hi1_val = 0x32aa299c,
+	.user_ctl_val = 0x00000001,
+	.user_ctl_hi_val = 0x00400805,
+};
+
+static struct clk_alpha_pll gpu_cc_pll1 = {
+	.offset = 0x1000,
+	.vco_table = lucid_evo_vco,
+	.num_vco = ARRAY_SIZE(lucid_evo_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_pll1",
+			.parent_data = &parent_data_tcxo,
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_evo_ops,
+		},
+	},
+};
+
+static const struct parent_map gpu_cc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPLL0_OUT_MAIN, 5 },
+	{ P_GPLL0_OUT_MAIN_DIV, 6 },
+};
+
+static const struct clk_parent_data gpu_cc_parent_data_0[] = {
+	{ .index = DT_BI_TCXO },
+	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
+	{ .index = DT_GCC_GPU_GPLL0_DIV_CLK_SRC },
+};
+
+static const struct parent_map gpu_cc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPU_CC_PLL0_OUT_MAIN, 1 },
+	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
+	{ P_GPLL0_OUT_MAIN, 5 },
+	{ P_GPLL0_OUT_MAIN_DIV, 6 },
+};
+
+static const struct clk_parent_data gpu_cc_parent_data_1[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gpu_cc_pll0.clkr.hw },
+	{ .hw = &gpu_cc_pll1.clkr.hw },
+	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
+	{ .index = DT_GCC_GPU_GPLL0_DIV_CLK_SRC },
+};
+
+static const struct parent_map gpu_cc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
+	{ P_GPLL0_OUT_MAIN, 5 },
+	{ P_GPLL0_OUT_MAIN_DIV, 6 },
+};
+
+static const struct clk_parent_data gpu_cc_parent_data_2[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gpu_cc_pll1.clkr.hw },
+	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
+	{ .index = DT_GCC_GPU_GPLL0_DIV_CLK_SRC },
+};
+
+static const struct parent_map gpu_cc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+};
+
+static const struct clk_parent_data gpu_cc_parent_data_3[] = {
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct freq_tbl ftbl_gpu_cc_ff_clk_src[] = {
+	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gpu_cc_ff_clk_src = {
+	.cmd_rcgr = 0x9474,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gpu_cc_parent_map_0,
+	.freq_tbl = ftbl_gpu_cc_ff_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gpu_cc_ff_clk_src",
+		.parent_data = gpu_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
+	F(500000000, P_GPU_CC_PLL1_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gpu_cc_gmu_clk_src = {
+	.cmd_rcgr = 0x9318,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gpu_cc_parent_map_1,
+	.freq_tbl = ftbl_gpu_cc_gmu_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gpu_cc_gmu_clk_src",
+		.parent_data = gpu_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gpu_cc_hub_clk_src[] = {
+	F(240000000, P_GPLL0_OUT_MAIN, 2.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gpu_cc_hub_clk_src = {
+	.cmd_rcgr = 0x93ec,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gpu_cc_parent_map_2,
+	.freq_tbl = ftbl_gpu_cc_hub_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gpu_cc_hub_clk_src",
+		.parent_data = gpu_cc_parent_data_2,
+		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gpu_cc_xo_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gpu_cc_xo_clk_src = {
+	.cmd_rcgr = 0x9010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gpu_cc_parent_map_3,
+	.freq_tbl = ftbl_gpu_cc_xo_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gpu_cc_xo_clk_src",
+		.parent_data = gpu_cc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_3),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div gpu_cc_demet_div_clk_src = {
+	.reg = 0x9054,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gpu_cc_demet_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&gpu_cc_xo_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div gpu_cc_hub_ahb_div_clk_src = {
+	.reg = 0x9430,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gpu_cc_hub_ahb_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&gpu_cc_hub_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div gpu_cc_hub_cx_int_div_clk_src = {
+	.reg = 0x942c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gpu_cc_hub_cx_int_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&gpu_cc_hub_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_branch gpu_cc_ahb_clk = {
+	.halt_reg = 0x911c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x911c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_hub_ahb_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cb_clk = {
+	.halt_reg = 0x93a4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x93a4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_cb_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_crc_ahb_clk = {
+	.halt_reg = 0x9120,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x9120,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_crc_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_hub_ahb_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cx_ff_clk = {
+	.halt_reg = 0x914c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x914c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_cx_ff_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_ff_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cx_gmu_clk = {
+	.halt_reg = 0x913c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x913c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_cx_gmu_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_gmu_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags =  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cx_snoc_dvm_clk = {
+	.halt_reg = 0x9130,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x9130,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_cx_snoc_dvm_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cxo_aon_clk = {
+	.halt_reg = 0x9004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x9004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_cxo_aon_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cxo_clk = {
+	.halt_reg = 0x9144,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9144,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_cxo_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags =  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_demet_clk = {
+	.halt_reg = 0x900c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x900c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_demet_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_demet_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_hlos1_vote_gpu_smmu_clk = {
+	.halt_reg = 0x7000,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x7000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_hlos1_vote_gpu_smmu_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_hub_aon_clk = {
+	.halt_reg = 0x93e8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x93e8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_hub_aon_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_hub_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_hub_cx_int_clk = {
+	.halt_reg = 0x9148,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9148,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_hub_cx_int_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_hub_cx_int_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags =  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_memnoc_gfx_clk = {
+	.halt_reg = 0x9150,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9150,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_memnoc_gfx_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_sleep_clk = {
+	.halt_reg = 0x9134,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x9134,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpu_cc_sleep_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *gpu_cc_sa8775p_clocks[] = {
+	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
+	[GPU_CC_CB_CLK] = &gpu_cc_cb_clk.clkr,
+	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
+	[GPU_CC_CX_FF_CLK] = &gpu_cc_cx_ff_clk.clkr,
+	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
+	[GPU_CC_CX_SNOC_DVM_CLK] = &gpu_cc_cx_snoc_dvm_clk.clkr,
+	[GPU_CC_CXO_AON_CLK] = &gpu_cc_cxo_aon_clk.clkr,
+	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
+	[GPU_CC_DEMET_CLK] = &gpu_cc_demet_clk.clkr,
+	[GPU_CC_DEMET_DIV_CLK_SRC] = &gpu_cc_demet_div_clk_src.clkr,
+	[GPU_CC_FF_CLK_SRC] = &gpu_cc_ff_clk_src.clkr,
+	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
+	[GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK] = &gpu_cc_hlos1_vote_gpu_smmu_clk.clkr,
+	[GPU_CC_HUB_AHB_DIV_CLK_SRC] = &gpu_cc_hub_ahb_div_clk_src.clkr,
+	[GPU_CC_HUB_AON_CLK] = &gpu_cc_hub_aon_clk.clkr,
+	[GPU_CC_HUB_CLK_SRC] = &gpu_cc_hub_clk_src.clkr,
+	[GPU_CC_HUB_CX_INT_CLK] = &gpu_cc_hub_cx_int_clk.clkr,
+	[GPU_CC_HUB_CX_INT_DIV_CLK_SRC] = &gpu_cc_hub_cx_int_div_clk_src.clkr,
+	[GPU_CC_MEMNOC_GFX_CLK] = &gpu_cc_memnoc_gfx_clk.clkr,
+	[GPU_CC_PLL0] = &gpu_cc_pll0.clkr,
+	[GPU_CC_PLL1] = &gpu_cc_pll1.clkr,
+	[GPU_CC_SLEEP_CLK] = &gpu_cc_sleep_clk.clkr,
+	[GPU_CC_XO_CLK_SRC] = &gpu_cc_xo_clk_src.clkr,
+};
+
+static struct gdsc cx_gdsc = {
+	.gdscr = 0x9108,
+	.gds_hw_ctrl = 0x953c,
+	.pd = {
+		.name = "cx_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE | RETAIN_FF_ENABLE | ALWAYS_ON,
+};
+
+static struct gdsc gx_gdsc = {
+	.gdscr = 0x905c,
+	.pd = {
+		.name = "gx_gdsc",
+		.power_on = gdsc_gx_do_nothing_enable,
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = AON_RESET | RETAIN_FF_ENABLE,
+};
+
+static struct gdsc *gpu_cc_sa8775p_gdscs[] = {
+	[GPU_CC_CX_GDSC] = &cx_gdsc,
+	[GPU_CC_GX_GDSC] = &gx_gdsc,
+};
+
+static const struct qcom_reset_map gpu_cc_sa8775p_resets[] = {
+	[GPUCC_GPU_CC_ACD_BCR] = { 0x9358 },
+	[GPUCC_GPU_CC_CB_BCR] = { 0x93a0 },
+	[GPUCC_GPU_CC_CX_BCR] = { 0x9104 },
+	[GPUCC_GPU_CC_FAST_HUB_BCR] = { 0x93e4 },
+	[GPUCC_GPU_CC_FF_BCR] = { 0x9470 },
+	[GPUCC_GPU_CC_GFX3D_AON_BCR] = { 0x9198 },
+	[GPUCC_GPU_CC_GMU_BCR] = { 0x9314 },
+	[GPUCC_GPU_CC_GX_BCR] = { 0x9058 },
+	[GPUCC_GPU_CC_XO_BCR] = { 0x9000 },
+};
+
+static const struct regmap_config gpu_cc_sa8775p_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x9988,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc gpu_cc_sa8775p_desc = {
+	.config = &gpu_cc_sa8775p_regmap_config,
+	.clks = gpu_cc_sa8775p_clocks,
+	.num_clks = ARRAY_SIZE(gpu_cc_sa8775p_clocks),
+	.resets = gpu_cc_sa8775p_resets,
+	.num_resets = ARRAY_SIZE(gpu_cc_sa8775p_resets),
+	.gdscs = gpu_cc_sa8775p_gdscs,
+	.num_gdscs = ARRAY_SIZE(gpu_cc_sa8775p_gdscs),
+};
+
+static const struct of_device_id gpu_cc_sa8775p_match_table[] = {
+	{ .compatible = "qcom,sa8775p-gpucc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpu_cc_sa8775p_match_table);
+
+static int gpu_cc_sa8775p_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &gpu_cc_sa8775p_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_lucid_evo_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
+	clk_lucid_evo_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
+
+	/*
+	 * Keep the clocks always-ON
+	 * GPU_CC_CB_CLK
+	 */
+	regmap_update_bits(regmap, 0x93a4, BIT(0), BIT(0));
+
+	return qcom_cc_really_probe(pdev, &gpu_cc_sa8775p_desc, regmap);
+}
+
+static struct platform_driver gpu_cc_sa8775p_driver = {
+	.probe = gpu_cc_sa8775p_probe,
+	.driver = {
+		.name = "gpu_cc-sa8775p",
+		.of_match_table = gpu_cc_sa8775p_match_table,
+	},
+};
+
+static int __init gpu_cc_sa8775p_init(void)
+{
+	return platform_driver_register(&gpu_cc_sa8775p_driver);
+}
+subsys_initcall(gpu_cc_sa8775p_init);
+
+static void __exit gpu_cc_sa8775p_exit(void)
+{
+	platform_driver_unregister(&gpu_cc_sa8775p_driver);
+}
+module_exit(gpu_cc_sa8775p_exit);
+
+MODULE_DESCRIPTION("SA8775P GPUCC driver");
+MODULE_LICENSE("GPL");
-- 
2.37.2

