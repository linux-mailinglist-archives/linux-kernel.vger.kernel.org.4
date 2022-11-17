Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008FD62DDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiKQONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiKQONT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:13:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBF06204F;
        Thu, 17 Nov 2022 06:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MW5+NnO2Tu8NlwdFq3hDFtaofKcS5eP2XdeVQ9JCU3g=; b=AbnKE5Jc6O+H3xaGhMYqGrC3y9
        YVacd7j962DPg4af6H/+3simUiSgbuK/6G4zOl6bRYUYuLlrfnrdtOe9kgHbyzTTSHzpcEqu7qPv4
        i/tQVeVWKIRgJXbg5hWxJebKtN2EOimPdIUqJ5UPTvtVLIe3VOu+NAxDi+ao2G6T7X7leU6AgOQe+
        EVJz3gbkA7CnSkui7IjODrAPkhoYTvJzucvlcmObLasetIt9Y4UcnCmj1L8efJmwNseYneU9uObMI
        C3+2NforbJUN9mRB2v294ooOYsk2XW5dJTDvRy1Ypp9Befi7H88f/EarR5pfO0ONSMvNsDK5hGMyP
        m8CTMzhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovfd5-001hCk-C8; Thu, 17 Nov 2022 14:12:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81A68300220;
        Thu, 17 Nov 2022 15:12:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6829C207D6247; Thu, 17 Nov 2022 15:12:32 +0100 (CET)
Date:   Thu, 17 Nov 2022 15:12:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH v2 8/8] sched, smp: Trace smp callback causing an IPI
Message-ID: <Y3ZBUMteJysc1/lA@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-7-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102183336.3120536-7-vschneid@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:33:36PM +0000, Valentin Schneider wrote:
> The newly-introduced ipi_send_cpumask tracepoint has a "callback" parameter
> which so far has only been fed with NULL.
> 
> While CSD_TYPE_SYNC/ASYNC and CSD_TYPE_IRQ_WORK share a similar backing
> struct layout (meaning their callback func can be accessed without caring
> about the actual CSD type), CSD_TYPE_TTWU doesn't even have a function
> attached to its struct. This means we need to check the type of a CSD
> before eventually dereferencing its associated callback.
> 
> This isn't as trivial as it sounds: the CSD type is stored in
> __call_single_node.u_flags, which get cleared right before the callback is
> executed via csd_unlock(). This implies checking the CSD type before it is
> enqueued on the call_single_queue, as the target CPU's queue can be flushed
> before we get to sending an IPI.
> 
> Furthermore, send_call_function_single_ipi() only has a CPU parameter, and
> would need to have an additional argument to trickle down the invoked
> function. This is somewhat silly, as the extra argument will always be
> pushed down to the function even when nothing is being traced, which is
> unnecessary overhead.
> 
> Two options present themselves:
> a) Create copies of send_call_function_{single_ipi, ipi_mask}() that take
>    an extra argument used for tracing, so that codepaths remain unchanged
>    when tracing isn't in effect (a sort of manual -fipa-sra).
> 
> b) Stash the CSD func in somewhere as a side effect that
>    the portion of send_call_function_{single_ipi, ipi_mask}() under the
>    tracepoint's static key can fetch.
> 
> a) creates redundant code, and b) is quite fragile due to requiring extra
> care for "reentrant" functions (async SMP calls).
> 
> This implements a).
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/irq_work.c   |  2 ++
>  kernel/sched/core.c | 35 ++++++++++++++++++++++++-----------
>  kernel/sched/smp.h  |  1 +
>  kernel/smp.c        | 42 ++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 65 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index aec38c294ce68..fcfa75c4a5daf 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -24,6 +24,8 @@
>  
>  #include <trace/events/ipi.h>
>  
> +#include "sched/smp.h"
> +
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
>  static DEFINE_PER_CPU(struct task_struct *, irq_workd);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 02181f8072b5f..41196ca67e913 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3743,17 +3743,30 @@ void sched_ttwu_pending(void *arg)
>  	rq_unlock_irqrestore(rq, &rf);
>  }
>  
> -void send_call_function_single_ipi(int cpu)
> -{
> -	struct rq *rq = cpu_rq(cpu);
> -
> -	if (!set_nr_if_polling(rq->idle)) {
> -		trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);
> -		arch_send_call_function_single_ipi(cpu);
> -	} else {
> -		trace_sched_wake_idle_without_ipi(cpu);
> -	}
> -}
> +/*
> + * We want a variant that traces the function causing the IPI to be sent, but
> + * we don't want the extra argument to cause unnecessary overhead when tracing
> + * isn't happening.
> + */
> +#define GEN_CFSI(suffix, IPI_EXP, ...)						\
> +void send_call_function_single_ipi##suffix(__VA_ARGS__)				\
> +{										\
> +	struct rq *rq = cpu_rq(cpu);						\
> +										\
> +	if (!set_nr_if_polling(rq->idle)) {					\
> +		IPI_EXP;							\
> +		arch_send_call_function_single_ipi(cpu);			\
> +	} else {								\
> +		trace_sched_wake_idle_without_ipi(cpu);				\
> +	}									\
> +}
> +
> +GEN_CFSI(/* nop */,
> +	 /* nop */,
> +	 int cpu)
> +GEN_CFSI(_trace,
> +	 trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, func),
> +	 int cpu, smp_call_func_t func)
>  

