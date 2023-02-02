Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29836880A2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBBOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjBBOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:52:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E6859E9;
        Thu,  2 Feb 2023 06:52:37 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312EVD1K003218;
        Thu, 2 Feb 2023 14:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=UGz90dShSyDi0yZp7LaYDJub8mdD5uOjJtAh7ZjBjNs=;
 b=nWQiLkDFHfVjmA6zuR2oOI8c4tBmF4Vcjj20HX3DAOgiCYQwL3g8YKwzbQOBi/dovJig
 BGM5MoI3LpEJbHnFB/l95Uf8BSrf3tFEk4TQ0fx2sO80K/2bD+aOVILOQBD4ldrvKaH8
 dHVhGiIEXtFtPCs7cmOfWzuioLq0n9IXWaVbeWJm1QKmqeYoC+7muUF2gyP7ytCyzDBa
 ai58NYImEfh0LmW43qfBbfZSOY8W8RpCj5D39alp5Ea8VQbI/lF8RwozA9pPI38depw/
 5+yI+hhCR+9c37W5K+sRxFKOy6md4gUZgU/5IhDO0JYAYIzf+stTe77EILfPp9Z97Kzf wA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfkj4bccb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 14:52:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312EqVMv002950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 14:52:31 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 06:52:27 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 1/6] clk: qcom: apss-ipq-pll: refactor the driver to accommodate different PLL types
Date:   Thu, 2 Feb 2023 20:22:03 +0530
Message-ID: <20230202145208.2328032-2-quic_kathirav@quicinc.com>
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
X-Proofpoint-GUID: nk-UTjWyK2EV2YIDD5VL_HWTy9bfXVj8
X-Proofpoint-ORIG-GUID: nk-UTjWyK2EV2YIDD5VL_HWTy9bfXVj8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APSS PLL found on the IPQ8074 and IPQ6018 are of type Huayra PLL. But,
IPQ5332 APSS PLL is of type Stromer Plus. To accommodate both these PLLs,
refactor the driver to take the clk_alpha_pll, alpha_pll_config via device
data.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/apss-ipq-pll.c | 55 +++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index a5aea27eb867..6e815e8b7fe4 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -8,20 +8,22 @@
 
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
@@ -61,6 +63,21 @@ static const struct alpha_pll_config ipq8074_pll_config = {
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
@@ -71,7 +88,7 @@ static const struct regmap_config ipq_pll_regmap_config = {
 
 static int apss_ipq_pll_probe(struct platform_device *pdev)
 {
-	const struct alpha_pll_config *ipq_pll_config;
+	const struct apss_pll_data *data;
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
 	void __iomem *base;
@@ -85,23 +102,23 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
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
2.34.1

