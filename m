Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B465E651E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiLTJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiLTJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:50:31 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DBF16498
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:50:29 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so27914409ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oM/2vJGiY2u/89J5VcnMUtDZgqlnKuz0nC3Sbo2L+8=;
        b=UA98Yy6ZTJarKzvISSRu3ZSmITKKDvmdVB1cTlYQwZsPT8KB7aXLle6qqFl02MzSAt
         MvO/e+sTJFpvj/eIleKj8azRYC35NLZ5AJ3wHsKCxvVznc1rP5cmtJUkPswzNR3oTVku
         jtxmZfo+rEXVmkefL8tlQSMwJ8STn7J3ToaPfYEXwcvXUCMBt/EY8vbNg6aZczG1Tla5
         HSiXNYx81Zl5zxQL9Q55fmot1e7QH5Ob6C4n+FGM8uqT73k+ZJzJYtKnNJUCLJWugHmU
         sfYpAZGy67k1Po7in+JB1Sgvixoqnu28ZBRwqhnLbtmvUOgYZ6UzSnrBd5fiixFUvvOx
         BHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oM/2vJGiY2u/89J5VcnMUtDZgqlnKuz0nC3Sbo2L+8=;
        b=W9cTasl+tEsOZ2GTbLMzvP3xCEDYaa5hoSh5gH8wfYqgY8kmJSSgbXrLhmbyQuvWm4
         6gOhOv6yL8BQBWsyrt/ulpw7qx9lqbHyODvj55/Nn43p8DpV0ixUK+Lp5eKRXZRCPUa8
         EueghvhGF4yP3F0y+zhOkuME9hJ0EEeG8CiaMMDWYigkgPFuagKoctbJ2xeTRJpHCAzE
         OAH/SPeIBZ/xFWTfO70/ZbEB45nTw0DrMt1rMlPiMK9M3upD2mgz/W49d0SrnkC41F01
         XkKtoNIJBy6QWM9aoXdIgejxYWzi7V0hshp16PcQMQhdzq7/4J9p7yheQV0JwGR1l1AC
         /Vlw==
X-Gm-Message-State: ANoB5pnwBrKsnDz2WFIIx1gCY/VvG2yLBXOeUVCxNNXRkA4WjO9h2x0m
        +kncGCvF4m6mzl6yG1Y9IN9IpOCLqxLFsOpB
X-Google-Smtp-Source: AA0mqf6D6QTtB+ZejVR0pu5F1rLmrIJNvNqxZMKvatz9opt1b0cQrV+hfvOqIl2CFFjAu8RF57U0NQ==
X-Received: by 2002:a17:906:144f:b0:7c1:28a9:c277 with SMTP id q15-20020a170906144f00b007c128a9c277mr41095300ejc.6.1671529828909;
        Tue, 20 Dec 2022 01:50:28 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0082ea03c395esm1669207ejf.74.2022.12.20.01.50.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:50:28 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V11 7/8] block, bfq: inject I/O to underutilized actuators
Date:   Tue, 20 Dec 2022 10:50:12 +0100
Message-Id: <20221220095013.55803-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221220095013.55803-1-paolo.valente@linaro.org>
References: <20221220095013.55803-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-cgroup.c  |   2 +-
 block/bfq-iosched.c | 136 ++++++++++++++++++++++++++++++++------------
 block/bfq-iosched.h |  39 ++++++++++++-
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 139 insertions(+), 40 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 219d8f09f6a3..a81ade8010f3 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -708,7 +708,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_activate_bfqq(bfqd, bfqq);
 	}
 
-	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
+	if (!bfqd->in_service_queue && !bfqd->tot_rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
 	/* release extra ref taken above, bfqq may happen to be freed now */
 	bfq_put_queue(bfqq);
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2774e96c73d2..c46f1f81e65b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2253,9 +2253,9 @@ static void bfq_add_request(struct request *rq)
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
@@ -2279,7 +2279,7 @@ static void bfq_add_request(struct request *rq)
 			 * will be set in case injection is performed
 			 * on bfqq before rq is completed).
 			 */
-			if (bfqd->rq_in_driver == 0)
+			if (bfqd->tot_rq_in_driver == 0)
 				bfqd->rqs_injected = false;
 		}
 	}
