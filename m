Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00BE6129D8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiJ3KDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJ3KDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:03:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C6A1A0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:03:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x2so13733176edd.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tB9eObh3Vne5izy9wSWj1GaOcjX6R5NF7vt6yMovsw=;
        b=X+Wfh5H/RZeSi8Kt7fTrGwLqbc/NnXXmiagL5glKrMG0MZ0sGc4b8HpO/zrq//6pbb
         pNrzaLbzr8iudfQLhFBJd0uWvk/C1mHLx6ODggUzUnocmHQzWIEZHfoXyXI/imePL+vD
         cnYLO6C//y6Gy3f+AgXlrX6fj8X5JRPSdNqAKpdFs9UWCIX36fLbR5OydeAsw/Y0/uVj
         3kBVgLjOUUL/eAzI9dre0itnsARyJa9a6tiGQmDPYfPegq5qNUSMF/2O6qo2rIF2OSsM
         FmgHEbXRqsQh5Vz9z2VdHtYHNCiD+JZj7TpU1vt2yFiMnamHaaqH37fh/5eAzD8vC6J9
         rmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tB9eObh3Vne5izy9wSWj1GaOcjX6R5NF7vt6yMovsw=;
        b=OjQYOlYhLa6NqjmLUfHUr1TmS1PHppk0L986aovWJDLpb7Sr+i8qmCWz4mnYCJP07K
         0znvwB5X3kWdghx2puEWNFFlyB+VsmVzrdYGQNWSrbkG+vwfKtu82csMC/6GgeA8hrTy
         0XAjp4ZVb1FTkr2NQvWYPh8FzzOYn3WTtafAQxW/1YJgzrflOX8ga486hRIrm7JKkehN
         Z6fFEjSbk1w+/EyGuYciHO8sO38gIoLC81te7w5mPljRd6of762SZZEydOHtz3gPqdqy
         9liTGDuJvMVtGPmg6FgZvtB8f2TxaYti95gTEGN6VqMv47usHCiejx4zhzKOmJh22Xmx
         24zg==
X-Gm-Message-State: ACrzQf1fJC8rLSnLpMUIBKGYVP41xpAqLL86j3/ZgFKgJqVrN3o/MnWG
        IOmL1DiOb1DyrtKp0LejjgyaCQ==
X-Google-Smtp-Source: AMsMyM4gf9USHZSnDacnwPwQOiSdPyU/M1mh/FvolmY/yq9+Fvf9G3g/zWYazoUzh/qvqSz5/eVD1A==
X-Received: by 2002:a05:6402:440d:b0:450:de54:3fcf with SMTP id y13-20020a056402440d00b00450de543fcfmr7914149eda.312.1667124217377;
        Sun, 30 Oct 2022 03:03:37 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id d27-20020a170906305b00b0073d71792c8dsm1666088ejd.180.2022.10.30.03.03.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 03:03:36 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
Subject: [PATCH V5 3/8] block, bfq: move io_cq-persistent bfqq data into a dedicated struct
Date:   Sun, 30 Oct 2022 11:02:55 +0100
Message-Id: <20221030100300.3085-4-paolo.valente@linaro.org>
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
 block/bfq-iosched.c | 129 +++++++++++++++++++++++++-------------------
 block/bfq-iosched.h |  52 ++++++++++--------
 2 files changed, 105 insertions(+), 76 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ec4b0e70265f..139b8f1ba439 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -404,9 +404,10 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
 	 * we cancel the stable merge if
 	 * bic->stable_merge_bfqq == bfqq.
 	 */
+	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
 	bic->bfqq[is_sync][actuator_idx] = bfqq;
 
-	if (bfqq && bic->stable_merge_bfqq == bfqq) {
+	if (bfqq && bfqq_data.stable_merge_bfqq == bfqq) {
 		/*
 		 * Actually, these same instructions are executed also
 		 * in bfq_setup_cooperator, in case of abort or actual
@@ -415,9 +416,9 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
 		 * did so, we would nest even more complexity in this
 		 * function.
 		 */
-		bfq_put_stable_ref(bic->stable_merge_bfqq);
+		bfq_put_stable_ref(bfqq_data.stable_merge_bfqq);
 
-		bic->stable_merge_bfqq = NULL;
+		bfqq_data.stable_merge_bfqq = NULL;
 	}
 }
 
