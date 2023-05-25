Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27CB711165
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjEYQxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjEYQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:53:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158D9194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cfgTSMcxjwAGXAqRNOZFC56D/VdiYcVGEhQCRK6sn0Y=; b=mDe/26FnD6W+OGKvkXu8PLYy77
        hr9jPTGJEbt/5j/0R4TNbVUZ+mooTo29WEyBUk8G+FbrKw+xQCPENoEmUUO/BXgUtCiVQE0gKV+cM
        nl/T3f3k4fcF2lSkhBkrf5Cr0sPCkPoY28Cq0zG0LqpZRLb1oPUyt/cUG7jxqJEAvVjMUCztvlZv1
        6v08UWtzYIHDBy0T03R5DeUIXLiVM0JqlmDRY/F9NbBdetf0L/Ktm6QWADs/Y5PzOsCAHHDlSxVxR
        1+1OGzxvQ4eoUVP+3Wu9c1XRBa7Zx+lMj9xi+CUmldJVBe1Ur+d4ZkEgPtJRs4BVtSHuN+KmfpiN4
        /uZ2L07w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2ECk-006bTt-1V;
        Thu, 25 May 2023 16:52:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55B0C300338;
        Thu, 25 May 2023 18:52:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C10C24393D93; Thu, 25 May 2023 18:52:44 +0200 (CEST)
Date:   Thu, 25 May 2023 18:52:44 +0200
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
Message-ID: <20230525165244.GV83892@hirez.programming.kicks-ass.net>
References: <Y++UzubyNavLKFDP@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y++UzubyNavLKFDP@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 03:53:02PM +0100, Sebastian Andrzej Siewior wrote:

> +static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
> +{
> +	unsigned long flags;
> +	bool mismatch;
> +
> +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> +	if (READ_ONCE(p->__state) & match_state)
> +		mismatch = false;
> +	else if (READ_ONCE(p->saved_state) & match_state)
> +		mismatch = false;
> +	else
> +		mismatch = true;
> +
> +	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> +	return mismatch;
> +}
> +static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
> +					bool *wait)
> +{
> +	if (READ_ONCE(p->__state) & match_state)
> +		return true;
> +	if (READ_ONCE(p->saved_state) & match_state) {
> +		*wait = true;
> +		return true;
> +	}
> +	return false;
> +}
> +#else
> +static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
> +{
> +	return !(READ_ONCE(p->__state) & match_state);
> +}
> +static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
> +					bool *wait)
> +{
> +	return (READ_ONCE(p->__state) & match_state);
> +}
> +#endif
> +
>  /*
>   * wait_task_inactive - wait for a thread to unschedule.
>   *

Urgh...

I've ended up with the below.. I've tried folding it with
ttwu_state_match() but every attempt so far makes it an unholy mess.

Now, if only we had proper lock guard then we could drop another few
lines, but alas.

---
 kernel/sched/core.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..5a106629a98d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3341,6 +3341,37 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p,
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+static __always_inline
+bool __wti_state_match(struct task_struct *p, unsigned int state, int *queued)
+{
+	if (READ_ONCE(p->__state) & state)
+		return true;
+
+#ifdef CONFIG_PREEMPT_RT
+	if (READ_ONCE(p->saved_state) & state) {
+		if (queued)
+			*queued = 1;
+		return true;
+	}
+#endif
+	return false;
+}
+
+static __always_inline bool wti_state_match(struct task_struct *p, unsigned int state)
+{
+#ifdef CONFIG_PREEMPT_RT
+	bool match;
+
+	raw_spin_lock_irq(&p->pi_lock);
+	match = __wti_state_match(p, state, NULL);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	return match;
+#else
+	return __wti_state_match(p, state, NULL);
+#endif
+}
+
 /*
  * wait_task_inactive - wait for a thread to unschedule.
  *
@@ -3385,7 +3416,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_on_cpu(rq, p)) {
-			if (!(READ_ONCE(p->__state) & match_state))
+			if (!wti_state_match(p, match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3400,7 +3431,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (READ_ONCE(p->__state) & match_state)
+		if (__wti_state_match(p, match_state, &queued))
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
