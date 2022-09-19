Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4D15BD26C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiISQsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiISQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:48:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C125E84;
        Mon, 19 Sep 2022 09:48:16 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JFU2ds010970;
        Mon, 19 Sep 2022 16:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=1XdBrH+AhkUaeI967z1Ko6Jl++k36BAjoZcbq8iueco=;
 b=nUwKDFmpukzPBrsSRVT1XPrgFQZ07jj8EGZ7pFU1H2fIuB2eHa/ejwhZbSp2JYuVmjUO
 T1uXwZnhEgg1GvbVGEy/WiNwzRzop1t9OG8tjChYFbTEvvd1pcZpRRFqf2eNulaGnqnG
 4RYaB6pl/UeM0tlnAx+fZtNPNtRE9JOHeOtOtOdoLOWVSj7DajW6LQGDau01WGUg7ybr
 so31FKRqG7oXQMAyYVs7EjjaAzz9nhe20GEaZz0j/xzmGvjGsQwEfYp1xcXdyY9/uFSq
 GEYt8qFWeXlRYgLSKWZ5vS4TWUFr6Z4eNJd2JtEgvPyWuCyhRCgWAcRoE4O5cKVu966o Ng== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6f85h3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 16:48:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JGm9Fk003406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 16:48:09 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 09:48:08 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v1 1/1] remoteproc: qcom: Add sysfs entry to detect device shutdown
Date:   Mon, 19 Sep 2022 09:48:01 -0700
Message-ID: <42d3ab9227ac3d299abcedbbdd68c86e1dd6acce.1663604826.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: azU-nV8ugoeAnzh5BEVhM6NdXRff9g7J
X-Proofpoint-ORIG-GUID: azU-nV8ugoeAnzh5BEVhM6NdXRff9g7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190112
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds a sysfs entry which indicates whether the device is being
shutdown to the qcom remoteproc drivers. This is going to be used in the
following patches.

Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
 drivers/remoteproc/qcom_common.c | 58 ++++++++++++++++++++++++++++++++++++++++
 drivers/remoteproc/qcom_common.h |  1 +
 2 files changed, 59 insertions(+)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 020349f..7959e96 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -87,9 +87,32 @@ struct qcom_ssr_subsystem {
 	struct list_head list;
 };
 
+static struct kobject *sysfs_kobject;
+bool qcom_device_shutdown_in_progress;
+EXPORT_SYMBOL(qcom_device_shutdown_in_progress);
+
 static LIST_HEAD(qcom_ssr_subsystem_list);
 static DEFINE_MUTEX(qcom_ssr_subsys_lock);
 
+static const char * const ssr_timeout_msg = "srcu notifier chain for %s:%s taking too long";
+
+static ssize_t qcom_rproc_shutdown_request_store(struct kobject *kobj, struct kobj_attribute *attr,
+						 const char *buf, size_t count)
+{
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	qcom_device_shutdown_in_progress = val;
+	pr_info("qcom rproc: Device shutdown requested: %s\n", val ? "true" : "false");
+	return count;
+}
+static struct kobj_attribute shutdown_requested_attr = __ATTR(shutdown_in_progress, 0220, NULL,
+							  qcom_rproc_shutdown_request_store);
+
 static void qcom_minidump_cleanup(struct rproc *rproc)
 {
 	struct rproc_dump_segment *entry, *tmp;
@@ -505,5 +528,40 @@ void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr)
 }
 EXPORT_SYMBOL_GPL(qcom_remove_ssr_subdev);
 
+static int __init qcom_common_init(void)
+{
+	int ret = 0;
+
+	qcom_device_shutdown_in_progress = false;
+
+	sysfs_kobject = kobject_create_and_add("qcom_rproc", kernel_kobj);
+	if (!sysfs_kobject) {
+		pr_err("qcom rproc: failed to create sysfs kobject\n");
+		return -EINVAL;
+	}
+
+	ret = sysfs_create_file(sysfs_kobject, &shutdown_requested_attr.attr);
+	if (ret) {
+		pr_err("qcom rproc: failed to create sysfs file\n");
+		goto remove_kobject;
+	}
+
+	return 0;
+
+	sysfs_remove_file(sysfs_kobject, &shutdown_requested_attr.attr);
+remove_kobject:
+	kobject_put(sysfs_kobject);
+	return ret;
+
+}
+module_init(qcom_common_init);
+
+static void __exit qcom_common_exit(void)
+{
+	sysfs_remove_file(sysfs_kobject, &shutdown_requested_attr.attr);
+	kobject_put(sysfs_kobject);
+}
+module_exit(qcom_common_exit);
+
 MODULE_DESCRIPTION("Qualcomm Remoteproc helper driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
index c35adf7..90b79ce 100644
--- a/drivers/remoteproc/qcom_common.h
+++ b/drivers/remoteproc/qcom_common.h
@@ -34,6 +34,7 @@ struct qcom_rproc_ssr {
 };
 
 void qcom_minidump(struct rproc *rproc, unsigned int minidump_id);
+extern bool qcom_device_shutdown_in_progress;
 
 void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink,
 			   const char *ssr_name);
-- 
2.7.4

