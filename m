Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728596BA6FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjCOFVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjCOFUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:20:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB300664E4;
        Tue, 14 Mar 2023 22:16:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56C9E16A3;
        Tue, 14 Mar 2023 22:16:16 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 568363F67D;
        Tue, 14 Mar 2023 22:15:28 -0700 (PDT)
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
Subject: [PATCH V9 07/10] arm64/perf: Add PERF_ATTACH_TASK_DATA to events with has_branch_stack()
Date:   Wed, 15 Mar 2023 10:44:41 +0530
Message-Id: <20230315051444.1683170-8-anshuman.khandual@arm.com>
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
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kernel/brbe.c       | 13 +++++++++++++
 arch/arm64/kernel/brbe.h       | 13 +++++++++++++
 arch/arm64/kernel/perf_event.c |  8 ++++++--
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/brbe.c b/arch/arm64/kernel/brbe.c
index c37118983751..a8b4f89b5d00 100644
--- a/arch/arm64/kernel/brbe.c
+++ b/arch/arm64/kernel/brbe.c
@@ -109,20 +109,33 @@ bool armv8pmu_branch_valid(struct perf_event *event)
 	return true;
 }
 
+static inline struct kmem_cache *
+arm64_create_brbe_task_ctx_kmem_cache(size_t size)
+{
+	return kmem_cache_create("arm64_brbe_task_ctx", size, 0, 0, NULL);
+}
+
 int armv8pmu_private_alloc(struct arm_pmu *arm_pmu)
 {
 	struct brbe_hw_attr *brbe_attr = kzalloc(sizeof(struct brbe_hw_attr), GFP_KERNEL);
+	size_t size = sizeof(struct arm64_perf_task_context);
 
 	if (!brbe_attr)
 		return -ENOMEM;
 
 	arm_pmu->private = brbe_attr;
+	arm_pmu->pmu.task_ctx_cache = arm64_create_brbe_task_ctx_kmem_cache(size);
+	if (!arm_pmu->pmu.task_ctx_cache) {
+		kfree(arm_pmu->private);
+		return -ENOMEM;
+	}
 	return 0;
 }
 
 void armv8pmu_private_free(struct arm_pmu *arm_pmu)
 {
 	kfree(arm_pmu->private);
+	kmem_cache_destroy(arm_pmu->pmu.task_ctx_cache);
 }
 
 static int brbe_attributes_probe(struct arm_pmu *armpmu, u32 brbe)
diff --git a/arch/arm64/kernel/brbe.h b/arch/arm64/kernel/brbe.h
index a47480eec070..4a72c2ba7140 100644
--- a/arch/arm64/kernel/brbe.h
+++ b/arch/arm64/kernel/brbe.h
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
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index b074502835a2..c100731c52a0 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1067,8 +1067,12 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 				       &armv8_pmuv3_perf_cache_map,
 				       ARMV8_PMU_EVTYPE_EVENT);
 
-	if (has_branch_stack(event) && !armv8pmu_branch_valid(event))
-		return -EOPNOTSUPP;
+	if (has_branch_stack(event)) {
+		if (!armv8pmu_branch_valid(event))
+			return -EOPNOTSUPP;
+
+		event->attach_state |= PERF_ATTACH_TASK_DATA;
+	}
 
 	/*
 	 * CHAIN events only work when paired with an adjacent counter, and it
-- 
2.25.1

