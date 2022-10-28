Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE8610A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJ1Gmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJ1Gl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:41:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2359543D4;
        Thu, 27 Oct 2022 23:41:55 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:41:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TezJNdTWVusi9KEghoLLrOvInnlFXwhMwygeY1mMcyY=;
        b=x370leqqoqk/+TRaUYyi44TVfhoylchXMa3ywfWyuOhF4iSGDlfGxt1p1Wv0T+pIV1yn8E
        4/nh7w0i8VQqrwxE3I3L1Hn/CzI8ky/sh+5kxBasg8wbpVZDKNDt5L4pzcy29quNiCxka/
        Q7OogkZcaWIqn24KaPHfvtttWN1PVHIkLO1uF61Rjusw6BbjU9mQrv54xukAJrUPutqD+U
        qRvqc6qIzkqTSoy//mBaUc08MMVvHoAAWuhSWWtiN4a8hB3bwkvAuNK67dckL9j3bkLs5N
        Xnk9D8ql74RKd+NLE1Pfc9SGYlDsP0n6yXTXGGQcqutPGVzs7o49pxRLF1m2jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TezJNdTWVusi9KEghoLLrOvInnlFXwhMwygeY1mMcyY=;
        b=YTvA0idjE6wwYXwrYqo6gQqfa9sGPpu5HMZgf6VXYQSM22Pm6dfht0voIBas0AwcWKwjB2
        B6SfboKQa9HeFZDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Rewrite core context handling
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221008062424.313-1-ravi.bangoria@amd.com>
References: <20221008062424.313-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <166693931315.29415.18154447859932085034.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bd27568117664b8b3e259721393df420ed51f57b
Gitweb:        https://git.kernel.org/tip/bd27568117664b8b3e259721393df420ed51f57b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 08 Oct 2022 11:54:24 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 20:12:16 +02:00

perf: Rewrite core context handling

There have been various issues and limitations with the way perf uses
(task) contexts to track events. Most notable is the single hardware
PMU task context, which has resulted in a number of yucky things (both
proposed and merged).

Notably:
 - HW breakpoint PMU
 - ARM big.little PMU / Intel ADL PMU
 - Intel Branch Monitoring PMU
 - AMD IBS PMU
 - S390 cpum_cf PMU
 - PowerPC trace_imc PMU

*Current design:*

Currently we have a per task and per cpu perf_event_contexts:

  task_struct::perf_events_ctxp[] <-> perf_event_context <-> perf_cpu_context
       ^                                 |    ^     |           ^
       `---------------------------------'    |     `--> pmu ---'
                                              v           ^
                                         perf_event ------'

Each task has an array of pointers to a perf_event_context. Each
perf_event_context has a direct relation to a PMU and a group of
events for that PMU. The task related perf_event_context's have a
pointer back to that task.

Each PMU has a per-cpu pointer to a per-cpu perf_cpu_context, which
includes a perf_event_context, which again has a direct relation to
that PMU, and a group of events for that PMU.

The perf_cpu_context also tracks which task context is currently
associated with that CPU and includes a few other things like the
hrtimer for rotation etc.

Each perf_event is then associated with its PMU and one
perf_event_context.

*Proposed design:*

New design proposed by this patch reduce to a single task context and
a single CPU context but adds some intermediate data-structures:

  task_struct::perf_event_ctxp -> perf_event_context <- perf_cpu_context
       ^                           |   ^ ^
       `---------------------------'   | |
                                       | |    perf_cpu_pmu_context <--.
                                       | `----.    ^                  |
                                       |      |    |                  |
                                       |      v    v                  |
                                       | ,--> perf_event_pmu_context  |
                                       | |                            |
                                       | |                            |
                                       v v                            |
                                  perf_event ---> pmu ----------------'

With the new design, perf_event_context will hold all events for all
pmus in the (respective pinned/flexible) rbtrees. This can be achieved
by adding pmu to rbtree key:

  {cpu, pmu, cgroup, group_index}

Each perf_event_context carries a list of perf_event_pmu_context which
is used to hold per-pmu-per-context state. For example, it keeps track
of currently active events for that pmu, a pmu specific task_ctx_data,
a flag to tell whether rotation is required or not etc.

Additionally, perf_cpu_pmu_context is used to hold per-pmu-per-cpu
state like hrtimer details to drive the event rotation, a pointer to
perf_event_pmu_context of currently running task and some other
ancillary information.

Each perf_event is associated to it's pmu, perf_event_context and
perf_event_pmu_context.

Further optimizations to current implementation are possible. For
example, ctx_resched() can be optimized to reschedule only single pmu
events.

Much thanks to Ravi for picking this up and pushing it towards
completion.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221008062424.313-1-ravi.bangoria@amd.com
---
 arch/arm64/kernel/perf_event.c     |   18 +-
 arch/powerpc/perf/core-book3s.c    |    8 +-
 arch/s390/kernel/perf_pai_crypto.c |    2 +-
 arch/s390/kernel/perf_pai_ext.c    |    2 +-
 arch/x86/events/amd/brs.c          |    2 +-
 arch/x86/events/amd/lbr.c          |    6 +-
 arch/x86/events/core.c             |   44 +-
 arch/x86/events/intel/core.c       |   23 +-
 arch/x86/events/intel/ds.c         |    4 +-
 arch/x86/events/intel/lbr.c        |   30 +-
 arch/x86/events/perf_event.h       |   30 +-
 drivers/perf/arm_pmu.c             |   16 +-
 include/linux/perf/arm_pmu.h       |    2 +-
 include/linux/perf_event.h         |  125 +-
 include/linux/sched.h              |    2 +-
 kernel/events/core.c               | 1958 +++++++++++++--------------
 16 files changed, 1178 insertions(+), 1094 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 7b0643f..5418654 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -806,10 +806,14 @@ static void armv8pmu_disable_event(struct perf_event *event)
 
 static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 {
-	struct perf_event_context *task_ctx =
-		this_cpu_ptr(cpu_pmu->pmu.pmu_cpu_context)->task_ctx;
+	struct perf_event_context *ctx;
+	int nr_user = 0;
 
-	if (sysctl_perf_user_access && task_ctx && task_ctx->nr_user)
+	ctx = perf_cpu_task_ctx();
+	if (ctx)
+		nr_user = ctx->nr_user;
+
+	if (sysctl_perf_user_access && nr_user)
 		armv8pmu_enable_user_access(cpu_pmu);
 	else
 		armv8pmu_disable_user_access();
@@ -1019,10 +1023,10 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
-static int armv8pmu_filter_match(struct perf_event *event)
+static bool armv8pmu_filter(struct pmu *pmu, int cpu)
 {
-	unsigned long evtype = event->hw.config_base & ARMV8_PMU_EVTYPE_EVENT;
-	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
+	struct arm_pmu *armpmu = to_arm_pmu(pmu);
+	return !cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus);
 }
 
 static void armv8pmu_reset(void *info)
@@ -1253,7 +1257,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->stop			= armv8pmu_stop;
 	cpu_pmu->reset			= armv8pmu_reset;
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
-	cpu_pmu->filter_match		= armv8pmu_filter_match;
+	cpu_pmu->filter			= armv8pmu_filter;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
 
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 942aa83..bf318dd 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -132,7 +132,7 @@ static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
 static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
-static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in) {}
+static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in) {}
 static inline void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
@@ -424,7 +424,7 @@ static void power_pmu_bhrb_enable(struct perf_event *event)
 		cpuhw->bhrb_context = event->ctx;
 	}
 	cpuhw->bhrb_users++;
-	perf_sched_cb_inc(event->ctx->pmu);
+	perf_sched_cb_inc(event->pmu);
 }
 
 static void power_pmu_bhrb_disable(struct perf_event *event)
@@ -436,7 +436,7 @@ static void power_pmu_bhrb_disable(struct perf_event *event)
 
 	WARN_ON_ONCE(!cpuhw->bhrb_users);
 	cpuhw->bhrb_users--;
-	perf_sched_cb_dec(event->ctx->pmu);
+	perf_sched_cb_dec(event->pmu);
 
 	if (!cpuhw->disabled && !cpuhw->bhrb_users) {
 		/* BHRB cannot be turned off when other
@@ -451,7 +451,7 @@ static void power_pmu_bhrb_disable(struct perf_event *event)
 /* Called from ctxsw to prevent one process's branch entries to
  * mingle with the other process's entries during context switch.
  */
-static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	if (!ppmu->bhrb_nr)
 		return;
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 6826e2a..f747137 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -379,7 +379,7 @@ static int paicrypt_push_sample(void)
 /* Called on schedule-in and schedule-out. No access to event structure,
  * but for sampling only event CRYPTO_ALL is allowed.
  */
-static void paicrypt_sched_task(struct perf_event_context *ctx, bool sched_in)
+static void paicrypt_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	/* We started with a clean page on event installation. So read out
 	 * results on schedule_out and if page was dirty, clear values.
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index d5c7c1e..9547798 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -471,7 +471,7 @@ static int paiext_push_sample(void)
 /* Called on schedule-in and schedule-out. No access to event structure,
  * but for sampling only event NNPA_ALL is allowed.
  */
-static void paiext_sched_task(struct perf_event_context *ctx, bool sched_in)
+static void paiext_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	/* We started with a clean page on event installation. So read out
 	 * results on schedule_out and if page was dirty, clear values.
diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index f1bff15..58461fa 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -384,7 +384,7 @@ static void amd_brs_poison_buffer(void)
  * On ctxswin, sched_in = true, called after the PMU has started
  * On ctxswout, sched_in = false, called before the PMU is stopped
  */
-void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in)
+void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 38a7521..eb31f85 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -352,7 +352,7 @@ void amd_pmu_lbr_add(struct perf_event *event)
 		cpuc->br_sel = reg->reg;
 	}
 
-	perf_sched_cb_inc(event->ctx->pmu);
+	perf_sched_cb_inc(event->pmu);
 
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		amd_pmu_lbr_reset();
@@ -370,10 +370,10 @@ void amd_pmu_lbr_del(struct perf_event *event)
 
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
-	perf_sched_cb_dec(event->ctx->pmu);
+	perf_sched_cb_dec(event->pmu);
 }
 
-void amd_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
+void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b30b8bb..337a99a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -90,6 +90,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
 DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
 DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
+
 /*
  * This one is magic, it will get called even when PMU init fails (because
  * there is no PMU), in which case it should simply return NULL.
@@ -2031,6 +2033,7 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
 
 	static_call_update(x86_pmu_guest_get_msrs, x86_pmu.guest_get_msrs);
+	static_call_update(x86_pmu_filter, x86_pmu.filter);
 }
 
 static void _x86_pmu_read(struct perf_event *event)
@@ -2052,23 +2055,6 @@ void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
 	pr_info("... event mask:             %016Lx\n", intel_ctrl);
 }
 
-/*
- * The generic code is not hybrid friendly. The hybrid_pmu->pmu
- * of the first registered PMU is unconditionally assigned to
- * each possible cpuctx->ctx.pmu.
- * Update the correct hybrid PMU to the cpuctx->ctx.pmu.
- */
-void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu)
-{
-	struct perf_cpu_context *cpuctx;
-
-	if (!pmu->pmu_cpu_context)
-		return;
-
-	cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
-	cpuctx->ctx.pmu = pmu;
-}
-
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -2195,9 +2181,6 @@ static int __init init_hw_perf_events(void)
 						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
 			if (err)
 				break;
-
-			if (cpu_type == hybrid_pmu->cpu_type)
-				x86_pmu_update_cpu_context(&hybrid_pmu->pmu, raw_smp_processor_id());
 		}
 
 		if (i < x86_pmu.num_hybrid_pmus) {
@@ -2646,15 +2629,15 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 	NULL,
 };
 
-static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
-	static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
+	static_call_cond(x86_pmu_sched_task)(pmu_ctx, sched_in);
 }
 
-static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
-				  struct perf_event_context *next)
+static void x86_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
+				  struct perf_event_pmu_context *next_epc)
 {
-	static_call_cond(x86_pmu_swap_task_ctx)(prev, next);
+	static_call_cond(x86_pmu_swap_task_ctx)(prev_epc, next_epc);
 }
 
 void perf_check_microcode(void)
@@ -2689,12 +2672,13 @@ static int x86_pmu_aux_output_match(struct perf_event *event)
 	return 0;
 }
 
-static int x86_pmu_filter_match(struct perf_event *event)
+static bool x86_pmu_filter(struct pmu *pmu, int cpu)
 {
-	if (x86_pmu.filter_match)
-		return x86_pmu.filter_match(event);
+	bool ret = false;
 
-	return 1;
+	static_call_cond(x86_pmu_filter)(pmu, cpu, &ret);
+
+	return ret;
 }
 
 static struct pmu pmu = {
@@ -2725,7 +2709,7 @@ static struct pmu pmu = {
 
 	.aux_output_match	= x86_pmu_aux_output_match,
 
-	.filter_match		= x86_pmu_filter_match,
+	.filter			= x86_pmu_filter,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a646a5f..d8af754 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4536,8 +4536,6 @@ end:
 	cpumask_set_cpu(cpu, &pmu->supported_cpus);
 	cpuc->pmu = &pmu->pmu;
 
-	x86_pmu_update_cpu_context(&pmu->pmu, cpu);
-
 	return true;
 }
 
@@ -4671,17 +4669,17 @@ static void intel_pmu_cpu_dead(int cpu)
 		cpumask_clear_cpu(cpu, &hybrid_pmu(cpuc->pmu)->supported_cpus);
 }
 
-static void intel_pmu_sched_task(struct perf_event_context *ctx,
+static void intel_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
 				 bool sched_in)
 {
-	intel_pmu_pebs_sched_task(ctx, sched_in);
-	intel_pmu_lbr_sched_task(ctx, sched_in);
+	intel_pmu_pebs_sched_task(pmu_ctx, sched_in);
+	intel_pmu_lbr_sched_task(pmu_ctx, sched_in);
 }
 
-static void intel_pmu_swap_task_ctx(struct perf_event_context *prev,
-				    struct perf_event_context *next)
+static void intel_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
+				    struct perf_event_pmu_context *next_epc)
 {
-	intel_pmu_lbr_swap_task_ctx(prev, next);
+	intel_pmu_lbr_swap_task_ctx(prev_epc, next_epc);
 }
 
 static int intel_pmu_check_period(struct perf_event *event, u64 value)
@@ -4705,12 +4703,11 @@ static int intel_pmu_aux_output_match(struct perf_event *event)
 	return is_intel_pt_event(event);
 }
 
-static int intel_pmu_filter_match(struct perf_event *event)
+static void intel_pmu_filter(struct pmu *pmu, int cpu, bool *ret)
 {
-	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
-	unsigned int cpu = smp_processor_id();
+	struct x86_hybrid_pmu *hpmu = hybrid_pmu(pmu);
 
-	return cpumask_test_cpu(cpu, &pmu->supported_cpus);
+	*ret = !cpumask_test_cpu(cpu, &hpmu->supported_cpus);
 }
 
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
@@ -6412,7 +6409,7 @@ __init int intel_pmu_init(void)
 		static_call_update(intel_pmu_set_topdown_event_period,
 				   &adl_set_topdown_event_period);
 
-		x86_pmu.filter_match = intel_pmu_filter_match;
+		x86_pmu.filter = intel_pmu_filter;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
 		x86_pmu.limit_period = spr_limit_period;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7839507..f141cc7 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1059,7 +1059,7 @@ static inline bool pebs_needs_sched_cb(struct cpu_hw_events *cpuc)
 	return cpuc->n_pebs && (cpuc->n_pebs == cpuc->n_large_pebs);
 }
 
-void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in)
+void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
@@ -1167,7 +1167,7 @@ static void
 pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 		  struct perf_event *event, bool add)
 {
-	struct pmu *pmu = event->ctx->pmu;
+	struct pmu *pmu = event->pmu;
 	/*
 	 * Make sure we get updated with the first PEBS
 	 * event. It will trigger also during removal, but
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8259d72..017baba 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -515,21 +515,21 @@ static void __intel_pmu_lbr_save(void *ctx)
 	cpuc->last_log_id = ++task_context_opt(ctx)->log_id;
 }
 
-void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
-				 struct perf_event_context *next)
+void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
+				 struct perf_event_pmu_context *next_epc)
 {
 	void *prev_ctx_data, *next_ctx_data;
 
-	swap(prev->task_ctx_data, next->task_ctx_data);
+	swap(prev_epc->task_ctx_data, next_epc->task_ctx_data);
 
 	/*
-	 * Architecture specific synchronization makes sense in
-	 * case both prev->task_ctx_data and next->task_ctx_data
+	 * Architecture specific synchronization makes sense in case
+	 * both prev_epc->task_ctx_data and next_epc->task_ctx_data
 	 * pointers are allocated.
 	 */
 
-	prev_ctx_data = next->task_ctx_data;
-	next_ctx_data = prev->task_ctx_data;
+	prev_ctx_data = next_epc->task_ctx_data;
+	next_ctx_data = prev_epc->task_ctx_data;
 
 	if (!prev_ctx_data || !next_ctx_data)
 		return;
@@ -538,7 +538,7 @@ void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
 	     task_context_opt(next_ctx_data)->lbr_callstack_users);
 }
 
-void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
+void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	void *task_ctx;
@@ -551,7 +551,7 @@ void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
 	 * the task was scheduled out, restore the stack. Otherwise flush
 	 * the LBR stack.
 	 */
-	task_ctx = ctx ? ctx->task_ctx_data : NULL;
+	task_ctx = pmu_ctx ? pmu_ctx->task_ctx_data : NULL;
 	if (task_ctx) {
 		if (sched_in)
 			__intel_pmu_lbr_restore(task_ctx);
@@ -587,8 +587,8 @@ void intel_pmu_lbr_add(struct perf_event *event)
 
 	cpuc->br_sel = event->hw.branch_reg.reg;
 
-	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data)
-		task_context_opt(event->ctx->task_ctx_data)->lbr_callstack_users++;
+	if (branch_user_callstack(cpuc->br_sel) && event->pmu_ctx->task_ctx_data)
+		task_context_opt(event->pmu_ctx->task_ctx_data)->lbr_callstack_users++;
 
 	/*
 	 * Request pmu::sched_task() callback, which will fire inside the
@@ -611,7 +611,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	 */
 	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
 		cpuc->lbr_pebs_users++;
-	perf_sched_cb_inc(event->ctx->pmu);
+	perf_sched_cb_inc(event->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
 }
@@ -664,8 +664,8 @@ void intel_pmu_lbr_del(struct perf_event *event)
 		return;
 
 	if (branch_user_callstack(cpuc->br_sel) &&
-	    event->ctx->task_ctx_data)
-		task_context_opt(event->ctx->task_ctx_data)->lbr_callstack_users--;
+	    event->pmu_ctx->task_ctx_data)
+		task_context_opt(event->pmu_ctx->task_ctx_data)->lbr_callstack_users--;
 
 	if (event->hw.flags & PERF_X86_EVENT_LBR_SELECT)
 		cpuc->lbr_select = 0;
