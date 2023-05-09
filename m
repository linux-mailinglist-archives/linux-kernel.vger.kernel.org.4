Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12F56FC634
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjEIMXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbjEIMXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:23:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0926B44AD;
        Tue,  9 May 2023 05:23:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15881106F;
        Tue,  9 May 2023 05:23:46 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9C743F67D;
        Tue,  9 May 2023 05:22:58 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, lukasz.luba@arm.com,
        qyousef@google.com, qyousef@layalina.io
Subject: [PATCH v2 2/3] cpufreq: schedutil: Refactor sugov_update_shared() internals
Date:   Tue,  9 May 2023 13:22:45 +0100
Message-Id: <20230509122246.1702397-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230509122246.1702397-1-lukasz.luba@arm.com>
References: <20230509122246.1702397-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.25.1