@@ -1174,38 +1175,40 @@ static void
 bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 		      struct bfq_io_cq *bic, bool bfq_already_existing)
 {
+	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
 	unsigned int old_wr_coeff = 1;
 	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
 
-	if (bic->saved_has_short_ttime)
+	if (bfqq_data.saved_has_short_ttime)
 		bfq_mark_bfqq_has_short_ttime(bfqq);
 	else
 		bfq_clear_bfqq_has_short_ttime(bfqq);
 
-	if (bic->saved_IO_bound)
+	if (bfqq_data.saved_IO_bound)
 		bfq_mark_bfqq_IO_bound(bfqq);
 	else
 		bfq_clear_bfqq_IO_bound(bfqq);
 
-	bfqq->last_serv_time_ns = bic->saved_last_serv_time_ns;
-	bfqq->inject_limit = bic->saved_inject_limit;
-	bfqq->decrease_time_jif = bic->saved_decrease_time_jif;
+	bfqq->last_serv_time_ns = bfqq_data.saved_last_serv_time_ns;
+	bfqq->inject_limit = bfqq_data.saved_inject_limit;
+	bfqq->decrease_time_jif = bfqq_data.saved_decrease_time_jif;
 
-	bfqq->entity.new_weight = bic->saved_weight;
-	bfqq->ttime = bic->saved_ttime;
-	bfqq->io_start_time = bic->saved_io_start_time;
-	bfqq->tot_idle_time = bic->saved_tot_idle_time;
+	bfqq->entity.new_weight = bfqq_data.saved_weight;
+	bfqq->ttime = bfqq_data.saved_ttime;
+	bfqq->io_start_time = bfqq_data.saved_io_start_time;
+	bfqq->tot_idle_time = bfqq_data.saved_tot_idle_time;
 	/*
 	 * Restore weight coefficient only if low_latency is on
 	 */
 	if (bfqd->low_latency) {
 		old_wr_coeff = bfqq->wr_coeff;
-		bfqq->wr_coeff = bic->saved_wr_coeff;
+		bfqq->wr_coeff = bfqq_data.saved_wr_coeff;
 	}
-	bfqq->service_from_wr = bic->saved_service_from_wr;
-	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
-	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
-	bfqq->wr_cur_max_time = bic->saved_wr_cur_max_time;
+	bfqq->service_from_wr = bfqq_data.saved_service_from_wr;
+	bfqq->wr_start_at_switch_to_srt =
+		bfqq_data.saved_wr_start_at_switch_to_srt;
+	bfqq->last_wr_start_finish = bfqq_data.saved_last_wr_start_finish;
+	bfqq->wr_cur_max_time = bfqq_data.saved_wr_cur_max_time;
 
 	if (bfqq->wr_coeff > 1 && (bfq_bfqq_in_large_burst(bfqq) ||
 	    time_is_before_jiffies(bfqq->last_wr_start_finish +
@@ -1878,7 +1881,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	wr_or_deserves_wr = bfqd->low_latency &&
 		(bfqq->wr_coeff > 1 ||
 		 (bfq_bfqq_sync(bfqq) &&
-		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
+		  (bfqq->bic || RQ_BIC(rq)->bfqq_data.stably_merged) &&
 		   (*interactive || soft_rt)));
 
 	/*
@@ -2902,6 +2905,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		     void *io_struct, bool request, struct bfq_io_cq *bic)
 {
 	struct bfq_queue *in_service_bfqq, *new_bfqq;
+	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
 
 	/* if a merge has already been setup, then proceed with that first */
 	if (bfqq->new_bfqq)
@@ -2923,21 +2927,21 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		 * stable merging) also if bic is associated with a
 		 * sync queue, but this bfqq is async
 		 */
-		if (bfq_bfqq_sync(bfqq) && bic->stable_merge_bfqq &&
+		if (bfq_bfqq_sync(bfqq) && bfqq_data.stable_merge_bfqq &&
 		    !bfq_bfqq_just_created(bfqq) &&
 		    time_is_before_jiffies(bfqq->split_time +
 					  msecs_to_jiffies(bfq_late_stable_merging)) &&
 		    time_is_before_jiffies(bfqq->creation_time +
 					   msecs_to_jiffies(bfq_late_stable_merging))) {
 			struct bfq_queue *stable_merge_bfqq =
-				bic->stable_merge_bfqq;
+				bfqq_data.stable_merge_bfqq;
 			int proc_ref = min(bfqq_process_refs(bfqq),
 					   bfqq_process_refs(stable_merge_bfqq));
 
 			/* deschedule stable merge, because done or aborted here */
 			bfq_put_stable_ref(stable_merge_bfqq);
 
-			bic->stable_merge_bfqq = NULL;
+			bfqq_data.stable_merge_bfqq = NULL;
 
 			if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
 			    proc_ref > 0) {
@@ -2946,10 +2950,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 					bfq_setup_merge(bfqq, stable_merge_bfqq);
 
 				if (new_bfqq) {
-					bic->stably_merged = true;
+					bfqq_data.stably_merged = true;
 					if (new_bfqq->bic)
-						new_bfqq->bic->stably_merged =
-									true;
+						new_bfqq->bic->bfqq_data.stably_merged =
+							true;
 				}
 				return new_bfqq;
 			} else
@@ -3048,6 +3052,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 {
 	struct bfq_io_cq *bic = bfqq->bic;
+	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
 
 	/*
 	 * If !bfqq->bic, the queue is already shared or its requests
@@ -3057,18 +3062,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
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
+	bfqq_data.saved_last_serv_time_ns = bfqq->last_serv_time_ns;
+	bfqq_data.saved_inject_limit = bfqq->inject_limit;
+	bfqq_data.saved_decrease_time_jif = bfqq->decrease_time_jif;
+
+	bfqq_data.saved_weight = bfqq->entity.orig_weight;
+	bfqq_data.saved_ttime = bfqq->ttime;
+	bfqq_data.saved_has_short_ttime =
+		bfq_bfqq_has_short_ttime(bfqq);
+	bfqq_data.saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
+	bfqq_data.saved_io_start_time = bfqq->io_start_time;
+	bfqq_data.saved_tot_idle_time = bfqq->tot_idle_time;
+	bfqq_data.saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
+	bfqq_data.was_in_burst_list =
+		!hlist_unhashed(&bfqq->burst_list_node);
+
 	if (unlikely(bfq_bfqq_just_created(bfqq) &&
 		     !bfq_bfqq_in_large_burst(bfqq) &&
 		     bfqq->bfqd->low_latency)) {
@@ -3081,17 +3089,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 		 * to bfqq, so that to avoid that bfqq unjustly fails
 		 * to enjoy weight raising if split soon.
 		 */
-		bic->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
-		bic->saved_wr_start_at_switch_to_srt = bfq_smallest_from_now();
-		bic->saved_wr_cur_max_time = bfq_wr_duration(bfqq->bfqd);
-		bic->saved_last_wr_start_finish = jiffies;
+		bfqq_data.saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
+		bfqq_data.saved_wr_start_at_switch_to_srt =
+			bfq_smallest_from_now();
+		bfqq_data.saved_wr_cur_max_time =
+			bfq_wr_duration(bfqq->bfqd);
+		bfqq_data.saved_last_wr_start_finish = jiffies;
 	} else {
-		bic->saved_wr_coeff = bfqq->wr_coeff;
-		bic->saved_wr_start_at_switch_to_srt =
+		bfqq_data.saved_wr_coeff = bfqq->wr_coeff;
+		bfqq_data.saved_wr_start_at_switch_to_srt =
 			bfqq->wr_start_at_switch_to_srt;
-		bic->saved_service_from_wr = bfqq->service_from_wr;
-		bic->saved_last_wr_start_finish = bfqq->last_wr_start_finish;
-		bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
+		bfqq_data.saved_service_from_wr =
+			bfqq->service_from_wr;
+		bfqq_data.saved_last_wr_start_finish =
+			bfqq->last_wr_start_finish;
+		bfqq_data.saved_wr_cur_max_time = bfqq->wr_cur_max_time;
 	}
 }
 
@@ -5413,6 +5425,7 @@ static void bfq_exit_icq(struct io_cq *icq)
 	unsigned long flags;
 	unsigned int act_idx;
 	unsigned int num_actuators;
+	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
 
 	/*
 	 * bfqd is NULL if scheduler already exited, and in that case
@@ -5432,8 +5445,8 @@ static void bfq_exit_icq(struct io_cq *icq)
 		num_actuators = BFQ_MAX_ACTUATORS;
 	}
 
-	if (bic->stable_merge_bfqq)
-		bfq_put_stable_ref(bic->stable_merge_bfqq);
+	if (bfqq_data.stable_merge_bfqq)
+		bfq_put_stable_ref(bfqq_data.stable_merge_bfqq);
 
 	for (act_idx = 0; act_idx < num_actuators; act_idx++) {
 		bfq_exit_icq_bfqq(bic, true, act_idx);
@@ -5624,13 +5637,14 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_queue *new_bfqq =
 		bfq_setup_merge(bfqq, last_bfqq_created);
+	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
 
 	if (!new_bfqq)
 		return bfqq;
 
 	if (new_bfqq->bic)
-		new_bfqq->bic->stably_merged = true;
-	bic->stably_merged = true;
+		new_bfqq->bic->bfqq_data.stably_merged = true;
+	bfqq_data.stably_merged = true;
 
 	/*
 	 * Reusing merge functions. This implies that
@@ -5699,6 +5713,7 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 		&bfqd->last_bfqq_created;
 
 	struct bfq_queue *last_bfqq_created = *source_bfqq;
+	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
 
 	/*
 	 * If last_bfqq_created has not been set yet, then init it. If
@@ -5760,7 +5775,7 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 			/*
 			 * Record the bfqq to merge to.
 			 */
-			bic->stable_merge_bfqq = last_bfqq_created;
+			bfqq_data.stable_merge_bfqq = last_bfqq_created;
 		}
 	}
 
@@ -6681,6 +6696,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 {
 	unsigned int act_idx = bfq_actuator_index(bfqd, bio);
 	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, act_idx);
+	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
 
 	if (likely(bfqq && bfqq != &bfqd->oom_bfqq))
 		return bfqq;
@@ -6694,12 +6710,12 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 
 	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
 	if (split && is_sync) {
-		if ((bic->was_in_burst_list && bfqd->large_burst) ||
-		    bic->saved_in_large_burst)
+		if ((bfqq_data.was_in_burst_list && bfqd->large_burst) ||
+		    bfqq_data.saved_in_large_burst)
 			bfq_mark_bfqq_in_large_burst(bfqq);
 		else {
 			bfq_clear_bfqq_in_large_burst(bfqq);
-			if (bic->was_in_burst_list)
+			if (bfqq_data.was_in_burst_list)
 				/*
 				 * If bfqq was in the current
 				 * burst list before being
@@ -6788,6 +6804,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	struct bfq_queue *bfqq;
 	bool new_queue = false;
 	bool bfqq_already_existing = false, split = false;
+	struct bfq_iocq_bfqq_data bfqq_data;
 
 	if (unlikely(!rq->elv.icq))
 		return NULL;
@@ -6811,15 +6828,17 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio, false, is_sync,
 					 &new_queue);
 
+	bfqq_data = bic->bfqq_data;
+
 	if (likely(!new_queue)) {
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
-			!bic->stably_merged) {
+			!bfqq_data.stably_merged) {
 			struct bfq_queue *old_bfqq = bfqq;
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
-				bic->saved_in_large_burst = true;
+				bfqq_data.saved_in_large_burst = true;
 
 			bfqq = bfq_split_bfqq(bic, bfqq);
 			split = true;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index bfcbd8ea9000..f2e8ab91951c 100644
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

