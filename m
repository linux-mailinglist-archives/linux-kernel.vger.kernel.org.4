Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9519654C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 06:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiLWFxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 00:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLWFxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 00:53:14 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D96BFCC3;
        Thu, 22 Dec 2022 21:53:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4134F6732D; Fri, 23 Dec 2022 06:53:09 +0100 (CET)
Date:   Fri, 23 Dec 2022 06:53:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, john.garry@huawei.com
Subject: Re: [PATCH 12/13] blk-mq: use switch/case to improve readability
 in blk_mq_try_issue_list_directly
Message-ID: <20221223055308.GB2676@lst.de>
References: <20221223125223.1687670-1-shikemeng@huaweicloud.com> <20221223125223.1687670-13-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223125223.1687670-13-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 08:52:22PM +0800, Kemeng Shi wrote:
> +			blk_mq_request_bypass_insert(rq, false, list_empty(list));

Please try to avoid the overly long line here.

That beng said blk_mq_request_bypass_insert is simply a horrible
API.  I think we should do something like this:


diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53202eff545efb..b6157ae11df651 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -432,7 +432,8 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		blk_mq_request_bypass_insert(rq, false, true);
+		blk_mq_request_bypass_insert(rq);
+		blk_mq_run_hw_queue(rq->mq_hctx, false);
 		return;
 	}
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 23d1a90fec4271..d49fe4503b09d7 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -437,12 +437,13 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 		 * Simply queue flush rq to the front of hctx->dispatch so that
 		 * intensive flush workloads can benefit in case of NCQ HW.
 		 */
-		at_head = (rq->rq_flags & RQF_FLUSH_SEQ) ? true : at_head;
-		blk_mq_request_bypass_insert(rq, at_head, false);
-		goto run;
-	}
-
-	if (e) {
+		spin_lock(&hctx->lock);
+		if ((rq->rq_flags & RQF_FLUSH_SEQ) || at_head)
+			list_add(&rq->queuelist, &hctx->dispatch);
+		else
+			list_add_tail(&rq->queuelist, &hctx->dispatch);
+		spin_unlock(&hctx->lock);
+	} else if (e) {
 		LIST_HEAD(list);
 
 		list_add(&rq->queuelist, &list);
@@ -453,7 +454,6 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 		spin_unlock(&ctx->lock);
 	}
 
-run:
 	if (run_queue)
 		blk_mq_run_hw_queue(hctx, async);
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c5cf0dbca1db8d..43bb9b36c90da7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1467,7 +1467,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		 * merge.
 		 */
 		if (rq->rq_flags & RQF_DONTPREP)
-			blk_mq_request_bypass_insert(rq, false, false);
+			blk_mq_request_bypass_insert(rq);
 		else
 			blk_mq_sched_insert_request(rq, true, false, false);
 	}
@@ -2504,26 +2504,17 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 /**
  * blk_mq_request_bypass_insert - Insert a request at dispatch list.
  * @rq: Pointer to request to be inserted.
- * @at_head: true if the request should be inserted at the head of the list.
- * @run_queue: If we should run the hardware queue after inserting the request.
  *
  * Should only be used carefully, when the caller knows we want to
  * bypass a potential IO scheduler on the target device.
  */
-void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
-				  bool run_queue)
+void blk_mq_request_bypass_insert(struct request *rq)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	spin_lock(&hctx->lock);
-	if (at_head)
-		list_add(&rq->queuelist, &hctx->dispatch);
-	else
-		list_add_tail(&rq->queuelist, &hctx->dispatch);
+	list_add_tail(&rq->queuelist, &hctx->dispatch);
 	spin_unlock(&hctx->lock);
-
-	if (run_queue)
-		blk_mq_run_hw_queue(hctx, false);
 }
 
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
@@ -2670,10 +2661,17 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	blk_status_t ret =
 		__blk_mq_try_issue_directly(hctx, rq, false, true);
 
-	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
-		blk_mq_request_bypass_insert(rq, false, true);
-	else if (ret != BLK_STS_OK)
+	switch (ret) {
+	case BLK_STS_OK:
+		break;
+	case BLK_STS_RESOURCE:
+	case BLK_STS_DEV_RESOURCE:
+		blk_mq_request_bypass_insert(rq);
+		blk_mq_run_hw_queue(rq->mq_hctx, false);
+		break;
+	default:
 		blk_mq_end_request(rq, ret);
+	}
 }
 
 static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
@@ -2705,7 +2703,8 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 			break;
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false, true);
+			blk_mq_request_bypass_insert(rq);
+			blk_mq_run_hw_queue(rq->mq_hctx, false);
 			blk_mq_commit_rqs(hctx, &queued, from_schedule);
 			return;
 		default:
@@ -2818,8 +2817,9 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 			errors++;
 			if (ret == BLK_STS_RESOURCE ||
 					ret == BLK_STS_DEV_RESOURCE) {
-				blk_mq_request_bypass_insert(rq, false,
-							list_empty(list));
+				blk_mq_request_bypass_insert(rq);
+				if (list_empty(list))
+					blk_mq_run_hw_queue(rq->mq_hctx, false);
 				break;
 			}
 			blk_mq_end_request(rq, ret);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index ef59fee62780d3..3733429561e1eb 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -61,8 +61,7 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
  */
 void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 				bool at_head);
-void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
-				  bool run_queue);
+void blk_mq_request_bypass_insert(struct request *rq);
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
