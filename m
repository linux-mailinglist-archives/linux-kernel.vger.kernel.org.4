Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5A741119
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjF1Mgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:36:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:44466 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231361AbjF1MgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S5EVNh008250;
        Wed, 28 Jun 2023 12:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=q7eMGPWHW8Qdlj/xARxpF3rf5Aw7Mja6chBsgEl+PdM=;
 b=Lwf88naVZM9rqLg6zUWbsXtU/n4cPzhukm4YcQ4d2+8ehyZ8/UzLHDBmjCk0qQ3mFVIJ
 87D1GTq1QzZHuij4+lksoZQooaLcJtq3KDezaVzDq5koUvTTgP6Auho2kr0GsA3jd2ng
 Nv7+uOtLN6KV/mvsNvdoazjGlFRtwC4r8ulwEO8jwbZCQjD9sm1aw07aWNJTdDub8bPv
 x6IQAsuPXXa3SmBoQNpHQm2+5ZvZKRIWUgb8i22Ge036Y8Esn2kDPPJWe/YHazOqt7a8
 1O/hE7YWxrBlm4q9L9TjkngHlr5Y8QfnF3nbLAoJFDB+VUa+oS0Z3gpRRT/vFzZZXvVO zQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg7x3sksv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:50 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCZnc5023752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:49 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:35:42 -0700
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
Subject: [PATCH v4 05/21] soc: qcom: Add linux minidump smem backend driver support
Date:   Wed, 28 Jun 2023 18:04:32 +0530
Message-ID: <1687955688-20809-6-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: kVGVTzD2a7UtHGXgP73bXyhZaBJfOJMh
X-Proofpoint-GUID: kVGVTzD2a7UtHGXgP73bXyhZaBJfOJMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shared memory based minidump backend driver and hook it
with minidump core (qcom_minidump) by registering SMEM as
backend device.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/Kconfig              |   8 +-
 drivers/soc/qcom/qcom_minidump_smem.c | 231 +++++++++++++++++++++++++++++++++-
 drivers/soc/qcom/smem.c               |   9 ++
 3 files changed, 240 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 874ee8c3efe0..1834213fd652 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -298,8 +298,12 @@ config QCOM_MINIDUMP_SMEM
 	tristate "QCOM Minidump SMEM (as backend) Support"
 	depends on ARCH_QCOM
 	depends on QCOM_SMEM
+	select QCOM_MINIDUMP
 	help
 	  Enablement of core minidump feature is controlled from boot firmware
-	  side, and this config allow linux to query minidump segments associated
-	  with the remote processor and check its validity.
+	  side, and this config allow linux to query and manages minidump
+	  table for remote processors as well as APSS.
+
+	  This config should be enabled if the low level minidump is implemented
+	  as part of SMEM.
 endmenu
