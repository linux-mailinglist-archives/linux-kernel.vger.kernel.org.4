Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CD0741154
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjF1Mji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:39:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:43138 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231659AbjF1MhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:37:25 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SCSGE4001841;
        Wed, 28 Jun 2023 12:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=bXAVQ/l1JxtYIrEXFz1M9FxwE6mSfXNtpjd0vCm4a9I=;
 b=H+v+fC/e/Zumcaxk4l3a+nsDLVUDme3xGCs+UaZwDau8NJHhd6EYi2n5C7QjmmapP5PN
 IPwJ5SAFoVDQLNYW951fN5o8oCaqrUK2XtIXRuo4I/kzwF/DYjCqgmb1TWb2QZrXZW/c
 A1Fvu7ElQ2G6guGdq+pOGSW8ExxSM1ieZJ+/HAAO+55ALlDozoquvObfNGgHxura+mA1
 9/g/+gtW31yy5QY/9K8qeSJ6O99tB6Q9K2ibgLtU/XCxLp9qDPvG914muYfjL5FBkeid
 vyO5oXdMRq/UCu8hToRQ4ssEI71yGiPm8weI6Bnlf4lcDtkKLyQ6fF0rf+utxaPeZTH9 NA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgetpgw6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCaiuY008625
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:44 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:36:37 -0700
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
Subject: [PATCH v4 13/21] remoterproc: qcom: refactor to leverage exported minidump symbol
Date:   Wed, 28 Jun 2023 18:04:40 +0530
Message-ID: <1687955688-20809-14-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: c0s6xSyHVbDjNhTuabGX7nTgJRy1rqii
X-Proofpoint-GUID: c0s6xSyHVbDjNhTuabGX7nTgJRy1rqii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need remoteproc code(driver/remoteproc/qcom_common.c)
to know about minidump data structure layout instead it should
better use the minidump exported symbol to get the required
information.

Refactor the qcom_minidump() function and remove the minidump
related data structure from driver/remoteproc/qcom_common.c .

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/remoteproc/qcom_common.c | 142 +++++++--------------------------------
 1 file changed, 25 insertions(+), 117 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 805e525df3b5..24e8b692cd2c 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/soc/qcom/smem.h>
+#include <soc/qcom/qcom_minidump.h>
 
 #include "remoteproc_internal.h"
 #include "qcom_common.h"
@@ -26,61 +27,6 @@
 #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
 #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
 
-#define MAX_NUM_OF_SS           10
-#define MAX_REGION_NAME_LENGTH  16
-#define SBL_MINIDUMP_SMEM_ID	602
-#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
-#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
-#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
-
-/**
- * struct minidump_region - Minidump region
- * @name		: Name of the region to be dumped
- * @seq_num:		: Use to differentiate regions with same name.
- * @valid		: This entry to be dumped (if set to 1)
- * @address		: Physical address of region to be dumped
- * @size		: Size of the region
- */
-struct minidump_region {
-	char	name[MAX_REGION_NAME_LENGTH];
-	__le32	seq_num;
-	__le32	valid;
-	__le64	address;
-	__le64	size;
-};
-
-/**
- * struct minidump_subsystem - Subsystem's SMEM Table of content
- * @status : Subsystem toc init status
- * @enabled : if set to 1, this region would be copied during coredump
- * @encryption_status: Encryption status for this subsystem
- * @encryption_required : Decides to encrypt the subsystem regions or not
- * @region_count : Number of regions added in this subsystem toc
- * @regions_baseptr : regions base pointer of the subsystem
- */
-struct minidump_subsystem {
-	__le32	status;
-	__le32	enabled;
-	__le32	encryption_status;
-	__le32	encryption_required;
-	__le32	region_count;
-	__le64	regions_baseptr;
-};
-
-/**
- * struct minidump_global_toc - Global Table of Content
- * @status : Global Minidump init status
- * @md_revision : Minidump revision
- * @enabled : Minidump enable status
- * @subsystems : Array of subsystems toc
- */
-struct minidump_global_toc {
-	__le32				status;
-	__le32				md_revision;
-	__le32				enabled;
-	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
-};
-
 struct qcom_ssr_subsystem {
 	const char *name;
 	struct srcu_notifier_head notifier_list;
@@ -101,85 +47,47 @@ static void qcom_minidump_cleanup(struct rproc *rproc)
 	}
 }
 
