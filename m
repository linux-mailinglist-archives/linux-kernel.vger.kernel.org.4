Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6216F731A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbjFONd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbjFONdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:33:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03354272D;
        Thu, 15 Jun 2023 06:33:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 009F12F4;
        Thu, 15 Jun 2023 06:33:54 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.46.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A74463F64C;
        Thu, 15 Jun 2023 06:33:04 -0700 (PDT)
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
Subject: [PATCH V12 03/10] arm64/perf: Add branch stack support in struct arm_pmu
Date:   Thu, 15 Jun 2023 19:02:32 +0530
Message-Id: <20230615133239.442736-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615133239.442736-1-anshuman.khandual@arm.com>
References: <20230615133239.442736-1-anshuman.khandual@arm.com>
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

This updates 'struct arm_pmu' for branch stack sampling support being added
later. This adds an element 'reg_trbidr' to capture BRBE attribute details.
These updates here will help in tracking any branch stack sampling support.

This also enables perf branch stack sampling event on all 'struct arm pmu',
supporting the feature but after removing the current gate that blocks such
events unconditionally in armpmu_event_init(). Instead a quick probe can be
initiated via arm_pmu->has_branch_stack to ascertain the support.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_pmu.c       | 3 +--
 include/linux/perf/arm_pmu.h | 9 ++++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index aada47e3b126..d9ffe9e56e74 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -510,8 +510,7 @@ static int armpmu_event_init(struct perf_event *event)
 		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
 		return -ENOENT;
 
-	/* does not support taken branch sampling */
-	if (has_branch_stack(event))
+	if (has_branch_stack(event) && !armpmu->has_branch_stack)
 		return -EOPNOTSUPP;
 
 	return __hw_perf_event_init(event);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index f7fbd162ca4c..ba4204bdcebf 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -102,7 +102,9 @@ struct arm_pmu {
 	int		(*map_event)(struct perf_event *event);
 	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 	int		num_events;
-	bool		secure_access; /* 32-bit ARM only */
+	unsigned int	secure_access	: 1, /* 32-bit ARM only */
+			has_branch_stack: 1, /* 64-bit ARM only */
+			reserved	: 30;
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 #define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
@@ -118,6 +120,11 @@ struct arm_pmu {
 
 	/* Only to be used by ACPI probing code */
 	unsigned long acpi_cpuid;
+
+	/* Implementation specific attributes */
+#ifdef CONFIG_ARM64_BRBE
+	u64		reg_brbidr;
+#endif
 };
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
-- 
2.25.1

