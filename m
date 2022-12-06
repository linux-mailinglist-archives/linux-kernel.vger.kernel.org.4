Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EE7644A38
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiLFRU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiLFRUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:20:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9684C32BA4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670347188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LzBXqEHOMXr4LWZyx1UBLp3VkxawbaFt43nnWFn12AM=;
        b=WHsOD2JEuOoqNcGJajJfHFfpydjuwBz1Bw/MvKXaSSDiL1vpOZdRVgwQwZoeMm64XZ/N+R
        vLJ7aitTTpfqioyOMgVdctT7FNwXZXRdFp5IfpBc2KxR0RvBZ0hn2gVAlE7aDNojEfc8KI
        4xbs90hQgHfP/2KdcofmBe3SRyti3+E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-yDSEV5NgP0u8twIH6bo-Uw-1; Tue, 06 Dec 2022 12:19:42 -0500
X-MC-Unique: yDSEV5NgP0u8twIH6bo-Uw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C2F8296A605;
        Tue,  6 Dec 2022 17:19:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B14740C2064;
        Tue,  6 Dec 2022 17:19:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id CCA02409005DE; Tue,  6 Dec 2022 13:31:40 -0300 (-03)
Message-ID: <20221206162416.474800121@redhat.com>
User-Agent: quilt/0.66
Date:   Tue, 06 Dec 2022 13:18:29 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v9 3/5] mm/vmstat: manage per-CPU stats from CPU context when NOHZ full
References: <20221206161826.698593151@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nohz full CPUs, manage per-CPU stat syncing from CPU context:
start delayed work when marking per-CPU vmstat dirty.

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
 
@@ -195,9 +196,24 @@ void fold_vm_numa_events(void)
 
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
+int sysctl_stat_interval __read_mostly = HZ;
 
 static inline void vmstat_mark_dirty(void)
 {
+	int cpu = smp_processor_id();
+
+	if (tick_nohz_full_cpu(cpu) && !this_cpu_read(vmstat_dirty)) {
+		struct delayed_work *dw;
+
+		dw = &per_cpu(vmstat_work, cpu);
+		if (!delayed_work_pending(dw)) {
+			unsigned long delay;
+
+			delay = round_jiffies_relative(sysctl_stat_interval);
+			queue_delayed_work_on(cpu, mm_percpu_wq, dw, delay);
+		}
+	}
 	this_cpu_write(vmstat_dirty, true);
 }
 
@@ -1886,9 +1902,6 @@ static const struct seq_operations vmsta
 #endif /* CONFIG_PROC_FS */
 
 #ifdef CONFIG_SMP
-static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
-int sysctl_stat_interval __read_mostly = HZ;
-
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
 {
@@ -1973,21 +1986,27 @@ static void vmstat_update(struct work_st
  * until the diffs stay at zero. The function is used by NOHZ and can only be
  * invoked when tick processing is not active.
  */
-void quiet_vmstat(void)
+void quiet_vmstat(bool user)
 {
+	struct delayed_work *dw;
+
 	if (system_state != SYSTEM_RUNNING)
 		return;
 
 	if (!is_vmstat_dirty())
 		return;
 
+	refresh_cpu_vm_stats(false);
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
+	dw = &per_cpu(vmstat_work, smp_processor_id());
+	if (delayed_work_pending(dw))
+		cancel_delayed_work(dw);
 }
 
 /*
@@ -2009,6 +2028,10 @@ static void vmstat_shepherd(struct work_
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
 
+		/* NOHZ full CPUs manage their own vmstat flushing */
+		if (tick_nohz_full_cpu(smp_processor_id()))
+			continue;
+
 		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 
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


