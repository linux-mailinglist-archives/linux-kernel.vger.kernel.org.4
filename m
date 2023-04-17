Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED2E6E53A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjDQVIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjDQVHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:07:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB579F;
        Mon, 17 Apr 2023 14:07:38 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HHOSs8028334;
        Mon, 17 Apr 2023 21:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=zpxe9NkHaQ+6z6OsPtNhHFYbZ1jNJdAyO/uOBuoAIdY=;
 b=Ap4VOO9XvPAgQbBxcVkWyC2c1hJ97CTx9y/IxmJaluiFLCY2lIJX17UtyhsPnjxB+YPK
 wwW3mBD5u5HUlZkwiCo7+jZWn+PT1lF+aCiMIFhByBfciuG6i8enFsbhk0j9TU8ohd4N
 Wl7TpHXN1qRt9IZhUN5Zsd7XM/fccXNR3w4wr7WKDvRnhX49vQ2dBrGkQYi5qTyHbpSY
 LE2rgBYfOj6EjWIdtpgbdHOAYTL5PTjJds5opw7pOa4t95Fzdcd4ijV08kUR3xutT5Ym
 gg/Q+Zpgkw7VVsdqfDrRUZJ22TfBQ4xc2rU7nK3joMXE9K9pInFLzvuNxbviMbNLTh2g zg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q14gk9eqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 21:07:19 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HL74eQ027011
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 21:07:04 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 17 Apr 2023 14:07:04 -0700
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
To:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>, <Powen.Kao@mediatek.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] ufs: mcq: Added ufshcd_mcq_abort()
Date:   Mon, 17 Apr 2023 14:05:47 -0700
Message-ID: <349ea681e56578191da834250cebfbd7859e9216.1681764704.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1681764704.git.quic_nguyenb@quicinc.com>
References: <cover.1681764704.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dCrgLmrPvzDdbCt_Qba-BWz6zAyWCami
X-Proofpoint-GUID: dCrgLmrPvzDdbCt_Qba-BWz6zAyWCami
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ufshcd_mcq_abort() to support ufs abort in mcq mode.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 62 ++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  5 +++-
 drivers/ufs/core/ufshcd.c      | 11 ++++++--
 3 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index a463674..e3031cd 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -619,3 +619,65 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 	spin_unlock(&hwq->sq_lock);
 	return ret;
 }
+
+/**
+ * ufshcd_mcq_abort - Abort the command in MCQ.
+ * @cmd - The command to be aborted.
+ *
+ * Returns SUCCESS or FAILED error codes
+ */
+int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
+{
+	struct Scsi_Host *host = cmd->device->host;
+	struct ufs_hba *hba = shost_priv(host);
+	int tag = scsi_cmd_to_rq(cmd)->tag;
+	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
+	struct ufs_hw_queue *hwq;
+	int err = FAILED;
+
+	if (!lrbp->cmd) {
+		dev_err(hba->dev,
+			"%s: skip abort. cmd at tag %d already completed.\n",
+			__func__, tag);
+		goto out;
+	}
+
+	/* Skip task abort in case previous aborts failed and report failure */
+	if (lrbp->req_abort_skip) {
+		dev_err(hba->dev, "%s: skip abort. tag %d failed earlier\n",
+			__func__, tag);
+		goto out;
+	}
+
+	hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
+
+	if (ufshcd_mcq_sqe_search(hba, hwq, tag)) {
+		/*
+		 * Failure. The command should not be "stuck" in SQ for
+		 * a long time which resulted in command being aborted.
+		 */
+		dev_err(hba->dev, "%s: cmd found in sq. hwq=%d, tag=%d\n",
+				__func__, hwq->id, tag);
+		/* Set the Command Type to 0xF per the spec */
+		ufshcd_mcq_nullify_cmd(hba, hwq);
+		goto out;
+	}
+
+	/*
+	 * The command is not in the Submission Queue, and it is not
+	 * in the Completion Queue either. Query the device to see if
+	 * the command is being processed in the device.
+	 */
+	if (ufshcd_try_to_abort_task(hba, tag)) {
+		dev_err(hba->dev, "%s: device abort failed %d\n", __func__, err);
+		lrbp->req_abort_skip = true;
+		goto out;
+	}
+
+	err = SUCCESS;
+	if (lrbp->cmd)
+		ufshcd_release_scsi_cmd(hba, lrbp);
+
+out:
+	return err;
+}
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 1a40cf7..ef66151 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -79,7 +79,10 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq);
 
 int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag, int *result);
-
+int ufshcd_mcq_abort(struct scsi_cmnd *cmd);
+int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
+void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
+				struct ufshcd_lrb *lrbp);
 #define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
 #define SD_ASCII_STD true
 #define SD_RAW false
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ffccb91..84efb52 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -299,7 +299,6 @@ static int ufshcd_setup_hba_vreg(struct ufs_hba *hba, bool on);
 static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
 static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
 					 struct ufs_vreg *vreg);
-static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
 static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
 						 bool enable);
 static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
@@ -5438,7 +5437,7 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
 }
 
 /* Release the resources allocated for processing a SCSI command. */
-static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
+void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 				    struct ufshcd_lrb *lrbp)
 {
 	struct scsi_cmnd *cmd = lrbp->cmd;
@@ -7374,7 +7373,7 @@ static void ufshcd_set_req_abort_skip(struct ufs_hba *hba, unsigned long bitmap)
  *
  * Returns zero on success, non-zero on failure
  */
-static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
+int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 {
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	int err = 0;
@@ -7534,6 +7533,12 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		goto release;
 	}
 
+	if (is_mcq_enabled(hba)) {
+		/* MCQ mode. Branch off to handle abort for mcq mode */
+		err = ufshcd_mcq_abort(cmd);
+		goto release;
+	}
+
 	/* Skip task abort in case previous aborts failed and report failure */
 	if (lrbp->req_abort_skip) {
 		dev_err(hba->dev, "%s: skipping abort\n", __func__);
-- 
2.7.4

