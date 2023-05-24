Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED68270EF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbjEXHIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbjEXHHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:07:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B69E45
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:07:08 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684912026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEvFequz/v8RruCId8HNJNPT119D1XkoaDQOT2BX4vs=;
        b=ObzGprqUayL24Y+3JI8FkJNmBeTslfwnGfr72GM7e2MpSyb08Tcm4uXvYGKHdhihWZ9ckd
        b4ThYApDTu0NWUBKqcmZYvFaZEbUSVTDqLKNFntC2ubZmrr/eZM3tczGPBXTMvu0eFKITT
        Ors811Z5TNzGTZgHd9ixJ78+yXx8nVx/LDkmj1qXk64nnktHhfSEyHtjd9tUjn0VUG02Dy
        PGTGkp+GBkgxn54+rLIaUF5AvBWChfwE/RTy9hgwhsn8ZSQljTb8zJyK/vctCIuHCl4cgA
        a0MP4bExtMBuzn/sm+gqjIOh+tIW2jY2YbilAkPxBZXuuJ14yqLDuFAJofKx0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684912026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEvFequz/v8RruCId8HNJNPT119D1XkoaDQOT2BX4vs=;
        b=yCElpIaC+G3devh5FqHZOTzaQCFPbNXTGV1lutEZr18Zfm9AejaO/pCHe4ZuwiEyLefndm
        w5YWr0VzF0/sN+AA==
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
Subject: [PATCH v7 19/21] timer: Implement the hierarchical pull model
Date:   Wed, 24 May 2023 09:06:27 +0200
Message-Id: <20230524070629.6377-20-anna-maria@linutronix.de>
In-Reply-To: <20230524070629.6377-1-anna-maria@linutronix.de>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Placing timers at enqueue time on a target CPU based on dubious heuristics
does not make any sense:

 1) Most timer wheel timers are canceled or rearmed before they expire.

 2) The heuristics to predict which CPU will be busy when the timer expires
    are wrong by definition.

So placing the timers at enqueue wastes precious cycles.

The proper solution to this problem is to always queue the timers on the
local CPU and allow the non pinned timers to be pulled onto a busy CPU at
expiry time.

Therefore split the timer storage into local pinned and global timers:
Local pinned timers are always expired on the CPU on which they have been
queued. Global timers can be expired on any CPU.

As long as a CPU is busy it expires both local and global timers. When a
CPU goes idle it arms for the first expiring local timer. If the first
expiring pinned (local) timer is before the first expiring movable timer,
then no action is required because the CPU will wake up before the first
movable timer expires. If the first expiring movable timer is before the
first expiring pinned (local) timer, then this timer is queued into a idle
timerqueue and eventually expired by some other active CPU.

To avoid global locking the timerqueues are implemented as a hierarchy. The
lowest level of the hierarchy holds the CPUs. The CPUs are associated to
groups of 8, which are separated per node. If more than one CPU group
exist, then a second level in the hierarchy collects the groups. Depending
on the size of the system more than 2 levels are required. Each group has a
"migrator" which checks the timerqueue during the tick for remote expirable
timers.

If the last CPU in a group goes idle it reports the first expiring event in
the group up to the next group(s) in the hierarchy. If the last CPU goes
idle it arms its timer for the first system wide expiring timer to ensure
that no timer event is missed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v7:
  - Review remarks of Frederic and bigeasy:
    - change logic in tmigr_handle_remote_cpu()
    - s/kzalloc/kcalloc
    - move timer_expire_remote() into NO_HZ_COMMON && SMP config section
    - drop DBG_BUG_ON() makro and use only WARN_ON_ONCE()
    - remove leftovers from sibling logic during setup
  - Move timer_expire_remote() into tick-internal.h
  - Add documentation section about "Required event and timerqueue update
    after remote expiry"
  - Fix fallout of kernel test robot

v6:
  - Fix typos
  - Review remarks of Peter Zijlstra (locking, struct member cleanup, use
    atomic_try_cmpxchg(), update struct member descriptions)
  - Fix race in tmigr_handle_remote_cpu() (Frederic Weisbecker)

v5:
  - Review remarks of Frederic
  - Return nextevt when CPU is marked offline in timer migration hierarchy
    instead of KTIME_MAX
  - Fix update of group events issue, after remote expiring

v4:
  - Fold typo fix in comment into proper patch "timer: Split out "get next
    timer interrupt" functionality"
  - Update wrong comment for tmigr_state union definition
  - Fix fallout of kernel test robot
---
 include/linux/cpuhotplug.h    |    1 +
 kernel/time/Makefile          |    3 +
 kernel/time/tick-internal.h   |    1 +
 kernel/time/timer.c           |   73 +-
 kernel/time/timer_migration.c | 1411 +++++++++++++++++++++++++++++++++
 kernel/time/timer_migration.h |  136 ++++
 6 files changed, 1617 insertions(+), 8 deletions(-)
 create mode 100644 kernel/time/timer_migration.c
 create mode 100644 kernel/time/timer_migration.h

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0f1001dca0e0..a32395b128de 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -242,6 +242,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE,
 	CPUHP_AP_PERF_POWERPC_HV_GPCI_ONLINE,
 	CPUHP_AP_PERF_CSKY_ONLINE,
+	CPUHP_AP_TMIGR_ONLINE,
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RANDOM_ONLINE,
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index 7e875e63ff3b..4af2a264a160 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -17,6 +17,9 @@ endif
 obj-$(CONFIG_GENERIC_SCHED_CLOCK)		+= sched_clock.o
 obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o tick-sched.o
 obj-$(CONFIG_LEGACY_TIMER_TICK)			+= tick-legacy.o
+ifeq ($(CONFIG_SMP),y)
+ obj-$(CONFIG_NO_HZ_COMMON)			+= timer_migration.o
+endif
 obj-$(CONFIG_HAVE_GENERIC_VDSO)			+= vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 34d44fb50c81..f5020473cc93 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -166,6 +166,7 @@ extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
 					      unsigned int cpu);
 extern void timer_lock_remote_bases(unsigned int cpu);
 extern void timer_unlock_remote_bases(unsigned int cpu);
+extern void timer_expire_remote(unsigned int cpu);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index c2d66fd4638f..3a8c2c88f845 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -53,6 +53,7 @@
 #include <asm/io.h>
 
 #include "tick-internal.h"
+#include "timer_migration.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/timer.h>
@@ -2078,6 +2079,21 @@ void timer_lock_remote_bases(unsigned int cpu)
 	raw_spin_lock(&base_local->lock);
 	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 }
+
+static void __run_timer_base(struct timer_base *base);
+
+/**
+ * timer_expire_remote - expire global timers of cpu
+ * @cpu:	Remote CPU
+ *
+ * Expire timers of global base of remote CPU.
+ */
+void timer_expire_remote(unsigned int cpu)
+{
+	struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	__run_timer_base(base);
+}
 # endif /* CONFIG_SMP */
 
 /*
@@ -2104,8 +2120,11 @@ static void forward_base_clk(struct timer_base *base, unsigned long nextevt,
  * idle. Idle marking of timer bases is allowed only to be done by CPU
  * itself.
  *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
+ * Returns the tick aligned clock monotonic time of the next pending timer
+ * or KTIME_MAX if no timer is pending. If timer of global base was queued
+ * into timer migration hierarchy, first global timer is not taken into
+ * account. If it was the last CPU of timer migration hierarchy going idle,
+ * first global event is taken into account.
  */
 u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
@@ -2149,6 +2168,40 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	 */
 	is_idle = time_after(nextevt, basej + 1);
 
