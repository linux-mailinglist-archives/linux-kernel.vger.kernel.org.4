Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0416C6543
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCWKiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjCWKhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:37:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C591C307
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:34:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg48so84227025edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679567640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qjht4vTChRpFeoKS3xK8PrUlAYMElAZIp6og0BY81Ms=;
        b=MfbiojYrW35n833YKGLdmFVP8lv6mVjA/jXwandx3HVYwMXkra5c2SsbJtleqriVdj
         ICq9KI50HY9y4O0utld2XDCs+anUuh8WCptdQeI7TUstWZIYk/ywd0OeRySIt6b+2SJZ
         9nxaTG+vN2yF2fEwK9W8x8CWYGtqNim7167qxK+MNbLjjpbxEAbI9dE/QMnoAjpnSX3Q
         rezUzQqEoSuCZnwW6SSrZH37MByGfAK9BTeeJ/KHMH506X7uSPgj7ehXj4m6pjUWUQjy
         z6tRWIRIh7fVWTu+VI4DmIqTNMvsGcUVtnmXKg2jJHg+87e1J9q5QrGBuXx9LE98LXcv
         78Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qjht4vTChRpFeoKS3xK8PrUlAYMElAZIp6og0BY81Ms=;
        b=7dKACMVfQGoCCCXU6/jqU7mf6eTdXrEbES6vf8Tlsi8kGqOzBSRA/D5B/nr+e3iT1S
         hchKpLm/YZc9dKRgjcJTQ05+cGCiRSuwgryd6vxYo2b07fb2U5Zje3I+02wW3JtTToG7
         cff2kWrLMhnHXaKo+h2Ds7Buc+V3WEJj3khtwU38PVtAgZXuUlrk1SvGY+USaf2fsXed
         tGXnR4PaAleAcS6z88lesKWPeNkUlqHoqtHnbGesHUTWjs1YgiZgcVKUfSjg7pe2pmsj
         PX4jO6OXy8ipZ2Oq25DWnVfy6JMl7tpV90ct/YBZdAEaFNyokA0TQHu5Bh1JxLXS9I9F
         ft2g==
X-Gm-Message-State: AO0yUKU3gNauzNgW0vyAV/cMCKQUGoeWxG2wUiMWK300Pg7Pg/jUsDqn
        bJSeDFVNAebbrxtb/4kKmpPrJQmZ7QciSg==
X-Google-Smtp-Source: AK7set9bzjrtGAbv5wzYdTTF//4e3j9LaLohlGtv1iRqtr9z+JsZ8l8u95mQcGhxV0Q2IrRsIwffFw==
X-Received: by 2002:a17:906:360f:b0:92f:dcf7:9434 with SMTP id q15-20020a170906360f00b0092fdcf79434mr5370616ejb.9.1679567640253;
        Thu, 23 Mar 2023 03:34:00 -0700 (PDT)
Received: from lelloman-5950.. (host-79-13-135-230.retail.telecomitalia.it. [79.13.135.230])
        by smtp.gmail.com with ESMTPSA id s15-20020a1709060c0f00b00928e0ea53e5sm8432687ejf.84.2023.03.23.03.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:33:59 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v2 3/3] sched/psi: allow unprivileged polling of N*2s period
