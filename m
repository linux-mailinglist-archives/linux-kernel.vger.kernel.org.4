Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF310700799
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbjELMWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbjELMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:21:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D449013;
        Fri, 12 May 2023 05:21:56 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CBDI1H011040;
        Fri, 12 May 2023 12:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=yfzJYZu/9y46Q70PlmxBlI8FMOuVHr/VsKH79cgMxDA=;
 b=YGozAFgEO59yUsd2ceOXmhUhJgo/1y0kPPmo+1mWbz1Dh96S6bEkJQ/HQqD2wjfIDFYQ
 HoYI9e91x/RGR8+jqoLqVz5jdFbDeTFq8Ou7+sI3J5E/D5012mv8a3xqiNIQT34+QfrE
 LruOMgDrnkGZekmh7i4Ev0BO0DoDHdZSXvX9t7EIR+c8b4R24GXdst2gPJnNVDhGnTx+
 prPvs5fiCmUV+VG5syMbRIAgW4e1Onq8N3cJj+u8fuNp2aqDsNJgvOkOYfR9IYzS4BRn
 1MII9QpVGEtSVbyHvTKV9RkEtHuiwm2azes6ahF1D+DmcvcnPUVY1WU0IvkSnMoHlQ7x AQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh5g99xbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:21:52 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34CCLnBt029054;
        Fri, 12 May 2023 12:21:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdy59u1v9-1;
        Fri, 12 May 2023 12:21:49 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CCLnWx029048;
        Fri, 12 May 2023 12:21:49 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34CCLnTV029047;
        Fri, 12 May 2023 12:21:49 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id EB25E52974D; Fri, 12 May 2023 17:51:48 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 05/10] soc: qcom: llcc: Refactor llcc driver to support multiple configuration
Date:   Fri, 12 May 2023 17:51:29 +0530
Message-Id: <20230512122134.24339-6-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MXLh4kCF2tYlDrFYvc9F98wbbRufUNal
X-Proofpoint-ORIG-GUID: MXLh4kCF2tYlDrFYvc9F98wbbRufUNal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120103
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor driver to support multiple configuration for llcc on a target.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 210 ++++++++++++++++++++---------------
 1 file changed, 123 insertions(+), 87 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 67c19ed2219a..6cf373da5df9 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -423,101 +423,137 @@ static const u32 llcc_v2_1_reg_offset[] = {
 	[LLCC_COMMON_STATUS0]	= 0x0003400c,
 };

