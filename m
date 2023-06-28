Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25247740D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjF1Jdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:33:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:24904 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233680AbjF1J3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:29:31 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S7kKcv028278;
        Wed, 28 Jun 2023 09:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=GScz/dR9QVpcVHbYAArlF0BLYW9ekCkbj6HoNSkUIkw=;
 b=pR7Y3idOaOm1YD1vNAqtNnCWIUGyNCLAq4m1Z8zfLpnIS/ilL4/pGRA37lUosfpYd/xa
 NjuuYDsRM5sNS7uHWZVDblU+l3ueAlh9E4CXZRzlKeVa/ukWKyjheQLzD3LgfYUmE6f/
 sSAyeYeJw1aLHQzSxA+DdQC9dkcc+0/poQdF6EI+sJ7V728k0xPHQA43FRwooF0FqipP
 YRd7bmNENLLRbgwysrbCZLQ/TpZqhhx1dUKXLFEjz7FheJJhRa6l94HrN1RDURRIH2tV
 +CO8UjDSEUTDQ/ANHzUxpZ4blL4Y9tXVZt3rpG0ljqpaZqxNn9ZWyE7Kq2m9Alv7GVEk oQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg7x3s7s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 09:29:27 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35S9TQiL018984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 09:29:26 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 02:29:20 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V2 4/5] clk: qcom: gcc-qdu1000: Add support for GDSCs
Date:   Wed, 28 Jun 2023 14:58:36 +0530
Message-ID: <20230628092837.3090801-5-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
References: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LYGFlHecqRTd9hT25A0x5K0DoUigI2Ad
X-Proofpoint-GUID: LYGFlHecqRTd9hT25A0x5K0DoUigI2Ad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the GDSCs support for QDU1000 and QRU1000 SoCs.

Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
Changes since v1:
 - Newly added

 drivers/clk/qcom/gcc-qdu1000.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
index 991fb2bc97e9..718c34dca6e8 100644
--- a/drivers/clk/qcom/gcc-qdu1000.c
+++ b/drivers/clk/qcom/gcc-qdu1000.c
@@ -17,6 +17,7 @@
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
 #include "clk-regmap-phy-mux.h"
+#include "gdsc.h"
 #include "reset.h"
 
 enum {
@@ -2409,6 +2410,39 @@ static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
 	},
 };
 
+static struct gdsc pcie_0_gdsc = {
+	.gdscr = 0x9d004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
+	.pd = {
+		.name = "gcc_pcie_0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc pcie_0_phy_gdsc = {
+	.gdscr = 0x7c004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0x2,
+	.pd = {
+		.name = "gcc_pcie_0_phy_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc usb30_prim_gdsc = {
+	.gdscr = 0x49004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
+	.pd = {
+		.name = "gcc_usb30_prim_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
 static struct clk_regmap *gcc_qdu1000_clocks[] = {
 	[GCC_AGGRE_NOC_ECPRI_DMA_CLK] = &gcc_aggre_noc_ecpri_dma_clk.clkr,
 	[GCC_AGGRE_NOC_ECPRI_DMA_CLK_SRC] = &gcc_aggre_noc_ecpri_dma_clk_src.clkr,
@@ -2545,6 +2579,12 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
 	[GCC_DDRSS_ECPRI_GSI_CLK] = &gcc_ddrss_ecpri_gsi_clk.clkr,
 };
 
+static struct gdsc *gcc_qdu1000_gdscs[] = {
+	[PCIE_0_GDSC] = &pcie_0_gdsc,
+	[PCIE_0_PHY_GDSC] = &pcie_0_phy_gdsc,
+	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
+};
+
 static const struct qcom_reset_map gcc_qdu1000_resets[] = {
 	[GCC_ECPRI_CC_BCR] = { 0x3e000 },
 	[GCC_ECPRI_SS_BCR] = { 0x3a000 },
@@ -2606,6 +2646,8 @@ static const struct qcom_cc_desc gcc_qdu1000_desc = {
 	.num_clks = ARRAY_SIZE(gcc_qdu1000_clocks),
 	.resets = gcc_qdu1000_resets,
 	.num_resets = ARRAY_SIZE(gcc_qdu1000_resets),
+	.gdscs = gcc_qdu1000_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_qdu1000_gdscs),
 };
 
 static const struct of_device_id gcc_qdu1000_match_table[] = {
-- 
2.25.1

