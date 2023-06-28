Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFC574114E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjF1MiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:38:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:2428 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231856AbjF1Mgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S7R01Z029236;
        Wed, 28 Jun 2023 12:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=QmPTvnuCX9nTTcTKJzsrAxvtP/T8wK3/aBYs6dPtSDI=;
 b=Ierbl0LvulKXCI+Dz6XQC3UdYbrYlrZS0tR4q0MBlUktdtEqvx2n6tXi379tRuiLGqQs
 ZlaHvQ8KGcrwc9sKDX9vrqc3MJN54GOaLSY3C7LMcZXvXRzqaZXLNbz74Ee9VL5qdgLY
 fGdje59auLxBoEFaZtssqR9Xj/Hzylj0k3N3HmoVWxwc4xP7oIrDs6tUctq78RRSPk1d
 EGqL1ioVGw9FGMYiBSiS+x5KixChWZUJAE/z8cczyVTd8JN/oQG+8euPwE3BIsjTej88
 aXihprM1c18RE9J0k5Cl9RW5yOVD63DMK4V5ne5GoWuQlijZ/WjUOGb7Re05LtyA0O0S DA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgbfss8d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:36 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCZZpe029190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:35 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:35:27 -0700
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
Subject: [PATCH v4 03/21] soc: qcom: Add qcom_minidump_smem module
Date:   Wed, 28 Jun 2023 18:04:30 +0530
Message-ID: <1687955688-20809-4-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: 8vbZ3mHqD4PnjLNlGLMFmmrv47sJ7uZj
X-Proofpoint-ORIG-GUID: 8vbZ3mHqD4PnjLNlGLMFmmrv47sJ7uZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom_minidump_smem module in a preparation to remove smem
based minidump specific code from driver/remoteproc/qcom_common.c
and provide needed exported API, this abstract minidump specific
data layout from qualcomm's remoteproc driver.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/Kconfig              |   8 ++
 drivers/soc/qcom/qcom_minidump_smem.c | 147 ++++++++++++++++++++++++++++++++++
 include/soc/qcom/qcom_minidump.h      |  24 ++++++
 3 files changed, 179 insertions(+)
 create mode 100644 drivers/soc/qcom/qcom_minidump_smem.c
 create mode 100644 include/soc/qcom/qcom_minidump.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a491718f8064..982310b5a1cb 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -279,4 +279,12 @@ config QCOM_INLINE_CRYPTO_ENGINE
 	tristate
 	select QCOM_SCM
 
+config QCOM_MINIDUMP_SMEM
+	tristate "QCOM Minidump SMEM (as backend) Support"
+	depends on ARCH_QCOM
+	depends on QCOM_SMEM
+	help
+	  Enablement of core minidump feature is controlled from boot firmware
+	  side, and this config allow linux to query minidump segments associated
+	  with the remote processor and check its validity.
 endmenu
