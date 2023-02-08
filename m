Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A668E712
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 05:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBHE3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 23:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjBHE3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 23:29:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C9A3C2B3;
        Tue,  7 Feb 2023 20:29:17 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3183jplY011197;
        Wed, 8 Feb 2023 04:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xcWZB+E7iiv5uh7QVKlbZAoeb9zd5CyjePGdDpAeoZA=;
 b=CEU0heqehgMKnNfr0vp54zpOFO1TIJwNUT57iURlhgTdnHprAEQ7dG6ZOT/1gsfYVUYG
 CwKv6vnT9nuJaxbwvuksOwAQ+4ALIjZjXpmp2KQToNRRBVuZfrcA+FCjpRWbhw0TxfBT
 JKShTia9pth9ju5VhOpGFx7a71DR9dlmRVW6+TDSoN4GtqLcFlLGR11oIGevsJ8t2kGE
 GJ4hkkAcPTClGeH2H+s92eXJySDcEXv9U+8c3U6RqnItnX15MP/bkMQ0yKTnKFk7gfep
 LEe7F0UpmcHGuvd8UU5rxCJmYRifmt7PKaC0JUnf9pwITwvITKRwH6skMdFX/XPZLsVb Qw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm1yf0ce6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 04:29:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3184TCPk001804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 04:29:12 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 20:29:07 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 1/5] clk: qcom: apss-ipq-pll: refactor the driver to accommodate different PLL types
Date:   Wed, 8 Feb 2023 09:58:46 +0530
Message-ID: <20230208042850.1687-2-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230208042850.1687-1-quic_kathirav@quicinc.com>
References: <20230208042850.1687-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pfYT9cx2en6Vo_xiIHTNQk_uRl3jY7uj
X-Proofpoint-GUID: pfYT9cx2en6Vo_xiIHTNQk_uRl3jY7uj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_15,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APSS PLL found on the IPQ8074 and IPQ6018 are of type Huayra PLL. But,
IPQ5332 APSS PLL is of type Stromer Plus. To accommodate both these PLLs,
refactor the driver to take the clk_alpha_pll, alpha_pll_config via driver
data.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Added a comment to describe why different offsets are required
	  for PLL

 drivers/clk/qcom/apss-ipq-pll.c | 60 ++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index a5aea27eb867..4f2a147e9fb2 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -8,20 +8,27 @@
 
 #include "clk-alpha-pll.h"
 
-static const u8 ipq_pll_offsets[] = {
-	[PLL_OFF_L_VAL] = 0x08,
-	[PLL_OFF_ALPHA_VAL] = 0x10,
-	[PLL_OFF_USER_CTL] = 0x18,
-	[PLL_OFF_CONFIG_CTL] = 0x20,
-	[PLL_OFF_CONFIG_CTL_U] = 0x24,
-	[PLL_OFF_STATUS] = 0x28,
-	[PLL_OFF_TEST_CTL] = 0x30,
-	[PLL_OFF_TEST_CTL_U] = 0x34,
+/*
+ * Even though APSS PLL type is of existing one (like Huayra), its offsets
+ * are different from the one mentioned in the clk-alpha-pll.c, since the
+ * PLL is specific to APSS, so lets the define the same.
+ */
+static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
+	[CLK_ALPHA_PLL_TYPE_HUAYRA] =  {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_STATUS] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+	},
 };
 
-static struct clk_alpha_pll ipq_pll = {
+static struct clk_alpha_pll ipq_pll_huayra = {
 	.offset = 0x0,
-	.regs = ipq_pll_offsets,
+	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_HUAYRA],
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
 	.clkr = {
 		.enable_reg = 0x0,
@@ -61,6 +68,21 @@ static const struct alpha_pll_config ipq8074_pll_config = {
 	.test_ctl_hi_val = 0x4000,
 };
 
+struct apss_pll_data {
+	struct clk_alpha_pll *pll;
+	const struct alpha_pll_config *pll_config;
+};
+
+static struct apss_pll_data ipq8074_pll_data = {
+	.pll = &ipq_pll_huayra,
+	.pll_config = &ipq8074_pll_config,
+};
+
+static struct apss_pll_data ipq6018_pll_data = {
+	.pll = &ipq_pll_huayra,
+	.pll_config = &ipq6018_pll_config,
+};
+
 static const struct regmap_config ipq_pll_regmap_config = {
 	.reg_bits		= 32,
 	.reg_stride		= 4,
@@ -71,7 +93,7 @@ static const struct regmap_config ipq_pll_regmap_config = {
 
 static int apss_ipq_pll_probe(struct platform_device *pdev)
 {
-	const struct alpha_pll_config *ipq_pll_config;
+	const struct apss_pll_data *data;
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
 	void __iomem *base;
@@ -85,23 +107,23 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	ipq_pll_config = of_device_get_match_data(&pdev->dev);
-	if (!ipq_pll_config)
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
 		return -ENODEV;
 
-	clk_alpha_pll_configure(&ipq_pll, regmap, ipq_pll_config);
+	clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
 
-	ret = devm_clk_register_regmap(dev, &ipq_pll.clkr);
+	ret = devm_clk_register_regmap(dev, &data->pll->clkr);
 	if (ret)
 		return ret;
 
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
-					   &ipq_pll.clkr.hw);
+					   &data->pll->clkr.hw);
 }
 
 static const struct of_device_id apss_ipq_pll_match_table[] = {
-	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_config },
-	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_config },
+	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_data },
+	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
-- 
2.17.1

