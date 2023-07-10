Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4425D74CD9C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjGJGrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGJGrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:47:46 -0400
Received: from out-44.mta0.migadu.com (out-44.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110394
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:47:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688971661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFHrBB4bko1T7CcipHLq8zzquXX/o6IDfKwmotZ7GxM=;
        b=DIySGC8GNDHey1wTOKKSQIMH13DY+utpZiE8x/xYUw9o5HGuPML6lnZyjimxk/DUpvkqyY
        TXi4E3QDQxoIl3DVh3fzjTK1Z87y4Si/e9X84usuuoHvKlPo5BvCpk1Vm6qDEwUO6uYzNh
        iWuOIONcFgIAsU1k7wL6i4n1Owzvi30=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 2/2] blk-flush: don't need to end rq twice for non post-flush requests
Date:   Mon, 10 Jul 2023 14:47:05 +0800
Message-ID: <20230710064705.1847287-2-chengming.zhou@linux.dev>
In-Reply-To: <20230710064705.1847287-1-chengming.zhou@linux.dev>
References: <20230710064705.1847287-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Now we unconditionally blk_rq_init_flush() to replace rq->end_io to
make rq return twice back to the flush state machine for post-flush.

Obviously, non post-flush requests don't need it, they don't need to
end request twice, so they don't need to replace rq->end_io callback.
And the same for requests with the FUA bit on hardware with FUA support.

So we move blk_rq_init_flush() to REQ_FSEQ_DATA stage and only replace
rq->end_io if it needs post-flush. Otherwise, it can end like normal
request and doesn't need to return back to the flush state machine.

There are also some other good points:
1. all requests on hardware with FUA support won't have post-flush, so
   all of them don't need to end twice.

2. non post-flush requests won't have RQF_FLUSH_SEQ rq_flags set, so
   they can merge like normal requests.

3. we don't account non post-flush requests in flush_data_in_flight,
   since there is no point to defer pending flush for these requests.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-flush.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 094a6adb2718..1b92654e8757 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -93,6 +93,7 @@ enum {
 
 static void blk_kick_flush(struct request_queue *q,
 			   struct blk_flush_queue *fq, blk_opf_t flags);
+static void blk_rq_init_flush(struct request *rq);
 
 static inline struct blk_flush_queue *
 blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
@@ -187,7 +188,15 @@ static void blk_flush_complete_seq(struct request *rq,
 		break;
 
 	case REQ_FSEQ_DATA:
-		fq->flush_data_in_flight++;
+		/*
+		 * Only for requests that need post-flush,
+		 * we need to do rq->end_io replacement trick
+		 * to return back to the flush state machine.
+		 */
+		if (!(rq->flush.seq & REQ_FSEQ_POSTFLUSH)) {
+			blk_rq_init_flush(rq);
+			fq->flush_data_in_flight++;
+		}
 		spin_lock(&q->requeue_lock);
 		list_move_tail(&rq->queuelist, &q->flush_list);
 		spin_unlock(&q->requeue_lock);
@@ -202,7 +211,13 @@ static void blk_flush_complete_seq(struct request *rq,
 		 * normal completion and end it.
 		 */
 		list_del_init(&rq->queuelist);
-		blk_flush_restore_request(rq);
+		/*
+		 * Only for requests that had rq->end_io replaced,
+		 * we need to restore rq->end_io and make it a normal
+		 * request before the second end.
+		 */
+		if (rq->rq_flags & RQF_FLUSH_SEQ)
+			blk_flush_restore_request(rq);
 		blk_mq_end_request(rq, error);
 		break;
 
@@ -389,7 +404,6 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 
 static void blk_rq_init_flush(struct request *rq)
 {
-	rq->flush.seq = 0;
 	rq->rq_flags |= RQF_FLUSH_SEQ;
 	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
 	rq->end_io = mq_flush_data_end_io;
@@ -424,6 +438,7 @@ bool blk_insert_flush(struct request *rq)
 	 * the request accounting.
 	 */
 	rq->cmd_flags |= REQ_SYNC;
+	rq->flush.seq = 0;
 
 	switch (policy) {
 	case 0:
@@ -458,7 +473,6 @@ bool blk_insert_flush(struct request *rq)
 		 * Mark the request as part of a flush sequence and submit it
 		 * for further processing to the flush state machine.
 		 */
-		blk_rq_init_flush(rq);
 		spin_lock_irq(&fq->mq_flush_lock);
 		blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
 		spin_unlock_irq(&fq->mq_flush_lock);
-- 
2.41.0

