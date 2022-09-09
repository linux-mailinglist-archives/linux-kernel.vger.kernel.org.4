Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62035B324D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiIIIwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiIIIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B4112F702;
        Fri,  9 Sep 2022 01:52:38 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95ecoFTBb3dNDQsnro9L3NdW/jZX7V0QCPerHqkmkPA=;
        b=VrLyw/OoefevQ/CiF3UbyncQmc5SZhBrhUgXuSJpKaEAdXpFmNwTknmk2rpgE+ZU0LzmjM
        4fgwmv3iPjlwN8QUC6sr9Cy8KGbquwYR62dEd9yfOxFnPxDxAd9fUhrsOtFlMkH7ZmTHNC
        J9fgja2xkvo92pdaTe4cuSXOq5y8sh+OCgT9IDOrVaeKLY61fdCKUBeODKFSmXVZztuD15
        cfsjt7T4f+OdZ3CiaNljZcpJxa/THnoz1JM+F/OnWlZOJWEVieWqpez6K2hZ6V5a+StRZS
        2SfLE9Mycgc28FctLwytCYylNCl8wVOy6iga+U7Pv88XC1cQi08y51ln6VTTUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95ecoFTBb3dNDQsnro9L3NdW/jZX7V0QCPerHqkmkPA=;
        b=8E3402bSbr0SPQLgvqD1zrAs+0kQ1BJktU2zpp3pRbPchKBSXCoM65bx65Jeg4qlI8TwuF
        ZfjV9dkp5Oa5GHCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/p4: Remove perfctr_second_write quirk
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829101321.839502514@infradead.org>
References: <20220829101321.839502514@infradead.org>
MIME-Version: 1.0
Message-ID: <166271355517.401.17541809614483607816.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     dbf4e792beadafc684ef455453c613ff182c7723
Gitweb:        https://git.kernel.org/tip/dbf4e792beadafc684ef455453c613ff182c7723
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 20 May 2022 15:38:43 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:04 +02:00

perf/x86/p4: Remove perfctr_second_write quirk

Now that we have a x86_pmu::set_period() method, use it to remove the
perfctr_second_write quirk from the generic code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220829101321.839502514@infradead.org
---
 arch/x86/events/core.c       | 12 +-----------
 arch/x86/events/intel/p4.c   | 37 +++++++++++++++++++++++++----------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 05830bb..b30b8bb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1356,7 +1356,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 	static_call(x86_pmu_enable_all)(added);
 }
 
-static DEFINE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
+DEFINE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
 
 /*
  * Set the next IRQ period, based on the hwc->period_left value.
@@ -1416,16 +1416,6 @@ int x86_perf_event_set_period(struct perf_event *event)
 	if (is_counter_pair(hwc))
 		wrmsrl(x86_pmu_event_addr(idx + 1), 0xffff);
 
-	/*
-	 * Due to erratum on certan cpu we need
-	 * a second write to be sure the register
-	 * is updated properly
-	 */
-	if (x86_pmu.perfctr_second_write) {
-		wrmsrl(hwc->event_base,
-			(u64)(-left) & x86_pmu.cntval_mask);
-	}
-
 	perf_event_update_userpage(event);
 
 	return ret;
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 7951a5d..03bbcc2 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1006,6 +1006,29 @@ static void p4_pmu_enable_all(int added)
 	}
 }
 
+static int p4_pmu_set_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	s64 left = this_cpu_read(pmc_prev_left[hwc->idx]);
+	int ret;
+
+	ret = x86_perf_event_set_period(event);
+
+	if (hwc->event_base) {
+		/*
+		 * This handles erratum N15 in intel doc 249199-029,
+		 * the counter may not be updated correctly on write
+		 * so we need a second write operation to do the trick
+		 * (the official workaround didn't work)
+		 *
+		 * the former idea is taken from OProfile code
+		 */
+		wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
+	}
+
+	return ret;
+}
+
 static int p4_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct perf_sample_data data;
@@ -1044,7 +1067,7 @@ static int p4_pmu_handle_irq(struct pt_regs *regs)
 		/* event overflow for sure */
 		perf_sample_data_init(&data, 0, hwc->last_period);
 
-		if (!x86_perf_event_set_period(event))
+		if (!static_call(x86_pmu_set_period)(event))
 			continue;
 
 
@@ -1316,6 +1339,9 @@ static __initconst const struct x86_pmu p4_pmu = {
 	.enable_all		= p4_pmu_enable_all,
 	.enable			= p4_pmu_enable_event,
 	.disable		= p4_pmu_disable_event,
+
+	.set_period		= p4_pmu_set_period,
+
 	.eventsel		= MSR_P4_BPU_CCCR0,
 	.perfctr		= MSR_P4_BPU_PERFCTR0,
 	.event_map		= p4_pmu_event_map,
@@ -1334,15 +1360,6 @@ static __initconst const struct x86_pmu p4_pmu = {
 	.max_period		= (1ULL << (ARCH_P4_CNTRVAL_BITS - 1)) - 1,
 	.hw_config		= p4_hw_config,
 	.schedule_events	= p4_pmu_schedule_events,
-	/*
-	 * This handles erratum N15 in intel doc 249199-029,
-	 * the counter may not be updated correctly on write
-	 * so we need a second write operation to do the trick
-	 * (the official workaround didn't work)
-	 *
-	 * the former idea is taken from OProfile code
-	 */
-	.perfctr_second_write	= 1,
 
 	.format_attrs		= intel_p4_formats_attr,
 };
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 386ebfa..20c2ee2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -780,7 +780,6 @@ struct x86_pmu {
 
 	struct event_constraint *event_constraints;
 	struct x86_pmu_quirk *quirks;
-	int		perfctr_second_write;
 	void		(*limit_period)(struct perf_event *event, s64 *l);
 
 	/* PMI handler bits */
@@ -1060,6 +1059,7 @@ static inline bool x86_pmu_has_lbr_callstack(void)
 }
 
 DECLARE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
+DECLARE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
 
 int x86_perf_event_set_period(struct perf_event *event);
 
