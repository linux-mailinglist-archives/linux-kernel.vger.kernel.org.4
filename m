Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3636F62A01C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiKORTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiKORTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:19:03 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B813D3C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o4so25327485wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0gt5dMxvQbqno+STaQibPwy3l5gz8MECmjhw94KguxM=;
        b=gDlAKnk9+Ms0Le2gLFVmU+3clOP59GSKkv9GngIkekxRvYns5OBHP80f5OAv2vvvM6
         J+9Sirc0kDuo0uRHvG85cjSAkntieDPfLiP5zLdnqEGiekLQi1Y9xp9ysNHXp6BN2j8u
         csCvr+rbhPeDVHLK0q3y2kcJ7DmQdTCEV+YxeGbAL8bDAN3FPq+Q3YXlCKuY7cghq40q
         OUerFuSRsmo4hMCll1BI73vbcS8mXd8gtz3SXsD8y0kJI47XE5RKYuU0ecUK2TMzKDx6
         VgTYxklpL3Zaz+uTu+bh0+Oq6SSTXVcS7J8s5+y/rp9fH4WYeZpt4m7o+8YdyuZb3EhV
         Yl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gt5dMxvQbqno+STaQibPwy3l5gz8MECmjhw94KguxM=;
        b=lICA+aSGDZHSfjSj5UBRWdQTMJNoW4n5/kEdJtXlFYpwVzf32jWMOoOVgPWilA0N/I
         GrbPWYjzSz4M0pkWUpRKRe0ghK6lVJ7L8MVVYPz8loSniXezxCbIRxQxQxJTHjAGyyen
         DV37kqmENPQfTxkKR10mvxr/VVBOaQNpGzVN58eqeoyJRL5y79m7l5brX4BJ0zktSpGs
         Ge2csK9bHW9N4Q9W3h00kUKnPWbtw4OwwHNbXpgJ/9cqTFVYcpBrTTPzUF5hNYADmed8
         ZEJKuVnV0Rwqx7cGmcJYfoeQlEEqTcKbiMSyvY25FxTvyJTMWtvRDNsr9v1TQTKpQds9
         BtKg==
X-Gm-Message-State: ANoB5pnx1OqBjCScoH2gxvuJ6q/3rbb+5RXbnNZ7DT3kyNXItmAQqBvA
        3URnEu6yO8avxhXUfwM3SFQKCw==
X-Google-Smtp-Source: AA0mqf55iZ1zHnxQ5HbFIfLc/TFTuq0dFnRpy4KDRhkgi1eznszPpqvaI5E1NktaD9oG9R+8+/nvAw==
X-Received: by 2002:adf:e702:0:b0:236:695b:6275 with SMTP id c2-20020adfe702000000b00236695b6275mr11843770wrm.116.1668532739919;
        Tue, 15 Nov 2022 09:18:59 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:91c8:7496:8b73:811f])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b003cf78aafdd7sm16846461wmb.39.2022.11.15.09.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:18:59 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v9 1/9] sched/fair: fix unfairness at wakeup
Date:   Tue, 15 Nov 2022 18:18:43 +0100
Message-Id: <20221115171851.835-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115171851.835-1-vincent.guittot@linaro.org>
References: <20221115171851.835-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DIET_1,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At wake up, the vruntime of a task is updated to not be more older than
a sched_latency period behind the min_vruntime. This prevents long sleeping
task to get unlimited credit at wakeup.
Such waking task should preempt current one to use its CPU bandwidth but
wakeup_gran() can be larger than sched_latency, filter out the
wakeup preemption and as a results steals some CPU bandwidth to
the waking task.

Make sure that a task, which vruntime has been capped, will preempt current
task and use its CPU bandwidth even if wakeup_gran() is in the same range
as sched_latency.

If the waking task failed to preempt current it could to wait up to
sysctl_sched_min_granularity before preempting it during next tick.

