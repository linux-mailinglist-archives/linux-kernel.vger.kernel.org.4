Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3756E2202
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjDNL0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjDNL0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:26:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BE69004
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:26:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q26so10737727lfe.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681471573; x=1684063573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vCSS4qlf+9EWgDlBCFQcmngTo8GFneZhl+SfxH8gRo=;
        b=P/uDdmiwihgi3KwKisgAvbLRT+iCVA21ldX6UkTqnwvBwocZz7Fz3YU3M/ThkRS7wz
         rGaSyjoEyzWbylzyh0+TnYEyQj/NEzvorfZRvD9pQmjnAgyAYIrqzQxHakzek7jEreIl
         dOHmghAZtS/iKhINyWpjQxN9UIab33In08TGr+4RPNhzHCYJwiyh2R453EgLXiqNWVyB
         NGysLy1kpvHnWK41XLtS8k/4K30GE0DOsDOaIbyXE7lhrTvqoJfqVfNdwHwALlCRJrCO
         aFeVlkssNYUeGeCAW/4nzAOYQaOAzZjrmEvqe3i/A6BRsmIKAixcq8qnbvDWwmGaNG7Y
         W/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471573; x=1684063573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vCSS4qlf+9EWgDlBCFQcmngTo8GFneZhl+SfxH8gRo=;
        b=Beb37bqWPvA3v58vNwhL4oK0cRej4jklbF2l6ucqWtSrVkN8hJBbbr84xKxeKi2f0h
         HZeB4ro7bD+dKAE0T44KkH3JATBrcNtD/dDJk6Sn4M1KclbAEEQgXD1O266DTzUNgmX1
         hfrvS8EXPuERUd27P+EAQwSNotqzpWDeDroC6V2Pa0EFR+pcKae/48yud94KWx1bHM0F
         02RsB6YcMctO2byNNl9DXwyepecA5DMSPW5RX5ccAKl1gpkerDWs5ob1JQrQhZrOY+jp
         M5ppC3536PCE5Y1wezZsnw/w+tYffDwx9fRy3X+LNAQa2M52e1TeMyBD28oS4vQ/WI8e
         FkSw==
X-Gm-Message-State: AAQBX9clBLnCijW/dSw81wmCusGu7dMzXO5nlZjIFCb2e6Im6UCFv6jf
        5K0mz/tLuJzX4w7CitxTHGHO/A==
X-Google-Smtp-Source: AKy350aYlpYC2UhTn2A3FIvL17pCTR1GOiHrE9G61dg7Dd6Toxbn0lsPESGnEeZ1XcY2PvwMVpcpxg==
X-Received: by 2002:ac2:568b:0:b0:4e8:56e7:60db with SMTP id 11-20020ac2568b000000b004e856e760dbmr1687271lfr.35.1681471573327;
        Fri, 14 Apr 2023 04:26:13 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id f2-20020a19ae02000000b004ecb06acbb3sm738430lfc.281.2023.04.14.04.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:26:13 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 14 Apr 2023 13:26:09 +0200
Subject: [PATCH v2 2/2] clk: qcom: Introduce SM8350 VIDEOCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-topic-lahaina_vidcc-v2-2-f721d507e555@linaro.org>
References: <20230413-topic-lahaina_vidcc-v2-0-f721d507e555@linaro.org>
In-Reply-To: <20230413-topic-lahaina_vidcc-v2-0-f721d507e555@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681471569; l=17098;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1g3IgnEsOz1gIZvsQE5VCpiKOHyCXp+3UHd7PNbxUns=;
 b=dqvENaixfPqPF/sp5hwLFVIrkYWwhALhPkArsa2LbCJlbZeqIYZxjTZ4r8dYJmNVMveMFRdTfgyg
 vsB/+3SuC4zJKK4jPrBf+LEbDwAWxv5Wawub1OerV8y4mQL+yPpd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Video Clock Controller found on the SM8350 SoC.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/Kconfig          |   9 +
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/videocc-sm8350.c | 557 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 567 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index d71c9d6036bb..dbb1dfcddb31 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -916,6 +916,15 @@ config SM_VIDEOCC_8250
 	  Say Y if you want to support video devices and functionality such as
 	  video encode and decode.
 
