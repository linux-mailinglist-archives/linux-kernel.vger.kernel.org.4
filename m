Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CEB606476
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiJTP1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJTP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:27:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C9D1D799B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:27:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f11so35126141wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOn+31mximXGw88FTtnbU7DllPEek+g8kJecNxz5KjE=;
        b=VusxOHdNWislEEHmtINCCPmMwjMLjw8XBie3Jz/VU0i3TYG96wUIuiX5cdZfwXYZUJ
         Gaga4+Ob4vbFzUcVmOOOh8J5v/oX1AY3R64jvHWUuqZt0sD7j+AiSyfgizpbccPk22hT
         Z0ZuHzJUvwPLnnqs8NZ82pWulr5vF/KC/dxtSPhyjW/c2VzIlI6r6yD/Zw0U7Il2fTh/
         m5OaF3rwXT2MAmaSzJDixmrng6q4t+ytzbGnljigFb6jXaO5waWy8VkJ7AqwpC8uNUsw
         toDhbIlmXbzPDwPjzPV6IncociHzIhH8IJiiyUjWLLcLpPe8U20HP3G+rQCilBhMJorp
         yUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOn+31mximXGw88FTtnbU7DllPEek+g8kJecNxz5KjE=;
        b=YcIv8Ve9FoWvBA6/GI0FsB0QU7oHJXCmowRr2b5Z9ZSwe8GK9lzPIuKZtNVfrIVW4E
         4CYkYizerZB6ZAvCl5R6YknnRMl5fmoMBb0BxRmG8+ki702aCIB8awujin9rhw+cd8H6
         mr1FNJKT/dHQcARfyb2ckChHLdYckqKu/zl1kyrPIBg1ng232hI3uZT/nB9nnVbJYumt
         LakVHaIZlCccxUf6c+1110DUx63VTXhJx/gD9egV3dEAGNebqSnSDwv49+zV+LldOZN3
         MAIKfAv6wL62GA8F6yvtzh9kkIqoZM1zpUdlg10il1+JZ5ejzJyXY1Eqasuw6jZnHQRH
         0YQw==
X-Gm-Message-State: ACrzQf2LPFnoToapyOVTIIYOu/+hnq9VqZ4zwMzB+bf/AzwPbnz/uR3O
        OcM28owkYPI0PNfROw7K09kYlw==
X-Google-Smtp-Source: AMsMyM7835igKpCn91JYbJit8ZfG5GRx53WQdA1TwgeX3C1I6kxRWVCtFtYz1glO1DbaqLVRTzFSKw==
X-Received: by 2002:a05:6000:1e14:b0:22e:6224:1e78 with SMTP id bj20-20020a0560001e1400b0022e62241e78mr9421979wrb.56.1666279616930;
        Thu, 20 Oct 2022 08:26:56 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id l10-20020a1ced0a000000b003c409244bb0sm134337wmh.6.2022.10.20.08.26.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 08:26:56 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        glen.valante@linaro.org, arie.vanderhoeven@seagate.com,
        rory.c.chen@seagate.com, Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
Subject: [PATCH V4 3/8] block, bfq: move io_cq-persistent bfqq data into a dedicated struct
Date:   Thu, 20 Oct 2022 17:26:38 +0200
Message-Id: <20221020152643.21199-4-paolo.valente@linaro.org>
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

With a multi-actuator drive, a process may get associated with multiple
bfq_queues: one queue for each of the N actuators. So, the bfq_io_cq
data structure must be able to accommodate its per-queue persistent
information for N queues. Currently it stores this information for
just one queue, in several scalar fields.

This is a preparatory commit for moving to accommodating persistent
information for N queues. In particular, this commit packs all the
above scalar fields into a single data structure. Then there is now
only one fieldi, in bfq_io_cq, that stores all the above information. This
scalar field will then be turned into an array by a following commit.

Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
Signed-off-by: Giulio Barabino <giuliobarabino99@gmail.com>
Signed-off-by: Emiliano Maccaferri <inbox@emilianomaccaferri.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 118 +++++++++++++++++++++++---------------------
 block/bfq-iosched.h |  52 +++++++++++--------
 2 files changed, 94 insertions(+), 76 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 57de6a6a7f06..d2bd94ea2e95 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -406,7 +406,7 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
 	 */
 	bic->bfqq[is_sync][actuator_idx] = bfqq;
 