Strictly speaking, we should use cfs->min_vruntime instead of
curr->vruntime but it doesn't worth the additional overhead and complexity
as the vruntime of current should be close to min_vruntime if not equal.

Reported-by: Youssef Esmat <youssefesmat@chromium.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 46 ++++++++++++++++++++------------------------
 kernel/sched/sched.h | 34 +++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4cc56c91e06e..c8a697f8db88 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4645,33 +4645,17 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
 	u64 vruntime = cfs_rq->min_vruntime;
 
-	/*
-	 * The 'current' period is already promised to the current tasks,
-	 * however the extra weight of the new task will slow them down a
-	 * little, place the new task so that it fits in the slot that
-	 * stays open at the end.
-	 */
-	if (initial && sched_feat(START_DEBIT))
-		vruntime += sched_vslice(cfs_rq, se);
-
-	/* sleeps up to a single latency don't count. */
-	if (!initial) {
-		unsigned long thresh;
-
-		if (se_is_idle(se))
-			thresh = sysctl_sched_min_granularity;
-		else
-			thresh = sysctl_sched_latency;
-
+	if (!initial)
+		/* sleeps up to a single latency don't count. */
+		vruntime -= get_sleep_latency(se_is_idle(se));
+	else if (sched_feat(START_DEBIT))
 		/*
-		 * Halve their sleep time's effect, to allow
-		 * for a gentler effect of sleepers:
+		 * The 'current' period is already promised to the current tasks,
+		 * however the extra weight of the new task will slow them down a
+		 * little, place the new task so that it fits in the slot that
+		 * stays open at the end.
 		 */
-		if (sched_feat(GENTLE_FAIR_SLEEPERS))
-			thresh >>= 1;
-
-		vruntime -= thresh;
-	}
+		vruntime += sched_vslice(cfs_rq, se);
 
 	/* ensure we never gain time by being placed backwards. */
 	se->vruntime = max_vruntime(se->vruntime, vruntime);
@@ -7520,6 +7504,18 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 		return -1;
 
 	gran = wakeup_gran(se);
+
+	/*
+	 * At wake up, the vruntime of a task is capped to not be older than
+	 * a sched_latency period compared to min_vruntime. This prevents long
+	 * sleeping task to get unlimited credit at wakeup. Such waking up task
+	 * has to preempt current in order to not lose its share of CPU
+	 * bandwidth but wakeup_gran() can become higher than scheduling period
+	 * for low priority task. Make sure that long sleeping task will get a
+	 * chance to preempt current.
+	 */
+	gran = min_t(s64, gran, get_latency_max());
+
 	if (vdiff > gran)
 		return 1;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 771f8ddb7053..842ce0094d9c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2453,9 +2453,9 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
-#ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_latency;
 extern unsigned int sysctl_sched_min_granularity;
+#ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_idle_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
 extern int sysctl_resched_latency_warn_ms;
@@ -2470,6 +2470,38 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 extern unsigned int sysctl_numa_balancing_hot_threshold;
 #endif
 
+static inline unsigned long get_sleep_latency(bool idle)
+{
+	unsigned long thresh;
+
+	if (idle)
+		thresh = sysctl_sched_min_granularity;
+	else
+		thresh = sysctl_sched_latency;
+
+	/*
+	 * Halve their sleep time's effect, to allow
+	 * for a gentler effect of sleepers:
+	 */
+	if (sched_feat(GENTLE_FAIR_SLEEPERS))
+		thresh >>= 1;
+
+	return thresh;
+}
+
+static inline unsigned long get_latency_max(void)
+{
+	unsigned long thresh = get_sleep_latency(false);
+
+	 /*
+	  * If the waking task failed to preempt current it could to wait up to
+	  * sysctl_sched_min_granularity before preempting it during next tick.
+	  */
+	thresh -= sysctl_sched_min_granularity;
+
+	return thresh;
+}
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
-- 
2.17.1

