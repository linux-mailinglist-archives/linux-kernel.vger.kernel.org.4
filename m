Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7631C600683
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJQF6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiJQF6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:58:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EFBC564F8;
        Sun, 16 Oct 2022 22:58:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B74551042;
        Sun, 16 Oct 2022 22:58:19 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F63B3F7D8;
        Sun, 16 Oct 2022 22:58:08 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH V4 5/7] arm64/perf: Drive BRBE from perf event states
Date:   Mon, 17 Oct 2022 11:27:11 +0530
Message-Id: <20221017055713.451092-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017055713.451092-1-anshuman.khandual@arm.com>
References: <20221017055713.451092-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
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
 arch/arm64/kernel/perf_event.c |  7 ++++++
 drivers/perf/arm_pmu.c         | 40 ++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index c97377e28288..97db333d1208 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -874,6 +874,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
+		if (has_branch_stack(event)) {
+			cpu_pmu->brbe_read(cpuc, event);
+			data.br_stack = &cpuc->branches->brbe_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+			cpu_pmu->brbe_reset(cpuc);
+		}
+
 		/*
 		 * Perf event overflow will queue the processing of the event as
 		 * an irq_work which will be taken care of in the handling of
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 5048a500441e..1a8dca4e513e 100644
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

