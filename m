Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAED866A49C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjAMUyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjAMUyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:54:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457D189BDF;
        Fri, 13 Jan 2023 12:53:44 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DJuUn5003597;
        Fri, 13 Jan 2023 20:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=G8bRvgTvCFP7YI0Tt9Pou9pLifJZ62SsKsrcI25hSiU=;
 b=BNFQikd79QN/9yiAM8gYt/ZVzzq9NRi8DncwLS1GulqoC/r+pCD83oqRfxPye/dFtt0X
 hjqrAh0ZJGJa7K1FHD6zh2kVxN/trGU7KzKq5xayyfrFI42AEzmoZPSPtBkCjAA1cIWk
 miyjzvD5w6PLTRtxJCrfJFMbNAjSNwRGvwpz73BtS+MY63VN6psg6BEB0WppLH2r+QZM
 /N2vD7WG5/G/YWYvR86PTNmrdmBcILnZDyRpMErcR/t2jyqyZ/lVofJymrccYiAkcFfq
 lyOzYRZqu1zpZQ0Z2trB1aFLHd3kejnpp8LwW14TMemR8IwXSFRx9QHXYKjuj3ifrMV0 VQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2s0ctq6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 20:53:26 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DKrPmF024770
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 20:53:25 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 12:53:24 -0800
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Eric Biggers <ebiggers@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v13 13/15] ufs: mcq: Add completion support of a cqe
Date:   Fri, 13 Jan 2023 12:48:50 -0800
Message-ID: <51a0ff60e4800e8366d9f0039a953079e2742d52.1673557949.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1673557949.git.quic_asutoshd@quicinc.com>
References: <cover.1673557949.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2pCks_JEcjuC7VVz_DvBq4odgpewws5L
X-Proofpoint-GUID: 2pCks_JEcjuC7VVz_DvBq4odgpewws5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for completing requests from Completion Queue.
Some host controllers support vendor specific registers
that provide a bitmap of all CQ's which have at least one
completed CQE. Add this support.
The MCQ specification doesn't provide the Task Tag or its
equivalent in the Completion Queue Entry.
So use an indirect method to find the Task Tag from the
Completion Queue Entry.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c     | 61 ++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h | 43 +++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c      | 37 +++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.c    | 14 ++++++++++
 drivers/ufs/host/ufs-qcom.h    |  4 +++
 include/ufs/ufshcd.h           |  7 +++++
 include/ufs/ufshci.h           |  3 +++
 7 files changed, 169 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index be84bce..cd10d59 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -25,6 +25,7 @@
 #define MCQ_CFG_MAC_MASK	GENMASK(16, 8)
 #define MCQ_QCFG_SIZE		0x40
 #define MCQ_ENTRY_SIZE_IN_DWORD	8
+#define CQE_UCD_BA GENMASK_ULL(63, 7)
 
 static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
 {
@@ -236,6 +237,63 @@ static void __iomem *mcq_opr_base(struct ufs_hba *hba,
 	return opr->base + opr->stride * i;
 }
 
+u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i)
+{
+	return readl(mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIS);
+}
+
+void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i)
+{
+	writel(val, mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIS);
+}
+
+/*
+ * Current MCQ specification doesn't provide a Task Tag or its equivalent in
+ * the Completion Queue Entry. Find the Task Tag using an indirect method.
+ */
+static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
+				     struct ufs_hw_queue *hwq,
+				     struct cq_entry *cqe)
+{
+	u64 addr;
+
+	/* sizeof(struct utp_transfer_cmd_desc) must be a multiple of 128 */
+	BUILD_BUG_ON(sizeof(struct utp_transfer_cmd_desc) & GENMASK(6, 0));
+
+	/* Bits 63:7 UCD base address, 6:5 are reserved, 4:0 is SQ ID */
+	addr = (le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA) -
+		hba->ucdl_dma_addr;
+
+	return div_u64(addr, sizeof(struct utp_transfer_cmd_desc));
+}
+
+static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
+					    struct ufs_hw_queue *hwq)
+{
+	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
+	int tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
+
+	ufshcd_compl_one_cqe(hba, tag, cqe);
+}
+
+unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+					 struct ufs_hw_queue *hwq)
+{
+	unsigned long completed_reqs = 0;
+
+	ufshcd_mcq_update_cq_tail_slot(hwq);
+	while (!ufshcd_mcq_is_cq_empty(hwq)) {
+		ufshcd_mcq_process_cqe(hba, hwq);
+		ufshcd_mcq_inc_cq_head_slot(hwq);
+		completed_reqs++;
+	}
+
+	if (completed_reqs)
+		ufshcd_mcq_update_cq_head(hwq);
+
+	return completed_reqs;
+}
+
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
 {
 	struct ufs_hw_queue *hwq;
@@ -279,6 +337,9 @@ void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
 		hwq->mcq_cq_head = mcq_opr_base(hba, OPR_CQD, i) + REG_CQHP;
 		hwq->mcq_cq_tail = mcq_opr_base(hba, OPR_CQD, i) + REG_CQTP;
 
+		/* Reinitializing is needed upon HC reset */
+		hwq->sq_tail_slot = hwq->cq_tail_slot = hwq->cq_head_slot = 0;
+
 		/* Enable Tail Entry Push Status interrupt only for non-poll queues */
 		if (i < hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL])
 			writel(1, mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIE);
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index e87ce19..583fb86 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -69,6 +69,10 @@ int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
 void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
 void ufshcd_mcq_select_mcq_mode(struct ufs_hba *hba);
