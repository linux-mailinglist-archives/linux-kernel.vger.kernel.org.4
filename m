Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D305964DB45
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLOMh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOMhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:37:22 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0073192B4;
        Thu, 15 Dec 2022 04:37:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NXsF80xx5z4f3vfN;
        Thu, 15 Dec 2022 20:37:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDHONb9FJtjOv0bCQ--.50238S9;
        Thu, 15 Dec 2022 20:37:19 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: [PATCH v2 5/5] sbitmap: correct wake_batch recalculation to avoid potential IO hung
Date:   Fri, 16 Dec 2022 04:36:21 +0800
Message-Id: <20221215203621.3572458-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221215203621.3572458-1-shikemeng@huaweicloud.com>
References: <20221215203621.3572458-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHONb9FJtjOv0bCQ--.50238S9
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fAF4rAw4xWr47KFy8Krg_yoW8trWrp3
        y8tFnrGr4vyrWSkrZrJr48AF1avayktwnxGF4Sv3yFyw15GFsa9r4FgFZxXw1IvF4rGF45
        A343GrZ8GayUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIVyIUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 180dccb0dba4f ("blk-mq: fix tag_get wait task can't be awakened")
mentioned that in case of shared tags, there could be just one real
active hctx(queue) because of lazy detection of tag idle. Then driver tag
allocation may wait forever on this real active hctx(queue) if wake_batch
is > hctx_max_depth where hctx_max_depth is available tags depth for the
actve hctx(queue). However, the condition wake_batch > hctx_max_depth is
not strong enough to avoid IO hung as the sbitmap_queue_wake_up will only
wake up one wait queue for each wake_batch even though there is only one
waiter in the woken wait queue. After this, there is only one tag to free
and wake_batch may not be reached anymore. Commit 180dccb0dba4f ("blk-mq:
fix tag_get wait task can't be awakened") methioned that driver tag
allocation may wait forever. Actually, the inactive hctx(queue) will be
truely idle after at most 30 seconds and will call blk_mq_tag_wakeup_all
to wake one waiter per wait queue to break the hung. But IO hung for 30
seconds is also not acceptable. Set batch size to small enough that depth
of the shared hctx(queue) is enough to wake up all of the queues like
sbq_calc_wake_batch do to fix this potential IO hung.

Although hctx_max_depth will be clamped to at least 4 while wake_batch
recalculation does not do the clamp, the wake_batch will be always
recalculated to 1 when hctx_max_depth <= 4.

Fixes: 180dccb0dba4 ("blk-mq: fix tag_get wait task can't be awakened")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/sbitmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index b6d3bb1c3675..804fe99783e4 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -458,13 +458,10 @@ void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
 					    unsigned int users)
 {
 	unsigned int wake_batch;
-	unsigned int min_batch;
 	unsigned int depth = (sbq->sb.depth + users - 1) / users;
 
-	min_batch = sbq->sb.depth >= (4 * SBQ_WAIT_QUEUES) ? 4 : 1;
-
 	wake_batch = clamp_val(depth / SBQ_WAIT_QUEUES,
-			min_batch, SBQ_WAKE_BATCH);
+			1, SBQ_WAKE_BATCH);
 
 	WRITE_ONCE(sbq->wake_batch, wake_batch);
 }
-- 
2.30.0

