Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34DD6B77C6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCMMlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCMMlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:41:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9BE5AB7D;
        Mon, 13 Mar 2023 05:41:20 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DBAT5W017663;
        Mon, 13 Mar 2023 12:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=Mlhqt/TQMW/XaKNhevXXYT1CK62k+l/39EDBwWNGHkE=;
 b=WLx9BsfZTssmxMhYe0jxzm4fRoChUAbebaGR+IZHQy4X6Mabx45Lp5t4aTao8YtH6RWd
 EBYtVaqX8/1KzUdamcAOp6tB0AzBE3l21OP9TOqI7Ct3Wf4VddOGw9CJDw1d/7HSM8qU
 KechRNbrTNUQ5P/2sY42uWP8q7wgKglvW0A/CuCIiEIRhjYtm1DehFLENKu5v5DN6YvK
 9TdWgOQZ5G/2jyPrNY/EajwheBkfH5nq0PbE1BsJXx2ASPVzd1KRsatYSTegK6KXwZDa
 mwVf4gp3L87DFztgk99HVy4D59q3BBvXCuxHRZvbzkmITERUyHeXhi8dQUHdSXMHWJ2f hw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p8jtwvtjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 12:40:56 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32DCemJU022410;
        Mon, 13 Mar 2023 12:40:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqkna0y-1;
        Mon, 13 Mar 2023 12:40:52 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DCeqlS022445;
        Mon, 13 Mar 2023 12:40:52 GMT
Received: from kbajaj-linux.qualcomm.com (kbajaj-linux.qualcomm.com [10.214.66.129])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32DCeqL0022443;
        Mon, 13 Mar 2023 12:40:52 +0000
Received: from kbajaj-linux.qualcomm.com (localhost [127.0.0.1])
        by kbajaj-linux.qualcomm.com (Postfix) with ESMTP id 6F0652A3;
        Mon, 13 Mar 2023 18:10:51 +0530 (IST)
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
Subject: [PATCH v2 5/5] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support
Date:   Mon, 13 Mar 2023 18:10:40 +0530
Message-Id: <20230313124040.9463-6-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
References: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jQnTkOtyOMnd6PtDUG2z37wiY9buHtQF
X-Proofpoint-GUID: jQnTkOtyOMnd6PtDUG2z37wiY9buHtQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130102
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
index f4d3e266c629..2dd9fc4e2858 100644
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

