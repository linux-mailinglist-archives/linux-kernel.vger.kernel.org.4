Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9226660BF0C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJXXx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiJXXxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:53:19 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B8F1911C5;
        Mon, 24 Oct 2022 15:10:59 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 7f9f6f99fe18a591; Mon, 24 Oct 2022 21:23:34 +0200
Received: from kreacher.localnet (unknown [213.134.163.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D31266692BC;
        Mon, 24 Oct 2022 21:23:33 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH v1 2/2] cpufreq: intel_pstate: hybrid: Use known scaling factor for P-cores
Date:   Mon, 24 Oct 2022 21:22:48 +0200
Message-ID: <8132750.T7Z3S40VBb@kreacher>
In-Reply-To: <2258064.ElGaqSPkdT@kreacher>
References: <2258064.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.181
X-CLIENT-HOSTNAME: 213.134.163.181
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgudefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudeifedrudekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddukedupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhdrsghrohifnhesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghl
 rdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 46573fd6369f ("cpufreq: intel_pstate: hybrid: Rework HWP
calibration") attempted to use the information from CPPC (the nominal
performance in particular) to obtain the scaling factor allowing the
frequency to be computed if the HWP performance level of the given CPU
is known or vice versa.

However, it turns out that on some platforms this doesn't work, because
the CPPC information on them does not align with the contents of the
MSR_HWP_CAPABILITIES registers.

This basically means that the only way to make intel_pstate work on all
of the hybrid platforms to date is to use the observation that on all
of them the scaling factor between the HWP performance levels and
frequency for P-cores is 78741 (approximately 100000/1.27).  For
E-cores it is 100000, which is the same as for all of the non-hybrid
"core" platforms and does not require any changes.

Accordingly, make intel_pstate use 78741 as the scaling factor between
HWP performance levels and frequency for P-cores on all hybrid platforms
and drop the dependency of the HWP calibration code on CPPC.

Fixes: 46573fd6369f ("cpufreq: intel_pstate: hybrid: Rework HWP calibration")
Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   69 ++++++++---------------------------------
 1 file changed, 15 insertions(+), 54 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -27,6 +27,7 @@
 #include <linux/pm_qos.h>
 #include <trace/events/power.h>
 
+#include <asm/cpu.h>
 #include <asm/div64.h>
 #include <asm/msr.h>
 #include <asm/cpu_device_id.h>
@@ -398,16 +399,6 @@ static int intel_pstate_get_cppc_guarant
 
 	return cppc_perf.nominal_perf;
 }
-
-static u32 intel_pstate_cppc_nominal(int cpu)
-{
-	u64 nominal_perf;
-
-	if (cppc_get_nominal_perf(cpu, &nominal_perf))
-		return 0;
-
-	return nominal_perf;
-}
 #else /* CONFIG_ACPI_CPPC_LIB */
 static inline void intel_pstate_set_itmt_prio(int cpu)
 {
@@ -532,34 +523,17 @@ static void intel_pstate_hybrid_hwp_adju
 	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
 	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
 	int perf_ctl_turbo = pstate_funcs.get_turbo(cpu->cpu);
-	int turbo_freq = perf_ctl_turbo * perf_ctl_scaling;
 	int scaling = cpu->pstate.scaling;
 
 	pr_debug("CPU%d: perf_ctl_max_phys = %d\n", cpu->cpu, perf_ctl_max_phys);
-	pr_debug("CPU%d: perf_ctl_max = %d\n", cpu->cpu, pstate_funcs.get_max(cpu->cpu));
 	pr_debug("CPU%d: perf_ctl_turbo = %d\n", cpu->cpu, perf_ctl_turbo);
 	pr_debug("CPU%d: perf_ctl_scaling = %d\n", cpu->cpu, perf_ctl_scaling);
 	pr_debug("CPU%d: HWP_CAP guaranteed = %d\n", cpu->cpu, cpu->pstate.max_pstate);
 	pr_debug("CPU%d: HWP_CAP highest = %d\n", cpu->cpu, cpu->pstate.turbo_pstate);
 	pr_debug("CPU%d: HWP-to-frequency scaling factor: %d\n", cpu->cpu, scaling);
 
-	/*
-	 * If the product of the HWP performance scaling factor and the HWP_CAP
-	 * highest performance is greater than the maximum turbo frequency
-	 * corresponding to the pstate_funcs.get_turbo() return value, the
-	 * scaling factor is too high, so recompute it to make the HWP_CAP
-	 * highest performance correspond to the maximum turbo frequency.
-	 */
-	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * scaling;
-	if (turbo_freq < cpu->pstate.turbo_freq) {
-		cpu->pstate.turbo_freq = turbo_freq;
-		scaling = DIV_ROUND_UP(turbo_freq, cpu->pstate.turbo_pstate);
-		cpu->pstate.scaling = scaling;
-
-		pr_debug("CPU%d: refined HWP-to-frequency scaling factor: %d\n",
-			 cpu->cpu, scaling);
-	}
-
+	cpu->pstate.turbo_freq = rounddown(cpu->pstate.turbo_pstate * scaling,
+					   perf_ctl_scaling);
 	cpu->pstate.max_freq = rounddown(cpu->pstate.max_pstate * scaling,
 					 perf_ctl_scaling);
 
@@ -1965,37 +1939,24 @@ static int knl_get_turbo_pstate(int cpu)
 	return ret;
 }
 
-#ifdef CONFIG_ACPI_CPPC_LIB
-static u32 hybrid_ref_perf;
-
-static int hybrid_get_cpu_scaling(int cpu)
+static void hybrid_get_type(void *data)
 {
-	return DIV_ROUND_UP(core_get_scaling() * hybrid_ref_perf,
-			    intel_pstate_cppc_nominal(cpu));
+	u8 *cpu_type = data;
+
+	*cpu_type = get_this_hybrid_cpu_type();
 }
 
-static void intel_pstate_cppc_set_cpu_scaling(void)
+static int hybrid_get_cpu_scaling(int cpu)
 {
-	u32 min_nominal_perf = U32_MAX;
-	int cpu;
+	u8 cpu_type = 0;
 
-	for_each_present_cpu(cpu) {
-		u32 nominal_perf = intel_pstate_cppc_nominal(cpu);
+	smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
+	/* P-cores have a smaller perf level-to-freqency scaling factor. */
+	if (cpu_type == 0x40)
+		return 78741;
 
-		if (nominal_perf && nominal_perf < min_nominal_perf)
-			min_nominal_perf = nominal_perf;
-	}
-
-	if (min_nominal_perf < U32_MAX) {
-		hybrid_ref_perf = min_nominal_perf;
-		pstate_funcs.get_cpu_scaling = hybrid_get_cpu_scaling;
-	}
+	return core_get_scaling();
 }
-#else
-static inline void intel_pstate_cppc_set_cpu_scaling(void)
-{
-}
-#endif /* CONFIG_ACPI_CPPC_LIB */
 
 static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 {
@@ -3450,7 +3411,7 @@ static int __init intel_pstate_init(void
 				default_driver = &intel_pstate;
 
 			if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
-				intel_pstate_cppc_set_cpu_scaling();
+				pstate_funcs.get_cpu_scaling = hybrid_get_cpu_scaling;
 
 			goto hwp_cpu_matched;
 		}



