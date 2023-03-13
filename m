Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CEF6B6FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCMHOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCMHO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:14:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D386134F7D;
        Mon, 13 Mar 2023 00:14:21 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D4k1cr003214;
        Mon, 13 Mar 2023 07:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=NUiZjjIrTP5ZgkkmZU3onne1lk3VLupFYt6bYLSlRSg=;
 b=PpFXvsYUbKsBg/JNqXEG0NE62zEVTZVf/DGzhLR4guw5+S13yA25OI2k+36FoUh6dP5Z
 w6Xf3CE1+OfNHOq1gLYn2AAVfudIxKgNhLllFUEP/Rchz9pySSfm30Rw//8u2Ly/3saC
 VIaeaPfOG2uaMYEaIOYWJtGXhR+mr4jSUqknMSQPD3kqH6cQbB93iiZ+dJMSci83OXjP
 nuNuSwEM1P6wbvkpcQVzPvoh8OMsV5er7viNXzNFVPdPgf+khJlNfBk4hKGlRc00qxK8
 xqJWzBIFglhEMfS7lNZjd5JAcb5JprxOXEbVR/o/nsZmU1LR0ePTijLDbCuEoF8VSVpO cA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p8fbncd6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 07:13:55 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32D7DqCS032189;
        Mon, 13 Mar 2023 07:13:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqkkymb-1;
        Mon, 13 Mar 2023 07:13:52 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32D7DqiI032184;
        Mon, 13 Mar 2023 07:13:52 GMT
Received: from kbajaj-linux.qualcomm.com (kbajaj-linux.qualcomm.com [10.214.66.129])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32D7DpWk032183;
        Mon, 13 Mar 2023 07:13:52 +0000
Received: from kbajaj-linux.qualcomm.com (localhost [127.0.0.1])
        by kbajaj-linux.qualcomm.com (Postfix) with ESMTP id 1AE17D8;
        Mon, 13 Mar 2023 12:43:51 +0530 (IST)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 5/5] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support
Date:   Mon, 13 Mar 2023 12:43:25 +0530
Message-Id: <20230313071325.21605-6-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313071325.21605-1-quic_kbajaj@quicinc.com>
References: <20230313071325.21605-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HXhlDz34mRU-r-llx61NRfpGSnW4Aygm
X-Proofpoint-GUID: HXhlDz34mRU-r-llx61NRfpGSnW4Aygm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC configuration data for QDU1000 and QRU1000 SoCs
and updating macro name for LLCC_DRE to LLCC_ECC as per
the latest specification.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c       | 65 +++++++++++++++++++++++++++++-
 include/linux/soc/qcom/llcc-qcom.h |  2 +-
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 696f1f46dd61..c2c05fcf1f7b 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -188,7 +188,7 @@ static const struct llcc_slice_config sc8280xp_data[] = {
 	{ LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
 	{ LLCC_DISP,     16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
 	{ LLCC_AUDHW,    22, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
-	{ LLCC_DRE,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
+	{ LLCC_ECC,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
 	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
 	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
 	{ LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
@@ -351,6 +351,36 @@ static const struct llcc_slice_config sm8550_data[] =  {
 	{LLCC_VIDVSP,   28,  256, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
 };
 
+static const struct llcc_slice_config qdu1000_data_2ch[] = {
+	{LLCC_MDMHPGRW, 7, 512, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_MODHW,    9, 256, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_MDMPNG,  21, 256, 0, 1,   0x3, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_ECC,     26, 512, 3, 1, 0xFFC, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+	{LLCC_MODPE,   29, 256, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_APTCM,   30, 256, 3, 1,   0x0, 0xC, 1, 0, 0, 1, 0, 0, 0 },
+	{LLCC_WRCACHE, 31, 128, 1, 1,   0x3, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+};
+
+static const struct llcc_slice_config qdu1000_data_4ch[] = {
+	{LLCC_MDMHPGRW, 7, 1024, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_MODHW,    9, 512,  1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_MDMPNG,  21, 512,  0, 1,   0x3, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_ECC,     26, 1024, 3, 1, 0xFFC, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+	{LLCC_MODPE,   29, 512,  1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_APTCM,   30, 512,  3, 1,   0x0, 0xC, 1, 0, 0, 1, 0, 0, 0 },
+	{LLCC_WRCACHE, 31, 256,  1, 1,   0x3, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+};
+
+static const struct llcc_slice_config qdu1000_data_8ch[] = {
+	{LLCC_MDMHPGRW, 7, 2048, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_MODHW,    9, 1024, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_MDMPNG,  21, 1024, 0, 1,   0x3, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_ECC,     26, 2048, 3, 1, 0xFFC, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+	{LLCC_MODPE,   29, 1024, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_APTCM,   30, 1024, 3, 1,   0x0, 0xC, 1, 0, 0, 1, 0, 0, 0 },
+	{LLCC_WRCACHE, 31, 512,  1, 1,   0x3, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+};
+
 static const struct llcc_edac_reg_offset llcc_v1_edac_reg_offset = {
 	.trp_ecc_error_status0 = 0x20344,
 	.trp_ecc_error_status1 = 0x20348,
@@ -538,6 +568,38 @@ static const struct qcom_llcc_config sm8550_cfg[] = {
 	{ },
 };
 
+static const struct qcom_llcc_config qdu1000_cfg[] = {
+	{
+		.sct_data       = qdu1000_data_8ch,
+		.size		= ARRAY_SIZE(qdu1000_data_8ch),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v2_1_reg_offset,
+		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+	},
+	{
+		.sct_data       = qdu1000_data_4ch,
+		.size           = ARRAY_SIZE(qdu1000_data_4ch),
+		.need_llcc_cfg  = true,
+		.reg_offset     = llcc_v2_1_reg_offset,
+		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+	},
+	{
+		.sct_data       = qdu1000_data_4ch,
+		.size           = ARRAY_SIZE(qdu1000_data_4ch),
+		.need_llcc_cfg  = true,
+		.reg_offset     = llcc_v2_1_reg_offset,
+		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+	},
+	{
+		.sct_data       = qdu1000_data_2ch,
+		.size           = ARRAY_SIZE(qdu1000_data_2ch),
+		.need_llcc_cfg  = true,
+		.reg_offset     = llcc_v2_1_reg_offset,
+		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+	},
+	{ },
+};
+
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
 
 /**
@@ -1110,6 +1172,7 @@ static const struct of_device_id qcom_llcc_of_match[] = {
 	{ .compatible = "qcom,sm8350-llcc", .data = sm8350_cfg },
 	{ .compatible = "qcom,sm8450-llcc", .data = sm8450_cfg },
 	{ .compatible = "qcom,sm8550-llcc", .data = sm8550_cfg },
+	{ .compatible = "qcom,qdu1000-llcc", .data = qdu1000_cfg},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_llcc_of_match);
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 225891a02f5d..150b2836c8b9 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -30,7 +30,7 @@
 #define LLCC_NPU         23
 #define LLCC_WLHW        24
 #define LLCC_PIMEM       25
-#define LLCC_DRE         26
+#define LLCC_ECC         26
 #define LLCC_CVP         28
 #define LLCC_MODPE       29
 #define LLCC_APTCM       30
-- 
2.39.1

