Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E9C665326
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjAKFEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbjAKFDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:03:37 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809E1DF50;
        Tue, 10 Jan 2023 21:03:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NsFv63x2Tz4f3jQP;
        Wed, 11 Jan 2023 13:03:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDX9S8fQ75jGl2gBQ--.10280S14;
        Wed, 11 Jan 2023 13:03:32 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v3 12/14] blk-mq: remove set of bd->last when get driver tag for next request fails
Date:   Wed, 11 Jan 2023 21:01:57 +0800
Message-Id: <20230111130159.3741753-13-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX9S8fQ75jGl2gBQ--.10280S14
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryrKr17Cr1DAw1rCrWxWFg_yoW8Kr18pF
        W3Ja1akr45XF40gFW8AwsrWr45Jw4DArWayrsI934Sqrn0krs7KFy8J3y8ZFySvrWkCrsI
        gr1qgryDZr48XFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUxD7aUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 113285b473824 ("blk-mq: ensure that bd->last is always set
correctly") will set last if we failed to get driver tag for next
request to avoid flush miss as we break the list walk and will not
send the last request in the list which will be sent with last set
normally.
This code seems stale now becase the flush introduced is always
redundant as:
For case tag is really out, we will send a extra flush if we find
list is not empty after list walk.
For case some tag is freed before retry in blk_mq_prep_dispatch_rq for
next, then we can get a tag for next request in retry and flush notified
already is not necessary.

Just remove these stale codes.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b2133af1c846..1b66a5169be2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1923,16 +1923,6 @@ static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
 static void blk_mq_handle_dev_resource(struct request *rq,
 				       struct list_head *list)
 {
-	struct request *next =
-		list_first_entry_or_null(list, struct request, queuelist);
-
-	/*
-	 * If an I/O scheduler has been configured and we got a driver tag for
-	 * the next request already, free it.
-	 */
-	if (next)
-		blk_mq_put_driver_tag(next);
-
 	list_add(&rq->queuelist, list);
 	__blk_mq_requeue_request(rq);
 }
@@ -2038,7 +2028,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 {
 	enum prep_dispatch prep;
 	struct request_queue *q = hctx->queue;
-	struct request *rq, *nxt;
+	struct request *rq;
 	int queued;
 	blk_status_t ret = BLK_STS_OK;
 	LIST_HEAD(zone_list);
@@ -2064,17 +2054,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		list_del_init(&rq->queuelist);
 
 		bd.rq = rq;
-
-		/*
-		 * Flag last if we have no more requests, or if we have more
-		 * but can't assign a driver tag to it.
-		 */
-		if (list_empty(list))
-			bd.last = true;
-		else {
-			nxt = list_first_entry(list, struct request, queuelist);
-			bd.last = !blk_mq_get_driver_tag(nxt);
-		}
+		bd.last = list_empty(list);
 
 		/*
 		 * once the request is queued to lld, no need to cover the
-- 
2.30.0

