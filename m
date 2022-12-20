Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3843651E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiLTJvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiLTJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:50:29 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98815C2F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:50:27 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id x22so27845387ejs.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwuFiI40NeJ4FSWqa2v70OmokTuPGAZ7TLwbZ8Gtk+Q=;
        b=f690VqWGtOhiXHui2u6LQQzcMAf9zFE118t3VaNFxFUtQGDE+HXkB/UbT+OXU87kl2
         LrwyyNTrbDSW30c9NMs0pQS0nCtH0HSI6FFYHMosFwJxx6H7IUn3vE9qX3VJA4luV/Ml
         QVQPXuVyu6Jj9ePnDgouLrVpjtMqQv56ZLgqjFpy/2RARv00HQJctdoChsojKog15TW6
         G/WNEEK8TXHndFW4MQCTc+CdJzjAFakjy7aHLZ6jDQgh47/4MwiS/mnVBo8NbH2QXdiZ
         bjCtY7Tm4uWvTZ9AwwE5SQuLWSt1anurk94a0M6fvfJNkcYY2GZiTCTWCq9T0IYyB+mA
         +eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwuFiI40NeJ4FSWqa2v70OmokTuPGAZ7TLwbZ8Gtk+Q=;
        b=YerFVFHDICND7Z1TXqMdt0aEIbtBvPUkJZp5E3AWZFWouBo1V+ZXWO2APDMK6jfPZe
         ob9IqmyWKBdAqedpdLCm0400nsCMgAiNeCeyMrmNcTfc9BLLGP3cqwnFxgwA+HciQ7fH
         uUel0S9TGKcdzDZp8AwwEvw1S/fpvckKNWSzNiMdQYD4wTNRPFY3+wyO3e8w18KNYKAn
         meaHxa0bSnwyc/mrk8tNYm5IbJxuBeCSsY7osn2Zpk7EORiaBZ0lvh+wK6qRmomLjBQB
         U2xjVN14I8GPwl6YrIDIG7hUNfCuYG+ESFcFjazyHs/ExgqnxVaSViRzbm20m++wXN40
         k+4A==
X-Gm-Message-State: ANoB5pkFX1vduMdEE4bmw7R/BqJOhXKfwQojIDgDl1kGXagAAqmobkaX
        srcWlsIgGtenU7+cdrk3MFs7Eg==
X-Google-Smtp-Source: AA0mqf6DCwRIPFpPnhKNhczGMZCoj7CBKM1m+POsbcVG9eRrzavlWp2+vyi1TNzk3Pr1u6GMmDhE8A==
X-Received: by 2002:a17:906:7b50:b0:7c1:65d1:c4ca with SMTP id n16-20020a1709067b5000b007c165d1c4camr30796946ejo.33.1671529826119;
        Tue, 20 Dec 2022 01:50:26 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0082ea03c395esm1669207ejf.74.2022.12.20.01.50.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:50:25 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
Subject: [PATCH V11 4/8] block, bfq: turn bfqq_data into an array in bfq_io_cq
Date:   Tue, 20 Dec 2022 10:50:09 +0100
Message-Id: <20221220095013.55803-5-paolo.valente@linaro.org>
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
not close to each other (apart from the corner case of the last
sectors served by a given actuator and the first sectors served by the
next actuator). As for stable cross-merging, the assumption here is
that it is disabled.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Gabriele Felici <felicigb@gmail.com>
Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
Signed-off-by: Giulio Barabino <giuliobarabino99@gmail.com>
Signed-off-by: Emiliano Maccaferri <inbox@emilianomaccaferri.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 100 ++++++++++++++++++++++++++------------------
 block/bfq-iosched.h |  12 ++++--
 2 files changed, 67 insertions(+), 45 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 233f2c3e1103..b4a1cad48871 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -406,7 +406,7 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
 	 * we cancel the stable merge if
 	 * bic->stable_merge_bfqq == bfqq.
 	 */
-	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[actuator_idx];
 
 	if (is_sync)
 		bic->bfqq[1][actuator_idx] = bfqq;
