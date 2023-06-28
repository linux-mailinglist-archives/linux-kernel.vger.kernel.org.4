Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CDF741195
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjF1MrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:47:10 -0400
Received: from out-20.mta1.migadu.com ([95.215.58.20]:42890 "EHLO
        out-20.mta1.migadu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjF1MqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:46:21 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687956379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XFNAPAH6EuvNrQxjh5kQssWIEiKUAzjh/YE9gXkp8o=;
        b=ZB6x5iMJqA8fmsPlQ9csKa8eBIPh55rqemfIfNxgnDavPid2FV70CgRteGjoqUMd16rJ1U
        C/6TTcH8RqjGAph+iWU30iPJEa/lm+izi4ZcSndLvXFhJGOMdzX/kNxaS6plfuUlB2M8HD
        JfQ5E4WnEkjpfYXg5wEuKqhZD6zApL0=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, ming.lei@redhat.com, hch@lst.de
Subject: [PATCH v3 2/3] blk-mq: ktime_get_ns() only once for batched requests init
Date:   Wed, 28 Jun 2023 20:45:45 +0800
Message-Id: <20230628124546.1056698-3-chengming.zhou@linux.dev>
In-Reply-To: <20230628124546.1056698-1-chengming.zhou@linux.dev>
References: <20230628124546.1056698-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Extend blk_mq_rq_ctx_init() to receive start_time_ns, so we can
ktime_get_ns() only once for batched requests start_time_ns setting.

Since data->rq_flags initialization has been moved to the caller
__blk_mq_alloc_requests(), we can use it to check if time is needed.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c         | 23 ++++++++++++++---------
 include/linux/blk-mq.h |  6 +++---
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c50ef953759f..8b981d0a868e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -338,7 +338,8 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 EXPORT_SYMBOL(blk_rq_init);
 
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
-		struct blk_mq_tags *tags, unsigned int tag, u64 alloc_time_ns)
+		struct blk_mq_tags *tags, unsigned int tag,
+		u64 alloc_time_ns, u64 start_time_ns)
 {
 	struct blk_mq_ctx *ctx = data->ctx;
 	struct blk_mq_hw_ctx *hctx = data->hctx;
@@ -360,14 +361,11 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
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
+	rq->start_time_ns = start_time_ns;
 	rq->io_start_time_ns = 0;
 	rq->stats_sectors = 0;
 	rq->nr_phys_segments = 0;
@@ -405,11 +403,15 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 	struct request *rq;
 	unsigned long tag_mask;
 	int i, nr = 0;
+	u64 start_time_ns = 0;
 
 	tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
 	if (unlikely(!tag_mask))
 		return NULL;
 
+	if (blk_mq_need_time_stamp(data->rq_flags))
+		start_time_ns = ktime_get_ns();
+
 	tags = blk_mq_tags_from_data(data);
 	for (i = 0; tag_mask; i++) {
 		if (!(tag_mask & (1UL << i)))
@@ -417,7 +419,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 		tag = tag_offset + i;
 		prefetch(tags->static_rqs[tag]);
 		tag_mask &= ~(1UL << i);
-		rq = blk_mq_rq_ctx_init(data, tags, tag, alloc_time_ns);
+		rq = blk_mq_rq_ctx_init(data, tags, tag, alloc_time_ns, start_time_ns);
 		rq_list_add(data->cached_rq, rq);
 		nr++;
 	}
@@ -431,7 +433,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 {
 	struct request_queue *q = data->q;
-	u64 alloc_time_ns = 0;
+	u64 alloc_time_ns = 0, start_time_ns = 0;
 	struct request *rq;
 	unsigned int tag;
 
@@ -514,8 +516,11 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		goto retry;
 	}
 
+	if (blk_mq_need_time_stamp(data->rq_flags))
+		start_time_ns = ktime_get_ns();
+
 	return blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag,
-					alloc_time_ns);
+				  alloc_time_ns, start_time_ns);
 }
 
 static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
@@ -1004,7 +1009,7 @@ static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
 
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
-	if (blk_mq_need_time_stamp(rq))
+	if (blk_mq_need_time_stamp(rq->rq_flags))
 		__blk_mq_end_request_acct(rq, ktime_get_ns());
 
 	if (rq->end_io) {
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

