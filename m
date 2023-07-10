Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4970874D401
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGJK4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjGJK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:56:18 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE17CC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:56:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688986571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JAAcTMTsrAbVSkHrV3Db9f82+9y9+CSUZSusZpOXTxQ=;
        b=xwELUxx5NzyXo3IUYtBQAxtpHrkwS2foQIMSGnIRGb4fpzUZXqrsl/58qwGy0RWV9aLuW3
        +A5S2ZbKe6hh7F1nGgFkEJXbY0mDM5XLF4ZuG2UceOGYCDxJAobfJPe8SA35FieYN050C5
        aO0n7VPxcYyZonSHVWMalC620oP26IE=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, tj@kernel.org, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq
Date:   Mon, 10 Jul 2023 18:55:16 +0800
Message-ID: <20230710105516.2053478-1-chengming.zhou@linux.dev>
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

The iocost rely on rq start_time_ns and alloc_time_ns to tell saturation
state of the block device. Most of the time request is allocated after
rq_qos_throttle() and its alloc_time_ns or start_time_ns won't be affected.

But for plug batched allocation introduced by the commit 47c122e35d7e
("block: pre-allocate requests if plug is started and is a batch"), we can
rq_qos_throttle() after the allocation of the request. This is what the
blk_mq_get_cached_request() does.

In this case, the cached request alloc_time_ns or start_time_ns is much
ahead if blocked in any qos ->throttle().

Fix it by setting alloc_time_ns and start_time_ns to now when the allocated
request is actually used.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v5:
 - Don't reuse __blk_mq_alloc_requests(), which makes it much complex.
 - Always initialize the time stamps after blk_mq_rq_ctx_init(), which
   is clearer, as suggested by Christoph Hellwig.
 - We still need to pass optional alloc_time_ns to blk_mq_rq_time_init(),
   which includes depth and tag waits time by definition.
 - [v4] https://lore.kernel.org/all/20230629121302.1124851-1-chengming.zhou@linux.dev/

v4:
 - Use blk_mq_alloc_data to pass start_time_ns instead of passing down
   yet another parameter. Thanks Christoph Hellwig.
 - [v3] https://lore.kernel.org/all/20230628124546.1056698-1-chengming.zhou@linux.dev/

v3:
 - Skip setting the alloc_time_ns and start_time_ns during pre-allocation,
   which is clearer, as suggested by Tejun.
 - [v2] https://lore.kernel.org/all/20230626050405.781253-1-chengming.zhou@linux.dev/
---
 block/blk-mq.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index decb6ab2d508..2352fed460f8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -337,8 +337,24 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 }
 EXPORT_SYMBOL(blk_rq_init);
 
+/* Set start and alloc time when the allocated request is actually used */
+static inline void blk_mq_rq_time_init(struct request *rq, u64 alloc_time_ns)
+{
+	if (blk_mq_need_time_stamp(rq))
+		rq->start_time_ns = ktime_get_ns();
+	else
+		rq->start_time_ns = 0;
+
+#ifdef CONFIG_BLK_RQ_ALLOC_TIME
+	if (blk_queue_rq_alloc_time(rq->q))
+		rq->alloc_time_ns = alloc_time_ns ?: rq->start_time_ns;
+	else
+		rq->alloc_time_ns = 0;
+#endif
+}
+
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
-		struct blk_mq_tags *tags, unsigned int tag, u64 alloc_time_ns)
+		struct blk_mq_tags *tags, unsigned int tag)
 {
 	struct blk_mq_ctx *ctx = data->ctx;
 	struct blk_mq_hw_ctx *hctx = data->hctx;
@@ -365,14 +381,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
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
@@ -402,8 +411,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 }
 
 static inline struct request *
-__blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
-		u64 alloc_time_ns)
+__blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 {
 	unsigned int tag, tag_offset;
 	struct blk_mq_tags *tags;
@@ -422,7 +430,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 		tag = tag_offset + i;
 		prefetch(tags->static_rqs[tag]);
 		tag_mask &= ~(1UL << i);
-		rq = blk_mq_rq_ctx_init(data, tags, tag, alloc_time_ns);
+		rq = blk_mq_rq_ctx_init(data, tags, tag);
 		rq_list_add(data->cached_rq, rq);
 		nr++;
 	}
@@ -483,9 +491,11 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	 * Try batched alloc if we want more than 1 tag.
 	 */
 	if (data->nr_tags > 1) {
-		rq = __blk_mq_alloc_requests_batch(data, alloc_time_ns);
-		if (rq)
+		rq = __blk_mq_alloc_requests_batch(data);
+		if (rq) {
+			blk_mq_rq_time_init(rq, alloc_time_ns);
 			return rq;
+		}
 		data->nr_tags = 1;
 	}
 
@@ -508,8 +518,9 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		goto retry;
 	}
 
-	return blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag,
-					alloc_time_ns);
+	rq = blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag);
+	blk_mq_rq_time_init(rq, alloc_time_ns);
+	return rq;
 }
 
 static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
@@ -564,6 +575,7 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
 			return NULL;
 
 		plug->cached_rq = rq_list_next(rq);
+		blk_mq_rq_time_init(rq, 0);
 	}
 
 	rq->cmd_flags = opf;
@@ -665,8 +677,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
-	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
-					alloc_time_ns);
+	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
+	blk_mq_rq_time_init(rq, alloc_time_ns);
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
@@ -2901,6 +2913,7 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	plug->cached_rq = rq_list_next(rq);
 	rq_qos_throttle(q, *bio);
 
+	blk_mq_rq_time_init(rq, 0);
 	rq->cmd_flags = (*bio)->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
-- 
2.41.0

