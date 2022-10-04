Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD65F3F57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiJDJTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiJDJSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:18:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033242D1CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:18:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l22so16539910edj.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=b6TeUlcCs6MuTTByuNY1DhHnN3DzVLpNcbuJntwSQ4w=;
        b=MntntBf0XZ1Cgh+KYacNCW0SKXPPVmdgFyWcXFsyFoNIVQB4eA2zpY9/4scIo05B7h
         GTNmhj0wMqU+gmhhYpbBvhaqgpNnYgJgv545xsoRd/soWR1Ayt8CipSz62hr4jOZgDDZ
         8NIgGWnWTgA2rBCJqXJD388C95YpLwyKrdGZMlTv0uSytkVNikaekKzqkxkqDxg1kRns
         d6oZkOawDGIMtu6gWMQb7TgTeA9jMoF2E06TGrm+J0WUpTnPFE2gVTOw5Ygy4DYr+haG
         ++YPgmKHZ4gHw1bF4U9UWn3gtNi9+9GJ09d7VjsswMgzVMVhOD/oHAEcdW2zmq1QGUNQ
         76Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b6TeUlcCs6MuTTByuNY1DhHnN3DzVLpNcbuJntwSQ4w=;
        b=jjTg7/pMOIOAnVHc9/SUXdDwY/WT3GBRqUL5DPXbbq8lp4R/+vAz7PRffXf/btWYAJ
         OeIUw8Gyp3famjyfj8opIgHwLwE2vA8RRwaUM1xwRAfjzqPprtwenWXJZHTKA3pnrV1c
         87EpsnYZy7QSDwXGp6JCoeoC05k0bZDIHxEidFqnE1WrVsmdjm+sFmV3W66RpfVJb2vp
         8NPGKmOXmgYxOQW/0zUd8Ndtn2BDfbokN5S61OAMKl8LInCsRGZ0blb9tx1KBoCDmNDH
         TR/Y/2KJVpwIetFARqPdmpZZm9IpplRI2VBZXJQHD3w13WBX01KwW6o7nqc8o/bndXt9
         xYkg==
X-Gm-Message-State: ACrzQf1eD+jCPa7KqPEgPoIW121G/fXDbt+EeWciF8b40cx34DPmkrbk
        1VY2DOp1LQR9ge8RJTGRK2Ndrg==
X-Google-Smtp-Source: AMsMyM4GbwwARCqkWFx2Lgn+cRIntZjPXWji2qu3jW5Zaa7HXz9CuMutUQs6UCgu+Ebu0yc2RU+dyw==
X-Received: by 2002:a05:6402:518d:b0:451:6655:5fb4 with SMTP id q13-20020a056402518d00b0045166555fb4mr22427711edd.150.1664875130552;
        Tue, 04 Oct 2022 02:18:50 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b007826c0a05ecsm6597926ejf.209.2022.10.04.02.18.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:18:49 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 5/8] block, bfq: turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS
Date:   Tue,  4 Oct 2022 11:18:13 +0200
Message-Id: <20221004091816.79799-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004091816.79799-1-paolo.valente@linaro.org>
References: <20221004091816.79799-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit, for the commit that will use independent
access ranges. The latter retrieves the number of ranges, that is the
number of actuators. That number is assumed to be equal at most to
a constant BFQ_MAX_ACTUATORS. Such a constant is defined in this
preparatory icommit. In particular, this commit uses BFQ_MAX_ACTUATORS
in place of the placeholder BFQ_NUM_ACTUATORS, which was introduced in
a previous commit.

The actual commit that uses independet access ranges will then
replace BFQ_MAX_ACTUATORS with the actual number of actuators, where
appropriate.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.c |  8 ++++----
 block/bfq-iosched.h | 48 ++++++++++++++++++++++-----------------------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 6462e8de44db..c5866f57b3aa 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -764,7 +764,7 @@ static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 	struct bfq_entity *entity;
 	unsigned int act_idx;
 
-	for (act_idx = 0; act_idx < BFQ_NUM_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
 		struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0, act_idx);
 		struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1, act_idx);
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index acc2282cf196..99c305df6cce 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -689,7 +689,7 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 		limit = (limit * depth) >> bfqd->full_depth_shift;
 	}
 
