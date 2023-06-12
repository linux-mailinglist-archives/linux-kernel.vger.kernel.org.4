Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00DC72B9DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjFLIKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjFLIKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:10:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B54C0;
        Mon, 12 Jun 2023 01:10:00 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C57E7Q009309;
        Mon, 12 Jun 2023 07:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=mcHkfg4Mfqa89aDgB0OvEW5s0d+aFsZu3ljZvfu2q2Q=;
 b=RwK6v+2tde3GX2X5OE7pWJ0eIN0D6espJK5A38kyJbDgl7k9W2PUDNw2ws1Yg0wX4bY5
 G6SjrDjIMfSXImT18vOGcpl2alvQ724Z4JlXiTVUTuGYTWKl6XIyMuMusqhAm5Tobn9z
 MLZeMPnaJAdAaKW8QlgY+Vf1iutuuMX5pY7oYmiYjLWAgLLwbiAQSJSoS0l7X4RC6CJp
 TqHsB7AUHKR5svJgn5NlkPSPUwP5DCRv7hc3R4fnA2F1ivGcpXeOwOuRPxafH+3Krv/A
 ktzUZb6pDMSHMHSYT9fAGeAGi2Qn4VAHC3gRjv/MFdGFGsAmXMkmXwmktlGzrfDjf36r Rg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r4hjbtk05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 07:08:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35C78TXv020382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 07:08:29 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 00:08:23 -0700
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
Subject: [PATCH v5 03/13] coresight-tpdm: Introduce TPDM subtype to TPDM driver
Date:   Mon, 12 Jun 2023 15:07:36 +0800
Message-ID: <1686553666-5811-4-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686553666-5811-1-git-send-email-quic_taozha@quicinc.com>
References: <1686553666-5811-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Bo4fJ7mEZnRGFBO5j1GWzJLbNvqswe2Q
X-Proofpoint-GUID: Bo4fJ7mEZnRGFBO5j1GWzJLbNvqswe2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_04,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=931
 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the new subtype of "CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM"
for TPDM components in driver.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 1 +
 drivers/hwtracing/coresight/coresight-tpdm.c | 2 +-
 include/linux/coresight.h                    | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 118fcf2..23b18c2 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1093,6 +1093,7 @@ static int coresight_validate_source(struct coresight_device *csdev,
 
 	if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
 	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
+		subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
 	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
 		dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
 		return -EINVAL;
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index b645612..abaff0b 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -203,7 +203,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!desc.name)
 		return -ENOMEM;
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
-	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
+	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM;
 	desc.ops = &tpdm_cs_ops;
 	desc.pdata = adev->dev.platform_data;
 	desc.dev = &adev->dev;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 949aa24..29cd6d8 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -61,6 +61,7 @@ enum coresight_dev_subtype_source {
 	CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
 	CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
 	CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
+	CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM,
 	CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS,
 };
 
-- 
2.7.4

