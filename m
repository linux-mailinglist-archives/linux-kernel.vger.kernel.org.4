Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDB663E20A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiK3Uaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiK3Uab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:30:31 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDF952151;
        Wed, 30 Nov 2022 12:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669840229; x=1701376229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=nu8Tp+Xn++lLxjBTqmScG/giC7/DJTUO5MPwOFkmZBo=;
  b=AK/stwEtDJemT6oEtIajc9iXHZilxrTq/4PgitYyZiMH1mwqFXHO6IZ1
   09OU69GXoxCb4uUOCdazvfXQw/+/jmnm9vt9JSc+kye2FktE0Gnlt789W
   2YgnaRWyUDmnCtWSPzUkjovL5Vv6ahK+/It4d7YxK9xLaDXjxETGood8t
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Nov 2022 12:30:28 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 12:30:28 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 12:30:28 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <eddie.huang@mediatek.com>,
        <daejun7.park@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 13/16] ufs: core: Prepare for completion in mcq
Date:   Wed, 30 Nov 2022 12:27:54 -0800
Message-ID: <273b096b13ce7e7e52562421caa9bb1b4648367a.1669839847.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669839847.git.quic_asutoshd@quicinc.com>
References: <cover.1669839847.git.quic_asutoshd@quicinc.com>
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

Modify completion path APIs and add completion queue
entry.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/ufs/core/ufshcd-priv.h |  2 ++
 drivers/ufs/core/ufshcd.c      | 80 ++++++++++++++++++++++++++----------------
 2 files changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index a07f85e..a7af6aa 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -61,6 +61,8 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 	enum flag_idn idn, u8 index, bool *flag_res);
 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
+void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
+			  struct cq_entry *cqe);
 int ufshcd_mcq_init(struct ufs_hba *hba);
 int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
 int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b0b0f2c..0024586 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -784,12 +784,17 @@ static inline bool ufshcd_is_device_present(struct ufs_hba *hba)
 /**
  * ufshcd_get_tr_ocs - Get the UTRD Overall Command Status
  * @lrbp: pointer to local command reference block
+ * @cqe: pointer to the completion queue entry
  *
  * This function is used to get the OCS field from UTRD
  * Returns the OCS field in the UTRD
  */
-static enum utp_ocs ufshcd_get_tr_ocs(struct ufshcd_lrb *lrbp)
+static enum utp_ocs ufshcd_get_tr_ocs(struct ufshcd_lrb *lrbp,
+				      struct cq_entry *cqe)
 {
+	if (cqe)
+		return le32_to_cpu(cqe->status) & MASK_OCS;
+
 	return le32_to_cpu(lrbp->utr_descriptor_ptr->header.dword_2) & MASK_OCS;
 }
 
@@ -3048,7 +3053,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		 * not trigger any race conditions.
 		 */
 		hba->dev_cmd.complete = NULL;
-		err = ufshcd_get_tr_ocs(lrbp);
+		err = ufshcd_get_tr_ocs(lrbp, hba->dev_cmd.cqe);
 		if (!err)
 			err = ufshcd_dev_cmd_completion(hba, lrbp);
 	} else {
@@ -5216,18 +5221,20 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int scsi_status)
  * ufshcd_transfer_rsp_status - Get overall status of the response
  * @hba: per adapter instance
  * @lrbp: pointer to local reference block of completed command
+ * @cqe: pointer to the completion queue entry
  *
  * Returns result of the command to notify SCSI midlayer
  */
 static inline int
-ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
+ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
+			   struct cq_entry *cqe)
 {
 	int result = 0;
 	int scsi_status;
 	enum utp_ocs ocs;
 
 	/* overall command status of utrd */
-	ocs = ufshcd_get_tr_ocs(lrbp);
+	ocs = ufshcd_get_tr_ocs(lrbp, cqe);
 
 	if (hba->quirks & UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR) {
 		if (be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_1) &
@@ -5392,6 +5399,40 @@ static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 }
 
 /**
+ * ufshcd_compl_one_cqe - handle a completion queue entry
+ * @hba: per adapter instance
+ * @task_tag: the task tag of the request to be completed
+ * @cqe: pointer to the completion queue entry
+ */
+void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
+			  struct cq_entry *cqe)
+{
+	struct ufshcd_lrb *lrbp;
+	struct scsi_cmnd *cmd;
+
+	lrbp = &hba->lrb[task_tag];
+	lrbp->compl_time_stamp = ktime_get();
+	cmd = lrbp->cmd;
+	if (cmd) {
+		if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
+			ufshcd_update_monitor(hba, lrbp);
+		ufshcd_add_command_trace(hba, task_tag, UFS_CMD_COMP);
+		cmd->result = ufshcd_transfer_rsp_status(hba, lrbp, cqe);
+		ufshcd_release_scsi_cmd(hba, lrbp);
+		/* Do not touch lrbp after scsi done */
+		scsi_done(cmd);
+	} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
+		   lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
+		if (hba->dev_cmd.complete) {
+			hba->dev_cmd.cqe = cqe;
+			ufshcd_add_command_trace(hba, task_tag, UFS_DEV_COMP);
+			complete(hba->dev_cmd.complete);
+			ufshcd_clk_scaling_update_busy(hba);
+ 		}
+ 	}
+ }
+ 
+/**
  * __ufshcd_transfer_req_compl - handle SCSI and query command completion
  * @hba: per adapter instance
  * @completed_reqs: bitmask that indicates which requests to complete
@@ -5399,33 +5440,10 @@ static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 					unsigned long completed_reqs)
 {
-	struct ufshcd_lrb *lrbp;
-	struct scsi_cmnd *cmd;
-	int index;
-
-	for_each_set_bit(index, &completed_reqs, hba->nutrs) {
-		lrbp = &hba->lrb[index];
-		lrbp->compl_time_stamp = ktime_get();
-		lrbp->compl_time_stamp_local_clock = local_clock();
-		cmd = lrbp->cmd;
-		if (cmd) {
-			if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
-				ufshcd_update_monitor(hba, lrbp);
-			ufshcd_add_command_trace(hba, index, UFS_CMD_COMP);
-			cmd->result = ufshcd_transfer_rsp_status(hba, lrbp);
-			ufshcd_release_scsi_cmd(hba, lrbp);
-			/* Do not touch lrbp after scsi done */
-			scsi_done(cmd);
-		} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
-			lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
-			if (hba->dev_cmd.complete) {
-				ufshcd_add_command_trace(hba, index,
-							 UFS_DEV_COMP);
-				complete(hba->dev_cmd.complete);
-				ufshcd_clk_scaling_update_busy(hba);
-			}
-		}
-	}
+	int tag;
+
+	for_each_set_bit(tag, &completed_reqs, hba->nutrs)
+		ufshcd_compl_one_cqe(hba, tag, NULL);
 }
 
 /* Any value that is not an existing queue number is fine for this constant. */
-- 
2.7.4

