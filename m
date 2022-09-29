Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4B5EEFD6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiI2H7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiI2H7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:59:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F171213AF3D;
        Thu, 29 Sep 2022 00:59:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9C48139F;
        Thu, 29 Sep 2022 00:59:26 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47CC73F73D;
        Thu, 29 Sep 2022 00:59:16 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH V3 3/7] arm64/perf: Update struct pmu_hw_events for BRBE
Date:   Thu, 29 Sep 2022 13:28:53 +0530
Message-Id: <20220929075857.158358-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929075857.158358-1-anshuman.khandual@arm.com>
References: <20220929075857.158358-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single perf event instance BRBE related contexts and data will be tracked
in struct pmu_hw_events. Hence update the structure to accommodate required
details related to BRBE.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_pmu.c       |  1 +
 include/linux/perf/arm_pmu.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 59d3980b8ca2..16fda9a1229f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -905,6 +905,7 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 
 		events = per_cpu_ptr(pmu->hw_events, cpu);
 		raw_spin_lock_init(&events->pmu_lock);
+		events->branches = kmalloc(sizeof(struct brbe_records), flags);
 		events->percpu_pmu = pmu;
 	}
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 3d427ac0ca45..ffce43ceb670 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -43,6 +43,16 @@
 	},								\
 }
 
+/*
+ * Maximum branch records in BRBE
+ */
+#define BRBE_MAX_ENTRIES 64
+
+struct brbe_records {
+	struct perf_branch_stack	brbe_stack;
+	struct perf_branch_entry	brbe_entries[BRBE_MAX_ENTRIES];
+};
+
 /* The events for a given PMU register set. */
 struct pmu_hw_events {
 	/*
@@ -69,6 +79,22 @@ struct pmu_hw_events {
 	struct arm_pmu		*percpu_pmu;
 
 	int irq;
+
+	/* Detected BRBE attributes */
+	bool				v1p1;
+	int				brbe_cc;
+	int				brbe_nr;
+
+	/* Evaluated BRBE configuration */
+	u64				brbfcr;
+	u64				brbcr;
+
+	/* Tracked BRBE context */
+	unsigned int			brbe_users;
+	void				*brbe_context;
+
+	/* Captured BRBE buffer - copied as is into perf_sample_data */
+	struct brbe_records		*branches;
 };
 
 enum armpmu_attr_groups {
-- 
2.25.1

