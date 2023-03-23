Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BE46C5F78
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjCWGGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjCWGG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:06:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D339A2799B;
        Wed, 22 Mar 2023 23:05:59 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4VXti012561;
        Thu, 23 Mar 2023 06:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ZGw4m4kFy/MgkluNP7jMvjFNNAs1BsIzSi4FRMxapXg=;
 b=VJnoWaZMcKg03LxHWoWpE0gk5GpB3u+oX7DKIfG9q+IvALxCN7/yuC+TXLykdcOZYqCZ
 PXjT1Azl1dSs5RlW7JIHlwSZZg0sLrRyTnqBNcusorXOxWwEB2B4DGbBcdiIWMbaM9EJ
 bmbSvROvCEBkyAo6jMfXHOdf+0bbTn+C12ese3I+4j0A6tzHT9l6Pbrm0IkdbdgpW/E7
 k4G7A24QGSGdtQDwmuaU8gW2NXro4KTYCsnhaL3Dd50mXWtLElVjod8Vl5P7LvQO7rZ5
 hz6O/yH7/myi1hGFUTwq/byZX1E6FVo04p6KjM4hrUUuwDe1t47ToqkObdtDEmUq3wGg pQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg3c99y77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:05:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N65A4e007622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:05:10 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 23:05:05 -0700
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
Subject: [PATCH v3 07/11] coresight-tpdm: Add nodes for dsb edge control
Date:   Thu, 23 Mar 2023 14:04:04 +0800
Message-ID: <1679551448-19160-8-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kut6Z0yQNBVba_NXshYsKSSmevGB43vf
X-Proofpoint-ORIG-GUID: kut6Z0yQNBVba_NXshYsKSSmevGB43vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230046
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  26 ++++
 drivers/hwtracing/coresight/coresight-tpdm.c       | 142 ++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h       |  14 ++
 3 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index f13e282..094d624 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -45,3 +45,29 @@ Description:
 		tpdm.
 
 		Accepts the value needs to be greater than 0.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Set the edge control of DSB tpdm. Read the
+		edge control of DSB tpdm.
+
+		Accepts the following three values.
+		value 1: Start EDCR register number
+		value 2: End EDCR register number
+		value 3: The value need to be written
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_mask
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Set the edge control mask of DSB tpdm. Read
+		the edge control mask of DSB tpdm.
+
+		Accepts the following three values.
+		value 1: Start EDCMR register number
+		value 2: End EDCMR register number
+		value 3: The value need to be written
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 8cd822f..2a0b36c 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -88,7 +88,14 @@ static void set_trigger_type(struct tpdm_drvdata *drvdata, u32 *val)
 
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
@@ -311,6 +318,137 @@ static ssize_t dsb_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_mode);
 
+static ssize_t dsb_edge_ctrl_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
+		size += sysfs_emit_at(buf, size,
+				  "Index:0x%x Val:0x%x\n", i,
+				  drvdata->dsb->edge_ctrl[i]);
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
+	unsigned long start, end, edge_ctrl;
+	uint32_t val;
+	int i, index, bit, reg;
+
+	if (sscanf(buf, "%lx %lx %lx", &start, &end, &edge_ctrl) != 3)
+		return -EINVAL;
+	if ((start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES) ||
+	    edge_ctrl > 0x2)
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = start; i <= end; i++) {
+		/*
+		 * The 32-bit register has 32 bits(NUM_OF_BITS).
+		 * Each one register can be configured to control 16
+		 * (NUM_OF_BITS / 2) edge detectioins.
+		 */
+		reg = i / (NUM_OF_BITS / 2);
+		index = i % (NUM_OF_BITS / 2);
+		bit = index * 2;
+
+		val = drvdata->dsb->edge_ctrl[reg];
+		val &= ~GENMASK((bit + 1), bit);
+		val |= (edge_ctrl << bit);
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
+	int i;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_EDCR / 2; i++) {
+		size += sysfs_emit_at(buf, size,
+				  "Index:0x%x Val:0x%x\n", i,
+				  drvdata->dsb->edge_ctrl_mask[i]);
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
+	int i, index, reg;
+
+	if (sscanf(buf, "%lx %lx %lx", &start, &end, &val) != 3)
+		return -EINVAL;
+	if ((start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES)
+		|| (val & ~1UL))
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = start; i <= end; i++) {
+		/*
+		 * The 32-bit register has 32 bits(NUM_OF_BITS).
+		 * Each one register can be configured to control 32
+		 * (NUM_OF_BITS) edge detectioin masks.
+		 */
+		reg = i / NUM_OF_BITS;
+		index = (i % NUM_OF_BITS);
+
+		set = drvdata->dsb->edge_ctrl_mask[reg];
+		if (val)
+			set |= BIT(index);
+		else
+			set &= ~BIT(index);
+		drvdata->dsb->edge_ctrl_mask[reg] = set;
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
+
 static ssize_t dsb_trig_type_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -383,6 +521,8 @@ static DEVICE_ATTR_RW(dsb_trig_ts);
 
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
+	&dev_attr_dsb_edge_ctrl.attr,
+	&dev_attr_dsb_edge_ctrl_mask.attr,
 	&dev_attr_dsb_trig_ts.attr,
 	&dev_attr_dsb_trig_type.attr,
 	NULL,
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 8fee562..342ef23 100644
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
@@ -31,6 +33,8 @@
 #define TPDM_DSB_TEST_MODE		GENMASK(11, 9)
 #define TPDM_DSB_HPSEL		GENMASK(6, 2)
 
+#define NUM_OF_BITS		32
+
 /* TPDM integration test registers */
 #define TPDM_ITATBCNTRL		(0xEF0)
 #define TPDM_ITCNTRL		(0xF00)
@@ -57,14 +61,24 @@
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
+	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
+	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
 	bool			trig_ts;
 	bool			trig_type;
 };
-- 
2.7.4

