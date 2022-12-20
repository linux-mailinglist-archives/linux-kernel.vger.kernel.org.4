Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C02651E08
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiLTJuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiLTJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:50:28 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A019A1161
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:50:25 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so27914072ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qefety/ju5f+uNjz6Jq3Xt1vUQrBxquQrBlYm++uu2A=;
        b=eF+OXlPsnuKd6f91OITv0zgEnjAPmtyWkfIS2iJIZPupg03/rpDTQZNXg7/xZiWequ
         52t6wN7TNS7xLV7BdZD6ldgvdKT6uFuP3tTg7Fgc9YbAjOdz4kYZLslOiHgISDp+h6Mm
         J1Gcuv0phQG2gwwGVgptKmR6ZF3Skd9+Jg1HjvPXhlBj00CPY/pSmQUNG8bODY6SR/Yc
         VSpM6OYZhPp0r2L7OP3GmrHsLhzqy8awMKQK6dSl4Ea1UMKaenDEMVoRVlN0uAl2xw0j
         bN1ZhcoKoc438dmNEKPI/Sj9gfXzIzBbbBTbd9ahPEovvbcr5siYD5MvrgZbQH7HNP0h
         Mh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qefety/ju5f+uNjz6Jq3Xt1vUQrBxquQrBlYm++uu2A=;
        b=dyrczzCdfsfQvPKCD/0d+lUYrv8e1lfjV3QOTvLlPyY396kJjvbmN0HIPYKSC+j7Dm
         tbn6CDlI6ySsOxgx42ukNCU90DIXpUhRXLsAPaNa81l3fHJ+HuSxWe25TNvaKmXbt3MB
         ZCvVOuMdgI18G/xbyucl6HT8nfi6YMQWY6cVyRSe934OoNSs7C0bVs8cEK4uN1Kce16w
         cUSBmprrvG21Npb6pZ0R06NdMxwSL/TbcBDzElYpMdSqY35b4yenlg4PBXLIrcb8XA76
         OZWH4/OAiPceCfOQgwQhpE13Z9QGgEOFT6QPuuMgu/eD3T47W6elfbrbh13CjvYDI/2E
         4bSg==
X-Gm-Message-State: AFqh2kpjm/5hlaPDoZIPRp+mlFVSiOo8SOnWb91h+4CyEd87kw3FTn9e
        n9myBQo8w4XPCQ7NXY6Lb3nNjA==
X-Google-Smtp-Source: AMrXdXve1wIdYOcNU2tK7lkYCbJsAT7fbqkZE/2mGkvi1jIMsVzXQzzakex4AP+Ho2Zxb8jgqC5kpA==
X-Received: by 2002:a17:907:bd1:b0:835:57c9:6431 with SMTP id ez17-20020a1709070bd100b0083557c96431mr1929137ejc.68.1671529825061;
        Tue, 20 Dec 2022 01:50:25 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0082ea03c395esm1669207ejf.74.2022.12.20.01.50.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:50:24 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
Subject: [PATCH V11 3/8] block, bfq: move io_cq-persistent bfqq data into a dedicated struct
Date:   Tue, 20 Dec 2022 10:50:08 +0100
Message-Id: <20221220095013.55803-4-paolo.valente@linaro.org>
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

With a multi-actuator drive, a process may get associated with multiple
bfq_queues: one queue for each of the N actuators. So, the bfq_io_cq
data structure must be able to accommodate its per-queue persistent
information for N queues. Currently it stores this information for
just one queue, in several scalar fields.

This is a preparatory commit for moving to accommodating persistent
information for N queues. In particular, this commit packs all the
above scalar fields into a single data structure. Then there is now
only one field, in bfq_io_cq, that stores all the above information. This
scalar field will then be turned into an array by a following commit.

Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
Signed-off-by: Giulio Barabino <giuliobarabino99@gmail.com>
Signed-off-by: Emiliano Maccaferri <inbox@emilianomaccaferri.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 130 +++++++++++++++++++++++++-------------------
 block/bfq-iosched.h |  52 +++++++++++-------
 2 files changed, 106 insertions(+), 76 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 79cdc4dbf76c..233f2c3e1103 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -406,12 +406,14 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
 	 * we cancel the stable merge if
 	 * bic->stable_merge_bfqq == bfqq.
 	 */
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
+
 	if (is_sync)
 		bic->bfqq[1][actuator_idx] = bfqq;
 	else
 		bic->bfqq[0][actuator_idx] = bfqq;
 
