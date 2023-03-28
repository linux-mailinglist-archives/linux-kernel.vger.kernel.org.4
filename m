Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D236CB980
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjC1Ie7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjC1Iet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:34:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A32944A2;
        Tue, 28 Mar 2023 01:34:47 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:34:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679992484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XpLjRFRiEVC9/oYrVNBJfIL8dz/BQSgaQjKmk/OnM7E=;
        b=aXWEWHLS3Aw9XnGdosUPHOV9eVIpnbKiqEwdsm6W1AiLtj+xTNHrAyeLkeVIvOTFyApliB
        VoE4XzjMbnyAeMHPsWyoDX55dgRAkXY/JMpd+8DjMbANO3OHLF3fPgNro8iQa5PUTFyV5E
        o9EzQpLv+H/SdbSbGyezxhGyiyzNHoSLBJj/GruKy3cjEeswQY34XUfUnoiyO6RTqS+Ndt
        j6LCuFMycNUoRFQd/AS6zf7LXnD3MXOIpv6Np4xuF9MBQmdruExz3HaCM4NBIedAMWKsCy
        IUMZHQAWwE6hLxetNo+T5GuO1NfvT/d5IGCBwvbuisG3010GZuZdAoZQKZv5LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679992484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XpLjRFRiEVC9/oYrVNBJfIL8dz/BQSgaQjKmk/OnM7E=;
        b=48tew/NiVka8f3nUXl+FAw+xiwTzXy7EZodP/z7qgbKXQDnBqULhExClWOEChB55hYEFst
        Gr8/f4StuAeZUlCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] trace: Add trace_ipi_send_cpu()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167999248419.5837.9236956776813815592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     68e2d17c9eb311ab59aeb6d0c38aad8985fa2596
Gitweb:        https://git.kernel.org/tip/68e2d17c9eb311ab59aeb6d0c38aad8985fa2596
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 22 Mar 2023 11:28:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Mar 2023 11:01:29 +01:00

trace: Add trace_ipi_send_cpu()

Because copying cpumasks around when targeting a single CPU is a bit
daft...

Tested-and-reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230322103004.GA571242%40hirez.programming.kicks-ass.net
---
 include/linux/smp.h        |  6 +++---
 include/trace/events/ipi.h | 22 ++++++++++++++++++++++
 kernel/irq_work.c          |  6 ++----
 kernel/sched/core.c        |  1 +
 kernel/smp.c               |  4 ++--
 5 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index c036a22..ed8f344 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -130,9 +130,9 @@ extern void arch_smp_send_reschedule(int cpu);
  * scheduler_ipi() is inline so can't be passed as callback reason, but the
  * callsite IP should be sufficient for root-causing IPIs sent from here.
  */
-#define smp_send_reschedule(cpu) ({				  \
-	trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);  \
-	arch_smp_send_reschedule(cpu);				  \
+#define smp_send_reschedule(cpu) ({		  \
+	trace_ipi_send_cpu(cpu, _RET_IP_, NULL);  \
+	arch_smp_send_reschedule(cpu);		  \
 })
 
 /*
diff --git a/include/trace/events/ipi.h b/include/trace/events/ipi.h
index b1125dc..3de9bfc 100644
--- a/include/trace/events/ipi.h
+++ b/include/trace/events/ipi.h
@@ -35,6 +35,28 @@ TRACE_EVENT(ipi_raise,
 	TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
 );
 
+TRACE_EVENT(ipi_send_cpu,
+
+	TP_PROTO(const unsigned int cpu, unsigned long callsite, void *callback),
+
+	TP_ARGS(cpu, callsite, callback),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, cpu)
+		__field(void *, callsite)
+		__field(void *, callback)
+	),
+
+	TP_fast_assign(
+		__entry->cpu = cpu;
+		__entry->callsite = (void *)callsite;
+		__entry->callback = callback;
+	),
+
+	TP_printk("cpu=%u callsite=%pS callback=%pS",
+		  __entry->cpu, __entry->callsite, __entry->callback)
+);
+
 TRACE_EVENT(ipi_send_cpumask,
 
 	TP_PROTO(const struct cpumask *cpumask, unsigned long callsite, void *callback),
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index c33e88e..2f4fb33 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -78,10 +78,8 @@ void __weak arch_irq_work_raise(void)
 
 static __always_inline void irq_work_raise(struct irq_work *work)
 {
-	if (trace_ipi_send_cpumask_enabled() && arch_irq_work_has_interrupt())
-		trace_ipi_send_cpumask(cpumask_of(smp_processor_id()),
-				       _RET_IP_,
-				       work->func);
+	if (trace_ipi_send_cpu_enabled() && arch_irq_work_has_interrupt())
+		trace_ipi_send_cpu(smp_processor_id(), _RET_IP_, work->func);
 
 	arch_irq_work_raise();
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b0a48cf..ad40755 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -96,6 +96,7 @@
 #include "../../io_uring/io-wq.h"
 #include "../smpboot.h"
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpu);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpumask);
 
 /*
diff --git a/kernel/smp.c b/kernel/smp.c
index 37e9613..43f0796 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -107,7 +107,7 @@ static __always_inline void
 send_call_function_single_ipi(int cpu, smp_call_func_t func)
 {
 	if (call_function_single_prep_ipi(cpu)) {
-		trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, func);
+		trace_ipi_send_cpu(cpu, _RET_IP_, func);
 		arch_send_call_function_single_ipi(cpu);
 	}
 }
@@ -346,7 +346,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
 	 * executes migration_cpu_stop() on the remote CPU).
 	 */
-	if (trace_ipi_send_cpumask_enabled()) {
+	if (trace_ipi_send_cpu_enabled()) {
 		call_single_data_t *csd;
 		smp_call_func_t func;
 
