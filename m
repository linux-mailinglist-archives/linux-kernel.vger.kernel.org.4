Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF26C6439
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCWJ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjCWJ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:56:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5CC2BF15;
        Thu, 23 Mar 2023 02:55:50 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N7fhAP021816;
        Thu, 23 Mar 2023 09:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=n6B5sLN8cmPdb7O6bjPsx+TuI5g+ZpGMmvDOgLf8pZY=;
 b=FlrWESP3aR2n8RhRJgGLwOM+mi5ry7xDFkGcRoVMewAiiZ0+RzP85Spa8AQa2KufNlig
 pvJRKWQImFRKb5flmup3BOKmFSu3V6l9BTDU6spmaBv2/vh4z6YQmtApyFMf3o2tOsWZ
 mxe/qiMJXZpqw9KnRj69klmBS0QU4SrXfZvd2W37/I7SJEvy+IOj8bhFhSgv4JIxOlfy
 VtHYEQFjqFkL8Mim45vTWQqQ5rghrop5LrqhnfQDxmNMvTN/C2yainjcanm/bQByKGOY
 deiyJOsL6GmSBayQBkDb4H6fOc6LuiyaQm51aQKK8NvWXXsgJPYbcL8atl1K5oEEk7JI JA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pghh4re76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 09:54:51 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N9snR3004259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 09:54:49 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 02:54:49 -0700
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
Subject: [RFC PATCH v3 3/5] ufs: mcq: Added ufshcd_mcq_abort()
Date:   Thu, 23 Mar 2023 02:53:33 -0700
Message-ID: <bb5ddd8407795c0186b71c39f4e67cf2e68f7708.1679564391.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1679564391.git.quic_nguyenb@quicinc.com>
References: <cover.1679564391.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DF347HYvttHf162QWhXBXzkOmPrY0BcN
X-Proofpoint-ORIG-GUID: DF347HYvttHf162QWhXBXzkOmPrY0BcN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230074
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 29d0e37..5c417a1 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -618,3 +618,65 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
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
index 0ecd03e..359747a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -301,7 +301,6 @@ static int ufshcd_setup_hba_vreg(struct ufs_hba *hba, bool on);
 static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
 static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
 					 struct ufs_vreg *vreg);
-static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
 static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
 						 bool enable);
 static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
@@ -5412,7 +5411,7 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
 }
 
 /* Release the resources allocated for processing a SCSI command. */
-static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
+void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 				    struct ufshcd_lrb *lrbp)
 {
 	struct scsi_cmnd *cmd = lrbp->cmd;
@@ -7338,7 +7337,7 @@ static void ufshcd_set_req_abort_skip(struct ufs_hba *hba, unsigned long bitmap)
  *
  * Returns zero on success, non-zero on failure
  */
-static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
+int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 {
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	int err = 0;
@@ -7498,6 +7497,12 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
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

