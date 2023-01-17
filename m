Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A166E8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjAQV5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjAQVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:51:51 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 96743A249
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:15:07 -0800 (PST)
Received: (qmail 180556 invoked by uid 1000); 17 Jan 2023 15:15:06 -0500
Date:   Tue, 17 Jan 2023 15:15:06 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
References: <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
 <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:43:08AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 17, 2023 at 10:56:34AM -0500, Alan Stern wrote:
> > Isn't it true that the current code will flag srcu-bad-nesting if a 
> > litmus test has non-nested overlapping SRCU read-side critical sections?
> 
> Now that you mention it, it does indeed, flagging srcu-bad-nesting.
> 
> Just to see if I understand, different-values yields true if the set
> contains multiple elements with the same value mapping to different
> values.  Or, to put it another way, if the relation does not correspond
> to a function.

As I understand it, given a relation r (i.e., a set of pairs of events), 
different-values(r) returns the sub-relation consisting of those pairs 
in r for which the value associated with the first event of the pair is 
different from the value associated with the second event of the pair.

For srcu_read_lock() and loads in general, the associated value is the 
value returned by the function call.  For srcu_read_unlock() and stores 
in general, the associated value is the value (i.e., the second 
argument) passed to the function call.

> Or am I still missing something?
> 
> > And if it is true, is there any need to change the memory model at this 
> > point?
> > 
> > (And if it's not true, that's most likely due to a bug in herd7.)
> 
> Agreed, changes must wait for SRCU support in herd7.

Apparently the only change necessary is to make the srcu_read_lock and 
srcu_read_unlock events act like loads and stores.  In particular, they 
need to be subject to the standard rules for calculating dependencies.

Right now the behavior is kind of strange.  The following simple litmus 
test:

C test
{}
P0(int *x)
{
	int r1;
	r1 = srcu_read_lock(x);
	srcu_read_unlock(x, r1);
}
exists (~0:r1=0)

produces the following output from herd7:

Test test Allowed
States 1
0:r1=906;
Ok
Witnesses
Positive: 1 Negative: 0
Condition exists (not (0:r1=0))
Observation test Always 1 0
Time test 0.01
Hash=2f42c87ae9c1d267f4e80c66f646b9bb

Don't ask me where that 906 value comes from or why it is't 0.  Also, 
herd7's graphical output shows there is no data dependency from the lock 
to the unlock, but we need to have one.

> At which point something roughly similar to this might work?
> 
> let srcu-rscs = return_value(Srcu-lock) ; (dep | rfi)* ;
> 		parameter(Srcu-unlock, 2)

I can't tell what that's supposed to mean.  In any case, I think what 
you want would be:

let srcu-rscs = ([Srcu-lock] ; data ; [Srcu-unlock]) & loc

> Given an Srcu-down and an Srcu-up:
> 
> let srcu-rscs = ( return_value(Srcu-lock) ; (dep | rfi)* ;
> 		  parameter(Srcu-unlock, 2) ) |
> 		( return_value(Srcu-down) ; (dep | rf)* ;
> 		  parameter(Srcu-up, 2) )
> 
> Seem reasonable, or am I missing yet something else?

Not at all reasonable.

For one thing, consider this question: Which statements lie inside a 
read-side critical section?

With srcu_read_lock() and a matching srcu_read_unlock(), the answer is 
clear: All statements po-between the two.  With srcu_down_read() and 
srcu_up_read(), the answer is cloudy in the extreme.

Also, bear in mind that the Fundamental Law of RCU is formulated in 
terms of stores propagating to a critical section's CPU.  What are we to 
make of this when a single critical section can belong to more than one 
CPU?

Indeed, given:

	P0(int *x) {
		srcu_down_read(x);
	}

	P1(int *x) {
		srcu_up_read(x);
	}

what are we to make of executions in which P1 executes before P0?

Alan
