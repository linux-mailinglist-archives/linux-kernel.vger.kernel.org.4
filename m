Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC3619AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiKDO7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiKDO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:58:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5E131ED0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:58:03 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667573881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdVcoBx7/tuIOiTEjcb989uDKzmjA/NfDt6Q7fyRUUU=;
        b=0g22eLEgtf+duujb8mx91XeZxs3w2lmo2ok9sJqTz2qndFHIDwU3ND4lBw/yvb4ozJPAjZ
        lHmijG/mdXeNls5aMN5YUTPHyTNdxGmwASeDPF+pzPK6km2aTNX1tVRoVQGUZoGiSFO6Xk
        K5XDGgrsd1V2J64kvfH7tp1o8gcLzGJ0wJQR+xX5+xE9IPUQ4/bRGjJ8ipdrO6ulCdtXC0
        O6eUfTWLlz+1G5nmHJlCc5Zd1kjgrbNJAj18Ta/qLQFRnDBF6im1WC56JFrAPvsmgwEIoV
        BUGJ69P/+9dM9YQ0AtHniaxG+brnxPJ+G7CYXVh1VQ6nL77/rjyKI5jXZDWKgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667573881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdVcoBx7/tuIOiTEjcb989uDKzmjA/NfDt6Q7fyRUUU=;
        b=dAIjc2Y3hCQFk7g+gXz6kF/aSMr0MpEjlw+MrN+F/R5HuISKPvp2SarBBoTcpf2vPR5FyX
        s/m7EwNWsIDwwIDw==
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
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v4 16/16] timer: Always queue timers on the local CPU
Date:   Fri,  4 Nov 2022 15:57:37 +0100
Message-Id: <20221104145737.71236-17-anna-maria@linutronix.de>
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

The timer pull model is in place so we can remove the heuristics which try
to guess the best target CPU at enqueue/modification time.

All non pinned timers are queued on the local CPU in the seperate storage
and eventually pulled at expiry time to a remote CPU.

When a timer is added via add_timer_on(), TIMER_PINNED flag is required to
ensure it expires on the specified CPU. Otherwise it will be enqueued in
the global timer base which could be expired by a remote CPU. WARN_ONCE()
is added to prevent misuse.

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v4: Update comment about TIMER_PINNED flag (heristic is removed)
---
 include/linux/timer.h |  5 ++---
 kernel/time/timer.c   | 17 +++++------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 648f00105f58..181a3d3fa45a 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -50,9 +50,8 @@ struct timer_list {
  * workqueue locking issues. It's not meant for executing random crap
  * with interrupts disabled. Abuse is monitored!
  *
- * @TIMER_PINNED: A pinned timer will not be affected by any timer
- * placement heuristics (like, NOHZ) and will always expire on the CPU
- * on which the timer was enqueued.
+ * @TIMER_PINNED: A pinned timer will always expire on the CPU on which
+ * the timer was enqueued.
  *
  * Note: Because enqueuing of timers can migrate the timer from one
  * CPU to another, pinned timers are not guaranteed to stay on the
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 214397d84747..bdff4be066e4 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -947,17 +947,6 @@ static inline struct timer_base *get_timer_base(u32 tflags)
 	return get_timer_cpu_base(tflags, tflags & TIMER_CPUMASK);
 }
 
-static inline struct timer_base *
-get_target_base(struct timer_base *base, unsigned tflags)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-	if (static_branch_likely(&timers_migration_enabled) &&
-	    !(tflags & TIMER_PINNED))
-		return get_timer_cpu_base(tflags, get_nohz_timer_target());
-#endif
-	return get_timer_this_cpu_base(tflags);
-}
-
 static inline void forward_timer_base(struct timer_base *base)
 {
 	unsigned long jnow = READ_ONCE(jiffies);
@@ -1093,7 +1082,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	if (!ret && (options & MOD_TIMER_PENDING_ONLY))
 		goto out_unlock;
 
-	new_base = get_target_base(base, timer->flags);
+	new_base = get_timer_this_cpu_base(timer->flags);
 
 	if (base != new_base) {
 		/*
@@ -1228,6 +1217,10 @@ void add_timer_on(struct timer_list *timer, int cpu)
 
 	BUG_ON(timer_pending(timer) || !timer->function);
 
+	WARN_ONCE(!(timer->flags & TIMER_PINNED), "TIMER_PINNED flag for "
+		  "add_timer_on() is missing: timer=%p function=%ps",
+		  timer, timer->function);
+
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
 	/*
-- 
2.30.2

