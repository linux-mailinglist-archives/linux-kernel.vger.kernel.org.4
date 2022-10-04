Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1465F4015
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJDJnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJDJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:42:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DFD54C93
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:40:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lt21so2345771ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PhHLVXcjENr+c62plFUE4L75G8J7r4FgJx5wcPd+U/o=;
        b=QXmbjRvlwkGLt1DK4yC8OEelYZDkreUKsi9WsXOMq4dxsynMHA6FdRt+kNxFv84ovI
         qzenSgbATr4dNf2TiDaETivsqS6+KXeZ6MTqxL4DAoOkbMm/E28ef+BErbb1xR+GQc7o
         YAB9UcQ3iy0XHn3OTOXoCNw3NhPEKfTwBZdrcIxyNdOD/3pu+pU8tNOTRSC1EvhIAmkT
         O3Q0ZqGE8d2y31m0bi+ZNu/WLIq5toBgZr9SLo/2ApklCYCMJGkJ/bPrnyfv8kX1ZDWP
         6exIGn+DaQ4GCGwjb54/A5ziI5EYByUwMe0sO5ZFt3B7frFYLvMxpW/1prAUdv8liLFl
         AG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PhHLVXcjENr+c62plFUE4L75G8J7r4FgJx5wcPd+U/o=;
        b=LIowSzr+qAHsaG8TJ/j+UNfu9oRRaae6BmOrnlKtY3Zv3sP/1mLsaWE+j+HR7y1mjG
         +Z6Vgsj61nJi2PdgyKXy+TRn043jkkddHT8y9vYidNvBcOrqe0PTTcR2cv6ZJAjc0WNb
         EryzQgXffbT5+AxENMChcs5QlOaJ4zLehoPd/OYfUBf/jV5ymBvTFswOeTCFPCEmM04t
         0bZHXHLiOyJ7tSd8YndceAJKK8dhmVCKhLSwBuQOv+rg+2JbKeL5R2npqx0YGnMSD80i
         VqnQ+D4QKf9SOTQh8Nk8IqUb2p5LjhdhmDMYwQWwH+18L0+VD6MepNueCg+Y9rjvrc5z
         4npQ==
X-Gm-Message-State: ACrzQf370RhQNMVWg9T2HQzKRZ3FPp6VeJaxMAJlB1oIl+jxuDCGU/lI
        qDCDpa+E67L0TEjIkP4dLhTJ3g==
X-Google-Smtp-Source: AMsMyM4n1QowgTDG0H6KBcDrOVerHiJpI0YeLiyh087cE+KHfccB6y4PC7ePTIDDWap2fXMnZgLGaQ==
X-Received: by 2002:a17:907:743:b0:740:ef93:2ffc with SMTP id xc3-20020a170907074300b00740ef932ffcmr18850227ejb.514.1664876424494;
        Tue, 04 Oct 2022 02:40:24 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906200900b00780f6071b5dsm6774853ejo.188.2022.10.04.02.40.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:40:24 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V3 7/8] block, bfq: inject I/O to underutilized actuators
Date:   Tue,  4 Oct 2022 11:40:09 +0200
Message-Id: <20221004094010.80090-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004094010.80090-1-paolo.valente@linaro.org>
References: <20221004094010.80090-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Zini <davidezini2@gmail.com>

The main service scheme of BFQ for sync I/O is serving one sync
bfq_queue at a time, for a while. In particular, BFQ enforces this
scheme when it deems the latter necessary to boost throughput or
to preserve service guarantees. Unfortunately, when BFQ enforces
this policy, only one actuator at a time gets served for a while,
because each bfq_queue contains I/O only for one actuator. The
other actuators may remain underutilized.

Actually, BFQ may serve (inject) extra I/O, taken from other
bfq_queues, in parallel with that of the in-service queue. This
injection mechanism may provide the ground for dealing also with
the above actuator-underutilization problem. Yet BFQ does not take
the actuator load into account when choosing which queue to pick
extra I/O from. In addition, BFQ may happen to inject extra I/O
only when the in-service queue is temporarily empty.

