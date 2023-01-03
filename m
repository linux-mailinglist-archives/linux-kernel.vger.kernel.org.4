Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A2565C724
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbjACTO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbjACTOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:14:06 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C761409E;
        Tue,  3 Jan 2023 11:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1672773185; x=1704309185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fW41cdF7gaYN9PDOqpjyowG+kMENc9WOH7T4oS8D4ak=;
  b=QXTOX83O1dgYZ9eTVaCu8Em+1w2lCdhTJ5wblV5yNQQMvlD++GmAJ4gI
   2qB9dfS+ysK+5Tjvvtny3OjxYCH/GM0WUJyN6CYHSSgm64nGybnxKEnDV
   GZX+0j0srQ2VfpB1oD2LUGzDSsDIUoQz9/SymGTivMwF69FuExy5mP8z7
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Jan 2023 11:13:04 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:13:04 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 3 Jan 2023 11:13:04 -0800
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
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Eric Biggers <ebiggers@google.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 08/15] ufs: core: mcq: Configure operation and runtime interface
Date:   Tue, 3 Jan 2023 11:09:27 -0800
Message-ID: <ae7e0ba909effbd61b34cd479aabe3f491374429.1672771664.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1672771664.git.quic_asutoshd@quicinc.com>
References: <cover.1672771664.git.quic_asutoshd@quicinc.com>
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

Runtime and operation registers are defined per Submission
and Completion queue.
The location of these registers is not defined in the spec;
meaning the offsets and stride may vary for different
HC vendors. Establish the stride, base address and doorbell
address offsets from vendor host driver and program it.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufs-mcq.c     | 102 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  11 +++++
 drivers/ufs/core/ufshcd.c      |  27 +++++++++++
 drivers/ufs/host/ufs-qcom.c    |  24 ++++++++++
 include/ufs/ufshcd.h           |  52 +++++++++++++++++++++
 include/ufs/ufshci.h           |  31 +++++++++++++
 6 files changed, 247 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index c77bc54..496e2b6 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -18,9 +18,13 @@
 #define UFS_MCQ_MIN_READ_QUEUES 0
 #define UFS_MCQ_NUM_DEV_CMD_QUEUES 1
 #define UFS_MCQ_MIN_POLL_QUEUES 0
+#define QUEUE_EN_OFFSET 31
+#define QUEUE_ID_OFFSET 16
 
 #define MAX_DEV_CMD_ENTRIES	2
 #define MCQ_CFG_MAC_MASK	GENMASK(16, 8)
