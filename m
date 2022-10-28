Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D2F610B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiJ1Hgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJ1Hgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:36:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4EA2AAE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:36:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y10so2512368wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ps1HJOKEnWCS/7lhYsGYqdzZOp8bQxvEb3UkDJ00+rE=;
        b=r9vIh/ryRXdC+rppRMO3FTwE+0X1f+lWJeXTpplDr1lwrJHn/xrHVLoKDD6kZMVagk
         j93h8jTAYJtL8vF9kjq21yJrD8slyw3iXGnirmuMXPajEwK1VVsjMArBtJix0T8+fabz
         I2lXoSYDdErFeK8SoY6C3JedlwVBUNAx2vPXC7o7rm5AvK2o8Gqlrhsv2Gsm8/wNAh6L
         fb7JLIckOITXrPF8D4a80BUAZxOhMDSApK91MR4HX9keJ35xz0wwIpbbMwE6i6aF/c5K
         1p/IDsnj6LX9KvyNNu3C/swsXaAnzurA7j1nXH6b9sRXCAiMrlPXhkaxfaN8DkrB8eZS
         w+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ps1HJOKEnWCS/7lhYsGYqdzZOp8bQxvEb3UkDJ00+rE=;
        b=zQKVXmjdre5KcPpw7FoyDXGgao9xWskTKxD/4ZQoHoFEb5tCfOEAd/6jNMeykAOsbC
         IBZaX9xaBY6r9OLz73fosb9vN09XiK63sQMzqjx3TRJEMmAuwAW6ksVO/2e+BM+8PaCR
         aeFBvlLjBvi+0M9gF+te7kSn0ZCT6kkCTnPRcmAk10TqLPrLiDjoZ/qba7dGIIh+HbnM
         SxX4XzCEMLYsfW+8baC2GNVKz6d6Y11MDAY4ADh+pU7eB9FPfZe3NO7jnk4fzn3gXgsv
         rqom72fTCYyl5ug0oFKmroAqjkQ5P8dXZAFql+f4/ypLYK5vBbgd/K68g5cn6uEbq/+Z
         o1kA==
X-Gm-Message-State: ACrzQf2yAjJtduBRiLc6sIaFNP2HW/ABIQmd7On2JGBwjAxeo3HHsziD
        zgMvfDR995D9nptfJ+G7OzfO5g==
X-Google-Smtp-Source: AMsMyM527xBEAZohTxE1FXCbjfTHv9OZDl7dFxX+lxSX5pSXIrWqKsMgpJ0tFf1bmJ7EYyGEeVlAyw==
X-Received: by 2002:a1c:c90c:0:b0:3b4:adc7:9766 with SMTP id f12-20020a1cc90c000000b003b4adc79766mr8555482wmb.66.1666942608656;
        Fri, 28 Oct 2022 00:36:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003b47e8a5d22sm7783129wmq.23.2022.10.28.00.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:36:47 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 1/9] sched/fair: fix unfairness at wakeup
Date:   Fri, 28 Oct 2022 09:36:29 +0200
Message-Id: <20221028073637.31195-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028073637.31195-1-vincent.guittot@linaro.org>
References: <20221028073637.31195-1-vincent.guittot@linaro.org>
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
 kernel/sched/sched.h | 28 +++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 25 deletions(-)

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
index 1fc198be1ffd..cdb84aec8ed5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
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

