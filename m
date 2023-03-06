Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32716AC396
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCFOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCFOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:42:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEEB360AA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kChkAIziN/l/ohkn0x/Uv70FRWWM1V/aqgty+8Q0xK0=; b=DKIXdglKYd7SsFfYO3jfvX9q6t
        Jg0/Crz9CCV8YAgZ7ZXBfQQlzq8nd+f/wihT2HToGSsSPBeuq8jsMT8HdTbdZUGItrHIfanEkZoWs
        3j0FMqKhNkyIz1466pcchZqhekF9Q+GVq898noqvv/NoSp4dLchLNe0UgEBfygggduyHr8Uq++OgQ
        KHdkjfMvK2Znj2d/f8xljlPHgYvZ/V21JkhYXB7bdBQiK1yJqsImWROVpWiC8apFj+PBnsxjnG9BD
        1rGrfBPPjehktc9W5YuV1rcTM4mlX5esM+lZSMLKKNcixPFsPLZHbWEVsjs0mfQJrcGkKiUXy3u3B
        2ALQ81Kg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZBe6-005P2b-89; Mon, 06 Mar 2023 14:16:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8908C3010ED;
        Mon,  6 Mar 2023 15:16:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1142823BC8E32; Mon,  6 Mar 2023 15:16:55 +0100 (CET)
Message-ID: <20230306141502.691294694@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 06 Mar 2023 14:25:29 +0100
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
        joel@joelfernandes.org
Subject: [PATCH 08/10] sched/fair: Add lag based placement
References: <20230306132521.968182689@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of avg_vruntime, it is possible to approximate
lag (the entire purpose of introducing it in fact). Use this to do lag
based placement over sleep+wake.

Specifically, the FAIR_SLEEPERS thing places things too far to the
left and messes up the deadline aspect of EEVDF.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |    1 
 kernel/sched/core.c     |    1 
 kernel/sched/fair.c     |   63 +++++++++++++++++++++++++++---------------------
 kernel/sched/features.h |    8 ++++++
 4 files changed, 46 insertions(+), 27 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -555,6 +555,7 @@ struct sched_entity {
 	u64				sum_exec_runtime;
 	u64				vruntime;
 	u64				prev_sum_exec_runtime;
+	s64				lag;
 
 	u64				nr_migrations;
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4436,6 +4436,7 @@ static void __sched_fork(unsigned long c
 	p->se.prev_sum_exec_runtime	= 0;
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
+	p->se.lag			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 	set_latency_offset(p);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4749,39 +4749,45 @@ static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
 	u64 vruntime = avg_vruntime(cfs_rq);
-	u64 sleep_time;
 
-	/* sleeps up to a single latency don't count. */
-	if (!initial) {
-		unsigned long thresh;
-
-		if (se_is_idle(se))
-			thresh = sysctl_sched_min_granularity;
-		else
-			thresh = sysctl_sched_latency;
+	if (sched_feat(FAIR_SLEEPERS)) {
+		u64 sleep_time;
+
+		/* sleeps up to a single latency don't count. */
+		if (!initial) {
+			unsigned long thresh;
+
+			if (se_is_idle(se))
+				thresh = sysctl_sched_min_granularity;
+			else
+				thresh = sysctl_sched_latency;
+
+			/*
+			 * Halve their sleep time's effect, to allow
+			 * for a gentler effect of sleepers:
+			 */
+			if (sched_feat(GENTLE_FAIR_SLEEPERS))
+				thresh >>= 1;
+
+			vruntime -= thresh;
+		}
 
 		/*
-		 * Halve their sleep time's effect, to allow
-		 * for a gentler effect of sleepers:
+		 * Pull vruntime of the entity being placed to the base level of
+		 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
+		 * slept for a long time, don't even try to compare its vruntime with
+		 * the base as it may be too far off and the comparison may get
+		 * inversed due to s64 overflow.
 		 */
-		if (sched_feat(GENTLE_FAIR_SLEEPERS))
-			thresh >>= 1;
-
-		vruntime -= thresh;
+		sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
+		if ((s64)sleep_time < 60LL * NSEC_PER_SEC)
+			vruntime = max_vruntime(se->vruntime, vruntime);
 	}
 
-	/*
-	 * Pull vruntime of the entity being placed to the base level of
-	 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
-	 * slept for a long time, don't even try to compare its vruntime with
-	 * the base as it may be too far off and the comparison may get
-	 * inversed due to s64 overflow.
-	 */
-	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
-	if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
-		se->vruntime = vruntime;
-	else
-		se->vruntime = max_vruntime(se->vruntime, vruntime);
+	if (sched_feat(PRESERVE_LAG))
+		vruntime -= se->lag;
+
+	se->vruntime = vruntime;
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
@@ -4949,6 +4955,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 
 	clear_buddies(cfs_rq, se);
 
+	if (sched_feat(PRESERVE_LAG) && (flags & DEQUEUE_SLEEP))
+		se->lag = avg_vruntime(cfs_rq) - se->vruntime;
+
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
 	se->on_rq = 0;
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -1,12 +1,20 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Only give sleepers 50% of their service deficit. This allows
  * them to run sooner, but does not allow tons of sleepers to
  * rip the spread apart.
  */
+SCHED_FEAT(FAIR_SLEEPERS, false)
 SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true)
 
 /*
+ * Using the avg_vruntime, do the right thing and preserve lag
+ * across sleep+wake cycles.
+ */
+SCHED_FEAT(PRESERVE_LAG, true)
+
+/*
  * Prefer to schedule the task we woke last (assuming it failed
  * wakeup-preemption), since its likely going to consume data we
  * touched, increases cache locality.


