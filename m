Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8B070D7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjEWIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjEWIvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:51:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D80C95;
        Tue, 23 May 2023 01:51:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d44b198baso2296672b3a.0;
        Tue, 23 May 2023 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684831882; x=1687423882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd9VcsDJ8elNncryM1wYDU//sBkMxzd/B1cmsfb/p9A=;
        b=KRfyQ2yxg+B7sqQkFqe1Icwkw7vdlDlF4Jjm18E2uU/CLmX3WGaWEIal3LtT87uU3L
         YINOR4HoEE0OHEq6xiRw7CX3WGxnjr5t8vqR5jEXtL0C6uVg+gHJQHm/qZw2pUrwU+Fv
         HbgB3fy4g/axMQFx50hIFJi96+sfyb310fOumH7g1iaSQ44+hAAQHcRlo0O7uCMWFln1
         /MX5oaccf6cTe9aI2IVfTWTncK6f29rODp0zmbjgbTPX/zfKWJzBqwJ4zN96rsB/9Mg4
         Cs1RRVmqHCjxxExJOMty8JQp3uGr8yBIsFUqinpKOu8mjTgkoBjQfX6X6IT7n4J9xyH3
         3lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684831882; x=1687423882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vd9VcsDJ8elNncryM1wYDU//sBkMxzd/B1cmsfb/p9A=;
        b=HP+vu6S54ZdXwWuPno4mrPeKcsD8VKycLyh3e9aX5hseb7JBkb+8JokSRrCjYBXzsV
         NbRTfB7ibPGMo6B8LO26k50veOVehULyYOgdLhWkefrguvzA+GTeQO4A7S1NFatOcjda
         mByTOFE/L+tf9FtPX4i/MB92wys5eULU/rdlU4iCyWg5CaDGJryiZ9SRpY+hXcPpzZ09
         rTDXxDPnYIDlEpSvBrj5AimjdoKCTQH3Ry3QL+Y2Qq9v54fY3byCbIyVnxPlxg0rdqC3
         ZZH9harVjYGI5nHcpdeAFCn5JB2Dtb7WZU9lq87T+5JlX6XRj9zxL+NSbu1SR20kJGAD
         9/Pw==
X-Gm-Message-State: AC+VfDyKiBeJdcpBQjJjByrxtgCnh0Zi9ckIkEeUo1kxegDtwMKb9Dsa
        ey4QR6DqCd9+Z3ddG6dLA5t4ofOuiYEKQA==
X-Google-Smtp-Source: ACHHUZ6YH8rNBdpo5UrIZanYvNELj214VsoUYf3zvSmBtNnTx4OfnO3JhnekIwU2fCxyUD17miL9xw==
X-Received: by 2002:a05:6a00:806:b0:64f:3840:3c24 with SMTP id m6-20020a056a00080600b0064f38403c24mr2313324pfk.16.1684831881574;
        Tue, 23 May 2023 01:51:21 -0700 (PDT)
Received: from localhost.localdomain ([202.160.36.160])
        by smtp.googlemail.com with ESMTPSA id l15-20020a62be0f000000b0064d57ecaa1dsm786417pff.28.2023.05.23.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 01:51:20 -0700 (PDT)
From:   Fieah Lim <kweifat@gmail.com>
To:     srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fieah Lim <kweifat@gmail.com>
Subject: [PATCH v2] cpufreq: intel_pstate: Avoid initializing variables prematurely
Date:   Tue, 23 May 2023 16:50:45 +0800
Message-Id: <20230523085045.29391-1-kweifat@gmail.com>
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

We should avoid initializing some rather expensive data
when the function has a chance to bail out earlier
before actually using it.
This applies to the following initializations:

 - cpudata *cpu = all_cpu_data; (in everywhere)
 - this_cpu = smp_processor_id(); (in notify_hwp_interrupt)
 - hwp_cap = READ_ONCE(cpu->hwp_cap_cached); (in intel_pstate_hwp_boost_up)

These initializations are premature because there is a chance
that the function will bail out before actually using the data.
I think this qualifies as a micro-optimization,
especially in such a hot path.

While at it, tidy up how and when we initialize
all of the cpu_data pointers, for the sake of consistency.

A side note on the intel_pstate_cpu_online change:
we simply don't have to initialize cpudata just
for the pr_debug, while policy->cpu is being there.

Signed-off-by: Fieah Lim <kweifat@gmail.com>
---
V1 -> V2: Rewrite changelog for better explanation.
---
 drivers/cpufreq/intel_pstate.c | 35 +++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2548ec92faa2..b85e340520d9 100644
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
@@ -2024,8 +2028,8 @@ static int hwp_boost_hold_time_ns = 3 * NSEC_PER_MSEC;
 
 static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
 {
+	u64 hwp_cap;
 	u64 hwp_req = READ_ONCE(cpu->hwp_req_cached);
-	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
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

