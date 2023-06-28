Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7FD741143
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjF1Mgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:36:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:45604 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229935AbjF1MgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:16 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S9nKm9003322;
        Wed, 28 Jun 2023 12:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tS6lGkX8CHBycfdhWdiPwgr8+XHLSbQNBox00mN4HUE=;
 b=NW1gxG4wdwB9zb7phKTlbtE9dXGtJywK9EsSLPiHVS6Xfe6Zv4fnVOGZifwagqncS35k
 K8mUvEtPLQVGYKPRzKk3KySiTvZluAvPP+r44P6kgiP6tIKIOwbEIC6IxtWOGsUc0JNW
 c82V7+kpdlb9q7kVoa7L/GuyP3XXT6qXf5o8llyJLXfOYShkNgZey7kCKe21QZEz6kFu
 S9Bwx0e195ZZ2XEU1llwL5pgB0IyPJaTwGZW2Qafymff8pH67pgFGX6ts1sVVSkMEfNO
 fAk82ps+QH//S+nE2gs0+h7kyB6uUfeVw0v+zBhUoyFW/4dUowHimz0PU/Rv8qGMro2n Fg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg9pb1ese-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:57 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCZuhK029721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:56 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:35:49 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v4 06/21] soc: qcom: minidump: Add pending region registration support
Date:   Wed, 28 Jun 2023 18:04:33 +0530
Message-ID: <1687955688-20809-7-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n2xHEv_GvbGRgwFkrml1q7DhTpJMKIKO
X-Proofpoint-ORIG-GUID: n2xHEv_GvbGRgwFkrml1q7DhTpJMKIKO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pending regions are those apss minidump regions which came for
registration before minidump was initialized or ready to do
register the region.

We can add regions to pending region list and register them from
apss minidump driver probe in one go.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/qcom_minidump.c          | 87 ++++++++++++++++++++++++++++---
 drivers/soc/qcom/qcom_minidump_internal.h | 20 +++++++
 2 files changed, 99 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
index 7744e57843ab..cfdb63cc29d6 100644
--- a/drivers/soc/qcom/qcom_minidump.c
+++ b/drivers/soc/qcom/qcom_minidump.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/kallsyms.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/string.h>
@@ -35,6 +36,10 @@ static DEFINE_MUTEX(md_lock);
 /* Only one front end will be attached to one back-end */
 static struct minidump *md;
 static char *md_backend;
