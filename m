Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596346D0FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjC3UGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjC3UGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:06:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C761042E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:06:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b20so81200152edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680206786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab6RM1SXfHf1aco0WeQ1+JYQ9lDmnvAO+T2tlcY879g=;
        b=FkZhDbDe5bNnzW4OMf5ENN8yEpSDWu38Js62WxK0zh4vl7lC0HnWtL0rBkLmTFXOBR
         jOPe8Sok6rowJdMW+5xXaItYGcXfYEJe8dDfEIr+S7yVOJFpntzlNoqMSVcD7CyPcEyC
         sfQ8zEuWXnzceMCxPbGcP/tQEP5bhjRRYw+Nj1TdraSjbwn6hnEhyxu2udfPX7ZyopbK
         2yXVPQdymz6QI5oEZZY7DqL2w3HN4llN476v+fy6GxoeP+c0ACsQVGYpFpiC54R50qDR
         Zs/POmUvnn9bCIVPQtajBCDI/hZKCjtFKX/SGYmN41Kgm2gTeCXqjbbZ67oy1yvSWwjR
         Oomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680206786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab6RM1SXfHf1aco0WeQ1+JYQ9lDmnvAO+T2tlcY879g=;
        b=hoGTHXBrjREdO3wYSy0R8hhfJWy/gXa55knfUdGP0A+IURTBNWPT5ZhTFODoKlxWHT
         51LV03hTrQatGhR1Sz0usoiZ8zL3gZwI6x3pn/8KXM3DYlkauDcpkaVDXB9FgcFowyRa
         iYc22RfrQowEGcYCSnn0dSb5WytlTtt/yBAgxPvUvuMmwvIwId9JrwcwjxA77NObejs1
         xZxXBVfit5b19fI01wHlA+JHzOqgWOB4i0UqL/YAI5JVkVtBi6juTDH9AiQ1L0eM94fJ
         pq8PM4RZJo/bsDOVdAUU9sSB/N3TxXdlDCJ5CwZ1eQa6dCt3SDsYQsosiRz9vzX/AWfz
         rQug==
X-Gm-Message-State: AAQBX9cX1wUtpgw1D2m6aUSDxzHzEVKRsrfbYRV2KN75zcpfs68pNtKa
        p4TNdglnBMMPOa0qsBGjEyt9A5DXMdfWMw==
X-Google-Smtp-Source: AKy350bs5FnCXxFMxLPC64hCcWFrxcX2hYn6NZQu5mhvdo2KAd/5QagXEuYUR6PSbzKauk+RkZIftQ==
X-Received: by 2002:a17:906:4796:b0:93f:3084:d6f with SMTP id cw22-20020a170906479600b0093f30840d6fmr24620894ejc.18.1680206786348;
        Thu, 30 Mar 2023 13:06:26 -0700 (PDT)
Received: from lelloman-5950.. (host-80-182-134-1.retail.telecomitalia.it. [80.182.134.1])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709064e5100b009312cc428e4sm161101ejw.165.2023.03.30.13.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:06:25 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v7 4/4] sched/psi: allow unprivileged polling of N*2s period
Date:   Thu, 30 Mar 2023 22:06:14 +0200
Message-Id: <20230330200614.132354-5-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330200614.132354-1-cerasuolodomenico@gmail.com>
References: <20230330200614.132354-1-cerasuolodomenico@gmail.com>
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/accounting/psi.rst |  4 ++
 include/linux/psi.h              |  2 +-
 include/linux/psi_types.h        |  7 +++
 kernel/cgroup/cgroup.c           |  2 +-
 kernel/sched/psi.c               | 97 +++++++++++++++++++++++---------
 5 files changed, 84 insertions(+), 28 deletions(-)

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
index 1819afa8b198..040c089581c6 100644
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
index f3df6a8ff493..2a7d1fa2e45b 100644
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
@@ -1302,7 +1335,18 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->last_event_time = 0;
 	init_waitqueue_head(&t->event_wait);
 	t->pending_event = false;
+	t->aggregator = privileged ? PSI_POLL : PSI_AVGS;
+
+	if (t->aggregator == PSI_AVGS) {
+		mutex_lock(&group->avgs_lock);
 
+		list_add(&t->node, &group->avg_triggers);
+		group->avg_nr_triggers[t->state]++;
+
+		mutex_unlock(&group->avgs_lock);
+		return t;
+	}
+	/* else, PSI_POLL privileged trigger */
 	mutex_lock(&group->rtpoll_trigger_lock);
 
 	if (!rcu_access_pointer(group->rtpoll_task)) {
@@ -1350,8 +1394,17 @@ void psi_trigger_destroy(struct psi_trigger *t)
 	 */
 	wake_up_pollfree(&t->event_wait);
 
-	mutex_lock(&group->rtpoll_trigger_lock);
+	if (t->aggregator == PSI_AVGS) {
+		mutex_lock(&group->avgs_lock);
+		if (!list_empty(&t->node)) {
+			list_del(&t->node);
+			group->avg_nr_triggers[t->state]--;
+		}
+		mutex_unlock(&group->avgs_lock);
+		goto out;
+	}
 
+	mutex_lock(&group->rtpoll_trigger_lock);
 	if (!list_empty(&t->node)) {
 		struct psi_trigger *tmp;
 		u64 period = ULLONG_MAX;
@@ -1375,9 +1428,9 @@ void psi_trigger_destroy(struct psi_trigger *t)
 			del_timer(&group->rtpoll_timer);
 		}
 	}
-
 	mutex_unlock(&group->rtpoll_trigger_lock);
 
+out:
 	/*
 	 * Wait for psi_schedule_rtpoll_work RCU to complete its read-side
 	 * critical section before destroying the trigger and optionally the
@@ -1437,27 +1490,19 @@ static int psi_cpu_show(struct seq_file *m, void *v)
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
@@ -1491,7 +1536,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return -EBUSY;
 	}
 
-	new = psi_trigger_create(&psi_system, buf, res);
+	new = psi_trigger_create(&psi_system, buf, res, file);
 	if (IS_ERR(new)) {
 		mutex_unlock(&seq->lock);
 		return PTR_ERR(new);
@@ -1571,7 +1616,7 @@ static int psi_irq_show(struct seq_file *m, void *v)
 
 static int psi_irq_open(struct inode *inode, struct file *file)
 {
-	return psi_open(file, psi_irq_show);
+	return single_open(file, psi_irq_show, NULL);
 }
 
 static ssize_t psi_irq_write(struct file *file, const char __user *user_buf,
-- 
2.34.1

