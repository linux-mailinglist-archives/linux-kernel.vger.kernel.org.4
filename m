Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B89665DD75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjADUOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbjADUOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:14:11 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB991BE8E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672863250; x=1704399250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=970u/0g+e4dGCNxze4E0X7C5IVyu6CmpruauqCZkzzc=;
  b=XgDVi17bwbpIbHxh02ToEBxXibxTAb8omb/dPzTWOoGCVt9myje9Hviv
   BNMk0Ch33eQ8iDvbCwQOi9Qq8Bfg3YQElOE/C45EkiWRNq46oi7a3SgXk
   L9UKWXTlnk6LTZAZxJfk/wyN9W6zR2zkfrVuTKwe2im3Fkba22KD/orb/
   WoFXa8NB5KDbPDlQRnJ9BLWfosBPl5m6oyJ1Pi7f6yrYHaDI9qyMDX98z
   dt6LGwoCGmaK9XpcufVdxy7wNutmTeJlxoQW2k5ouaIGEOG/kaReJga1E
   YYKQcdSTI0EYK8hM9NRKPOSSg1TNbT0QGdNiFrumUJvjZdvuGsFwjvXez
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322105472"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="322105472"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:14:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779324005"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="779324005"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 12:14:10 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 5/9] perf/x86/intel: Support Architectural PerfMon Extension leaf
Date:   Wed,  4 Jan 2023 12:13:45 -0800
Message-Id: <20230104201349.1451191-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104201349.1451191-1-kan.liang@linux.intel.com>
References: <20230104201349.1451191-1-kan.liang@linux.intel.com>
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

The new CPUID leaf 0x23 reports the "true view" of PMU resources.

The sub-leaf 1 reports the available general-purpose counters and fixed
counters. Update the number of counters and fixed counters when the
sub-leaf is detected.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No change since V1

 arch/x86/events/intel/core.c      | 22 ++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h |  8 ++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a5678ab6d3e3..29d2d0411caf 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4588,6 +4588,25 @@ static void flip_smm_bit(void *data)
 	}
 }
 
+static void intel_pmu_check_num_counters(int *num_counters,
+					 int *num_counters_fixed,
+					 u64 *intel_ctrl, u64 fixed_mask);
+
+static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
+{
+	unsigned int sub_bitmaps = cpuid_eax(ARCH_PERFMON_EXT_LEAF);
+	unsigned int eax, ebx, ecx, edx;
+
+	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
+			    &eax, &ebx, &ecx, &edx);
+		pmu->num_counters = fls(eax);
+		pmu->num_counters_fixed = fls(ebx);
+		intel_pmu_check_num_counters(&pmu->num_counters, &pmu->num_counters_fixed,
+					     &pmu->intel_ctrl, ebx);
+	}
+}
+
 static bool init_hybrid_pmu(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
@@ -4613,6 +4632,9 @@ static bool init_hybrid_pmu(int cpu)
 	if (!cpumask_empty(&pmu->supported_cpus))
 		goto end;
 
+	if (this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
+		update_pmu_cap(pmu);
+
 	if (!check_hw_exists(&pmu->pmu, pmu->num_counters, pmu->num_counters_fixed))
 		return false;
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 5d0f6891ae61..6496bdbcac98 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -159,6 +159,14 @@ union cpuid10_edx {
 	unsigned int full;
 };
 
+/*
+ * Intel "Architectural Performance Monitoring extension" CPUID
+ * detection/enumeration details:
+ */
+#define ARCH_PERFMON_EXT_LEAF			0x00000023
+#define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
+#define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
+
 /*
  * Intel Architectural LBR CPUID detection/enumeration details:
  */
-- 
2.35.1

