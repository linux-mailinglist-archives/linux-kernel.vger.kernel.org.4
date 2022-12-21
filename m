Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6688C653037
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiLUL0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUL0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:26:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A16BD2;
        Wed, 21 Dec 2022 03:26:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F20B3CE17E4;
        Wed, 21 Dec 2022 11:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D471C433EF;
        Wed, 21 Dec 2022 11:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671621993;
        bh=FscquwddOQ3u/Rw3lrYIViWRPTejLSfAr8RPD2BHxOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Whc4GmBdZ2D5cs54/dzhDQ6e3Ngp8GpHdo3dsOloWxSwQMGDnqN93KcRkTFXiw6D2
         FMY9ThczlTQ5kj3Lq5l1lhTp6mG+VAzY28DFM2nf7u/HY2BG/KNShlnZ/2tjb8941k
         AFgwVXcyCkbTHZTya55K6TZX7OHzI5+TCmE3fr8NyZNqMm+hI0D2ymNbybYVVAc872
         lGXPXqu1/2fIW65djhjWvTY6wLRQYMp3OKHFxQhmidzDhhza4jD7IABgCf6KJ8sU2H
         cA3//vtkLWvHE7DVny9cIoVEORAIkzeAv0+VSZD0z6unvNZW/olpIIt9GdRhxeGg+V
         EB0NoBKhCwdMQ==
Date:   Wed, 21 Dec 2022 12:26:29 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221221112629.GA29427@lothringen>
References: <20221221004957.GA29021@lothringen>
 <0B1950D8-9319-4F25-B14B-4ED949A57BE0@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0B1950D8-9319-4F25-B14B-4ED949A57BE0@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 09:41:17PM -0500, Joel Fernandes wrote:
> 
> 
> > On Dec 20, 2022, at 7:50 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > 
> > ﻿On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
> >> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >> Agreed about (1).
> >> 
> >>> _ In (2), E pairs with the address-dependency between idx and lock_count.
> >> 
> >> But that is not the only reason. If that was the only reason for (2),
> >> then there is an smp_mb() just before the next-scan post-flip before
> >> the lock counts are read.
> > 
> > The post-flip barrier makes sure the new idx is visible on the next READER's
> > turn, but it doesn't protect against the fact that "READ idx then WRITE lock[idx]"
> > may appear unordered from the update side POV if there is no barrier between the
> > scan and the flip.
> > 
> > If you remove the smp_mb() from the litmus test I sent, things explode.
> 
> Sure I see what you are saying and it’s a valid point as well. However why do you need memory barrier D (labeled such in the kernel code) for that? You already have a memory barrier A before the lock count is read. That will suffice for the ordering pairing with the addr dependency.
> In other words, if updater sees readers lock counts, then reader would be making those lock count updates on post-flip inactive index, not the one being scanned as you wanted, and you will accomplish that just with the mem barrier A.
> 
> So D fixes the above issue you are talking about (lock count update), however that is already fixed by the memory barrier A. But you still need D for the issue I mentioned (unlock counts vs flip).
> 
> That’s just my opinion and let’s discuss more because I cannot rule out that I
> am missing something with this complicated topic ;-)

I must be missing something. I often do.

Ok let's put that on litmus:

----
C srcu

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
	
	// FLIP
	smp_mb(); // E
	WRITE_ONCE(*IDX, 1);
	smp_mb(); // D
	
	// SCAN2
	unlock0 = READ_ONCE(*UNLOCK0);
	smp_mb(); // A
	lock0 = READ_ONCE(*LOCK0);
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
}

exists (0:lock1!=0)
---

This gives:

Test srcu Allowed
States 1
0:lock1=0;
No
Witnesses
Positive: 0 Negative: 9
Condition exists (not (0:lock1=0))
Observation srcu Never 0 9
Time srcu 0.57
Hash=855d17de503814d2421602174f307c59

Now if I comment out the "smp_mb() /* E */" line this gives:

Test srcu Allowed
States 3
0:lock1=0;
0:lock1=1;
0:lock1=2;
Ok
Witnesses
Positive: 4 Negative: 9
Condition exists (not (0:lock1=0))
Observation srcu Sometimes 4 9

Thanks
