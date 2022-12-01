Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C463F23B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiLAOFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiLAOE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:04:57 -0500
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EA6A5192;
        Thu,  1 Dec 2022 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669903493;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=MIzn1NcSJedwLjPhIjJCpsTHdO40SqaloeB8f4zW50I=;
    b=KwRpCEUPNqIcOJUdwLuXGFhhWoA0PsnsV5J99AUGJYsQ8LaLhNVaXr5wca++qBn+M9
    IkjHZlvcqvEzElpraUWbftaJ0cOniI8wRIbnzwf4kp/GAvRTxCgfcWn9yscxAUSaGU9d
    nwi7K7m84CTBWDfYjP052xuZlRA7fxWn9imb7uEIAIHSi5ndBHcWZMXydz1qpOoraZEz
    10cBbJYJKa8fYzFjlX3Bj2QTINrRigvDbEKpwx8t/pHPaeFuhxNogRvvh2CcMUcOOwyT
    SM5FCEL6mYo+QvoUePuudHOIrTKKGqwxsBVA0l1SINpGQrHB8j08tPb1EJbNA25uq0DF
    BfWA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
X-RZG-CLASS-ID: mo03
Received: from blinux.micron.com
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyB1E4qHoZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 1 Dec 2022 15:04:52 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] ufs: core: Pass EHS length into ufshcd_prepare_req_desc_hdr()
Date:   Thu,  1 Dec 2022 15:04:36 +0100
Message-Id: <20221201140437.549272-7-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201140437.549272-1-beanhuo@iokpp.de>
References: <20221201140437.549272-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We need to fill in the total EHS length in UTP Transfer Request Descriptor,
add this functionality to ufshcd_prepare_req_desc_hdr().

Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 641fed6dae5d..bacc94f87ee2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2506,14 +2506,15 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
 }
 
 /**
- * ufshcd_prepare_req_desc_hdr() - Fills the requests header
+ * ufshcd_prepare_req_desc_hdr - Fill UTP Transfer request descriptor header according to request
  * descriptor according to request
  * @lrbp: pointer to local reference block
  * @upiu_flags: flags required in the header
  * @cmd_dir: requests data direction
+ * @ehs_length: Total EHS Length (in 32‐bytes units of all Extra Header Segments)
  */
-static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
-			u8 *upiu_flags, enum dma_data_direction cmd_dir)
+static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp, u8 *upiu_flags,
+					enum dma_data_direction cmd_dir, int ehs_length)
 {
 	struct utp_transfer_req_desc *req_desc = lrbp->utr_descriptor_ptr;
 	u32 data_direction;
@@ -2532,8 +2533,8 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 		*upiu_flags = UPIU_CMD_FLAGS_NONE;
 	}
 
-	dword_0 = data_direction | (lrbp->command_type
-				<< UPIU_COMMAND_TYPE_OFFSET);
+	dword_0 = data_direction | (lrbp->command_type << UPIU_COMMAND_TYPE_OFFSET) |
+		ehs_length << 8;
 	if (lrbp->intr_cmd)
 		dword_0 |= UTP_REQ_DESC_INT_CMD;
 
@@ -2588,8 +2589,7 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufshcd_lrb *lrbp, u8 upiu_flags)
 }
 
 /**
- * ufshcd_prepare_utp_query_req_upiu() - fills the utp_transfer_req_desc,
- * for query requsts
+ * ufshcd_prepare_utp_query_req_upiu() - fill the utp_transfer_req_desc for query request
  * @hba: UFS hba
  * @lrbp: local reference block pointer
  * @upiu_flags: flags
@@ -2660,7 +2660,7 @@ static int ufshcd_compose_devman_upiu(struct ufs_hba *hba,
 	else
 		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
 
-	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE);
+	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE, 0);
 	if (hba->dev_cmd.type == DEV_CMD_TYPE_QUERY)
 		ufshcd_prepare_utp_query_req_upiu(hba, lrbp, upiu_flags);
 	else if (hba->dev_cmd.type == DEV_CMD_TYPE_NOP)
@@ -2688,8 +2688,7 @@ static int ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
 
 	if (likely(lrbp->cmd)) {
-		ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags,
-						lrbp->cmd->sc_data_direction);
+		ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, lrbp->cmd->sc_data_direction, 0);
 		ufshcd_prepare_utp_scsi_cmd_upiu(lrbp, upiu_flags);
 	} else {
 		ret = -EINVAL;
@@ -6884,7 +6883,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	/* update the task tag in the request upiu */
 	req_upiu->header.dword_0 |= cpu_to_be32(tag);
 
-	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE);
+	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE, 0);
 
 	/* just copy the upiu request as it is */
 	memcpy(lrbp->ucd_req_ptr, req_upiu, sizeof(*lrbp->ucd_req_ptr));
-- 
2.25.1

