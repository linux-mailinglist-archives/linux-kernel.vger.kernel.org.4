Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C4C5B325F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiIIIwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIIIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BD812B365;
        Fri,  9 Sep 2022 01:52:37 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=df1Z6P2tJqbbKAD+5iJN0WRGAbe9hGKW/QVVuMizVvM=;
        b=dfmoC3FUSHU277kh43c55Lk+rT3WdPZXZe0gzks/QVO8c+6CV6Ifdi9vGJP3pdDETSrA+U
        MgeOdGtvwb56WU52GG3hulgslWY7WNyxdF3ok51KTQCqMjEduVfIPHYjHRNosxjjVS2Ekp
        A0Kf07EBC3Z+SzeYR5CwwSEnZzYNjL0EB7I1TzcWD+esjsYh2KVtFobNuxiIs1UsMv/29O
        LG20bKenaH3qC8yx7FF+8XDxDdKq2gAYwS4Kg1SeeA2XVLavO3csz0CO5C9Six7u93LuCR
        oi1q9l9iS3kkVEfSj8Pik2l4vE76hITfpqbZGpIGcX5MV9LDQ4DUP+lZAI+AhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=df1Z6P2tJqbbKAD+5iJN0WRGAbe9hGKW/QVVuMizVvM=;
        b=4/w1nJMTRvTMOMChkmjRfi+dBJWnFhtveaT2Q1Pk9hmoDNsr9unqpeVRrF0i9Ywhlgo/RI
        bzEC5VOUEsFUq/Cw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Optimize FIXED_CTR_CTRL access
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220804140729.2951259-1-kan.liang@linux.intel.com>
References: <20220804140729.2951259-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166271355396.401.13292491978156019931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fae9ebde9696385fa2e993e752cf68d9781f3ea0
Gitweb:        https://git.kernel.org/tip/fae9ebde9696385fa2e993e752cf68d9781f3ea0
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 04 Aug 2022 07:07:29 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:04 +02:00

perf/x86/intel: Optimize FIXED_CTR_CTRL access

All the fixed counters share a fixed control register. The current
perf reads and re-writes the fixed control register for each fixed
counter disable/enable, which is unnecessary.

When changing the fixed control register, the entire PMU must be
disabled via the global control register. The changing cannot be taken
effect until the entire PMU is re-enabled. Only updating the fixed
control register once right before the entire PMU re-enabling is
enough.

The read of the fixed control register is not necessary either. The
value can be cached in the per CPU cpu_hw_events.

Test results:

Counting all the fixed counters with the perf bench sched pipe as below
on a SPR machine.

 $perf stat -e cycles,instructions,ref-cycles,slots --no-inherit --
  taskset -c 1 perf bench sched pipe

The Total elapsed time reduces from 5.36s (without the patch) to 4.99s
(with the patch), which is ~6.9% improvement.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220804140729.2951259-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 22 +++++++++++++---------
 arch/x86/events/perf_event.h |  4 ++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1e429e8..7f4e7e6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2190,6 +2190,12 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
 	intel_pmu_lbr_enable_all(pmi);
+
+	if (cpuc->fixed_ctrl_val != cpuc->active_fixed_ctrl_val) {
+		wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cpuc->fixed_ctrl_val);
+		cpuc->active_fixed_ctrl_val = cpuc->fixed_ctrl_val;
+	}
+
 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL,
 	       intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
 
@@ -2407,9 +2413,10 @@ static inline void intel_clear_masks(struct perf_event *event, int idx)
 
 static void intel_pmu_disable_fixed(struct perf_event *event)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	u64 ctrl_val, mask;
 	int idx = hwc->idx;
+	u64 mask;
 
 	if (is_topdown_idx(idx)) {
 		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -2426,9 +2433,7 @@ static void intel_pmu_disable_fixed(struct perf_event *event)
 	intel_clear_masks(event, idx);
 
 	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
-	rdmsrl(hwc->config_base, ctrl_val);
-	ctrl_val &= ~mask;
-	wrmsrl(hwc->config_base, ctrl_val);
+	cpuc->fixed_ctrl_val &= ~mask;
 }
 
 static void intel_pmu_disable_event(struct perf_event *event)
@@ -2701,8 +2706,9 @@ static void intel_pmu_read_event(struct perf_event *event)
 
 static void intel_pmu_enable_fixed(struct perf_event *event)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	u64 ctrl_val, mask, bits = 0;
+	u64 mask, bits = 0;
 	int idx = hwc->idx;
 
 	if (is_topdown_idx(idx)) {
@@ -2746,10 +2752,8 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 		mask |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
 	}
 
-	rdmsrl(hwc->config_base, ctrl_val);
-	ctrl_val &= ~mask;
-	ctrl_val |= bits;
-	wrmsrl(hwc->config_base, ctrl_val);
+	cpuc->fixed_ctrl_val &= ~mask;
+	cpuc->fixed_ctrl_val |= bits;
 }
 
 static void intel_pmu_enable_event(struct perf_event *event)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 20c2ee2..3719670 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -270,6 +270,10 @@ struct cpu_hw_events {
 	u64			active_pebs_data_cfg;
 	int			pebs_record_size;
 
+	/* Intel Fixed counter configuration */
+	u64			fixed_ctrl_val;
+	u64			active_fixed_ctrl_val;
+
 	/*
 	 * Intel LBR bits
 	 */
