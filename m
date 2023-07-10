Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619F774CE93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjGJHgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjGJHgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:36:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2EC12E;
        Mon, 10 Jul 2023 00:36:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 963D567373; Mon, 10 Jul 2023 09:36:31 +0200 (CEST)
Date:   Mon, 10 Jul 2023 09:36:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Christoph Hellwig <hch@lst.de>, chengming.zhou@linux.dev,
        axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v3 1/3] blk-mq: always use __blk_mq_alloc_requests() to
 alloc and init rq
Message-ID: <20230710073631.GA29077@lst.de>
References: <20230628124546.1056698-1-chengming.zhou@linux.dev> <20230628124546.1056698-2-chengming.zhou@linux.dev> <20230629052828.GD16819@lst.de> <f91c32b3-1d3b-b28c-40cb-2edf02448f22@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f91c32b3-1d3b-b28c-40cb-2edf02448f22@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 03:40:03PM +0800, Chengming Zhou wrote:
> Thanks for your review!
> 
> Since hctx-specific allocation path always has BLK_MQ_REQ_NOWAIT flag,
> it won't retry.
> 
> But I agree, this makes the general __blk_mq_alloc_requests() more complex.

And also very confusing as it pretends to share some code, while almost
nothing of __blk_mq_alloc_requests is actually used.

> The reason is blk_mq_rq_ctx_init() has some data->rq_flags initialization:
> 
> ```
> if (data->flags & BLK_MQ_REQ_PM)
> 	data->rq_flags |= RQF_PM;
> if (blk_queue_io_stat(q))
> 	data->rq_flags |= RQF_IO_STAT;
> rq->rq_flags = data->rq_flags;
> ```
> 
> Because we need this data->rq_flags to tell if we need start_time_ns,
> we need to put these initialization in the callers of blk_mq_rq_ctx_init().

Why can't we just always initialize the time stampts after
blk_mq_rq_ctx_init? Something like this (untested) variant of your
patch 2 from the latest iteration:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5504719b970d59..55bf1009f3e32a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -328,8 +328,26 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 }
 EXPORT_SYMBOL(blk_rq_init);
 
+/* Set alloc and start time when pre-allocated rq is actually used */
+static inline void blk_mq_rq_time_init(struct request *rq, bool set_alloc_time)
+{
+	if (blk_mq_need_time_stamp(rq)) {
+		u64 now = ktime_get_ns();
+
+#ifdef CONFIG_BLK_RQ_ALLOC_TIME
+		/*
+		 * The alloc time is only used by iocost for now,
+		 * only possible when blk_mq_need_time_stamp().
+		 */
+		if (set_alloc_time)
+			rq->alloc_time_ns = now;
+#endif
+		rq->start_time_ns = now;
+	}
+}
+
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
-		struct blk_mq_tags *tags, unsigned int tag, u64 alloc_time_ns)
+		struct blk_mq_tags *tags, unsigned int tag)
 {
 	struct blk_mq_ctx *ctx = data->ctx;
 	struct blk_mq_hw_ctx *hctx = data->hctx;
@@ -356,14 +374,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	}
 	rq->timeout = 0;
 
-	if (blk_mq_need_time_stamp(rq))
-		rq->start_time_ns = ktime_get_ns();
-	else
-		rq->start_time_ns = 0;
 	rq->part = NULL;
-#ifdef CONFIG_BLK_RQ_ALLOC_TIME
-	rq->alloc_time_ns = alloc_time_ns;
-#endif
 	rq->io_start_time_ns = 0;
 	rq->stats_sectors = 0;
 	rq->nr_phys_segments = 0;
@@ -393,8 +404,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 }
 
 static inline struct request *
-__blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
-		u64 alloc_time_ns)
+__blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 {
 	unsigned int tag, tag_offset;
 	struct blk_mq_tags *tags;
@@ -413,7 +423,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 		tag = tag_offset + i;
 		prefetch(tags->static_rqs[tag]);
 		tag_mask &= ~(1UL << i);
-		rq = blk_mq_rq_ctx_init(data, tags, tag, alloc_time_ns);
+		rq = blk_mq_rq_ctx_init(data, tags, tag);
 		rq_list_add(data->cached_rq, rq);
 		nr++;
 	}
@@ -427,12 +437,13 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 {
 	struct request_queue *q = data->q;
+	bool set_alloc_time = blk_queue_rq_alloc_time(q);
 	u64 alloc_time_ns = 0;
 	struct request *rq;
 	unsigned int tag;
 
 	/* alloc_time includes depth and tag waits */
-	if (blk_queue_rq_alloc_time(q))
+	if (set_alloc_time)
 		alloc_time_ns = ktime_get_ns();
 
 	if (data->cmd_flags & REQ_NOWAIT)
@@ -474,9 +485,11 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	 * Try batched alloc if we want more than 1 tag.
 	 */
 	if (data->nr_tags > 1) {
-		rq = __blk_mq_alloc_requests_batch(data, alloc_time_ns);
-		if (rq)
+		rq = __blk_mq_alloc_requests_batch(data);
+		if (rq) {
+			blk_mq_rq_time_init(rq, true);
 			return rq;
+		}
 		data->nr_tags = 1;
 	}
 
@@ -499,8 +512,10 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		goto retry;
 	}
 
-	return blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag,
-					alloc_time_ns);
+	rq = blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag);
+	if (rq)
+		blk_mq_rq_time_init(rq, set_alloc_time);
+	return rq;
 }
 
 static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
@@ -555,6 +570,7 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
 			return NULL;
 
 		plug->cached_rq = rq_list_next(rq);
+		blk_mq_rq_time_init(rq, blk_queue_rq_alloc_time(rq->q));
 	}
 
 	rq->cmd_flags = opf;
@@ -656,8 +672,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
-	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
-					alloc_time_ns);
+	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
+	blk_mq_rq_time_init(rq, blk_queue_rq_alloc_time(rq->q));
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
@@ -2896,6 +2912,7 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	plug->cached_rq = rq_list_next(rq);
 	rq_qos_throttle(q, *bio);
 
+	blk_mq_rq_time_init(rq, blk_queue_rq_alloc_time(rq->q));
 	rq->cmd_flags = (*bio)->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
