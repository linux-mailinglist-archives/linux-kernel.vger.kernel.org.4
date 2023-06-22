Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C447397A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjFVGy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjFVGym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:54:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A59C1FE3;
        Wed, 21 Jun 2023 23:54:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3BD61042;
        Wed, 21 Jun 2023 23:55:18 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C43FB3F59C;
        Wed, 21 Jun 2023 23:54:29 -0700 (PDT)
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
Subject: [PATCH V13 05/10] arm64/perf: Add branch stack support in ARMV8 PMU
Date:   Thu, 22 Jun 2023 12:23:46 +0530
Message-Id: <20230622065351.1092893-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622065351.1092893-1-anshuman.khandual@arm.com>
References: <20230622065351.1092893-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm/include/asm/arm_pmuv3.h    |  9 +++
 arch/arm64/include/asm/perf_event.h | 31 +++++++++++
 drivers/perf/arm_pmuv3.c            | 86 +++++++++++++++++++++--------
 3 files changed, 102 insertions(+), 24 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index f4db3e75d75f..38d8aeb31214 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -244,4 +244,13 @@ static inline bool is_pmuv3p5(int pmuver)
 	return pmuver >= ARMV8_PMU_DFR_VER_V3P5;
 }
 
+/* BRBE stubs */
+#ifdef CONFIG_PERF_EVENTS
+static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event) { }
+static inline bool armv8pmu_branch_attr_valid(struct perf_event *event) { return false; }
+static inline void armv8pmu_branch_enable(struct perf_event *event) { }
+static inline void armv8pmu_branch_disable(struct perf_event *event) { }
+static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
+static inline void armv8pmu_branch_reset(void) { }
+#endif
 #endif
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index eb7071c9eb34..ebc392ba3559 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -24,4 +24,35 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
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
+static inline bool armv8pmu_branch_attr_valid(struct perf_event *event)
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
+#endif
 #endif
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index c98e4039386d..54c80f393eb6 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -705,38 +705,21 @@ static void armv8pmu_enable_event(struct perf_event *event)
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
 
@@ -814,6 +797,11 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
+		if (has_branch_stack(event) && !WARN_ON(!cpuc->branches)) {
+			armv8pmu_branch_read(cpuc, event);
+			perf_sample_save_brstack(&data, event, &cpuc->branches->branch_stack);
+		}
+
 		/*
 		 * Perf event overflow will queue the processing of the event as
 		 * an irq_work which will be taken care of in the handling of
@@ -912,6 +900,14 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
 	return event->hw.idx;
 }
 
+static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
+
+	if (sched_in && armpmu->has_branch_stack)
+		armv8pmu_branch_reset();
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -982,6 +978,9 @@ static void armv8pmu_reset(void *info)
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
 	armv8pmu_pmcr_write(pmcr);
+
+	if (cpu_pmu->has_branch_stack)
+		armv8pmu_branch_reset();
 }
 
 static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
@@ -1019,6 +1018,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 
 	hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
 
+	if (has_branch_stack(event) && !armv8pmu_branch_attr_valid(event))
+		return -EOPNOTSUPP;
+
 	/*
 	 * CHAIN events only work when paired with an adjacent counter, and it
 	 * never makes sense for a user to open one in isolation, as they'll be
@@ -1135,6 +1137,33 @@ static void __armv8pmu_probe_pmu(void *info)
 		cpu_pmu->reg_pmmir = read_pmmir();
 	else
 		cpu_pmu->reg_pmmir = 0;
+	armv8pmu_branch_probe(cpu_pmu);
+}
+
+static int branch_records_alloc(struct arm_pmu *armpmu)
+{
+	struct branch_records __percpu *records;
+	int cpu;
+
+	records = alloc_percpu_gfp(struct branch_records, GFP_KERNEL);
+	if (!records)
+		return -ENOMEM;
+
+	/*
+	 * FIXME: Memory allocated via records gets completely
+	 * consumed here, never required to be freed up later. Hence
+	 * losing access to on stack 'records' is acceptable.
+	 * Otherwise this alloc handle has to be saved some where.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct pmu_hw_events *events_cpu;
+		struct branch_records *records_cpu;
+
+		events_cpu = per_cpu_ptr(armpmu->hw_events, cpu);
+		records_cpu = per_cpu_ptr(records, cpu);
+		events_cpu->branches = records_cpu;
+	}
+	return 0;
 }
 
 static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
@@ -1151,7 +1180,15 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	if (ret)
 		return ret;
 
-	return probe.present ? 0 : -ENODEV;
+	if (!probe.present)
+		return -ENODEV;
+
+	if (cpu_pmu->has_branch_stack) {
+		ret = branch_records_alloc(cpu_pmu);
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
 
 static void armv8pmu_disable_user_access_ipi(void *unused)
@@ -1214,6 +1251,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
+	cpu_pmu->sched_task		= armv8pmu_sched_task;
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
-- 
2.25.1

