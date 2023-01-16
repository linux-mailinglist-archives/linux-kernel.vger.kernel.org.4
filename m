Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089C566CF53
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjAPTHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjAPTGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:06:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA26298E7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:06:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4124D61123
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94814C433EF;
        Mon, 16 Jan 2023 19:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673896012;
        bh=/4lqJw+MW10yFNzZpZTh/NCIHg4tnhSxEPNCyHASEK8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f54ph7NeGFqhQND/+hT4HRcVd3or9IHwutjUQhUO0IXX9lAzfHKmYG12D6ieRiExO
         Mr1bVAJhVE4eL6E2v7Tc2CATTK+b5Gp/s+d/zNUebefCxPAHB7DyhwWeedIQ7tJIT8
         ZuxyR0AtadV9oeva2ZuTE2q24XWzSmxdqo6V7DJWXO02Ueri6ZLK9wh519ZIeVkRms
         dv4spAHPEyREZ4zjMxBc/BHJt7bEriHhTuYMaB1qL2Gnz6wIY2pEFaN4GrGvVnhY1F
         4iUICx7lFTJJSSzvVtBgloddu7WYAnNVgZa5mrwiQlSphcG1yMO2pSuGkBpddNAW86
         PPGpuXq1pdhOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 37EF95C0687; Mon, 16 Jan 2023 11:06:52 -0800 (PST)
Date:   Mon, 16 Jan 2023 11:06:52 -0800
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
Message-ID: <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <136d019d8c8049f6b737627df830e66f@huawei.com>
 <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
 <Y8MOOrrHntA9TyUk@rowland.harvard.edu>
 <20230115051510.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8Qog8qf7wIx2Kve@rowland.harvard.edu>
 <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
 <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 01:11:41PM -0500, Alan Stern wrote:
> On Sun, Jan 15, 2023 at 08:23:29PM -0800, Paul E. McKenney wrote:
> > On Sun, Jan 15, 2023 at 03:46:10PM -0500, Alan Stern wrote:
> > > On Sun, Jan 15, 2023 at 10:10:52AM -0800, Paul E. McKenney wrote:
> > > > On Sun, Jan 15, 2023 at 11:23:31AM -0500, Alan Stern wrote:
> > > > > On Sat, Jan 14, 2023 at 09:15:10PM -0800, Paul E. McKenney wrote:
> > > > > > What am I missing here?
> > > > > 
> > > > > I don't think you're missing anything.  This is a matter for Boqun or 
> > > > > Luc; it must have something to do with the way herd treats the 
> > > > > srcu_read_lock() and srcu_read_unlock() primitives.
> > > > 
> > > > It looks like we need something that tracks (data | rf)* between
> > > > the return value of srcu_read_lock() and the second parameter of
> > > > srcu_read_unlock().  The reason for rf rather than rfi is the upcoming
> > > > srcu_down_read() and srcu_up_read().
> > > 
> > > Or just make herd treat srcu_read_lock(s) as an annotated equivalent of 
> > > READ_ONCE(&s) and srcu_read_unlock(s, v) as an annotated equivalent of 
> > > WRITE_ONCE(s, v).  But with some special accomodation to avoid 
> > > interaction with the new carry-dep relation.
> > 
> > This is a modification to herd7 you are suggesting?  Otherwise, I am
> > suffering a failure of imagination on how to properly sort it from the
> > other READ_ONCE() and WRITE_ONCE() instances.
> 
> srcu_read_lock and srcu_read_unlock events would be distinguished from 
> other marked loads and stores by belonging to the Srcu-lock and 
> Srcu-unlock sets.  But I don't know whether this result can be 
> accomplished just by modifying the .def file -- it might require changes 
> to herd7.  (In fact, as far as I know there is no documentation at all 
> for the double-underscore operations used in linux-kernel.def.  Hint 
> hint!)
> 
> As mentioned earlier, we should ask Luc or Boqun.

Good point, will do.

> > > > Or is there some better intermediate position that could be taken?
> > > 
> > > Do you mean go back to the current linux-kernel.bell?  The code you 
> > > wrote above is different, since it prohibits nesting.
> > 
> > Not to the current linux-kernel.bell, but, as you say, making the change
> > to obtain a better approximation by prohibiting nesting.
> 
> Why do you want to prohibit nesting?  Why would that be a better 
> approximation?

Because the current LKMM gives wrong answers for nested critical
sections.  For example, for the litmus test shown below, mainline
LKMM will incorrectly report "Never".  The two SRCU read-side critical
sections are independent, so the fact that P1()'s synchronize_srcu() is
guaranteed to wait for the first on to complete says nothing about the
second having completed.  Therefore, in Linux-kernel SRCU, the "exists"
clause could be satisfied.

In contrast, the proposed change flags this as having nesting.

							Thaxn, Paul

------------------------------------------------------------------------

C C-srcu-nest-5

(*
 * Result: Sometimes
 *
 * This demonstrates non-nesting of SRCU read-side critical sections.
 * Unlike RCU, SRCU critical sections do not nest.
 *)

{}

P0(int *x, int *y, struct srcu_struct *s1)
{
	int r1;
	int r2;
	int r3;
	int r4;

	r3 = srcu_read_lock(s1);
	r2 = READ_ONCE(*y);
	r4 = srcu_read_lock(s1);
	srcu_read_unlock(s1, r3);
	r1 = READ_ONCE(*x);
	srcu_read_unlock(s1, r4);
}

P1(int *x, int *y, struct srcu_struct *s1)
{
	WRITE_ONCE(*y, 1);
	synchronize_srcu(s1);
	WRITE_ONCE(*x, 1);
}

locations [0:r1]
exists (0:r1=1 /\ 0:r2=0)
