Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3A6CD528
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjC2ItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjC2Ish (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:48:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24850270B;
        Wed, 29 Mar 2023 01:48:30 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T5EcU3010496;
        Wed, 29 Mar 2023 08:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=TzK5i/ajuvHn0kJ11FDgKqTnpNjR94m2w+KYenxBxS4=;
 b=nYhOBIXqcAAiyKfNX+UZRqiOnw58qrJ1DpipILhREgwpBezBwCuDKCqNTbxEPLoZWPiO
 51yhr3r50SH4pFFSDPlXT8XYguUJf0BR+QKELqQDFIdNvCLpJmNLjjztXXliiMhampdO
 XxOvJkerYsF1tIG7vaLtiZDpY9R6Qoxz0mWhLphQdUql+w9OhPAg51ho1pMSZgymhJ0u
 naQwJXcxb7bQA+/4aoQhjy1UnrViHycTw3FzS2Ne1ds9SqdKKaeWipQXTIbVoxK/8ma7
 YhBiz8I2//U13675jxIf4zLrSSKwXQapflK0iiOkUssaFGMG5l7U4CDUI96DiejZfDV3 +w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmbs88skc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T8lvUr031340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:57 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 29 Mar 2023 01:47:56 -0700
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
Subject: [PATCH v1 1/8] coresight-tpdm: Add CMB dataset support
Date:   Wed, 29 Mar 2023 01:47:37 -0700
Message-ID: <20230329084744.5705-2-quic_jinlmao@quicinc.com>
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
X-Proofpoint-ORIG-GUID: TnV_6cR8QRKoe7Li3qhZoMCUuh4BB-Xb
X-Proofpoint-GUID: TnV_6cR8QRKoe7Li3qhZoMCUuh4BB-Xb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290071
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMB (continuous multi-bit) is one of TPDM's dataset type. CMB subunit
can be enabled for data collection by writing 1 to the first bit of
CMB_CR register. This change is to add enable/disable function for
CMB dataset by writing CMB_CR register.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 30 ++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tpdm.h |  9 ++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 3240bc4a8b30..d92432329c9c 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -149,6 +149,17 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
 }
 
+static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
+{
+	u32 val;
+
+	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
+	val |= TPDM_CMB_CR_ENA;
+
+	/* Set the enable bit of CMB control register to 1 */
+	writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
+}
+
 /* TPDM enable operations */
 /* The TPDM or Monitor serves as data collection component for various
  * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
@@ -160,9 +171,11 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	/* Check if DSB datasets is present for TPDM. */
+	/* Enable dataset packets */
 	if (drvdata->datasets & TPDM_PIDR0_DS_DSB)
 		tpdm_enable_dsb(drvdata);
+	if (drvdata->datasets & TPDM_PIDR0_DS_CMB)
+		tpdm_enable_cmb(drvdata);
 
 	CS_LOCK(drvdata->base);
 }
@@ -196,14 +209,27 @@ static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
 	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
 }
 
+static void tpdm_disable_cmb(struct tpdm_drvdata *drvdata)
+{
+	u32 val;
+
+	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
+	val &= ~TPDM_CMB_CR_ENA;
+
+	/* Set the enable bit of CMB control register to 0 */
+	writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
+}
+
 /* TPDM disable operations */
 static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	/* Check if DSB datasets is present for TPDM. */
+	/* Disable dataset packet */
 	if (drvdata->datasets & TPDM_PIDR0_DS_DSB)
 		tpdm_disable_dsb(drvdata);
+	if (drvdata->datasets & TPDM_PIDR0_DS_CMB)
+		tpdm_disable_cmb(drvdata);
 
 	CS_LOCK(drvdata->base);
 }
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 355a499635c2..4c065a4b8a75 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -9,6 +9,13 @@
 /* The max number of the datasets that TPDM supports */
 #define TPDM_DATASETS       7
 
+/* CMB Subunit Registers*/
+/*CMB subunit global control register*/
+#define TPDM_CMB_CR		(0xA00)
+
+/* Enable bit for CMB subunit */
+#define TPDM_CMB_CR_ENA		BIT(0)
+
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
@@ -65,10 +72,12 @@
  *
  * PERIPHIDR0[0] : Fix to 1 if ImplDef subunit present, else 0
  * PERIPHIDR0[1] : Fix to 1 if DSB subunit present, else 0
+ * PERIPHIDR0[2] : Fix to 1 if CMB subunit present, else 0
  */
 
 #define TPDM_PIDR0_DS_IMPDEF	BIT(0)
 #define TPDM_PIDR0_DS_DSB	BIT(1)
+#define TPDM_PIDR0_DS_CMB	BIT(2)
 
 #define TPDM_DSB_MAX_LINES	256
 /* MAX number of EDCR registers */
-- 
2.39.0

