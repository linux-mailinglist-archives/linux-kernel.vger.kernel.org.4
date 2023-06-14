Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCCB72B9B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjFLIGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjFLIFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:05:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803AD1FE4;
        Mon, 12 Jun 2023 01:04:56 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C5vLfh020613;
        Mon, 12 Jun 2023 07:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0ceFu343VBNgYMvMtpC4a9jH9BI0mOMHWUxajBBuLps=;
 b=dhjkPnt9jl3h4wNhh8zwGibrbNlEvaDM/BEUW5v8fhnm+MR1CtHKGQPNbxyHHULVqcA7
 I747AxJlm4c78oLF2UjtOd87fVVEQgNSQkgNVsr86yy6RqohG6RmfgItdAv1YFP+djB+
 zDkbtOgxNrihEeAW74vCp70G8KPnmuVLAhYkW/6cwHNOt2q2eJ+0ertQCHNaC1UExSoA
 O0PHrh71iN3pH8eNnFzBZj0cgetTIzSa7U72CaTL9jzD2EByu8kszGXPZswTHt1fbUe2
 hOhEkzB+Jsgb+2ed7JPSnmibl36HxFZc3DUwescm88I0zjs96yCJtXwc7QS3dmR7dFEo AA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r4ggr2m34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 07:09:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35C790oI015065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 07:09:00 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 00:08:55 -0700
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
Subject: [PATCH v5 09/13] Add nodes for dsb edge control
Date:   Mon, 12 Jun 2023 15:07:42 +0800
Message-ID: <1686553666-5811-10-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-GUID: S6OdWxRWh27Auy4w8NzrHamFunH2FrCZ
X-Proofpoint-ORIG-GUID: S6OdWxRWh27Auy4w8NzrHamFunH2FrCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_04,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes to set value for DSB edge control and DSB edge
control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
resgisters to configure edge control. DSB edge detection control
00: Rising edge detection
01: Falling edge detection
10: Rising and falling edge detection (toggle detection)
And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
configure mask. Eight 32 bit registers providing DSB interface
edge detection mask control.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  32 +++++
 drivers/hwtracing/coresight/coresight-tpdm.c       | 143 ++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h       |  22 ++++
 3 files changed, 196 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 2a82cd0..34189e4a 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -60,3 +60,35 @@ Description:
 		Bit[3] : Set to 0 for low performance mode.
 				 Set to 1 for high performance mode.
 		Bit[4:8] : Select byte lane for high performance mode.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl
+Date:		March 2023
+KernelVersion	6.5
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		Read/Write a set of the edge control registers of the DSB
+		in TPDM.
+
+		Expected format is the following:
+		<integer1> <integer2> <integer3>
+
+		Where:
+		<integer1> : Start EDCR register number
+		<integer2> : End EDCR register number
+		<integer3> : The value need to be written
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_mask
+Date:		March 2023
+KernelVersion	6.5
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		Read/Write a set of the edge control mask registers of the
+		DSB in TPDM.
+
+		Expected format is the following:
+		<integer1> <integer2> <integer3>
+
+		Where:
+		<integer1> : Start EDCMR register number
+		<integer2> : End EDCMR register number
+		<integer3> : The value need to be written
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index c38760b..fc92900 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -71,7 +71,14 @@ static void set_dsb_perf_mode(struct tpdm_drvdata *drvdata, u32 *val)
 
 static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
-	u32 val;
+	u32 val, i;
+
+	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
+		writel_relaxed(drvdata->dsb->edge_ctrl[i],
+			   drvdata->base + TPDM_DSB_EDCR(i));
+	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
+		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
+			   drvdata->base + TPDM_DSB_EDCMR(i));
 
 	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
 	/* Set trigger timestamp */
@@ -302,6 +309,138 @@ static ssize_t dsb_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_mode);
 
