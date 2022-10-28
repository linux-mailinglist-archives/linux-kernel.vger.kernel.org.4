Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D43610B65
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiJ1Hha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiJ1HhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:37:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF911BC15B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:37:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k8so5872176wrh.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ENYyRamoy8ZlslgxQpSlD1U36+EC0S6QAIMpH75DwoY=;
        b=McbZwsPKlZfVbGKcEq4/662OAB9E+k3f5GdHKRbqIWoXpwDvFzIp+NGqIkEmuuojsM
         9gNIdzoo+Ct9st6crajDxF/HEJYv7ipUNh1EbPDxdWKcH8uVBNOVWH9C+pmDEe1W+Lv6
         x+YJ4oDs1/oqyFthfp7Su9rqEn3XEH+rBPXp9kT1I4DCXzDgZ/zGkfW/HNtAESBY/Uf1
         7ohzrUFED3GuZm8JBpt+Z9c9tSNcENdu7/JPtKqYBMWNuaQvScKhqSuLlvxo0xrCVbta
         /5ZbpHq0MQGBuOZOfsFNIPBsSzMFHrFIjFd2ClyEshxSigUL8VhioiQIpZRABNIv7i4c
         Py7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENYyRamoy8ZlslgxQpSlD1U36+EC0S6QAIMpH75DwoY=;
        b=M3Hd5+NHh5QF1JD8h6GaOxXk1RbVtbLcdtf0TIkjpueBATwVDOIzuadOkN9r9lLiyR
         hTkQu49uwyXYb2W8cOPNVpmWxPGdWXq4k+JNifOGXmBM7dmf+J3XNobl+u1FOcTFIvcC
         p6Qi7NGXju9f142zCIztx1wOoIK/CAHaHKYpC5We+9wyfoQv0NesRhABHlf5Z4fM/sad
         NcCXjmzF5CyJCZT7F5lCh/CGWWIBIzNLYuXrI3Is1qVzu9/Ba1Cs7cD9zfjLTJA9pM/x
         6Ftc6wplQvqAPXxA7cxfO8AL0Vkqdt5NZPKMUAmlVagiz/T8pAH1XPdciK5hbtqewl6I
         ZrQg==
X-Gm-Message-State: ACrzQf0EMwrkMI0pKI2waGsnhnF8brmIJI86XeJ/ZyuynUNBMw9O9OMC
        opCzEYjgLJa5vRKJxS5pFpW4ew==
X-Google-Smtp-Source: AMsMyM4YhnQCBiQyEG4tSfn7TMkkWh0+qGFSr6240Xs9foFf6fqFIovhb7DAD4tP2HilNiE4E645bg==
X-Received: by 2002:adf:e785:0:b0:236:5998:67a0 with SMTP id n5-20020adfe785000000b00236599867a0mr22987923wrm.414.1666942625227;
        Fri, 28 Oct 2022 00:37:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003b47e8a5d22sm7783129wmq.23.2022.10.28.00.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:37:03 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 8/9] sched/fair: Add latency list
Date:   Fri, 28 Oct 2022 09:36:36 +0200
Message-Id: <20221028073637.31195-9-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028073637.31195-1-vincent.guittot@linaro.org>
References: <20221028073637.31195-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a rb tree for latency sensitive entities so we can schedule the most
sensitive one first even when it failed to preempt current at wakeup or
when it got quickly preempted by another entity of higher priority.

In order to keep fairness, the latency is used once at wakeup to get a
minimum slice and not during the following scheduling slice to prevent
long running entity to got more running time than allocated to his nice
priority.

The rb tree enables to cover the last corner case where latency
sensitive entity can't got schedule quickly after the wakeup.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  2 +
 kernel/sched/fair.c   | 96 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h  |  1 +
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a74cad08e91e..0b92674e3664 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -547,6 +547,8 @@ struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
 	struct rb_node			run_node;
+	struct rb_node			latency_node;
+	unsigned int			on_latency;
 	struct list_head		group_node;
 	unsigned int			on_rq;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a7372f80b1ea..c28992b7d1a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -664,7 +664,77 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 
 	return __node_2_se(last);
 }
+#endif
 