-	if (bfqq && bic->stable_merge_bfqq == bfqq) {
+	if (bfqq && bic->bfqq_data->stable_merge_bfqq == bfqq) {
 		/*
 		 * Actually, these same instructions are executed also
 		 * in bfq_setup_cooperator, in case of abort or actual
@@ -415,9 +415,9 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
 		 * did so, we would nest even more complexity in this
 		 * function.
 		 */
-		bfq_put_stable_ref(bic->stable_merge_bfqq);
+		bfq_put_stable_ref(bic->bfqq_data->stable_merge_bfqq);
 
-		bic->stable_merge_bfqq = NULL;
+		bic->bfqq_data->stable_merge_bfqq = NULL;
 	}
 }
 
@@ -1177,35 +1177,36 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 	unsigned int old_wr_coeff = 1;
 	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
 
-	if (bic->saved_has_short_ttime)
+	if (bic->bfqq_data->saved_has_short_ttime)
 		bfq_mark_bfqq_has_short_ttime(bfqq);
 	else
 		bfq_clear_bfqq_has_short_ttime(bfqq);
 
-	if (bic->saved_IO_bound)
+	if (bic->bfqq_data->saved_IO_bound)
 		bfq_mark_bfqq_IO_bound(bfqq);
 	else
 		bfq_clear_bfqq_IO_bound(bfqq);
 
-	bfqq->last_serv_time_ns = bic->saved_last_serv_time_ns;
-	bfqq->inject_limit = bic->saved_inject_limit;
-	bfqq->decrease_time_jif = bic->saved_decrease_time_jif;
+	bfqq->last_serv_time_ns = bic->bfqq_data->saved_last_serv_time_ns;
+	bfqq->inject_limit = bic->bfqq_data->saved_inject_limit;
+	bfqq->decrease_time_jif = bic->bfqq_data->saved_decrease_time_jif;
 
-	bfqq->entity.new_weight = bic->saved_weight;
-	bfqq->ttime = bic->saved_ttime;
-	bfqq->io_start_time = bic->saved_io_start_time;
-	bfqq->tot_idle_time = bic->saved_tot_idle_time;
+	bfqq->entity.new_weight = bic->bfqq_data->saved_weight;
+	bfqq->ttime = bic->bfqq_data->saved_ttime;
+	bfqq->io_start_time = bic->bfqq_data->saved_io_start_time;
+	bfqq->tot_idle_time = bic->bfqq_data->saved_tot_idle_time;
 	/*
 	 * Restore weight coefficient only if low_latency is on
 	 */
 	if (bfqd->low_latency) {
 		old_wr_coeff = bfqq->wr_coeff;
-		bfqq->wr_coeff = bic->saved_wr_coeff;
+		bfqq->wr_coeff = bic->bfqq_data->saved_wr_coeff;
 	}
