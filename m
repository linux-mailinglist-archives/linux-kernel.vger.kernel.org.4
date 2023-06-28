Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9BC74119E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjF1MsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjF1MrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:47:25 -0400
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [IPv6:2001:41d0:203:375::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7BF3580
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:46:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687956383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+XqY897Bsd8trRe4zaYsQVNZ9l3mE6f4vuEKbcRGH4=;
        b=CSTLZSKNj6ys56vnYR2av9Ny99Lqz1lGsQthqeKYSIcQ6AA/1ibqgqVW9kWf815EDeArpi
        9C1qTXEzPKb0JJNdsulSf4a5ulx+7FvHM42bKdtMAxak2qdoSqhvzC2EOfZVQn+aQOxbcQ
        CHFXZ5JpciTdAFydsQibQI+8YlT8oIk=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, ming.lei@redhat.com, hch@lst.de
Subject: [PATCH v3 3/3] blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq
Date:   Wed, 28 Jun 2023 20:45:46 +0800
Message-Id: <20230628124546.1056698-4-chengming.zhou@linux.dev>
In-Reply-To: <20230628124546.1056698-1-chengming.zhou@linux.dev>
References: <20230628124546.1056698-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 block/blk-mq.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8b981d0a868e..55a2e600f943 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -337,6 +337,24 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 }
 EXPORT_SYMBOL(blk_rq_init);
 
+/* Set rq alloc and start time when pre-allocated rq is actually used */
+static inline void blk_mq_rq_time_init(struct request_queue *q, struct request *rq)
+{
+	if (blk_mq_need_time_stamp(rq->rq_flags)) {
+		u64 now = ktime_get_ns();
+
+#ifdef CONFIG_BLK_RQ_ALLOC_TIME
+		/*
+		 * alloc time is only used by iocost for now,
+		 * only possible when blk_mq_need_time_stamp().
+		 */
+		if (blk_queue_rq_alloc_time(q))
+			rq->alloc_time_ns = now;
+#endif
+		rq->start_time_ns = now;
+	}
+}
+
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		struct blk_mq_tags *tags, unsigned int tag,
 		u64 alloc_time_ns, u64 start_time_ns)
@@ -395,23 +413,18 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 }
 
 static inline struct request *
-__blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
-		u64 alloc_time_ns)
+__blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 {
 	unsigned int tag, tag_offset;
 	struct blk_mq_tags *tags;
 	struct request *rq;
 	unsigned long tag_mask;
 	int i, nr = 0;
-	u64 start_time_ns = 0;
 
 	tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
 	if (unlikely(!tag_mask))
 		return NULL;
 
-	if (blk_mq_need_time_stamp(data->rq_flags))
-		start_time_ns = ktime_get_ns();
-
 	tags = blk_mq_tags_from_data(data);
 	for (i = 0; tag_mask; i++) {
 		if (!(tag_mask & (1UL << i)))
@@ -419,7 +432,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 		tag = tag_offset + i;
 		prefetch(tags->static_rqs[tag]);
 		tag_mask &= ~(1UL << i);
-		rq = blk_mq_rq_ctx_init(data, tags, tag, alloc_time_ns, start_time_ns);
+		rq = blk_mq_rq_ctx_init(data, tags, tag, 0, 0);
 		rq_list_add(data->cached_rq, rq);
 		nr++;
 	}
@@ -490,9 +503,11 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	 * Try batched alloc if we want more than 1 tag.
 	 */
 	if (data->nr_tags > 1) {
-		rq = __blk_mq_alloc_requests_batch(data, alloc_time_ns);
-		if (rq)
+		rq = __blk_mq_alloc_requests_batch(data);
+		if (rq) {
+			blk_mq_rq_time_init(q, rq);
 			return rq;
+		}
 		data->nr_tags = 1;
 	}
 
@@ -575,6 +590,7 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
 			return NULL;
 
 		plug->cached_rq = rq_list_next(rq);
+		blk_mq_rq_time_init(q, rq);
 	}
 
 	rq->cmd_flags = opf;
@@ -2896,6 +2912,7 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	plug->cached_rq = rq_list_next(rq);
 	rq_qos_throttle(q, *bio);
 
+	blk_mq_rq_time_init(q, rq);
 	rq->cmd_flags = (*bio)->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
-- 
2.39.2

