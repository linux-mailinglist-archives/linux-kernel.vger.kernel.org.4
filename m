Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E89653784
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiLUUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiLUUUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:20:13 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F3240B7;
        Wed, 21 Dec 2022 12:20:11 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id j16so14619511qtv.4;
        Wed, 21 Dec 2022 12:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UXCFydrmK1z6Qhkn87Ucp6FLx4NmeDWK8G4stlzRl/o=;
        b=fVPGvRwOnmD67BwJvCQ6sr0wC0BdeXbI0LQAyJfC6UrXYkA0Od4RsFNyTbvCweThqI
         JspLXJcIlHkQ7gg4uzJNjKu7EISIcXCTb0a4OcfAR8O+nqtx00pqNT7FBdkLDppH9VCZ
         7xgrcCPV170cq5ynBddsJVCz9UmBluewQ4WTrGgwq2LDFGMmXJTsRmSubzLyZFY2qMow
         JF37XiHlIWqv9/HMsXb0y4KHxPDomd1X3zpbz4tJW9nzab95ZSutV+qRqYODDityECfu
         poCi7a0dmHaAHYxcd3SYSwi7s/4kAj0bs6TqCUyxR/dMMMXbvX7w7UayDtD9rVxb5BVX
         TX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXCFydrmK1z6Qhkn87Ucp6FLx4NmeDWK8G4stlzRl/o=;
        b=p7Uag2TOQwVlVOy86z/psCeDvLXn6AlRe3RR/s7qSLE4Lk0eeVek9vpfyEqfOViqej
         Ald39HF1fopHVUSmSRspb6HlwLN1F+np/RCg0KbLVzxaUMO4uVlGp5rmj7g1HrwM2SKQ
         1R4ttGo4TCmz9T0ndc6B2EByCnSQvpMkAcSuO2RkAEJjoImgG9IV7PwedBlWP+q0Dj+M
         JFh6rVH+Vm834dEy72XwYruOsf4RCACWseZZM7pWavBXhCOU1vk7FjoxJyJcA2s4Aaqz
         xRa7Ybsoi/qDJCy1mynbMDTqAzjn5qVrpCwGf7g1osXevn5/8EP2JYSiGblRNyTU+grn
         LNxQ==
X-Gm-Message-State: AFqh2komX0KFMFmmNjSs15gDYukWCJW7jM4wZZxBO28HwUxBLbwLb86l
        YkBX6hij1FrSgMuFyYEqpKI=
X-Google-Smtp-Source: AMrXdXtf81Jf9mYGUJTYOdxQs/S5Pq4SOEu1jhQvWA/UVOatu0fG77H3qq5vRjfAvtgbqn+mHRX7ZA==
X-Received: by 2002:ac8:4519:0:b0:39c:da20:609 with SMTP id q25-20020ac84519000000b0039cda200609mr9755205qtn.19.1671654010889;
        Wed, 21 Dec 2022 12:20:10 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id z26-20020ac8711a000000b003a816011d51sm9616972qto.38.2022.12.21.12.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 12:20:10 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 871A727C0054;
        Wed, 21 Dec 2022 15:20:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 21 Dec 2022 15:20:09 -0500
X-ME-Sender: <xms:eWqjY7E2r0xTB-vH9S4DSSkm-mvEY2ZzCVBOs7UPAoaBSisWeL7XuA>
    <xme:eWqjY4Vr30JTYESCX6QF3QNSjq7nvTLrUHVD2Jh3efrjUMyfyWThXG0lzfDOwlOa6
    nKkTpkAa6RI8Oe-0g>
X-ME-Received: <xmr:eWqjY9Kdtp8p0uUjDZnubO573Z2lbOlRkU_Cz8Rg-Glg9QCWAGkEYJ-_6RY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeekgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehmkeerredttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvddugffhfffhuddvvdejvdfgtdeiieeufeehveevtedthfehffeitdei
    veeijeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:eWqjY5FKB_E135mwfvocUJ12JF0M5k2Acw0jzL8EHPYV2PTXh9VzJw>
    <xmx:eWqjYxXKCOUsA0zQBFziBRxIIlvf3SBFyBZ4mTAwAom3XCsDhGSnSA>
    <xmx:eWqjY0OFj2wdnEw-x2UtFl-AJKXF7_SHngWCWSsu2YnLp9B5mfvTFg>
    <xmx:eWqjY9qecHUiCW__10sFzvGVOXlv3kWVaSQfO8XV8UZMayjwd5p7Og>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Dec 2022 15:20:08 -0500 (EST)
