Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2DC72BA94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjFLI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjFLI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:28:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF04A10E4;
        Mon, 12 Jun 2023 01:27:53 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C6c6V8010393;
        Mon, 12 Jun 2023 07:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=f7KtmMD3x0zsy+mXU47TA2shtj1MOmMQdRqFlm1Gyrk=;
 b=B1Vh0Jj748s5kUW5pYtn0T04Ja+gVhs9nt7pU4FmuQaWCL3Uui729dwS/6+UWMIPGxcq
 CeZZCL13pmPwgy8/fkl6f6hXjIKhaHy95kFMPIEFIfhquH5t2CoPb7LIysbldGHkt3lo
 eE3QMW1D0Kh6b4S7kwLfbtSqdbHrKxsAn6PnPd4AuCPjpfD3o8CV3a8+ANFtTBNi4cmi
 srtyOaWxxKbHkP4+iriUTO8/RFW1zBdEdtA2/ZzWs1kbiuFpclmMchwuo4lnPlexkRss
 CwXeURWzG/yRknv3XUBeByhvb3Xc+UNnUh+QueQt2ktc9iu6sFZJz0GGFOt9CrVYerbf 2g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r4g6eamrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 07:08:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35C78tHf015004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 07:08:55 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 00:08:50 -0700
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
Subject: [PATCH v5 08/13] coresight-tpdm: Add node to set dsb programming mode
Date:   Mon, 12 Jun 2023 15:07:41 +0800
Message-ID: <1686553666-5811-9-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UyAt7geuxquavBt5cGlbRXofQbxeEeoG
X-Proofpoint-GUID: UyAt7geuxquavBt5cGlbRXofQbxeEeoG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_04,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 clxscore=1015 bulkscore=0 malwarescore=0
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

Add node to set and show programming mode for TPDM DSB subunit.
Once the DSB programming mode is set, it will be written to the
register DSB_CR.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 15 ++++++
 drivers/hwtracing/coresight/coresight-tpdm.c       | 62 ++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h       | 16 ++++++
 3 files changed, 93 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 0b7b4ad..2a82cd0 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -45,3 +45,18 @@ Description:
 		Accepts only one of the 2 values -  0 or 1.
 		0 : Set the DSB trigger type to false
 		1 : Set the DSB trigger type to true
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_mode
+Date:		March 2023
+KernelVersion	6.5
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Set the mode of DSB tpdm. Read the mode of DSB
+		tpdm.
+
+		Accepts the value needs to be greater than 0. What data
+		bits do is listed below.
+		Bit[0:1] : Test mode control bit for choosing the inputs.
+		Bit[3] : Set to 0 for low performance mode.
+				 Set to 1 for high performance mode.
+		Bit[4:8] : Select byte lane for high performance mode.
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 62efc18..c38760b 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/amba/bus.h>
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
@@ -42,6 +43,32 @@ static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
 	}
 }
 
+static void set_dsb_test_mode(struct tpdm_drvdata *drvdata, u32 *val)
+{
+	u32 mode;
+
+	mode = TPDM_DSB_MODE_TEST(drvdata->dsb->mode);
+	*val &= ~TPDM_DSB_TEST_MODE;
+	*val |= FIELD_PREP(TPDM_DSB_TEST_MODE, mode);
+}
+
+static void set_dsb_hpsel_mode(struct tpdm_drvdata *drvdata, u32 *val)
+{
+	u32 mode;
+
+	mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
+	*val &= ~TPDM_DSB_HPSEL;
+	*val |= FIELD_PREP(TPDM_DSB_HPSEL, mode);
+}
+
+static void set_dsb_perf_mode(struct tpdm_drvdata *drvdata, u32 *val)
+{
+	if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
+		*val |= TPDM_DSB_CR_MODE;
+	else
+		*val &= ~TPDM_DSB_CR_MODE;
+}
+
 static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val;
@@ -55,6 +82,12 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
 
 	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+	/* Set the test accurate mode */
+	set_dsb_test_mode(drvdata, &val);
+	/* Set the byte lane for high-performance mode */
+	set_dsb_hpsel_mode(drvdata, &val);
+	/* Set the performance mode */
+	set_dsb_perf_mode(drvdata, &val);
 	/* Set trigger type */
 	if (drvdata->dsb->trig_type)
 		val |= TPDM_DSB_CR_TRIG_TYPE;
@@ -241,6 +274,34 @@ static struct attribute_group tpdm_attr_grp = {
 	.attrs = tpdm_attrs,
 };
 
+static ssize_t dsb_mode_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%lx\n",
+			 (unsigned long)drvdata->dsb->mode);
+}
+
+static ssize_t dsb_mode_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || val < 0)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->dsb->mode = val & TPDM_DSB_MODE_MASK;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_mode);
+
 static ssize_t dsb_trig_type_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
@@ -312,6 +373,7 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
 static DEVICE_ATTR_RW(dsb_trig_ts);
 
 static struct attribute *tpdm_dsb_attrs[] = {
+	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_trig_ts.attr,
 	&dev_attr_dsb_trig_type.attr,
 	NULL,
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 92c34cd..49fffb1 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -15,11 +15,25 @@
 
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
+/* Enable bit for DSB subunit perfmance mode */
+#define TPDM_DSB_CR_MODE		BIT(1)
 /* Enable bit for DSB subunit trigger type */
 #define TPDM_DSB_CR_TRIG_TYPE		BIT(12)
+
 /* Enable bit for DSB subunit trigger timestamp */
 #define TPDM_DSB_TIER_XTRIG_TSENAB		BIT(1)
 
+/* DSB programming modes */
+/* Test mode control bit*/
+#define TPDM_DSB_MODE_TEST(val)	(val & GENMASK(1, 0))
+/* Performance mode */
+#define TPDM_DSB_MODE_PERF		BIT(3)
+/* High performance mode */
+#define TPDM_DSB_MODE_HPBYTESEL(val)	(val & GENMASK(8, 4))
+#define TPDM_DSB_MODE_MASK			GENMASK(8, 0)
+#define TPDM_DSB_TEST_MODE		GENMASK(10, 9)
+#define TPDM_DSB_HPSEL		GENMASK(6, 2)
+
 /* TPDM integration test registers */
 #define TPDM_ITATBCNTRL		(0xEF0)
 #define TPDM_ITCNTRL		(0xF00)
@@ -48,10 +62,12 @@
 
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
+ * @mode:             DSB programming mode
  * @trig_ts:          Enable/Disable trigger timestamp.
  * @trig_type:        Enable/Disable trigger type.
  */
 struct dsb_dataset {
+	u32				mode;
 	bool			trig_ts;
 	bool			trig_type;
 };
-- 
2.7.4

