Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93567711209
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbjEYRWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjEYRWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:22:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A516189;
        Thu, 25 May 2023 10:22:37 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PFBESF006073;
        Thu, 25 May 2023 17:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=n8n0k4r8TZYf/pNQ32WPO0ebIlzXxI4ryx6qmAg8DEM=;
 b=QAY3UW+mmmmLfwkcCZGxrp4SXbTjLPh1EKo/U/i7G3tbtZXKhaUo8JJhyqZZFT7S5jiQ
 tmWaekUJVV027h3LFXt6XWMJtrdD/K5uXK0l5wDcQ8afvJemxHkULXiozNmfVbv6DVaN
 S9JEn49ZettmtvnJKmH7aioaubd6tjqfgWwrTouqFDwWAxklXfIBKopRR2xHvHj5ylrd
 9liuSlJnR9uXjy2UQOtmsoXRU7Bgst7LGMfuxzjQEhc3hs4EDKIu+yirv6zMLFJCRNAJ
 KgPA79IgnoBp8m0z08jyZ/LhBTpvmI9oEVJk8hkYM+yDPB/ySuvHXw1peW79AQTcYKyD FQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt5ufrwvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 17:22:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PHMWqF020238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 17:22:32 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 25 May 2023 10:22:27 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V2 5/6] clk: qcom: camcc-sm8550: Add support for qdss, sleep and xo clocks
Date:   Thu, 25 May 2023 22:51:41 +0530
Message-ID: <20230525172142.9039-6-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525172142.9039-1-quic_jkona@quicinc.com>
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RZMYSljLvDuCw4G5enGs6W_5N_wqhdco
X-Proofpoint-GUID: RZMYSljLvDuCw4G5enGs6W_5N_wqhdco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_10,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxlogscore=833 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for camera qdss, sleep and xo clocks.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
Changes since V1:
 - Newly added.

 drivers/clk/qcom/camcc-sm8550.c | 180 ++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
