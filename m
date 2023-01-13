Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474A566A492
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjAMUxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjAMUxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:53:13 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A78A21E;
        Fri, 13 Jan 2023 12:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673643168; x=1705179168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=blpT889W7c9TW1uvyWfMz/ObnL3DGdA89WRcD38ZZbw=;
  b=JgtL8V/revPwaELnkCqa6Fg6afKZIOzUzdFbDNCGiEvX7SY0S7nOElF9
   eZ8BCSchZ2BFrOtYKUZzD83RkVt3CmHooM3IE5so46jN25r05ueAar1Ld
   TQCcEIKkNjGb3vvOVbo2w0Eiuf9mfZZ2g/m4Pk0bdoSqTqyyuuF7o5M/r
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jan 2023 12:52:48 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 12:52:48 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 12:52:47 -0800
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v13 10/15] ufs: core: Prepare ufshcd_send_command for mcq
Date:   Fri, 13 Jan 2023 12:48:47 -0800
Message-ID: <a380c21182acf07bb37ac4d68803897dfff883ce.1673557949.git.quic_asutoshd@quicinc.com>
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

Add support to send commands using multiple submission
queues in MCQ mode.
Modify the functions that use ufshcd_send_command().

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c     |  1 +
 drivers/ufs/core/ufshcd-priv.h | 10 ++++++++++
 drivers/ufs/core/ufshcd.c      | 38 +++++++++++++++++++++++++++-----------
 include/ufs/ufshcd.h           |  5 +++++
 4 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 8bf222f..6815825 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -309,6 +309,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	for (i = 0; i < hba->nr_hw_queues; i++) {
 		hwq = &hba->uhq[i];
 		hwq->max_entries = hba->nutrs;
+		spin_lock_init(&hwq->sq_lock);
 	}
 
 	/* The very first HW queue serves device commands */
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 4cd9b7b..013111f 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -335,4 +335,14 @@ static inline bool ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info, u8
 	return lun == UFS_UPIU_RPMB_WLUN || (lun < dev_info->max_lu_supported);
 }
 
+static inline void ufshcd_inc_sq_tail(struct ufs_hw_queue *q)
+{
+	u32 mask = q->max_entries - 1;
+	u32 val;
+
+	q->sq_tail_slot = (q->sq_tail_slot + 1) & mask;
+	val = q->sq_tail_slot * sizeof(struct utp_transfer_req_desc);
+	writel(val, q->mcq_sq_tail);
+}
+
 #endif /* _UFSHCD_PRIV_H_ */
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a492c88..655903b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2185,9 +2185,11 @@ static void ufshcd_update_monitor(struct ufs_hba *hba, const struct ufshcd_lrb *
  * ufshcd_send_command - Send SCSI or device management commands
  * @hba: per adapter instance
  * @task_tag: Task tag of the command
+ * @hwq: pointer to hardware queue instance
  */
 static inline
-void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
+void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
+			 struct ufs_hw_queue *hwq)
 {
 	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
 	unsigned long flags;
@@ -2201,12 +2203,24 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 	if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
 		ufshcd_start_monitor(hba, lrbp);
 
-	spin_lock_irqsave(&hba->outstanding_lock, flags);
-	if (hba->vops && hba->vops->setup_xfer_req)
-		hba->vops->setup_xfer_req(hba, task_tag, !!lrbp->cmd);
-	__set_bit(task_tag, &hba->outstanding_reqs);
-	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+	if (is_mcq_enabled(hba)) {
+		int utrd_size = sizeof(struct utp_transfer_req_desc);
+
+		spin_lock(&hwq->sq_lock);
+		memcpy(hwq->sqe_base_addr + (hwq->sq_tail_slot * utrd_size),
+		       lrbp->utr_descriptor_ptr, utrd_size);
+		ufshcd_inc_sq_tail(hwq);
+		spin_unlock(&hwq->sq_lock);
+	} else {
+		spin_lock_irqsave(&hba->outstanding_lock, flags);
+		if (hba->vops && hba->vops->setup_xfer_req)
+			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
+						  !!lrbp->cmd);
+		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
+		ufshcd_writel(hba, 1 << lrbp->task_tag,
+			      REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+	}
 }
 
 /**
@@ -2836,6 +2850,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	int tag = scsi_cmd_to_rq(cmd)->tag;
 	struct ufshcd_lrb *lrbp;
 	int err = 0;
+	struct ufs_hw_queue *hwq = NULL;
 
 	WARN_ONCE(tag < 0 || tag >= hba->nutrs, "Invalid tag %d\n", tag);
 
@@ -2920,7 +2935,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		goto out;
 	}
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, tag, hwq);
 
 out:
 	rcu_read_unlock();
@@ -3121,10 +3136,11 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 		goto out;
 
 	hba->dev_cmd.complete = &wait;
+	hba->dev_cmd.cqe = NULL;
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
 	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
 	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
@@ -6938,7 +6954,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
 	/*
 	 * ignore the returning value here - ufshcd_check_query_response is
 	 * bound to fail since dev_cmd.query and dev_cmd.type were left empty.
@@ -7104,7 +7120,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 
 	hba->dev_cmd.complete = &wait;
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
 
 	err = ufshcd_wait_for_dev_cmd(hba, lrbp, ADVANCED_RPMB_REQ_TIMEOUT);
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 13a2f17..019b8cf 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -224,6 +224,7 @@ struct ufs_dev_cmd {
 	struct mutex lock;
 	struct completion *complete;
 	struct ufs_query query;
+	struct cq_entry *cqe;
 };
 
 /**
@@ -1078,6 +1079,8 @@ struct ufs_hba {
  * @cqe_dma_addr: completion queue dma address
  * @max_entries: max number of slots in this hardware queue
  * @id: hardware queue ID
+ * @sq_tp_slot: current slot to which SQ tail pointer is pointing
+ * @sq_lock: serialize submission queue access
  */
 struct ufs_hw_queue {
 	void __iomem *mcq_sq_head;
@@ -1091,6 +1094,8 @@ struct ufs_hw_queue {
 	dma_addr_t cqe_dma_addr;
 	u32 max_entries;
 	u32 id;
+	u32 sq_tail_slot;
+	spinlock_t sq_lock;
 };
 
 static inline bool is_mcq_enabled(struct ufs_hba *hba)
-- 
2.7.4

