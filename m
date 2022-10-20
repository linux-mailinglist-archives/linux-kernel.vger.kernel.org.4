Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A89606471
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiJTP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiJTP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:27:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F98186791
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:27:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f11so35126291wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEuBX2Fjtu2GATP0vSLLhT/7UV4LYojmOM94TePICgY=;
        b=h77gyFLtqON09wNhssE2FXYmgVmC5qEWR2ldEtmwnw7VzsiRsPg6RzGq+jJsQm8xVS
         pXOj+odXRfbKXMyKaLMwztEvr7z8TUEXmZvex0GsuFCpTYEzY1Q51noHz7vZdFw+MhpM
         /ZuhJAPYHWLsFLpL/jIjGa5YUZ4amZQMJblS9ys4zuBbqdSBdQX0r3ilB1q7funr++uU
         s0UJCkOBfrh3qwglYH+FUD9ZW2bfsaXliNYJYB30RoaVempFcogl0/JMWdXIcGVH/Y3w
         IazDqpPtLWIfOcwVFULUyrJFFVUArUSyWqa5MT0ou37igVaW/Fw7kZ1N5+D7bQbKPZcT
         mCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEuBX2Fjtu2GATP0vSLLhT/7UV4LYojmOM94TePICgY=;
        b=w0xf06xGbqBh2jFsughnIgHoj9LB8dXHXOVAexxF2VQQqnLbyf5VLz+Liqc8bqmkdO
         vIhuGiU/BxQGypL3EA10uhabdFI36BnjRBzDMovTGDVQ2oxuMbAKBKOU95c5QJx2/0t4
         BnICq9s0I0w6AJUmzWwkxya+PNuFfnN94zt2Zf5EB+DnfqLqCOlcPXUIxD6kZQho12OS
         p5Ijkx1V1b6JSbYj1r31drIa7ZUfcUxvpO2n3VPjogAp74EOD1BVPHZ3kDVgQCU2ssON
         UIqTRuHvwsR3EfIYTcuR7v/Mx5hR6JkQ7fxiIwaN2IxVxwbFWeBAJe9QqZj4a9Wa0hfG
         vcMw==
X-Gm-Message-State: ACrzQf3var8O6EzHMXPRvlKsGz/PSYRo+5ANTtY/L9g9iY1eQYEjjIFH
        3TnEBqZ33oc9yR7g0N1Ory2MPkBbXRlsVg==
X-Google-Smtp-Source: AMsMyM7Q0e9/5AG10u21OOD8157uAy4v19fFi59FUtb77u8BnEzpEOMwuONpbc/SqqzLTd3nKF4Y/Q==
X-Received: by 2002:a5d:6508:0:b0:22e:1af4:57f9 with SMTP id x8-20020a5d6508000000b0022e1af457f9mr8979414wru.539.1666279618393;
        Thu, 20 Oct 2022 08:26:58 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id l10-20020a1ced0a000000b003c409244bb0sm134337wmh.6.2022.10.20.08.26.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 08:26:57 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        glen.valante@linaro.org, arie.vanderhoeven@seagate.com,
        rory.c.chen@seagate.com, Paolo Valente <paolo.valente@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
Subject: [PATCH V4 4/8] block, bfq: turn bfqq_data into an array in bfq_io_cq
Date:   Thu, 20 Oct 2022 17:26:39 +0200
Message-Id: <20221020152643.21199-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221020152643.21199-1-paolo.valente@linaro.org>
References: <20221020152643.21199-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a bfq_queue Q is merged with another queue, several pieces of
information are saved about Q. These pieces are stored in the
bfqq_data field in the bfq_io_cq data structure of the process
associated with Q.

Yet, with a multi-actuator drive, a process may get associated with
multiple bfq_queues: one queue for each of the N actuators. Each of
these queues may undergo a merge. So, the bfq_io_cq data structure
must be able to accommodate the above information for N queues.

This commit solves this problem by turning the bfqq_data scalar field
into an array of N elements (and by changing code so as to handle
this array).

This solution is written under the assumption that bfq_queues
associated with different actuators cannot be cross-merged. This
assumption holds naturally with basic queue merging: the latter is
triggered by spatial locality, and sectors for different actuators are
not close to each other. As for stable cross-merging, the assumption
here is that it is disabled.

