Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35218742DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjF2TpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjF2TpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:45:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9398D210E;
        Thu, 29 Jun 2023 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688067921; x=1719603921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=geT+oGQMxV2zFLyPGdH8g9ALOVFH/UnqOkB/8QWYnzQ=;
  b=JIzltdyGH9GudMgpcSz6JZcoQ6Ai9ioww1AFEs8We6g+bvZpn6AIxR1r
   PaGAgCw1tXFFpJnDeGhNpJJZkmhtEUCJejAPpKzfDtINVdpMho7Ze5Vz7
   lvE/RjLTsKuB9REgH0WHIWKsEiedVrln5fBRjUU4VSUr+QssHENrug++9
   wROZk7iY+Omr3Jhxupb3sqV9Ph7rwmMcHgrG+4CnaWdaLC5O6XuBdqNsi
   +ATqHjAZ1VV3JfdfTg+TihsSy5hvqGUlaZcOoZbPNfWGJ3icQViLxy2Vh
   KcWXeeSUBFynUrKZehhpEkW413tLX2P0Ks5uOT9lr1Yw0sEE18482mXXX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="425897624"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="425897624"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 12:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="694781644"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="694781644"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2023 12:45:15 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] cpufreq: intel_pstate: Fix scaling for hybrid capable system with disabled E-cores
Date:   Thu, 29 Jun 2023 12:45:09 -0700
Message-Id: <20230629194509.4094455-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some system BIOS configuration may provide option to disable E-cores.
As part of this change, CPUID feature for hybrid (Leaf 7 sub leaf 0,
EDX[15] = 0) may not be set. But HWP performance limits will still be
using a scaling factor like any other hybrid enabled system.

The current check for applying scaling factor will fail when hybrid
CPUID feature is not set. Only way to make sure that scaling should be
applied by checking CPPC nominal frequency and nominal performance. If
CPPC nominal frequency and nominal performance is defined and nominal
frequency is not in multiples of 100MHz of nominal performance, then use
hybrid scaling factor.

The above check will fail for non hybrid capable systems as they don't
publish nominal frequency field in CPPC, so this function can be used
for all HWP systems without additional cpu model check.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
Compile errors reported by kernel test robot and Rafael for the case
when CONFIG_ACPI is not defined

 drivers/cpufreq/intel_pstate.c | 58 ++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2548ec92faa2..7e18999be46a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -302,6 +302,13 @@ static bool hwp_forced __read_mostly;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
+#define HYBRID_SCALING_FACTOR	78741
+
+static inline int core_get_scaling(void)
+{
+	return 100000;
+}
+
 #ifdef CONFIG_ACPI
 static bool acpi_ppc;
 #endif
@@ -400,6 +407,25 @@ static int intel_pstate_get_cppc_guaranteed(int cpu)
 
 	return cppc_perf.nominal_perf;
 }
+
+static int intel_pstate_cppc_get_scaling(int cpu)
+{
+	struct cppc_perf_caps cppc_perf;
+	int ret;
+
+	ret = cppc_get_perf_caps(cpu, &cppc_perf);
+
+	/*
+	 * Check if nominal frequency is multiples of 100 MHz, if
+	 * not return hybrid scaling factor.
+	 */
+	if (!ret && cppc_perf.nominal_perf && cppc_perf.nominal_freq &&
+	    (cppc_perf.nominal_perf * 100 != cppc_perf.nominal_freq))
+		return HYBRID_SCALING_FACTOR;
+
+	return core_get_scaling();
+}
+
 #else /* CONFIG_ACPI_CPPC_LIB */
 static inline void intel_pstate_set_itmt_prio(int cpu)
 {
@@ -492,6 +518,11 @@ static inline int intel_pstate_get_cppc_guaranteed(int cpu)
 {
 	return -ENOTSUPP;
 }
+
+static int intel_pstate_cppc_get_scaling(int cpu)
+{
+	return core_get_scaling();
+}
 #endif /* CONFIG_ACPI_CPPC_LIB */
 
 /**
@@ -1895,11 +1926,6 @@ static int core_get_turbo_pstate(int cpu)
 	return ret;
 }
 
-static inline int core_get_scaling(void)
-{
-	return 100000;
-}
-
 static u64 core_get_val(struct cpudata *cpudata, int pstate)
 {
 	u64 val;
@@ -1936,16 +1962,29 @@ static void hybrid_get_type(void *data)
 	*cpu_type = get_this_hybrid_cpu_type();
 }
 
-static int hybrid_get_cpu_scaling(int cpu)
+static int hwp_get_cpu_scaling(int cpu)
 {
 	u8 cpu_type = 0;
 
 	smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
 	/* P-cores have a smaller perf level-to-freqency scaling factor. */
 	if (cpu_type == 0x40)
-		return 78741;
+		return HYBRID_SCALING_FACTOR;
 
-	return core_get_scaling();
+	/* Use default core scaling for E-cores */
+	if (cpu_type == 0x20)
+		return core_get_scaling();
+
+	/*
+	 * If reached here, it means that, this system is either non
+	 * hybrid system (like Tiger Lake) or hybrid capable system (like
+	 * Alder Lake or Raptor Lake) with no E cores (CPUID for hybrid
+	 * support is 0).
+	 * All non hybrid systems, don't publish nominal_frequency
+	 * field (means nominal frequency = 0), In that case
+	 * the legacy core scaling is used.
+	 */
+	return intel_pstate_cppc_get_scaling(cpu);
 }
 
 static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
@@ -3393,8 +3432,7 @@ static int __init intel_pstate_init(void)
 			if (!default_driver)
 				default_driver = &intel_pstate;
 
-			if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
-				pstate_funcs.get_cpu_scaling = hybrid_get_cpu_scaling;
+			pstate_funcs.get_cpu_scaling = hwp_get_cpu_scaling;
 
 			goto hwp_cpu_matched;
 		}
-- 
2.38.1

