Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111B865CD08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjADGZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjADGYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:24:24 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C10013D67;
        Tue,  3 Jan 2023 22:24:23 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nn01Z27lZz4f3nG8;
        Wed,  4 Jan 2023 14:24:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbGOG7Vju3lKBA--.23788S13;
        Wed, 04 Jan 2023 14:24:20 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v2 11/13] blk-mq: remove unncessary from_schedule parameter in blk_mq_plug_issue_direct
Date:   Wed,  4 Jan 2023 22:22:57 +0800
Message-Id: <20230104142259.2673013-12-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
References: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbGOG7Vju3lKBA--.23788S13
X-Coremail-Antispam: 1UD129KBjvJXoWxuryUZr1xJw17tr13XFy8uFg_yoW5AryfpF
        WUJa12yrWrXrZ7X3ykAanrZry3Krs3Kryagr1ft34fXrWrKw1fJw45try3ArWIyrs5Cr43
        ur45W3sxJr15GwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
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
index 882c03a3f0aa..696bd4a82b14 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2528,11 +2528,10 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
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
@@ -2661,7 +2660,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	return __blk_mq_try_issue_directly(rq->mq_hctx, rq, true, last);
 }
 
-static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
+static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
 	struct request *rq;
@@ -2673,7 +2672,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 
 		if (hctx != rq->mq_hctx) {
 			if (hctx)
-				blk_mq_commit_rqs(hctx, &queued, from_schedule);
+				blk_mq_commit_rqs(hctx, &queued);
 			hctx = rq->mq_hctx;
 		}
 
@@ -2685,7 +2684,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
 			blk_mq_request_bypass_insert(rq, false, true);
-			blk_mq_commit_rqs(hctx, &queued, from_schedule);
+			blk_mq_commit_rqs(hctx, &queued);
 			return;
 		default:
 			blk_mq_end_request(rq, ret);
@@ -2698,7 +2697,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 	 * there was more coming, but that turned out to be a lie.
 	 */
 	if (ret != BLK_STS_OK)
-		blk_mq_commit_rqs(hctx, &queued, from_schedule);
+		blk_mq_commit_rqs(hctx, &queued);
 }
 
 static void __blk_mq_flush_plug_list(struct request_queue *q,
@@ -2769,7 +2768,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		}
 
 		blk_mq_run_dispatch_ops(q,
-				blk_mq_plug_issue_direct(plug, false));
+				blk_mq_plug_issue_direct(plug));
 		if (rq_list_empty(plug->mq_list))
 			return;
 	}
-- 
2.30.0

