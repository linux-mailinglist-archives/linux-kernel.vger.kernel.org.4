Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66666C5F61
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjCWGFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCWGFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:05:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39FF26C28;
        Wed, 22 Mar 2023 23:05:09 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4MWs7013989;
        Thu, 23 Mar 2023 06:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QjybkIAfXvZpkJLA5qMBvRVaX7V7xv12+llA4avH+M4=;
 b=QPrBzjFRFrJkQjoqVIXdB6jz3ApqxmvAGXdcMWgqdPjLSm8bhs+SlDRJb38vuDaPDDEx
 xcBc+bp7QisYgY1kmKH2v6zTU8oIdsdjcxgyRy5HC0lfDS5sus5ik+6DlGsAK4PgoCft
 w5usmIQGP2yu6NseGINKx0rCziUkbzQlPqBSLuzdx15F0Ah+upX2yJpPMZyH/oF0T2DO
 f1BhyVExQRMKQcw8AKGlzm0K1DfDDqnVPNI08d80OJtjYFfULTRRNGBv9IWfUnBmIDMJ
 RdV2Lkk8jHwnpzu8Eb5ek6Z/GXpz5/aKxfE/2vh0b3rPmcAfAPo1CmMPaCL0rZtSiLXq HQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg64k1ejb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:04:51 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N64nx4015000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:04:49 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 23:04:44 -0700
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
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
Subject: [PATCH v3 03/11] coresight-tpdm: Initialize DSB subunit configuration
Date:   Thu, 23 Mar 2023 14:04:00 +0800
Message-ID: <1679551448-19160-4-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0LYA1bwb7D1qOR1jZmlvYLMlcBm7W8Dj
X-Proofpoint-ORIG-GUID: 0LYA1bwb7D1qOR1jZmlvYLMlcBm7W8Dj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230045
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSB is used for monitoring “events”. Events are something that
occurs at some point in time. It could be a state decode, the
act of writing/reading a particular address, a FIFO being empty,
etc. This decoding of the event desired is done outside TPDM.
DSB subunit need to be configured in enablement and disablement.
A struct that specifics associated to dsb dataset is needed. It
saves the configuration and parameters of the dsb datasets. This
change is to add this struct and initialize the configuration of
DSB subunit.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 58 +++++++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tpdm.h | 17 ++++++++
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index f4854af..5e1e2ba 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -20,17 +20,59 @@
 
 DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
 
+static int tpdm_init_datasets(struct tpdm_drvdata *drvdata)
+{
+	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
+		if (!drvdata->dsb) {
+			drvdata->dsb = devm_kzalloc(drvdata->dev,
+						    sizeof(*drvdata->dsb), GFP_KERNEL);
+			if (!drvdata->dsb)
+				return -ENOMEM;
+		} else
+			memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
+
+		drvdata->dsb->trig_ts = true;
+		drvdata->dsb->trig_type = false;
+	}
+
+	return 0;
+}
+
+static void set_trigger_type(struct tpdm_drvdata *drvdata, u32 *val)
+{
+	if (drvdata->dsb->trig_type)
+		*val |= TPDM_DSB_CR_TRIG_TYPE;
+	else
+		*val &= ~TPDM_DSB_CR_TRIG_TYPE;
+}
+
 static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val;
 
-	/* Set the enable bit of DSB control register to 1 */
+	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
+	/* Set trigger timestamp */
+	if (drvdata->dsb->trig_ts)
+		val |= TPDM_DSB_TIER_XTRIG_TSENAB;
+	else
+		val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
+	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
+
 	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+	/* Set trigger type */
+	set_trigger_type(drvdata, &val);
+	/* Set the enable bit of DSB control register to 1 */
 	val |= TPDM_DSB_CR_ENA;
 	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
 }
 
 /* TPDM enable operations */
+/* The TPDM or Monitor serves as data collection component for various
+ * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
+ * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
+ * Bit(DSB). This function will initialize the configuration according
+ * to the dataset type supported by the TPDM.
+ */
 static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
@@ -110,15 +152,13 @@ static const struct coresight_ops tpdm_cs_ops = {
 	.source_ops	= &tpdm_source_ops,
 };
 
-static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
+static void tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
 {
 	u32 pidr;
 
-	CS_UNLOCK(drvdata->base);
 	/*  Get the datasets present on the TPDM. */
 	pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
 	drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
-	CS_LOCK(drvdata->base);
 }
 
 /*
@@ -181,6 +221,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct coresight_platform_data *pdata;
 	struct tpdm_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
+	int ret;
 
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
@@ -200,6 +241,8 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	drvdata->base = base;
 
+	tpdm_datasets_setup(drvdata);
+
 	/* Set up coresight component description */
 	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
 	if (!desc.name)
@@ -216,7 +259,12 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(drvdata->csdev);
 
 	spin_lock_init(&drvdata->spinlock);
-	tpdm_init_default_data(drvdata);
+	ret = tpdm_init_datasets(drvdata);
+	if (ret) {
+		coresight_unregister(drvdata->csdev);
+		return ret;
+	}
+
 	/* Decrease pm refcount when probe is done.*/
 	pm_runtime_put(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 5438540..68f33bd 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -11,8 +11,14 @@
 
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
+#define TPDM_DSB_TIER		(0x784)
+
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
+/* Enable bit for DSB subunit trigger type */
+#define TPDM_DSB_CR_TRIG_TYPE		BIT(12)
+/* Enable bit for DSB subunit trigger timestamp */
+#define TPDM_DSB_TIER_XTRIG_TSENAB		BIT(1)
 
 /* TPDM integration test registers */
 #define TPDM_ITATBCNTRL		(0xEF0)
@@ -41,6 +47,16 @@
 #define TPDM_PIDR0_DS_DSB	BIT(1)
 
 /**
+ * struct dsb_dataset - specifics associated to dsb dataset
+ * @trig_ts:          Enable/Disable trigger timestamp.
+ * @trig_type:        Enable/Disable trigger type.
+ */
+struct dsb_dataset {
+	bool			trig_ts;
+	bool			trig_type;
+};
+
+/**
  * struct tpdm_drvdata - specifics associated to an TPDM component
  * @base:       memory mapped base address for this component.
  * @dev:        The device entity associated to this component.
@@ -57,6 +73,7 @@ struct tpdm_drvdata {
 	spinlock_t		spinlock;
 	bool			enable;
 	unsigned long		datasets;
+	struct dsb_dataset	*dsb;
 };
 
 #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
-- 
2.7.4

