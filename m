Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327126316C7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 23:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKTWWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 17:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTWWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 17:22:34 -0500
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCA795B7;
        Sun, 20 Nov 2022 14:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1668982948;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=AoDuL4Xj3zDQl9TURGe3xsxqp70mUfT+N6ozH7NwzN8=;
    b=EycFjyOsj7Lz1Cdm8IvA7YIG41q91u7T5sfpDRfIWBw2dUNnisWK4UpH6Mra/5nFA8
    9q3FRiWFUt7vJ53aLJegiyai1E9iFMG2+H75q9/a+/GDhF/LNX6Ms26TNMJNvD3GKgv/
    GmTiKCegubsMleIYxNDq1enbvhIUqWw7THNtWIpS6wTwC/oK6rUcA46/D7PUEZQw/+8x
    xt4ZkqIX0DARDjvcAbfCwScuTdN4EQZBSaXCPEvDofyHeMmQtnZ9B4ZaHdCnqvtKBdv/
    7sCl+Kxo3waKxu07S0EcdBp96Zo4QtAl8O1i8Uddmsc87cUsYZEIeqiH+EefzvLHX1sD
    kpZA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RvWtIfZ/7Q8ZGqEBlwxF4QH61wYa9UK/y81Dg=="
X-RZG-CLASS-ID: mo03
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyAKMMSWc7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 20 Nov 2022 23:22:28 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ufs: core: Split ufshcd_map_sg
Date:   Sun, 20 Nov 2022 23:22:14 +0100
Message-Id: <20221120222217.108492-4-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221120222217.108492-1-beanhuo@iokpp.de>
References: <20221120222217.108492-1-beanhuo@iokpp.de>
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
---
 drivers/ufs/core/ufshcd.c | 50 ++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 768cb49d269c..1b252e6cf93f 100644
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
@@ -2449,6 +2441,26 @@ static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
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
+	struct scsi_cmnd *cmd;
+	int sg_segments;
+
+	cmd = lrbp->cmd;
+	sg_segments = scsi_dma_map(cmd);
+	if (sg_segments < 0)
+		return sg_segments;
+
+	ufshcd_sgl_to_prdt(hba, lrbp, sg_segments, scsi_sglist(cmd));
 
 	return 0;
 }
-- 
2.25.1

