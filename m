Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BD56CD514
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjC2IsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjC2IsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:48:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68206172B;
        Wed, 29 Mar 2023 01:48:20 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T3Bmu5007034;
        Wed, 29 Mar 2023 08:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=45d4yhT9YEm0+LQwNA6raFnJAcjyP2ebzoinOzaHzc4=;
 b=lW9IeU3YQcNQJ+Dgpvrc57HoWvSbc5ZaVIXOCEoW1qh1Q5icA57wwet2QG7SmuaACd0A
 UPNfbL7c0HPjtLlshFBlwlbr1YZG0GSMTy3jHOVlyu93/aaPuKwAY1bxNZudNj5MzZMV
 t4A/QTM2Hq7dEkfelKLiNCMBzjBl/joCRngHrOM3D9wacLjIao5bKYChpuOAY78OLKDi
 Bqq/Jxz5e8jnWKyCXFtOW/hIEFUNOtNVrD5dc3QvlRFs9dHSC6HER7gVfSaZgJxubQa5
 BL3gVQktZVXf6M8lwwhPutZlU8OAgjdrQNDgy/PBpScC0dZCq2Dz33ibWGYblzD0cYGZ xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmd6ugmbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T8lwej017497
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:58 GMT
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
Subject: [PATCH v1 4/8] coresight-tpdm: Add timestamp control register support for the CMB
Date:   Wed, 29 Mar 2023 01:47:40 -0700
Message-ID: <20230329084744.5705-5-quic_jinlmao@quicinc.com>
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
X-Proofpoint-GUID: 2f0jtgMG8KpiX207l28c-mQULJQYpxET
X-Proofpoint-ORIG-GUID: 2f0jtgMG8KpiX207l28c-mQULJQYpxET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
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

CMB_TIER register is CMB subunit timestamp insertion enable register.
Bit 0 is PATT_TSENAB bit. Set this bit to 1 to request a timestamp
following a CMB interface pattern match. Bit 1 is XTRIG_TSENAB bit.
Set this bit to 1 to request a timestamp following a CMB CTI timestamp
request. Bit 2 is TS_ALL bit. Set this bit to 1 to request timestamp
for all packets.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  |  24 ++++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 114 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h  |  14 +++
 3 files changed, 152 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 4cc22ad5c485..aa357f463d03 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -188,3 +188,27 @@ KernelVersion	6.3
 Contact:	Jinlong Mao <quic_jinlmao@quicinc.com>
 Description:	(RW) Read or write the value of CMB subunit trigger pattern match.
 
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_patt_ts
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao <quic_jinlmao@quicinc.com>
+Description:	(RW) Read or write status of timestamp upon CMB interface pattern match.
+		Only value 0 and 1 can be written to this node. Set this node to 1 to
+		request a timestamp following a CMB interface pattern match.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_ts
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao <quic_jinlmao@quicinc.com>
+Description:	(RW) Read or write the status of timestamp upon CMB cross trigger interface.
+		Only value 0 and 1  can be written to this node. Set this node to 1 to
+		request a timestamp following a CMB CTI timestamp request.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_ts_all
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao <quic_jinlmao@quicinc.com>
+Description:	(RW) Read or write the status of timestamp upon all interface.
+		Only value 0 and 1  can be written to this node. Set this node to 1 to requeset
+		timestamp to all trace packet.
+
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 05341fa7a6b7..88bb740cddd6 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -190,6 +190,22 @@ static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 			    drvdata->base + TPDM_CMB_XPMR(i));
 	}
 