Date:   Wed, 21 Dec 2022 12:19:47 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <Y6NqYydTKFEwJIqN@boqun-archlinux>
References: <20221221004957.GA29021@lothringen>
 <0B1950D8-9319-4F25-B14B-4ED949A57BE0@joelfernandes.org>
 <20221221112629.GA29427@lothringen>
 <Y6MuFH2ZMY7mV06q@Boquns-Mac-mini.local>
 <20221221173005.GB37362@lothringen>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k57muiFtjZ4gPWtM"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221221173005.GB37362@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k57muiFtjZ4gPWtM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 21, 2022 at 06:30:05PM +0100, Frederic Weisbecker wrote:
> On Wed, Dec 21, 2022 at 08:02:28AM -0800, Boqun Feng wrote:
> > On Wed, Dec 21, 2022 at 12:26:29PM +0100, Frederic Weisbecker wrote:
> > > On Tue, Dec 20, 2022 at 09:41:17PM -0500, Joel Fernandes wrote:
> > > > 
> > > > 
> > > > > On Dec 20, 2022, at 7:50 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > > > > 
> > > > > ﻿On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
> > > > >> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > > >> Agreed about (1).
> > > > >> 
> > > > >>> _ In (2), E pairs with the address-dependency between idx and lock_count.
> > > > >> 
> > > > >> But that is not the only reason. If that was the only reason for (2),
> > > > >> then there is an smp_mb() just before the next-scan post-flip before
> > > > >> the lock counts are read.
> > > > > 
> > > > > The post-flip barrier makes sure the new idx is visible on the next READER's
> > > > > turn, but it doesn't protect against the fact that "READ idx then WRITE lock[idx]"
> > > > > may appear unordered from the update side POV if there is no barrier between the
> > > > > scan and the flip.
> > > > > 
> > > > > If you remove the smp_mb() from the litmus test I sent, things explode.
> > > > 
> > > > Sure I see what you are saying and it’s a valid point as well. However why do you need memory barrier D (labeled such in the kernel code) for that? You already have a memory barrier A before the lock count is read. That will suffice for the ordering pairing with the addr dependency.
> > > > In other words, if updater sees readers lock counts, then reader would be making those lock count updates on post-flip inactive index, not the one being scanned as you wanted, and you will accomplish that just with the mem barrier A.
> > > > 
> > > > So D fixes the above issue you are talking about (lock count update), however that is already fixed by the memory barrier A. But you still need D for the issue I mentioned (unlock counts vs flip).
> > > > 
> > > > That’s just my opinion and let’s discuss more because I cannot rule out that I
> > > > am missing something with this complicated topic ;-)
> > > 
> > > I must be missing something. I often do.
> > > 
> > > Ok let's put that on litmus:
> > > 
> > > ----
> > > C srcu
> > > 
> > > {}
> > > 
> > > // updater
> > > P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> > > {
> > > 	int lock1;
> > > 	int unlock1;
> > > 	int lock0;
> > > 	int unlock0;
> > > 
> > > 	// SCAN1
> > > 	unlock1 = READ_ONCE(*UNLOCK1);
> > > 	smp_mb(); // A
> > > 	lock1 = READ_ONCE(*LOCK1);
> > > 	
> > > 	// FLIP
> > > 	smp_mb(); // E
> > 
> > In real code there is a control dependency between the READ_ONCE() above
> > and the WRITE_ONCE() before, i.e. only flip the idx when lock1 ==
> > unlock1, maybe try with the P0 below? Untested due to not having herd on
> > this computer ;-)
> > 
> > > 	WRITE_ONCE(*IDX, 1);
> > > 	smp_mb(); // D
> > > 	
> > > 	// SCAN2
> > > 	unlock0 = READ_ONCE(*UNLOCK0);
> > > 	smp_mb(); // A
> > > 	lock0 = READ_ONCE(*LOCK0);
> > > }
> > > 
> > 	P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> > 	{
> > 		int lock1;
> > 		int unlock1;
> > 		int lock0;
> > 		int unlock0;
> > 
> > 		// SCAN1
> > 		unlock1 = READ_ONCE(*UNLOCK1);
> > 		smp_mb(); // A
> > 		lock1 = READ_ONCE(*LOCK1);
> > 		
> > 		// FLIP
> > 		if (unlock1 == lock1) {
> > 			smp_mb(); // E
> > 			WRITE_ONCE(*IDX, 1);
> > 			smp_mb(); // D
> > 			
> > 			// SCAN2
> > 			unlock0 = READ_ONCE(*UNLOCK0);
> > 			smp_mb(); // A
> > 			lock0 = READ_ONCE(*LOCK0);
> > 		}
> > 	}
> 
> That becomes the below (same effect).
> 

By "same effect" you mean removing E results in the exist-clause
triggered? If so, then our environments disagree with each other ;-)

I "download" your litmus test (frederic.litmus) and created an variant
(frederic-remove-E.litmus) that only removes the E, both of the litmus
tests are in the attachment.

