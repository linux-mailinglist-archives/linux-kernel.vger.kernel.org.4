Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6FB631B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiKUIYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiKUIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:24:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB19FAE7;
        Mon, 21 Nov 2022 00:23:52 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL7PJ7F001583;
        Mon, 21 Nov 2022 08:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=wJ+gBd921X/TLNoPpx3ToZdLO7xUi0rzfhWyMwE2kE0=;
 b=l1heYl1LYqnflXra4F7RerXZPKfdvGUumDyHEXN99J+3qywAK/x+pWabMGU5ojh0C3JT
 1Mgxb2UNeFZaDQioPS7ccGd2LsF0l5IW4M8DEOuHGiZL+s8jDY5a6FWP6yHvJz5qNFei
 xDiZJPbNIYQmQSk5nLhAZmfnG9lmYmYkhwn3iK3iqHu7/AfI2HTh0lvqcsx7V0UAKU5x
 iu4ymIGh6PduOg/rMyggojymH+GWOjV62Y3A8LaWN3AkBSoWKdt3f1/5UKgoS8+6HNlT
 kZwaWjaCqQWgKMpYWseZiKrvO2sffscL3vrjEgCG6ci/pyog9R5el63TXxRkiqBrfnR+ pg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrpb3vur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:22:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AL8Mfrm019408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:22:41 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 00:22:36 -0800
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
Subject: [PATCH v1 5/9] coresight-tpdm: Add nodes to set trigger timestamp and type
Date:   Mon, 21 Nov 2022 16:21:09 +0800
Message-ID: <1669018873-4718-6-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: SHcxZzTpmhS4MEPUeInJLYOIeda7Bq9m
X-Proofpoint-GUID: SHcxZzTpmhS4MEPUeInJLYOIeda7Bq9m
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

The nodes are needed to set or show the trigger timestamp and
trigger type. This change is to add these nodes to achieve these
function.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 97 ++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 5d5f442..35b328e 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -20,6 +20,22 @@
 
 DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
 
+static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
+							struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (drvdata) {
+		if (drvdata->datasets & TPDM_PIDR0_DS_DSB)
+			return attr->mode;
+		else
+			return 0;
+	}
+
+	return 0;
+}
+
 static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val;
@@ -241,8 +257,89 @@ static struct attribute_group tpdm_attr_grp = {
 	.attrs = tpdm_attrs,
 };
 
+static ssize_t dsb_trig_type_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			 (unsigned int)drvdata->dsb->trig_type);
+}
+
+/*
+ * value 0: set trigger type as enablement
+ * value 1: set trigger type as disablement
+ */
+static ssize_t dsb_trig_type_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || val < 0 || val > 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->dsb->trig_type = true;
+	else
+		drvdata->dsb->trig_type = false;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_type);
+
+static ssize_t dsb_trig_ts_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			 (unsigned int)drvdata->dsb->trig_ts);
+}
+
+/*
+ * value 0: set trigger timestamp as enablement
+ * value 1: set trigger timestamp as disablement
+ */
+static ssize_t dsb_trig_ts_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || val < 0 || val > 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->dsb->trig_ts = true;
+	else
+		drvdata->dsb->trig_ts = false;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_ts);
+static struct attribute *tpdm_dsb_attrs[] = {
+	&dev_attr_dsb_trig_ts.attr,
+	&dev_attr_dsb_trig_type.attr,
+	NULL,
+};
+
+static struct attribute_group tpdm_dsb_attr_grp = {
+	.attrs = tpdm_dsb_attrs,
+	.is_visible = tpdm_dsb_is_visible,
+};
+
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
+	&tpdm_dsb_attr_grp,
 	NULL,
 };
 
-- 
2.7.4