Date:   Thu, 23 Mar 2023 11:33:50 +0100
Message-Id: <20230323103350.40569-4-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323103350.40569-1-cerasuolodomenico@gmail.com>
References: <20230323103350.40569-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
runs independently of any triggers.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 Documentation/accounting/psi.rst |   4 ++
 include/linux/psi.h              |   2 +-
 include/linux/psi_types.h        |  11 +++-
 kernel/cgroup/cgroup.c           |   2 +-
 kernel/sched/psi.c               | 110 ++++++++++++++++++-------------
 5 files changed, 78 insertions(+), 51 deletions(-)

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
index 1e0a0d7ace3a..eaee30f54670 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -151,6 +151,14 @@ struct psi_trigger {
 
 	/* Deferred event(s) from previous ratelimit window */
 	bool pending_event;
+
+	/* Used to differentiate destruction action*/
+	enum psi_aggregators aggregator;
+};
+
+struct trigger_info {
+	struct list_head triggers;
+	u32 nr_triggers[NR_PSI_STATES - 1];
 };
 
 struct psi_group {
@@ -186,8 +194,7 @@ struct psi_group {
 	struct mutex trigger_lock;
 
 	/* Configured polling triggers */
-	struct list_head triggers;
-	u32 nr_triggers[NR_PSI_STATES - 1];
+	struct trigger_info trig_info[NR_PSI_AGGREGATORS];
 	u32 poll_states;
 	u64 poll_min_period;
 
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
index 17d71ef07751..f15d92819fe5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -180,18 +180,20 @@ static void poll_timer_fn(struct timer_list *t);
 static void group_init(struct psi_group *group)
 {
 	int cpu;
+	int i;
 
 	group->enabled = true;
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->avg_last_update = sched_clock();
 	group->avg_next_update = group->avg_last_update + psi_period;
-	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 	mutex_init(&group->avgs_lock);
 	/* Init trigger-related members */
 	atomic_set(&group->poll_scheduled, 0);
 	mutex_init(&group->trigger_lock);
-	INIT_LIST_HEAD(&group->triggers);
+	for (i = 0; i < NR_PSI_AGGREGATORS; i++)
+		INIT_LIST_HEAD(&group->trig_info[i].triggers);
+	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 	group->poll_min_period = U32_MAX;
 	group->polling_next_update = ULLONG_MAX;
 	init_waitqueue_head(&group->poll_wait);
@@ -430,21 +432,24 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }
 
-static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total)
+static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
+						   enum psi_aggregators aggregator)
 {
 	struct psi_trigger *t;
-	u64 *total = group->total[PSI_POLL];
+	u64 *total = group->total[aggregator];
+	struct list_head *triggers = &group->trig_info[aggregator].triggers;
+	u64 *aggregator_total = aggregator == PSI_AVGS ? group->avg_total : group->polling_total;
 	*update_total = false;
 
 	/*
 	 * On subsequent updates, calculate growth deltas and let
 	 * watchers know when their specified thresholds are exceeded.
 	 */
-	list_for_each_entry(t, &group->triggers, node) {
+	list_for_each_entry(t, triggers, node) {
 		u64 growth;
 		bool new_stall;
 
-		new_stall = group->polling_total[t->state] != total[t->state];
+		new_stall = aggregator_total[t->state] != total[t->state];
 
 		/* Check for stall activity or a previous threshold breach */
 		if (!new_stall && !t->pending_event)
@@ -545,6 +550,7 @@ static void psi_avgs_work(struct work_struct *work)
 {
 	struct delayed_work *dwork;
 	struct psi_group *group;
+	bool update_total;
 	u32 changed_states;
 	u64 now;
 
@@ -563,8 +569,10 @@ static void psi_avgs_work(struct work_struct *work)
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
@@ -574,11 +582,11 @@ static void psi_avgs_work(struct work_struct *work)
 	mutex_unlock(&group->avgs_lock);
 }
 
-static void init_triggers(struct psi_group *group, u64 now)
+static void init_poll_triggers(struct psi_group *group, u64 now)
 {
 	struct psi_trigger *t;
 
-	list_for_each_entry(t, &group->triggers, node)
+	list_for_each_entry(t, &group->trig_info[PSI_POLL].triggers, node)
 		window_reset(&t->win, now,
 				group->total[PSI_POLL][t->state], 0);
 	memcpy(group->polling_total, group->total[PSI_POLL],
@@ -667,7 +675,7 @@ static void psi_poll_work(struct psi_group *group)
 	if (changed_states & group->poll_states) {
 		/* Initialize trigger windows when entering polling mode */
 		if (now > group->polling_until)
-			init_triggers(group, now);
+			init_poll_triggers(group, now);
 
 		/*
 		 * Keep the monitor active for at least the duration of the
@@ -684,7 +692,7 @@ static void psi_poll_work(struct psi_group *group)
 	}
 
 	if (now >= group->polling_next_update) {
-		group->polling_next_update = update_triggers(group, now, &update_total);
+		group->polling_next_update = update_triggers(group, now, &update_total, PSI_POLL);
 		if (update_total)
 			memcpy(group->polling_total, group->total[PSI_POLL],
 				   sizeof(group->polling_total));
@@ -1254,16 +1262,19 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
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
@@ -1283,6 +1294,13 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
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
@@ -1302,10 +1320,11 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->last_event_time = 0;
 	init_waitqueue_head(&t->event_wait);
 	t->pending_event = false;
+	t->aggregator = privileged ? PSI_POLL : PSI_AVGS;
 
 	mutex_lock(&group->trigger_lock);
 
-	if (!rcu_access_pointer(group->poll_task)) {
+	if (privileged && !rcu_access_pointer(group->poll_task)) {
 		struct task_struct *task;
 
 		task = kthread_create(psi_poll_worker, group, "psimon");
@@ -1319,12 +1338,14 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 		rcu_assign_pointer(group->poll_task, task);
 	}
 
-	list_add(&t->node, &group->triggers);
-	group->poll_min_period = min(group->poll_min_period,
-		div_u64(t->win.size, UPDATES_PER_WINDOW));
-	group->nr_triggers[t->state]++;
-	group->poll_states |= (1 << t->state);
+	list_add(&t->node, &group->trig_info[t->aggregator].triggers);
+	group->trig_info[t->aggregator].nr_triggers[t->state]++;
 
+	if (privileged) {
+		group->poll_min_period = min(group->poll_min_period,
+			div_u64(t->win.size, UPDATES_PER_WINDOW));
+		group->poll_states |= (1 << t->state);
+	}
 	mutex_unlock(&group->trigger_lock);
 
 	return t;
@@ -1357,22 +1378,25 @@ void psi_trigger_destroy(struct psi_trigger *t)
 		u64 period = ULLONG_MAX;
 
 		list_del(&t->node);
-		group->nr_triggers[t->state]--;
-		if (!group->nr_triggers[t->state])
-			group->poll_states &= ~(1 << t->state);
-		/* reset min update period for the remaining triggers */
-		list_for_each_entry(tmp, &group->triggers, node)
-			period = min(period, div_u64(tmp->win.size,
-					UPDATES_PER_WINDOW));
-		group->poll_min_period = period;
-		/* Destroy poll_task when the last trigger is destroyed */
-		if (group->poll_states == 0) {
-			group->polling_until = 0;
-			task_to_destroy = rcu_dereference_protected(
-					group->poll_task,
-					lockdep_is_held(&group->trigger_lock));
-			rcu_assign_pointer(group->poll_task, NULL);
-			del_timer(&group->poll_timer);
+		group->trig_info[t->aggregator].nr_triggers[t->state]--;
+
+		if (t->aggregator == PSI_POLL) {
+			if (!group->trig_info[t->aggregator].nr_triggers[t->state])
+				group->poll_states &= ~(1 << t->state);
+			/* reset min update period for the remaining triggers */
+			list_for_each_entry(tmp, &group->trig_info[t->aggregator].triggers, node)
+				period = min(period, div_u64(tmp->win.size,
+						UPDATES_PER_WINDOW));
+			group->poll_min_period = period;
+			/* Destroy poll_task when the last trigger is destroyed */
+			if (group->poll_states == 0) {
+				group->polling_until = 0;
+				task_to_destroy = rcu_dereference_protected(
+						group->poll_task,
+						lockdep_is_held(&group->trigger_lock));
+				rcu_assign_pointer(group->poll_task, NULL);
+				del_timer(&group->poll_timer);
+			}
 		}
 	}
 
@@ -1436,27 +1460,19 @@ static int psi_cpu_show(struct seq_file *m, void *v)
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
@@ -1490,7 +1506,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return -EBUSY;
 	}
 
-	new = psi_trigger_create(&psi_system, buf, res);
+	new = psi_trigger_create(&psi_system, buf, res, file);
 	if (IS_ERR(new)) {
 		mutex_unlock(&seq->lock);
 		return PTR_ERR(new);
@@ -1570,7 +1586,7 @@ static int psi_irq_show(struct seq_file *m, void *v)
 
 static int psi_irq_open(struct inode *inode, struct file *file)
 {
-	return psi_open(file, psi_irq_show);
+	return single_open(file, psi_irq_show, NULL);
 }
 
 static ssize_t psi_irq_write(struct file *file, const char __user *user_buf,
-- 
2.34.1

