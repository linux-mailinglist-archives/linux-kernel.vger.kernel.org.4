Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89C46732D1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjASHoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjASHnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:43:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34876797D;
        Wed, 18 Jan 2023 23:42:54 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J7atJp022944;
        Thu, 19 Jan 2023 07:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=BjGlUuG85ZIxBon+F2anCaKi/MvRI7WMd/RYZPpvb4k=;
 b=A2XgVoZuIXRR3kdlwboLaGprKZpyLCLXf/pgZdNushHSPHc8WBh1BvZzfh4qLNbhq+Tp
 ZhC6xTcrQO87/tsg4c5DB2+dXy84/9Du4ZvhbELKitCokHLQAd8Ie9+W06E+1HXm+7Xn
 WuZaef9OaduRJFSlokdAG9+CgOeQWjxDKi73sYBkMA+18o2I2B6mLnseKPAW+xk18R3j
 vs834P6pC2obRm3NKLtbbte1U/bEChHaG5Bl5SAUfmU+F1CdN+QiKy8K5KxYEqgebDzu
 9nmnqJL62Rmzs/FpCBkHhKGfXRsWIHL+MavL8agxuW56zz1dp/Knxhww9mHqOJNjpZPY Og== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6xktggpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:42:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J7gcGZ029521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:42:38 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 23:42:33 -0800
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
Subject: [PATCH v2 6/9] coresight-tpdm: Add node to set dsb programming mode
Date:   Thu, 19 Jan 2023 15:41:42 +0800
Message-ID: <1674114105-16651-7-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: TdywzO3c3VuGD7Brwqu3Q7yYIn6fm3Xy
X-Proofpoint-GUID: TdywzO3c3VuGD7Brwqu3Q7yYIn6fm3Xy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 45 +++++++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h | 12 ++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 1dbb6c4..9126a37 100644
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
index 3ad1be5..b3ecb9f 100644
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

