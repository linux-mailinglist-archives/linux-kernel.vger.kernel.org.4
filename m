Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F03766D19E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjAPWQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjAPWPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:15:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8C32CC5C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:15:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8644EB81061
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 22:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A32C433D2;
        Mon, 16 Jan 2023 22:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673907239;
        bh=HDDwsr/jVcWfGKARG5uQ3ogSLNqfka/oq/xPUxmY2GY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bwDMRWA7XqFOnrEgWlT1LjqlaY/rqBtGz1B8zitJJ5+ZxUAB5e4mwJKdNN+vi/lkf
         nViRNWbJ0+s6ZgbPI1euMKpH48C0Bdrx2eZ6SPvfGEUvrz1IYpf9kawMm7pvqZFdS5
         erSjDNYKQbfsnAF0O8NF8ERUX7fm8hneIIQ/A1spDpuGpTMgrDMA+VlbL2DeP8N726
         HpT65ete1zs8643SboeSh9p/cWJadhFS6IeCQLNP/QC3ZaaqjRhpsutyAcLXb8pPGr
         aUHA5tRTr8W9gjttpJLpeiecK3tFodzyU4EjGuIIbHULqvPvvM+JlRnGqUSYsha5F3
         4EK5QN6mdZX6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C2BEC5C0687; Mon, 16 Jan 2023 14:13:57 -0800 (PST)
Date:   Mon, 16 Jan 2023 14:13:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
 <Y8MOOrrHntA9TyUk@rowland.harvard.edu>
 <20230115051510.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8Qog8qf7wIx2Kve@rowland.harvard.edu>
 <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
 <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 02:20:57PM -0500, Alan Stern wrote:
> On Mon, Jan 16, 2023 at 11:06:52AM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 16, 2023 at 01:11:41PM -0500, Alan Stern wrote:
> 
> > > Why do you want to prohibit nesting?  Why would that be a better 
> > > approximation?
> > 
> > Because the current LKMM gives wrong answers for nested critical
> > sections.
> 
> I don't agree.  Or at least, it depends on whose definition of "nested 
> critical sections" you adopt.

Fair point, and I have therefore updated the test's header comment
to read as follows:

(*
 * Result: Sometimes
 *
 * This demonstrates non-nested overlapping of SRCU read-side critical
 * sections.  Unlike RCU, SRCU critical sections do not unconditionally
 * nest.
 *)

> >  For example, for the litmus test shown below, mainline
> > LKMM will incorrectly report "Never".  The two SRCU read-side critical
> > sections are independent, so the fact that P1()'s synchronize_srcu() is
> > guaranteed to wait for the first on to complete says nothing about the
> > second having completed.  Therefore, in Linux-kernel SRCU, the "exists"
> > clause could be satisfied.
> > 
> > In contrast, the proposed change flags this as having nesting.
> 
> In fact, this litmus test has overlapping critical sections, not nested 
> ones.  But the current LKML incorrectly _thinks_ they are nested, 
> because it matches each lock with the first unmatched unlock.
> 
> If you write a litmus test that has properly nested (not overlapping!) 
> read-side critical sections, the current LKMM will match the locks and 
> unlocks correctly and will give the right answer.
> 
> So what you really want to do is rule out overlapping, not nesting.  But 
> I guess there's no way to do one without the other.

None that I could see!

							Thanx, Paul

> Alan
> 
> > 							Thaxn, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > C C-srcu-nest-5
> > 
> > (*
> >  * Result: Sometimes
> >  *
> >  * This demonstrates non-nesting of SRCU read-side critical sections.
> >  * Unlike RCU, SRCU critical sections do not nest.
> >  *)
> > 
> > {}
> > 
> > P0(int *x, int *y, struct srcu_struct *s1)
> > {
> > 	int r1;
> > 	int r2;
> > 	int r3;
> > 	int r4;
> > 
> > 	r3 = srcu_read_lock(s1);
> > 	r2 = READ_ONCE(*y);
> > 	r4 = srcu_read_lock(s1);
> > 	srcu_read_unlock(s1, r3);
> > 	r1 = READ_ONCE(*x);
> > 	srcu_read_unlock(s1, r4);
> > }
> > 
> > P1(int *x, int *y, struct srcu_struct *s1)
> > {
> > 	WRITE_ONCE(*y, 1);
> > 	synchronize_srcu(s1);
> > 	WRITE_ONCE(*x, 1);
> > }
> > 
> > locations [0:r1]
> > exists (0:r1=1 /\ 0:r2=0)
