Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0DB70A857
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjETNc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 09:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjETNc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 09:32:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229F8101;
        Sat, 20 May 2023 06:32:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d4e45971bso184757b3a.2;
        Sat, 20 May 2023 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684589575; x=1687181575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iiLcYMUpXhR3oS34Vgx4ZvB+MvhBvpRDLmCWtryg/3g=;
        b=gbFI3+d95lbF6o6H7jIG0JwL+IxsymQ8vhSzvTYEcgyKIQqdV5Flzso81x4hP49vBx
         KH2ZUQuc4KbDMJjIVa0YbZZlAHsopMhjoaKyB+SJ0s6BSCb4RKTIzEllYARaLy3dFYxz
         zcfEroJON69L81HY7+tD4rYG1zVGbA1oWy39Cd9gvfpyQTMQaRjjavut+y8Fct2TLIMh
         xowU43jZz/whtrKHCRXhlt44Yu/J9o9EYtYoqstDTGkUpJUrDGpafV5/Z9prpgyMoHtI
         Oh6rfVzMPMoO8ElQQgc/a99iUyf8JzCI30Shm8o8Yr5HsCtCCyr7aKPskq95xV9HP0sZ
         tJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684589575; x=1687181575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiLcYMUpXhR3oS34Vgx4ZvB+MvhBvpRDLmCWtryg/3g=;
        b=GkW39jcZ7nNkc8ZyfYiVxJFq4BpPG+cPEiC/hGvOm4xry8aHVGyyvaqR4V0zx4jQTc
         MKgA/GWt5UXd0oMkbRF7fIbODzjj5mNIY+HeFY4bZZJjJdKNZ0szq3sBVAK2B66G/pOl
         NtZ9bahYpUtNuQuck5JEJ+wAyyFj7erBq70UaQLds5IppSFkGRZLHOaA/RLIqXo23ov+
         AyOtj+W01GOoo0JbAxoFXAxavCPGJa0+ipZkOBfH/znaPVOVL+0HKyo5GWbe/CyZIHty
         pvr34Ermiku+L7epjNrbLEt+hJL1UFw4gTKnoffY72ZPkp6QYSRGkHbYI9gLEVQOGwdT
         jKpg==
X-Gm-Message-State: AC+VfDxUMMwZfFUwsUWIvJo6yf1kshC8xquSf8VqH7hrT1WvHGdT75+P
        I+gI7K2MS/BdkGb1ffRw9nI=
X-Google-Smtp-Source: ACHHUZ6JEMwXuV2OYIuWH0SGjEcCh/NhsfV6iz4//3jcPLKusA22Pfcs5eSL3QM1ZnEOofINer0pQg==
X-Received: by 2002:a05:6a00:ac4:b0:64a:5cde:3a7d with SMTP id c4-20020a056a000ac400b0064a5cde3a7dmr7274408pfl.27.1684589575398;
        Sat, 20 May 2023 06:32:55 -0700 (PDT)
Received: from localhost.localdomain ([202.160.36.160])
        by smtp.googlemail.com with ESMTPSA id x18-20020aa79192000000b00642ea56f06dsm1285792pfa.26.2023.05.20.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 06:32:54 -0700 (PDT)
From:   Fieah Lim <kweifat@gmail.com>
To:     srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fieah Lim <kweifat@gmail.com>
Subject: [PATCH] cpufreq: intel_pstate: Avoid initializing variables prematurely
Date:   Sat, 20 May 2023 21:32:49 +0800
Message-Id: <20230520133249.22689-1-kweifat@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

all_cpu_data struct is pretty large,
we should avoid assigning it around when the function has a chance
to bail out earlier before actually using it.

The same idea applies to the
this_cpu of notify_hwp_interrupt
and
the hwp_cap of intel_pstate_hwp_boost_up,
which are also initialized prematurely.
I think it also qualifies as a micro-optimization.

While at it, tidy up all the cpu_data initialization,
for the sake of consistency.

