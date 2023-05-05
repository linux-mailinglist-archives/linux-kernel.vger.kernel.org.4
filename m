Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12836F862A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjEEPuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjEEPut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0204459D8
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B3DF61463
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 15:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC279C433D2;
        Fri,  5 May 2023 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683301846;
        bh=CDHn8TlmIRVpbZP3dhIjrM+46IXW3eOwMG/RUV0P/vY=;
        h=From:To:Cc:Subject:Date:From;
        b=ImHYPVkHlHHobpHo8LHtCvK0LCQ6BPGU68wAGaiAzUeNLXf/VrzskOEG7Uwsjfeyj
         c50niOn1S+HLwCaYqguC3YWfsqxqxT6zWJrTH9AlNAZ5tg4zWmV8H22quUgDaI7SV6
         W/gdPj74wq8a+23wCkywiWkqkWzsHMXYWVUTYn8FpezpjW3vbBtjVMNSRECe0Q6uag
         70qhGoqnEgjtbvZNsTQ7/9OJq1wkYBqMxl7lUl+Gut+bgt1iEDLDS0IH1H481Tol1n
         DFT5Ei43hxFaViwNUcHh5mL58/WMfWSBh2/iClWfc77lQOk54DXtsRHHSsWUt5CtFY
         6M0DJNKFe/rCw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Daeho Jeong <daehojeong@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: maintain six open zones for zoned devices
Date:   Fri,  5 May 2023 08:50:40 -0700
Message-ID: <20230505155040.87561-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

To keep six open zone constraints, make them not to be open over six
open zones.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h |  5 +++++
 2 files changed, 62 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7dd92a9028b1..bb9de0a02143 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -383,6 +383,17 @@ static void f2fs_write_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static void f2fs_zone_write_end_io(struct bio *bio)
+{
+	struct f2fs_bio_info *io = (struct f2fs_bio_info *)bio->bi_private;
+
+	bio->bi_private = io->bi_private;
+	complete(&io->zone_wait);
+	f2fs_write_end_io(bio);
+}
+#endif
+
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 		block_t blk_addr, sector_t *sector)
 {
@@ -639,6 +650,10 @@ int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi)
 			INIT_LIST_HEAD(&sbi->write_io[i][j].io_list);
 			INIT_LIST_HEAD(&sbi->write_io[i][j].bio_list);
 			init_f2fs_rwsem(&sbi->write_io[i][j].bio_list_lock);
+#ifdef CONFIG_BLK_DEV_ZONED
+			sbi->write_io[i][j].zone_pending_bio = NULL;
+			sbi->write_io[i][j].bi_private = NULL;
+#endif
 		}
 	}
 
@@ -965,6 +980,26 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
+{
+	int devi = 0;
+
+	if (f2fs_is_multi_device(sbi)) {
+		devi = f2fs_target_device_index(sbi, blkaddr);
+		if (blkaddr < FDEV(devi).start_blk ||
+		    blkaddr > FDEV(devi).end_blk) {
+			f2fs_err(sbi, "Invalid block %x", blkaddr);
+			return false;
+		}
+		blkaddr -= FDEV(devi).start_blk;
+	}
+	return bdev_zoned_model(FDEV(devi).bdev) == BLK_ZONED_HM &&
+		f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
+		(blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
+}
+#endif
+
 void f2fs_submit_page_write(struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
@@ -975,6 +1010,16 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
 	f2fs_down_write(&io->io_rwsem);
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_has_blkzoned(sbi) && btype < META && io->zone_pending_bio) {
+		wait_for_completion_io(&io->zone_wait);
+		bio_put(io->zone_pending_bio);
+		io->zone_pending_bio = NULL;
+		io->bi_private = NULL;
+	}
+#endif
+
 next:
 	if (fio->in_list) {
 		spin_lock(&io->io_lock);
@@ -1038,6 +1083,18 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	if (fio->in_list)
 		goto next;
 out:
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
+			is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
+		bio_get(io->bio);
+		init_completion(&io->zone_wait);
+		io->bi_private = io->bio->bi_private;
+		io->bio->bi_private = io;
+		io->bio->bi_end_io = f2fs_zone_write_end_io;
+		io->zone_pending_bio = io->bio;
+		__submit_merged_bio(io);
+	}
+#endif
 	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
 				!f2fs_is_checkpoint_ready(sbi))
 		__submit_merged_bio(io);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7afc9aef127a..0f05c1dd633f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1218,6 +1218,11 @@ struct f2fs_bio_info {
 	struct bio *bio;		/* bios to merge */
 	sector_t last_block_in_bio;	/* last block number */
 	struct f2fs_io_info fio;	/* store buffered io info. */
+#ifdef CONFIG_BLK_DEV_ZONED
+	struct completion zone_wait;	/* condition value for the previous open zone to close */
+	struct bio *zone_pending_bio;	/* pending bio for the previous zone */
+	void *bi_private;		/* previous bi_private for pending bio */
+#endif
 	struct f2fs_rwsem io_rwsem;	/* blocking op for bio */
 	spinlock_t io_lock;		/* serialize DATA/NODE IOs */
 	struct list_head io_list;	/* track fios */
-- 
2.40.1.521.gf1e218fcd8-goog

