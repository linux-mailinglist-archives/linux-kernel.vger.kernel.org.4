Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAAC653538
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiLURa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLURaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:30:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B732529F;
        Wed, 21 Dec 2022 09:30:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66D846187C;
        Wed, 21 Dec 2022 17:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461E0C433EF;
        Wed, 21 Dec 2022 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671643808;
        bh=L5LFj0rta4nug9qHuoHXNeHR10A6TuA0EVWGsjxjrxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jT79d7EClpeWvwxpJ1quJpz1HsaRqGSn9TcQ7DMx6TNUQUmCNf+hsk4qV+yr+0LDe
         PfVnyuMTDBxQ/VMdVb+4Mf183+PI0UOU6rhN3azhh+3MaTYJydHpNLs+zPrMiK9n0i
         hJipVDDNAppreO2b3DPB9I32lh6F58bXpRJJvIqnFMYFHeOy1jwxwRsZrRxdAPKQV5
         Mk1ZrRM9rRnIv/9zyd3I5IVTrFwZX2r1+cvuWyjesS4IX1RgoiLeTLWLGtumEjEOD8
         vMTuwLCmSt+6Wyi84l9Uhv4x+GCkGeFreKH43E1IyX4FRM8XSv2A7sYF/8cmrNdutG
         3Vi2TZ005bjgA==
Date:   Wed, 21 Dec 2022 18:30:05 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221221173005.GB37362@lothringen>
References: <20221221004957.GA29021@lothringen>
 <0B1950D8-9319-4F25-B14B-4ED949A57BE0@joelfernandes.org>
 <20221221112629.GA29427@lothringen>
 <Y6MuFH2ZMY7mV06q@Boquns-Mac-mini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6MuFH2ZMY7mV06q@Boquns-Mac-mini.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 08:02:28AM -0800, Boqun Feng wrote:
> On Wed, Dec 21, 2022 at 12:26:29PM +0100, Frederic Weisbecker wrote:
> > On Tue, Dec 20, 2022 at 09:41:17PM -0500, Joel Fernandes wrote:
> > > 
> > > 
> > > > On Dec 20, 2022, at 7:50 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > > > 
> > > > ﻿On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
> > > >> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > >> Agreed about (1).
> > > >> 
> > > >>> _ In (2), E pairs with the address-dependency between idx and lock_count.
> > > >> 
> > > >> But that is not the only reason. If that was the only reason for (2),
> > > >> then there is an smp_mb() just before the next-scan post-flip before
> > > >> the lock counts are read.
> > > > 
> > > > The post-flip barrier makes sure the new idx is visible on the next READER's
> > > > turn, but it doesn't protect against the fact that "READ idx then WRITE lock[idx]"
> > > > may appear unordered from the update side POV if there is no barrier between the
> > > > scan and the flip.
> > > > 
> > > > If you remove the smp_mb() from the litmus test I sent, things explode.
> > > 
> > > Sure I see what you are saying and it’s a valid point as well. However why do you need memory barrier D (labeled such in the kernel code) for that? You already have a memory barrier A before the lock count is read. That will suffice for the ordering pairing with the addr dependency.
> > > In other words, if updater sees readers lock counts, then reader would be making those lock count updates on post-flip inactive index, not the one being scanned as you wanted, and you will accomplish that just with the mem barrier A.
> > > 
> > > So D fixes the above issue you are talking about (lock count update), however that is already fixed by the memory barrier A. But you still need D for the issue I mentioned (unlock counts vs flip).
> > > 
> > > That’s just my opinion and let’s discuss more because I cannot rule out that I
> > > am missing something with this complicated topic ;-)
> > 
> > I must be missing something. I often do.
> > 
> > Ok let's put that on litmus:
> > 
> > ----
> > C srcu
> > 
> > {}
> > 
> > // updater
> > P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> > {
> > 	int lock1;
> > 	int unlock1;
> > 	int lock0;
> > 	int unlock0;
> > 
> > 	// SCAN1
> > 	unlock1 = READ_ONCE(*UNLOCK1);
> > 	smp_mb(); // A
> > 	lock1 = READ_ONCE(*LOCK1);
> > 	
> > 	// FLIP
> > 	smp_mb(); // E
> 
> In real code there is a control dependency between the READ_ONCE() above
> and the WRITE_ONCE() before, i.e. only flip the idx when lock1 ==
> unlock1, maybe try with the P0 below? Untested due to not having herd on
> this computer ;-)
> 
> > 	WRITE_ONCE(*IDX, 1);
> > 	smp_mb(); // D
> > 	
> > 	// SCAN2
> > 	unlock0 = READ_ONCE(*UNLOCK0);
> > 	smp_mb(); // A
> > 	lock0 = READ_ONCE(*LOCK0);
> > }
> > 
> 	P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> 	{
> 		int lock1;
> 		int unlock1;
> 		int lock0;
> 		int unlock0;
> 
> 		// SCAN1
> 		unlock1 = READ_ONCE(*UNLOCK1);
> 		smp_mb(); // A
> 		lock1 = READ_ONCE(*LOCK1);
> 		
> 		// FLIP
> 		if (unlock1 == lock1) {
> 			smp_mb(); // E
> 			WRITE_ONCE(*IDX, 1);
> 			smp_mb(); // D
> 			
> 			// SCAN2
> 			unlock0 = READ_ONCE(*UNLOCK0);
> 			smp_mb(); // A
> 			lock0 = READ_ONCE(*LOCK0);
> 		}
> 	}

