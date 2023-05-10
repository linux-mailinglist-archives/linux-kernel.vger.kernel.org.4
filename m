Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5216FDEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbjEJNd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbjEJNdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:33:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13610B0;
        Wed, 10 May 2023 06:33:44 -0700 (PDT)
Date:   Wed, 10 May 2023 13:33:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683725622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PY6F26NK8UmvrH96aAC5DrHFygHK5zxj6SowBHiosHE=;
        b=PYaMYOkN0ESNgOvRmmk7mUflEbbIUk8niehneCz2WOSwrd5k0n4JITBJ0k5dY60xYI5ED1
        N//akpoX9HRbqRyEeCOg7V+TfCHrK/U6z+TeK8FknzYZ9bdb+06yAZp+hg4OkoXJaaI29+
        KzD0vkvVHZnaZWGv/YBuQFs1ZLtVmtpw3eypsdcCYc3cNLc0aDHeRS2SkRl2CmsDTIPVj6
        zrczugZnx49qCpBiK/zmfIsmP+9hJo+WJx9qI/yxP401J0gI9WpM8CfRtHjbOTIGrKKbJI
        FJM9l3JALjIFfFd9s1L0CmXiER34jPFA2oCT1FglM78AVjt1axkSCHHY1wKBIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683725622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PY6F26NK8UmvrH96aAC5DrHFygHK5zxj6SowBHiosHE=;
        b=Zm6ROnHl6+SzUudVa7ss9ejGFSz/nO7ebJMaOFrbrLOJ3/zzpUUpuE7iCSPOyQ0G2b1QOG
        IKKLIQKlNK1WTiBA==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Rework forwarding of {task|cpu}-clock events
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230504110003.2548-2-ravi.bangoria@amd.com>
References: <20230504110003.2548-2-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <168372562225.404.13530707071831243955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0d6d062ca27ec7ef547712d34dcfcfb952bcef53
Gitweb:        https://git.kernel.org/tip/0d6d062ca27ec7ef547712d34dcfcfb952bcef53
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Thu, 04 May 2023 16:30:00 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:30 +02:00

perf/core: Rework forwarding of {task|cpu}-clock events

Currently, PERF_TYPE_SOFTWARE is treated specially since task-clock and
cpu-clock events are interfaced through it but internally gets forwarded
to their own pmus.

Rework this by overwriting event->attr.type in perf_swevent_init() which
will cause perf_init_event() to retry with updated type and event will
automatically get forwarded to right pmu. With the change, SW pmu no
longer needs to be treated specially and can be included in 'pmu_idr'
list.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230504110003.2548-2-ravi.bangoria@amd.com
---
 include/linux/perf_event.h | 10 +++++-
 kernel/events/core.c       | 77 +++++++++++++++++++------------------
 2 files changed, 51 insertions(+), 36 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7..bf4f346 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -295,6 +295,8 @@ struct perf_event_pmu_context;
 
 struct perf_output_handle;
 
+#define PMU_NULL_DEV	((void *)(~0UL))
+
 /**
  * struct pmu - generic performance monitoring unit
  */
