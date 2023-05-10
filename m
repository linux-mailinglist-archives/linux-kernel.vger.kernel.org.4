Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367476FD83A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjEJHa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbjEJHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:30:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71797869A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:29:39 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683703727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyAKWfyxjIX2BG4rSv+/0LYcifwNkMse08WwDlCLvBc=;
        b=2Z1etC06d4lDLpwjKAOGimT4b+2yNvR89djJPCVhuuxnWs+94hROwFS5LDJDU64oPQUjx3
        CD2BuCRG1KTsSaA5LgdCY2iQZV+UZw1sR30vTMEdoNLSrrK5uuWgCy3HfbbW03yo44bb2/
        gPFcoEyszk5MyPahZY29vhLOifwR6kfaTP/ya/oECYv0cJAlAKpx9Y1q5kIJfLhbtR68g1
        Ih+jZgdD/K0OtU4h3OQwo3ykUkMLRAPGGRXqhS1SnOtoUg1dCweRg2YetWeD2hA/yFQ88Y
        AxCMZPSGmjG7GfHU5dVqjC2RR9LTOYtYnj3I5DFs9lRjWO1GMojn54CMJFQDig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683703727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyAKWfyxjIX2BG4rSv+/0LYcifwNkMse08WwDlCLvBc=;
        b=7VFQE7/nQ8DK+Fxgmu5I7LR8QTaLS/ESlflG86BFSBFu7POvc3QeFadmM5QsWKHbm4cHRK
        oy/sKen7gKCAy4Dw==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v6 20/21] timer_migration: Add tracepoints
Date:   Wed, 10 May 2023 09:28:16 +0200
Message-Id: <20230510072817.116056-21-anna-maria@linutronix.de>
In-Reply-To: <20230510072817.116056-1-anna-maria@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer pull logic needs proper debugging aids. Add tracepoints so the
hierarchical idle machinery can be diagnosed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/trace/events/timer_migration.h | 277 +++++++++++++++++++++++++
 kernel/time/timer_migration.c          |  24 +++
 2 files changed, 301 insertions(+)
 create mode 100644 include/trace/events/timer_migration.h

