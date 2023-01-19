Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BD067346C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjASJ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjASJ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:28:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54825AA69;
        Thu, 19 Jan 2023 01:28:16 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5uF9d016204;
        Thu, 19 Jan 2023 09:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=W9BYNxCXZUaL8mn2RCE8VrCL8fDgv2Lv0w2tYJzsIOs=;
 b=B1bt/CxjMui7anvGT5QVIZdkJ1fCghHL82feHIywK+VyvJGIto23X9jdX782OHNmVkac
 fnanQ1Md2SEz9IZBYsyiVlTwxhYvvwykY99lXRutfpI9B0dG42ZZI5deG2uzrjO9OrjE
 n+JbJHhc9KIWJ7PTy/JJKKfiUdvoFboDbIlAmtveynFEQ+PcYgCmZc8lk3J7fElEw3fc
 w95BsuykgW3bvEBeyfX0QgpNR0lZcHpYBBFk3pN13JXJOdmrSL3vBW4spC5o+9goucuD
 53qd9ORJdjpZ14BjEDteZMGrosTdT+TXDx2KfIRiGPtHLaGsDF7HhXz9Hg4dTHFpEQI0 0g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n69uyu9qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 09:28:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J9S8ma023468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 09:28:09 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 01:28:04 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v4 5/6] clk: qcom: lpassaudiocc-sc7280: Merge lpasscc into lpass_aon
Date:   Thu, 19 Jan 2023 14:57:23 +0530
Message-ID: <1674120444-23706-6-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674120444-23706-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674120444-23706-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XGFhFyKJ_FI60ZB5VIRzpLWdeQ8tWcLQ
X-Proofpoint-GUID: XGFhFyKJ_FI60ZB5VIRzpLWdeQ8tWcLQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_07,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=483
 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge lpasscc clocks into lpass_aon clk_regmap structure as they
are using same register space.
In existing implementation, lpasscc clocks and lpass_aon clocks are
being registered exclusively and overlapping if both of them are
to be used.
This is required to avoid such overlapping and to register
lpasscc clocks and lpass_aon clocks simultaneously.

Fixes: 0cbcfbe50cbf ("clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon")
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 1339f92..18f7a50 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -642,11 +642,6 @@ static struct gdsc lpass_aon_cc_lpass_audio_hm_gdsc = {
 	.flags = RETAIN_FF_ENABLE,
 };
 
-static struct clk_regmap *lpass_cc_sc7280_clocks[] = {
-	[LPASS_Q6SS_AHBM_CLK] = &lpass_q6ss_ahbm_clk.clkr,
-	[LPASS_Q6SS_AHBS_CLK] = &lpass_q6ss_ahbs_clk.clkr,
-};
-
 static struct clk_regmap *lpass_aon_cc_sc7280_clocks[] = {
 	[LPASS_AON_CC_AUDIO_HM_H_CLK] = &lpass_aon_cc_audio_hm_h_clk.clkr,
 	[LPASS_AON_CC_VA_MEM0_CLK] = &lpass_aon_cc_va_mem0_clk.clkr,
@@ -660,6 +655,8 @@ static struct clk_regmap *lpass_aon_cc_sc7280_clocks[] = {
 	[LPASS_AON_CC_TX_MCLK_2X_CLK] = &lpass_aon_cc_tx_mclk_2x_clk.clkr,
 	[LPASS_AON_CC_TX_MCLK_CLK] = &lpass_aon_cc_tx_mclk_clk.clkr,
 	[LPASS_AON_CC_TX_MCLK_RCG_CLK_SRC] = &lpass_aon_cc_tx_mclk_rcg_clk_src.clkr,
+	[LPASS_Q6_AHBM_CLK] = &lpass_q6ss_ahbm_clk.clkr,
+	[LPASS_Q6_AHBS_CLK] = &lpass_q6ss_ahbs_clk.clkr,
 };
 
 static struct gdsc *lpass_aon_cc_sc7280_gdscs[] = {
@@ -692,12 +689,6 @@ static struct regmap_config lpass_audio_cc_sc7280_regmap_config = {
 	.fast_io = true,
 };
 
-static const struct qcom_cc_desc lpass_cc_sc7280_desc = {
-	.config = &lpass_audio_cc_sc7280_regmap_config,
-	.clks = lpass_cc_sc7280_clocks,
-	.num_clks = ARRAY_SIZE(lpass_cc_sc7280_clocks),
-};
-
 static const struct qcom_cc_desc lpass_audio_cc_sc7280_desc = {
 	.config = &lpass_audio_cc_sc7280_regmap_config,
 	.clks = lpass_audio_cc_sc7280_clocks,
@@ -825,13 +816,6 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
-		lpass_audio_cc_sc7280_regmap_config.name = "cc";
-		desc = &lpass_cc_sc7280_desc;
-		ret = qcom_cc_probe(pdev, desc);
-		goto exit;
-	}
-
 	lpass_audio_cc_sc7280_regmap_config.name = "lpasscc_aon";
 	lpass_audio_cc_sc7280_regmap_config.max_register = 0xa0008;
 	desc = &lpass_aon_cc_sc7280_desc;
-- 
2.7.4

