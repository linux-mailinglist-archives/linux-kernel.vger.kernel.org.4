Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55E6A0427
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjBWItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjBWItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:49:04 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEA837F1C;
        Thu, 23 Feb 2023 00:49:02 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PMmsP1D3Qz4f3l7D;
        Thu, 23 Feb 2023 16:48:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgBH9CF5KPdjdmo0Dw--.40730S4;
        Thu, 23 Feb 2023 16:48:59 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, guz.fnst@cn.fujitsu.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next RFC] block: count 'ios' and 'sectors' when io is done for bio-based device
Date:   Thu, 23 Feb 2023 17:12:26 +0800
Message-Id: <20230223091226.1135678-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CF5KPdjdmo0Dw--.40730S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1fXr43Gr1DGr4UXr4rGrg_yoW7AF1fpF
        48W3WrCrZrXwnYg3yUAayDuF1rKa10q347AFW7J345Zw4ktryvvF10y3Wqyr15Ca97uFW7
        Aa48AF9rur42k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        U6c_fUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

While using iostat for raid, I observed very strange 'await'
occasionally, and turns out it's due to that 'ios' and 'sectors' is
counted in bdev_start_io_acct(), while 'nsecs' is counted in
bdev_end_io_acct(). I'm not sure why they are ccounted like that
but I think this behaviour is obviously wrong because user will get
wrong disk stats.

Fix the problem by counting 'ios' and 'sectors' when io is done, like
what rq-based device does.

Fixes: 394ffa503bc4 ("blk: introduce generic io stat accounting help function")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c              | 16 ++++++----------
 drivers/md/dm.c               |  6 +++---
 drivers/nvme/host/multipath.c |  8 ++++----
 include/linux/blkdev.h        |  5 ++---
 4 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 82b5b2c53f1e..fe1d320f5f07 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -953,16 +953,11 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 	}
 }
 
-unsigned long bdev_start_io_acct(struct block_device *bdev,
-				 unsigned int sectors, enum req_op op,
+unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
 				 unsigned long start_time)
 {
-	const int sgrp = op_stat_group(op);
-
 	part_stat_lock();
 	update_io_ticks(bdev, start_time, false);
-	part_stat_inc(bdev, ios[sgrp]);
-	part_stat_add(bdev, sectors[sgrp], sectors);
 	part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
@@ -978,13 +973,12 @@ EXPORT_SYMBOL(bdev_start_io_acct);
  */
 unsigned long bio_start_io_acct(struct bio *bio)
 {
-	return bdev_start_io_acct(bio->bi_bdev, bio_sectors(bio),
-				  bio_op(bio), jiffies);
+	return bdev_start_io_acct(bio->bi_bdev, bio_op(bio), jiffies);
 }
 EXPORT_SYMBOL_GPL(bio_start_io_acct);
 
 void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
-		      unsigned long start_time)
+		      unsigned int sectors, unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
 	unsigned long now = READ_ONCE(jiffies);
@@ -992,6 +986,8 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 
 	part_stat_lock();
 	update_io_ticks(bdev, now, true);
+	part_stat_inc(bdev, ios[sgrp]);
+	part_stat_add(bdev, sectors[sgrp], sectors);
 	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
 	part_stat_unlock();
@@ -1001,7 +997,7 @@ EXPORT_SYMBOL(bdev_end_io_acct);
 void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
 			      struct block_device *orig_bdev)
 {
-	bdev_end_io_acct(orig_bdev, bio_op(bio), start_time);
+	bdev_end_io_acct(orig_bdev, bio_op(bio), bio_sectors(bio), start_time);
 }
 EXPORT_SYMBOL_GPL(bio_end_io_acct_remapped);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index eace45a18d45..f5cc330bb549 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -512,10 +512,10 @@ static void dm_io_acct(struct dm_io *io, bool end)
 		sectors = io->sectors;
 
 	if (!end)
-		bdev_start_io_acct(bio->bi_bdev, sectors, bio_op(bio),
-				   start_time);
+		bdev_start_io_acct(bio->bi_bdev, bio_op(bio), start_time);
 	else
-		bdev_end_io_acct(bio->bi_bdev, bio_op(bio), start_time);
+		bdev_end_io_acct(bio->bi_bdev, bio_op(bio), sectors,
+				 start_time);
 
 	if (static_branch_unlikely(&stats_enabled) &&
 	    unlikely(dm_stats_used(&md->stats))) {
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index fc39d01e7b63..9171452e2f6d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -123,9 +123,8 @@ void nvme_mpath_start_request(struct request *rq)
 		return;
 
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
-	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0,
-					blk_rq_bytes(rq) >> SECTOR_SHIFT,
-					req_op(rq), jiffies);
+	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
+						      jiffies);
 }
 EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
 
@@ -136,7 +135,8 @@ void nvme_mpath_end_request(struct request *rq)
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
-		nvme_req(rq)->start_time);
+			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
+			 nvme_req(rq)->start_time);
 }
 
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d1aee08f8c18..941304f17492 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1446,11 +1446,10 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 		wake_up_process(waiter);
 }
 
-unsigned long bdev_start_io_acct(struct block_device *bdev,
-				 unsigned int sectors, enum req_op op,
+unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
 				 unsigned long start_time);
 void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
-		unsigned long start_time);
+		      unsigned int sectors, unsigned long start_time);
 
 unsigned long bio_start_io_acct(struct bio *bio);
 void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
-- 
2.31.1

