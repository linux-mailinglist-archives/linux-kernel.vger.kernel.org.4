Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629636B3F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCJMiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjCJMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:37:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8846310BA7E;
        Fri, 10 Mar 2023 04:37:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 231FFB82289;
        Fri, 10 Mar 2023 12:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4EEC433EF;
        Fri, 10 Mar 2023 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678451831;
        bh=9sWEZ+1Z6ff9ke3ovuR4A8ZZM7aSKC6q9nzpFqVYUWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=K691tFqLWrfiRfkOdRaxKhOpqrE5N6Tl7R8UW/BN88jIdJ7JKkjCE3asYO5lAI38D
         cifNUwzA5C+G0YPnIO9l1noAiJurl8yS5sXZR/gM/1y3Q5OJj2zXUxhKO3tNBaaWJs
         uDIgNSvo06xTcgI4sKtAMEATeHvDMJy2zTFXrpQRwanGm34POeb/CLp52hmBEaMwIi
         76XnA/4TcwYTG3zPZd7Aj5pMjWjESNoJ+Bq5k8YzD0tf86hzUo0vD85ypOGMYvcbR3
         AFew8gkuY3Q8JQ4cDdAqLpn6dB4A2cFAjixOcEsAmHZbt1IqB5qtQOlweeYld4XKzE
         sZwtjVx1Eqo+A==
From:   Chao Yu <chao@kernel.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     bvanassche@acm.org, hch@infradead.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v5] scsi: support packing multi-segment in UNMAP command
Date:   Fri, 10 Mar 2023 20:36:04 +0800
Message-Id: <20230310123604.1820231-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As SCSI SBC4 specification section 5.30.2 describes that it can
support unmapping one or more LBA range in single UNMAP command.

However, previously we only pack one LBA range in UNMAP command
by default no matter device gives the block limits that says it
can support unmapping multiple LBA ranges with a single UNMAP
command.

This patch sets max_discard_segments config according to block
limits of device, and supports unmapping multiple LBA ranges with
a single UNMAP command.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v5:
- fix to assign cmd->cmnd[7] and cmd->cmnd[8] w/ data_len correctly.
- fix to let ufshpb recognize and handle discard request which contains
multiple ranges correctly.
 drivers/scsi/sd.c         | 36 +++++++++++++++++++++++++-----------
 drivers/scsi/sd.h         |  1 +
 drivers/ufs/core/ufshpb.c | 21 +++++++++++++++++++--
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4bb87043e6db..1908b31c7342 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -792,6 +792,8 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 	q->limits.discard_granularity =
 		max(sdkp->physical_block_size,
 		    sdkp->unmap_granularity * logical_block_size);
+	blk_queue_max_discard_segments(q, min_t(u32, U16_MAX,
+				sdkp->max_unmap_block_desc_count));
 	sdkp->provisioning_mode = mode;
 
 	switch (mode) {
@@ -851,9 +853,10 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
-	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
-	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
-	unsigned int data_len = 24;
+	unsigned short segments = blk_rq_nr_discard_segments(rq);
+	unsigned int data_len = 8 + 16 * segments;
+	unsigned int descriptor_offset = 8;
+	struct bio *bio;
 	char *buf;
 
 	buf = sd_set_special_bvec(rq, data_len);
@@ -862,12 +865,20 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 
 	cmd->cmd_len = 10;
 	cmd->cmnd[0] = UNMAP;
-	cmd->cmnd[8] = 24;
+	cmd->cmnd[7] = data_len >> 8;
+	cmd->cmnd[8] = data_len & 0xff;
+
+	put_unaligned_be16(6 + 16 * segments, &buf[0]);
+	put_unaligned_be16(16 * segments, &buf[2]);
 
-	put_unaligned_be16(6 + 16, &buf[0]);
-	put_unaligned_be16(16, &buf[2]);
-	put_unaligned_be64(lba, &buf[8]);
-	put_unaligned_be32(nr_blocks, &buf[16]);
+	__rq_for_each_bio(bio, rq) {
+		u64 lba = sectors_to_logical(sdp, bio->bi_iter.bi_sector);
+		u32 nr_blocks = sectors_to_logical(sdp, bio_sectors(bio));
+
+		put_unaligned_be64(lba, &buf[descriptor_offset]);
+		put_unaligned_be32(nr_blocks, &buf[descriptor_offset + 8]);
+		descriptor_offset += 16;
+	}
 
 	cmd->allowed = sdkp->max_retries;
 	cmd->transfersize = data_len;
@@ -2917,7 +2928,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 	sdkp->opt_xfer_blocks = get_unaligned_be32(&vpd->data[12]);
 
 	if (vpd->len >= 64) {
-		unsigned int lba_count, desc_count;
+		unsigned int lba_count;
 
 		sdkp->max_ws_blocks = (u32)get_unaligned_be64(&vpd->data[36]);
 
@@ -2925,9 +2936,12 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 			goto out;
 
 		lba_count = get_unaligned_be32(&vpd->data[20]);
-		desc_count = get_unaligned_be32(&vpd->data[24]);
 
-		if (lba_count && desc_count)
+		/* Extract the MAXIMUM UNMAP BLOCK DESCRIPTOR COUNT. */
+		sdkp->max_unmap_block_desc_count =
+					get_unaligned_be32(&vpd->data[24]);
+
+		if (lba_count && sdkp->max_unmap_block_desc_count)
 			sdkp->max_unmap_blocks = lba_count;
 
 		sdkp->unmap_granularity = get_unaligned_be32(&vpd->data[28]);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5eea762f84d1..e7c51d23395b 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -119,6 +119,7 @@ struct scsi_disk {
 	u32		opt_xfer_blocks;
 	u32		max_ws_blocks;
 	u32		max_unmap_blocks;
+	u32		max_unmap_block_desc_count;
 	u32		unmap_granularity;
 	u32		unmap_alignment;
 	u32		index;
diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index a46a7666c891..327b29cf506f 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -383,13 +383,30 @@ int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	rgn = hpb->rgn_tbl + rgn_idx;
 	srgn = rgn->srgn_tbl + srgn_idx;
 
-	/* If command type is WRITE or DISCARD, set bitmap as dirty */
-	if (ufshpb_is_write_or_discard(cmd)) {
+	/* If command type is WRITE, set bitmap as dirty */
+	if (op_is_write(req_op(scsi_cmd_to_rq(cmd)))) {
 		ufshpb_iterate_rgn(hpb, rgn_idx, srgn_idx, srgn_offset,
 				   transfer_len, true);
 		return 0;
 	}
 
+	/* If command type is DISCARD, set bitmap as dirty */
+	if (op_is_discard(req_op(scsi_cmd_to_rq(cmd)))) {
+		struct bio *bio;
+
+		__rq_for_each_bio(bio, scsi_cmd_to_rq(cmd)) {
+			lpn = sectors_to_logical(cmd->device,
+						bio->bi_iter.bi_sector);
+			transfer_len = sectors_to_logical(cmd->device,
+							bio_sectors(bio));
+			ufshpb_get_pos_from_lpn(hpb, lpn, &rgn_idx,
+						&srgn_idx, &srgn_offset);
+			ufshpb_iterate_rgn(hpb, rgn_idx, srgn_idx,
+					srgn_offset, transfer_len, true);
+		}
+		return 0;
+	}
+
 	if (!ufshpb_is_supported_chunk(hpb, transfer_len))
 		return 0;
 
-- 
2.25.1

