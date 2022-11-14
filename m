Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D056282FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiKNOmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiKNOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:41:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBAD65F3;
        Mon, 14 Nov 2022 06:41:17 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEEJRDT030441;
        Mon, 14 Nov 2022 14:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=zSm/tCiWDz8IwwowFawgSF9n7YJ3Rhu0te7oRoRDPgw=;
 b=LtwGKyq/Dve35pj7AJ6LBbDLnNhD289YWMsH1154scttMqkKSYwhwMKBJpvJUmVHkBiE
 g5m3o8zYj0NnJcHGPPAT/OpYuZmBnAsuNmqQEC4htlZu87DQgUQMBhG/RgQgyc0E9JQ0
 sX+iUtWieQqlDnJn6N0KHKkuQ3U4GLrmY13fOJ9aKRw3y5a6a5gTkh/W39tyTUdbXGfP
 4SlIhRdjRKjam/tZwgpGFC2a/Yb/5G1ptm0PX91LJzo3LaOvtAlZinuIuBHxZVtyItU4
 fVyEAyxo6Q6FYJv3kIzIfbHeaxrnXf/x0nCGSJ6KVJ2PPOvNTCv88vLVJc0fpoOEZp56 gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kuccw1m7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:41:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEEf7Je002671
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:41:07 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 06:41:03 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v15 4/8] coresight-tpdm: Add DSB dataset support
Date:   Mon, 14 Nov 2022 22:40:23 +0800
Message-ID: <20221114144027.14365-5-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114144027.14365-1-quic_jinlmao@quicinc.com>
References: <20221114144027.14365-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f37wys-l8Cya5SQoCo_EmO9fQmt44Czn
X-Proofpoint-ORIG-GUID: f37wys-l8Cya5SQoCo_EmO9fQmt44Czn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPDM serves as data collection component for various dataset types.
DSB(Discrete Single Bit) is one of the dataset types. DSB subunit
can be enabled for data collection by writing 1 to the first bit of
DSB_CR register. This change is to add enable/disable function for
DSB dataset by writing DSB_CR register.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 56 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h | 22 ++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 6f9a136b2c3f..f6d653a45c99 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -20,7 +20,28 @@
 
 DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
 
+static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
+{
+	u32 val;
+
+	/* Set the enable bit of DSB control register to 1 */
+	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+	val |= TPDM_DSB_CR_ENA;
+	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
+}
+
 /* TPDM enable operations */
+static void __tpdm_enable(struct tpdm_drvdata *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	/* Check if DSB datasets is present for TPDM. */
+	if (drvdata->datasets & TPDM_PIDR0_DS_DSB)
+		tpdm_enable_dsb(drvdata);
+
+	CS_LOCK(drvdata->base);
+}
+
 static int tpdm_enable(struct coresight_device *csdev,
 		       struct perf_event *event, u32 mode)
 {
@@ -32,6 +53,7 @@ static int tpdm_enable(struct coresight_device *csdev,
 		return -EBUSY;
 	}
 
+	__tpdm_enable(drvdata);
 	drvdata->enable = true;
 	spin_unlock(&drvdata->spinlock);
 
@@ -39,7 +61,28 @@ static int tpdm_enable(struct coresight_device *csdev,
 	return 0;
 }
 
+static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
+{
+	u32 val;
+
+	/* Set the enable bit of DSB control register to 0 */
+	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+	val &= ~TPDM_DSB_CR_ENA;
+	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
+}
+
 /* TPDM disable operations */
+static void __tpdm_disable(struct tpdm_drvdata *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	/* Check if DSB datasets is present for TPDM. */
+	if (drvdata->datasets & TPDM_PIDR0_DS_DSB)
+		tpdm_disable_dsb(drvdata);
+
+	CS_LOCK(drvdata->base);
+}
+
 static void tpdm_disable(struct coresight_device *csdev,
 			 struct perf_event *event)
 {
@@ -51,6 +94,7 @@ static void tpdm_disable(struct coresight_device *csdev,
 		return;
 	}
 
+	__tpdm_disable(drvdata);
 	drvdata->enable = false;
 	spin_unlock(&drvdata->spinlock);
 
@@ -66,6 +110,17 @@ static const struct coresight_ops tpdm_cs_ops = {
 	.source_ops	= &tpdm_source_ops,
 };
 
+static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
+{
+	u32 pidr;
+
+	CS_UNLOCK(drvdata->base);
+	/*  Get the datasets present on the TPDM. */
+	pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
+	drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
+	CS_LOCK(drvdata->base);
+}
+
 static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	void __iomem *base;
@@ -107,6 +162,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(drvdata->csdev);
 
 	spin_lock_init(&drvdata->spinlock);
+	tpdm_init_default_data(drvdata);
 	/* Decrease pm refcount when probe is done.*/
 	pm_runtime_put(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index c87b982d963e..c8a101cbb4c7 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -6,6 +6,26 @@
 #ifndef _CORESIGHT_CORESIGHT_TPDM_H
 #define _CORESIGHT_CORESIGHT_TPDM_H
 
+/* The max number of the datasets that TPDM supports */
+#define TPDM_DATASETS       7
+
+/* DSB Subunit Registers */
+#define TPDM_DSB_CR		(0x780)
+/* Enable bit for DSB subunit */
+#define TPDM_DSB_CR_ENA		BIT(0)
+
+/**
+ * The bits of PERIPHIDR0 register.
+ * The fields [6:0] of PERIPHIDR0 are used to determine what
+ * interfaces and subunits are present on a given TPDM.
+ *
+ * PERIPHIDR0[0] : Fix to 1 if ImplDef subunit present, else 0
+ * PERIPHIDR0[1] : Fix to 1 if DSB subunit present, else 0
+ */
+
+#define TPDM_PIDR0_DS_IMPDEF	BIT(0)
+#define TPDM_PIDR0_DS_DSB	BIT(1)
+
 /**
  * struct tpdm_drvdata - specifics associated to an TPDM component
  * @base:       memory mapped base address for this component.
@@ -13,6 +33,7 @@
  * @csdev:      component vitals needed by the framework.
  * @spinlock:   lock for the drvdata value.
  * @enable:     enable status of the component.
+ * @datasets:   The datasets types present of the TPDM.
  */
 
 struct tpdm_drvdata {
@@ -21,6 +42,7 @@ struct tpdm_drvdata {
 	struct coresight_device	*csdev;
 	spinlock_t		spinlock;
 	bool			enable;
+	unsigned long		datasets;
 };
 
 #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
-- 
2.17.1