+	/* Configure timestamp control register. */
+	val = readl_relaxed(drvdata->base + TPDM_CMB_TIER);
+	if (drvdata->cmb->patt_ts)
+		val = val | TPDM_CMB_TIER_PATT_TSENAB;
+	else
+		val = val & ~TPDM_CMB_TIER_PATT_TSENAB;
+	if (drvdata->cmb->trig_ts)
+		val = val | TPDM_CMB_TIER_XTRIG_TSENAB;
+	else
+		val = val & ~TPDM_CMB_TIER_XTRIG_TSENAB;
+	if (drvdata->cmb->ts_all)
+		val = val | TPDM_CMB_TIER_TS_ALL;
+	else
+		val = val & ~TPDM_CMB_TIER_TS_ALL;
+	writel_relaxed(val, drvdata->base + TPDM_CMB_TIER);
+
 	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
 	/*
 	 * Set to 0 for continuous CMB collection mode,
@@ -1048,6 +1064,101 @@ static ssize_t cmb_trig_patt_mask_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(cmb_trig_patt_mask);
 
+static ssize_t cmb_patt_ts_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->cmb->patt_ts);
+}
+
+static ssize_t cmb_patt_ts_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val) || (val & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->cmb->patt_ts = true;
+	else
+		drvdata->cmb->patt_ts = false;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_patt_ts);
+
+static ssize_t cmb_ts_all_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->cmb->ts_all);
+}
+
+static ssize_t cmb_ts_all_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val) || (val & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->cmb->ts_all = true;
+	else
+		drvdata->cmb->ts_all = false;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_ts_all);
+
+static ssize_t cmb_trig_ts_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->cmb->trig_ts);
+}
+
+static ssize_t cmb_trig_ts_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val) || (val & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->cmb->trig_ts = true;
+	else
+		drvdata->cmb->trig_ts = false;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_trig_ts);
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_edge_ctrl.attr,
@@ -1070,6 +1181,9 @@ static struct attribute *tpdm_cmb_attrs[] = {
 	&dev_attr_cmb_patt_mask.attr,
 	&dev_attr_cmb_trig_patt_val.attr,
 	&dev_attr_cmb_trig_patt_mask.attr,
+	&dev_attr_cmb_patt_ts.attr,
+	&dev_attr_cmb_ts_all.attr,
+	&dev_attr_cmb_trig_ts.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 616b6df41e00..88ade2f2ef6c 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -12,6 +12,8 @@
 /* CMB Subunit Registers*/
 /*CMB subunit global control register*/
 #define TPDM_CMB_CR		(0xA00)
+/*CMB subunit timestamp insertion enable register*/
+#define TPDM_CMB_TIER		(0xA04)
 /*CMB subunit timestamp pattern registers*/
 #define TPDM_CMB_TPR(n)		(0xA08 + (n * 4))
 /*CMB subunit timestamp pattern mask registers*/
@@ -25,6 +27,12 @@
 #define TPDM_CMB_CR_ENA		BIT(0)
 /* Trace collection mode for CMB subunit*/
 #define TPDM_CMB_CR_MODE	BIT(1)
+/* Timestamp control for pattern match */
+#define TPDM_CMB_TIER_PATT_TSENAB	BIT(0)
+/* CMB CTI timestamp request */
+#define TPDM_CMB_TIER_XTRIG_TSENAB	BIT(1)
+/* For timestamp fo all trace*/
+#define TPDM_CMB_TIER_TS_ALL		BIT(2)
 
 /*Patten register number*/
 #define TPDM_CMB_MAX_PATT		2
@@ -137,6 +145,9 @@ struct dsb_dataset {
  * @patt_mask:        Save value for pattern mask
  * @trig_patt_val:    Save value for trigger pattern
  * @trig_patt_mask:   Save value for trigger pattern mask
+ * @patt_ts:	      Indicates if pattern match for timestamp is enabled.
+ * @trig_ts:	      Indicates if CTI trigger for timestamp is enabled.
+ * @ts_all:	      Indicates if timestamp is enabled for all packets.
  */
 struct cmb_dataset {
 	u32				trace_mode;
@@ -144,6 +155,9 @@ struct cmb_dataset {
 	u32				patt_mask[TPDM_CMB_MAX_PATT];
 	u32				trig_patt_val[TPDM_CMB_MAX_PATT];
 	u32				trig_patt_mask[TPDM_CMB_MAX_PATT];
+	bool				patt_ts;
+	bool				trig_ts;
+	bool				ts_all;
 };
 
 /**
-- 
2.39.0

