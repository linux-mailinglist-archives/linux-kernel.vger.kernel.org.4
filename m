Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7581066BF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjAPNOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjAPNOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:14:21 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA03A92;
        Mon, 16 Jan 2023 05:11:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NwX3w599Pz4f43Lr;
        Mon, 16 Jan 2023 20:52:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7uuMSMVjYH02Bw--.361S7;
        Mon, 16 Jan 2023 20:52:31 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.cz, axboe@kernel.dk
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huaweicloud.com
Subject: [PATCH v3 5/5] sbitmap: correct wake_batch recalculation to avoid potential IO hung
Date:   Tue, 17 Jan 2023 04:50:59 +0800
Message-Id: <20230116205059.3821738-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230116205059.3821738-1-shikemeng@huaweicloud.com>
References: <20230116205059.3821738-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7uuMSMVjYH02Bw--.361S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fAF4rAw4xWr47KFy8Krg_yoW8tFy3p3
        yrt3ZrGrnYyrWSkrZrJr4UAF12v3yktwnxGF4Sv3yrAw15GFna9r4FgFZxXw1IvFs5GF45
        A343GrZ5GayUZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/sbitmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 2514e7a3f6ca..eff4e42c425a 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -457,13 +457,10 @@ void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
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

