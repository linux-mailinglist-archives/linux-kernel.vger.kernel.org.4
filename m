Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1327063F233
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiLAOE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiLAOE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:04:56 -0500
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAAC9C61B;
        Thu,  1 Dec 2022 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669903491;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=8eyKC2fgrN9qumLxJ3Hcsm6flrWlMQT35zpuY2GjhlA=;
    b=kTTGkmMue8mQ3qeF+gLkKNkSuf7cDNw2REOfX9/BSKmZCMVb/YzjYEnHmRUITcNJGZ
    C3+a0FQoDCn4+qqQ6G6DRbign8gK8kY5+zDx3LEdecGOUQ2FvKu0kKGq/uR2SgZ0U4vz
    kJrUy11HdTUSZe7y9cyU1djlxbE5X6igsb0Eaeppnx1Q5cH8aIf5KJ6NiEODdm/wd7LI
    36C6N8TPwWpHDhVriEQIH4gZ49sHCjTdqvz1N9qqMa3IVVKc+yjInbYhCrC0FdeZQCMS
    P0EwNJAF6FfeG3s6/9YFzN7tZO1d3cN2IybGVgzzDS+LDEDCZOuFg5Wz0ccvrH2K0F80
    3/iw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
X-RZG-CLASS-ID: mo02
Received: from blinux.micron.com
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyB1E4pHoW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 1 Dec 2022 15:04:51 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] ufs: core: Split ufshcd_map_sg
Date:   Thu,  1 Dec 2022 15:04:34 +0100
Message-Id: <20221201140437.549272-5-beanhuo@iokpp.de>
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

Take out the "map scatter-gather list to prdt" part of the code in
ufshcd_map_sg and split it into a new function ufshcd_sgl_to_prdt.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 48 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 2dbe24977822..d1bcb4c4e4e4 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2399,38 +2399,30 @@ int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 }
 
 /**
- * ufshcd_map_sg - Map scatter-gather list to prdt
- * @hba: per adapter instance
- * @lrbp: pointer to local reference block
- *
- * Returns 0 in case of success, non-zero value in case of failure
+ * ufshcd_sgl_to_prdt - SG list to PRTD (Physical Region Description Table, 4DW format)
+ * @hba:	per-adapter instance
+ * @lrbp:	pointer to local reference block
+ * @sg_entries:	The number of sg lists actually used
+ * @sg_list:	Pointer to SG list
  */
-static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
+static void ufshcd_sgl_to_prdt(struct ufs_hba *hba, struct ufshcd_lrb *lrbp, int sg_entries,
+			       struct scatterlist *sg_list)
 {
 	struct ufshcd_sg_entry *prd_table;
 	struct scatterlist *sg;
-	struct scsi_cmnd *cmd;
-	int sg_segments;
 	int i;
 
-	cmd = lrbp->cmd;
-	sg_segments = scsi_dma_map(cmd);
-	if (sg_segments < 0)
-		return sg_segments;
-
-	if (sg_segments) {
+	if (sg_entries) {
 
 		if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN)
 			lrbp->utr_descriptor_ptr->prd_table_length =
-				cpu_to_le16((sg_segments *
-					sizeof(struct ufshcd_sg_entry)));
+				cpu_to_le16((sg_entries * sizeof(struct ufshcd_sg_entry)));
 		else
-			lrbp->utr_descriptor_ptr->prd_table_length =
-				cpu_to_le16(sg_segments);
+			lrbp->utr_descriptor_ptr->prd_table_length = cpu_to_le16(sg_entries);
 
 		prd_table = lrbp->ucd_prdt_ptr;
 
-		scsi_for_each_sg(cmd, sg, sg_segments, i) {
+		for_each_sg(sg_list, sg, sg_entries, i) {
 			const unsigned int len = sg_dma_len(sg);
 
 			/*
@@ -2449,6 +2441,24 @@ static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	} else {
 		lrbp->utr_descriptor_ptr->prd_table_length = 0;
 	}
+}
+
+/**
+ * ufshcd_map_sg - Map scatter-gather list to prdt
+ * @hba: per adapter instance
+ * @lrbp: pointer to local reference block
+ *
+ * Returns 0 in case of success, non-zero value in case of failure
+ */
+static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
+{
+	struct scsi_cmnd *cmd = lrbp->cmd;
+	int sg_segments = scsi_dma_map(cmd);
+
+	if (sg_segments < 0)
+		return sg_segments;
+
+	ufshcd_sgl_to_prdt(hba, lrbp, sg_segments, scsi_sglist(cmd));
 
 	return 0;
 }
-- 
2.25.1

