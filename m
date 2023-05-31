Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2B8718049
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbjEaMta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbjEaMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:48:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0BBE48
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tv6sCKoE79EpD05Hd2YDu+LAbWtn1Gj3QHTavbmMia4=; b=EReReZwapFqWEFIy7DpROKSIH9
        q1jJLDzgpDvkhe1XTxxvXBhQAoPtKBjTYzafnLkXptHn9yqT3StYSxUJGwGMih3QA2JfnKLgl/UPh
        U2P3Tc2Qp/0IMoj9cMCowiKz2IbB3cowRjpzGyozNaGheTUHkPWB99Ie6m3WH4SKAojBrdhhbRGGN
        WGMtY5Ao/JhLv7PN4EKTg9fhdp/2/XjPvjzG3RMiTqETbI6HD9o3tqqyuI+XH7LQ5Z9bLgkX+9q6i
        0KOdr9JR01Nz5IS2nFjXPxv3J6A0AaQ/E+D91T8OBCtruT6ZVsln4kpjwN+ZUyqbJov1fGX8Uu+wO
        feaq7k6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4LEp-007GRc-WB; Wed, 31 May 2023 12:47:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CFCB300E25;
        Wed, 31 May 2023 14:47:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1486922BA645E; Wed, 31 May 2023 14:47:34 +0200 (CEST)
Message-ID: <20230531124604.341527144@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:50 +0200
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
Subject: [PATCH 11/15] sched/eevdf: Better handle mixed slice length
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

In the case where (due to latency-nice) there are different request
sizes in the tree, the smaller requests tend to be dominated by the
larger. Also note how the EEVDF lag limits are based on r_max.

Therefore; add a heuristic that for the mixed request size case, moves
smaller requests to placement strategy #2 which ensures they're
immidiately eligible and and due to their smaller (virtual) deadline
will cause preemption.

NOTE: this relies on update_entity_lag() to impose lag limits above
a single slice.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   30 ++++++++++++++++++++++++++++++
 kernel/sched/features.h |    1 +
 kernel/sched/sched.h    |    1 +
 3 files changed, 32 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -642,6 +642,7 @@ avg_vruntime_add(struct cfs_rq *cfs_rq,
 	s64 key = entity_key(cfs_rq, se);
 
 	cfs_rq->avg_vruntime += key * weight;
+	cfs_rq->avg_slice += se->slice * weight;
 	cfs_rq->avg_load += weight;
 }
 
@@ -652,6 +653,7 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq,
 	s64 key = entity_key(cfs_rq, se);
 
 	cfs_rq->avg_vruntime -= key * weight;
+	cfs_rq->avg_slice -= se->slice * weight;
 	cfs_rq->avg_load -= weight;
 }
 
@@ -4908,6 +4910,21 @@ static inline void update_misfit_status(
 
 #endif /* CONFIG_SMP */
 
+static inline bool
+entity_has_slept(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+{
+	u64 now;
+
+	if (!(flags & ENQUEUE_WAKEUP))
+		return false;
+
+	if (flags & ENQUEUE_MIGRATED)
+		return true;
+
+	now = rq_clock_task(rq_of(cfs_rq));
+	return (s64)(se->exec_start - now) >= se->slice;
+}
+
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
@@ -4930,6 +4947,19 @@ place_entity(struct cfs_rq *cfs_rq, stru
 		lag = se->vlag;
 
 		/*
+		 * For latency sensitive tasks; those that have a shorter than
+		 * average slice and do not fully consume the slice, transition
+		 * to EEVDF placement strategy #2.
+		 */
+		if (sched_feat(PLACE_FUDGE) &&
+		    (cfs_rq->avg_slice > se->slice * cfs_rq->avg_load) &&
+		    entity_has_slept(cfs_rq, se, flags)) {
+			lag += vslice;
+			if (lag > 0)
+				lag = 0;
+		}
+
+		/*
 		 * If we want to place a task and preserve lag, we have to
 		 * consider the effect of the new entity on the weighted
 		 * average and compensate for this, otherwise lag can quickly
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -5,6 +5,7 @@
  * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
  */
 SCHED_FEAT(PLACE_LAG, true)
+SCHED_FEAT(PLACE_FUDGE, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -555,6 +555,7 @@ struct cfs_rq {
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
 	s64			avg_vruntime;
+	u64			avg_slice;
 	u64			avg_load;
 
 	u64			exec_clock;