Signed-off-by: Fieah Lim <kweifat@gmail.com>
---
 drivers/cpufreq/intel_pstate.c | 35 +++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2548ec92faa2..831769c39778 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -464,9 +464,8 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 
 static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 {
-	struct cpudata *cpu;
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
-	cpu = all_cpu_data[policy->cpu];
 	if (!cpu->valid_pss_table)
 		return;
 
@@ -539,9 +538,8 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 static inline void update_turbo_state(void)
 {
 	u64 misc_en;
-	struct cpudata *cpu;
+	struct cpudata *cpu = all_cpu_data[0];
 
-	cpu = all_cpu_data[0];
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
 	global.turbo_disabled =
 		(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ||
@@ -769,7 +767,7 @@ static struct cpufreq_driver intel_pstate;
 static ssize_t store_energy_performance_preference(
 		struct cpufreq_policy *policy, const char *buf, size_t count)
 {
-	struct cpudata *cpu = all_cpu_data[policy->cpu];
+	struct cpudata *cpu;
 	char str_preference[21];
 	bool raw = false;
 	ssize_t ret;
@@ -802,6 +800,8 @@ static ssize_t store_energy_performance_preference(
 	if (!intel_pstate_driver)
 		return -EAGAIN;
 
+	cpu = all_cpu_data[policy->cpu];
+
 	mutex_lock(&intel_pstate_limits_lock);
 
 	if (intel_pstate_driver == &intel_pstate) {
@@ -1297,7 +1297,7 @@ static void update_qos_request(enum freq_qos_req_type type)
 	int i;
 
 	for_each_possible_cpu(i) {
-		struct cpudata *cpu = all_cpu_data[i];
+		struct cpudata *cpu;
 		unsigned int freq, perf_pct;
 
 		policy = cpufreq_cpu_get(i);
@@ -1310,6 +1310,8 @@ static void update_qos_request(enum freq_qos_req_type type)
 		if (!req)
 			continue;
 
+		cpu = all_cpu_data[i];
+
 		if (hwp_active)
 			intel_pstate_get_hwp_cap(cpu);
 
@@ -1579,7 +1581,7 @@ static cpumask_t hwp_intr_enable_mask;
 
 void notify_hwp_interrupt(void)
 {
-	unsigned int this_cpu = smp_processor_id();
+	unsigned int this_cpu;
 	struct cpudata *cpudata;
 	unsigned long flags;
 	u64 value;
@@ -1591,6 +1593,8 @@ void notify_hwp_interrupt(void)
 	if (!(value & 0x01))
 		return;
 
+	this_cpu = smp_processor_id();
+
 	spin_lock_irqsave(&hwp_notify_lock, flags);
 
 	if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
@@ -2025,7 +2029,7 @@ static int hwp_boost_hold_time_ns = 3 * NSEC_PER_MSEC;
 static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
 {
 	u64 hwp_req = READ_ONCE(cpu->hwp_req_cached);
-	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
+	u64 hwp_cap;
 	u32 max_limit = (hwp_req & 0xff00) >> 8;
 	u32 min_limit = (hwp_req & 0xff);
 	u32 boost_level1;
@@ -2052,6 +2056,7 @@ static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
 		cpu->hwp_boost_min = min_limit;
 
 	/* level at half way mark between min and guranteed */
+	hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
 	boost_level1 = (HWP_GUARANTEED_PERF(hwp_cap) + min_limit) >> 1;
 
 	if (cpu->hwp_boost_min < boost_level1)
@@ -2389,9 +2394,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
 
 static int intel_pstate_init_cpu(unsigned int cpunum)
 {
-	struct cpudata *cpu;
-
-	cpu = all_cpu_data[cpunum];
+	struct cpudata *cpu = all_cpu_data[cpunum];
 
 	if (!cpu) {
 		cpu = kzalloc(sizeof(*cpu), GFP_KERNEL);
@@ -2431,11 +2434,13 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 
 static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 {
-	struct cpudata *cpu = all_cpu_data[cpu_num];
+	struct cpudata *cpu;
 
 	if (hwp_active && !hwp_boost)
 		return;
 
+	cpu = all_cpu_data[cpu_num];
+
 	if (cpu->update_util_set)
 		return;
 
@@ -2638,9 +2643,7 @@ static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 
 static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
 {
-	struct cpudata *cpu = all_cpu_data[policy->cpu];
-
-	pr_debug("CPU %d going online\n", cpu->cpu);
+	pr_debug("CPU %d going online\n", policy->cpu);
 
 	intel_pstate_init_acpi_perf_limits(policy);
 
@@ -2649,6 +2652,8 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
 		 * Re-enable HWP and clear the "suspended" flag to let "resume"
 		 * know that it need not do that.
 		 */
+		struct cpudata *cpu = all_cpu_data[policy->cpu];
+
 		intel_pstate_hwp_reenable(cpu);
 		cpu->suspended = false;
 	}
-- 
2.40.1

