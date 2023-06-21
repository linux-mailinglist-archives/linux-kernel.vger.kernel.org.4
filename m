Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2449737E59
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjFUIxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjFUIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:52:48 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A718FE60;
        Wed, 21 Jun 2023 01:52:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QmHMD4gMLz4f3ys0;
        Wed, 21 Jun 2023 16:52:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBWupJkbVnFMA--.53622S9;
        Wed, 21 Jun 2023 16:52:42 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 5/8] md/raid10: switch to use md_account_bio() for io accounting
Date:   Thu, 22 Jun 2023 00:51:07 +0800
Message-Id: <20230621165110.1498313-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
References: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBWupJkbVnFMA--.53622S9
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1DCFW5ZFy5Gry8Wr4DArb_yoW5tr4fp3
        yDCa4rArW5J3yUuw1DJFWDuwnYyayvq3yayrWxJw13A3W3XF98KF18XFWFqrn8ZFZ5ur9r
        Z3Z09rsrCwsrtFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRiVb
        yDUUUUU==
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

Make sure that 'active_io' will represent inflight io instead of io that
is dispatching, and io accounting from all levels will be consistent.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid10.c | 20 +++++++++-----------
 drivers/md/raid10.h |  1 -
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 79067769e44b..69f6d7b1e600 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -325,8 +325,6 @@ static void raid_end_bio_io(struct r10bio *r10_bio)
 	if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
 		bio->bi_status = BLK_STS_IOERR;
 
-	if (r10_bio->start_time)
-		bio_end_io_acct(bio, r10_bio->start_time);
 	bio_endio(bio);
 	/*
 	 * Wake up any possible resync thread that waits for the device
@@ -1172,7 +1170,7 @@ static bool regular_request_wait(struct mddev *mddev, struct r10conf *conf,
 }
 
 static void raid10_read_request(struct mddev *mddev, struct bio *bio,
-				struct r10bio *r10_bio)
+				struct r10bio *r10_bio, bool io_accounting)
 {
 	struct r10conf *conf = mddev->private;
 	struct bio *read_bio;
@@ -1243,9 +1241,10 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	}
 	slot = r10_bio->read_slot;
 
-	if (!r10_bio->start_time &&
-	    blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
-		r10_bio->start_time = bio_start_io_acct(bio);
+	if (io_accounting) {
+		md_account_bio(mddev, &bio);
+		r10_bio->master_bio = bio;
+	}
 	read_bio = bio_alloc_clone(rdev->bdev, bio, gfp, &mddev->bio_set);
 
 	r10_bio->devs[slot].bio = read_bio;
@@ -1543,8 +1542,8 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		r10_bio->master_bio = bio;
 	}
 
-	if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
-		r10_bio->start_time = bio_start_io_acct(bio);
+	md_account_bio(mddev, &bio);
+	r10_bio->master_bio = bio;
 	atomic_set(&r10_bio->remaining, 1);
 	md_bitmap_startwrite(mddev->bitmap, r10_bio->sector, r10_bio->sectors, 0);
 
@@ -1571,12 +1570,11 @@ static void __make_request(struct mddev *mddev, struct bio *bio, int sectors)
 	r10_bio->sector = bio->bi_iter.bi_sector;
 	r10_bio->state = 0;
 	r10_bio->read_slot = -1;
-	r10_bio->start_time = 0;
 	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) *
 			conf->geo.raid_disks);
 
 	if (bio_data_dir(bio) == READ)
-		raid10_read_request(mddev, bio, r10_bio);
+		raid10_read_request(mddev, bio, r10_bio, true);
 	else
 		raid10_write_request(mddev, bio, r10_bio);
 }
@@ -2985,7 +2983,7 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 
 	rdev_dec_pending(rdev, mddev);
 	r10_bio->state = 0;
-	raid10_read_request(mddev, r10_bio->master_bio, r10_bio);
+	raid10_read_request(mddev, r10_bio->master_bio, r10_bio, false);
 	/*
 	 * allow_barrier after re-submit to ensure no sync io
 	 * can be issued while regular io pending.
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 63e48b11b552..2e75e88d0802 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -123,7 +123,6 @@ struct r10bio {
 	sector_t		sector;	/* virtual sector number */
 	int			sectors;
 	unsigned long		state;
-	unsigned long		start_time;
 	struct mddev		*mddev;
 	/*
 	 * original bio going to /dev/mdx
-- 
2.39.2