-	if (bfqq && bic->stable_merge_bfqq == bfqq) {
+	if (bfqq && bfqq_data->stable_merge_bfqq == bfqq) {
 		/*
 		 * Actually, these same instructions are executed also
 		 * in bfq_setup_cooperator, in case of abort or actual
@@ -420,9 +422,9 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
 		 * did so, we would nest even more complexity in this
 		 * function.
 		 */
-		bfq_put_stable_ref(bic->stable_merge_bfqq);
+		bfq_put_stable_ref(bfqq_data->stable_merge_bfqq);
 
-		bic->stable_merge_bfqq = NULL;
+		bfqq_data->stable_merge_bfqq = NULL;
 	}
 }
 
@@ -1127,38 +1129,40 @@ static void
 bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 		      struct bfq_io_cq *bic, bool bfq_already_existing)
 {
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
 	unsigned int old_wr_coeff = 1;
 	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
 
-	if (bic->saved_has_short_ttime)
+	if (bfqq_data->saved_has_short_ttime)
 		bfq_mark_bfqq_has_short_ttime(bfqq);
 	else
 		bfq_clear_bfqq_has_short_ttime(bfqq);
 
-	if (bic->saved_IO_bound)
+	if (bfqq_data->saved_IO_bound)
 		bfq_mark_bfqq_IO_bound(bfqq);
 	else
 		bfq_clear_bfqq_IO_bound(bfqq);
 
-	bfqq->last_serv_time_ns = bic->saved_last_serv_time_ns;
-	bfqq->inject_limit = bic->saved_inject_limit;
-	bfqq->decrease_time_jif = bic->saved_decrease_time_jif;
+	bfqq->last_serv_time_ns = bfqq_data->saved_last_serv_time_ns;
+	bfqq->inject_limit = bfqq_data->saved_inject_limit;
+	bfqq->decrease_time_jif = bfqq_data->saved_decrease_time_jif;
 
-	bfqq->entity.new_weight = bic->saved_weight;
-	bfqq->ttime = bic->saved_ttime;
-	bfqq->io_start_time = bic->saved_io_start_time;
-	bfqq->tot_idle_time = bic->saved_tot_idle_time;
+	bfqq->entity.new_weight = bfqq_data->saved_weight;
+	bfqq->ttime = bfqq_data->saved_ttime;
+	bfqq->io_start_time = bfqq_data->saved_io_start_time;
+	bfqq->tot_idle_time = bfqq_data->saved_tot_idle_time;
 	/*
 	 * Restore weight coefficient only if low_latency is on
 	 */
 	if (bfqd->low_latency) {
 		old_wr_coeff = bfqq->wr_coeff;
-		bfqq->wr_coeff = bic->saved_wr_coeff;
+		bfqq->wr_coeff = bfqq_data->saved_wr_coeff;
 	}
-	bfqq->service_from_wr = bic->saved_service_from_wr;
-	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
-	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
-	bfqq->wr_cur_max_time = bic->saved_wr_cur_max_time;
+	bfqq->service_from_wr = bfqq_data->saved_service_from_wr;
+	bfqq->wr_start_at_switch_to_srt =
+		bfqq_data->saved_wr_start_at_switch_to_srt;
+	bfqq->last_wr_start_finish = bfqq_data->saved_last_wr_start_finish;
+	bfqq->wr_cur_max_time = bfqq_data->saved_wr_cur_max_time;
 
 	if (bfqq->wr_coeff > 1 && (bfq_bfqq_in_large_burst(bfqq) ||
 	    time_is_before_jiffies(bfqq->last_wr_start_finish +
@@ -1843,7 +1847,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	wr_or_deserves_wr = bfqd->low_latency &&
 		(bfqq->wr_coeff > 1 ||
 		 (bfq_bfqq_sync(bfqq) &&
-		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
+		  (bfqq->bic || RQ_BIC(rq)->bfqq_data.stably_merged) &&
 		   (*interactive || soft_rt)));
 
 	/*
@@ -2843,6 +2847,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		     void *io_struct, bool request, struct bfq_io_cq *bic)
 {
 	struct bfq_queue *in_service_bfqq, *new_bfqq;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
 
 	/* if a merge has already been setup, then proceed with that first */
 	if (bfqq->new_bfqq)
@@ -2864,21 +2869,21 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		 * stable merging) also if bic is associated with a
 		 * sync queue, but this bfqq is async
 		 */
-		if (bfq_bfqq_sync(bfqq) && bic->stable_merge_bfqq &&
+		if (bfq_bfqq_sync(bfqq) && bfqq_data->stable_merge_bfqq &&
 		    !bfq_bfqq_just_created(bfqq) &&
 		    time_is_before_jiffies(bfqq->split_time +
 					  msecs_to_jiffies(bfq_late_stable_merging)) &&
 		    time_is_before_jiffies(bfqq->creation_time +
 					   msecs_to_jiffies(bfq_late_stable_merging))) {
 			struct bfq_queue *stable_merge_bfqq =
-				bic->stable_merge_bfqq;
+				bfqq_data->stable_merge_bfqq;
 			int proc_ref = min(bfqq_process_refs(bfqq),
 					   bfqq_process_refs(stable_merge_bfqq));
 
 			/* deschedule stable merge, because done or aborted here */
 			bfq_put_stable_ref(stable_merge_bfqq);
 
-			bic->stable_merge_bfqq = NULL;
+			bfqq_data->stable_merge_bfqq = NULL;
 
 			if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
 			    proc_ref > 0) {
@@ -2887,10 +2892,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 					bfq_setup_merge(bfqq, stable_merge_bfqq);
 
 				if (new_bfqq) {
-					bic->stably_merged = true;
+					bfqq_data->stably_merged = true;
 					if (new_bfqq->bic)
-						new_bfqq->bic->stably_merged =
-									true;
+						new_bfqq->bic->bfqq_data.stably_merged =
+							true;
 				}
 				return new_bfqq;
 			} else
@@ -2989,6 +2994,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 {
 	struct bfq_io_cq *bic = bfqq->bic;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
 
 	/*
 	 * If !bfqq->bic, the queue is already shared or its requests
@@ -2998,18 +3004,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
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
+	bfqq_data->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
+	bfqq_data->saved_inject_limit = bfqq->inject_limit;
+	bfqq_data->saved_decrease_time_jif = bfqq->decrease_time_jif;
+
+	bfqq_data->saved_weight = bfqq->entity.orig_weight;
+	bfqq_data->saved_ttime = bfqq->ttime;
+	bfqq_data->saved_has_short_ttime =
+		bfq_bfqq_has_short_ttime(bfqq);
+	bfqq_data->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
+	bfqq_data->saved_io_start_time = bfqq->io_start_time;
+	bfqq_data->saved_tot_idle_time = bfqq->tot_idle_time;
+	bfqq_data->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
+	bfqq_data->was_in_burst_list =
+		!hlist_unhashed(&bfqq->burst_list_node);
+
 	if (unlikely(bfq_bfqq_just_created(bfqq) &&
 		     !bfq_bfqq_in_large_burst(bfqq) &&
 		     bfqq->bfqd->low_latency)) {
@@ -3022,17 +3031,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 		 * to bfqq, so that to avoid that bfqq unjustly fails
 		 * to enjoy weight raising if split soon.
 		 */
-		bic->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
-		bic->saved_wr_start_at_switch_to_srt = bfq_smallest_from_now();
-		bic->saved_wr_cur_max_time = bfq_wr_duration(bfqq->bfqd);
-		bic->saved_last_wr_start_finish = jiffies;
+		bfqq_data->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
+		bfqq_data->saved_wr_start_at_switch_to_srt =
+			bfq_smallest_from_now();
+		bfqq_data->saved_wr_cur_max_time =
+			bfq_wr_duration(bfqq->bfqd);
+		bfqq_data->saved_last_wr_start_finish = jiffies;
 	} else {
-		bic->saved_wr_coeff = bfqq->wr_coeff;
-		bic->saved_wr_start_at_switch_to_srt =
+		bfqq_data->saved_wr_coeff = bfqq->wr_coeff;
+		bfqq_data->saved_wr_start_at_switch_to_srt =
 			bfqq->wr_start_at_switch_to_srt;
-		bic->saved_service_from_wr = bfqq->service_from_wr;
-		bic->saved_last_wr_start_finish = bfqq->last_wr_start_finish;
-		bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
+		bfqq_data->saved_service_from_wr =
+			bfqq->service_from_wr;
+		bfqq_data->saved_last_wr_start_finish =
+			bfqq->last_wr_start_finish;
+		bfqq_data->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
 	}
 }
 
@@ -5359,6 +5372,7 @@ static void bfq_exit_icq(struct io_cq *icq)
 	 * therefore on its unused per-actuator fields being NULL.
 	 */
 	unsigned int num_actuators = BFQ_MAX_ACTUATORS;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
 
 	/*
 	 * bfqd is NULL if scheduler already exited, and in that case
@@ -5369,8 +5383,8 @@ static void bfq_exit_icq(struct io_cq *icq)
 		num_actuators = bfqd->num_actuators;
 	}
 
-	if (bic->stable_merge_bfqq)
-		bfq_put_stable_ref(bic->stable_merge_bfqq);
+	if (bfqq_data->stable_merge_bfqq)
+		bfq_put_stable_ref(bfqq_data->stable_merge_bfqq);
 
 	for (act_idx = 0; act_idx < num_actuators; act_idx++) {
 		bfq_exit_icq_bfqq(bic, true, act_idx);
@@ -5561,13 +5575,14 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_queue *new_bfqq =
 		bfq_setup_merge(bfqq, last_bfqq_created);
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
 
 	if (!new_bfqq)
 		return bfqq;
 
 	if (new_bfqq->bic)
-		new_bfqq->bic->stably_merged = true;
-	bic->stably_merged = true;
+		new_bfqq->bic->bfqq_data.stably_merged = true;
+	bfqq_data->stably_merged = true;
 
 	/*
 	 * Reusing merge functions. This implies that
@@ -5636,6 +5651,7 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 		&bfqd->last_bfqq_created;
 
 	struct bfq_queue *last_bfqq_created = *source_bfqq;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
 
 	/*
 	 * If last_bfqq_created has not been set yet, then init it. If
@@ -5697,7 +5713,7 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 			/*
 			 * Record the bfqq to merge to.
 			 */
-			bic->stable_merge_bfqq = last_bfqq_created;
+			bfqq_data->stable_merge_bfqq = last_bfqq_created;
 		}
 	}
 
@@ -6618,6 +6634,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 {
 	unsigned int act_idx = bfq_actuator_index(bfqd, bio);
 	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, act_idx);
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
 
 	if (likely(bfqq && bfqq != &bfqd->oom_bfqq))
 		return bfqq;
@@ -6631,12 +6648,12 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 
 	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
 	if (split && is_sync) {
-		if ((bic->was_in_burst_list && bfqd->large_burst) ||
-		    bic->saved_in_large_burst)
+		if ((bfqq_data->was_in_burst_list && bfqd->large_burst) ||
+		    bfqq_data->saved_in_large_burst)
 			bfq_mark_bfqq_in_large_burst(bfqq);
 		else {
 			bfq_clear_bfqq_in_large_burst(bfqq);
-			if (bic->was_in_burst_list)
+			if (bfqq_data->was_in_burst_list)
 				/*
 				 * If bfqq was in the current
 				 * burst list before being
@@ -6725,6 +6742,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	struct bfq_queue *bfqq;
 	bool new_queue = false;
 	bool bfqq_already_existing = false, split = false;
+	struct bfq_iocq_bfqq_data *bfqq_data;
 
 	if (unlikely(!rq->elv.icq))
 		return NULL;
@@ -6748,15 +6766,17 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio, false, is_sync,
 					 &new_queue);
 
+	bfqq_data = &bic->bfqq_data;
+
 	if (likely(!new_queue)) {
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
-			!bic->stably_merged) {
+			!bfqq_data->stably_merged) {
 			struct bfq_queue *old_bfqq = bfqq;
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
-				bic->saved_in_large_burst = true;
+				bfqq_data->saved_in_large_burst = true;
 
 			bfqq = bfq_split_bfqq(bic, bfqq);
 			split = true;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 52b9119389d6..5d6f738be316 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -411,27 +411,9 @@ struct bfq_queue {
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
@@ -486,6 +468,34 @@ struct bfq_io_cq {
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
+	struct bfq_iocq_bfqq_data bfqq_data;
+
 	unsigned int requests;	/* Number of requests this process has in flight */
 };
 
-- 
2.20.1