+	if (is_idle) {
+		u64 next_tmigr;
+
+		/*
+		 * Enqueue first global timer into timer migration
+		 * hierarchy, afterwards tevt.global is no longer used.
+		 */
+		next_tmigr = tmigr_cpu_deactivate(tevt.global);
+
+		/*
+		 * If CPU is the last going idle in timer migration
+		 * hierarchy, make sure CPU will wake up in time to handle
+		 * remote timers. next_tmigr == KTIME_MAX if other CPUs are
+		 * still active.
+		 */
+		if (next_tmigr < tevt.local) {
+			u64 tmp;
+
+			/* If we missed a tick already, force 0 delta */
+			if (next_tmigr < basem)
+				next_tmigr = basem;
+
+			tmp = div_u64(next_tmigr - basem, TICK_NSEC);
+
+			nextevt = basej + (unsigned long)tmp;
+			tevt.local = next_tmigr;
+			is_idle = time_after(nextevt, basej + 1);
+		}
+		/*
+		 * Update of nextevt is not required in an else path, as it
+		 * is revisited in !is_idle path only.
+		 */
+	}
+
 	/* We need to mark both bases in sync */
 	base_local->is_idle = base_global->is_idle = is_idle;
 
@@ -2159,19 +2212,16 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	 * If the bases are not marked idle, i.e one of the events is at
 	 * max. one tick away, then the CPU can't go into a NOHZ idle
 	 * sleep. Use the earlier event of both and store it in the local
-	 * expiry value. The next global event is irrelevant in this case
-	 * and can be left as KTIME_MAX. CPU will wakeup on time.
+	 * expiry value. tevt.global update is superfluous and is
+	 * ignored. CPU will wakeup on time.
 	 */
 	if (!is_idle) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
-		tevt.global = KTIME_MAX;
 	}
 
-	tevt.local = min_t(u64, tevt.local, tevt.global);
-
 	return cmp_next_hrtimer_event(basem, tevt.local);
 }
 
@@ -2190,6 +2240,9 @@ void timer_clear_idle(void)
 	 */
 	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
 	__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
+
+	/* Activate without holding the timer_base->lock */
+	tmigr_cpu_activate();
 }
 #endif
 
@@ -2255,6 +2308,9 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
 		run_timer_base(BASE_GLOBAL);
 		run_timer_base(BASE_DEF);
+
+		if (is_timers_nohz_active())
+			tmigr_handle_remote();
 	}
 }
 
