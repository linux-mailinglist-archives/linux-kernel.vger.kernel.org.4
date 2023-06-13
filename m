Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E74E72D70B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbjFMBiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjFMBiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:38:10 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DBC1726
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:38:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QgB5L4WM8z4f3mKx
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:37:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3mp52yIdkGIRNLg--.33211S4;
        Tue, 13 Jun 2023 09:38:00 +0800 (CST)
From:   linan666@huaweicloud.com
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH] dm: Support turning off io stat accounting
Date:   Tue, 13 Jun 2023 09:33:32 +0800
Message-Id: <20230613013332.4078896-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3mp52yIdkGIRNLg--.33211S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF45KFyfZr4kZrWkuw4xXrb_yoW5XryDpF
        WDW34Syr4rWa12ga1UW3y7ua4Fga93KryUCrW3C39a9a1UKryDAr4UtFW3Xr1kJFyxCFy2
        qF10kFyDCayrArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40E
        w7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwc_TUU
        UUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

Commit bc58ba9468d9 ("block: add sysfs file for controlling io stats
accounting") allowed user to turn off disk stat accounting completely by
queue flag QUEUE_FLAG_IO_STAT. In dm, this flag is not set. io stats
is continuously counted and cannot be turn off.

Support turning off io stat accounting for dm. Set QUEUE_FLAG_IO_STAT for
dm request_queue. When the io starts, we account the io using DM_IO_STAT
dm_io flag to avoid io stats disable in the middle of the io. DM statistics
is independent of block io stat and remains unchanged.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/dm-core.h  |  3 ++-
 drivers/md/dm-table.c |  1 +
 drivers/md/dm.c       | 15 ++++++++++-----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index aecab0c0720f..8b0af3e1331a 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -307,7 +307,8 @@ struct dm_io {
  */
 enum {
 	DM_IO_ACCOUNTED,
-	DM_IO_WAS_SPLIT
+	DM_IO_WAS_SPLIT,
+	DM_IO_STAT
 };
 
 static inline bool dm_io_flagged(struct dm_io *io, unsigned int bit)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 1398f1d6e83e..bd5e16a3f2b1 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1936,6 +1936,7 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	 */
 	q->limits = *limits;
 
+	blk_queue_flag_set(QUEUE_FLAG_IO_STAT, q);
 	if (dm_table_supports_nowait(t))
 		blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
 	else
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3b694ba3a106..82b73536bd93 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -511,11 +511,14 @@ static void dm_io_acct(struct dm_io *io, bool end)
 	else
 		sectors = io->sectors;
 
-	if (!end)
-		bdev_start_io_acct(bio->bi_bdev, bio_op(bio), start_time);
-	else
-		bdev_end_io_acct(bio->bi_bdev, bio_op(bio), sectors,
-				 start_time);
+	if (dm_io_flagged(io, DM_IO_STAT)) {
+		if (!end)
+			bdev_start_io_acct(bio->bi_bdev, bio_op(bio),
+					   start_time);
+		else
+			bdev_end_io_acct(bio->bi_bdev, bio_op(bio),
+					 sectors, start_time);
+	}
 
 	if (static_branch_unlikely(&stats_enabled) &&
 	    unlikely(dm_stats_used(&md->stats))) {
@@ -592,6 +595,8 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	spin_lock_init(&io->lock);
 	io->start_time = jiffies;
 	io->flags = 0;
+	if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
+		dm_io_set_flag(io, DM_IO_STAT);
 
 	if (static_branch_unlikely(&stats_enabled))
 		dm_stats_record_start(&md->stats, &io->stats_aux);
-- 
2.39.2

