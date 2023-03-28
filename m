Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239A66CBD22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjC1LHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjC1LHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5BA7ED3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AAnu7Q5bQR+VfsEfiOofLxtBu4O6nuVihXVVPOvrlPw=; b=NRtKeab0oUOXxiy/HN17f9mVBL
        OCG8avrlO16uEMFv06m6Dug9rj8wHnhV6XjA/qgZEhlzqy1+sZWNAa/8X+ZhdhdegOdaWbPUOQLzu
        F74e+s0Qg1O1eRoWBDgdRb80CziOsAcn+67SlUE57nIq0Qud8Lj0ODHfDBpNO4VfSn2a+SrX6oY5T
        j1Xn9UXSCnOpEWyekm9JJgDBC4Xr2irX1vY4fhLyb2c2dKKYnBKYVWnexlGkdzZtbmFmD1Mdm13g1
        VAnNIu0aivARIPRLsF4Sj2qHyZMvSQbn+q1dCFPEpkAMTuonkZlYUkIdlwkpY8tlzJmzzqln8OL8v
        LMhP/HvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph79m-006XVA-1h;
        Tue, 28 Mar 2023 11:06:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 697DD303109;
        Tue, 28 Mar 2023 13:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0DD5F2CB8D7AC; Tue, 28 Mar 2023 13:06:21 +0200 (CEST)
Message-ID: <20230328110354.641979416@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:37 +0200
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
        joel@joelfernandes.org, efault@gmx.de
Subject: [PATCH 15/17] [RFC] sched/eevdf: Sleeper bonus
References: <20230328092622.062917921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sleeper bonus hack, but keep it default disabled. This should
allow easy testing if regressions are due to this.

Specifically; this 'restores' performance for things like starve and
stress-futex, stress-nanosleep that rely on sleeper bonus to compete
against an always running parent (the fair 67%/33% split vs the
50%/50% bonus thing).

OTOH this completely destroys latency and hackbench (as in 5x worse).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   47 ++++++++++++++++++++++++++++++++++++++++-------
 kernel/sched/features.h |    1 +
 kernel/sched/sched.h    |    3 ++-
 3 files changed, 43 insertions(+), 8 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4819,7 +4819,7 @@ static inline void update_misfit_status(
 #endif /* CONFIG_SMP */
 
 static void
-place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
+place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 vslice = calc_delta_fair(se->slice, se);
 	u64 vruntime = avg_vruntime(cfs_rq);
@@ -4878,22 +4878,55 @@ place_entity(struct cfs_rq *cfs_rq, stru
 		if (WARN_ON_ONCE(!load))
 			load = 1;
 		lag = div_s64(lag, load);
+
+		vruntime -= lag;
+	}
+
+	/*
+	 * Base the deadline on the 'normal' EEVDF placement policy in an
+	 * attempt to not let the bonus crud below wreck things completely.
+	 */
+	se->deadline = vruntime;
+
+	/*
+	 * The whole 'sleeper' bonus hack... :-/ This is strictly unfair.
+	 *
+	 * By giving a sleeping task a little boost, it becomes possible for a
+	 * 50% task to compete equally with a 100% task. That is, strictly fair
+	 * that setup would result in a 67% / 33% split. Sleeper bonus will
+	 * change that to 50% / 50%.
+	 *
+	 * This thing hurts my brain, because tasks leaving with negative lag
+	 * will move 'time' backward, so comparing against a historical
+	 * se->vruntime is dodgy as heck.
+	 */
+	if (sched_feat(PLACE_BONUS) &&
+	    (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)) {
+		/*
+		 * If se->vruntime is ahead of vruntime, something dodgy
+		 * happened and we cannot give bonus due to not having valid
+		 * history.
+		 */
+		if ((s64)(se->vruntime - vruntime) < 0) {
+			vruntime -= se->slice/2;
+			vruntime = max_vruntime(se->vruntime, vruntime);
+		}
 	}
 
-	se->vruntime = vruntime - lag;
+	se->vruntime = vruntime;
 
 	/*
 	 * When joining the competition; the exisiting tasks will be,
 	 * on average, halfway through their slice, as such start tasks
 	 * off with half a slice to ease into the competition.
 	 */
-	if (sched_feat(PLACE_DEADLINE_INITIAL) && initial)
+	if (sched_feat(PLACE_DEADLINE_INITIAL) && (flags & ENQUEUE_INITIAL))
 		vslice /= 2;
 
 	/*
 	 * EEVDF: vd_i = ve_i + r_i/w_i
 	 */
-	se->deadline = se->vruntime + vslice;
+	se->deadline += vslice;
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
@@ -4910,7 +4943,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
 	 * update_curr().
 	 */
 	if (curr)
-		place_entity(cfs_rq, se, 0);
+		place_entity(cfs_rq, se, flags);
 
 	update_curr(cfs_rq);
 
@@ -4937,7 +4970,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
 	 * we can place the entity.
 	 */
 	if (!curr)
-		place_entity(cfs_rq, se, 0);
+		place_entity(cfs_rq, se, flags);
 
 	account_entity_enqueue(cfs_rq, se);
 
@@ -11933,7 +11966,7 @@ static void task_fork_fair(struct task_s
 	curr = cfs_rq->curr;
 	if (curr)
 		update_curr(cfs_rq);
-	place_entity(cfs_rq, se, 1);
+	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
 	rq_unlock(rq, &rf);
 }
 
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -7,6 +7,7 @@
 SCHED_FEAT(PLACE_LAG, true)
 SCHED_FEAT(PLACE_FUDGE, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
+SCHED_FEAT(PLACE_BONUS, false)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2143,7 +2143,7 @@ extern const u32		sched_prio_to_wmult[40
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
- *
+ * ENQUEUE_INITIAL   - place a new task (fork/clone)
  */
 
 #define DEQUEUE_SLEEP		0x01
@@ -2163,6 +2163,7 @@ extern const u32		sched_prio_to_wmult[40
 #else
 #define ENQUEUE_MIGRATED	0x00
 #endif
+#define ENQUEUE_INITIAL		0x80
 
 #define RETRY_TASK		((void *)-1UL)
 


