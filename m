Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB487127D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbjEZNzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEZNzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:55:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28202DF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+e2DKNlvGt5M5nGvUwYYIdq9yzO5XQ9oRYgjqZP3Ayo=; b=bH70WdNRplLWhWIhT+bJni5cPN
        ijZQMeLZvbzIVv6s+wqrSRu9atdkdEAfltlQco5Rnh+4YSHH5Pq6KLY8fnr6kboUkaVMeu4/sYvif
        dXP3BI1/VZAx8gB56Q9ezUcwAY4jaqOpS/ETIi12c2ENW6B8hDflflTRuUW7Kg5oDOMteyBQ5LhOP
        IyVXuYAuJVbi/CXRCyxY3UDH4+jz9YVLr16FQqNxeRJR328g4buMqnWIX5+AjOWfwZHn0MWr6zIUM
        1FIIW7FcgvNPMIQiQtBVpcljFXSItDoL+icABtqiaCjpOIYNzWVSDcmutyKU2J1gvcUBdjBJ2n89q
        07VXVL+Q==;
Received: from [24.132.130.84] (helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2SSH-002YAY-F0; Fri, 26 May 2023 08:05:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78E053006B1;
        Fri, 26 May 2023 10:05:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D4232640A8B4; Fri, 26 May 2023 10:05:43 +0200 (CEST)
Date:   Fri, 26 May 2023 10:05:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Consider task_struct::saved_state in
 wait_task_inactive().
Message-ID: <20230526080543.GF38236@hirez.programming.kicks-ass.net>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <20230525165244.GV83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525165244.GV83892@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 06:52:44PM +0200, Peter Zijlstra wrote:
> On Fri, Feb 17, 2023 at 03:53:02PM +0100, Sebastian Andrzej Siewior wrote:
> 
> > +static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
> > +{
> > +	unsigned long flags;
> > +	bool mismatch;
> > +
> > +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> > +	if (READ_ONCE(p->__state) & match_state)
> > +		mismatch = false;
> > +	else if (READ_ONCE(p->saved_state) & match_state)
> > +		mismatch = false;
> > +	else
> > +		mismatch = true;
> > +
> > +	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> > +	return mismatch;
> > +}
> > +static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
> > +					bool *wait)
> > +{
> > +	if (READ_ONCE(p->__state) & match_state)
> > +		return true;
> > +	if (READ_ONCE(p->saved_state) & match_state) {
> > +		*wait = true;
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +#else
> > +static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
> > +{
> > +	return !(READ_ONCE(p->__state) & match_state);
> > +}
> > +static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
> > +					bool *wait)
> > +{
> > +	return (READ_ONCE(p->__state) & match_state);
> > +}
> > +#endif
> > +
> >  /*
> >   * wait_task_inactive - wait for a thread to unschedule.
> >   *
> 
> Urgh...
> 
> I've ended up with the below.. I've tried folding it with
> ttwu_state_match() but every attempt so far makes it an unholy mess.
> 
> Now, if only we had proper lock guard then we could drop another few
> lines, but alas.

New day, new chances... How's this? Code-gen doesn't look totally
insane, but then, making sense of an optimizing compiler's output is
always a wee challenge.

---
 kernel/sched/core.c | 55 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..d89610fffd23 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3341,6 +3341,35 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p,
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+static __always_inline
+int __task_state_match(struct task_struct *p, unsigned int state)
+{
+	if (READ_ONCE(p->__state) & state)
+		return 1;
+
+#ifdef CONFIG_PREEMPT_RT
+	if (READ_ONCE(p->saved_state) & state)
+		return -1;
+#endif
+	return 0;
+}
+
+static __always_inline
+int task_state_match(struct task_struct *p, unsigned int state)
+{
+#ifdef CONFIG_PREEMPT_RT
+	int match;
+
+	raw_spin_lock_irq(&p->pi_lock);
+	match = __task_state_match(p, state);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	return match;
+#else
+	return __task_state_match(p, state);
+#endif
+}
+
 /*
  * wait_task_inactive - wait for a thread to unschedule.
  *
@@ -3359,7 +3388,7 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p,
  */
 unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
 {
-	int running, queued;
+	int running, queued, match;
 	struct rq_flags rf;
 	unsigned long ncsw;
 	struct rq *rq;
@@ -3385,7 +3414,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_on_cpu(rq, p)) {
-			if (!(READ_ONCE(p->__state) & match_state))
+			if (!task_state_match(p, match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3400,8 +3429,15 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (READ_ONCE(p->__state) & match_state)
+		if ((match = __task_state_match(p, match_state))) {
+			/*
+			 * When matching on p->saved_state, consider this task
+			 * still queued so it will wait.
+			 */
+			if (match < 0)
+				queued = 1;
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
+		}
 		task_rq_unlock(rq, p, &rf);
 
 		/*
@@ -4003,15 +4039,14 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 static __always_inline
 bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 {
+	int match;
+
 	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)) {
 		WARN_ON_ONCE((state & TASK_RTLOCK_WAIT) &&
 			     state != TASK_RTLOCK_WAIT);
 	}
 
-	if (READ_ONCE(p->__state) & state) {
-		*success = 1;
-		return true;
-	}
+	*success = !!(match = __task_state_match(p, state));
 
 #ifdef CONFIG_PREEMPT_RT
 	/*
@@ -4027,12 +4062,10 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 	 * p::saved_state to TASK_RUNNING so any further tests will
 	 * not result in false positives vs. @success
 	 */
-	if (p->saved_state & state) {
+	if (match < 0)
 		p->saved_state = TASK_RUNNING;
-		*success = 1;
-	}
 #endif
-	return false;
+	return match > 0;
 }
 
 /*
