Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A1F6FFC31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbjEKV5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbjEKV5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:57:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C830C0;
        Thu, 11 May 2023 14:57:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BLmPKF019216;
        Thu, 11 May 2023 21:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=pPbSYsPiwyxtt6l3P1M6MQt2bFYKSdpLTJDSR3vOr0w=;
 b=krI4m5lDvX4p4glv9v1mhaa+U96hN2cWpNvnGC80V8ENAUHR0iIBqt/nZnRnqXg3ky5v
 p/gdR2n3Z6nwniUGstAr/+Kxb90DTQk7nhPrcEae/D/6FMX3UGdr8jgw4Lv/VwXaDkcp
 LiFtcTwrXiviRf14SLhRJzDXczmQv60btdXLEIDXHHZdOXt8DggegXJOY0XBQnv7fhMW
 pY3MH5QqZ5yNx5n+iS72zpja5ekyMz5SJ/GShXY7SVuWyTuUWz/WnoeEewU6C/Fotii1
 Rh63zIDkpWhzyhU9d1KNztkBsAs5ZXlOlRKy/l3E0gzB6jLkeHkK30aJKuBGl82Qfhtm cA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgv1t9yck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 21:56:16 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34BLuFsn004794
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 21:56:15 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 11 May 2023 14:56:15 -0700
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
        Alice Chao <alice.chao@mediatek.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/7] ufs: mcq: Added ufshcd_mcq_abort()
Date:   Thu, 11 May 2023 14:54:42 -0700
Message-ID: <0e009af290bc60f1e66015bc4f77e0489a39b939.1683841772.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1683841772.git.quic_nguyenb@quicinc.com>
References: <cover.1683841772.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2oMzzs1ehAgvGiHCsn6CsW21NwiWpN2n
X-Proofpoint-GUID: 2oMzzs1ehAgvGiHCsn6CsW21NwiWpN2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305110186
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ufshcd_mcq_abort() to support ufs abort in mcq mode.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 60 ++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  4 +++
 drivers/ufs/core/ufshcd.c      | 13 ++++++---
 3 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 655f220..63db20b 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -596,3 +596,63 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 	mutex_unlock(&hwq->sq_mutex);
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
+	if (!ufshcd_cmd_inflight(lrbp->cmd)) {
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
+			__func__, hwq->id, tag);
+		goto out;
+	}
+
+	/*
+	 * The command is not in the submission queue, and it is not
+	 * in the completion queue either. Query the device to see if
+	 * the command is being processed in the device.
+	 */
+	if (ufshcd_try_to_abort_task(hba, tag)) {
+		dev_err(hba->dev, "%s: device abort failed %d\n", __func__, err);
+		lrbp->req_abort_skip = true;
+		goto out;
+	}
+
+	err = SUCCESS;
+	if (ufshcd_cmd_inflight(lrbp->cmd))
+		ufshcd_release_scsi_cmd(hba, lrbp);
+
+out:
+	return err;
+}
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 3f518e9..80293fd 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -80,6 +80,10 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 
 bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd);
 int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag);
+int ufshcd_mcq_abort(struct scsi_cmnd *cmd);
+int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
+void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
+			     struct ufshcd_lrb *lrbp);
 
 #define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
 #define SD_ASCII_STD true
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 585f530..fbe8ba7 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -300,7 +300,6 @@ static int ufshcd_setup_hba_vreg(struct ufs_hba *hba, bool on);
 static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
 static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
 					 struct ufs_vreg *vreg);
-static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
 static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
 						 bool enable);
 static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
@@ -5457,8 +5456,8 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
 }
 
 /* Release the resources allocated for processing a SCSI command. */
-static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
-				    struct ufshcd_lrb *lrbp)
+void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
+			     struct ufshcd_lrb *lrbp)
 {
 	struct scsi_cmnd *cmd = lrbp->cmd;
 
@@ -7396,7 +7395,7 @@ static void ufshcd_set_req_abort_skip(struct ufs_hba *hba, unsigned long bitmap)
  *
  * Returns zero on success, non-zero on failure
  */
-static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
+int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 {
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	int err = 0;
@@ -7557,6 +7556,12 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
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

