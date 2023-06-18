Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1363734569
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjFRIJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFRIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:09:05 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5496B10F7;
        Sun, 18 Jun 2023 01:09:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QkQXB3GBpz4f3w0S;
        Sun, 18 Jun 2023 16:08:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZSXu45kz8rjLw--.30784S6;
        Sun, 18 Jun 2023 16:08:59 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC 2/7] blk-mq: delay tag fair sharing until fail to get driver tag
Date:   Mon, 19 Jun 2023 00:07:33 +0800
Message-Id: <20230618160738.54385-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230618160738.54385-1-yukuai1@huaweicloud.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZSXu45kz8rjLw--.30784S6
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1DAr13uFyDGry8Gw4UArb_yoWfAF1rpF
        W7Ga12kw1FqrsrZFWjqw47ZF1Sgrs7Kr13Ganag34FvF1j9r4fur1vkry0vrW8trWkAr47
        Zr45trWjyF4DWrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
        AqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
        43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTR
        QNVDUUUUU
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

Start tag fair sharing when a device start to issue io will waste
resources, same number of tags will be assigned to each disk/hctx,
and such tags can't be used for other disk/hctx, which means a disk/hctx
can't use more than assinged tags even if there are still lots of tags
that is assinged to other disks are unused.

Add a new api blk_mq_driver_tag_busy(), it will be called when get
driver tag failed, and move tag sharing from blk_mq_tag_busy() to
blk_mq_driver_tag_busy().

This approch will work well if total tags are not exhausted, and follow
up patches will try to refactor how tag is shared to handle this case.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c |  4 ++-
 block/blk-mq-tag.c     | 60 ++++++++++++++++++++++++++++++++++--------
 block/blk-mq.c         |  4 ++-
 block/blk-mq.h         | 13 ++++++---
 include/linux/blk-mq.h |  6 +++--
 include/linux/blkdev.h |  1 +
 6 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 431aaa3eb181..de5a911b07c2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -400,8 +400,10 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 {
 	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
 	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
-	seq_printf(m, "active_queues=%d\n",
+	seq_printf(m, "active_queues=%u\n",
 		   READ_ONCE(tags->ctl.active_queues));
+	seq_printf(m, "share_queues=%u\n",
+		   READ_ONCE(tags->ctl.share_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
 	sbitmap_queue_show(&tags->bitmap_tags, m);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index fe41a0d34fc0..1c2bde917195 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -29,6 +29,32 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
 			users);
 }
 
+void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_tags *tags = hctx->tags;
+
+	/*
+	 * calling test_bit() prior to test_and_set_bit() is intentional,
+	 * it avoids dirtying the cacheline if the queue is already active.
+	 */
+	if (blk_mq_is_shared_tags(hctx->flags)) {
+		struct request_queue *q = hctx->queue;
+
+		if (test_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags) ||
+		    test_and_set_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags))
+			return;
+	} else {
+		if (test_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state) ||
+		    test_and_set_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state))
+			return;
+	}
+
+	spin_lock_irq(&tags->lock);
+	WRITE_ONCE(tags->ctl.share_queues, tags->ctl.active_queues);
+	blk_mq_update_wake_batch(tags, tags->ctl.share_queues);
+	spin_unlock_irq(&tags->lock);
+}
+
 /*
  * If a previously inactive queue goes active, bump the active user count.
  * We need to do this before try to allocate driver tag, then even if fail
@@ -37,7 +63,6 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
  */
 void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
