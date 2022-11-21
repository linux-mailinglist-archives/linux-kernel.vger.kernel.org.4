Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8BC631B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKUIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKUIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:23:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22411473;
        Mon, 21 Nov 2022 00:23:11 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL4ImMn008918;
        Mon, 21 Nov 2022 08:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=VjROx97eEj4irAGrUO8O5pNis2tNTi+iu+TwHJhkuSQ=;
 b=YTmInukLmTIe4+CzmxWnw9l1pC/s3wTdfPV9B5v39+7QrOEyvCPhLf5MmAjOQl9wBM5O
 7z2OEDXa2A94CbUL0CPhQ85Wxwx4vAOnrBeM6+FlmCTMXzknDyGtTb3vryy1RNBsXynp
 ZFMCfrNiGzAUT2NNcU71W3jAS0Vfq1yeyfrpnMuxSbsBv3Qte9Wg5429MZoxwfvi2SpU
 a7D8+hz2XYaqxBJWTCWG4Cn5lw0hIOW5IsRuMHyk1oNDdBGxrDEiF3RmyW/WicLtNxXd
 rDCIfW0OP1+5Chv+TH1QFl8eWh8A8/Pdu4kOd/N90FSkYA3sMj3+RhfVqBBlhPPW74Sm RQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrtqbtk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:23:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AL8N0sQ024586
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:23:00 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 00:22:56 -0800
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
Subject: [PATCH v1 9/9] coresight-tpdm: Add nodes for timestamp request
Date:   Mon, 21 Nov 2022 16:21:13 +0800
Message-ID: <1669018873-4718-10-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 86mPlXtu-2T6AQBzTEssaKoDiT9hG4jS
X-Proofpoint-GUID: 86mPlXtu-2T6AQBzTEssaKoDiT9hG4jS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_05,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes to configure the timestamp request based on input
pattern match. Each TPDM that support DSB subunit has maximum of
n(n<7) TPR registers to configure value for timestamp request
based on input pattern match. Eight 32 bit registers providing
DSB interface timestamp request  pattern match comparison. And
each TPDM that support DSB subunit has maximum of m(m<7) TPMR
registers to configure pattern mask for timestamp request. Eight
32 bit registers providing DSB interface timestamp request
pattern match mask generation. Add nodes to enable/disable
pattern timestamp and set pattern timestamp type.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 174 +++++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h |  14 +++
 2 files changed, 188 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 2a0b8ed..1cc9eb0 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -49,6 +49,13 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 			   drvdata->base + TPDM_DSB_EDCMR(i));
 
 	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		writel_relaxed(drvdata->dsb->patt_val[i],
+			    drvdata->base + TPDM_DSB_TPR(i));
+		writel_relaxed(drvdata->dsb->patt_mask[i],
+			    drvdata->base + TPDM_DSB_TPMR(i));
+	}
+
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
 		writel_relaxed(drvdata->dsb->trig_patt_val[i],
 			    drvdata->base + TPDM_DSB_XPR(i));
 		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
@@ -56,6 +63,16 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 	}
 
 	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
+	/* Set pattern timestamp type and enablement */
+	if (drvdata->dsb->patt_ts) {
+		val |= TPDM_DSB_PATT_TSENAB;
+		if (drvdata->dsb->patt_type)
+			val |= TPDM_DSB_PATT_TYPE;
+		else
+			val &= ~TPDM_DSB_PATT_TYPE;
+	} else {
+		val &= ~TPDM_DSB_PATT_TSENAB;
+	}
 	/* Set trigger timestamp */
 	if (drvdata->dsb->trig_ts)
 		val |= TPDM_DSB_XTRIG_TSENAB;
@@ -444,6 +461,159 @@ static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
 
