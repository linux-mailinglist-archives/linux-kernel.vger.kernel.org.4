Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAD1714A09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjE2NPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjE2NPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:15:07 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CFE106;
        Mon, 29 May 2023 06:14:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QVGGF2nz1z4f44Cn;
        Mon, 29 May 2023 21:14:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNDpXRknNjnKQ--.28139S7;
        Mon, 29 May 2023 21:14:46 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, neilb@suse.de, akpm@osdl.org
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v3 3/7] md/raid1-10: factor out a helper to submit normal write
Date:   Mon, 29 May 2023 21:11:02 +0800
Message-Id: <20230529131106.2123367-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLNDpXRknNjnKQ--.28139S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1rXFW5ZFyfXFyUWr48JFb_yoW5tr1xp3
        9Iqa4fZ3y7JF47Wan8Cay8Ja4Fga1DtrWUuFW7CayfAFW3ZFyDta1kJry0gryDAFyrCry7
        ZF18K39rWa13JFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWx
        JVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/md/raid1-10.c | 17 +++++++++++++++++
 drivers/md/raid1.c    | 13 ++-----------
 drivers/md/raid10.c   | 26 ++++----------------------
 3 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 9bf19a3409ce..506299bd55cb 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -110,6 +110,23 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
 	} while (idx++ < RESYNC_PAGES && size > 0);
 }
 
+
+static inline void raid1_submit_write(struct bio *bio)
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
 static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
 				      blk_plug_cb_fn unplug)
 {
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index e86c5e71c604..0778e398584c 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -799,17 +799,8 @@ static void flush_bio_list(struct r1conf *conf, struct bio *bio)
 
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
+		raid1_submit_write(bio);
 		bio = next;
 		cond_resched();
 	}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 18702051ebd1..6640507ecb0d 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -909,17 +909,8 @@ static void flush_pending_writes(struct r10conf *conf)
 
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
+			raid1_submit_write(bio);
 			bio = next;
 			cond_resched();
 		}
@@ -1134,17 +1125,8 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
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
+		raid1_submit_write(bio);
 		bio = next;
 		cond_resched();
 	}
-- 
2.39.2

