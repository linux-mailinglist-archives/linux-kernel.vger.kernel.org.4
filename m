Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28E6662C17
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjAIRDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjAIRCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:02:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFD41036;
        Mon,  9 Jan 2023 09:02:12 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:02:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673283729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTp6ZhmIawXqa6mE3N1jeHhxCeaZ3ll0gnZLFbiMFmw=;
        b=EeE0wruQHzik8jigNskv51bS/Ms/oElNRV40L9Y+wEzcLTwhD6XHJBo0ARl4aPjClhpI6T
        qgmU77RQSGKEdpIei+IMm3OMFRV/4eM75+aRejaWLW+M01pGqpySjT6U6VnLI6HcJEw4nD
        teYnSBRn/7VMb+GMh0Bt8sPrY4HrI/utjMA3bjflbpIkIddQ+fnT21ot9sZFbRUkLO2jg4
        IRChFCGjqW+C8hMvQXRuKLObcs5CSA9bR3liw/FrCNwyCJ4d7Njb8y7dj5U47eYk/IlqXV
        LA7V7IesmjKlP0YmGmQFaTNRtVFZGQBPjSqCFRAwbGTb0f92cPvFD7aqeTup8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673283729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTp6ZhmIawXqa6mE3N1jeHhxCeaZ3ll0gnZLFbiMFmw=;
        b=SEWf8WLJolrMwn7jUz9fa8teaxoqLQ99hrHu4qT4q+oJkCB+nJEbfDqmacmhSq3NOFq2/P
        HQbgSu5Sv4zlHHCQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Support Retire Latency
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230104201349.1451191-3-kan.liang@linux.intel.com>
References: <20230104201349.1451191-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167328372910.4906.775292701679325779.tip-bot2@tip-bot2>
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

Commit-ID:     c87a31093c707eb0b8c48aab89922c1d0bf4bd90
Gitweb:        https://git.kernel.org/tip/c87a31093c707eb0b8c48aab89922c1d0bf4bd90
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 04 Jan 2023 12:13:43 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 12:22:07 +01:00

perf/x86: Support Retire Latency

Retire Latency reports the number of elapsed core clocks between the
retirement of the instruction indicated by the Instruction Pointer field
of the PEBS record and the retirement of the prior instruction. It's
enumerated by the IA32_PERF_CAPABILITIES.PEBS_TIMING_INFO[17].

Add flag PMU_FL_RETIRE_LATENCY to indicate the availability of the
feature.

The Retire Latency is not supported by the fixed counter 0 on p-core of
MTL.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230104201349.1451191-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 32 +++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c   |  4 ++++
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d2030be..a5678ab 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4210,6 +4210,9 @@ static struct event_constraint fixed0_counter0_constraint =
 static struct event_constraint fixed0_counter0_1_constraint =
 			INTEL_ALL_EVENT_CONSTRAINT(0, 0x100000003ULL);
 
+static struct event_constraint counters_1_7_constraint =
+			INTEL_ALL_EVENT_CONSTRAINT(0, 0xfeULL);
+
 static struct event_constraint *
 hsw_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -4375,13 +4378,37 @@ cmt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 }
 
 static struct event_constraint *
+rwc_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			  struct perf_event *event)
+{
+	struct event_constraint *c;
+
+	c = spr_get_event_constraints(cpuc, idx, event);
+
+	/* The Retire Latency is not supported by the fixed counter 0. */
+	if (event->attr.precise_ip &&
+	    (event->attr.sample_type & PERF_SAMPLE_WEIGHT_TYPE) &&
+	    constraint_match(&fixed0_constraint, event->hw.config)) {
+		/*
+		 * The Instruction PDIR is only available
+		 * on the fixed counter 0. Error out for this case.
+		 */
+		if (event->attr.precise_ip == 3)
+			return &emptyconstraint;
+		return &counters_1_7_constraint;
+	}
+
+	return c;
+}
+
+static struct event_constraint *
 mtl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
 {
 	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
 
 	if (pmu->cpu_type == hybrid_big)
-		return spr_get_event_constraints(cpuc, idx, event);
+		return rwc_get_event_constraints(cpuc, idx, event);
 	if (pmu->cpu_type == hybrid_small)
 		return cmt_get_event_constraints(cpuc, idx, event);
 
@@ -6718,6 +6745,9 @@ __init int intel_pmu_init(void)
 	if (is_hybrid())
 		intel_pmu_check_hybrid_pmus((u64)fixed_mask);
 
+	if (x86_pmu.intel_cap.pebs_timing_info)
+		x86_pmu.flags |= PMU_FL_RETIRE_LATENCY;
+
 	intel_aux_output_init();
 
 	return 0;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e991c54..6ec326b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1753,6 +1753,7 @@ static void adaptive_pebs_save_regs(struct pt_regs *regs,
 
 #define PEBS_LATENCY_MASK			0xffff
 #define PEBS_CACHE_LATENCY_OFFSET		32
+#define PEBS_RETIRE_LATENCY_OFFSET		32
 
 /*
  * With adaptive PEBS the layout depends on what fields are configured.
@@ -1804,6 +1805,9 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	set_linear_ip(regs, basic->ip);
 	regs->flags = PERF_EFLAGS_EXACT;
 
+	if ((sample_type & PERF_SAMPLE_WEIGHT_STRUCT) && (x86_pmu.flags & PMU_FL_RETIRE_LATENCY))
+		data->weight.var3_w = format_size >> PEBS_RETIRE_LATENCY_OFFSET & PEBS_LATENCY_MASK;
+
 	/*
 	 * The record for MEMINFO is in front of GP
 	 * But PERF_SAMPLE_TRANSACTION needs gprs->ax.
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1ac9d9e..d6de448 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -608,6 +608,7 @@ union perf_capabilities {
 		u64     pebs_baseline:1;
 		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
+		u64	pebs_timing_info:1;
 		u64	anythread_deprecated:1;
 	};
 	u64	capabilities;
@@ -1003,6 +1004,7 @@ do {									\
 #define PMU_FL_PAIR		0x40 /* merge counters for large incr. events */
 #define PMU_FL_INSTR_LATENCY	0x80 /* Support Instruction Latency in PEBS Memory Info Record */
 #define PMU_FL_MEM_LOADS_AUX	0x100 /* Require an auxiliary event for the complete memory info */
+#define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
