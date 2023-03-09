Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2346B2BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjCIRLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjCIRKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:10:03 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BCA16ACF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:08:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id da10so9839114edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 09:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678381685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPrjIlcKtd89jv00eXJk/K8E993g+fzHBjKuVHhHBB4=;
        b=Esm16GcGGqKillnOKS1lxVJtybW52HFGoFSOVYd0wJP8McxKeUBaZprPiKabL06qVC
         cLbB67UUOz0I7OTeF1xxUJT5EZ/8zmwksCsVtO/j83qWY1IIyTZOsuLpJz49tIvoOrwR
         DoEy/Knui6xDHNNCaZoAXHesWC11PfUXTIeWeD3NYLbI31cEH9LXKqWiBaVwGHYHtoDJ
         nNqmNeluIEsTiufueawawYLUedHw5xDxvx9E/ZrmjBYcCUx0LZvJ1dU3qJTmyzSuC+0N
         42J2pvO5O1A4nZElRHGvPxGBEi/UtGVKJmwKLt/2QCwrIWF73Hp4DjI0YY8kOif2KUXp
         hZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678381685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPrjIlcKtd89jv00eXJk/K8E993g+fzHBjKuVHhHBB4=;
        b=C18c/prlJPdSraC4KEpH8NhpX02jJdAUfMd+3KEci5V+PAG0laM7JlS0vxqT5yGOdO
         tF4NNQLgZh2XBYsmn8QQWQc36HcUKukMNja4OPoWZWT5dMGE42kWVk6FRN/aCW5oLnge
         nDDOhDbbvsaTTAIncS3TVxr0JUU7JqdxOKNkYjC0piMOJts3htsECcOfX8xMcuWFEz3Y
         4rxIxv2SbdBBs/dbIsRnfMmBTrlDTNn7REUKIjqaaXl6+SLufDIdiqvhvDh76wLEbw8H
         BYg5B5viP899PzYNY68wewyRPcxTu/QfVeVbOdGdPjVxCE6uS1Smppt0DGhskE8wlhjL
         1org==
X-Gm-Message-State: AO0yUKXqMzRf5W6bR8PoPdktF37ttJttrRiZfebTqkCWLnZ8Wb6Ho7a9
        eZ21a4El69lX8GBFNZ9n3lXlTZljWOL05w==
X-Google-Smtp-Source: AK7set/f7Rjc6mTQu0ZWiGYlcW3EtHaalwe4K0D3jaaMyDD44GKo9a6oy5Q40YNe2dawXrvWKAef4w==
X-Received: by 2002:a17:907:3ea9:b0:88d:777a:9ca6 with SMTP id hs41-20020a1709073ea900b0088d777a9ca6mr27714046ejc.18.1678381685455;
        Thu, 09 Mar 2023 09:08:05 -0800 (PST)
Received: from lelloman-5950.. (host-79-22-154-28.retail.telecomitalia.it. [79.22.154.28])
        by smtp.gmail.com with ESMTPSA id bj8-20020a170906b04800b008d85435f914sm9154867ejb.98.2023.03.09.09.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:08:05 -0800 (PST)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH 4/4] sched/psi: allow unprivileged polling of N*2s period
Date:   Thu,  9 Mar 2023 18:07:56 +0100
Message-Id: <20230309170756.52927-5-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309170756.52927-1-cerasuolodomenico@gmail.com>
References: <20230309170756.52927-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
runs indipendently of any triggers.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 Documentation/accounting/psi.rst |   4 ++
 include/linux/psi.h              |   2 +-
 include/linux/psi_types.h        |   7 +++
 kernel/cgroup/cgroup.c           |   2 +-
 kernel/sched/psi.c               | 105 ++++++++++++++++++++-----------
 5 files changed, 83 insertions(+), 37 deletions(-)

diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
index 5e40b3f437f9..df6062eb3abb 100644
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
index b029a847def1..ab26200c2803 100644
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
index 1819afa8b198..e439f411c23b 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -151,6 +151,9 @@ struct psi_trigger {
 
 	/* Deferred event(s) from previous ratelimit window */
 	bool pending_event;
+
+	/* Used to differentiate destruction action*/
+	enum psi_aggregators aggregator;
 };
 
 struct psi_group {
@@ -171,6 +174,10 @@ struct psi_group {
 	/* Aggregator work control */
 	struct delayed_work avgs_work;
 
+	/* Unprivileged triggers against N*PSI_FREQ windows */
+	struct list_head triggers;
+	u32 nr_triggers[NR_PSI_STATES - 1];
+
 	/* Total stall times and sampled pressure averages */
 	u64 total[NR_PSI_AGGREGATORS][NR_PSI_STATES - 1];
 	unsigned long avg[NR_PSI_STATES - 1][3];
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 935e8121b21e..dead36969bba 100644
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
index 476941c1cbea..fde91aa4e55f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -186,9 +186,9 @@ static void group_init(struct psi_group *group)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->avg_last_update = sched_clock();
 	group->avg_next_update = group->avg_last_update + psi_period;
-	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 	mutex_init(&group->avgs_lock);
-	/* Init trigger-related members */
+
+	/* Init rtpoll trigger-related members */
 	atomic_set(&group->rtpoll_scheduled, 0);
 	mutex_init(&group->rtpoll_trigger_lock);
 	INIT_LIST_HEAD(&group->rtpoll_triggers);
@@ -197,6 +197,11 @@ static void group_init(struct psi_group *group)
 	init_waitqueue_head(&group->rtpoll_wait);
 	timer_setup(&group->rtpoll_timer, poll_timer_fn, 0);
 	rcu_assign_pointer(group->rtpoll_task, NULL);
+
+	/* Init avg trigger-related members */
+	INIT_LIST_HEAD(&group->triggers);
+	memset(group->nr_triggers, 0, sizeof(group->nr_triggers));
+	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 }
 
 void __init psi_init(void)
@@ -430,20 +435,23 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }
 