In view of these facts, this commit extends the
injection mechanism in such a way that the latter:
(1) takes into account also the actuator load;
(2) checks such a load on each dispatch, and injects I/O for an
    underutilized actuator, if there is one and there is I/O for it.

To perform the check in (2), this commit introduces a load
threshold, currently set to 4.  A linear scan of each actuator is
performed, until an actuator is found for which the following two
conditions hold: the load of the actuator is below the threshold,
and there is at least one non-in-service queue that contains I/O
for that actuator. If such a pair (actuator, queue) is found, then
the head request of that queue is returned for dispatch, instead
of the head request of the in-service queue.

We have set the threshold, empirically, to the minimum possible
value for which an actuator is fully utilized, or close to be
fully utilized. By doing so, injected I/O 'steals' as few
drive-queue slots as possibile to the in-service queue. This
reduces as much as possible the probability that the service of
I/O from the in-service bfq_queue gets delayed because of slot
exhaustion, i.e., because all the slots of the drive queue are
filled with I/O injected from other queues (NCQ provides for 32
slots).

This new mechanism also counters actuator underutilization in the
case of asymmetric configurations of bfq_queues. Namely if there
are few bfq_queues containing I/O for some actuators and many
bfq_queues containing I/O for other actuators. Or if the
bfq_queues containing I/O for some actuators have lower weights
than the other bfq_queues.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-cgroup.c  |   2 +-
 block/bfq-iosched.c | 137 +++++++++++++++++++++++++++++++++-----------
 block/bfq-iosched.h |  39 ++++++++++++-
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 141 insertions(+), 39 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 080d9160217b..abaf9cc4b7b2 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -699,7 +699,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_activate_bfqq(bfqd, bfqq);
 	}
 
-	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
+	if (!bfqd->in_service_queue && !bfqd->tot_rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
 	/* release extra ref taken above, bfqq may happen to be freed now */
 	bfq_put_queue(bfqq);
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9203b4604da8..4deb0f6c751e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2249,6 +2249,7 @@ static void bfq_add_request(struct request *rq)
 
 	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
 	bfqq->queued[rq_is_sync(rq)]++;
+
 	/*
 	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', however, it
 	 * may be read without holding the lock in bfq_has_work().
@@ -2294,9 +2295,9 @@ static void bfq_add_request(struct request *rq)
 		 *   elapsed.
 		 */
 		if (bfqq == bfqd->in_service_queue &&
-		    (bfqd->rq_in_driver == 0 ||
+		    (bfqd->tot_rq_in_driver == 0 ||
 		     (bfqq->last_serv_time_ns > 0 &&
-		      bfqd->rqs_injected && bfqd->rq_in_driver > 0)) &&
+		      bfqd->rqs_injected && bfqd->tot_rq_in_driver > 0)) &&
 		    time_is_before_eq_jiffies(bfqq->decrease_time_jif +
 					      msecs_to_jiffies(10))) {
 			bfqd->last_empty_occupied_ns = ktime_get_ns();
@@ -2320,7 +2321,7 @@ static void bfq_add_request(struct request *rq)
 			 * will be set in case injection is performed
 			 * on bfqq before rq is completed).
 			 */
-			if (bfqd->rq_in_driver == 0)
+			if (bfqd->tot_rq_in_driver == 0)
 				bfqd->rqs_injected = false;
 		}
 	}
@@ -2418,15 +2419,18 @@ static sector_t get_sdist(sector_t last_pos, struct request *rq)
 static void bfq_activate_request(struct request_queue *q, struct request *rq)
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
+	unsigned int act_idx = bfq_actuator_index(bfqd, rq->bio);
 