+#define MCQ_QCFG_SIZE		0x40
+#define MCQ_ENTRY_SIZE_IN_DWORD	8
 
 static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
 {
@@ -71,6 +75,24 @@ MODULE_PARM_DESC(poll_queues,
 		 "Number of poll queues used for r/w. Default value is 1");
 
 /**
+ * ufshcd_mcq_config_mac - Set the #Max Activ Cmds.
+ * @hba - per adapter instance
+ * @max_active_cmds - maximum # of active commands to the device at any time.
+ *
+ * The controller won't send more than the max_active_cmds to the device at
+ * any time.
+ */
+void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds)
+{
+	u32 val;
+
+	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
+	val &= ~MCQ_CFG_MAC_MASK;
+	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds);
+	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
+}
+
+/**
  * ufshcd_mcq_decide_queue_depth - decide the queue depth
  * @hba - per adapter instance
  *
@@ -182,6 +204,80 @@ int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
 }
 
 
+/* Operation and runtime registers configuration */
+#define MCQ_CFG_n(r, i)	((r) + MCQ_QCFG_SIZE * (i))
+#define MCQ_OPR_OFFSET_n(p, i) \
+	(hba->mcq_opr[(p)].offset + hba->mcq_opr[(p)].stride * (i))
+
+static void __iomem *mcq_opr_base(struct ufs_hba *hba,
+					 enum ufshcd_mcq_opr n, int i)
+{
+	struct ufshcd_mcq_opr_info_t *opr = &hba->mcq_opr[n];
+
+	return opr->base + opr->stride * i;
+}
+
+void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
+{
+	struct ufs_hw_queue *hwq;
+	u16 qsize;
+	int i;
+
+	for (i = 0; i < hba->nr_hw_queues; i++) {
+		hwq = &hba->uhq[i];
+		hwq->id = i;
+		qsize = hwq->max_entries * MCQ_ENTRY_SIZE_IN_DWORD - 1;
+
+		/* Submission Queue Lower Base Address */
+		ufsmcq_writelx(hba, lower_32_bits(hwq->sqe_dma_addr),
+			      MCQ_CFG_n(REG_SQLBA, i));
+		/* Submission Queue Upper Base Address */
+		ufsmcq_writelx(hba, upper_32_bits(hwq->sqe_dma_addr),
+			      MCQ_CFG_n(REG_SQUBA, i));
+		/* Submission Queue Doorbell Address Offset */
+		ufsmcq_writelx(hba, MCQ_OPR_OFFSET_n(OPR_SQD, i),
+			      MCQ_CFG_n(REG_SQDAO, i));
+		/* Submission Queue Interrupt Status Address Offset */
+		ufsmcq_writelx(hba, MCQ_OPR_OFFSET_n(OPR_SQIS, i),
+			      MCQ_CFG_n(REG_SQISAO, i));
+
+		/* Completion Queue Lower Base Address */
+		ufsmcq_writelx(hba, lower_32_bits(hwq->cqe_dma_addr),
+			      MCQ_CFG_n(REG_CQLBA, i));
+		/* Completion Queue Upper Base Address */
+		ufsmcq_writelx(hba, upper_32_bits(hwq->cqe_dma_addr),
+			      MCQ_CFG_n(REG_CQUBA, i));
+		/* Completion Queue Doorbell Address Offset */
+		ufsmcq_writelx(hba, MCQ_OPR_OFFSET_n(OPR_CQD, i),
+			      MCQ_CFG_n(REG_CQDAO, i));
+		/* Completion Queue Interrupt Status Address Offset */
+		ufsmcq_writelx(hba, MCQ_OPR_OFFSET_n(OPR_CQIS, i),
+			      MCQ_CFG_n(REG_CQISAO, i));
+
+		/* Save the base addresses for quicker access */
+		hwq->mcq_sq_head = mcq_opr_base(hba, OPR_SQD, i) + REG_SQHP;
+		hwq->mcq_sq_tail = mcq_opr_base(hba, OPR_SQD, i) + REG_SQTP;
+		hwq->mcq_cq_head = mcq_opr_base(hba, OPR_CQD, i) + REG_CQHP;
+		hwq->mcq_cq_tail = mcq_opr_base(hba, OPR_CQD, i) + REG_CQTP;
+
+		/* Enable Tail Entry Push Status interrupt only for non-poll queues */
+		if (i < hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL])
+			writel(1, mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIE);
+
+		/* Completion Queue Enable|Size to Completion Queue Attribute */
+		ufsmcq_writel(hba, (1 << QUEUE_EN_OFFSET) | qsize,
+			      MCQ_CFG_n(REG_CQATTR, i));
+
+		/*
+		 * Submission Qeueue Enable|Size|Completion Queue ID to
+		 * Submission Queue Attribute
+		 */
+		ufsmcq_writel(hba, (1 << QUEUE_EN_OFFSET) | qsize |
+			      (i << QUEUE_ID_OFFSET),
+			      MCQ_CFG_n(REG_SQATTR, i));
+	}
+}
+
 int ufshcd_mcq_init(struct ufs_hba *hba)
 {
 	struct ufs_hw_queue *hwq;
@@ -195,6 +291,12 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
+	ret = ufshcd_mcq_vops_op_runtime_config(hba);
+	if (ret) {
+		dev_err(hba->dev, "Operation runtime config failed, ret=%d\n",
+			ret);
+		return ret;
+	}
 	hba->uhq = devm_kzalloc(hba->dev,
 				hba->nr_hw_queues * sizeof(struct ufs_hw_queue),
 				GFP_KERNEL);
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 6c3c078..00c914c 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -64,6 +64,9 @@ void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
 int ufshcd_mcq_init(struct ufs_hba *hba);
 int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
 int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
+void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
+void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
+void ufshcd_mcq_select_mcq_mode(struct ufs_hba *hba);
 
 #define SD_ASCII_STD true
 #define SD_RAW false
@@ -242,6 +245,14 @@ static inline int ufshcd_mcq_vops_get_hba_mac(struct ufs_hba *hba)
 	return -EOPNOTSUPP;
 }
 
+static inline int ufshcd_mcq_vops_op_runtime_config(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->op_runtime_config)
+		return hba->vops->op_runtime_config(hba);
+
+	return -EOPNOTSUPP;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c4f75a4..bd80ce6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -43,6 +43,12 @@
 #define UFSHCD_ENABLE_INTRS	(UTP_TRANSFER_REQ_COMPL |\
 				 UTP_TASK_REQ_COMPL |\
 				 UFSHCD_ERROR_MASK)
+
+#define UFSHCD_ENABLE_MCQ_INTRS	(UTP_TASK_REQ_COMPL |\
+				 UFSHCD_ERROR_MASK |\
+				 MCQ_CQ_EVENT_STATUS)
+
+
 /* UIC command timeout, unit: ms */
 #define UIC_CMD_TIMEOUT	500
 
@@ -8356,6 +8362,20 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
 	return ret;
 }
 
