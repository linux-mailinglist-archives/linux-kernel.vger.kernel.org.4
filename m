Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9915B3A3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiIIOAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiIIOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E55E315;
        Fri,  9 Sep 2022 07:00:16 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpPYXWuOujSmNum6cSVks+GWdV/VRVwSdjFzy9t3dhs=;
        b=VvshDv1w+abvyjbXdjkGxolFRaR2KG8t/ohaLt0o+dnOvRv07Yoj71YvqYaqokhzBexSUg
        m7IDjOgw7G7aD60ntd1lA1uRMpbz/CT9p3zTsRlm7tBaldewVZ/UMyn+dEYqHvEq506MY5
        GjZoLUVHcQFSgnQvO89eZxF3ARnifxwZk/XS10oZ5ZzTJlLXpT5i3tursvm4o2acbM4JSE
        4tPxVOamfq2i02kZbE7a1RYru1LdGXVDIbD46A7jB//Kg3I7CbcMIUZFhpZk8q1hU6GFJj
        9JjTNjcUNiIqugi+If0oxS0Dz+GmNXGBT7Ue+vIGEWfTPdD27ifHZpWaTsJdfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpPYXWuOujSmNum6cSVks+GWdV/VRVwSdjFzy9t3dhs=;
        b=c1aPPKsy6QG1mDDulCv1uMVjx4Q6R2gK4iSy5f2b+CsCTgA/kPUwJKNg5P4MGjyt8cVvWv
        SC/PEE3lU6H2VjAg==
From:   "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] sched/psi: Remove NR_ONCPU task accounting
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164111.29534-7-zhouchengming@bytedance.com>
References: <20220825164111.29534-7-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166273201374.401.13286343863016390605.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     71dbdde7914d32e86f01ac1f6e54e964c9dfdbd9
Gitweb:        https://git.kernel.org/tip/71dbdde7914d32e86f01ac1f6e54e964c9dfdbd9
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Fri, 26 Aug 2022 00:41:07 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Sep 2022 11:08:32 +02:00

sched/psi: Remove NR_ONCPU task accounting

We put all fields updated by the scheduler in the first cacheline of
struct psi_group_cpu for performance.

Since we want add another PSI_IRQ_FULL to track IRQ/SOFTIRQ pressure,
we need to reclaim space first. This patch remove NR_ONCPU task accounting
in struct psi_group_cpu, use one bit in state_mask to track instead.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Link: https://lore.kernel.org/r/20220825164111.29534-7-zhouchengming@bytedance.com
---
 include/linux/psi_types.h | 16 ++++++---------
 kernel/sched/psi.c        | 41 +++++++++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index c7fe7c0..54cb749 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -16,13 +16,6 @@ enum psi_task_count {
 	NR_MEMSTALL,
 	NR_RUNNING,
 	/*
-	 * This can't have values other than 0 or 1 and could be
-	 * implemented as a bit flag. But for now we still have room
-	 * in the first cacheline of psi_group_cpu, and this way we
-	 * don't have to special case any state tracking for it.
-	 */
-	NR_ONCPU,
-	/*
 	 * For IO and CPU stalls the presence of running/oncpu tasks
 	 * in the domain means a partial rather than a full stall.
 	 * For memory it's not so simple because of page reclaimers:
@@ -32,16 +25,18 @@ enum psi_task_count {
 	 * threads and memstall ones.
 	 */
 	NR_MEMSTALL_RUNNING,
-	NR_PSI_TASK_COUNTS = 5,
+	NR_PSI_TASK_COUNTS = 4,
 };
 
 /* Task state bitmasks */
 #define TSK_IOWAIT	(1 << NR_IOWAIT)
 #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
 #define TSK_RUNNING	(1 << NR_RUNNING)
-#define TSK_ONCPU	(1 << NR_ONCPU)
 #define TSK_MEMSTALL_RUNNING	(1 << NR_MEMSTALL_RUNNING)
 
