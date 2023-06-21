Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B50C737EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjFUIxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjFUIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:52:46 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6490D170C;
        Wed, 21 Jun 2023 01:52:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QmHMD3LfYz4f4cB1;
        Wed, 21 Jun 2023 16:52:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBWupJkbVnFMA--.53622S6;
        Wed, 21 Jun 2023 16:52:41 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 2/8] md: also clone new io if io accounting is disabled
Date:   Thu, 22 Jun 2023 00:51:04 +0800
Message-Id: <20230621165110.1498313-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
References: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBWupJkbVnFMA--.53622S6
X-Coremail-Antispam: 1UD129KBjvJXoW3ArWfCr43WrWxWw4kCF47CFg_yoW3XFWxpa
        1Igas8Wr45XrZYgFW2ka4v93WftrnFgrZ3tryxXw1rAF1Skryvka1rWa48Ary5GFW8CF9F
        93WkKF17ur1xKrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
        CS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
        W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
        0piHmhUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, 'active_io' is grabbed before make_reqeust() is called, and
it's dropped immediately make_reqeust() returns. Hence 'active_io'
actually means io is dispatching, not io is inflight.

For raid0 and raid456 that io accounting is enabled, 'active_io' will
also be grabbed when bio is cloned for io accounting, and this 'active_io'
is dropped until io is done.

Always clone new bio so that 'active_io' will mean that io is inflight,
raid1 and raid10 will switch to use this method in later patches.

