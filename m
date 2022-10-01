Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CC75F18D5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiJADF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiJADFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:05:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696905EDD7;
        Fri, 30 Sep 2022 20:04:58 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29130b9k004310;
        Sat, 1 Oct 2022 03:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=M28DN+CmkOoSWhMuqhbyVG5ixfvNZzbqpEWQRnZ6yDk=;
 b=iYjrr32q2OK00Tt3RHvbZ8jZtZ5Ueqz99cvwqMV0fIYxmPTvycQZ0MSmY1z8664tgppp
 RGI2i+wLLwMotDCkORn/lXC26KZcCtu53hsrNo1nDkHGP2RzMcOlIt82Ax7PCt+QxtJ3
 U18pvKryRM64yAhSBVc+31hrYrbj7F+CvtjF402ScxERgN28SsmiU6RpyauePWBUAOaz
 4+pEgb5Ue0rdjon7lXnxXWgbaV+LPcdOYAqMNHVCTLgJiz8HceEqY6WDsBGbJzCrv1K9
 I2CJTyZq+2E0scr68q9FWCPUVjcDmcF4qiljFKj91DX6HlwWJkKqFe0O2MUUHTtxKqPm dQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwj1bvdvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Oct 2022 03:04:34 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29134Xnx003169
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Oct 2022 03:04:33 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:04:33 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 3/5] clk: qcom: Add QDU1000 and QRU1000 GCC support
Date:   Fri, 30 Sep 2022 20:04:01 -0700
Message-ID: <20221001030403.27659-4-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030403.27659-1-quic_molvera@quicinc.com>
References: <20221001030403.27659-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RelZjwDjKik5PdzP2ifBZROrhACeOhrZ
X-Proofpoint-ORIG-GUID: RelZjwDjKik5PdzP2ifBZROrhACeOhrZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210010015
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <quic_tdas@quicinc.com>

Add Global Clock Controller (GCC) support for QDU1000 and QRU1000 SoCs.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/clk/qcom/Kconfig        |    8 +
 drivers/clk/qcom/Makefile       |    1 +
 drivers/clk/qcom/clk-branch.c   |    5 +
 drivers/clk/qcom/clk-branch.h   |    2 +
 drivers/clk/qcom/gcc-qdru1000.c | 2649 +++++++++++++++++++++++++++++++
 5 files changed, 2665 insertions(+)
 create mode 100644 drivers/clk/qcom/gcc-qdru1000.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 1cf1ef70e347..195c018c6f87 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -696,6 +696,14 @@ config SM_GCC_8450
 	  Say Y if you want to use peripheral devices such as UART,
 	  SPI, I2C, USB, SD/UFS, PCIe etc.
 
+config QDRU_GCC_1000
+	tristate "QDU1000/QRU1000 Global Clock Controller"
+	select QCOM_GDSC
+	help
+	  Support for the global clock controller on QDU1000 and
+	  QRU1000 devices. Say Y if you want to use peripheral
+	  devices such as UART, SPI, I2C, USB, SD, PCIe, etc.
+
 config SM_GPUCC_6350
 	tristate "SM6350 Graphics Clock Controller"
 	select SM_GCC_6350
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index fbcf04073f07..080253a338e7 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_SM_GCC_8150) += gcc-sm8150.o
 obj-$(CONFIG_SM_GCC_8250) += gcc-sm8250.o
 obj-$(CONFIG_SM_GCC_8350) += gcc-sm8350.o
 obj-$(CONFIG_SM_GCC_8450) += gcc-sm8450.o
