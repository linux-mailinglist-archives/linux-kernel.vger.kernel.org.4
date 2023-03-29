Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875EA6CD51A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjC2Is2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjC2IsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:48:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E9A1721;
        Wed, 29 Mar 2023 01:48:20 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T6Bnqx030838;
        Wed, 29 Mar 2023 08:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Hizfx70K2+XOLPTpvFYRBuhNI+gaFxVSY3aWlzR3sd0=;
 b=kCRIwlwsDOjMe4lnB+iIKZ+FNdl4xaRUSrzarvC8mVpoODUTrMWK+I/HFBmI2IzWxMnP
 zC0uC5BzuvRdccKa4pWcgQAIIBeAg2ZmvdYmm9kqx2VxwhF3tFXb3WbhISmJI9ZLoeOI
 6uzJhXnyKJTKDEuL584WuoMv07r/jaWoseLEnqC9GrVyHgDEW2sbwlU5dK8LZ0SEk/sO
 WZA9JYBssGsa/2bJNqcZmTXJNVPIf82MtzC6WFJKxpXdlKlGslPvJ7E+/cvCPtTFshsP
 yqNWdsuFwpuZDoDpMGpGNuLoakbKyuqjiaXFUF3A0I2aCfm+jsBFIL4qT2kAI54vQNcI ow== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pm6k81d3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T8lxLf031756
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:59 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 29 Mar 2023 01:47:58 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v1 7/8] coresight-tpda: Add support to configure CMB element size
Date:   Wed, 29 Mar 2023 01:47:43 -0700
Message-ID: <20230329084744.5705-8-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230329084744.5705-1-quic_jinlmao@quicinc.com>
References: <20230329084744.5705-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TsQUo688sPHWPk05tQhkPEbxFpcM8DZ_
X-Proofpoint-GUID: TsQUo688sPHWPk05tQhkPEbxFpcM8DZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=911 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303290071
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the CMB element size from the device tree. Set the register
bit that controls the CMB element size of the corresponding port.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 33 +++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tpda.h |  4 +++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index a620a51e861a..c2ce62e769ea 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -42,11 +42,12 @@ static int tpda_set_element_size(struct tpda_drvdata *drvdata,
 				continue;
 		}
 		if (in_csdev && strstr(dev_name(&in_csdev->dev), "tpdm")) {
-			if (!of_property_read_u32(in_csdev->dev.parent->of_node,
-					"qcom,dsb-elemenet-size", &drvdata->dsb_esize[nr_inport]))
-				break;
-			dev_err(drvdata->dev, "Fail to get data set element size\n");
-			return -EINVAL;
+			of_property_read_u32(in_csdev->dev.parent->of_node,
+					"qcom,dsb-elemenet-size", &drvdata->dsb_esize[nr_inport]);
+			of_property_read_u8(in_csdev->dev.parent->of_node,
+					"qcom,cmb-elemenet-size", &drvdata->cmb_esize[nr_inport]);
+
+			break;
 		}
 		tpda_set_element_size(drvdata, in_csdev, 0);
 	}
@@ -82,6 +83,28 @@ static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
 	else
 		dev_err(drvdata->dev,
 			"DSB data size input from port[%d] is invalid\n", port);
+
+	/*
+	 * Configure aggregator port n CMB data set element size
+	 * Set the bit to 0 if the size is 8
+	 * Set the bit to 1 if the size is 32
+	 * Set the bit to 1 if the size is 64
+	 */
+	if (drvdata->cmb_esize[port] == 8)
+		val &= ~TPDA_Pn_CR_CMBSIZE;
+	else if (drvdata->cmb_esize[port] == 32)
+		val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
+	else if (drvdata->cmb_esize[port] == 32)
+		val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
+	else {
+		/*
+		 * CMB element size is not configured.
+		 * Fall back to 32-bit.
+		 */
+		WARN_ON_ONCE(1);
+		val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
+	}
+
 	/* Enable the port */
 	val |= TPDA_Pn_CR_ENA;
 	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index 9ec5870b5f7c..d5290d21457d 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -12,6 +12,8 @@
 #define TPDA_Pn_CR_ENA		BIT(0)
 /* Aggregator port DSB data set element size bit */
 #define TPDA_Pn_CR_DSBSIZE		BIT(8)
+/* Aggregator port CMB data set element size bit */
+#define TPDA_Pn_CR_CMBSIZE	GENMASK(7, 6)
 
 #define TPDA_MAX_INPORTS	32
 
@@ -26,6 +28,7 @@
  * @spinlock:   lock for the drvdata value.
  * @enable:     enable status of the component.
  * @dsb_esize:   DSB element size
+ * @cmb_esize:	CMB element size. Must be 8, 32 or 64.
  */
 struct tpda_drvdata {
 	void __iomem		*base;
@@ -34,6 +37,7 @@ struct tpda_drvdata {
 	spinlock_t		spinlock;
 	u8			atid;
 	u32			dsb_esize[TPDA_MAX_INPORTS];
+	u8			cmb_esize[TPDA_MAX_INPORTS];
 };
 
 #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
-- 
2.39.0

