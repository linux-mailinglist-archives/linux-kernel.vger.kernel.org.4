Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652A6656B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiL0Mih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiL0MiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C92CE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 04:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672144597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SOpyQwoCtFinH0fm5Xs947e8NK9akFHNxtsVnF6/lgM=;
        b=g0IhgUzJ6tL92O5spA68UrHVXFzvmcNHXnaPNPP4t4Mkclh9j9nmsykrr5o43/X4xU1Y1Z
        zMpyr36dLstp4qWfe6FxUllSzpVtxTN1mo9+jJSFKSnuwBb2HmT8NQaofB77uEg/FtFzD4
        GUieY2MrAzallu/Pcod7PF+18ue7iXE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-qavEe3xWMlKRx3s8ruTvkA-1; Tue, 27 Dec 2022 07:36:34 -0500
X-MC-Unique: qavEe3xWMlKRx3s8ruTvkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F10542803D60;
        Tue, 27 Dec 2022 12:36:33 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D01A111F3BB;
        Tue, 27 Dec 2022 12:36:33 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id BE00340C519A6; Tue, 27 Dec 2022 09:14:52 -0300 (-03)
Message-ID: <20221227121342.020984662@redhat.com>
User-Agent: quilt/0.66
Date:   Tue, 27 Dec 2022 09:11:40 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@atomlin.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v12 3/6] mm/vmstat: manage per-CPU stats from CPU context when NOHZ full
References: <20221227121137.102497574@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nohz full CPUs, we'd like the per-CPU vm statistics to be
synchronized when userspace is executing. Otherwise, 
the vmstat_shepherd might queue a work item to synchronize them,
which is undesired intereference for isolated CPUs.

This means that its necessary to check for, and possibly sync,
the statistics when returning to userspace. This means that
there are now two execution contexes, on different CPUs,
which require awareness about each other: context switch
and vmstat shepherd kernel threadr.

To avoid the shared variables between these two contexes (which
would require atomic accesses), delegate the responsability
of statistics synchronization from vmstat_shepherd to local CPU
context, for nohz_full CPUs.

Do that by queueing a delayed work when marking per-CPU vmstat dirty.

When returning to userspace, fold the stats and cancel the delayed work.

When entering idle, only fold the stats.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
---
 include/linux/vmstat.h   |    4 ++--
 kernel/time/tick-sched.c |    2 +-
 mm/vmstat.c              |   41 ++++++++++++++++++++++++++++++++---------
 3 files changed, 35 insertions(+), 12 deletions(-)

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -28,6 +28,7 @@
 #include <linux/mm_inline.h>
 #include <linux/page_ext.h>
 #include <linux/page_owner.h>
+#include <linux/tick.h>
 
 #include "internal.h"
 
@@ -194,21 +195,57 @@ void fold_vm_numa_events(void)
 #endif
 
 #ifdef CONFIG_SMP
-static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+
+struct vmstat_dirty {
+	bool dirty;
+#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER
+	bool cpu_offline;
+#endif
+};
+
+static DEFINE_PER_CPU_ALIGNED(struct vmstat_dirty, vmstat_dirty_pcpu);
+static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
+int sysctl_stat_interval __read_mostly = HZ;
+
+#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER
+static inline void vmstat_queue_local_work(void)
+{
+	bool vmstat_dirty = this_cpu_read(vmstat_dirty_pcpu.dirty);
+	bool cpu_offline = this_cpu_read(vmstat_dirty_pcpu.cpu_offline);
+	int cpu = smp_processor_id();
+
+	if (tick_nohz_full_cpu(cpu) && !vmstat_dirty) {
+		struct delayed_work *dw;
+
+		dw = this_cpu_ptr(&vmstat_work);
+		if (!delayed_work_pending(dw) && !cpu_offline) {
+			unsigned long delay;
+
+			delay = round_jiffies_relative(sysctl_stat_interval);
+			queue_delayed_work_on(cpu, mm_percpu_wq, dw, delay);
+		}
+	}
+}
+#else
+static inline void vmstat_queue_local_work(void)
+{
+}
+#endif
 
 static inline void vmstat_mark_dirty(void)
 {
-	this_cpu_write(vmstat_dirty, true);
+	vmstat_queue_local_work();
+	this_cpu_write(vmstat_dirty_pcpu.dirty, true);
 }
 
 static inline void vmstat_clear_dirty(void)
 {
-	this_cpu_write(vmstat_dirty, false);
+	this_cpu_write(vmstat_dirty_pcpu.dirty, false);
 }
 
 static inline bool is_vmstat_dirty(void)
 {
-	return this_cpu_read(vmstat_dirty);
+	return this_cpu_read(vmstat_dirty_pcpu.dirty);
 }
 
 int calculate_pressure_threshold(struct zone *zone)
@@ -1886,9 +1923,6 @@ static const struct seq_operations vmsta
 #endif /* CONFIG_PROC_FS */
 
 #ifdef CONFIG_SMP
