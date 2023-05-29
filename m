Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F9D71518F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjE2WNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjE2WNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:13:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BDCD9;
        Mon, 29 May 2023 15:13:09 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TM7maO022995;
        Mon, 29 May 2023 22:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=chwVS0r8aWLNz8P8s+zZWUa4weJtmdHmTZLt9b04Rys=;
 b=piYnyVgXPhZcne+11r9FBAC2JMdcCnS/xUcR8IxeawHDgqdXKkW8ihNY4SVd21XVEgmg
 qTXDhSmpl4Wi6hUwaWg8YNY38ajMlzHcp4KqbQPi/An2CI0mUNwV8LdURrszm3dc/yGC
 TNXXsgUSGvTal924Usor86PWK4OOO5Yk7njW0FQDPlnJm7M2wjIQJDP6ojR6fViwARk3
 3JZd1kVWgKts27nBcGXIUxfIj3l/4Fkhi2NxHWSXjntEiq/ztAiR37e8bAKthNgwoK2l
 hB9A6yE26jcbFqionA5vHAJbZFATHT7nEp6pQ2FOIzPUJnlyPlm4Lzh6u9xlgF4v+Nx/ kQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qvv7nrwgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 22:12:49 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34TMCn7q025791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 22:12:49 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 29 May 2023 15:12:48 -0700
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
Subject: [PATCH v7 2/7] ufs: core: Update the ufshcd_clear_cmds() functionality
Date:   Mon, 29 May 2023 15:12:21 -0700
Message-ID: <8411fb5363acc90519bced30ea2c2ac582ff2340.1685396241.git.quic_nguyenb@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Rx4ZoStK44W2hw2sWIluaSfCxyvagev7
X-Proofpoint-GUID: Rx4ZoStK44W2hw2sWIluaSfCxyvagev7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_12,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

In the ufshcd_clear_cmds(), the 2nd pamameter would be the
bit mask of the command to be cleared in the transfer request
door bell register. This bit mask mechanism does not scale well in
mcq mode when the queue depth becomes much greater than 64. Change the
2nd parameter to the function to be the task_tag number of the
corresponding bit to be cleared in the door bell register.
By doing so, mcq mode with a large queue depth can reuse this function.

Since the behavior of this function is changed from handling
multiple commands into a single command, rename ufshcd_clear_cmds()
into ufshcd_clear_cmd().

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 5527d45..a37e1eb 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3006,13 +3006,15 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
 }
 
 /*
- * Clear all the requests from the controller for which a bit has been set in
- * @mask and wait until the controller confirms that these requests have been
- * cleared.
+ * Clear the pending command in the controller and wait until
+ * the controller confirms that the command has been cleared.
+ * @hba: per adapter instance
+ * @task_tag: The tag number of the command to be cleared.
  */
-static int ufshcd_clear_cmds(struct ufs_hba *hba, u32 mask)
+static int ufshcd_clear_cmd(struct ufs_hba *hba, u32 task_tag)
 {
 	unsigned long flags;
+	u32 mask = 1U << task_tag;
 
 	/* clear outstanding transaction before retry */
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -3113,7 +3115,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		err = -ETIMEDOUT;
 		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
 			__func__, lrbp->task_tag);
-		if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0) {
+		if (ufshcd_clear_cmd(hba, lrbp->task_tag) == 0) {
 			/* successfully cleared the command, retry if needed */
 			err = -EAGAIN;
 			/*
@@ -7286,7 +7288,7 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 	unsigned long flags, pending_reqs = 0, not_cleared = 0;
 	struct Scsi_Host *host;
 	struct ufs_hba *hba;
-	u32 pos;
+	u32 pos, not_cleared_mask = 0;
 	int err;
 	u8 resp = 0xF, lun;
 
@@ -7309,17 +7311,20 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 	hba->outstanding_reqs &= ~pending_reqs;
 	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
 
-	if (ufshcd_clear_cmds(hba, pending_reqs) < 0) {
-		spin_lock_irqsave(&hba->outstanding_lock, flags);
-		not_cleared = pending_reqs &
-			ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-		hba->outstanding_reqs |= not_cleared;
-		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+	for_each_set_bit(pos, &pending_reqs, hba->nutrs) {
+		if (ufshcd_clear_cmd(hba, pos) < 0) {
+			spin_lock_irqsave(&hba->outstanding_lock, flags);
+			not_cleared = 1U << pos &
+				ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+			hba->outstanding_reqs |= not_cleared;
+			not_cleared_mask |= not_cleared;
+			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
 
-		dev_err(hba->dev, "%s: failed to clear requests %#lx\n",
-			__func__, not_cleared);
+			dev_err(hba->dev, "%s: failed to clear request %d\n",
+				__func__, pos);
+		}
 	}
-	__ufshcd_transfer_req_compl(hba, pending_reqs & ~not_cleared);
+	__ufshcd_transfer_req_compl(hba, pending_reqs & ~not_cleared_mask);
 
 out:
 	hba->req_abort_count = 0;
@@ -7416,7 +7421,7 @@ static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 		goto out;
 	}
 
-	err = ufshcd_clear_cmds(hba, 1U << tag);
+	err = ufshcd_clear_cmd(hba, tag);
 	if (err)
 		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d, err %d\n",
 			__func__, tag, err);
-- 
2.7.4

