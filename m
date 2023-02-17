Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45E69A6F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBQIdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:33:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC895FBEA;
        Fri, 17 Feb 2023 00:33:37 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7Jg4v010504;
        Fri, 17 Feb 2023 08:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xa9XZiBikd9wXQPbluBvwWQN/1ODQw+TlYDNvBgoWu0=;
 b=HT3zw/nHTcHgeBhAAwwiwdqsAHzCa78ZJZF/Xm8M1ofnlc4fiyKLggZgHR1Fqra9Z9/I
 aOSwdrwGeonZFpqLmy0OQznCxCVyVahv/7Pr+gtDjXrOvJtLhRvxcTGwQmg9AhAk05ED
 Yj842Ghf3EMgc7QSK2GG7RXBcFufy4Nn8cvaiLo/spxlT3PuYF9vBL5sR50YzbjPaO73
 K9R9aNhlrXOOUd9CsN4cnLDrE5c+gqI+kZVlF+FAc2p4To/toFpoELHG1UJSUfBHwozF
 0je3tQxyxUDIOL2A1IZoqwRyT/VnF3OoR8nu1y2mqdUGzgkV6STN6XLaVIwswVttJoKS tA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nt53br5eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:33:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31H8XWse012488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:33:32 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 00:33:27 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V3 1/5] clk: qcom: apss-ipq-pll: refactor the driver to accommodate different PLL types
Date:   Fri, 17 Feb 2023 14:03:04 +0530
Message-ID: <20230217083308.12017-2-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230217083308.12017-1-quic_kathirav@quicinc.com>
References: <20230217083308.12017-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DCSrJVLpnVTY_hCcJrH4F79AYBsAl7yO
X-Proofpoint-GUID: DCSrJVLpnVTY_hCcJrH4F79AYBsAl7yO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_04,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170076
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V3:
	- Pick up R-b tag

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

