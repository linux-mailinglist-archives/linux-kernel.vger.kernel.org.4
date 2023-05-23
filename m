Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5535B70D4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjEWHak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjEWHaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:30:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8EB11A;
        Tue, 23 May 2023 00:30:02 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N7MOdr031554;
        Tue, 23 May 2023 07:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fFxOJlVlhuvFzYutazyLVXNCf8wMvkWPEFJYeiTNkmg=;
 b=jMDWMhQmbKbwIpq3ImmffL/iHtGJ7RN8WaDRRcF6VkAB/PBXwb4uypGCr6LGeYTccueZ
 ScpzCNGO4Uv3B970q5TGEpPdTb1Lza3AaH2jNn7NoNuCs6SEze0lnhK4zIwdc3tUCBNY
 Gamt1QP8bNqnN8wUnZ3KoDDX5/3dkZZ1fUtUET6Fh/JgavH4hnJktkRjYQIAAt1WmTPF
 4EvMuGVZRLUsoWxhfkAWneajLW9Mq/d1fsSSNegtXsn+I5Yyqor+kfEqYKosGDV1sw5d
 WX8UckYuESM+TgWEf9AXITCwPuxleIALFRmUH4npzCDaA5g/Us4199o8oamo8sRpIyqx ZQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrpmm0a5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:29:36 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N7TUSc019938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:29:30 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 23 May 2023 00:29:30 -0700
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
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 7/7] ufs: core: Add error handling for MCQ mode
Date:   Tue, 23 May 2023 00:28:15 -0700
Message-ID: <a8afbd1088d9f8803610a5907cb2bdf1c0852457.1684825500.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1684825500.git.quic_nguyenb@quicinc.com>
References: <cover.1684825500.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zzj3JL40w5LfI-vO2VgG1XJPBeLYb2jK
X-Proofpoint-GUID: zzj3JL40w5LfI-vO2VgG1XJPBeLYb2jK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for error handling for MCQ mode.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 106 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 94 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 69562c4..90cf047 100644
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
@@ -5572,6 +5581,31 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 }
 
 /**
+ * ufshcd_mcq_compl_pending_transfer - MCQ mode function. It is
+ * invoked from the error handler context or ufshcd_host_reset_and_restore()
+ * to complete the pending transfers and free the resources associated with
+ * the scsi command.
+ *
+ * @hba: per adapter instance
+ */
+static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba)
+{
+	struct ufshcd_lrb *lrbp;
+	struct scsi_cmnd *cmd;
+	int tag;
+
+	for (tag = 0; tag < hba->nutrs; tag++) {
+		lrbp = &hba->lrb[tag];
+		cmd = lrbp->cmd;
+		if (ufshcd_cmd_inflight(lrbp->cmd)) {
+			set_host_byte(cmd, DID_ERROR);
+			ufshcd_release_scsi_cmd(hba, lrbp);
+			scsi_done(cmd);
+		}
+	}
+}
+
+/**
  * ufshcd_transfer_req_compl - handle SCSI and query command completion
  * @hba: per adapter instance
  *
@@ -6137,7 +6171,11 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 /* Complete requests that have door-bell cleared */
 static void ufshcd_complete_requests(struct ufs_hba *hba)
 {
-	ufshcd_transfer_req_compl(hba);
+	if (is_mcq_enabled(hba))
+		ufshcd_mcq_compl_pending_transfer(hba);
+	else
+		ufshcd_transfer_req_compl(hba);
+
 	ufshcd_tmc_handler(hba);
 }
 
@@ -6378,18 +6416,36 @@ static bool ufshcd_abort_all(struct ufs_hba *hba)
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
@@ -7321,6 +7377,8 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 	unsigned long flags, pending_reqs = 0, not_cleared = 0;
 	struct Scsi_Host *host;
 	struct ufs_hba *hba;
+	struct ufs_hw_queue *hwq;
+	struct ufshcd_lrb *lrbp;
 	u32 pos, not_cleared_mask = 0;
 	int err;
 	u8 resp = 0xF, lun;
@@ -7336,6 +7394,20 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
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
@@ -7610,7 +7682,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
  */
 static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 {
-	int err;
+	struct ufs_hw_queue *hwq;
+	int err, i;
 
 	/*
 	 * Stop the host controller and complete the requests
@@ -7622,6 +7695,15 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	ufshcd_complete_requests(hba);
 	hba->silence_err_logs = false;
 
+	if (is_mcq_enabled(hba)) {
+		for (i = 0; i < hba->nr_hw_queues; i++) {
+			hwq = &hba->uhq[i];
+			hwq->sq_tail_slot = 0;
+			hwq->cq_tail_slot = 0;
+			hwq->cq_head_slot = 0;
+		}
+	}
+
 	/* scale up clocks to max frequency before full reinitialization */
 	ufshcd_scale_clks(hba, true);
 
-- 
2.7.4