-static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
-int sysctl_stat_interval __read_mostly = HZ;
-
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
 {
@@ -1973,7 +2007,7 @@ static void vmstat_update(struct work_st
  * until the diffs stay at zero. The function is used by NOHZ and can only be
  * invoked when tick processing is not active.
  */
-void quiet_vmstat(void)
+void quiet_vmstat(bool user)
 {
 	if (system_state != SYSTEM_RUNNING)
 		return;
@@ -1981,13 +2015,19 @@ void quiet_vmstat(void)
 	if (!is_vmstat_dirty())
 		return;
 
+	refresh_cpu_vm_stats(false);
+
+	if (!IS_ENABLED(CONFIG_FLUSH_WORK_ON_RESUME_USER))
+		return;
+
+	if (!user)
+		return;
 	/*
-	 * Just refresh counters and do not care about the pending delayed
-	 * vmstat_update. It doesn't fire that often to matter and canceling
-	 * it would be too expensive from this path.
-	 * vmstat_shepherd will take care about that for us.
+	 * If the tick is stopped, cancel any delayed work to avoid
+	 * interruptions to this CPU in the future.
 	 */
-	refresh_cpu_vm_stats(false);
+	if (delayed_work_pending(this_cpu_ptr(&vmstat_work)))
+		cancel_delayed_work(this_cpu_ptr(&vmstat_work));
 }
 
 /*
@@ -2008,8 +2048,14 @@ static void vmstat_shepherd(struct work_
 	/* Check processors whose vmstat worker threads have been disabled */
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
+		struct vmstat_dirty *vms = per_cpu_ptr(&vmstat_dirty_pcpu, cpu);
+
+		if (IS_ENABLED(CONFIG_FLUSH_WORK_ON_RESUME_USER))
+			/* NOHZ full CPUs manage their own vmstat flushing */
+			if (tick_nohz_full_cpu(cpu))
+				continue;
 
-		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
+		if (!delayed_work_pending(dw) && vms->dirty)
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 
 		cond_resched();
@@ -2042,8 +2088,36 @@ static void __init init_cpu_node_state(v
 	}
 }
 
+#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER
+static void vmstat_cpu_online_rearm(unsigned int cpu)
+{
+	struct vmstat_dirty *vms = per_cpu_ptr(&vmstat_dirty_pcpu, cpu);
+
+	if (tick_nohz_full_cpu(cpu)) {
+		struct delayed_work *dw;
+
+		vms->cpu_offline = false;
+		vms->dirty = true;
+
+		dw = this_cpu_ptr(&vmstat_work);
+		if (!delayed_work_pending(dw)) {
+			unsigned long delay;
+
+			delay = round_jiffies_relative(sysctl_stat_interval);
+			queue_delayed_work_on(cpu, mm_percpu_wq, dw, delay);
+		}
+	}
+}
+#else
+static void vmstat_cpu_online_rearm(unsigned int cpu)
+{
+}
+#endif
+
 static int vmstat_cpu_online(unsigned int cpu)
 {
+	vmstat_cpu_online_rearm(cpu);
+
 	refresh_zone_stat_thresholds();
 
 	if (!node_state(cpu_to_node(cpu), N_CPU)) {
@@ -2053,8 +2127,28 @@ static int vmstat_cpu_online(unsigned in
 	return 0;
 }
 
+
+#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER
+static void vmstat_mark_cpu_offline(unsigned int cpu)
+{
+	struct vmstat_dirty *vms = per_cpu_ptr(&vmstat_dirty_pcpu, cpu);
+
+	vms->cpu_offline = true;
+}
+#else
+static void vmstat_mark_cpu_offline(unsigned int cpu)
+{
+}
+#endif
+
+/*
+ * Callbacks in the ONLINE section (CPUHP_AP_ONLINE_DYN is in this section),
+ * are invoked on the hotplugged CPU from the per CPU
+ * hotplug thread with interrupts and preemption enabled.
+ */
 static int vmstat_cpu_down_prep(unsigned int cpu)
 {
+	vmstat_mark_cpu_offline(cpu);
 	cancel_delayed_work_sync(&per_cpu(vmstat_work, cpu));
 	return 0;
 }
Index: linux-2.6/include/linux/vmstat.h
===================================================================
--- linux-2.6.orig/include/linux/vmstat.h
+++ linux-2.6/include/linux/vmstat.h
@@ -290,7 +290,7 @@ extern void dec_zone_state(struct zone *
 extern void __dec_zone_state(struct zone *, enum zone_stat_item);
 extern void __dec_node_state(struct pglist_data *, enum node_stat_item);
 
-void quiet_vmstat(void);
+void quiet_vmstat(bool user);
 void cpu_vm_stats_fold(int cpu);
 void refresh_zone_stat_thresholds(void);
 
@@ -403,7 +403,7 @@ static inline void __dec_node_page_state
 
 static inline void refresh_zone_stat_thresholds(void) { }
 static inline void cpu_vm_stats_fold(int cpu) { }
-static inline void quiet_vmstat(void) { }
+static inline void quiet_vmstat(bool user) { }
 
 static inline void drain_zonestat(struct zone *zone,
 			struct per_cpu_zonestat *pzstats) { }
Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -911,7 +911,7 @@ static void tick_nohz_stop_tick(struct t
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
-		quiet_vmstat();
+		quiet_vmstat(false);
 
 		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 		ts->tick_stopped = 1;
Index: linux-2.6/init/Kconfig
===================================================================
--- linux-2.6.orig/init/Kconfig
+++ linux-2.6/init/Kconfig
@@ -678,6 +678,19 @@ config CPU_ISOLATION
 
 	  Say Y if unsure.
 
+config FLUSH_WORK_ON_RESUME_USER
+	bool "Flush per-CPU vmstats on user return (for nohz full CPUs)"
+	depends on NO_HZ_FULL
+	default y
+
+	help
+	  By default, nohz full CPUs flush per-CPU vm statistics on return
+	  to userspace (to avoid additional interferences when executing
+	  userspace code). This has a small but measurable impact on
+	  system call performance. You can disable this to improve system call
+	  performance, at the expense of potential interferences to userspace
+	  execution.
+
 source "kernel/rcu/Kconfig"
 
 config BUILD_BIN2C


