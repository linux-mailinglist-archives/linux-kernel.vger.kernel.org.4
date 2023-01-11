Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BCB665325
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjAKFEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjAKFDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:03:37 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163B9DF4B;
        Tue, 10 Jan 2023 21:03:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NsFv52qnjz4f3v5L;
        Wed, 11 Jan 2023 13:03:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDX9S8fQ75jGl2gBQ--.10280S11;
        Wed, 11 Jan 2023 13:03:31 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v3 09/14] blk-mq: use blk_mq_commit_rqs helper in blk_mq_try_issue_list_directly
Date:   Wed, 11 Jan 2023 21:01:54 +0800
Message-Id: <20230111130159.3741753-10-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX9S8fQ75jGl2gBQ--.10280S11
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfJryDGFyUGF1UKr4fuFg_yoW8Aw1rpF
        W3Ganxtr4Sqr4xZFykAay7ZFy7Jrs8Kry7Xryakw1aqrWUCrW0gFsxtr1xXFyrtFWkAa13
        XFyDWr98tF4UWwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Call blk_mq_commit_rqs instead of access ->commit_rqs directly. As you
can see in comment of blk_mq_commit_rqs, we only need explicitly call
this in two cases:
 -did not queue everything initially scheduled to queue
 -the last attempt to queue a request failed
Both cases can be checked with ret of last request which breaks list
walk. Then we can remove unnecessary error count and unnecessary
commit triggered by error besides cases described above.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c6c84f44c7a6..f45d81e20d9e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2819,17 +2819,15 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
 	int queued = 0;
-	int errors = 0;
+	blk_status_t ret;
 
 	while (!list_empty(list)) {
-		blk_status_t ret;
 		struct request *rq = list_first_entry(list, struct request,
 				queuelist);
 
 		list_del_init(&rq->queuelist);
 		ret = blk_mq_request_issue_directly(rq, list_empty(list));
 		if (ret != BLK_STS_OK) {
-			errors++;
 			if (ret == BLK_STS_RESOURCE ||
 					ret == BLK_STS_DEV_RESOURCE) {
 				blk_mq_request_bypass_insert(rq, false,
@@ -2841,13 +2839,8 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 			queued++;
 	}
 
-	/*
-	 * If we didn't flush the entire list, we could have told
-	 * the driver there was more coming, but that turned out to
-	 * be a lie.
-	 */
-	if (errors && hctx->queue->mq_ops->commit_rqs && queued)
-		hctx->queue->mq_ops->commit_rqs(hctx);
+	if (ret != BLK_STS_OK)
+		blk_mq_commit_rqs(hctx, queued);
 }
 
 static bool blk_mq_attempt_bio_merge(struct request_queue *q,
-- 
2.30.0

