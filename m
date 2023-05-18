Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C6F7083B5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjEROMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjEROMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:12:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E20172E;
        Thu, 18 May 2023 07:12:28 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ID7MYt032526;
        Thu, 18 May 2023 14:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YfYGBi0MJcLV62GDnIjLUlWW9j0ejj/QmQbnoEl3aEQ=;
 b=W9K0UcoXrsFQvXPrLQ0KaIqaFtMVv180JIuiN3rPctrQziCRx4oIx1GdG7/Pvvf93rDY
 f3VYojL+OoAVJHbjvToj9OeIklLygtkT8+0OD0hOp3KlBY4aVKJsc5RPzBnJfXsofEuY
 466RKeBUbOWChnKF1YIQ3q6vfLXYV4PfIyXSd/Hy93oYkTqYi+O40zh3Xe3Dzq/5X4w1
 UuqIjA9t8Ywsgm8cyrsXRR6uuwJkTzCmHyNccil19N+06WhHQeCtoHZWIzhTGNXO3Vf5
 9V+j88rUGWTfhXIewvrALgueucyADPeO6dIY1fKQ8i9VLfIs1fQLLI3UQ+eFf63glm7s Og== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnbxqh8jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 14:12:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IECGZx019055
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 14:12:16 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 07:12:09 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V3 2/4] clk: qcom: gcc-ipq9574: Enable crypto clocks
Date:   Thu, 18 May 2023 19:41:03 +0530
Message-ID: <20230518141105.24741-3-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518141105.24741-1-quic_anusha@quicinc.com>
References: <20230518141105.24741-1-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WJxECJ6gQlfOTSXkm7VqE4eOIw_YMuRg
X-Proofpoint-GUID: WJxECJ6gQlfOTSXkm7VqE4eOIw_YMuRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180113
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the clocks required for crypto operation.

Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
---
 Changes in V3:
	- Added GCC prefix to CRYPTO_CLK_SRC.

 drivers/clk/qcom/gcc-ipq9574.c | 72 ++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 7b0505f5c255..73663168d72a 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -728,6 +728,41 @@ static struct clk_rcg2 blsp1_uart6_apps_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_gcc_crypto_clk_src[] = {
+	F(160000000, P_GPLL0, 5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_crypto_clk_src = {
+	.cmd_rcgr = 0x16004,
+	.freq_tbl = ftbl_gcc_crypto_clk_src,
+	.hid_width = 5,
+	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_crypto_clk_src",
+		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
+		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch gcc_crypto_clk = {
+	.halt_reg = 0x1600c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x0b004,
+		.enable_mask = BIT(14),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_crypto_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&gcc_crypto_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_apss_ahb_clk = {
 	.halt_reg = 0x24018,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -2071,6 +2106,38 @@ static struct clk_rcg2 pcnoc_bfdcd_clk_src = {
 	},
 };
 
+static struct clk_branch gcc_crypto_axi_clk = {
+	.halt_reg = 0x16010,
+	.clkr = {
+		.enable_reg = 0x16010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_crypto_axi_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pcnoc_bfdcd_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_crypto_ahb_clk = {
+	.halt_reg = 0x16014,
+	.clkr = {
+		.enable_reg = 0x16014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_crypto_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pcnoc_bfdcd_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_nsscfg_clk = {
 	.halt_reg = 0x1702c,
 	.clkr = {
@@ -4036,6 +4103,10 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_SNOC_PCIE1_1LANE_S_CLK] = &gcc_snoc_pcie1_1lane_s_clk.clkr,
 	[GCC_SNOC_PCIE2_2LANE_S_CLK] = &gcc_snoc_pcie2_2lane_s_clk.clkr,
 	[GCC_SNOC_PCIE3_2LANE_S_CLK] = &gcc_snoc_pcie3_2lane_s_clk.clkr,
+	[GCC_CRYPTO_CLK_SRC] = &gcc_crypto_clk_src.clkr,
+	[GCC_CRYPTO_CLK] = &gcc_crypto_clk.clkr,
+	[GCC_CRYPTO_AXI_CLK] = &gcc_crypto_axi_clk.clkr,
+	[GCC_CRYPTO_AHB_CLK] = &gcc_crypto_ahb_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq9574_resets[] = {
@@ -4193,6 +4264,7 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
 	[GCC_WCSS_ECAHB_ARES] = { 0x25070, 0 },
 	[GCC_WCSS_Q6_BCR] = { 0x18000, 0 },
 	[GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
+	[GCC_CRYPTO_BCR] = { 0x16000, 0 },
 };
 
 static const struct of_device_id gcc_ipq9574_match_table[] = {
-- 
2.17.1

