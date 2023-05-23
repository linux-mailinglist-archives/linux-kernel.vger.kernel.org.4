Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFD70D502
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjEWHau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjEWHal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:30:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149DC120;
        Tue, 23 May 2023 00:30:03 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N5ojDo000841;
        Tue, 23 May 2023 07:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YjRs36zs23+wsk0UH3qudaf3FDkE8BSi2qMzsXRIUMI=;
 b=hWsiIzeCIzIJr3Qlw/X17erw9f89bak2dyPbRKj7rdheFyhbV36V7Q2QeHJ810Ot45bi
 8ZOyskNmfiTEA8VfgdulTZqyojJzljSgK7/jS1sjB8rp5TY0Qc41/wgscw5AkazYh8zA
 WBMqCjkLoj7NW33ElbN5jd3Bd+XHHynaBtwiJHaHYvZJmDQueTOGjF4aae74Lwor9HTv
 AUe7tSx6pVZH0z7pryqThX9obP9vRa1a9vi/N2iPlDby45qqETnrvTBkJRaTHwR4QQ7W
 KntOsCHMJoYeMD5QQHlypeakkLUxprX/V5e34Sbs6ycWnfAu+xzT1GAEsJRgEBYihMe4 dQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr6h0t6xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:29:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N7T56W020619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:29:05 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 23 May 2023 00:29:05 -0700
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
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/7] ufs: mcq: Add support for clean up mcq resources
Date:   Tue, 23 May 2023 00:28:12 -0700
Message-ID: <cab786369106e637829701250ea76d97b3500373.1684825500.git.quic_nguyenb@quicinc.com>
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
X-Proofpoint-GUID: 0TnQLQpffRu8_2_0ElLOulJkQ32KsunA
X-Proofpoint-ORIG-GUID: 0TnQLQpffRu8_2_0ElLOulJkQ32KsunA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/ufs/core/ufshcd.c      | 74 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 9 deletions(-)

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
index 140ab15..e9d30c3 100644
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
@@ -7449,13 +7498,16 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	WARN_ONCE(tag < 0, "Invalid tag %d\n", tag);
 
 	ufshcd_hold(hba, false);
-	reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	/* If command is already aborted/completed, return FAILED. */
-	if (!(test_bit(tag, &hba->outstanding_reqs))) {
-		dev_err(hba->dev,
-			"%s: cmd at tag %d already completed, outstanding=0x%lx, doorbell=0x%x\n",
-			__func__, tag, hba->outstanding_reqs, reg);
-		goto release;
+
+	if (!is_mcq_enabled(hba)) {
+		reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		if (!test_bit(tag, &hba->outstanding_reqs)) {
+			/* If command is already aborted/completed, return FAILED. */
+			dev_err(hba->dev,
+				"%s: cmd at tag %d already completed, outstanding=0x%lx, doorbell=0x%x\n",
+				__func__, tag, hba->outstanding_reqs, reg);
+			goto release;
+		}
 	}
 
 	/* Print Transfer Request of aborted task */
@@ -7480,7 +7532,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	}
 	hba->req_abort_count++;
 
-	if (!(reg & (1 << tag))) {
+	if (!is_mcq_enabled(hba) && !(reg & (1 << tag))) {
+		/* only execute this code in single doorbell mode */
 		dev_err(hba->dev,
 		"%s: cmd was completed, but without a notifying intr, tag = %d",
 		__func__, tag);
@@ -7506,6 +7559,9 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		goto release;
 	}
 
+	if (is_mcq_enabled(hba))
+		goto release;
+
 	/* Skip task abort in case previous aborts failed and report failure */
 	if (lrbp->req_abort_skip) {
 		dev_err(hba->dev, "%s: skipping abort\n", __func__);
-- 
2.7.4

