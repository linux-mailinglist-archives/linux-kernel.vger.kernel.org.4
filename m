Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC6646AE4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiLHIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiLHIo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:44:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0548BF14;
        Thu,  8 Dec 2022 00:44:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8736FD6E;
        Thu,  8 Dec 2022 00:45:01 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.40.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A294E3F73D;
        Thu,  8 Dec 2022 00:44:49 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V6 5/7] arm64/perf: Add branch stack support in ARMV8 PMU
Date:   Thu,  8 Dec 2022 14:14:00 +0530
Message-Id: <20221208084402.863310-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208084402.863310-1-anshuman.khandual@arm.com>
References: <20221208084402.863310-1-anshuman.khandual@arm.com>
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
 arch/arm64/include/asm/perf_event.h | 10 ++++++++++
 arch/arm64/kernel/perf_event.c      | 31 +++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 3eaf462f5752..3be9b7a987e9 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -273,4 +273,14 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 	(regs)->pstate = PSR_MODE_EL1h;	\
 }
 
+struct pmu_hw_events;
+struct arm_pmu;
+struct perf_event;
+
+static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event) { }
+static inline bool armv8pmu_branch_valid(struct perf_event *event) {return false; }
+static inline void armv8pmu_branch_enable(struct perf_event *event) { }
+static inline void armv8pmu_branch_disable(struct perf_event *event) { }
+static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
+static inline void armv8pmu_branch_reset(void) { }
 #endif
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 7b0643fe2f13..25878978843e 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -789,6 +789,12 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	 * Enable counter
 	 */
 	armv8pmu_enable_event_counter(event);
+
+	/*
+	 * Enable BRBE
+	 */
+	if (has_branch_stack(event))
+		armv8pmu_branch_enable(event);
 }
 
 static void armv8pmu_disable_event(struct perf_event *event)
@@ -802,6 +808,12 @@ static void armv8pmu_disable_event(struct perf_event *event)
 	 * Disable interrupt for this counter
 	 */
 	armv8pmu_disable_event_irq(event);
+
+	/*
+	 * Disable BRBE
+	 */
+	if (has_branch_stack(event))
+		armv8pmu_branch_disable(event);
 }
 
 static void armv8pmu_start(struct arm_pmu *cpu_pmu)
@@ -874,6 +886,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
+		if (has_branch_stack(event)) {
+			WARN_ON(!cpuc->branches);
+			armv8pmu_branch_read(cpuc, event);
+			data.br_stack = &cpuc->branches->branch_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+		}
+
 		/*
 		 * Perf event overflow will queue the processing of the event as
 		 * an irq_work which will be taken care of in the handling of
@@ -972,6 +991,12 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
 	return event->hw.idx;
 }
 
+static void armv8pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+{
+	if (sched_in)
+		armv8pmu_branch_reset();
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -1048,6 +1073,7 @@ static void armv8pmu_reset(void *info)
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
 	armv8pmu_pmcr_write(pmcr);
+	armv8pmu_branch_reset();
 }
 
 static int __armv8_pmuv3_map_event(struct perf_event *event,
@@ -1065,6 +1091,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 				       &armv8_pmuv3_perf_cache_map,
 				       ARMV8_PMU_EVTYPE_EVENT);
 
+	if (has_branch_stack(event) && !armv8pmu_branch_valid(event))
+		return -EOPNOTSUPP;
+
 	if (armv8pmu_event_is_64bit(event))
 		event->hw.flags |= ARMPMU_EVT_64BIT;
 
@@ -1176,6 +1205,7 @@ static void __armv8pmu_probe_pmu(void *info)
 		cpu_pmu->reg_pmmir = read_cpuid(PMMIR_EL1);
 	else
 		cpu_pmu->reg_pmmir = 0;
+	armv8pmu_branch_probe(cpu_pmu);
 }
 
 static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
@@ -1256,6 +1286,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
+	cpu_pmu->sched_task		= armv8pmu_sched_task;
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
-- 
2.25.1

