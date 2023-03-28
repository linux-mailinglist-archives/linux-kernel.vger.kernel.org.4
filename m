Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87C6CBD12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjC1LHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjC1LHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8271BE4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=H9x+ShaeP9YoW47hGaGvsVgtEZo3ZxR71JolnNzDIQ8=; b=TYkZFOTPB9o8fat0R9ZFyZPr9I
        toX25dX7KaJ4Q0aIpka2EYarmoXS354x1SwXr4/VtLxoVytg9etPESaikkHnJBhHidg8fp9LYaa2x
        yHXR9QDc3QUhi29HvgVHE2i1l7Jq/ws8DMI9RLWLWFZ1nWv7FRM2eBt7dXzogjLlOyEvKCRMlcZlf
        3Ik+3NDMm4WiY0InOBjRARBKs/cL3YSaB/6NxQTFNkrURAL6zhbA5//Davwz+Niw87HSSW2x8esdA
        OM78VSO0NQ0NcHS2TC36zIunNJWYbSoyU6RHpbIo+lML2tZBiXEVYagSxfGbwuXXkPBeDeGdhIZoh
        qjUwzPwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph79m-006XVB-29;
        Tue, 28 Mar 2023 11:06:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 723D8303283;
        Tue, 28 Mar 2023 13:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 187762CB8D7B0; Tue, 28 Mar 2023 13:06:21 +0200 (CEST)
Message-ID: <20230328110354.780171563@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de
Subject: [PATCH 17/17] [DEBUG] sched/eevdf: Debug / validation crud
References: <20230328092622.062917921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XXX do not merge

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   95 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |    2 +
 2 files changed, 97 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -793,6 +793,92 @@ static inline bool min_deadline_update(s
 RB_DECLARE_CALLBACKS(static, min_deadline_cb, struct sched_entity,
 		     run_node, min_deadline, min_deadline_update);
 
+#ifdef CONFIG_SCHED_DEBUG
+struct validate_data {
+	s64 va;
+	s64 avg_vruntime;
+	s64 avg_load;
+	s64 min_deadline;
+};
+
+static void __print_se(struct cfs_rq *cfs_rq, struct sched_entity *se, int level,
+		       struct validate_data *data)
+{
+	static const char indent[] = "                                           ";
+	unsigned long weight = scale_load_down(se->load.weight);
+	struct task_struct *p = NULL;
+
+	s64 v = se->vruntime - cfs_rq->min_vruntime;
+	s64 d = se->deadline - cfs_rq->min_vruntime;
+
+	data->avg_vruntime += v * weight;
+	data->avg_load += weight;
+
+	data->min_deadline = min(data->min_deadline, d);
+
+	if (entity_is_task(se))
+		p = task_of(se);
+
+	trace_printk("%.*s%lx w: %ld ve: %Ld lag: %Ld vd: %Ld vmd: %Ld %s (%d/%s)\n",
+		     level*2, indent, (unsigned long)se,
+		     weight,
+		     v, data->va - se->vruntime, d,
+		     se->min_deadline - cfs_rq->min_vruntime,
+		     entity_eligible(cfs_rq, se) ? "E" : "N",
+		     p ? p->pid : -1,
+		     p ? p->comm : "(null)");
+}
+
+static void __print_node(struct cfs_rq *cfs_rq, struct rb_node *node, int level,
+			 struct validate_data *data)
+{
+	if (!node)
+		return;
+
+	__print_se(cfs_rq, __node_2_se(node), level, data);
+	__print_node(cfs_rq, node->rb_left, level+1, data);
+	__print_node(cfs_rq, node->rb_right, level+1, data);
+}
+
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq);
+
+static void validate_cfs_rq(struct cfs_rq *cfs_rq, bool pick)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	struct rb_node *root = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct validate_data _data = {
+		.va = avg_vruntime(cfs_rq),
+		.min_deadline = (~0ULL) >> 1,
+	}, *data = &_data;
+
+	trace_printk("---\n");
+
+	__print_node(cfs_rq, root, 0, data);
+
+	trace_printk("min_deadline: %Ld avg_vruntime: %Ld / %Ld = %Ld\n",
+		     data->min_deadline,
+		     data->avg_vruntime, data->avg_load,
+		     data->avg_load ? div_s64(data->avg_vruntime, data->avg_load) : 0);
+
+	if (WARN_ON_ONCE(cfs_rq->avg_vruntime != data->avg_vruntime))
+		cfs_rq->avg_vruntime = data->avg_vruntime;
+
+	if (WARN_ON_ONCE(cfs_rq->avg_load != data->avg_load))
+		cfs_rq->avg_load = data->avg_load;
+
+	data->min_deadline += cfs_rq->min_vruntime;
+	WARN_ON_ONCE(cfs_rq->avg_load && __node_2_se(root)->min_deadline != data->min_deadline);
+
+	if (curr && curr->on_rq)
+		__print_se(cfs_rq, curr, 0, data);
+
+	if (pick)
+		trace_printk("pick: %lx\n", (unsigned long)pick_eevdf(cfs_rq));
+}
+#else
+static inline void validate_cfs_rq(struct cfs_rq *cfs_rq, bool pick) { }
+#endif
+
 /*
  * Enqueue an entity into the rb-tree:
  */
@@ -802,6 +888,9 @@ static void __enqueue_entity(struct cfs_
 	se->min_deadline = se->deadline;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				__entity_less, &min_deadline_cb);
+
+	if (sched_feat(VALIDATE_QUEUE))
+		validate_cfs_rq(cfs_rq, true);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -809,6 +898,9 @@ static void __dequeue_entity(struct cfs_
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_deadline_cb);
 	avg_vruntime_sub(cfs_rq, se);
+
+	if (sched_feat(VALIDATE_QUEUE))
+		validate_cfs_rq(cfs_rq, true);
 }
 
 struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
@@ -894,6 +986,9 @@ static struct sched_entity *pick_eevdf(s
 	if (unlikely(!best)) {
 		struct sched_entity *left = __pick_first_entity(cfs_rq);
 		if (left) {
+			trace_printk("EEVDF scheduling fail, picking leftmost\n");
+			validate_cfs_rq(cfs_rq, false);
+			tracing_off();
 			pr_err("EEVDF scheduling fail, picking leftmost\n");
 			return left;
 		}
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -6,6 +6,8 @@ SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 
 SCHED_FEAT(MINIMAL_VA, false)
 
+SCHED_FEAT(VALIDATE_QUEUE, false)
+
 /*
  * Prefer to schedule the task we woke last (assuming it failed
  * wakeup-preemption), since its likely going to consume data we


