Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC375E7118
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIWBH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiIWBHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:07:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1791166E7;
        Thu, 22 Sep 2022 18:07:42 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N0oMjw005920;
        Fri, 23 Sep 2022 01:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2CGX5MvPy4zj/6LsPK0HhUY7aHHfWo+xciiUB+o72v0=;
 b=fqEJiYVHOJNbh87I4xX7o1SjbmFEBxIt46cqpY1Wk9kO4iTaffQun5j7mOOkYLeRcxkg
 4f+FpXNIlrl0ppI8jMxnsnRwV83KU4Mru79d6yRhtPJmCW5DUKukIbzal8qPkfYeHvVG
 sUBisJlR9ADQ0Etaa4KArMcEJu8Bg/iSXRnVvt8dI1NwYoe+Vu+kCKBo2/Ee+fOKOrXk
 q/LKEAJxxY0Sfx3TI2j5cweroSv/hT0Wqz68qcbo8U/y8smEAi2R9WZpw3ctKHdp540b
 o+d7ZKhCDj56v9Nmhdm20I17yrHlG8zJ2bEfpHbgTD1PJe6FgfxZOvsiEs7obeAqFYDG +Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jr8y1usx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 01:07:26 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28N17OAr032090
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 01:07:24 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 18:07:24 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <mani@kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_richardp@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 07/16] ufs: core: mcq: Allocate memory for mcq mode
Date:   Thu, 22 Sep 2022 18:05:14 -0700
Message-ID: <66d2f7b0794b4f95ad8db223408b710d7a5e2b8c.1663894792.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1663894792.git.quic_asutoshd@quicinc.com>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7wYKAIbbPu5AoYZ_MKDmvkaX5TAUilUa
X-Proofpoint-GUID: 7wYKAIbbPu5AoYZ_MKDmvkaX5TAUilUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_16,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209230005
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To read the bqueuedepth, the device descriptor is fetched
in Single Doorbell Mode. This allocated memory may not be
enough for MCQ mode because the number of tags supported
in MCQ mode may be larger than in SDB mode.
Hence, release the memory allocated in SDB mode and allocate
memory for MCQ mode operation.
Defines the ufs hardware queue and Completion Queue Entry.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 59 ++++++++++++++++++++++++++++++++++++++++--
 drivers/ufs/core/ufshcd-priv.h |  1 +
 drivers/ufs/core/ufshcd.c      | 39 +++++++++++++++++++++++++---
 include/ufs/ufshcd.h           | 19 ++++++++++++++
 include/ufs/ufshci.h           | 21 +++++++++++++++
 5 files changed, 134 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index e52066e..e2854a3 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -251,14 +251,69 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 	return 0;
 }
 