+static void ufshcd_config_mcq(struct ufs_hba *hba)
+{
+	ufshcd_enable_intr(hba, UFSHCD_ENABLE_MCQ_INTRS);
+	ufshcd_mcq_make_queues_operational(hba);
+	ufshcd_mcq_config_mac(hba, hba->nutrs);
+
+	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
+	hba->reserved_slot = hba->nutrs - UFSHCD_NUM_RESERVED;
+	dev_info(hba->dev, "MCQ configured, nr_queues=%d, io_queues=%d, read_queue=%d, poll_queues=%d, queue_depth=%d\n",
+		 hba->nr_hw_queues, hba->nr_queues[HCTX_TYPE_DEFAULT],
+		 hba->nr_queues[HCTX_TYPE_READ], hba->nr_queues[HCTX_TYPE_POLL],
+		 hba->nutrs);
+}
+
 /**
  * ufshcd_probe_hba - probe hba to detect device and initialize it
  * @hba: per-adapter instance
@@ -8385,6 +8405,10 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	/* UniPro link is active now */
 	ufshcd_set_link_active(hba);
 
+	/* Reconfigure MCQ upon reset */
+	if (is_mcq_enabled(hba) && !init_dev_params)
+		ufshcd_config_mcq(hba);
+
 	/* Verify device initialization by sending NOP OUT UPIU */
 	ret = ufshcd_verify_dev_init(hba);
 	if (ret)
@@ -8417,6 +8441,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 				dev_err(hba->dev, "scsi_add_host failed\n");
 				goto out;
 			}
+			/* MCQ may be disabled if ufshcd_alloc_mcq() fails */
+			if (use_mcq_mode)
+				ufshcd_config_mcq(hba);
 		}
 	}
 
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 10da087..8dddd2d 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1485,6 +1485,29 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 	return ret;
 }
 
+static int ufs_qcom_op_runtime_config(struct ufs_hba *hba)
+{
+	struct ufshcd_res_info *mem_res, *sqdao_res;
+	struct ufshcd_mcq_opr_info_t *opr;
+	int i;
+
+	mem_res = &hba->res[RES_UFS];
+	sqdao_res = &hba->res[RES_MCQ_SQD];
+
+	if (!mem_res->base || !sqdao_res->base)
+		return -EINVAL;
+
+	for (i = 0; i < OPR_MAX; i++) {
+		opr = &hba->mcq_opr[i];
+		opr->offset = sqdao_res->resource->start -
+			      mem_res->resource->start + 0x40 * i;
+		opr->stride = 0x100;
+		opr->base = sqdao_res->base + 0x40 * i;
+	}
+
+	return 0;
+}
+
 static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
 {
 	/* Qualcomm HC supports up to 64 */
@@ -1516,6 +1539,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.program_key		= ufs_qcom_ice_program_key,
 	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
 	.get_hba_mac		= ufs_qcom_get_hba_mac,
+	.op_runtime_config	= ufs_qcom_op_runtime_config,
 };
 
 /**
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 884b5c13..65feb38 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -300,6 +300,7 @@ struct ufs_pwr_mode_info {
  * @event_notify: called to notify important events
  * @mcq_config_resource: called to configure MCQ platform resources
  * @get_hba_mac: called to get vendor specific mac value, mandatory for mcq mode
+ * @op_runtime_config: called to config Operation and runtime regs Pointers
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -340,6 +341,7 @@ struct ufs_hba_variant_ops {
 				enum ufs_event_type evt, void *data);
 	int	(*mcq_config_resource)(struct ufs_hba *hba);
 	int	(*get_hba_mac)(struct ufs_hba *hba);
+	int	(*op_runtime_config)(struct ufs_hba *hba);
 };
 
 /* clock gating state  */
