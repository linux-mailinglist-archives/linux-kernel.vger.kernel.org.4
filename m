Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCD963160D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 20:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKTTuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 14:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKTTtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 14:49:47 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F3B2E9EB;
        Sun, 20 Nov 2022 11:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1668973779;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=i/hP+BNTbKHkp5aptNnxVflJu3FZ4tJ6s/JXowJobxU=;
    b=snJKObeChR7FyjTqg8m49m67HWMiV6mcegk28USEyHpdIfy+zDkzWr2yNXFCOafEqW
    7JZbmUNnW8Kz3kLdeGPnjkrEExZAAHDu7zwVRARGAbo+YTUDCKFAC2FRKeQ3PRjcTBYe
    phZKnnSRrv556/7sMPDowkXy611WRgVsn5Tet595GURKufOOMVXnCVpS5Zd0izWYreWV
    m65JgFqJJkOWBok4dr8sMA336GrCqxEW4Uk/35zkNMbEP/iNF/VzLU7LkqBI98NnkOra
    jrml5Skw2FX15G+fomXoBH7fymPAY/pokL+b5RGQXc6ldkuVYANbIHCLdQRERaL61UyB
    U/8g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RvWtIfZ/7Q8ZGqEBlwxF4QH61wYa9UK/y81Dg=="
X-RZG-CLASS-ID: mo02
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyAKJncWNX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 20 Nov 2022 20:49:38 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] ufs: ufs_bsg: Cleanup ufs_bsg_request
Date:   Sun, 20 Nov 2022 20:49:26 +0100
Message-Id: <20221120194930.90283-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221120194930.90283-1-beanhuo@iokpp.de>
References: <20221120194930.90283-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Move sg_copy_from_buffer() below its associated case statement.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufs_bsg.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 9ac8204f1ee6..850a0d798f63 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -90,11 +90,8 @@ static int ufs_bsg_request(struct bsg_job *job)
 		desc_op = bsg_request->upiu_req.qr.opcode;
 		ret = ufs_bsg_alloc_desc_buffer(hba, job, &desc_buff,
 						&desc_len, desc_op);
-		if (ret) {
-			ufshcd_rpm_put_sync(hba);
+		if (ret)
 			goto out;
-		}
-
 		fallthrough;
 	case UPIU_TRANSACTION_NOP_OUT:
 	case UPIU_TRANSACTION_TASK_REQ:
@@ -102,9 +99,12 @@ static int ufs_bsg_request(struct bsg_job *job)
 					       &bsg_reply->upiu_rsp, msgcode,
 					       desc_buff, &desc_len, desc_op);
 		if (ret)
-			dev_err(hba->dev,
-				"exe raw upiu: error code %d\n", ret);
-
+			dev_err(hba->dev, "exe raw upiu: error code %d\n", ret);
+		else if (desc_op == UPIU_QUERY_OPCODE_READ_DESC && desc_len)
+			bsg_reply->reply_payload_rcv_len =
+				sg_copy_from_buffer(job->request_payload.sg_list,
+						    job->request_payload.sg_cnt,
+						    desc_buff, desc_len);
 		break;
 	case UPIU_TRANSACTION_UIC_CMD:
 		memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE);
@@ -123,20 +123,9 @@ static int ufs_bsg_request(struct bsg_job *job)
 		break;
 	}
 
+out:
 	ufshcd_rpm_put_sync(hba);
-
-	if (!desc_buff)
-		goto out;
-
-	if (desc_op == UPIU_QUERY_OPCODE_READ_DESC && desc_len)
-		bsg_reply->reply_payload_rcv_len =
-			sg_copy_from_buffer(job->request_payload.sg_list,
-					    job->request_payload.sg_cnt,
-					    desc_buff, desc_len);
-
 	kfree(desc_buff);
-
-out:
 	bsg_reply->result = ret;
 	job->reply_len = sizeof(struct ufs_bsg_reply);
 	/* complete the job here only if no error */
-- 
2.25.1

