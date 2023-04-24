Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6176D93A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbjDFKFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbjDFKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:05:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E321BEF;
        Thu,  6 Apr 2023 03:05:19 -0700 (PDT)
Date:   Thu, 06 Apr 2023 10:05:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680775517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SSAPc9Ucf2h9e1oZ/IebzqAwUw+Yd7HOfFSEQl+kuww=;
        b=BnAGfacM5zCiEn0xZF3A4sd7aDeoGANGBKn6LV/RXTh+ygBnB3iAlDi/y2ExONaN7zatCz
        vhUzpksTRfv8eENsGJjOXdjy4maWCelD9xS1trrAQIywovBzEjzfQue4c8MeaySvA7QDH7
        CJVgAJR7q1m9f/thWZWkzEt7yX2/m0P+Ar0s8vKkf1zgRiwiEJPCrN3xqTS7hfN677jXW0
        awjEochKxxkGBf41A5NN2QqlXfaSYzn84nCXPLVoAVGOQqUo9oeUBRu1VhY7+j+RTjnZJR
        Y2u4Ubo4ARyzeBABKcwNNmV95d+V7fQJgzkcsbl8Nz9bOCJimtvb9K5e9JUZog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680775517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SSAPc9Ucf2h9e1oZ/IebzqAwUw+Yd7HOfFSEQl+kuww=;
        b=Hu6UCHqnfqWISLUzDT1l9h4v92E2qoLI1Kdv1ylhiJcAS0/USeXZlEDm4T1mVUQ8uiS+9b
        4RSOSixVZxSOm2BA==
From:   "tip-bot2 for Domenico Cerasuolo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Allow unprivileged polling of N*2s period
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230330105418.77061-5-cerasuolodomenico@gmail.com>
References: <20230330105418.77061-5-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Message-ID: <168077551711.404.11196810994528776584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d82caa273565b45fcf103148950549af76c314b0
Gitweb:        https://git.kernel.org/tip/d82caa273565b45fcf103148950549af76c314b0
Author:        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
AuthorDate:    Thu, 30 Mar 2023 12:54:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Apr 2023 09:58:50 +02:00

sched/psi: Allow unprivileged polling of N*2s period

PSI offers 2 mechanisms to get information about a specific resource
pressure. One is reading from /proc/pressure/<resource>, which gives
average pressures aggregated every 2s. The other is creating a pollable
fd for a specific resource and cgroup.

The trigger creation requires CAP_SYS_RESOURCE, and gives the
possibility to pick specific time window and threshold, spawing an RT
thread to aggregate the data.

Systemd would like to provide containers the option to monitor pressure
on their own cgroup and sub-cgroups. For example, if systemd launches a
container that itself then launches services, the container should have
the ability to poll() for pressure in individual services. But neither
the container nor the services are privileged.

This patch implements a mechanism to allow unprivileged users to create
pressure triggers. The difference with privileged triggers creation is
that unprivileged ones must have a time window that's a multiple of 2s.
This is so that we can avoid unrestricted spawning of rt threads, and
use instead the same aggregation mechanism done for the averages, which
runs independently of any triggers.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20230330105418.77061-5-cerasuolodomenico@gmail.com
---
 Documentation/accounting/psi.rst |   4 +-
 include/linux/psi.h              |   2 +-
 include/linux/psi_types.h        |   7 +-
 kernel/cgroup/cgroup.c           |   2 +-
 kernel/sched/psi.c               | 175 ++++++++++++++++++------------
 5 files changed, 121 insertions(+), 69 deletions(-)

diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
index 5e40b3f..df6062e 100644
--- a/Documentation/accounting/psi.rst
+++ b/Documentation/accounting/psi.rst
@@ -105,6 +105,10 @@ prevent overly frequent polling. Max limit is chosen as a high enough number
 after which monitors are most likely not needed and psi averages can be used
 instead.
 
+Unprivileged users can also create monitors, with the only limitation that the
+window size must be a multiple of 2s, in order to prevent excessive resource
+usage.
+
 When activated, psi monitor stays active for at least the duration of one
 tracking window to avoid repeated activations/deactivations when system is
 bouncing in and out of the stall state.
diff --git a/include/linux/psi.h b/include/linux/psi.h
index b029a84..ab26200 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -24,7 +24,7 @@ void psi_memstall_leave(unsigned long *flags);
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
 struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, enum psi_res res);
