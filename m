Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F7E7007AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbjELMWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240954AbjELMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:22:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC57C12EAC;
        Fri, 12 May 2023 05:22:03 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CCGsjc007693;
        Fri, 12 May 2023 12:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=NIMkV1VJzIXY7dIMMBQioiedQcl/BFgTMohOJYZ1TWU=;
 b=oyLFf+HV08U5CVRVYCcP3iBjhJ7FbbOmbYlpMKAyY7EpMYGMDHkZVLxl4YEpcyAlj/Qi
 OdUX71EZuDfO6Zo83g0Sc9ICs89zUNx8/1bjSVRlaAItekeRVnDAfAybSkQ2ieGEdbsL
 l8JVeFwkbRRNtLo7RwlFk6chgNqSHai0B7r9N+Spa3/2HVbEiX+4bTtE40idp74PhYE1
 wcDM+7zaz6VfErkV7Gi5mT7TabNLfUf/OOFLfpvEWc/2voRW0+NPFl3TBuas+Pi7ELXW
 LX0JUIyhCczTemGy9NnGn6I7QNFO69eihDNK49n+LVwNm/K4ssEkFWr/5HWfP8xwI6n7 VQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhh390k9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:22:00 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34CCLv4I029122;
        Fri, 12 May 2023 12:21:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdy59u1w7-1;
        Fri, 12 May 2023 12:21:57 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CCLvIm029117;
        Fri, 12 May 2023 12:21:57 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34CCLuew029116;
        Fri, 12 May 2023 12:21:57 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 3CF2952974D; Fri, 12 May 2023 17:51:56 +0530 (+0530)
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
Subject: [PATCH v3 10/10] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support
Date:   Fri, 12 May 2023 17:51:34 +0530
Message-Id: <20230512122134.24339-11-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WPEJo8Do-RyKQYwt770G-oaoxvej3oIq
X-Proofpoint-ORIG-GUID: WPEJo8Do-RyKQYwt770G-oaoxvej3oIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120103
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
index 1da337e7a378..01da6be1f861 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -187,7 +187,7 @@ static const struct llcc_slice_config sc8280xp_data[] = {
 	{ LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
 	{ LLCC_DISP,     16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
 	{ LLCC_AUDHW,    22, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
-	{ LLCC_DRE,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
+	{ LLCC_ECC,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
 	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
 	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
 	{ LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
@@ -358,6 +358,36 @@ static const struct llcc_slice_config sm8550_data[] =  {
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
@@ -557,6 +587,38 @@ static const struct qcom_llcc_config sm8550_cfg[] = {
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
@@ -1125,6 +1187,7 @@ static const struct of_device_id qcom_llcc_of_match[] = {
 	{ .compatible = "qcom,sm8350-llcc", .data = sm8350_cfg },
 	{ .compatible = "qcom,sm8450-llcc", .data = sm8450_cfg },
 	{ .compatible = "qcom,sm8550-llcc", .data = sm8550_cfg },
+	{ .compatible = "qcom,qdu1000-llcc", .data = qdu1000_cfg},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_llcc_of_match);
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 423220e66026..1359ed8a8a3f 100644
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
2.17.1