+/* Only one task can be scheduled, no corresponding task count */
+#define TSK_ONCPU	(1 << NR_PSI_TASK_COUNTS)
+
 /* Resources that workloads could be stalled on */
 enum psi_res {
 	PSI_IO,
@@ -68,6 +63,9 @@ enum psi_states {
 	NR_PSI_STATES = 7,
 };
 
+/* Use one bit in the state mask to track TSK_ONCPU */
+#define PSI_ONCPU	(1 << NR_PSI_STATES)
+
 enum psi_aggregators {
 	PSI_AVGS = 0,
 	PSI_POLL,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index d71dbc2..4702a77 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -212,7 +212,7 @@ void __init psi_init(void)
 	group_init(&psi_system);
 }
 
-static bool test_state(unsigned int *tasks, enum psi_states state)
+static bool test_state(unsigned int *tasks, enum psi_states state, bool oncpu)
 {
 	switch (state) {
 	case PSI_IO_SOME:
@@ -225,9 +225,9 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 		return unlikely(tasks[NR_MEMSTALL] &&
 			tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
 	case PSI_CPU_SOME:
-		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
+		return unlikely(tasks[NR_RUNNING] > oncpu);
 	case PSI_CPU_FULL:
-		return unlikely(tasks[NR_RUNNING] && !tasks[NR_ONCPU]);
+		return unlikely(tasks[NR_RUNNING] && !oncpu);
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -689,9 +689,9 @@ static void psi_group_change(struct psi_group *group, int cpu,
 			     bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
-	u32 state_mask = 0;
 	unsigned int t, m;
 	enum psi_states s;
+	u32 state_mask;
 
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
@@ -707,17 +707,36 @@ static void psi_group_change(struct psi_group *group, int cpu,
 
 	record_times(groupc, now);
 
+	/*
+	 * Start with TSK_ONCPU, which doesn't have a corresponding
+	 * task count - it's just a boolean flag directly encoded in
+	 * the state mask. Clear, set, or carry the current state if
+	 * no changes are requested.
+	 */
+	if (unlikely(clear & TSK_ONCPU)) {
+		state_mask = 0;
+		clear &= ~TSK_ONCPU;
+	} else if (unlikely(set & TSK_ONCPU)) {
+		state_mask = PSI_ONCPU;
+		set &= ~TSK_ONCPU;
+	} else {
+		state_mask = groupc->state_mask & PSI_ONCPU;
+	}
+
+	/*
+	 * The rest of the state mask is calculated based on the task
+	 * counts. Update those first, then construct the mask.
+	 */
 	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
 		if (!(m & (1 << t)))
 			continue;
 		if (groupc->tasks[t]) {
 			groupc->tasks[t]--;
 		} else if (!psi_bug) {
-			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u %u] clear=%x set=%x\n",
+			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
 					cpu, t, groupc->tasks[0],
 					groupc->tasks[1], groupc->tasks[2],
-					groupc->tasks[3], groupc->tasks[4],
-					clear, set);
+					groupc->tasks[3], clear, set);
 			psi_bug = 1;
 		}
 	}
@@ -726,9 +745,8 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (set & (1 << t))
 			groupc->tasks[t]++;
 
-	/* Calculate state mask representing active states */
 	for (s = 0; s < NR_PSI_STATES; s++) {
-		if (test_state(groupc->tasks, s))
+		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
 			state_mask |= (1 << s);
 	}
 
@@ -740,7 +758,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 * task in a cgroup is in_memstall, the corresponding groupc
 	 * on that cpu is in PSI_MEM_FULL state.
 	 */
-	if (unlikely(groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall))
+	if (unlikely((state_mask & PSI_ONCPU) && cpu_curr(cpu)->in_memstall))
 		state_mask |= (1 << PSI_MEM_FULL);
 
 	groupc->state_mask = state_mask;
@@ -828,7 +846,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 */
 		iter = NULL;
 		while ((group = iterate_groups(next, &iter))) {
-			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
+			    PSI_ONCPU) {
 				common = group;
 				break;
 			}
