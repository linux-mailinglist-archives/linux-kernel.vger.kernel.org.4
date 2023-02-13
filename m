Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD02C695063
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBMTIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBMTIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:08:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B181D20D13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676315284; x=1707851284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c/ssmWV2rsADLLuYj8FPgrlgffTVyCWr1wk53uQoQzs=;
  b=T7nwOSAwKCm6JusTwbhnPqd2EAQXqjU3LA+xw2/vs8ASzYfLxmNhPTQb
   lVsorpwn3Ac+bnX/yd/6WtD6W3ZC2Ot+05YRfswS1Y3iL+K0SQE/ojlSC
   038hyGVhIL6uQenesZsCvAR9lLruB9ba3EsVBR9Lnx5DIurWkOxBWrXeZ
   iIUsHr2hMdTiv/bFvABItsYGlaBIfqbB6mJeg3FwncTMlzUjLuPFM6ISM
   g//ZvxULY43xCZ05HhV333q1R3dpXMaXzb4bKpJUScmVK+N7J6AZ8awT/
   +0OSoIrfTGotUXD5ZMsucvDg/dk65CZJStv38M+euJgSIwHaik9N5suMI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333108728"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333108728"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:08:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668901940"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668901940"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 11:08:03 -0800
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, jstultz@google.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [RFC PATCH V2 3/9] perf/x86: Factor out x86_pmu_sample_preload()
Date:   Mon, 13 Feb 2023 11:07:48 -0800
Message-Id: <20230213190754.1836051-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230213190754.1836051-1-kan.liang@linux.intel.com>
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some common sample data are preloaded on X86 platforms before the sample
output. For example, the branch stack information.
Factor out a generic x86_pmu_sample_preload().

It will also be used later to preload the common HW time, TSC.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/core.c   | 3 +--
 arch/x86/events/core.c       | 5 +----
 arch/x86/events/intel/core.c | 3 +--
 arch/x86/events/intel/ds.c   | 3 +--
 arch/x86/events/perf_event.h | 8 ++++++++
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8c45b198b62f..af7b3977efa8 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -928,8 +928,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
+		x86_pmu_sample_preload(&data, event, cpuc);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 85a63a41c471..b19ac54ebeea 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1703,10 +1703,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event)) {
-			data.br_stack = &cpuc->lbr_stack;
-			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
-		}
+		x86_pmu_sample_preload(&data, event, cpuc);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 14f0a746257d..d9be5701e60a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3036,8 +3036,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
+		x86_pmu_sample_preload(&data, event, cpuc);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7980e92dec64..2f59573ed463 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1742,8 +1742,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	if (x86_pmu.intel_cap.pebs_format >= 3)
 		setup_pebs_time(event, data, pebs->tsc);
 
-	if (has_branch_stack(event))
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
+	x86_pmu_sample_preload(data, event, cpuc);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d6de4487348c..ae6ec58fde14 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1185,6 +1185,14 @@ int x86_pmu_handle_irq(struct pt_regs *regs);
 void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
 			  u64 intel_ctrl);
 
+static inline void x86_pmu_sample_preload(struct perf_sample_data *data,
+					  struct perf_event *event,
+					  struct cpu_hw_events *cpuc)
+{
+	if (has_branch_stack(event))
+		perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
+}
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
-- 
2.35.1

