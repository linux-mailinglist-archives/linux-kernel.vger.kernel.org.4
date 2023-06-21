Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A67737E30
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjFUIxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjFUIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:52:48 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3BC1981;
        Wed, 21 Jun 2023 01:52:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QmHMD1Yqlz4f3yrt;
        Wed, 21 Jun 2023 16:52:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBWupJkbVnFMA--.53622S8;
        Wed, 21 Jun 2023 16:52:42 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 4/8] md/raid1: switch to use md_account_bio() for io accounting
Date:   Thu, 22 Jun 2023 00:51:06 +0800
Message-Id: <20230621165110.1498313-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
References: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBWupJkbVnFMA--.53622S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tw17ur4rZrW8Wr1UtrWrXwb_yoW8uw48pa
        1UWFyru3yrX3yq9w1DJFWUuF1fCan0ga42krWxX3sxZF1avF90qa18XFWfKr1DJF95WFy2
        y3WvkF4DCF47tFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
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

Two problems can be fixed this way:

1) 'active_io' will represent inflight io instead of io that is
dispatching.

2) If io accounting is enabled or disabled while io is still inflight,
bio_start_io_acct() and bio_end_io_acct() is not balanced and io
inflight counter will be leaked.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid1.c | 14 ++++++--------
 drivers/md/raid1.h |  1 -
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index dd25832eb045..06fa1580501f 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -304,8 +304,6 @@ static void call_bio_endio(struct r1bio *r1_bio)
 	if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
 		bio->bi_status = BLK_STS_IOERR;
 
-	if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
-		bio_end_io_acct(bio, r1_bio->start_time);
 	bio_endio(bio);
 }
 
@@ -1303,10 +1301,10 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	}
 
 	r1_bio->read_disk = rdisk;
-
-	if (!r1bio_existed && blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
-		r1_bio->start_time = bio_start_io_acct(bio);
-
+	if (!r1bio_existed) {
+		md_account_bio(mddev, &bio);
+		r1_bio->master_bio = bio;
+	}
 	read_bio = bio_alloc_clone(mirror->rdev->bdev, bio, gfp,
 				   &mddev->bio_set);
 
@@ -1500,8 +1498,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		r1_bio->sectors = max_sectors;
 	}
 
-	if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
-		r1_bio->start_time = bio_start_io_acct(bio);
+	md_account_bio(mddev, &bio);
+	r1_bio->master_bio = bio;
 	atomic_set(&r1_bio->remaining, 1);
 	atomic_set(&r1_bio->behind_remaining, 0);
 
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index 468f189da7a0..14d4211a123a 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -157,7 +157,6 @@ struct r1bio {
 	sector_t		sector;
 	int			sectors;
 	unsigned long		state;
-	unsigned long		start_time;
 	struct mddev		*mddev;
 	/*
 	 * original bio going to /dev/mdx
-- 
2.39.2