@@ -753,6 +755,27 @@ enum ufshcd_res {
 };
 
 /**
+ * struct ufshcd_mcq_opr_info_t - Operation and Runtime registers
+ *
+ * @offset: Doorbell Address Offset
+ * @stride: Steps proportional to queue [0...31]
+ * @base: base address
+ */
+struct ufshcd_mcq_opr_info_t {
+	unsigned long offset;
+	unsigned long stride;
+	void __iomem *base;
+};
+
+enum ufshcd_mcq_opr {
+	OPR_SQD,
+	OPR_SQIS,
+	OPR_CQD,
+	OPR_CQIS,
+	OPR_MAX,
+};
+
+/**
  * struct ufs_hba - per adapter private structure
  * @mmio_base: UFSHCI base register address
  * @ucdl_base_addr: UFS Command Descriptor base address
@@ -865,6 +888,7 @@ enum ufshcd_res {
  *	ufshcd_resume_complete()
  * @ext_iid_sup: is EXT_IID is supported by UFSHC
  * @mcq_sup: is mcq supported by UFSHC
+ * @mcq_enabled: is mcq ready to accept requests
  * @res: array of resource info of MCQ registers
  * @mcq_base: Multi circular queue registers base address
  * @uhq: array of supported hardware queues
@@ -1024,28 +1048,46 @@ struct ufs_hba {
 	bool complete_put;
 	bool ext_iid_sup;
 	bool mcq_sup;
+	bool mcq_enabled;
 	struct ufshcd_res_info res[RES_MAX];
 	void __iomem *mcq_base;
 	struct ufs_hw_queue *uhq;
 	struct ufs_hw_queue *dev_cmd_queue;
+	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
 };
 
 /**
  * struct ufs_hw_queue - per hardware queue structure
+ * @mcq_sq_head: base address of submission queue head pointer
+ * @mcq_sq_tail: base address of submission queue tail pointer
+ * @mcq_cq_head: base address of completion queue head pointer
+ * @mcq_cq_tail: base address of completion queue tail pointer
  * @sqe_base_addr: submission queue entry base address
  * @sqe_dma_addr: submission queue dma address
  * @cqe_base_addr: completion queue base address
  * @cqe_dma_addr: completion queue dma address
  * @max_entries: max number of slots in this hardware queue
+ * @id: hardware queue ID
  */
 struct ufs_hw_queue {
+	void __iomem *mcq_sq_head;
+	void __iomem *mcq_sq_tail;
+	void __iomem *mcq_cq_head;
+	void __iomem *mcq_cq_tail;
+
 	void *sqe_base_addr;
 	dma_addr_t sqe_dma_addr;
 	struct cq_entry *cqe_base_addr;
 	dma_addr_t cqe_dma_addr;
 	u32 max_entries;
+	u32 id;
 };
 
+static inline bool is_mcq_enabled(struct ufs_hba *hba)
+{
+	return hba->mcq_enabled;
+}
+
 #ifdef CONFIG_SCSI_UFS_VARIABLE_SG_ENTRY_SIZE
 static inline size_t ufshcd_sg_entry_size(const struct ufs_hba *hba)
 {
@@ -1127,6 +1169,16 @@ static inline bool ufshcd_enable_wb_if_scaling_up(struct ufs_hba *hba)
 	return hba->caps & UFSHCD_CAP_WB_WITH_CLK_SCALING;
 }
 
+#define ufsmcq_writel(hba, val, reg)	\
+	writel((val), (hba)->mcq_base + (reg))
+#define ufsmcq_readl(hba, reg)	\
+	readl((hba)->mcq_base + (reg))
+
+#define ufsmcq_writelx(hba, val, reg)	\
+	writel_relaxed((val), (hba)->mcq_base + (reg))
+#define ufsmcq_readlx(hba, reg)	\
+	readl_relaxed((hba)->mcq_base + (reg))
+
 #define ufshcd_writel(hba, val, reg)	\
 	writel((val), (hba)->mmio_base + (reg))
 #define ufshcd_readl(hba, reg)	\
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 0d621e9..b6ae571 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -57,6 +57,7 @@ enum {
 	REG_UFS_CCAP				= 0x100,
 	REG_UFS_CRYPTOCAP			= 0x104,
 
+	REG_UFS_MEM_CFG				= 0x300,
 	REG_UFS_MCQ_CFG				= 0x380,
 	UFSHCI_CRYPTO_REG_SPACE_SIZE		= 0x400,
 };
@@ -79,6 +80,35 @@ enum {
 	MASK_EXT_IID_SUPPORT = 0x00000400,
 };
 
+enum {
+	REG_SQATTR		= 0x0,
+	REG_SQLBA		= 0x4,
+	REG_SQUBA		= 0x8,
+	REG_SQDAO		= 0xC,
+	REG_SQISAO		= 0x10,
+
+	REG_CQATTR		= 0x20,
+	REG_CQLBA		= 0x24,
+	REG_CQUBA		= 0x28,
+	REG_CQDAO		= 0x2C,
+	REG_CQISAO		= 0x30,
+};
+
+enum {
+	REG_SQHP		= 0x0,
+	REG_SQTP		= 0x4,
+};
+
+enum {
+	REG_CQHP		= 0x0,
+	REG_CQTP		= 0x4,
+};
+
+enum {
+	REG_CQIS		= 0x0,
+	REG_CQIE		= 0x4,
+};
+
 #define UFS_MASK(mask, offset)		((mask) << (offset))
 
 /* UFS Version 08h */
@@ -135,6 +165,7 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 #define CONTROLLER_FATAL_ERROR			0x10000
 #define SYSTEM_BUS_FATAL_ERROR			0x20000
 #define CRYPTO_ENGINE_FATAL_ERROR		0x40000
+#define MCQ_CQ_EVENT_STATUS			0x100000
 
 #define UFSHCD_UIC_HIBERN8_MASK	(UIC_HIBERNATE_ENTER |\
 				UIC_HIBERNATE_EXIT)
-- 
2.7.4

