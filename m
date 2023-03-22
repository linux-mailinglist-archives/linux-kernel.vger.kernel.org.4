Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60156C4CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjCVOG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjCVOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:06:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4BA54CA4;
        Wed, 22 Mar 2023 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sOH/P4JrokMCYAgfWwj5ycXuOYqJurQfzeUI9onBv2s=; b=jBjNHOC7qWB4oHhln7lym2SyvG
        13fiewzNurZdmqlPmM5LTnqVATc7bc7Ck81ekMH2BdQufrQhM/S/cYdNh+nUd/SS8jlISkZJdxng9
        UGDNfRGIVcLBM0n4Q0WPB/BTCRBw/oZTgxkxh/MFcemdwuVVMfRrzZwT8hleSfze70nwksyC7FdQo
        URq2nt3wWzTns3K+z/QYKTG28lEJZKPQMPsDVNr07WZ093beJ4RGvPV3dW+CYaEfTPjs2OhVfICrD
        rnE+0tsqva+jhkqwvNTu6Df6g8GtY/D7ezclkZESxvIP2EapnT7/e9uX8x4F6vTPNIrjB5GOcYvb0
        GUSRtrjg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pez4w-004ZNU-0e;
        Wed, 22 Mar 2023 14:04:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFDD830031E;
        Wed, 22 Mar 2023 15:04:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8585240C838E; Wed, 22 Mar 2023 15:04:34 +0100 (CET)
Date:   Wed, 22 Mar 2023 15:04:34 +0100
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
Subject: Re: [PATCH v5 7/7] sched, smp: Trace smp callback causing an IPI
Message-ID: <20230322140434.GC2357380@hirez.programming.kicks-ass.net>
References: <20230307143558.294354-1-vschneid@redhat.com>
 <20230307143558.294354-8-vschneid@redhat.com>
 <20230322095329.GS2017917@hirez.programming.kicks-ass.net>
 <xhsmhmt45c703.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhmt45c703.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:20:28PM +0000, Valentin Schneider wrote:
> On 22/03/23 10:53, Peter Zijlstra wrote:

> > Hurmph... so we only really consume @func when we IPI. Would it not be
> > more useful to trace this thing for *every* csd enqeued?
> 
> It's true that any CSD enqueued on that CPU's call_single_queue in the
> [first CSD llist_add()'ed, IPI IRQ hits] timeframe is a potential source of
> interference.
> 
> However, can we be sure that first CSD isn't an indirect cause for the
> following ones? say the target CPU exits RCU EQS due to the IPI, there's a
> bit of time before it gets to flush_smp_call_function_queue() where some other CSD
> could be enqueued *because* of that change in state.
> 
> I couldn't find a easy example of that, I might be biased as this is where
> I'd like to go wrt IPI'ing isolated CPUs in usermode. But regardless, when
> correlating an IPI IRQ with its source, we'd always have to look at the
> first CSD in that CSD stack.

So I was thinking something like this:

---
Subject: trace,smp: Trace all smp_function_call*() invocations
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 22 14:58:36 CET 2023

(Ab)use the trace_ipi_send_cpu*() family to trace all
smp_function_call*() invocations, not only those that result in an
actual IPI.

The queued entries log their callback function while the actual IPIs
are traced on generic_smp_call_function_single_interrupt().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/smp.c |   58 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -106,18 +106,20 @@ void __init call_function_init(void)
 }
 
 static __always_inline void
-send_call_function_single_ipi(int cpu, smp_call_func_t func)
+send_call_function_single_ipi(int cpu)
 {
 	if (call_function_single_prep_ipi(cpu)) {
-		trace_ipi_send_cpu(cpu, _RET_IP_, func);
+		trace_ipi_send_cpu(cpu, _RET_IP_,
+				   generic_smp_call_function_single_interrupt);
 		arch_send_call_function_single_ipi(cpu);
 	}
 }
 
 static __always_inline void
-send_call_function_ipi_mask(const struct cpumask *mask, smp_call_func_t func)
+send_call_function_ipi_mask(const struct cpumask *mask)
 {
-	trace_ipi_send_cpumask(mask, _RET_IP_, func);
+	trace_ipi_send_cpumask(mask, _RET_IP_,
+			       generic_smp_call_function_single_interrupt);
 	arch_send_call_function_ipi_mask(mask);
 }
 
@@ -318,25 +320,6 @@ static __always_inline void csd_unlock(s
 	smp_store_release(&csd->node.u_flags, 0);
 }
 
-static __always_inline void
-raw_smp_call_single_queue(int cpu, struct llist_node *node, smp_call_func_t func)
-{
-	/*
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
-		send_call_function_single_ipi(cpu, func);
-}
-
 static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 
 void __smp_call_single_queue(int cpu, struct llist_node *node)
@@ -356,10 +339,23 @@ void __smp_call_single_queue(int cpu, st
 		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
 			sched_ttwu_pending : csd->func;
 
-		raw_smp_call_single_queue(cpu, node, func);
-	} else {
-		raw_smp_call_single_queue(cpu, node, NULL);
+		trace_ipi_send_cpu(cpu, _RET_IP_, func);
 	}
+
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
+		send_call_function_single_ipi(cpu);
 }
 
 /*
@@ -798,14 +794,20 @@ static void smp_call_function_many_cond(
 		}
 
 		/*
+		 * Trace each smp_function_call_*() as an IPI, actual IPIs
+		 * will be traced with func==generic_smp_call_function_single_ipi().
+		 */
+		trace_ipi_send_cpumask(cfd->cpumask_ipi, _RET_IP_, func);
+
+		/*
 		 * Choose the most efficient way to send an IPI. Note that the
 		 * number of CPUs might be zero due to concurrent changes to the
 		 * provided mask.
 		 */
 		if (nr_cpus == 1)
-			send_call_function_single_ipi(last_cpu, func);
+			send_call_function_single_ipi(last_cpu);
 		else if (likely(nr_cpus > 1))
-			send_call_function_ipi_mask(cfd->cpumask_ipi, func);
+			send_call_function_ipi_mask(cfd->cpumask_ipi);
 	}
 
 	if (run_local && (!cond_func || cond_func(this_cpu, info))) {
