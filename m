Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FDF6A6E34
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCAOSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCAOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3122331A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:07 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61R/6m3cWzpu0i+kgy8BBTevSM03VxMJMhiETBOD2eY=;
        b=hJGMDtSmaW6X+SmKXImqcyNQ41a6XFWvmTIEMMKcClZ2tyoL4yyvd/rL6PtyPF6gPwbVEa
        NmNsfJrEF82YQLynRZ8T/QGvXijl9QHlBcLZX/xch6QeK2ETGvGnlcI6pP5a88C+pcPrIW
        uf3w/UakWz9nM5hqk9Vd36nhRPZL0ieTWjSDPtZ5KuAcE08aK7X2nDwhGibHuwEb6oSxRL
        sjMPcs7R/TXKNZikPJ7UKa6NciIIM4Ks0+dZBBw5YD88BbNstfPKqoXyOb8JC3LVmf+fAo
        /pzmKe47Lm4j4KhPBuRANu1lt77XwJ3G7swxcIWuwoGwBPrFWXrJAavG2MjzXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61R/6m3cWzpu0i+kgy8BBTevSM03VxMJMhiETBOD2eY=;
        b=EfG+Pih/pAPGwXQLXhIy/5G1cbdLAIxWy49IZB0zbJf7Hyl29HbCpokJIlDMoEkhctkA/+
        Z+sCzFUC1d6jasCw==
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
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Stephen Boyd <sboyd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH v5 06/18] add_timer_on(): Make sure callers have TIMER_PINNED flag
Date:   Wed,  1 Mar 2023 15:17:32 +0100
Message-Id: <20230301141744.16063-7-anna-maria@linutronix.de>
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

The implementation of the hierachical timer pull model will change the
timer bases per CPU. Timers, that have to expire on a specific CPU, require
the TIMER_PINNED flag. Otherwise they will be queued on the dedicated CPU
but in global timer base and those timers could also expire on other
CPUs. Timers with TIMER_DEFERRABLE flag end up in a separate base anyway
and are executed on the local CPU only.

Therefore add the missing TIMER_PINNED flag for those callers who use
add_timer_on() without the flag. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
v5: Add comment in workqueue.c that it's only a workaround for now
---
 arch/x86/kernel/tsc_sync.c |  3 ++-
 drivers/char/random.c      |  2 +-
 kernel/time/clocksource.c  |  2 +-
 kernel/workqueue.c         | 15 +++++++++++++--
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 9452dc9664b5..eab827288e0f 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -110,7 +110,8 @@ static int __init start_sync_check_timer(void)
 	if (!cpu_feature_enabled(X86_FEATURE_TSC_ADJUST) || tsc_clocksource_reliable)
 		return 0;
 
-	timer_setup(&tsc_sync_check_timer, tsc_sync_check_timer_fn, 0);
+	timer_setup(&tsc_sync_check_timer, tsc_sync_check_timer_fn,
+		    TIMER_PINNED);
 	tsc_sync_check_timer.expires = jiffies + SYNC_CHECK_INTERVAL;
 	add_timer(&tsc_sync_check_timer);
 
diff --git a/drivers/char/random.c b/drivers/char/random.c
index ce3ccd172cc8..db6a7c0695de 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1007,7 +1007,7 @@ static DEFINE_PER_CPU(struct fast_pool, irq_randomness) = {
 #define FASTMIX_PERM HSIPHASH_PERMUTATION
 	.pool = { HSIPHASH_CONST_0, HSIPHASH_CONST_1, HSIPHASH_CONST_2, HSIPHASH_CONST_3 },
 #endif
-	.mix = __TIMER_INITIALIZER(mix_interrupt_randomness, 0)
+	.mix = __TIMER_INITIALIZER(mix_interrupt_randomness, TIMER_PINNED)
 };
 
 /*
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 91836b727cef..e982c119e3c9 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -561,7 +561,7 @@ static inline void clocksource_start_watchdog(void)
 {
 	if (watchdog_running || !watchdog || list_empty(&watchdog_list))
 		return;
-	timer_setup(&watchdog_timer, clocksource_watchdog, 0);
+	timer_setup(&watchdog_timer, clocksource_watchdog, TIMER_PINNED);
 	watchdog_timer.expires = jiffies + WATCHDOG_INTERVAL;
 	add_timer_on(&watchdog_timer, cpumask_first(cpu_online_mask));
 	watchdog_running = 1;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed48..a428d94084ee 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1677,10 +1677,21 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	dwork->cpu = cpu;
 	timer->expires = jiffies + delay;
 
-	if (unlikely(cpu != WORK_CPU_UNBOUND))
+	if (unlikely(cpu != WORK_CPU_UNBOUND)) {
+		/*
+		 * TODO: Setting the flag is a workaround for now; needs to
+		 * be cleaned up with new work initializers and defines
+		 */
+		timer->flags |= TIMER_PINNED;
 		add_timer_on(timer, cpu);
-	else
+	} else {
+		/*
+		 * TODO: Resetting the flag is a workaround for now; needs
+		 * to be cleaned up with new work initializers and defines
+		 */
+		timer->flags &= ~TIMER_PINNED;
 		add_timer(timer);
+	}
 }
 
 /**
-- 
2.30.2