Signed-off-by: Gabriele Felici <felicigb@gmail.com>
Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
Signed-off-by: Giulio Barabino <giuliobarabino99@gmail.com>
Signed-off-by: Emiliano Maccaferri <inbox@emilianomaccaferri.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 152 +++++++++++++++++++++++++-------------------
 block/bfq-iosched.h |  12 ++--
 2 files changed, 95 insertions(+), 69 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d2bd94ea2e95..80fb20fe0e41 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -406,7 +406,7 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
 	 */
 	bic->bfqq[is_sync][actuator_idx] = bfqq;
 
-	if (bfqq && bic->bfqq_data->stable_merge_bfqq == bfqq) {
+	if (bfqq && bic->bfqq_data[actuator_idx]->stable_merge_bfqq == bfqq) {
 		/*
 		 * Actually, these same instructions are executed also
 		 * in bfq_setup_cooperator, in case of abort or actual
@@ -415,9 +415,9 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
 		 * did so, we would nest even more complexity in this
 		 * function.
 		 */
-		bfq_put_stable_ref(bic->bfqq_data->stable_merge_bfqq);
+		bfq_put_stable_ref(bic->bfqq_data[actuator_idx]->stable_merge_bfqq);
 
-		bic->bfqq_data->stable_merge_bfqq = NULL;
+		bic->bfqq_data[actuator_idx]->stable_merge_bfqq = NULL;
 	}
 }
 
