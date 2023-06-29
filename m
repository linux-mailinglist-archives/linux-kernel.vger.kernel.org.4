Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A041A74257A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjF2MOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjF2MOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:14:01 -0400
Received: from out-21.mta1.migadu.com (out-21.mta1.migadu.com [IPv6:2001:41d0:203:375::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D716358D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:13:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688040836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xfO61CVQK88KgiArAYWZDOZyMihC48YiU9gHQY2Va0=;
        b=r1G3+cS2ZjO3+13QKYsSzJ/FdnDotCg6MG25x1PCO1qA3EsmJ25mFkfmwoZ8tyEbLrywd6
        kG8Y9sHdRBxod+sKC2TuYi79+yJpwlFsFtuQQFonuc+gpqC90ZcUOL117fy+Q4XJ1tLzGF
        lwkmah3iNxTbOm6uCR8pFLwgG+8OMTo=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 2/2] blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq
Date:   Thu, 29 Jun 2023 20:13:02 +0800
Message-Id: <20230629121302.1124851-3-chengming.zhou@linux.dev>
In-Reply-To: <20230629121302.1124851-1-chengming.zhou@linux.dev>
References: <20230629121302.1124851-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The iocost rely on rq start_time_ns and alloc_time_ns to tell saturation
state of the block device. Most of the time request is allocated after
rq_qos_throttle() and its alloc_time_ns or start_time_ns won't be affected.

But for plug batched allocation introduced by the commit 47c122e35d7e
("block: pre-allocate requests if plug is started and is a batch"), we can
rq_qos_throttle() after the allocation of the request. This is what the
blk_mq_get_cached_request() does.

In this case, the cached request alloc_time_ns or start_time_ns is much
ahead if blocked in any qos ->throttle().

This patch fix it by setting alloc_time_ns and start_time_ns to now
when the pre-allocated rq is actually used. And we skip setting the
alloc_time_ns and start_time_ns during pre-allocation, so just pass 0
in __blk_mq_alloc_requests_batch().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c         | 41 +++++++++++++++++++++++++++++++----------
 block/blk-mq.h         |  1 +
 include/linux/blk-mq.h |  6 +++---
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c50ef953759f..2849395ca4c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -337,6 +337,24 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 }
 EXPORT_SYMBOL(blk_rq_init);
 
+/* Set alloc and start time when pre-allocated rq is actually used */
+static inline void blk_mq_rq_time_init(struct request *rq)
+{
+	if (blk_mq_need_time_stamp(rq->rq_flags)) {
+		u64 now = ktime_get_ns();
+
+#ifdef CONFIG_BLK_RQ_ALLOC_TIME
+		/*
+		 * The alloc time is only used by iocost for now,
+		 * only possible when blk_mq_need_time_stamp().
+		 */
+		if (blk_queue_rq_alloc_time(rq->q))
+			rq->alloc_time_ns = now;
+#endif
+		rq->start_time_ns = now;
+	}
+}
+
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		struct blk_mq_tags *tags, unsigned int tag, u64 alloc_time_ns)
 {
@@ -360,14 +378,11 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	}
 	rq->timeout = 0;
 
-	if (blk_mq_need_time_stamp(rq))
-		rq->start_time_ns = ktime_get_ns();
-	else
-		rq->start_time_ns = 0;
 	rq->part = NULL;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
 	rq->alloc_time_ns = alloc_time_ns;
 #endif
+	rq->start_time_ns = data->start_time_ns;
 	rq->io_start_time_ns = 0;
 	rq->stats_sectors = 0;
 	rq->nr_phys_segments = 0;
@@ -397,8 +412,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 }
 
 static inline struct request *
-__blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
-		u64 alloc_time_ns)
+__blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 {
 	unsigned int tag, tag_offset;
 	struct blk_mq_tags *tags;
@@ -417,7 +431,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 		tag = tag_offset + i;
 		prefetch(tags->static_rqs[tag]);
 		tag_mask &= ~(1UL << i);
-		rq = blk_mq_rq_ctx_init(data, tags, tag, alloc_time_ns);
+		rq = blk_mq_rq_ctx_init(data, tags, tag, 0);
 		rq_list_add(data->cached_rq, rq);
 		nr++;
 	}
@@ -488,9 +502,11 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	 * Try batched alloc if we want more than 1 tag.
 	 */
 	if (data->nr_tags > 1) {
-		rq = __blk_mq_alloc_requests_batch(data, alloc_time_ns);
-		if (rq)
+		rq = __blk_mq_alloc_requests_batch(data);
+		if (rq) {
+			blk_mq_rq_time_init(rq);
 			return rq;
+		}
 		data->nr_tags = 1;
 	}
 
@@ -514,6 +530,9 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		goto retry;
 	}
 
+	if (blk_mq_need_time_stamp(data->rq_flags))
+		data->start_time_ns = ktime_get_ns();
+
 	return blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag,
 					alloc_time_ns);
 }
@@ -570,6 +589,7 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
 			return NULL;
 
 		plug->cached_rq = rq_list_next(rq);
+		blk_mq_rq_time_init(rq);
 	}
 
 	rq->cmd_flags = opf;
@@ -1004,7 +1024,7 @@ static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
 
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
-	if (blk_mq_need_time_stamp(rq))
+	if (blk_mq_need_time_stamp(rq->rq_flags))
 		__blk_mq_end_request_acct(rq, ktime_get_ns());
 
 	if (rq->end_io) {
@@ -2891,6 +2911,7 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	plug->cached_rq = rq_list_next(rq);
 	rq_qos_throttle(q, *bio);
 
+	blk_mq_rq_time_init(rq);
 	rq->cmd_flags = (*bio)->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1743857e0b01..29ed4d05110e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -150,6 +150,7 @@ struct blk_mq_alloc_data {
 	unsigned int shallow_depth;
 	blk_opf_t cmd_flags;
 	req_flags_t rq_flags;
+	u64 start_time_ns;
 
 	/* allocate multiple requests/tags in one go */
 	unsigned int nr_tags;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f401067ac03a..e8366e9c3388 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -834,9 +834,9 @@ void blk_mq_end_request_batch(struct io_comp_batch *ib);
  * Only need start/end time stamping if we have iostat or
  * blk stats enabled, or using an IO scheduler.
  */
-static inline bool blk_mq_need_time_stamp(struct request *rq)
+static inline bool blk_mq_need_time_stamp(req_flags_t rq_flags)
 {
-	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_USE_SCHED));
+	return (rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_USE_SCHED));
 }
 
 static inline bool blk_mq_is_reserved_rq(struct request *rq)
@@ -860,7 +860,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 		iob->complete = complete;
 	else if (iob->complete != complete)
 		return false;
-	iob->need_ts |= blk_mq_need_time_stamp(req);
+	iob->need_ts |= blk_mq_need_time_stamp(req->rq_flags);
 	rq_list_add(&iob->req_list, req);
 	return true;
 }
-- 
2.39.2