+			char *buf, enum psi_res res, struct file *file);
 void psi_trigger_destroy(struct psi_trigger *t);
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 1819afa..040c089 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -151,6 +151,9 @@ struct psi_trigger {
 
 	/* Deferred event(s) from previous ratelimit window */
 	bool pending_event;
+
+	/* Trigger type - PSI_AVGS for unprivileged, PSI_POLL for RT */
+	enum psi_aggregators aggregator;
 };
 
 struct psi_group {
@@ -171,6 +174,10 @@ struct psi_group {
 	/* Aggregator work control */
 	struct delayed_work avgs_work;
 
+	/* Unprivileged triggers against N*PSI_FREQ windows */
+	struct list_head avg_triggers;
+	u32 avg_nr_triggers[NR_PSI_STATES - 1];
+
 	/* Total stall times and sampled pressure averages */
 	u64 total[NR_PSI_AGGREGATORS][NR_PSI_STATES - 1];
 	unsigned long avg[NR_PSI_STATES - 1][3];
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 935e812..dead369 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3761,7 +3761,7 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
 	}
 
 	psi = cgroup_psi(cgrp);
-	new = psi_trigger_create(psi, buf, res);
+	new = psi_trigger_create(psi, buf, res, of->file);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
 		return PTR_ERR(new);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index f3df6a8..e072f6b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -186,9 +186,14 @@ static void group_init(struct psi_group *group)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->avg_last_update = sched_clock();
 	group->avg_next_update = group->avg_last_update + psi_period;
-	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 	mutex_init(&group->avgs_lock);
-	/* Init trigger-related members */
+
+	/* Init avg trigger-related members */
+	INIT_LIST_HEAD(&group->avg_triggers);
+	memset(group->avg_nr_triggers, 0, sizeof(group->avg_nr_triggers));
+	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
+
+	/* Init rtpoll trigger-related members */
 	atomic_set(&group->rtpoll_scheduled, 0);
 	mutex_init(&group->rtpoll_trigger_lock);
 	INIT_LIST_HEAD(&group->rtpoll_triggers);
@@ -430,21 +435,32 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }
 
