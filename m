Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F38D6AD663
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCGEnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCGEnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:43:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2574C58C02;
        Mon,  6 Mar 2023 20:42:50 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3273qU9q014943;
        Tue, 7 Mar 2023 04:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sF2DwJE7SmOL5xV0zNRWTVd9SU9HW3tE0C8S8uezg80=;
 b=cSbJ8eg3R0QflXkyBVkW0RC7cCt/Y+dC+eNlBsOY5DgBYFkehxbw7eA+8s1lZoMSv5+V
 fH7jG7eRCmj/E+SbKOzeMRLxQZt9vgaxbGinPSzRDjeQLSAaCap8u/umoahuBTFnZsG9
 UGiDNw9HDkaZhUPd7SnmOBeLjkmN97izdb6xJHdLPqpoInXzRP3xNCIjGLoxgw926Shd
 DWQejwSAYAvg+woIMnFhMQY4GrMAmavuY5Xyslx74Kv8HjfDjTizLvIgYHX66XWAAytW
 Lvi5Gx82CLr8XKZ8Kwrb8POZ3Rn1sGjAVwj9paDgX8691XP8+681Z7/DXagaxxnySuYv jQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p41876xpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 04:42:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3274gdGG015335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 04:42:39 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 20:42:32 -0800
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_mmanikan@quicinc.com>,
        <quic_gurus@quicinc.com>, <loic.poulain@linaro.org>,
        <quic_eberman@quicinc.com>, <robimarko@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 06/11] clk: qcom: IPQ9574: Add q6/wcss clocks
Date:   Tue, 7 Mar 2023 10:11:32 +0530
Message-ID: <1678164097-13247-7-git-send-email-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mZWUR098l_tCIeSe2qFSFw0ydKT1-148
X-Proofpoint-ORIG-GUID: mZWUR098l_tCIeSe2qFSFw0ydKT1-148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=981 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070041
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the clocks required for q6/wcss bring up
are missing. So this patch adds clocks.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq9574.c | 119 +++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 1bf33d582dc2..355f2e12d9c6 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -2697,6 +2697,22 @@ static struct clk_branch gcc_wcss_acmt_clk = {
 	},
 };
 