+static ssize_t dsb_edge_ctrl_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	unsigned long bytes;
+	int i;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
+		bytes = sysfs_emit_at(buf, size,
+				  "Index:0x%x Val:0x%x\n", i,
+				  drvdata->dsb->edge_ctrl[i]);
+		if (bytes <= 0)
+			break;
+		size += bytes;
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+/*
+ * value 1: Start EDCR register number
+ * value 2: End EDCR register number
+ * value 3: The value need to be written
+ * The EDCR registers can include up to 16 32-bit registers, and each
+ * one can be configured to control up to 16 edge detections(2 bits
+ * control one edge detection). So a total 256 edge detections can be
+ * configured. So the starting number(value 1) and ending number(value 2)
+ * cannot be greater than 256, and value 1 should be less than value 2.
+ * The following values are the rage of value 3.
+ * 0 - Rising edge detection
+ * 1 - Falling edge detection
+ * 2 - Rising and falling edge detection (toggle detection)
+ */
+static ssize_t dsb_edge_ctrl_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val, mask, start, end, edge_ctrl;
+	int i, reg;
+
+	if (sscanf(buf, "%lx %lx %lx", &start, &end, &edge_ctrl) != 3)
+		return -EINVAL;
+	if ((start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES) ||
+	    (start > end) || (edge_ctrl > 0x2))
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = start; i <= end; i++) {
+		/*
+		 * There are 2 bit per DSB Edge Control line.
+		 * Thus we have 16 lines in a 32bit word.
+		 */
+		reg = EDCR_TO_WORD_IDX(i);
+		mask = EDCR_TO_WORD_MASK(i);
+		val = drvdata->dsb->edge_ctrl[reg];
+		val &= ~EDCR_TO_WORD_MASK(i);
+		val |= EDCR_TO_WORD_VAL(edge_ctrl, i);
+		drvdata->dsb->edge_ctrl[reg] = val;
+	}
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_edge_ctrl);
+
+static ssize_t dsb_edge_ctrl_mask_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	unsigned long bytes;
+	int i;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++) {
+		bytes = sysfs_emit_at(buf, size,
+				  "Index:0x%x Val:0x%x\n", i,
+				  drvdata->dsb->edge_ctrl_mask[i]);
+		if (bytes <= 0)
+			break;
+		size += bytes;
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+/*
+ * value 1: Start EDCMR register number
+ * value 2: End EDCMR register number
+ * value 3: The value need to be written
+ */
+static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf,
+					     size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long start, end, val;
+	u32 set;
+	int i, reg;
+
+	if (sscanf(buf, "%lx %lx %lx", &start, &end, &val) != 3)
+		return -EINVAL;
+	if ((start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES)
+		|| (start > end) || (val & ~1UL))
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = start; i <= end; i++) {
+		/*
+		 * There is 1 bit per DSB Edge Control Mark line.
+		 * Thus we have 32 lines in a 32bit word.
+		 */
+		reg = EDCMR_TO_WORD_IDX(i);
+		set = drvdata->dsb->edge_ctrl_mask[reg];
+		if (val)
+			set |= BIT(EDCR_TO_WORD_SHIFT(i));
+		else
+			set &= ~BIT(EDCR_TO_WORD_SHIFT(i));
+		drvdata->dsb->edge_ctrl_mask[reg] = set;
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
+
 static ssize_t dsb_trig_type_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
@@ -374,6 +513,8 @@ static DEVICE_ATTR_RW(dsb_trig_ts);
 
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
+	&dev_attr_dsb_edge_ctrl.attr,
+	&dev_attr_dsb_edge_ctrl_mask.attr,
 	&dev_attr_dsb_trig_ts.attr,
 	&dev_attr_dsb_trig_type.attr,
 	NULL,
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 49fffb1..f81bfe8 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -12,6 +12,8 @@
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
+#define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
+#define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
 
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
@@ -34,6 +36,16 @@
 #define TPDM_DSB_TEST_MODE		GENMASK(10, 9)
 #define TPDM_DSB_HPSEL		GENMASK(6, 2)
 
+#define EDCRS_PER_WORD				16
+#define EDCR_TO_WORD_IDX(r)			((r) / EDCRS_PER_WORD)
+#define EDCR_TO_WORD_SHIFT(r)		((r % EDCRS_PER_WORD) * 2)
+#define EDCR_TO_WORD_VAL(val, r)	(val << EDCR_TO_WORD_SHIFT(r))
+#define EDCR_TO_WORD_MASK(r)		EDCR_TO_WORD_VAL(0x3, r)
+
+#define EDCMRS_PER_WORD				32
+#define EDCMR_TO_WORD_IDX(r)		((r) / EDCMRS_PER_WORD)
+#define EDCMR_TO_WORD_SHIFT(r)		((r) % EDCMRS_PER_WORD)
+
 /* TPDM integration test registers */
 #define TPDM_ITATBCNTRL		(0xEF0)
 #define TPDM_ITCNTRL		(0xF00)
@@ -60,14 +72,24 @@
 #define TPDM_PIDR0_DS_IMPDEF	BIT(0)
 #define TPDM_PIDR0_DS_DSB	BIT(1)
 
+#define TPDM_DSB_MAX_LINES	256
+/* MAX number of EDCR registers */
+#define TPDM_DSB_MAX_EDCR	16
+/* MAX number of EDCMR registers */
+#define TPDM_DSB_MAX_EDCMR	8
+
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
  * @mode:             DSB programming mode
+ * @edge_ctrl:        Save value for edge control
+ * @edge_ctrl_mask:   Save value for edge control mask
  * @trig_ts:          Enable/Disable trigger timestamp.
  * @trig_type:        Enable/Disable trigger type.
  */
 struct dsb_dataset {
 	u32				mode;
+	u32			edge_ctrl[TPDM_DSB_MAX_EDCR];
+	u32			edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
 	bool			trig_ts;
 	bool			trig_type;
 };
-- 
2.7.4

