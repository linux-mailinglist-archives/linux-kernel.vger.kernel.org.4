Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3EF65E33F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjAEDLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAEDK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:10:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 200E3178B9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:10:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A240F15BF;
        Wed,  4 Jan 2023 19:11:37 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BADB93F663;
        Wed,  4 Jan 2023 19:10:53 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH V7 1/6] drivers: perf: arm_pmu: Add new sched_task() callback
Date:   Thu,  5 Jan 2023 08:40:34 +0530
Message-Id: <20230105031039.207972-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230105031039.207972-1-anshuman.khandual@arm.com>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds armpmu_sched_task(), as generic pmu's sched_task() override which
in turn can utilize a new arm_pmu.sched_task() callback when available from
the arm_pmu instance. This new callback will be used while enabling BRBE in
ARMV8 PMU.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_pmu.c       | 9 +++++++++
 include/linux/perf/arm_pmu.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 9b593f985805..14a3ed3bdb0b 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -517,6 +517,14 @@ static int armpmu_event_init(struct perf_event *event)
 	return __hw_perf_event_init(event);
 }
 
+static void armpmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
+
+	if (armpmu->sched_task)
+		armpmu->sched_task(pmu_ctx, sched_in);
+}
+
 static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
@@ -873,6 +881,7 @@ struct arm_pmu *armpmu_alloc(void)
 	}
 
 	pmu->pmu = (struct pmu) {
+		.sched_task	= armpmu_sched_task,
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
 		.event_init	= armpmu_event_init,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index ef914a600087..2a9d07cee927 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -101,6 +101,7 @@ struct arm_pmu {
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
 	bool		(*filter)(struct pmu *pmu, int cpu);
+	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 	int		num_events;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
-- 
2.25.1

