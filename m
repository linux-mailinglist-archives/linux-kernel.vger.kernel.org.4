Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7241682F20
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjAaOW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjAaOWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:22:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EE51D921;
        Tue, 31 Jan 2023 06:22:30 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675174948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4lUA3VPonoVUn9hM8v0u4FdHhUH8cnco09NvCP743iA=;
        b=wcUTV3ram6kUDK/x+b5vsHu+h144O6chFf2dP4gbNbHd+0b1F297Vhd20IeW9ikTNnSSBz
        aH0La4KLp7MZL0li4Vn/0FHcRr3YC9dW2Wo4R4M/Rk+ETcH31OB4TGNtwbgjDfrAZ4VeCg
        4DUDRRL3Bq7hmfeAH/QAdWvzsg5MEZJrguYLBBqPBeHkOgZcRuIFDh2/Gm6tOf3Fzyl0rw
        60TmX7FExqgmJz6/YB5wJXSkzpEc/YOUM/LuqcWHZseclfArqTjo9C2fBPzccasv7/I29q
        gUI3fwbHtPOmNcwJO9lf4OAoomiSCVdFWkoBSZiaD+ir9YlWYPbq5rKbU/OJHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675174948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4lUA3VPonoVUn9hM8v0u4FdHhUH8cnco09NvCP743iA=;
        b=lhzgc9Efj4EoBzwzRqr3H+Gw639meGVBeuito+2jqcNGdVkXHMYEEf3hZThELHDn8mgxm1
        mKOr5n9nFNIByEAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle: tracing, preempt: Squash _rcuidle tracing
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y9D5AfnOukWNOZ5q@hirez.programming.kicks-ass.net>
References: <Y9D5AfnOukWNOZ5q@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <167517494797.4906.221283019576785250.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3017ba4b831bc7fd67cc82e744116b6e45e259a4
Gitweb:        https://git.kernel.org/tip/3017ba4b831bc7fd67cc82e744116b6e45e259a4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 31 Jan 2023 09:50:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 31 Jan 2023 15:01:46 +01:00

cpuidle: tracing, preempt: Squash _rcuidle tracing

Extend/fix commit:

  9aedeaed6fc6 ("tracing, hardirq: No moar _rcuidle() tracing")

... to also cover trace_preempt_{on,off}() which were mysteriously
untouched.

Fixes: 9aedeaed6fc6 ("tracing, hardirq: No moar _rcuidle() tracing")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/Y9D5AfnOukWNOZ5q@hirez.programming.kicks-ass.net
Link: https://lore.kernel.org/r/Y9jWXKgkxY5EZVwW@hirez.programming.kicks-ass.net
---
 kernel/trace/trace_preemptirq.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index f992444..e37446f 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -15,10 +15,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/preemptirq.h>
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-/* Per-cpu variable to prevent redundant calls when IRQs already off */
-static DEFINE_PER_CPU(int, tracing_irq_cpu);
-
 /*
  * Use regular trace points on architectures that implement noinstr
  * tooling: these calls will only happen with RCU enabled, which can
@@ -33,6 +29,10 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
 #define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
 #endif
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+/* Per-cpu variable to prevent redundant calls when IRQs already off */
+static DEFINE_PER_CPU(int, tracing_irq_cpu);
+
 /*
  * Like trace_hardirqs_on() but without the lockdep invocation. This is
  * used in the low level entry code where the ordering vs. RCU is important
@@ -100,15 +100,13 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
 
 void trace_preempt_on(unsigned long a0, unsigned long a1)
 {
-	if (!in_nmi())
-		trace_preempt_enable_rcuidle(a0, a1);
+	trace(preempt_enable)(a0, a1);
 	tracer_preempt_on(a0, a1);
 }
 
 void trace_preempt_off(unsigned long a0, unsigned long a1)
 {
-	if (!in_nmi())
-		trace_preempt_disable_rcuidle(a0, a1);
+	trace(preempt_disable)(a0, a1);
 	tracer_preempt_off(a0, a1);
 }
 #endif
