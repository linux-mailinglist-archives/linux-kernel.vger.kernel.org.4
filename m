Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3716CD524
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjC2Is7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjC2IsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:48:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE7719AA;
        Wed, 29 Mar 2023 01:48:22 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T4G9Tk032383;
        Wed, 29 Mar 2023 08:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T0RIXA94jq1FwQF0oeAsD0q59AYGX1JGeAtA947i83I=;
 b=nR4KBV5kD2HcQMMOd90HUR9zKShQHwADSdoW5hKo29Dts8v8Qrw/PRFbAwH5JeQEQGPg
 pHznXa6POsio8njFbIPEXEolVqXHssNcvA38Cq4YkqUG7KaOdbi8BnXK0Cj/dnyGp6xY
 t6kHRYJtxl+ALQyW+a/cd7tyhD4m1R1+0DHUUnxxTG9VqD48jaEMCnQjhnIsJo6D/5zd
 04Cm8JNkVP1RppZ5YPfzgLag6FY//sVCoCY8+ZVtHA0YwMSuFtx1W6ozPxg2H6SZIYDX
 NDx1sdyOUtlrF9ND4eRE1Hp6jEsrvfwBl6IT5GgyBA6B+/u5tr2b1G2kSbpqy4IkksZa 9g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmb8h0v93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T8lvg6031501
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:57 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 29 Mar 2023 01:47:57 -0700
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
Subject: [PATCH v1 3/8] coresight-tpdm: Add pattern registers support for CMB data set
Date:   Wed, 29 Mar 2023 01:47:39 -0700
Message-ID: <20230329084744.5705-4-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230329084744.5705-1-quic_jinlmao@quicinc.com>
References: <20230329084744.5705-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: asVZ83vdQpQAOIhT53QyukegyAd3Em1A
X-Proofpoint-GUID: asVZ83vdQpQAOIhT53QyukegyAd3Em1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290071
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timestamps are requested if the monitor’s CMB data set unit input
data matches the value in the Monitor CMB timestamp pattern and mask
registers (M_CMB_TPR and M_CMB_TPMR) when CMB timestamp enabled
via the timestamp insertion enable register bit(CMB_TIER.PATT_TSENAB).
The pattern match trigger output is achieved via setting values into
the CMB trigger pattern and mask registers (CMB_XPR and CMB_XPMR).
After configuring a pattern through these registers, the TPDM subunit
will assert an output trigger every time it receives new input data
that matches the configured pattern value. Values in a given bit
number of the mask register correspond to the same bit number in
the corresponding pattern register.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  |  25 +++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 169 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h  |  19 ++
 3 files changed, 213 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 89051018dd70..4cc22ad5c485 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -163,3 +163,28 @@ Contact:	Jinlong Mao <quic_jinlmao@quicinc.com>
 Description:	(RW) Read or write CMB data collection mode. Only value 0 and 1 can be written to this node.
 		Set to 0 is for continuous CMB collection mode. Set to 1 is for  trace-on-change CMB
 		collection mode.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_patt_mask
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao <quic_jinlmao@quicinc.com>
+Description:	(RW) Read or write CMB timestamp pattern mask.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_patt_val
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao <quic_jinlmao@quicinc.com>
+Description:	(RW) Read or write CMB interface timestamp request pattern match control.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt_mask
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao <quic_jinlmao@quicinc.com>
+Description:	(RW) Read or write the value of CMB subunit trigger pattern mask.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt_val
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao <quic_jinlmao@quicinc.com>
+Description:	(RW) Read or write the value of CMB subunit trigger pattern match.
+
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 68244abfc8b9..05341fa7a6b7 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -176,6 +176,19 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 {
 	u32 val;
+	int i;
+
+	/* Configure pattern registers*/
+	for (i = 0; i < TPDM_CMB_MAX_PATT; i++) {
+		writel_relaxed(drvdata->cmb->patt_val[i],
+			    drvdata->base + TPDM_CMB_TPR(i));
+		writel_relaxed(drvdata->cmb->patt_mask[i],
+			    drvdata->base + TPDM_CMB_TPMR(i));
+		writel_relaxed(drvdata->cmb->trig_patt_val[i],
+			    drvdata->base + TPDM_CMB_XPR(i));
+		writel_relaxed(drvdata->cmb->trig_patt_mask[i],
+			    drvdata->base + TPDM_CMB_XPMR(i));
+	}
 
 	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
 	/*
@@ -883,6 +896,158 @@ static ssize_t cmb_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(cmb_mode);
 
+static ssize_t cmb_patt_val_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_CMB_MAX_PATT; i++) {
+		size += sysfs_emit_at(buf, size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->cmb->patt_val[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+static ssize_t cmb_patt_val_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (index >= TPDM_CMB_MAX_PATT)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->cmb->patt_val[index] = val;
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_patt_val);
+
+static ssize_t cmb_patt_mask_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_CMB_MAX_PATT; i++) {
+		size += sysfs_emit_at(buf, size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->cmb->patt_mask[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+
+}
+
+static ssize_t cmb_patt_mask_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (index >= TPDM_CMB_MAX_PATT)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->cmb->patt_mask[index] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_patt_mask);
+
+static ssize_t cmb_trig_patt_val_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_CMB_MAX_PATT; i++) {
+		size += sysfs_emit_at(buf, size,
+				"Index: 0x%x Value: 0x%x\n", i,
+				drvdata->cmb->trig_patt_val[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+
+static ssize_t cmb_trig_patt_val_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (index >= TPDM_CMB_MAX_PATT)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->cmb->trig_patt_val[index] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_trig_patt_val);
+
+static ssize_t cmb_trig_patt_mask_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_CMB_MAX_PATT; i++) {
+		size += sysfs_emit_at(buf, size,
+				"Index: 0x%x Value: 0x%x\n", i,
+				drvdata->cmb->trig_patt_mask[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+
+static ssize_t cmb_trig_patt_mask_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (index >= TPDM_CMB_MAX_PATT)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->cmb->trig_patt_mask[index] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_trig_patt_mask);
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_edge_ctrl.attr,
@@ -901,6 +1066,10 @@ static struct attribute *tpdm_dsb_attrs[] = {
 
 static struct attribute *tpdm_cmb_attrs[] = {
 	&dev_attr_cmb_mode.attr,
+	&dev_attr_cmb_patt_val.attr,
+	&dev_attr_cmb_patt_mask.attr,
+	&dev_attr_cmb_trig_patt_val.attr,
+	&dev_attr_cmb_trig_patt_mask.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index d716963bee10..616b6df41e00 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -12,12 +12,23 @@
 /* CMB Subunit Registers*/
 /*CMB subunit global control register*/
 #define TPDM_CMB_CR		(0xA00)
+/*CMB subunit timestamp pattern registers*/
+#define TPDM_CMB_TPR(n)		(0xA08 + (n * 4))
+/*CMB subunit timestamp pattern mask registers*/
+#define TPDM_CMB_TPMR(n)	(0xA10 + (n * 4))
+/*CMB subunit trigger pattern registers*/
+#define TPDM_CMB_XPR(n)		(0xA18 + (n * 4))
+/*CMB subunit trigger pattern mask registers*/
+#define TPDM_CMB_XPMR(n)	(0xA20 + (n * 4))
 
 /* Enable bit for CMB subunit */
 #define TPDM_CMB_CR_ENA		BIT(0)
 /* Trace collection mode for CMB subunit*/
 #define TPDM_CMB_CR_MODE	BIT(1)
 
+/*Patten register number*/
+#define TPDM_CMB_MAX_PATT		2
+
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
@@ -122,9 +133,17 @@ struct dsb_dataset {
 /*
  * struct cmb_dataset
  * @trace_mode:		Dataset collection mode
+ * @patt_val:         Save value for pattern
+ * @patt_mask:        Save value for pattern mask
+ * @trig_patt_val:    Save value for trigger pattern
+ * @trig_patt_mask:   Save value for trigger pattern mask
  */
 struct cmb_dataset {
 	u32				trace_mode;
+	u32				patt_val[TPDM_CMB_MAX_PATT];
+	u32				patt_mask[TPDM_CMB_MAX_PATT];
+	u32				trig_patt_val[TPDM_CMB_MAX_PATT];
+	u32				trig_patt_mask[TPDM_CMB_MAX_PATT];
 };
 
 /**
-- 
2.39.0

