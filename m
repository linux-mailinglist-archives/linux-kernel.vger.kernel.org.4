Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCFE734568
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjFRIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFRIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:09:05 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9A610FB;
        Sun, 18 Jun 2023 01:09:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QkQXC0RnYz4f4MXN;
        Sun, 18 Jun 2023 16:08:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZSXu45kz8rjLw--.30784S8;
        Sun, 18 Jun 2023 16:08:59 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC 4/7] blk-mq: precalculate available tags for hctx_may_queue()
Date:   Mon, 19 Jun 2023 00:07:35 +0800
Message-Id: <20230618160738.54385-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230618160738.54385-1-yukuai1@huaweicloud.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZSXu45kz8rjLw--.30784S8
X-Coremail-Antispam: 1UD129KBjvJXoWxurWkKF1fCF18WF1ktw15twb_yoWrKr4DpF
        WUGa17K3yIqrnrZFWqq39ruF1Igrs2kr1fJ3Zag34Fyr1jkrZ7Xr18JrW0vF40yrWkAF4q
        kr4DtrZ0yF4UJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiVbyDUU
        UUU==
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

Currently, hctx_mq_queue() only need to get how many queues is sharing
tags, then calculate how many tags is available for each queue by fair
sharing. In order to refactor how tag is shared, the calculation will be
more complicated, however, hctx_may_queue() is fast path, hence
precalculate available tags and prepare to refactor tag sharing.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c     | 19 +++++++++++++++++++
 block/blk-mq.c         |  3 +++
 block/blk-mq.h         | 14 +++++---------
 include/linux/blkdev.h |  3 ++-
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 8c527e68d4e4..e0137206c02b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -14,6 +14,22 @@
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
 
+static void blk_mq_update_available_driver_tags(struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_tags *tags = hctx->tags;
+	unsigned int nr_tags;
+	struct tag_sharing *tag_sharing;
+
+	if (tags->ctl.share_queues <= 1)
+		nr_tags = tags->nr_tags;
+	else
+		nr_tags = max((tags->nr_tags + tags->ctl.share_queues - 1) /
+			       tags->ctl.share_queues, 4U);
+
+	list_for_each_entry(tag_sharing, &tags->ctl.head, node)
+		tag_sharing->available_tags = nr_tags;
+}
+
 /*
  * Recalculate wakeup batch when tag is shared by hctx.
  */
@@ -51,6 +67,7 @@ void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
 
 	spin_lock_irq(&tags->lock);
 	WRITE_ONCE(tags->ctl.share_queues, tags->ctl.active_queues);
+	blk_mq_update_available_driver_tags(hctx);
 	blk_mq_update_wake_batch(tags, tags->ctl.share_queues);
 	spin_unlock_irq(&tags->lock);
 }
@@ -136,9 +153,11 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 
 	spin_lock_irq(&tags->lock);
 	list_del_init(&tag_sharing->node);
+	tag_sharing->available_tags = tags->nr_tags;
 	__blk_mq_driver_tag_idle(hctx);
 	WRITE_ONCE(tags->ctl.active_queues, tags->ctl.active_queues - 1);
 	WRITE_ONCE(tags->ctl.share_queues, tags->ctl.active_queues);
+	blk_mq_update_available_driver_tags(hctx);
 	blk_mq_update_wake_batch(tags, tags->ctl.share_queues);
 	spin_unlock_irq(&tags->lock);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 171ee4ac97ef..771802ff1d45 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3621,6 +3621,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
 
 	hctx->tags = set->tags[hctx_idx];
+	hctx->tag_sharing.available_tags = hctx->tags->nr_tags;
 
 	if (set->ops->init_hctx &&
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
@@ -3881,6 +3882,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		}
 
 		hctx->tags = set->tags[i];
+		hctx->tag_sharing.available_tags = hctx->tags->nr_tags;
 		WARN_ON(!hctx->tags);
 
 		/*
@@ -4234,6 +4236,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	spin_lock_init(&q->requeue_lock);
 
 	q->nr_requests = set->queue_depth;
+	q->tag_sharing.available_tags = set->queue_depth;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_add_queue_tag_set(set, q);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 01441a5e9910..fcfb040efbbd 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -398,7 +398,7 @@ static inline void blk_mq_free_requests(struct list_head *list)
 static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 				  struct sbitmap_queue *bt)
 {
-	unsigned int depth, users;
+	unsigned int depth;
 
 	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
 		return true;
@@ -414,19 +414,15 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 
 		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
 			return true;
+
+		depth = READ_ONCE(q->tag_sharing.available_tags);
 	} else {
 		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return true;
-	}
 
-	users = READ_ONCE(hctx->tags->ctl.share_queues);
-	if (!users)
-		return true;
+		depth = READ_ONCE(hctx->tag_sharing.available_tags);
+	}
 
-	/*
-	 * Allow at least some tags
-	 */
-	depth = max((bt->sb.depth + users - 1) / users, 4U);
 	return __blk_mq_active_requests(hctx) < depth;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 62f8fcc20c30..e5111bedfd8d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -376,7 +376,8 @@ struct blk_independent_access_ranges {
 };
 
 struct tag_sharing {
-	struct list_head node;
+	struct list_head	node;
+	unsigned int		available_tags;
 };
 
 struct request_queue {
-- 
2.39.2

