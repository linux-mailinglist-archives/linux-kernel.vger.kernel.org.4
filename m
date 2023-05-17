Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49632705D39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjEQC0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjEQCZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:25:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 568691BD9;
        Tue, 16 May 2023 19:25:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EADD91FB;
        Tue, 16 May 2023 19:26:04 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.70.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A2B93F793;
        Tue, 16 May 2023 19:25:14 -0700 (PDT)
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
Subject: [PATCH V10 10/10] arm64/perf: Implement branch records save on PMU IRQ
Date:   Wed, 17 May 2023 07:54:10 +0530
Message-Id: <20230517022410.722287-11-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517022410.722287-1-anshuman.khandual@arm.com>
References: <20230517022410.722287-1-anshuman.khandual@arm.com>
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
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_brbe.c | 75 +++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index 0678ebf0a896..9e441141a2c3 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -693,41 +693,45 @@ void armv8pmu_branch_reset(void)
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
 	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;
+	struct arm64_perf_task_context *task_ctx = event->pmu_ctx->task_ctx_data;
+	struct brbe_regset live[BRBE_MAX_ENTRIES];
+	int nr_live, nr_store;
 	u64 brbfcr, brbcr;
-	int idx, loop1_idx1, loop1_idx2, loop2_idx1, loop2_idx2, count;
 
 	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
 	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
@@ -739,36 +743,13 @@ void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
 	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
 	isb();
 
-	/* Determine the indices for each loop */
-	loop1_idx1 = BRBE_BANK0_IDX_MIN;
-	if (brbe_attr->brbe_nr <= BRBE_BANK_MAX_ENTRIES) {
-		loop1_idx2 = brbe_attr->brbe_nr - 1;
-		loop2_idx1 = BRBE_BANK1_IDX_MIN;
-		loop2_idx2 = BRBE_BANK0_IDX_MAX;
-	} else {
-		loop1_idx2 = BRBE_BANK0_IDX_MAX;
-		loop2_idx1 = BRBE_BANK1_IDX_MIN;
-		loop2_idx2 = brbe_attr->brbe_nr - 1;
-	}
-
-	/* Loop through bank 0 */
-	select_brbe_bank(BRBE_BANK_IDX_0);
-	for (idx = 0, count = loop1_idx1; count <= loop1_idx2; idx++, count++) {
-		if (!capture_branch_entry(cpuc, event, idx))
-			goto skip_bank_1;
-	}
-
-	/* Loop through bank 1 */
-	select_brbe_bank(BRBE_BANK_IDX_1);
-	for (count = loop2_idx1; count <= loop2_idx2; idx++, count++) {
-		if (!capture_branch_entry(cpuc, event, idx))
-			break;
-	}
-
-skip_bank_1:
-	cpuc->branches->branch_stack.nr = idx;
-	cpuc->branches->branch_stack.hw_idx = -1ULL;
+	nr_live = capture_brbe_regset(brbe_attr, live);
+	nr_store = task_ctx->nr_brbe_records;
+	nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
+					      nr_live, brbe_attr->brbe_nr);
+	process_branch_entries(cpuc, event, task_ctx->store, nr_store);
 	process_branch_aborts(cpuc);
+	task_ctx->nr_brbe_records = 0;
 
 	/* Unpause the buffer */
 	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
-- 
2.25.1