@@ -2644,11 +2644,14 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 static void bfq_end_wr(struct bfq_data *bfqd)
 {
 	struct bfq_queue *bfqq;
+	int i;
 
 	spin_lock_irq(&bfqd->lock);
 
-	list_for_each_entry(bfqq, &bfqd->active_list, bfqq_list)
-		bfq_bfqq_end_wr(bfqq);
+	for (i = 0; i < bfqd->num_actuators; i++) {
+		list_for_each_entry(bfqq, &bfqd->active_list[i], bfqq_list)
+			bfq_bfqq_end_wr(bfqq);
+	}
 	list_for_each_entry(bfqq, &bfqd->idle_list, bfqq_list)
 		bfq_bfqq_end_wr(bfqq);
 	bfq_end_wr_async(bfqd);
@@ -3605,13 +3608,13 @@ static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
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
@@ -3876,10 +3879,8 @@ static bool idling_needed_for_service_guarantees(struct bfq_data *bfqd,
 		return false;
 
 	return (bfqq->wr_coeff > 1 &&
-		(bfqd->wr_busy_queues <
-		 tot_busy_queues ||
-		 bfqd->rq_in_driver >=
-		 bfqq->dispatched + 4)) ||
+		(bfqd->wr_busy_queues < tot_busy_queues ||
+		 bfqd->tot_rq_in_driver >= bfqq->dispatched + 4)) ||
 		bfq_asymmetric_scenario(bfqd, bfqq) ||
 		tot_busy_queues == 1;
 }
@@ -4650,6 +4651,8 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 {
 	struct bfq_queue *bfqq, *in_serv_bfqq = bfqd->in_service_queue;
 	unsigned int limit = in_serv_bfqq->inject_limit;
+	int i;
+
 	/*
 	 * If
 	 * - bfqq is not weight-raised and therefore does not carry
@@ -4681,7 +4684,7 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 		)
 		limit = 1;
 
-	if (bfqd->rq_in_driver >= limit)
+	if (bfqd->tot_rq_in_driver >= limit)
 		return NULL;
 
 	/*
@@ -4696,11 +4699,12 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 	 *   (and re-added only if it gets new requests, but then it
 	 *   is assigned again enough budget for its new backlog).
 	 */
-	list_for_each_entry(bfqq, &bfqd->active_list, bfqq_list)
-		if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
-		    (in_serv_always_inject || bfqq->wr_coeff > 1) &&
-		    bfq_serv_to_charge(bfqq->next_rq, bfqq) <=
-		    bfq_bfqq_budget_left(bfqq)) {
+	for (i = 0; i < bfqd->num_actuators; i++) {
+		list_for_each_entry(bfqq, &bfqd->active_list[i], bfqq_list)
+			if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
+				(in_serv_always_inject || bfqq->wr_coeff > 1) &&
+				bfq_serv_to_charge(bfqq->next_rq, bfqq) <=
+				bfq_bfqq_budget_left(bfqq)) {
 			/*
 			 * Allow for only one large in-flight request
 			 * on non-rotational devices, for the
@@ -4725,22 +4729,69 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
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
+static struct bfq_queue *
+bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
+{
+	struct bfq_queue *bfqq;
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
 
 	return NULL;
 }
 
+/*
+ * Perform a linear scan of each actuator, until an actuator is found
+ * for which the following two conditions hold: the load of the
+ * actuator is below the threshold (see comments on actuator_load_threshold
+ * for details), and there is a queue that contains I/O for that
+ * actuator. On success, return that queue.
+ */
+static struct bfq_queue *
+bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
+{
+	int i;
+
+	for (i = 0 ; i < bfqd->num_actuators; i++) {
+		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
+			struct bfq_queue *bfqq =
+				bfq_find_active_bfqq_for_actuator(bfqd, i);
+
+			if (bfqq)
+				return bfqq;
+		}
+	}
+
+	return NULL;
+}
+
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
 
@@ -4762,6 +4813,15 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
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
@@ -5117,11 +5177,11 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 
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
@@ -5130,7 +5190,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 		 * bfq_finish_requeue_request hook, if defined, is
 		 * probably invoked also on this request. So, by
 		 * exploiting this hook, we could 1) increment
-		 * rq_in_driver here, and 2) decrement it in
+		 * tot_rq_in_driver here, and 2) decrement it in
 		 * bfq_finish_requeue_request. Such a solution would
 		 * let the value of the counter be always accurate,
 		 * but it would entail using an extra interface
@@ -5159,7 +5219,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	 * Of course, serving one request at a time may cause loss of
 	 * throughput.
 	 */
-	if (bfqd->strict_guarantees && bfqd->rq_in_driver > 0)
+	if (bfqd->strict_guarantees && bfqd->tot_rq_in_driver > 0)
 		goto exit;
 
 	bfqq = bfq_select_queue(bfqd);
