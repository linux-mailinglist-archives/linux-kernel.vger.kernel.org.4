Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D557353F2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjFSKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjFSKtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:49:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE26173D;
        Mon, 19 Jun 2023 03:49:26 -0700 (PDT)
Date:   Mon, 19 Jun 2023 10:49:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687171765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JLpmxaC3hPQe85VWfgs8yWcsP3kWSaneGCYgT+zvxro=;
        b=ha0fF8u+iYQvW1C7+CD2X7AZtmYEdCHc4pMhyL0u3WgLKhF6KK/jqWY94LT4UX8KuV/P5Y
        Q8FXQ2IOqLsTvZR7IJxFJgYN33QqPIgMTKVxUtgCXs+RerysQqawajCaCt/jwJXUr0cB9i
        4L2W03TTkr7nejP92IKHd9RP+JnuTUSMVLb6+5CckYexh2C3gqBYyJbL5i2DS2d2p9mr4w
        nRpTHitlqPRSWqr87fyHwAJoEVYoHcKLEFvOQFmUNid+6BmGdyAH7joIvh8bEvXJcYpXW8
        XahYypT/cLFiQL6o5eRZbK+02cFU4S1j4GFFR6JbR2+wHw8RVbP9ib5Q36o44Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687171765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JLpmxaC3hPQe85VWfgs8yWcsP3kWSaneGCYgT+zvxro=;
        b=NJdwaFEQ3pQ+VZV5Wy5QSXK6vgY2oreJsKG5j1K8Yxnvn6FYlx4fN005v+9MGMhd4w8YX3
        t0EYcb4FvaYNvUDA==
From:   "tip-bot2 for Leonardo Bras" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] trace,smp: Add tracepoints for scheduling remotelly
 called functions
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230615065944.188876-7-leobras@redhat.com>
References: <20230615065944.188876-7-leobras@redhat.com>
MIME-Version: 1.0
Message-ID: <168717176421.404.11770639740909284184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     bf5a8c26ad7caf0772a1cd48c8a0924e48bdbaf0
Gitweb:        https://git.kernel.org/tip/bf5a8c26ad7caf0772a1cd48c8a0924e48bdbaf0
Author:        Leonardo Bras <leobras@redhat.com>
AuthorDate:    Thu, 15 Jun 2023 03:59:47 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 22:08:09 +02:00

trace,smp: Add tracepoints for scheduling remotelly called functions

Add a tracepoint for when a CSD is queued to a remote CPU's
call_single_queue. This allows finding exactly which CPU queued a given CSD
when looking at a csd_function_{entry,exit} event, and also enables us to
accurately measure IPI delivery time with e.g. a synthetic event:

  $ echo 'hist:keys=cpu,csd.hex:ts=common_timestamp.usecs' >\
      /sys/kernel/tracing/events/smp/csd_queue_cpu/trigger
  $ echo 'csd_latency unsigned int dst_cpu; unsigned long csd; u64 time' >\
      /sys/kernel/tracing/synthetic_events
  $ echo \
  'hist:keys=common_cpu,csd.hex:'\
  'time=common_timestamp.usecs-$ts:'\
  'onmatch(smp.csd_queue_cpu).trace(csd_latency,common_cpu,csd,$time)' >\
      /sys/kernel/tracing/events/smp/csd_function_entry/trigger

  $ trace-cmd record -e 'synthetic:csd_latency' hackbench
  $ trace-cmd report
  <...>-467   [001]    21.824263: csd_queue_cpu:        cpu=0 callsite=try_to_wake_up+0x2ea func=sched_ttwu_pending csd=0xffff8880076148b8
  <...>-467   [001]    21.824280: ipi_send_cpu:         cpu=0 callsite=try_to_wake_up+0x2ea callback=generic_smp_call_function_single_interrupt+0x0
  <...>-489   [000]    21.824299: csd_function_entry:   func=sched_ttwu_pending csd=0xffff8880076148b8
  <...>-489   [000]    21.824320: csd_latency:          dst_cpu=0, csd=18446612682193848504, time=36

Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Leonardo Bras <leobras@redhat.com>
Tested-and-reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230615065944.188876-7-leobras@redhat.com
---
 include/trace/events/csd.h | 27 +++++++++++++++++++++++++++
 kernel/smp.c               | 16 +++++-----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/csd.h b/include/trace/events/csd.h
index af1df52..67e9d01 100644
--- a/include/trace/events/csd.h
+++ b/include/trace/events/csd.h
@@ -7,6 +7,33 @@
 
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(csd_queue_cpu,
+
+	TP_PROTO(const unsigned int cpu,
+		unsigned long callsite,
+		smp_call_func_t func,
+		struct __call_single_data *csd),
+
+	TP_ARGS(cpu, callsite, func, csd),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, cpu)
+		__field(void *, callsite)
+		__field(void *, func)
+		__field(void *, csd)
+		),
+
+	    TP_fast_assign(
+		__entry->cpu = cpu;
+		__entry->callsite = (void *)callsite;
+		__entry->func = func;
+		__entry->csd  = csd;
+		),
+
+	TP_printk("cpu=%u callsite=%pS func=%ps csd=%p",
+		__entry->cpu, __entry->callsite, __entry->func, __entry->csd)
+	);
+
 /*
  * Tracepoints for a function which is called as an effect of smp_call_function.*
  */
diff --git a/kernel/smp.c b/kernel/smp.c
index 1fa01a8..385179d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -340,7 +340,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
 	 * executes migration_cpu_stop() on the remote CPU).
 	 */
-	if (trace_ipi_send_cpu_enabled()) {
+	if (trace_csd_queue_cpu_enabled()) {
 		call_single_data_t *csd;
 		smp_call_func_t func;
 
@@ -348,7 +348,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
 			sched_ttwu_pending : csd->func;
 
-		trace_ipi_send_cpu(cpu, _RET_IP_, func);
+		trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
 	}
 
 	/*
@@ -741,7 +741,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
 	bool wait = scf_flags & SCF_WAIT;
-	int nr_cpus = 0, nr_queued = 0;
+	int nr_cpus = 0;
 	bool run_remote = false;
 	bool run_local = false;
 
@@ -799,22 +799,16 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd->node.src = smp_processor_id();
 			csd->node.dst = cpu;
 #endif
+			trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
+
 			if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
 				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 				nr_cpus++;
 				last_cpu = cpu;
 			}
-			nr_queued++;
 		}
 
 		/*
-		 * Trace each smp_function_call_*() as an IPI, actual IPIs
-		 * will be traced with func==generic_smp_call_function_single_ipi().
-		 */
-		if (nr_queued)
-			trace_ipi_send_cpumask(cfd->cpumask, _RET_IP_, func);
-
-		/*
 		 * Choose the most efficient way to send an IPI. Note that the
 		 * number of CPUs might be zero due to concurrent changes to the
 		 * provided mask.
