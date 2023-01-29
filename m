Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0E6802B6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjA2XJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA2XJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:09:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F1C18B20
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 15:09:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B99E260E76
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 23:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055D2C433EF;
        Sun, 29 Jan 2023 23:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675033741;
        bh=Z1FWLUxLy3wZx0fkSLKgTRs1+BQ2XfTS0l6hA5rBPYg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eIvGXPN2rnJe+lrp37JhnK5xWsqI1sC8rmQJKWsEB+K2C4bU/CHQnEdl3+S6i7tWK
         N2MwxlORsl87EZEVWir1jib5iB5foM3jvRQEUpDnnUfZIoAbSbfixynYX0WXtMtT85
         CzbKaqNLFxTc0hMhL376KBfJk5qbYx1VqHqwnKibyK+MBMGeibuOalW/7PgTnL8B2G
         PwpUssxB8+IuPV8q88lTCc7STV0mNnQYNrMC6ZYv0UrAzpybnuYcOZas6LKv7qlZDd
         LPxBNNObwPNwtBWc/CQAUmIh9qAR/CTSf8AOioqu1+jkmEhaVGaPsBkcKsqrVPyOBq
         R+SVkyAB7fSOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A2BA95C0543; Sun, 29 Jan 2023 15:09:00 -0800 (PST)
Date:   Sun, 29 Jan 2023 15:09:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230129230900.GK2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <20230129051734.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9aY4hG3p+82vVIw@rowland.harvard.edu>
 <20230129162156.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9asu0CswZZ3yyls@andrea>
 <20230129184403.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9bomciHJ/6WGYM0@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9bomciHJ/6WGYM0@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 01:43:53PM -0800, Boqun Feng wrote:
> On Sun, Jan 29, 2023 at 10:44:03AM -0800, Paul E. McKenney wrote:
> > On Sun, Jan 29, 2023 at 06:28:27PM +0100, Andrea Parri wrote:
> > > > Why can't P3's spin_lock() read from that initial write?
> > > 
> > > Mmh, sounds like you want to play with something like below?
> > > 
> > >   Andrea
> > > 
> > > diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> > > index 6b52f365d73ac..20c3af4511255 100644
> > > --- a/tools/memory-model/lock.cat
> > > +++ b/tools/memory-model/lock.cat
> > > @@ -74,7 +74,6 @@ flag ~empty UL \ range(critical) as unmatched-unlock
> > >  
> > >  (* Allow up to one unmatched LKW per location; more must deadlock *)
> > >  let UNMATCHED-LKW = LKW \ domain(critical)
> > > -empty ([UNMATCHED-LKW] ; loc ; [UNMATCHED-LKW]) \ id as unmatched-locks
> > >  
> > >  (* rfi for LF events: link each LKW to the LF events in its critical section *)
> > >  let rfi-lf = ([LKW] ; po-loc ; [LF]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
> > > @@ -120,8 +119,7 @@ let rf-ru = rfe-ru | rfi-ru
> > >  let rf = rf | rf-lf | rf-ru
> > >  
> > >  (* Generate all co relations, including LKW events but not UL *)
> > > -let co0 = co0 | ([IW] ; loc ; [LKW]) |
> > > -	(([LKW] ; loc ; [UNMATCHED-LKW]) \ [UNMATCHED-LKW])
> > > +let co0 = co0 | ([IW] ; loc ; [LKW])
> > >  include "cos-opt.cat"
> > >  let W = W | UL
> > >  let M = R | W
> > 
> > No idea.  But the following litmus test gets no executions whatsoever,
> > so point taken about my missing at least one corner case.  ;-)
> > 
> > Adding a spin_unlock() to the end of either process allows both to
> > run.
> > 
> > One could argue that this is a bug, but one could equally well argue
> > that if you have a deadlock, you have a deadlock.
> > 
> 
> in lock.cat: 
> 
> 	(* Allow up to one unmatched LKW per location; more must deadlock *)
> 	let UNMATCHED-LKW = LKW \ domain(critical)
> 	empty ([UNMATCHED-LKW] ; loc ; [UNMATCHED-LKW]) \ id as unmatched-locks
> 
> we rule out deadlocks from the execution candidates we care about.

Thank you, Boqun!

							Thanx, Paul

> Regards,
> Boqun
> 
> > Thoughts?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > C lock
> > 
> > {
> > }
> > 
> > 
> > P0(int *a, int *b, spinlock_t *l)
> > {
> > 	spin_lock(l);
> > 	WRITE_ONCE(*a, 1);
> > }
> > 
> > P1(int *a, int *b, spinlock_t *l)
> > {
> > 	spin_lock(l);
> > 	WRITE_ONCE(*b, 1);
> > }
> > 
> > exists (a=1 /\ b=1)
