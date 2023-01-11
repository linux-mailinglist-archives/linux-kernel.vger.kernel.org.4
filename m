Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C725665323
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjAKFEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjAKFDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:03:36 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CE9DF2B;
        Tue, 10 Jan 2023 21:03:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NsFv43zZSz4f3wQd;
        Wed, 11 Jan 2023 13:03:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDX9S8fQ75jGl2gBQ--.10280S9;
        Wed, 11 Jan 2023 13:03:30 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v3 07/14] blk-mq: make blk_mq_commit_rqs a general function for all commits
Date:   Wed, 11 Jan 2023 21:01:52 +0800
Message-Id: <20230111130159.3741753-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX9S8fQ75jGl2gBQ--.10280S9
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyxZw4kWryfCF18AFyUAwb_yoW5ur4kpF
        43Ja1Yy3yrJrsFvas5JanrZF13Gws5KrWUuryftw13XrWFgryxWw4ftryfJFWxtr4kAF13
        ZrW5ur9xGF13GwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU058n7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. rename orignal blk_mq_commit_rqs to blk_mq_plug_commit_rqs as
trace_block_unplug is only needed when we dispatch request from plug list.
We need a commit_rqs wrapper for this case. Besides, this patch
adds queued check and only commits request if any request was queued
to keep commit behavior consistent and remove unnecessary commit.
2. add new blk_mq_commit_rqs for general commits. Current
blk_mq_commit_rqs will not clear queued as queued clearing is not
wanted generally.
3. document rule for unusual cases which need explicit commit_rqs.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c6cc3feb3b84..98f6003474f2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2007,6 +2007,29 @@ static void blk_mq_release_budgets(struct request_queue *q,
 	}
 }
 
+/* blk_mq_commit_rqs and blk_mq_plug_commit_rqs notify driver using
+ * bd->last that there is no more requests. (See comment in struct
+ * blk_mq_ops for commit_rqs for details)
+ * Attention, we should explicitly call this in unusual cases:
+ *  1) did not queue everything initially scheduled to queue
+ *  2) the last attempt to queue a request failed
+ */
+static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int queued)
+{
+	if (hctx->queue->mq_ops->commit_rqs && queued) {
+		hctx->queue->mq_ops->commit_rqs(hctx);
+	}
+}
+
+static void blk_mq_plug_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued)
+{
+	if (hctx->queue->mq_ops->commit_rqs && *queued) {
+		trace_block_unplug(hctx->queue, *queued, true);
+		hctx->queue->mq_ops->commit_rqs(hctx);
+	}
+	*queued = 0;
+}
+
 /*
  * Returns true if we did some work AND can potentially do more.
  */
@@ -2555,15 +2578,6 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	spin_unlock(&ctx->lock);
 }
 
-static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued)
-{
-	if (hctx->queue->mq_ops->commit_rqs) {
-		trace_block_unplug(hctx->queue, *queued, true);
-		hctx->queue->mq_ops->commit_rqs(hctx);
-	}
-	*queued = 0;
-}
-
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 		unsigned int nr_segs)
 {
@@ -2700,7 +2714,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 
 		if (hctx != rq->mq_hctx) {
 			if (hctx)
-				blk_mq_commit_rqs(hctx, &queued);
+				blk_mq_plug_commit_rqs(hctx, &queued);
 			hctx = rq->mq_hctx;
 		}
 
@@ -2712,7 +2726,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
 			blk_mq_request_bypass_insert(rq, false, true);
-			blk_mq_commit_rqs(hctx, &queued);
+			blk_mq_plug_commit_rqs(hctx, &queued);
 			return;
 		default:
 			blk_mq_end_request(rq, ret);
@@ -2726,7 +2740,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 	 * there was more coming, but that turned out to be a lie.
 	 */
 	if (errors)
-		blk_mq_commit_rqs(hctx, &queued);
+		blk_mq_plug_commit_rqs(hctx, &queued);
 }
 
 static void __blk_mq_flush_plug_list(struct request_queue *q,
-- 
2.30.0