@@ -2269,7 +2325,8 @@ static void run_local_timers(void)
 
 	for (int i = 0; i < NR_BASES; i++, base++) {
 		/* Raise the softirq only if required. */
-		if (time_after_eq(jiffies, base->next_expiry)) {
+		if (time_after_eq(jiffies, base->next_expiry) ||
+		    (i == BASE_DEF && tmigr_requires_handle_remote())) {
 			raise_softirq(TIMER_SOFTIRQ);
 			return;
 		}
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
new file mode 100644
index 000000000000..eab58bc98c7f
--- /dev/null
+++ b/kernel/time/timer_migration.c
@@ -0,0 +1,1411 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Infrastructure for migratable timers
+ *
+ * Copyright(C) 2022 linutronix GmbH
+ */
+#include <linux/cpuhotplug.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/timerqueue.h>
+#include <trace/events/ipi.h>
+
+#include "timer_migration.h"
+#include "tick-internal.h"
+
+/*
+ * The timer migration mechanism is built on a hierarchy of groups. The
+ * lowest level group contains CPUs, the next level groups of CPU groups
+ * and so forth. The CPU groups are kept per node so for the normal case
+ * lock contention won't happen across nodes. Depending on the number of
+ * CPUs per node even the next level might be kept as groups of CPU groups
+ * per node and only the levels above cross the node topology.
+ *
+ * Example topology for a two node system with 24 CPUs each.
+ *
+ * LVL 2			[GRP2:0]
+ *			      GRP1:0 = GRP1:M
+ *
+ * LVL 1            [GRP1:0]		         [GRP1:1]
+ *	         GRP0:0 - GRP0:2	      GRP0:3 - GRP0:5
+ *
+ * LVL 0  [GRP0:0]  [GRP0:1]  [GRP0:2]  [GRP0:3]  [GRP0:4]  [GRP0:5]
+ * CPUS     0-7       8-15     16-23     24-31	   32-39     40-47
+ *
+ * The groups hold a timer queue of events sorted by expiry time. These
+ * queues are updated when CPUs go in idle. When they come out of idle
+ * ignore bit of events is set.
+ *
+ * Each group has a designated migrator CPU/group as long as a CPU/group is
+ * active in the group. This designated role is necessary to avoid that all
+ * active CPUs in a group try to migrate expired timers from other cpus,
+ * which would result in massive lock bouncing.
+ *
+ * When a CPU is awake, it checks in it's own timer tick the group
+ * hierarchy up to the point where it is assigned the migrator role or if
+ * no CPU is active, it also checks the groups where no migrator is set
+ * (TMIGR_NONE).
+ *
+ * If it finds expired timers in one of the group queues it pulls them over
+ * from the idle CPU and runs the timer function. After that it updates the
+ * group and the parent groups if required.
+ *
+ * CPUs which go idle arm their CPU local timer hardware for the next local
+ * (pinned) timer event. If the next migratable timer expires after the
+ * next local timer or the CPU has no migratable timer pending then the
+ * CPU does not queue an event in the LVL0 group. If the next migratable
+ * timer expires before the next local timer then the CPU queues that timer
+ * in the LVL0 group. In both cases the CPU marks itself idle in the LVL0
+ * group.
+ *
+ * When CPU comes out of idle and when a group has at least a single active
+ * child, the ignore flag of the tmigr_event is set. This indicates, that
+ * the event is ignored even if it is still enqueued in the parent groups
+ * timer queue. It will be removed when touching the timer queue the next
+ * time. This spares locking in active path as the lock protects (after
+ * setup) only event information. For more information about locking,
+ * please read the section "Locking rules".
+ *
+ * If the CPU is the migrator of the group then it delegates that role to
+ * the next active CPU in the group or sets migrator to TMIGR_NONE when
+ * there is no active CPU in the group. This delegation needs to be
+ * propagated up the hierarchy so hand over from other leaves can happen at
+ * all hierarchy levels w/o doing a search.
+ *
+ * When the last CPU in the system goes idle, then it drops all migrator
+ * duties up to the top level of the hierarchy (LVL2 in the example). It
+ * then has to make sure, that it arms it's own local hardware timer for
+ * the earliest event in the system.
+ *
+ *
+ * Lifetime rules:
+ * ---------------
+ *
+ * The groups are built up at init time or when CPUs come online. They are
+ * not destroyed when a group becomes empty due to offlining. The group
+ * just won't participate in the hierachary management anymore. Destroying
+ * groups would result in interesting race conditions which would just make
+ * the whole mechanism slow and complex.
+ *
+ *
+ * Locking rules:
+ * --------------
+ *
+ * For setting up new groups and handling events it's required to lock both
+ * child and parent group. The lock odering is always bottom up. This also
+ * includes the per CPU locks in struct tmigr_cpu. For updating migrator
+ * and active CPU/group information atomic_try_cmpxchg() is used instead
+ * and only per CPU tmigr_cpu->lock is held.
+ *
+ * During setup of groups tmigr_level_list is required. It is protected by
+ * tmigr_mutex.
+ *
+ * When timer_base->lock as well as tmigr related locks are required, lock
+ * ordering is: first timer_base->lock, afterwards tmigr related locks.
+ *
+ *
+ * Protection of tmigr group state information:
+ * --------------------------------------------
+ *
+ * The state information with the list of active children and migrator needs
+ * to be protected by a sequence counter. It prevents a race when updates
+ * in child groups are propagated in changed order. The following scenario
+ * describes what happens without updating the sequence counter:
+ *
+ * Therefore, let's take three groups and four CPUs (CPU2 and CPU3 as well
+ * as GRP0:1 will not change during the scenario):
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:0, GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator = CPU0           migrator = CPU2
+ *           active   = CPU0           active   = CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             active      idle           active      idle
+ *
+ *
+ * 1. CPU0 goes idle (changes are updated in GRP0:0; afterwards current
+ *    states of GRP0:0 and GRP1:0 are stored in the data for walking the
+ *    hierarchy):
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:0, GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *       --> migrator = TMIGR_NONE     migrator = CPU2
+ *       --> active   =                active   = CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *         --> idle        idle           active      idle
+ *
+ * 2. CPU1 comes out of idle (changes are update in GRP0:0; afterwards
+ *    current states of GRP0:0 and GRP1:0 are stored in the data for
+ *    walking the hierarchy):
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:0, GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *       --> migrator = CPU1           migrator = CPU2
+ *       --> active   = CPU1           active   = CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle    --> active         active      idle
+ *
+ * 3. Here comes the change of the order: Propagating the changes of step 2
+ *    through the hierarchy to GRP1:0 - nothing to be done, because GRP0:0
+ *    is already up to date.
+ *
+ * 4. Propagating the changes of step 1 through the hierarchy to GRP1:0
+ *
+ *    LVL 1            [GRP1:0]
+ *                 --> migrator = GRP0:1
+ *                 --> active   = GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator = CPU1           migrator = CPU2
+ *           active   = CPU1           active   = CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        active         active      idle
+ *
+ * Now there is a inconsistent overall state because GRP0:0 is active, but
+ * it is marked as idle in the GRP1:0. This is prevented by incrementing
+ * sequence counter whenever changing the state.
+ *
+ *
+ * Required event and timerqueue update after remote expiry:
+ * ---------------------------------------------------------
+ *
+ * After remote expiry of a CPU, a walk through the hierarchy updating
+ * events and timerqueues has to be done when there is a 'new' global timer
+ * of the remote CPU (which is obvious) but also if there is no new global
+ * timer, but the remote CPU is still idle:
+ *
+ * 1. CPU2 is migrator and does the remote expiry in GRP1:0; expiry of
+ *    evt-CPU0 and evt-CPU1 are equal:
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:1
+ *                 --> timerqueue = evt-GRP0:0
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator = TMIGR_NONE     migrator = CPU2
+ *           active   =                active   = CPU2
+ *           groupevt.ignore = 0       groupevt.ignore = 1
+ *           groupevt.cpu = CPU0       groupevt.cpu =
+ *           timerqueue = evt-CPU0,    timerqueue =
+ *                        evt-CPU1
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           active      idle
+ *
+ * 2. Remove first event of timerqueue in GRP1:0 and expire timers of CPU0
+ *    (see evt-GRP0:0->cpu value):
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:1
+ *                 --> timerqueue =
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator = TMIGR_NONE     migrator = CPU2
+ *           active   =                active   = CPU2
+ *           groupevt.ignore = 0       groupevt.ignore = 1
+ *       --> groupevt.cpu = CPU0       groupevt.cpu =
+ *           timerqueue = evt-CPU0,    timerqueue =
+ *                        evt-CPU1
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           active      idle
+ *
+ * 3. After remote expiry CPU0 has no global timer that needs to be
+ *    enqueued. When skipping the walk, global timer of CPU1 is not
+ *    handled, as group event of GRP0:0 is not updated and not enqueued
+ *    into GRP1:0. The walk has to be done to update the group events and
+ *    timerqueues:
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:1
+ *                 --> timerqueue = evt-GRP0:0
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator = TMIGR_NONE     migrator = CPU2
+ *           active   =                active   = CPU2
+ *           groupevt.ignore = 0       groupevt.ignore = 1
+ *       --> groupevt.cpu = CPU1       groupevt.cpu =
+ *       --> timerqueue = evt-CPU1     timerqueue =
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           active      idle
+ *
+ * Now CPU2 (migrator) is able to handle timer of CPU1 as CPU2 only scans
+ * the timerqueues of GRP0:1 and GRP1:0.
+ *
+ * The update of step 3 is valid to be skipped, when remote CPU went
+ * offline in the meantime because update was already done during inactive
+ * path. When CPU became active in the meantime, update isn't required as
+ * well, because GRP0:0 is now longer idle.
+ */
+
+static DEFINE_MUTEX(tmigr_mutex);
+static struct list_head *tmigr_level_list __read_mostly;
+
+static unsigned int tmigr_hierarchy_levels __read_mostly;
+static unsigned int tmigr_crossnode_level __read_mostly;
+
+static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
+
+#define TMIGR_NONE	0xFF
+#define BIT_CNT		8
+
+static DEFINE_STATIC_KEY_FALSE(tmigr_enabled);
+
+static inline bool is_tmigr_enabled(void)
+{
+	return static_branch_unlikely(&tmigr_enabled);
+}
+
+/*
+ * Returns true, when @childmask corresponds to group migrator or when group
+ * is not active - so no migrator is set.
+ */
+static bool tmigr_check_migrator(struct tmigr_group *group, u8 childmask)
+{
+	union tmigr_state s;
+
+	s.state = atomic_read(&group->migr_state);
+
+	if ((s.migrator != childmask) && (s.migrator != TMIGR_NONE))
+		return false;
+
+	return true;
+}
+
+typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, void *);
+
+static void __walk_groups(up_f up, void *data,
+			  struct tmigr_cpu *tmc)
+{
+	struct tmigr_group *child = NULL, *group = tmc->tmgroup;
+
+	do {
+		WARN_ON_ONCE(group->level >= tmigr_hierarchy_levels);
+
+		if (up(group, child, data))
+			break;
+
+		child = group;
+		group = group->parent;
+	} while (group);
+}
+
+static void walk_groups(up_f up, void *data, struct tmigr_cpu *tmc)
+{
+	lockdep_assert_held(&tmc->lock);
+
+	__walk_groups(up, data, tmc);
+}
+
+/**
+ * struct tmigr_walk - data required for walking the hierarchy
+ * @evt:		Pointer to tmigr_event which needs to be queued (of idle
+ *			child group)
+ * @childmask:		childmask of child group
+ * @nextexp:		Next CPU event expiry information which is handed
+ *			into tmigr code by timer code
+ *			(get_next_timer_interrupt()); it is furthermore
+ *			used for first event which is queued, if timer
+ *			migration hierarchy is completely idle
+ * @childstate:		tmigr_group->migr_state of child - will be only reread
+ *			when cmpxchg in group fails (is required for deactivate
+ *			path and new timer path)
+ * @groupstate:		tmigr_group->migr_state of group - will be only reread
+ *			when cmpxchg in group fails (is required for active,
+ *			deactivate and new timer path)
+ * @remote:		Is set, when new timer path is executed in
+ *			tmigr_handle_remote_cpu()
+ */
+struct tmigr_walk {
+	struct tmigr_event	*evt;
+	u8			childmask;
+	u64			nextexp;
+	union tmigr_state	childstate;
+	union tmigr_state	groupstate;
+	bool			remote;
+};
+
+/**
+ * struct tmigr_remote_data -	data required for (check) remote expiry
+ *				hierarchy walk
+ * @basej:	timer base in jiffies
+ * @now:	timer base monotonic
+ * @childmask:	childmask of child group
+ * @check:	is set to 1 if there is the need to handle remote timers;
+ *		required in tmigr_check_handle_remote() only
+ * @wakeup:	returns expiry of first timer in idle timer migration hierarchy
+ *		to make sure timer is handled in time; it is stored in per CPU
+ *		tmigr_cpu struct of CPU which expires remote timers
+ */
+struct tmigr_remote_data {
+	unsigned long	basej;
+	u64		now;
+	u8		childmask;
+	int		check;
+	u64		wakeup;
+};
+
+/*
+ * Returns next event of timerqueue @group->events
+ *
+ * Removes timers with ignore bits and update next_expiry of group. Values
+ * of group event are updated in tmigr_update_events() only.
+ */
+static struct tmigr_event *tmigr_next_groupevt(struct tmigr_group *group)
+{
+	struct timerqueue_node *node = NULL;
+	struct tmigr_event *evt = NULL;
+
+	lockdep_assert_held(&group->lock);
+
+	WRITE_ONCE(group->next_expiry, KTIME_MAX);
+
+	while ((node = timerqueue_getnext(&group->events))) {
+		evt = container_of(node, struct tmigr_event, nextevt);
+
+		if (!evt->ignore) {
+			WRITE_ONCE(group->next_expiry, evt->nextevt.expires);
+			return evt;
+		}
+
+		/*
+		 * Remove next timers with ignore bits, because group lock
+		 * is held anyway
+		 */
+		if (!timerqueue_del(&group->events, node))
+			break;
+	}
+
+	return NULL;
+}
+
+/*
+ * Return next event which is already expired of group timerqueue
+ *
+ * Event is also removed from queue.
+ */
+static struct tmigr_event *tmigr_next_expired_groupevt(struct tmigr_group *group,
+						     u64 now)
+{
+	struct tmigr_event *evt = tmigr_next_groupevt(group);
+
+	if (!evt || now < evt->nextevt.expires)
+		return NULL;
+
+	/*
+	 * Event is already expired. Remove it. If it's not the last event,
+	 * then update all group event related information.
+	 */
+	if (timerqueue_del(&group->events, &evt->nextevt))
+		tmigr_next_groupevt(group);
+	else
+		WRITE_ONCE(group->next_expiry, KTIME_MAX);
+
+	return evt;
+}
+
+static u64 tmigr_next_groupevt_expires(struct tmigr_group *group)
+{
+	struct tmigr_event *evt;
+
+	evt = tmigr_next_groupevt(group);
+
+	if (!evt)
+		return KTIME_MAX;
+	else
+		return evt->nextevt.expires;
+}
+
+static bool tmigr_active_up(struct tmigr_group *group,
+			    struct tmigr_group *child,
+			    void *ptr)
+{
+	union tmigr_state curstate, newstate;
+	struct tmigr_walk *data = ptr;
+	bool walk_done;
+	u8 childmask;
+
+	childmask = data->childmask;
+	newstate = curstate = data->groupstate;
+
+retry:
+	walk_done = true;
+
+	if (newstate.migrator == TMIGR_NONE) {
+		newstate.migrator = childmask;
+
+		/* Changes need to be propagated */
+		walk_done = false;
+	}
+
+	newstate.active |= childmask;
+
+	newstate.seq++;
+
+	if (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state)) {
+		newstate.state = curstate.state;
+		goto retry;
+	}
+
+	if (group->parent && (walk_done == false)) {
+		data->groupstate.state = atomic_read(&group->parent->migr_state);
+		data->childmask = group->childmask;
+	}
+
+	/*
+	 * Group is active, event will be ignored - bit is updated without
+	 * holding the lock. In case bit is set while another CPU already
+	 * handles remote events, nothing happens, because it is clear that
+	 * CPU became active just in this moment, or in worst case event is
+	 * handled remote. Nothing to worry about.
+	 */
+	group->groupevt.ignore = 1;
+
+	return walk_done;
+}
+
+static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
+{
+	struct tmigr_walk data;
+
+	data.childmask = tmc->childmask;
+	data.groupstate.state = atomic_read(&tmc->tmgroup->migr_state);
+
+	tmc->cpuevt.ignore = 1;
+
+	walk_groups(&tmigr_active_up, &data, tmc);
+}
+
+/**
+ * tmigr_cpu_activate - set CPU active in timer migration hierarchy
+ *
+ * Call site timer_clear_idle() is called with interrupts disabled
+ */
+void tmigr_cpu_activate(void)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+
+	if (!is_tmigr_enabled() || !tmc->tmgroup || !tmc->online || !tmc->idle)
+		return;
+
+	raw_spin_lock(&tmc->lock);
+	tmc->idle = 0;
+	tmc->wakeup = KTIME_MAX;
+	__tmigr_cpu_activate(tmc);
+	raw_spin_unlock(&tmc->lock);
+}
+
+/*
+ * Returns true, if there is nothing to be propagated to the next level
+ *
+ * @data->nextexp is reset to KTIME_MAX; it is reused for first global
+ * event which needs to be handled by migrator (in toplevel group)
+ *
+ * This is the only place where group event expiry value is set.
+ */
+static bool tmigr_update_events(struct tmigr_group *group,
+				struct tmigr_group *child,
+				struct tmigr_walk *data)
+{
+	struct tmigr_event *evt, *first_childevt;
+	bool walk_done, remote = data->remote;
+	u64 nextexp;
+
+	if (child) {
+		if (data->childstate.active)
+			return true;
+
+		raw_spin_lock(&child->lock);
+		raw_spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
+
+		first_childevt = tmigr_next_groupevt(child);
+		nextexp = child->next_expiry;
+		evt = &child->groupevt;
+	} else {
+		nextexp = data->nextexp;
+
+		/*
+		 * Set @data->nextexp to KTIME_MAX; it is reused for first
+		 * global event which needs to be handled by migrator (in
+		 * toplevel group)
+		 */
+		data->nextexp = KTIME_MAX;
+
+		first_childevt = evt = data->evt;
+
+		/*
+		 * Walking the hierarchy is required in any case, when a
+		 * remote expiry was done before. This ensures to not lost
+		 * already queued events in non active groups (see section
+		 * "Required event and timerqueue update after remote
+		 * expiry" in documentation at the top).
+		 */
+		if (evt->ignore && !remote)
+			return true;
+
+		raw_spin_lock(&group->lock);
+	}
+
+	if (nextexp == KTIME_MAX) {
+		evt->ignore = 1;
+
+		/*
+		 * When next child event could be ignored (nextexp is
+		 * KTIME_MAX) and there was no remote timer handling before
+		 * or the group is already active, there is no need to walk
+		 * the hierarchy even if there is a parent group.
+		 *
+		 * The other way round: even if the event could be ignored,
+		 * but if a remote timer handling was executed before and
+		 * the group is not active, walking the hierarchy is
+		 * required to not miss an enqueued timer in the non active
+		 * group. The enqueued timer of the group needs to be
+		 * propagated to a higher level to ensure it is handled.
+		 */
+		if (!remote || data->groupstate.active) {
+			walk_done = true;
+			goto unlock;
+		}
+	} else {
+		/*
+		 * Update of event cpu and ignore bit is required only when
+		 * @child is set (child is equal or higher than lvl0), but
+		 * it doesn't matter if it is written once more to per cpu
+		 * event; make the update unconditional.
+		 */
+		evt->cpu = first_childevt->cpu;
+		evt->ignore = 0;
+	}
+
+	walk_done = !group->parent;
+
+	/*
+	 * If child event is already queued in group, remove it from queue
+	 * when expiry time changed only.
+	 */
+	if (timerqueue_node_queued(&evt->nextevt)) {
+		if (evt->nextevt.expires == nextexp)
+			goto check_toplvl;
+		else if (!timerqueue_del(&group->events, &evt->nextevt))
+			WRITE_ONCE(group->next_expiry, KTIME_MAX);
+	}
+
+	evt->nextevt.expires = nextexp;
+
+	if (timerqueue_add(&group->events, &evt->nextevt))
+		WRITE_ONCE(group->next_expiry, nextexp);
+
+check_toplvl:
+	if (walk_done && (data->groupstate.migrator == TMIGR_NONE)) {
+		/*
+		 * Toplevel group is idle and it has to be ensured global
+		 * timers are handled in time. (This could be optimized by
+		 * keeping track of the last global scheduled event and
+		 * only arming it on CPU if the new event is earlier. Not
+		 * sure if its worth the complexity.)
+		 */
+		data->nextexp = tmigr_next_groupevt_expires(group);
+	}
+
+unlock:
+	raw_spin_unlock(&group->lock);
+
+	if (child)
+		raw_spin_unlock(&child->lock);
+
+	return walk_done;
+}
+
+static bool tmigr_new_timer_up(struct tmigr_group *group,
+			       struct tmigr_group *child,
+			       void *ptr)
+{
+	struct tmigr_walk *data = ptr;
+	bool walk_done;
+
+	walk_done = tmigr_update_events(group, child, data);
+
+	if (!walk_done) {
+		/* Update state information for next iteration */
+		data->childstate.state = atomic_read(&group->migr_state);
+		if (group->parent)
+			data->groupstate.state = atomic_read(&group->parent->migr_state);
+	}
+
+	return walk_done;
+}
+
+/*
+ * Returns expiry of next timer that needs to be handled. KTIME_MAX is
+ * returned, when an active CPU will handle all timer migration hierarchy
+ * timers.
+ */
+static u64 tmigr_new_timer(struct tmigr_cpu *tmc, u64 nextexp)
+{
+	struct tmigr_walk data = { .evt = &tmc->cpuevt,
+				   .nextexp = nextexp };
+
+	lockdep_assert_held(&tmc->lock);
+
+	if (tmc->remote)
+		return KTIME_MAX;
+
+	tmc->cpuevt.ignore = 0;
+
+	data.groupstate.state = atomic_read(&tmc->tmgroup->migr_state);
+	data.remote = false;
+
+	walk_groups(&tmigr_new_timer_up, &data, tmc);
+
+	/* If there is a new first global event, make sure it is handled */
+	return data.nextexp;
+}
+
+static bool tmigr_inactive_up(struct tmigr_group *group,
+			      struct tmigr_group *child,
+			      void *ptr)
+{
+	union tmigr_state curstate, newstate;
+	struct tmigr_walk *data = ptr;
+	bool walk_done;
+	u8 childmask;
+
+	childmask = data->childmask;
+	newstate = curstate = data->groupstate;
+
+retry:
+	walk_done = true;
+
+	/* Reset active bit when child is no longer active */
+	if (!data->childstate.active)
+		newstate.active &= ~childmask;
+
+	if (newstate.migrator == childmask) {
+		/*
+		 * Find a new migrator for the group, because child group
+		 * is idle!
+		 */
+		if (!data->childstate.active) {
+			unsigned long new_migr_bit, active = newstate.active;
+
+			new_migr_bit = find_first_bit(&active, BIT_CNT);
+
+			if (new_migr_bit != BIT_CNT) {
+				newstate.migrator = BIT(new_migr_bit);
+			} else {
+				newstate.migrator = TMIGR_NONE;
+
+				/* Changes need to be propagated */
+				walk_done = false;
+			}
+		}
+	}
+
+	newstate.seq++;
+
+	WARN_ON_ONCE((newstate.migrator != TMIGR_NONE) && !(newstate.active));
+
+	if (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state)) {
+		newstate.state = curstate.state;
+
+		/*
+		 * Something changed in child/parent group in the meantime,
+		 * reread the state of child and parent; Update of
+		 * data->childstate is required for event handling;
+		 */
+		if (child)
+			data->childstate.state = atomic_read(&child->migr_state);
+
+		goto retry;
+	}
+
+	data->groupstate = newstate;
+	data->remote = false;
+
+	/* Event Handling */
+	tmigr_update_events(group, child, data);
+
+	if (group->parent && (walk_done == false)) {
+		data->childmask = group->childmask;
+		data->childstate = newstate;
+		data->groupstate.state = atomic_read(&group->parent->migr_state);
+	}
+
+	/*
+	 * data->nextexp was set by tmigr_update_events() and contains the
+	 * expiry of first global event which needs to be handled
+	 */
+	if (data->nextexp != KTIME_MAX) {
+		WARN_ON_ONCE(group->parent);
+		/*
+		 * Toplevel path - If this cpu is about going offline wake
+		 * up some random other cpu so it will take over the
+		 * migrator duty and program its timer properly. Ideally
+		 * wake the cpu with the closest expiry time, but that's
+		 * overkill to figure out.
+		 */
+		if (!(this_cpu_ptr(&tmigr_cpu)->online)) {
+			unsigned int cpu = smp_processor_id();
+
+			cpu = cpumask_any_but(cpu_online_mask, cpu);
+			smp_send_reschedule(cpu);
+		}
+	}
+
+	return walk_done;
+}
+
+static u64 __tmigr_cpu_deactivate(struct tmigr_cpu *tmc, u64 nextexp)
+{
+	struct tmigr_walk data = { .childmask = tmc->childmask,
+				   .evt = &tmc->cpuevt,
+				   .nextexp = nextexp,
+				   .childstate.state = 0 };
+
+	data.groupstate.state = atomic_read(&tmc->tmgroup->migr_state);
+
+	/*
+	 * If nextexp is KTIME_MAX, CPU event will be ignored because,
+	 * local timer expires before global timer, no global timer is set
+	 * or CPU goes offline.
+	 */
+	if (nextexp != KTIME_MAX)
+		tmc->cpuevt.ignore = 0;
+
+	walk_groups(&tmigr_inactive_up, &data, tmc);
+	return data.nextexp;
+}
+
+/**
+ * tmigr_cpu_deactivate - Put current CPU into inactive state
+ * @nextexp:	The next timer event expiry set in the current CPU
+ *
+ * Must be called with interrupts disabled.
+ *
+ * Return: next event of the current CPU or next event from the hierarchy
+ * if this CPU is the top level migrator or hierarchy is completely idle.
+ */
+u64 tmigr_cpu_deactivate(u64 nextexp)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	u64 ret;
+
+	if (!is_tmigr_enabled() || !tmc->tmgroup || !tmc->online)
+		return nextexp;
+
+	raw_spin_lock(&tmc->lock);
+
+	/*
+	 * CPU is already deactivated in timer migration
+	 * hierarchy. tick_nohz_get_sleep_length() calls
+	 * tick_nohz_next_event() and thereby timer idle path is
+	 * executed once more. tmc->wakeup holds the first timer, when
+	 * timer migration hierarchy is completely idle and remote
+	 * expiry was done. If there is no new next expiry value
+	 * handed in which should be inserted into the timer migration
+	 * hierarchy, wakeup value is returned.
+	 */
+	if (tmc->idle) {
+		ret = tmc->wakeup;
+
+		tmc->wakeup = KTIME_MAX;
+
+		if (nextexp != KTIME_MAX) {
+			if (nextexp != tmc->cpuevt.nextevt.expires ||
+			    tmc->cpuevt.ignore)
+				ret = tmigr_new_timer(tmc, nextexp);
+		}
+
+		goto unlock;
+	}
+
+	ret = __tmigr_cpu_deactivate(tmc, nextexp);
+
+	tmc->idle = 1;
+
+unlock:
+	raw_spin_unlock(&tmc->lock);
+	return ret;
+}
+
+static u64 tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
+				   unsigned long jif)
+{
+	struct timer_events tevt;
+	struct tmigr_walk data;
+	struct tmigr_cpu *tmc;
+	u64 next = KTIME_MAX;
+
+	tmc = per_cpu_ptr(&tmigr_cpu, cpu);
+
+	raw_spin_lock_irq(&tmc->lock);
+	/*
+	 * Remote CPU is offline or no longer idle or other cpu handles cpu
+	 * timers already or next event was already expired - return!
+	 */
+	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
+	    now < tmc->cpuevt.nextevt.expires) {
+		raw_spin_unlock_irq(&tmc->lock);
+		return next;
+	}
+
+	tmc->remote = 1;
+
+	/* Drop the lock to allow the remote CPU to exit idle */
+	raw_spin_unlock_irq(&tmc->lock);
+
+	if (cpu != smp_processor_id())
+		timer_expire_remote(cpu);
+
+	/*
+	 * Lock ordering needs to be preserved - timer_base locks before
+	 * tmigr related locks (see section "Locking rules" in the
+	 * documentation at the top). During fetching the next timer
+	 * interrupt, also tmc->lock needs to be held. Otherwise there is a
+	 * possible race window against the CPU itself when it comes out of
+	 * idle, updates the first timer in hierarchy and goes back to
+	 * idle.
+	 *
+	 * timer base locks are dropped as fast as possible: After checking
+	 * whether the remote CPU when offline in the meantime and after
+	 * fetching the next remote timer interrupt. Dropping the locks as
+	 * fast as possible keeps the locking region small and prevents
+	 * holding several (unnecessary) locks during walking the hierarchy
+	 * for updating the timerqueue and group events.
+	 */
+	local_irq_disable();
+	timer_lock_remote_bases(cpu);
+	raw_spin_lock(&tmc->lock);
+
+	/*
+	 * When CPU went offline in the meantime, no hierarchy walk has to
+	 * be done for updating the queued events, because the walk was
+	 * already done during marking CPU offline in the hierarchy.
+	 *
+	 * When CPU is no longer idle, CPU takes care of the timers and
+	 * also of the timers in the path to the top.
+	 *
+	 * (See also section "Required event and timerqueue update after
+	 * remote expiry" in documentation at the top)
+	 */
+	if (!tmc->online || !tmc->idle) {
+		timer_unlock_remote_bases(cpu);
+		goto unlock;
+	} else {
+		/* next	event of cpu */
+		fetch_next_timer_interrupt_remote(jif, now, &tevt, cpu);
+	}
+
+	timer_unlock_remote_bases(cpu);
+
+	data.evt = &tmc->cpuevt;
+	data.nextexp = tevt.global;
+	data.groupstate.state = atomic_read(&tmc->tmgroup->migr_state);
+	data.remote = true;
+
+	/*
+	 * Update is done even when there is no 'new' global timer pending
+	 * on remote CPU (see section "Required event and timerqueue update
+	 * after remote expiry" in documentation at the top)
+	 */
+	walk_groups(&tmigr_new_timer_up, &data, tmc);
+
+	next = data.nextexp;
+
+unlock:
+	tmc->remote = 0;
+	raw_spin_unlock_irq(&tmc->lock);
+
+	return next;
+}
+
+static bool tmigr_handle_remote_up(struct tmigr_group *group,
+				   struct tmigr_group *child,
+				   void *ptr)
+{
+	struct tmigr_remote_data *data = ptr;
+	u64 now, next = KTIME_MAX;
+	struct tmigr_event *evt;
+	unsigned long jif;
+	u8 childmask;
+
+	jif = data->basej;
+	now = data->now;
+
+	childmask = data->childmask;
+
+again:
+	/*
+	 * Handle the group only if @childmask is the migrator or if the
+	 * group has no migrator. Otherwise the group is active and is
+	 * handled by its own migrator.
+	 */
+	if (!tmigr_check_migrator(group, childmask))
+		return true;
+
+	raw_spin_lock_irq(&group->lock);
+
+	evt = tmigr_next_expired_groupevt(group, now);
+
+	if (evt) {
+		unsigned int remote_cpu = evt->cpu;
+
+		raw_spin_unlock_irq(&group->lock);
+
+		next = tmigr_handle_remote_cpu(remote_cpu, now, jif);
+
+		/* check if there is another event, that needs to be handled */
+		goto again;
+	} else {
+		raw_spin_unlock_irq(&group->lock);
+	}
+
+	/* Update of childmask for next level */
+	data->childmask = group->childmask;
+	data->wakeup = next;
+
+	return false;
+}
+
+/**
+ * tmigr_handle_remote - Handle migratable timers on remote idle CPUs
+ *
+ * Called from the timer soft interrupt with interrupts enabled.
+ */
+void tmigr_handle_remote(void)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_remote_data data;
+
+	if (!is_tmigr_enabled() || !tmc->tmgroup || !tmc->online)
+		return;
+
+	/*
+	 * NOTE: This is a doubled check because migrator test will be done
+	 * in tmigr_handle_remote_up() anyway. Keep this check to fasten
+	 * the return when nothing has to be done.
+	 */
+	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask))
+		return;
+
+	data.now = get_jiffies_update(&data.basej);
+	data.childmask = tmc->childmask;
+	data.wakeup = KTIME_MAX;
+
+	__walk_groups(&tmigr_handle_remote_up, &data, tmc);
+
+	raw_spin_lock_irq(&tmc->lock);
+	if (tmc->idle)
+		tmc->wakeup = data.wakeup;
+
+	raw_spin_unlock_irq(&tmc->lock);
+}
+
+static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
+					    struct tmigr_group *child,
+					    void *ptr)
+{
+	struct tmigr_remote_data *data = ptr;
+	u8 childmask;
+
+	childmask = data->childmask;
+
+	/*
+	 * Handle the group only if child is the migrator or if the group
+	 * has no migrator. Otherwise the group is active and is handled by
+	 * its own migrator.
+	 */
+	if (!tmigr_check_migrator(group, childmask))
+		return true;
+
+	/*
+	 * On 32 bit systems the racy lockless check for next_expiry will
+	 * turn into a random number generator. Therefore do the lockless
+	 * check only on 64 bit systems.
+	 */
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		if (data->now >= READ_ONCE(group->next_expiry)) {
+			data->check = 1;
+			return true;
+		}
+	} else {
+		raw_spin_lock(&group->lock);
+		if (data->now >= group->next_expiry) {
+			data->check = 1;
+			raw_spin_unlock(&group->lock);
+			return true;
+		}
+		raw_spin_unlock(&group->lock);
+	}
+
+	/* Update of childmask for next level */
+	data->childmask = group->childmask;
+	return false;
+}
+
+/**
+ * tmigr_requires_handle_remote - Check whether remote timer handling is required
+ *
+ * Must be called with interrupts disabled.
+ */
+int tmigr_requires_handle_remote(void)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_remote_data data;
+
+	if (!is_tmigr_enabled() || !tmc->tmgroup || !tmc->online)
+		return 0;
+
+	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask))
+		return 0;
+
+	data.now = get_jiffies_update(&data.basej);
+	data.childmask = tmc->childmask;
+
+	__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
+
+	return data.check;
+}
+
+static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
+			     int node)
+{
+	union tmigr_state s;
+
+	raw_spin_lock_init(&group->lock);
+
+	group->level = lvl;
+	group->numa_node = lvl < tmigr_crossnode_level ? node : NUMA_NO_NODE;
+
+	group->num_children = 0;
+
+	s.migrator = TMIGR_NONE;
+	s.active = 0;
+	s.seq = 0;
+	atomic_set(&group->migr_state, s.state);
+
+	timerqueue_init_head(&group->events);
+	timerqueue_init(&group->groupevt.nextevt);
+	group->groupevt.nextevt.expires = KTIME_MAX;
+	WRITE_ONCE(group->next_expiry, KTIME_MAX);
+	group->groupevt.ignore = 1;
+}
+
+static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
+					   unsigned int lvl)
+{
+	struct tmigr_group *tmp, *group = NULL;
+
+	lockdep_assert_held(&tmigr_mutex);
+
+	/* Try to attach to an exisiting group first */
+	list_for_each_entry(tmp, &tmigr_level_list[lvl], list) {
+		/*
+		 * If @lvl is below the cross numa node level, check whether
+		 * this group belongs to the same numa node.
+		 */
+		if (lvl < tmigr_crossnode_level && tmp->numa_node != node)
+			continue;
+
+		/* Capacity left? */
+		if (tmp->num_children >= TMIGR_CHILDS_PER_GROUP)
+			continue;
+
+		/*
+		 * TODO: A possible further improvement: Make sure that all
+		 * CPU siblings end up in the same group of lowest level of
+		 * the hierarchy. Rely on topology sibling mask would be a
+		 * reasonable solution.
+		 */
+
+		group = tmp;
+		break;
+	}
+
+	if (group)
+		return group;
+
+	/* Allocate and	set up a new group */
+	group = kzalloc_node(sizeof(*group), GFP_KERNEL, node);
+	if (!group)
+		return ERR_PTR(-ENOMEM);
+
+	tmigr_init_group(group, lvl, node);
+
+	/* Setup successful. Add it to the hierarchy */
+	list_add(&group->list, &tmigr_level_list[lvl]);
+	return group;
+}
+
+static void tmigr_connect_child_parent(struct tmigr_group *child,
+				       struct tmigr_group *parent)
+{
+	union tmigr_state childstate;
+
+	raw_spin_lock_irq(&child->lock);
+	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
+
+	child->parent = parent;
+	child->childmask = BIT(parent->num_children++);
+
+	raw_spin_unlock(&parent->lock);
+	raw_spin_unlock_irq(&child->lock);
+
+	/*
+	 * To prevent inconsistent states, active children need to be
+	 * active in new parent as well. Inactive children are already
+	 * marked inactive in parent group.
+	 */
+	childstate.state = atomic_read(&child->migr_state);
+	if (childstate.migrator != TMIGR_NONE) {
+		struct tmigr_walk data;
+
+		data.childmask = child->childmask;
+		data.groupstate.state = atomic_read(&parent->migr_state);
+
+		/*
+		 * There is only one new level per time. When connecting
+		 * child and parent and set child active when parent is
+		 * inactive, parent needs to be the uppermost
+		 * level. Otherwise there went something wrong!
+		 */
+		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
+	}
+}
+
+static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
+{
+	struct tmigr_group *group, *child, **stack;
+	int top = 0, err = 0, i = 0;
+	struct list_head *lvllist;
+
+	stack = kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
+	if (!stack)
+		return -ENOMEM;
+
+	do {
+		group = tmigr_get_group(cpu, node, i);
+		if (IS_ERR(group)) {
+			err = PTR_ERR(group);
+			break;
+		}
+
+		top = i;
+		stack[i++] = group;
+
+		/*
+		 * When booting only less CPUs of a system than CPUs are
+		 * available, not all calculated hierarchy levels are required.
+		 *
+		 * The loop is aborted as soon as the highest level, which might
+		 * be different from tmigr_hierarchy_levels, contains only a
+		 * single group.
+		 */
+		if (group->parent || i == tmigr_hierarchy_levels ||
+		    (list_empty(&tmigr_level_list[i]) &&
+		     list_is_singular(&tmigr_level_list[i - 1])))
+			break;
+
+	} while (i < tmigr_hierarchy_levels);
+
+	do {
+		group = stack[--i];
+
+		if (err < 0) {
+			list_del(&group->list);
+			kfree(group);
+			continue;
+		}
+
+		WARN_ON_ONCE(i != group->level);
+
+		/*
+		 * Update tmc -> group / child -> group connection
+		 */
+		if (i == 0) {
+			struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+
+			raw_spin_lock_irq(&group->lock);
+
+			tmc->tmgroup = group;
+			tmc->childmask = BIT(group->num_children++);
+
+			raw_spin_unlock_irq(&group->lock);
+
+			/* There are no children that need to be connected */
+			continue;
+		} else {
+			child = stack[i - 1];
+			tmigr_connect_child_parent(child, group);
+		}
+
+		/* check if uppermost level was newly created */
+		if (top != i)
+			continue;
+
+		WARN_ON_ONCE(top == 0);
+
+		lvllist = &tmigr_level_list[top];
+		if (group->num_children == 1 && list_is_singular(lvllist)) {
+			lvllist = &tmigr_level_list[top - 1];
+			list_for_each_entry(child, lvllist, list) {
+				if (child->parent)
+					continue;
+
+				tmigr_connect_child_parent(child, group);
+			}
+		}
+	} while (i > 0);
+
+	kfree(stack);
+
+	return err;
+}
+
+static int tmigr_add_cpu(unsigned int cpu)
+{
+	int node = cpu_to_node(cpu);
+	int ret;
+
+	mutex_lock(&tmigr_mutex);
+	ret = tmigr_setup_groups(cpu, node);
+	mutex_unlock(&tmigr_mutex);
+
+	return ret;
+}
+
+static int tmigr_cpu_online(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	unsigned int ret;
+
+	/* First online attempt? Initialize CPU data */
+	if (!tmc->tmgroup) {
+		raw_spin_lock_init(&tmc->lock);
+
+		ret = tmigr_add_cpu(cpu);
+		if (ret < 0)
+			return ret;
+
+		if (tmc->childmask == 0)
+			return -EINVAL;
+
+		timerqueue_init(&tmc->cpuevt.nextevt);
+		tmc->cpuevt.nextevt.expires = KTIME_MAX;
+		tmc->cpuevt.ignore = 1;
+		tmc->cpuevt.cpu = cpu;
+
+		tmc->remote = 0;
+		tmc->idle = 0;
+		tmc->wakeup = KTIME_MAX;
+	}
+	raw_spin_lock_irq(&tmc->lock);
+	__tmigr_cpu_activate(tmc);
+	tmc->online = 1;
+	raw_spin_unlock_irq(&tmc->lock);
+	return 0;
+}
+
+static int tmigr_cpu_offline(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+
+	raw_spin_lock_irq(&tmc->lock);
+	tmc->online = 0;
+
+	/*
+	 * CPU has to handle local events on his own, when on the way to
+	 * offline; Therefore nextevt value is set to KTIME_MAX
+	 */
+	__tmigr_cpu_deactivate(tmc, KTIME_MAX);
+	raw_spin_unlock_irq(&tmc->lock);
+
+	return 0;
+}
+
+static int __init tmigr_init(void)
+{
+	unsigned int cpulvl, nodelvl, cpus_per_node, i;
+	unsigned int nnodes = num_possible_nodes();
+	unsigned int ncpus = num_possible_cpus();
+	int ret = -ENOMEM;
+
+	/* Nothing to do if running on UP */
+	if (ncpus == 1)
+		return 0;
+
+	/*
+	 * Calculate the required hierarchy levels. Unfortunately there is no
+	 * reliable information available, unless all possible CPUs have been
+	 * brought up and all numa nodes are populated.
+	 *
+	 * Estimate the number of levels with the number of possible nodes and
+	 * the number of possible cpus. Assume CPUs are spread evenly across
+	 * nodes. We cannot rely on cpumask_of_node() because there only already
+	 * online CPUs are considered.
+	 */
+	cpus_per_node = DIV_ROUND_UP(ncpus, nnodes);
+
+	/* Calc the hierarchy levels required to hold the CPUs of a node */
+	cpulvl = DIV_ROUND_UP(order_base_2(cpus_per_node),
+			      ilog2(TMIGR_CHILDS_PER_GROUP));
+
+	/* Calculate the extra levels to connect all nodes */
+	nodelvl = DIV_ROUND_UP(order_base_2(nnodes),
+			       ilog2(TMIGR_CHILDS_PER_GROUP));
+
+	tmigr_hierarchy_levels = cpulvl + nodelvl;
+
+	/*
+	 * If a numa node spawns more than one CPU level group then the next
+	 * level(s) of the hierarchy contains groups which handle all CPU groups
+	 * of the same numa node. The level above goes across numa nodes. Store
+	 * this information for the setup code to decide when node matching is
+	 * not longer required.
+	 */
+	tmigr_crossnode_level = cpulvl;
+
+	tmigr_level_list = kcalloc(tmigr_hierarchy_levels, sizeof(struct list_head), GFP_KERNEL);
+	if (!tmigr_level_list)
+		goto err;
+
+	for (i = 0; i < tmigr_hierarchy_levels; i++)
+		INIT_LIST_HEAD(&tmigr_level_list[i]);
+
+	pr_info("Timer migration: %d hierarchy levels; %d children per group;"
+		" %d crossnode level\n",
+		tmigr_hierarchy_levels, TMIGR_CHILDS_PER_GROUP,
+		tmigr_crossnode_level);
+
+	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
+				tmigr_cpu_online, tmigr_cpu_offline);
+	if (ret)
+		goto err;
+
+	static_branch_enable(&tmigr_enabled);
+
+	return 0;
+
+err:
+	pr_err("Timer migration setup failed\n");
+	return ret;
+}
+late_initcall(tmigr_init);
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
new file mode 100644
index 000000000000..3a31a16443d2
--- /dev/null
+++ b/kernel/time/timer_migration.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _KERNEL_TIME_MIGRATION_H
+#define _KERNEL_TIME_MIGRATION_H
+
+/* Per group capacity. Must be a power of 2! */
+#define TMIGR_CHILDS_PER_GROUP 8
+
+/**
+ * struct tmigr_event - a timer event associated to a CPU
+ * @nextevt:	The node to enqueue an event in the parent group queue
+ * @cpu:	The CPU to which this event belongs
+ * @ignore:	Hint whether the event could be ignored; it is set when
+ *		CPU or group is active;
+ */
+struct tmigr_event {
+	struct timerqueue_node	nextevt;
+	unsigned int		cpu;
+	int			ignore;
+};
+
+/**
+ * struct tmigr_group - timer migration hierarchy group
+ * @lock:		Lock protecting the event information and group hierarchy
+ *			information during setup
+ * @migr_state:		State of group (see union tmigr_state)
+ * @parent:		Pointer to parent group
+ * @groupevt:		Next event of group which is only used when group is
+ *			!active. The group event is then queued into parent
+ *			timer queue.
+ *			Ignore bit of groupevt is set when group is active.
+ * @next_expiry:	Base monotonic expiry time of next event of group;
+ *			Used for racy lockless check whether remote expiry is
+ *			required; it is always reliable
+ * @events:		Timer queue for child events queued in the group
+ * @childmask:		childmask of group in parent group; is set during
+ *			setup and will never change; could be read lockless
+ * @level:		Hierarchy level of group; Required during setup and
+ *			when DEBUG is defined
+ * @list:		List head that is added to per level
+ *			tmigr_level_list; is required during setup when a
+ *			new group needs to be connected to the existing
+ *			hierarchy groups
+ * @numa_node:		Is set to numa node when level < tmigr_crossnode_level;
+ *			otherwise it is set to NUMA_NO_NODE; Required for
+ *			setup only to make sure CPUs and groups are per
+ *			numa node as long as level < tmigr_crossnode_level
+ * @num_children:	Counter of group children to make sure group is only filled
+ *			with TMIGR_CHILDS_PER_GROUP; Required for setup only
+ */
+struct tmigr_group {
+	raw_spinlock_t		lock;
+	atomic_t		migr_state;
+	struct tmigr_group	*parent;
+	struct tmigr_event	groupevt;
+	u64			next_expiry;
+	struct timerqueue_head	events;
+	u8			childmask;
+	unsigned int		level;
+	struct list_head	list;
+	int			numa_node;
+	unsigned int		num_children;
+};
+
+/**
+ * struct tmigr_cpu - timer migration per CPU group
+ * @lock:	Lock protecting tmigr_cpu group information
+ * @online:	Indicates whether CPU is online; In deactivate path it is
+ *		required to know whether the migrator in top level group is
+ *		on the way to go offline when a timer is pending. Then
+ *		another online CPU needs to be rescheduled to make sure
+ *		timers are handled properly; Furthermore the information is
+ *		required in hotplug path as CPU is able to go idle before
+ *		timer migration hierarchy hotplug AP is reached. During
+ *		this phase CPU has to handle global timers by its own and
+ *		does not act as migrator.
+ * @idle:	Indicates whether CPU is idle in timer migration hierarchy
+ * @remote:	Is set when timers of CPU are expired remote
+ * @tmgroup:	Pointer to parent group
+ * @childmask:	childmask of tmigr_cpu in parent group
+ * @wakeup:	Stores the first timer when the timer migration hierarchy is
+ *		completely idle and remote expiry was done; is returned to
+ *		timer code when tmigr_cpu_deactive() is called and group is
+ *		idle; afterwards a reset to KTIME_MAX is required;
+ * @cpuevt:	CPU event which could be queued into parent group
+ */
+struct tmigr_cpu {
+	raw_spinlock_t		lock;
+	int			online;
+	int			idle;
+	int			remote;
+	struct tmigr_group	*tmgroup;
+	u8			childmask;
+	u64			wakeup;
+	struct tmigr_event	cpuevt;
+};
+
+/**
+ * union tmigr_state - state of tmigr_group
+ * @state:	Combined version of the state - only used for atomic
+ *		read/cmpxchg function
+ * @struct:	Split version of the state - only use the struct members to
+ *		update information to stay independent of endianness
+ */
+union tmigr_state {
+	u32 state;
+	/**
+	 * struct - split state of tmigr_group
+	 * @active:	Contains each childmask bit of active children
+	 * @migrator:	Contains childmask of child which is migrator
+	 * @seq:	Sequence counter needs to be increased when update
+	 *		to the tmigr_state is done. It prevents a race when
+	 *		updates in child groups are propagated in changed
+	 *		order. Detailed information about the scenario is
+	 *		given in documentation at the begin of
+	 *		timer_migration.c.
+	 */
+	struct {
+		u8	active;
+		u8	migrator;
+		u16	seq;
+	} __packed;
+};
+
+#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+extern void tmigr_handle_remote(void);
+extern int tmigr_requires_handle_remote(void);
+extern void tmigr_cpu_activate(void);
+extern u64 tmigr_cpu_deactivate(u64 nextevt);
+#else
+static inline void tmigr_handle_remote(void) { }
+static inline int tmigr_requires_handle_remote(void) { return 0; }
+static inline void tmigr_cpu_activate(void) { }
+static inline u64 tmigr_cpu_deactivate(u64 nextevt) { return KTIME_MAX; }
+#endif
+
+#endif
-- 
2.30.2