+/**************************************************************
+ * Scheduling class tree data structure manipulation methods:
+ * for latency
+ */
+
+static inline bool latency_before(struct sched_entity *a,
+				struct sched_entity *b)
+{
+	return (s64)(a->vruntime + a->latency_offset - b->vruntime - b->latency_offset) < 0;
+}
+
+#define __latency_node_2_se(node) \
+	rb_entry((node), struct sched_entity, latency_node)
+
+static inline bool __latency_less(struct rb_node *a, const struct rb_node *b)
+{
+	return latency_before(__latency_node_2_se(a), __latency_node_2_se(b));
+}
+
+/*
+ * Enqueue an entity into the latency rb-tree:
+ */
+static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+{
+
+	/* Only latency sensitive entity can be added to the list */
+	if (se->latency_offset >= 0)
+		return;
+
+	if (se->on_latency)
+		return;
+
+	/*
+	 * An execution time less than sysctl_sched_min_granularity means that
+	 * the entity has been preempted by a higher sched class or an entity
+	 * with higher latency constraint.
+	 * Put it back in the list so it gets a chance to run 1st during the
+	 * next slice.
+	 */
+	if (!(flags & ENQUEUE_WAKEUP)) {
+		u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+
+		if (delta_exec >= sysctl_sched_min_granularity)
+			return;
+	}
+
+	rb_add_cached(&se->latency_node, &cfs_rq->latency_timeline, __latency_less);
+	se->on_latency = 1;
+}
+
+static void __dequeue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (se->on_latency) {
+		rb_erase_cached(&se->latency_node, &cfs_rq->latency_timeline);
+		se->on_latency = 0;
+	}
+}
+
+static struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *left = rb_first_cached(&cfs_rq->latency_timeline);
+
+	if (!left)
+		return NULL;
+
+	return __latency_node_2_se(left);
+}
+
+#ifdef CONFIG_SCHED_DEBUG
 /**************************************************************
  * Scheduling class statistics methods:
  */
@@ -4439,8 +4509,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
 	check_spread(cfs_rq, se);
-	if (!curr)
+	if (!curr) {
 		__enqueue_entity(cfs_rq, se);
+		__enqueue_latency(cfs_rq, se, flags);
+	}
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -4526,8 +4598,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	clear_buddies(cfs_rq, se);
 
-	if (se != cfs_rq->curr)
+	if (se != cfs_rq->curr) {
 		__dequeue_entity(cfs_rq, se);
+		__dequeue_latency(cfs_rq, se);
+	}
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -4616,6 +4690,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 */
 		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
+		__dequeue_latency(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
 
@@ -4654,7 +4729,7 @@ static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	struct sched_entity *left = __pick_first_entity(cfs_rq);
-	struct sched_entity *se;
+	struct sched_entity *latency, *se;
 
 	/*
 	 * If curr is set we have to see if its left of the leftmost entity
@@ -4696,6 +4771,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 		se = cfs_rq->last;
 	}
 
+	/* Check for latency sensitive entity waiting for running */
+	latency = __pick_first_latency(cfs_rq);
+	if (latency && (latency != se) &&
+	    wakeup_preempt_entity(latency, se) < 1)
+		se = latency;
+
 	return se;
 }
 
@@ -4719,6 +4800,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
+		__enqueue_latency(cfs_rq, prev, 0);
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
@@ -11712,6 +11794,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
+	cfs_rq->latency_timeline = RB_ROOT_CACHED;
 	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
@@ -12020,8 +12103,15 @@ int sched_group_set_latency(struct task_group *tg, s64 latency)
 
 	for_each_possible_cpu(i) {
 		struct sched_entity *se = tg->se[i];
+		struct rq *rq = cpu_rq(i);
+		struct rq_flags rf;
+
+		rq_lock_irqsave(rq, &rf);
 
+		__dequeue_latency(se->cfs_rq, se);
 		WRITE_ONCE(se->latency_offset, latency);
+
+		rq_unlock_irqrestore(rq, &rf);
 	}
 
 	mutex_unlock(&shares_mutex);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b22113c8939b..c8206945868d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -599,6 +599,7 @@ struct cfs_rq {
 #endif
 
 	struct rb_root_cached	tasks_timeline;
+	struct rb_root_cached	latency_timeline;
 
 	/*
 	 * 'curr' points to currently running entity on this cfs_rq.
-- 
2.17.1