-	bfqd->rq_in_driver++;
+	bfqd->tot_rq_in_driver++;
+	bfqd->rq_in_driver[act_idx]++;
 }
 
 static void bfq_deactivate_request(struct request_queue *q, struct request *rq)
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 
-	bfqd->rq_in_driver--;
+	bfqd->tot_rq_in_driver--;
+	bfqd->rq_in_driver[bfq_actuator_index(bfqd, rq->bio)]--;
 }
 #endif
 
@@ -2700,11 +2704,14 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 static void bfq_end_wr(struct bfq_data *bfqd)
 {
 	struct bfq_queue *bfqq;
+	int i;
 
 	spin_lock_irq(&bfqd->lock);
 
-	list_for_each_entry(bfqq, &bfqd->active_list, bfqq_list)
-		bfq_bfqq_end_wr(bfqq);
+	for (i = 0; i < bfqd->num_ia_ranges; i++) {
+		list_for_each_entry(bfqq, &bfqd->active_list[i], bfqq_list)
+			bfq_bfqq_end_wr(bfqq);
+	}
 	list_for_each_entry(bfqq, &bfqd->idle_list, bfqq_list)
 		bfq_bfqq_end_wr(bfqq);
 	bfq_end_wr_async(bfqd);
@@ -3639,13 +3646,13 @@ static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
 	 * - start a new observation interval with this dispatch
 	 */
 	if (now_ns - bfqd->last_dispatch > 100*NSEC_PER_MSEC &&
-	    bfqd->rq_in_driver == 0)
+	    bfqd->tot_rq_in_driver == 0)
 		goto update_rate_and_reset;
 
 	/* Update sampling information */
 	bfqd->peak_rate_samples++;
 
