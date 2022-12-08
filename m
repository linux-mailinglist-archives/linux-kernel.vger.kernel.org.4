Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF7A646AE2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLHIpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiLHIoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:44:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 996A0E0FE;
        Thu,  8 Dec 2022 00:44:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1297123A;
        Thu,  8 Dec 2022 00:44:50 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.40.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49CD83F73D;
        Thu,  8 Dec 2022 00:44:38 -0800 (PST)
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
Subject: [PATCH V6 3/7] arm64/perf: Add branch stack support in struct arm_pmu
Date:   Thu,  8 Dec 2022 14:13:58 +0530
Message-Id: <20221208084402.863310-4-anshuman.khandual@arm.com>
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

This updates 'struct arm_pmu' for branch stack sampling support later. This
adds a new 'features' element in the structure to track supported features,
and another 'hw_attr' element to encapsulate implementation attributes on a
given 'struct arm_pmu'. These updates here will help in tracking any branch
stack sampling support, which is being added later. This also adds a helper
arm_pmu_branch_stack_supported().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/perf/arm_pmu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 60d4e4c9b3ea..8c4f42189904 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -80,11 +80,14 @@ enum armpmu_attr_groups {
 	ARMPMU_NR_ATTR_GROUPS
 };
 
+#define ARM_PMU_BRANCH_STACK	BIT(0)
+
 struct arm_pmu {
 	struct pmu	pmu;
 	cpumask_t	supported_cpus;
 	char		*name;
 	int		pmuver;
+	int		features;
 	irqreturn_t	(*handle_irq)(struct arm_pmu *pmu);
 	void		(*enable)(struct perf_event *event);
 	void		(*disable)(struct perf_event *event);
@@ -119,8 +122,14 @@ struct arm_pmu {
 
 	/* Only to be used by ACPI probing code */
 	unsigned long acpi_cpuid;
+	void		*hw_attr;
 };
 
+static inline bool arm_pmu_branch_stack_supported(struct arm_pmu *armpmu)
+{
+	return armpmu->features & ARM_PMU_BRANCH_STACK;
+}
+
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
 
 u64 armpmu_event_update(struct perf_event *event);
-- 
2.25.1

