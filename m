Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75FC70033C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbjELJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbjELJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:02:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A71C10E63;
        Fri, 12 May 2023 02:02:15 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C5qZaA024785;
        Fri, 12 May 2023 09:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=KXi1JfWIq+YlLXJAZFiW+byAkf1TmCLK2wHhESE4NJU=;
 b=WR4v0zjKhXlE0mCvK36v2iPNsSB+svurwGhT88ypQcPN9fLjZam7ogYN/3RhK6S5xzd7
 JAAoSx1wRqtfXFPjHCXyfr+qCJM1/MDjiYr8dOEMxOEua0lkaJtjfjyrVvLui0Jw5rZe
 952O00A3itX21/U24ZhtjWUGNOz0ez8JIru5qtehyxxMRsNY9FpjxshroW3Wc2yQnypY
 afrwx67g5c70nmTMDDVEZPX31vdrGKxZVBYXO4BZY4PoJRgvzadoXkE2V4NgPFNsTGcc
 a03+ZZjYyBNyO31OY76nGcwbFeyeXxidzKcS/k5QrOIjKYEBHCGVB1wAF9vNyy/zpDPa 4w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh1k9j4kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 09:02:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34C927UY014204
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 09:02:07 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 May 2023 02:02:01 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH 1/2] clk: qcom: gcc-ipq9574: Enable crypto clocks
Date:   Fri, 12 May 2023 14:31:33 +0530
Message-ID: <20230512090134.9811-2-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230512090134.9811-1-quic_anusha@quicinc.com>
References: <20230512090134.9811-1-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FwYxOjp2xd9z-pgoqOLj0zSLqv1wt109
X-Proofpoint-GUID: FwYxOjp2xd9z-pgoqOLj0zSLqv1wt109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_05,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120075
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the clocks required for crypto operation.

Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq9574.c               | 72 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h |  4 ++
 include/dt-bindings/reset/qcom,ipq9574-gcc.h |  2 +-
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 7b0505f5c255..b203e7aae145 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -728,6 +728,41 @@ static struct clk_rcg2 blsp1_uart6_apps_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_crypto_clk_src[] = {
+	F(160000000, P_GPLL0, 5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 crypto_clk_src = {
+	.cmd_rcgr = 0x16004,
+	.freq_tbl = ftbl_crypto_clk_src,
+	.hid_width = 5,
+	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "crypto_clk_src",
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
+				&crypto_clk_src.clkr.hw },
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
+	[CRYPTO_CLK_SRC] = &crypto_clk_src.clkr,
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
diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 5a2961bfe893..86790efa10f0 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -210,4 +210,8 @@
 #define GCC_SNOC_PCIE1_1LANE_S_CLK			201
 #define GCC_SNOC_PCIE2_2LANE_S_CLK			202
 #define GCC_SNOC_PCIE3_2LANE_S_CLK			203
+#define CRYPTO_CLK_SRC					204
+#define GCC_CRYPTO_CLK					205
+#define GCC_CRYPTO_AXI_CLK				206
+#define GCC_CRYPTO_AHB_CLK				207
 #endif
diff --git a/include/dt-bindings/reset/qcom,ipq9574-gcc.h b/include/dt-bindings/reset/qcom,ipq9574-gcc.h
index d01dc6a24cf1..5bcf077413ba 100644
--- a/include/dt-bindings/reset/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/reset/qcom,ipq9574-gcc.h
@@ -160,5 +160,5 @@
 #define GCC_WCSS_Q6_BCR						151
 #define GCC_WCSS_Q6_TBU_BCR					152
 #define GCC_TCSR_BCR						153
-
+#define GCC_CRYPTO_BCR						154
 #endif
-- 
2.17.1