diff --git a/include/trace/events/timer_migration.h b/include/trace/events/timer_migration.h
new file mode 100644
index 000000000000..9efbaf5dabe6
--- /dev/null
+++ b/include/trace/events/timer_migration.h
@@ -0,0 +1,277 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM timer_migration
+
+#if !defined(_TRACE_TIMER_MIGRATION_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TIMER_MIGRATION_H
+
+#include <linux/tracepoint.h>
+
+/* Group events */
+TRACE_EVENT(tmigr_group_set,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group),
+
+	TP_STRUCT__entry(
+		__field( void *,	group		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->lvl		= group->level;
+		__entry->numa_node	= group->numa_node;
+	),
+
+	TP_printk("group=%p lvl=%d numa=%d",
+		  __entry->group, __entry->lvl, __entry->numa_node)
+);
+
+TRACE_EVENT(tmigr_connect_child_parent,
+
+	TP_PROTO(struct tmigr_group *child),
+
+	TP_ARGS(child),
+
+	TP_STRUCT__entry(
+		__field( void *,	child		)
+		__field( void *,	parent		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( unsigned int,	num_children	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->child		= child;
+		__entry->parent		= child->parent;
+		__entry->lvl		= child->parent->level;
+		__entry->numa_node	= child->parent->numa_node;
+		__entry->numa_node	= child->parent->num_children;
+		__entry->childmask	= child->childmask;
+	),
+
+	TP_printk("group=%p childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
+		  __entry->child,  __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_children)
+);
+
+TRACE_EVENT(tmigr_connect_cpu_parent,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc),
+
+	TP_STRUCT__entry(
+		__field( void *,	parent		)
+		__field( unsigned int,	cpu		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( unsigned int,	num_children	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->parent		= tmc->tmgroup;
+		__entry->cpu		= tmc->cpuevt.cpu;
+		__entry->lvl		= tmc->tmgroup->level;
+		__entry->numa_node	= tmc->tmgroup->numa_node;
+		__entry->numa_node	= tmc->tmgroup->num_children;
+		__entry->childmask	= tmc->childmask;
+	),
+
+	TP_printk("cpu=%d childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
+		  __entry->cpu,	 __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_children)
+);
+
+DECLARE_EVENT_CLASS(tmigr_group_and_cpu,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask),
+
+	TP_STRUCT__entry(
+		__field( void *,	group		)
+		__field( void *,	parent		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( u8,		active		)
+		__field( u8,		migrator	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->parent		= group->parent;
+		__entry->lvl		= group->level;
+		__entry->numa_node	= group->numa_node;
+		__entry->active		= state.active;
+		__entry->migrator	= state.migrator;
+		__entry->childmask	= childmask;
+	),
+
+	TP_printk("group=%p lvl=%d numa=%d active=%0x migrator=%0x "
+		  "parent=%p childmask=%0x",
+		  __entry->group, __entry->lvl, __entry->numa_node,
+		  __entry->active, __entry->migrator,
+		  __entry->parent, __entry->childmask)
+);
+
+DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_inactive,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask)
+);
+
+DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_active,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask)
+);
+
+/* CPU events*/
+DECLARE_EVENT_CLASS(tmigr_cpugroup,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc),
+
+	TP_STRUCT__entry(
+		__field( void *,	parent)
+		__field( unsigned int,	cpu)
+	),
+
+	TP_fast_assign(
+		__entry->cpu		= tmc->cpuevt.cpu;
+		__entry->parent		= tmc->tmgroup;
+	),
+
+	TP_printk("cpu=%d parent=%p", __entry->cpu, __entry->parent)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_new_timer,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_active,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_online,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_offline,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_handle_remote_cpu,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+TRACE_EVENT(tmigr_cpu_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt),
+
+	TP_STRUCT__entry(
+		__field( void *,	parent)
+		__field( unsigned int,	cpu)
+		__field( u64,		nextevt)
+	),
+
+	TP_fast_assign(
+		__entry->cpu		= tmc->cpuevt.cpu;
+		__entry->parent		= tmc->tmgroup;
+		__entry->nextevt	= nextevt;
+	),
+
+	TP_printk("cpu=%d parent=%p nextevt=%llu",
+		  __entry->cpu, __entry->parent, __entry->nextevt)
+);
+
+TRACE_EVENT(tmigr_update_events,
+
+	TP_PROTO(struct tmigr_group *child, struct tmigr_group *group,
+		 union tmigr_state childstate,	union tmigr_state groupstate,
+		 u64 nextevt),
+
+	TP_ARGS(child, group, childstate, groupstate, nextevt),
+
+	TP_STRUCT__entry(
+		__field( void *,	child			)
+		__field( void *,	group			)
+		__field( u64,		nextevt			)
+		__field( u64,		group_next_expiry	)
+		__field( unsigned int,	group_lvl		)
+		__field( u8,		child_active		)
+		__field( u8,		group_active		)
+		__field( unsigned int,	child_evtcpu		)
+		__field( u64,		child_evt_expiry	)
+	),
+
+	TP_fast_assign(
+		__entry->child			= child;
+		__entry->group			= group;
+		__entry->nextevt		= nextevt;
+		__entry->group_next_expiry	= group->next_expiry;
+		__entry->group_lvl		= group->level;
+		__entry->child_active		= childstate.active;
+		__entry->group_active		= groupstate.active;
+		__entry->child_evtcpu		= child ? child->groupevt.cpu : 0;
+		__entry->child_evt_expiry	= child ? child->groupevt.nextevt.expires : 0;
+	),
+
+	TP_printk("child=%p group=%p group_lvl=%d child_active=%0x group_active=%0x "
+		  "nextevt=%llu next_expiry=%llu child_evt_expiry=%llu child_evtcpu=%d",
+		  __entry->child, __entry->group, __entry->group_lvl, __entry->child_active,
+		  __entry->group_active,
+		  __entry->nextevt, __entry->group_next_expiry, __entry->child_evt_expiry,
+		  __entry->child_evtcpu)
+);
+
+TRACE_EVENT(tmigr_handle_remote,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group),
+
+	TP_STRUCT__entry(
+		__field( void * ,	group	)
+		__field( unsigned int ,	lvl	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->lvl		= group->level;
+	),
+
+	TP_printk("group=%p lvl=%d",
+		   __entry->group, __entry->lvl)
+);
+
+#endif /*  _TRACE_TIMER_MIGRATION_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index accce2b368f4..7418743d3334 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -14,6 +14,9 @@
 #include "timer_migration.h"
 #include "tick-internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/timer_migration.h>
