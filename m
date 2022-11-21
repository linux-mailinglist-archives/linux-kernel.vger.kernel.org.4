Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0228D631B41
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiKUIXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiKUIXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:23:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48EE6337;
        Mon, 21 Nov 2022 00:22:56 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL4wLYq004558;
        Mon, 21 Nov 2022 08:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sIX00c12kKIh/2EExRRGy/YlN+uRLbty30R/eD+4PDM=;
 b=KV1MDSIjG849iGu+g2QkJpuF0398O//22683cCL/3ViwnMv6JX2y/jsZptz2ajMFI3IR
 Sfjhw08++6ajLntnkZSROcD03/g+FoGuRpLXYw1GxBCZX8cPihxOd0IZez8DhsZitXyd
 H4yEcsUz6lVpY0BDHK0E7vQ0lcwb/4IK7gq8TLa7vJHJkAioBYSzkv4bjTBysqCO3ZC/
 NKWTdW20/luxZUlfPKa/9LP4Po7TR/Kf58e3DbBdX2eyFQLsQcco/L1JhcOnOUTA7nwN
 yZLySWramazD9SqH2XhcuNof1zDT1gYFeOpDwz1FeIztb8Xo8Oe2xwUcCbt5bWmiOI6I gA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrpb3vuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:22:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AL8Mkux028058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:22:46 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 00:22:41 -0800
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
Subject: [PATCH v1 6/9] coresight-tpdm: Add node to set dsb programming mode
Date:   Mon, 21 Nov 2022 16:21:10 +0800
Message-ID: <1669018873-4718-7-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1-LTWwFtX7I8MEYxfP_vcF326dMlFtOk
X-Proofpoint-GUID: 1-LTWwFtX7I8MEYxfP_vcF326dMlFtOk
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

Add node to set and show programming mode for TPDM DSB subunit.
Once the DSB programming mode is set, it will be written to the
register DSB_CR. Bit[10:9] of the DSB_CR register is used to set
the DSB test mode.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 45 +++++++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h | 12 ++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 35b328e..8872e3a 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/amba/bus.h>
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
@@ -38,7 +39,7 @@ static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
 
 static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
-	u32 val;
+	u32 val, mode;
 
 	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
 	/* Set trigger timestamp */
@@ -58,6 +59,19 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 
 	/* Set the enable bit of DSB control register to 1 */
 	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+	/* Set the cycle accurate mode */
+	mode = TPDM_DSB_MODE_CYCACC(drvdata->dsb->mode);
+	val &= ~TPDM_DSB_TEST_MODE;
+	val |= FIELD_PREP(TPDM_DSB_TEST_MODE, mode);
+	/* Set the byte lane for high-performance mode */
+	mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
+	val &= ~TPDM_DSB_HPSEL;
+	val |= FIELD_PREP(TPDM_DSB_HPSEL, mode);
+	/* Set the performance mode */
+	if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
+		val |= TPDM_DSB_MODE;
+	else
+		val &= ~TPDM_DSB_MODE;
 	val |= TPDM_DSB_CR_ENA;
 	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
 }
@@ -257,6 +271,34 @@ static struct attribute_group tpdm_attr_grp = {
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
+	drvdata->dsb->mode = val & TPDM_MODE_ALL;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_mode);
+
 static ssize_t dsb_trig_type_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -327,6 +369,7 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_trig_ts);
 static struct attribute *tpdm_dsb_attrs[] = {
+	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_trig_ts.attr,
 	&dev_attr_dsb_trig_type.attr,
 	NULL,
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index dd4a013..de1492c 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -19,6 +19,16 @@
 #define TPDM_DSB_XTRIG_TSENAB		BIT(1)
 /* Enable bit for DSB subunit trigger type */
 #define TPDM_DSB_TRIG_TYPE		BIT(12)
+/* Enable bit for DSB subunit perfmance mode */
+#define TPDM_DSB_MODE		BIT(1)
+
+/* DSB programming modes */
+#define TPDM_DSB_MODE_CYCACC(val)	(val & GENMASK(2, 0))
+#define TPDM_DSB_MODE_PERF		BIT(3)
+#define TPDM_DSB_MODE_HPBYTESEL(val)	(val & GENMASK(8, 4))
+#define TPDM_MODE_ALL			(0xFFFFFFF)
+#define TPDM_DSB_TEST_MODE		GENMASK(11, 9)
+#define TPDM_DSB_HPSEL		GENMASK(6, 2)
 
 /* TPDM integration test registers */
 #define TPDM_ITATBCNTRL		(0xEF0)
@@ -48,10 +58,12 @@
 
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