-static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
-			void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
-				void *dest, size_t offset, size_t size))
+void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
+		void (*rproc_dumpfn_t)(struct rproc *rproc,
+		struct rproc_dump_segment *segment, void *dest, size_t offset,
+		size_t size))
 {
-	struct minidump_region __iomem *ptr;
-	struct minidump_region region;
-	int seg_cnt, i;
 	dma_addr_t da;
 	size_t size;
+	int seg_cnt;
 	char *name;
+	void *ptr;
+	int ret;
+	int i;
 
 	if (WARN_ON(!list_empty(&rproc->dump_segments))) {
 		dev_err(&rproc->dev, "dump segment list already populated\n");
-		return -EUCLEAN;
+		return;
 	}
 
-	seg_cnt = le32_to_cpu(subsystem->region_count);
-	ptr = ioremap((unsigned long)le64_to_cpu(subsystem->regions_baseptr),
-		      seg_cnt * sizeof(struct minidump_region));
+	ptr = qcom_ss_md_mapped_base(minidump_id, &seg_cnt);
 	if (!ptr)
-		return -EFAULT;
+		return;
 
 	for (i = 0; i < seg_cnt; i++) {
-		memcpy_fromio(&region, ptr + i, sizeof(region));
-		if (le32_to_cpu(region.valid) == MINIDUMP_REGION_VALID) {
-			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
-			if (!name) {
-				iounmap(ptr);
-				return -ENOMEM;
-			}
-			da = le64_to_cpu(region.address);
-			size = le64_to_cpu(region.size);
-			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
+		ret = qcom_ss_valid_segment_info(ptr, i, &name, &da, &size);
+		if (ret < 0) {
+			iounmap(ptr);
+			dev_err(&rproc->dev,
+				"Failed with error: %d while adding minidump entries\n",
+				ret);
+			goto clean_minidump;
 		}
-	}
-
-	iounmap(ptr);
-	return 0;
-}
-
-void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
-		void (*rproc_dumpfn_t)(struct rproc *rproc,
-		struct rproc_dump_segment *segment, void *dest, size_t offset,
-		size_t size))
-{
-	int ret;
-	struct minidump_subsystem *subsystem;
-	struct minidump_global_toc *toc;
-
-	/* Get Global minidump ToC*/
-	toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
-
-	/* check if global table pointer exists and init is set */
-	if (IS_ERR(toc) || !toc->status) {
-		dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
-		return;
-	}
 
-	/* Get subsystem table of contents using the minidump id */
-	subsystem = &toc->subsystems[minidump_id];
-
-	/**
-	 * Collect minidump if SS ToC is valid and segment table
-	 * is initialized in memory and encryption status is set.
-	 */
-	if (subsystem->regions_baseptr == 0 ||
-	    le32_to_cpu(subsystem->status) != 1 ||
-	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED ||
-	    le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE) {
-		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
-		return;
+		/* if it is a valid segment */
+		if (!ret)
+			rproc_coredump_add_custom_segment(rproc, da, size,
+							  rproc_dumpfn_t, name);
 	}
 
-	ret = qcom_add_minidump_segments(rproc, subsystem, rproc_dumpfn_t);
-	if (ret) {
-		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
-		goto clean_minidump;
-	}
+	iounmap(ptr);
 	rproc_coredump_using_sections(rproc);
+
 clean_minidump:
 	qcom_minidump_cleanup(rproc);
 }
-- 
2.7.4

