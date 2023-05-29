Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE1271519D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjE2WO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjE2WOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:14:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9982E184;
        Mon, 29 May 2023 15:14:02 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TMAb3l015307;
        Mon, 29 May 2023 22:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=h+9GGXIQGiqHaDNSfG7t8NCmOejqPPcx1D0oM7wA4jU=;
 b=XqzkjDlytEYYpWPQF5Xqj2kMVw2uosw8lhRzHvGUI9jaRJFnczFv6UTCnEi5L78M/sE8
 AgXyWI3kgl/zTcAzKyBIV2bQbO2yZgPH6t6EfvzX5gLqLkTEXrSga4E3ZXOIqjRm3JXF
 gpsGRYnf7mOZYPYgrYHY6yI1JSaewHgbHZK1yDJqdQ5hmiKrIzdrGCkvCaJXFuQhVCTE
 qKV5FjIu1EUkld3nfV4WsqcmKx5ktlLkif+Lq9D9LH40B2IVUBJPPQ4KUr1QCnEcldkE
 foNX51SJQh/Sr62JnAfZV+lLonq/gp/EeBjXoFnZSAv7MmII47rzd8DdxhU++4n7BRtF ow== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qvmqrhtvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 22:13:42 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34TMDgLp029708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 22:13:42 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 29 May 2023 15:13:41 -0700
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
To:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Alice Chao" <alice.chao@mediatek.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v7 7/7] ufs: core: Add error handling for MCQ mode
Date:   Mon, 29 May 2023 15:12:26 -0700
Message-ID: <f0d923ee1f009f171a55c258d044e814ec0917ab.1685396241.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1685396241.git.quic_nguyenb@quicinc.com>
References: <cover.1685396241.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gey-v_a_2KuUSJYJFloLqYLRQoMGErRL
X-Proofpoint-ORIG-GUID: gey-v_a_2KuUSJYJFloLqYLRQoMGErRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_12,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305290187
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for error handling for MCQ mode.

Suggested-by: Can Guo <quic_cang@quicinc.com>
Co-developed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     |  26 ++++++++-
 drivers/ufs/core/ufshcd-priv.h |   3 +-
 drivers/ufs/core/ufshcd.c      | 128 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 139 insertions(+), 18 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 2efa012..66ac02e 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -276,12 +276,34 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
 }
 
 static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
-					    struct ufs_hw_queue *hwq)
+				   struct ufs_hw_queue *hwq)
 {
 	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
 	int tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
 
-	ufshcd_compl_one_cqe(hba, tag, cqe);
+	if (cqe->command_desc_base_addr) {
+		ufshcd_compl_one_cqe(hba, tag, cqe);
+		/* After processed the cqe, mark it empty (invalid) entry */
+		cqe->command_desc_base_addr = 0;
+	}
+}
+
+void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
+				    struct ufs_hw_queue *hwq)
+{
+	unsigned long flags;
+	u32 entries = hwq->max_entries;
+
+	spin_lock_irqsave(&hwq->cq_lock, flags);
+	while (entries > 0) {
+		ufshcd_mcq_process_cqe(hba, hwq);
+		ufshcd_mcq_inc_cq_head_slot(hwq);
+		entries--;
+	}
+
+	ufshcd_mcq_update_cq_tail_slot(hwq);
+	hwq->cq_head_slot = hwq->cq_tail_slot;
+	spin_unlock_irqrestore(&hwq->cq_lock, flags);
 }
 
 static unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 339ab51..802cc40 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -75,7 +75,8 @@ struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 					   struct request *req);
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq);
-
+void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
+				    struct ufs_hw_queue *hwq);
 bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd);
 int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag);
 int ufshcd_mcq_abort(struct scsi_cmnd *cmd);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 69562c4..313bead 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3148,6 +3148,15 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		err = -ETIMEDOUT;
 		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
 			__func__, lrbp->task_tag);
+
+		/* MCQ mode */
+		if (is_mcq_enabled(hba)) {
+			err = ufshcd_clear_cmd(hba, lrbp->task_tag);
+			hba->dev_cmd.complete = NULL;
+			return err;
+		}
+
+		/* SDB mode */
 		if (ufshcd_clear_cmd(hba, lrbp->task_tag) == 0) {
 			/* successfully cleared the command, retry if needed */
 			err = -EAGAIN;
@@ -5572,6 +5581,57 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 }
 
 /**
+ * ufshcd_mcq_compl_pending_transfer - MCQ mode function. It is
+ * invoked from the error handler context or ufshcd_host_reset_and_restore()
+ * to complete the pending transfers and free the resources associated with
+ * the scsi command.
+ *
+ * @hba: per adapter instance
+ * @force_compl: This flag is set to true when invoked
+ * from ufshcd_host_reset_and_restore() in which case it requires special
+ * handling because the host controller has been reset by ufshcd_hba_stop().
+ */
+static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
+					      bool force_compl)
+{
+	struct ufs_hw_queue *hwq;
+	struct ufshcd_lrb *lrbp;
+	struct scsi_cmnd *cmd;
+	unsigned long flags;
+	u32 hwq_num, utag;
+	int tag;
+
+	for (tag = 0; tag < hba->nutrs; tag++) {
+		lrbp = &hba->lrb[tag];
+		cmd = lrbp->cmd;
+		if (!ufshcd_cmd_inflight(cmd) ||
+		    test_bit(SCMD_STATE_COMPLETE, &cmd->state))
+			continue;
+
+		utag = blk_mq_unique_tag(scsi_cmd_to_rq(cmd));
+		hwq_num = blk_mq_unique_tag_to_hwq(utag);
+		hwq = &hba->uhq[hwq_num + UFSHCD_MCQ_IO_QUEUE_OFFSET];
+
+		if (force_compl) {
+			ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
+			/*
+			 * For those cmds of which the cqes are not present
+			 * in the cq, complete them explicitly.
+			 */
+			if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
+				spin_lock_irqsave(&hwq->cq_lock, flags);
+				set_host_byte(cmd, DID_REQUEUE);
+				ufshcd_release_scsi_cmd(hba, lrbp);
+				scsi_done(cmd);
+				spin_unlock_irqrestore(&hwq->cq_lock, flags);
+			}
+		} else {
+			ufshcd_mcq_poll_cqe_lock(hba, hwq);
+		}
+	}
+}
+
+/**
  * ufshcd_transfer_req_compl - handle SCSI and query command completion
  * @hba: per adapter instance
  *
@@ -6135,9 +6195,13 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 }
 
 /* Complete requests that have door-bell cleared */
