Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B520665DD73
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbjADUOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbjADUOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:14:09 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92941ADAE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672863248; x=1704399248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ASV50RpTsst4D7Bu4atslCazcYGAe3W6ZUfwWfrYJW0=;
  b=BYssGMosB8csH9RfcQV8R2nih1tAPHRGJ0dUIf/adP893NqtNR4KZ3JP
   Y+I1ddcDBW6qHjvKUlx8gA7L+EkQgcCjBltClxcAycuSJjBWyO3dRSit8
   gU7MOrxyutOcPqmvJHAj19/j2LuWDid43tkjmNsANmcmGR54qx17i2Sem
   4TkggdF5yGUVdb8mwqZswMLO6aIKVBkm2+sAvAq36h/c3QiTl7r1vfUIk
   kIQhBb+rGCVUZteKhZXlwfyQS12crq0aQHB4NnJGc+AeAorAk/DRHUkFE
   JsATQ+i4KlboVXDl/GZd8p+r6VbuFTvMb/puTwTrDU/lP2eN3pj+7lQpo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322105454"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="322105454"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779324001"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="779324001"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 12:14:08 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/9] perf/x86: Support Retire Latency
Date:   Wed,  4 Jan 2023 12:13:43 -0800
Message-Id: <20230104201349.1451191-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104201349.1451191-1-kan.liang@linux.intel.com>
References: <20230104201349.1451191-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Retire Latency reports the number of elapsed core clocks between the
retirement of the instruction indicated by the Instruction Pointer field
of the PEBS record and the retirement of the prior instruction. It's
enumerated by the IA32_PERF_CAPABILITIES.PEBS_TIMING_INFO[17].

Add flag PMU_FL_RETIRE_LATENCY to indicate the availability of the
feature.

The Retire Latency is not supported by the fixed counter 0 on p-core of
MTL.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No change since V1

 arch/x86/events/intel/core.c | 32 +++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c   |  4 ++++
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d2030be04e4a..a5678ab6d3e3 100644
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
@@ -4374,6 +4377,30 @@ cmt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	return c;
 }
 
+static struct event_constraint *
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
 static struct event_constraint *
 mtl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -4381,7 +4408,7 @@ mtl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
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
index e991c54916d1..6ec326b47e2e 100644
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
index 1ac9d9e3c55c..d6de4487348c 100644
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
-- 
2.35.1

