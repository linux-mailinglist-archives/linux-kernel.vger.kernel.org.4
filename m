Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA86129DB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJ3KEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJ3KDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:03:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7321A1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:03:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt23so22774177ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a6As9UVgwj6yXvVVDplGTtGvsy9ujSwGGjDgxJRrts=;
        b=eawdJckTVbzkCIQZ9+YQ2zSimtcKcyQ9pF8VtJQM5MQeCtJ8AU6l5ZV7fKJBs+Lnua
         Y/kn6HGxkU2gbPRz9PnUS9y7CUJJja+Y8MtP6C1gaYzXmSOKd4VIxSPRgw7CX/qADpZE
         oASeB/K71mfwwFI4zkqFL9xej8aAgJYn8ILBJbIcEKkU2c1lwPbVB+/u9giAPlm0Qx0o
         woUSqechGR57X/GeWGQQZpXuobjoXaV+paaRZBKj5I9w9UMq1b2dTu+tvFLcHBUiMtWo
         jVdyY2GEYUu+aP7WNBzjKvYSOEn3iEZDMZsdDggu5Ka6Ki0BaIgQ0sqJPT55zK3iEZLf
         56/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5a6As9UVgwj6yXvVVDplGTtGvsy9ujSwGGjDgxJRrts=;
        b=HVxMJ+eRAqQhk0lMWWjK9ATpJh6wlu0QIBiSq/QPR4rCnfD6cb1UUtzQj5cM3x28qG
         7/QursY+60ZsoxxvmD/UTqA7R/z04ZQxlxyeKsWXQ8Yt4Pb+mH43j2+hyT3HyMolukbo
         QlZfXesAcWk8luuBSBoi0cM+uSNuPfZcNVXSBEbxBpdWD81jdY9kPTgvhB22vp5P+trK
         EFIgYrjBi8m5lkFYrFPXWx/ORxL4scI6IRmMGxa+XI4mpwhN25UyRSheXkZ4/pDb5i1d
         fA1rXJW2KUv7dVZ5iAdtuVAah3BY0rOdM+0eX6yEIhZhiMucviLFLK6Z5edixIwj1oD+
         g82w==
X-Gm-Message-State: ACrzQf0hdo2LbWxz9kPJqf/f0XOg6QjXapiiXZykX5C1fbHTAqbbzO0v
        eL8pZoQS4O/CL2tGtOJVmSLF7g==
X-Google-Smtp-Source: AMsMyM4Xg7yIPyhOs9G3PMOkyRBM+6GNXim4zkaMqO8dHsxnSmWy+sxFCm4FMBAt+/NnbhlAjzNRGg==
X-Received: by 2002:a17:907:7621:b0:741:6656:bd14 with SMTP id jy1-20020a170907762100b007416656bd14mr7416763ejc.298.1667124218755;
        Sun, 30 Oct 2022 03:03:38 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id d27-20020a170906305b00b0073d71792c8dsm1666088ejd.180.2022.10.30.03.03.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 03:03:38 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
Subject: [PATCH V5 4/8] block, bfq: turn bfqq_data into an array in bfq_io_cq
Date:   Sun, 30 Oct 2022 11:02:56 +0100
Message-Id: <20221030100300.3085-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221030100300.3085-1-paolo.valente@linaro.org>
References: <20221030100300.3085-1-paolo.valente@linaro.org>
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
 block/bfq-iosched.c | 170 ++++++++++++++++++++++++--------------------
 block/bfq-iosched.h |  12 ++--
 2 files changed, 101 insertions(+), 81 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 139b8f1ba439..bfdf954da5b7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -404,10 +404,10 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
 	 * we cancel the stable merge if
 	 * bic->stable_merge_bfqq == bfqq.
 	 */
-	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[actuator_idx];
 	bic->bfqq[is_sync][actuator_idx] = bfqq;
 
-	if (bfqq && bfqq_data.stable_merge_bfqq == bfqq) {
+	if (bfqq && bfqq_data->stable_merge_bfqq == bfqq) {
 		/*
 		 * Actually, these same instructions are executed also
 		 * in bfq_setup_cooperator, in case of abort or actual
@@ -416,9 +416,9 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
 		 * did so, we would nest even more complexity in this
 		 * function.
 		 */
-		bfq_put_stable_ref(bfqq_data.stable_merge_bfqq);
+		bfq_put_stable_ref(bfqq_data->stable_merge_bfqq);
 
-		bfqq_data.stable_merge_bfqq = NULL;
+		bfqq_data->stable_merge_bfqq = NULL;
 	}
 }
 
