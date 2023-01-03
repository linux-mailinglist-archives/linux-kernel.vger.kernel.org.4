Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2165C28B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbjACO4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbjACOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:55:45 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E41208A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:55:33 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id fy8so10337634ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXXK2qnu5qVvXVUzy+cOnV+H+KufbHHn0u7i4BD209g=;
        b=i+X0wiT7210gip+CLvAq6qmtBCpGBb66d06z9pRHvtO4FY6W/cWDN6KOFSF//XV64G
         VoHBRXE9oQKKFBQ5jLRQ4ix1173gEwGa01Sz2IsNgTrCxR/XlBXyDMJx9mWuydjrXvmZ
         /g4js18lS+pQPk094UuDqVdMvZTwbChzklZZya4Q+1CVdBuVgaffwvQPDqC9u/KPpWIV
         wXfzTRf8u+H9L9zvxNFMhsAYJraOrCmd7W1v/4IzbnemN88MQwtXVeV7xlfZqJZpocc4
         8r+oQrZ0Lv0ODgqbwNy4uc4WUo5Mpo7jJQx2ZeATE04hIgfy2ljEV4vYosxtPYW+RFt9
         vxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXXK2qnu5qVvXVUzy+cOnV+H+KufbHHn0u7i4BD209g=;
        b=WevRk/XwIftF3NXOSc//bR6OuKV5IsV16dOp7Agn5y1l+yHVm+oYQuH7Odp48m8ymn
         gWfrveRutcs4fny4ej2X/jOIUEzqn3fKkR1JPNfMa+cowTTf2jvCaftqWTLufA+qK+Sa
         gB8yB5HDr95YsJf/+5MAbYW3osnNrbGCcqElFa11vmQJY/gPFfF5WEtYCkjyKNmIe82I
         cx+NwAFedEJVjGZ/WUTZK3rftSGRc2RG49iWhmxNvhRULg6w4AnqhSwwUdlUHDSeCIDE
         4rSVMJJKs/sGK0RgJk6XSeF5nI0yvuhsKZ4U34Qdx8KFp8//ikibtdzcWxm9XbG2zad6
         g2pA==
X-Gm-Message-State: AFqh2kom6oiHRlcddwQQ23VYZ90DI2sa5alhk8d2YSDE9wnQzofSlH7q
        ymQSLBiXOZIJVsnb0EuXaLxlaQ==
X-Google-Smtp-Source: AMrXdXsGo1CQJbc5pGrekNbPr2X7RkIwLWOLTpG0+cdR4ggHhBxHfIMVWquBMoZOuqkQF/flcqrUJQ==
X-Received: by 2002:a17:906:5048:b0:7c0:b770:df94 with SMTP id e8-20020a170906504800b007c0b770df94mr38506880ejk.63.1672757733143;
        Tue, 03 Jan 2023 06:55:33 -0800 (PST)
Received: from localhost.localdomain (mob-5-91-46-2.net.vodafone.it. [5.91.46.2])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090604d100b007c16fdc93ddsm14122595eja.81.2023.01.03.06.55.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:55:32 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 REBASED 7/8] block, bfq: inject I/O to underutilized actuators
Date:   Tue,  3 Jan 2023 15:55:02 +0100
Message-Id: <20230103145503.71712-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230103145503.71712-1-paolo.valente@linaro.org>
References: <20230103145503.71712-1-paolo.valente@linaro.org>
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
index bd7bf0f8121d..a6e8da5f5cfd 100644
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
index 56486f24b4c5..d42a229b5a86 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2259,9 +2259,9 @@ static void bfq_add_request(struct request *rq)
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
@@ -2285,7 +2285,7 @@ static void bfq_add_request(struct request *rq)
 			 * will be set in case injection is performed
 			 * on bfqq before rq is completed).
 			 */
-			if (bfqd->rq_in_driver == 0)
+			if (bfqd->tot_rq_in_driver == 0)
 				bfqd->rqs_injected = false;
 		}
 	}
