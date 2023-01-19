Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609936732D7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjASHpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjASHnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:43:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EE1689FD;
        Wed, 18 Jan 2023 23:43:01 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5vBMl024736;
        Thu, 19 Jan 2023 07:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=A3zz+Jx7HEGw4pEP66Nkk5nOP57llUNFENN7zakwGvE=;
 b=ejrTTgF7l8qtgXJ960gyVtiIue3owKHlmHcTnUXctSyyawMgE7Rq3tMJVNNhmQkY1fCR
 iZGuNLqacRRKuNramd3Rpu5r33rHkn0NDwb3va1IGsIGmyULwclE/U0OBD3s0tVwL/qd
 OjqMTrWDZ+19EnG6wH2Pl97pErqZszGNMgriFh3/6XeGAr3kJQUAXYu4vzN/k87tsKcd
 QZ5CFhwIpjUFRqGXj9zIF2JpbtOwJt3E3iay5Tlxp6uY2UUx77L86syB3ZRePw5YaKmr
 QVcPBSgx7waKhZyrVCp9TRcyq4JLeDRnFF1+O+BVNB7glRy6lpjM0gqd8p1eixAqhnLT 2w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6vjbgp8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:42:48 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J7gl5J025955
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:42:47 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 23:42:42 -0800
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
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        Tao Zhang <taozha@qti.qualcomm.com>
Subject: [PATCH v2 8/9] coresight-tpdm: Add nodes to configure pattern match output
Date:   Thu, 19 Jan 2023 15:41:44 +0800
Message-ID: <1674114105-16651-9-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XH6pw19S8CRcUQmqafbwIJCSwQ1Q6wGL
X-Proofpoint-GUID: XH6pw19S8CRcUQmqafbwIJCSwQ1Q6wGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes to configure trigger pattern and trigger pattern mask.
Each DSB subunit TPDM has maximum of n(n<7) XPR registers to
configure trigger pattern match output. Eight 32 bit registers
providing DSB interface trigger output pattern match comparison.
And each DSB subunit TPDM has maximum of m(m<7) XPMR registers to
configure trigger pattern mask match output. Eight 32 bit
registers providing DSB interface trigger output pattern match
mask.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 85 ++++++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h |  8 +++
 2 files changed, 93 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 0ec2691..52f6331 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -48,6 +48,13 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
 			   drvdata->base + TPDM_DSB_EDCMR(i));
 
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		writel_relaxed(drvdata->dsb->trig_patt_val[i],
+			    drvdata->base + TPDM_DSB_XPR(i));
+		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
+			    drvdata->base + TPDM_DSB_XPMR(i));
+	}
+
 	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
 	/* Set trigger timestamp */
 	if (drvdata->dsb->trig_ts)
@@ -437,6 +444,82 @@ static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
 
+static ssize_t dsb_trig_patt_val_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		size += sysfs_emit_at(buf, size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->dsb->trig_patt_val[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+static ssize_t dsb_trig_patt_val_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t size)
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
+	drvdata->dsb->trig_patt_val[index] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_patt_val);
+
+static ssize_t dsb_trig_patt_mask_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		size += sysfs_emit_at(buf, size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->dsb->trig_patt_mask[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+static ssize_t dsb_trig_patt_mask_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf,
+					     size_t size)
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
+	drvdata->dsb->trig_patt_mask[index] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_patt_mask);
+
 static ssize_t dsb_trig_type_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -510,6 +593,8 @@ static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_edge_ctrl.attr,
 	&dev_attr_dsb_edge_ctrl_mask.attr,
+	&dev_attr_dsb_trig_patt_val.attr,
+	&dev_attr_dsb_trig_patt_mask.attr,
 	&dev_attr_dsb_trig_ts.attr,
 	&dev_attr_dsb_trig_type.attr,
 	NULL,
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 89f8d8b..c93f72f 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -12,6 +12,8 @@
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
+#define TPDM_DSB_XPR(n)		(0x7C8 + (n * 4))
+#define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
 #define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
 #define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
 
@@ -65,12 +67,16 @@
 #define TPDM_DSB_MAX_EDCR	16
 /* MAX number of EDCMR registers */
 #define TPDM_DSB_MAX_EDCMR	8
+/* MAX number of DSB pattern */
+#define TPDM_DSB_MAX_PATT	8
 
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
  * @mode:             DSB programming mode
  * @edge_ctrl:        Save value for edge control
  * @edge_ctrl_mask:   Save value for edge control mask
+ * @trig_patt_val:    Save value for trigger pattern
+ * @trig_patt_mask:   Save value for trigger pattern mask
  * @trig_ts:          Enable/Disable trigger timestamp.
  * @trig_type:        Enable/Disable trigger type.
  */
@@ -78,6 +84,8 @@ struct dsb_dataset {
 	u32				mode;
 	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
 	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
+	u32				trig_patt_val[TPDM_DSB_MAX_PATT];
+	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
 	bool			trig_ts;
 	bool			trig_type;
 };
-- 
2.7.4