-	bfqq->service_from_wr = bic->saved_service_from_wr;
-	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
-	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
-	bfqq->wr_cur_max_time = bic->saved_wr_cur_max_time;
+	bfqq->service_from_wr = bic->bfqq_data->saved_service_from_wr;
+	bfqq->wr_start_at_switch_to_srt =
+		bic->bfqq_data->saved_wr_start_at_switch_to_srt;
+	bfqq->last_wr_start_finish = bic->bfqq_data->saved_last_wr_start_finish;
+	bfqq->wr_cur_max_time = bic->bfqq_data->saved_wr_cur_max_time;
 
 	if (bfqq->wr_coeff > 1 && (bfq_bfqq_in_large_burst(bfqq) ||
 	    time_is_before_jiffies(bfqq->last_wr_start_finish +
@@ -1878,7 +1879,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	wr_or_deserves_wr = bfqd->low_latency &&
 		(bfqq->wr_coeff > 1 ||
 		 (bfq_bfqq_sync(bfqq) &&
-		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
+		  (bfqq->bic || RQ_BIC(rq)->bfqq_data->stably_merged) &&
 		   (*interactive || soft_rt)));
 
 	/*
@@ -2923,21 +2924,21 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		 * stable merging) also if bic is associated with a
 		 * sync queue, but this bfqq is async
 		 */
-		if (bfq_bfqq_sync(bfqq) && bic->stable_merge_bfqq &&
+		if (bfq_bfqq_sync(bfqq) && bic->bfqq_data->stable_merge_bfqq &&
 		    !bfq_bfqq_just_created(bfqq) &&
 		    time_is_before_jiffies(bfqq->split_time +
 					  msecs_to_jiffies(bfq_late_stable_merging)) &&
 		    time_is_before_jiffies(bfqq->creation_time +
 					   msecs_to_jiffies(bfq_late_stable_merging))) {
 			struct bfq_queue *stable_merge_bfqq =
-				bic->stable_merge_bfqq;
+				bic->bfqq_data->stable_merge_bfqq;
 			int proc_ref = min(bfqq_process_refs(bfqq),
 					   bfqq_process_refs(stable_merge_bfqq));
 
 			/* deschedule stable merge, because done or aborted here */
 			bfq_put_stable_ref(stable_merge_bfqq);
 
-			bic->stable_merge_bfqq = NULL;
+			bic->bfqq_data->stable_merge_bfqq = NULL;
 
 			if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
 			    proc_ref > 0) {
@@ -2946,10 +2947,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 					bfq_setup_merge(bfqq, stable_merge_bfqq);
 
 				if (new_bfqq) {
-					bic->stably_merged = true;
+					bic->bfqq_data->stably_merged = true;
 					if (new_bfqq->bic)
-						new_bfqq->bic->stably_merged =
-									true;
+						new_bfqq->bic->bfqq_data->stably_merged =
+							true;
 				}
 				return new_bfqq;
 			} else
@@ -3057,18 +3058,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	if (!bic)
 		return;
 
-	bic->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
-	bic->saved_inject_limit = bfqq->inject_limit;
-	bic->saved_decrease_time_jif = bfqq->decrease_time_jif;
-
-	bic->saved_weight = bfqq->entity.orig_weight;
-	bic->saved_ttime = bfqq->ttime;
-	bic->saved_has_short_ttime = bfq_bfqq_has_short_ttime(bfqq);
-	bic->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
-	bic->saved_io_start_time = bfqq->io_start_time;
-	bic->saved_tot_idle_time = bfqq->tot_idle_time;
-	bic->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
-	bic->was_in_burst_list = !hlist_unhashed(&bfqq->burst_list_node);
+	bic->bfqq_data->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
+	bic->bfqq_data->saved_inject_limit = bfqq->inject_limit;
+	bic->bfqq_data->saved_decrease_time_jif = bfqq->decrease_time_jif;
+
+	bic->bfqq_data->saved_weight = bfqq->entity.orig_weight;
+	bic->bfqq_data->saved_ttime = bfqq->ttime;
+	bic->bfqq_data->saved_has_short_ttime =
+		bfq_bfqq_has_short_ttime(bfqq);
+	bic->bfqq_data->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
+	bic->bfqq_data->saved_io_start_time = bfqq->io_start_time;
+	bic->bfqq_data->saved_tot_idle_time = bfqq->tot_idle_time;
+	bic->bfqq_data->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
+	bic->bfqq_data->was_in_burst_list =
+		!hlist_unhashed(&bfqq->burst_list_node);
+
 	if (unlikely(bfq_bfqq_just_created(bfqq) &&
 		     !bfq_bfqq_in_large_burst(bfqq) &&
 		     bfqq->bfqd->low_latency)) {
@@ -3081,17 +3085,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 		 * to bfqq, so that to avoid that bfqq unjustly fails
 		 * to enjoy weight raising if split soon.
 		 */
-		bic->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
-		bic->saved_wr_start_at_switch_to_srt = bfq_smallest_from_now();
-		bic->saved_wr_cur_max_time = bfq_wr_duration(bfqq->bfqd);
-		bic->saved_last_wr_start_finish = jiffies;
+		bic->bfqq_data->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
+		bic->bfqq_data->saved_wr_start_at_switch_to_srt =
+			bfq_smallest_from_now();
+		bic->bfqq_data->saved_wr_cur_max_time =
+			bfq_wr_duration(bfqq->bfqd);
+		bic->bfqq_data->saved_last_wr_start_finish = jiffies;
 	} else {
-		bic->saved_wr_coeff = bfqq->wr_coeff;
-		bic->saved_wr_start_at_switch_to_srt =
+		bic->bfqq_data->saved_wr_coeff = bfqq->wr_coeff;
+		bic->bfqq_data->saved_wr_start_at_switch_to_srt =
 			bfqq->wr_start_at_switch_to_srt;
-		bic->saved_service_from_wr = bfqq->service_from_wr;
-		bic->saved_last_wr_start_finish = bfqq->last_wr_start_finish;
-		bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
+		bic->bfqq_data->saved_service_from_wr =
+			bfqq->service_from_wr;
+		bic->bfqq_data->saved_last_wr_start_finish =
+			bfqq->last_wr_start_finish;
+		bic->bfqq_data->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
 	}
 }
 
@@ -5421,8 +5429,8 @@ static void bfq_exit_icq(struct io_cq *icq)
 		spin_lock_irqsave(&bfqd->lock, flags);
 
 	for (act_idx = 0; act_idx < bfqd->num_actuators; act_idx++) {
-		if (bic->stable_merge_bfqq)
-			bfq_put_stable_ref(bic->stable_merge_bfqq);
+		if (bic->bfqq_data->stable_merge_bfqq)
+			bfq_put_stable_ref(bic->bfqq_data->stable_merge_bfqq);
 
 		bfq_exit_icq_bfqq(bic, true, act_idx);
 		bfq_exit_icq_bfqq(bic, false, act_idx);
@@ -5617,8 +5625,8 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		return bfqq;
 
 	if (new_bfqq->bic)
-		new_bfqq->bic->stably_merged = true;
-	bic->stably_merged = true;
+		new_bfqq->bic->bfqq_data->stably_merged = true;
+	bic->bfqq_data->stably_merged = true;
 
 	/*
 	 * Reusing merge functions. This implies that
@@ -5748,7 +5756,7 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 			/*
 			 * Record the bfqq to merge to.
 			 */
-			bic->stable_merge_bfqq = last_bfqq_created;
+			bic->bfqq_data->stable_merge_bfqq = last_bfqq_created;
 		}
 	}
 
@@ -6682,12 +6690,12 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 
 	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
 	if (split && is_sync) {
-		if ((bic->was_in_burst_list && bfqd->large_burst) ||
-		    bic->saved_in_large_burst)
+		if ((bic->bfqq_data->was_in_burst_list && bfqd->large_burst) ||
+		    bic->bfqq_data->saved_in_large_burst)
 			bfq_mark_bfqq_in_large_burst(bfqq);
 		else {
 			bfq_clear_bfqq_in_large_burst(bfqq);
-			if (bic->was_in_burst_list)
+			if (bic->bfqq_data->was_in_burst_list)
 				/*
 				 * If bfqq was in the current
 				 * burst list before being
@@ -6802,12 +6810,12 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	if (likely(!new_queue)) {
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
-			!bic->stably_merged) {
+			!bic->bfqq_data->stably_merged) {
 			struct bfq_queue *old_bfqq = bfqq;
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
-				bic->saved_in_large_burst = true;
+				bic->bfqq_data->saved_in_large_burst = true;
 
 			bfqq = bfq_split_bfqq(bic, bfqq);
 			split = true;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index d98e31be447f..6bc7bed97956 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -415,27 +415,9 @@ struct bfq_queue {
 };
 
 /**
- * struct bfq_io_cq - per (request_queue, io_context) structure.
- */
-struct bfq_io_cq {
-	/* associated io_cq structure */
-	struct io_cq icq; /* must be the first member */
-	/*
-	 * Matrix of associated process queues: first row for async
-	 * queues, second row sync queues. Each row contains one
-	 * column for each actuator. An I/O request generated by the
-	 * process is inserted into the queue pointed by bfqq[i][j] if
-	 * the request is to be served by the j-th actuator of the
-	 * drive, where i==0 or i==1, depending on whether the request
-	 * is async or sync. So there is a distinct queue for each
-	 * actuator.
-	 */
-	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
-	/* per (request_queue, blkcg) ioprio */
-	int ioprio;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	uint64_t blkcg_serial_nr; /* the current blkcg serial */
-#endif
+* struct bfq_data - bfqq data unique and persistent for associated bfq_io_cq
+*/
+struct bfq_iocq_bfqq_data {
 	/*
 	 * Snapshot of the has_short_time flag before merging; taken
 	 * to remember its value while the queue is merged, so as to
@@ -490,6 +472,34 @@ struct bfq_io_cq {
 	struct bfq_queue *stable_merge_bfqq;
 
 	bool stably_merged;	/* non splittable if true */
+};
+
+/**
+ * struct bfq_io_cq - per (request_queue, io_context) structure.
+ */
+struct bfq_io_cq {
+	/* associated io_cq structure */
+	struct io_cq icq; /* must be the first member */
+	/*
+	 * Matrix of associated process queues: first row for async
+	 * queues, second row sync queues. Each row contains one
+	 * column for each actuator. An I/O request generated by the
+	 * process is inserted into the queue pointed by bfqq[i][j] if
+	 * the request is to be served by the j-th actuator of the
+	 * drive, where i==0 or i==1, depending on whether the request
+	 * is async or sync. So there is a distinct queue for each
+	 * actuator.
+	 */
+	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
+	/* per (request_queue, blkcg) ioprio */
+	int ioprio;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	uint64_t blkcg_serial_nr; /* the current blkcg serial */
+#endif
+
+	/* persistent data for associated synchronous process queue */
+	struct bfq_iocq_bfqq_data *bfqq_data;
+
 	unsigned int requests;	/* Number of requests this process has in flight */
 };
 
-- 
2.20.1

