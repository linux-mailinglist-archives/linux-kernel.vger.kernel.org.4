Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28F663F240
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiLAOFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiLAOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:04:58 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B57CA518F;
        Thu,  1 Dec 2022 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669903490;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wcfxSKOuTbBkcUevcdbx3NdSEBMJ+Px6H+Sh6zzv4Yg=;
    b=slw7R3c1xLvlD7j6uBQooP6HrSurV0s5316sovCe31eS+Or1kewtoSa4CDWCQo3bvv
    IgscYiJz4iTAMV76vdQBgQrb8Re2WjYon+mSg3rBKAVmUvZZ6pmgAkQTVe76gDOr5oQE
    gA5YZx8IbWczQhoGkzoluDytfYeK74jQlNOnxnObJ+ab/vPGyeeGglAgfy1BodniJ8i/
    C4KC6mWjuK7oK7G4OaHzCVoL3XGQMSfgpijQ7FmXQlWKf71rDse1YSeZuwL7agK+bQLF
    LKISshD/oa7KaiMv02BtZ2znB18W0yprIwO+QmKTrgEzyfJGDF7Pg6PyV/wL9oqaxLpW
    mhxg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
X-RZG-CLASS-ID: mo02
Received: from blinux.micron.com
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyB1E4oHoV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 1 Dec 2022 15:04:50 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] ufs: ufs_bsg: Cleanup ufs_bsg_request
Date:   Thu,  1 Dec 2022 15:04:33 +0100
Message-Id: <20221201140437.549272-4-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201140437.549272-1-beanhuo@iokpp.de>
References: <20221201140437.549272-1-beanhuo@iokpp.de>
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
Reviewed-by: Avri Altman <avri.altman@wdc.com>
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