diff --git a/drivers/soc/qcom/qcom_minidump_smem.c b/drivers/soc/qcom/qcom_minidump_smem.c
index b588833ea26e..bdc75aa2f518 100644
--- a/drivers/soc/qcom/qcom_minidump_smem.c
+++ b/drivers/soc/qcom/qcom_minidump_smem.c
@@ -2,18 +2,34 @@
 /*
  * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
 #include <linux/soc/qcom/smem.h>
-#include <soc/qcom/qcom_minidump.h>
+
+#include "qcom_minidump_internal.h"
 
 #define MAX_NUM_OF_SS           10
-#define MAX_REGION_NAME_LENGTH  16
 #define SBL_MINIDUMP_SMEM_ID	602
-#define MINIDUMP_REGION_VALID	('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
-#define MINIDUMP_SS_ENCR_DONE	('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
-#define MINIDUMP_SS_ENABLED	('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+
+#define MINIDUMP_REGION_VALID	   ('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_REGION_INVALID	   ('I' << 24 | 'N' << 16 | 'V' << 8 | 'A' << 0)
+#define MINIDUMP_REGION_INIT	   ('I' << 24 | 'N' << 16 | 'I' << 8 | 'T' << 0)
+#define MINIDUMP_REGION_NOINIT	   0
+
+#define MINIDUMP_SS_ENCR_REQ	   (0 << 24 | 'Y' << 16 | 'E' << 8 | 'S' << 0)
+#define MINIDUMP_SS_ENCR_NOTREQ	   (0 << 24 | 0 << 16 | 'N' << 8 | 'R' << 0)
+#define MINIDUMP_SS_ENCR_START	   ('S' << 24 | 'T' << 16 | 'R' << 8 | 'T' << 0)
+#define MINIDUMP_SS_ENCR_DONE	   ('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENABLED	   ('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+
+#define MINIDUMP_APSS_DESC	   0
 
 /**
  * struct minidump_region - Minidump region
@@ -64,6 +80,16 @@ struct minidump_global_toc {
 };
 
 /**
+ * struct minidump_ss_data - Minidump subsystem private data
+ * @md_ss_toc	: Application Subsystem TOC pointer
+ * @md_regions	: Application Subsystem region base pointer
+ */
+struct minidump_ss_data {
+	struct minidump_subsystem	*md_ss_toc;
+	struct minidump_region		*md_regions;
+};
+
+/**
  * qcom_ss_md_mapped_base() - For getting subsystem iomapped base segment address
  * for given minidump index.
  *
@@ -143,5 +169,198 @@ int qcom_ss_valid_segment_info(void *ptr, int i, char **name, dma_addr_t *da, si
 }
 EXPORT_SYMBOL_GPL(qcom_ss_valid_segment_info);
 
+static int smem_md_get_region_index(struct minidump_ss_data *mdss_data,
+				    const struct qcom_minidump_region *region)
+{
+	struct minidump_subsystem *mdss_toc = mdss_data->md_ss_toc;
+	struct minidump_region *mdr;
+	unsigned int i;
+	unsigned int count;
+
+	count = le32_to_cpu(mdss_toc->region_count);
+	for (i = 0; i < count; i++) {
+		mdr = &mdss_data->md_regions[i];
+		if (!strcmp(mdr->name, region->name))
+			return i;
+	}
+
+	return -ENOENT;
+}
+
+static void smem_md_add_region(struct minidump_ss_data *mdss_data,
+			       const struct qcom_minidump_region *region)
+{
+	struct minidump_subsystem *mdss_toc = mdss_data->md_ss_toc;
+	struct minidump_region *mdr;
+	unsigned int region_cnt;
+
+	region_cnt = le32_to_cpu(mdss_toc->region_count);
+	mdr = &mdss_data->md_regions[region_cnt];
+	strscpy(mdr->name, region->name, sizeof(mdr->name));
+	mdr->address = cpu_to_le64(region->phys_addr);
+	mdr->size = cpu_to_le64(region->size);
+	mdr->valid = cpu_to_le32(MINIDUMP_REGION_VALID);
+	region_cnt++;
+	mdss_toc->region_count = cpu_to_le32(region_cnt);
+}
+
+static int smem_md_region_register(struct minidump *md,
+				   const struct qcom_minidump_region *region)
+{
+	struct minidump_ss_data *mdss_data = md->apss_data;
+	struct minidump_subsystem *mdss_toc = mdss_data->md_ss_toc;
+	unsigned int num_region;
+	int ret;
+
+	ret = smem_md_get_region_index(mdss_data, region);
+	if (ret >= 0) {
+		dev_info(md->dev, "%s region is already registered\n", region->name);
+		return -EEXIST;
+	}
+
+	/* Check if there is a room for a new entry */
+	num_region = le32_to_cpu(mdss_toc->region_count);
+	if (num_region >= md->max_region_limit) {
+		dev_err(md->dev, "maximum region limit %u reached\n", num_region);
+		return -ENOSPC;
+	}
+
+	smem_md_add_region(mdss_data, region);
+
+	return 0;
+}
+
+static int smem_md_region_unregister(struct minidump *md,
+				     const struct qcom_minidump_region *region)
+{
+	struct minidump_ss_data *mdss_data = md->apss_data;
+	struct minidump_subsystem *mdss_toc = mdss_data->md_ss_toc;
+	struct minidump_region *mdr;
+	unsigned int region_cnt;
+	unsigned int idx;
+	int ret;
+
+	ret = smem_md_get_region_index(mdss_data, region);
+	if (ret < 0) {
+		dev_err(md->dev, "%s region is not present\n", region->name);
+		return ret;
+	}
+
+	idx = ret;
+	mdr = &mdss_data->md_regions[0];
+	region_cnt = le32_to_cpu(mdss_toc->region_count);
+	/*
+	 * Left shift all the regions exist after this removed region
+	 * index by 1 to fill the gap and zero out the last region
+	 * present at the end.
+	 */
+	memmove(&mdr[idx], &mdr[idx + 1],
+		(region_cnt - idx - 1) * sizeof(struct minidump_region));
+	memset(&mdr[region_cnt - 1], 0, sizeof(struct minidump_region));
+	region_cnt--;
+	mdss_toc->region_count = cpu_to_le32(region_cnt);
+
+	return 0;
+}
+
+static int smem_md_table_init(struct minidump *md)
+{
+	struct minidump_global_toc *mdgtoc;
+	struct minidump_ss_data *mdss_data;
+	struct minidump_subsystem *mdss_toc;
+	size_t size;
+	int ret;
+
+	mdgtoc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, &size);
+	if (IS_ERR(mdgtoc)) {
+		ret = PTR_ERR(mdgtoc);
+		dev_err(md->dev, "Couldn't find minidump smem item: %d\n", ret);
+		return ret;
+	}
+
+	if (size < sizeof(mdgtoc) || !mdgtoc->status) {
+		ret = -EINVAL;
+		dev_err(md->dev, "minidump table is not initialized: %d\n", ret);
+		return ret;
+	}
+
+	mdss_data = devm_kzalloc(md->dev, sizeof(*mdss_data), GFP_KERNEL);
+	if (!mdss_data)
+		return -ENOMEM;
+
+	mdss_data->md_ss_toc = &mdgtoc->subsystems[MINIDUMP_APSS_DESC];
+	mdss_data->md_regions = devm_kcalloc(md->dev, md->max_region_limit,
+					     sizeof(struct minidump_region), GFP_KERNEL);
+	if (!mdss_data->md_regions)
+		return -ENOMEM;
+
+	mdss_toc = mdss_data->md_ss_toc;
+	mdss_toc->regions_baseptr = cpu_to_le64(virt_to_phys(mdss_data->md_regions));
+	mdss_toc->enabled = cpu_to_le32(MINIDUMP_SS_ENABLED);
+	mdss_toc->status = cpu_to_le32(1);
+	mdss_toc->region_count = cpu_to_le32(0);
+
+	/* Tell bootloader not to encrypt the regions of this subsystem */
+	mdss_toc->encryption_status = cpu_to_le32(MINIDUMP_SS_ENCR_DONE);
+	mdss_toc->encryption_required = cpu_to_le32(MINIDUMP_SS_ENCR_NOTREQ);
+	md->apss_data = mdss_data;
+
+	return 0;
+}
+
+static int smem_md_table_exit(struct minidump *md)
+{
+	struct minidump_ss_data *mdss_data;
+
+	mdss_data = md->apss_data;
+	memset(mdss_data->md_ss_toc,
+	       cpu_to_le32(0), sizeof(struct minidump_subsystem));
+
+	return 0;
+}
+
+static struct minidump_ops smem_md_ops = {
+	.md_table_init		= smem_md_table_init,
+	.md_table_exit		= smem_md_table_exit,
+	.md_region_register	= smem_md_region_register,
+	.md_region_unregister	= smem_md_region_unregister,
+};
+
+static int qcom_minidump_smem_probe(struct platform_device *pdev)
+{
+	struct minidump *md;
+
+	md = devm_kzalloc(&pdev->dev, sizeof(*md), GFP_KERNEL);
+	if (!md)
+		return -ENOMEM;
+
+	md->dev = &pdev->dev;
+	md->ops = &smem_md_ops;
+	md->name = "smem";
+	platform_set_drvdata(pdev, md);
+
+	return qcom_minidump_backend_register(md);
+}
+
+static int qcom_minidump_smem_remove(struct platform_device *pdev)
+{
+	struct minidump *md = platform_get_drvdata(pdev);
+
+	qcom_minidump_backend_unregister(md);
+
+	return 0;
+}
+
+static struct platform_driver qcom_minidump_smem_driver = {
+	.probe = qcom_minidump_smem_probe,
+	.remove = qcom_minidump_smem_remove,
+	.driver  = {
+		.name = "qcom-minidump-smem",
+	},
+};
+
+module_platform_driver(qcom_minidump_smem_driver);
+
 MODULE_DESCRIPTION("Qualcomm Minidump SMEM as backend driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:qcom-minidump-smem");
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 6be7ea93c78c..af582aa7f9a3 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -269,6 +269,7 @@ struct smem_region {
  * @partitions: list of partitions of current processor/host
  * @item_count: max accepted item number
  * @socinfo:	platform device pointer
+ * @minidump:	minidump platform device pointer
  * @num_regions: number of @regions
  * @regions:	list of the memory regions defining the shared memory
  */
@@ -279,6 +280,7 @@ struct qcom_smem {
 
 	u32 item_count;
 	struct platform_device *socinfo;
+	struct platform_device *minidump;
 	struct smem_ptable *ptable;
 	struct smem_partition global_partition;
 	struct smem_partition partitions[SMEM_HOST_COUNT];
@@ -1151,11 +1153,18 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (IS_ERR(smem->socinfo))
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
 
+	smem->minidump = platform_device_register_data(&pdev->dev, "qcom-minidump-smem",
+						      PLATFORM_DEVID_NONE, NULL,
+						      0);
+	if (IS_ERR(smem->minidump))
+		dev_dbg(&pdev->dev, "failed to register minidump device\n");
+
 	return 0;
 }
 
 static int qcom_smem_remove(struct platform_device *pdev)
 {
+	platform_device_unregister(__smem->minidump);
 	platform_device_unregister(__smem->socinfo);
 
 	hwspin_lock_free(__smem->hwlock);
-- 
2.7.4

