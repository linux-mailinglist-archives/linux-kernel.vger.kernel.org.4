Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240CE718044
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbjEaMtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjEaMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:48:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B928D11F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ooCzPCYSqVr6QyMDeQ079tUQl3VStjnWctZzZdJhV4U=; b=LJZTEnixaPT+VF/Dg/xCQ2sZ/+
        CHTZJbJ/bdU8Shcdezf0cjmAH5E9lbIE1iClq02huaoxKsC2yIjzD05cJmCJd/7d0ihQxbClm7aWq
        TlYqv3Sp04YAVPY6rG9j6hGWV+zFCfjTYaXQcwaCvTABtZkaicNq0F5UoDYd10lak4zh2zdlj2bBN
        9msf75dU3pSVfh6H48W1mm+l3vYAoT491Ut2eI9Sk2cQcELw7tyePjSmHjhmM6p4cMHwoduiEH7uV
        H4wSdYJRwQCgI9kg8O5zf9Ec3BfY651JGrvIR3f1wkjanOZRUX1gdOT2OojxkQAdJDEi/lgjs8sEN
        61meYq8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LEp-00FSLE-36;
        Wed, 31 May 2023 12:47:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 838CA300C4B;
        Wed, 31 May 2023 14:47:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F098A22BA6451; Wed, 31 May 2023 14:47:33 +0200 (CEST)
Message-ID: <20230531124604.000198861@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: [PATCH 06/15] sched: Commit to lag based placement
References: <20230531115839.089944915@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the FAIR_SLEEPERS code in favour of the new LAG based
placement.

Specifically, the whole FAIR_SLEEPER thing was a very crud
approximation to make up for the lack of lag based placement,
specifically the 'service owed' part. This is important for things
like 'starve' and 'hackbench'.

One side effect of FAIR_SLEEPER is that is caused 'small' unfairness,
specifically, by always ignoring up-to 'thresh' sleeptime it would
have a 50%/50% time distribution for a 50% sleeper vs a 100% runner,
while strictly speaking this should (of course) result in a 33%/67%
split (as CFS will also do if the sleep period exceeds 'thresh').

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   59 ------------------------------------------------
 kernel/sched/features.h |    8 ------
 2 files changed, 1 insertion(+), 66 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5068,29 +5068,6 @@ static void check_spread(struct cfs_rq *
 #endif
 }
 
-static inline bool entity_is_long_sleeper(struct sched_entity *se)
-{
-	struct cfs_rq *cfs_rq;
-	u64 sleep_time;
-
-	if (se->exec_start == 0)
-		return false;
-
-	cfs_rq = cfs_rq_of(se);
-
-	sleep_time = rq_clock_task(rq_of(cfs_rq));
-
-	/* Happen while migrating because of clock task divergence */
-	if (sleep_time <= se->exec_start)
-		return false;
-
-	sleep_time -= se->exec_start;
-	if (sleep_time > ((1ULL << 63) / scale_load_down(NICE_0_LOAD)))
-		return true;
-
-	return false;
-}
-
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
@@ -5172,43 +5149,9 @@ place_entity(struct cfs_rq *cfs_rq, stru
 		if (WARN_ON_ONCE(!load))
 			load = 1;
 		lag = div_s64(lag, load);
-
-		vruntime -= lag;
-	}
-
-	if (sched_feat(FAIR_SLEEPERS)) {
-
-		/* sleeps up to a single latency don't count. */
-		if (!initial) {
-			unsigned long thresh;
-
-			if (se_is_idle(se))
-				thresh = sysctl_sched_min_granularity;
-			else
-				thresh = sysctl_sched_latency;
-
-			/*
-			 * Halve their sleep time's effect, to allow
-			 * for a gentler effect of sleepers:
-			 */
-			if (sched_feat(GENTLE_FAIR_SLEEPERS))
-				thresh >>= 1;
-
-			vruntime -= thresh;
-		}
-
-		/*
-		 * Pull vruntime of the entity being placed to the base level of
-		 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
-		 * slept for a long time, don't even try to compare its vruntime with
-		 * the base as it may be too far off and the comparison may get
-		 * inversed due to s64 overflow.
-		 */
-		if (!entity_is_long_sleeper(se))
-			vruntime = max_vruntime(se->vruntime, vruntime);
 	}
 
-	se->vruntime = vruntime;
+	se->vruntime = vruntime - lag;
 
 	/*
 	 * When joining the competition; the exisiting tasks will be,
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -1,14 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /*
- * Only give sleepers 50% of their service deficit. This allows
- * them to run sooner, but does not allow tons of sleepers to
- * rip the spread apart.
- */
-SCHED_FEAT(FAIR_SLEEPERS, false)
-SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true)
-
-/*
  * Using the avg_vruntime, do the right thing and preserve lag across
  * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
  */


