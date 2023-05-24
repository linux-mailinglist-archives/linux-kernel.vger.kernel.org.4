Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D570EF06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbjEXHIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbjEXHHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:07:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B709E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:07:05 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684912024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrYsq/KOHDHxpa95h8UCcHB8BfDXtWT1sXcK5p35vZM=;
        b=31ReD5wF1GyMOnZMnmOfgPQM7WEEQoGhX1O5LbxX4bUmVF/71U6sRpN4A23TiCNGXevAic
        yailAyK2ImdqrJ28dzkf5ZqfmjnKYaBfoDnd8TGzLO9suo20o7YNiygCWaIn2lLqjzfW83
        8z/UTxYkBRm4oUNoPWjx1AP7XmslDcKduKL/XLwIPT7yg8QVETlt2JWGbOKptXLFyKsNwX
        /nbjg0D+2dScekQYcPMvC51aycYLBnlLSS5DgJ+dO8x4sbUFYEpCXKHrxcpc7ge68PXCGp
        9wfwi6Xl6w+cz/Nt1KfMTGZAT43G7ljCAl8NgIckxJ6053j8KGbvpjGwYg9/Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684912024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrYsq/KOHDHxpa95h8UCcHB8BfDXtWT1sXcK5p35vZM=;
        b=R2ZrH/i1drMQQTxLOEBANtnwfGSA1jgMXZNOPE9nCL4Xoas4Fkq8VOARbqqffTHg3yzP3J
        rCYXOVq3bVWJ0EBg==
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
Subject: [PATCH v7 15/21] timer: Add get next timer interrupt functionality for remote CPUs
Date:   Wed, 24 May 2023 09:06:23 +0200
Message-Id: <20230524070629.6377-16-anna-maria@linutronix.de>
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

To prepare for the conversion of the NOHZ timer placement to a pull at
expiry time model it's required to have functionality available getting the
next timer interrupt on a remote CPU.

Locking of the timer bases and getting the information for the next timer
interrupt functionality is split into separate functions. This is required
to be compliant with lock ordering when the new model is in place.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v7:
 - Move functions into CONFIG_SMP && CONFIG_NO_HZ_COMMON section
 - change lock, fetch functions to be unconditional
 - split out unlock function into a separate function

v6:
 - introduce timer_lock_remote_bases() to fix race
---
 kernel/time/tick-internal.h | 10 +++++
 kernel/time/timer.c         | 77 ++++++++++++++++++++++++++++++++++---
 2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 649f2b48e8f0..9b738117b2ab 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -8,6 +8,11 @@
 #include "timekeeping.h"
 #include "tick-sched.h"
 
+struct timer_events {
+	u64	local;
+	u64	global;
+};
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 # define TICK_DO_TIMER_NONE	-1
@@ -155,6 +160,11 @@ extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
 # ifdef CONFIG_SMP
 extern struct static_key_false timers_migration_enabled;
+extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+					      struct timer_events *tevt,
+					      unsigned int cpu);
+extern void timer_lock_remote_bases(unsigned int cpu);
+extern void timer_unlock_remote_bases(unsigned int cpu);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4bb6c168d106..564001b98098 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -221,11 +221,6 @@ struct timer_base {
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
 
-struct timer_events {
-	u64	local;
-	u64	global;
-};
-
 #ifdef CONFIG_NO_HZ_COMMON
 
 static DEFINE_STATIC_KEY_FALSE(timers_nohz_active);
@@ -2013,6 +2008,78 @@ static unsigned long fetch_next_timer_interrupt(struct timer_base *base_local,
 	return local_first ? nextevt_local : nextevt_global;
 }
 
+# ifdef CONFIG_SMP
+/**
+ * fetch_next_timer_interrupt_remote
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ * @tevt:	Pointer to the storage for the expiry values
+ * @cpu:	Remote CPU
+ *
+ * Stores the next pending local and global timer expiry values in the
+ * struct pointed to by @tevt. If a queue is empty the corresponding
+ * field is set to KTIME_MAX. If local event expires before global
+ * event, global event is set to KTIME_MAX as well.
+ *
+ * Caller needs to make sure timer base locks are held (use
+ * timer_lock_remote_bases() for this purpose). Caller must make sure
+ * interrupts are reopened, if required.
+ */
+void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+				       struct timer_events *tevt,
+				       unsigned int cpu)
+{
+	struct timer_base *base_local, *base_global;
+
+	/* Preset local / global events */
+	tevt->local = tevt->global = KTIME_MAX;
+
+	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	lockdep_assert_held(&base_local->lock);
+	lockdep_assert_held(&base_global->lock);
+
+	fetch_next_timer_interrupt(base_local, base_global, basej, basem, tevt);
+}
+
+/**
+ * timer_unlock_remote_bases - unlock timer bases of cpu
+ * @cpu:	Remote CPU
+ *
+ * Unlocks the remote timer bases.
+ */
+void timer_unlock_remote_bases(unsigned int cpu)
+{
+	struct timer_base *base_local, *base_global;
+
+	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock(&base_local->lock);
+}
+
+/**
+ * timer_lock_remote_bases - lock timer bases of cpu
+ * @cpu:	Remote CPU
+ *
+ * Locks the remote timer bases.
+ */
+void timer_lock_remote_bases(unsigned int cpu)
+{
+	struct timer_base *base_local, *base_global;
+
+	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	lockdep_assert_irqs_disabled();
+
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+}
+# endif /* CONFIG_SMP */
+
 /*
  * Forward base clock is done only when @basej is past base->clk, otherwise
  * base-clk might be rewind.
-- 
2.30.2

