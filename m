Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5C700798
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbjELMWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbjELMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:21:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF72136;
        Fri, 12 May 2023 05:21:54 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CBjEOH020981;
        Fri, 12 May 2023 12:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=qRWrHVDwbLS+lNdPMcQNCVsVTRkpVonMCQUakS2Yv+k=;
 b=KzcjMaJhSc3xOCc9Q0WTVat71unx7/ZadGeH0xAmSwtjxQevYcFfTWDsuAk/jFdf9bnc
 3WWy04IJ29w6a/LmxsMbOe//T7MNrBktAn/pRWg04XzDuVPBBQWjLSLATREzYJrFMAEu
 x8GqMbICYzp2E64cw9M2zvKa7/Nl0I9+PTV6mqTgtRAo/niatWCqpyzDv2zplU5ecq4x
 OM/YhmshIq6MRR9OcOFtdX1Jn+/3LfGSsZjWJ6/q9Ew3cgMdHOwo1xgvrmn+G1qvrbRF
 r8ZKINAMcs/GuUay94SCrRb6H5+MPvlDMMHRX6qb0ChDywi7H6m6bYRU40EVPatTsW8Q 7A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhes20x14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:21:51 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34CCLj5W028989;
        Fri, 12 May 2023 12:21:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdy59u1v4-1;
        Fri, 12 May 2023 12:21:48 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CCLmet029036;
        Fri, 12 May 2023 12:21:48 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34CCLmab029035;
        Fri, 12 May 2023 12:21:48 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 87FCD52974D; Fri, 12 May 2023 17:51:47 +0530 (+0530)
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
Subject: [PATCH v3 04/10] nvmem: qfprom: Add support for secure reading on QDU1000/QRU1000
Date:   Fri, 12 May 2023 17:51:28 +0530
Message-Id: <20230512122134.24339-5-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IARbnrTGb9K1hxRrRUGmlX-AD9sHcsMM
X-Proofpoint-GUID: IARbnrTGb9K1hxRrRUGmlX-AD9sHcsMM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
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

Add qfprom driver support for QDU1000/QRU1000 SOCs.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/nvmem/qfprom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 20662e2d3732..12a7981a8a71 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -109,6 +109,10 @@ struct qfprom_soc_compatible_data {
 	bool secure;
 };

+static const struct qfprom_soc_compatible_data qdu1000_qfprom = {
+	.secure = true
+};
+
 static const struct nvmem_keepout sc7180_qfprom_keepout[] = {
 	{.start = 0x128, .end = 0x148},
 	{.start = 0x220, .end = 0x228}
@@ -490,6 +494,7 @@ static int qfprom_probe(struct platform_device *pdev)

 static const struct of_device_id qfprom_of_match[] = {
 	{ .compatible = "qcom,qfprom",},
+	{ .compatible = "qcom,qdu1000-qfprom", .data = &qdu1000_qfprom},
 	{ .compatible = "qcom,sc7180-qfprom", .data = &sc7180_qfprom},
 	{ .compatible = "qcom,sc7280-qfprom", .data = &sc7280_qfprom},
 	{/* sentinel */},
--
2.17.1

