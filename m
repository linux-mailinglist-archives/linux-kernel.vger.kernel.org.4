Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304A37364C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjFTHen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjFTHe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:34:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A33A139;
        Tue, 20 Jun 2023 00:34:25 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K5xV5p016297;
        Tue, 20 Jun 2023 07:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=DfyZCmPJgINc2vFaG8QlV7pWGi3oWtmNllEgbtOpkTY=;
 b=Iyq2XA8QtDkVThFZlVGB5S4xqj+qE64BgpIRQFMCz4S08p3VAZxDIQRxTG4ulCrcJkRr
 C8GoDCeO3lD4y06Kwo6YG64SDMXCRI52TJRQLffFoSscbZtDKBHyeSh6xKiL2VRrlh+J
 z+U2QpYWDPdQX2xRcXB/0ItgOTtgi5ZkFsggri7chrdOAbPAWZAYO9hWDM94/1G+GjbT
 7LPHwANQ4UaGgqTngP8Zko8C5oa3UM6PXEHuB9+m98C8RybvSUl6TnDM3vRR5Gb/zV0Q
 xidhY6UvlFWfgQO+83PJ4tPhZHczz+SU0N+NWpHttvWUDX74NA78hdHqaAl10ongM/Kq 2Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb3fhrd2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 07:34:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35K7Y4Ew025835
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 07:34:04 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 20 Jun 2023 00:33:38 -0700
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
Subject: [PATCH v6 07/13] coresight-tpdm: Add nodes to set trigger timestamp and type
Date:   Tue, 20 Jun 2023 15:32:35 +0800
Message-ID: <1687246361-23607-8-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687246361-23607-1-git-send-email-quic_taozha@quicinc.com>
References: <1687246361-23607-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1lDUvVoPB8hxz1-KFm1CLmVVnMi_5UAi
X-Proofpoint-ORIG-GUID: 1lDUvVoPB8hxz1-KFm1CLmVVnMi_5UAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306200067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 24 ++++++
 drivers/hwtracing/coresight/coresight-tpdm.c       | 94 ++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index dbc2fbd0..0b7b4ad 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -21,3 +21,27 @@ Description:
 
 		Accepts only one value -  1.
 		1 : Reset the dataset of the tpdm
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_type
+Date:		March 2023
+KernelVersion	6.5
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Set the trigger type of DSB tpdm. Read the trigger
+		type of DSB tpdm.
+
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Set the DSB trigger type to false
+		1 : Set the DSB trigger type to true
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_ts
+Date:		March 2023
+KernelVersion	6.5
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Set the trigger timestamp of DSB tpdm. Read the
+		trigger timestamp of DSB tpdm.
+
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Set the DSB trigger type to false
+		1 : Set the DSB trigger type to true
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index acc3eea..62efc18 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -20,6 +20,18 @@
 
 DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
 
+static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
+					   struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (drvdata && (drvdata->datasets & TPDM_PIDR0_DS_DSB))
+		return attr->mode;
+
+	return 0;
+}
+
 static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
 {
 	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
@@ -229,8 +241,90 @@ static struct attribute_group tpdm_attr_grp = {
 	.attrs = tpdm_attrs,
 };
 
+static ssize_t dsb_trig_type_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			 (unsigned int)drvdata->dsb->trig_type);
+}
+
+/*
+ * Trigger type (boolean):
+ * false - Disable trigger type.
+ * true  - Enable trigger type.
+ */
+static ssize_t dsb_trig_type_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
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
+				     struct device_attribute *attr, char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			 (unsigned int)drvdata->dsb->trig_ts);
+}
+
+/*
+ * Trigger timestamp (boolean):
+ * false - Disable trigger timestamp.
+ * true  - Enable trigger timestamp.
+ */
+static ssize_t dsb_trig_ts_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
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
+
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

