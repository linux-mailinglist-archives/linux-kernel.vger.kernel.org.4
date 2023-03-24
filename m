Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5E6C7C18
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjCXKA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCXKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:00:56 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3459A199DB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:00:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679652053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bSc0WWKCrF67Pi/HwlNZVSesODSTBfnuSU6f64Y3d4A=;
        b=eZe+OG47+3TlSHWJlYF8pqZJwWOkYm4wcvj+d/U76tHtu84GBZq+4nEYKUT9dYfTrKuoYD
        ApeYh3GxTNz+v52A0863zXehU83OexBfz7xAOy/hCTPvsBtAjKYa+T5e/+jXbQhsvVbw5S
        yKKmUb9jbuA9qR/mP/n0vuPfhdtNCZM=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] cpufreq: schedutil: Combine two loops into one in sugov_start()
Date:   Fri, 24 Mar 2023 18:00:23 +0800
Message-Id: <20230324100023.900616-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sugov_start() function currently contains two for loops that
traverse the CPU list and perform some initialization tasks. The first
loop initializes each sugov_cpu struct and assigns the CPU number and
sugov_policy pointer. The second loop sets up the update_util hook for
each CPU based on the policy type.

Since both loops operate on the same CPU list, it is possible to combine
them into a single for loop. This simplifies the code and reduces the
number of times the CPU list needs to be traversed, which can improve
performance.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/cpufreq_schedutil.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e3211455b203..9a28ebbb9c1e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -766,14 +766,6 @@ static int sugov_start(struct cpufreq_policy *policy)
 
 	sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
 
-	for_each_cpu(cpu, policy->cpus) {
-		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
-
-		memset(sg_cpu, 0, sizeof(*sg_cpu));
-		sg_cpu->cpu			= cpu;
-		sg_cpu->sg_policy		= sg_policy;
-	}
-
 	if (policy_is_shared(policy))
 		uu = sugov_update_shared;
 	else if (policy->fast_switch_enabled && cpufreq_driver_has_adjust_perf())
@@ -784,6 +776,10 @@ static int sugov_start(struct cpufreq_policy *policy)
 	for_each_cpu(cpu, policy->cpus) {
 		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
 
+		memset(sg_cpu, 0, sizeof(*sg_cpu));
+		sg_cpu->cpu			= cpu;
+		sg_cpu->sg_policy		= sg_policy;
+
 		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
 	}
 	return 0;
-- 
2.25.1

