Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F86707774
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjERBeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjERBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:34:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C02319BD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:34:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559d36a91a9so14836547b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684373682; x=1686965682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGd11uJrEauFdMc+x3tyZ2RnE2rDj1U9cEd6S0knPbY=;
        b=EM6+JMyNggS40H+yrDfKc942QmVVl0BSiAmnmIdr1/kkXic9IJcQtltRWoogIsU1JP
         yizy17CMGSaLm87+DRT8IW5KwhsIvUklVd3Zg+cdMbNJzyGyic057eS3d77CkMBxJf3x
         TOf8Gg6xvn+aTzjCD0kmDzCbEKp1VvLO4HGLm3Fk+K0u8OuJYzQbUQ2ifKVRQN4HhLrc
         z0AM3nsccsVc0GtAFgIOJ6PprJp3r2bM3aezhzo5QOL7wi1W4rRRPmKmx1WXLTfKscCK
         YqMmeAs1h1ouryvDB/6hU1nT3uNsrTbmKiCdAZmS+w0WbXhTJ5KaCEj2gZe3wwS8/Bzy
         UQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684373682; x=1686965682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGd11uJrEauFdMc+x3tyZ2RnE2rDj1U9cEd6S0knPbY=;
        b=S9qDcyiKuBVd3K2/GFH4bPEmynrz1krZTr0EZYyjhyQOrkIJSJ0v9E+DRbd1NNhnP1
         s8ihy625IQoD6futX9r0pOrhzfdF7jUKf1YIjFje2jSF0sLg48JU71NI5BLmlhVNf/xw
         X8Y52DZn3QO+o4VpLd1Ug4EY3mWqNH9vfSN6cyfG1bkxZxtImdcDrGqPg3v4cpiQCaQF
         YE/E82lAKqsAxXYjPCVosglFQGZp7XBlLd4vj6uAtP+/dJg/nZs7zxnj2NlNQs8SLrCV
         Fjtbyzaq2otMneFn+45oQ5uJd6eAW84f1Ucb7vAgZy4NL9laxQv7o7joNNCFs065pUJP
         6aJg==
X-Gm-Message-State: AC+VfDxoVhCTokDIE1I8rBoJ5vS/XtzkVuE5c/K/6tAsJGmvO/lVWE8h
        +ABYxbUF0yBsWFveyMJVsGPc/Eb5Tfu0
X-Google-Smtp-Source: ACHHUZ68zc97RMvLDe05J2XBL3InoeuMKNrjFS46JdgbIckmFb6NdYEK+PuBMzEn7RnorbS0F9JXOsRbouAU
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2d4:203:53e2:12a7:c986:1d79])
 (user=joshdon job=sendgmr) by 2002:a81:af15:0:b0:561:8bfb:feb1 with SMTP id
 n21-20020a81af15000000b005618bfbfeb1mr74532ywh.10.1684373682560; Wed, 17 May
 2023 18:34:42 -0700 (PDT)
Date:   Wed, 17 May 2023 18:34:14 -0700
In-Reply-To: <20230518013414.3053254-1-joshdon@google.com>
Mime-Version: 1.0
References: <20230518013414.3053254-1-joshdon@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230518013414.3053254-2-joshdon@google.com>
Subject: [PATCH 2/2] sched: add throttled time stat for throttled children
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Xiangling Kong <xiangling@google.com>,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently export the total throttled time for cgroups that are given
a bandwidth limit. This patch extends this accounting to also account
the total time that each children cgroup has been throttled.

This is useful to understand the degree to which children have been
affected by the throttling control. Children which are not runnable
during the entire throttled period, for example, will not show any
self-throttling time during this period.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/core.c  | 21 +++++++++++++++++++--
 kernel/sched/fair.c  | 17 +++++++++++++++++
 kernel/sched/sched.h |  2 ++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a384344ec9ee..fcd702889fcb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11064,6 +11064,18 @@ static int __cfs_schedulable(struct task_group *tg, u64 period, u64 quota)
 	return ret;
 }
 
+static u64 throttled_time_self(struct task_group *tg)
+{
+	int i;
+	u64 total = 0;
+
+	for_each_possible_cpu(i) {
+		total += READ_ONCE(tg->cfs_rq[i]->throttled_clock_self_time);
+	}
+
+	return total;
+}
+
 static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 {
 	struct task_group *tg = css_tg(seq_css(sf));
@@ -11072,6 +11084,7 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 	seq_printf(sf, "nr_periods %d\n", cfs_b->nr_periods);
 	seq_printf(sf, "nr_throttled %d\n", cfs_b->nr_throttled);
 	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
+	seq_printf(sf, "throttled_time_self %llu\n", throttled_time_self(tg));
 
 	if (schedstat_enabled() && tg != &root_task_group) {
 		struct sched_statistics *stats;
@@ -11204,20 +11217,24 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 	{
 		struct task_group *tg = css_tg(css);
 		struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
-		u64 throttled_usec, burst_usec;
+		u64 throttled_usec, burst_usec, throttled_self_usec;
 
 		throttled_usec = cfs_b->throttled_time;
 		do_div(throttled_usec, NSEC_PER_USEC);
+		throttled_self_usec = throttled_time_self(tg);
+		do_div(throttled_self_usec, NSEC_PER_USEC);
 		burst_usec = cfs_b->burst_time;
 		do_div(burst_usec, NSEC_PER_USEC);
 
 		seq_printf(sf, "nr_periods %d\n"
 			   "nr_throttled %d\n"
 			   "throttled_usec %llu\n"
+			   "throttled_self_usec %llu\n"
 			   "nr_bursts %d\n"
 			   "burst_usec %llu\n",
 			   cfs_b->nr_periods, cfs_b->nr_throttled,
-			   throttled_usec, cfs_b->nr_burst, burst_usec);
+			   throttled_usec, throttled_self_usec, cfs_b->nr_burst,
+			   burst_usec);
 	}
 #endif
 	return 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 85c2c0c3cab6..fd348b9421c1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4822,6 +4822,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		} else {
 			if (!cfs_rq->throttled_clock)
 				cfs_rq->throttled_clock = rq_clock(rq);
+			if (!cfs_rq->throttled_clock_self)
+				cfs_rq->throttled_clock_self = rq_clock(rq);
 		}
 	}
 }
@@ -5327,6 +5329,17 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
+	if (cfs_rq->throttled_clock_self) {
+		u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
+
+		cfs_rq->throttled_clock_self = 0;
+
+		if (SCHED_WARN_ON((s64)delta < 0))
+			delta = 0;
+
+		cfs_rq->throttled_clock_self_time += delta;
+	}
+
 	return 0;
 }
 
@@ -5342,6 +5355,10 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	}
 	cfs_rq->throttle_count++;
 
+	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
+	if (cfs_rq->nr_running)
+		cfs_rq->throttled_clock_self = rq_clock(rq);
+
 	return 0;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 060616944d7a..ddc48b2f1fd0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -642,6 +642,8 @@ struct cfs_rq {
 	u64			throttled_clock;
 	u64			throttled_clock_pelt;
 	u64			throttled_clock_pelt_time;
+	u64			throttled_clock_self;
+	u64			throttled_clock_self_time;
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;
-- 
2.40.1.606.ga4b1b128d6-goog