@@ -827,6 +829,14 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+
+	/*
+	 * Certain events gets forwarded to another pmu internally by over-
+	 * writing kernel copy of event->attr.type without user being aware
+	 * of it. event->orig_type contains original 'type' requested by
+	 * user.
+	 */
+	__u32				orig_type;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 68baa81..c01bbe9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6647,7 +6647,7 @@ static void perf_sigtrap(struct perf_event *event)
 		return;
 
 	send_sig_perf((void __user *)event->pending_addr,
-		      event->attr.type, event->attr.sig_data);
+		      event->orig_type, event->attr.sig_data);
 }
 
 /*
@@ -9951,6 +9951,9 @@ static void sw_perf_event_destroy(struct perf_event *event)
 	swevent_hlist_put();
 }
 
+static struct pmu perf_cpu_clock; /* fwd declaration */
+static struct pmu perf_task_clock;
+
 static int perf_swevent_init(struct perf_event *event)
 {
 	u64 event_id = event->attr.config;
@@ -9966,7 +9969,10 @@ static int perf_swevent_init(struct perf_event *event)
 
 	switch (event_id) {
 	case PERF_COUNT_SW_CPU_CLOCK:
+		event->attr.type = perf_cpu_clock.type;
+		return -ENOENT;
 	case PERF_COUNT_SW_TASK_CLOCK:
+		event->attr.type = perf_task_clock.type;
 		return -ENOENT;
 
 	default:
@@ -11086,7 +11092,7 @@ static void cpu_clock_event_read(struct perf_event *event)
 
 static int cpu_clock_event_init(struct perf_event *event)
 {
-	if (event->attr.type != PERF_TYPE_SOFTWARE)
+	if (event->attr.type != perf_cpu_clock.type)
 		return -ENOENT;
 
 	if (event->attr.config != PERF_COUNT_SW_CPU_CLOCK)
@@ -11107,6 +11113,7 @@ static struct pmu perf_cpu_clock = {
 	.task_ctx_nr	= perf_sw_context,
 
 	.capabilities	= PERF_PMU_CAP_NO_NMI,
+	.dev		= PMU_NULL_DEV,
 
 	.event_init	= cpu_clock_event_init,
 	.add		= cpu_clock_event_add,
@@ -11167,7 +11174,7 @@ static void task_clock_event_read(struct perf_event *event)
 
 static int task_clock_event_init(struct perf_event *event)
 {
-	if (event->attr.type != PERF_TYPE_SOFTWARE)
+	if (event->attr.type != perf_task_clock.type)
 		return -ENOENT;
 
 	if (event->attr.config != PERF_COUNT_SW_TASK_CLOCK)
@@ -11188,6 +11195,7 @@ static struct pmu perf_task_clock = {
 	.task_ctx_nr	= perf_sw_context,
 
 	.capabilities	= PERF_PMU_CAP_NO_NMI,
+	.dev		= PMU_NULL_DEV,
 
 	.event_init	= task_clock_event_init,
 	.add		= task_clock_event_add,
@@ -11415,31 +11423,31 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		goto unlock;
 
 	pmu->type = -1;
-	if (!name)
-		goto skip_type;
+	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
+		ret = -EINVAL;
+		goto free_pdc;
+	}
+
 	pmu->name = name;
 
-	if (type != PERF_TYPE_SOFTWARE) {
-		if (type >= 0)
-			max = type;
+	if (type >= 0)
+		max = type;
 
-		ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
-		if (ret < 0)
-			goto free_pdc;
+	ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto free_pdc;
 
-		WARN_ON(type >= 0 && ret != type);
+	WARN_ON(type >= 0 && ret != type);
 
-		type = ret;
-	}
+	type = ret;
 	pmu->type = type;
 
-	if (pmu_bus_running) {
+	if (pmu_bus_running && !pmu->dev) {
 		ret = pmu_dev_alloc(pmu);
 		if (ret)
 			goto free_idr;
 	}
 
-skip_type:
 	ret = -ENOMEM;
 	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
 	if (!pmu->cpu_pmu_context)
@@ -11481,16 +11489,7 @@ skip_type:
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
-	/*
-	 * Ensure the TYPE_SOFTWARE PMUs are at the head of the list,
-	 * since these cannot be in the IDR. This way the linear search
-	 * is fast, provided a valid software event is provided.
-	 */
-	if (type == PERF_TYPE_SOFTWARE || !name)
-		list_add_rcu(&pmu->entry, &pmus);
-	else
-		list_add_tail_rcu(&pmu->entry, &pmus);
-
+	list_add_rcu(&pmu->entry, &pmus);
 	atomic_set(&pmu->exclusive_cnt, 0);
 	ret = 0;
 unlock:
@@ -11499,12 +11498,13 @@ unlock:
 	return ret;
 
 free_dev:
-	device_del(pmu->dev);
-	put_device(pmu->dev);
+	if (pmu->dev && pmu->dev != PMU_NULL_DEV) {
+		device_del(pmu->dev);
+		put_device(pmu->dev);
+	}
 
 free_idr:
-	if (pmu->type != PERF_TYPE_SOFTWARE)
-		idr_remove(&pmu_idr, pmu->type);
+	idr_remove(&pmu_idr, pmu->type);
 
 free_pdc:
 	free_percpu(pmu->pmu_disable_count);
@@ -11525,9 +11525,8 @@ void perf_pmu_unregister(struct pmu *pmu)
 	synchronize_rcu();
 
 	free_percpu(pmu->pmu_disable_count);
-	if (pmu->type != PERF_TYPE_SOFTWARE)
-		idr_remove(&pmu_idr, pmu->type);
-	if (pmu_bus_running) {
+	idr_remove(&pmu_idr, pmu->type);
+	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
 		device_del(pmu->dev);
@@ -11601,6 +11600,12 @@ static struct pmu *perf_init_event(struct perf_event *event)
 
 	idx = srcu_read_lock(&pmus_srcu);
 
+	/*
+	 * Save original type before calling pmu->event_init() since certain
+	 * pmus overwrites event->attr.type to forward event to another pmu.
+	 */
+	event->orig_type = event->attr.type;
+
 	/* Try parent's PMU first: */
 	if (event->parent && event->parent->pmu) {
 		pmu = event->parent->pmu;
@@ -13640,8 +13645,8 @@ void __init perf_event_init(void)
 	perf_event_init_all_cpus();
 	init_srcu_struct(&pmus_srcu);
 	perf_pmu_register(&perf_swevent, "software", PERF_TYPE_SOFTWARE);
-	perf_pmu_register(&perf_cpu_clock, NULL, -1);
-	perf_pmu_register(&perf_task_clock, NULL, -1);
+	perf_pmu_register(&perf_cpu_clock, "cpu_clock", -1);
+	perf_pmu_register(&perf_task_clock, "task_clock", -1);
 	perf_tp_register();
 	perf_event_init_cpu(smp_processor_id());
 	register_reboot_notifier(&perf_reboot_notifier);
@@ -13684,7 +13689,7 @@ static int __init perf_event_sysfs_init(void)
 		goto unlock;
 
 	list_for_each_entry(pmu, &pmus, entry) {
-		if (!pmu->name || pmu->type < 0)
+		if (pmu->dev)
 			continue;
 
 		ret = pmu_dev_alloc(pmu);
