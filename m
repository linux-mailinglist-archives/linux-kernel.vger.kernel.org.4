Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA573456B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjFRIJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFRIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:09:06 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E1010D7;
        Sun, 18 Jun 2023 01:09:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QkQXC5dxmz4f4925;
        Sun, 18 Jun 2023 16:08:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZSXu45kz8rjLw--.30784S10;
        Sun, 18 Jun 2023 16:09:00 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC 6/7] blk-mq: move active request counter to struct tag_sharing
Date:   Mon, 19 Jun 2023 00:07:37 +0800
Message-Id: <20230618160738.54385-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230618160738.54385-1-yukuai1@huaweicloud.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZSXu45kz8rjLw--.30784S10
X-Coremail-Antispam: 1UD129KBjvJXoW3AryrGrW5KF47Xw17Wr4Durg_yoW7ZF1xpF
        W5Ka1jk3yFqF1DZFWkt39rZw1SgwsYkr4xGrn3Kwn0v3Z2kws7X3W8JFy5ZF48ArZ5CrZr
        Cr4qgrW5CF17WrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
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

Now that there is a separate structure to control tag sharing, it make
sense to move such counter for tag sharing into this structure. There
are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c       |  2 --
 block/blk-mq.c         |  3 ++-
 block/blk-mq.h         | 22 +++++++++++-----------
 include/linux/blk-mq.h |  6 ------
 include/linux/blkdev.h |  3 +--
 5 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 99d8b9812b18..f2077ee32a99 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -413,8 +413,6 @@ struct request_queue *blk_alloc_queue(int node_id)
 
 	q->node = node_id;
 
-	atomic_set(&q->nr_active_requests_shared_tags, 0);
-
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
 	INIT_WORK(&q->timeout_work, blk_timeout_work);
 	INIT_LIST_HEAD(&q->icq_list);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 771802ff1d45..91020cd2f6bf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3661,7 +3661,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	if (!zalloc_cpumask_var_node(&hctx->cpumask, gfp, node))
 		goto free_hctx;
 
-	atomic_set(&hctx->nr_active, 0);
+	atomic_set(&hctx->tag_sharing.active_tags, 0);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 	hctx->numa_node = node;
@@ -4237,6 +4237,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	q->nr_requests = set->queue_depth;
 	q->tag_sharing.available_tags = set->queue_depth;
+	atomic_set(&q->tag_sharing.active_tags, 0);
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_add_queue_tag_set(set, q);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index fcfb040efbbd..c8923a8565b5 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -281,18 +281,18 @@ static inline int blk_mq_get_rq_budget_token(struct request *rq)
 static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
 {
 	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_inc(&hctx->queue->nr_active_requests_shared_tags);
+		atomic_inc(&hctx->queue->tag_sharing.active_tags);
 	else
-		atomic_inc(&hctx->nr_active);
+		atomic_inc(&hctx->tag_sharing.active_tags);
 }
 
 static inline void __blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx,
 		int val)
 {
 	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_sub(val, &hctx->queue->nr_active_requests_shared_tags);
+		atomic_sub(val, &hctx->queue->tag_sharing.active_tags);
 	else
-		atomic_sub(val, &hctx->nr_active);
+		atomic_sub(val, &hctx->tag_sharing.active_tags);
 }
 
 static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
@@ -303,8 +303,8 @@ static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
 static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
 {
 	if (blk_mq_is_shared_tags(hctx->flags))
-		return atomic_read(&hctx->queue->nr_active_requests_shared_tags);
-	return atomic_read(&hctx->nr_active);
+		return atomic_read(&hctx->queue->tag_sharing.active_tags);
+	return atomic_read(&hctx->tag_sharing.active_tags);
 }
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
@@ -398,7 +398,7 @@ static inline void blk_mq_free_requests(struct list_head *list)
 static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 				  struct sbitmap_queue *bt)
 {
-	unsigned int depth;
+	struct tag_sharing *tag_sharing;
 
 	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
 		return true;
@@ -415,15 +415,15 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
 			return true;
 
-		depth = READ_ONCE(q->tag_sharing.available_tags);
+		tag_sharing = &q->tag_sharing;
 	} else {
 		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return true;
-
-		depth = READ_ONCE(hctx->tag_sharing.available_tags);
+		tag_sharing = &hctx->tag_sharing;
 	}
 
-	return __blk_mq_active_requests(hctx) < depth;
+	return atomic_read(&tag_sharing->active_tags) <
+	       READ_ONCE(tag_sharing->available_tags);
 }
 
 /* run the code block in @dispatch_ops with rcu/srcu read lock held */
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 639d618e6ca8..fdfa63b76136 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -408,12 +408,6 @@ struct blk_mq_hw_ctx {
 	/** @queue_num: Index of this hardware queue. */
 	unsigned int		queue_num;
 
-	/**
-	 * @nr_active: Number of active requests. Only used when a tag set is
-	 * shared across request queues.
-	 */
-	atomic_t		nr_active;
-
 	/** @cpuhp_online: List to store request if CPU is going to die */
 	struct hlist_node	cpuhp_online;
 	/** @cpuhp_dead: List to store request if some CPU die. */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f3faaf5f6504..0d25e7d2a94c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -378,6 +378,7 @@ struct blk_independent_access_ranges {
 struct tag_sharing {
 	struct list_head	node;
 	unsigned int		available_tags;
+	atomic_t		active_tags;
 	atomic_t		fail_count;
 	unsigned long		period;
 };
@@ -462,8 +463,6 @@ struct request_queue {
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 
-	atomic_t		nr_active_requests_shared_tags;
-
 	struct blk_mq_tags	*sched_shared_tags;
 
 	struct list_head	icq_list;
-- 
2.39.2

