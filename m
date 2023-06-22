Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA57397AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjFVGzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjFVGzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:55:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55E5E1BC3;
        Wed, 21 Jun 2023 23:54:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E181F1042;
        Wed, 21 Jun 2023 23:55:29 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 608AA3F59C;
        Wed, 21 Jun 2023 23:54:41 -0700 (PDT)
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
Subject: [PATCH V13 07/10] arm64/perf: Add PERF_ATTACH_TASK_DATA to events with has_branch_stack()
Date:   Thu, 22 Jun 2023 12:23:48 +0530
Message-Id: <20230622065351.1092893-8-anshuman.khandual@arm.com>
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

Short running processes i.e those getting very small cpu run time each time
when they get scheduled on, might not accumulate much branch records before
a PMU IRQ really happens. This increases possibility, for such processes to
loose much of its branch records, while being scheduled in-out of various
cpus on the system.

There is a need to save all occurred branch records during the cpu run time
while the process gets scheduled out. It requires an event context specific
buffer for such storage.

This adds PERF_ATTACH_TASK_DATA flag unconditionally, for all branch stack
sampling events, which would allocate task_ctx_data during its event init.
This also creates a platform specific task_ctx_data kmem cache which will
serve such allocation requests.

This adds a new structure 'arm64_perf_task_context' which encapsulates brbe
register set for maximum possible BRBE entries on the HW along with a valid
records tracking element.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm/include/asm/arm_pmuv3.h    |  2 ++
 arch/arm64/include/asm/perf_event.h |  4 ++++
 drivers/perf/arm_brbe.c             | 21 +++++++++++++++++++++
 drivers/perf/arm_brbe.h             | 13 +++++++++++++
 drivers/perf/arm_pmuv3.c            | 16 +++++++++++++---
 5 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 38d8aeb31214..1f948eaed1c6 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -252,5 +252,7 @@ static inline void armv8pmu_branch_enable(struct perf_event *event) { }
 static inline void armv8pmu_branch_disable(struct perf_event *event) { }
 static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
 static inline void armv8pmu_branch_reset(void) { }
+static inline int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu) { return 0; }
+static inline void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu) { }
 #endif
 #endif
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 49a973571415..b0c12a5882df 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -38,6 +38,8 @@ void armv8pmu_branch_enable(struct perf_event *event);
 void armv8pmu_branch_disable(struct perf_event *event);
 void armv8pmu_branch_probe(struct arm_pmu *arm_pmu);
 void armv8pmu_branch_reset(void);
+int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu);
+void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu);
 #else
 static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
 {
@@ -62,6 +64,8 @@ static inline void armv8pmu_branch_disable(struct perf_event *event)
 
 static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
 static inline void armv8pmu_branch_reset(void) { }
+static inline int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu) { return 0; }
+static inline void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu) { }
 #endif
 #endif
 #endif
diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index 79106300cf2e..a74459445813 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -109,6 +109,27 @@ bool armv8pmu_branch_attr_valid(struct perf_event *event)
 	return true;
 }
 
+static inline struct kmem_cache *
+arm64_create_brbe_task_ctx_kmem_cache(size_t size)
+{
+	return kmem_cache_create("arm64_brbe_task_ctx", size, 0, 0, NULL);
+}
+
+int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu)
+{
+	size_t size = sizeof(struct arm64_perf_task_context);
+
+	arm_pmu->pmu.task_ctx_cache = arm64_create_brbe_task_ctx_kmem_cache(size);
+	if (!arm_pmu->pmu.task_ctx_cache)
+		return -ENOMEM;
+	return 0;
+}
+
+void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu)
+{
+	kmem_cache_destroy(arm_pmu->pmu.task_ctx_cache);
+}
+
 static int brbe_attributes_probe(struct arm_pmu *armpmu, u32 brbe)
 {
 	u64 brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
diff --git a/drivers/perf/arm_brbe.h b/drivers/perf/arm_brbe.h
index a47480eec070..4a72c2ba7140 100644
--- a/drivers/perf/arm_brbe.h
+++ b/drivers/perf/arm_brbe.h
@@ -80,12 +80,25 @@
  *	---------------------------------	------
  */
 #define BRBE_BANK_MAX_ENTRIES 32
+#define BRBE_MAX_BANK 2
+#define BRBE_MAX_ENTRIES (BRBE_BANK_MAX_ENTRIES * BRBE_MAX_BANK)
 
 #define BRBE_BANK0_IDX_MIN 0
 #define BRBE_BANK0_IDX_MAX 31
 #define BRBE_BANK1_IDX_MIN 32
 #define BRBE_BANK1_IDX_MAX 63
 
+struct brbe_regset {
+	unsigned long brbsrc;
+	unsigned long brbtgt;
+	unsigned long brbinf;
+};
+
+struct arm64_perf_task_context {
+	struct brbe_regset store[BRBE_MAX_ENTRIES];
+	int nr_brbe_records;
+};
+
 struct brbe_hw_attr {
 	int	brbe_version;
 	int	brbe_cc;
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 02907371523a..3c079051a63a 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1022,8 +1022,12 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 
 	hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
 
-	if (has_branch_stack(event) && !armv8pmu_branch_attr_valid(event))
-		return -EOPNOTSUPP;
+	if (has_branch_stack(event)) {
+		if (!armv8pmu_branch_attr_valid(event))
+			return -EOPNOTSUPP;
+
+		event->attach_state |= PERF_ATTACH_TASK_DATA;
+	}
 
 	/*
 	 * CHAIN events only work when paired with an adjacent counter, and it
@@ -1188,9 +1192,15 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 		return -ENODEV;
 
 	if (cpu_pmu->has_branch_stack) {
-		ret = branch_records_alloc(cpu_pmu);
+		ret = armv8pmu_task_ctx_cache_alloc(cpu_pmu);
 		if (ret)
 			return ret;
+
+		ret = branch_records_alloc(cpu_pmu);
+		if (ret) {
+			armv8pmu_task_ctx_cache_free(cpu_pmu);
+			return ret;
+		}
 	}
 	return 0;
 }
-- 
2.25.1

