Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A536534B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiLURMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiLURLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A7760FD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671642651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=3gD3dwT2L6CCCjRN92vyud3vtNAmOazkyM6y6Mm+R8Y=;
        b=PQZoEu+1zHYXP8igNSJ1UAjpgUR2es/w0fiU7U6x1HC4UspxmPOqleWn9+UhCbC9zF+82L
        4/AEI3NIQL8gh0bYUuDg4Bq84EgBn2kgUh11hD1aTRB749P494DUGLapysKjV2+sSUcRiw
        gbeQStiFmDFAU4y48x7mcSfMwz2osLk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-P822zIk2PAq546CNbWl-3w-1; Wed, 21 Dec 2022 12:10:45 -0500
X-MC-Unique: P822zIk2PAq546CNbWl-3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BF6918E0046;
        Wed, 21 Dec 2022 17:10:45 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF8E34014EBD;
        Wed, 21 Dec 2022 17:10:44 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id A67D440408D49; Wed, 21 Dec 2022 14:09:34 -0300 (-03)
Message-ID: <20221221170436.330627967@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 21 Dec 2022 13:58:04 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@atomlin.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v11 3/6] mm/vmstat: manage per-CPU stats from CPU context when NOHZ full
References: <20221221165801.362118576@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
 
@@ -194,21 +195,50 @@ void fold_vm_numa_events(void)
 #endif
 
 #ifdef CONFIG_SMP
-static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+
+struct vmstat_dirty {
+	bool dirty;
+	bool cpuhotplug;
+};
+
+static DEFINE_PER_CPU_ALIGNED(struct vmstat_dirty, vmstat_dirty_pcpu);
+static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
+int sysctl_stat_interval __read_mostly = HZ;
 
 static inline void vmstat_mark_dirty(void)
 {
-	this_cpu_write(vmstat_dirty, true);
+	struct vmstat_dirty *vms = this_cpu_ptr(&vmstat_dirty_pcpu);
+
+#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER
+	int cpu = smp_processor_id();
+
+	if (tick_nohz_full_cpu(cpu) && !vms->dirty) {
+		struct delayed_work *dw;
+
+		dw = this_cpu_ptr(&vmstat_work);
+		if (!delayed_work_pending(dw) && !vms->cpuhotplug) {
+			unsigned long delay;
+
+			delay = round_jiffies_relative(sysctl_stat_interval);
+			queue_delayed_work_on(cpu, mm_percpu_wq, dw, delay);
+		}
+	}
+#endif
+	vms->dirty = true;
 }
 
 static inline void vmstat_clear_dirty(void)
 {
-	this_cpu_write(vmstat_dirty, false);
+	struct vmstat_dirty *vms = this_cpu_ptr(&vmstat_dirty_pcpu);
+
+	vms->dirty = false;
 }
 
 static inline bool is_vmstat_dirty(void)
 {
-	return this_cpu_read(vmstat_dirty);
+	struct vmstat_dirty *vms = this_cpu_ptr(&vmstat_dirty_pcpu);
+
+	return vms->dirty;
 }
 
 int calculate_pressure_threshold(struct zone *zone)
@@ -1886,9 +1916,6 @@ static const struct seq_operations vmsta
 #endif /* CONFIG_PROC_FS */
 
 #ifdef CONFIG_SMP
-static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
-int sysctl_stat_interval __read_mostly = HZ;
-
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
 {
@@ -1973,7 +2000,7 @@ static void vmstat_update(struct work_st
  * until the diffs stay at zero. The function is used by NOHZ and can only be
  * invoked when tick processing is not active.
  */
-void quiet_vmstat(void)
+void quiet_vmstat(bool user)
 {
 	if (system_state != SYSTEM_RUNNING)
 		return;
@@ -1981,13 +2008,18 @@ void quiet_vmstat(void)
 	if (!is_vmstat_dirty())
 		return;
 
+	refresh_cpu_vm_stats(false);
+
+#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER
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
+#endif
 }
 
 /*
@@ -2008,8 +2040,15 @@ static void vmstat_shepherd(struct work_
 	/* Check processors whose vmstat worker threads have been disabled */
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
+		struct vmstat_dirty *vms = per_cpu_ptr(&vmstat_dirty_pcpu, cpu);
 
-		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
+#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER
+		/* NOHZ full CPUs manage their own vmstat flushing */
+		if (tick_nohz_full_cpu(cpu))
+			continue;
+#endif
+
+		if (!delayed_work_pending(dw) && vms->dirty)
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 
 		cond_resched();
@@ -2044,6 +2083,25 @@ static void __init init_cpu_node_state(v
 
 static int vmstat_cpu_online(unsigned int cpu)
 {
+#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER
+	struct vmstat_dirty *vms = per_cpu_ptr(&vmstat_dirty_pcpu, cpu);
+
+	if (tick_nohz_full_cpu(cpu)) {
+		struct delayed_work *dw;
+
+		vms->cpuhotplug = false;
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
+#endif
+
 	refresh_zone_stat_thresholds();
 
 	if (!node_state(cpu_to_node(cpu), N_CPU)) {
@@ -2053,8 +2111,15 @@ static int vmstat_cpu_online(unsigned in
 	return 0;
 }
 
+/*
+ * ONLINE: The callbacks are invoked on the hotplugged CPU from the per CPU
+ * hotplug thread with interrupts and preemption enabled.
+ */
 static int vmstat_cpu_down_prep(unsigned int cpu)
 {
+	struct vmstat_dirty *vms = per_cpu_ptr(&vmstat_dirty_pcpu, cpu);
+
+	vms->cpuhotplug = true;
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
Index: linux-2.6/mm/Kconfig
===================================================================
--- linux-2.6.orig/mm/Kconfig
+++ linux-2.6/mm/Kconfig
@@ -1124,6 +1124,19 @@ config PTE_MARKER_UFFD_WP
 	  purposes.  It is required to enable userfaultfd write protection on
 	  file-backed memory types like shmem and hugetlbfs.
 
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
 # multi-gen LRU {
 config LRU_GEN
 	bool "Multi-Gen LRU"


