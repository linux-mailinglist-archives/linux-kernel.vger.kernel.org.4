Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332477397AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjFVG4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjFVGzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:55:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A33D26A5;
        Wed, 21 Jun 2023 23:55:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0775C14BF;
        Wed, 21 Jun 2023 23:55:40 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A0603F777;
        Wed, 21 Jun 2023 23:54:51 -0700 (PDT)
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
Subject: [PATCH V13 09/10] arm64/perf: Implement branch records save on task sched out
Date:   Thu, 22 Jun 2023 12:23:50 +0530
Message-Id: <20230622065351.1092893-10-anshuman.khandual@arm.com>
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
Tested-by: James Clark <james.clark@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm/include/asm/arm_pmuv3.h    |  1 +
 arch/arm64/include/asm/perf_event.h |  2 ++
 drivers/perf/arm_brbe.c             | 30 +++++++++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c            | 14 ++++++++++++--
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 1f948eaed1c6..6c65357de94d 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -254,5 +254,6 @@ static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
 static inline void armv8pmu_branch_reset(void) { }
 static inline int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu) { return 0; }
 static inline void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu) { }
+static inline void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx) { }
 #endif
 #endif
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index b0c12a5882df..36e7dfb466a6 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -40,6 +40,7 @@ void armv8pmu_branch_probe(struct arm_pmu *arm_pmu);
 void armv8pmu_branch_reset(void);
 int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu);
 void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu);
+void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx);
 #else
 static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
 {
@@ -66,6 +67,7 @@ static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
 static inline void armv8pmu_branch_reset(void) { }
 static inline int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu) { return 0; }
 static inline void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu) { }
+static inline void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx) { }
 #endif
 #endif
 #endif
diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index 203cd4f350d5..2177632befa6 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -165,6 +165,36 @@ static int stitch_stored_live_entries(struct brbe_regset *stored,
 	return min(nr_live + nr_stored, nr_max);
 }
 
+static int brbe_branch_save(struct brbe_regset *live, int nr_hw_entries)
+{
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	int nr_live;
+
+	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+
+	nr_live = capture_brbe_regset(live, nr_hw_entries);
+
+	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+
+	return nr_live;
+}
+
+void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx)
+{
+	struct arm64_perf_task_context *task_ctx = ctx;
+	struct brbe_regset live[BRBE_MAX_ENTRIES];
+	int nr_live, nr_store, nr_hw_entries;
+
+	nr_hw_entries = brbe_get_numrec(arm_pmu->reg_brbidr);
+	nr_live = brbe_branch_save(live, nr_hw_entries);
+	nr_store = task_ctx->nr_brbe_records;
+	nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
+					      nr_live, nr_hw_entries);
+	task_ctx->nr_brbe_records = nr_store;
+}
+
 /*
  * Generic perf branch filters supported on BRBE
  *
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 3c079051a63a..53f404618891 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -907,9 +907,19 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
 static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
+	void *task_ctx = pmu_ctx ? pmu_ctx->task_ctx_data : NULL;
 
-	if (sched_in && armpmu->has_branch_stack)
-		armv8pmu_branch_reset();
+	if (armpmu->has_branch_stack) {
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

