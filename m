Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AF6146D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiKAJfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiKAJec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7206118E25;
        Tue,  1 Nov 2022 02:34:27 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1lBQ10wBzpW50;
        Tue,  1 Nov 2022 17:30:54 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:25 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 10/20] block, bfq: define and use soft_rt, in_burst and wr_or_deserves_wr only low_latency is enable
Date:   Tue, 1 Nov 2022 17:34:07 +0800
Message-ID: <20221101093417.10540-11-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221101093417.10540-1-shikemeng@huawei.com>
References: <20221101093417.10540-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 77 ++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8f6d05258f22..0ecb3640d715 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1822,8 +1822,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 					     struct request *rq,
 					     bool *interactive)
 {
-	bool soft_rt, in_burst,	wr_or_deserves_wr,
-		bfqq_wants_to_preempt,
+	bool bfqq_wants_to_preempt,
 		idle_for_long_time = bfq_bfqq_idle_for_long_time(bfqd, bfqq),
 		/*
 		 * See the comments on
@@ -1834,43 +1833,6 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 			bfqq->ttime.last_end_request +
 			bfqd->bfq_slice_idle * 3;
 
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
-		 (bfq_bfqq_sync(bfqq) &&
-		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
-		   (*interactive || soft_rt)));
-
 	/*
 	 * Using the last flag, update budget and check whether bfqq
 	 * may want to preempt the in-service queue.
@@ -1904,6 +1866,20 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	bfq_clear_bfqq_just_created(bfqq);
 
 	if (bfqd->low_latency) {
+		bool soft_rt, in_burst,	wr_or_deserves_wr;
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
@@ -1911,6 +1887,29 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 
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
+					(bfq_bfqq_sync(bfqq) &&
+					 (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
+					 (*interactive || soft_rt)));
+
 			bfq_update_bfqq_wr_on_rq_arrival(bfqd, bfqq,
 							 old_wr_coeff,
 							 wr_or_deserves_wr,
-- 
2.30.0

