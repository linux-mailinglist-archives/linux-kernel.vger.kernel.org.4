Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA1A6FFC28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbjEKV4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjEKV4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:56:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF09946A2;
        Thu, 11 May 2023 14:56:41 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BLhlw9021037;
        Thu, 11 May 2023 21:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Hxphp8uH1DaKK/5eWpkIaJsxjpy0xopdPcik/h/ibsw=;
 b=PxQzXMyoxIz+wV9Kr8FCPkab8OWN2NhpkYlfYoyq+ZGR+3EVWzwGn1TNEK9aorDUi9oc
 4ht06V2RmOcgAf+bDJs1fUQhRdDQYAVWsb5s0sDOf+RRKqk8elZlDbJRXKO93+trGyAV
 hWnANLPFSD7CieAzcViOxh6CDfW07Sr2C109zWs9ZnIJkhPqJPQnvxmeXV9lOEKwT6+T
 /qcmkOaG5oWYFu8GSR+gnnWWZlwn3VSsgsgLCrmmEqXpDoO4oZa/l0kJRa4EawKz34EK
 UAWrcQuPoN1/dk3k/MhdRKceWXiizcW/70RAjhrzbgDlebdFmAKMAq4KB7aVu+i7MDgV Pw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh8hm00ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 21:56:01 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34BLu0Xd024648
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 21:56:00 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 11 May 2023 14:56:00 -0700
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
Subject: [PATCH v4 4/7] ufs: mcq: Add support for clean up mcq resources
Date:   Thu, 11 May 2023 14:54:41 -0700
Message-ID: <33fe3d5bd6223d0ca1b5002efb7efc7bb90f3495.1683841772.git.quic_nguyenb@quicinc.com>
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
X-Proofpoint-GUID: wBu0R-B3_QZ8P3sjAwaBYlOM2WwIwGI4
X-Proofpoint-ORIG-GUID: wBu0R-B3_QZ8P3sjAwaBYlOM2WwIwGI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110186
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ufshcd_clear_cmd() to clean up the mcq resources similar
to the function ufshcd_utrl_clear() does for sdb mode.

Update ufshcd_try_to_abort_task() to support mcq mode so that
this function can be invoked in either mcq or sdb mode.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufshcd-priv.h |  1 +
 drivers/ufs/core/ufshcd.c      | 61 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 40727e8..3f518e9 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -78,6 +78,7 @@ struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq);
 
+bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd);
 int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag);
 
 #define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 140ab15..585f530 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3005,6 +3005,26 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
 }
 
 /*
+ * Check with the block layer if the command is inflight
+ * @cmd: command to check.
+ *
+ * Returns true if command is inflight; false if not.
+ */
+bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
+{
+	struct request *rq;
+
+	if (!cmd)
+		return false;
+
+	rq = scsi_cmd_to_rq(cmd);
+	if (!blk_mq_request_started(rq))
+		return false;
+
+	return true;
+}
+
+/*
  * Clear the pending command in the controller and wait until
  * the controller confirms that the command has been cleared.
  * @hba: per adapter instance
@@ -3012,8 +3032,23 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
  */
 static int ufshcd_clear_cmd(struct ufs_hba *hba, u32 task_tag)
 {
-	unsigned long flags;
 	u32 mask = 1U << task_tag;
+	unsigned long flags;
+	int err;
+
+	if (is_mcq_enabled(hba)) {
+		/*
+		 * MCQ mode. Clean up the MCQ resources similar to
+		 * what the ufshcd_utrl_clear() does for SDB mode.
+		 */
+		err = ufshcd_mcq_sq_cleanup(hba, task_tag);
+		if (err) {
+			dev_err(hba->dev, "%s: failed tag=%d. err=%d\n",
+				__func__, task_tag, err);
+			return err;
+		}
+		return 0;
+	}
 
 	/* clear outstanding transaction before retry */
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -7384,6 +7419,20 @@ static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 			 */
 			dev_err(hba->dev, "%s: cmd at tag %d not pending in the device.\n",
 				__func__, tag);
+			if (is_mcq_enabled(hba)) {
+				/* MCQ mode */
+				if (ufshcd_cmd_inflight(lrbp->cmd)) {
+					/* sleep for max. 200us same delay as in SDB mode */
+					usleep_range(100, 200);
+					continue;
+				}
+				/* command completed already */
+				dev_err(hba->dev, "%s: cmd at tag=%d is cleared.\n",
+					__func__, tag);
+				goto out;
+			}
+
+			/* Single Doorbell Mode */
 			reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 			if (reg & (1 << tag)) {
 				/* sleep for max. 200us to stabilize */
@@ -7449,9 +7498,10 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	WARN_ONCE(tag < 0, "Invalid tag %d\n", tag);
 
 	ufshcd_hold(hba, false);
-	reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	/* If command is already aborted/completed, return FAILED. */
-	if (!(test_bit(tag, &hba->outstanding_reqs))) {
+
+	if (!is_mcq_enabled(hba) && !test_bit(tag, &hba->outstanding_reqs)) {
+		reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		/* If command is already aborted/completed, return FAILED. */
 		dev_err(hba->dev,
 			"%s: cmd at tag %d already completed, outstanding=0x%lx, doorbell=0x%x\n",
 			__func__, tag, hba->outstanding_reqs, reg);
@@ -7480,7 +7530,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	}
 	hba->req_abort_count++;
 
-	if (!(reg & (1 << tag))) {
+	if (!is_mcq_enabled(hba) && !(reg & (1 << tag))) {
+		/* only execute this code in single doorbell mode */
 		dev_err(hba->dev,
 		"%s: cmd was completed, but without a notifying intr, tag = %d",
 		__func__, tag);
-- 
2.7.4