-	for (act_idx = 0; act_idx < BFQ_NUM_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
 		struct bfq_queue *bfqq =
 			bic ? bic_to_bfqq(bic, op_is_sync(op), act_idx) : NULL;
 
@@ -2673,7 +2673,7 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 {
 	int i, j, k;
 
-	for (k = 0; k < BFQ_NUM_ACTUATORS; k++) {
+	for (k = 0; k < BFQ_MAX_ACTUATORS; k++) {
 		for (i = 0; i < 2; i++)
 			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
 				if (bfqg->async_bfqq[i][j][k])
@@ -5432,7 +5432,7 @@ static void bfq_exit_icq(struct io_cq *icq)
 	if (bfqd)
 		spin_lock_irqsave(&bfqd->lock, flags);
 
-	for (act_idx = 0; act_idx < BFQ_NUM_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
 		if (bic->stable_merge_bfqq[act_idx])
 			bfq_put_stable_ref(bic->stable_merge_bfqq[act_idx]);
 
@@ -7003,7 +7003,7 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
 	int i, j, k;
 
-	for (k = 0; k < BFQ_NUM_ACTUATORS; k++) {
+	for (k = 0; k < BFQ_MAX_ACTUATORS; k++) {
 		for (i = 0; i < 2; i++)
 			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
 				__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j][k]);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 8862c12e8031..2687e9a85a41 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -33,7 +33,7 @@
  */
 #define BFQ_SOFTRT_WEIGHT_FACTOR	100
 
-#define BFQ_NUM_ACTUATORS 2
+#define BFQ_MAX_ACTUATORS 32
 
 struct bfq_entity;
 
@@ -424,7 +424,7 @@ struct bfq_io_cq {
 	 * is async or sync. So there is a distinct queue for each
 	 * actuator.
 	 */
-	struct bfq_queue *bfqq[2][BFQ_NUM_ACTUATORS];
+	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
 	/* per (request_queue, blkcg) ioprio */
 	int ioprio;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
@@ -442,26 +442,26 @@ struct bfq_io_cq {
 	 * to remember their values while a queue is merged, so as to
 	 * be able to restore them in case of split.
 	 */
-	bool saved_has_short_ttime[BFQ_NUM_ACTUATORS];
+	bool saved_has_short_ttime[BFQ_MAX_ACTUATORS];
 	/*
 	 * Same purpose as the previous two fields for the I/O bound
 	 * classification of a queue.
 	 */
-	bool saved_IO_bound[BFQ_NUM_ACTUATORS];
+	bool saved_IO_bound[BFQ_MAX_ACTUATORS];
 
-	u64 saved_io_start_time[BFQ_NUM_ACTUATORS];
-	u64 saved_tot_idle_time[BFQ_NUM_ACTUATORS];
+	u64 saved_io_start_time[BFQ_MAX_ACTUATORS];
+	u64 saved_tot_idle_time[BFQ_MAX_ACTUATORS];
 
 	/*
 	 * Same purpose as the previous fields for the values of the
 	 * field keeping the queue's belonging to a large burst
 	 */
-	bool saved_in_large_burst[BFQ_NUM_ACTUATORS];
+	bool saved_in_large_burst[BFQ_MAX_ACTUATORS];
 	/*
 	 * True if the queue belonged to a burst list before its merge
 	 * with another cooperating queue.
 	 */
-	bool was_in_burst_list[BFQ_NUM_ACTUATORS];
+	bool was_in_burst_list[BFQ_MAX_ACTUATORS];
 
 	/*
 	 * Save the weight when a merge occurs, to be able
@@ -470,27 +470,27 @@ struct bfq_io_cq {
 	 * then the weight of the recycled queue could differ
 	 * from the weight of the original queue.
 	 */
-	unsigned int saved_weight[BFQ_NUM_ACTUATORS];
+	unsigned int saved_weight[BFQ_MAX_ACTUATORS];
 
 	/*
 	 * Similar to previous fields: save wr information.
 	 */
-	unsigned long saved_wr_coeff[BFQ_NUM_ACTUATORS];
-	unsigned long saved_last_wr_start_finish[BFQ_NUM_ACTUATORS];
-	unsigned long saved_service_from_wr[BFQ_NUM_ACTUATORS];
-	unsigned long saved_wr_start_at_switch_to_srt[BFQ_NUM_ACTUATORS];
-	unsigned int saved_wr_cur_max_time[BFQ_NUM_ACTUATORS];
-	struct bfq_ttime saved_ttime[BFQ_NUM_ACTUATORS];
+	unsigned long saved_wr_coeff[BFQ_MAX_ACTUATORS];
+	unsigned long saved_last_wr_start_finish[BFQ_MAX_ACTUATORS];
+	unsigned long saved_service_from_wr[BFQ_MAX_ACTUATORS];
+	unsigned long saved_wr_start_at_switch_to_srt[BFQ_MAX_ACTUATORS];
+	unsigned int saved_wr_cur_max_time[BFQ_MAX_ACTUATORS];
+	struct bfq_ttime saved_ttime[BFQ_MAX_ACTUATORS];
 
 	/* Save also injection state */
-	u64 saved_last_serv_time_ns[BFQ_NUM_ACTUATORS];
-	unsigned int saved_inject_limit[BFQ_NUM_ACTUATORS];
-	unsigned long saved_decrease_time_jif[BFQ_NUM_ACTUATORS];
+	u64 saved_last_serv_time_ns[BFQ_MAX_ACTUATORS];
+	unsigned int saved_inject_limit[BFQ_MAX_ACTUATORS];
+	unsigned long saved_decrease_time_jif[BFQ_MAX_ACTUATORS];
 
 	/* candidate queue for a stable merge (due to close creation time) */
-	struct bfq_queue *stable_merge_bfqq[BFQ_NUM_ACTUATORS];
+	struct bfq_queue *stable_merge_bfqq[BFQ_MAX_ACTUATORS];
 
-	bool stably_merged[BFQ_NUM_ACTUATORS];	/* non splittable if true */
+	bool stably_merged[BFQ_MAX_ACTUATORS];	/* non splittable if true */
 
 	unsigned int requests;	/* Number of requests this process has in flight */
 };
@@ -961,8 +961,8 @@ struct bfq_group {
 
 	void *bfqd;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_NUM_ACTUATORS];
-	struct bfq_queue *async_idle_bfqq[BFQ_NUM_ACTUATORS];
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct bfq_entity *my_entity;
 
@@ -978,8 +978,8 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_NUM_ACTUATORS];
-	struct bfq_queue *async_idle_bfqq[BFQ_NUM_ACTUATORS];
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct rb_root rq_pos_tree;
 };
-- 
2.20.1

