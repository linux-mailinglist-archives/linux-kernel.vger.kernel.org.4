Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D594671221
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjARDup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjARDuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:50:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF6251C7E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:50:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C5B161615
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22C5C433EF;
        Wed, 18 Jan 2023 03:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674013842;
        bh=EGKVBC87lAEbUkQXKBFtuooqFnAG927XNLarIjESrrk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qkrwYGQGbsUldsrNGuXnuiWYY89I8RrmD2He5Xq38AfknTAHDnxXk+hmG5J/yPg0m
         cKaRSCKc4/rJtDs+KOiUILGhI/NIOY0bWPVo8dJQ//mx6/nflF4UFdEndL1ls/ENu2
         5eFg7XOZFwo5aHSH3jRbGo+9rTwcgnxM05EYL/zG57jYFz/6OrsAR191PmESIACRJV
         UfvYY+NJIPdURnb7fqONNt/xVynWKruzDUK8kyVYNAJcVBno8dzQQVTzmIhEryOffG
         tndIAuZZILDWWZiT2xhXO/jNrihJCzTeI/ZalKBqQFUjtqHD10JX++Ly8Wzw2vTi3r
         U/SWoekv93IRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A2B905C1052; Tue, 17 Jan 2023 19:50:41 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:50:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 03:15:06PM -0500, Alan Stern wrote:
> On Tue, Jan 17, 2023 at 09:43:08AM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 17, 2023 at 10:56:34AM -0500, Alan Stern wrote:
> > > Isn't it true that the current code will flag srcu-bad-nesting if a 
> > > litmus test has non-nested overlapping SRCU read-side critical sections?
> > 
> > Now that you mention it, it does indeed, flagging srcu-bad-nesting.
> > 
> > Just to see if I understand, different-values yields true if the set
> > contains multiple elements with the same value mapping to different
> > values.  Or, to put it another way, if the relation does not correspond
> > to a function.
> 
> As I understand it, given a relation r (i.e., a set of pairs of events), 
> different-values(r) returns the sub-relation consisting of those pairs 
> in r for which the value associated with the first event of the pair is 
> different from the value associated with the second event of the pair.

OK, so different-values(r) is different than (r \ id) because the
former operates on values and the latter on events?

> For srcu_read_lock() and loads in general, the associated value is the 
> value returned by the function call.  For srcu_read_unlock() and stores 
> in general, the associated value is the value (i.e., the second 
> argument) passed to the function call.

As you say later, it would be good to have that "data" relation include
srcu_read_lock() and srcu_read_unlock().  ;-)

> > Or am I still missing something?
> > 
> > > And if it is true, is there any need to change the memory model at this 
> > > point?
> > > 
> > > (And if it's not true, that's most likely due to a bug in herd7.)
> > 
> > Agreed, changes must wait for SRCU support in herd7.
> 
> Apparently the only change necessary is to make the srcu_read_lock and 
> srcu_read_unlock events act like loads and stores.  In particular, they 
> need to be subject to the standard rules for calculating dependencies.
> 
> Right now the behavior is kind of strange.  The following simple litmus 
> test:
> 
> C test
> {}
> P0(int *x)
> {
> 	int r1;
> 	r1 = srcu_read_lock(x);
> 	srcu_read_unlock(x, r1);
> }
> exists (~0:r1=0)
> 
> produces the following output from herd7:
> 
> Test test Allowed
> States 1
> 0:r1=906;
> Ok
> Witnesses
> Positive: 1 Negative: 0
> Condition exists (not (0:r1=0))
> Observation test Always 1 0
> Time test 0.01
> Hash=2f42c87ae9c1d267f4e80c66f646b9bb
> 
> Don't ask me where that 906 value comes from or why it is't 0.  Also, 
> herd7's graphical output shows there is no data dependency from the lock 
> to the unlock, but we need to have one.

Is it still the case that any herd7 value greater than 127 is special?