+static ssize_t dsb_patt_val_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		size += sysfs_emit_at(buf, size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->dsb->patt_val[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+/*
+ * value 1: Index of TPR register
+ * value 2: Value need to be written
+ */
+static ssize_t dsb_patt_val_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (index >= TPDM_DSB_MAX_PATT)
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->dsb->patt_val[index] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_patt_val);
+
+static ssize_t dsb_patt_mask_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		size += sysfs_emit_at(buf, size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->dsb->patt_mask[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+/*
+ * value 1: Index of TPMR register
+ * value 2: Value need to be written
+ */
+static ssize_t dsb_patt_mask_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (index >= TPDM_DSB_MAX_PATT)
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->dsb->patt_mask[index] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_patt_mask);
+
+static ssize_t dsb_patt_ts_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			 (unsigned int)drvdata->dsb->patt_ts);
+}
+
+/*
+ * value 1: Enable/Disable DSB pattern timestamp
+ */
+static ssize_t dsb_patt_ts_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->dsb->patt_ts = true;
+	else
+		drvdata->dsb->patt_ts = false;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_patt_ts);
+
+static ssize_t dsb_patt_type_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+
+	return sysfs_emit(buf, "%u\n",
+			 (unsigned int)drvdata->dsb->patt_type);
+}
+
+/*
+ * value 1: Set DSB pattern type
+ */
+static ssize_t dsb_patt_type_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->dsb->patt_type = true;
+	else
+		drvdata->dsb->patt_type = false;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_patt_type);
+
 static ssize_t dsb_trig_patt_val_show(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
@@ -593,6 +763,10 @@ static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_edge_ctrl.attr,
 	&dev_attr_dsb_edge_ctrl_mask.attr,
+	&dev_attr_dsb_patt_val.attr,
+	&dev_attr_dsb_patt_mask.attr,
+	&dev_attr_dsb_patt_ts.attr,
+	&dev_attr_dsb_patt_type.attr,
 	&dev_attr_dsb_trig_patt_val.attr,
 	&dev_attr_dsb_trig_patt_mask.attr,
 	&dev_attr_dsb_trig_ts.attr,
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 386a0e5..fa550f3 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -12,6 +12,8 @@
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
+#define TPDM_DSB_TPR(n)		(0x788 + (n * 4))
+#define TPDM_DSB_TPMR(n)	(0x7A8 + (n * 4))
 #define TPDM_DSB_XPR(n)		(0x7C8 + (n * 4))
 #define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
 #define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
@@ -19,8 +21,12 @@
 
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
+/* Enable bit for DSB subunit pattern timestamp */
+#define TPDM_DSB_PATT_TSENAB		BIT(0)
 /* Enable bit for DSB subunit trigger timestamp */
 #define TPDM_DSB_XTRIG_TSENAB		BIT(1)
+/* Bit for DSB subunit pattern type */
+#define TPDM_DSB_PATT_TYPE		BIT(2)
 /* Enable bit for DSB subunit trigger type */
 #define TPDM_DSB_TRIG_TYPE		BIT(12)
 /* Enable bit for DSB subunit perfmance mode */
@@ -75,6 +81,10 @@
  * @mode:             DSB programming mode
  * @edge_ctrl:        Save value for edge control
  * @edge_ctrl_mask:   Save value for edge control mask
+ * @patt_val:         Save value for pattern
+ * @patt_mask:        Save value for pattern mask
+ * @patt_ts:          Enable/Disable pattern timestamp
+ * @patt_type:        Set pattern type
  * @trig_patt_val:    Save value for trigger pattern
  * @trig_patt_mask:   Save value for trigger pattern mask
  * @trig_ts:          Enable/Disable trigger timestamp.
@@ -84,6 +94,10 @@ struct dsb_dataset {
 	u32				mode;
 	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
 	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
+	u32				patt_val[TPDM_DSB_MAX_PATT];
+	u32				patt_mask[TPDM_DSB_MAX_PATT];
+	bool			patt_ts;
+	bool			patt_type;
 	u32				trig_patt_val[TPDM_DSB_MAX_PATT];
 	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
 	bool			trig_ts;
-- 
2.7.4

