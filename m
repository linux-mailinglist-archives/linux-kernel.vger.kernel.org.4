Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8330D742577
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjF2MN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjF2MNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:13:54 -0400
Received: from out-22.mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B285A30C5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:13:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688040831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PIs+ICQNDa5Vfiyu1UAjrg6pN938Jdy2JxIM6CdLM3k=;
        b=NFz7GpY3S3aV7jV8xRsur9xzqu6C4Qib21R6jTKJkpaZrJiUA8T5yvi48X0ycq/iBk6OgY
        58R8Mp6ZmSf/ViThCrgmYM54zKo6r+gs/HHWzHmZhIMHtEiTN7Abue0iPQSPpEgqWoa6+B
        nhyB0C469Q0wFK9N6G1ka56gVityIBc=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 1/2] blk-mq: move data->rq_flags initialization code
Date:   Thu, 29 Jun 2023 20:13:01 +0800
Message-Id: <20230629121302.1124851-2-chengming.zhou@linux.dev>
In-Reply-To: <20230629121302.1124851-1-chengming.zhou@linux.dev>
References: <20230629121302.1124851-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The blk_mq_rq_ctx_init() has some data->rq_flags initialization:

```
if (data->flags & BLK_MQ_REQ_PM)
	data->rq_flags |= RQF_PM;
if (blk_queue_io_stat(q))
	data->rq_flags |= RQF_IO_STAT;
rq->rq_flags = data->rq_flags;
```

We will need this data->rq_flags to tell if we need start_time_ns, so
we need to put these initialization in the callers of blk_mq_rq_ctx_init().

Now we basically have two callers, the 1st is general __blk_mq_alloc_requests(),
the 2nd is the special blk_mq_alloc_request_hctx(). So change the 2nd caller
to reuse the 1st __blk_mq_alloc_requests() to avoid code duplication.

This is safe because blk_mq_alloc_request_hctx() always has BLK_MQ_REQ_NOWAIT
flag, it won't go into the normal retry path when doesn't have free tag.
But it indeed make the general __blk_mq_alloc_requests() more complex.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index decb6ab2d508..c50ef953759f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -349,11 +349,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->mq_ctx = ctx;
 	rq->mq_hctx = hctx;
 	rq->cmd_flags = data->cmd_flags;
-
-	if (data->flags & BLK_MQ_REQ_PM)
-		data->rq_flags |= RQF_PM;
-	if (blk_queue_io_stat(q))
-		data->rq_flags |= RQF_IO_STAT;
 	rq->rq_flags = data->rq_flags;
 
 	if (data->rq_flags & RQF_SCHED_TAGS) {
@@ -447,6 +442,15 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
+	if (data->flags & BLK_MQ_REQ_RESERVED)
+		data->rq_flags |= RQF_RESV;
+
+	if (data->flags & BLK_MQ_REQ_PM)
+		data->rq_flags |= RQF_PM;
+
+	if (blk_queue_io_stat(q))
+		data->rq_flags |= RQF_IO_STAT;
+
 	if (q->elevator) {
 		/*
 		 * All requests use scheduler tags when an I/O scheduler is
@@ -471,14 +475,15 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	}
 
 retry:
-	data->ctx = blk_mq_get_ctx(q);
-	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
+	/* See blk_mq_alloc_request_hctx() for details */
+	if (!data->ctx) {
+		data->ctx = blk_mq_get_ctx(q);
+		data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
+	}
+
 	if (!(data->rq_flags & RQF_SCHED_TAGS))
 		blk_mq_tag_busy(data->hctx);
 
-	if (data->flags & BLK_MQ_REQ_RESERVED)
-		data->rq_flags |= RQF_RESV;
-
 	/*
 	 * Try batched alloc if we want more than 1 tag.
 	 */
@@ -505,6 +510,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		 * is going away.
 		 */
 		msleep(3);
+		data->ctx = NULL;
 		goto retry;
 	}
 
@@ -613,16 +619,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		.cmd_flags	= opf,
 		.nr_tags	= 1,
 	};
-	u64 alloc_time_ns = 0;
 	struct request *rq;
 	unsigned int cpu;
-	unsigned int tag;
 	int ret;
 
-	/* alloc_time includes depth and tag waits */
-	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns = ktime_get_ns();
-
 	/*
 	 * If the tag allocator sleeps we could get an allocation for a
 	 * different hardware context.  No need to complicate the low level
@@ -653,20 +653,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		goto out_queue_exit;
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
-	if (q->elevator)
-		data.rq_flags |= RQF_SCHED_TAGS;
-	else
-		blk_mq_tag_busy(data.hctx);
-
-	if (flags & BLK_MQ_REQ_RESERVED)
-		data.rq_flags |= RQF_RESV;
-
 	ret = -EWOULDBLOCK;
-	tag = blk_mq_get_tag(&data);
-	if (tag == BLK_MQ_NO_TAG)
+	rq = __blk_mq_alloc_requests(&data);
+	if (!rq)
 		goto out_queue_exit;
-	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
-					alloc_time_ns);
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
-- 
2.39.2