Now that bio will be cloned even if io accounting is disabled, also
rename related structure from '*_acct_*' to '*_clone_*'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c    | 61 ++++++++++++++++++++++++----------------------
 drivers/md/md.h    |  4 +--
 drivers/md/raid5.c | 18 +++++++-------
 3 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e56e1dd80999..1086d7282ee7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2314,7 +2314,7 @@ int md_integrity_register(struct mddev *mddev)
 	pr_debug("md: data integrity enabled on %s\n", mdname(mddev));
 	if (bioset_integrity_create(&mddev->bio_set, BIO_POOL_SIZE) ||
 	    (mddev->level != 1 && mddev->level != 10 &&
-	     bioset_integrity_create(&mddev->io_acct_set, BIO_POOL_SIZE))) {
+	     bioset_integrity_create(&mddev->io_clone_set, BIO_POOL_SIZE))) {
 		/*
 		 * No need to handle the failure of bioset_integrity_create,
 		 * because the function is called by md_run() -> pers->run(),
@@ -5886,9 +5886,9 @@ int md_run(struct mddev *mddev)
 			goto exit_bio_set;
 	}
 
-	if (!bioset_initialized(&mddev->io_acct_set)) {
-		err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
-				  offsetof(struct md_io_acct, bio_clone), 0);
+	if (!bioset_initialized(&mddev->io_clone_set)) {
+		err = bioset_init(&mddev->io_clone_set, BIO_POOL_SIZE,
+				  offsetof(struct md_io_clone, bio_clone), 0);
 		if (err)
 			goto exit_sync_set;
 	}
@@ -6070,7 +6070,7 @@ int md_run(struct mddev *mddev)
 	module_put(pers->owner);
 	md_bitmap_destroy(mddev);
 abort:
-	bioset_exit(&mddev->io_acct_set);
+	bioset_exit(&mddev->io_clone_set);
 exit_sync_set:
 	bioset_exit(&mddev->sync_set);
 exit_bio_set:
@@ -6295,7 +6295,7 @@ static void __md_stop(struct mddev *mddev)
 	percpu_ref_exit(&mddev->active_io);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
-	bioset_exit(&mddev->io_acct_set);
+	bioset_exit(&mddev->io_clone_set);
 }
 
 void md_stop(struct mddev *mddev)
@@ -8652,45 +8652,48 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 }
 EXPORT_SYMBOL_GPL(md_submit_discard_bio);
 
-static void md_end_io_acct(struct bio *bio)
+static void md_end_clone_io(struct bio *bio)
 {
-	struct md_io_acct *md_io_acct = bio->bi_private;
-	struct bio *orig_bio = md_io_acct->orig_bio;
-	struct mddev *mddev = md_io_acct->mddev;
+	struct md_io_clone *md_io_clone = bio->bi_private;
+	struct bio *orig_bio = md_io_clone->orig_bio;
+	struct mddev *mddev = md_io_clone->mddev;
 
 	orig_bio->bi_status = bio->bi_status;
 
-	bio_end_io_acct(orig_bio, md_io_acct->start_time);
+	if (md_io_clone->start_time)
+		bio_end_io_acct(orig_bio, md_io_clone->start_time);
+
 	bio_put(bio);
 	bio_endio(orig_bio);
-
 	percpu_ref_put(&mddev->active_io);
 }
 
+static void md_clone_bio(struct mddev *mddev, struct bio **bio)
+{
+	struct block_device *bdev = (*bio)->bi_bdev;
+	struct md_io_clone *md_io_clone;
+	struct bio *clone =
+		bio_alloc_clone(bdev, *bio, GFP_NOIO, &mddev->io_clone_set);
+
+	md_io_clone = container_of(clone, struct md_io_clone, bio_clone);
+	md_io_clone->orig_bio = *bio;
+	md_io_clone->mddev = mddev;
+	if (blk_queue_io_stat(bdev->bd_disk->queue))
+		md_io_clone->start_time = bio_start_io_acct(*bio);
+
+	clone->bi_end_io = md_end_clone_io;
+	clone->bi_private = md_io_clone;
+	*bio = clone;
+}
+
 /*
  * Used by personalities that don't already clone the bio and thus can't
  * easily add the timestamp to their extended bio structure.
  */
 void md_account_bio(struct mddev *mddev, struct bio **bio)
 {
-	struct block_device *bdev = (*bio)->bi_bdev;
-	struct md_io_acct *md_io_acct;
-	struct bio *clone;
-
-	if (!blk_queue_io_stat(bdev->bd_disk->queue))
-		return;
-
 	percpu_ref_get(&mddev->active_io);
-
-	clone = bio_alloc_clone(bdev, *bio, GFP_NOIO, &mddev->io_acct_set);
-	md_io_acct = container_of(clone, struct md_io_acct, bio_clone);
-	md_io_acct->orig_bio = *bio;
-	md_io_acct->start_time = bio_start_io_acct(*bio);
-	md_io_acct->mddev = mddev;
-
-	clone->bi_end_io = md_end_io_acct;
-	clone->bi_private = md_io_acct;
-	*bio = clone;
+	md_clone_bio(mddev, bio);
 }
 EXPORT_SYMBOL_GPL(md_account_bio);
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 11299d94b239..892a598a5029 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -510,7 +510,7 @@ struct mddev {
 	struct bio_set			sync_set; /* for sync operations like
 						   * metadata and bitmap writes
 						   */
-	struct bio_set			io_acct_set; /* for raid0 and raid5 io accounting */
+	struct bio_set			io_clone_set;
 
 	/* Generic flush handling.
 	 * The last to finish preflush schedules a worker to submit
@@ -738,7 +738,7 @@ struct md_thread {
 	void			*private;
 };
 
-struct md_io_acct {
+struct md_io_clone {
 	struct mddev	*mddev;
 	struct bio	*orig_bio;
 	unsigned long	start_time;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 29cf5455d7a5..cef0b400b2ee 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5468,13 +5468,13 @@ static struct bio *remove_bio_from_retry(struct r5conf *conf,
  */
 static void raid5_align_endio(struct bio *bi)
 {
-	struct md_io_acct *md_io_acct = bi->bi_private;
-	struct bio *raid_bi = md_io_acct->orig_bio;
+	struct md_io_clone *md_io_clone = bi->bi_private;
+	struct bio *raid_bi = md_io_clone->orig_bio;
 	struct mddev *mddev;
 	struct r5conf *conf;
 	struct md_rdev *rdev;
 	blk_status_t error = bi->bi_status;
-	unsigned long start_time = md_io_acct->start_time;
+	unsigned long start_time = md_io_clone->start_time;
 
 	bio_put(bi);
 
@@ -5506,7 +5506,7 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 	struct md_rdev *rdev;
 	sector_t sector, end_sector, first_bad;
 	int bad_sectors, dd_idx;
-	struct md_io_acct *md_io_acct;
+	struct md_io_clone *md_io_clone;
 	bool did_inc;
 
 	if (!in_chunk_boundary(mddev, raid_bio)) {
@@ -5544,15 +5544,15 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 	}
 
 	align_bio = bio_alloc_clone(rdev->bdev, raid_bio, GFP_NOIO,
-				    &mddev->io_acct_set);
-	md_io_acct = container_of(align_bio, struct md_io_acct, bio_clone);
+				    &mddev->io_clone_set);
+	md_io_clone = container_of(align_bio, struct md_io_clone, bio_clone);
 	raid_bio->bi_next = (void *)rdev;
 	if (blk_queue_io_stat(raid_bio->bi_bdev->bd_disk->queue))
-		md_io_acct->start_time = bio_start_io_acct(raid_bio);
-	md_io_acct->orig_bio = raid_bio;
+		md_io_clone->start_time = bio_start_io_acct(raid_bio);
+	md_io_clone->orig_bio = raid_bio;
 
 	align_bio->bi_end_io = raid5_align_endio;
-	align_bio->bi_private = md_io_acct;
+	align_bio->bi_private = md_io_clone;
 	align_bio->bi_iter.bi_sector = sector;
 
 	/* No reshape active, so we can trust rdev->data_offset */
-- 
2.39.2

