Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC57D60CE39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiJYOBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiJYN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:59:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C446FAC9;
        Tue, 25 Oct 2022 06:59:31 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666706370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t38ZOSk7RADUS9yQPx+jhxDPVyx+Ww7vTN6ZsN90lKg=;
        b=bEwlhGzpXpX8hMG8IqtPZmhlQRTQikKxqNs+gbQgfv3WFD96OO3tUpQT4EGa3g/BzQnubQ
        YJSxR22rP/7t7RYGTs+tiAigsONu+jLzODJiGTM/3aFyR1hciqB+lBSGwaCnd2Th7JbGQq
        uwSOnET8vkJWh2fJdQx7Pue1BuPsppC5/Vnq2Kf4G1QWNwkR7MP7bc6yZ3yGh4vYfD9AGW
        NcMkYkdYIzu/1fLOmu4BzSl8JZJExpqx06XXG7SZsxGs6MycZ4DWUgN6eLrtxp1JzRVe61
        FhrUh86UP3a4VJCA0facxuPBjkZB5p26oaplpC/jxnH/cB37pSiJfUs6KLYmgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666706370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t38ZOSk7RADUS9yQPx+jhxDPVyx+Ww7vTN6ZsN90lKg=;
        b=WydopO46wwu45sP+yRfKw5ZwrGNEVisF1hJAUAO3vVDu9Yj/PohrKCIGU8fAEgVTpFn5D9
        G2QbL4hSwWjxuBDg==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v3 16/17] add_timer_on(): Make sure callers have TIMER_PINNED flag
Date:   Tue, 25 Oct 2022 15:58:49 +0200
Message-Id: <20221025135850.51044-17-anna-maria@linutronix.de>
In-Reply-To: <20221025135850.51044-1-anna-maria@linutronix.de>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hierachical timer pull model at expiry time is now in place. Timers
which should expire on a dedicated CPU needs the TIMER_PINNED
flag. Otherwise they will be queued on the dedicated CPU but in global
timer base and those timers could also expire on other CPUs. Only timers
with TIMER_PINNED flag will end up in local timer base

Therefore add the missing TIMER_PINNED flag for those who use
add_timer_on() without the flag.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 arch/x86/kernel/tsc_sync.c | 3 ++-
 kernel/time/clocksource.c  | 2 +-
 kernel/workqueue.c         | 7 +++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

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