> > At which point something roughly similar to this might work?
> > 
> > let srcu-rscs = return_value(Srcu-lock) ; (dep | rfi)* ;
> > 		parameter(Srcu-unlock, 2)
> 
> I can't tell what that's supposed to mean.  In any case, I think what 
> you want would be:
> 
> let srcu-rscs = ([Srcu-lock] ; data ; [Srcu-unlock]) & loc

Agreed, given that (data) is supposed to propagate through locals
and globals.  Within the Linux kernel, assigning the return value from
srcu_read_lock() to a global is asking for it, though.

> > Given an Srcu-down and an Srcu-up:
> > 
> > let srcu-rscs = ( return_value(Srcu-lock) ; (dep | rfi)* ;
> > 		  parameter(Srcu-unlock, 2) ) |
> > 		( return_value(Srcu-down) ; (dep | rf)* ;
> > 		  parameter(Srcu-up, 2) )
> > 
> > Seem reasonable, or am I missing yet something else?
> 
> Not at all reasonable.
> 
> For one thing, consider this question: Which statements lie inside a 
> read-side critical section?

Here srcu_down_read() and srcu_up_read() are to srcu_read_lock() and
srcu_read_unlock() as down_read() and up_read() are to mutex_lock()
and mutex_unlock().  Not that this should be all that much comfort
given that I have no idea how one would go about modeling down_read()
and up_read() in LKMM.

> With srcu_read_lock() and a matching srcu_read_unlock(), the answer is 
> clear: All statements po-between the two.  With srcu_down_read() and 
> srcu_up_read(), the answer is cloudy in the extreme.

And I agree that it must be clearly specified, and my that previous try
was completely lacking.  Here is a second attempt:

let srcu-rscs = (([Srcu-lock] ; data ; [Srcu-unlock]) & loc) |
		(([Srcu-down] ; (data | rf)* ; [Srcu-up]) & loc)

(And I see your proposal and will try it.)

> Also, bear in mind that the Fundamental Law of RCU is formulated in 
> terms of stores propagating to a critical section's CPU.  What are we to 
> make of this when a single critical section can belong to more than one 
> CPU?

One way of answering this question is by analogy with down() and up()
when used as a cross-task mutex.  Another is by mechanically applying
some of current LKMM.  Let's start with this second option.

LKMM works mostly with critical sections, but we also discussed ordering
based on the set of events po-after an srcu_read_lock() on the one hand
and the set of events po-before an srcu_read_unlock() on the other.
Starting here, the critical section is the intersection of these two sets.

In the case of srcu_down_read() and srcu_up_read(), as you say, whatever
might be a critical section must span processes.  So what if instead of
po, we used (say) xbstar?  Then given a set of A such that ([Srcu-down ;
xbstar ; A) and B such that (B ; xbstar ; [Srcu-up]), then the critical
section is the intersection of A and B.

One objection to this approach is that a bunch of unrelated events could
end up being defined as part of the critical section.  Except that this
happens already anyway in real critical sections in the Linux kernel.

So what about down() and up() when used as cross-task mutexes?
These often do have conceptual critical sections that protect some
combination of resource, but these critical sections might span tasks
and/or workqueue handlers.  And any reasonable definition of these
critical sections would be just as likely to pull in unrelated accesses as
the above intersection approach for srcu_down_read() and srcu_up_read().

But I am just now making all this up, so thoughts?

> Indeed, given:
> 
> 	P0(int *x) {
> 		srcu_down_read(x);
> 	}
> 
> 	P1(int *x) {
> 		srcu_up_read(x);
> 	}
> 
> what are we to make of executions in which P1 executes before P0?

Indeed, there had better be something else forbidding such executions, or
this is an invalid use of srcu_down_read() and srcu_up_read().  This might
become more clear if the example is expanded to include the index returned
from srcu_down_read() that is to be passed to srcu_up_read():

	P0(int *x, int *i) {
		WRITE_ONCE(i, srcu_down_read(x));
	}

	P1(int *x, int *i) {
		srcu_up_read(x, READ_ONCE(i));
	}

Which it looks like you in fact to have in your patch, so time for me
to go try that out.

							Thanx, Paul
