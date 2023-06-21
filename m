Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23B737EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjFUIxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjFUIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:52:46 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64892E60;
        Wed, 21 Jun 2023 01:52:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QmHMF091gz4f43lb;
        Wed, 21 Jun 2023 16:52:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBWupJkbVnFMA--.53622S7;
        Wed, 21 Jun 2023 16:52:41 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 3/8] raid5: fix missing io accounting in raid5_align_endio()
Date:   Thu, 22 Jun 2023 00:51:05 +0800
Message-Id: <20230621165110.1498313-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
References: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBWupJkbVnFMA--.53622S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWry7XF4kAFykGF1kCFWDXFb_yoW5Wr1kpa
        nagF9xXrW5XrW5WFZrK3yDW3WSqwsrKrZ7tFWxX34fta4ayFyvka18Xa4rJry5CFW8ury7
        Zw1qkw4UGr4xKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRNzVbUUUU
        U
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

Io will only be accounted as done from raid5_align_endio() if the io
succeeded, and io inflight counter will be leaked if such io failed.

Fix this problem by switching to use md_account_bio() for io accounting.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid5.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index cef0b400b2ee..4cdb35e54251 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5468,26 +5468,17 @@ static struct bio *remove_bio_from_retry(struct r5conf *conf,
  */
 static void raid5_align_endio(struct bio *bi)
 {
-	struct md_io_clone *md_io_clone = bi->bi_private;
-	struct bio *raid_bi = md_io_clone->orig_bio;
-	struct mddev *mddev;
-	struct r5conf *conf;
-	struct md_rdev *rdev;
+	struct bio *raid_bi = bi->bi_private;
+	struct md_rdev *rdev = (void *)raid_bi->bi_next;
+	struct mddev *mddev = rdev->mddev;
+	struct r5conf *conf = mddev->private;
 	blk_status_t error = bi->bi_status;
-	unsigned long start_time = md_io_clone->start_time;
 
 	bio_put(bi);
-
-	rdev = (void*)raid_bi->bi_next;
 	raid_bi->bi_next = NULL;
-	mddev = rdev->mddev;
-	conf = mddev->private;
-
 	rdev_dec_pending(rdev, conf->mddev);
 
 	if (!error) {
-		if (blk_queue_io_stat(raid_bi->bi_bdev->bd_disk->queue))
-			bio_end_io_acct(raid_bi, start_time);
 		bio_endio(raid_bi);
 		if (atomic_dec_and_test(&conf->active_aligned_reads))
 			wake_up(&conf->wait_for_quiescent);
@@ -5506,7 +5497,6 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 	struct md_rdev *rdev;
 	sector_t sector, end_sector, first_bad;
 	int bad_sectors, dd_idx;
-	struct md_io_clone *md_io_clone;
 	bool did_inc;
 
 	if (!in_chunk_boundary(mddev, raid_bio)) {
@@ -5543,16 +5533,13 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 		return 0;
 	}
 
-	align_bio = bio_alloc_clone(rdev->bdev, raid_bio, GFP_NOIO,
-				    &mddev->io_clone_set);
-	md_io_clone = container_of(align_bio, struct md_io_clone, bio_clone);
+	md_account_bio(mddev, &raid_bio);
 	raid_bio->bi_next = (void *)rdev;
-	if (blk_queue_io_stat(raid_bio->bi_bdev->bd_disk->queue))
-		md_io_clone->start_time = bio_start_io_acct(raid_bio);
-	md_io_clone->orig_bio = raid_bio;
 
+	align_bio = bio_alloc_clone(rdev->bdev, raid_bio, GFP_NOIO,
+				    &mddev->bio_set);
 	align_bio->bi_end_io = raid5_align_endio;
-	align_bio->bi_private = md_io_clone;
+	align_bio->bi_private = raid_bio;
 	align_bio->bi_iter.bi_sector = sector;
 
 	/* No reshape active, so we can trust rdev->data_offset */
-- 
2.39.2

