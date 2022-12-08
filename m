Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5739646AE0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiLHIox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiLHIod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:44:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CFB663BB5;
        Thu,  8 Dec 2022 00:44:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE7DBD6E;
        Thu,  8 Dec 2022 00:44:38 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.40.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E45443F73D;
        Thu,  8 Dec 2022 00:44:26 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V6 1/7] drivers: perf: arm_pmu: Add new sched_task() callback
Date:   Thu,  8 Dec 2022 14:13:56 +0530
Message-Id: <20221208084402.863310-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208084402.863310-1-anshuman.khandual@arm.com>
References: <20221208084402.863310-1-anshuman.khandual@arm.com>
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
index 3f07df5a7e95..66880a4bb248 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -520,6 +520,14 @@ static int armpmu_event_init(struct perf_event *event)
 	return __hw_perf_event_init(event);
 }
 
+static void armpmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(ctx->pmu);
+
+	if (armpmu->sched_task)
+		armpmu->sched_task(ctx, sched_in);
+}
+
 static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
@@ -877,6 +885,7 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 	}
 
 	pmu->pmu = (struct pmu) {
+		.sched_task	= armpmu_sched_task,
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
 		.event_init	= armpmu_event_init,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 0356cb6a215d..60d4e4c9b3ea 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -101,6 +101,7 @@ struct arm_pmu {
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
 	int		(*filter_match)(struct perf_event *event);
+	void		(*sched_task)(struct perf_event_context *ctx, bool sched_in);
 	int		num_events;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
-- 
2.25.1