-static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total)
+static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
+						   enum psi_aggregators aggregator)
 {
 	struct psi_trigger *t;
-	u64 *total = group->total[PSI_POLL];
+	u64 *total = group->total[aggregator];
+	struct list_head *triggers;
+	u64 *aggregator_total;
 	*update_total = false;
 
+	if (aggregator == PSI_AVGS) {
+		triggers = &group->avg_triggers;
+		aggregator_total = group->avg_total;
+	} else {
+		triggers = &group->rtpoll_triggers;
+		aggregator_total = group->rtpoll_total;
+	}
+
 	/*
 	 * On subsequent updates, calculate growth deltas and let
 	 * watchers know when their specified thresholds are exceeded.
 	 */
-	list_for_each_entry(t, &group->rtpoll_triggers, node) {
+	list_for_each_entry(t, triggers, node) {
 		u64 growth;
 		bool new_stall;
 
-		new_stall = group->rtpoll_total[t->state] != total[t->state];
+		new_stall = aggregator_total[t->state] != total[t->state];
 
 		/* Check for stall activity or a previous threshold breach */
 		if (!new_stall && !t->pending_event)
@@ -546,6 +562,7 @@ static void psi_avgs_work(struct work_struct *work)
 	struct delayed_work *dwork;
 	struct psi_group *group;
 	u32 changed_states;
+	bool update_total;
 	u64 now;
 
 	dwork = to_delayed_work(work);
@@ -563,8 +580,10 @@ static void psi_avgs_work(struct work_struct *work)
 	 * Once restarted, we'll catch up the running averages in one
 	 * go - see calc_avgs() and missed_periods.
 	 */
-	if (now >= group->avg_next_update)
+	if (now >= group->avg_next_update) {
+		update_triggers(group, now, &update_total, PSI_AVGS);
 		group->avg_next_update = update_averages(group, now);
+	}
 
 	if (changed_states & PSI_STATE_RESCHEDULE) {
 		schedule_delayed_work(dwork, nsecs_to_jiffies(
@@ -574,7 +593,7 @@ static void psi_avgs_work(struct work_struct *work)
 	mutex_unlock(&group->avgs_lock);
 }
 
-static void init_triggers(struct psi_group *group, u64 now)
+static void init_rtpoll_triggers(struct psi_group *group, u64 now)
 {
 	struct psi_trigger *t;
 
@@ -667,7 +686,7 @@ static void psi_rtpoll_work(struct psi_group *group)
 	if (changed_states & group->rtpoll_states) {
 		/* Initialize trigger windows when entering polling mode */
 		if (now > group->rtpoll_until)
-			init_triggers(group, now);
+			init_rtpoll_triggers(group, now);
 
 		/*
 		 * Keep the monitor active for at least the duration of the
@@ -684,7 +703,7 @@ static void psi_rtpoll_work(struct psi_group *group)
 	}
 
 	if (now >= group->rtpoll_next_update) {
-		group->rtpoll_next_update = update_triggers(group, now, &update_total);
+		group->rtpoll_next_update = update_triggers(group, now, &update_total, PSI_POLL);
 		if (update_total)
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
@@ -1254,16 +1273,23 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 }
 
 struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, enum psi_res res)
+			char *buf, enum psi_res res, struct file *file)
 {
 	struct psi_trigger *t;
 	enum psi_states state;
 	u32 threshold_us;
+	bool privileged;
 	u32 window_us;
 
 	if (static_branch_likely(&psi_disabled))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	/*
+	 * Checking the privilege here on file->f_cred implies that a privileged user
+	 * could open the file and delegate the write to an unprivileged one.
+	 */
+	privileged = cap_raised(file->f_cred->cap_effective, CAP_SYS_RESOURCE);
+
 	if (sscanf(buf, "some %u %u", &threshold_us, &window_us) == 2)
 		state = PSI_IO_SOME + res * 2;
 	else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) == 2)
@@ -1283,6 +1309,13 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 		window_us > WINDOW_MAX_US)
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * Unprivileged users can only use 2s windows so that averages aggregation
+	 * work is used, and no RT threads need to be spawned.
+	 */
+	if (!privileged && window_us % 2000000)
+		return ERR_PTR(-EINVAL);
+
 	/* Check threshold */
 	if (threshold_us == 0 || threshold_us > window_us)
 		return ERR_PTR(-EINVAL);
@@ -1302,31 +1335,40 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->last_event_time = 0;
 	init_waitqueue_head(&t->event_wait);
 	t->pending_event = false;
+	t->aggregator = privileged ? PSI_POLL : PSI_AVGS;
 
-	mutex_lock(&group->rtpoll_trigger_lock);
+	if (privileged) {
+		mutex_lock(&group->rtpoll_trigger_lock);
 
-	if (!rcu_access_pointer(group->rtpoll_task)) {
-		struct task_struct *task;
+		if (!rcu_access_pointer(group->rtpoll_task)) {
+			struct task_struct *task;
 
-		task = kthread_create(psi_rtpoll_worker, group, "psimon");
-		if (IS_ERR(task)) {
-			kfree(t);
-			mutex_unlock(&group->rtpoll_trigger_lock);
-			return ERR_CAST(task);
+			task = kthread_create(psi_rtpoll_worker, group, "psimon");
+			if (IS_ERR(task)) {
+				kfree(t);
+				mutex_unlock(&group->rtpoll_trigger_lock);
+				return ERR_CAST(task);
+			}
+			atomic_set(&group->rtpoll_wakeup, 0);
+			wake_up_process(task);
+			rcu_assign_pointer(group->rtpoll_task, task);
 		}
-		atomic_set(&group->rtpoll_wakeup, 0);
-		wake_up_process(task);
-		rcu_assign_pointer(group->rtpoll_task, task);
-	}
 
-	list_add(&t->node, &group->rtpoll_triggers);
-	group->rtpoll_min_period = min(group->rtpoll_min_period,
-		div_u64(t->win.size, UPDATES_PER_WINDOW));
-	group->rtpoll_nr_triggers[t->state]++;
-	group->rtpoll_states |= (1 << t->state);
+		list_add(&t->node, &group->rtpoll_triggers);
+		group->rtpoll_min_period = min(group->rtpoll_min_period,
+			div_u64(t->win.size, UPDATES_PER_WINDOW));
+		group->rtpoll_nr_triggers[t->state]++;
+		group->rtpoll_states |= (1 << t->state);
 
-	mutex_unlock(&group->rtpoll_trigger_lock);
+		mutex_unlock(&group->rtpoll_trigger_lock);
+	} else {
+		mutex_lock(&group->avgs_lock);
+
+		list_add(&t->node, &group->avg_triggers);
+		group->avg_nr_triggers[t->state]++;
 
+		mutex_unlock(&group->avgs_lock);
+	}
 	return t;
 }
 
@@ -1350,34 +1392,41 @@ void psi_trigger_destroy(struct psi_trigger *t)
 	 */
 	wake_up_pollfree(&t->event_wait);
 
-	mutex_lock(&group->rtpoll_trigger_lock);
-
-	if (!list_empty(&t->node)) {
-		struct psi_trigger *tmp;
-		u64 period = ULLONG_MAX;
-
-		list_del(&t->node);
-		group->rtpoll_nr_triggers[t->state]--;
-		if (!group->rtpoll_nr_triggers[t->state])
-			group->rtpoll_states &= ~(1 << t->state);
-		/* reset min update period for the remaining triggers */
-		list_for_each_entry(tmp, &group->rtpoll_triggers, node)
-			period = min(period, div_u64(tmp->win.size,
-					UPDATES_PER_WINDOW));
-		group->rtpoll_min_period = period;
-		/* Destroy rtpoll_task when the last trigger is destroyed */
-		if (group->rtpoll_states == 0) {
-			group->rtpoll_until = 0;
-			task_to_destroy = rcu_dereference_protected(
-					group->rtpoll_task,
-					lockdep_is_held(&group->rtpoll_trigger_lock));
-			rcu_assign_pointer(group->rtpoll_task, NULL);
-			del_timer(&group->rtpoll_timer);
+	if (t->aggregator == PSI_AVGS) {
+		mutex_lock(&group->avgs_lock);
+		if (!list_empty(&t->node)) {
+			list_del(&t->node);
+			group->avg_nr_triggers[t->state]--;
 		}
+		mutex_unlock(&group->avgs_lock);
+	} else {
+		mutex_lock(&group->rtpoll_trigger_lock);
+		if (!list_empty(&t->node)) {
+			struct psi_trigger *tmp;
+			u64 period = ULLONG_MAX;
+
+			list_del(&t->node);
+			group->rtpoll_nr_triggers[t->state]--;
+			if (!group->rtpoll_nr_triggers[t->state])
+				group->rtpoll_states &= ~(1 << t->state);
+			/* reset min update period for the remaining triggers */
+			list_for_each_entry(tmp, &group->rtpoll_triggers, node)
+				period = min(period, div_u64(tmp->win.size,
+						UPDATES_PER_WINDOW));
+			group->rtpoll_min_period = period;
+			/* Destroy rtpoll_task when the last trigger is destroyed */
+			if (group->rtpoll_states == 0) {
+				group->rtpoll_until = 0;
+				task_to_destroy = rcu_dereference_protected(
+						group->rtpoll_task,
+						lockdep_is_held(&group->rtpoll_trigger_lock));
+				rcu_assign_pointer(group->rtpoll_task, NULL);
+				del_timer(&group->rtpoll_timer);
+			}
+		}
+		mutex_unlock(&group->rtpoll_trigger_lock);
 	}
 
-	mutex_unlock(&group->rtpoll_trigger_lock);
-
 	/*
 	 * Wait for psi_schedule_rtpoll_work RCU to complete its read-side
 	 * critical section before destroying the trigger and optionally the
@@ -1437,27 +1486,19 @@ static int psi_cpu_show(struct seq_file *m, void *v)
 	return psi_show(m, &psi_system, PSI_CPU);
 }
 
-static int psi_open(struct file *file, int (*psi_show)(struct seq_file *, void *))
-{
-	if (file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
-		return -EPERM;
-
-	return single_open(file, psi_show, NULL);
-}
-
 static int psi_io_open(struct inode *inode, struct file *file)
 {
-	return psi_open(file, psi_io_show);
+	return single_open(file, psi_io_show, NULL);
 }
 
 static int psi_memory_open(struct inode *inode, struct file *file)
 {
-	return psi_open(file, psi_memory_show);
+	return single_open(file, psi_memory_show, NULL);
 }
 
 static int psi_cpu_open(struct inode *inode, struct file *file)
 {
-	return psi_open(file, psi_cpu_show);
+	return single_open(file, psi_cpu_show, NULL);
 }
 
 static ssize_t psi_write(struct file *file, const char __user *user_buf,
@@ -1491,7 +1532,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return -EBUSY;
 	}
 
-	new = psi_trigger_create(&psi_system, buf, res);
+	new = psi_trigger_create(&psi_system, buf, res, file);
 	if (IS_ERR(new)) {
 		mutex_unlock(&seq->lock);
 		return PTR_ERR(new);
@@ -1571,7 +1612,7 @@ static int psi_irq_show(struct seq_file *m, void *v)
 
 static int psi_irq_open(struct inode *inode, struct file *file)
 {
-	return psi_open(file, psi_irq_show);
+	return single_open(file, psi_irq_show, NULL);
 }
 
 static ssize_t psi_irq_write(struct file *file, const char __user *user_buf,