diff --git a/drivers/soc/qcom/qcom_minidump_smem.c b/drivers/soc/qcom/qcom_minidump_smem.c
new file mode 100644
index 000000000000..b588833ea26e
--- /dev/null
+++ b/drivers/soc/qcom/qcom_minidump_smem.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/soc/qcom/smem.h>
+#include <soc/qcom/qcom_minidump.h>
+
+#define MAX_NUM_OF_SS           10
+#define MAX_REGION_NAME_LENGTH  16
+#define SBL_MINIDUMP_SMEM_ID	602
+#define MINIDUMP_REGION_VALID	('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_SS_ENCR_DONE	('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENABLED	('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+
+/**
+ * struct minidump_region - Minidump region
+ * @name		: Name of the region to be dumped
+ * @seq_num:		: Use to differentiate regions with same name.
+ * @valid		: This entry to be dumped (if set to 1)
+ * @address		: Physical address of region to be dumped
+ * @size		: Size of the region
+ */
+struct minidump_region {
+	char	name[MAX_REGION_NAME_LENGTH];
+	__le32	seq_num;
+	__le32	valid;
+	__le64	address;
+	__le64	size;
+};
+
+/**
+ * struct minidump_subsystem - Subsystem's SMEM Table of content
+ * @status : Subsystem toc init status
+ * @enabled : if set to 1, this region would be copied during coredump
+ * @encryption_status: Encryption status for this subsystem
+ * @encryption_required : Decides to encrypt the subsystem regions or not
+ * @region_count : Number of regions added in this subsystem toc
+ * @regions_baseptr : regions base pointer of the subsystem
+ */
+struct minidump_subsystem {
+	__le32	status;
+	__le32	enabled;
+	__le32	encryption_status;
+	__le32	encryption_required;
+	__le32	region_count;
+	__le64	regions_baseptr;
+};
+
+/**
+ * struct minidump_global_toc - Global Table of Content
+ * @status : Global Minidump init status
+ * @md_revision : Minidump revision
+ * @enabled : Minidump enable status
+ * @subsystems : Array of subsystems toc
+ */
+struct minidump_global_toc {
+	__le32				status;
+	__le32				md_revision;
+	__le32				enabled;
+	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
+};
+
+/**
+ * qcom_ss_md_mapped_base() - For getting subsystem iomapped base segment address
+ * for given minidump index.
+ *
+ * @minidump_id: Subsystem minidump index.
+ * @seg_cnt:	 Segment count for a given minidump index
+ *
+ * Return: On success, it returns iomapped base segment address, otherwise NULL on error.
+ */
+void *qcom_ss_md_mapped_base(unsigned int minidump_id, int *seg_cnt)
+{
+	struct minidump_global_toc *toc;
+	struct minidump_subsystem *subsystem;
+
+	/*
+	 * Get global minidump ToC and check if global table
+	 * pointer exists and init is set.
+	 */
+	toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
+	if (IS_ERR(toc) || !toc->status)
+		return NULL;
+
+	/* Get subsystem table of contents using the minidump id */
+	subsystem = &toc->subsystems[minidump_id];
+
+	/**
+	 * Collect minidump if SS ToC is valid and segment table
+	 * is initialized in memory and encryption status is set.
+	 */
+	if (subsystem->regions_baseptr == 0 ||
+	    le32_to_cpu(subsystem->status) != 1 ||
+	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED ||
+	    le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE)
+		return NULL;
+
+	*seg_cnt = le32_to_cpu(subsystem->region_count);
+
+	return ioremap((unsigned long)le64_to_cpu(subsystem->regions_baseptr),
+			*seg_cnt * sizeof(struct minidump_region));
+}
+EXPORT_SYMBOL_GPL(qcom_ss_md_mapped_base);
+
+/**
+ * qcom_ss_valid_segment_info() - Checks segment sanity and gets it's details
+ *
+ * @ptr:  Segment IO-mapped base address.
+ * @i:	  Segment index.
+ * @name: Segment name.
+ * @da:	  Segment physical address.
+ * @size: Segment size.
+ *
+ * Return: It returns 0 on success and 1 if the segment is invalid and negative
+ *	   value on error.
+ */
+int qcom_ss_valid_segment_info(void *ptr, int i, char **name, dma_addr_t *da, size_t *size)
+{
+	struct minidump_region __iomem *tmp;
+	struct minidump_region region;
+
+	if (!ptr)
+		return -EINVAL;
+
+	tmp = ptr;
+	memcpy_fromio(&region, tmp + i, sizeof(region));
+
+	/* If it is not valid region, skip it */
+	if (le32_to_cpu(region.valid) != MINIDUMP_REGION_VALID)
+		return 1;
+
+	*name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
+	if (!*name)
+		return -ENOMEM;
+
+	*da = le64_to_cpu(region.address);
+	*size = le64_to_cpu(region.size);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_ss_valid_segment_info);
+
+MODULE_DESCRIPTION("Qualcomm Minidump SMEM as backend driver");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
new file mode 100644
index 000000000000..d7747c27fd45
--- /dev/null
+++ b/include/soc/qcom/qcom_minidump.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _QCOM_MINIDUMP_H_
+#define _QCOM_MINIDUMP_H_
+
+#if IS_ENABLED(CONFIG_QCOM_MINIDUMP_SMEM)
+void *qcom_ss_md_mapped_base(unsigned int minidump_id, int *seg_cnt);
+int qcom_ss_valid_segment_info(void *ptr, int i, char **name,
+			       dma_addr_t *da, size_t *size);
+#else
+static inline void *qcom_ss_md_mapped_base(unsigned int minidump_id, int *seg_cnt)
+{
+	return NULL;
+}
+static inline int qcom_ss_valid_segment_info(void *ptr, int i, char **name,
+					     dma_addr_t *da, size_t *size)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_QCOM_MINIDUMP_SMEM */
+#endif /* _QCOM_MINIDUMP_H_ */
-- 
2.7.4

