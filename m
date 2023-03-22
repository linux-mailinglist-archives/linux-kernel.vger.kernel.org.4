Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2D6C4F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjCVPUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjCVPUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:20:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B68445DC8B;
        Wed, 22 Mar 2023 08:20:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A60E15DB;
        Wed, 22 Mar 2023 08:21:01 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.18.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE2843F71E;
        Wed, 22 Mar 2023 08:20:14 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, lukasz.luba@arm.com,
        qyousef@google.com
Subject: [PATCH 2/3] cpufreq: schedutil: Refactor sugov_update_shared() internals
Date:   Wed, 22 Mar 2023 15:18:42 +0000
Message-Id: <20230322151843.14390-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230322151843.14390-1-lukasz.luba@arm.com>
References: <20230322151843.14390-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the if section block. Use the simple check to bail out
and jump to the unlock at the end. That makes the code more readable
and ready for some future tracing.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e3211455b203..f462496e5c07 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -446,17 +446,19 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
 	ignore_dl_rate_limit(sg_cpu);
 
-	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_cpu, time);
+	if (!sugov_should_update_freq(sg_policy, time))
+		goto unlock;
 
-		if (!sugov_update_next_freq(sg_policy, time, next_f))
-			goto unlock;
+	next_f = sugov_next_freq_shared(sg_cpu, time);
+
+	if (!sugov_update_next_freq(sg_policy, time, next_f))
+		goto unlock;
+
+	if (sg_policy->policy->fast_switch_enabled)
+		cpufreq_driver_fast_switch(sg_policy->policy, next_f);
+	else
+		sugov_deferred_update(sg_policy);
 
-		if (sg_policy->policy->fast_switch_enabled)
-			cpufreq_driver_fast_switch(sg_policy->policy, next_f);
-		else
-			sugov_deferred_update(sg_policy);
-	}
 unlock:
 	raw_spin_unlock(&sg_policy->update_lock);
 }
-- 
2.17.1

