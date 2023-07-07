Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6660574ADE8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjGGJji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjGGJja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:39:30 -0400
Received: from out-43.mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11CB2128
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 02:39:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688722754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znByHfzQSpvrPQaReH7yflCmK5TREu8Z0tH8P3jgNog=;
        b=k7qzuLrFyLTHZjTplLwK1pIMWbb8ID0RsNUs4Ol1S8PtEC8M5suueKCd3IbrWN5ymFPn7L
        nJb+qDCU2VhjmBkz7x9+mo5G5TP4+RPaHNpqlbB807FYEBzpT5x7zerC5w8JMfDl0HLH20
        ZkBK7AQ8c03WwQMbsn4KP4k8L1ZAzrI=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v3 4/4] blk-flush: reuse rq queuelist in flush state machine
Date:   Fri,  7 Jul 2023 17:37:22 +0800
Message-ID: <20230707093722.1338589-5-chengming.zhou@linux.dev>
In-Reply-To: <20230707093722.1338589-1-chengming.zhou@linux.dev>
References: <20230707093722.1338589-1-chengming.zhou@linux.dev>
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

Since we don't need to maintain inflight flush_data requests list
anymore, we can reuse rq->queuelist for flush pending list.

Note in mq_flush_data_end_io(), we need to re-initialize rq->queuelist
before reusing it in the state machine when end, since the rq->rq_next
also reuse it, may have corrupted rq->queuelist by the driver.

This patch decrease the size of struct request by 16 bytes.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v3:
 - fix a bug report of blktests nvme/012, we need to re-initialize
   rq->queuelist before reusing it in the state machine when end.
   Because rq->rq_next reuse may have corrupted it. Thanks Ming Lei.
---
 block/blk-flush.c      | 17 ++++++++++-------
 include/linux/blk-mq.h |  1 -
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index bb7adfc2a5da..4826d2d61a23 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -183,14 +183,13 @@ static void blk_flush_complete_seq(struct request *rq,
 		/* queue for flush */
 		if (list_empty(pending))
 			fq->flush_pending_since = jiffies;
-		list_move_tail(&rq->flush.list, pending);
+		list_move_tail(&rq->queuelist, pending);
 		break;
 
 	case REQ_FSEQ_DATA:
-		list_del_init(&rq->flush.list);
 		fq->flush_data_in_flight++;
 		spin_lock(&q->requeue_lock);
-		list_add_tail(&rq->queuelist, &q->flush_list);
+		list_move_tail(&rq->queuelist, &q->flush_list);
 		spin_unlock(&q->requeue_lock);
 		blk_mq_kick_requeue_list(q);
 		break;
@@ -202,7 +201,7 @@ static void blk_flush_complete_seq(struct request *rq,
 		 * flush data request completion path.  Restore @rq for
 		 * normal completion and end it.
 		 */
-		list_del_init(&rq->flush.list);
+		list_del_init(&rq->queuelist);
 		blk_flush_restore_request(rq);
 		blk_mq_end_request(rq, error);
 		break;
@@ -258,7 +257,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 	fq->flush_running_idx ^= 1;
 
 	/* and push the waiting requests to the next stage */
-	list_for_each_entry_safe(rq, n, running, flush.list) {
+	list_for_each_entry_safe(rq, n, running, queuelist) {
 		unsigned int seq = blk_flush_cur_seq(rq);
 
 		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
@@ -292,7 +291,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 {
 	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
 	struct request *first_rq =
-		list_first_entry(pending, struct request, flush.list);
+		list_first_entry(pending, struct request, queuelist);
 	struct request *flush_rq = fq->flush_rq;
 
 	/* C1 described at the top of this file */
@@ -376,6 +375,11 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 	 */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 	fq->flush_data_in_flight--;
+	/*
+	 * May have been corrupted by rq->rq_next reuse, we need to
+	 * re-initialize rq->queuelist before reusing it here.
+	 */
+	INIT_LIST_HEAD(&rq->queuelist);
 	blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 
@@ -386,7 +390,6 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 static void blk_rq_init_flush(struct request *rq)
 {
 	rq->flush.seq = 0;
-	INIT_LIST_HEAD(&rq->flush.list);
 	rq->rq_flags |= RQF_FLUSH_SEQ;
 	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
 	rq->end_io = mq_flush_data_end_io;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 34d400171b3e..ab790eba5fcf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -176,7 +176,6 @@ struct request {
 
 	struct {
 		unsigned int		seq;
-		struct list_head	list;
 		rq_end_io_fn		*saved_end_io;
 	} flush;
 
-- 
2.41.0

