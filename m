Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80520734567
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjFRIJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFRIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:09:05 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D062810FE;
        Sun, 18 Jun 2023 01:09:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QkQXD1BgJz4f4MX7;
        Sun, 18 Jun 2023 16:09:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZSXu45kz8rjLw--.30784S11;
        Sun, 18 Jun 2023 16:09:01 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC 7/7] blk-mq: allow shared queue to get more driver tags
Date:   Mon, 19 Jun 2023 00:07:38 +0800
Message-Id: <20230618160738.54385-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230618160738.54385-1-yukuai1@huaweicloud.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZSXu45kz8rjLw--.30784S11
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4xWrWDGFWUGrykuFW8Crg_yoW5KFWfpF
        W7Ka45K3yrAF17ZFZxK39FkF1rKwsak3W5JFySq34rJwsrtr4rZ3W8tr15Zr18A395CF4j
        9ryqgrWrCF12y3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

If the queue fail to get driver tags frequently, and other queue
doesn't, try to borrow some shared tags from other queue.

Currently, borrowed tags will not be given back untill this queue is
idle.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c     | 52 ++++++++++++++++++++++++++++++++++++++----
 include/linux/blkdev.h |  1 +
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 5e5742c7277a..aafcc131e3e6 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -45,7 +45,44 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
 			users);
 }
 
-static void update_tag_sharing_busy(struct tag_sharing *tag_sharing)
+static void try_to_increase_available_tags(struct blk_mq_tags *tags,
+					   struct tag_sharing *tag_sharing)
+{
+	unsigned int users = tags->ctl.share_queues;
+	unsigned int free_tags = 0;
+	unsigned int borrowed_tags = 0;
+	unsigned int nr_tags;
+	struct tag_sharing *tmp;
+
+	if (users <= 1)
+		return;
+
+	nr_tags = max((tags->nr_tags + tags->ctl.share_queues - 1) /
+		       tags->ctl.share_queues, 4U);
+
+	list_for_each_entry(tmp, &tags->ctl.head, node) {
+		if (tmp == tag_sharing)
+			continue;
+
+		if (tmp->available_tags > nr_tags)
+			borrowed_tags += tmp->available_tags - nr_tags;
+		else if (atomic_read(&tmp->fail_count) <= nr_tags / 2)
+			free_tags += tmp->available_tags -
+				atomic_read(&tmp->active_tags);
+	}
+
+	/* can't borrow more tags */
+	if (free_tags <= borrowed_tags) {
+		WRITE_ONCE(tag_sharing->suspend, jiffies + HZ);
+		return;
+	}
+
+	/* try to borrow half of free tags */
+	tag_sharing->available_tags += (free_tags - borrowed_tags) / 2;
+}
+
+static void update_tag_sharing_busy(struct blk_mq_tags *tags,
+				    struct tag_sharing *tag_sharing)
 {
 	unsigned int count = atomic_inc_return(&tag_sharing->fail_count);
 	unsigned long last_period = READ_ONCE(tag_sharing->period);
@@ -53,7 +90,14 @@ static void update_tag_sharing_busy(struct tag_sharing *tag_sharing)
 	if (time_after(jiffies, last_period + HZ) &&
 	    cmpxchg_relaxed(&tag_sharing->period, last_period, jiffies) ==
 			    last_period)
-		atomic_sub(count / 2, &tag_sharing->fail_count);
+		count = atomic_sub_return(count / 2, &tag_sharing->fail_count);
+
+	if (count >= tags->nr_tags &&
+	    time_after(jiffies, READ_ONCE(tag_sharing->suspend))) {
+		spin_lock_irq(&tags->lock);
+		try_to_increase_available_tags(tags, tag_sharing);
+		spin_unlock_irq(&tags->lock);
+	}
 }
 
 void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
@@ -69,13 +113,13 @@ void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
 
 		if (test_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags) ||
 		    test_and_set_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags)) {
-			update_tag_sharing_busy(&q->tag_sharing);
+			update_tag_sharing_busy(tags, &q->tag_sharing);
 			return;
 		}
 	} else {
 		if (test_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state) ||
 		    test_and_set_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state)) {
-			update_tag_sharing_busy(&hctx->tag_sharing);
+			update_tag_sharing_busy(tags, &hctx->tag_sharing);
 			return;
 		}
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0d25e7d2a94c..3528bdc96a17 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -381,6 +381,7 @@ struct tag_sharing {
 	atomic_t		active_tags;
 	atomic_t		fail_count;
 	unsigned long		period;
+	unsigned long		suspend;
 };
 
 struct request_queue {
-- 
2.39.2

