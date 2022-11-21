Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2274E631B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiKUIW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiKUIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:22:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC20614B;
        Mon, 21 Nov 2022 00:22:43 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL7RfeS009800;
        Mon, 21 Nov 2022 08:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qjqKdTF2+9L1NB3S7ZiAHfWqzeK71lUia3Hi7BE/dmM=;
 b=mDzEAUdEUnzn4nsLQdBdZKBBzkIMkbNt/CQcHuMSD5QwPqzcvE0ymfzx8wDUfLUCBTJ1
 u0FIys7zVRzUkKNgc2yo966SARQMbifbg0WPhAMV3ES/ikAwG54WWqntSK63K30bhiwn
 u1WuctjQxqGXTG5Bep8r6ypPhdnCapb+sYFRbEzmbglXZiY23BYqedMFDF+5ArzY22cV
 Mz9VQTB9lPIKImSzKFt26FbZ0OLxFuiwCeB9+APvhBfHFP/6qYPJ/yGSuLVN56iwQoKo
 LYcJIdhfmGFE/lHXFtCFZ1jZlGhinyaHJyUUhcTkJWgnk8T8BJ26HkxHFa3VSvXU6DG3 0w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrpb3vu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:22:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AL8MWOe016763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:22:32 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 00:22:26 -0800
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
Subject: [PATCH v1 3/9] coresight-tpdm: Initialize DSB subunit configuration
Date:   Mon, 21 Nov 2022 16:21:07 +0800
Message-ID: <1669018873-4718-4-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669018873-4718-1-git-send-email-quic_taozha@quicinc.com>
References: <1669018873-4718-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BT-Ni5xocC-BkUtKAvmt6vVz__iMyqtt
X-Proofpoint-GUID: BT-Ni5xocC-BkUtKAvmt6vVz__iMyqtt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_05,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211210065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSB subunit need to be configured in enablement and disablement.
A struct that specifics associated to dsb dataset is needed. It
saves the configuration and parameters of the dsb datasets. This
change is to add this struct and initialize the configuration of
DSB subunit.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 57 ++++++++++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tpdm.h | 17 +++++++++
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 88df3e6..60de21d 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -24,13 +24,35 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val;
 
+	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
+	/* Set trigger timestamp */
+	if (drvdata->dsb->trig_ts)
+		val |= TPDM_DSB_XTRIG_TSENAB;
+	else
+		val &= ~TPDM_DSB_XTRIG_TSENAB;
+	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
+
+	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+	/* Set trigger type */
+	if (drvdata->dsb->trig_type)
+		val |= TPDM_DSB_TRIG_TYPE;
+	else
+		val &= ~TPDM_DSB_TRIG_TYPE;
+	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
+
 	/* Set the enable bit of DSB control register to 1 */
 	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
 	val |= TPDM_DSB_CR_ENA;
 	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
 }
 
-/* TPDM enable operations */
+/* TPDM enable operations
+ * The TPDM or Monitor serves as data collection component for various
+ * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
+ * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
+ * Bit(DSB). This function will initialize the configuration according
+ * to the dataset type supported by the TPDM.
+ */
 static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
@@ -110,15 +132,33 @@ static const struct coresight_ops tpdm_cs_ops = {
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
+}
+
+static int tpdm_datasets_alloc(struct tpdm_drvdata *drvdata)
+{
+	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
+		drvdata->dsb = devm_kzalloc(drvdata->dev, sizeof(*drvdata->dsb),
+					    GFP_KERNEL);
+		if (!drvdata->dsb)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
+{
+	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
+		drvdata->dsb->trig_ts = true;
+		drvdata->dsb->trig_type = false;
+	}
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
@@ -216,7 +259,13 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(drvdata->csdev);
 
 	spin_lock_init(&drvdata->spinlock);
+	ret = tpdm_datasets_alloc(drvdata);
+	if (ret) {
+		coresight_unregister(drvdata->csdev);
+		return ret;
+	}
 	tpdm_init_default_data(drvdata);
+
 	/* Decrease pm refcount when probe is done.*/
 	pm_runtime_put(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index d808fa1..dd4a013 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -11,8 +11,14 @@
 
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
+#define TPDM_DSB_TIER		(0x784)
+
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
+/* Enable bit for DSB subunit trigger timestamp */
+#define TPDM_DSB_XTRIG_TSENAB		BIT(1)
+/* Enable bit for DSB subunit trigger type */
+#define TPDM_DSB_TRIG_TYPE		BIT(12)
 
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