-static void ufshcd_complete_requests(struct ufs_hba *hba)
+static void ufshcd_complete_requests(struct ufs_hba *hba, bool force_compl)
 {
-	ufshcd_transfer_req_compl(hba);
+	if (is_mcq_enabled(hba))
+		ufshcd_mcq_compl_pending_transfer(hba, force_compl);
+	else
+		ufshcd_transfer_req_compl(hba);
+
 	ufshcd_tmc_handler(hba);
 }
 
@@ -6378,18 +6442,36 @@ static bool ufshcd_abort_all(struct ufs_hba *hba)
 	bool needs_reset = false;
 	int tag, ret;
 
-	/* Clear pending transfer requests */
-	for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
-		ret = ufshcd_try_to_abort_task(hba, tag);
-		dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
-			hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
-			ret ? "failed" : "succeeded");
-		if (ret) {
-			needs_reset = true;
-			goto out;
+	if (is_mcq_enabled(hba)) {
+		struct ufshcd_lrb *lrbp;
+		int tag;
+
+		for (tag = 0; tag < hba->nutrs; tag++) {
+			lrbp = &hba->lrb[tag];
+			if (!ufshcd_cmd_inflight(lrbp->cmd))
+				continue;
+			ret = ufshcd_try_to_abort_task(hba, tag);
+			dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
+				hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
+				ret ? "failed" : "succeeded");
+			if (ret) {
+				needs_reset = true;
+				goto out;
+			}
+		}
+	} else {
+		/* Clear pending transfer requests */
+		for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
+			ret = ufshcd_try_to_abort_task(hba, tag);
+			dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
+				hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
+				ret ? "failed" : "succeeded");
+			if (ret) {
+				needs_reset = true;
+				goto out;
+			}
 		}
 	}
-
 	/* Clear pending task management requests */
 	for_each_set_bit(tag, &hba->outstanding_tasks, hba->nutmrs) {
 		if (ufshcd_clear_tm_cmd(hba, tag)) {
@@ -6400,7 +6482,7 @@ static bool ufshcd_abort_all(struct ufs_hba *hba)
 
 out:
 	/* Complete the requests that are cleared by s/w */
-	ufshcd_complete_requests(hba);
+	ufshcd_complete_requests(hba, false);
 
 	return needs_reset;
 }
@@ -6440,7 +6522,7 @@ static void ufshcd_err_handler(struct work_struct *work)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	ufshcd_err_handling_prepare(hba);
 	/* Complete requests that have door-bell cleared by h/w */
-	ufshcd_complete_requests(hba);
+	ufshcd_complete_requests(hba, false);
 	spin_lock_irqsave(hba->host->host_lock, flags);
 again:
 	needs_restore = false;
@@ -7321,6 +7403,8 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 	unsigned long flags, pending_reqs = 0, not_cleared = 0;
 	struct Scsi_Host *host;
 	struct ufs_hba *hba;
+	struct ufs_hw_queue *hwq;
+	struct ufshcd_lrb *lrbp;
 	u32 pos, not_cleared_mask = 0;
 	int err;
 	u8 resp = 0xF, lun;
@@ -7336,6 +7420,20 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 		goto out;
 	}
 
+	if (is_mcq_enabled(hba)) {
+		for (pos = 0; pos < hba->nutrs; pos++) {
+			lrbp = &hba->lrb[pos];
+			if (ufshcd_cmd_inflight(lrbp->cmd) &&
+			    lrbp->lun == lun) {
+				ufshcd_clear_cmd(hba, pos);
+				hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(lrbp->cmd));
+				ufshcd_mcq_poll_cqe_lock(hba, hwq);
+			}
+		}
+		err = 0;
+		goto out;
+	}
+
 	/* clear the commands that were pending for corresponding LUN */
 	spin_lock_irqsave(&hba->outstanding_lock, flags);
 	for_each_set_bit(pos, &hba->outstanding_reqs, hba->nutrs)
@@ -7619,7 +7717,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	ufshpb_toggle_state(hba, HPB_PRESENT, HPB_RESET);
 	ufshcd_hba_stop(hba);
 	hba->silence_err_logs = true;
-	ufshcd_complete_requests(hba);
+	ufshcd_complete_requests(hba, true);
 	hba->silence_err_logs = false;
 
 	/* scale up clocks to max frequency before full reinitialization */
-- 
2.7.4