-	if ((bfqd->rq_in_driver > 0 ||
+	if ((bfqd->tot_rq_in_driver > 0 ||
 		now_ns - bfqd->last_completion < BFQ_MIN_TT)
 	    && !BFQ_RQ_SEEKY(bfqd, bfqd->last_position, rq))
 		bfqd->sequential_samples++;
@@ -3912,7 +3919,7 @@ static bool idling_needed_for_service_guarantees(struct bfq_data *bfqd,
 	return (bfqq->wr_coeff > 1 &&
 		(bfqd->wr_busy_queues <
 		 tot_busy_queues ||
-		 bfqd->rq_in_driver >=
+		 bfqd->tot_rq_in_driver >=
 		 bfqq->dispatched + 4)) ||
 		bfq_asymmetric_scenario(bfqd, bfqq) ||
 		tot_busy_queues == 1;
@@ -4684,6 +4691,7 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 {
 	struct bfq_queue *bfqq, *in_serv_bfqq = bfqd->in_service_queue;
 	unsigned int limit = in_serv_bfqq->inject_limit;
+	int i;
 	/*
 	 * If
 	 * - bfqq is not weight-raised and therefore does not carry
@@ -4715,7 +4723,7 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 		)
 		limit = 1;
 
-	if (bfqd->rq_in_driver >= limit)
+	if (bfqd->tot_rq_in_driver >= limit)
 		return NULL;
 
 	/*
@@ -4730,11 +4738,12 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 	 *   (and re-added only if it gets new requests, but then it
 	 *   is assigned again enough budget for its new backlog).
 	 */
-	list_for_each_entry(bfqq, &bfqd->active_list, bfqq_list)
-		if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
-		    (in_serv_always_inject || bfqq->wr_coeff > 1) &&
-		    bfq_serv_to_charge(bfqq->next_rq, bfqq) <=
-		    bfq_bfqq_budget_left(bfqq)) {
+	for (i = 0; i < bfqd->num_ia_ranges; i++) {
+		list_for_each_entry(bfqq, &bfqd->active_list[i], bfqq_list)
+			if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
+				(in_serv_always_inject || bfqq->wr_coeff > 1) &&
+				bfq_serv_to_charge(bfqq->next_rq, bfqq) <=
+				bfq_bfqq_budget_left(bfqq)) {
 			/*
 			 * Allow for only one large in-flight request
 			 * on non-rotational devices, for the
@@ -4759,22 +4768,67 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 			else
 				limit = in_serv_bfqq->inject_limit;
 
-			if (bfqd->rq_in_driver < limit) {
+			if (bfqd->tot_rq_in_driver < limit) {
 				bfqd->rqs_injected = true;
 				return bfqq;
 			}
 		}
+	}
+
+	return NULL;
+}
+
+struct bfq_queue *bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd,
+						    int idx)
+{
+	struct bfq_queue *bfqq = NULL;
+
+	if (bfqd->in_service_queue &&
+	    bfqd->in_service_queue->actuator_idx == idx)
+		return bfqd->in_service_queue;
+
+	list_for_each_entry(bfqq, &bfqd->active_list[idx], bfqq_list) {
+		if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
+			bfq_serv_to_charge(bfqq->next_rq, bfqq) <=
+				bfq_bfqq_budget_left(bfqq)) {
+			return bfqq;
+		}
+	}
+
+	return NULL;
+}
+
+/*
+ * Perform a linear scan of each actuator, until an actuator is found
+ * for which the following two conditions hold: the load of the
+ * actuator is below the threshold (see comments on actuator_load_threshold
+ * for details), and there is a queue that contains I/O for that
+ * actuator. On success, return that queue.
+ */
+struct bfq_queue *bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
+{
+	int i;
+
+	for (i = 0 ; i < bfqd->num_ia_ranges; i++)
+		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
+			struct bfq_queue *bfqq =
+				bfq_find_active_bfqq_for_actuator(bfqd, i);
+
+			if (bfqq)
+				return bfqq;
+		}
 
 	return NULL;
 }
 
+
 /*
  * Select a queue for service.  If we have a current queue in service,
  * check whether to continue servicing it, or retrieve and set a new one.
  */
 static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 {
-	struct bfq_queue *bfqq;
+	struct bfq_queue *bfqq, *inject_bfqq;
 	struct request *next_rq;
 	enum bfqq_expiration reason = BFQQE_BUDGET_TIMEOUT;
 
@@ -4796,6 +4850,15 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		goto expire;
 
 check_queue:
+	/*
+	 *  If some actuator is underutilized, but the in-service
+	 *  queue does not contain I/O for that actuator, then try to
+	 *  inject I/O for that actuator.
+	 */
+	inject_bfqq = bfq_find_bfqq_for_underused_actuator(bfqd);
+	if (inject_bfqq && inject_bfqq != bfqq)
+		return inject_bfqq;
+
 	/*
 	 * This loop is rarely executed more than once. Even when it
 	 * happens, it is much more convenient to re-execute this loop
@@ -5151,11 +5214,11 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 
 		/*
 		 * We exploit the bfq_finish_requeue_request hook to
-		 * decrement rq_in_driver, but
+		 * decrement tot_rq_in_driver, but
 		 * bfq_finish_requeue_request will not be invoked on
 		 * this request. So, to avoid unbalance, just start
-		 * this request, without incrementing rq_in_driver. As
-		 * a negative consequence, rq_in_driver is deceptively
+		 * this request, without incrementing tot_rq_in_driver. As
+		 * a negative consequence, tot_rq_in_driver is deceptively
 		 * lower than it should be while this request is in
 		 * service. This may cause bfq_schedule_dispatch to be
 		 * invoked uselessly.
@@ -5164,7 +5227,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 		 * bfq_finish_requeue_request hook, if defined, is
 		 * probably invoked also on this request. So, by
 		 * exploiting this hook, we could 1) increment
-		 * rq_in_driver here, and 2) decrement it in
+		 * tot_rq_in_driver here, and 2) decrement it in
 		 * bfq_finish_requeue_request. Such a solution would
 		 * let the value of the counter be always accurate,
 		 * but it would entail using an extra interface
@@ -5193,7 +5256,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	 * Of course, serving one request at a time may cause loss of
 	 * throughput.
 	 */
-	if (bfqd->strict_guarantees && bfqd->rq_in_driver > 0)
+	if (bfqd->strict_guarantees && bfqd->tot_rq_in_driver > 0)
 		goto exit;
 
 	bfqq = bfq_select_queue(bfqd);
@@ -5204,7 +5267,8 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 
 	if (rq) {
 inc_in_driver_start_rq:
-		bfqd->rq_in_driver++;
+		bfqd->rq_in_driver[bfqq->actuator_idx]++;
+		bfqd->tot_rq_in_driver++;
 start_rq:
 		rq->rq_flags |= RQF_STARTED;
 	}
@@ -6266,7 +6330,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	struct bfq_queue *bfqq = bfqd->in_service_queue;
 
 	bfqd->max_rq_in_driver = max_t(int, bfqd->max_rq_in_driver,
-				       bfqd->rq_in_driver);
+				       bfqd->tot_rq_in_driver);
 
 	if (bfqd->hw_tag == 1)
 		return;
@@ -6277,7 +6341,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	 * sum is not exact, as it's not taking into account deactivated
 	 * requests.
 	 */
-	if (bfqd->rq_in_driver + bfqd->queued <= BFQ_HW_QUEUE_THRESHOLD)
+	if (bfqd->tot_rq_in_driver + bfqd->queued <= BFQ_HW_QUEUE_THRESHOLD)
 		return;
 
 	/*
@@ -6288,7 +6352,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	if (bfqq && bfq_bfqq_has_short_ttime(bfqq) &&
 	    bfqq->dispatched + bfqq->queued[0] + bfqq->queued[1] <
 	    BFQ_HW_QUEUE_THRESHOLD &&
-	    bfqd->rq_in_driver < BFQ_HW_QUEUE_THRESHOLD)
+	    bfqd->tot_rq_in_driver < BFQ_HW_QUEUE_THRESHOLD)
 		return;
 
 	if (bfqd->hw_tag_samples++ < BFQ_HW_QUEUE_SAMPLES)
@@ -6309,7 +6373,8 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 
 	bfq_update_hw_tag(bfqd);
 
-	bfqd->rq_in_driver--;
+	bfqd->rq_in_driver[bfqq->actuator_idx]--;
+	bfqd->tot_rq_in_driver--;
 	bfqq->dispatched--;
 
 	if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq)) {
@@ -6428,7 +6493,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 					BFQQE_NO_MORE_REQUESTS);
 	}
 
-	if (!bfqd->rq_in_driver)
+	if (!bfqd->tot_rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
 }
 
@@ -6559,13 +6624,13 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 	 * conditions to do it, or we can lower the last base value
 	 * computed.
 	 *
-	 * NOTE: (bfqd->rq_in_driver == 1) means that there is no I/O
+	 * NOTE: (bfqd->tot_rq_in_driver == 1) means that there is no I/O
 	 * request in flight, because this function is in the code
 	 * path that handles the completion of a request of bfqq, and,
 	 * in particular, this function is executed before
-	 * bfqd->rq_in_driver is decremented in such a code path.
+	 * bfqd->tot_rq_in_driver is decremented in such a code path.
 	 */
-	if ((bfqq->last_serv_time_ns == 0 && bfqd->rq_in_driver == 1) ||
+	if ((bfqq->last_serv_time_ns == 0 && bfqd->tot_rq_in_driver == 1) ||
 	    tot_time_ns < bfqq->last_serv_time_ns) {
 		if (bfqq->last_serv_time_ns == 0) {
 			/*
@@ -6575,7 +6640,7 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 			bfqq->inject_limit = max_t(unsigned int, 1, old_limit);
 		}
 		bfqq->last_serv_time_ns = tot_time_ns;
-	} else if (!bfqd->rqs_injected && bfqd->rq_in_driver == 1)
+	} else if (!bfqd->rqs_injected && bfqd->tot_rq_in_driver == 1)
 		/*
 		 * No I/O injected and no request still in service in
 		 * the drive: these are the exact conditions for
@@ -7212,7 +7277,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->queue_weights_tree = RB_ROOT_CACHED;
 	bfqd->num_groups_with_pending_reqs = 0;
 
-	INIT_LIST_HEAD(&bfqd->active_list);
+	INIT_LIST_HEAD(&bfqd->active_list[0]);
+	INIT_LIST_HEAD(&bfqd->active_list[1]);
 	INIT_LIST_HEAD(&bfqd->idle_list);
 	INIT_HLIST_HEAD(&bfqd->burst_list);
 
@@ -7257,6 +7323,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 		ref_wr_duration[blk_queue_nonrot(bfqd->queue)];
 	bfqd->peak_rate = ref_rate[blk_queue_nonrot(bfqd->queue)] * 2 / 3;
 
+	/* see comments on the definition of next field inside bfq_data */
+	bfqd->actuator_load_threshold = 4;
+
 	spin_lock_init(&bfqd->lock);
 
 	/*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 34f7603bb62f..1585f2b827a6 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -578,7 +578,12 @@ struct bfq_data {
 	/* number of queued requests */
 	int queued;
 	/* number of requests dispatched and waiting for completion */
-	int rq_in_driver;
+	int tot_rq_in_driver;
+	/*
+	 * number of requests dispatched and waiting for completion
+	 * for each actuator
+	 */
+	int rq_in_driver[BFQ_MAX_ACTUATORS];
 
 	/* true if the device is non rotational and performs queueing */
 	bool nonrot_with_queueing;
@@ -672,8 +677,13 @@ struct bfq_data {
 	/* maximum budget allotted to a bfq_queue before rescheduling */
 	int bfq_max_budget;
 
-	/* list of all the bfq_queues active on the device */
-	struct list_head active_list;
+	/*
+	 * List of all the bfq_queues active for a specific actuator
+	 * on the device. Keeping active queues separate on a
+	 * per-actuator basis helps implementing per-actuator
+	 * injection more efficiently.
+	 */
+	struct list_head active_list[BFQ_MAX_ACTUATORS];
 	/* list of all the bfq_queues idle on the device */
 	struct list_head idle_list;
 
@@ -808,6 +818,29 @@ struct bfq_data {
 	 * in this device.
 	 */
 	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];
+
+	/*
+	 * If the number of I/O requests queued in the device for a
+	 * given actuator is below next threshold, then the actuator
+	 * is deemed as underutilized. If this condition is found to
+	 * hold for some actuator upon a dispatch, but (i) the
+	 * in-service queue does not contain I/O for that actuator,
+	 * while (ii) some other queue does contain I/O for that
+	 * actuator, then the head I/O request of the latter queue is
+	 * returned (injected), instead of the head request of the
+	 * currently in-service queue.
+	 *
+	 * We set the threshold, empirically, to the minimum possible
+	 * value for which an actuator is fully utilized, or close to
+	 * be fully utilized. By doing so, injected I/O 'steals' as
+	 * few drive-queue slots as possibile to the in-service
+	 * queue. This reduces as much as possible the probability
+	 * that the service of I/O from the in-service bfq_queue gets
+	 * delayed because of slot exhaustion, i.e., because all the
+	 * slots of the drive queue are filled with I/O injected from
+	 * other queues (NCQ provides for 32 slots).
+	 */
+	unsigned int actuator_load_threshold;
 };
 
 enum bfqq_state_flags {
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 983413cdefad..fc19f9ba6b9a 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -477,7 +477,7 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 	bfqd = (struct bfq_data *)bfqg->bfqd;
 #endif
 	if (bfqq)
-		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
+		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list[bfqq->actuator_idx]);
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	if (bfqg != bfqd->root_group)
 		bfqg->active_entities++;
-- 
2.20.1

