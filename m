Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9946CB981
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjC1Iex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjC1Iet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:34:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896143C33;
        Tue, 28 Mar 2023 01:34:47 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:34:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679992485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tUILXd7hnx0zQEHBSwqkcnBfj7Vwkx3YWbcPQ6UQd8=;
        b=BK8AqibDR3CgHdcAQO9RiHJowcyabFUcLVqAV+FEKtGqg8hC25OrSnWhwPxLkkKpikiRAT
        jusO145RpzhO4OftC9+WI3wSF3oJ6yA52bfQCnQy02okkaszZFm4MYYICMw88weq3usdle
        5YxEGveikii5FuVLCTY4WMlwPAv4hkOg/fsXWdDdIK6qhr0oirgTcDwN5ZKNaMNQL9+8Vy
        eIPuWStpvF8SwDFeawIlYNWr0TN5uwAwbAd2GWYVBQq2e4SDgLewcjARG5EHgDgxW6MzGE
        FudiRtcXaJIvASRIpGb11FhAnNVSE2d/WWfRMI6+FU6Sa/HmssOH+Bf74ar24Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679992485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tUILXd7hnx0zQEHBSwqkcnBfj7Vwkx3YWbcPQ6UQd8=;
        b=d1mbeOjiMFFtpl/SCGEPp43CpTbjLiSEVUSne8uyqHxkqPBcs1RO7r9dhUN7DD8sTLBvxf
        6N+y8r1RbSuGDcCg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] sched, smp: Trace smp callback causing an IPI
Cc:     Valentin Schneider <vschneid@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307143558.294354-8-vschneid@redhat.com>
References: <20230307143558.294354-8-vschneid@redhat.com>
MIME-Version: 1.0
Message-ID: <167999248462.5837.17270622315487282939.tip-bot2@tip-bot2>
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

Commit-ID:     68f4ff04dbada18dad79659c266a8e5e29e458cd
Gitweb:        https://git.kernel.org/tip/68f4ff04dbada18dad79659c266a8e5e29e458cd
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Tue, 07 Mar 2023 14:35:58 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Mar 2023 11:01:29 +01:00

sched, smp: Trace smp callback causing an IPI

Context
=======

The newly-introduced ipi_send_cpumask tracepoint has a "callback" parameter
which so far has only been fed with NULL.

While CSD_TYPE_SYNC/ASYNC and CSD_TYPE_IRQ_WORK share a similar backing
struct layout (meaning their callback func can be accessed without caring
about the actual CSD type), CSD_TYPE_TTWU doesn't even have a function
attached to its struct. This means we need to check the type of a CSD
before eventually dereferencing its associated callback.

This isn't as trivial as it sounds: the CSD type is stored in
__call_single_node.u_flags, which get cleared right before the callback is
executed via csd_unlock(). This implies checking the CSD type before it is
enqueued on the call_single_queue, as the target CPU's queue can be flushed
before we get to sending an IPI.

Furthermore, send_call_function_single_ipi() only has a CPU parameter, and
would need to have an additional argument to trickle down the invoked
function. This is somewhat silly, as the extra argument will always be
pushed down to the function even when nothing is being traced, which is
unnecessary overhead.

Changes
=======

