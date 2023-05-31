Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FAB718045
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbjEaMtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjEaMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:48:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457161BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5rlW/Hj0raApbJ4gn/QrplWF37O1ajo4J98jOFm33f4=; b=AKXfB9voxqdnfjL6anU/gtnbVL
        zF/18FvMhanSXylI3B+Atq9nG+3b/f2XFXB0kQ6RK6z1luaxQCaQYrye3EjFaE2EgsR7bwn8jv5h5
        4kD6YPEDFyYT8d/odLF1WdKeppuhO6vOgfAtLU2AHbtvRt7h3fkMpKaeyNtAxEMXHjD7w7UWrhgp1
        mvEQdiwZsIn6Xf/qXFgMGEYnFGdo6j7SymvLQkpmgninfM2NcjSsAX18CS/bQzg587Kfqb5QEem0w
        zxNmkksbBZ0lvD/2dQ33sS43S0B4ZP3ZamVfGAX5A0cGsWQ24CF0JRkgkAbECG9ue+KP7e66ureKp
        ngDtVIuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LEp-00FSLF-3C;
        Wed, 31 May 2023 12:47:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C6FD300DDC;
        Wed, 31 May 2023 14:47:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0E68522BA645C; Wed, 31 May 2023 14:47:34 +0200 (CEST)
Message-ID: <20230531124604.274010996@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:49 +0200
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
Subject: [PATCH 10/15] sched/fair: Propagate enqueue flags into place_entity()
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

This allows place_entity() to consider ENQUEUE_WAKEUP and
ENQUEUE_MIGRATED.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c  |   10 +++++-----
 kernel/sched/sched.h |    1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4909,7 +4909,7 @@ static inline void update_misfit_status(
 #endif /* CONFIG_SMP */
 
 static void
-place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
+place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 vslice = calc_delta_fair(se->slice, se);
 	u64 vruntime = avg_vruntime(cfs_rq);
@@ -4998,7 +4998,7 @@ place_entity(struct cfs_rq *cfs_rq, stru
 	 * on average, halfway through their slice, as such start tasks
 	 * off with half a slice to ease into the competition.
 	 */
-	if (sched_feat(PLACE_DEADLINE_INITIAL) && initial)
+	if (sched_feat(PLACE_DEADLINE_INITIAL) && (flags & ENQUEUE_INITIAL))
 		vslice /= 2;
 
 	/*
@@ -5021,7 +5021,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
 	 * update_curr().
 	 */
 	if (curr)
-		place_entity(cfs_rq, se, 0);
+		place_entity(cfs_rq, se, flags);
 
 	update_curr(cfs_rq);
 
@@ -5048,7 +5048,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
 	 * we can place the entity.
 	 */
 	if (!curr)
-		place_entity(cfs_rq, se, 0);
+		place_entity(cfs_rq, se, flags);
 
 	account_entity_enqueue(cfs_rq, se);
 
@@ -12053,7 +12053,7 @@ static void task_fork_fair(struct task_s
 	curr = cfs_rq->curr;
 	if (curr)
 		update_curr(cfs_rq);
-	place_entity(cfs_rq, se, 1);
+	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
 	rq_unlock(rq, &rf);
 }
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2174,6 +2174,7 @@ extern const u32		sched_prio_to_wmult[40
 #else
 #define ENQUEUE_MIGRATED	0x00
 #endif
+#define ENQUEUE_INITIAL		0x80
 
 #define RETRY_TASK		((void *)-1UL)
 