+u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
+void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
+unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+					 struct ufs_hw_queue *hwq);
 struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 					   struct request *req);
 
@@ -264,6 +268,15 @@ static inline int ufshcd_mcq_vops_op_runtime_config(struct ufs_hba *hba)
 	return -EOPNOTSUPP;
 }
 
+static inline int ufshcd_vops_get_outstanding_cqs(struct ufs_hba *hba,
+						  unsigned long *ocqs)
+{
+	if (hba->vops && hba->vops->get_outstanding_cqs)
+		return hba->vops->get_outstanding_cqs(hba, ocqs);
+
+	return -EOPNOTSUPP;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
@@ -350,4 +363,34 @@ static inline void ufshcd_inc_sq_tail(struct ufs_hw_queue *q)
 	writel(val, q->mcq_sq_tail);
 }
 
+static inline void ufshcd_mcq_update_cq_tail_slot(struct ufs_hw_queue *q)
+{
+	u32 val = readl(q->mcq_cq_tail);
+
+	q->cq_tail_slot = val / sizeof(struct cq_entry);
+}
+
+static inline bool ufshcd_mcq_is_cq_empty(struct ufs_hw_queue *q)
+{
+	return q->cq_head_slot == q->cq_tail_slot;
+}
+
+static inline void ufshcd_mcq_inc_cq_head_slot(struct ufs_hw_queue *q)
+{
+	q->cq_head_slot++;
+	if (q->cq_head_slot == q->max_entries)
+		q->cq_head_slot = 0;
+}
+
+static inline void ufshcd_mcq_update_cq_head(struct ufs_hw_queue *q)
+{
+	writel(q->cq_head_slot * sizeof(struct cq_entry), q->mcq_cq_head);
+}
+
+static inline struct cq_entry *ufshcd_mcq_cur_cqe(struct ufs_hw_queue *q)
+{
+	struct cq_entry *cqe = q->cqe_base_addr;
+
+	return cqe + q->cq_head_slot;
+}
 #endif /* _UFSHCD_PRIV_H_ */
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3494737..3afa076 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6684,6 +6684,40 @@ static irqreturn_t ufshcd_tmc_handler(struct ufs_hba *hba)
 }
 
 /**
+ * ufshcd_handle_mcq_cq_events - handle MCQ completion queue events
+ * @hba: per adapter instance
+ *
+ * Returns IRQ_HANDLED if interrupt is handled
+ */
+static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
+{
+	struct ufs_hw_queue *hwq;
+	unsigned long outstanding_cqs;
+	unsigned int nr_queues;
+	int i, ret;
+	u32 events;
+
+	ret = ufshcd_vops_get_outstanding_cqs(hba, &outstanding_cqs);
+	if (ret)
+		outstanding_cqs = (1U << hba->nr_hw_queues) - 1;
+
+	/* Exclude the poll queues */
+	nr_queues = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
+	for_each_set_bit(i, &outstanding_cqs, nr_queues) {
+		hwq = &hba->uhq[i];
+
+		events = ufshcd_mcq_read_cqis(hba, i);
+		if (events)
+			ufshcd_mcq_write_cqis(hba, events, i);
+
+		if (events & UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS)
+			ufshcd_mcq_poll_cqe_nolock(hba, hwq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
  * ufshcd_sl_intr - Interrupt service routine
  * @hba: per adapter instance
  * @intr_status: contains interrupts generated by the controller
@@ -6708,6 +6742,9 @@ static irqreturn_t ufshcd_sl_intr(struct ufs_hba *hba, u32 intr_status)
 	if (intr_status & UTP_TRANSFER_REQ_COMPL)
 		retval |= ufshcd_transfer_req_compl(hba);
 
+	if (intr_status & MCQ_CQ_EVENT_STATUS)
+		retval |= ufshcd_handle_mcq_cq_events(hba);
+
 	return retval;
 }
 
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index e828b87..19b1814 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1525,6 +1525,19 @@ static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
 	return MAX_SUPP_MAC;
 }
 
+static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
+					unsigned long *ocqs)
+{
+	struct ufshcd_res_info *mcq_vs_res = &hba->res[RES_MCQ_VS];
+
+	if (!mcq_vs_res->base)
+		return -EINVAL;
+
+	*ocqs = readl(mcq_vs_res->base + UFS_MEM_CQIS_VS);
+
+	return 0;
+}
+
 /*
  * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
  *
@@ -1552,6 +1565,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
 	.get_hba_mac		= ufs_qcom_get_hba_mac,
 	.op_runtime_config	= ufs_qcom_op_runtime_config,
+	.get_outstanding_cqs	= ufs_qcom_get_outstanding_cqs,
 };
 
 /**
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 164e18b..8050e21 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -71,6 +71,10 @@ enum {
 	UFS_UFS_DBG_RD_EDTL_RAM			= 0x1900,
 };
 
+enum {
+	UFS_MEM_CQIS_VS		= 0x8,
+};
+
 #define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
 #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 019b8cf..0dcb104 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -304,6 +304,7 @@ struct ufs_pwr_mode_info {
  * @mcq_config_resource: called to configure MCQ platform resources
  * @get_hba_mac: called to get vendor specific mac value, mandatory for mcq mode
  * @op_runtime_config: called to config Operation and runtime regs Pointers
+ * @get_outstanding_cqs: called to get outstanding completion queues
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -346,6 +347,8 @@ struct ufs_hba_variant_ops {
 	int	(*mcq_config_resource)(struct ufs_hba *hba);
 	int	(*get_hba_mac)(struct ufs_hba *hba);
 	int	(*op_runtime_config)(struct ufs_hba *hba);
+	int	(*get_outstanding_cqs)(struct ufs_hba *hba,
+				       unsigned long *ocqs);
 };
 
 /* clock gating state  */
@@ -1081,6 +1084,8 @@ struct ufs_hba {
  * @id: hardware queue ID
  * @sq_tp_slot: current slot to which SQ tail pointer is pointing
  * @sq_lock: serialize submission queue access
+ * @cq_tail_slot: current slot to which CQ tail pointer is pointing
+ * @cq_head_slot: current slot to which CQ head pointer is pointing
  */
 struct ufs_hw_queue {
 	void __iomem *mcq_sq_head;
@@ -1096,6 +1101,8 @@ struct ufs_hw_queue {
 	u32 id;
 	u32 sq_tail_slot;
 	spinlock_t sq_lock;
+	u32 cq_tail_slot;
+	u32 cq_head_slot;
 };
 
 static inline bool is_mcq_enabled(struct ufs_hba *hba)
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index b6ae571..eca89f9 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -263,6 +263,9 @@ enum {
 /* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
 #define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
 
+/* CQISy - CQ y Interrupt Status Register  */
+#define UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS	0x1
+
 /* UICCMD - UIC Command */
 #define COMMAND_OPCODE_MASK		0xFF
 #define GEN_SELECTOR_INDEX_MASK		0xFFFF
-- 
2.7.4

