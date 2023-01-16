Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA0D66CF78
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjAPTVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjAPTU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:20:59 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 27751524F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:20:57 -0800 (PST)
Received: (qmail 137219 invoked by uid 1000); 16 Jan 2023 14:20:57 -0500
Date:   Mon, 16 Jan 2023 14:20:57 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
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
Message-ID: <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
References: <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
 <Y8MOOrrHntA9TyUk@rowland.harvard.edu>
 <20230115051510.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8Qog8qf7wIx2Kve@rowland.harvard.edu>
 <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
 <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:06:52AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 16, 2023 at 01:11:41PM -0500, Alan Stern wrote:

> > Why do you want to prohibit nesting?  Why would that be a better 
> > approximation?
> 
> Because the current LKMM gives wrong answers for nested critical
> sections.

I don't agree.  Or at least, it depends on whose definition of "nested 
critical sections" you adopt.

>  For example, for the litmus test shown below, mainline
> LKMM will incorrectly report "Never".  The two SRCU read-side critical
> sections are independent, so the fact that P1()'s synchronize_srcu() is
> guaranteed to wait for the first on to complete says nothing about the
> second having completed.  Therefore, in Linux-kernel SRCU, the "exists"
> clause could be satisfied.
> 
> In contrast, the proposed change flags this as having nesting.

In fact, this litmus test has overlapping critical sections, not nested 
ones.  But the current LKML incorrectly _thinks_ they are nested, 
because it matches each lock with the first unmatched unlock.

If you write a litmus test that has properly nested (not overlapping!) 
read-side critical sections, the current LKMM will match the locks and 
unlocks correctly and will give the right answer.

So what you really want to do is rule out overlapping, not nesting.  But 
I guess there's no way to do one without the other.

Alan

> 							Thaxn, Paul
> 
> ------------------------------------------------------------------------
> 
> C C-srcu-nest-5
> 
> (*
>  * Result: Sometimes
>  *
>  * This demonstrates non-nesting of SRCU read-side critical sections.
>  * Unlike RCU, SRCU critical sections do not nest.
>  *)
> 
> {}
> 
> P0(int *x, int *y, struct srcu_struct *s1)
> {
> 	int r1;
> 	int r2;
> 	int r3;
> 	int r4;
> 
> 	r3 = srcu_read_lock(s1);
> 	r2 = READ_ONCE(*y);
> 	r4 = srcu_read_lock(s1);
> 	srcu_read_unlock(s1, r3);
> 	r1 = READ_ONCE(*x);
> 	srcu_read_unlock(s1, r4);
> }
> 
> P1(int *x, int *y, struct srcu_struct *s1)
> {
> 	WRITE_ONCE(*y, 1);
> 	synchronize_srcu(s1);
> 	WRITE_ONCE(*x, 1);
> }
> 
> locations [0:r1]
> exists (0:r1=1 /\ 0:r2=0)
