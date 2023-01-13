Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAFB66A486
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjAMUwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjAMUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:52:12 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D62E89BD4;
        Fri, 13 Jan 2023 12:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673643131; x=1705179131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kungIzX+BFZpzDRKnR9WQNjIRAjC290lpMD8LZFTedo=;
  b=pp2yQzCAuo4Vda2vcVUWDIo2X1XY/5WI63ek/iEraB9UEAwjb8MlLDvn
   /pmBTgbiDN2VrzOe08dpGIWAZI1wc7AOLSIHL8d/3pjUAf3ojWF2HpoSG
   aQo/GY7w8r7vVXzv1fl8Kfc9/SLAeRBKr5yt+VdeMN4GLmGLnHgwsuJ+V
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jan 2023 12:52:11 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 12:52:10 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 12:52:09 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <beanhuo@micron.com>, Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Eric Biggers <ebiggers@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 07/15] ufs: core: mcq: Allocate memory for mcq mode
Date:   Fri, 13 Jan 2023 12:48:44 -0800
Message-ID: <76fdabebf9abec3fbd6bdc274e0b8ffbbb52e1e7.1673557949.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1673557949.git.quic_asutoshd@quicinc.com>
References: <cover.1673557949.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
Define the ufs hardware queue and Completion Queue Entry.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufs-mcq.c     | 59 ++++++++++++++++++++++++++++++++++++++++--
 drivers/ufs/core/ufshcd-priv.h |  1 +
 drivers/ufs/core/ufshcd.c      | 48 +++++++++++++++++++++++++++++++---
 include/ufs/ufshcd.h           | 20 ++++++++++++++
 include/ufs/ufshci.h           | 22 ++++++++++++++++
 5 files changed, 145 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 2f680ff..c77bc54 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -149,14 +149,69 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
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
+
 int ufshcd_mcq_init(struct ufs_hba *hba)
 {
-	int ret;
+	struct ufs_hw_queue *hwq;
+	int ret, i;
 
 	ret = ufshcd_mcq_config_nr_queues(hba);
 	if (ret)
 		return ret;
 
 	ret = ufshcd_vops_mcq_config_resource(hba);
-	return ret;
+	if (ret)
+		return ret;
+
+	hba->uhq = devm_kzalloc(hba->dev,
+				hba->nr_hw_queues * sizeof(struct ufs_hw_queue),
+				GFP_KERNEL);
+	if (!hba->uhq) {
+		dev_err(hba->dev, "ufs hw queue memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < hba->nr_hw_queues; i++) {
+		hwq = &hba->uhq[i];
+		hwq->max_entries = hba->nutrs;
+	}
+
+	/* The very first HW queue serves device commands */
+	hba->dev_cmd_queue = &hba->uhq[0];
+	/* Give dev_cmd_queue the minimal number of entries */
+	hba->dev_cmd_queue->max_entries = MAX_DEV_CMD_ENTRIES;
+
+	return 0;
 }
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 11076c3..667e601 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -63,6 +63,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
 int ufshcd_mcq_init(struct ufs_hba *hba);
 int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
+int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
 
 #define SD_ASCII_STD true
 #define SD_RAW false
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 5c8570c..9b4d7a9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3720,6 +3720,14 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 	}
 
 	/*
+	 * Skip utmrdl allocation; it may have been
+	 * allocated during first pass and not released during
+	 * MCQ memory allocation.
+	 * See ufshcd_release_sdb_queue() and ufshcd_config_mcq()
+	 */
+	if (hba->utmrdl_base_addr)
+		goto skip_utmrdl;
+	/*
 	 * Allocate memory for UTP Task Management descriptors
 	 * UFSHCI requires 1024 byte alignment of UTMRD
 	 */
@@ -3735,6 +3743,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 		goto out;
 	}
 
+skip_utmrdl:
 	/* Allocate memory for local reference block */
 	hba->lrb = devm_kcalloc(hba->dev,
 				hba->nutrs, sizeof(struct ufshcd_lrb),
@@ -8295,6 +8304,22 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
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
 static int ufshcd_alloc_mcq(struct ufs_hba *hba)
 {
 	int ret;
@@ -8306,12 +8331,29 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
 
 	hba->nutrs = ret;
 	ret = ufshcd_mcq_init(hba);
-	if (ret) {
-		hba->nutrs = old_nutrs;
-		return ret;
+	if (ret)
+		goto err;
+
+	/*
+	 * Previously allocated memory for nutrs may not be enough in MCQ mode.
+	 * Number of supported tags in MCQ mode may be larger than SDB mode.
+	 */
+	if (hba->nutrs != old_nutrs) {
+		ufshcd_release_sdb_queue(hba, old_nutrs);
+		ret = ufshcd_memory_alloc(hba);
+		if (ret)
+			goto err;
+		ufshcd_host_memory_configure(hba);
 	}
 
+	ret = ufshcd_mcq_memory_alloc(hba);
+	if (ret)
+		goto err;
+
 	return 0;
+err:
+	hba->nutrs = old_nutrs;
+	return ret;
 }
 
 static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 57854bb..311113c8 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -876,6 +876,8 @@ enum ufshcd_res {
  * @mcq_sup: is mcq supported by UFSHC
  * @res: array of resource info of MCQ registers
  * @mcq_base: Multi circular queue registers base address
+ * @uhq: array of supported hardware queues
+ * @dev_cmd_queue: Queue for issuing device management commands
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -1034,6 +1036,24 @@ struct ufs_hba {
 	bool mcq_sup;
 	struct ufshcd_res_info res[RES_MAX];
 	void __iomem *mcq_base;
+	struct ufs_hw_queue *uhq;
+	struct ufs_hw_queue *dev_cmd_queue;
+};
+
+/**
+ * struct ufs_hw_queue - per hardware queue structure
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
 
 #ifdef CONFIG_SCSI_UFS_VARIABLE_SG_ENTRY_SIZE
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 845a82a..0d621e9 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -492,6 +492,28 @@ struct utp_transfer_req_desc {
 	__le16  prd_table_offset;
 };
 
+/* MCQ Completion Queue Entry */
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
+	__le32 reserved[3];
+};
+
+static_assert(sizeof(struct cq_entry) == 32);
+
 /*
  * UTMRD structure.
  */
-- 
2.7.4