@@ -5170,7 +5230,8 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 
 	if (rq) {
 inc_in_driver_start_rq:
-		bfqd->rq_in_driver++;
+		bfqd->rq_in_driver[bfqq->actuator_idx]++;
+		bfqd->tot_rq_in_driver++;
 start_rq:
 		rq->rq_flags |= RQF_STARTED;
 	}
@@ -6238,7 +6299,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	struct bfq_queue *bfqq = bfqd->in_service_queue;
 
 	bfqd->max_rq_in_driver = max_t(int, bfqd->max_rq_in_driver,
-				       bfqd->rq_in_driver);
+				       bfqd->tot_rq_in_driver);
 
 	if (bfqd->hw_tag == 1)
 		return;
@@ -6249,7 +6310,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	 * sum is not exact, as it's not taking into account deactivated
 	 * requests.
 	 */
-	if (bfqd->rq_in_driver + bfqd->queued <= BFQ_HW_QUEUE_THRESHOLD)
+	if (bfqd->tot_rq_in_driver + bfqd->queued <= BFQ_HW_QUEUE_THRESHOLD)
 		return;
 
 	/*
@@ -6260,7 +6321,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	if (bfqq && bfq_bfqq_has_short_ttime(bfqq) &&
 	    bfqq->dispatched + bfqq->queued[0] + bfqq->queued[1] <
 	    BFQ_HW_QUEUE_THRESHOLD &&
-	    bfqd->rq_in_driver < BFQ_HW_QUEUE_THRESHOLD)
+	    bfqd->tot_rq_in_driver < BFQ_HW_QUEUE_THRESHOLD)
 		return;
 
 	if (bfqd->hw_tag_samples++ < BFQ_HW_QUEUE_SAMPLES)
@@ -6281,7 +6342,8 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 
 	bfq_update_hw_tag(bfqd);
 
-	bfqd->rq_in_driver--;
+	bfqd->rq_in_driver[bfqq->actuator_idx]--;
+	bfqd->tot_rq_in_driver--;
 	bfqq->dispatched--;
 
 	if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq)) {
@@ -6401,7 +6463,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 					BFQQE_NO_MORE_REQUESTS);
 	}
 
-	if (!bfqd->rq_in_driver)
+	if (!bfqd->tot_rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
 }
 
@@ -6532,13 +6594,13 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
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
@@ -6548,7 +6610,7 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 			bfqq->inject_limit = max_t(unsigned int, 1, old_limit);
 		}
 		bfqq->last_serv_time_ns = tot_time_ns;
-	} else if (!bfqd->rqs_injected && bfqd->rq_in_driver == 1)
+	} else if (!bfqd->rqs_injected && bfqd->tot_rq_in_driver == 1)
 		/*
 		 * No I/O injected and no request still in service in
 		 * the drive: these are the exact conditions for
@@ -7201,7 +7263,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->queue_weights_tree = RB_ROOT_CACHED;
 	bfqd->num_groups_with_pending_reqs = 0;
 
-	INIT_LIST_HEAD(&bfqd->active_list);
+	INIT_LIST_HEAD(&bfqd->active_list[0]);
+	INIT_LIST_HEAD(&bfqd->active_list[1]);
 	INIT_LIST_HEAD(&bfqd->idle_list);
 	INIT_HLIST_HEAD(&bfqd->burst_list);
 
@@ -7246,6 +7309,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 		ref_wr_duration[blk_queue_nonrot(bfqd->queue)];
 	bfqd->peak_rate = ref_rate[blk_queue_nonrot(bfqd->queue)] * 2 / 3;
 
+	/* see comments on the definition of next field inside bfq_data */
+	bfqd->actuator_load_threshold = 4;
+
 	spin_lock_init(&bfqd->lock);
 
 	/*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index fbc6f63a62e1..e992d7fc24e6 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -586,7 +586,12 @@ struct bfq_data {
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
@@ -680,8 +685,13 @@ struct bfq_data {
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
 
@@ -817,6 +827,29 @@ struct bfq_data {
 	sector_t sector[BFQ_MAX_ACTUATORS];
 	sector_t nr_sectors[BFQ_MAX_ACTUATORS];
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
index b02b53658ed4..54b4f6264e8b 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -493,7 +493,7 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 	bfq_update_active_tree(node);
 
 	if (bfqq)
-		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
+		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list[bfqq->actuator_idx]);
 
 	bfq_inc_active_entities(entity);
 }
-- 
2.20.1

