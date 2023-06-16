Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF4733453
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbjFPPJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345846AbjFPPIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:08:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62310358C;
        Fri, 16 Jun 2023 08:08:43 -0700 (PDT)
Date:   Fri, 16 Jun 2023 15:08:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686928121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MWN9/UVJSfR8UNKg5ncnrUXsrX5NsjGgJXK/AFJEOIU=;
        b=0bE4Ms5rZYj/Ya7VR/VM2vqJn6G9RfZ5d+VdljhLagkZXz6smXDdSnXsj80bET+r49GHa6
        v0zcFOIX6i5l5U3LiTTq2BvEurboGW8NBkol4tcH+DxURITI7mczOG2HR94jK0e160OKSR
        IEQGPC4Qo4w6d5ia48bG2zj2X1xSa1BmiMtW/I+bGHpmsuenS4PZ6bssDRwSLt1om7An4/
        QdhxDRYvwLu3DN+hW/P0hr1TNbz66H00U49IaXEwVRty2x+ECbPMbybgmkMF+Rnjap6HD3
        2bPUoIR59NFbaa9GOVDSeYhZUhdAJWl2e3oOOGqdOx3b2avnNPDzAyvLxDK7Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686928121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MWN9/UVJSfR8UNKg5ncnrUXsrX5NsjGgJXK/AFJEOIU=;
        b=mDFCWnYOqeaKx4iNd1H/UoIwXlJfwnJXK2vQaNbjJjR5U1pOGCx1Is+eO+C+avWvcEx9C1
        dBI2gtFljm3sFjCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230615173242.3726364-1-kan.liang@linux.intel.com>
References: <20230615173242.3726364-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168692812071.404.11837107430102881683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a6742cb90b567f952a95efa27dee345748d09fc7
Gitweb:        https://git.kernel.org/tip/a6742cb90b567f952a95efa27dee345748d09fc7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 15 Jun 2023 10:32:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 16:46:33 +02:00

perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL

When counting a FRONTEND event, the MSR_PEBS_FRONTEND is not correctly
set on GNR and MTL p-core.

The umask value for the FRONTEND events is changed on GNR and MTL. The
new umask is missing in the extra_regs[] table.

Add a dedicated intel_gnr_extra_regs[] for GNR and MTL p-core.

Fixes: bc4000fdb009 ("perf/x86/intel: Add Granite Rapids")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20230615173242.3726364-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 89b9c1c..27f3a7b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -349,6 +349,16 @@ static struct event_constraint intel_spr_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+static struct extra_reg intel_gnr_extra_regs[] __read_mostly = {
+	INTEL_UEVENT_EXTRA_REG(0x012a, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x012b, MSR_OFFCORE_RSP_1, 0x3fffffffffull, RSP_1),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
+	INTEL_UEVENT_EXTRA_REG(0x02c6, MSR_PEBS_FRONTEND, 0x9, FE),
+	INTEL_UEVENT_EXTRA_REG(0x03c6, MSR_PEBS_FRONTEND, 0x7fff1f, FE),
+	INTEL_UEVENT_EXTRA_REG(0x40ad, MSR_PEBS_FRONTEND, 0x7, FE),
+	INTEL_UEVENT_EXTRA_REG(0x04c2, MSR_PEBS_FRONTEND, 0x8, FE),
+	EVENT_EXTRA_END
+};
 
 EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
@@ -6496,6 +6506,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 	case INTEL_FAM6_EMERALDRAPIDS_X:
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
+		x86_pmu.extra_regs = intel_spr_extra_regs;
 		fallthrough;
 	case INTEL_FAM6_GRANITERAPIDS_X:
 	case INTEL_FAM6_GRANITERAPIDS_D:
@@ -6506,7 +6517,8 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.event_constraints = intel_spr_event_constraints;
 		x86_pmu.pebs_constraints = intel_spr_pebs_event_constraints;
-		x86_pmu.extra_regs = intel_spr_extra_regs;
+		if (!x86_pmu.extra_regs)
+			x86_pmu.extra_regs = intel_gnr_extra_regs;
 		x86_pmu.limit_period = spr_limit_period;
 		x86_pmu.pebs_ept = 1;
 		x86_pmu.pebs_aliases = NULL;
@@ -6650,6 +6662,7 @@ __init int intel_pmu_init(void)
 		pmu->pebs_constraints = intel_grt_pebs_event_constraints;
 		pmu->extra_regs = intel_grt_extra_regs;
 		if (is_mtl(boot_cpu_data.x86_model)) {
+			x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].extra_regs = intel_gnr_extra_regs;
 			x86_pmu.pebs_latency_data = mtl_latency_data_small;
 			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 				mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
