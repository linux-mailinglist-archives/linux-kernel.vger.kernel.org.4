Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A126880B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjBBOxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjBBOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:52:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F3718B27;
        Thu,  2 Feb 2023 06:52:45 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312EbsIR018065;
        Thu, 2 Feb 2023 14:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=bdgK5SOH3aihuDMEqBQrs9Qku/i3zw0lLU2xV96Mpbg=;
 b=bUwEOGqcf+ftC3eyGyKa37ztLTxXsJXfWEODNYWd4Y/lRep2d7u8cjE2qMr21BIVOgOD
 ExGEjsE2msXZT1GJGTUr55GPVxABK1tx6YrRCH9tzkfnWN3v14CiynsPup5IqZ2niMKQ
 wzqf9BDr6TeuOrXjhAw8ekj6HLMGuj/AYAMEIhZNGjFtCLnj96METrnc5CTOjU5rHK9j
 Gca1clHrqCAW0SBBDrxGwbhIZrw7GRSlpwHkn60Lb8ad/AhVGWN0QqieykdqPtmMoagW
 FBGkaJKGAR2rru8Quyb3veAUmN0GwtGfBkk6j9Mq08O4vKF8gV6O8n56YqbLaiV5loYT PA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfqt3jrqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 14:52:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312Eqd0T019630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 14:52:39 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 06:52:35 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 3/6] clk: qcom: apss-ipq-pll: add support for IPQ5332
Date:   Thu, 2 Feb 2023 20:22:05 +0530
Message-ID: <20230202145208.2328032-4-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tzxi54dXN7EDaqaRcXo5qEpeYzWipJke
X-Proofpoint-GUID: tzxi54dXN7EDaqaRcXo5qEpeYzWipJke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 APSS PLL is of type Stromer Plus. Add support for the same.

To configure the stromer plus PLL separate API
(clock_stromer_pll_configure) to be used. To achieve this, introduce the
new member pll_type in device data structure and call the appropriate
function based on this.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/apss-ipq-pll.c | 58 ++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 6e815e8b7fe4..023a854f2c21 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -19,6 +19,17 @@ static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_TEST_CTL] = 0x30,
 		[PLL_OFF_TEST_CTL_U] = 0x34,
 	},
+	[CLK_ALPHA_PLL_TYPE_STROMER_PLUS] = {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL_U] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_STATUS] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+	},
 };
 
 static struct clk_alpha_pll ipq_pll_huayra = {
@@ -39,6 +50,38 @@ static struct clk_alpha_pll ipq_pll_huayra = {
 	},
 };
 
+static struct clk_alpha_pll ipq_pll_stromer_plus = {
+	.offset = 0x0,
+	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.clkr = {
+		.enable_reg = 0x0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "a53pll",
+			.parent_data = &(const struct clk_parent_data) {
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_stromer_ops,
+		},
+	},
+};
+
+static const struct alpha_pll_config ipq5332_pll_config = {
+	.l = 0x3e,
+	.config_ctl_val = 0x4001075b,
+	.config_ctl_hi_val = 0x304,
+	.main_output_mask = BIT(0),
+	.aux_output_mask = BIT(1),
+	.early_output_mask = BIT(3),
+	.alpha_en_mask = BIT(24),
+	.status_val = 0x3,
+	.status_mask = GENMASK(10, 8),
+	.lock_det = BIT(2),
+	.test_ctl_hi_val = 0x00400003,
+};
+
 static const struct alpha_pll_config ipq6018_pll_config = {
 	.l = 0x37,
 	.config_ctl_val = 0x240d4828,
@@ -64,16 +107,25 @@ static const struct alpha_pll_config ipq8074_pll_config = {
 };
 
 struct apss_pll_data {
+	int pll_type;
 	struct clk_alpha_pll *pll;
 	const struct alpha_pll_config *pll_config;
 };
 
+static struct apss_pll_data ipq5332_pll_data = {
+	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
+	.pll = &ipq_pll_stromer_plus,
+	.pll_config = &ipq5332_pll_config,
+};
+
 static struct apss_pll_data ipq8074_pll_data = {
+	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
 	.pll = &ipq_pll_huayra,
 	.pll_config = &ipq8074_pll_config,
 };
 
 static struct apss_pll_data ipq6018_pll_data = {
+	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
 	.pll = &ipq_pll_huayra,
 	.pll_config = &ipq6018_pll_config,
 };
@@ -106,7 +158,10 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENODEV;
 
-	clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
+	if (data->pll_type == CLK_ALPHA_PLL_TYPE_HUAYRA)
+		clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
+	else if (data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER_PLUS)
+		clk_stromer_pll_configure(data->pll, regmap, data->pll_config);
 
 	ret = devm_clk_register_regmap(dev, &data->pll->clkr);
 	if (ret)
@@ -117,6 +172,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id apss_ipq_pll_match_table[] = {
+	{ .compatible = "qcom,ipq5332-a53pll", .data = &ipq5332_pll_data },
 	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_data },
 	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_data },
 	{ }
-- 
2.34.1

