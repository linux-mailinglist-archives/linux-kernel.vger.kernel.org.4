Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE28366E1D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjAQPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjAQPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:14:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394AE24102
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:14:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBB7FB815AA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9719BC433D2;
        Tue, 17 Jan 2023 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673968456;
        bh=+6xJTEWsucgd0urRiwxzMqUf02zncBOUP+sryF1wL7E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oyWa3yYeIq2L+sMqZ20rO3zUQ3V02YcGu5MEq1+NTEfl12+OBnsRhVE/zVhnu1E1T
         b4xmM1SBW71t0EeQZjGsIw7+tP04MjWBg3HxbY5XxehphMlvmxBuVWRHSXts7HfPKK
         Uxjn+oAM4/Wo9zjJOzcZWZGWtzu5VtCpz/5YdVkhc/9YNvX47wldJCJTy9NVKVhBCq
         OslZjlDARFg3Mx9292UY9gjt6h7HoDKgahTsJVXUhPqwdUdXelhMZMI5NlOVqtscgW
         6VLY4Dy0P76LHkKW3dTTXlDTs4vhlg6XnzhFo6XQZswkdABdHajy53m+ujrsnpHsDa
         Lzn6US+zlSzMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 340505C0543; Tue, 17 Jan 2023 07:14:16 -0800 (PST)
Date:   Tue, 17 Jan 2023 07:14:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230115051510.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8Qog8qf7wIx2Kve@rowland.harvard.edu>
 <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
 <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8aKlNY4Z0z2Yqs0@andrea>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 12:46:28PM +0100, Andrea Parri wrote:
> On Mon, Jan 16, 2023 at 02:13:57PM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 16, 2023 at 02:20:57PM -0500, Alan Stern wrote:
> > > On Mon, Jan 16, 2023 at 11:06:52AM -0800, Paul E. McKenney wrote:
> > > > On Mon, Jan 16, 2023 at 01:11:41PM -0500, Alan Stern wrote:
> > > 
> > > > > Why do you want to prohibit nesting?  Why would that be a better 
> > > > > approximation?
> > > > 
> > > > Because the current LKMM gives wrong answers for nested critical
> > > > sections.
> > > 
> > > I don't agree.  Or at least, it depends on whose definition of "nested 
> > > critical sections" you adopt.
> > 
> > Fair point, and I have therefore updated the test's header comment
> > to read as follows:
> > 
> > (*
> >  * Result: Sometimes
> >  *
> >  * This demonstrates non-nested overlapping of SRCU read-side critical
> >  * sections.  Unlike RCU, SRCU critical sections do not unconditionally
> >  * nest.
> >  *)
> > 
> > > >  For example, for the litmus test shown below, mainline
> > > > LKMM will incorrectly report "Never".  The two SRCU read-side critical
> > > > sections are independent, so the fact that P1()'s synchronize_srcu() is
> > > > guaranteed to wait for the first on to complete says nothing about the
> > > > second having completed.  Therefore, in Linux-kernel SRCU, the "exists"
> > > > clause could be satisfied.
> > > > 
> > > > In contrast, the proposed change flags this as having nesting.
> > > 
> > > In fact, this litmus test has overlapping critical sections, not nested 
> > > ones.  But the current LKML incorrectly _thinks_ they are nested, 
> > > because it matches each lock with the first unmatched unlock.
> > > 
> > > If you write a litmus test that has properly nested (not overlapping!) 
> > > read-side critical sections, the current LKMM will match the locks and 
> > > unlocks correctly and will give the right answer.
> > > 
> > > So what you really want to do is rule out overlapping, not nesting.  But 
> > > I guess there's no way to do one without the other.
> > 
> > None that I could see!
> 
> This was reminiscent of old discussions, in fact, we do have:
> 
> [tools/memory-model/Documentation/litmus-tests.txt]
> 
> e.	Although sleepable RCU (SRCU) is now modeled, there
> 	are some subtle differences between its semantics and
> 	those in the Linux kernel.  For example, the kernel
> 	might interpret the following sequence as two partially
> 	overlapping SRCU read-side critical sections:
> 
> 		 1  r1 = srcu_read_lock(&my_srcu);
> 		 2  do_something_1();
> 		 3  r2 = srcu_read_lock(&my_srcu);
> 		 4  do_something_2();
> 		 5  srcu_read_unlock(&my_srcu, r1);
> 		 6  do_something_3();
> 		 7  srcu_read_unlock(&my_srcu, r2);
> 
> 	In contrast, LKMM will interpret this as a nested pair of
> 	SRCU read-side critical sections, with the outer critical
> 	section spanning lines 1-7 and the inner critical section
> 	spanning lines 3-5.
> 
> 	This difference would be more of a concern had anyone
> 	identified a reasonable use case for partially overlapping
> 	SRCU read-side critical sections.  For more information
> 	on the trickiness of such overlapping, please see:
> 	https://paulmck.livejournal.com/40593.html

Good point, if we do change the definition, we also need to update
this documentation.

> More recently/related,
> 
>   https://lore.kernel.org/lkml/20220421230848.GA194034@paulmck-ThinkPad-P17-Gen-1/T/#m2a8701c7c377ccb27190a6679e58b0929b0b0ad9

It would not be a bad thing for LKMM to be able to show people the
error of their ways when they try non-nested partially overlapping SRCU
read-side critical sections.  Or, should they find some valid use case,
to help them prove their point.  ;-)

							Thanx, Paul

> Thanks,
>   Andrea
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > Alan
> > > 
> > > > 							Thaxn, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > C C-srcu-nest-5
> > > > 
> > > > (*
> > > >  * Result: Sometimes
> > > >  *
> > > >  * This demonstrates non-nesting of SRCU read-side critical sections.
> > > >  * Unlike RCU, SRCU critical sections do not nest.
> > > >  *)
> > > > 
> > > > {}
> > > > 
> > > > P0(int *x, int *y, struct srcu_struct *s1)
> > > > {
> > > > 	int r1;
> > > > 	int r2;
> > > > 	int r3;
> > > > 	int r4;
> > > > 
> > > > 	r3 = srcu_read_lock(s1);
> > > > 	r2 = READ_ONCE(*y);
> > > > 	r4 = srcu_read_lock(s1);
> > > > 	srcu_read_unlock(s1, r3);
> > > > 	r1 = READ_ONCE(*x);
> > > > 	srcu_read_unlock(s1, r4);
> > > > }
> > > > 
> > > > P1(int *x, int *y, struct srcu_struct *s1)
> > > > {
> > > > 	WRITE_ONCE(*y, 1);
> > > > 	synchronize_srcu(s1);
> > > > 	WRITE_ONCE(*x, 1);
> > > > }
> > > > 
> > > > locations [0:r1]
> > > > exists (0:r1=1 /\ 0:r2=0)