send_call_function_single_ipi() is only used by smp.c, and is defined in
sched/core.c as it contains scheduler-specific ops (set_nr_if_polling() of
a CPU's idle task).

Split it into two parts: the scheduler bits remain in sched/core.c, and the
actual IPI emission is moved into smp.c. This lets us define an
__always_inline helper function that can take the related callback as
parameter without creating useless register pressure in the non-traced path
which only gains a (disabled) static branch.

Do the same thing for the multi IPI case.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230307143558.294354-8-vschneid@redhat.com
---
 kernel/sched/core.c | 18 +++++++++-------
 kernel/sched/smp.h  |  2 +-
 kernel/smp.c        | 49 ++++++++++++++++++++++++++++++++++++--------
 3 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c26a2cd..b0a48cf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3829,16 +3829,20 @@ void sched_ttwu_pending(void *arg)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-void send_call_function_single_ipi(int cpu)
+/*
+ * Prepare the scene for sending an IPI for a remote smp_call
+ *
+ * Returns true if the caller can proceed with sending the IPI.
+ * Returns false otherwise.
+ */
+bool call_function_single_prep_ipi(int cpu)
 {
-	struct rq *rq = cpu_rq(cpu);
-
-	if (!set_nr_if_polling(rq->idle)) {
-		trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);
-		arch_send_call_function_single_ipi(cpu);
-	} else {
+	if (set_nr_if_polling(cpu_rq(cpu)->idle)) {
 		trace_sched_wake_idle_without_ipi(cpu);
+		return false;
 	}
+
+	return true;
 }
 
 /*
diff --git a/kernel/sched/smp.h b/kernel/sched/smp.h
index 2eb23dd..21ac444 100644
--- a/kernel/sched/smp.h
+++ b/kernel/sched/smp.h
@@ -6,7 +6,7 @@
 
 extern void sched_ttwu_pending(void *arg);
 
-extern void send_call_function_single_ipi(int cpu);
+extern bool call_function_single_prep_ipi(int cpu);
 
 #ifdef CONFIG_SMP
 extern void flush_smp_call_function_queue(void);
diff --git a/kernel/smp.c b/kernel/smp.c
index 6bbfabb..37e9613 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -104,9 +104,18 @@ void __init call_function_init(void)
 }
 
 static __always_inline void
-send_call_function_ipi_mask(struct cpumask *mask)
+send_call_function_single_ipi(int cpu, smp_call_func_t func)
 {
-	trace_ipi_send_cpumask(mask, _RET_IP_, NULL);
+	if (call_function_single_prep_ipi(cpu)) {
+		trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, func);
+		arch_send_call_function_single_ipi(cpu);
+	}
+}
+
+static __always_inline void
+send_call_function_ipi_mask(struct cpumask *mask, smp_call_func_t func)
+{
+	trace_ipi_send_cpumask(mask, _RET_IP_, func);
 	arch_send_call_function_ipi_mask(mask);
 }
 
@@ -307,9 +316,8 @@ static __always_inline void csd_unlock(struct __call_single_data *csd)
 	smp_store_release(&csd->node.u_flags, 0);
 }
 
-static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
-
-void __smp_call_single_queue(int cpu, struct llist_node *node)
+static __always_inline void
+raw_smp_call_single_queue(int cpu, struct llist_node *node, smp_call_func_t func)
 {
 	/*
 	 * The list addition should be visible to the target CPU when it pops
@@ -324,7 +332,32 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 	 * equipped to do the right thing...
 	 */
 	if (llist_add(node, &per_cpu(call_single_queue, cpu)))
-		send_call_function_single_ipi(cpu);
+		send_call_function_single_ipi(cpu, func);
+}
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
+
+void __smp_call_single_queue(int cpu, struct llist_node *node)
+{
+	/*
+	 * We have to check the type of the CSD before queueing it, because
+	 * once queued it can have its flags cleared by
+	 *   flush_smp_call_function_queue()
+	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
+	 * executes migration_cpu_stop() on the remote CPU).
+	 */
+	if (trace_ipi_send_cpumask_enabled()) {
+		call_single_data_t *csd;
+		smp_call_func_t func;
+
+		csd = container_of(node, call_single_data_t, node.llist);
+		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
+			sched_ttwu_pending : csd->func;
+
+		raw_smp_call_single_queue(cpu, node, func);
+	} else {
+		raw_smp_call_single_queue(cpu, node, NULL);
+	}
 }
 
 /*
@@ -768,9 +801,9 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		 * provided mask.
 		 */
 		if (nr_cpus == 1)
-			send_call_function_single_ipi(last_cpu);
+			send_call_function_single_ipi(last_cpu, func);
 		else if (likely(nr_cpus > 1))
-			send_call_function_ipi_mask(cfd->cpumask_ipi);
+			send_call_function_ipi_mask(cfd->cpumask_ipi, func);
 	}
 
 	if (run_local && (!cond_func || cond_func(this_cpu, info))) {