-static const struct qcom_llcc_config sc7180_cfg = {
-	.sct_data	= sc7180_data,
-	.size		= ARRAY_SIZE(sc7180_data),
-	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_reg_offset,
-	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+static const struct qcom_llcc_config sc7180_cfg[] = {
+	{
+		.sct_data	= sc7180_data,
+		.size		= ARRAY_SIZE(sc7180_data),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v1_reg_offset,
+		.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	},
+	{ },
 };

-static const struct qcom_llcc_config sc7280_cfg = {
-	.sct_data	= sc7280_data,
-	.size		= ARRAY_SIZE(sc7280_data),
-	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_reg_offset,
-	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+static const struct qcom_llcc_config sc7280_cfg[] = {
+	{
+		.sct_data	= sc7280_data,
+		.size		= ARRAY_SIZE(sc7280_data),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v1_reg_offset,
+		.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	},
+	{ },
 };

-static const struct qcom_llcc_config sc8180x_cfg = {
-	.sct_data	= sc8180x_data,
-	.size		= ARRAY_SIZE(sc8180x_data),
-	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_reg_offset,
-	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+static const struct qcom_llcc_config sc8180x_cfg[] = {
+	{
+		.sct_data	= sc8180x_data,
+		.size		= ARRAY_SIZE(sc8180x_data),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v1_reg_offset,
+		.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	},
+	{ },
 };

-static const struct qcom_llcc_config sc8280xp_cfg = {
-	.sct_data	= sc8280xp_data,
-	.size		= ARRAY_SIZE(sc8280xp_data),
-	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_reg_offset,
-	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+static const struct qcom_llcc_config sc8280xp_cfg[] = {
+	{
+		.sct_data	= sc8280xp_data,
+		.size		= ARRAY_SIZE(sc8280xp_data),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v1_reg_offset,
+		.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	},
+	{ },
 };

-static const struct qcom_llcc_config sdm845_cfg = {
-	.sct_data	= sdm845_data,
-	.size		= ARRAY_SIZE(sdm845_data),
-	.need_llcc_cfg	= false,
-	.reg_offset	= llcc_v1_reg_offset,
-	.edac_reg_offset = &llcc_v1_edac_reg_offset,
-	.no_edac	= true,
+static const struct qcom_llcc_config sdm845_cfg[] = {
+	{
+		.sct_data	= sdm845_data,
+		.size		= ARRAY_SIZE(sdm845_data),
+		.need_llcc_cfg	= false,
+		.reg_offset	= llcc_v1_reg_offset,
+		.edac_reg_offset = &llcc_v1_edac_reg_offset,
+		.no_edac	= true,
+	},
+	{ },
 };

-static const struct qcom_llcc_config sm6350_cfg = {
-	.sct_data	= sm6350_data,
-	.size		= ARRAY_SIZE(sm6350_data),
-	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_reg_offset,
-	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+static const struct qcom_llcc_config sm6350_cfg[] = {
+	{
+		.sct_data	= sm6350_data,
+		.size		= ARRAY_SIZE(sm6350_data),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v1_reg_offset,
+		.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	},
+	{ },
 };

-static const struct qcom_llcc_config sm7150_cfg = {
-	.sct_data       = sm7150_data,
-	.size           = ARRAY_SIZE(sm7150_data),
-	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_reg_offset,
-	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+static const struct qcom_llcc_config sm7150_cfg[] = {
+	{
+		.sct_data       = sm7150_data,
+		.size           = ARRAY_SIZE(sm7150_data),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v1_reg_offset,
+		.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	},
+	{ },
 };

-static const struct qcom_llcc_config sm8150_cfg = {
-	.sct_data       = sm8150_data,
-	.size           = ARRAY_SIZE(sm8150_data),
-	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_reg_offset,
-	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+static const struct qcom_llcc_config sm8150_cfg[] = {
+	{
+		.sct_data       = sm8150_data,
+		.size           = ARRAY_SIZE(sm8150_data),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v1_reg_offset,
+		.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	},
+	{ },
 };

-static const struct qcom_llcc_config sm8250_cfg = {
-	.sct_data       = sm8250_data,
-	.size           = ARRAY_SIZE(sm8250_data),
-	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_reg_offset,
-	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+static const struct qcom_llcc_config sm8250_cfg[] = {
+	{
+		.sct_data       = sm8250_data,
+		.size           = ARRAY_SIZE(sm8250_data),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v1_reg_offset,
+		.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	},
+	{ },
 };

-static const struct qcom_llcc_config sm8350_cfg = {
-	.sct_data       = sm8350_data,
-	.size           = ARRAY_SIZE(sm8350_data),
-	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_reg_offset,
-	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+static const struct qcom_llcc_config sm8350_cfg[] = {
+	{
+		.sct_data       = sm8350_data,
+		.size           = ARRAY_SIZE(sm8350_data),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v1_reg_offset,
+		.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	},
+	{ },
 };

-static const struct qcom_llcc_config sm8450_cfg = {
-	.sct_data       = sm8450_data,
-	.size           = ARRAY_SIZE(sm8450_data),
-	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v2_1_reg_offset,
-	.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+static const struct qcom_llcc_config sm8450_cfg[] = {
+	{
+		.sct_data       = sm8450_data,
+		.size           = ARRAY_SIZE(sm8450_data),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v2_1_reg_offset,
+		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+	},
+	{ },
 };

-static const struct qcom_llcc_config sm8550_cfg = {
-	.sct_data       = sm8550_data,
-	.size           = ARRAY_SIZE(sm8550_data),
-	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v2_1_reg_offset,
-	.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+static const struct qcom_llcc_config sm8550_cfg[] = {
+	{
+		.sct_data       = sm8550_data,
+		.size           = ARRAY_SIZE(sm8550_data),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v2_1_reg_offset,
+		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+	},
+	{ },
 };

 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
@@ -1004,8 +1040,8 @@ static int qcom_llcc_probe(struct platform_device *pdev)

 	drv_data->version = version;

-	llcc_cfg = cfg->sct_data;
-	sz = cfg->size;
+	llcc_cfg = cfg[0]->sct_data;
+	sz = cfg[0]->size;

 	for (i = 0; i < sz; i++)
 		if (llcc_cfg[i].slice_id > drv_data->max_slices)
@@ -1051,18 +1087,18 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 }

 static const struct of_device_id qcom_llcc_of_match[] = {
-	{ .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfg },
-	{ .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfg },
-	{ .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfg },
-	{ .compatible = "qcom,sc8280xp-llcc", .data = &sc8280xp_cfg },
-	{ .compatible = "qcom,sdm845-llcc", .data = &sdm845_cfg },
-	{ .compatible = "qcom,sm6350-llcc", .data = &sm6350_cfg },
-	{ .compatible = "qcom,sm7150-llcc", .data = &sm7150_cfg },
-	{ .compatible = "qcom,sm8150-llcc", .data = &sm8150_cfg },
-	{ .compatible = "qcom,sm8250-llcc", .data = &sm8250_cfg },
-	{ .compatible = "qcom,sm8350-llcc", .data = &sm8350_cfg },
-	{ .compatible = "qcom,sm8450-llcc", .data = &sm8450_cfg },
-	{ .compatible = "qcom,sm8550-llcc", .data = &sm8550_cfg },
+	{ .compatible = "qcom,sc7180-llcc", .data = sc7180_cfg },
+	{ .compatible = "qcom,sc7280-llcc", .data = sc7280_cfg },
+	{ .compatible = "qcom,sc8180x-llcc", .data = sc8180x_cfg },
+	{ .compatible = "qcom,sc8280xp-llcc", .data = sc8280xp_cfg },
+	{ .compatible = "qcom,sdm845-llcc", .data = sdm845_cfg },
+	{ .compatible = "qcom,sm6350-llcc", .data = sm6350_cfg },
+	{ .compatible = "qcom,sm7150-llcc", .data = sm7150_cfg },
+	{ .compatible = "qcom,sm8150-llcc", .data = sm8150_cfg },
+	{ .compatible = "qcom,sm8250-llcc", .data = sm8250_cfg },
+	{ .compatible = "qcom,sm8350-llcc", .data = sm8350_cfg },
+	{ .compatible = "qcom,sm8450-llcc", .data = sm8450_cfg },
+	{ .compatible = "qcom,sm8550-llcc", .data = sm8550_cfg },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_llcc_of_match);
--
2.17.1

