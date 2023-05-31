Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47B5718047
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbjEaMtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbjEaMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:48:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9676AE43
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=R1+1PylE05YHMapFN57/a7eEiVmU95jtvPhJv8WUe5M=; b=Ay5zZXGO21ULUt+43kfg0VDjJN
        UgV5SrHVxn4hAmrFaQ4kYArs+AJC8z5VYKmZ8KLzuE+mvANohLcC5guj8YfevTOe9dtq4mt9CzJl4
        jiPG9fz3A+mjIaSA2hrUYI/1JohWk9t4OZqvJrgBTMRmDvxlrOmX/DkNQ0s07gXDm4Pe+4dSWIguo
        ANU6sF6AXgsYm87kDlD5H2oLO4E/G73fKyV4xFx4CIKfY6LRC/yYPXBkr+9NxNO8hw7Lou0D/8i6J
        4KYBkZHqUCxYC1WR6D9PIdtjmEFwSqBavkiWSktmu5xkdovrLbba9gtYFVZHDRAlV3lBBwKZ2RcB8
        vQghUzFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LEq-00FSLH-0M;
        Wed, 31 May 2023 12:47:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B7603015B5;
        Wed, 31 May 2023 14:47:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 29BA422BA6462; Wed, 31 May 2023 14:47:34 +0200 (CEST)
Message-ID: <20230531124604.615053451@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:54 +0200
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
Subject: [RFC][PATCH 15/15] sched/eevdf: Use sched_attr::sched_runtime to set request/slice
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

As an alternative to the latency-nice interface; allow applications to
directly set the request/slice using sched_attr::sched_runtime.

The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.

Applications should strive to use their periodic runtime at a high
confidence interval (95%+) as the target slice. Using a smaller slice
will introduce undue preemptions, while using a larger value will
reduce latency.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7494,10 +7494,18 @@ static void __setscheduler_params(struct
 
 	p->policy = policy;
 
-	if (dl_policy(policy))
+	if (dl_policy(policy)) {
 		__setparam_dl(p, attr);
-	else if (fair_policy(policy))
+	} else if (fair_policy(policy)) {
 		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
+		if (attr->sched_runtime) {
+			p->se.slice = clamp_t(u64, attr->sched_runtime,
+					      NSEC_PER_MSEC/10,   /* HZ=1000 * 10 */
+					      NSEC_PER_MSEC*100); /* HZ=100  / 10 */
+		} else {
+			p->se.slice = sysctl_sched_base_slice;
+		}
+	}
 
 	/*
 	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
@@ -7689,7 +7697,9 @@ static int __sched_setscheduler(struct t
 	 * but store a possible modification of reset_on_fork.
 	 */
 	if (unlikely(policy == p->policy)) {
-		if (fair_policy(policy) && attr->sched_nice != task_nice(p))
+		if (fair_policy(policy) &&
+		    (attr->sched_nice != task_nice(p) ||
+		     (attr->sched_runtime && attr->sched_runtime != p->se.slice)))
 			goto change;
 		if (rt_policy(policy) && attr->sched_priority != p->rt_priority)
 			goto change;
@@ -8017,12 +8027,14 @@ static int sched_copy_attr(struct sched_
 
 static void get_params(struct task_struct *p, struct sched_attr *attr)
 {
-	if (task_has_dl_policy(p))
+	if (task_has_dl_policy(p)) {
 		__getparam_dl(p, attr);
-	else if (task_has_rt_policy(p))
+	} else if (task_has_rt_policy(p)) {
 		attr->sched_priority = p->rt_priority;
-	else
+	} else {
 		attr->sched_nice = task_nice(p);
+		attr->sched_runtime = p->se.slice;
+	}
 }
 
 /**


