Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258AA62489E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiKJRu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiKJRuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:50:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D83C6E4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j15so3386552wrq.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FulDXK+MjqUjf+jM0x0PxczJh4rRajiCQKKkLNt7L9g=;
        b=uqF7wYcoS1Vb/LeU+zmM+bWQUS+qz9nsrF2qaBasvtiFv8WBliA8otbDoW4M5B9cwq
         WyYJBfZgarq006JA96KlmAOBsILI2m/yIIl9TH5XlQZlQhqbt6L0C48uOa/lQwUqlb0e
         dUEkyyfWPCWzb+C/qL/jJNhesEP81sWPU+S8IemO62dyKhLOadbQ0Yr2ot3jnaHMpT4w
         HHv8T5aKurGZqFSIB3DDJJ26EOYDze3hRakZOMfuwqBmxYDsyNZ/qwWF//7Iw3R5Vifz
         ScMvIIPk2DaRqHmlyUGZPSx/MYUMdWgrq368eMR1B9K7LSAzkpWfxKENO404JPYFVvPJ
         8uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FulDXK+MjqUjf+jM0x0PxczJh4rRajiCQKKkLNt7L9g=;
        b=Vct2NnNgKo7IMqunMAQ8X5FxXGZ3mD+GfUeQ31rvdsllvTjVB6tHUZqSSi4FSG9TRK
         ZF3JhQFkKkYHkiYXYqQwxyd+iXK5Q2hNBtaLmkRoPYANUNQFz5aI+wSnilQepzzxosfM
         ywAFTD9RYv4+Fed54bQcsJTC6SqeX4Py+QMxZrBaTmk00kotY9bheSvmZa/CK9oBqc4H
         mBU7OXUdoK1ET16C1P7oF00Bv9jK7WITC1iVzhiriKxgOeIGK8Zust+uduq79fd+oujA
         ZJNGdLisbU0aq1nE8+J0lFO9S4v6deT2D2VASw6JvIfRzPfaArQBFxvY44gBOndgxewB
         77mA==
X-Gm-Message-State: ACrzQf1RyCenywJyHYnGYWiIerlTH/KEqzjYDR33zD80yvhWLY1Gr4aM
        e/w0TY7kbz2d7AKzMqdeq077CA==
X-Google-Smtp-Source: AMsMyM6WdwBpaJs4ST98fmb1rPvzZe96IKB9I9TQ8sdlYEGEUmjRpUbray5L7sZaZ6M3MtARdq/A9g==
X-Received: by 2002:adf:e104:0:b0:236:dce2:35dc with SMTP id t4-20020adfe104000000b00236dce235dcmr35917753wrz.675.1668102617044;
        Thu, 10 Nov 2022 09:50:17 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:342a:468f:562a:9cc4])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b003cfc02ab8basm6514677wmq.33.2022.11.10.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:50:15 -0800 (PST)
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
Subject: [PATCH v8 1/9] sched/fair: fix unfairness at wakeup
Date:   Thu, 10 Nov 2022 18:50:01 +0100
Message-Id: <20221110175009.18458-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110175009.18458-1-vincent.guittot@linaro.org>
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
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

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 46 ++++++++++++++++++++------------------------
 kernel/sched/sched.h | 30 ++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5ffec4370602..eb04c83112a0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4345,33 +4345,17 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
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
+		vruntime -= get_sched_latency(se_is_idle(se));
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
@@ -7187,6 +7171,18 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
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
index 1fc198be1ffd..14879d429919 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2432,9 +2432,9 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
-#ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_latency;
 extern unsigned int sysctl_sched_min_granularity;
+#ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_idle_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
 extern int sysctl_resched_latency_warn_ms;
@@ -2448,6 +2448,34 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
 #endif
 
+static inline unsigned long  get_sched_latency(bool idle)
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
+static inline unsigned long  get_latency_max(void)
+{
+	unsigned long thresh = get_sched_latency(false);
+
+	thresh -= sysctl_sched_min_granularity;
+
+	return thresh;
+}
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
-- 
2.17.1

