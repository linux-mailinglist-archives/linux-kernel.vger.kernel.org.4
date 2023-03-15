Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DE56BA705
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjCOFZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjCOFYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:24:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C35926B300;
        Tue, 14 Mar 2023 22:22:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8418165C;
        Tue, 14 Mar 2023 22:16:26 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 463E23F67D;
        Tue, 14 Mar 2023 22:15:38 -0700 (PDT)
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
Subject: [PATCH V9 09/10] arm64/perf: Implement branch records save on task sched out
Date:   Wed, 15 Mar 2023 10:44:43 +0530
Message-Id: <20230315051444.1683170-10-anshuman.khandual@arm.com>
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

This modifies current armv8pmu_sched_task(), to implement a branch records
save mechanism via armv8pmu_branch_save() when a task scheds out of a cpu.
BRBE is paused and disabled for all exception levels before branch records
get captured, which then get concatenated with all existing stored records
present in the task context maintaining the contiguity. Although the final
length of the concatenated buffer does not exceed implemented BRBE length.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/perf_event.h |  2 ++
 arch/arm64/kernel/brbe.c            | 30 +++++++++++++++++++++++++++++
 arch/arm64/kernel/perf_event.c      | 14 ++++++++++++--
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 8077b1fabe29..9ad0c6aabc07 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -289,6 +289,7 @@ void armv8pmu_branch_probe(struct arm_pmu *arm_pmu);
 void armv8pmu_branch_reset(void);
 int armv8pmu_private_alloc(struct arm_pmu *arm_pmu);
 void armv8pmu_private_free(struct arm_pmu *arm_pmu);
+void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx);
 #else
 static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
 {
@@ -315,6 +316,7 @@ static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
 static inline void armv8pmu_branch_reset(void) { }
 static inline int armv8pmu_private_alloc(struct arm_pmu *arm_pmu) { return 0; }
 static inline void armv8pmu_private_free(struct arm_pmu *arm_pmu) { }
+static inline void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx) { }
 #endif
 #endif
 #endif
diff --git a/arch/arm64/kernel/brbe.c b/arch/arm64/kernel/brbe.c
index 34bc58ef8062..3dcb4407b92a 100644
--- a/arch/arm64/kernel/brbe.c
+++ b/arch/arm64/kernel/brbe.c
@@ -207,6 +207,36 @@ static int stitch_stored_live_entries(struct brbe_regset *stored,
 	return nr_last;
 }
 
+static int brbe_branch_save(struct brbe_hw_attr *brbe_attr, struct brbe_regset *live)
+{
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	int nr_live;
+
+	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+
+	nr_live = capture_brbe_regset(brbe_attr, live);
+
+	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+
+	return nr_live;
+}
+
+void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx)
+{
+	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)arm_pmu->private;
+	struct arm64_perf_task_context *task_ctx = ctx;
+	struct brbe_regset live[BRBE_MAX_ENTRIES];
+	int nr_live, nr_store;
+
+	nr_live = brbe_branch_save(brbe_attr, live);
+	nr_store = task_ctx->nr_brbe_records;
+	nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
+					      nr_live, brbe_attr->brbe_nr);
+	task_ctx->nr_brbe_records = nr_store;
+}
+
 /*
  * Generic perf branch filters supported on BRBE
  *
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index c100731c52a0..2fbed575e747 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -972,9 +972,19 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
 static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
+	void *task_ctx = pmu_ctx ? pmu_ctx->task_ctx_data : NULL;
 
-	if (sched_in && arm_pmu_branch_stack_supported(armpmu))
-		armv8pmu_branch_reset();
+	if (arm_pmu_branch_stack_supported(armpmu)) {
+		/* Save branch records in task_ctx on sched out */
+		if (task_ctx && !sched_in) {
+			armv8pmu_branch_save(armpmu, task_ctx);
+			return;
+		}
+
+		/* Reset branch records on sched in */
+		if (sched_in)
+			armv8pmu_branch_reset();
+	}
 }
 
 /*
-- 
2.25.1

