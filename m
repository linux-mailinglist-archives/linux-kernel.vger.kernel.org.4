Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE0C6DE69A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjDKVl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKVlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:41:25 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463ED449E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681249281;
        bh=2YcjaEdF3Fedq8b1d6ChcarV16QJyDOvjmjefjNrqM0=;
        h=From:To:Cc:Subject:Date:From;
        b=NFYhG2g6DP3uKegdxJTT0uDL6yUqQe4sbLtp+QYT0170JR1iingBXp51Yu431L4gU
         yHV0HNnjqP2Av7jO9/6DuX6DAybKw5rqEPuoWnr/G5kfR1jHCzy7HSm5zFcPGNGiS7
         Gp8ZBah1lE1fcdjDiWHrY5gfe2J6J/LzeIWOApxUl/+fhdqOR8mt70F2OhZeIAI+Td
         20xqmEgAipMrlODn0sacElkQh+E7Z9fdgCF8e7KkiuyIFr1tLsQ/hwgQ+hm4EeLYl1
         etuiYtQvidivmSvtfDZRXQaoS5u5iwIJhArmowey8p9va0fmkDW6kDxIUt2iCnzA3f
         DAopk9XaYyhKA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Pwzmx1MPFztwD;
        Tue, 11 Apr 2023 17:41:21 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com
Subject: [RFC PATCH] sched: Rate limit migrations
Date:   Tue, 11 Apr 2023 17:41:16 -0400
Message-Id: <20230411214116.361016-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This WIP patch rate-limits migrations to 32 migrations per 10ms window
for each task.

The specific migration count and window size can be changed with the
following defines in kernel/sched/sched.h:

- SCHED_MIGRATION_WINDOW_NS
- SCHED_MIGRATION_LIMIT

Testing is welcome, especially to see if it helps with Aaron's
migration-heavy workload wrt rseq concurrency id performance
regression.

Link: https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Olivier Dion <odion@efficios.com>
Cc: michael.christie@oracle.com
---
 include/linux/sched.h |  9 +++++++++
 kernel/fork.c         |  3 +++
 kernel/sched/core.c   | 42 ++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h  |  7 +++++++
 4 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 48d48b2c73a5..bfd5e268900c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1316,6 +1316,15 @@ struct task_struct {
 	int				last_mm_cid;	/* Most recent cid in mm */
 	int				mm_cid_active;	/* Whether cid bitmap is active */
 #endif
+	/*
+	 * Keep track of last migration time to compare sched_clock
+	 * locally from a single CPU perspective.
+	 */
+	u64				last_migration_time;
+	/* Time slice used in current migration window. */
+	u64				migration_window_time_slice;
+	/* Number of migrations in current migration window. */
+	u32				migration_count;
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 3832bea713c4..791792a218f6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1061,6 +1061,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->last_mm_cid = -1;
 	tsk->mm_cid_active = 0;
 #endif
+	tsk->last_migration_time = 0;
+	tsk->migration_window_time_slice = 0;
+	tsk->migration_count = 0;
 	return tsk;
 
 free_stack:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2aac6f14f21c..a530727b11f3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2087,6 +2087,7 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
 	if (task_on_rq_migrating(p)) {
 		flags |= ENQUEUE_MIGRATED;
 		sched_mm_cid_migrate_to(rq, p);
+		p->last_migration_time = sched_clock();
 	}
 
 	enqueue_task(rq, p, flags);
@@ -3547,17 +3548,47 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 	return dest_cpu;
 }
 
+static inline
+bool migration_allowed(struct task_struct *p, u64 current_time)
+{
+	u64 delta = current_time - p->last_migration_time;
+
+	if (delta + p->migration_window_time_slice > SCHED_MIGRATION_WINDOW_NS ||
+	    p->migration_count < SCHED_MIGRATION_LIMIT)
+		return true;
+	return false;
+}
+
+static inline
+void migration_add_delta_to_slice(struct task_struct *p, u64 current_time)
+{
+	u64 delta = current_time - p->last_migration_time;
+
+	if (delta + p->migration_window_time_slice > SCHED_MIGRATION_WINDOW_NS) {
+		/* Reset the migration window if it has ended. */
+		p->migration_window_time_slice = 0;
+		p->migration_count = 0;
+		return;
+	}
+	p->migration_window_time_slice += delta;
+	p->migration_count++;
+}
+
 /*
  * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
  */
 static inline
-int select_task_rq(struct task_struct *p, int cpu, int wake_flags)
+int select_task_rq(struct task_struct *p, int prev_cpu, int wake_flags)
 {
+	u64 current_time = sched_clock();
+	int cpu = prev_cpu;
+
 	lockdep_assert_held(&p->pi_lock);
 
-	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p))
-		cpu = p->sched_class->select_task_rq(p, cpu, wake_flags);
-	else
+	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p)) {
+		if (migration_allowed(p, current_time))
+			cpu = p->sched_class->select_task_rq(p, cpu, wake_flags);
+	} else
 		cpu = cpumask_any(p->cpus_ptr);
 
 	/*
@@ -3573,6 +3604,9 @@ int select_task_rq(struct task_struct *p, int cpu, int wake_flags)
 	if (unlikely(!is_cpu_allowed(p, cpu)))
 		cpu = select_fallback_rq(task_cpu(p), p);
 
+	if (prev_cpu != cpu)
+		migration_add_delta_to_slice(p, current_time);
+
 	return cpu;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 64220134fb45..e52cc38f10fc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -104,6 +104,13 @@ struct cpuidle_state;
 #define TASK_ON_RQ_QUEUED	1
 #define TASK_ON_RQ_MIGRATING	2
 
+/*
+ * A task can be migrated at most SCHED_MIGRATION_WINDOW_LIMIT times per
+ * sched-migration window.
+ */
+#define SCHED_MIGRATION_WINDOW_NS	(10ULL * 1000000)	/* 10 ms */
+#define SCHED_MIGRATION_LIMIT		32
+
 extern __read_mostly int scheduler_running;
 
 extern unsigned long calc_load_update;
-- 
2.25.1