That becomes the below (same effect).

C D

{}

// updater
P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
{
	int lock1;
	int unlock1;
	int lock0;
	int unlock0;

	// SCAN1
	unlock1 = READ_ONCE(*UNLOCK1);
	smp_mb(); // A
	lock1 = READ_ONCE(*LOCK1);
	
	if (unlock1 == lock1) {
		// FLIP
		smp_mb(); // E
		WRITE_ONCE(*IDX, 1);
		smp_mb(); // D
	
		// SCAN 2
		unlock0 = READ_ONCE(*UNLOCK0);
		smp_mb(); // A
		lock0 = READ_ONCE(*LOCK0);
	}
}

// reader
P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
{
	int tmp;
	int idx;

	// 1st reader
	idx = READ_ONCE(*IDX);
	if (idx == 0) {
		tmp = READ_ONCE(*LOCK0);
		WRITE_ONCE(*LOCK0, tmp + 1);
		smp_mb(); /* B and C */
		tmp = READ_ONCE(*UNLOCK0);
		WRITE_ONCE(*UNLOCK0, tmp + 1);
	} else {
		tmp = READ_ONCE(*LOCK1);
		WRITE_ONCE(*LOCK1, tmp + 1);
		smp_mb(); /* B and C */
		tmp = READ_ONCE(*UNLOCK1);
		WRITE_ONCE(*UNLOCK1, tmp + 1);
	}
	
	// second reader
	idx = READ_ONCE(*IDX);
	if (idx == 0) {
		tmp = READ_ONCE(*LOCK0);
		WRITE_ONCE(*LOCK0, tmp + 1);
		smp_mb(); /* B and C */
		tmp = READ_ONCE(*UNLOCK0);
		WRITE_ONCE(*UNLOCK0, tmp + 1);
	} else {
		tmp = READ_ONCE(*LOCK1);
		WRITE_ONCE(*LOCK1, tmp + 1);
		smp_mb(); /* B and C */
		tmp = READ_ONCE(*UNLOCK1);
		WRITE_ONCE(*UNLOCK1, tmp + 1);
	}
	
	// third reader
	idx = READ_ONCE(*IDX);
	if (idx == 0) {
		tmp = READ_ONCE(*LOCK0);
		WRITE_ONCE(*LOCK0, tmp + 1);
		smp_mb(); /* B and C */
		tmp = READ_ONCE(*UNLOCK0);
		WRITE_ONCE(*UNLOCK0, tmp + 1);
	} else {
		tmp = READ_ONCE(*LOCK1);
		WRITE_ONCE(*LOCK1, tmp + 1);
		smp_mb(); /* B and C */
		tmp = READ_ONCE(*UNLOCK1);
		WRITE_ONCE(*UNLOCK1, tmp + 1);
	}
}

exists (0:unlock0=0 /\ 1:idx=0)

