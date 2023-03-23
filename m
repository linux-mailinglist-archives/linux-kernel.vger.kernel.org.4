Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC94E6C643D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCWJ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjCWJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:56:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742FB2886E;
        Thu, 23 Mar 2023 02:55:59 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N95p26028342;
        Thu, 23 Mar 2023 09:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=b7lBknDZbj/cY/j9cKG/0VDahEq1L4VQILxWupDjmkI=;
 b=jUb88aTzlInPQOlQdyjrln7y+whngo01nbpjT7rRX0Rd6+2mtUw3pFHMmtSjA9J1ZiIb
 2rnNgCq4bMbUHldZD0W1XWvIf5kr1sY/8o4eCTk2puQyV9TPv7Mpqg86VY5skG417Imd
 3baSuw/ppU7jRa8ICnBmGmK02Y/j/k9EcctG2R3a9bDZpCG8QnlRcDeoRY4OES75+Agw
 GvQS1TcWOSxoQ3m5oFwUNuaEoWWUCi7syzPmURFwcQUDTLX9as3g74zHCljuRgREiUUC
 WqxxzrGh2oK0FHNJLnBfgw1ZKA/oM8iKkRdCb+L6+jb84EHIhmDvZEKDDtM13G6FmNqN 4w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgghj0j6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 09:54:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N9sU3D020335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 09:54:30 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 02:54:30 -0700
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
        open list <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 2/5] ufs: mcq: Add support for clean up mcq resources
Date:   Thu, 23 Mar 2023 02:53:32 -0700
Message-ID: <ec8ab005c6b814986548d0d01bf5de5e83119f27.1679564391.git.quic_nguyenb@quicinc.com>
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
X-Proofpoint-GUID: XU5nqGASyFV7XgoledHAXpAzHiLnvCcw
X-Proofpoint-ORIG-GUID: XU5nqGASyFV7XgoledHAXpAzHiLnvCcw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 mlxlogscore=865 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230074
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ufshcd_clear_cmds() to clean up the mcq resources similar
to the function ufshcd_utrl_clear() does for sdb mode.

Update ufshcd_try_to_abort_task() to support mcq mode so that
this function can be invoked in either mcq or sdb mode.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 504f041..0ecd03e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2984,10 +2984,28 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
  * @mask and wait until the controller confirms that these requests have been
  * cleared.
  */
-static int ufshcd_clear_cmds(struct ufs_hba *hba, u32 mask)
+static int ufshcd_clear_cmds(struct ufs_hba *hba, unsigned long mask)
 {
 	unsigned long flags;
+	int err, result, tag;
 
+	if (is_mcq_enabled(hba)) {
+		/*
+		 * MCQ mode. Clean up the MCQ resources similar to
+		 * what the ufshcd_utrl_clear() does for SDB mode.
+		 */
+		for_each_set_bit(tag, &mask, hba->nutrs) {
+			err = ufshcd_mcq_sq_cleanup(hba, tag, &result);
+			if (err || result) {
+				dev_err(hba->dev, "%s: failed tag=%d. err=%d, result=%d\n",
+					__func__, tag, err, result);
+				return FAILED;
+			}
+		}
+		return 0;
+	}
+
+	/* Single Doorbell Mode */
 	/* clear outstanding transaction before retry */
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	ufshcd_utrl_clear(hba, mask);
@@ -7343,6 +7361,20 @@ static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 			 */
 			dev_err(hba->dev, "%s: cmd at tag %d not pending in the device.\n",
 				__func__, tag);
+			if (is_mcq_enabled(hba)) {
+				/* mcq mode */
+				if (lrbp->cmd) {
+					/* sleep for max. 200us to stabilize */
+					usleep_range(100, 200);
+					continue;
+				}
+				/* command completed already */
+				dev_err(hba->dev, "%s: cmd at tag=%d is cleared.\n",
+					__func__, tag);
+				goto out;
+			}
+
+			/* single door bell mode */
 			reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 			if (reg & (1 << tag)) {
 				/* sleep for max. 200us to stabilize */
@@ -7409,8 +7441,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 
 	ufshcd_hold(hba, false);
 	reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	/* If command is already aborted/completed, return FAILED. */
-	if (!(test_bit(tag, &hba->outstanding_reqs))) {
+	if (!is_mcq_enabled(hba) && !(test_bit(tag, &hba->outstanding_reqs))) {
+		/* If command is already aborted/completed, return FAILED. */
 		dev_err(hba->dev,
 			"%s: cmd at tag %d already completed, outstanding=0x%lx, doorbell=0x%x\n",
 			__func__, tag, hba->outstanding_reqs, reg);
@@ -7439,7 +7471,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
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

