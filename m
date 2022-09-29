Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D15EEFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiI2H77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiI2H7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:59:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1001813B00F;
        Thu, 29 Sep 2022 00:59:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6693D139F;
        Thu, 29 Sep 2022 00:59:34 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25B2B3F73D;
        Thu, 29 Sep 2022 00:59:23 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH V3 5/7] arm64/perf: Drive BRBE from perf event states
Date:   Thu, 29 Sep 2022 13:28:55 +0530
Message-Id: <20220929075857.158358-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929075857.158358-1-anshuman.khandual@arm.com>
References: <20220929075857.158358-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Branch stack sampling rides along the normal perf event and all the branch
records get captured during the PMU interrupt. This just changes perf event
handling on the arm64 platform to accommodate required BRBE operations that
will enable branch stack sampling support.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kernel/perf_event.c |  6 +++++
 drivers/perf/arm_pmu.c         | 40 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index e7013699171f..6793b25c3f21 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -874,6 +874,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
+		if (has_branch_stack(event)) {
+			cpu_pmu->brbe_read(cpuc, event);
+			data.br_stack = &cpuc->branches->brbe_stack;
+			cpu_pmu->brbe_reset(cpuc);
+		}
+
 		/*
 		 * Perf event overflow will queue the processing of the event as
 		 * an irq_work which will be taken care of in the handling of
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 16fda9a1229f..93b36933124f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -271,12 +271,22 @@ armpmu_stop(struct perf_event *event, int flags)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 
 	/*
 	 * ARM pmu always has to update the counter, so ignore
 	 * PERF_EF_UPDATE, see comments in armpmu_start().
 	 */
 	if (!(hwc->state & PERF_HES_STOPPED)) {
+		if (has_branch_stack(event)) {
+			WARN_ON_ONCE(!hw_events->brbe_users);
+			hw_events->brbe_users--;
+			if (!hw_events->brbe_users) {
+				hw_events->brbe_context = NULL;
+				armpmu->brbe_disable(hw_events);
+			}
+		}
+
 		armpmu->disable(event);
 		armpmu_event_update(event);
 		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
@@ -287,6 +297,7 @@ static void armpmu_start(struct perf_event *event, int flags)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 
 	/*
 	 * ARM pmu always has to reprogram the period, so ignore
@@ -304,6 +315,14 @@ static void armpmu_start(struct perf_event *event, int flags)
 	 * happened since disabling.
 	 */
 	armpmu_event_set_period(event);
+	if (has_branch_stack(event)) {
+		if (event->ctx->task && hw_events->brbe_context != event->ctx) {
+			armpmu->brbe_reset(hw_events);
+			hw_events->brbe_context = event->ctx;
+		}
+		armpmu->brbe_enable(hw_events);
+		hw_events->brbe_users++;
+	}
 	armpmu->enable(event);
 }
 
@@ -349,6 +368,10 @@ armpmu_add(struct perf_event *event, int flags)
 	hw_events->events[idx] = event;
 
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (has_branch_stack(event))
+		armpmu->brbe_filter(hw_events, event);
+
 	if (flags & PERF_EF_START)
 		armpmu_start(event, PERF_EF_RELOAD);
 
@@ -443,6 +466,7 @@ __hw_perf_event_init(struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 	int mapping;
 
 	hwc->flags = 0;
@@ -492,6 +516,9 @@ __hw_perf_event_init(struct perf_event *event)
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
 
+	if (has_branch_stack(event))
+		armpmu->brbe_filter(hw_events, event);
+
 	return validate_group(event);
 }
 
@@ -520,6 +547,18 @@ static int armpmu_event_init(struct perf_event *event)
 	return __hw_perf_event_init(event);
 }
 
+static void armpmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(ctx->pmu);
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
+
+	if (!hw_events->brbe_users)
+		return;
+
+	if (sched_in)
+		armpmu->brbe_reset(hw_events);
+}
+
 static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
@@ -877,6 +916,7 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 	}
 
 	pmu->pmu = (struct pmu) {
+		.sched_task	= armpmu_sched_task,
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
 		.event_init	= armpmu_event_init,
-- 
2.25.1

