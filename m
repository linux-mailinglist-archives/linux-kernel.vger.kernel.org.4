Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3316E92CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjDTLcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjDTLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:31:44 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3B51FFB;
        Thu, 20 Apr 2023 04:31:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q2Fpp3d77z4f3nV8;
        Thu, 20 Apr 2023 19:31:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7OAIkFkVY8hHw--.17021S8;
        Thu, 20 Apr 2023 19:31:15 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, neilb@suse.de, akpm@osdl.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 4/8] md/raid1-10: factor out a helper to submit normal write
Date:   Thu, 20 Apr 2023 19:29:42 +0800
Message-Id: <20230420112946.2869956-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
References: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7OAIkFkVY8hHw--.17021S8
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1rXFW5ZF1xGrW5urW3Jrb_yoW5tFWxp3
        9Iqas3Z3y7XFW7Wa1DZay8J3WSg3WDtrWUCFW3CayfAFy3ZryDta18JryIgryDAFyrCry7
        ZF18K3y7Ww47JFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are multiple places to do the same thing, factor out a helper to
prevent redundant code, and the helper will be used in following patch
as well.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1-10.h | 17 +++++++++++++++++
 drivers/md/raid1.c    | 13 ++-----------
 drivers/md/raid10.c   | 26 ++++----------------------
 3 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/md/raid1-10.h b/drivers/md/raid1-10.h
index 664646a3591a..9dc53d8a8129 100644
--- a/drivers/md/raid1-10.h
+++ b/drivers/md/raid1-10.h
@@ -113,6 +113,22 @@ static inline void md_bio_reset_resync_pages(struct bio *bio,
 	} while (idx++ < RESYNC_PAGES && size > 0);
 }
 
+static inline void md_submit_write(struct bio *bio)
+{
+	struct md_rdev *rdev = (struct md_rdev *)bio->bi_bdev;
+
+	bio->bi_next = NULL;
+	bio_set_dev(bio, rdev->bdev);
+	if (test_bit(Faulty, &rdev->flags))
+		bio_io_error(bio);
+	else if (unlikely(bio_op(bio) ==  REQ_OP_DISCARD &&
+			  !bdev_max_discard_sectors(bio->bi_bdev)))
+		/* Just ignore it */
+		bio_endio(bio);
+	else
+		submit_bio_noacct(bio);
+}
+
 static inline bool md_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
 				      blk_plug_cb_fn unplug)
 {
@@ -128,4 +144,5 @@ static inline bool md_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
 
 	return true;
 }
+
 #endif
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 44c8d113621f..c068ed3e6c96 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -797,17 +797,8 @@ static void flush_bio_list(struct r1conf *conf, struct bio *bio)
 
 	while (bio) { /* submit pending writes */
 		struct bio *next = bio->bi_next;
-		struct md_rdev *rdev = (void *)bio->bi_bdev;
-		bio->bi_next = NULL;
-		bio_set_dev(bio, rdev->bdev);
-		if (test_bit(Faulty, &rdev->flags)) {
-			bio_io_error(bio);
-		} else if (unlikely((bio_op(bio) == REQ_OP_DISCARD) &&
-				    !bdev_max_discard_sectors(bio->bi_bdev)))
-			/* Just ignore it */
-			bio_endio(bio);
-		else
-			submit_bio_noacct(bio);
+
+		md_submit_write(bio);
 		bio = next;
 		cond_resched();
 	}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index d67c5672933c..fd625026c97b 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -907,17 +907,8 @@ static void flush_pending_writes(struct r10conf *conf)
 
 		while (bio) { /* submit pending writes */
 			struct bio *next = bio->bi_next;
-			struct md_rdev *rdev = (void*)bio->bi_bdev;
-			bio->bi_next = NULL;
-			bio_set_dev(bio, rdev->bdev);
-			if (test_bit(Faulty, &rdev->flags)) {
-				bio_io_error(bio);
-			} else if (unlikely((bio_op(bio) ==  REQ_OP_DISCARD) &&
-					    !bdev_max_discard_sectors(bio->bi_bdev)))
-				/* Just ignore it */
-				bio_endio(bio);
-			else
-				submit_bio_noacct(bio);
+
+			md_submit_write(bio);
 			bio = next;
 			cond_resched();
 		}
@@ -1127,17 +1118,8 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
 	while (bio) { /* submit pending writes */
 		struct bio *next = bio->bi_next;
-		struct md_rdev *rdev = (void*)bio->bi_bdev;
-		bio->bi_next = NULL;
-		bio_set_dev(bio, rdev->bdev);
-		if (test_bit(Faulty, &rdev->flags)) {
-			bio_io_error(bio);
-		} else if (unlikely((bio_op(bio) ==  REQ_OP_DISCARD) &&
-				    !bdev_max_discard_sectors(bio->bi_bdev)))
-			/* Just ignore it */
-			bio_endio(bio);
-		else
-			submit_bio_noacct(bio);
+
+		md_submit_write(bio);
 		bio = next;
 		cond_resched();
 	}
-- 
2.39.2

