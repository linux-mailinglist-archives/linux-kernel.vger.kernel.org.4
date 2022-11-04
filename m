Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57FB619AB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiKDO6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiKDO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:58:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7B52ED53
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:57:58 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667573875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJQXT73M5EqpgN/OaScjUbemA9h45EuN/DjSPRp7+B8=;
        b=opSSMs8+INQWcYQu5UHb3U05ouat0+yID7SNf3MMsxOGnyiItb/TVF8NFamERP/PRs9WS/
        QWiFzEGdPN/gDJwLu1w2iZ2XRZ8GRyJn3I3oCyzc/Nl/PYbJMmTnoanSIQTN+fBTorjgoK
        dbJVSy4yNQxYIFHfHhUIbtR+XyXGAKEyBdg+DvZLEXBIPBgMXpta3mEiCbv2hUXANnRDxm
        +ZJ264kASAAprhV9amckn3jET3X8I/cL32JGSblkbgX6pHJ4hb5j3SHni7EPbfMn6tA5PZ
        88Tk1AUB2GexmeMPAEmKJpEL57n6qdZFJHtdUx4rlzq7frqsvT/zcOLSnB2Xsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667573875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJQXT73M5EqpgN/OaScjUbemA9h45EuN/DjSPRp7+B8=;
        b=Qw00fyiuSOq+8nMDyzrrq/BLOY+V56inCGAMwhxbouDigpsmgPMJJjh8IN+Ez30tZDJ+3x
        c55XuXSl6NCE/HCg==
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
Subject: [PATCH v4 05/16] add_timer_on(): Make sure callers have TIMER_PINNED flag
Date:   Fri,  4 Nov 2022 15:57:26 +0100
Message-Id: <20221104145737.71236-6-anna-maria@linutronix.de>
In-Reply-To: <20221104145737.71236-1-anna-maria@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
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
v4:
  - Move patch before local and global base are introduced
  - Add missing user (drivers/char/random.c) of add_timer_on() without
    TIMER_PINNED flag (kernel test robot)
---
 arch/x86/kernel/tsc_sync.c | 3 ++-
 drivers/char/random.c      | 2 +-
 kernel/time/clocksource.c  | 2 +-
 kernel/workqueue.c         | 7 +++++--
 4 files changed, 9 insertions(+), 5 deletions(-)

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
index 69754155300e..2cae98dc86dc 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -949,7 +949,7 @@ static DEFINE_PER_CPU(struct fast_pool, irq_randomness) = {
 #define FASTMIX_PERM HSIPHASH_PERMUTATION
 	.pool = { HSIPHASH_CONST_0, HSIPHASH_CONST_1, HSIPHASH_CONST_2, HSIPHASH_CONST_3 },
 #endif
-	.mix = __TIMER_INITIALIZER(mix_interrupt_randomness, 0)
+	.mix = __TIMER_INITIALIZER(mix_interrupt_randomness, TIMER_PINNED)
 };
 
 /*
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 8058bec87ace..f8c310e62758 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -523,7 +523,7 @@ static inline void clocksource_start_watchdog(void)
 {
 	if (watchdog_running || !watchdog || list_empty(&watchdog_list))
 		return;
-	timer_setup(&watchdog_timer, clocksource_watchdog, 0);
+	timer_setup(&watchdog_timer, clocksource_watchdog, TIMER_PINNED);
 	watchdog_timer.expires = jiffies + WATCHDOG_INTERVAL;
 	add_timer_on(&watchdog_timer, cpumask_first(cpu_online_mask));
 	watchdog_running = 1;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e0a1..a0f7bf7be6f2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1670,10 +1670,13 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	dwork->cpu = cpu;
 	timer->expires = jiffies + delay;
 
-	if (unlikely(cpu != WORK_CPU_UNBOUND))
+	if (unlikely(cpu != WORK_CPU_UNBOUND)) {
+		timer->flags |= TIMER_PINNED;
 		add_timer_on(timer, cpu);
-	else
+	} else {
+		timer->flags &= ~TIMER_PINNED;
 		add_timer(timer);
+	}
 }
 
 /**
-- 
2.30.2

