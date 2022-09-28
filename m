Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7775EDCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiI1M3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiI1M3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:29:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93CF925B2;
        Wed, 28 Sep 2022 05:29:22 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SCRVl1023037;
        Wed, 28 Sep 2022 12:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=wQLJt/4AfEbF8qWTSB77diKqqtlCNfgXesF14oyIVmA=;
 b=WnbXXk6GYe+/n2ItQP9EI9I5NHKAj3fVGCKecE+YA4KaPEcKZ/2/KZnPRb7W9IQTcCiK
 CtbpSKdtrS9OMII5tDvZ3FhvWXHxu1yOEtuAH2frWEOASMnq1+b28GeymWdSr+vV9tGA
 IMFs8pcJW9Hh4IehZbbGajF75vfFgJAWg7uxGwUQRIKE+2bicQNGEG53g2mgvLLdZkL2
 cuMvVwLjlAnqD5NQVRfhqneAAaRwdsZZj/j8Q+zmLWtwv8sXhqnAoAKCbl67ssdnlkX6
 IZssRFFdTVjeFny5ZSa42JUsDhtJiCqg16v3DvzA0xfJJfki3vsXfcLOHFM6qnOPiYyp ww== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvm7587cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 12:28:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SCSg6c001285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 12:28:42 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 05:28:36 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v10 4/7] remoteproc: qcom: Update rproc parse firmware callback
Date:   Wed, 28 Sep 2022 17:57:50 +0530
Message-ID: <1664368073-13659-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664368073-13659-1-git-send-email-quic_srivasam@quicinc.com>
References: <1664368073-13659-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5b4tKzt1ao5x3uQ7VWxUaXr3tAIj1LKD
X-Proofpoint-GUID: 5b4tKzt1ao5x3uQ7VWxUaXr3tAIj1LKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_05,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change parse_fw callback in rproc ops from qcom_register_dump_segments
to local function such that, it can perform coredump segments registration
and it can parse section header in memory sandboxing required platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
Changes since V6:
	-- Update parse firmware callback.

 drivers/remoteproc/qcom_q6v5_adsp.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 14a3864..b8cbbf7 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -439,6 +439,27 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iom
 	return adsp->mem_region + offset;
 }
 
+static int adsp_parse_firmware(struct rproc *rproc, const struct firmware *fw)
+{
+	struct qcom_adsp *adsp = rproc->priv;
+	int ret;
+
+	ret = qcom_register_dump_segments(rproc, fw);
+	if (ret) {
+		dev_err(&rproc->dev, "Error in registering dump segments\n");
+		return ret;
+	}
+
+	if (adsp->has_iommu) {
+		ret = rproc_elf_load_rsc_table(rproc, fw);
+		if (ret) {
+			dev_err(&rproc->dev, "Error in loading resource table\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
 static unsigned long adsp_panic(struct rproc *rproc)
 {
 	struct qcom_adsp *adsp = rproc->priv;
@@ -450,7 +471,7 @@ static const struct rproc_ops adsp_ops = {
 	.start = adsp_start,
 	.stop = adsp_stop,
 	.da_to_va = adsp_da_to_va,
-	.parse_fw = qcom_register_dump_segments,
+	.parse_fw = adsp_parse_firmware,
 	.load = adsp_load,
 	.panic = adsp_panic,
 };
-- 
2.7.4