@@ -2650,11 +2650,14 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
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
@@ -3611,13 +3614,13 @@ static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
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
@@ -3882,10 +3885,8 @@ static bool idling_needed_for_service_guarantees(struct bfq_data *bfqd,
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
@@ -4656,6 +4657,8 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 {
 	struct bfq_queue *bfqq, *in_serv_bfqq = bfqd->in_service_queue;
 	unsigned int limit = in_serv_bfqq->inject_limit;
+	int i;
+
 	/*
 	 * If
 	 * - bfqq is not weight-raised and therefore does not carry
@@ -4687,7 +4690,7 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 		)
 		limit = 1;
 
-	if (bfqd->rq_in_driver >= limit)
+	if (bfqd->tot_rq_in_driver >= limit)
 		return NULL;
 
 	/*
@@ -4702,11 +4705,12 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
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
@@ -4731,22 +4735,69 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
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
 
@@ -4768,6 +4819,15 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
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
@@ -5123,11 +5183,11 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 
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
@@ -5136,7 +5196,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 		 * bfq_finish_requeue_request hook, if defined, is
 		 * probably invoked also on this request. So, by
 		 * exploiting this hook, we could 1) increment
-		 * rq_in_driver here, and 2) decrement it in
+		 * tot_rq_in_driver here, and 2) decrement it in
 		 * bfq_finish_requeue_request. Such a solution would
 		 * let the value of the counter be always accurate,
 		 * but it would entail using an extra interface
@@ -5165,7 +5225,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	 * Of course, serving one request at a time may cause loss of
 	 * throughput.
 	 */
-	if (bfqd->strict_guarantees && bfqd->rq_in_driver > 0)
+	if (bfqd->strict_guarantees && bfqd->tot_rq_in_driver > 0)
 		goto exit;
 
 	bfqq = bfq_select_queue(bfqd);
@@ -5176,7 +5236,8 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 
 	if (rq) {
 inc_in_driver_start_rq:
-		bfqd->rq_in_driver++;
+		bfqd->rq_in_driver[bfqq->actuator_idx]++;
+		bfqd->tot_rq_in_driver++;
 start_rq:
 		rq->rq_flags |= RQF_STARTED;
 	}
@@ -6243,7 +6304,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	struct bfq_queue *bfqq = bfqd->in_service_queue;
 
 	bfqd->max_rq_in_driver = max_t(int, bfqd->max_rq_in_driver,
-				       bfqd->rq_in_driver);
+				       bfqd->tot_rq_in_driver);
 
 	if (bfqd->hw_tag == 1)
 		return;
@@ -6254,7 +6315,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	 * sum is not exact, as it's not taking into account deactivated
 	 * requests.
 	 */
-	if (bfqd->rq_in_driver + bfqd->queued <= BFQ_HW_QUEUE_THRESHOLD)
+	if (bfqd->tot_rq_in_driver + bfqd->queued <= BFQ_HW_QUEUE_THRESHOLD)
 		return;
 
 	/*
@@ -6265,7 +6326,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	if (bfqq && bfq_bfqq_has_short_ttime(bfqq) &&
 	    bfqq->dispatched + bfqq->queued[0] + bfqq->queued[1] <
 	    BFQ_HW_QUEUE_THRESHOLD &&
-	    bfqd->rq_in_driver < BFQ_HW_QUEUE_THRESHOLD)
+	    bfqd->tot_rq_in_driver < BFQ_HW_QUEUE_THRESHOLD)
 		return;
 
 	if (bfqd->hw_tag_samples++ < BFQ_HW_QUEUE_SAMPLES)
@@ -6286,7 +6347,8 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 
 	bfq_update_hw_tag(bfqd);
 
-	bfqd->rq_in_driver--;
+	bfqd->rq_in_driver[bfqq->actuator_idx]--;
+	bfqd->tot_rq_in_driver--;
 	bfqq->dispatched--;
 
 	if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq)) {
@@ -6406,7 +6468,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 					BFQQE_NO_MORE_REQUESTS);
 	}
 
-	if (!bfqd->rq_in_driver)
+	if (!bfqd->tot_rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
 }
 
@@ -6537,13 +6599,13 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
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
@@ -6553,7 +6615,7 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 			bfqq->inject_limit = max_t(unsigned int, 1, old_limit);
 		}
 		bfqq->last_serv_time_ns = tot_time_ns;
-	} else if (!bfqd->rqs_injected && bfqd->rq_in_driver == 1)
+	} else if (!bfqd->rqs_injected && bfqd->tot_rq_in_driver == 1)
 		/*
 		 * No I/O injected and no request still in service in
 		 * the drive: these are the exact conditions for
@@ -7208,7 +7270,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->num_groups_with_pending_reqs = 0;
 #endif
 
-	INIT_LIST_HEAD(&bfqd->active_list);
+	INIT_LIST_HEAD(&bfqd->active_list[0]);
+	INIT_LIST_HEAD(&bfqd->active_list[1]);
 	INIT_LIST_HEAD(&bfqd->idle_list);
 	INIT_HLIST_HEAD(&bfqd->burst_list);
 
@@ -7253,6 +7316,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 		ref_wr_duration[blk_queue_nonrot(bfqd->queue)];
 	bfqd->peak_rate = ref_rate[blk_queue_nonrot(bfqd->queue)] * 2 / 3;
 
+	/* see comments on the definition of next field inside bfq_data */
+	bfqd->actuator_load_threshold = 4;
+
 	spin_lock_init(&bfqd->lock);
 
 	/*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 830dda1f9322..058af701bbbe 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -590,7 +590,12 @@ struct bfq_data {
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
@@ -684,8 +689,13 @@ struct bfq_data {
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
 
@@ -821,6 +831,29 @@ struct bfq_data {
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
index ea4c3d757fdd..7941b6f07391 100644
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

