Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0233D677C14
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjAWNAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjAWNAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:00:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ECAA241E4;
        Mon, 23 Jan 2023 05:00:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBE77C14;
        Mon, 23 Jan 2023 05:01:09 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.50.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 61C563F64C;
        Mon, 23 Jan 2023 05:00:22 -0800 (PST)
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
Subject: [PATCH V8 3/6] arm64/perf: Add branch stack support in struct arm_pmu
Date:   Mon, 23 Jan 2023 18:29:53 +0530
Message-Id: <20230123125956.1350336-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123125956.1350336-1-anshuman.khandual@arm.com>
References: <20230123125956.1350336-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates 'struct arm_pmu' for branch stack sampling support later. This
adds a new 'features' element in the structure to track supported features,
and another 'private' element to encapsulate implementation attributes on a
given 'struct arm_pmu'. These updates here will help in tracking any branch
stack sampling support, which is being added later. This also adds a helper
arm_pmu_branch_stack_supported().

This also enables perf branch stack sampling event on all 'struct arm pmu',
supporting the feature but after removing the current gate that blocks such
events unconditionally in armpmu_event_init(). Instead a quick probe can be
initiated via arm_pmu_branch_stack_supported() to ascertain the support.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_pmu.c       |  3 +--
 include/linux/perf/arm_pmu.h | 12 +++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 14a3ed3bdb0b..a85b2d67022e 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -510,8 +510,7 @@ static int armpmu_event_init(struct perf_event *event)
 		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
 		return -ENOENT;
 
-	/* does not support taken branch sampling */
-	if (has_branch_stack(event))
+	if (has_branch_stack(event) && !arm_pmu_branch_stack_supported(armpmu))
 		return -EOPNOTSUPP;
 
 	return __hw_perf_event_init(event);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 2a9d07cee927..78cb1c895ab9 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -103,7 +103,9 @@ struct arm_pmu {
 	bool		(*filter)(struct pmu *pmu, int cpu);
 	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 	int		num_events;
-	bool		secure_access; /* 32-bit ARM only */
+	unsigned int	secure_access	: 1, /* 32-bit ARM only */
+			has_branch_stack: 1, /* 64-bit ARM only */
+			reserved	: 30;
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 #define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
@@ -119,8 +121,16 @@ struct arm_pmu {
 
 	/* Only to be used by ACPI probing code */
 	unsigned long acpi_cpuid;
+
+	/* Implementation specific attributes */
+	void		*private;
 };
 
+static inline bool arm_pmu_branch_stack_supported(struct arm_pmu *armpmu)
+{
+	return armpmu->has_branch_stack;
+}
+
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
 
 u64 armpmu_event_update(struct perf_event *event);
-- 
2.25.1