+static struct clk_branch gcc_wcss_ahb_s_clk = {
+	.halt_reg = 0x25060,
+	.clkr = {
+		.enable_reg = 0x25060,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_wcss_ahb_s_clk",
+			.parent_hws = (const struct clk_hw *[]){
+					&wcss_ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_sys_noc_wcss_ahb_clk = {
 	.halt_reg = 0x2e030,
 	.clkr = {
@@ -2734,6 +2750,22 @@ static struct clk_rcg2 wcss_axi_m_clk_src = {
 	},
 };
 
+static struct clk_branch gcc_wcss_axi_m_clk = {
+	.halt_reg = 0x25064,
+	.clkr = {
+		.enable_reg = 0x25064,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_wcss_axi_m_clk",
+			.parent_hws = (const struct clk_hw *[]){
+					&wcss_axi_m_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_anoc_wcss_axi_m_clk = {
 	.halt_reg = 0x2e0a8,
 	.clkr = {
@@ -2803,6 +2835,22 @@ static struct clk_branch gcc_wcss_dbg_ifc_atb_clk = {
 	},
 };
 
+static struct clk_branch gcc_wcss_dbg_ifc_atb_bdg_clk = {
+	.halt_reg = 0x2504C,
+	.clkr = {
+		.enable_reg = 0x2504C,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_wcss_dbg_ifc_atb_bdg_clk",
+			.parent_hws = (const struct clk_hw *[]){
+					&qdss_at_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_nssnoc_atb_clk = {
 	.halt_reg = 0x17014,
 	.clkr = {
@@ -3073,6 +3121,22 @@ static struct clk_branch gcc_wcss_dbg_ifc_nts_clk = {
 	},
 };
 
+static struct clk_branch gcc_wcss_dbg_ifc_nts_bdg_clk = {
+	.halt_reg = 0x25050,
+	.clkr = {
+		.enable_reg = 0x25050,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_wcss_dbg_ifc_nts_bdg_clk",
+			.parent_hws = (const struct clk_hw *[]){
+					&qdss_tsctr_div2_clk_src.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_qdss_tsctr_div2_clk = {
 	.halt_reg = 0x2d044,
 	.clkr = {
@@ -3315,6 +3379,38 @@ static struct clk_branch gcc_wcss_dbg_ifc_dapbus_clk = {
 	},
 };
 
+static struct clk_branch gcc_wcss_dbg_ifc_apb_bdg_clk = {
+	.halt_reg = 0x25048,
+	.clkr = {
+		.enable_reg = 0x25048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_wcss_dbg_ifc_apb_bdg_clk",
+			.parent_hws = (const struct clk_hw *[]){
+					&qdss_dap_sync_clk_src.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_wcss_dbg_ifc_dapbus_bdg_clk = {
+	.halt_reg = 0x25054,
+	.clkr = {
+		.enable_reg = 0x25054,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_wcss_dbg_ifc_dapbus_bdg_clk",
+			.parent_hws = (const struct clk_hw *[]){
+					&qdss_dap_sync_clk_src.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_qdss_dap_clk = {
 	.halt_reg = 0x2d058,
 	.clkr = {
@@ -3513,6 +3609,22 @@ static struct clk_rcg2 q6_axim2_clk_src = {
 	},
 };
 
+static struct clk_branch gcc_q6_axim2_clk = {
+	.halt_reg = 0x25010,
+	.clkr = {
+		.enable_reg = 0x25010,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_q6_axim2_clk",
+			.parent_hws = (const struct clk_hw *[]){
+					&q6_axim2_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static const struct freq_tbl ftbl_nssnoc_memnoc_bfdcd_clk_src[] = {
 	F(533333333, P_GPLL0, 1.5, 0, 0),
 	{ }
@@ -4037,14 +4149,17 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[WCSS_AHB_CLK_SRC] = &wcss_ahb_clk_src.clkr,
 	[GCC_Q6_AHB_CLK] = &gcc_q6_ahb_clk.clkr,
 	[GCC_Q6_AHB_S_CLK] = &gcc_q6_ahb_s_clk.clkr,
+	[GCC_WCSS_AHB_S_CLK] = &gcc_wcss_ahb_s_clk.clkr,
 	[GCC_WCSS_ECAHB_CLK] = &gcc_wcss_ecahb_clk.clkr,
 	[GCC_WCSS_ACMT_CLK] = &gcc_wcss_acmt_clk.clkr,
 	[GCC_SYS_NOC_WCSS_AHB_CLK] = &gcc_sys_noc_wcss_ahb_clk.clkr,
 	[WCSS_AXI_M_CLK_SRC] = &wcss_axi_m_clk_src.clkr,
+	[GCC_WCSS_AXI_M_CLK] = &gcc_wcss_axi_m_clk.clkr,
 	[GCC_ANOC_WCSS_AXI_M_CLK] = &gcc_anoc_wcss_axi_m_clk.clkr,
 	[QDSS_AT_CLK_SRC] = &qdss_at_clk_src.clkr,
 	[GCC_Q6SS_ATBM_CLK] = &gcc_q6ss_atbm_clk.clkr,
 	[GCC_WCSS_DBG_IFC_ATB_CLK] = &gcc_wcss_dbg_ifc_atb_clk.clkr,
+	[GCC_WCSS_DBG_IFC_ATB_BDG_CLK] = &gcc_wcss_dbg_ifc_atb_bdg_clk.clkr,
 	[GCC_NSSNOC_ATB_CLK] = &gcc_nssnoc_atb_clk.clkr,
 	[GCC_QDSS_AT_CLK] = &gcc_qdss_at_clk.clkr,
 	[GCC_SYS_NOC_AT_CLK] = &gcc_sys_noc_at_clk.clkr,
@@ -4059,6 +4174,7 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[QDSS_TSCTR_CLK_SRC] = &qdss_tsctr_clk_src.clkr,
 	[GCC_Q6_TSCTR_1TO2_CLK] = &gcc_q6_tsctr_1to2_clk.clkr,
 	[GCC_WCSS_DBG_IFC_NTS_CLK] = &gcc_wcss_dbg_ifc_nts_clk.clkr,
+	[GCC_WCSS_DBG_IFC_NTS_BDG_CLK] = &gcc_wcss_dbg_ifc_nts_bdg_clk.clkr,
 	[GCC_QDSS_TSCTR_DIV2_CLK] = &gcc_qdss_tsctr_div2_clk.clkr,
 	[GCC_QDSS_TS_CLK] = &gcc_qdss_ts_clk.clkr,
 	[GCC_QDSS_TSCTR_DIV4_CLK] = &gcc_qdss_tsctr_div4_clk.clkr,
@@ -4068,7 +4184,9 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_Q6SS_PCLKDBG_CLK] = &gcc_q6ss_pclkdbg_clk.clkr,
 	[GCC_Q6SS_TRIG_CLK] = &gcc_q6ss_trig_clk.clkr,
 	[GCC_WCSS_DBG_IFC_APB_CLK] = &gcc_wcss_dbg_ifc_apb_clk.clkr,
+	[GCC_WCSS_DBG_IFC_APB_BDG_CLK] = &gcc_wcss_dbg_ifc_apb_bdg_clk.clkr,
 	[GCC_WCSS_DBG_IFC_DAPBUS_CLK] = &gcc_wcss_dbg_ifc_dapbus_clk.clkr,
+	[GCC_WCSS_DBG_IFC_DAPBUS_BDG_CLK] = &gcc_wcss_dbg_ifc_dapbus_bdg_clk.clkr,
 	[GCC_QDSS_DAP_CLK] = &gcc_qdss_dap_clk.clkr,
 	[GCC_QDSS_APB2JTAG_CLK] = &gcc_qdss_apb2jtag_clk.clkr,
 	[GCC_QDSS_TSCTR_DIV3_CLK] = &gcc_qdss_tsctr_div3_clk.clkr,
@@ -4076,6 +4194,7 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_QPIC_IO_MACRO_CLK] = &gcc_qpic_io_macro_clk.clkr,
 	[Q6_AXI_CLK_SRC] = &q6_axi_clk_src.clkr,
 	[GCC_Q6_AXIM_CLK] = &gcc_q6_axim_clk.clkr,
+	[GCC_Q6_AXIM2_CLK] = &gcc_q6_axim2_clk.clkr,
 	[GCC_WCSS_Q6_TBU_CLK] = &gcc_wcss_q6_tbu_clk.clkr,
 	[GCC_MEM_NOC_Q6_AXI_CLK] = &gcc_mem_noc_q6_axi_clk.clkr,
 	[Q6_AXIM2_CLK_SRC] = &q6_axim2_clk_src.clkr,
-- 
2.34.1