@@ -1176,37 +1176,40 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 {
 	unsigned int old_wr_coeff = 1;
 	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
+	unsigned int a_idx = bfqq->actuator_idx;
 
-	if (bic->bfqq_data->saved_has_short_ttime)
+	if (bic->bfqq_data[a_idx]->saved_has_short_ttime)
 		bfq_mark_bfqq_has_short_ttime(bfqq);
 	else
 		bfq_clear_bfqq_has_short_ttime(bfqq);
 
-	if (bic->bfqq_data->saved_IO_bound)
+	if (bic->bfqq_data[a_idx]->saved_IO_bound)
 		bfq_mark_bfqq_IO_bound(bfqq);
 	else
 		bfq_clear_bfqq_IO_bound(bfqq);
 
-	bfqq->last_serv_time_ns = bic->bfqq_data->saved_last_serv_time_ns;
-	bfqq->inject_limit = bic->bfqq_data->saved_inject_limit;
-	bfqq->decrease_time_jif = bic->bfqq_data->saved_decrease_time_jif;
-
-	bfqq->entity.new_weight = bic->bfqq_data->saved_weight;
-	bfqq->ttime = bic->bfqq_data->saved_ttime;
-	bfqq->io_start_time = bic->bfqq_data->saved_io_start_time;
-	bfqq->tot_idle_time = bic->bfqq_data->saved_tot_idle_time;
+	bfqq->last_serv_time_ns =
+		bic->bfqq_data[a_idx]->saved_last_serv_time_ns;
+	bfqq->inject_limit = bic->bfqq_data[a_idx]->saved_inject_limit;
+	bfqq->decrease_time_jif =
+		bic->bfqq_data[a_idx]->saved_decrease_time_jif;
+	bfqq->entity.new_weight = bic->bfqq_data[a_idx]->saved_weight;
+	bfqq->ttime = bic->bfqq_data[a_idx]->saved_ttime;
+	bfqq->io_start_time = bic->bfqq_data[a_idx]->saved_io_start_time;
+	bfqq->tot_idle_time = bic->bfqq_data[a_idx]->saved_tot_idle_time;
 	/*
 	 * Restore weight coefficient only if low_latency is on
 	 */
 	if (bfqd->low_latency) {
 		old_wr_coeff = bfqq->wr_coeff;
-		bfqq->wr_coeff = bic->bfqq_data->saved_wr_coeff;
+		bfqq->wr_coeff = bic->bfqq_data[a_idx]->saved_wr_coeff;
 	}
-	bfqq->service_from_wr = bic->bfqq_data->saved_service_from_wr;
+	bfqq->service_from_wr = bic->bfqq_data[a_idx]->saved_service_from_wr;
 	bfqq->wr_start_at_switch_to_srt =
-		bic->bfqq_data->saved_wr_start_at_switch_to_srt;
-	bfqq->last_wr_start_finish = bic->bfqq_data->saved_last_wr_start_finish;
-	bfqq->wr_cur_max_time = bic->bfqq_data->saved_wr_cur_max_time;
+		bic->bfqq_data[a_idx]->saved_wr_start_at_switch_to_srt;
+	bfqq->last_wr_start_finish =
+		bic->bfqq_data[a_idx]->saved_last_wr_start_finish;
+	bfqq->wr_cur_max_time = bic->bfqq_data[a_idx]->saved_wr_cur_max_time;
 
 	if (bfqq->wr_coeff > 1 && (bfq_bfqq_in_large_burst(bfqq) ||
 	    time_is_before_jiffies(bfqq->last_wr_start_finish +
@@ -1825,6 +1828,16 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
 	return bfqq_weight > in_serv_weight;
 }
 
+/* get the index of the actuator that will serve bio */
+static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
+{
+	/*
+	 * Multi-actuator support not complete yet, so always return 0
+	 * for the moment.
+	 */
+	return 0;
+}
+
 static bool bfq_better_to_idle(struct bfq_queue *bfqq);
 
 static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
@@ -1879,7 +1892,9 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	wr_or_deserves_wr = bfqd->low_latency &&
 		(bfqq->wr_coeff > 1 ||
 		 (bfq_bfqq_sync(bfqq) &&
-		  (bfqq->bic || RQ_BIC(rq)->bfqq_data->stably_merged) &&
+		  (bfqq->bic ||
+		   RQ_BIC(rq)->bfqq_data[bfq_actuator_index(bfqd, rq->bio)]
+		   ->stably_merged) &&
 		   (*interactive || soft_rt)));
 
 	/*
@@ -2467,16 +2482,6 @@ static void bfq_remove_request(struct request_queue *q,
 
 }
 
-/* get the index of the actuator that will serve bio */
-static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
-{
-	/*
-	 * Multi-actuator support not complete yet, so always return 0
-	 * for the moment.
-	 */
-	return 0;
-}
-
 static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
@@ -2903,6 +2908,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		     void *io_struct, bool request, struct bfq_io_cq *bic)
 {
 	struct bfq_queue *in_service_bfqq, *new_bfqq;
+	unsigned int a_idx = bfqq->actuator_idx;
 
 	/* if a merge has already been setup, then proceed with that first */
 	if (bfqq->new_bfqq)
@@ -2924,21 +2930,22 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		 * stable merging) also if bic is associated with a
 		 * sync queue, but this bfqq is async
 		 */
-		if (bfq_bfqq_sync(bfqq) && bic->bfqq_data->stable_merge_bfqq &&
+		if (bfq_bfqq_sync(bfqq) &&
+		    bic->bfqq_data[a_idx]->stable_merge_bfqq &&
 		    !bfq_bfqq_just_created(bfqq) &&
 		    time_is_before_jiffies(bfqq->split_time +
 					  msecs_to_jiffies(bfq_late_stable_merging)) &&
 		    time_is_before_jiffies(bfqq->creation_time +
 					   msecs_to_jiffies(bfq_late_stable_merging))) {
 			struct bfq_queue *stable_merge_bfqq =
-				bic->bfqq_data->stable_merge_bfqq;
+				bic->bfqq_data[a_idx]->stable_merge_bfqq;
 			int proc_ref = min(bfqq_process_refs(bfqq),
 					   bfqq_process_refs(stable_merge_bfqq));
 
 			/* deschedule stable merge, because done or aborted here */
 			bfq_put_stable_ref(stable_merge_bfqq);
 
-			bic->bfqq_data->stable_merge_bfqq = NULL;
+			bic->bfqq_data[a_idx]->stable_merge_bfqq = NULL;
 
 			if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
 			    proc_ref > 0) {
@@ -2947,10 +2954,12 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 					bfq_setup_merge(bfqq, stable_merge_bfqq);
 
 				if (new_bfqq) {
-					bic->bfqq_data->stably_merged = true;
+					bic->bfqq_data[a_idx]->stably_merged =
+						true;
 					if (new_bfqq->bic)
-						new_bfqq->bic->bfqq_data->stably_merged =
-							true;
+						new_bfqq->bic->bfqq_data
+							[new_bfqq->actuator_idx]
+							->stably_merged = true;
 				}
 				return new_bfqq;
 			} else
@@ -3049,6 +3058,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 {
 	struct bfq_io_cq *bic = bfqq->bic;
+	/* State must be saved for the right queue index. */
+	unsigned int a_idx = bfqq->actuator_idx;
 
 	/*
 	 * If !bfqq->bic, the queue is already shared or its requests
@@ -3058,19 +3069,23 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	if (!bic)
 		return;
 
-	bic->bfqq_data->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
-	bic->bfqq_data->saved_inject_limit = bfqq->inject_limit;
-	bic->bfqq_data->saved_decrease_time_jif = bfqq->decrease_time_jif;
+	bic->bfqq_data[a_idx]->saved_last_serv_time_ns =
+		bfqq->last_serv_time_ns;
+	bic->bfqq_data[a_idx]->saved_inject_limit =
+		bfqq->inject_limit;
+	bic->bfqq_data[a_idx]->saved_decrease_time_jif =
+		bfqq->decrease_time_jif;
 
-	bic->bfqq_data->saved_weight = bfqq->entity.orig_weight;
-	bic->bfqq_data->saved_ttime = bfqq->ttime;
-	bic->bfqq_data->saved_has_short_ttime =
+	bic->bfqq_data[a_idx]->saved_weight = bfqq->entity.orig_weight;
+	bic->bfqq_data[a_idx]->saved_ttime = bfqq->ttime;
+	bic->bfqq_data[a_idx]->saved_has_short_ttime =
 		bfq_bfqq_has_short_ttime(bfqq);
-	bic->bfqq_data->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
-	bic->bfqq_data->saved_io_start_time = bfqq->io_start_time;
-	bic->bfqq_data->saved_tot_idle_time = bfqq->tot_idle_time;
-	bic->bfqq_data->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
-	bic->bfqq_data->was_in_burst_list =
+	bic->bfqq_data[a_idx]->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
+	bic->bfqq_data[a_idx]->saved_io_start_time = bfqq->io_start_time;
+	bic->bfqq_data[a_idx]->saved_tot_idle_time = bfqq->tot_idle_time;
+	bic->bfqq_data[a_idx]->saved_in_large_burst =
+		bfq_bfqq_in_large_burst(bfqq);
+	bic->bfqq_data[a_idx]->was_in_burst_list =
 		!hlist_unhashed(&bfqq->burst_list_node);
 
 	if (unlikely(bfq_bfqq_just_created(bfqq) &&
@@ -3085,21 +3100,23 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 		 * to bfqq, so that to avoid that bfqq unjustly fails
 		 * to enjoy weight raising if split soon.
 		 */
-		bic->bfqq_data->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
-		bic->bfqq_data->saved_wr_start_at_switch_to_srt =
+		bic->bfqq_data[a_idx]->saved_wr_coeff =
+			bfqq->bfqd->bfq_wr_coeff;
+		bic->bfqq_data[a_idx]->saved_wr_start_at_switch_to_srt =
 			bfq_smallest_from_now();
-		bic->bfqq_data->saved_wr_cur_max_time =
+		bic->bfqq_data[a_idx]->saved_wr_cur_max_time =
 			bfq_wr_duration(bfqq->bfqd);
-		bic->bfqq_data->saved_last_wr_start_finish = jiffies;
+		bic->bfqq_data[a_idx]->saved_last_wr_start_finish = jiffies;
 	} else {
-		bic->bfqq_data->saved_wr_coeff = bfqq->wr_coeff;
-		bic->bfqq_data->saved_wr_start_at_switch_to_srt =
+		bic->bfqq_data[a_idx]->saved_wr_coeff = bfqq->wr_coeff;
+		bic->bfqq_data[a_idx]->saved_wr_start_at_switch_to_srt =
 			bfqq->wr_start_at_switch_to_srt;
-		bic->bfqq_data->saved_service_from_wr =
+		bic->bfqq_data[a_idx]->saved_service_from_wr =
 			bfqq->service_from_wr;
-		bic->bfqq_data->saved_last_wr_start_finish =
+		bic->bfqq_data[a_idx]->saved_last_wr_start_finish =
 			bfqq->last_wr_start_finish;
-		bic->bfqq_data->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
+		bic->bfqq_data[a_idx]->saved_wr_cur_max_time =
+			bfqq->wr_cur_max_time;
 	}
 }
 
@@ -5429,8 +5446,8 @@ static void bfq_exit_icq(struct io_cq *icq)
 		spin_lock_irqsave(&bfqd->lock, flags);
 
 	for (act_idx = 0; act_idx < bfqd->num_actuators; act_idx++) {
-		if (bic->bfqq_data->stable_merge_bfqq)
-			bfq_put_stable_ref(bic->bfqq_data->stable_merge_bfqq);
+		if (bic->bfqq_data[act_idx]->stable_merge_bfqq)
+			bfq_put_stable_ref(bic->bfqq_data[act_idx]->stable_merge_bfqq);
 
 		bfq_exit_icq_bfqq(bic, true, act_idx);
 		bfq_exit_icq_bfqq(bic, false, act_idx);
@@ -5618,6 +5635,7 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  struct bfq_io_cq *bic,
 			  struct bfq_queue *last_bfqq_created)
 {
+	unsigned int a_idx = last_bfqq_created->actuator_idx;
 	struct bfq_queue *new_bfqq =
 		bfq_setup_merge(bfqq, last_bfqq_created);
 
@@ -5625,8 +5643,8 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		return bfqq;
 
 	if (new_bfqq->bic)
-		new_bfqq->bic->bfqq_data->stably_merged = true;
-	bic->bfqq_data->stably_merged = true;
+		new_bfqq->bic->bfqq_data[a_idx]->stably_merged = true;
+	bic->bfqq_data[a_idx]->stably_merged = true;
 
 	/*
 	 * Reusing merge functions. This implies that
@@ -5756,7 +5774,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 			/*
 			 * Record the bfqq to merge to.
 			 */
-			bic->bfqq_data->stable_merge_bfqq = last_bfqq_created;
+			bic->bfqq_data[last_bfqq_created->actuator_idx]->stable_merge_bfqq =
+				last_bfqq_created;
 		}
 	}
 
@@ -6690,12 +6709,13 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 
 	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
 	if (split && is_sync) {
-		if ((bic->bfqq_data->was_in_burst_list && bfqd->large_burst) ||
-		    bic->bfqq_data->saved_in_large_burst)
+		if ((bic->bfqq_data[act_idx]->was_in_burst_list &&
+		     bfqd->large_burst) ||
+		    bic->bfqq_data[act_idx]->saved_in_large_burst)
 			bfq_mark_bfqq_in_large_burst(bfqq);
 		else {
 			bfq_clear_bfqq_in_large_burst(bfqq);
-			if (bic->bfqq_data->was_in_burst_list)
+			if (bic->bfqq_data[act_idx]->was_in_burst_list)
 				/*
 				 * If bfqq was in the current
 				 * burst list before being
@@ -6784,6 +6804,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	struct bfq_queue *bfqq;
 	bool new_queue = false;
 	bool bfqq_already_existing = false, split = false;
+	unsigned int a_idx = bfq_actuator_index(bfqd, bio);
 
 	if (unlikely(!rq->elv.icq))
 		return NULL;
@@ -6810,12 +6831,13 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	if (likely(!new_queue)) {
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
-			!bic->bfqq_data->stably_merged) {
+			!bic->bfqq_data[a_idx]->stably_merged) {
 			struct bfq_queue *old_bfqq = bfqq;
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
-				bic->bfqq_data->saved_in_large_burst = true;
+				bic->bfqq_data[a_idx]->saved_in_large_burst =
+					true;
 
 			bfqq = bfq_split_bfqq(bic, bfqq);
 			split = true;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 6bc7bed97956..713c6559fe91 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -420,7 +420,7 @@ struct bfq_queue {
 struct bfq_iocq_bfqq_data {
 	/*
 	 * Snapshot of the has_short_time flag before merging; taken
-	 * to remember its value while the queue is merged, so as to
+	 * to remember its values while the queue is merged, so as to
 	 * be able to restore it in case of split.
 	 */
 	bool saved_has_short_ttime;
@@ -434,7 +434,7 @@ struct bfq_iocq_bfqq_data {
 	u64 saved_tot_idle_time;
 
 	/*
-	 * Same purpose as the previous fields for the value of the
+	 * Same purpose as the previous fields for the values of the
 	 * field keeping the queue's belonging to a large burst
 	 */
 	bool saved_in_large_burst;
@@ -497,8 +497,12 @@ struct bfq_io_cq {
 	uint64_t blkcg_serial_nr; /* the current blkcg serial */
 #endif
 
-	/* persistent data for associated synchronous process queue */
-	struct bfq_iocq_bfqq_data *bfqq_data;
+	/*
+	 * Persistent data for associated synchronous process queues
+	 * (one queue per actuator, see field bfqq above). In
+	 * particular, each of these queues may undergo a merge.
+	 */
+	struct bfq_iocq_bfqq_data *bfqq_data[BFQ_MAX_ACTUATORS];
 
 	unsigned int requests;	/* Number of requests this process has in flight */
 };
-- 
2.20.1