*yuck*

How about something like so?

---
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -24,6 +24,8 @@
 
 #include <trace/events/ipi.h>
 
+#include "sched/smp.h"
+
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
 static DEFINE_PER_CPU(struct task_struct *, irq_workd);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3763,16 +3763,17 @@ void sched_ttwu_pending(void *arg)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-void send_call_function_single_ipi(int cpu)
+bool send_call_function_single_ipi(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
 	if (!set_nr_if_polling(rq->idle)) {
-		trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);
 		arch_send_call_function_single_ipi(cpu);
-	} else {
-		trace_sched_wake_idle_without_ipi(cpu);
+		return true;
 	}
+
+	trace_sched_wake_idle_without_ipi(cpu);
+	return false;
 }
 
 /*
--- a/kernel/sched/smp.h
+++ b/kernel/sched/smp.h
@@ -6,7 +6,7 @@
 
 extern void sched_ttwu_pending(void *arg);
 
-extern void send_call_function_single_ipi(int cpu);
+extern bool send_call_function_single_ipi(int cpu);
 
 #ifdef CONFIG_SMP
 extern void flush_smp_call_function_queue(void);
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -163,7 +163,6 @@ void __init call_function_init(void)
 static inline void
 send_call_function_ipi_mask(const struct cpumask *mask)
 {
-	trace_ipi_send_cpumask(mask, _RET_IP_, func);
 	arch_send_call_function_ipi_mask(mask);
 }
 
@@ -438,11 +437,16 @@ static void __smp_call_single_queue_debu
 	struct cfd_seq_local *seq = this_cpu_ptr(&cfd_seq_local);
 	struct call_function_data *cfd = this_cpu_ptr(&cfd_data);
 	struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
+	struct __call_single_data *csd;
+
+	csd = container_of(node, call_single_data_t, node.llist);
+	WARN_ON_ONCE(!(CSD_TYPE(csd) & (CSD_TYPE_SYNC | CSD_TYPE_ASYNC)));
 
 	cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
 	if (llist_add(node, &per_cpu(call_single_queue, cpu))) {
 		cfd_seq_store(pcpu->seq_ipi, this_cpu, cpu, CFD_SEQ_IPI);
 		cfd_seq_store(seq->ping, this_cpu, cpu, CFD_SEQ_PING);
+		trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, csd->func);
 		send_call_function_single_ipi(cpu);
 		cfd_seq_store(seq->pinged, this_cpu, cpu, CFD_SEQ_PINGED);
 	} else {
@@ -487,6 +491,27 @@ static __always_inline void csd_unlock(s
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 
+static __always_inline
+bool raw_smp_call_single_queue(int cpu, struct llist_node *node)
+{
+	/*
+	 * The list addition should be visible to the target CPU when it pops
+	 * the head of the list to pull the entry off it in the IPI handler
+	 * because of normal cache coherency rules implied by the underlying
+	 * llist ops.
+	 *
+	 * If IPIs can go out of order to the cache coherency protocol
+	 * in an architecture, sufficient synchronisation should be added
+	 * to arch code to make it appear to obey cache coherency WRT
+	 * locking and barrier primitives. Generic code isn't really
+	 * equipped to do the right thing...
+	 */
+	if (llist_add(node, &per_cpu(call_single_queue, cpu)))
+		return send_call_function_single_ipi(cpu);
+
+	return false;
+}
+
 void __smp_call_single_queue(int cpu, struct llist_node *node)
 {
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
@@ -503,19 +528,28 @@ void __smp_call_single_queue(int cpu, st
 #endif
 
 	/*
-	 * The list addition should be visible to the target CPU when it pops
-	 * the head of the list to pull the entry off it in the IPI handler
-	 * because of normal cache coherency rules implied by the underlying
-	 * llist ops.
-	 *
-	 * If IPIs can go out of order to the cache coherency protocol
-	 * in an architecture, sufficient synchronisation should be added
-	 * to arch code to make it appear to obey cache coherency WRT
-	 * locking and barrier primitives. Generic code isn't really
-	 * equipped to do the right thing...
-	 */
-	if (llist_add(node, &per_cpu(call_single_queue, cpu)))
-		send_call_function_single_ipi(cpu);
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
+
+		func = sched_ttwu_pending;
+		if (CSD_TYPE(csd) != CSD_TYPE_TTWU)
+			func = csd->func;
+
+		if (raw_smp_call_single_queue(cpu, node))
+			trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, func);
+		return;
+	}
+
+	raw_smp_call_single_queue(cpu, node);
 }
 
 /*
@@ -983,10 +1017,13 @@ static void smp_call_function_many_cond(
 		 * number of CPUs might be zero due to concurrent changes to the
 		 * provided mask.
 		 */
-		if (nr_cpus == 1)
+		if (nr_cpus == 1) {
+			trace_ipi_send_cpumask(cpumask_of(last_cpu), _RET_IP_, func);
 			send_call_function_single_ipi(last_cpu);
-		else if (likely(nr_cpus > 1))
-			send_call_function_ipi_mask(cfd->cpumask_ipi);
+		} else if (likely(nr_cpus > 1)) {
+			trace_ipi_send_cpumask(mask, _RET_IP_, func);
+			send_call_function_ipi_mask(mask);
+		}
 
 		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu, CFD_SEQ_NOCPU, CFD_SEQ_PINGED);
 	}
