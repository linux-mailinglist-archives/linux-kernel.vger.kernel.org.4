Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9156BA744
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjCOFlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjCOFlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:41:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCC194DE24;
        Tue, 14 Mar 2023 22:41:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFB80169C;
        Tue, 14 Mar 2023 22:16:06 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CBB333F67D;
        Tue, 14 Mar 2023 22:15:18 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V9 05/10] arm64/perf: Add branch stack support in ARMV8 PMU
Date:   Wed, 15 Mar 2023 10:44:39 +0530
Message-Id: <20230315051444.1683170-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315051444.1683170-1-anshuman.khandual@arm.com>
References: <20230315051444.1683170-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables support for branch stack sampling event in ARMV8 PMU, checking
has_branch_stack() on the event inside 'struct arm_pmu' callbacks. Although
these branch stack helpers armv8pmu_branch_XXXXX() are just dummy functions
for now. While here, this also defines arm_pmu's sched_task() callback with
armv8pmu_sched_task(), which resets the branch record buffer on a sched_in.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/perf_event.h | 33 +++++++++++++
 arch/arm64/kernel/perf_event.c      | 77 ++++++++++++++++++++---------
 2 files changed, 87 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 3eaf462f5752..463f23c3484f 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -273,4 +273,37 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 	(regs)->pstate = PSR_MODE_EL1h;	\
 }
 
+struct pmu_hw_events;
+struct arm_pmu;
+struct perf_event;
+
+#ifdef CONFIG_PERF_EVENTS
+static inline bool has_branch_stack(struct perf_event *event);
+
+static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
+{
+	WARN_ON_ONCE(!has_branch_stack(event));
+}
+
+static inline bool armv8pmu_branch_valid(struct perf_event *event)
+{
+	WARN_ON_ONCE(!has_branch_stack(event));
+	return false;
+}
+
+static inline void armv8pmu_branch_enable(struct perf_event *event)
+{
+	WARN_ON_ONCE(!has_branch_stack(event));
+}
+
+static inline void armv8pmu_branch_disable(struct perf_event *event)
+{
+	WARN_ON_ONCE(!has_branch_stack(event));
+}
+
+static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
+static inline void armv8pmu_branch_reset(void) { }
+static inline int armv8pmu_private_alloc(struct arm_pmu *arm_pmu) { return 0; }
+static inline void armv8pmu_private_free(struct arm_pmu *arm_pmu) { }
+#endif
 #endif
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index dde06c0f97f3..6d7c4f91cbf7 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -769,38 +769,21 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-
-	/*
-	 * Disable counter
-	 */
 	armv8pmu_disable_event_counter(event);
-
-	/*
-	 * Set event.
-	 */
 	armv8pmu_write_event_type(event);
-
-	/*
-	 * Enable interrupt for this counter
-	 */
 	armv8pmu_enable_event_irq(event);
-
-	/*
-	 * Enable counter
-	 */
 	armv8pmu_enable_event_counter(event);
+
+	if (has_branch_stack(event))
+		armv8pmu_branch_enable(event);
 }
 
 static void armv8pmu_disable_event(struct perf_event *event)
 {
-	/*
-	 * Disable counter
-	 */
-	armv8pmu_disable_event_counter(event);
+	if (has_branch_stack(event))
+		armv8pmu_branch_disable(event);
 
-	/*
-	 * Disable interrupt for this counter
-	 */
+	armv8pmu_disable_event_counter(event);
 	armv8pmu_disable_event_irq(event);
 }
 
@@ -878,6 +861,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
+		if (has_branch_stack(event)) {
+			WARN_ON(!cpuc->branches);
+			armv8pmu_branch_read(cpuc, event);
+			perf_sample_save_brstack(&data, event, &cpuc->branches->branch_stack);
+		}
+
 		/*
 		 * Perf event overflow will queue the processing of the event as
 		 * an irq_work which will be taken care of in the handling of
@@ -976,6 +965,14 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
 	return event->hw.idx;
 }
 
+static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
+
+	if (sched_in && arm_pmu_branch_stack_supported(armpmu))
+		armv8pmu_branch_reset();
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -1046,6 +1043,9 @@ static void armv8pmu_reset(void *info)
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
 	armv8pmu_pmcr_write(pmcr);
+
+	if (arm_pmu_branch_stack_supported(cpu_pmu))
+		armv8pmu_branch_reset();
 }
 
 static int __armv8_pmuv3_map_event(struct perf_event *event,
@@ -1063,6 +1063,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 				       &armv8_pmuv3_perf_cache_map,
 				       ARMV8_PMU_EVTYPE_EVENT);
 
+	if (has_branch_stack(event) && !armv8pmu_branch_valid(event))
+		return -EOPNOTSUPP;
+
 	/*
 	 * CHAIN events only work when paired with an adjacent counter, and it
 	 * never makes sense for a user to open one in isolation, as they'll be
@@ -1183,6 +1186,21 @@ static void __armv8pmu_probe_pmu(void *info)
 		cpu_pmu->reg_pmmir = read_cpuid(PMMIR_EL1);
 	else
 		cpu_pmu->reg_pmmir = 0;
+	armv8pmu_branch_probe(cpu_pmu);
+}
+
+static int branch_records_alloc(struct arm_pmu *armpmu)
+{
+	struct pmu_hw_events *events;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		events = per_cpu_ptr(armpmu->hw_events, cpu);
+		events->branches = kzalloc(sizeof(struct branch_records), GFP_KERNEL);
+		if (!events->branches)
+			return -ENOMEM;
+	}
+	return 0;
 }
 
 static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
@@ -1193,12 +1211,24 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	};
 	int ret;
 
+	ret = armv8pmu_private_alloc(cpu_pmu);
+	if (ret)
+		return ret;
+
 	ret = smp_call_function_any(&cpu_pmu->supported_cpus,
 				    __armv8pmu_probe_pmu,
 				    &probe, 1);
 	if (ret)
 		return ret;
 
+	if (arm_pmu_branch_stack_supported(cpu_pmu)) {
+		ret = branch_records_alloc(cpu_pmu);
+		if (ret)
+			return ret;
+	} else {
+		armv8pmu_private_free(cpu_pmu);
+	}
+
 	return probe.present ? 0 : -ENODEV;
 }
 
@@ -1262,6 +1292,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
+	cpu_pmu->sched_task		= armv8pmu_sched_task;
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
-- 
2.25.1