+
 /*
  * The timer migration mechanism is built on a hierarchy of groups. The
  * lowest level group contains CPUs, the next level groups of CPU groups
@@ -403,6 +406,8 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 */
 	group->groupevt.ignore = 1;
 
+	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+
 	return walk_done;
 }
 
@@ -433,6 +438,7 @@ void tmigr_cpu_activate(void)
 	raw_spin_lock(&tmc->lock);
 	tmc->idle = 0;
 	tmc->wakeup = KTIME_MAX;
+	trace_tmigr_cpu_active(tmc);
 	__tmigr_cpu_activate(tmc);
 	raw_spin_unlock(&tmc->lock);
 }
@@ -541,6 +547,9 @@ static bool tmigr_update_events(struct tmigr_group *group,
 		data->nextexp = tmigr_next_groupevt_expires(group);
 	}
 
+	trace_tmigr_update_events(child, group, data->childstate,
+				  data->groupstate, nextexp);
+
 unlock:
 	raw_spin_unlock(&group->lock);
 
@@ -584,6 +593,8 @@ static u64 tmigr_new_timer(struct tmigr_cpu *tmc, u64 nextexp)
 	if (tmc->remote)
 		return KTIME_MAX;
 
+	trace_tmigr_cpu_new_timer(tmc);
+
 	tmc->cpuevt.ignore = 0;
 
 	data.groupstate.state = atomic_read(&tmc->tmgroup->migr_state);
@@ -686,6 +697,8 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 		}
 	}
 
+	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
+
 	return walk_done;
 }
 
@@ -758,6 +771,7 @@ u64 tmigr_cpu_deactivate(u64 nextexp)
 	tmc->idle = 1;
 
 unlock:
+	trace_tmigr_cpu_idle(tmc, ret);
 	raw_spin_unlock(&tmc->lock);
 	return ret;
 }
@@ -783,6 +797,8 @@ static u64 tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
 		return next;
 	}
 
+	trace_tmigr_handle_remote_cpu(tmc);
+
 	tmc->remote = 1;
 
 	/* Drop the lock to allow the remote CPU to exit idle */
@@ -853,6 +869,7 @@ static bool tmigr_handle_remote_up(struct tmigr_group *group,
 
 	childmask = data->childmask;
 
+	trace_tmigr_handle_remote(group);
 again:
 	/*
 	 * Handle the group only if @childmask is the migrator or if the
@@ -1059,6 +1076,7 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, unsigned int node,
 
 	/* Setup successful. Add it to the hierarchy */
 	list_add(&group->list, &tmigr_level_list[lvl]);
+	trace_tmigr_group_set(group);
 	return group;
 }
 
@@ -1076,6 +1094,8 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);
 
+	trace_tmigr_connect_child_parent(child);
+
 	/*
 	 * To prevent inconsistent states, active children need to be
 	 * active in new parent as well. Inactive children are already
@@ -1159,6 +1179,8 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 			raw_spin_unlock_irq(&group->lock);
 
+			trace_tmigr_connect_cpu_parent(tmc);
+
 			/* There are no children that need to be connected */
 			continue;
 		} else {
@@ -1227,6 +1249,7 @@ static int tmigr_cpu_online(unsigned int cpu)
 		tmc->wakeup = KTIME_MAX;
 	}
 	raw_spin_lock_irq(&tmc->lock);
+	trace_tmigr_cpu_online(tmc);
 	__tmigr_cpu_activate(tmc);
 	tmc->online = 1;
 	raw_spin_unlock_irq(&tmc->lock);
@@ -1245,6 +1268,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	 * offline; Therefore nextevt value is set to KTIME_MAX
 	 */
 	__tmigr_cpu_deactivate(tmc, KTIME_MAX);
+	trace_tmigr_cpu_offline(tmc);
 	raw_spin_unlock_irq(&tmc->lock);
 
 	return 0;
-- 
2.30.2