+static struct minidump_plist md_plist = {
+	.plist = LIST_HEAD_INIT(md_plist.plist),
+	.pregion_cnt = 0,
+};
 
 static struct elf_shdr *elf_shdr_entry_addr(struct elfhdr *ehdr, int idx)
 {
@@ -201,6 +206,26 @@ static bool qcom_minidump_valid_region(const struct qcom_minidump_region *region
 		IS_ALIGNED(region->size, 4);
 }
 
+static struct minidump_pregion *
+check_if_pending_region_exist(const struct qcom_minidump_region *region)
+{
+	struct minidump_pregion *md_pregion;
+	struct minidump_pregion *tmp;
+	bool found = false;
+
+	list_for_each_entry_safe(md_pregion, tmp, &md_plist.plist, list) {
+		struct qcom_minidump_region *md_region;
+
+		md_region = &md_pregion->region;
+		if (!strcmp(md_region->name, region->name)) {
+			found = true;
+			break;
+		}
+	}
+
+	return found ? md_pregion : NULL;
+}
+
 /**
  * qcom_minidump_region_register() - Register region in APSS Minidump table.
  * @region: minidump region.
@@ -209,16 +234,40 @@ static bool qcom_minidump_valid_region(const struct qcom_minidump_region *region
  */
 int qcom_minidump_region_register(const struct qcom_minidump_region *region)
 {
-	int ret;
+	struct minidump_pregion *md_pregion;
+	int ret = 0;
 
 	if (!qcom_minidump_valid_region(region))
 		return -EINVAL;
 
 	mutex_lock(&md_lock);
 	if (!md) {
-		mutex_unlock(&md_lock);
-		pr_err("No backend registered yet, try again..");
-		return -EPROBE_DEFER;
+		if (md_plist.pregion_cnt >= MAX_NUM_ENTRIES - 1) {
+			pr_err("maximum region limit %u reached\n", md_plist.pregion_cnt);
+			ret = -ENOSPC;
+			goto unlock;
+		}
+
+		md_pregion = check_if_pending_region_exist(region);
+		if (md_pregion) {
+			pr_info("%s region is already exist\n", region->name);
+			ret = -EEXIST;
+			goto unlock;
+		}
+		/*
+		 * Maintain a list of client regions which came before
+		 * minidump driver was ready and once it is ready,
+		 * register them in one go from minidump probe function.
+		 */
+		md_pregion = kzalloc(sizeof(*md_pregion), GFP_KERNEL);
+		if (!md_pregion) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+		md_pregion->region = *region;
+		list_add_tail(&md_pregion->list, &md_plist.plist);
+		md_plist.pregion_cnt++;
+		goto unlock;
 	}
 
 	ret = md->ops->md_region_register(md, region);
@@ -240,16 +289,22 @@ EXPORT_SYMBOL_GPL(qcom_minidump_region_register);
  */
 int qcom_minidump_region_unregister(const struct qcom_minidump_region *region)
 {
-	int ret;
+	struct minidump_pregion *md_pregion;
+	int ret = 0;
 
 	if (!qcom_minidump_valid_region(region))
 		return -EINVAL;
 
 	mutex_lock(&md_lock);
 	if (!md) {
-		mutex_unlock(&md_lock);
-		pr_err("No backend registered yet, try again..");
-		return -EPROBE_DEFER;
+		md_pregion = check_if_pending_region_exist(region);
+		if (!md_pregion)
+			goto unlock;
+
+		list_del(&md_pregion->list);
+		kfree(md_pregion);
+		md_plist.pregion_cnt--;
+		goto unlock;
 	}
 
 	ret = md->ops->md_region_unregister(md, region);
@@ -378,6 +433,8 @@ static int qcom_minidump_add_elf_header(struct minidump *md_data)
  */
 int qcom_minidump_backend_register(struct minidump *md_data)
 {
+	struct minidump_pregion *md_pregion;
+	struct minidump_pregion *tmp;
 	int ret;
 
 	if (!md_data->name || !md_data->dev ||
@@ -425,6 +482,20 @@ int qcom_minidump_backend_register(struct minidump *md_data)
 	md_backend = kstrdup(md->name, GFP_KERNEL);
 	dev_info(md->dev, "Registered minidump backend : %s\n", md->name);
 
+	list_for_each_entry_safe(md_pregion, tmp, &md_plist.plist, list) {
+		struct qcom_minidump_region *region;
+
+		region = &md_pregion->region;
+		ret = md->ops->md_region_register(md, region);
+		if (ret)
+			goto unlock;
+
+		qcom_md_update_elf_header(region);
+		list_del(&md_pregion->list);
+		kfree(md_pregion);
+		md_plist.pregion_cnt--;
+	}
+
 unlock:
 	mutex_unlock(&md_lock);
 	return ret;
diff --git a/drivers/soc/qcom/qcom_minidump_internal.h b/drivers/soc/qcom/qcom_minidump_internal.h
index 9031b1b0a046..6993e3be10c2 100644
--- a/drivers/soc/qcom/qcom_minidump_internal.h
+++ b/drivers/soc/qcom/qcom_minidump_internal.h
@@ -65,6 +65,26 @@ struct minidump {
 	void				*apss_data;
 };
 
+/**
+ * struct minidump_pregion - Minidump pending region
+ * @list       : Pending region list pointer
+ * @region     : APSS minidump client region
+ */
+struct minidump_pregion {
+	struct list_head	     list;
+	struct qcom_minidump_region  region;
+};
+
+/**
+ * struct minidump_plist - Minidump pending region list
+ * @plist	: List of pending region to be registered
+ * @pregion_cnt	: Count of the pending region to be registered
+ */
+struct minidump_plist {
+	struct list_head  plist;
+	int		  pregion_cnt;
+};
+
 #if IS_ENABLED(CONFIG_QCOM_MINIDUMP)
 int qcom_minidump_backend_register(struct minidump *md);
 void qcom_minidump_backend_unregister(struct minidump *md);
-- 
2.7.4

