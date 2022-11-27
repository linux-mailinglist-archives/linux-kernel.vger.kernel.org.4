Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C0639B55
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 15:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiK0OST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 09:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiK0OSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 09:18:14 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4885710064
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:18:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q7so12196428wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+zI3N5dOdb5fnuld4XLb6zCk7BINl8UZmpVHd/GV18=;
        b=YL7I8FMhXz/vWOBdm0iwJGKE6DZDoPh/njdZxuTNpEYYbF0lNnsIes+tMfSo5ZC3bU
         cazrU3Hscj+kfniaYduTzHkXS3Ck/MhquUmrSvZfV+2Tl/ihZ4Srdm4bzQ5qG61+v9TN
         rzM+xUdSez2cUB42XLom5otuLmSpSZBVdvfDFut+1SQmMXr8AK2j4l1eFNRMVes8z9YI
         YASI+nPG1Rlw8piGO7hE0H4E/elWg2AU/lgc4Y+pWj6U556iNC09QHxzTezq5Nl2GVoA
         4ewKH5KzrIogkrxZZZF6EQBbodWLUAAguC6HN6yW8cKwKiU50+gECaMRRNxUIq5KCfFq
         rweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+zI3N5dOdb5fnuld4XLb6zCk7BINl8UZmpVHd/GV18=;
        b=iMeSMAbffFwRWTMHdS2sbCLjpoG4B8aNnG3Su/BxfCbHZ8YZrmbtXxty1o9WhU6K+B
         TVFXPP4x9zDS7hqO/5c3VG7VUV2ggzWH+kAXbbfLYyhJej860diibnclGRntNPhFMmE5
         GKnBPLljaIVVfQighW48Sx+1Mpz1/lSMIhlZk69It6RKncvzAouRH1/cR3OKELY6O42N
         Z0ckuk9iGw3nVKPUrekyM2t8Fw5wZEA/dG1TA0Hpnid5S6ebuFmfXBzUjfxuuO0i48+1
         dqtGp6FYdzlu56PebzxEXJNjmqJIZe+ZmCfhaQ0oNyn+NTQMr2vtroyO6ET7w6LjB7Uk
         RdlQ==
X-Gm-Message-State: ANoB5pm5HL+DBFQIvCZtZv8ixCo+HgQj4ePigHYzK07yzCaTTjYYVn69
        Uo5C/FfvCWMGRJp7xegKPzIA9A==
X-Google-Smtp-Source: AA0mqf5XRkFhfqjpca1dn7QxzfG1JYdVGyo/02PwYYs2GfrtndATS2MNfDYZUt+Wq/TAsaWe2BtRnA==
X-Received: by 2002:adf:fe42:0:b0:242:15e1:580d with SMTP id m2-20020adffe42000000b0024215e1580dmr892622wrs.506.1669558690208;
        Sun, 27 Nov 2022 06:18:10 -0800 (PST)
Received: from localhost.localdomain (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b003c6f3f6675bsm17109757wmq.26.2022.11.27.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 06:18:09 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect capacity inversion
Date:   Sun, 27 Nov 2022 14:17:42 +0000
Message-Id: <20221127141742.1644023-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221127141742.1644023-1-qyousef@layalina.io>
References: <20221127141742.1644023-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used performance domains to traverse the list of domains that share
the same cpufreq policy to detect when this domain is severely impacted
by thermal pressure to cause it to be lower than another domain in the
system - capacity inversion.

Since performance domains are only available for when energy model or
schedutil are present, this makes the detection mechanism unavailable
for Capacity Aware Scheduling (CAS).

Since we only care about traversing the capacity_orig() of any cpu
within that domain; export for_each_active_policy() to traverse the
cpufreq policies instead of performance domains.

Introduce a new for_each_active_policy_safe() to protect against races
with deletion. Races against additions are fine since we can't
eliminate the race without having to do heavy handed locking which is
unacceptable in this path. The policy should be visible in the next
tick if we missed it.

Fixes: 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---

Rafael, Viresh, I hope it's okay to export these macros in the public header.
And that my usage is okay; I'm not sure if I missed important locking rules.


 drivers/cpufreq/cpufreq.c | 12 +-----------
 include/linux/cpufreq.h   | 26 ++++++++++++++++++++++++++
 kernel/sched/fair.c       | 13 +++++--------
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 69b3d61852ac..b11e7c545fc1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -31,17 +31,7 @@
 #include <linux/units.h>
 #include <trace/events/power.h>
 
-static LIST_HEAD(cpufreq_policy_list);
-
-/* Macros to iterate over CPU policies */
-#define for_each_suitable_policy(__policy, __active)			 \
-	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
-		if ((__active) == !policy_is_inactive(__policy))
-
-#define for_each_active_policy(__policy)		\
-	for_each_suitable_policy(__policy, true)
-#define for_each_inactive_policy(__policy)		\
-	for_each_suitable_policy(__policy, false)
+LIST_HEAD(cpufreq_policy_list);
 
 /* Iterate over governors */
 static LIST_HEAD(cpufreq_governor_list);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d5595d57f4e5..c3c79d4ad821 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -780,6 +780,32 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
 			continue;						\
 		else
 
+#ifdef CONFIG_CPU_FREQ
+extern struct list_head cpufreq_policy_list;
+
+/* Macros to iterate over CPU policies */
+#define for_each_suitable_policy(__policy, __active)			 \
+	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
+		if ((__active) == !policy_is_inactive(__policy))
+
+#define for_each_suitable_policy_safe(__policy, __n, __active)			   \
+	list_for_each_entry_safe(__policy, __n, &cpufreq_policy_list, policy_list) \
+		if ((__active) == !policy_is_inactive(__policy))
+#else
+#define for_each_suitable_policy(__policy, __active)		while (0)
+#define for_each_suitable_policy_safe(__policy, __n, __active)	while (0)
+#endif
+
+#define for_each_active_policy(__policy)		\
+	for_each_suitable_policy(__policy, true)
+#define for_each_inactive_policy(__policy)		\
+	for_each_suitable_policy(__policy, false)
+
+#define for_each_active_policy_safe(__policy, __n)		\
+	for_each_suitable_policy_safe(__policy, __n, true)
+#define for_each_inactive_policy_safe(__policy, __n)		\
+	for_each_suitable_policy_safe(__policy, __n, false)
+
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 				    struct cpufreq_frequency_table *table);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7c0dd57e562a..4bbbca85134b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8856,23 +8856,20 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	 *   * Thermal pressure will impact all cpus in this perf domain
 	 *     equally.
 	 */
-	if (sched_energy_enabled()) {
+	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
 		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
-		struct perf_domain *pd = rcu_dereference(rq->rd->pd);
+		struct cpufreq_policy *policy, __maybe_unused *policy_n;
 
 		rq->cpu_capacity_inverted = 0;
 
-		SCHED_WARN_ON(!rcu_read_lock_held());
-
-		for (; pd; pd = pd->next) {
-			struct cpumask *pd_span = perf_domain_span(pd);
+		for_each_active_policy_safe(policy, policy_n) {
 			unsigned long pd_cap_orig, pd_cap;
 
 			/* We can't be inverted against our own pd */
-			if (cpumask_test_cpu(cpu_of(rq), pd_span))
+			if (cpumask_test_cpu(cpu_of(rq), policy->cpus))
 				continue;
 
-			cpu = cpumask_any(pd_span);
+			cpu = cpumask_any(policy->cpus);
 			pd_cap_orig = arch_scale_cpu_capacity(cpu);
 
 			if (capacity_orig < pd_cap_orig)
-- 
2.25.1

