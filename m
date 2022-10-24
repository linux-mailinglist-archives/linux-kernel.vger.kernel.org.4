Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF91360BF05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJXXxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJXXxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:53:00 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9127A3362FE;
        Mon, 24 Oct 2022 15:10:49 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 1e047c12660352c6; Mon, 24 Oct 2022 21:23:36 +0200
Received: from kreacher.localnet (unknown [213.134.163.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 46B5F6692BC;
        Mon, 24 Oct 2022 21:23:35 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH v1 1/2] cpufreq: intel_pstate: Read all MSRs on the target CPU
Date:   Mon, 24 Oct 2022 21:21:00 +0200
Message-ID: <3195597.aeNJFYEL58@kreacher>
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

Some of the MSR accesses in intel_pstate are carried out on the CPU
that is running the code, but the values coming from them are used
for the performance scaling of the other CPUs.

This is problematic, for example, on hybrid platforms where
MSR_TURBO_RATIO_LIMIT for P-cores and E-cores is different, so the
values read from it on a P-core are generally not applicable to E-cores
and the other way around.

For this reason, make the driver access all MSRs on the target CPU on
platforms using the "core" pstate_funcs callbacks which is the case for
all of the hybrid platforms released to date.  For this purpose, pass
a CPU argument to the ->get_max(), ->get_max_physical(), ->get_min()
and ->get_turbo() pstate_funcs callbacks and from there pass it to
rdmsrl_on_cpu() or rdmsrl_safe_on_cpu() to access the MSR on the target
CPU.

Fixes: 46573fd6369f ("cpufreq: intel_pstate: hybrid: Rework HWP calibration")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   66 ++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -280,10 +280,10 @@ static struct cpudata **all_cpu_data;
  * structure is used to store those callbacks.
  */
 struct pstate_funcs {
-	int (*get_max)(void);
-	int (*get_max_physical)(void);
-	int (*get_min)(void);
-	int (*get_turbo)(void);
+	int (*get_max)(int cpu);
+	int (*get_max_physical)(int cpu);
+	int (*get_min)(int cpu);
+	int (*get_turbo)(int cpu);
 	int (*get_scaling)(void);
 	int (*get_cpu_scaling)(int cpu);
 	int (*get_aperf_mperf_shift)(void);
@@ -531,12 +531,12 @@ static void intel_pstate_hybrid_hwp_adju
 {
 	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
 	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
-	int perf_ctl_turbo = pstate_funcs.get_turbo();
+	int perf_ctl_turbo = pstate_funcs.get_turbo(cpu->cpu);
 	int turbo_freq = perf_ctl_turbo * perf_ctl_scaling;
 	int scaling = cpu->pstate.scaling;
 
 	pr_debug("CPU%d: perf_ctl_max_phys = %d\n", cpu->cpu, perf_ctl_max_phys);
-	pr_debug("CPU%d: perf_ctl_max = %d\n", cpu->cpu, pstate_funcs.get_max());
+	pr_debug("CPU%d: perf_ctl_max = %d\n", cpu->cpu, pstate_funcs.get_max(cpu->cpu));
 	pr_debug("CPU%d: perf_ctl_turbo = %d\n", cpu->cpu, perf_ctl_turbo);
 	pr_debug("CPU%d: perf_ctl_scaling = %d\n", cpu->cpu, perf_ctl_scaling);
 	pr_debug("CPU%d: HWP_CAP guaranteed = %d\n", cpu->cpu, cpu->pstate.max_pstate);
@@ -1740,7 +1740,7 @@ static void intel_pstate_hwp_enable(stru
 	intel_pstate_update_epp_defaults(cpudata);
 }
 
-static int atom_get_min_pstate(void)
+static int atom_get_min_pstate(int not_used)
 {
 	u64 value;
 
@@ -1748,7 +1748,7 @@ static int atom_get_min_pstate(void)
 	return (value >> 8) & 0x7F;
 }
 
-static int atom_get_max_pstate(void)
+static int atom_get_max_pstate(int not_used)
 {
 	u64 value;
 
@@ -1756,7 +1756,7 @@ static int atom_get_max_pstate(void)
 	return (value >> 16) & 0x7F;
 }
 
-static int atom_get_turbo_pstate(void)
+static int atom_get_turbo_pstate(int not_used)
 {
 	u64 value;
 
@@ -1834,23 +1834,23 @@ static void atom_get_vid(struct cpudata
 	cpudata->vid.turbo = value & 0x7f;
 }
 
-static int core_get_min_pstate(void)
+static int core_get_min_pstate(int cpu)
 {
 	u64 value;
 
-	rdmsrl(MSR_PLATFORM_INFO, value);
+	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
 	return (value >> 40) & 0xFF;
 }
 
-static int core_get_max_pstate_physical(void)
+static int core_get_max_pstate_physical(int cpu)
 {
 	u64 value;
 
-	rdmsrl(MSR_PLATFORM_INFO, value);
+	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
 	return (value >> 8) & 0xFF;
 }
 
-static int core_get_tdp_ratio(u64 plat_info)
+static int core_get_tdp_ratio(int cpu, u64 plat_info)
 {
 	/* Check how many TDP levels present */
 	if (plat_info & 0x600000000) {
@@ -1860,13 +1860,13 @@ static int core_get_tdp_ratio(u64 plat_i
 		int err;
 
 		/* Get the TDP level (0, 1, 2) to get ratios */
-		err = rdmsrl_safe(MSR_CONFIG_TDP_CONTROL, &tdp_ctrl);
+		err = rdmsrl_safe_on_cpu(cpu, MSR_CONFIG_TDP_CONTROL, &tdp_ctrl);
 		if (err)
 			return err;
 
 		/* TDP MSR are continuous starting at 0x648 */
 		tdp_msr = MSR_CONFIG_TDP_NOMINAL + (tdp_ctrl & 0x03);
-		err = rdmsrl_safe(tdp_msr, &tdp_ratio);
+		err = rdmsrl_safe_on_cpu(cpu, tdp_msr, &tdp_ratio);
 		if (err)
 			return err;
 
@@ -1883,7 +1883,7 @@ static int core_get_tdp_ratio(u64 plat_i
 	return -ENXIO;
 }
 
-static int core_get_max_pstate(void)
+static int core_get_max_pstate(int cpu)
 {
 	u64 tar;
 	u64 plat_info;
@@ -1891,10 +1891,10 @@ static int core_get_max_pstate(void)
 	int tdp_ratio;
 	int err;
 
-	rdmsrl(MSR_PLATFORM_INFO, plat_info);
+	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
 	max_pstate = (plat_info >> 8) & 0xFF;
 
-	tdp_ratio = core_get_tdp_ratio(plat_info);
+	tdp_ratio = core_get_tdp_ratio(cpu, plat_info);
 	if (tdp_ratio <= 0)
 		return max_pstate;
 
@@ -1903,7 +1903,7 @@ static int core_get_max_pstate(void)
 		return tdp_ratio;
 	}
 
-	err = rdmsrl_safe(MSR_TURBO_ACTIVATION_RATIO, &tar);
+	err = rdmsrl_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO, &tar);
 	if (!err) {
 		int tar_levels;
 
@@ -1918,13 +1918,13 @@ static int core_get_max_pstate(void)
 	return max_pstate;
 }
 
-static int core_get_turbo_pstate(void)
+static int core_get_turbo_pstate(int cpu)
 {
 	u64 value;
 	int nont, ret;
 
-	rdmsrl(MSR_TURBO_RATIO_LIMIT, value);
-	nont = core_get_max_pstate();
+	rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
+	nont = core_get_max_pstate(cpu);
 	ret = (value) & 255;
 	if (ret <= nont)
 		ret = nont;
@@ -1952,13 +1952,13 @@ static int knl_get_aperf_mperf_shift(voi
 	return 10;
 }
 
-static int knl_get_turbo_pstate(void)
+static int knl_get_turbo_pstate(int cpu)
 {
 	u64 value;
 	int nont, ret;
 
-	rdmsrl(MSR_TURBO_RATIO_LIMIT, value);
-	nont = core_get_max_pstate();
+	rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
+	nont = core_get_max_pstate(cpu);
 	ret = (((value) >> 8) & 0xFF);
 	if (ret <= nont)
 		ret = nont;
@@ -2025,10 +2025,10 @@ static void intel_pstate_max_within_limi
 
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
-	int perf_ctl_max_phys = pstate_funcs.get_max_physical();
+	int perf_ctl_max_phys = pstate_funcs.get_max_physical(cpu->cpu);
 	int perf_ctl_scaling = pstate_funcs.get_scaling();
 
-	cpu->pstate.min_pstate = pstate_funcs.get_min();
+	cpu->pstate.min_pstate = pstate_funcs.get_min(cpu->cpu);
 	cpu->pstate.max_pstate_physical = perf_ctl_max_phys;
 	cpu->pstate.perf_ctl_scaling = perf_ctl_scaling;
 
@@ -2044,8 +2044,8 @@ static void intel_pstate_get_cpu_pstates
 		}
 	} else {
 		cpu->pstate.scaling = perf_ctl_scaling;
-		cpu->pstate.max_pstate = pstate_funcs.get_max();
-		cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
+		cpu->pstate.max_pstate = pstate_funcs.get_max(cpu->cpu);
+		cpu->pstate.turbo_pstate = pstate_funcs.get_turbo(cpu->cpu);
 	}
 
 	if (cpu->pstate.scaling == perf_ctl_scaling) {
@@ -3221,9 +3221,9 @@ static unsigned int force_load __initdat
 
 static int __init intel_pstate_msrs_not_valid(void)
 {
-	if (!pstate_funcs.get_max() ||
-	    !pstate_funcs.get_min() ||
-	    !pstate_funcs.get_turbo())
+	if (!pstate_funcs.get_max(0) ||
+	    !pstate_funcs.get_min(0) ||
+	    !pstate_funcs.get_turbo(0))
 		return -ENODEV;
 
 	return 0;



