Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24046CBD0E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjC1LHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjC1LHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BFE3ABE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LZqDNvc3VZAUuNOXrYMg3ThXH5ZrYNaem+9q9B7vV4c=; b=BTDId8QtdLNetcXedB4tOLNnWa
        bQ/HX2wyXqc+8Zj4AGo/bYLWEyVWQqx8P3/jstQr+lu09sgK5dE+a+6Js0ty5aBQGWCEPrP0v7V0N
        4hhrkUs7H7FbqtWp22Oid35wvR1a8CgkM6BpJN8SWlsPPESPcr7C7oktiPCaCCYdhrcxanYFTqjxw
        leNE8e4TzI8dGzDPjxmteRsDo1K3Z4BRwceekqMX8t45M/v6rwSwrL8bjAv/nKDiTVkrycccbaA/5
        PfEmg8ffuQUP3QM83eK6a9Sknts91XGZcIz1Oh0XeBxmBgYy1D3aIl6VJUkAvVEiOS6uzT5vLdDZW
        TZSRBmRg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph79l-006XUx-1s;
        Tue, 28 Mar 2023 11:06:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51412302E7D;
        Tue, 28 Mar 2023 13:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B73732CB8CEB6; Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Message-ID: <20230328110353.920761844@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:27 +0200
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
Subject: [PATCH 05/17] sched/fair: Remove START_DEBIT
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

With the introduction of avg_vruntime() there is no need to use worse
approximations. Take the 0-lag point as starting point for inserting
new tasks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   21 +--------------------
 kernel/sched/features.h |    6 ------
 2 files changed, 1 insertion(+), 26 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -882,16 +882,6 @@ static u64 sched_slice(struct cfs_rq *cf
 	return slice;
 }
 
-/*
- * We calculate the vruntime slice of a to-be-inserted task.
- *
- * vs = s/w
- */
-static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	return calc_delta_fair(sched_slice(cfs_rq, se), se);
-}
-
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
@@ -4781,16 +4771,7 @@ static inline bool entity_is_long_sleepe
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
-	u64 vruntime = cfs_rq->min_vruntime;
-
-	/*
-	 * The 'current' period is already promised to the current tasks,
-	 * however the extra weight of the new task will slow them down a
-	 * little, place the new task so that it fits in the slot that
-	 * stays open at the end.
-	 */
-	if (initial && sched_feat(START_DEBIT))
-		vruntime += sched_vslice(cfs_rq, se);
+	u64 vruntime = avg_vruntime(cfs_rq);
 
 	/* sleeps up to a single latency don't count. */
 	if (!initial) {
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -7,12 +7,6 @@
 SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true)
 
 /*
- * Place new tasks ahead so that they do not starve already running
- * tasks
- */
-SCHED_FEAT(START_DEBIT, true)
-
-/*
  * Prefer to schedule the task we woke last (assuming it failed
  * wakeup-preemption), since its likely going to consume data we
  * touched, increases cache locality.