@@ -1175,40 +1175,43 @@ static void
 bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 		      struct bfq_io_cq *bic, bool bfq_already_existing)
 {
-	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
 	unsigned int old_wr_coeff = 1;
 	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
+	unsigned int a_idx = bfqq->actuator_idx;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
 
-	if (bfqq_data.saved_has_short_ttime)
+	if (bfqq_data->saved_has_short_ttime)
 		bfq_mark_bfqq_has_short_ttime(bfqq);
 	else
 		bfq_clear_bfqq_has_short_ttime(bfqq);
 
-	if (bfqq_data.saved_IO_bound)
+	if (bfqq_data->saved_IO_bound)
 		bfq_mark_bfqq_IO_bound(bfqq);
 	else
 		bfq_clear_bfqq_IO_bound(bfqq);
 
-	bfqq->last_serv_time_ns = bfqq_data.saved_last_serv_time_ns;
-	bfqq->inject_limit = bfqq_data.saved_inject_limit;
-	bfqq->decrease_time_jif = bfqq_data.saved_decrease_time_jif;
-
-	bfqq->entity.new_weight = bfqq_data.saved_weight;
-	bfqq->ttime = bfqq_data.saved_ttime;
-	bfqq->io_start_time = bfqq_data.saved_io_start_time;
-	bfqq->tot_idle_time = bfqq_data.saved_tot_idle_time;
+	bfqq->last_serv_time_ns =
+		bfqq_data->saved_last_serv_time_ns;
+	bfqq->inject_limit = bfqq_data->saved_inject_limit;
+	bfqq->decrease_time_jif =
+		bfqq_data->saved_decrease_time_jif;
+	bfqq->entity.new_weight = bfqq_data->saved_weight;
+	bfqq->ttime = bfqq_data->saved_ttime;
+	bfqq->io_start_time = bfqq_data->saved_io_start_time;
+	bfqq->tot_idle_time = bfqq_data->saved_tot_idle_time;
 	/*
 	 * Restore weight coefficient only if low_latency is on
 	 */
 	if (bfqd->low_latency) {
 		old_wr_coeff = bfqq->wr_coeff;
-		bfqq->wr_coeff = bfqq_data.saved_wr_coeff;
+		bfqq->wr_coeff = bfqq_data->saved_wr_coeff;
 	}
-	bfqq->service_from_wr = bfqq_data.saved_service_from_wr;
+	bfqq->service_from_wr = bfqq_data->saved_service_from_wr;
 	bfqq->wr_start_at_switch_to_srt =
-		bfqq_data.saved_wr_start_at_switch_to_srt;
-	bfqq->last_wr_start_finish = bfqq_data.saved_last_wr_start_finish;
-	bfqq->wr_cur_max_time = bfqq_data.saved_wr_cur_max_time;
+		bfqq_data->saved_wr_start_at_switch_to_srt;
+	bfqq->last_wr_start_finish =
+		bfqq_data->saved_last_wr_start_finish;
+	bfqq->wr_cur_max_time = bfqq_data->saved_wr_cur_max_time;
 
 	if (bfqq->wr_coeff > 1 && (bfq_bfqq_in_large_burst(bfqq) ||
 	    time_is_before_jiffies(bfqq->last_wr_start_finish +
@@ -1827,6 +1830,16 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
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
@@ -1881,7 +1894,9 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	wr_or_deserves_wr = bfqd->low_latency &&
 		(bfqq->wr_coeff > 1 ||
 		 (bfq_bfqq_sync(bfqq) &&
-		  (bfqq->bic || RQ_BIC(rq)->bfqq_data.stably_merged) &&
+		  (bfqq->bic ||
+		   RQ_BIC(rq)->bfqq_data[bfq_actuator_index(bfqd, rq->bio)]
+		   .stably_merged) &&
 		   (*interactive || soft_rt)));
 
 	/*
@@ -2469,16 +2484,6 @@ static void bfq_remove_request(struct request_queue *q,
 
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
@@ -2905,7 +2910,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		     void *io_struct, bool request, struct bfq_io_cq *bic)
 {
 	struct bfq_queue *in_service_bfqq, *new_bfqq;
-	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
+	unsigned int a_idx = bfqq->actuator_idx;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
 
 	/* if a merge has already been setup, then proceed with that first */
 	if (bfqq->new_bfqq)
@@ -2927,21 +2933,22 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		 * stable merging) also if bic is associated with a
 		 * sync queue, but this bfqq is async
 		 */
-		if (bfq_bfqq_sync(bfqq) && bfqq_data.stable_merge_bfqq &&
+		if (bfq_bfqq_sync(bfqq) &&
+		    bfqq_data->stable_merge_bfqq &&
 		    !bfq_bfqq_just_created(bfqq) &&
 		    time_is_before_jiffies(bfqq->split_time +
 					  msecs_to_jiffies(bfq_late_stable_merging)) &&
 		    time_is_before_jiffies(bfqq->creation_time +
 					   msecs_to_jiffies(bfq_late_stable_merging))) {
 			struct bfq_queue *stable_merge_bfqq =
-				bfqq_data.stable_merge_bfqq;
+				bfqq_data->stable_merge_bfqq;
 			int proc_ref = min(bfqq_process_refs(bfqq),
 					   bfqq_process_refs(stable_merge_bfqq));
 
 			/* deschedule stable merge, because done or aborted here */
 			bfq_put_stable_ref(stable_merge_bfqq);
 
-			bfqq_data.stable_merge_bfqq = NULL;
+			bfqq_data->stable_merge_bfqq = NULL;
 
 			if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
 			    proc_ref > 0) {
@@ -2950,10 +2957,11 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 					bfq_setup_merge(bfqq, stable_merge_bfqq);
 
 				if (new_bfqq) {
-					bfqq_data.stably_merged = true;
+					bfqq_data->stably_merged = true;
 					if (new_bfqq->bic)
-						new_bfqq->bic->bfqq_data.stably_merged =
-							true;
+						new_bfqq->bic->bfqq_data
+							[new_bfqq->actuator_idx]
+							.stably_merged = true;
 				}
 				return new_bfqq;
 			} else
@@ -3052,7 +3060,9 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 {
 	struct bfq_io_cq *bic = bfqq->bic;
-	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
+	/* State must be saved for the right queue index. */
+	unsigned int a_idx = bfqq->actuator_idx;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
 
 	/*
 	 * If !bfqq->bic, the queue is already shared or its requests
@@ -3062,19 +3072,23 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	if (!bic)
 		return;
 
-	bfqq_data.saved_last_serv_time_ns = bfqq->last_serv_time_ns;
-	bfqq_data.saved_inject_limit = bfqq->inject_limit;
-	bfqq_data.saved_decrease_time_jif = bfqq->decrease_time_jif;
+	bfqq_data->saved_last_serv_time_ns =
+		bfqq->last_serv_time_ns;
+	bfqq_data->saved_inject_limit =
+		bfqq->inject_limit;
+	bfqq_data->saved_decrease_time_jif =
+		bfqq->decrease_time_jif;
 
-	bfqq_data.saved_weight = bfqq->entity.orig_weight;
-	bfqq_data.saved_ttime = bfqq->ttime;
-	bfqq_data.saved_has_short_ttime =
+	bfqq_data->saved_weight = bfqq->entity.orig_weight;
+	bfqq_data->saved_ttime = bfqq->ttime;
+	bfqq_data->saved_has_short_ttime =
 		bfq_bfqq_has_short_ttime(bfqq);
-	bfqq_data.saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
-	bfqq_data.saved_io_start_time = bfqq->io_start_time;
-	bfqq_data.saved_tot_idle_time = bfqq->tot_idle_time;
-	bfqq_data.saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
-	bfqq_data.was_in_burst_list =
+	bfqq_data->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
+	bfqq_data->saved_io_start_time = bfqq->io_start_time;
+	bfqq_data->saved_tot_idle_time = bfqq->tot_idle_time;
+	bfqq_data->saved_in_large_burst =
+		bfq_bfqq_in_large_burst(bfqq);
+	bfqq_data->was_in_burst_list =
 		!hlist_unhashed(&bfqq->burst_list_node);
 
 	if (unlikely(bfq_bfqq_just_created(bfqq) &&
@@ -3089,21 +3103,23 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 		 * to bfqq, so that to avoid that bfqq unjustly fails
 		 * to enjoy weight raising if split soon.
 		 */
-		bfqq_data.saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
-		bfqq_data.saved_wr_start_at_switch_to_srt =
+		bfqq_data->saved_wr_coeff =
+			bfqq->bfqd->bfq_wr_coeff;
+		bfqq_data->saved_wr_start_at_switch_to_srt =
 			bfq_smallest_from_now();
-		bfqq_data.saved_wr_cur_max_time =
+		bfqq_data->saved_wr_cur_max_time =
 			bfq_wr_duration(bfqq->bfqd);
-		bfqq_data.saved_last_wr_start_finish = jiffies;
+		bfqq_data->saved_last_wr_start_finish = jiffies;
 	} else {
-		bfqq_data.saved_wr_coeff = bfqq->wr_coeff;
-		bfqq_data.saved_wr_start_at_switch_to_srt =
+		bfqq_data->saved_wr_coeff = bfqq->wr_coeff;
+		bfqq_data->saved_wr_start_at_switch_to_srt =
 			bfqq->wr_start_at_switch_to_srt;
-		bfqq_data.saved_service_from_wr =
+		bfqq_data->saved_service_from_wr =
 			bfqq->service_from_wr;
-		bfqq_data.saved_last_wr_start_finish =
+		bfqq_data->saved_last_wr_start_finish =
 			bfqq->last_wr_start_finish;
-		bfqq_data.saved_wr_cur_max_time = bfqq->wr_cur_max_time;
+		bfqq_data->saved_wr_cur_max_time =
+			bfqq->wr_cur_max_time;
 	}
 }
 
@@ -5425,7 +5441,7 @@ static void bfq_exit_icq(struct io_cq *icq)
 	unsigned long flags;
 	unsigned int act_idx;
 	unsigned int num_actuators;
-	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
+	struct bfq_iocq_bfqq_data *bfqq_data = bic->bfqq_data;
 
 	/*
 	 * bfqd is NULL if scheduler already exited, and in that case
@@ -5445,10 +5461,10 @@ static void bfq_exit_icq(struct io_cq *icq)
 		num_actuators = BFQ_MAX_ACTUATORS;
 	}
 
-	if (bfqq_data.stable_merge_bfqq)
-		bfq_put_stable_ref(bfqq_data.stable_merge_bfqq);
-
 	for (act_idx = 0; act_idx < num_actuators; act_idx++) {
+		if (bfqq_data[act_idx].stable_merge_bfqq)
+			bfq_put_stable_ref(bfqq_data[act_idx].stable_merge_bfqq);
+
 		bfq_exit_icq_bfqq(bic, true, act_idx);
 		bfq_exit_icq_bfqq(bic, false, act_idx);
 	}
@@ -5635,16 +5651,16 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  struct bfq_io_cq *bic,
 			  struct bfq_queue *last_bfqq_created)
 {
+	unsigned int a_idx = last_bfqq_created->actuator_idx;
 	struct bfq_queue *new_bfqq =
 		bfq_setup_merge(bfqq, last_bfqq_created);
-	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
 
 	if (!new_bfqq)
 		return bfqq;
 
 	if (new_bfqq->bic)
-		new_bfqq->bic->bfqq_data.stably_merged = true;
-	bfqq_data.stably_merged = true;
+		new_bfqq->bic->bfqq_data[a_idx].stably_merged = true;
+	bic->bfqq_data[a_idx].stably_merged = true;
 
 	/*
 	 * Reusing merge functions. This implies that
@@ -5713,7 +5729,6 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 		&bfqd->last_bfqq_created;
 
 	struct bfq_queue *last_bfqq_created = *source_bfqq;
-	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
 
 	/*
 	 * If last_bfqq_created has not been set yet, then init it. If
@@ -5775,7 +5790,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 			/*
 			 * Record the bfqq to merge to.
 			 */
-			bfqq_data.stable_merge_bfqq = last_bfqq_created;
+			bic->bfqq_data[last_bfqq_created->actuator_idx].stable_merge_bfqq =
+				last_bfqq_created;
 		}
 	}
 
@@ -6696,7 +6712,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 {
 	unsigned int act_idx = bfq_actuator_index(bfqd, bio);
 	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, act_idx);
-	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[act_idx];
 
 	if (likely(bfqq && bfqq != &bfqd->oom_bfqq))
 		return bfqq;
@@ -6710,12 +6726,13 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 
 	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
 	if (split && is_sync) {
-		if ((bfqq_data.was_in_burst_list && bfqd->large_burst) ||
-		    bfqq_data.saved_in_large_burst)
+		if ((bfqq_data->was_in_burst_list &&
+		     bfqd->large_burst) ||
+		    bfqq_data->saved_in_large_burst)
 			bfq_mark_bfqq_in_large_burst(bfqq);
 		else {
 			bfq_clear_bfqq_in_large_burst(bfqq);
-			if (bfqq_data.was_in_burst_list)
+			if (bfqq_data->was_in_burst_list)
 				/*
 				 * If bfqq was in the current
 				 * burst list before being
@@ -6804,7 +6821,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	struct bfq_queue *bfqq;
 	bool new_queue = false;
 	bool bfqq_already_existing = false, split = false;
-	struct bfq_iocq_bfqq_data bfqq_data;
+	unsigned int a_idx = bfq_actuator_index(bfqd, bio);
 
 	if (unlikely(!rq->elv.icq))
 		return NULL;
@@ -6828,17 +6845,16 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio, false, is_sync,
 					 &new_queue);
 
-	bfqq_data = bic->bfqq_data;
-
 	if (likely(!new_queue)) {
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
-			!bfqq_data.stably_merged) {
+			!bic->bfqq_data[a_idx].stably_merged) {
 			struct bfq_queue *old_bfqq = bfqq;
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
-				bfqq_data.saved_in_large_burst = true;
+				bic->bfqq_data[a_idx].saved_in_large_burst =
+					true;
 
 			bfqq = bfq_split_bfqq(bic, bfqq);
 			split = true;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index f2e8ab91951c..e27897d66a0f 100644
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

