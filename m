Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931B868EE36
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBHLqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjBHLqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:46:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568B249024;
        Wed,  8 Feb 2023 03:46:00 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318BENio005774;
        Wed, 8 Feb 2023 11:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=KPGYDqcDrr8XsolksFSl7StuBWFEXS8GKvS6LELY/So=;
 b=LVMepOWrh5gj12B/KwX7q1fzF4f9vQV84RDZVWyNOaO4wRxraDqgpM8A6vqxW3ZyNNH4
 iLJWfBVgR4syHwJpjIkUOFO+ptozKEy4KkEWdt6o6OGQt0bVXfFhhnsgpVsYECBNTKHl
 H5T4cMLXZu+b/+FSbTyv2SdxcWbxXm8zLfFMSWVMnaPCBK0tF4YPZukQiWumtNDG8qvm
 3lbHdWQOFYh4kfjhSVWsxrDiHygObWO6+U7elMvbfMQA12G97QViNvzTU7iZGKYWEbWp
 6virG01MN5UQ7FyIaiKRqh7VXUErzrMn8F+L4l/FoJ97siMKektis22pb0OMAhMsNRVu 1Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkk0dkch7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 11:16:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 318BGjjp025145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 11:16:45 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 8 Feb 2023 03:16:44 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH] coresight: core: Add sysfs node to reset all sources and sinks
Date:   Wed, 8 Feb 2023 03:16:30 -0800
Message-ID: <20230208111630.20132-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8JFFtk4EW_OHV7RssK6N495__mAiXY9t
X-Proofpoint-ORIG-GUID: 8JFFtk4EW_OHV7RssK6N495__mAiXY9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_04,2023-02-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs node to reset all the sources and sinks. When mltiple
sources are enabled, write 1 to reset_source_sink node to disable
all sources and sinks.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 106 +++++++++++++++++--
 1 file changed, 99 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index d3bf82c0de1d..06741ed2dee7 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -458,6 +458,28 @@ static bool coresight_disable_source(struct coresight_device *csdev)
 	return !csdev->enable;
 }
 
+/**
+ * coresight_get_source - Get the source from the path
+ *
+ * @path: The list of devices.
+ *
+ * Returns the soruce csdev.
+ *
+ */
+static struct coresight_device *coresight_get_source(struct list_head *path)
+{
+	struct coresight_device *csdev;
+
+	if (!path)
+		return NULL;
+
+	csdev = list_first_entry(path, struct coresight_node, link)->csdev;
+	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
+		return NULL;
+
+	return csdev;
+}
+
 /*
  * coresight_disable_path_from : Disable components in the given path beyond
  * @nd in the list. If @nd is NULL, all the components, except the SOURCE are
@@ -1159,20 +1181,18 @@ int coresight_enable(struct coresight_device *csdev)
 }
 EXPORT_SYMBOL_GPL(coresight_enable);
 
-void coresight_disable(struct coresight_device *csdev)
+static void _coresight_disable(struct coresight_device *csdev)
 {
 	int cpu, ret;
 	struct list_head *path = NULL;
 	u32 hash;
 
-	mutex_lock(&coresight_mutex);
-
 	ret = coresight_validate_source(csdev, __func__);
 	if (ret)
-		goto out;
+		return;
 
 	if (!csdev->enable || !coresight_disable_source(csdev))
-		goto out;
+		return;
 
 	switch (csdev->subtype.source_subtype) {
 	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
@@ -1187,7 +1207,7 @@ void coresight_disable(struct coresight_device *csdev)
 		path = idr_find(&path_idr, hash);
 		if (path == NULL) {
 			pr_err("Path is not found for %s\n", dev_name(&csdev->dev));
-			goto out;
+			return;
 		}
 		idr_remove(&path_idr, hash);
 		break;
@@ -1198,8 +1218,12 @@ void coresight_disable(struct coresight_device *csdev)
 
 	coresight_disable_path(path);
 	coresight_release_path(path);
+}
 
-out:
+void coresight_disable(struct coresight_device *csdev)
+{
+	mutex_lock(&coresight_mutex);
+	_coresight_disable(csdev);
 	mutex_unlock(&coresight_mutex);
 }
 EXPORT_SYMBOL_GPL(coresight_disable);
@@ -1761,8 +1785,76 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
 }
 EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
 
+/*
+ * Set the sink active status to false.
+ */
+static int coresight_reset_sink(struct device *dev, void *data)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+		csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
+		csdev->activated)
+		csdev->activated = false;
+
+	return 0;
+}
+
+static void coresight_reset_all_sink(void)
+{
+	bus_for_each_dev(&coresight_bustype, NULL, NULL, coresight_reset_sink);
+}
+
+static ssize_t reset_source_sink_store(struct bus_type *bus,
+				       const char *buf, size_t size)
+{
+	int id, cpu, ret = 0;
+	unsigned long val;
+	struct coresight_device *csdev;
+	struct list_head *path = NULL;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&coresight_mutex);
+
+	/* Disable all per cpu sources */
+	for_each_present_cpu(cpu) {
+		path = per_cpu(tracer_path, cpu);
+		if (path) {
+			csdev = coresight_get_source(path);
+			if (!csdev)
+				continue;
+		}
+		_coresight_disable(csdev);
+	}
+
+	/* Disable all sources which aren't associated with CPU */
+	idr_for_each_entry (&path_idr, path, id) {
+		csdev = coresight_get_source(path);
+		if (!csdev)
+			continue;
+
+		_coresight_disable(csdev);
+	}
+	/* Reset all activated sinks */
+	coresight_reset_all_sink();
+
+	mutex_unlock(&coresight_mutex);
+	return size;
+}
+static BUS_ATTR_WO(reset_source_sink);
+
+static struct attribute *coresight_reset_source_sink_attrs[] = {
+	&bus_attr_reset_source_sink.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(coresight_reset_source_sink);
+
 struct bus_type coresight_bustype = {
 	.name	= "coresight",
+	.bus_groups	= coresight_reset_source_sink_groups,
 };
 
 static int __init coresight_init(void)
-- 
2.39.0

