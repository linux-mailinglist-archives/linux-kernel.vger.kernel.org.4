Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70366A6E3F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCAOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCAOSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56F1233FF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:11 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MBIeOLlrHqRhX6QL4OE3pPIfaDDO8TjpNEVJjFfspc=;
        b=h7Lvvp03+RugOIGosqnBV98qAj+HcLzNQTqm9+o6HZ1lISBDOeGmPB/Ecm1yP5bNn1XFMI
        A60PEuXNon0i0Q5LQcDCAYgVAHnmE2AdZ8td3QUt9I4g/mQWjYedNSd588ZJUUx+uWJnzF
        P1smgh/N18IYFKSP96o/wkIwUNrOCSuj0CnjJGSR5Op8gmTBERzVgl8g3rMpHvjmv0cM33
        hYPj1xgm2CHLuLFfFvEbKRxcwHHO0w67nREzs0m81OnfLkjqGGCfHUC7bzW3i3I7T3vk0d
        i1Uor+G5huRXWcm2/nl84DQ95oE0KjBlnhIx54qFdi8PggMimR4qV5TTHqb5Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MBIeOLlrHqRhX6QL4OE3pPIfaDDO8TjpNEVJjFfspc=;
        b=iWOek0rkR5+g5UYio1TKLdxrwr+KT6aNCz5E0yId2wsyU/6Yhc9iwIe1a+mXeY+tkeQwcb
        3slQN7mWQuW0FeAg==
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
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v5 17/18] timer_migration: Add tracepoints
Date:   Wed,  1 Mar 2023 15:17:43 +0100
Message-Id: <20230301141744.16063-18-anna-maria@linutronix.de>
In-Reply-To: <20230301141744.16063-1-anna-maria@linutronix.de>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..0c4824056930
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
+		__field( unsigned int,	num_childs	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->child		= child;
+		__entry->parent		= child->parent;
+		__entry->lvl		= child->parent->level;
+		__entry->numa_node	= child->parent->numa_node;
+		__entry->numa_node	= child->parent->num_childs;
+		__entry->childmask	= child->childmask;
+	),
+
+	TP_printk("group=%p childmask=%0x parent=%p lvl=%d numa=%d num_childs=%d",
+		  __entry->child,  __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_childs)
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
+		__field( unsigned int,	num_childs	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->parent		= tmc->tmgroup;
+		__entry->cpu		= tmc->cpuevt.cpu;
+		__entry->lvl		= tmc->tmgroup->level;
+		__entry->numa_node	= tmc->tmgroup->numa_node;
+		__entry->numa_node	= tmc->tmgroup->num_childs;
+		__entry->childmask	= tmc->childmask;
+	),
+
+	TP_printk("cpu=%d childmask=%0x parent=%p lvl=%d numa=%d num_childs=%d",
+		  __entry->cpu,	 __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_childs)
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
index 5a600de3623b..5a371bc252d4 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -13,6 +13,9 @@
 #include "timer_migration.h"
 #include "tick-internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/timer_migration.h>
+
 /*
  * The timer migration mechanism is built on a hierarchy of groups. The
  * lowest level group contains CPUs, the next level groups of CPU groups
@@ -320,6 +323,8 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 */
 	group->groupevt.ignore = 1;
 
+	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+
 	return walk_done;
 }
 
@@ -344,6 +349,7 @@ void tmigr_cpu_activate(void)
 	raw_spin_lock(&tmc->lock);
 	tmc->idle = 0;
 	tmc->wakeup = KTIME_MAX;
+	trace_tmigr_cpu_active(tmc);
 	__tmigr_cpu_activate(tmc);
 	raw_spin_unlock(&tmc->lock);
 }
@@ -450,6 +456,9 @@ static bool tmigr_update_events(struct tmigr_group *group,
 		data->nextexp = tmigr_next_groupevt_expires(group);
 	}
 
+	trace_tmigr_update_events(child, group, data->childstate,
+				  data->groupstate, nextexp);
+
 unlock:
 	raw_spin_unlock(&group->lock);
 
@@ -493,6 +502,8 @@ static u64 tmigr_new_timer(struct tmigr_cpu *tmc, u64 nextexp)
 	if (tmc->remote)
 		return KTIME_MAX;
 
+	trace_tmigr_cpu_new_timer(tmc);
+
 	tmc->cpuevt.ignore = 0;
 
 	data.groupstate.state = atomic_read(tmc->tmgroup->migr_state);
@@ -593,6 +604,8 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 		}
 	}
 
+	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
+
 	return walk_done;
 }
 
@@ -669,6 +682,7 @@ u64 tmigr_cpu_deactivate(u64 nextexp)
 	tmc->idle = 1;
 
 unlock:
+	trace_tmigr_cpu_idle(tmc, ret);
 	raw_spin_unlock(&tmc->lock);
 	return ret;
 }
@@ -695,6 +709,8 @@ static u64 tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
 		return next;
 	}
 
+	trace_tmigr_handle_remote_cpu(tmc);
+
 	tmc->remote = 1;
 
 	/* Drop the lock to allow the remote CPU to exit idle */
@@ -746,6 +762,7 @@ static bool tmigr_handle_remote_up(struct tmigr_group *group,
 
 	childmask = data->childmask;
 
+	trace_tmigr_handle_remote(group);
 again:
 	/*
 	 * Handle the group only if @childmask is the migrator or if the
@@ -979,6 +996,7 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, unsigned int node,
 	tmigr_init_group(group, lvl, node, migr_state);
 	/* Setup successful. Add it to the hierarchy */
 	list_add(&group->list, &tmigr_level_list[lvl]);
+	trace_tmigr_group_set(group);
 	return group;
 }
 
@@ -997,6 +1015,8 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irqrestore(&child->lock, flags);
 
+	trace_tmigr_connect_child_parent(child);
+
 	/*
 	 * To prevent inconsistent states, active childs needs to be active
 	 * in new parent as well. Inactive childs are already marked
@@ -1083,6 +1103,8 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 			raw_spin_unlock_irqrestore(&group->lock, flags);
 
+			trace_tmigr_connect_cpu_parent(tmc);
+
 			/* There are no childs that needs to be connected */
 			continue;
 		} else {
@@ -1151,6 +1173,7 @@ static int tmigr_cpu_online(unsigned int cpu)
 		tmc->wakeup = KTIME_MAX;
 	}
 	raw_spin_lock_irqsave(&tmc->lock, flags);
+	trace_tmigr_cpu_online(tmc);
 	__tmigr_cpu_activate(tmc);
 	tmc->online = 1;
 	raw_spin_unlock_irqrestore(&tmc->lock, flags);
@@ -1164,6 +1187,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	raw_spin_lock_irq(&tmc->lock);
 	tmc->online = 0;
 	__tmigr_cpu_deactivate(tmc, KTIME_MAX);
+	trace_tmigr_cpu_offline(tmc);
 	raw_spin_unlock_irq(&tmc->lock);
 
 	return 0;
-- 
2.30.2