And here is the result on my env:

for frederic.litmus:

	Test D Allowed
	States 6
	0:unlock0=0; 1:idx=1;
	0:unlock0=1; 1:idx=0;
	0:unlock0=1; 1:idx=1;
	0:unlock0=2; 1:idx=0;
	0:unlock0=2; 1:idx=1;
	0:unlock0=3; 1:idx=0;
	No
	Witnesses
	Positive: 0 Negative: 14
	Condition exists (0:unlock0=0 /\ 1:idx=0)
	Observation D Never 0 14
	Time D 54.22
	Hash=eead834f635201cde8ceb21250e33381

for frederic-remove-E.litmus:

	Test D Allowed
	States 6
	0:unlock0=0; 1:idx=1;
	0:unlock0=1; 1:idx=0;
	0:unlock0=1; 1:idx=1;
	0:unlock0=2; 1:idx=0;
	0:unlock0=2; 1:idx=1;
	0:unlock0=3; 1:idx=0;
	No
	Witnesses
	Positive: 0 Negative: 14
	Condition exists (0:unlock0=0 /\ 1:idx=0)
	Observation D Never 0 14
	Time D 53.50
	Hash=c2579f542cf9f87af125c5792999dc44

Regards,
Boqun

> C D
> 
> {}
> 
> // updater
> P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> {
> 	int lock1;
> 	int unlock1;
> 	int lock0;
> 	int unlock0;
> 
> 	// SCAN1
> 	unlock1 = READ_ONCE(*UNLOCK1);
> 	smp_mb(); // A
> 	lock1 = READ_ONCE(*LOCK1);
> 	
> 	if (unlock1 == lock1) {
> 		// FLIP
> 		smp_mb(); // E
> 		WRITE_ONCE(*IDX, 1);
> 		smp_mb(); // D
> 	
> 		// SCAN 2
> 		unlock0 = READ_ONCE(*UNLOCK0);
> 		smp_mb(); // A
> 		lock0 = READ_ONCE(*LOCK0);
> 	}
> }
> 
> // reader
> P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> {
> 	int tmp;
> 	int idx;
> 
> 	// 1st reader
> 	idx = READ_ONCE(*IDX);
> 	if (idx == 0) {
> 		tmp = READ_ONCE(*LOCK0);
> 		WRITE_ONCE(*LOCK0, tmp + 1);
> 		smp_mb(); /* B and C */
> 		tmp = READ_ONCE(*UNLOCK0);
> 		WRITE_ONCE(*UNLOCK0, tmp + 1);
> 	} else {
> 		tmp = READ_ONCE(*LOCK1);
> 		WRITE_ONCE(*LOCK1, tmp + 1);
> 		smp_mb(); /* B and C */
> 		tmp = READ_ONCE(*UNLOCK1);
> 		WRITE_ONCE(*UNLOCK1, tmp + 1);
> 	}
> 	
> 	// second reader
> 	idx = READ_ONCE(*IDX);
> 	if (idx == 0) {
> 		tmp = READ_ONCE(*LOCK0);
> 		WRITE_ONCE(*LOCK0, tmp + 1);
> 		smp_mb(); /* B and C */
> 		tmp = READ_ONCE(*UNLOCK0);
> 		WRITE_ONCE(*UNLOCK0, tmp + 1);
> 	} else {
> 		tmp = READ_ONCE(*LOCK1);
> 		WRITE_ONCE(*LOCK1, tmp + 1);
> 		smp_mb(); /* B and C */
> 		tmp = READ_ONCE(*UNLOCK1);
> 		WRITE_ONCE(*UNLOCK1, tmp + 1);
> 	}
> 	
> 	// third reader
> 	idx = READ_ONCE(*IDX);
> 	if (idx == 0) {
> 		tmp = READ_ONCE(*LOCK0);
> 		WRITE_ONCE(*LOCK0, tmp + 1);
> 		smp_mb(); /* B and C */
> 		tmp = READ_ONCE(*UNLOCK0);
> 		WRITE_ONCE(*UNLOCK0, tmp + 1);
> 	} else {
> 		tmp = READ_ONCE(*LOCK1);
> 		WRITE_ONCE(*LOCK1, tmp + 1);
> 		smp_mb(); /* B and C */
> 		tmp = READ_ONCE(*UNLOCK1);
> 		WRITE_ONCE(*UNLOCK1, tmp + 1);
> 	}
> }
> 
> exists (0:unlock0=0 /\ 1:idx=0)
> 

--k57muiFtjZ4gPWtM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="frederic.litmus"

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

--k57muiFtjZ4gPWtM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="frederic-remove-E.litmus"

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

--k57muiFtjZ4gPWtM--
