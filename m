Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF1B654C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbiLWEyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiLWExg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:53:36 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E51F2C2;
        Thu, 22 Dec 2022 20:53:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NdZZL2Cylz4f3p5Z;
        Fri, 23 Dec 2022 12:53:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXjbFHNKVjpOduAQ--.93S13;
        Fri, 23 Dec 2022 12:53:33 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, john.garry@huawei.com, shikemeng@huaweicloud.com
Subject: [PATCH 11/13] blk-mq: remove unncessary from_schedule parameter in blk_mq_plug_issue_direct
Date:   Fri, 23 Dec 2022 20:52:21 +0800
Message-Id: <20221223125223.1687670-12-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221223125223.1687670-1-shikemeng@huaweicloud.com>
References: <20221223125223.1687670-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXjbFHNKVjpOduAQ--.93S13
X-Coremail-Antispam: 1UD129KBjvJXoWxur4kCFWxKr1DWFyUWFy3Jwb_yoW5AryfpF
        WUJa12yrWrXrZ7XaykAanrZryakrs3Kry2gry3t34fXrW5Kw1fJw45try3ArWIyrs5Ar43
        ur45W3sxJr13GwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRv
        JPtUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function blk_mq_plug_issue_direct tries to issue batch requests in plug
list to driver directly. We will only issue plug request to driver if we
are not from scheduler, so from_scheduler parameter of
blk_mq_plug_issue_direct is always false, so as the blk_mq_commit_rqs
which is only called in blk_mq_plug_issue_direct.
Remove unncessary from_scheduler of blk_mq_plug_issue_direct and
blk_mq_commit_rqs.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 452f2e0fba05..a48f2a913295 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2527,11 +2527,10 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	spin_unlock(&ctx->lock);
 }
 
-static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued,
-			      bool from_schedule)
+static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued)
 {
 	if (hctx->queue->mq_ops->commit_rqs) {
-		trace_block_unplug(hctx->queue, *queued, !from_schedule);
+		trace_block_unplug(hctx->queue, *queued, true);
 		hctx->queue->mq_ops->commit_rqs(hctx);
 	}
 	*queued = 0;
@@ -2660,7 +2659,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	return __blk_mq_try_issue_directly(rq->mq_hctx, rq, true, last);
 }
 
-static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
+static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
 	struct request *rq;
@@ -2672,7 +2671,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 
 		if (hctx != rq->mq_hctx) {
 			if (hctx)
-				blk_mq_commit_rqs(hctx, &queued, from_schedule);
+				blk_mq_commit_rqs(hctx, &queued);
 			hctx = rq->mq_hctx;
 		}
 
@@ -2684,7 +2683,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
 			blk_mq_request_bypass_insert(rq, false, true);
-			blk_mq_commit_rqs(hctx, &queued, from_schedule);
+			blk_mq_commit_rqs(hctx, &queued);
 			return;
 		default:
 			blk_mq_end_request(rq, ret);
@@ -2697,7 +2696,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 	 * there was more coming, but that turned out to be a lie.
 	 */
 	if (ret != BLK_STS_OK)
-		blk_mq_commit_rqs(hctx, &queued, from_schedule);
+		blk_mq_commit_rqs(hctx, &queued);
 }
 
 static void __blk_mq_flush_plug_list(struct request_queue *q,
@@ -2768,7 +2767,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		}
 
 		blk_mq_run_dispatch_ops(q,
-				blk_mq_plug_issue_direct(plug, false));
+				blk_mq_plug_issue_direct(plug));
 		if (rq_list_empty(plug->mq_list))
 			return;
 	}
-- 
2.30.0