-	unsigned int users;
 	struct blk_mq_tags *tags = hctx->tags;
 
 	/*
@@ -57,9 +82,7 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 	}
 
 	spin_lock_irq(&tags->lock);
-	users = tags->ctl.active_queues + 1;
-	WRITE_ONCE(tags->ctl.active_queues, users);
-	blk_mq_update_wake_batch(tags, users);
+	WRITE_ONCE(tags->ctl.active_queues, tags->ctl.active_queues + 1);
 	spin_unlock_irq(&tags->lock);
 }
 
@@ -73,6 +96,14 @@ void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool include_reserve)
 		sbitmap_queue_wake_all(&tags->breserved_tags);
 }
 
+static void __blk_mq_driver_tag_idle(struct blk_mq_hw_ctx *hctx)
+{
+	if (blk_mq_is_shared_tags(hctx->flags))
+		clear_bit(QUEUE_FLAG_HCTX_BUSY, &hctx->queue->queue_flags);
+	else
+		clear_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state);
+}
+
 /*
  * If a previously busy queue goes inactive, potential waiters could now
  * be allowed to queue. Wake them up and check.
@@ -80,7 +111,6 @@ void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool include_reserve)
 void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_tags *tags = hctx->tags;
-	unsigned int users;
 
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
@@ -94,9 +124,10 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	}
 
 	spin_lock_irq(&tags->lock);
-	users = tags->ctl.active_queues - 1;
-	WRITE_ONCE(tags->ctl.active_queues, users);
-	blk_mq_update_wake_batch(tags, users);
+	__blk_mq_driver_tag_idle(hctx);
+	WRITE_ONCE(tags->ctl.active_queues, tags->ctl.active_queues - 1);
+	WRITE_ONCE(tags->ctl.share_queues, tags->ctl.active_queues);
+	blk_mq_update_wake_batch(tags, tags->ctl.share_queues);
 	spin_unlock_irq(&tags->lock);
 
 	blk_mq_tag_wakeup_all(tags, false);
@@ -105,14 +136,21 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
+	int ret = BLK_MQ_NO_TAG;
+
 	if (!data->q->elevator && !(data->flags & BLK_MQ_REQ_RESERVED) &&
 			!hctx_may_queue(data->hctx, bt))
-		return BLK_MQ_NO_TAG;
+		goto out;
 
+	/* shallow_depth is only used for elevator */
 	if (data->shallow_depth)
 		return sbitmap_queue_get_shallow(bt, data->shallow_depth);
-	else
-		return __sbitmap_queue_get(bt);
+
+	ret = __sbitmap_queue_get(bt);
+out:
+	if (ret == BLK_MQ_NO_TAG && !(data->rq_flags & RQF_SCHED_TAGS))
+		blk_mq_driver_tag_busy(data->hctx);
+	return ret;
 }
 
 unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index da650a2c4ca1..171ee4ac97ef 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1753,8 +1753,10 @@ static bool __blk_mq_alloc_driver_tag(struct request *rq)
 
 bool __blk_mq_get_driver_tag(struct blk_mq_hw_ctx *hctx, struct request *rq)
 {
-	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_alloc_driver_tag(rq))
+	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_alloc_driver_tag(rq)) {
+		blk_mq_driver_tag_busy(hctx);
 		return false;
+	}
 
 	if ((hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) &&
 			!(rq->rq_flags & RQF_MQ_INFLIGHT)) {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index ca1c13127868..01441a5e9910 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -193,8 +193,9 @@ static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 	return sbq_wait_ptr(bt, &hctx->wait_index);
 }
 
-void __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
-void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
+void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx);
+void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx);
+void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx);
 
 static inline void blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
@@ -208,6 +209,12 @@ static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 		__blk_mq_tag_idle(hctx);
 }
 
+static inline void blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_driver_tag_busy(hctx);
+}
+
 static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
 					  unsigned int tag)
 {
@@ -412,7 +419,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 			return true;
 	}
 
-	users = READ_ONCE(hctx->tags->ctl.active_queues);
+	users = READ_ONCE(hctx->tags->ctl.share_queues);
 	if (!users)
 		return true;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8d2cd6b9d305..bc3ac22edb07 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -675,10 +675,11 @@ enum {
 
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
-	BLK_MQ_S_SCHED_RESTART	= 2,
+	BLK_MQ_S_DTAG_BUSY	= 2,
+	BLK_MQ_S_SCHED_RESTART	= 3,
 
 	/* hw queue is inactive after all its CPUs become offline */
-	BLK_MQ_S_INACTIVE	= 3,
+	BLK_MQ_S_INACTIVE	= 4,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
 
@@ -735,6 +736,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 
 struct tag_sharing_ctl {
 	unsigned int active_queues;
+	unsigned int share_queues;
 };
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed44a997f629..0994707f6a68 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -546,6 +546,7 @@ struct request_queue {
 #define QUEUE_FLAG_DAX		19	/* device supports DAX */
 #define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
 #define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
+#define QUEUE_FLAG_HCTX_BUSY	23	/* at least one blk-mq hctx failed to get driver tag */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
-- 
2.39.2

