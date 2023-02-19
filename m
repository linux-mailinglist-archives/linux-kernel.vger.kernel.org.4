Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5542869BE42
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 03:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBSCl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 21:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBSCl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 21:41:29 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887BA11EA1;
        Sat, 18 Feb 2023 18:41:28 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PK8v76Vpwz4f3pC9;
        Sun, 19 Feb 2023 10:41:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7utQjPFjPmleDw--.7604S14;
        Sun, 19 Feb 2023 10:41:25 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 12/17] block, bfq: define and use soft_rt, in_burst and wr_or_deserves_wr only low_latency is enable
Date:   Sun, 19 Feb 2023 18:43:04 +0800
Message-Id: <20230219104309.1511562-13-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
References: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7utQjPFjPmleDw--.7604S14
X-Coremail-Antispam: 1UD129KBjvJXoW3WrW7CFW7Cw18ZF4DWry8Krg_yoW7XrWDpF
        WagFy3tr43JF4fZrW3Kw48Xr1Sv3WfGFWIkFZ0q34kAF1UCrn2qFyqyr1Fvas7ur9xCr43
        XrWqqa97CF1kAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
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

The soft_rt, in_burst and wr_or_deserves_wr are only used when low_latency
is enable. Currently, these variables are computed even low_latency is
disable. Define these variables in successful branch of bfqd->low_latency
check and compute them if needed to remove redundant computation and
improve readability.
The interactive parameter will be used only if low_latency is enabled
outside bfq_bfqq_handle_idle_busy_switch, so it's safe to move
interactive assignment inside branch where low_latency is true.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 81 +++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a8cb0a0d36f3..eda6669d0571 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1828,8 +1828,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 					     struct request *rq,
 					     bool *interactive)
 {
-	bool soft_rt, in_burst,	wr_or_deserves_wr,
-		bfqq_wants_to_preempt,
+	bool bfqq_wants_to_preempt,
 		idle_for_long_time = bfq_bfqq_idle_for_long_time(bfqd, bfqq),
 		/*
 		 * See the comments on
@@ -1840,43 +1839,6 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 			bfqq->ttime.last_end_request +
 			bfqd->bfq_slice_idle * 3;
 	unsigned int act_idx = bfq_actuator_index(bfqd, rq->bio);
-	bool bfqq_non_merged_or_stably_merged =
-		bfqq->bic || RQ_BIC(rq)->bfqq_data[act_idx].stably_merged;
-
-	/*
-	 * bfqq deserves to be weight-raised if:
-	 * - it is sync,
-	 * - it does not belong to a large burst,
-	 * - it has been idle for enough time or is soft real-time,
-	 * - is linked to a bfq_io_cq (it is not shared in any sense),
-	 * - has a default weight (otherwise we assume the user wanted
-	 *   to control its weight explicitly)
-	 */
-	in_burst = bfq_bfqq_in_large_burst(bfqq);
-	soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
-		!BFQQ_TOTALLY_SEEKY(bfqq) &&
-		!in_burst &&
-		time_is_before_jiffies(bfqq->soft_rt_next_start) &&
-		bfqq->dispatched == 0 &&
-		bfqq->entity.new_weight == 40;
-	*interactive = !in_burst && idle_for_long_time &&
-		bfqq->entity.new_weight == 40;
-	/*
-	 * Merged bfq_queues are kept out of weight-raising
-	 * (low-latency) mechanisms. The reason is that these queues
-	 * are usually created for non-interactive and
-	 * non-soft-real-time tasks. Yet this is not the case for
-	 * stably-merged queues. These queues are merged just because
-	 * they are created shortly after each other. So they may
-	 * easily serve the I/O of an interactive or soft-real time
-	 * application, if the application happens to spawn multiple
-	 * processes. So let also stably-merged queued enjoy weight
-	 * raising.
-	 */
-	wr_or_deserves_wr = bfqd->low_latency &&
-		(bfqq->wr_coeff > 1 ||
-		 (bfq_bfqq_sync(bfqq) && bfqq_non_merged_or_stably_merged &&
-		  (*interactive || soft_rt)));
 
 	/*
 	 * Using the last flag, update budget and check whether bfqq
@@ -1911,6 +1873,24 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	bfq_clear_bfqq_just_created(bfqq);
 
 	if (bfqd->low_latency) {
+		bool soft_rt, in_burst,	wr_or_deserves_wr;
+		bool bfqq_non_merged_or_stably_merged =
+			bfqq->bic ||
+			RQ_BIC(rq)->bfqq_data[act_idx].stably_merged;
+
+		/*
+		 * bfqq deserves to be weight-raised if:
+		 * - it is sync,
+		 * - it does not belong to a large burst,
+		 * - it has been idle for enough time or is soft real-time,
+		 * - is linked to a bfq_io_cq (it is not shared in any sense),
+		 * - has a default weight (otherwise we assume the user wanted
+		 *   to control its weight explicitly)
+		 */
+		in_burst = bfq_bfqq_in_large_burst(bfqq);
+		*interactive = !in_burst && idle_for_long_time &&
+			bfqq->entity.new_weight == 40;
+
 		if (unlikely(time_is_after_jiffies(bfqq->split_time)))
 			/* wraparound */
 			bfqq->split_time =
@@ -1918,6 +1898,29 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 
 		if (time_is_before_jiffies(bfqq->split_time +
 					   bfqd->bfq_wr_min_idle_time)) {
+			soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
+				!BFQQ_TOTALLY_SEEKY(bfqq) &&
+				!in_burst &&
+				time_is_before_jiffies(bfqq->soft_rt_next_start) &&
+				bfqq->dispatched == 0 &&
+				bfqq->entity.new_weight == 40;
+			/*
+			 * Merged bfq_queues are kept out of weight-raising
+			 * (low-latency) mechanisms. The reason is that these queues
+			 * are usually created for non-interactive and
+			 * non-soft-real-time tasks. Yet this is not the case for
+			 * stably-merged queues. These queues are merged just because
+			 * they are created shortly after each other. So they may
+			 * easily serve the I/O of an interactive or soft-real time
+			 * application, if the application happens to spawn multiple
+			 * processes. So let also stably-merged queued enjoy weight
+			 * raising.
+			 */
+			wr_or_deserves_wr = (bfqq->wr_coeff > 1 ||
+				(bfq_bfqq_sync(bfqq) &&
+				bfqq_non_merged_or_stably_merged &&
+				(*interactive || soft_rt)));
+
 			bfq_update_bfqq_wr_on_rq_arrival(bfqd, bfqq,
 							 old_wr_coeff,
 							 wr_or_deserves_wr,
-- 
2.30.0