-static u64 update_triggers(struct psi_group *group, u64 now)
+static u64 update_triggers(struct psi_group *group, u64 now, enum psi_aggregators aggregator)
 {
 	struct psi_trigger *t;
-	u64 *total = group->total[PSI_POLL];
+	u64 *total = group->total[aggregator];
+	struct list_head *triggers = aggregator == PSI_AVGS ? &group->triggers
+			: &group->rtpoll_triggers;
+	u64 *aggregator_total = aggregator == PSI_AVGS ? group->avg_total : group->rtpoll_total;
 
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
@@ -553,8 +561,10 @@ static void psi_avgs_work(struct work_struct *work)
 	 * Once restarted, we'll catch up the running averages in one
 	 * go - see calc_avgs() and missed_periods.
 	 */
-	if (now >= group->avg_next_update)
+	if (now >= group->avg_next_update) {
+		update_triggers(group, now, PSI_AVGS);
 		group->avg_next_update = update_averages(group, now);
+	}
 
 	if (changed_states & PSI_STATE_RESCHEDULE) {
 		schedule_delayed_work(dwork, nsecs_to_jiffies(
@@ -571,9 +581,17 @@ static void init_triggers(struct psi_group *group, u64 now)
 	list_for_each_entry(t, &group->rtpoll_triggers, node)
 		window_reset(&t->win, now,
 				group->total[PSI_POLL][t->state], 0);
+
+	list_for_each_entry(t, &group->triggers, node)
+		window_reset(&t->win, now,
+				group->total[PSI_AVGS][t->state], 0);
+
 	memcpy(group->rtpoll_total, group->total[PSI_POLL],
 		   sizeof(group->rtpoll_total));
 	group->rtpoll_next_update = now + group->rtpoll_min_period;
+
+	memcpy(group->avg_total, group->total[PSI_AVGS],
+		   sizeof(group->avg_total));
 }
 
 /* Schedule polling if it's not already scheduled or forced. */
@@ -673,7 +691,7 @@ static void psi_rtpoll_work(struct psi_group *group)
 	}
 
 	if (now >= group->rtpoll_next_update) {
-		group->rtpoll_next_update = update_triggers(group, now);
+		group->rtpoll_next_update = update_triggers(group, now, PSI_POLL);
 		if (changed_states & group->rtpoll_states)
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
@@ -1243,16 +1261,19 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
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
 
+	privileged = cap_raised(file->f_cred->cap_effective, CAP_SYS_RESOURCE);
+
 	if (sscanf(buf, "some %u %u", &threshold_us, &window_us) == 2)
 		state = PSI_IO_SOME + res * 2;
 	else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) == 2)
@@ -1272,6 +1293,13 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
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
@@ -1291,10 +1319,11 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->last_event_time = 0;
 	init_waitqueue_head(&t->event_wait);
 	t->pending_event = false;
+	t->aggregator = privileged ? PSI_POLL : PSI_AVGS;
 
 	mutex_lock(&group->rtpoll_trigger_lock);
 
-	if (!rcu_access_pointer(group->rtpoll_task)) {
+	if (privileged && !rcu_access_pointer(group->rtpoll_task)) {
 		struct task_struct *task;
 
 		task = kthread_create(psi_rtpoll_worker, group, "psimon");
@@ -1308,11 +1337,16 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 		rcu_assign_pointer(group->rtpoll_task, task);
 	}
 
-	list_add(&t->node, &group->rtpoll_triggers);
-	group->rtpoll_min_period = min(group->rtpoll_min_period,
-		div_u64(t->win.size, UPDATES_PER_WINDOW));
-	group->rtpoll_nr_triggers[t->state]++;
-	group->rtpoll_states |= (1 << t->state);
+	if (privileged) {
+		list_add(&t->node, &group->rtpoll_triggers);
+		group->rtpoll_min_period = min(group->rtpoll_min_period,
+			div_u64(t->win.size, UPDATES_PER_WINDOW));
+		group->rtpoll_nr_triggers[t->state]++;
+		group->rtpoll_states |= (1 << t->state);
+	} else {
+		list_add(&t->node, &group->triggers);
+		group->nr_triggers[t->state]++;
+	}
 
 	mutex_unlock(&group->rtpoll_trigger_lock);
 
@@ -1346,22 +1380,26 @@ void psi_trigger_destroy(struct psi_trigger *t)
 		u64 period = ULLONG_MAX;
 
 		list_del(&t->node);
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
+		if (t->aggregator == PSI_AVGS) {
+			group->nr_triggers[t->state]--;
+		} else {
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
 		}
 	}
 
@@ -1428,9 +1466,6 @@ static int psi_cpu_show(struct seq_file *m, void *v)
 
 static int psi_open(struct file *file, int (*psi_show)(struct seq_file *, void *))
 {
-	if (file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
-		return -EPERM;
-
 	return single_open(file, psi_show, NULL);
 }
 
@@ -1480,7 +1515,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return -EBUSY;
 	}
 
-	new = psi_trigger_create(&psi_system, buf, res);
+	new = psi_trigger_create(&psi_system, buf, res, file);
 	if (IS_ERR(new)) {
 		mutex_unlock(&seq->lock);
 		return PTR_ERR(new);
-- 
2.34.1

