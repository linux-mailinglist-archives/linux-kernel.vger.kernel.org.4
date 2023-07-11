Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA774E905
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGKIZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjGKIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:25:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 125D610F0;
        Tue, 11 Jul 2023 01:25:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D984F2B;
        Tue, 11 Jul 2023 01:26:08 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.47.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB0F63F740;
        Tue, 11 Jul 2023 01:25:21 -0700 (PDT)
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
Subject: [PATCH V13 - RESEND 03/10] arm64/perf: Add branch stack support in struct arm_pmu
Date:   Tue, 11 Jul 2023 13:54:48 +0530
Message-Id: <20230711082455.215983-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230711082455.215983-1-anshuman.khandual@arm.com>
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index c0475a96c2a0..fe456a46fe8d 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -512,8 +512,7 @@ static int armpmu_event_init(struct perf_event *event)
 		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
 		return -ENOENT;
 
-	/* does not support taken branch sampling */
-	if (has_branch_stack(event))
+	if (has_branch_stack(event) && !armpmu->has_branch_stack)
 		return -EOPNOTSUPP;
 
 	return __hw_perf_event_init(event);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 3d3bd944d630..5ecd3d0e7645 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -104,7 +104,9 @@ struct arm_pmu {
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
@@ -120,6 +122,11 @@ struct arm_pmu {
 
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