+int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
+{
+	struct ufs_hw_queue *hwq;
+	size_t utrdl_size, cqe_size;
+	int i;
+
+	for (i = 0; i < hba->nr_hw_queues; i++) {
+		hwq = &hba->uhq[i];
+
+		utrdl_size = sizeof(struct utp_transfer_req_desc) *
+			     hwq->max_entries;
+		hwq->sqe_base_addr = dmam_alloc_coherent(hba->dev, utrdl_size,
+							 &hwq->sqe_dma_addr,
+							 GFP_KERNEL);
+		if (!hwq->sqe_dma_addr) {
+			dev_err(hba->dev, "SQE allocation failed\n");
+			return -ENOMEM;
+		}
+
+		cqe_size = sizeof(struct cq_entry) * hwq->max_entries;
+		hwq->cqe_base_addr = dmam_alloc_coherent(hba->dev, cqe_size,
+							 &hwq->cqe_dma_addr,
+							 GFP_KERNEL);
+		if (!hwq->cqe_dma_addr) {
+			dev_err(hba->dev, "CQE allocation failed\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 int ufshcd_mcq_init(struct ufs_hba *hba)
 {
-	int ret;
+	int ret, i;
+	struct ufs_hw_queue *hwq;
 
 	ret = ufshcd_mcq_config_nr_queues(hba);
 	if (ret)
 		return ret;
 	ret = ufshcd_mcq_config_resource(hba);
-	return ret;
+	if (ret)
+		return ret;
+
+	hba->uhq = devm_kmalloc(hba->dev,
+				hba->nr_hw_queues * sizeof(struct ufs_hw_queue),
+				GFP_KERNEL);
+	if (!hba->uhq) {
+		dev_err(hba->dev, "Alloc ufs hw queue failed\n");
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	for (i = 0; i < hba->nr_hw_queues; i++) {
+		hwq = &hba->uhq[i];
+		hwq->max_entries = hba->nutrs;
+	}
+
+	/* The very first HW queue is to serve device command */
+	hba->dev_cmd_queue = &hba->uhq[0];
+	/* Give dev_cmd_queue the minimal number of entries */
+	hba->dev_cmd_queue->max_entries = 2;
+
+	return 0;
 }
 
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 6d16beb..f624682 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -52,6 +52,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
 int ufshcd_mcq_init(struct ufs_hba *hba);
 u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
+int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
 
 #define SD_ASCII_STD true
 #define SD_RAW false
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a71b57e..5fc1e5e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3676,6 +3676,8 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 		goto out;
 	}
 
+	if (hba->utmrdl_base_addr)
+		goto skip_utmrdl;
 	/*
 	 * Allocate memory for UTP Task Management descriptors
 	 * UFSHCI requires 1024 byte alignment of UTMRD
@@ -3692,6 +3694,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 		goto out;
 	}
 
+skip_utmrdl:
 	/* Allocate memory for local reference block */
 	hba->lrb = devm_kcalloc(hba->dev,
 				hba->nutrs, sizeof(struct ufshcd_lrb),
@@ -8173,6 +8176,22 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	return ret;
 }
 
+/* SDB - Single Doorbell */
+static void ufshcd_release_sdb_queue(struct ufs_hba *hba, int nutrs)
+{
+	size_t ucdl_size, utrdl_size;
+
+	ucdl_size = sizeof(struct utp_transfer_cmd_desc) * nutrs;
+	dmam_free_coherent(hba->dev, ucdl_size, hba->ucdl_base_addr,
+			   hba->ucdl_dma_addr);
+
+	utrdl_size = sizeof(struct utp_transfer_req_desc) * nutrs;
+	dmam_free_coherent(hba->dev, utrdl_size, hba->utrdl_base_addr,
+			   hba->utrdl_dma_addr);
+
+	devm_kfree(hba->dev, hba->lrb);
+}
+
 static int ufshcd_config_mcq(struct ufs_hba *hba)
 {
 	int ret;
@@ -8180,11 +8199,25 @@ static int ufshcd_config_mcq(struct ufs_hba *hba)
 
 	hba->nutrs = ufshcd_mcq_decide_queue_depth(hba);
 	ret = ufshcd_mcq_init(hba);
-	if (ret) {
-		hba->nutrs = old_nutrs;
-		return ret;
+	if (ret)
+		goto err;
+
+	if (hba->nutrs != old_nutrs) {
+		ufshcd_release_sdb_queue(hba, old_nutrs);
+		ret = ufshcd_memory_alloc(hba);
+		if (ret)
+			goto err;
+		ufshcd_host_memory_configure(hba);
 	}
+
+	ret = ufshcd_mcq_memory_alloc(hba);
+	if (ret)
+		goto err;
+
 	return 0;
+err:
+	hba->nutrs = old_nutrs;
+	return ret;
 }
 
 /**
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 630a0eb..e54d624 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -857,6 +857,8 @@ enum ufshcd_res {
  * @nr_queues: number of Queues of different queue types
  * @res: array of resource info of MCQ registers
  * @mcq_base: Multi circular queue registers base address
+ * @uhq: array of supported hardware queues
+ * @dev_cmd_queue: Queue for issuing device management commands
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -1011,6 +1013,23 @@ struct ufs_hba {
 	unsigned int nr_queues[HCTX_MAX_TYPES];
 	struct ufshcd_res_info_t res[RES_MAX];
 	void __iomem *mcq_base;
+	struct ufs_hw_queue *uhq;
+	struct ufs_hw_queue *dev_cmd_queue;
+};
+
+/**
+ * @sqe_base_addr: submission queue entry base address
+ * @sqe_dma_addr: submission queue dma address
+ * @cqe_base_addr: completion queue base address
+ * @cqe_dma_addr: completion queue dma address
+ * @max_entries: max number of slots in this hardware queue
+ */
+struct ufs_hw_queue {
+	void *sqe_base_addr;
+	dma_addr_t sqe_dma_addr;
+	struct cq_entry *cqe_base_addr;
+	dma_addr_t cqe_dma_addr;
+	u32 max_entries;
 };
 
 static inline bool is_mcq_supported(struct ufs_hba *hba)
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index ca7db49d..7fa8faf 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -490,6 +490,27 @@ struct utp_transfer_req_desc {
 	__le16  prd_table_offset;
 };
 
+struct cq_entry {
+	/* DW 0-1 */
+	__le64 command_desc_base_addr;
+
+	/* DW 2 */
+	__le16  response_upiu_length;
+	__le16  response_upiu_offset;
+
+	/* DW 3 */
+	__le16  prd_table_length;
+	__le16  prd_table_offset;
+
+	/* DW 4 */
+	__le32 status;
+
+	/* DW 5-7 */
+	u32 reserved[3];
+};
+
+static_assert(sizeof(struct cq_entry) == 32);
+
 /*
  * UTMRD structure.
  */
-- 
2.7.4