@@ -675,7 +675,7 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
-	perf_sched_cb_dec(event->ctx->pmu);
+	perf_sched_cb_dec(event->pmu);
 }
 
 static inline bool vlbr_exclude_host(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 332d2e6..6a44aed 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -811,7 +811,7 @@ struct x86_pmu {
 	void		(*cpu_dead)(int cpu);
 
 	void		(*check_microcode)(void);
-	void		(*sched_task)(struct perf_event_context *ctx,
+	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx,
 				      bool sched_in);
 
 	/*
@@ -894,12 +894,12 @@ struct x86_pmu {
 	int		num_topdown_events;
 
 	/*
-	 * perf task context (i.e. struct perf_event_context::task_ctx_data)
+	 * perf task context (i.e. struct perf_event_pmu_context::task_ctx_data)
 	 * switch helper to bridge calls from perf/core to perf/x86.
 	 * See struct pmu::swap_task_ctx() usage for examples;
 	 */
-	void		(*swap_task_ctx)(struct perf_event_context *prev,
-					 struct perf_event_context *next);
+	void		(*swap_task_ctx)(struct perf_event_pmu_context *prev_epc,
+					 struct perf_event_pmu_context *next_epc);
 
 	/*
 	 * AMD bits
@@ -925,7 +925,7 @@ struct x86_pmu {
 
 	int (*aux_output_match) (struct perf_event *event);
 
-	int (*filter_match)(struct perf_event *event);
+	void (*filter)(struct pmu *pmu, int cpu, bool *ret);
 	/*
 	 * Hybrid support
 	 *
@@ -1180,8 +1180,6 @@ int x86_pmu_handle_irq(struct pt_regs *regs);
 void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
 			  u64 intel_ctrl);
 
-void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu);
-
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
@@ -1306,7 +1304,7 @@ void amd_pmu_lbr_reset(void);
 void amd_pmu_lbr_read(void);
 void amd_pmu_lbr_add(struct perf_event *event);
 void amd_pmu_lbr_del(struct perf_event *event);
-void amd_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
+void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 void amd_pmu_lbr_enable_all(void);
 void amd_pmu_lbr_disable_all(void);
 int amd_pmu_lbr_hw_config(struct perf_event *event);
@@ -1330,7 +1328,7 @@ static inline void amd_pmu_brs_add(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	perf_sched_cb_inc(event->ctx->pmu);
+	perf_sched_cb_inc(event->pmu);
 	cpuc->lbr_users++;
 	/*
 	 * No need to reset BRS because it is reset
@@ -1345,10 +1343,10 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 
-	perf_sched_cb_dec(event->ctx->pmu);
+	perf_sched_cb_dec(event->pmu);
 }
 
-void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in);
+void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 #else
 static inline int amd_brs_init(void)
 {
@@ -1373,7 +1371,7 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 {
 }
 
-static inline void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in)
+static inline void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 }
 
@@ -1533,7 +1531,7 @@ void intel_pmu_pebs_enable_all(void);
 
 void intel_pmu_pebs_disable_all(void);
 
-void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in);
+void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
 void intel_pmu_auto_reload_read(struct perf_event *event);
 
@@ -1541,10 +1539,10 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
 void intel_ds_init(void);
 
-void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
-				 struct perf_event_context *next);
+void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
+				 struct perf_event_pmu_context *next_epc);
 
-void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
+void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
 u64 lbr_from_signext_quirk_wr(u64 val);
 
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 3f07df5..5ece3f1 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -550,15 +550,14 @@ static void armpmu_disable(struct pmu *pmu)
  * microarchitecture, and aren't suitable for another. Thus, only match CPUs of
  * the same microarchitecture.
  */
-static int armpmu_filter_match(struct perf_event *event)
+static bool armpmu_filter(struct pmu *pmu, int cpu)
 {
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	unsigned int cpu = smp_processor_id();
-	int ret;
+	struct arm_pmu *armpmu = to_arm_pmu(pmu);
+	bool ret;
 
 	ret = cpumask_test_cpu(cpu, &armpmu->supported_cpus);
-	if (ret && armpmu->filter_match)
-		return armpmu->filter_match(event);
+	if (ret && armpmu->filter)
+		return armpmu->filter(pmu, cpu);
 
 	return ret;
 }
@@ -885,14 +884,13 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 		.start		= armpmu_start,
 		.stop		= armpmu_stop,
 		.read		= armpmu_read,
-		.filter_match	= armpmu_filter_match,
+		.filter		= armpmu_filter,
 		.attr_groups	= pmu->attr_groups,
 		/*
 		 * This is a CPU PMU potentially in a heterogeneous
 		 * configuration (e.g. big.LITTLE). This is not an uncore PMU,
 		 * and we have taken ctx sharing into account (e.g. with our
-		 * pmu::filter_match callback and pmu::event_init group
-		 * validation).
+		 * pmu::filter callback and pmu::event_init group validation).
 		 */
 		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS,
 	};
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 0356cb6..7259680 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -100,7 +100,7 @@ struct arm_pmu {
 	void		(*stop)(struct arm_pmu *);
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
-	int		(*filter_match)(struct perf_event *event);
+	bool		(*filter)(struct pmu *pmu, int cpu);
 	int		num_events;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0031f7b..c6a3bac 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -266,6 +266,7 @@ struct hw_perf_event {
 };
 
 struct perf_event;
+struct perf_event_pmu_context;
 
 /*
  * Common implementation detail of pmu::{start,commit,cancel}_txn
@@ -308,7 +309,7 @@ struct pmu {
 	int				capabilities;
 
 	int __percpu			*pmu_disable_count;
-	struct perf_cpu_context __percpu *pmu_cpu_context;
+	struct perf_cpu_pmu_context __percpu *cpu_pmu_context;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
 	int				task_ctx_nr;
 	int				hrtimer_interval_ms;
@@ -443,7 +444,7 @@ struct pmu {
 	/*
 	 * context-switches callback
 	 */
-	void (*sched_task)		(struct perf_event_context *ctx,
+	void (*sched_task)		(struct perf_event_pmu_context *pmu_ctx,
 					bool sched_in);
 
 	/*
@@ -457,8 +458,8 @@ struct pmu {
 	 * implementation and Perf core context switch handling callbacks for usage
 	 * examples.
 	 */
-	void (*swap_task_ctx)		(struct perf_event_context *prev,
-					 struct perf_event_context *next);
+	void (*swap_task_ctx)		(struct perf_event_pmu_context *prev_epc,
+					 struct perf_event_pmu_context *next_epc);
 					/* optional */
 
 	/*
@@ -522,9 +523,10 @@ struct pmu {
 					/* optional */
 
 	/*
-	 * Filter events for PMU-specific reasons.
+	 * Skip programming this PMU on the given CPU. Typically needed for
+	 * big.LITTLE things.
 	 */
-	int (*filter_match)		(struct perf_event *event); /* optional */
+	bool (*filter)			(struct pmu *pmu, int cpu); /* optional */
 
 	/*
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
@@ -695,6 +697,11 @@ struct perf_event {
 	int				group_caps;
 
 	struct perf_event		*group_leader;
+	/*
+	 * event->pmu will always point to pmu in which this event belongs.
+	 * Whereas event->pmu_ctx->pmu may point to other pmu when group of
+	 * different pmu events is created.
+	 */
 	struct pmu			*pmu;
 	void				*pmu_private;
 
@@ -720,6 +727,12 @@ struct perf_event {
 	struct hw_perf_event		hw;
 
 	struct perf_event_context	*ctx;
+	/*
+	 * event->pmu_ctx points to perf_event_pmu_context in which the event
+	 * is added. This pmu_ctx can be of other pmu for sw event when that
+	 * sw event is part of a group which also contains non-sw events.
+	 */
+	struct perf_event_pmu_context	*pmu_ctx;
 	atomic_long_t			refcount;
 
 	/*
@@ -812,19 +825,69 @@ struct perf_event {
 #endif /* CONFIG_PERF_EVENTS */
 };
 
+/*
+ *           ,-----------------------[1:n]----------------------.
+ *           V                                                  V
+ * perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
+ *           ^                      ^     |                     |
+ *           `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
+ *
+ *
+ * struct perf_event_pmu_context  lifetime is refcount based and RCU freed
+ * (similar to perf_event_context). Locking is as if it were a member of
+ * perf_event_context; specifically:
+ *
+ *   modification, both: ctx->mutex && ctx->lock
+ *   reading, either:    ctx->mutex || ctx->lock
+ *
+ * There is one exception to this; namely put_pmu_ctx() isn't always called
+ * with ctx->mutex held; this means that as long as we can guarantee the epc
+ * has events the above rules hold.
+ *
+ * Specificially, sys_perf_event_open()'s group_leader case depends on
+ * ctx->mutex pinning the configuration. Since we hold a reference on
+ * group_leader (through the filedesc) it can't go away, therefore it's
+ * associated pmu_ctx must exist and cannot change due to ctx->mutex.
+ */
+struct perf_event_pmu_context {
+	struct pmu			*pmu;
+	struct perf_event_context       *ctx;
+
+	struct list_head		pmu_ctx_entry;
+
+	struct list_head		pinned_active;
+	struct list_head		flexible_active;
+
+	/* Used to avoid freeing per-cpu perf_event_pmu_context */
+	unsigned int			embedded : 1;
+
+	unsigned int			nr_events;
+
+	atomic_t			refcount; /* event <-> epc */
+	struct rcu_head			rcu_head;
+
+	void				*task_ctx_data; /* pmu specific data */
+	/*
+	 * Set when one or more (plausibly active) event can't be scheduled
+	 * due to pmu overcommit or pmu constraints, except tolerant to
+	 * events not necessary to be active due to scheduling constraints,
+	 * such as cgroups.
+	 */
+	int				rotate_necessary;
+};
 
 struct perf_event_groups {
 	struct rb_root	tree;
 	u64		index;
 };
 
+
 /**
  * struct perf_event_context - event context structure
  *
  * Used as a container for task events and CPU events as well:
  */
 struct perf_event_context {
-	struct pmu			*pmu;
 	/*
 	 * Protect the states of the events in the list,
 	 * nr_active, and the list:
@@ -837,27 +900,21 @@ struct perf_event_context {
 	 */
 	struct mutex			mutex;
 
-	struct list_head		active_ctx_list;
+	struct list_head		pmu_ctx_list;
 	struct perf_event_groups	pinned_groups;
 	struct perf_event_groups	flexible_groups;
 	struct list_head		event_list;
 
-	struct list_head		pinned_active;
-	struct list_head		flexible_active;
-
 	int				nr_events;
-	int				nr_active;
 	int				nr_user;
 	int				is_active;
+
+	int				nr_task_data;
 	int				nr_stat;
 	int				nr_freq;
 	int				rotate_disable;
-	/*
-	 * Set when nr_events != nr_active, except tolerant to events not
-	 * necessary to be active due to scheduling constraints, such as cgroups.
-	 */
-	int				rotate_necessary;
-	refcount_t			refcount;
+
+	refcount_t			refcount; /* event <-> ctx */
 	struct task_struct		*task;
 
 	/*
@@ -878,7 +935,6 @@ struct perf_event_context {
 #ifdef CONFIG_CGROUP_PERF
 	int				nr_cgroups;	 /* cgroup evts */
 #endif
-	void				*task_ctx_data; /* pmu specific data */
 	struct rcu_head			rcu_head;
 
 	/*
@@ -896,12 +952,13 @@ struct perf_event_context {
  */
 #define PERF_NR_CONTEXTS	4
 
-/**
- * struct perf_cpu_context - per cpu event context structure
- */
-struct perf_cpu_context {
-	struct perf_event_context	ctx;
-	struct perf_event_context	*task_ctx;
+struct perf_cpu_pmu_context {
+	struct perf_event_pmu_context	epc;
+	struct perf_event_pmu_context	*task_epc;
+
+	struct list_head		sched_cb_entry;
+	int				sched_cb_usage;
+
 	int				active_oncpu;
 	int				exclusive;
 
@@ -909,16 +966,20 @@ struct perf_cpu_context {
 	struct hrtimer			hrtimer;
 	ktime_t				hrtimer_interval;
 	unsigned int			hrtimer_active;
+};
+
+/**
+ * struct perf_event_cpu_context - per cpu event context structure
+ */
+struct perf_cpu_context {
+	struct perf_event_context	ctx;
+	struct perf_event_context	*task_ctx;
+	int				online;
 
 #ifdef CONFIG_CGROUP_PERF
 	struct perf_cgroup		*cgrp;
-	struct list_head		cgrp_cpuctx_entry;
 #endif
 
-	struct list_head		sched_cb_entry;
-	int				sched_cb_usage;
-
-	int				online;
 	/*
 	 * Per-CPU storage for iterators used in visit_groups_merge. The default
 	 * storage is of size 2 to hold the CPU and any CPU event iterators.
@@ -982,6 +1043,8 @@ perf_cgroup_from_task(struct task_struct *task, struct perf_event_context *ctx)
 
 #ifdef CONFIG_PERF_EVENTS
 
+extern struct perf_event_context *perf_cpu_task_ctx(void);
+
 extern void *perf_aux_output_begin(struct perf_output_handle *handle,
 				   struct perf_event *event);
 extern void perf_aux_output_end(struct perf_output_handle *handle,
@@ -1187,7 +1250,7 @@ static inline int is_software_event(struct perf_event *event)
  */
 static inline int in_software_context(struct perf_event *event)
 {
-	return event->ctx->pmu->task_ctx_nr == perf_sw_context;
+	return event->pmu_ctx->pmu->task_ctx_nr == perf_sw_context;
 }
 
 static inline int is_exclusive_pmu(struct pmu *pmu)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb5..4e03f1d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1243,7 +1243,7 @@ struct task_struct {
 	unsigned int			futex_state;
 #endif
 #ifdef CONFIG_PERF_EVENTS
-	struct perf_event_context	*perf_event_ctxp[perf_nr_task_contexts];
+	struct perf_event_context	*perf_event_ctxp;
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
 #endif
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 01933db..640f0a5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -155,12 +155,6 @@ static int cpu_function_call(int cpu, remote_function_f func, void *info)
 	return data.ret;
 }
 
-static inline struct perf_cpu_context *
-__get_cpu_context(struct perf_event_context *ctx)
-{
-	return this_cpu_ptr(ctx->pmu->pmu_cpu_context);
-}
-
 static void perf_ctx_lock(struct perf_cpu_context *cpuctx,
 			  struct perf_event_context *ctx)
 {
@@ -184,6 +178,14 @@ static bool is_kernel_event(struct perf_event *event)
 	return READ_ONCE(event->owner) == TASK_TOMBSTONE;
 }
 
+static DEFINE_PER_CPU(struct perf_cpu_context, perf_cpu_context);
+
+struct perf_event_context *perf_cpu_task_ctx(void)
+{
+	lockdep_assert_irqs_disabled();
+	return this_cpu_ptr(&perf_cpu_context)->task_ctx;
+}
+
 /*
  * On task ctx scheduling...
  *
@@ -217,7 +219,7 @@ static int event_function(void *info)
 	struct event_function_struct *efs = info;
 	struct perf_event *event = efs->event;
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 	int ret = 0;
 
@@ -314,7 +316,7 @@ again:
 static void event_function_local(struct perf_event *event, event_f func, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct task_struct *task = READ_ONCE(ctx->task);
 	struct perf_event_context *task_ctx = NULL;
 
@@ -388,7 +390,6 @@ static DEFINE_MUTEX(perf_sched_mutex);
 static atomic_t perf_sched_count;
 
 static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
-static DEFINE_PER_CPU(int, perf_sched_cb_usages);
 static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
 
 static atomic_t nr_mmap_events __read_mostly;
@@ -448,7 +449,7 @@ static void update_perf_cpu_limits(void)
 	WRITE_ONCE(perf_sample_allowed_ns, tmp);
 }
 
-static bool perf_rotate_context(struct perf_cpu_context *cpuctx);
+static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc);
 
 int perf_proc_update_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
@@ -571,12 +572,6 @@ void perf_sample_event_took(u64 sample_len_ns)
 
 static atomic64_t perf_event_id;
 
-static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
-			      enum event_type_t event_type);
-
-static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
-			     enum event_type_t event_type);
-
 static void update_context_time(struct perf_event_context *ctx);
 static u64 perf_event_time(struct perf_event *event);
 
@@ -691,13 +686,31 @@ do {									\
 	___p;								\
 })
 
+static void perf_ctx_disable(struct perf_event_context *ctx)
+{
+	struct perf_event_pmu_context *pmu_ctx;
+
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
+		perf_pmu_disable(pmu_ctx->pmu);
+}
+
+static void perf_ctx_enable(struct perf_event_context *ctx)
+{
+	struct perf_event_pmu_context *pmu_ctx;
+
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
+		perf_pmu_enable(pmu_ctx->pmu);
+}
+
+static void ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
+static void ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type);
+
 #ifdef CONFIG_CGROUP_PERF
 
 static inline bool
 perf_cgroup_match(struct perf_event *event)
 {
-	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 
 	/* @event doesn't care about cgroup */
 	if (!event->cgrp)
@@ -823,54 +836,39 @@ perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
 	}
 }
 
-static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
-
 /*
  * reschedule events based on the cgroup constraint of task.
  */
 static void perf_cgroup_switch(struct task_struct *task)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_cgroup *cgrp;
-	struct perf_cpu_context *cpuctx, *tmp;
-	struct list_head *list;
-	unsigned long flags;
-
-	/*
-	 * Disable interrupts and preemption to avoid this CPU's
-	 * cgrp_cpuctx_entry to change under us.
-	 */
-	local_irq_save(flags);
 
 	cgrp = perf_cgroup_from_task(task, NULL);
 
-	list = this_cpu_ptr(&cgrp_cpuctx_list);
-	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
-		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
-		if (READ_ONCE(cpuctx->cgrp) == cgrp)
-			continue;
-
-		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
-		perf_pmu_disable(cpuctx->ctx.pmu);
+	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
+	if (READ_ONCE(cpuctx->cgrp) == cgrp)
+		return;
 
-		cpu_ctx_sched_out(cpuctx, EVENT_ALL);
-		/*
-		 * must not be done before ctxswout due
-		 * to update_cgrp_time_from_cpuctx() in
-		 * ctx_sched_out()
-		 */
-		cpuctx->cgrp = cgrp;
-		/*
-		 * set cgrp before ctxsw in to allow
-		 * perf_cgroup_set_timestamp() in ctx_sched_in()
-		 * to not have to pass task around
-		 */
-		cpu_ctx_sched_in(cpuctx, EVENT_ALL);
+	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+	perf_ctx_disable(&cpuctx->ctx);
 
-		perf_pmu_enable(cpuctx->ctx.pmu);
-		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
-	}
+	ctx_sched_out(&cpuctx->ctx, EVENT_ALL);
+	/*
+	 * must not be done before ctxswout due
+	 * to update_cgrp_time_from_cpuctx() in
+	 * ctx_sched_out()
+	 */
+	cpuctx->cgrp = cgrp;
+	/*
+	 * set cgrp before ctxsw in to allow
+	 * perf_cgroup_set_timestamp() in ctx_sched_in()
+	 * to not have to pass task around
+	 */
+	ctx_sched_in(&cpuctx->ctx, EVENT_ALL);
 
-	local_irq_restore(flags);
+	perf_ctx_enable(&cpuctx->ctx);
+	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
 static int perf_cgroup_ensure_storage(struct perf_event *event,
@@ -888,7 +886,7 @@ static int perf_cgroup_ensure_storage(struct perf_event *event,
 		heap_size++;
 
 	for_each_possible_cpu(cpu) {
-		cpuctx = per_cpu_ptr(event->pmu->pmu_cpu_context, cpu);
+		cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
 		if (heap_size <= cpuctx->heap_size)
 			continue;
 
@@ -972,8 +970,6 @@ perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ct
 		return;
 
 	cpuctx->cgrp = perf_cgroup_from_task(current, ctx);
-	list_add(&cpuctx->cgrp_cpuctx_entry,
-			per_cpu_ptr(&cgrp_cpuctx_list, event->cpu));
 }
 
 static inline void
@@ -994,7 +990,6 @@ perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *c
 		return;
 
 	cpuctx->cgrp = NULL;
-	list_del(&cpuctx->cgrp_cpuctx_entry);
 }
 
 #else /* !CONFIG_CGROUP_PERF */
@@ -1069,34 +1064,30 @@ static void perf_cgroup_switch(struct task_struct *task)
  */
 static enum hrtimer_restart perf_mux_hrtimer_handler(struct hrtimer *hr)
 {
-	struct perf_cpu_context *cpuctx;
+	struct perf_cpu_pmu_context *cpc;
 	bool rotations;
 
 	lockdep_assert_irqs_disabled();
 
-	cpuctx = container_of(hr, struct perf_cpu_context, hrtimer);
-	rotations = perf_rotate_context(cpuctx);
+	cpc = container_of(hr, struct perf_cpu_pmu_context, hrtimer);
+	rotations = perf_rotate_context(cpc);
 
-	raw_spin_lock(&cpuctx->hrtimer_lock);
+	raw_spin_lock(&cpc->hrtimer_lock);
 	if (rotations)
-		hrtimer_forward_now(hr, cpuctx->hrtimer_interval);
+		hrtimer_forward_now(hr, cpc->hrtimer_interval);
 	else
-		cpuctx->hrtimer_active = 0;
-	raw_spin_unlock(&cpuctx->hrtimer_lock);
+		cpc->hrtimer_active = 0;
+	raw_spin_unlock(&cpc->hrtimer_lock);
 
 	return rotations ? HRTIMER_RESTART : HRTIMER_NORESTART;
 }
 
-static void __perf_mux_hrtimer_init(struct perf_cpu_context *cpuctx, int cpu)
+static void __perf_mux_hrtimer_init(struct perf_cpu_pmu_context *cpc, int cpu)
 {
-	struct hrtimer *timer = &cpuctx->hrtimer;
-	struct pmu *pmu = cpuctx->ctx.pmu;
+	struct hrtimer *timer = &cpc->hrtimer;
+	struct pmu *pmu = cpc->epc.pmu;
 	u64 interval;
 
-	/* no multiplexing needed for SW PMU */
-	if (pmu->task_ctx_nr == perf_sw_context)
-		return;
-
 	/*
 	 * check default is sane, if not set then force to
 	 * default interval (1/tick)
@@ -1105,30 +1096,25 @@ static void __perf_mux_hrtimer_init(struct perf_cpu_context *cpuctx, int cpu)
 	if (interval < 1)
 		interval = pmu->hrtimer_interval_ms = PERF_CPU_HRTIMER;
 
-	cpuctx->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * interval);
+	cpc->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * interval);
 
-	raw_spin_lock_init(&cpuctx->hrtimer_lock);
+	raw_spin_lock_init(&cpc->hrtimer_lock);
 	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	timer->function = perf_mux_hrtimer_handler;
 }
 
-static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
+static int perf_mux_hrtimer_restart(struct perf_cpu_pmu_context *cpc)
 {
-	struct hrtimer *timer = &cpuctx->hrtimer;
-	struct pmu *pmu = cpuctx->ctx.pmu;
+	struct hrtimer *timer = &cpc->hrtimer;
 	unsigned long flags;
 
-	/* not for SW PMU */
-	if (pmu->task_ctx_nr == perf_sw_context)
-		return 0;
-
-	raw_spin_lock_irqsave(&cpuctx->hrtimer_lock, flags);
-	if (!cpuctx->hrtimer_active) {
-		cpuctx->hrtimer_active = 1;
-		hrtimer_forward_now(timer, cpuctx->hrtimer_interval);
+	raw_spin_lock_irqsave(&cpc->hrtimer_lock, flags);
+	if (!cpc->hrtimer_active) {
+		cpc->hrtimer_active = 1;
+		hrtimer_forward_now(timer, cpc->hrtimer_interval);
 		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	}
-	raw_spin_unlock_irqrestore(&cpuctx->hrtimer_lock, flags);
+	raw_spin_unlock_irqrestore(&cpc->hrtimer_lock, flags);
 
 	return 0;
 }
@@ -1147,32 +1133,9 @@ void perf_pmu_enable(struct pmu *pmu)
 		pmu->pmu_enable(pmu);
 }
 
-static DEFINE_PER_CPU(struct list_head, active_ctx_list);
-
-/*
- * perf_event_ctx_activate(), perf_event_ctx_deactivate(), and
- * perf_event_task_tick() are fully serialized because they're strictly cpu
- * affine and perf_event_ctx{activate,deactivate} are called with IRQs
- * disabled, while perf_event_task_tick is called from IRQ context.
- */
-static void perf_event_ctx_activate(struct perf_event_context *ctx)
-{
-	struct list_head *head = this_cpu_ptr(&active_ctx_list);
-
-	lockdep_assert_irqs_disabled();
-
-	WARN_ON(!list_empty(&ctx->active_ctx_list));
-
-	list_add(&ctx->active_ctx_list, head);
-}
-
-static void perf_event_ctx_deactivate(struct perf_event_context *ctx)
+static void perf_assert_pmu_disabled(struct pmu *pmu)
 {
-	lockdep_assert_irqs_disabled();
-
-	WARN_ON(list_empty(&ctx->active_ctx_list));
-
-	list_del_init(&ctx->active_ctx_list);
+	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
 }
 
 static void get_ctx(struct perf_event_context *ctx)
@@ -1199,7 +1162,6 @@ static void free_ctx(struct rcu_head *head)
 	struct perf_event_context *ctx;
 
 	ctx = container_of(head, struct perf_event_context, rcu_head);
-	free_task_ctx_data(ctx->pmu, ctx->task_ctx_data);
 	kfree(ctx);
 }
 
@@ -1384,7 +1346,7 @@ static u64 primary_event_id(struct perf_event *event)
  * the context could get moved to another task.
  */
 static struct perf_event_context *
-perf_lock_task_context(struct task_struct *task, int ctxn, unsigned long *flags)
+perf_lock_task_context(struct task_struct *task, unsigned long *flags)
 {
 	struct perf_event_context *ctx;
 
@@ -1400,7 +1362,7 @@ retry:
 	 */
 	local_irq_save(*flags);
 	rcu_read_lock();
-	ctx = rcu_dereference(task->perf_event_ctxp[ctxn]);
+	ctx = rcu_dereference(task->perf_event_ctxp);
 	if (ctx) {
 		/*
 		 * If this context is a clone of another, it might
@@ -1413,7 +1375,7 @@ retry:
 		 * can't get swapped on us any more.
 		 */
 		raw_spin_lock(&ctx->lock);
-		if (ctx != rcu_dereference(task->perf_event_ctxp[ctxn])) {
+		if (ctx != rcu_dereference(task->perf_event_ctxp)) {
 			raw_spin_unlock(&ctx->lock);
 			rcu_read_unlock();
 			local_irq_restore(*flags);
@@ -1440,12 +1402,12 @@ retry:
  * reference count so that the context can't get freed.
  */
 static struct perf_event_context *
-perf_pin_task_context(struct task_struct *task, int ctxn)
+perf_pin_task_context(struct task_struct *task)
 {
 	struct perf_event_context *ctx;
 	unsigned long flags;
 
-	ctx = perf_lock_task_context(task, ctxn, &flags);
+	ctx = perf_lock_task_context(task, &flags);
 	if (ctx) {
 		++ctx->pin_count;
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
@@ -1593,14 +1555,22 @@ static inline struct cgroup *event_cgroup(const struct perf_event *event)
  * which provides ordering when rotating groups for the same CPU.
  */
 static __always_inline int
-perf_event_groups_cmp(const int left_cpu, const struct cgroup *left_cgroup,
-		      const u64 left_group_index, const struct perf_event *right)
+perf_event_groups_cmp(const int left_cpu, const struct pmu *left_pmu,
+		      const struct cgroup *left_cgroup, const u64 left_group_index,
+		      const struct perf_event *right)
 {
 	if (left_cpu < right->cpu)
 		return -1;
 	if (left_cpu > right->cpu)
 		return 1;
 
+	if (left_pmu) {
+		if (left_pmu < right->pmu_ctx->pmu)
+			return -1;
+		if (left_pmu > right->pmu_ctx->pmu)
+			return 1;
+	}
+
 #ifdef CONFIG_CGROUP_PERF
 	{
 		const struct cgroup *right_cgroup = event_cgroup(right);
@@ -1643,12 +1613,13 @@ perf_event_groups_cmp(const int left_cpu, const struct cgroup *left_cgroup,
 static inline bool __group_less(struct rb_node *a, const struct rb_node *b)
 {
 	struct perf_event *e = __node_2_pe(a);
-	return perf_event_groups_cmp(e->cpu, event_cgroup(e), e->group_index,
-				     __node_2_pe(b)) < 0;
+	return perf_event_groups_cmp(e->cpu, e->pmu_ctx->pmu, event_cgroup(e),
+				     e->group_index, __node_2_pe(b)) < 0;
 }
 
 struct __group_key {
 	int cpu;
+	struct pmu *pmu;
 	struct cgroup *cgroup;
 };
 
@@ -1657,14 +1628,25 @@ static inline int __group_cmp(const void *key, const struct rb_node *node)
 	const struct __group_key *a = key;
 	const struct perf_event *b = __node_2_pe(node);
 
-	/* partial/subtree match: @cpu, @cgroup; ignore: @group_index */
-	return perf_event_groups_cmp(a->cpu, a->cgroup, b->group_index, b);
+	/* partial/subtree match: @cpu, @pmu, @cgroup; ignore: @group_index */
+	return perf_event_groups_cmp(a->cpu, a->pmu, a->cgroup, b->group_index, b);
+}
+
+static inline int
+__group_cmp_ignore_cgroup(const void *key, const struct rb_node *node)
+{
+	const struct __group_key *a = key;
+	const struct perf_event *b = __node_2_pe(node);
+
+	/* partial/subtree match: @cpu, @pmu, ignore: @cgroup, @group_index */
+	return perf_event_groups_cmp(a->cpu, a->pmu, event_cgroup(b),
+				     b->group_index, b);
 }
 
 /*
- * Insert @event into @groups' tree; using {@event->cpu, ++@groups->index} for
- * key (see perf_event_groups_less). This places it last inside the CPU
- * subtree.
+ * Insert @event into @groups' tree; using
+ *   {@event->cpu, @event->pmu_ctx->pmu, event_cgroup(@event), ++@groups->index}
+ * as key. This places it last inside the {cpu,pmu,cgroup} subtree.
  */
 static void
 perf_event_groups_insert(struct perf_event_groups *groups,
@@ -1714,14 +1696,15 @@ del_event_from_groups(struct perf_event *event, struct perf_event_context *ctx)
 }
 
 /*
- * Get the leftmost event in the cpu/cgroup subtree.
+ * Get the leftmost event in the {cpu,pmu,cgroup} subtree.
  */
 static struct perf_event *
 perf_event_groups_first(struct perf_event_groups *groups, int cpu,
-			struct cgroup *cgrp)
+			struct pmu *pmu, struct cgroup *cgrp)
 {
 	struct __group_key key = {
 		.cpu = cpu,
+		.pmu = pmu,
 		.cgroup = cgrp,
 	};
 	struct rb_node *node;
@@ -1733,14 +1716,12 @@ perf_event_groups_first(struct perf_event_groups *groups, int cpu,
 	return NULL;
 }
 
-/*
- * Like rb_entry_next_safe() for the @cpu subtree.
- */
 static struct perf_event *
-perf_event_groups_next(struct perf_event *event)
+perf_event_groups_next(struct perf_event *event, struct pmu *pmu)
 {
 	struct __group_key key = {
 		.cpu = event->cpu,
+		.pmu = pmu,
 		.cgroup = event_cgroup(event),
 	};
 	struct rb_node *next;
@@ -1752,6 +1733,10 @@ perf_event_groups_next(struct perf_event *event)
 	return NULL;
 }
 
+#define perf_event_groups_for_cpu_pmu(event, groups, cpu, pmu)		\
+	for (event = perf_event_groups_first(groups, cpu, pmu, NULL);	\
+	     event; event = perf_event_groups_next(event, pmu))
+
 /*
  * Iterate through the whole groups tree.
  */
@@ -1796,6 +1781,7 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 		perf_cgroup_event_enable(event, ctx);
 
 	ctx->generation++;
+	event->pmu_ctx->nr_events++;
 }
 
 /*
@@ -1941,7 +1927,8 @@ static void perf_group_attach(struct perf_event *event)
 	lockdep_assert_held(&event->ctx->lock);
 
 	/*
-	 * We can have double attach due to group movement in perf_event_open.
+	 * We can have double attach due to group movement (move_group) in
+	 * perf_event_open().
 	 */
 	if (event->attach_state & PERF_ATTACH_GROUP)
 		return;
@@ -2006,6 +1993,7 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	}
 
 	ctx->generation++;
+	event->pmu_ctx->nr_events--;
 }
 
 static int
@@ -2022,13 +2010,11 @@ perf_aux_output_match(struct perf_event *event, struct perf_event *aux_event)
 
 static void put_event(struct perf_event *event);
 static void event_sched_out(struct perf_event *event,
-			    struct perf_cpu_context *cpuctx,
 			    struct perf_event_context *ctx);
 
 static void perf_put_aux_event(struct perf_event *event)
 {
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 	struct perf_event *iter;
 
 	/*
@@ -2057,7 +2043,7 @@ static void perf_put_aux_event(struct perf_event *event)
 		 * state so that we don't try to schedule it again. Note
 		 * that perf_event_enable() will clear the ERROR status.
 		 */
-		event_sched_out(iter, cpuctx, ctx);
+		event_sched_out(iter, ctx);
 		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
 	}
 }
@@ -2108,8 +2094,8 @@ static int perf_get_aux_event(struct perf_event *event,
 
 static inline struct list_head *get_event_list(struct perf_event *event)
 {
-	struct perf_event_context *ctx = event->ctx;
-	return event->attr.pinned ? &ctx->pinned_active : &ctx->flexible_active;
+	return event->attr.pinned ? &event->pmu_ctx->pinned_active :
+				    &event->pmu_ctx->flexible_active;
 }
 
 /*
@@ -2120,10 +2106,7 @@ static inline struct list_head *get_event_list(struct perf_event *event)
  */
 static inline void perf_remove_sibling_event(struct perf_event *event)
 {
-	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
-
-	event_sched_out(event, cpuctx, ctx);
+	event_sched_out(event, event->ctx);
 	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
 }
 
@@ -2212,53 +2195,22 @@ static bool is_orphaned_event(struct perf_event *event)
 	return event->state == PERF_EVENT_STATE_DEAD;
 }
 
-static inline int __pmu_filter_match(struct perf_event *event)
-{
-	struct pmu *pmu = event->pmu;
-	return pmu->filter_match ? pmu->filter_match(event) : 1;
-}
-
-/*
- * Check whether we should attempt to schedule an event group based on
- * PMU-specific filtering. An event group can consist of HW and SW events,
- * potentially with a SW leader, so we must check all the filters, to
- * determine whether a group is schedulable:
- */
-static inline int pmu_filter_match(struct perf_event *event)
-{
-	struct perf_event *sibling;
-	unsigned long flags;
-	int ret = 1;
-
-	if (!__pmu_filter_match(event))
-		return 0;
-
-	local_irq_save(flags);
-	for_each_sibling_event(sibling, event) {
-		if (!__pmu_filter_match(sibling)) {
-			ret = 0;
-			break;
-		}
-	}
-	local_irq_restore(flags);
-
-	return ret;
-}
-
 static inline int
 event_filter_match(struct perf_event *event)
 {
 	return (event->cpu == -1 || event->cpu == smp_processor_id()) &&
-	       perf_cgroup_match(event) && pmu_filter_match(event);
+	       perf_cgroup_match(event);
 }
 
 static void
-event_sched_out(struct perf_event *event,
-		  struct perf_cpu_context *cpuctx,
-		  struct perf_event_context *ctx)
+event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 {
+	struct perf_event_pmu_context *epc = event->pmu_ctx;
+	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
 	enum perf_event_state state = PERF_EVENT_STATE_INACTIVE;
 
+	// XXX cpc serialization, probably per-cpu IRQ disabled
+
 	WARN_ON_ONCE(event->ctx != ctx);
 	lockdep_assert_held(&ctx->lock);
 
@@ -2300,38 +2252,32 @@ event_sched_out(struct perf_event *event,
 	perf_event_set_state(event, state);
 
 	if (!is_software_event(event))
-		cpuctx->active_oncpu--;
-	if (!--ctx->nr_active)
-		perf_event_ctx_deactivate(ctx);
+		cpc->active_oncpu--;
 	if (event->attr.freq && event->attr.sample_freq)
 		ctx->nr_freq--;
-	if (event->attr.exclusive || !cpuctx->active_oncpu)
-		cpuctx->exclusive = 0;
+	if (event->attr.exclusive || !cpc->active_oncpu)
+		cpc->exclusive = 0;
 
 	perf_pmu_enable(event->pmu);
 }
 
 static void
-group_sched_out(struct perf_event *group_event,
-		struct perf_cpu_context *cpuctx,
-		struct perf_event_context *ctx)
+group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
 {
 	struct perf_event *event;
 
 	if (group_event->state != PERF_EVENT_STATE_ACTIVE)
 		return;
 
-	perf_pmu_disable(ctx->pmu);
+	perf_assert_pmu_disabled(group_event->pmu_ctx->pmu);
 
-	event_sched_out(group_event, cpuctx, ctx);
+	event_sched_out(group_event, ctx);
 
 	/*
 	 * Schedule out siblings (if any):
 	 */
 	for_each_sibling_event(event, group_event)
-		event_sched_out(event, cpuctx, ctx);
-
-	perf_pmu_enable(ctx->pmu);
+		event_sched_out(event, ctx);
 }
 
 #define DETACH_GROUP	0x01UL
@@ -2349,6 +2295,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   struct perf_event_context *ctx,
 			   void *info)
 {
+	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
 	unsigned long flags = (unsigned long)info;
 
 	if (ctx->is_active & EVENT_TIME) {
@@ -2356,19 +2303,30 @@ __perf_remove_from_context(struct perf_event *event,
 		update_cgrp_time_from_cpuctx(cpuctx, false);
 	}
 
-	event_sched_out(event, cpuctx, ctx);
+	event_sched_out(event, ctx);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
 
+	if (!pmu_ctx->nr_events) {
+		pmu_ctx->rotate_necessary = 0;
+
+		if (ctx->task && ctx->is_active) {
+			struct perf_cpu_pmu_context *cpc;
+
+			cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
+			WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
+			cpc->task_epc = NULL;
+		}
+	}
+
 	if (!ctx->nr_events && ctx->is_active) {
 		if (ctx == &cpuctx->ctx)
 			update_cgrp_time_from_cpuctx(cpuctx, true);
 
 		ctx->is_active = 0;
-		ctx->rotate_necessary = 0;
 		if (ctx->task) {
 			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
 			cpuctx->task_ctx = NULL;
@@ -2398,12 +2356,8 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 	 * event_function_call() user.
 	 */
 	raw_spin_lock_irq(&ctx->lock);
-	/*
-	 * Cgroup events are per-cpu events, and must IPI because of
-	 * cgrp_cpuctx_list.
-	 */
-	if (!ctx->is_active && !is_cgroup_event(event)) {
-		__perf_remove_from_context(event, __get_cpu_context(ctx),
+	if (!ctx->is_active) {
+		__perf_remove_from_context(event, this_cpu_ptr(&perf_cpu_context),
 					   ctx, (void *)flags);
 		raw_spin_unlock_irq(&ctx->lock);
 		return;
@@ -2429,13 +2383,17 @@ static void __perf_event_disable(struct perf_event *event,
 		update_cgrp_time_from_event(event);
 	}
 
+	perf_pmu_disable(event->pmu_ctx->pmu);
+
 	if (event == event->group_leader)
-		group_sched_out(event, cpuctx, ctx);
+		group_sched_out(event, ctx);
 	else
-		event_sched_out(event, cpuctx, ctx);
+		event_sched_out(event, ctx);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
 	perf_cgroup_event_disable(event, ctx);
+
+	perf_pmu_enable(event->pmu_ctx->pmu);
 }
 
 /*
@@ -2497,10 +2455,10 @@ static void perf_log_throttle(struct perf_event *event, int enable);
 static void perf_log_itrace_start(struct perf_event *event);
 
 static int
-event_sched_in(struct perf_event *event,
-		 struct perf_cpu_context *cpuctx,
-		 struct perf_event_context *ctx)
+event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 {
+	struct perf_event_pmu_context *epc = event->pmu_ctx;
+	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
 	int ret = 0;
 
 	WARN_ON_ONCE(event->ctx != ctx);
@@ -2541,14 +2499,12 @@ event_sched_in(struct perf_event *event,
 	}
 
 	if (!is_software_event(event))
-		cpuctx->active_oncpu++;
-	if (!ctx->nr_active++)
-		perf_event_ctx_activate(ctx);
+		cpc->active_oncpu++;
 	if (event->attr.freq && event->attr.sample_freq)
 		ctx->nr_freq++;
 
 	if (event->attr.exclusive)
-		cpuctx->exclusive = 1;
+		cpc->exclusive = 1;
 
 out:
 	perf_pmu_enable(event->pmu);
@@ -2557,26 +2513,24 @@ out:
 }
 
 static int
-group_sched_in(struct perf_event *group_event,
-	       struct perf_cpu_context *cpuctx,
-	       struct perf_event_context *ctx)
+group_sched_in(struct perf_event *group_event, struct perf_event_context *ctx)
 {
 	struct perf_event *event, *partial_group = NULL;
-	struct pmu *pmu = ctx->pmu;
+	struct pmu *pmu = group_event->pmu_ctx->pmu;
 
 	if (group_event->state == PERF_EVENT_STATE_OFF)
 		return 0;
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
 
-	if (event_sched_in(group_event, cpuctx, ctx))
+	if (event_sched_in(group_event, ctx))
 		goto error;
 
 	/*
 	 * Schedule in siblings as one group (if any):
 	 */
 	for_each_sibling_event(event, group_event) {
-		if (event_sched_in(event, cpuctx, ctx)) {
+		if (event_sched_in(event, ctx)) {
 			partial_group = event;
 			goto group_error;
 		}
@@ -2595,9 +2549,9 @@ group_error:
 		if (event == partial_group)
 			break;
 
-		event_sched_out(event, cpuctx, ctx);
+		event_sched_out(event, ctx);
 	}
-	event_sched_out(group_event, cpuctx, ctx);
+	event_sched_out(group_event, ctx);
 
 error:
 	pmu->cancel_txn(pmu);
@@ -2607,10 +2561,11 @@ error:
 /*
  * Work out whether we can put this event group on the CPU now.
  */
-static int group_can_go_on(struct perf_event *event,
-			   struct perf_cpu_context *cpuctx,
-			   int can_add_hw)
+static int group_can_go_on(struct perf_event *event, int can_add_hw)
 {
+	struct perf_event_pmu_context *epc = event->pmu_ctx;
+	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
+
 	/*
 	 * Groups consisting entirely of software events can always go on.
 	 */
@@ -2620,7 +2575,7 @@ static int group_can_go_on(struct perf_event *event,
 	 * If an exclusive group is already on, no other hardware
 	 * events can go on.
 	 */
-	if (cpuctx->exclusive)
+	if (cpc->exclusive)
 		return 0;
 	/*
 	 * If this group is exclusive and there are already
@@ -2642,36 +2597,29 @@ static void add_event_to_ctx(struct perf_event *event,
 	perf_group_attach(event);
 }
 
-static void ctx_sched_out(struct perf_event_context *ctx,
-			  struct perf_cpu_context *cpuctx,
-			  enum event_type_t event_type);
-static void
-ctx_sched_in(struct perf_event_context *ctx,
-	     struct perf_cpu_context *cpuctx,
-	     enum event_type_t event_type);
-
-static void task_ctx_sched_out(struct perf_cpu_context *cpuctx,
-			       struct perf_event_context *ctx,
-			       enum event_type_t event_type)
+static void task_ctx_sched_out(struct perf_event_context *ctx,
+				enum event_type_t event_type)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+
 	if (!cpuctx->task_ctx)
 		return;
 
 	if (WARN_ON_ONCE(ctx != cpuctx->task_ctx))
 		return;
 
-	ctx_sched_out(ctx, cpuctx, event_type);
+	ctx_sched_out(ctx, event_type);
 }
 
 static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
 				struct perf_event_context *ctx)
 {
-	cpu_ctx_sched_in(cpuctx, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, EVENT_PINNED);
 	if (ctx)
-		ctx_sched_in(ctx, cpuctx, EVENT_PINNED);
-	cpu_ctx_sched_in(cpuctx, EVENT_FLEXIBLE);
+		 ctx_sched_in(ctx, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, EVENT_FLEXIBLE);
 	if (ctx)
-		ctx_sched_in(ctx, cpuctx, EVENT_FLEXIBLE);
+		 ctx_sched_in(ctx, EVENT_FLEXIBLE);
 }
 
 /*
@@ -2689,11 +2637,15 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
  * event_type is a bit mask of the types of events involved. For CPU events,
  * event_type is only either EVENT_PINNED or EVENT_FLEXIBLE.
  */
+/*
+ * XXX: ctx_resched() reschedule entire perf_event_context while adding new
+ * event to the context or enabling existing event in the context. We can
+ * probably optimize it by rescheduling only affected pmu_ctx.
+ */
 static void ctx_resched(struct perf_cpu_context *cpuctx,
 			struct perf_event_context *task_ctx,
 			enum event_type_t event_type)
 {
-	enum event_type_t ctx_event_type;
 	bool cpu_event = !!(event_type & EVENT_CPU);
 
 	/*
@@ -2703,11 +2655,13 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	if (event_type & EVENT_PINNED)
 		event_type |= EVENT_FLEXIBLE;
 
-	ctx_event_type = event_type & EVENT_ALL;
+	event_type &= EVENT_ALL;
 
-	perf_pmu_disable(cpuctx->ctx.pmu);
-	if (task_ctx)
-		task_ctx_sched_out(cpuctx, task_ctx, event_type);
+	perf_ctx_disable(&cpuctx->ctx);
+	if (task_ctx) {
+		perf_ctx_disable(task_ctx);
+		task_ctx_sched_out(task_ctx, event_type);
+	}
 
 	/*
 	 * Decide which cpu ctx groups to schedule out based on the types
@@ -2717,17 +2671,20 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	 *  - otherwise, do nothing more.
 	 */
 	if (cpu_event)
-		cpu_ctx_sched_out(cpuctx, ctx_event_type);
-	else if (ctx_event_type & EVENT_PINNED)
-		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
+		ctx_sched_out(&cpuctx->ctx, event_type);
+	else if (event_type & EVENT_PINNED)
+		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
 
 	perf_event_sched_in(cpuctx, task_ctx);
-	perf_pmu_enable(cpuctx->ctx.pmu);
+
+	perf_ctx_enable(&cpuctx->ctx);
+	if (task_ctx)
+		perf_ctx_enable(task_ctx);
 }
 
 void perf_pmu_resched(struct pmu *pmu)
 {
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 
 	perf_ctx_lock(cpuctx, task_ctx);
@@ -2745,7 +2702,7 @@ static int  __perf_install_in_context(void *info)
 {
 	struct perf_event *event = info;
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 	bool reprogram = true;
 	int ret = 0;
@@ -2787,7 +2744,7 @@ static int  __perf_install_in_context(void *info)
 #endif
 
 	if (reprogram) {
-		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
+		ctx_sched_out(ctx, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
 		ctx_resched(cpuctx, task_ctx, get_event_type(event));
 	} else {
@@ -2820,7 +2777,7 @@ perf_install_in_context(struct perf_event_context *ctx,
 	WARN_ON_ONCE(!exclusive_event_installable(event, ctx));
 
 	if (event->cpu != -1)
-		event->cpu = cpu;
+		WARN_ON_ONCE(event->cpu != cpu);
 
 	/*
 	 * Ensures that if we can observe event->ctx, both the event and ctx
@@ -2832,8 +2789,6 @@ perf_install_in_context(struct perf_event_context *ctx,
 	 * perf_event_attr::disabled events will not run and can be initialized
 	 * without IPI. Except when this is the first event for the context, in
 	 * that case we need the magic of the IPI to set ctx->is_active.
-	 * Similarly, cgroup events for the context also needs the IPI to
-	 * manipulate the cgrp_cpuctx_list.
 	 *
 	 * The IOC_ENABLE that is sure to follow the creation of a disabled
 	 * event will issue the IPI and reprogram the hardware.
@@ -2935,7 +2890,7 @@ static void __perf_event_enable(struct perf_event *event,
 		return;
 
 	if (ctx->is_active)
-		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
+		ctx_sched_out(ctx, EVENT_TIME);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 	perf_cgroup_event_enable(event, ctx);
@@ -2944,7 +2899,7 @@ static void __perf_event_enable(struct perf_event *event,
 		return;
 
 	if (!event_filter_match(event)) {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME);
+		ctx_sched_in(ctx, EVENT_TIME);
 		return;
 	}
 
@@ -2953,7 +2908,7 @@ static void __perf_event_enable(struct perf_event *event,
 	 * then don't put it on unless the group is on.
 	 */
 	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME);
+		ctx_sched_in(ctx, EVENT_TIME);
 		return;
 	}
 
@@ -3222,11 +3177,52 @@ out:
 	return err;
 }
 
-static void ctx_sched_out(struct perf_event_context *ctx,
-			  struct perf_cpu_context *cpuctx,
-			  enum event_type_t event_type)
+static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
+				enum event_type_t event_type)
 {
+	struct perf_event_context *ctx = pmu_ctx->ctx;
 	struct perf_event *event, *tmp;
+	struct pmu *pmu = pmu_ctx->pmu;
+
+	if (ctx->task && !ctx->is_active) {
+		struct perf_cpu_pmu_context *cpc;
+
+		cpc = this_cpu_ptr(pmu->cpu_pmu_context);
+		WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
+		cpc->task_epc = NULL;
+	}
+
+	if (!event_type)
+		return;
+
+	perf_pmu_disable(pmu);
+	if (event_type & EVENT_PINNED) {
+		list_for_each_entry_safe(event, tmp,
+					 &pmu_ctx->pinned_active,
+					 active_list)
+			group_sched_out(event, ctx);
+	}
+
+	if (event_type & EVENT_FLEXIBLE) {
+		list_for_each_entry_safe(event, tmp,
+					 &pmu_ctx->flexible_active,
+					 active_list)
+			group_sched_out(event, ctx);
+		/*
+		 * Since we cleared EVENT_FLEXIBLE, also clear
+		 * rotate_necessary, is will be reset by
+		 * ctx_flexible_sched_in() when needed.
+		 */
+		pmu_ctx->rotate_necessary = 0;
+	}
+	perf_pmu_enable(pmu);
+}
+
+static void
+ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
+{
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
 
 	lockdep_assert_held(&ctx->lock);
@@ -3274,27 +3270,8 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 
 	is_active ^= ctx->is_active; /* changed bits */
 
-	if (!ctx->nr_active || !(is_active & EVENT_ALL))
-		return;
-
-	perf_pmu_disable(ctx->pmu);
-	if (is_active & EVENT_PINNED) {
-		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
-			group_sched_out(event, cpuctx, ctx);
-	}
-
-	if (is_active & EVENT_FLEXIBLE) {
-		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list)
-			group_sched_out(event, cpuctx, ctx);
-
-		/*
-		 * Since we cleared EVENT_FLEXIBLE, also clear
-		 * rotate_necessary, is will be reset by
-		 * ctx_flexible_sched_in() when needed.
-		 */
-		ctx->rotate_necessary = 0;
-	}
-	perf_pmu_enable(ctx->pmu);
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
+		__pmu_ctx_sched_out(pmu_ctx, is_active);
 }
 
 /*
@@ -3399,26 +3376,68 @@ static void perf_event_sync_stat(struct perf_event_context *ctx,
 	}
 }
 
-static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
-					 struct task_struct *next)
+#define double_list_for_each_entry(pos1, pos2, head1, head2, member)	\
+	for (pos1 = list_first_entry(head1, typeof(*pos1), member),	\
+	     pos2 = list_first_entry(head2, typeof(*pos2), member);	\
+	     !list_entry_is_head(pos1, head1, member) &&		\
+	     !list_entry_is_head(pos2, head2, member);			\
+	     pos1 = list_next_entry(pos1, member),			\
+	     pos2 = list_next_entry(pos2, member))
+
+static void perf_event_swap_task_ctx_data(struct perf_event_context *prev_ctx,
+					  struct perf_event_context *next_ctx)
+{
+	struct perf_event_pmu_context *prev_epc, *next_epc;
+
+	if (!prev_ctx->nr_task_data)
+		return;
+
+	double_list_for_each_entry(prev_epc, next_epc,
+				   &prev_ctx->pmu_ctx_list, &next_ctx->pmu_ctx_list,
+				   pmu_ctx_entry) {
+
+		if (WARN_ON_ONCE(prev_epc->pmu != next_epc->pmu))
+			continue;
+
+		/*
+		 * PMU specific parts of task perf context can require
+		 * additional synchronization. As an example of such
+		 * synchronization see implementation details of Intel
+		 * LBR call stack data profiling;
+		 */
+		if (prev_epc->pmu->swap_task_ctx)
+			prev_epc->pmu->swap_task_ctx(prev_epc, next_epc);
+		else
+			swap(prev_epc->task_ctx_data, next_epc->task_ctx_data);
+	}
+}
+
+static void perf_ctx_sched_task_cb(struct perf_event_context *ctx, bool sched_in)
+{
+	struct perf_event_pmu_context *pmu_ctx;
+	struct perf_cpu_pmu_context *cpc;
+
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
+
+		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
+			pmu_ctx->pmu->sched_task(pmu_ctx, sched_in);
+	}
+}
+
+static void
+perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 {
-	struct perf_event_context *ctx = task->perf_event_ctxp[ctxn];
+	struct perf_event_context *ctx = task->perf_event_ctxp;
 	struct perf_event_context *next_ctx;
 	struct perf_event_context *parent, *next_parent;
-	struct perf_cpu_context *cpuctx;
 	int do_switch = 1;
-	struct pmu *pmu;
 
 	if (likely(!ctx))
 		return;
 
-	pmu = ctx->pmu;
-	cpuctx = __get_cpu_context(ctx);
-	if (!cpuctx->task_ctx)
-		return;
-
 	rcu_read_lock();
-	next_ctx = next->perf_event_ctxp[ctxn];
+	next_ctx = rcu_dereference(next->perf_event_ctxp);
 	if (!next_ctx)
 		goto unlock;
 
@@ -3443,7 +3462,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
 		if (context_equiv(ctx, next_ctx)) {
 
-			perf_pmu_disable(pmu);
+			perf_ctx_disable(ctx);
 
 			/* PMIs are disabled; ctx->nr_pending is stable. */
 			if (local_read(&ctx->nr_pending) ||
@@ -3460,21 +3479,10 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 			WRITE_ONCE(ctx->task, next);
 			WRITE_ONCE(next_ctx->task, task);
 
-			if (cpuctx->sched_cb_usage && pmu->sched_task)
-				pmu->sched_task(ctx, false);
-
-			/*
-			 * PMU specific parts of task perf context can require
-			 * additional synchronization. As an example of such
-			 * synchronization see implementation details of Intel
-			 * LBR call stack data profiling;
-			 */
-			if (pmu->swap_task_ctx)
-				pmu->swap_task_ctx(ctx, next_ctx);
-			else
-				swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
+			perf_ctx_sched_task_cb(ctx, false);
+			perf_event_swap_task_ctx_data(ctx, next_ctx);
 
-			perf_pmu_enable(pmu);
+			perf_ctx_enable(ctx);
 
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
@@ -3483,8 +3491,8 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 			 * since those values are always verified under
 			 * ctx->lock which we're now holding.
 			 */
-			RCU_INIT_POINTER(task->perf_event_ctxp[ctxn], next_ctx);
-			RCU_INIT_POINTER(next->perf_event_ctxp[ctxn], ctx);
+			RCU_INIT_POINTER(task->perf_event_ctxp, next_ctx);
+			RCU_INIT_POINTER(next->perf_event_ctxp, ctx);
 
 			do_switch = 0;
 
@@ -3498,38 +3506,40 @@ unlock:
 
 	if (do_switch) {
 		raw_spin_lock(&ctx->lock);
-		perf_pmu_disable(pmu);
+		perf_ctx_disable(ctx);
 
 inside_switch:
-		if (cpuctx->sched_cb_usage && pmu->sched_task)
-			pmu->sched_task(ctx, false);
-		task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
+		perf_ctx_sched_task_cb(ctx, false);
+		task_ctx_sched_out(ctx, EVENT_ALL);
 
-		perf_pmu_enable(pmu);
+		perf_ctx_enable(ctx);
 		raw_spin_unlock(&ctx->lock);
 	}
 }
 
 static DEFINE_PER_CPU(struct list_head, sched_cb_list);
+static DEFINE_PER_CPU(int, perf_sched_cb_usages);
 
 void perf_sched_cb_dec(struct pmu *pmu)
 {
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(pmu->cpu_pmu_context);
 
 	this_cpu_dec(perf_sched_cb_usages);
+	barrier();
 
-	if (!--cpuctx->sched_cb_usage)
-		list_del(&cpuctx->sched_cb_entry);
+	if (!--cpc->sched_cb_usage)
+		list_del(&cpc->sched_cb_entry);
 }
 
 
 void perf_sched_cb_inc(struct pmu *pmu)
 {
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(pmu->cpu_pmu_context);
 
-	if (!cpuctx->sched_cb_usage++)
-		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
+	if (!cpc->sched_cb_usage++)
+		list_add(&cpc->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
 
+	barrier();
 	this_cpu_inc(perf_sched_cb_usages);
 }
 
@@ -3541,19 +3551,21 @@ void perf_sched_cb_inc(struct pmu *pmu)
  * PEBS requires this to provide PID/TID information. This requires we flush
  * all queued PEBS records before we context switch to a new task.
  */
-static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx, bool sched_in)
+static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc, bool sched_in)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct pmu *pmu;
 
-	pmu = cpuctx->ctx.pmu; /* software PMUs will not have sched_task */
+	pmu = cpc->epc.pmu;
 
+	/* software PMUs will not have sched_task */
 	if (WARN_ON_ONCE(!pmu->sched_task))
 		return;
 
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(pmu);
 
-	pmu->sched_task(cpuctx->task_ctx, sched_in);
+	pmu->sched_task(cpc->task_epc, sched_in);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -3563,26 +3575,20 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 				struct task_struct *next,
 				bool sched_in)
 {
-	struct perf_cpu_context *cpuctx;
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_cpu_pmu_context *cpc;
 
-	if (prev == next)
+	/* cpuctx->task_ctx will be handled in perf_event_context_sched_in/out */
+	if (prev == next || cpuctx->task_ctx)
 		return;
 
-	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
-		/* will be handled in perf_event_context_sched_in/out */
-		if (cpuctx->task_ctx)
-			continue;
-
-		__perf_pmu_sched_task(cpuctx, sched_in);
-	}
+	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
+		__perf_pmu_sched_task(cpc, sched_in);
 }
 
 static void perf_event_switch(struct task_struct *task,
 			      struct task_struct *next_prev, bool sched_in);
 
-#define for_each_task_context_nr(ctxn)					\
-	for ((ctxn) = 0; (ctxn) < perf_nr_task_contexts; (ctxn)++)
-
 /*
  * Called from scheduler to remove the events of the current task,
  * with interrupts disabled.
@@ -3597,16 +3603,13 @@ static void perf_event_switch(struct task_struct *task,
 void __perf_event_task_sched_out(struct task_struct *task,
 				 struct task_struct *next)
 {
-	int ctxn;
-
 	if (__this_cpu_read(perf_sched_cb_usages))
 		perf_pmu_sched_task(task, next, false);
 
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, next, false);
 
-	for_each_task_context_nr(ctxn)
-		perf_event_context_sched_out(task, ctxn, next);
+	perf_event_context_sched_out(task, next);
 
 	/*
 	 * if cgroup events exist on this CPU, then we need
@@ -3617,15 +3620,6 @@ void __perf_event_task_sched_out(struct task_struct *task,
 		perf_cgroup_switch(next);
 }
 
-/*
- * Called with IRQs disabled
- */
-static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
-			      enum event_type_t event_type)
-{
-	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
-}
-
 static bool perf_less_group_idx(const void *l, const void *r)
 {
 	const struct perf_event *le = *(const struct perf_event **)l;
@@ -3657,21 +3651,39 @@ static void __heap_add(struct min_heap *heap, struct perf_event *event)
 	}
 }
 
-static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
+static void __link_epc(struct perf_event_pmu_context *pmu_ctx)
+{
+	struct perf_cpu_pmu_context *cpc;
+
+	if (!pmu_ctx->ctx->task)
+		return;
+
+	cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
+	WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
+	cpc->task_epc = pmu_ctx;
+}
+
+static noinline int visit_groups_merge(struct perf_event_context *ctx,
 				struct perf_event_groups *groups, int cpu,
+				struct pmu *pmu,
 				int (*func)(struct perf_event *, void *),
 				void *data)
 {
 #ifdef CONFIG_CGROUP_PERF
 	struct cgroup_subsys_state *css = NULL;
 #endif
+	struct perf_cpu_context *cpuctx = NULL;
 	/* Space for per CPU and/or any CPU event iterators. */
 	struct perf_event *itrs[2];
 	struct min_heap event_heap;
 	struct perf_event **evt;
 	int ret;
 
-	if (cpuctx) {
+	if (pmu->filter && pmu->filter(pmu, cpu))
+		return 0;
+
+	if (!ctx->task) {
+		cpuctx = this_cpu_ptr(&perf_cpu_context);
 		event_heap = (struct min_heap){
 			.data = cpuctx->heap,
 			.nr = 0,
@@ -3691,17 +3703,22 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 			.size = ARRAY_SIZE(itrs),
 		};
 		/* Events not within a CPU context may be on any CPU. */
-		__heap_add(&event_heap, perf_event_groups_first(groups, -1, NULL));
+		__heap_add(&event_heap, perf_event_groups_first(groups, -1, pmu, NULL));
 	}
 	evt = event_heap.data;
 
-	__heap_add(&event_heap, perf_event_groups_first(groups, cpu, NULL));
+	__heap_add(&event_heap, perf_event_groups_first(groups, cpu, pmu, NULL));
 
 #ifdef CONFIG_CGROUP_PERF
 	for (; css; css = css->parent)
-		__heap_add(&event_heap, perf_event_groups_first(groups, cpu, css->cgroup));
+		__heap_add(&event_heap, perf_event_groups_first(groups, cpu, pmu, css->cgroup));
 #endif
 
+	if (event_heap.nr) {
+		__link_epc((*evt)->pmu_ctx);
+		perf_assert_pmu_disabled((*evt)->pmu_ctx->pmu);
+	}
+
 	min_heapify_all(&event_heap, &perf_min_heap);
 
 	while (event_heap.nr) {
@@ -3709,7 +3726,7 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 		if (ret)
 			return ret;
 
-		*evt = perf_event_groups_next(*evt);
+		*evt = perf_event_groups_next(*evt, pmu);
 		if (*evt)
 			min_heapify(&event_heap, 0, &perf_min_heap);
 		else
@@ -3751,7 +3768,6 @@ static inline void group_update_userpage(struct perf_event *group_event)
 static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 	int *can_add_hw = data;
 
 	if (event->state <= PERF_EVENT_STATE_OFF)
@@ -3760,8 +3776,8 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	if (!event_filter_match(event))
 		return 0;
 
-	if (group_can_go_on(event, cpuctx, *can_add_hw)) {
-		if (!group_sched_in(event, cpuctx, ctx))
+	if (group_can_go_on(event, *can_add_hw)) {
+		if (!group_sched_in(event, ctx))
 			list_add_tail(&event->active_list, get_event_list(event));
 	}
 
@@ -3771,8 +3787,11 @@ static int merge_sched_in(struct perf_event *event, void *data)
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
 		} else {
-			ctx->rotate_necessary = 1;
-			perf_mux_hrtimer_restart(cpuctx);
+			struct perf_cpu_pmu_context *cpc;
+
+			event->pmu_ctx->rotate_necessary = 1;
+			cpc = this_cpu_ptr(event->pmu_ctx->pmu->cpu_pmu_context);
+			perf_mux_hrtimer_restart(cpc);
 			group_update_userpage(event);
 		}
 	}
@@ -3780,39 +3799,53 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	return 0;
 }
 
-static void
-ctx_pinned_sched_in(struct perf_event_context *ctx,
-		    struct perf_cpu_context *cpuctx)
+static void ctx_pinned_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
 {
+	struct perf_event_pmu_context *pmu_ctx;
 	int can_add_hw = 1;
 
-	if (ctx != &cpuctx->ctx)
-		cpuctx = NULL;
-
-	visit_groups_merge(cpuctx, &ctx->pinned_groups,
-			   smp_processor_id(),
-			   merge_sched_in, &can_add_hw);
+	if (pmu) {
+		visit_groups_merge(ctx, &ctx->pinned_groups,
+				   smp_processor_id(), pmu,
+				   merge_sched_in, &can_add_hw);
+	} else {
+		list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+			can_add_hw = 1;
+			visit_groups_merge(ctx, &ctx->pinned_groups,
+					   smp_processor_id(), pmu_ctx->pmu,
+					   merge_sched_in, &can_add_hw);
+		}
+	}
 }
 
-static void
-ctx_flexible_sched_in(struct perf_event_context *ctx,
-		      struct perf_cpu_context *cpuctx)
+static void ctx_flexible_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
 {
+	struct perf_event_pmu_context *pmu_ctx;
 	int can_add_hw = 1;
 
-	if (ctx != &cpuctx->ctx)
-		cpuctx = NULL;
+	if (pmu) {
+		visit_groups_merge(ctx, &ctx->flexible_groups,
+				   smp_processor_id(), pmu,
+				   merge_sched_in, &can_add_hw);
+	} else {
+		list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+			can_add_hw = 1;
+			visit_groups_merge(ctx, &ctx->flexible_groups,
+					   smp_processor_id(), pmu_ctx->pmu,
+					   merge_sched_in, &can_add_hw);
+		}
+	}
+}
 
-	visit_groups_merge(cpuctx, &ctx->flexible_groups,
-			   smp_processor_id(),
-			   merge_sched_in, &can_add_hw);
+static void __pmu_ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
+{
+	ctx_flexible_sched_in(ctx, pmu);
 }
 
 static void
-ctx_sched_in(struct perf_event_context *ctx,
-	     struct perf_cpu_context *cpuctx,
-	     enum event_type_t event_type)
+ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	int is_active = ctx->is_active;
 
 	lockdep_assert_held(&ctx->lock);
@@ -3846,39 +3879,32 @@ ctx_sched_in(struct perf_event_context *ctx,
 	 * in order to give them the best chance of going on.
 	 */
 	if (is_active & EVENT_PINNED)
-		ctx_pinned_sched_in(ctx, cpuctx);
+		ctx_pinned_sched_in(ctx, NULL);
 
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE)
-		ctx_flexible_sched_in(ctx, cpuctx);
+		ctx_flexible_sched_in(ctx, NULL);
 }
 
-static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
-			     enum event_type_t event_type)
+static void perf_event_context_sched_in(struct task_struct *task)
 {
-	struct perf_event_context *ctx = &cpuctx->ctx;
-
-	ctx_sched_in(ctx, cpuctx, event_type);
-}
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_event_context *ctx;
 
-static void perf_event_context_sched_in(struct perf_event_context *ctx,
-					struct task_struct *task)
-{
-	struct perf_cpu_context *cpuctx;
-	struct pmu *pmu;
+	rcu_read_lock();
+	ctx = rcu_dereference(task->perf_event_ctxp);
+	if (!ctx)
+		goto rcu_unlock;
 
-	cpuctx = __get_cpu_context(ctx);
+	if (cpuctx->task_ctx == ctx) {
+		perf_ctx_lock(cpuctx, ctx);
+		perf_ctx_disable(ctx);
 
-	/*
-	 * HACK: for HETEROGENEOUS the task context might have switched to a
-	 * different PMU, force (re)set the context,
-	 */
-	pmu = ctx->pmu = cpuctx->ctx.pmu;
+		perf_ctx_sched_task_cb(ctx, true);
 
-	if (cpuctx->task_ctx == ctx) {
-		if (cpuctx->sched_cb_usage)
-			__perf_pmu_sched_task(cpuctx, true);
-		return;
+		perf_ctx_enable(ctx);
+		perf_ctx_unlock(cpuctx, ctx);
+		goto rcu_unlock;
 	}
 
 	perf_ctx_lock(cpuctx, ctx);
@@ -3889,7 +3915,7 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 	if (!ctx->nr_events)
 		goto unlock;
 
-	perf_pmu_disable(pmu);
+	perf_ctx_disable(ctx);
 	/*
 	 * We want to keep the following priority order:
 	 * cpu pinned (that don't need to move), task pinned,
@@ -3898,17 +3924,24 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 	 * However, if task's ctx is not carrying any pinned
 	 * events, no need to flip the cpuctx's events around.
 	 */
-	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
-		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
+	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
+		perf_ctx_disable(&cpuctx->ctx);
+		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
+	}
+
 	perf_event_sched_in(cpuctx, ctx);
 
-	if (cpuctx->sched_cb_usage && pmu->sched_task)
-		pmu->sched_task(cpuctx->task_ctx, true);
+	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
 
-	perf_pmu_enable(pmu);
+	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
+		perf_ctx_enable(&cpuctx->ctx);
+
+	perf_ctx_enable(ctx);
 
 unlock:
 	perf_ctx_unlock(cpuctx, ctx);
+rcu_unlock:
+	rcu_read_unlock();
 }
 
 /*
@@ -3925,16 +3958,7 @@ unlock:
 void __perf_event_task_sched_in(struct task_struct *prev,
 				struct task_struct *task)
 {
-	struct perf_event_context *ctx;
-	int ctxn;
-
-	for_each_task_context_nr(ctxn) {
-		ctx = task->perf_event_ctxp[ctxn];
-		if (likely(!ctx))
-			continue;
-
-		perf_event_context_sched_in(ctx, task);
-	}
+	perf_event_context_sched_in(task);
 
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, prev, true);
@@ -4053,8 +4077,8 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
  * events. At the same time, make sure, having freq events does not change
  * the rate of unthrottling as that would introduce bias.
  */
-static void perf_adjust_freq_unthr_context(struct perf_event_context *ctx,
-					   int needs_unthr)
+static void
+perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 {
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
@@ -4066,16 +4090,16 @@ static void perf_adjust_freq_unthr_context(struct perf_event_context *ctx,
 	 * - context have events in frequency mode (needs freq adjust)
 	 * - there are events to unthrottle on this cpu
 	 */
-	if (!(ctx->nr_freq || needs_unthr))
+	if (!(ctx->nr_freq || unthrottle))
 		return;
 
 	raw_spin_lock(&ctx->lock);
-	perf_pmu_disable(ctx->pmu);
 
 	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
 			continue;
 
+		// XXX use visit thingy to avoid the -1,cpu match
 		if (!event_filter_match(event))
 			continue;
 
@@ -4116,7 +4140,6 @@ static void perf_adjust_freq_unthr_context(struct perf_event_context *ctx,
 		perf_pmu_enable(event->pmu);
 	}
 
-	perf_pmu_enable(ctx->pmu);
 	raw_spin_unlock(&ctx->lock);
 }
 
@@ -4138,72 +4161,111 @@ static void rotate_ctx(struct perf_event_context *ctx, struct perf_event *event)
 
 /* pick an event from the flexible_groups to rotate */
 static inline struct perf_event *
-ctx_event_to_rotate(struct perf_event_context *ctx)
+ctx_event_to_rotate(struct perf_event_pmu_context *pmu_ctx)
 {
 	struct perf_event *event;
+	struct rb_node *node;
+	struct rb_root *tree;
+	struct __group_key key = {
+		.pmu = pmu_ctx->pmu,
+	};
 
 	/* pick the first active flexible event */
-	event = list_first_entry_or_null(&ctx->flexible_active,
+	event = list_first_entry_or_null(&pmu_ctx->flexible_active,
 					 struct perf_event, active_list);
+	if (event)
+		goto out;
 
 	/* if no active flexible event, pick the first event */
-	if (!event) {
-		event = rb_entry_safe(rb_first(&ctx->flexible_groups.tree),
-				      typeof(*event), group_node);
+	tree = &pmu_ctx->ctx->flexible_groups.tree;
+
+	if (!pmu_ctx->ctx->task) {
+		key.cpu = smp_processor_id();
+
+		node = rb_find_first(&key, tree, __group_cmp_ignore_cgroup);
+		if (node)
+			event = __node_2_pe(node);
+		goto out;
 	}
 
-	/*
+	key.cpu = -1;
+	node = rb_find_first(&key, tree, __group_cmp_ignore_cgroup);
+	if (node) {
+		event = __node_2_pe(node);
+		goto out;
+	}
+
+	key.cpu = smp_processor_id();
+	node = rb_find_first(&key, tree, __group_cmp_ignore_cgroup);
+	if (node)
+		event = __node_2_pe(node);
+
+out:
+	/*
 	 * Unconditionally clear rotate_necessary; if ctx_flexible_sched_in()
 	 * finds there are unschedulable events, it will set it again.
 	 */
-	ctx->rotate_necessary = 0;
+	pmu_ctx->rotate_necessary = 0;
 
 	return event;
 }
 
-static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
+static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_event_pmu_context *cpu_epc, *task_epc = NULL;
 	struct perf_event *cpu_event = NULL, *task_event = NULL;
 	struct perf_event_context *task_ctx = NULL;
 	int cpu_rotate, task_rotate;
+	struct pmu *pmu;
 
 	/*
 	 * Since we run this from IRQ context, nobody can install new
 	 * events, thus the event count values are stable.
 	 */
 
-	cpu_rotate = cpuctx->ctx.rotate_necessary;
+	cpu_epc = &cpc->epc;
+	pmu = cpu_epc->pmu;
+	task_epc = cpc->task_epc;
+
+	cpu_rotate = cpu_epc->rotate_necessary;
 	task_ctx = cpuctx->task_ctx;
-	task_rotate = task_ctx ? task_ctx->rotate_necessary : 0;
+	task_rotate = task_epc ? task_epc->rotate_necessary : 0;
 
 	if (!(cpu_rotate || task_rotate))
 		return false;
 
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
-	perf_pmu_disable(cpuctx->ctx.pmu);
+	perf_pmu_disable(pmu);
 
 	if (task_rotate)
-		task_event = ctx_event_to_rotate(task_ctx);
+		task_event = ctx_event_to_rotate(task_epc);
 	if (cpu_rotate)
-		cpu_event = ctx_event_to_rotate(&cpuctx->ctx);
+		cpu_event = ctx_event_to_rotate(cpu_epc);
 
 	/*
 	 * As per the order given at ctx_resched() first 'pop' task flexible
 	 * and then, if needed CPU flexible.
 	 */
-	if (task_event || (task_ctx && cpu_event))
-		ctx_sched_out(task_ctx, cpuctx, EVENT_FLEXIBLE);
-	if (cpu_event)
-		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
+	if (task_event || (task_epc && cpu_event)) {
+		update_context_time(task_epc->ctx);
+		__pmu_ctx_sched_out(task_epc, EVENT_FLEXIBLE);
+	}
 
-	if (task_event)
-		rotate_ctx(task_ctx, task_event);
-	if (cpu_event)
+	if (cpu_event) {
+		update_context_time(&cpuctx->ctx);
+		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
 		rotate_ctx(&cpuctx->ctx, cpu_event);
+		__pmu_ctx_sched_in(&cpuctx->ctx, pmu);
+	}
 
-	perf_event_sched_in(cpuctx, task_ctx);
+	if (task_event)
+		rotate_ctx(task_epc->ctx, task_event);
+
+	if (task_event || (task_epc && cpu_event))
+		__pmu_ctx_sched_in(task_epc->ctx, pmu);
 
-	perf_pmu_enable(cpuctx->ctx.pmu);
+	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 
 	return true;
@@ -4211,8 +4273,8 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
 
 void perf_event_task_tick(void)
 {
-	struct list_head *head = this_cpu_ptr(&active_ctx_list);
-	struct perf_event_context *ctx, *tmp;
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_event_context *ctx;
 	int throttled;
 
 	lockdep_assert_irqs_disabled();
@@ -4221,8 +4283,13 @@ void perf_event_task_tick(void)
 	throttled = __this_cpu_xchg(perf_throttled_count, 0);
 	tick_dep_clear_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
 
-	list_for_each_entry_safe(ctx, tmp, head, active_ctx_list)
-		perf_adjust_freq_unthr_context(ctx, throttled);
+	perf_adjust_freq_unthr_context(&cpuctx->ctx, !!throttled);
+
+	rcu_read_lock();
+	ctx = rcu_dereference(current->perf_event_ctxp);
+	if (ctx)
+		perf_adjust_freq_unthr_context(ctx, !!throttled);
+	rcu_read_unlock();
 }
 
 static int event_enable_on_exec(struct perf_event *event,
@@ -4244,9 +4311,9 @@ static int event_enable_on_exec(struct perf_event *event,
  * Enable all of a task's events that have been marked enable-on-exec.
  * This expects task == current.
  */
-static void perf_event_enable_on_exec(int ctxn)
+static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 {
-	struct perf_event_context *ctx, *clone_ctx = NULL;
+	struct perf_event_context *clone_ctx = NULL;
 	enum event_type_t event_type = 0;
 	struct perf_cpu_context *cpuctx;
 	struct perf_event *event;
@@ -4254,13 +4321,16 @@ static void perf_event_enable_on_exec(int ctxn)
 	int enabled = 0;
 
 	local_irq_save(flags);
-	ctx = current->perf_event_ctxp[ctxn];
-	if (!ctx || !ctx->nr_events)
+	if (WARN_ON_ONCE(current->perf_event_ctxp != ctx))
+		goto out;
+
+	if (!ctx->nr_events)
 		goto out;
 
-	cpuctx = __get_cpu_context(ctx);
+	cpuctx = this_cpu_ptr(&perf_cpu_context);
 	perf_ctx_lock(cpuctx, ctx);
-	ctx_sched_out(ctx, cpuctx, EVENT_TIME);
+	ctx_sched_out(ctx, EVENT_TIME);
+
 	list_for_each_entry(event, &ctx->event_list, event_entry) {
 		enabled |= event_enable_on_exec(event, ctx);
 		event_type |= get_event_type(event);
@@ -4273,7 +4343,7 @@ static void perf_event_enable_on_exec(int ctxn)
 		clone_ctx = unclone_ctx(ctx);
 		ctx_resched(cpuctx, ctx, event_type);
 	} else {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME);
+		ctx_sched_in(ctx, EVENT_TIME);
 	}
 	perf_ctx_unlock(cpuctx, ctx);
 
@@ -4292,17 +4362,13 @@ static void perf_event_exit_event(struct perf_event *event,
  * Removes all events from the current task that have been marked
  * remove-on-exec, and feeds their values back to parent events.
  */
-static void perf_event_remove_on_exec(int ctxn)
+static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 {
-	struct perf_event_context *ctx, *clone_ctx = NULL;
+	struct perf_event_context *clone_ctx = NULL;
 	struct perf_event *event, *next;
 	unsigned long flags;
 	bool modified = false;
 
-	ctx = perf_pin_task_context(current, ctxn);
-	if (!ctx)
-		return;
-
 	mutex_lock(&ctx->mutex);
 
 	if (WARN_ON_ONCE(ctx->task != current))
@@ -4323,13 +4389,11 @@ static void perf_event_remove_on_exec(int ctxn)
 	raw_spin_lock_irqsave(&ctx->lock, flags);
 	if (modified)
 		clone_ctx = unclone_ctx(ctx);
-	--ctx->pin_count;
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
 unlock:
 	mutex_unlock(&ctx->mutex);
 
-	put_ctx(ctx);
 	if (clone_ctx)
 		put_ctx(clone_ctx);
 }
@@ -4365,7 +4429,7 @@ static void __perf_event_read(void *info)
 	struct perf_read_data *data = info;
 	struct perf_event *sub, *event = data->event;
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct pmu *pmu = event->pmu;
 
 	/*
@@ -4591,17 +4655,25 @@ static void __perf_event_init_context(struct perf_event_context *ctx)
 {
 	raw_spin_lock_init(&ctx->lock);
 	mutex_init(&ctx->mutex);
-	INIT_LIST_HEAD(&ctx->active_ctx_list);
+	INIT_LIST_HEAD(&ctx->pmu_ctx_list);
 	perf_event_groups_init(&ctx->pinned_groups);
 	perf_event_groups_init(&ctx->flexible_groups);
 	INIT_LIST_HEAD(&ctx->event_list);
-	INIT_LIST_HEAD(&ctx->pinned_active);
-	INIT_LIST_HEAD(&ctx->flexible_active);
 	refcount_set(&ctx->refcount, 1);
 }
 
+static void
+__perf_init_event_pmu_context(struct perf_event_pmu_context *epc, struct pmu *pmu)
+{
+	epc->pmu = pmu;
+	INIT_LIST_HEAD(&epc->pmu_ctx_entry);
+	INIT_LIST_HEAD(&epc->pinned_active);
+	INIT_LIST_HEAD(&epc->flexible_active);
+	atomic_set(&epc->refcount, 1);
+}
+
 static struct perf_event_context *
-alloc_perf_context(struct pmu *pmu, struct task_struct *task)
+alloc_perf_context(struct task_struct *task)
 {
 	struct perf_event_context *ctx;
 
@@ -4612,7 +4684,6 @@ alloc_perf_context(struct pmu *pmu, struct task_struct *task)
 	__perf_event_init_context(ctx);
 	if (task)
 		ctx->task = get_task_struct(task);
-	ctx->pmu = pmu;
 
 	return ctx;
 }
@@ -4641,15 +4712,12 @@ find_lively_task_by_vpid(pid_t vpid)
  * Returns a matching context with refcount and pincount.
  */
 static struct perf_event_context *
-find_get_context(struct pmu *pmu, struct task_struct *task,
-		struct perf_event *event)
+find_get_context(struct task_struct *task, struct perf_event *event)
 {
 	struct perf_event_context *ctx, *clone_ctx = NULL;
 	struct perf_cpu_context *cpuctx;
-	void *task_ctx_data = NULL;
 	unsigned long flags;
-	int ctxn, err;
-	int cpu = event->cpu;
+	int err;
 
 	if (!task) {
 		/* Must be root to operate on a CPU event: */
@@ -4657,7 +4725,7 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		if (err)
 			return ERR_PTR(err);
 
-		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
+		cpuctx = per_cpu_ptr(&perf_cpu_context, event->cpu);
 		ctx = &cpuctx->ctx;
 		get_ctx(ctx);
 		raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -4668,43 +4736,22 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 	}
 
 	err = -EINVAL;
-	ctxn = pmu->task_ctx_nr;
-	if (ctxn < 0)
-		goto errout;
-
-	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
-		task_ctx_data = alloc_task_ctx_data(pmu);
-		if (!task_ctx_data) {
-			err = -ENOMEM;
-			goto errout;
-		}
-	}
-
 retry:
-	ctx = perf_lock_task_context(task, ctxn, &flags);
+	ctx = perf_lock_task_context(task, &flags);
 	if (ctx) {
 		clone_ctx = unclone_ctx(ctx);
 		++ctx->pin_count;
 
-		if (task_ctx_data && !ctx->task_ctx_data) {
-			ctx->task_ctx_data = task_ctx_data;
-			task_ctx_data = NULL;
-		}
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
 		if (clone_ctx)
 			put_ctx(clone_ctx);
 	} else {
-		ctx = alloc_perf_context(pmu, task);
+		ctx = alloc_perf_context(task);
 		err = -ENOMEM;
 		if (!ctx)
 			goto errout;
 
-		if (task_ctx_data) {
-			ctx->task_ctx_data = task_ctx_data;
-			task_ctx_data = NULL;
-		}
-
 		err = 0;
 		mutex_lock(&task->perf_event_mutex);
 		/*
@@ -4713,12 +4760,12 @@ retry:
 		 */
 		if (task->flags & PF_EXITING)
 			err = -ESRCH;
-		else if (task->perf_event_ctxp[ctxn])
+		else if (task->perf_event_ctxp)
 			err = -EAGAIN;
 		else {
 			get_ctx(ctx);
 			++ctx->pin_count;
-			rcu_assign_pointer(task->perf_event_ctxp[ctxn], ctx);
+			rcu_assign_pointer(task->perf_event_ctxp, ctx);
 		}
 		mutex_unlock(&task->perf_event_mutex);
 
@@ -4731,21 +4778,146 @@ retry:
 		}
 	}
 
-	free_task_ctx_data(pmu, task_ctx_data);
 	return ctx;
 
 errout:
-	free_task_ctx_data(pmu, task_ctx_data);
 	return ERR_PTR(err);
 }
 
+static struct perf_event_pmu_context *
+find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
+		     struct perf_event *event)
+{
+	struct perf_event_pmu_context *new = NULL, *epc;
+	void *task_ctx_data = NULL;
+
+	if (!ctx->task) {
+		struct perf_cpu_pmu_context *cpc;
+
+		cpc = per_cpu_ptr(pmu->cpu_pmu_context, event->cpu);
+		epc = &cpc->epc;
+
+		if (!epc->ctx) {
+			atomic_set(&epc->refcount, 1);
+			epc->embedded = 1;
+			raw_spin_lock_irq(&ctx->lock);
+			list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+			epc->ctx = ctx;
+			raw_spin_unlock_irq(&ctx->lock);
+		} else {
+			WARN_ON_ONCE(epc->ctx != ctx);
+			atomic_inc(&epc->refcount);
+		}
+
+		return epc;
+	}
+
+	new = kzalloc(sizeof(*epc), GFP_KERNEL);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
+		task_ctx_data = alloc_task_ctx_data(pmu);
+		if (!task_ctx_data) {
+			kfree(new);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	__perf_init_event_pmu_context(new, pmu);
+
+	/*
+	 * XXX
+	 *
+	 * lockdep_assert_held(&ctx->mutex);
+	 *
+	 * can't because perf_event_init_task() doesn't actually hold the
+	 * child_ctx->mutex.
+	 */
+
+	raw_spin_lock_irq(&ctx->lock);
+	list_for_each_entry(epc, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		if (epc->pmu == pmu) {
+			WARN_ON_ONCE(epc->ctx != ctx);
+			atomic_inc(&epc->refcount);
+			goto found_epc;
+		}
+	}
+
+	epc = new;
+	new = NULL;
+
+	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+	epc->ctx = ctx;
+
+found_epc:
+	if (task_ctx_data && !epc->task_ctx_data) {
+		epc->task_ctx_data = task_ctx_data;
+		task_ctx_data = NULL;
+		ctx->nr_task_data++;
+	}
+	raw_spin_unlock_irq(&ctx->lock);
+
+	free_task_ctx_data(pmu, task_ctx_data);
+	kfree(new);
+
+	return epc;
+}
+
+static void get_pmu_ctx(struct perf_event_pmu_context *epc)
+{
+	WARN_ON_ONCE(!atomic_inc_not_zero(&epc->refcount));
+}
+
+static void free_epc_rcu(struct rcu_head *head)
+{
+	struct perf_event_pmu_context *epc = container_of(head, typeof(*epc), rcu_head);
+
+	kfree(epc->task_ctx_data);
+	kfree(epc);
+}
+
+static void put_pmu_ctx(struct perf_event_pmu_context *epc)
+{
+	unsigned long flags;
+
+	if (!atomic_dec_and_test(&epc->refcount))
+		return;
+
+	if (epc->ctx) {
+		struct perf_event_context *ctx = epc->ctx;
+
+		/*
+		 * XXX
+		 *
+		 * lockdep_assert_held(&ctx->mutex);
+		 *
+		 * can't because of the call-site in _free_event()/put_event()
+		 * which isn't always called under ctx->mutex.
+		 */
+
+		WARN_ON_ONCE(list_empty(&epc->pmu_ctx_entry));
+		raw_spin_lock_irqsave(&ctx->lock, flags);
+		list_del_init(&epc->pmu_ctx_entry);
+		epc->ctx = NULL;
+		raw_spin_unlock_irqrestore(&ctx->lock, flags);
+	}
+
+	WARN_ON_ONCE(!list_empty(&epc->pinned_active));
+	WARN_ON_ONCE(!list_empty(&epc->flexible_active));
+
+	if (epc->embedded)
+		return;
+
+	call_rcu(&epc->rcu_head, free_epc_rcu);
+}
+
 static void perf_event_free_filter(struct perf_event *event);
 
 static void free_event_rcu(struct rcu_head *head)
 {
-	struct perf_event *event;
+	struct perf_event *event = container_of(head, typeof(*event), rcu_head);
 
-	event = container_of(head, struct perf_event, rcu_head);
 	if (event->ns)
 		put_pid_ns(event->ns);
 	perf_event_free_filter(event);
@@ -4883,7 +5055,7 @@ static void perf_sched_delayed(struct work_struct *work)
  *
  *  1) cpu-wide events in the presence of per-task events,
  *  2) per-task events in the presence of cpu-wide events,
- *  3) two matching events on the same context.
+ *  3) two matching events on the same perf_event_context.
  *
  * The former two cases are handled in the allocation path (perf_event_alloc(),
  * _free_event()), the latter -- before the first perf_install_in_context().
@@ -5007,6 +5179,9 @@ static void _free_event(struct perf_event *event)
 	if (event->hw.target)
 		put_task_struct(event->hw.target);
 
+	if (event->pmu_ctx)
+		put_pmu_ctx(event->pmu_ctx);
+
 	/*
 	 * perf_event_free_task() relies on put_ctx() being 'last', in particular
 	 * all task references must be cleaned up.
@@ -5107,8 +5282,8 @@ int perf_event_release_kernel(struct perf_event *event)
 	LIST_HEAD(free_list);
 
 	/*
-	 * If we got here through err_file: fput(event_file); we will not have
-	 * attached to a context yet.
+	 * If we got here through err_alloc: free_event(event); we will not
+	 * have attached to a context yet.
 	 */
 	if (!ctx) {
 		WARN_ON_ONCE(event->attach_state &
@@ -5543,7 +5718,7 @@ static void __perf_event_period(struct perf_event *event,
 
 	active = (event->state == PERF_EVENT_STATE_ACTIVE);
 	if (active) {
-		perf_pmu_disable(ctx->pmu);
+		perf_pmu_disable(event->pmu);
 		/*
 		 * We could be throttled; unthrottle now to avoid the tick
 		 * trying to unthrottle while we already re-started the event.
@@ -5559,7 +5734,7 @@ static void __perf_event_period(struct perf_event *event,
 
 	if (active) {
 		event->pmu->start(event, PERF_EF_RELOAD);
-		perf_pmu_enable(ctx->pmu);
+		perf_pmu_enable(event->pmu);
 	}
 }
 
@@ -7720,7 +7895,6 @@ perf_iterate_sb(perf_iterate_f output, void *data,
 	       struct perf_event_context *task_ctx)
 {
 	struct perf_event_context *ctx;
-	int ctxn;
 
 	rcu_read_lock();
 	preempt_disable();
@@ -7737,11 +7911,9 @@ perf_iterate_sb(perf_iterate_f output, void *data,
 
 	perf_iterate_sb_cpu(output, data);
 
-	for_each_task_context_nr(ctxn) {
-		ctx = rcu_dereference(current->perf_event_ctxp[ctxn]);
-		if (ctx)
-			perf_iterate_ctx(ctx, output, data, false);
-	}
+	ctx = rcu_dereference(current->perf_event_ctxp);
+	if (ctx)
+		perf_iterate_ctx(ctx, output, data, false);
 done:
 	preempt_enable();
 	rcu_read_unlock();
@@ -7783,20 +7955,17 @@ static void perf_event_addr_filters_exec(struct perf_event *event, void *data)
 void perf_event_exec(void)
 {
 	struct perf_event_context *ctx;
-	int ctxn;
 
-	for_each_task_context_nr(ctxn) {
-		perf_event_enable_on_exec(ctxn);
-		perf_event_remove_on_exec(ctxn);
+	ctx = perf_pin_task_context(current);
+	if (!ctx)
+		return;
+
+	perf_event_enable_on_exec(ctx);
+	perf_event_remove_on_exec(ctx);
+	perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
 
-		rcu_read_lock();
-		ctx = rcu_dereference(current->perf_event_ctxp[ctxn]);
-		if (ctx) {
-			perf_iterate_ctx(ctx, perf_event_addr_filters_exec,
-					 NULL, true);
-		}
-		rcu_read_unlock();
-	}
+	perf_unpin_context(ctx);
+	put_ctx(ctx);
 }
 
 struct remote_output {
@@ -7836,8 +8005,7 @@ static void __perf_event_output_stop(struct perf_event *event, void *data)
 static int __perf_pmu_output_stop(void *info)
 {
 	struct perf_event *event = info;
-	struct pmu *pmu = event->ctx->pmu;
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct remote_output ro = {
 		.rb	= event->rb,
 	};
@@ -8626,7 +8794,6 @@ static void __perf_addr_filters_adjust(struct perf_event *event, void *data)
 static void perf_addr_filters_adjust(struct vm_area_struct *vma)
 {
 	struct perf_event_context *ctx;
-	int ctxn;
 
 	/*
 	 * Data tracing isn't supported yet and as such there is no need
@@ -8636,13 +8803,9 @@ static void perf_addr_filters_adjust(struct vm_area_struct *vma)
 		return;
 
 	rcu_read_lock();
-	for_each_task_context_nr(ctxn) {
-		ctx = rcu_dereference(current->perf_event_ctxp[ctxn]);
-		if (!ctx)
-			continue;
-
+	ctx = rcu_dereference(current->perf_event_ctxp);
+	if (ctx)
 		perf_iterate_ctx(ctx, __perf_addr_filters_adjust, vma, true);
-	}
 	rcu_read_unlock();
 }
 
@@ -9863,10 +10026,13 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 		struct trace_entry *entry = record;
 
 		rcu_read_lock();
-		ctx = rcu_dereference(task->perf_event_ctxp[perf_sw_context]);
+		ctx = rcu_dereference(task->perf_event_ctxp);
 		if (!ctx)
 			goto unlock;
 
+		// XXX iterate groups instead, we should be able to
+		// find the subtree for the perf_tracepoint pmu and CPU.
+
 		list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
 			if (event->cpu != smp_processor_id())
 				continue;
@@ -11012,36 +11178,9 @@ static int perf_event_idx_default(struct perf_event *event)
 	return 0;
 }
 
-/*
- * Ensures all contexts with the same task_ctx_nr have the same
- * pmu_cpu_context too.
- */
-static struct perf_cpu_context __percpu *find_pmu_context(int ctxn)
-{
-	struct pmu *pmu;
-
-	if (ctxn < 0)
-		return NULL;
-
-	list_for_each_entry(pmu, &pmus, entry) {
-		if (pmu->task_ctx_nr == ctxn)
-			return pmu->pmu_cpu_context;
-	}
-
-	return NULL;
-}
-
 static void free_pmu_context(struct pmu *pmu)
 {
-	/*
-	 * Static contexts such as perf_sw_context have a global lifetime
-	 * and may be shared between different PMUs. Avoid freeing them
-	 * when a single PMU is going away.
-	 */
-	if (pmu->task_ctx_nr > perf_invalid_context)
-		return;
-
-	free_percpu(pmu->pmu_cpu_context);
+	free_percpu(pmu->cpu_pmu_context);
 }
 
 /*
@@ -11105,12 +11244,12 @@ perf_event_mux_interval_ms_store(struct device *dev,
 	/* update all cpuctx for this PMU */
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
-		struct perf_cpu_context *cpuctx;
-		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
-		cpuctx->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
+		struct perf_cpu_pmu_context *cpc;
+		cpc = per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+		cpc->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
 
 		cpu_function_call(cpu,
-			(remote_function_f)perf_mux_hrtimer_restart, cpuctx);
+			(remote_function_f)perf_mux_hrtimer_restart, cpc);
 	}
 	cpus_read_unlock();
 	mutex_unlock(&mux_interval_mutex);
@@ -11221,47 +11360,19 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	}
 
 skip_type:
-	if (pmu->task_ctx_nr == perf_hw_context) {
-		static int hw_context_taken = 0;
-
-		/*
-		 * Other than systems with heterogeneous CPUs, it never makes
-		 * sense for two PMUs to share perf_hw_context. PMUs which are
-		 * uncore must use perf_invalid_context.
-		 */
-		if (WARN_ON_ONCE(hw_context_taken &&
-		    !(pmu->capabilities & PERF_PMU_CAP_HETEROGENEOUS_CPUS)))
-			pmu->task_ctx_nr = perf_invalid_context;
-
-		hw_context_taken = 1;
-	}
-
-	pmu->pmu_cpu_context = find_pmu_context(pmu->task_ctx_nr);
-	if (pmu->pmu_cpu_context)
-		goto got_cpu_context;
-
 	ret = -ENOMEM;
-	pmu->pmu_cpu_context = alloc_percpu(struct perf_cpu_context);
-	if (!pmu->pmu_cpu_context)
+	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
+	if (!pmu->cpu_pmu_context)
 		goto free_dev;
 
 	for_each_possible_cpu(cpu) {
-		struct perf_cpu_context *cpuctx;
-
-		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
-		__perf_event_init_context(&cpuctx->ctx);
-		lockdep_set_class(&cpuctx->ctx.mutex, &cpuctx_mutex);
-		lockdep_set_class(&cpuctx->ctx.lock, &cpuctx_lock);
-		cpuctx->ctx.pmu = pmu;
-		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
-
-		__perf_mux_hrtimer_init(cpuctx, cpu);
+		struct perf_cpu_pmu_context *cpc;
 
-		cpuctx->heap_size = ARRAY_SIZE(cpuctx->heap_default);
-		cpuctx->heap = cpuctx->heap_default;
+		cpc = per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+		__perf_init_event_pmu_context(&cpc->epc, pmu);
+		__perf_mux_hrtimer_init(cpc, cpu);
 	}
 
-got_cpu_context:
 	if (!pmu->start_txn) {
 		if (pmu->pmu_enable) {
 			/*
@@ -11740,10 +11851,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	}
 
 	/*
-	 * Disallow uncore-cgroup events, they don't make sense as the cgroup will
-	 * be different on other CPUs in the uncore mask.
+	 * Disallow uncore-task events. Similarly, disallow uncore-cgroup
+	 * events (they don't make sense as the cgroup will be different
+	 * on other CPUs in the uncore mask).
 	 */
-	if (pmu->task_ctx_nr == perf_invalid_context && cgroup_fd != -1) {
+	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
 		err = -EINVAL;
 		goto err_pmu;
 	}
@@ -12090,37 +12202,6 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 	return 0;
 }
 
-/*
- * Variation on perf_event_ctx_lock_nested(), except we take two context
- * mutexes.
- */
-static struct perf_event_context *
-__perf_event_ctx_lock_double(struct perf_event *group_leader,
-			     struct perf_event_context *ctx)
-{
-	struct perf_event_context *gctx;
-
-again:
-	rcu_read_lock();
-	gctx = READ_ONCE(group_leader->ctx);
-	if (!refcount_inc_not_zero(&gctx->refcount)) {
-		rcu_read_unlock();
-		goto again;
-	}
-	rcu_read_unlock();
-
-	mutex_lock_double(&gctx->mutex, &ctx->mutex);
-
-	if (group_leader->ctx != gctx) {
-		mutex_unlock(&ctx->mutex);
-		mutex_unlock(&gctx->mutex);
-		put_ctx(gctx);
-		goto again;
-	}
-
-	return gctx;
-}
-
 static bool
 perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
 {
@@ -12166,9 +12247,10 @@ SYSCALL_DEFINE5(perf_event_open,
 		pid_t, pid, int, cpu, int, group_fd, unsigned long, flags)
 {
 	struct perf_event *group_leader = NULL, *output_event = NULL;
+	struct perf_event_pmu_context *pmu_ctx;
 	struct perf_event *event, *sibling;
 	struct perf_event_attr attr;
-	struct perf_event_context *ctx, *gctx;
+	struct perf_event_context *ctx;
 	struct file *event_file = NULL;
 	struct fd group = {NULL, 0};
 	struct task_struct *task = NULL;
@@ -12298,42 +12380,53 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (pmu->task_ctx_nr == perf_sw_context)
 		event->event_caps |= PERF_EV_CAP_SOFTWARE;
 
-	if (group_leader) {
-		if (is_software_event(event) &&
-		    !in_software_context(group_leader)) {
-			/*
-			 * If the event is a sw event, but the group_leader
-			 * is on hw context.
-			 *
-			 * Allow the addition of software events to hw
-			 * groups, this is safe because software events
-			 * never fail to schedule.
-			 */
-			pmu = group_leader->ctx->pmu;
-		} else if (!is_software_event(event) &&
-			   is_software_event(group_leader) &&
-			   (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
-			/*
-			 * In case the group is a pure software group, and we
-			 * try to add a hardware event, move the whole group to
-			 * the hardware context.
-			 */
-			move_group = 1;
-		}
+	if (task) {
+		err = down_read_interruptible(&task->signal->exec_update_lock);
+		if (err)
+			goto err_alloc;
+
+		/*
+		 * We must hold exec_update_lock across this and any potential
+		 * perf_install_in_context() call for this new event to
+		 * serialize against exec() altering our credentials (and the
+		 * perf_event_exit_task() that could imply).
+		 */
+		err = -EACCES;
+		if (!perf_check_permission(&attr, task))
+			goto err_cred;
 	}
 
 	/*
 	 * Get the target context (task or percpu):
 	 */
-	ctx = find_get_context(pmu, task, event);
+	ctx = find_get_context(task, event);
 	if (IS_ERR(ctx)) {
 		err = PTR_ERR(ctx);
-		goto err_alloc;
+		goto err_cred;
+	}
+
+	mutex_lock(&ctx->mutex);
+
+	if (ctx->task == TASK_TOMBSTONE) {
+		err = -ESRCH;
+		goto err_locked;
+	}
+
+	if (!task) {
+		/*
+		 * Check if the @cpu we're creating an event for is online.
+		 *
+		 * We use the perf_cpu_context::ctx::mutex to serialize against
+		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
+		 */
+		struct perf_cpu_context *cpuctx = per_cpu_ptr(&perf_cpu_context, event->cpu);
+
+		if (!cpuctx->online) {
+			err = -ENODEV;
+			goto err_locked;
+		}
 	}
 
-	/*
-	 * Look up the group leader (we will attach this event to it):
-	 */
 	if (group_leader) {
 		err = -EINVAL;
 
@@ -12342,11 +12435,11 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * becoming part of another group-sibling):
 		 */
 		if (group_leader->group_leader != group_leader)
-			goto err_context;
+			goto err_locked;
 
 		/* All events in a group should have the same clock */
 		if (group_leader->clock != event->clock)
-			goto err_context;
+			goto err_locked;
 
 		/*
 		 * Make sure we're both events for the same CPU;
@@ -12354,145 +12447,70 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * you can never concurrently schedule them anyhow.
 		 */
 		if (group_leader->cpu != event->cpu)
-			goto err_context;
+			goto err_locked;
 
 		/*
-		 * Make sure we're both on the same task, or both
-		 * per-CPU events.
+		 * Make sure we're both on the same context; either task or cpu.
 		 */
-		if (group_leader->ctx->task != ctx->task)
-			goto err_context;
-
-		/*
-		 * Do not allow to attach to a group in a different task
-		 * or CPU context. If we're moving SW events, we'll fix
-		 * this up later, so allow that.
-		 *
-		 * Racy, not holding group_leader->ctx->mutex, see comment with
-		 * perf_event_ctx_lock().
-		 */
-		if (!move_group && group_leader->ctx != ctx)
-			goto err_context;
+		if (group_leader->ctx != ctx)
+			goto err_locked;
 
 		/*
 		 * Only a group leader can be exclusive or pinned
 		 */
 		if (attr.exclusive || attr.pinned)
-			goto err_context;
-	}
-
-	if (output_event) {
-		err = perf_event_set_output(event, output_event);
-		if (err)
-			goto err_context;
-	}
-
-	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event,
-					f_flags);
-	if (IS_ERR(event_file)) {
-		err = PTR_ERR(event_file);
-		event_file = NULL;
-		goto err_context;
-	}
-
-	if (task) {
-		err = down_read_interruptible(&task->signal->exec_update_lock);
-		if (err)
-			goto err_file;
-
-		/*
-		 * We must hold exec_update_lock across this and any potential
-		 * perf_install_in_context() call for this new event to
-		 * serialize against exec() altering our credentials (and the
-		 * perf_event_exit_task() that could imply).
-		 */
-		err = -EACCES;
-		if (!perf_check_permission(&attr, task))
-			goto err_cred;
-	}
-
-	if (move_group) {
-		gctx = __perf_event_ctx_lock_double(group_leader, ctx);
-
-		if (gctx->task == TASK_TOMBSTONE) {
-			err = -ESRCH;
 			goto err_locked;
-		}
 
-		/*
-		 * Check if we raced against another sys_perf_event_open() call
-		 * moving the software group underneath us.
-		 */
-		if (!(group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
+		if (is_software_event(event) &&
+		    !in_software_context(group_leader)) {
 			/*
-			 * If someone moved the group out from under us, check
-			 * if this new event wound up on the same ctx, if so
-			 * its the regular !move_group case, otherwise fail.
+			 * If the event is a sw event, but the group_leader
+			 * is on hw context.
+			 *
+			 * Allow the addition of software events to hw
+			 * groups, this is safe because software events
+			 * never fail to schedule.
+			 *
+			 * Note the comment that goes with struct
+			 * perf_event_pmu_context.
 			 */
-			if (gctx != ctx) {
-				err = -EINVAL;
-				goto err_locked;
-			} else {
-				perf_event_ctx_unlock(group_leader, gctx);
-				move_group = 0;
-				goto not_move_group;
-			}
-		}
-
-		/*
-		 * Failure to create exclusive events returns -EBUSY.
-		 */
-		err = -EBUSY;
-		if (!exclusive_event_installable(group_leader, ctx))
-			goto err_locked;
-
-		for_each_sibling_event(sibling, group_leader) {
-			if (!exclusive_event_installable(sibling, ctx))
-				goto err_locked;
-		}
-	} else {
-		mutex_lock(&ctx->mutex);
-
-		/*
-		 * Now that we hold ctx->lock, (re)validate group_leader->ctx == ctx,
-		 * see the group_leader && !move_group test earlier.
-		 */
-		if (group_leader && group_leader->ctx != ctx) {
-			err = -EINVAL;
-			goto err_locked;
+			pmu = group_leader->pmu_ctx->pmu;
+		} else if (!is_software_event(event) &&
+			is_software_event(group_leader) &&
+			(group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
+			/*
+			 * In case the group is a pure software group, and we
+			 * try to add a hardware event, move the whole group to
+			 * the hardware context.
+			 */
+			move_group = 1;
 		}
 	}
-not_move_group:
 
-	if (ctx->task == TASK_TOMBSTONE) {
-		err = -ESRCH;
+	/*
+	 * Now that we're certain of the pmu; find the pmu_ctx.
+	 */
+	pmu_ctx = find_get_pmu_context(pmu, ctx, event);
+	if (IS_ERR(pmu_ctx)) {
+		err = PTR_ERR(pmu_ctx);
 		goto err_locked;
 	}
+	event->pmu_ctx = pmu_ctx;
 
-	if (!perf_event_validate_size(event)) {
-		err = -E2BIG;
-		goto err_locked;
+	if (output_event) {
+		err = perf_event_set_output(event, output_event);
+		if (err)
+			goto err_context;
 	}
 
-	if (!task) {
-		/*
-		 * Check if the @cpu we're creating an event for is online.
-		 *
-		 * We use the perf_cpu_context::ctx::mutex to serialize against
-		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
-		 */
-		struct perf_cpu_context *cpuctx =
-			container_of(ctx, struct perf_cpu_context, ctx);
-
-		if (!cpuctx->online) {
-			err = -ENODEV;
-			goto err_locked;
-		}
+	if (!perf_event_validate_size(event)) {
+		err = -E2BIG;
+		goto err_context;
 	}
 
 	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader)) {
 		err = -EINVAL;
-		goto err_locked;
+		goto err_context;
 	}
 
 	/*
@@ -12501,36 +12519,33 @@ not_move_group:
 	 */
 	if (!exclusive_event_installable(event, ctx)) {
 		err = -EBUSY;
-		goto err_locked;
+		goto err_context;
 	}
 
 	WARN_ON_ONCE(ctx->parent_ctx);
 
+	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event, f_flags);
+	if (IS_ERR(event_file)) {
+		err = PTR_ERR(event_file);
+		event_file = NULL;
+		goto err_context;
+	}
+
 	/*
 	 * This is the point on no return; we cannot fail hereafter. This is
 	 * where we start modifying current state.
 	 */
 
 	if (move_group) {
-		/*
-		 * See perf_event_ctx_lock() for comments on the details
-		 * of swizzling perf_event::ctx.
-		 */
 		perf_remove_from_context(group_leader, 0);
-		put_ctx(gctx);
+		put_pmu_ctx(group_leader->pmu_ctx);
 
 		for_each_sibling_event(sibling, group_leader) {
 			perf_remove_from_context(sibling, 0);
-			put_ctx(gctx);
+			put_pmu_ctx(sibling->pmu_ctx);
 		}
 
 		/*
-		 * Wait for everybody to stop referencing the events through
-		 * the old lists, before installing it on new lists.
-		 */
-		synchronize_rcu();
-
-		/*
 		 * Install the group siblings before the group leader.
 		 *
 		 * Because a group leader will try and install the entire group
@@ -12541,9 +12556,10 @@ not_move_group:
 		 * reachable through the group lists.
 		 */
 		for_each_sibling_event(sibling, group_leader) {
+			sibling->pmu_ctx = pmu_ctx;
+			get_pmu_ctx(pmu_ctx);
 			perf_event__state_init(sibling);
 			perf_install_in_context(ctx, sibling, sibling->cpu);
-			get_ctx(ctx);
 		}
 
 		/*
@@ -12551,9 +12567,10 @@ not_move_group:
 		 * event. What we want here is event in the initial
 		 * startup state, ready to be add into new context.
 		 */
+		group_leader->pmu_ctx = pmu_ctx;
+		get_pmu_ctx(pmu_ctx);
 		perf_event__state_init(group_leader);
 		perf_install_in_context(ctx, group_leader, group_leader->cpu);
-		get_ctx(ctx);
 	}
 
 	/*
@@ -12570,8 +12587,6 @@ not_move_group:
 	perf_install_in_context(ctx, event, event->cpu);
 	perf_unpin_context(ctx);
 
-	if (move_group)
-		perf_event_ctx_unlock(group_leader, gctx);
 	mutex_unlock(&ctx->mutex);
 
 	if (task) {
@@ -12593,25 +12608,17 @@ not_move_group:
 	fd_install(event_fd, event_file);
 	return event_fd;
 
+err_context:
+	/* event->pmu_ctx freed by free_event() */
 err_locked:
-	if (move_group)
-		perf_event_ctx_unlock(group_leader, gctx);
 	mutex_unlock(&ctx->mutex);
+	perf_unpin_context(ctx);
+	put_ctx(ctx);
 err_cred:
 	if (task)
 		up_read(&task->signal->exec_update_lock);
-err_file:
-	fput(event_file);
-err_context:
-	perf_unpin_context(ctx);
-	put_ctx(ctx);
 err_alloc:
-	/*
-	 * If event_file is set, the fput() above will have called ->release()
-	 * and that will take care of freeing the event.
-	 */
-	if (!event_file)
-		free_event(event);
+	free_event(event);
 err_task:
 	if (task)
 		put_task_struct(task);
@@ -12637,8 +12644,10 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 				 perf_overflow_handler_t overflow_handler,
 				 void *context)
 {
+	struct perf_event_pmu_context *pmu_ctx;
 	struct perf_event_context *ctx;
 	struct perf_event *event;
+	struct pmu *pmu;
 	int err;
 
 	/*
@@ -12657,14 +12666,18 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 
 	/* Mark owner so we could distinguish it from user events. */
 	event->owner = TASK_TOMBSTONE;
+	pmu = event->pmu;
+
+	if (pmu->task_ctx_nr == perf_sw_context)
+		event->event_caps |= PERF_EV_CAP_SOFTWARE;
 
 	/*
 	 * Get the target context (task or percpu):
 	 */
-	ctx = find_get_context(event->pmu, task, event);
+	ctx = find_get_context(task, event);
 	if (IS_ERR(ctx)) {
 		err = PTR_ERR(ctx);
-		goto err_free;
+		goto err_alloc;
 	}
 
 	WARN_ON_ONCE(ctx->parent_ctx);
@@ -12674,6 +12687,13 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 		goto err_unlock;
 	}
 
+	pmu_ctx = find_get_pmu_context(pmu, ctx, event);
+	if (IS_ERR(pmu_ctx)) {
+		err = PTR_ERR(pmu_ctx);
+		goto err_unlock;
+	}
+	event->pmu_ctx = pmu_ctx;
+
 	if (!task) {
 		/*
 		 * Check if the @cpu we're creating an event for is online.
@@ -12685,13 +12705,13 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 			container_of(ctx, struct perf_cpu_context, ctx);
 		if (!cpuctx->online) {
 			err = -ENODEV;
-			goto err_unlock;
+			goto err_pmu_ctx;
 		}
 	}
 
 	if (!exclusive_event_installable(event, ctx)) {
 		err = -EBUSY;
-		goto err_unlock;
+		goto err_pmu_ctx;
 	}
 
 	perf_install_in_context(ctx, event, event->cpu);
@@ -12700,44 +12720,61 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 
 	return event;
 
+err_pmu_ctx:
+	put_pmu_ctx(pmu_ctx);
 err_unlock:
 	mutex_unlock(&ctx->mutex);
 	perf_unpin_context(ctx);
 	put_ctx(ctx);
-err_free:
+err_alloc:
 	free_event(event);
 err:
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
 
-void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
+static void __perf_pmu_remove(struct perf_event_context *ctx,
+			      int cpu, struct pmu *pmu,
+			      struct perf_event_groups *groups,
+			      struct list_head *events)
 {
-	struct perf_event_context *src_ctx;
-	struct perf_event_context *dst_ctx;
-	struct perf_event *event, *tmp;
-	LIST_HEAD(events);
-
-	src_ctx = &per_cpu_ptr(pmu->pmu_cpu_context, src_cpu)->ctx;
-	dst_ctx = &per_cpu_ptr(pmu->pmu_cpu_context, dst_cpu)->ctx;
+	struct perf_event *event, *sibling;
 
-	/*
-	 * See perf_event_ctx_lock() for comments on the details
-	 * of swizzling perf_event::ctx.
-	 */
-	mutex_lock_double(&src_ctx->mutex, &dst_ctx->mutex);
-	list_for_each_entry_safe(event, tmp, &src_ctx->event_list,
-				 event_entry) {
+	perf_event_groups_for_cpu_pmu(event, groups, cpu, pmu) {
 		perf_remove_from_context(event, 0);
-		unaccount_event_cpu(event, src_cpu);
-		put_ctx(src_ctx);
-		list_add(&event->migrate_entry, &events);
+		unaccount_event_cpu(event, cpu);
+		put_pmu_ctx(event->pmu_ctx);
+		list_add(&event->migrate_entry, events);
+
+		for_each_sibling_event(sibling, event) {
+			perf_remove_from_context(sibling, 0);
+			unaccount_event_cpu(sibling, cpu);
+			put_pmu_ctx(sibling->pmu_ctx);
+			list_add(&sibling->migrate_entry, events);
+		}
 	}
+}
 
-	/*
-	 * Wait for the events to quiesce before re-instating them.
-	 */
-	synchronize_rcu();
+static void __perf_pmu_install_event(struct pmu *pmu,
+				     struct perf_event_context *ctx,
+				     int cpu, struct perf_event *event)
+{
+	struct perf_event_pmu_context *epc;
+
+	event->cpu = cpu;
+	epc = find_get_pmu_context(pmu, ctx, event);
+	event->pmu_ctx = epc;
+
+	if (event->state >= PERF_EVENT_STATE_OFF)
+		event->state = PERF_EVENT_STATE_INACTIVE;
+	account_event_cpu(event, cpu);
+	perf_install_in_context(ctx, event, cpu);
+}
+
+static void __perf_pmu_install(struct perf_event_context *ctx,
+			       int cpu, struct pmu *pmu, struct list_head *events)
+{
+	struct perf_event *event, *tmp;
 
 	/*
 	 * Re-instate events in 2 passes.
@@ -12747,30 +12784,48 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 	 * leader will enable its siblings, even if those are still on the old
 	 * context.
 	 */
-	list_for_each_entry_safe(event, tmp, &events, migrate_entry) {
+	list_for_each_entry_safe(event, tmp, events, migrate_entry) {
 		if (event->group_leader == event)
 			continue;
 
 		list_del(&event->migrate_entry);
-		if (event->state >= PERF_EVENT_STATE_OFF)
-			event->state = PERF_EVENT_STATE_INACTIVE;
-		account_event_cpu(event, dst_cpu);
-		perf_install_in_context(dst_ctx, event, dst_cpu);
-		get_ctx(dst_ctx);
+		__perf_pmu_install_event(pmu, ctx, cpu, event);
 	}
 
 	/*
 	 * Once all the siblings are setup properly, install the group leaders
 	 * to make it go.
 	 */
-	list_for_each_entry_safe(event, tmp, &events, migrate_entry) {
+	list_for_each_entry_safe(event, tmp, events, migrate_entry) {
 		list_del(&event->migrate_entry);
-		if (event->state >= PERF_EVENT_STATE_OFF)
-			event->state = PERF_EVENT_STATE_INACTIVE;
-		account_event_cpu(event, dst_cpu);
-		perf_install_in_context(dst_ctx, event, dst_cpu);
-		get_ctx(dst_ctx);
+		__perf_pmu_install_event(pmu, ctx, cpu, event);
 	}
+}
+
+void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
+{
+	struct perf_event_context *src_ctx, *dst_ctx;
+	LIST_HEAD(events);
+
+	src_ctx = &per_cpu_ptr(&perf_cpu_context, src_cpu)->ctx;
+	dst_ctx = &per_cpu_ptr(&perf_cpu_context, dst_cpu)->ctx;
+
+	/*
+	 * See perf_event_ctx_lock() for comments on the details
+	 * of swizzling perf_event::ctx.
+	 */
+	mutex_lock_double(&src_ctx->mutex, &dst_ctx->mutex);
+
+	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_ctx->pinned_groups, &events);
+	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_ctx->flexible_groups, &events);
+
+	/*
+	 * Wait for the events to quiesce before re-instating them.
+	 */
+	synchronize_rcu();
+
+	__perf_pmu_install(dst_ctx, dst_cpu, pmu, &events);
+
 	mutex_unlock(&dst_ctx->mutex);
 	mutex_unlock(&src_ctx->mutex);
 }
@@ -12850,14 +12905,14 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 	perf_event_wakeup(event);
 }
 
-static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
+static void perf_event_exit_task_context(struct task_struct *child)
 {
 	struct perf_event_context *child_ctx, *clone_ctx = NULL;
 	struct perf_event *child_event, *next;
 
 	WARN_ON_ONCE(child != current);
 
-	child_ctx = perf_pin_task_context(child, ctxn);
+	child_ctx = perf_pin_task_context(child);
 	if (!child_ctx)
 		return;
 
@@ -12879,13 +12934,13 @@ static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
 	 * in.
 	 */
 	raw_spin_lock_irq(&child_ctx->lock);
-	task_ctx_sched_out(__get_cpu_context(child_ctx), child_ctx, EVENT_ALL);
+	task_ctx_sched_out(child_ctx, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
 	 * and mark the context dead.
 	 */
-	RCU_INIT_POINTER(child->perf_event_ctxp[ctxn], NULL);
+	RCU_INIT_POINTER(child->perf_event_ctxp, NULL);
 	put_ctx(child_ctx); /* cannot be last */
 	WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
 	put_task_struct(current); /* cannot be last */
@@ -12920,7 +12975,6 @@ static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
 void perf_event_exit_task(struct task_struct *child)
 {
 	struct perf_event *event, *tmp;
-	int ctxn;
 
 	mutex_lock(&child->perf_event_mutex);
 	list_for_each_entry_safe(event, tmp, &child->perf_event_list,
@@ -12936,8 +12990,7 @@ void perf_event_exit_task(struct task_struct *child)
 	}
 	mutex_unlock(&child->perf_event_mutex);
 
-	for_each_task_context_nr(ctxn)
-		perf_event_exit_task_context(child, ctxn);
+	perf_event_exit_task_context(child);
 
 	/*
 	 * The perf_event_exit_task_context calls perf_event_task
@@ -12980,56 +13033,51 @@ void perf_event_free_task(struct task_struct *task)
 {
 	struct perf_event_context *ctx;
 	struct perf_event *event, *tmp;
-	int ctxn;
 
-	for_each_task_context_nr(ctxn) {
-		ctx = task->perf_event_ctxp[ctxn];
-		if (!ctx)
-			continue;
+	ctx = rcu_access_pointer(task->perf_event_ctxp);
+	if (!ctx)
+		return;
 
-		mutex_lock(&ctx->mutex);
-		raw_spin_lock_irq(&ctx->lock);
-		/*
-		 * Destroy the task <-> ctx relation and mark the context dead.
-		 *
-		 * This is important because even though the task hasn't been
-		 * exposed yet the context has been (through child_list).
-		 */
-		RCU_INIT_POINTER(task->perf_event_ctxp[ctxn], NULL);
-		WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
-		put_task_struct(task); /* cannot be last */
-		raw_spin_unlock_irq(&ctx->lock);
+	mutex_lock(&ctx->mutex);
+	raw_spin_lock_irq(&ctx->lock);
+	/*
+	 * Destroy the task <-> ctx relation and mark the context dead.
+	 *
+	 * This is important because even though the task hasn't been
+	 * exposed yet the context has been (through child_list).
+	 */
+	RCU_INIT_POINTER(task->perf_event_ctxp, NULL);
+	WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
+	put_task_struct(task); /* cannot be last */
+	raw_spin_unlock_irq(&ctx->lock);
 
-		list_for_each_entry_safe(event, tmp, &ctx->event_list, event_entry)
-			perf_free_event(event, ctx);
 
-		mutex_unlock(&ctx->mutex);
+	list_for_each_entry_safe(event, tmp, &ctx->event_list, event_entry)
+		perf_free_event(event, ctx);
 
-		/*
-		 * perf_event_release_kernel() could've stolen some of our
-		 * child events and still have them on its free_list. In that
-		 * case we must wait for these events to have been freed (in
-		 * particular all their references to this task must've been
-		 * dropped).
-		 *
-		 * Without this copy_process() will unconditionally free this
-		 * task (irrespective of its reference count) and
-		 * _free_event()'s put_task_struct(event->hw.target) will be a
-		 * use-after-free.
-		 *
-		 * Wait for all events to drop their context reference.
-		 */
-		wait_var_event(&ctx->refcount, refcount_read(&ctx->refcount) == 1);
-		put_ctx(ctx); /* must be last */
-	}
+	mutex_unlock(&ctx->mutex);
+
+	/*
+	 * perf_event_release_kernel() could've stolen some of our
+	 * child events and still have them on its free_list. In that
+	 * case we must wait for these events to have been freed (in
+	 * particular all their references to this task must've been
+	 * dropped).
+	 *
+	 * Without this copy_process() will unconditionally free this
+	 * task (irrespective of its reference count) and
+	 * _free_event()'s put_task_struct(event->hw.target) will be a
+	 * use-after-free.
+	 *
+	 * Wait for all events to drop their context reference.
+	 */
+	wait_var_event(&ctx->refcount, refcount_read(&ctx->refcount) == 1);
+	put_ctx(ctx); /* must be last */
 }
 
 void perf_event_delayed_put(struct task_struct *task)
 {
-	int ctxn;
-
-	for_each_task_context_nr(ctxn)
-		WARN_ON_ONCE(task->perf_event_ctxp[ctxn]);
+	WARN_ON_ONCE(task->perf_event_ctxp);
 }
 
 struct file *perf_event_get(unsigned int fd)
@@ -13079,6 +13127,7 @@ inherit_event(struct perf_event *parent_event,
 	      struct perf_event_context *child_ctx)
 {
 	enum perf_event_state parent_state = parent_event->state;
+	struct perf_event_pmu_context *pmu_ctx;
 	struct perf_event *child_event;
 	unsigned long flags;
 
@@ -13099,17 +13148,12 @@ inherit_event(struct perf_event *parent_event,
 	if (IS_ERR(child_event))
 		return child_event;
 
-
-	if ((child_event->attach_state & PERF_ATTACH_TASK_DATA) &&
-	    !child_ctx->task_ctx_data) {
-		struct pmu *pmu = child_event->pmu;
-
-		child_ctx->task_ctx_data = alloc_task_ctx_data(pmu);
-		if (!child_ctx->task_ctx_data) {
-			free_event(child_event);
-			return ERR_PTR(-ENOMEM);
-		}
+	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
+	if (!pmu_ctx) {
+		free_event(child_event);
+		return NULL;
 	}
+	child_event->pmu_ctx = pmu_ctx;
 
 	/*
 	 * is_orphaned_event() and list_add_tail(&parent_event->child_list)
@@ -13232,11 +13276,11 @@ static int inherit_group(struct perf_event *parent_event,
 static int
 inherit_task_group(struct perf_event *event, struct task_struct *parent,
 		   struct perf_event_context *parent_ctx,
-		   struct task_struct *child, int ctxn,
+		   struct task_struct *child,
 		   u64 clone_flags, int *inherited_all)
 {
-	int ret;
 	struct perf_event_context *child_ctx;
+	int ret;
 
 	if (!event->attr.inherit ||
 	    (event->attr.inherit_thread && !(clone_flags & CLONE_THREAD)) ||
@@ -13246,7 +13290,7 @@ inherit_task_group(struct perf_event *event, struct task_struct *parent,
 		return 0;
 	}
 
-	child_ctx = child->perf_event_ctxp[ctxn];
+	child_ctx = child->perf_event_ctxp;
 	if (!child_ctx) {
 		/*
 		 * This is executed from the parent task context, so
@@ -13254,16 +13298,14 @@ inherit_task_group(struct perf_event *event, struct task_struct *parent,
 		 * First allocate and initialize a context for the
 		 * child.
 		 */
-		child_ctx = alloc_perf_context(parent_ctx->pmu, child);
+		child_ctx = alloc_perf_context(child);
 		if (!child_ctx)
 			return -ENOMEM;
 
-		child->perf_event_ctxp[ctxn] = child_ctx;
+		child->perf_event_ctxp = child_ctx;
 	}
 
-	ret = inherit_group(event, parent, parent_ctx,
-			    child, child_ctx);
-
+	ret = inherit_group(event, parent, parent_ctx, child, child_ctx);
 	if (ret)
 		*inherited_all = 0;
 
@@ -13273,8 +13315,7 @@ inherit_task_group(struct perf_event *event, struct task_struct *parent,
 /*
  * Initialize the perf_event context in task_struct
  */
-static int perf_event_init_context(struct task_struct *child, int ctxn,
-				   u64 clone_flags)
+static int perf_event_init_context(struct task_struct *child, u64 clone_flags)
 {
 	struct perf_event_context *child_ctx, *parent_ctx;
 	struct perf_event_context *cloned_ctx;
@@ -13284,14 +13325,14 @@ static int perf_event_init_context(struct task_struct *child, int ctxn,
 	unsigned long flags;
 	int ret = 0;
 
-	if (likely(!parent->perf_event_ctxp[ctxn]))
+	if (likely(!parent->perf_event_ctxp))
 		return 0;
 
 	/*
 	 * If the parent's context is a clone, pin it so it won't get
 	 * swapped under us.
 	 */
-	parent_ctx = perf_pin_task_context(parent, ctxn);
+	parent_ctx = perf_pin_task_context(parent);
 	if (!parent_ctx)
 		return 0;
 
@@ -13314,8 +13355,7 @@ static int perf_event_init_context(struct task_struct *child, int ctxn,
 	 */
 	perf_event_groups_for_each(event, &parent_ctx->pinned_groups) {
 		ret = inherit_task_group(event, parent, parent_ctx,
-					 child, ctxn, clone_flags,
-					 &inherited_all);
+					 child, clone_flags, &inherited_all);
 		if (ret)
 			goto out_unlock;
 	}
@@ -13331,8 +13371,7 @@ static int perf_event_init_context(struct task_struct *child, int ctxn,
 
 	perf_event_groups_for_each(event, &parent_ctx->flexible_groups) {
 		ret = inherit_task_group(event, parent, parent_ctx,
-					 child, ctxn, clone_flags,
-					 &inherited_all);
+					 child, clone_flags, &inherited_all);
 		if (ret)
 			goto out_unlock;
 	}
@@ -13340,7 +13379,7 @@ static int perf_event_init_context(struct task_struct *child, int ctxn,
 	raw_spin_lock_irqsave(&parent_ctx->lock, flags);
 	parent_ctx->rotate_disable = 0;
 
-	child_ctx = child->perf_event_ctxp[ctxn];
+	child_ctx = child->perf_event_ctxp;
 
 	if (child_ctx && inherited_all) {
 		/*
@@ -13376,18 +13415,16 @@ out_unlock:
  */
 int perf_event_init_task(struct task_struct *child, u64 clone_flags)
 {
-	int ctxn, ret;
+	int ret;
 
-	memset(child->perf_event_ctxp, 0, sizeof(child->perf_event_ctxp));
+	child->perf_event_ctxp = NULL;
 	mutex_init(&child->perf_event_mutex);
 	INIT_LIST_HEAD(&child->perf_event_list);
 
-	for_each_task_context_nr(ctxn) {
-		ret = perf_event_init_context(child, ctxn, clone_flags);
-		if (ret) {
-			perf_event_free_task(child);
-			return ret;
-		}
+	ret = perf_event_init_context(child, clone_flags);
+	if (ret) {
+		perf_event_free_task(child);
+		return ret;
 	}
 
 	return 0;
@@ -13396,6 +13433,7 @@ int perf_event_init_task(struct task_struct *child, u64 clone_flags)
 static void __init perf_event_init_all_cpus(void)
 {
 	struct swevent_htable *swhash;
+	struct perf_cpu_context *cpuctx;
 	int cpu;
 
 	zalloc_cpumask_var(&perf_online_mask, GFP_KERNEL);
@@ -13403,15 +13441,19 @@ static void __init perf_event_init_all_cpus(void)
 	for_each_possible_cpu(cpu) {
 		swhash = &per_cpu(swevent_htable, cpu);
 		mutex_init(&swhash->hlist_mutex);
-		INIT_LIST_HEAD(&per_cpu(active_ctx_list, cpu));
 
 		INIT_LIST_HEAD(&per_cpu(pmu_sb_events.list, cpu));
 		raw_spin_lock_init(&per_cpu(pmu_sb_events.lock, cpu));
 
-#ifdef CONFIG_CGROUP_PERF
-		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
-#endif
 		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
+
+		cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
+		__perf_event_init_context(&cpuctx->ctx);
+		lockdep_set_class(&cpuctx->ctx.mutex, &cpuctx_mutex);
+		lockdep_set_class(&cpuctx->ctx.lock, &cpuctx_lock);
+		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
+		cpuctx->heap_size = ARRAY_SIZE(cpuctx->heap_default);
+		cpuctx->heap = cpuctx->heap_default;
 	}
 }
 
@@ -13433,12 +13475,12 @@ static void perf_swevent_init_cpu(unsigned int cpu)
 #if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
 static void __perf_event_exit_context(void *__info)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_context *ctx = __info;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 	struct perf_event *event;
 
 	raw_spin_lock(&ctx->lock);
-	ctx_sched_out(ctx, cpuctx, EVENT_TIME);
+	ctx_sched_out(ctx, EVENT_TIME);
 	list_for_each_entry(event, &ctx->event_list, event_entry)
 		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
 	raw_spin_unlock(&ctx->lock);
@@ -13448,18 +13490,16 @@ static void perf_event_exit_cpu_context(int cpu)
 {
 	struct perf_cpu_context *cpuctx;
 	struct perf_event_context *ctx;
-	struct pmu *pmu;
 
+	// XXX simplify cpuctx->online
 	mutex_lock(&pmus_lock);
-	list_for_each_entry(pmu, &pmus, entry) {
-		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
-		ctx = &cpuctx->ctx;
+	cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
+	ctx = &cpuctx->ctx;
 
-		mutex_lock(&ctx->mutex);
-		smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
-		cpuctx->online = 0;
-		mutex_unlock(&ctx->mutex);
-	}
+	mutex_lock(&ctx->mutex);
+	smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
+	cpuctx->online = 0;
+	mutex_unlock(&ctx->mutex);
 	cpumask_clear_cpu(cpu, perf_online_mask);
 	mutex_unlock(&pmus_lock);
 }
@@ -13473,20 +13513,17 @@ int perf_event_init_cpu(unsigned int cpu)
 {
 	struct perf_cpu_context *cpuctx;
 	struct perf_event_context *ctx;
-	struct pmu *pmu;
 
 	perf_swevent_init_cpu(cpu);
 
 	mutex_lock(&pmus_lock);
 	cpumask_set_cpu(cpu, perf_online_mask);
-	list_for_each_entry(pmu, &pmus, entry) {
-		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
-		ctx = &cpuctx->ctx;
+	cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
+	ctx = &cpuctx->ctx;
 
-		mutex_lock(&ctx->mutex);
-		cpuctx->online = 1;
-		mutex_unlock(&ctx->mutex);
-	}
+	mutex_lock(&ctx->mutex);
+	cpuctx->online = 1;
+	mutex_unlock(&ctx->mutex);
 	mutex_unlock(&pmus_lock);
 
 	return 0;
@@ -13623,9 +13660,12 @@ static int perf_cgroup_css_online(struct cgroup_subsys_state *css)
 static int __perf_cgroup_move(void *info)
 {
 	struct task_struct *task = info;
-	rcu_read_lock();
-	perf_cgroup_switch(task);
-	rcu_read_unlock();
+
+	preempt_disable();
+	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
+		perf_cgroup_switch(task);
+	preempt_enable();
+
 	return 0;
 }
 