+obj-$(CONFIG_QDRU_GCC_1000) += gcc-qdru1000.o
 obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
 obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
 obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index f869fc6aaed6..b5dc1f4ef277 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -56,6 +57,10 @@ static bool clk_branch2_check_halt(const struct clk_branch *br, bool enabling)
 
 	if (enabling) {
 		val &= mask;
+
+		if (br->halt_check == BRANCH_HALT_INVERT)
+			return (val & BRANCH_CLK_OFF) == BRANCH_CLK_OFF;
+
 		return (val & BRANCH_CLK_OFF) == 0 ||
 			val == BRANCH_NOC_FSM_STATUS_ON;
 	} else {
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 17a58119165e..4ac1debeb91e 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2013, The Linux Foundation. All rights reserved. */
+/* Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved. */
 
 #ifndef __QCOM_CLK_BRANCH_H__
 #define __QCOM_CLK_BRANCH_H__
@@ -33,6 +34,7 @@ struct clk_branch {
 #define BRANCH_HALT_ENABLE_VOTED	(BRANCH_HALT_ENABLE | BRANCH_VOTED)
 #define BRANCH_HALT_DELAY		2 /* No bit to check; just delay */
 #define BRANCH_HALT_SKIP		3 /* Don't check halt bit */
+#define BRANCH_HALT_INVERT		4 /* Invert logic for halt bit */
 
 	struct clk_regmap clkr;
 };
diff --git a/drivers/clk/qcom/gcc-qdru1000.c b/drivers/clk/qcom/gcc-qdru1000.c
new file mode 100644
index 000000000000..4bc54f7b43a0
--- /dev/null
+++ b/drivers/clk/qcom/gcc-qdru1000.c
@@ -0,0 +1,2649 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,gcc-qdru1000.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+#include "clk-regmap-phy-mux.h"
+#include "reset.h"
+
+enum {
+	P_BI_TCXO,
+	P_GCC_GPLL0_OUT_EVEN,
+	P_GCC_GPLL0_OUT_MAIN,
+	P_GCC_GPLL1_OUT_MAIN,
+	P_GCC_GPLL2_OUT_MAIN,
+	P_GCC_GPLL3_OUT_MAIN,
+	P_GCC_GPLL4_OUT_MAIN,
+	P_GCC_GPLL5_OUT_MAIN,
+	P_GCC_GPLL6_OUT_MAIN,
+	P_GCC_GPLL7_OUT_MAIN,
+	P_GCC_GPLL8_OUT_MAIN,
+	P_PCIE_0_PHY_AUX_CLK,
+	P_PCIE_0_PIPE_CLK,
+	P_SLEEP_CLK,
+	P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
+};
+
+static struct clk_alpha_pll gcc_gpll0 = {
+	.offset = 0x0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x62018,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gpll0",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_gcc_gpll0_out_even[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv gcc_gpll0_out_even = {
+	.offset = 0x0,
+	.post_div_shift = 10,
+	.post_div_table = post_div_table_gcc_gpll0_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_gcc_gpll0_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_gpll0_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&gcc_gpll0.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_lucid_evo_ops,
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll1 = {
+	.offset = 0x1000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x62018,
+		.enable_mask = BIT(1),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gpll1",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll_postdiv gcc_gpll1_out_even = {
+	.offset = 0x1000,
+	.post_div_shift = 10,
+	.post_div_table = post_div_table_gcc_gpll0_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_gcc_gpll0_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_gpll1_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&gcc_gpll1.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_lucid_evo_ops,
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll2 = {
+	.offset = 0x2000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x62018,
+		.enable_mask = BIT(2),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gpll2",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll_postdiv gcc_gpll2_out_even = {
+	.offset = 0x2000,
+	.post_div_shift = 10,
+	.post_div_table = post_div_table_gcc_gpll0_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_gcc_gpll0_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_gpll2_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&gcc_gpll2.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_lucid_evo_ops,
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll3 = {
+	.offset = 0x3000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x62018,
+		.enable_mask = BIT(3),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gpll3",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll4 = {
+	.offset = 0x4000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x62018,
+		.enable_mask = BIT(4),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gpll4",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll5 = {
+	.offset = 0x5000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x62018,
+		.enable_mask = BIT(5),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gpll5",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll_postdiv gcc_gpll5_out_even = {
+	.offset = 0x5000,
+	.post_div_shift = 10,
+	.post_div_table = post_div_table_gcc_gpll0_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_gcc_gpll0_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_gpll5_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&gcc_gpll5.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_lucid_evo_ops,
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll6 = {
+	.offset = 0x6000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x62018,
+		.enable_mask = BIT(6),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gpll6",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll7 = {
+	.offset = 0x7000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x62018,
+		.enable_mask = BIT(7),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gpll7",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll8 = {
+	.offset = 0x8000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x62018,
+		.enable_mask = BIT(8),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gpll8",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static const struct parent_map gcc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_0[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .hw = &gcc_gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_SLEEP_CLK, 5 },
+	{ P_GCC_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_1[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .fw_name = "sleep_clk" },
+	{ .hw = &gcc_gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_GPLL5_OUT_MAIN, 3 },
+	{ P_GCC_GPLL4_OUT_MAIN, 5 },
+};
+
+static const struct clk_parent_data gcc_parent_data_2[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .hw = &gcc_gpll5.clkr.hw },
+	{ .hw = &gcc_gpll4.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_SLEEP_CLK, 5 },
+};
+
+static const struct clk_parent_data gcc_parent_data_3[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .fw_name = "sleep_clk" },
+};
+
+static const struct parent_map gcc_parent_map_4[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_GPLL2_OUT_MAIN, 2 },
+	{ P_GCC_GPLL5_OUT_MAIN, 3 },
+	{ P_GCC_GPLL1_OUT_MAIN, 4 },
+	{ P_GCC_GPLL4_OUT_MAIN, 5 },
+	{ P_GCC_GPLL3_OUT_MAIN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_4[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .hw = &gcc_gpll2.clkr.hw },
+	{ .hw = &gcc_gpll5.clkr.hw },
+	{ .hw = &gcc_gpll1.clkr.hw },
+	{ .hw = &gcc_gpll4.clkr.hw },
+	{ .hw = &gcc_gpll3.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_5[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_GPLL2_OUT_MAIN, 2 },
+	{ P_GCC_GPLL6_OUT_MAIN, 3 },
+	{ P_GCC_GPLL1_OUT_MAIN, 4 },
+	{ P_GCC_GPLL4_OUT_MAIN, 5 },
+	{ P_GCC_GPLL3_OUT_MAIN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_5[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .hw = &gcc_gpll2.clkr.hw },
+	{ .hw = &gcc_gpll6.clkr.hw },
+	{ .hw = &gcc_gpll1.clkr.hw },
+	{ .hw = &gcc_gpll4.clkr.hw },
+	{ .hw = &gcc_gpll3.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_6[] = {
+	{ P_PCIE_0_PHY_AUX_CLK, 0 },
+	{ P_BI_TCXO, 2 },
+};
+
+static const struct clk_parent_data gcc_parent_data_6[] = {
+	{ .fw_name = "pcie_0_phy_aux_clk" },
+	{ .fw_name = "bi_tcxo" },
+};
+
+static const struct parent_map gcc_parent_map_7[] = {
+	{ P_PCIE_0_PIPE_CLK, 0 },
+	{ P_BI_TCXO, 2 },
+};
+
+static const struct clk_parent_data gcc_parent_data_7[] = {
+	{ .fw_name = "pcie_0_pipe_clk" },
+	{ .fw_name = "bi_tcxo" },
+};
+
+static const struct parent_map gcc_parent_map_8[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_GPLL8_OUT_MAIN, 2 },
+	{ P_GCC_GPLL5_OUT_MAIN, 3 },
+	{ P_GCC_GPLL4_OUT_MAIN, 5 },
+};
+
+static const struct clk_parent_data gcc_parent_data_8[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .hw = &gcc_gpll8.clkr.hw },
+	{ .hw = &gcc_gpll5.clkr.hw },
+	{ .hw = &gcc_gpll4.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_9[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_GPLL2_OUT_MAIN, 2 },
+	{ P_GCC_GPLL5_OUT_MAIN, 3 },
+	{ P_GCC_GPLL7_OUT_MAIN, 4 },
+	{ P_GCC_GPLL4_OUT_MAIN, 5 },
+};
+
+static const struct clk_parent_data gcc_parent_data_9[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .hw = &gcc_gpll2.clkr.hw },
+	{ .hw = &gcc_gpll5.clkr.hw },
+	{ .hw = &gcc_gpll7.clkr.hw },
+	{ .hw = &gcc_gpll4.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_10[] = {
+	{ P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK, 0 },
+	{ P_BI_TCXO, 2 },
+};
+
+static const struct clk_parent_data gcc_parent_data_10[] = {
+	{ .fw_name = "usb3_phy_wrapper_gcc_usb30_pipe_clk" },
+	{ .fw_name = "bi_tcxo" },
+};
+
+static struct clk_regmap_mux gcc_pcie_0_phy_aux_clk_src = {
+	.reg = 0x9d080,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_6,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_phy_aux_clk_src",
+			.parent_data = gcc_parent_data_6,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
+	.reg = 0x9d064,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_7,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_pipe_clk_src",
+			.parent_data = gcc_parent_data_7,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux gcc_usb3_prim_phy_pipe_clk_src = {
+	.reg = 0x4906c,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_10,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb3_prim_phy_pipe_clk_src",
+			.parent_data = gcc_parent_data_10,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_10),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_aggre_noc_ecpri_dma_clk_src[] = {
+	F(466500000, P_GCC_GPLL5_OUT_MAIN, 2, 0, 0),
+	F(500000000, P_GCC_GPLL2_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_aggre_noc_ecpri_dma_clk_src = {
+	.cmd_rcgr = 0x92020,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_4,
+	.freq_tbl = ftbl_gcc_aggre_noc_ecpri_dma_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_aggre_noc_ecpri_dma_clk_src",
+		.parent_data = gcc_parent_data_4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_aggre_noc_ecpri_gsi_clk_src[] = {
+	F(250000000, P_GCC_GPLL2_OUT_MAIN, 4, 0, 0),
+	F(300000000, P_GCC_GPLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_aggre_noc_ecpri_gsi_clk_src = {
+	.cmd_rcgr = 0x92038,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_5,
+	.freq_tbl = ftbl_gcc_aggre_noc_ecpri_gsi_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_aggre_noc_ecpri_gsi_clk_src",
+		.parent_data = gcc_parent_data_5,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
+	F(200000000, P_GCC_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_gp1_clk_src = {
+	.cmd_rcgr = 0x74004,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_1,
+	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_gp1_clk_src",
+		.parent_data = gcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_gp2_clk_src = {
+	.cmd_rcgr = 0x75004,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_1,
+	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_gp2_clk_src",
+		.parent_data = gcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_gp3_clk_src = {
+	.cmd_rcgr = 0x76004,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_1,
+	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_gp3_clk_src",
+		.parent_data = gcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_pcie_0_aux_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
+	.cmd_rcgr = 0x9d068,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_pcie_0_aux_clk_src",
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_pcie_0_phy_rchng_clk_src = {
+	.cmd_rcgr = 0x9d04c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_pcie_0_phy_rchng_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
+	F(60000000, P_GCC_GPLL0_OUT_MAIN, 10, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_pdm2_clk_src = {
+	.cmd_rcgr = 0x43010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pdm2_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_pdm2_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
+	F(7372800, P_GCC_GPLL0_OUT_EVEN, 1, 384, 15625),
+	F(14745600, P_GCC_GPLL0_OUT_EVEN, 1, 768, 15625),
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
+	F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
+	F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
+	F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
+	F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
+	F(96000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 25),
+	F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
+	{ }
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s0_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
+	.cmd_rcgr = 0x27154,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s0_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s1_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
+	.cmd_rcgr = 0x27288,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s1_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s2_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
+	.cmd_rcgr = 0x273bc,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s2_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s3_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
+	.cmd_rcgr = 0x274f0,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s3_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s4_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
+	.cmd_rcgr = 0x27624,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s4_clk_src_init,
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s5_clk_src[] = {
+	F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
+	{ }
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s5_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
+	.cmd_rcgr = 0x27758,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s5_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s5_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s6_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s6_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
+	.cmd_rcgr = 0x2788c,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s6_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s7_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s7_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
+	.cmd_rcgr = 0x279c0,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s7_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s0_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
+	.cmd_rcgr = 0x28154,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s0_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s1_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
+	.cmd_rcgr = 0x28288,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s1_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s2_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
+	.cmd_rcgr = 0x283bc,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s2_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s3_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
+	.cmd_rcgr = 0x284f0,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s3_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s4_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
+	.cmd_rcgr = 0x28624,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s4_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s5_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
+	.cmd_rcgr = 0x28758,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s5_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s6_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
+	.cmd_rcgr = 0x2888c,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s6_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s7_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
+	.cmd_rcgr = 0x289c0,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s7_clk_src_init,
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc5_apps_clk_src[] = {
+	F(144000, P_BI_TCXO, 16, 3, 25),
+	F(400000, P_BI_TCXO, 12, 1, 4),
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(20000000, P_GCC_GPLL0_OUT_MAIN, 10, 1, 3),
+	F(25000000, P_GCC_GPLL0_OUT_MAIN, 12, 1, 2),
+	F(50000000, P_GCC_GPLL0_OUT_MAIN, 12, 0, 0),
+	F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(192000000, P_GCC_GPLL8_OUT_MAIN, 4, 0, 0),
+	F(300000000, P_GCC_GPLL0_OUT_MAIN, 2, 0, 0),
+	F(384000000, P_GCC_GPLL8_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_sdcc5_apps_clk_src = {
+	.cmd_rcgr = 0x3b034,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_gcc_sdcc5_apps_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_sdcc5_apps_clk_src",
+		.parent_data = gcc_parent_data_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc5_ice_core_clk_src[] = {
+	F(300000000, P_GCC_GPLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_sdcc5_ice_core_clk_src = {
+	.cmd_rcgr = 0x3b01c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_2,
+	.freq_tbl = ftbl_gcc_sdcc5_ice_core_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_sdcc5_ice_core_clk_src",
+		.parent_data = gcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_sm_bus_xo_clk_src = {
+	.cmd_rcgr = 0x5b00c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_2,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_sm_bus_xo_clk_src",
+		.parent_data = gcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_tsc_clk_src[] = {
+	F(500000000, P_GCC_GPLL7_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_tsc_clk_src = {
+	.cmd_rcgr = 0x57010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_9,
+	.freq_tbl = ftbl_gcc_tsc_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_tsc_clk_src",
+		.parent_data = gcc_parent_data_9,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_9),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(200000000, P_GCC_GPLL0_OUT_MAIN, 3, 0, 0),
+	F(240000000, P_GCC_GPLL0_OUT_MAIN, 2.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
+	.cmd_rcgr = 0x49028,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_usb30_prim_master_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_usb30_prim_master_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
+	.cmd_rcgr = 0x49044,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_usb30_prim_mock_utmi_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
+	.cmd_rcgr = 0x49070,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_usb3_prim_phy_aux_clk_src",
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div gcc_usb30_prim_mock_utmi_postdiv_clk_src = {
+	.reg = 0x4905c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_usb30_prim_mock_utmi_postdiv_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&gcc_usb30_prim_mock_utmi_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_branch gcc_aggre_noc_ecpri_dma_clk = {
+	.halt_reg = 0x92008,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x92008,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x92008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_aggre_noc_ecpri_dma_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_aggre_noc_ecpri_dma_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_aggre_noc_ecpri_gsi_clk = {
+	.halt_reg = 0x9201c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x9201c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x9201c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_aggre_noc_ecpri_gsi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_aggre_noc_ecpri_gsi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_boot_rom_ahb_clk = {
+	.halt_reg = 0x48004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x48004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(10),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_boot_rom_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_cfg_noc_ecpri_cc_ahb_clk = {
+	.halt_reg = 0x3e004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x3e004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x3e004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_cfg_noc_ecpri_cc_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_cfg_noc_usb3_prim_axi_clk = {
+	.halt_reg = 0x8401c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x8401c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x8401c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_cfg_noc_usb3_prim_axi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_usb30_prim_master_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ddrss_ecpri_dma_clk = {
+	.halt_reg = 0x54030,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x54030,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x54030,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_ddrss_ecpri_dma_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_aggre_noc_ecpri_dma_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ecpri_ahb_clk = {
+	.halt_reg = 0x3a008,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x3a008,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x3a008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_ecpri_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ecpri_cc_gpll0_clk_src = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x62010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_ecpri_cc_gpll0_clk_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gpll0.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ecpri_cc_gpll1_even_clk_src = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x62010,
+		.enable_mask = BIT(1),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_ecpri_cc_gpll1_even_clk_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gpll1_out_even.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ecpri_cc_gpll2_even_clk_src = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x62010,
+		.enable_mask = BIT(2),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_ecpri_cc_gpll2_even_clk_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gpll2_out_even.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ecpri_cc_gpll3_clk_src = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x62010,
+		.enable_mask = BIT(3),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_ecpri_cc_gpll3_clk_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gpll3.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ecpri_cc_gpll4_clk_src = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x62010,
+		.enable_mask = BIT(4),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_ecpri_cc_gpll4_clk_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gpll4.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ecpri_cc_gpll5_even_clk_src = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x62010,
+		.enable_mask = BIT(5),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_ecpri_cc_gpll5_even_clk_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gpll5_out_even.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ecpri_xo_clk = {
+	.halt_reg = 0x3a004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3a004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_ecpri_xo_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_eth_100g_c2c_hm_apb_clk = {
+	.halt_reg = 0x39010,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x39010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_eth_100g_c2c_hm_apb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_eth_100g_fh_hm_apb_0_clk = {
+	.halt_reg = 0x39004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x39004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_eth_100g_fh_hm_apb_0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_eth_100g_fh_hm_apb_1_clk = {
+	.halt_reg = 0x39008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x39008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_eth_100g_fh_hm_apb_1_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_eth_100g_fh_hm_apb_2_clk = {
+	.halt_reg = 0x3900c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3900c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_eth_100g_fh_hm_apb_2_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_eth_dbg_c2c_hm_apb_clk = {
+	.halt_reg = 0x39014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x39014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_eth_dbg_c2c_hm_apb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_eth_dbg_snoc_axi_clk = {
+	.halt_reg = 0x3901c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x3901c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x3901c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_eth_dbg_snoc_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gemnoc_pcie_qx_clk = {
+	.halt_reg = 0x5402c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x5402c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gemnoc_pcie_qx_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp1_clk = {
+	.halt_reg = 0x74000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x74000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gp1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gp1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp2_clk = {
+	.halt_reg = 0x75000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x75000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gp2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gp2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp3_clk = {
+	.halt_reg = 0x76000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x76000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gp3_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gp3_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_aux_clk = {
+	.halt_reg = 0x9d030,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x9d030,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(29),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_aux_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_pcie_0_aux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
+	.halt_reg = 0x9d02c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x9d02c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(28),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_clkref_en = {
+	.halt_reg = 0x9c004,
+	.halt_check = BRANCH_HALT_INVERT,
+	.clkr = {
+		.enable_reg = 0x9c004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_clkref_en",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_mstr_axi_clk = {
+	.halt_reg = 0x9d024,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x9d024,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(27),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_mstr_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_phy_aux_clk = {
+	.halt_reg = 0x9d038,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x9d038,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(24),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_phy_aux_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_pcie_0_phy_aux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_phy_rchng_clk = {
+	.halt_reg = 0x9d048,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x9d048,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(23),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_phy_rchng_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_pcie_0_phy_rchng_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_pipe_clk = {
+	.halt_reg = 0x9d040,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x9d040,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(30),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_pcie_0_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_slv_axi_clk = {
+	.halt_reg = 0x9d01c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x9d01c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(26),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_slv_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_slv_q2a_axi_clk = {
+	.halt_reg = 0x9d018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x9d018,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(25),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_slv_q2a_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm2_clk = {
+	.halt_reg = 0x4300c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4300c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pdm2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_pdm2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm_ahb_clk = {
+	.halt_reg = 0x43004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x43004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x43004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pdm_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm_xo4_clk = {
+	.halt_reg = 0x43008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x43008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pdm_xo4_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_anoc_pcie_clk = {
+	.halt_reg = 0x84044,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x84044,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x84044,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qmip_anoc_pcie_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_ecpri_dma0_clk = {
+	.halt_reg = 0x84038,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x84038,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x84038,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qmip_ecpri_dma0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_ecpri_dma1_clk = {
+	.halt_reg = 0x8403c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x8403c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x8403c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qmip_ecpri_dma1_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_ecpri_gsi_clk = {
+	.halt_reg = 0x84040,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x84040,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x84040,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qmip_ecpri_gsi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_core_2x_clk = {
+	.halt_reg = 0x27018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(9),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_core_2x_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_core_clk = {
+	.halt_reg = 0x2700c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(8),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_core_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s0_clk = {
+	.halt_reg = 0x2714c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(10),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s1_clk = {
+	.halt_reg = 0x27280,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(11),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s2_clk = {
+	.halt_reg = 0x273b4,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(12),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s3_clk = {
+	.halt_reg = 0x274e8,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(13),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s3_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s3_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s4_clk = {
+	.halt_reg = 0x2761c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(14),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s5_clk = {
+	.halt_reg = 0x27750,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(15),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s5_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s5_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s6_clk = {
+	.halt_reg = 0x27884,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(16),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s6_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s6_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s7_clk = {
+	.halt_reg = 0x279b8,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(17),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s7_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s7_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_core_2x_clk = {
+	.halt_reg = 0x28018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(18),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap1_core_2x_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_core_clk = {
+	.halt_reg = 0x2800c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(19),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap1_core_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s0_clk = {
+	.halt_reg = 0x2814c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(22),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap1_s0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap1_s0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s1_clk = {
+	.halt_reg = 0x28280,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(23),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap1_s1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap1_s1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s2_clk = {
+	.halt_reg = 0x283b4,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(24),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap1_s2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap1_s2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s3_clk = {
+	.halt_reg = 0x284e8,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(25),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap1_s3_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap1_s3_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s4_clk = {
+	.halt_reg = 0x2861c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(26),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap1_s4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap1_s4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s5_clk = {
+	.halt_reg = 0x28750,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(27),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap1_s5_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap1_s5_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s6_clk = {
+	.halt_reg = 0x28884,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(28),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap1_s6_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap1_s6_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s7_clk = {
+	.halt_reg = 0x289b8,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(29),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap1_s7_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap1_s7_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_0_m_ahb_clk = {
+	.halt_reg = 0x27004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x27004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(6),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap_0_m_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_0_s_ahb_clk = {
+	.halt_reg = 0x27008,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x27008,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(7),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap_0_s_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_1_m_ahb_clk = {
+	.halt_reg = 0x28004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x28004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(20),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap_1_m_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_1_s_ahb_clk = {
+	.halt_reg = 0x28008,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x28008,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62008,
+		.enable_mask = BIT(21),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap_1_s_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc5_ahb_clk = {
+	.halt_reg = 0x3b00c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3b00c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_sdcc5_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc5_apps_clk = {
+	.halt_reg = 0x3b004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3b004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_sdcc5_apps_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_sdcc5_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc5_ice_core_clk = {
+	.halt_reg = 0x3b010,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3b010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_sdcc5_ice_core_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_sdcc5_ice_core_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sm_bus_ahb_clk = {
+	.halt_reg = 0x5b004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5b004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_sm_bus_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sm_bus_xo_clk = {
+	.halt_reg = 0x5b008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5b008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_sm_bus_xo_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_sm_bus_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_snoc_cnoc_gemnoc_pcie_qx_clk = {
+	.halt_reg = 0x9200c,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x9200c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(11),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_snoc_cnoc_gemnoc_pcie_qx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_snoc_cnoc_gemnoc_pcie_south_qx_clk = {
+	.halt_reg = 0x92010,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x92010,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(12),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_snoc_cnoc_gemnoc_pcie_south_qx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_snoc_cnoc_pcie_qx_clk = {
+	.halt_reg = 0x84030,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x84030,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_snoc_cnoc_pcie_qx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_snoc_pcie_sf_center_qx_clk = {
+	.halt_reg = 0x92014,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x92014,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(19),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_snoc_pcie_sf_center_qx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_snoc_pcie_sf_south_qx_clk = {
+	.halt_reg = 0x92018,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x92018,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x62000,
+		.enable_mask = BIT(22),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_snoc_pcie_sf_south_qx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_tsc_cfg_ahb_clk = {
+	.halt_reg = 0x5700c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5700c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_tsc_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_tsc_cntr_clk = {
+	.halt_reg = 0x57004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x57004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_tsc_cntr_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_tsc_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_tsc_etu_clk = {
+	.halt_reg = 0x57008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x57008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_tsc_etu_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_tsc_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb2_clkref_en = {
+	.halt_reg = 0x9c008,
+	.halt_check = BRANCH_HALT_INVERT,
+	.clkr = {
+		.enable_reg = 0x9c008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb2_clkref_en",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb30_prim_master_clk = {
+	.halt_reg = 0x49018,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x49018,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb30_prim_master_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_usb30_prim_master_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb30_prim_mock_utmi_clk = {
+	.halt_reg = 0x49024,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x49024,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb30_prim_mock_utmi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_usb30_prim_mock_utmi_postdiv_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb30_prim_sleep_clk = {
+	.halt_reg = 0x49020,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x49020,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb30_prim_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_prim_phy_aux_clk = {
+	.halt_reg = 0x49060,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x49060,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb3_prim_phy_aux_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_prim_phy_com_aux_clk = {
+	.halt_reg = 0x49064,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x49064,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb3_prim_phy_com_aux_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
+	.halt_reg = 0x49068,
+	.halt_check = BRANCH_HALT_DELAY,
+	.hwcg_reg = 0x49068,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x49068,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb3_prim_phy_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_usb3_prim_phy_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *gcc_qdru1000_clocks[] = {
+	[GCC_AGGRE_NOC_ECPRI_DMA_CLK] = &gcc_aggre_noc_ecpri_dma_clk.clkr,
+	[GCC_AGGRE_NOC_ECPRI_DMA_CLK_SRC] = &gcc_aggre_noc_ecpri_dma_clk_src.clkr,
+	[GCC_AGGRE_NOC_ECPRI_GSI_CLK_SRC] = &gcc_aggre_noc_ecpri_gsi_clk_src.clkr,
+	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
+	[GCC_CFG_NOC_ECPRI_CC_AHB_CLK] = &gcc_cfg_noc_ecpri_cc_ahb_clk.clkr,
+	[GCC_CFG_NOC_USB3_PRIM_AXI_CLK] = &gcc_cfg_noc_usb3_prim_axi_clk.clkr,
+	[GCC_DDRSS_ECPRI_DMA_CLK] = &gcc_ddrss_ecpri_dma_clk.clkr,
+	[GCC_ECPRI_AHB_CLK] = &gcc_ecpri_ahb_clk.clkr,
+	[GCC_ECPRI_CC_GPLL0_CLK_SRC] = &gcc_ecpri_cc_gpll0_clk_src.clkr,
+	[GCC_ECPRI_CC_GPLL1_EVEN_CLK_SRC] = &gcc_ecpri_cc_gpll1_even_clk_src.clkr,
+	[GCC_ECPRI_CC_GPLL2_EVEN_CLK_SRC] = &gcc_ecpri_cc_gpll2_even_clk_src.clkr,
+	[GCC_ECPRI_CC_GPLL3_CLK_SRC] = &gcc_ecpri_cc_gpll3_clk_src.clkr,
+	[GCC_ECPRI_CC_GPLL4_CLK_SRC] = &gcc_ecpri_cc_gpll4_clk_src.clkr,
+	[GCC_ECPRI_CC_GPLL5_EVEN_CLK_SRC] = &gcc_ecpri_cc_gpll5_even_clk_src.clkr,
+	[GCC_ECPRI_XO_CLK] = &gcc_ecpri_xo_clk.clkr,
+	[GCC_ETH_DBG_SNOC_AXI_CLK] = &gcc_eth_dbg_snoc_axi_clk.clkr,
+	[GCC_GEMNOC_PCIE_QX_CLK] = &gcc_gemnoc_pcie_qx_clk.clkr,
+	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
+	[GCC_GP1_CLK_SRC] = &gcc_gp1_clk_src.clkr,
+	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
+	[GCC_GP2_CLK_SRC] = &gcc_gp2_clk_src.clkr,
+	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
+	[GCC_GP3_CLK_SRC] = &gcc_gp3_clk_src.clkr,
+	[GCC_GPLL0] = &gcc_gpll0.clkr,
+	[GCC_GPLL0_OUT_EVEN] = &gcc_gpll0_out_even.clkr,
+	[GCC_GPLL1] = &gcc_gpll1.clkr,
+	[GCC_GPLL2] = &gcc_gpll2.clkr,
+	[GCC_GPLL2_OUT_EVEN] = &gcc_gpll2_out_even.clkr,
+	[GCC_GPLL3] = &gcc_gpll3.clkr,
+	[GCC_GPLL4] = &gcc_gpll4.clkr,
+	[GCC_GPLL5] = &gcc_gpll5.clkr,
+	[GCC_GPLL5_OUT_EVEN] = &gcc_gpll5_out_even.clkr,
+	[GCC_GPLL6] = &gcc_gpll6.clkr,
+	[GCC_GPLL7] = &gcc_gpll7.clkr,
+	[GCC_GPLL8] = &gcc_gpll8.clkr,
+	[GCC_PCIE_0_AUX_CLK] = &gcc_pcie_0_aux_clk.clkr,
+	[GCC_PCIE_0_AUX_CLK_SRC] = &gcc_pcie_0_aux_clk_src.clkr,
+	[GCC_PCIE_0_CFG_AHB_CLK] = &gcc_pcie_0_cfg_ahb_clk.clkr,
+	[GCC_PCIE_0_CLKREF_EN] = &gcc_pcie_0_clkref_en.clkr,
+	[GCC_PCIE_0_MSTR_AXI_CLK] = &gcc_pcie_0_mstr_axi_clk.clkr,
+	[GCC_PCIE_0_PHY_AUX_CLK] = &gcc_pcie_0_phy_aux_clk.clkr,
+	[GCC_PCIE_0_PHY_RCHNG_CLK] = &gcc_pcie_0_phy_rchng_clk.clkr,
+	[GCC_PCIE_0_PHY_RCHNG_CLK_SRC] = &gcc_pcie_0_phy_rchng_clk_src.clkr,
+	[GCC_PCIE_0_PIPE_CLK] = &gcc_pcie_0_pipe_clk.clkr,
+	[GCC_PCIE_0_SLV_AXI_CLK] = &gcc_pcie_0_slv_axi_clk.clkr,
+	[GCC_PCIE_0_SLV_Q2A_AXI_CLK] = &gcc_pcie_0_slv_q2a_axi_clk.clkr,
+	[GCC_PDM2_CLK] = &gcc_pdm2_clk.clkr,
+	[GCC_PDM2_CLK_SRC] = &gcc_pdm2_clk_src.clkr,
+	[GCC_PDM_AHB_CLK] = &gcc_pdm_ahb_clk.clkr,
+	[GCC_PDM_XO4_CLK] = &gcc_pdm_xo4_clk.clkr,
+	[GCC_QMIP_ANOC_PCIE_CLK] = &gcc_qmip_anoc_pcie_clk.clkr,
+	[GCC_QMIP_ECPRI_DMA0_CLK] = &gcc_qmip_ecpri_dma0_clk.clkr,
+	[GCC_QMIP_ECPRI_DMA1_CLK] = &gcc_qmip_ecpri_dma1_clk.clkr,
+	[GCC_QMIP_ECPRI_GSI_CLK] = &gcc_qmip_ecpri_gsi_clk.clkr,
+	[GCC_QUPV3_WRAP0_CORE_2X_CLK] = &gcc_qupv3_wrap0_core_2x_clk.clkr,
+	[GCC_QUPV3_WRAP0_CORE_CLK] = &gcc_qupv3_wrap0_core_clk.clkr,
+	[GCC_QUPV3_WRAP0_S0_CLK] = &gcc_qupv3_wrap0_s0_clk.clkr,
+	[GCC_QUPV3_WRAP0_S0_CLK_SRC] = &gcc_qupv3_wrap0_s0_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S1_CLK] = &gcc_qupv3_wrap0_s1_clk.clkr,
+	[GCC_QUPV3_WRAP0_S1_CLK_SRC] = &gcc_qupv3_wrap0_s1_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S2_CLK] = &gcc_qupv3_wrap0_s2_clk.clkr,
+	[GCC_QUPV3_WRAP0_S2_CLK_SRC] = &gcc_qupv3_wrap0_s2_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S3_CLK] = &gcc_qupv3_wrap0_s3_clk.clkr,
+	[GCC_QUPV3_WRAP0_S3_CLK_SRC] = &gcc_qupv3_wrap0_s3_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S4_CLK] = &gcc_qupv3_wrap0_s4_clk.clkr,
+	[GCC_QUPV3_WRAP0_S4_CLK_SRC] = &gcc_qupv3_wrap0_s4_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S5_CLK] = &gcc_qupv3_wrap0_s5_clk.clkr,
+	[GCC_QUPV3_WRAP0_S5_CLK_SRC] = &gcc_qupv3_wrap0_s5_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S6_CLK] = &gcc_qupv3_wrap0_s6_clk.clkr,
+	[GCC_QUPV3_WRAP0_S6_CLK_SRC] = &gcc_qupv3_wrap0_s6_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S7_CLK] = &gcc_qupv3_wrap0_s7_clk.clkr,
+	[GCC_QUPV3_WRAP0_S7_CLK_SRC] = &gcc_qupv3_wrap0_s7_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_CORE_2X_CLK] = &gcc_qupv3_wrap1_core_2x_clk.clkr,
+	[GCC_QUPV3_WRAP1_CORE_CLK] = &gcc_qupv3_wrap1_core_clk.clkr,
+	[GCC_QUPV3_WRAP1_S0_CLK] = &gcc_qupv3_wrap1_s0_clk.clkr,
+	[GCC_QUPV3_WRAP1_S0_CLK_SRC] = &gcc_qupv3_wrap1_s0_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S1_CLK] = &gcc_qupv3_wrap1_s1_clk.clkr,
+	[GCC_QUPV3_WRAP1_S1_CLK_SRC] = &gcc_qupv3_wrap1_s1_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S2_CLK] = &gcc_qupv3_wrap1_s2_clk.clkr,
+	[GCC_QUPV3_WRAP1_S2_CLK_SRC] = &gcc_qupv3_wrap1_s2_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S3_CLK] = &gcc_qupv3_wrap1_s3_clk.clkr,
+	[GCC_QUPV3_WRAP1_S3_CLK_SRC] = &gcc_qupv3_wrap1_s3_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S4_CLK] = &gcc_qupv3_wrap1_s4_clk.clkr,
+	[GCC_QUPV3_WRAP1_S4_CLK_SRC] = &gcc_qupv3_wrap1_s4_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S5_CLK] = &gcc_qupv3_wrap1_s5_clk.clkr,
+	[GCC_QUPV3_WRAP1_S5_CLK_SRC] = &gcc_qupv3_wrap1_s5_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S6_CLK] = &gcc_qupv3_wrap1_s6_clk.clkr,
+	[GCC_QUPV3_WRAP1_S6_CLK_SRC] = &gcc_qupv3_wrap1_s6_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S7_CLK] = &gcc_qupv3_wrap1_s7_clk.clkr,
+	[GCC_QUPV3_WRAP1_S7_CLK_SRC] = &gcc_qupv3_wrap1_s7_clk_src.clkr,
+	[GCC_QUPV3_WRAP_0_M_AHB_CLK] = &gcc_qupv3_wrap_0_m_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_0_S_AHB_CLK] = &gcc_qupv3_wrap_0_s_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_1_M_AHB_CLK] = &gcc_qupv3_wrap_1_m_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_1_S_AHB_CLK] = &gcc_qupv3_wrap_1_s_ahb_clk.clkr,
+	[GCC_SDCC5_AHB_CLK] = &gcc_sdcc5_ahb_clk.clkr,
+	[GCC_SDCC5_APPS_CLK] = &gcc_sdcc5_apps_clk.clkr,
+	[GCC_SDCC5_APPS_CLK_SRC] = &gcc_sdcc5_apps_clk_src.clkr,
+	[GCC_SDCC5_ICE_CORE_CLK] = &gcc_sdcc5_ice_core_clk.clkr,
+	[GCC_SDCC5_ICE_CORE_CLK_SRC] = &gcc_sdcc5_ice_core_clk_src.clkr,
+	[GCC_SM_BUS_AHB_CLK] = &gcc_sm_bus_ahb_clk.clkr,
+	[GCC_SM_BUS_XO_CLK] = &gcc_sm_bus_xo_clk.clkr,
+	[GCC_SM_BUS_XO_CLK_SRC] = &gcc_sm_bus_xo_clk_src.clkr,
+	[GCC_SNOC_CNOC_GEMNOC_PCIE_QX_CLK] = &gcc_snoc_cnoc_gemnoc_pcie_qx_clk.clkr,
+	[GCC_SNOC_CNOC_GEMNOC_PCIE_SOUTH_QX_CLK] = &gcc_snoc_cnoc_gemnoc_pcie_south_qx_clk.clkr,
+	[GCC_SNOC_CNOC_PCIE_QX_CLK] = &gcc_snoc_cnoc_pcie_qx_clk.clkr,
+	[GCC_SNOC_PCIE_SF_CENTER_QX_CLK] = &gcc_snoc_pcie_sf_center_qx_clk.clkr,
+	[GCC_SNOC_PCIE_SF_SOUTH_QX_CLK] = &gcc_snoc_pcie_sf_south_qx_clk.clkr,
+	[GCC_TSC_CFG_AHB_CLK] = &gcc_tsc_cfg_ahb_clk.clkr,
+	[GCC_TSC_CLK_SRC] = &gcc_tsc_clk_src.clkr,
+	[GCC_TSC_CNTR_CLK] = &gcc_tsc_cntr_clk.clkr,
+	[GCC_TSC_ETU_CLK] = &gcc_tsc_etu_clk.clkr,
+	[GCC_USB2_CLKREF_EN] = &gcc_usb2_clkref_en.clkr,
+	[GCC_USB30_PRIM_MASTER_CLK] = &gcc_usb30_prim_master_clk.clkr,
+	[GCC_USB30_PRIM_MASTER_CLK_SRC] = &gcc_usb30_prim_master_clk_src.clkr,
+	[GCC_USB30_PRIM_MOCK_UTMI_CLK] = &gcc_usb30_prim_mock_utmi_clk.clkr,
+	[GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC] = &gcc_usb30_prim_mock_utmi_clk_src.clkr,
+	[GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC] = &gcc_usb30_prim_mock_utmi_postdiv_clk_src.clkr,
+	[GCC_USB30_PRIM_SLEEP_CLK] = &gcc_usb30_prim_sleep_clk.clkr,
+	[GCC_USB3_PRIM_PHY_AUX_CLK] = &gcc_usb3_prim_phy_aux_clk.clkr,
+	[GCC_USB3_PRIM_PHY_AUX_CLK_SRC] = &gcc_usb3_prim_phy_aux_clk_src.clkr,
+	[GCC_USB3_PRIM_PHY_COM_AUX_CLK] = &gcc_usb3_prim_phy_com_aux_clk.clkr,
+	[GCC_USB3_PRIM_PHY_PIPE_CLK] = &gcc_usb3_prim_phy_pipe_clk.clkr,
+	[GCC_USB3_PRIM_PHY_PIPE_CLK_SRC] = &gcc_usb3_prim_phy_pipe_clk_src.clkr,
+	[GCC_ETH_100G_C2C_HM_APB_CLK] = &gcc_eth_100g_c2c_hm_apb_clk.clkr,
+	[GCC_ETH_100G_FH_HM_APB_0_CLK] = &gcc_eth_100g_fh_hm_apb_0_clk.clkr,
+	[GCC_ETH_100G_FH_HM_APB_1_CLK] = &gcc_eth_100g_fh_hm_apb_1_clk.clkr,
+	[GCC_ETH_100G_FH_HM_APB_2_CLK] = &gcc_eth_100g_fh_hm_apb_2_clk.clkr,
+	[GCC_ETH_DBG_C2C_HM_APB_CLK] = &gcc_eth_dbg_c2c_hm_apb_clk.clkr,
+	[GCC_AGGRE_NOC_ECPRI_GSI_CLK] = &gcc_aggre_noc_ecpri_gsi_clk.clkr,
+	[GCC_PCIE_0_PHY_AUX_CLK_SRC] = &gcc_pcie_0_phy_aux_clk_src.clkr,
+	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
+};
+
+static const struct qcom_reset_map gcc_qdru1000_resets[] = {
+	[GCC_ECPRI_CC_BCR] = { 0x3e000 },
+	[GCC_ECPRI_SS_BCR] = { 0x3a000 },
+	[GCC_ETH_WRAPPER_BCR] = { 0x39000 },
+	[GCC_PCIE_0_BCR] = { 0x9d000 },
+	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x9e014 },
+	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0x9e020 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x7c000 },
+	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0x9e000 },
+	[GCC_PCIE_PHY_CFG_AHB_BCR] = { 0x7f00c },
+	[GCC_PCIE_PHY_COM_BCR] = { 0x7f010 },
+	[GCC_PDM_BCR] = { 0x43000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x27000 },
+	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x28000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x22000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x22004 },
+	[GCC_SDCC5_BCR] = { 0x3b000 },
+	[GCC_TSC_BCR] = { 0x57000 },
+	[GCC_USB30_PRIM_BCR] = { 0x49000 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x60008 },
+	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x60014 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x60000 },
+	[GCC_USB3_PHY_SEC_BCR] = { 0x6000c },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x60004 },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x60010 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x7a000 },
+};
+
+static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s0_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s1_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s2_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s3_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s4_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s5_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s6_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s7_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s0_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s1_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s2_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s3_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s4_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s5_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s6_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s7_clk_src),
+};
+
+static const struct regmap_config gcc_qdru1000_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1f41f0,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc gcc_qdru1000_desc = {
+	.config = &gcc_qdru1000_regmap_config,
+	.clks = gcc_qdru1000_clocks,
+	.num_clks = ARRAY_SIZE(gcc_qdru1000_clocks),
+	.resets = gcc_qdru1000_resets,
+	.num_resets = ARRAY_SIZE(gcc_qdru1000_resets),
+};
+
+static const struct of_device_id gcc_qdru1000_match_table[] = {
+	{ .compatible = "qcom,gcc-qdu1000" },
+	{ .compatible = "qcom,gcc-qru1000"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gcc_qdru1000_match_table);
+
+static int gcc_qdru1000_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+	int ret;
+
+	regmap = qcom_cc_map(pdev, &gcc_qdru1000_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/* Update FORCE_MEM_CORE_ON for gcc_pcie_0_mstr_axi_clk */
+	regmap_update_bits(regmap, 0x9d024, BIT(14), BIT(14));
+
+	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
+				       ARRAY_SIZE(gcc_dfs_clocks));
+	if (ret)
+		return ret;
+
+	ret = qcom_cc_really_probe(pdev, &gcc_qdru1000_desc, regmap);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register GCC clocks\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "Registered GCC clocks\n");
+
+	return ret;
+}
+
+static struct platform_driver gcc_qdru1000_driver = {
+	.probe = gcc_qdru1000_probe,
+	.driver = {
+		.name = "gcc-qdru1000",
+		.of_match_table = gcc_qdru1000_match_table,
+	},
+};
+
+static int __init gcc_qdru1000_init(void)
+{
+	return platform_driver_register(&gcc_qdru1000_driver);
+}
+subsys_initcall(gcc_qdru1000_init);
+
+static void __exit gcc_qdru1000_exit(void)
+{
+	platform_driver_unregister(&gcc_qdru1000_driver);
+}
+module_exit(gcc_qdru1000_exit);
+
+MODULE_DESCRIPTION("QTI GCC QDRU1000 Driver");
+MODULE_LICENSE("GPL");
-- 
2.37.3

