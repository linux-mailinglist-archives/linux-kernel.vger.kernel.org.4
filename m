Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05C16CB979
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjC1Ie4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjC1Iet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:34:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0213C34;
        Tue, 28 Mar 2023 01:34:47 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:34:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679992484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D3B7nzKMMWsjwR9QP71tCe6es3LnbxXXLiF4JlgphQM=;
        b=rDKeCg88RKsL0itI1NnTllrRubu805sHe3NENZZzmNmUbuwocQ03q/S8M4qQG0Zld4j8Eo
        b2jphTgBozvQRXSsD0h+s2Ab4bS3nV5Te73ePVMn0Iv45Dp9PfiTFBaIzw7lcEtKMDpmn9
        2xKintXeip+436Hp7b5HcHL4pfJ4ow9kUmSJ3X+Fzckk1zm/qe6GOhIuHT1dv0mL1o3t2x
        t9B6qk1wPcAIOEyb0/XvaSN5niV8FcdPCer/unmCaiHUSDQtU1AVrpK12r2mqjV2pLV/BY
        CemNBCYqSnWAGKtu0jDII+I9vV8xgM8RwCspJiBC7Eh3PICsmP+Uosc7hJrAhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679992484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D3B7nzKMMWsjwR9QP71tCe6es3LnbxXXLiF4JlgphQM=;
        b=g2cLdc5Rw2tZvOYS17smbn6ZhNaK3Dx3WCvJyUBusLEVOHvS33d0BaGAoR7my1fkWuozFp
        9AyRLF2AprOv9aCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] trace,smp: Trace all smp_function_call*() invocations
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167999248367.5837.16129137669331435205.tip-bot2@tip-bot2>
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

Commit-ID:     5c3124975e15c1fadd5af1c61e4d627cf6d97ba2
Gitweb:        https://git.kernel.org/tip/5c3124975e15c1fadd5af1c61e4d627cf6d97ba2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 22 Mar 2023 14:58:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Mar 2023 11:01:30 +01:00

trace,smp: Trace all smp_function_call*() invocations

(Ab)use the trace_ipi_send_cpu*() family to trace all
smp_function_call*() invocations, not only those that result in an
actual IPI.

The queued entries log their callback function while the actual IPIs
are traced on generic_smp_call_function_single_interrupt().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/smp.c | 66 +++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 43f0796..ab3e5da 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -104,18 +104,20 @@ void __init call_function_init(void)
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
-send_call_function_ipi_mask(struct cpumask *mask, smp_call_func_t func)
+send_call_function_ipi_mask(struct cpumask *mask)
 {
-	trace_ipi_send_cpumask(mask, _RET_IP_, func);
+	trace_ipi_send_cpumask(mask, _RET_IP_,
+			       generic_smp_call_function_single_interrupt);
 	arch_send_call_function_ipi_mask(mask);
 }
 
@@ -316,25 +318,6 @@ static __always_inline void csd_unlock(struct __call_single_data *csd)
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
@@ -354,10 +337,23 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
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
@@ -732,9 +728,9 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
 	bool wait = scf_flags & SCF_WAIT;
+	int nr_cpus = 0, nr_queued = 0;
 	bool run_remote = false;
 	bool run_local = false;
-	int nr_cpus = 0;
 
 	lockdep_assert_preemption_disabled();
 
@@ -776,8 +772,10 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
 
-			if (cond_func && !cond_func(cpu, info))
+			if (cond_func && !cond_func(cpu, info)) {
+				__cpumask_clear_cpu(cpu, cfd->cpumask);
 				continue;
+			}
 
 			csd_lock(csd);
 			if (wait)
@@ -793,17 +791,25 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 				nr_cpus++;
 				last_cpu = cpu;
 			}
+			nr_queued++;
 		}
 
 		/*
+		 * Trace each smp_function_call_*() as an IPI, actual IPIs
+		 * will be traced with func==generic_smp_call_function_single_ipi().
+		 */
+		if (nr_queued)
+			trace_ipi_send_cpumask(cfd->cpumask, _RET_IP_, func);
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
