Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0F663A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjAJIKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjAJIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:10:26 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D95347311;
        Tue, 10 Jan 2023 00:09:33 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8881E68BFE; Tue, 10 Jan 2023 09:09:25 +0100 (CET)
Date:   Tue, 10 Jan 2023 09:09:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, dwagner@suse.de,
        hare@suse.de, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v2 08/13] blk-mq: simplify flush check in
 blk_mq_dispatch_rq_list
Message-ID: <20230110080923.GA11231@lst.de>
References: <20230104142259.2673013-1-shikemeng@huaweicloud.com> <20230104142259.2673013-9-shikemeng@huaweicloud.com> <20230108180611.GG23466@lst.de> <86677943-1c5e-370f-ba69-25e10738b67b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86677943-1c5e-370f-ba69-25e10738b67b@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 10:27:33AM +0800, Kemeng Shi wrote:
> After we queue request[s] to one driver queue, we need to notify driver
> that there are no more request to the queue or driver will keep waiting
> for the last request to be queued and IO hung could happen.

Yes.

> Normaly, we will notify this by setting .last in struct blk_mq_queue_data
> along with the normal last request .rq in struct blk_mq_queue_data. The
> extra commit is only needed if normal last information in .last is lost.
> (See comment in struct blk_mq_ops for commit_rqs).
> 
> The lost could occur if error happens for sending last request with .last
> set or error happen in middle of list and we even do not send the request
> with .last set.

Yes. So the rule is:

 1) did not queue everything initially scheduled to queue

OR

 2) the last attempt to queue a request failed

I think we need to find a way to clearly document that and that
make all callers match it.

For most this becomes a

	if (ret || !list_empty(list))

or even just

	if (ret)

as an error is often the only way to break out of the submission
loop.

I wonder if we need to split the queued clearing from blk_mq_commit_rqs
and just clear it in the existing callers, so that we can use that
helpers for all commits, nicely hiding the ->commit_rqs presence
check, and then move that call to where it is needed directly.  Something
like this untested patch (which needs to be split up), which also
makes sure we trace these calls consistently:

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c5cf0dbca1db8d..436ca56a0b7172 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2001,6 +2001,15 @@ static void blk_mq_release_budgets(struct request_queue *q,
 	}
 }
 
+static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int queued,
+			      bool from_schedule)
+{
+	if (queued && hctx->queue->mq_ops->commit_rqs) {
+		trace_block_unplug(hctx->queue, queued, !from_schedule);
+		hctx->queue->mq_ops->commit_rqs(hctx);
+	}
+}
+
 /*
  * Returns true if we did some work AND can potentially do more.
  */
@@ -2082,12 +2091,9 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	if (!list_empty(&zone_list))
 		list_splice_tail_init(&zone_list, list);
 
-	/* If we didn't flush the entire list, we could have told the driver
-	 * there was more coming, but that turned out to be a lie.
-	 */
-	if ((!list_empty(list) || errors || needs_resource ||
-	     ret == BLK_STS_DEV_RESOURCE) && q->mq_ops->commit_rqs && queued)
-		q->mq_ops->commit_rqs(hctx);
+	if (!list_empty(list) || ret)
+		blk_mq_commit_rqs(hctx, queued, false);
+
 	/*
 	 * Any items that need requeuing? Stuff them into hctx->dispatch,
 	 * that is where we will continue on next queue run.
@@ -2548,16 +2554,6 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	spin_unlock(&ctx->lock);
 }
 
-static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued,
-			      bool from_schedule)
-{
-	if (hctx->queue->mq_ops->commit_rqs) {
-		trace_block_unplug(hctx->queue, *queued, !from_schedule);
-		hctx->queue->mq_ops->commit_rqs(hctx);
-	}
-	*queued = 0;
-}
-
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 		unsigned int nr_segs)
 {
@@ -2684,17 +2680,17 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
+	blk_status_t ret = BLK_STS_OK;
 	struct request *rq;
 	int queued = 0;
-	int errors = 0;
 
 	while ((rq = rq_list_pop(&plug->mq_list))) {
 		bool last = rq_list_empty(plug->mq_list);
-		blk_status_t ret;
 
 		if (hctx != rq->mq_hctx) {
 			if (hctx)
-				blk_mq_commit_rqs(hctx, &queued, from_schedule);
+				blk_mq_commit_rqs(hctx, queued, from_schedule);
+			queued = 0;
 			hctx = rq->mq_hctx;
 		}
 
@@ -2706,21 +2702,15 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
 			blk_mq_request_bypass_insert(rq, false, true);
-			blk_mq_commit_rqs(hctx, &queued, from_schedule);
-			return;
+			goto out;
 		default:
 			blk_mq_end_request(rq, ret);
-			errors++;
 			break;
 		}
 	}
-
-	/*
-	 * If we didn't flush the entire list, we could have told the driver
-	 * there was more coming, but that turned out to be a lie.
-	 */
-	if (errors)
-		blk_mq_commit_rqs(hctx, &queued, from_schedule);
+out:
+	if (ret)
+		blk_mq_commit_rqs(hctx, queued, from_schedule);
 }
 
 static void __blk_mq_flush_plug_list(struct request_queue *q,
@@ -2804,37 +2794,33 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
+	blk_status_t ret = BLK_STS_OK;
+	struct request *rq;
 	int queued = 0;
-	int errors = 0;
-
-	while (!list_empty(list)) {
-		blk_status_t ret;
-		struct request *rq = list_first_entry(list, struct request,
-				queuelist);
+	bool last;
 
+	while ((rq = list_first_entry_or_null(list, struct request,
+			queuelist))) {
 		list_del_init(&rq->queuelist);
-		ret = blk_mq_request_issue_directly(rq, list_empty(list));
-		if (ret != BLK_STS_OK) {
-			errors++;
-			if (ret == BLK_STS_RESOURCE ||
-					ret == BLK_STS_DEV_RESOURCE) {
-				blk_mq_request_bypass_insert(rq, false,
-							list_empty(list));
-				break;
-			}
-			blk_mq_end_request(rq, ret);
-		} else
+		last = list_empty(list);
+
+		ret = blk_mq_request_issue_directly(rq, last);
+		switch (ret) {
+		case BLK_STS_OK:
 			queued++;
+			break;
+		case BLK_STS_RESOURCE:
+		case BLK_STS_DEV_RESOURCE:
+			blk_mq_request_bypass_insert(rq, false, last);
+			goto out;
+		default:
+			blk_mq_end_request(rq, ret);
+			break;
+		}
 	}
-
-	/*
-	 * If we didn't flush the entire list, we could have told
-	 * the driver there was more coming, but that turned out to
-	 * be a lie.
-	 */
-	if ((!list_empty(list) || errors) &&
-	     hctx->queue->mq_ops->commit_rqs && queued)
-		hctx->queue->mq_ops->commit_rqs(hctx);
+out:
+	if (ret)
+		blk_mq_commit_rqs(hctx, queued, false);
 }
 
 static bool blk_mq_attempt_bio_merge(struct request_queue *q,
