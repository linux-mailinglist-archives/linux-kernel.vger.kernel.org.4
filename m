Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862367397AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjFVG4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjFVGzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:55:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49FF12119;
        Wed, 21 Jun 2023 23:55:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A1A71063;
        Wed, 21 Jun 2023 23:55:45 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3ACB3F59C;
        Wed, 21 Jun 2023 23:54:56 -0700 (PDT)
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
Subject: [PATCH V13 10/10] arm64/perf: Implement branch records save on PMU IRQ
Date:   Thu, 22 Jun 2023 12:23:51 +0530
Message-Id: <20230622065351.1092893-11-anshuman.khandual@arm.com>
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

This modifies armv8pmu_branch_read() to concatenate live entries along with
task context stored entries and then process the resultant buffer to create
perf branch entry array for perf_sample_data. It follows the same principle
like task sched out.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Tested-by: James Clark <james.clark@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_brbe.c | 69 +++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index 2177632befa6..cb765aaf1b52 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -647,41 +647,44 @@ void armv8pmu_branch_reset(void)
 	isb();
 }
 
-static bool capture_branch_entry(struct pmu_hw_events *cpuc,
-				 struct perf_event *event, int idx)
+static void brbe_regset_branch_entries(struct pmu_hw_events *cpuc, struct perf_event *event,
+				       struct brbe_regset *regset, int idx)
 {
 	struct perf_branch_entry *entry = &cpuc->branches->branch_entries[idx];
-	u64 brbinf = get_brbinf_reg(idx);
-
-	/*
-	 * There are no valid entries anymore on the buffer.
-	 * Abort the branch record processing to save some
-	 * cycles and also reduce the capture/process load
-	 * for the user space as well.
-	 */
-	if (brbe_invalid(brbinf))
-		return false;
+	u64 brbinf = regset[idx].brbinf;
 
 	perf_clear_branch_entry_bitfields(entry);
 	if (brbe_record_is_complete(brbinf)) {
-		entry->from = get_brbsrc_reg(idx);
-		entry->to = get_brbtgt_reg(idx);
+		entry->from = regset[idx].brbsrc;
+		entry->to = regset[idx].brbtgt;
 	} else if (brbe_record_is_source_only(brbinf)) {
-		entry->from = get_brbsrc_reg(idx);
+		entry->from = regset[idx].brbsrc;
 		entry->to = 0;
 	} else if (brbe_record_is_target_only(brbinf)) {
 		entry->from = 0;
-		entry->to = get_brbtgt_reg(idx);
+		entry->to = regset[idx].brbtgt;
 	}
 	capture_brbe_flags(entry, event, brbinf);
-	return true;
+}
+
+static void process_branch_entries(struct pmu_hw_events *cpuc, struct perf_event *event,
+				   struct brbe_regset *regset, int nr_regset)
+{
+	int idx;
+
+	for (idx = 0; idx < nr_regset; idx++)
+		brbe_regset_branch_entries(cpuc, event, regset, idx);
+
+	cpuc->branches->branch_stack.nr = nr_regset;
+	cpuc->branches->branch_stack.hw_idx = -1ULL;
 }
 
 void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
 {
-	int nr_hw_entries = brbe_get_numrec(cpuc->percpu_pmu->reg_brbidr);
+	struct arm64_perf_task_context *task_ctx = event->pmu_ctx->task_ctx_data;
+	struct brbe_regset live[BRBE_MAX_ENTRIES];
+	int nr_live, nr_store, nr_hw_entries;
 	u64 brbfcr, brbcr;
-	int idx = 0;
 
 	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
 	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
@@ -693,25 +696,17 @@ void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
 	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
 	isb();
 
-	/* Loop through bank 0 */
-	select_brbe_bank(BRBE_BANK_IDX_0);
-	while (idx < nr_hw_entries && idx <= BRBE_BANK0_IDX_MAX) {
-		if (!capture_branch_entry(cpuc, event, idx))
-			goto skip_bank_1;
-		idx++;
-	}
-
-	/* Loop through bank 1 */
-	select_brbe_bank(BRBE_BANK_IDX_1);
-	while (idx < nr_hw_entries && idx <= BRBE_BANK1_IDX_MAX) {
-		if (!capture_branch_entry(cpuc, event, idx))
-			break;
-		idx++;
+	nr_hw_entries = brbe_get_numrec(cpuc->percpu_pmu->reg_brbidr);
+	nr_live = capture_brbe_regset(live, nr_hw_entries);
+	if (event->ctx->task) {
+		nr_store = task_ctx->nr_brbe_records;
+		nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
+						      nr_live, nr_hw_entries);
+		process_branch_entries(cpuc, event, task_ctx->store, nr_store);
+		task_ctx->nr_brbe_records = 0;
+	} else {
+		process_branch_entries(cpuc, event, live, nr_live);
 	}
-
-skip_bank_1:
-	cpuc->branches->branch_stack.nr = idx;
-	cpuc->branches->branch_stack.hw_idx = -1ULL;
 	process_branch_aborts(cpuc);
 
 	/* Unpause the buffer */
-- 
2.25.1