+config SM_VIDEOCC_8350
+	tristate "SM8350 Video Clock Controller"
+	select SM_GCC_8350
+	select QCOM_GDSC
+	help
+	  Support for the video clock controller on SM8350 devices.
+	  Say Y if you want to support video devices and functionality such as
+	  video encode and decode.
+
 config SPMI_PMIC_CLKDIV
 	tristate "SPMI PMIC clkdiv Support"
 	depends on SPMI || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index b54085e579a0..53290040523b 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
 obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
 obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
 obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
+obj-$(CONFIG_SM_VIDEOCC_8350) += videocc-sm8350.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
 obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
 obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc-sm8350.c
new file mode 100644
index 000000000000..e0cf474a632d
--- /dev/null
+++ b/drivers/clk/qcom/videocc-sm8350.c
@@ -0,0 +1,557 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm8350-videocc.h>
+#include <dt-bindings/reset/qcom,sm8350-videocc.h>
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
+enum {
+	DT_BI_TCXO,
+	DT_BI_TCXO_AO,
+	DT_SLEEP_CLK,
+};
+
+enum {
+	P_BI_TCXO,
+	P_BI_TCXO_AO,
+	P_SLEEP_CLK,
+	P_VIDEO_PLL0_OUT_MAIN,
+	P_VIDEO_PLL1_OUT_MAIN,
+};
+
+static const struct pll_vco lucid_5lpe_vco[] = {
+	{ 249600000, 1750000000, 0 },
+};
+
+static const struct alpha_pll_config video_pll0_config = {
+	.l = 0x25,
+	.alpha = 0x8000,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002261,
+	.config_ctl_hi1_val = 0x2a9a699c,
+	.test_ctl_val = 0x00000000,
+	.test_ctl_hi_val = 0x00000000,
+	.test_ctl_hi1_val = 0x01800000,
+	.user_ctl_val = 0x00000000,
+	.user_ctl_hi_val = 0x00000805,
+	.user_ctl_hi1_val = 0x00000000,
+};
+
+static struct clk_alpha_pll video_pll0 = {
+	.offset = 0x42c,
+	.vco_table = lucid_5lpe_vco,
+	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_pll0",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_5lpe_ops,
+		},
+	},
+};
+
+static const struct alpha_pll_config video_pll1_config = {
+	.l = 0x2b,
+	.alpha = 0xc000,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002261,
+	.config_ctl_hi1_val = 0x2a9a699c,
+	.test_ctl_val = 0x00000000,
+	.test_ctl_hi_val = 0x00000000,
+	.test_ctl_hi1_val = 0x01800000,
+	.user_ctl_val = 0x00000000,
+	.user_ctl_hi_val = 0x00000805,
+	.user_ctl_hi1_val = 0x00000000,
+};
+
+static struct clk_alpha_pll video_pll1 = {
+	.offset = 0x7d0,
+	.vco_table = lucid_5lpe_vco,
+	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_pll1",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_5lpe_ops,
+		},
+	},
+};
+
+static const struct parent_map video_cc_parent_map_0[] = {
+	{ P_BI_TCXO_AO, 0 },
+};
+
+static const struct clk_parent_data video_cc_parent_data_0[] = {
+	{ .index = DT_BI_TCXO_AO },
+};
+
+static const struct parent_map video_cc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_VIDEO_PLL0_OUT_MAIN, 1 },
+};
+
+static const struct clk_parent_data video_cc_parent_data_1[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &video_pll0.clkr.hw },
+};
+
+static const struct parent_map video_cc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_VIDEO_PLL1_OUT_MAIN, 1 },
+};
+
+static const struct clk_parent_data video_cc_parent_data_2[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &video_pll1.clkr.hw },
+};
+
+static const struct freq_tbl ftbl_video_cc_ahb_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 video_cc_ahb_clk_src = {
+	.cmd_rcgr = 0xbd4,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = video_cc_parent_map_0,
+	.freq_tbl = ftbl_video_cc_ahb_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_ahb_clk_src",
+		.parent_data = video_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(video_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_video_cc_mvs0_clk_src[] = {
+	F(720000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1014000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1098000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1332000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 video_cc_mvs0_clk_src = {
+	.cmd_rcgr = 0xb94,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = video_cc_parent_map_1,
+	.freq_tbl = ftbl_video_cc_mvs0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_mvs0_clk_src",
+		.parent_data = video_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(video_cc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_video_cc_mvs1_clk_src[] = {
+	F(840000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1098000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1332000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 video_cc_mvs1_clk_src = {
+	.cmd_rcgr = 0xbb4,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = video_cc_parent_map_2,
+	.freq_tbl = ftbl_video_cc_mvs1_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_mvs1_clk_src",
+		.parent_data = video_cc_parent_data_2,
+		.num_parents = ARRAY_SIZE(video_cc_parent_data_2),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_video_cc_sleep_clk_src[] = {
+	F(32000, P_SLEEP_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 video_cc_sleep_clk_src = {
+	.cmd_rcgr = 0xef0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.freq_tbl = ftbl_video_cc_sleep_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_sleep_clk_src",
+		.parent_data = &(const struct clk_parent_data){
+			.index = DT_SLEEP_CLK,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 video_cc_xo_clk_src = {
+	.cmd_rcgr = 0xecc,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = video_cc_parent_map_0,
+	.freq_tbl = ftbl_video_cc_ahb_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_xo_clk_src",
+		.parent_data = video_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(video_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div video_cc_mvs0_div_clk_src = {
+	.reg = 0xd54,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_mvs0_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&video_cc_mvs0_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div video_cc_mvs0c_div2_div_clk_src = {
+	.reg = 0xc54,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_mvs0c_div2_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&video_cc_mvs0_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div video_cc_mvs1_div_clk_src = {
+	.reg = 0xdd4,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_mvs1_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&video_cc_mvs1_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div video_cc_mvs1c_div2_div_clk_src = {
+	.reg = 0xcf4,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_mvs1c_div2_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&video_cc_mvs1_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_branch video_cc_mvs0_clk = {
+	.halt_reg = 0xd34,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0xd34,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0xd34,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&video_cc_mvs0_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvs0c_clk = {
+	.halt_reg = 0xc34,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc34,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs0c_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&video_cc_mvs0c_div2_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvs1_clk = {
+	.halt_reg = 0xdb4,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0xdb4,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0xdb4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&video_cc_mvs1_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvs1_div2_clk = {
+	.halt_reg = 0xdf4,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0xdf4,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0xdf4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs1_div2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&video_cc_mvs1c_div2_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvs1c_clk = {
+	.halt_reg = 0xcd4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xcd4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs1c_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&video_cc_mvs1c_div2_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_sleep_clk = {
+	.halt_reg = 0xf10,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xf10,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_sleep_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&video_cc_sleep_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc mvs0c_gdsc = {
+	.gdscr = 0xbf8,
+	.pd = {
+		.name = "mvs0c_gdsc",
+	},
+	.flags = RETAIN_FF_ENABLE,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc mvs1c_gdsc = {
+	.gdscr = 0xc98,
+	.pd = {
+		.name = "mvs1c_gdsc",
+	},
+	.flags = RETAIN_FF_ENABLE,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc mvs0_gdsc = {
+	.gdscr = 0xd18,
+	.pd = {
+		.name = "mvs0_gdsc",
+	},
+	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc mvs1_gdsc = {
+	.gdscr = 0xd98,
+	.pd = {
+		.name = "mvs1_gdsc",
+	},
+	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct clk_regmap *video_cc_sm8350_clocks[] = {
+	[VIDEO_CC_AHB_CLK_SRC] = &video_cc_ahb_clk_src.clkr,
+	[VIDEO_CC_MVS0_CLK] = &video_cc_mvs0_clk.clkr,
+	[VIDEO_CC_MVS0_CLK_SRC] = &video_cc_mvs0_clk_src.clkr,
+	[VIDEO_CC_MVS0_DIV_CLK_SRC] = &video_cc_mvs0_div_clk_src.clkr,
+	[VIDEO_CC_MVS0C_CLK] = &video_cc_mvs0c_clk.clkr,
+	[VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC] = &video_cc_mvs0c_div2_div_clk_src.clkr,
+	[VIDEO_CC_MVS1_CLK] = &video_cc_mvs1_clk.clkr,
+	[VIDEO_CC_MVS1_CLK_SRC] = &video_cc_mvs1_clk_src.clkr,
+	[VIDEO_CC_MVS1_DIV2_CLK] = &video_cc_mvs1_div2_clk.clkr,
+	[VIDEO_CC_MVS1_DIV_CLK_SRC] = &video_cc_mvs1_div_clk_src.clkr,
+	[VIDEO_CC_MVS1C_CLK] = &video_cc_mvs1c_clk.clkr,
+	[VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC] = &video_cc_mvs1c_div2_div_clk_src.clkr,
+	[VIDEO_CC_SLEEP_CLK] = &video_cc_sleep_clk.clkr,
+	[VIDEO_CC_SLEEP_CLK_SRC] = &video_cc_sleep_clk_src.clkr,
+	[VIDEO_CC_XO_CLK_SRC] = &video_cc_xo_clk_src.clkr,
+	[VIDEO_PLL0] = &video_pll0.clkr,
+	[VIDEO_PLL1] = &video_pll1.clkr,
+};
+
+static const struct qcom_reset_map video_cc_sm8350_resets[] = {
+	[CVP_VIDEO_CC_INTERFACE_BCR] = { 0xe54 },
+	[CVP_VIDEO_CC_MVS0_BCR] = { 0xd14 },
+	[VIDEO_CC_MVS0C_CLK_ARES] = { 0xc34, 2 },
+	[CVP_VIDEO_CC_MVS0C_BCR] = { 0xbf4 },
+	[CVP_VIDEO_CC_MVS1_BCR] = { 0xd94 },
+	[VIDEO_CC_MVS1C_CLK_ARES] = { 0xcd4, 2 },
+	[CVP_VIDEO_CC_MVS1C_BCR] = { 0xc94 },
+};
+
+static struct gdsc *video_cc_sm8350_gdscs[] = {
+	[MVS0C_GDSC] = &mvs0c_gdsc,
+	[MVS1C_GDSC] = &mvs1c_gdsc,
+	[MVS0_GDSC] = &mvs0_gdsc,
+	[MVS1_GDSC] = &mvs1_gdsc,
+};
+
+static const struct regmap_config video_cc_sm8350_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x10000,
+	.fast_io = true,
+};
+
+static struct qcom_cc_desc video_cc_sm8350_desc = {
+	.config = &video_cc_sm8350_regmap_config,
+	.clks = video_cc_sm8350_clocks,
+	.num_clks = ARRAY_SIZE(video_cc_sm8350_clocks),
+	.resets = video_cc_sm8350_resets,
+	.num_resets = ARRAY_SIZE(video_cc_sm8350_resets),
+	.gdscs = video_cc_sm8350_gdscs,
+	.num_gdscs = ARRAY_SIZE(video_cc_sm8350_gdscs),
+};
+
+static int video_cc_sm8350_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+	int ret;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
+	regmap = qcom_cc_map(pdev, &video_cc_sm8350_desc);
+	if (IS_ERR(regmap)) {
+		pm_runtime_put(&pdev->dev);
+		return PTR_ERR(regmap);
+	};
+
+	clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
+	clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
+
+	/*
+	 * Keep clocks always enabled:
+	 *      video_cc_ahb_clk
+	 *      video_cc_xo_clk
+	 */
+	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
+
+	ret = qcom_cc_really_probe(pdev, &video_cc_sm8350_desc, regmap);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
+}
+
+static const struct dev_pm_ops video_cc_sm8350_pm_ops = {
+	SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
+};
+
+static const struct of_device_id video_cc_sm8350_match_table[] = {
+	{ .compatible = "qcom,sm8350-videocc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, video_cc_sm8350_match_table);
+
+static struct platform_driver video_cc_sm8350_driver = {
+	.probe = video_cc_sm8350_probe,
+	.driver = {
+		.name = "sm8350-videocc",
+		.of_match_table = video_cc_sm8350_match_table,
+		.pm = &video_cc_sm8350_pm_ops,
+	},
+};
+module_platform_driver(video_cc_sm8350_driver);
+
+MODULE_DESCRIPTION("QTI SM8350 VIDEOCC Driver");
+MODULE_LICENSE("GPL");

-- 
2.40.0