@@ -1129,9 +1129,10 @@ static void
 bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 		      struct bfq_io_cq *bic, bool bfq_already_existing)
 {
-	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
 	unsigned int old_wr_coeff = 1;
 	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
+	unsigned int a_idx = bfqq->actuator_idx;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
 
 	if (bfqq_data->saved_has_short_ttime)
 		bfq_mark_bfqq_has_short_ttime(bfqq);
@@ -1812,7 +1813,9 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 		arrived_in_time =  ktime_get_ns() <=
 			bfqq->ttime.last_end_request +
 			bfqd->bfq_slice_idle * 3;
-
+	unsigned int act_idx = bfq_actuator_index(bfqd, rq->bio);
+	bool bfqq_non_merged_or_stably_merged =
+		bfqq->bic || RQ_BIC(rq)->bfqq_data[act_idx].stably_merged;
 
 	/*
 	 * bfqq deserves to be weight-raised if:
@@ -1846,9 +1849,8 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 */
 	wr_or_deserves_wr = bfqd->low_latency &&
 		(bfqq->wr_coeff > 1 ||
-		 (bfq_bfqq_sync(bfqq) &&
-		  (bfqq->bic || RQ_BIC(rq)->bfqq_data.stably_merged) &&
-		   (*interactive || soft_rt)));
+		 (bfq_bfqq_sync(bfqq) && bfqq_non_merged_or_stably_merged &&
+		  (*interactive || soft_rt)));
 
 	/*
 	 * Using the last flag, update budget and check whether bfqq
@@ -2822,6 +2824,35 @@ static bool bfq_may_be_close_cooperator(struct bfq_queue *bfqq,
 static bool idling_boosts_thr_without_issues(struct bfq_data *bfqd,
 					     struct bfq_queue *bfqq);
 
+static struct bfq_queue *
+bfq_setup_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+		       struct bfq_queue *stable_merge_bfqq,
+		       struct bfq_iocq_bfqq_data *bfqq_data)
+{
+	int proc_ref = min(bfqq_process_refs(bfqq),
+			   bfqq_process_refs(stable_merge_bfqq));
+	struct bfq_queue *new_bfqq;
+
+	if (idling_boosts_thr_without_issues(bfqd, bfqq) ||
+	    proc_ref == 0)
+		return NULL;
+
+	/* next function will take at least one ref */
+	new_bfqq = bfq_setup_merge(bfqq, stable_merge_bfqq);
+
+	if (new_bfqq) {
+		bfqq_data->stably_merged = true;
+		if (new_bfqq->bic) {
+			unsigned int new_a_idx = new_bfqq->actuator_idx;
+			struct bfq_iocq_bfqq_data *new_bfqq_data =
+				&new_bfqq->bic->bfqq_data[new_a_idx];
+
+			new_bfqq_data->stably_merged = true;
+		}
+	}
+	return new_bfqq;
+}
+
 /*
  * Attempt to schedule a merge of bfqq with the currently in-service
  * queue or with a close queue among the scheduled queues.  Return
@@ -2847,7 +2878,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		     void *io_struct, bool request, struct bfq_io_cq *bic)
 {
 	struct bfq_queue *in_service_bfqq, *new_bfqq;
-	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
+	unsigned int a_idx = bfqq->actuator_idx;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
 
 	/* if a merge has already been setup, then proceed with that first */
 	if (bfqq->new_bfqq)
@@ -2877,29 +2909,15 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 					   msecs_to_jiffies(bfq_late_stable_merging))) {
 			struct bfq_queue *stable_merge_bfqq =
 				bfqq_data->stable_merge_bfqq;
-			int proc_ref = min(bfqq_process_refs(bfqq),
-					   bfqq_process_refs(stable_merge_bfqq));
 
 			/* deschedule stable merge, because done or aborted here */
 			bfq_put_stable_ref(stable_merge_bfqq);
 
 			bfqq_data->stable_merge_bfqq = NULL;
 
-			if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
-			    proc_ref > 0) {
-				/* next function will take at least one ref */
-				struct bfq_queue *new_bfqq =
-					bfq_setup_merge(bfqq, stable_merge_bfqq);
-
-				if (new_bfqq) {
-					bfqq_data->stably_merged = true;
-					if (new_bfqq->bic)
-						new_bfqq->bic->bfqq_data.stably_merged =
-							true;
-				}
-				return new_bfqq;
-			} else
-				return NULL;
+			return bfq_setup_stable_merge(bfqd, bfqq,
+						      stable_merge_bfqq,
+						      bfqq_data);
 		}
 	}
 