index 85f0c1e09b2b..82374091b450 100644
--- a/drivers/clk/qcom/camcc-sm8550.c
+++ b/drivers/clk/qcom/camcc-sm8550.c
@@ -22,6 +22,8 @@
 enum {
 	DT_IFACE,
 	DT_BI_TCXO,
+	DT_BI_TCXO_AO,
+	DT_SLEEP_CLK,
 };
 
 enum {
@@ -43,6 +45,7 @@ enum {
 	P_CAM_CC_PLL10_OUT_EVEN,
 	P_CAM_CC_PLL11_OUT_EVEN,
 	P_CAM_CC_PLL12_OUT_EVEN,
+	P_SLEEP_CLK,
 };
 
 static const struct pll_vco lucid_ole_vco[] = {
@@ -893,6 +896,22 @@ static const struct clk_parent_data cam_cc_parent_data_11[] = {
 	{ .hw = &cam_cc_pll7_out_even.clkr.hw },
 };
 
+static const struct parent_map cam_cc_parent_map_12[] = {
+	{ P_SLEEP_CLK, 0 },
+};
+
+static const struct clk_parent_data cam_cc_parent_data_12[] = {
+	{ .index = DT_SLEEP_CLK },
+};
+
+static const struct parent_map cam_cc_parent_map_13[] = {
+	{ P_BI_TCXO, 0 },
+};
+
+static const struct clk_parent_data cam_cc_parent_data_13_ao[] = {
+	{ .index = DT_BI_TCXO_AO },
+};
+
 static const struct freq_tbl ftbl_cam_cc_bps_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(200000000, P_CAM_CC_PLL8_OUT_EVEN, 1, 0, 0),
@@ -1577,6 +1596,29 @@ static struct clk_rcg2 cam_cc_mclk7_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_cam_cc_qdss_debug_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(75000000, P_CAM_CC_PLL0_OUT_EVEN, 8, 0, 0),
+	F(150000000, P_CAM_CC_PLL0_OUT_EVEN, 4, 0, 0),
+	F(300000000, P_CAM_CC_PLL0_OUT_MAIN, 4, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_qdss_debug_clk_src = {
+	.cmd_rcgr = 0x13f24,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_qdss_debug_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "cam_cc_qdss_debug_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
 static const struct freq_tbl ftbl_cam_cc_sfe_0_clk_src[] = {
 	F(466000000, P_CAM_CC_PLL6_OUT_EVEN, 1, 0, 0),
 	F(594000000, P_CAM_CC_PLL6_OUT_EVEN, 1, 0, 0),
@@ -1623,6 +1665,26 @@ static struct clk_rcg2 cam_cc_sfe_1_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_cam_cc_sleep_clk_src[] = {
+	F(32000, P_SLEEP_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_sleep_clk_src = {
+	.cmd_rcgr = 0x141a0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_12,
+	.freq_tbl = ftbl_cam_cc_sleep_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "cam_cc_sleep_clk_src",
+		.parent_data = cam_cc_parent_data_12,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_12),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
 static const struct freq_tbl ftbl_cam_cc_slow_ahb_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(80000000, P_CAM_CC_PLL0_OUT_EVEN, 7.5, 0, 0),
@@ -1644,6 +1706,26 @@ static struct clk_rcg2 cam_cc_slow_ahb_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_cam_cc_xo_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_xo_clk_src = {
+	.cmd_rcgr = 0x14070,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_13,
+	.freq_tbl = ftbl_cam_cc_xo_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "cam_cc_xo_clk_src",
+		.parent_data = cam_cc_parent_data_13_ao,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_13_ao),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
 static struct clk_branch cam_cc_bps_ahb_clk = {
 	.halt_reg = 0x10274,
 	.halt_check = BRANCH_HALT,
@@ -1716,6 +1798,42 @@ static struct clk_branch cam_cc_camnoc_axi_clk = {
 	},
 };
 
+static struct clk_branch cam_cc_camnoc_dcd_xo_clk = {
+	.halt_reg = 0x13f18,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x13f18,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "cam_cc_camnoc_dcd_xo_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&cam_cc_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_camnoc_xo_clk = {
+	.halt_reg = 0x13f1c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x13f1c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "cam_cc_camnoc_xo_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&cam_cc_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch cam_cc_cci_0_clk = {
 	.halt_reg = 0x13a2c,
 	.halt_check = BRANCH_HALT,
@@ -2382,6 +2500,24 @@ static struct clk_branch cam_cc_drv_ahb_clk = {
 	},
 };
 
+static struct clk_branch cam_cc_drv_xo_clk = {
+	.halt_reg = 0x142d4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x142d4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "cam_cc_drv_xo_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&cam_cc_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch cam_cc_icp_ahb_clk = {
 	.halt_reg = 0x138fc,
 	.halt_check = BRANCH_HALT,
@@ -2922,6 +3058,42 @@ static struct clk_branch cam_cc_mclk7_clk = {
 	},
 };
 
+static struct clk_branch cam_cc_qdss_debug_clk = {
+	.halt_reg = 0x14050,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x14050,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "cam_cc_qdss_debug_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&cam_cc_qdss_debug_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_qdss_debug_xo_clk = {
+	.halt_reg = 0x14054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x14054,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "cam_cc_qdss_debug_xo_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&cam_cc_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch cam_cc_sbi_clk = {
 	.halt_reg = 0x10540,
 	.halt_check = BRANCH_HALT,
@@ -3145,6 +3317,8 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
 	[CAM_CC_BPS_FAST_AHB_CLK] = &cam_cc_bps_fast_ahb_clk.clkr,
 	[CAM_CC_CAMNOC_AXI_CLK] = &cam_cc_camnoc_axi_clk.clkr,
 	[CAM_CC_CAMNOC_AXI_CLK_SRC] = &cam_cc_camnoc_axi_clk_src.clkr,
+	[CAM_CC_CAMNOC_DCD_XO_CLK] = &cam_cc_camnoc_dcd_xo_clk.clkr,
+	[CAM_CC_CAMNOC_XO_CLK] = &cam_cc_camnoc_xo_clk.clkr,
 	[CAM_CC_CCI_0_CLK] = &cam_cc_cci_0_clk.clkr,
 	[CAM_CC_CCI_0_CLK_SRC] = &cam_cc_cci_0_clk_src.clkr,
 	[CAM_CC_CCI_1_CLK] = &cam_cc_cci_1_clk.clkr,
@@ -3196,6 +3370,7 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
 	[CAM_CC_CSIPHY6_CLK] = &cam_cc_csiphy6_clk.clkr,
 	[CAM_CC_CSIPHY7_CLK] = &cam_cc_csiphy7_clk.clkr,
 	[CAM_CC_DRV_AHB_CLK] = &cam_cc_drv_ahb_clk.clkr,
+	[CAM_CC_DRV_XO_CLK] = &cam_cc_drv_xo_clk.clkr,
 	[CAM_CC_FAST_AHB_CLK_SRC] = &cam_cc_fast_ahb_clk_src.clkr,
 	[CAM_CC_ICP_AHB_CLK] = &cam_cc_icp_ahb_clk.clkr,
 	[CAM_CC_ICP_CLK] = &cam_cc_icp_clk.clkr,
@@ -3272,6 +3447,9 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
 	[CAM_CC_PLL11_OUT_EVEN] = &cam_cc_pll11_out_even.clkr,
 	[CAM_CC_PLL12] = &cam_cc_pll12.clkr,
 	[CAM_CC_PLL12_OUT_EVEN] = &cam_cc_pll12_out_even.clkr,
+	[CAM_CC_QDSS_DEBUG_CLK] = &cam_cc_qdss_debug_clk.clkr,
+	[CAM_CC_QDSS_DEBUG_CLK_SRC] = &cam_cc_qdss_debug_clk_src.clkr,
+	[CAM_CC_QDSS_DEBUG_XO_CLK] = &cam_cc_qdss_debug_xo_clk.clkr,
 	[CAM_CC_SBI_CLK] = &cam_cc_sbi_clk.clkr,
 	[CAM_CC_SBI_FAST_AHB_CLK] = &cam_cc_sbi_fast_ahb_clk.clkr,
 	[CAM_CC_SFE_0_CLK] = &cam_cc_sfe_0_clk.clkr,
@@ -3280,7 +3458,9 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
 	[CAM_CC_SFE_1_CLK] = &cam_cc_sfe_1_clk.clkr,
 	[CAM_CC_SFE_1_CLK_SRC] = &cam_cc_sfe_1_clk_src.clkr,
 	[CAM_CC_SFE_1_FAST_AHB_CLK] = &cam_cc_sfe_1_fast_ahb_clk.clkr,
+	[CAM_CC_SLEEP_CLK_SRC] = &cam_cc_sleep_clk_src.clkr,
 	[CAM_CC_SLOW_AHB_CLK_SRC] = &cam_cc_slow_ahb_clk_src.clkr,
+	[CAM_CC_XO_CLK_SRC] = &cam_cc_xo_clk_src.clkr,
 };
 
 static struct gdsc *cam_cc_sm8550_gdscs[] = {
-- 
2.40.1

