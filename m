Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F49F712AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbjEZQmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEZQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:42:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB777BC;
        Fri, 26 May 2023 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/2QSTLGqD4iT4FdYiOFZiER0pBrlULh2+1/cvz6IreM=; b=iTZt2k9etvAGrB42jErQZIlq9M
        rBI0aflYiIqy6tAsDZmmQONBFt8owIQj+EIovr1U68zHfLJWg1VrxkF5ud1yg1dXpE+bgWe/9knP0
        R7S9hvAFuqWq11R2s9yd/py4UTJYMl4g1rRo/n1cb135zW2DuOqQsDEZRN5z9ONPzHa8tX60LUQSh
        y3u0OMhufNpUGUq0Roxm0wvXWCBnGjzB8mal1/TEYXDaO0OMBJy48jdp1j9o7LYneEogdV7lo5tAz
        5+zG4as0eaiocVGvPyeyoE9M6ZUrbvoxqjUaT7e0M7WvWrGxp3xk72+zzfs5WxpB05CGd5+wX4NI5
        M9qSiJSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2aVS-002xkV-23; Fri, 26 May 2023 16:41:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55ECB3002F0;
        Fri, 26 May 2023 18:41:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 103F522163BD2; Fri, 26 May 2023 18:41:31 +0200 (CEST)
Date:   Fri, 26 May 2023 18:41:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 2/2] sched: Use fancy new guards
Message-ID: <20230526164130.GA4053578@hirez.programming.kicks-ass.net>
References: <20230526150549.250372621@infradead.org>
 <20230526151947.027972233@infradead.org>
 <2023052626-blunderer-delegator-4b82@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023052626-blunderer-delegator-4b82@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 05:25:58PM +0100, Greg KH wrote:
> On Fri, May 26, 2023 at 05:05:51PM +0200, Peter Zijlstra wrote:
> > Convert kernel/sched/core.c to use the fancy new guards to simplify
> > the error paths.
> 
> That's slightly crazy...
> 
> I like the idea, but is this really correct:
> 
> 
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/core.c  | 1223 +++++++++++++++++++++++----------------------------
> >  kernel/sched/sched.h |   39 +
> >  2 files changed, 595 insertions(+), 667 deletions(-)
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1097,24 +1097,21 @@ int get_nohz_timer_target(void)
> >  
> >  	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
> >  
> > -	rcu_read_lock();
> > -	for_each_domain(cpu, sd) {
> > -		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
> > -			if (cpu == i)
> > -				continue;
> > +	void_scope(rcu) {
> > +		for_each_domain(cpu, sd) {
> > +			for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
> > +				if (cpu == i)
> > +					continue;
> >  
> > -			if (!idle_cpu(i)) {
> > -				cpu = i;
> > -				goto unlock;
> > +				if (!idle_cpu(i))
> > +					return i;
> 
> You can call return from within a "scope" and it will clean up properly?

Yep, that's the main feature here.

> I tried to read the cpp "mess" but couldn't figure out how to validate
> this at all, have a set of tests for this somewhere?

I have it in userspace with printf, but yeah, I'll go make a selftest
somewhere.

One advantage of using the scheduler locks as testbed is that if you get
it wrong it burns *real* fast -- been there done that etc.

> Anyway, the naming is whack, but I don't have a proposed better name,
> except you might want to put "scope_" as the prefix not the suffix, but
> then that might look odd to, so who knows.

Yeah, naming is certainly crazy, but I figured I should get it all
working before spending too much time on that.

I can certainly do 's/lock_scope/scope_lock/g' on it all.

> But again, the idea is good, it might save us lots of "you forgot to
> clean this up on the error path" mess that we are getting constant churn
> for these days...

That's the goal...