@@ -2994,7 +3012,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 {
 	struct bfq_io_cq *bic = bfqq->bic;
-	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
+	unsigned int a_idx = bfqq->actuator_idx;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
 
 	/*
 	 * If !bfqq->bic, the queue is already shared or its requests
@@ -3005,7 +3024,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 		return;
 
 	bfqq_data->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
-	bfqq_data->saved_inject_limit = bfqq->inject_limit;
+	bfqq_data->saved_inject_limit =	bfqq->inject_limit;
 	bfqq_data->saved_decrease_time_jif = bfqq->decrease_time_jif;
 
 	bfqq_data->saved_weight = bfqq->entity.orig_weight;
@@ -5372,7 +5391,7 @@ static void bfq_exit_icq(struct io_cq *icq)
 	 * therefore on its unused per-actuator fields being NULL.
 	 */
 	unsigned int num_actuators = BFQ_MAX_ACTUATORS;
-	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
+	struct bfq_iocq_bfqq_data *bfqq_data = bic->bfqq_data;
 
 	/*
 	 * bfqd is NULL if scheduler already exited, and in that case
@@ -5383,10 +5402,10 @@ static void bfq_exit_icq(struct io_cq *icq)
 		num_actuators = bfqd->num_actuators;
 	}
 
-	if (bfqq_data->stable_merge_bfqq)
-		bfq_put_stable_ref(bfqq_data->stable_merge_bfqq);
-
 	for (act_idx = 0; act_idx < num_actuators; act_idx++) {
+		if (bfqq_data[act_idx].stable_merge_bfqq)
+			bfq_put_stable_ref(bfqq_data[act_idx].stable_merge_bfqq);
+
 		bfq_exit_icq_bfqq(bic, true, act_idx);
 		bfq_exit_icq_bfqq(bic, false, act_idx);
 	}
@@ -5573,16 +5592,16 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  struct bfq_io_cq *bic,
 			  struct bfq_queue *last_bfqq_created)
 {
+	unsigned int a_idx = last_bfqq_created->actuator_idx;
 	struct bfq_queue *new_bfqq =
 		bfq_setup_merge(bfqq, last_bfqq_created);
-	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
 
 	if (!new_bfqq)
 		return bfqq;
 
 	if (new_bfqq->bic)
-		new_bfqq->bic->bfqq_data.stably_merged = true;
-	bfqq_data->stably_merged = true;
+		new_bfqq->bic->bfqq_data[a_idx].stably_merged = true;
+	bic->bfqq_data[a_idx].stably_merged = true;
 
 	/*
 	 * Reusing merge functions. This implies that
@@ -5651,7 +5670,6 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 		&bfqd->last_bfqq_created;
 
 	struct bfq_queue *last_bfqq_created = *source_bfqq;
-	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
 
 	/*
 	 * If last_bfqq_created has not been set yet, then init it. If
@@ -5713,7 +5731,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 			/*
 			 * Record the bfqq to merge to.
 			 */
-			bfqq_data->stable_merge_bfqq = last_bfqq_created;
+			bic->bfqq_data[last_bfqq_created->actuator_idx].stable_merge_bfqq =
+				last_bfqq_created;
 		}
 	}
 
@@ -6634,7 +6653,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 {
 	unsigned int act_idx = bfq_actuator_index(bfqd, bio);
 	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, act_idx);
-	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[act_idx];
 
 	if (likely(bfqq && bfqq != &bfqd->oom_bfqq))
 		return bfqq;
@@ -6742,7 +6761,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	struct bfq_queue *bfqq;
 	bool new_queue = false;
 	bool bfqq_already_existing = false, split = false;
-	struct bfq_iocq_bfqq_data *bfqq_data;
+	unsigned int a_idx = bfq_actuator_index(bfqd, bio);
 
 	if (unlikely(!rq->elv.icq))
 		return NULL;
@@ -6766,17 +6785,16 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio, false, is_sync,
 					 &new_queue);
 
-	bfqq_data = &bic->bfqq_data;
-
 	if (likely(!new_queue)) {
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
-			!bfqq_data->stably_merged) {
+			!bic->bfqq_data[a_idx].stably_merged) {
 			struct bfq_queue *old_bfqq = bfqq;
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
-				bfqq_data->saved_in_large_burst = true;
+				bic->bfqq_data[a_idx].saved_in_large_burst =
+					true;
 
 			bfqq = bfq_split_bfqq(bic, bfqq);
 			split = true;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 5d6f738be316..21f72e7203d1 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -416,7 +416,7 @@ struct bfq_queue {
 struct bfq_iocq_bfqq_data {
 	/*
 	 * Snapshot of the has_short_time flag before merging; taken
-	 * to remember its value while the queue is merged, so as to
+	 * to remember its values while the queue is merged, so as to
 	 * be able to restore it in case of split.
 	 */
 	bool saved_has_short_ttime;
@@ -430,7 +430,7 @@ struct bfq_iocq_bfqq_data {
 	u64 saved_tot_idle_time;
 
 	/*
-	 * Same purpose as the previous fields for the value of the
+	 * Same purpose as the previous fields for the values of the
 	 * field keeping the queue's belonging to a large burst
 	 */
 	bool saved_in_large_burst;
@@ -493,8 +493,12 @@ struct bfq_io_cq {
 	uint64_t blkcg_serial_nr; /* the current blkcg serial */
 #endif
 
-	/* persistent data for associated synchronous process queue */
-	struct bfq_iocq_bfqq_data bfqq_data;
+	/*
+	 * Persistent data for associated synchronous process queues
+	 * (one queue per actuator, see field bfqq above). In
+	 * particular, each of these queues may undergo a merge.
+	 */
+	struct bfq_iocq_bfqq_data bfqq_data[BFQ_MAX_ACTUATORS];
 
 	unsigned int requests;	/* Number of requests this process has in flight */
 };
-- 
2.20.1

