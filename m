Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2296F6533BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiLUQCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLUQCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:02:35 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF3B4B0;
        Wed, 21 Dec 2022 08:02:34 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3b48b139b46so216772477b3.12;
        Wed, 21 Dec 2022 08:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v/dIy32+bdBLKf6bYmj0NQoaoS07b6I7Gj7D7Gwvwhc=;
        b=c6XVE6A8KzSMPeO7XY4RHwcJly+GCDwbpJmvgd4IIo2xDUXqt+8mr9GSm4dIf11+C9
         NAqmbqSpgUN3NBHZt779WgIBkn710Y1jP+/kfBodx6vbJ7fDCiFnngH4NgZcg5gysCoR
         /QR07YNbaaJicPLX7L1ExOB9eN5ju5VsgzEBPSJvNjI1NdEVpQ8uAas3b1rYRNgQUq/H
         ZIddBEYxZJMgP5r5Oo5zBJXIfuY+pYDEfIWb5tnSI3Y5F+JGTOAw1qu/VOAg5refmknd
         HAOeSyIbw62Smiwm9fFZIzpLRYnrW1b3oEm0O8TEF4+MtomcwpRZn3U2aBS5vx3XPmXB
         WK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/dIy32+bdBLKf6bYmj0NQoaoS07b6I7Gj7D7Gwvwhc=;
        b=drML6r8Quj/HUNJ+UYdSF8qWTZhyG3g33EoI0QrQy8tKgsxUGliWnIo8CkfrjhISlo
         AM3MXh9q1yjDav2yK3rGM61MH9dKOHwmJGc2VaaJnpYKDKguapgrAKaWqphNEQpoSy28
         YLiVmQVKMvfGC0iZTJpIz/QIR7vGBpARYKR16BW+UeSYKr05TD8LrS9L2QWWZJlhhJjE
         D2B0Bm6D7aR5RAkCTElNxdyxCAv1CXOGzUVH2kGoZsG7xnfMDJ6J+ivy6vaPZfoRN19d
         wtw4qsD8DFXSiT5A24zngcKy7gIq1L7UQN5FHcxG3r8saBAJ+0ON14h1gktd7faYt1JJ
         0PIw==
X-Gm-Message-State: AFqh2kpLVJs2zVAxb3JKf3I8CkyG2Mr9e8ixNGigtc72PLboaCbll6v2
        yPOBsFcOtyIH9+NlPxkBNHs=
X-Google-Smtp-Source: AMrXdXto/kMVLWr4vZ7kB13HDsLShKqEcDA1nkiPuuGeGBMOPkOUqhb0qXVGFUOhNGFK6B3x42xL1w==
X-Received: by 2002:a05:7500:5721:b0:ea:f07d:857e with SMTP id by33-20020a057500572100b000eaf07d857emr170903gab.54.1671638553186;
        Wed, 21 Dec 2022 08:02:33 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id az39-20020a05620a172700b006fbbdc6c68fsm10976740qkb.68.2022.12.21.08.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 08:02:32 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3928127C0054;
        Wed, 21 Dec 2022 11:02:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 21 Dec 2022 11:02:32 -0500
X-ME-Sender: <xms:Fi6jY20cyt98arwcrf9gue6NwLFDr2CStMd8a8NDVLZ1J4C_gaPEbg>
    <xme:Fi6jY5EkCuEGh58FM-60VEgO5I0ZpQTqICy67A0wqh5V4B_bkhi9CAMi0U9ug1qQN
    zeswUE956H67rssyg>
X-ME-Received: <xmr:Fi6jY-4vOFnvgmVibyateQ6RO3JbFccJ0x3I0ecMvtAl4s6looZ3B8JUv8UHP9g9oHn9Qyu3AvCJJW30IOv47Y5uZmpif7jTNjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeekgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffg
    geelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Fi6jY32oR1A2y807QkuXfU-TdBL0IHAry0q61_SboK-cUYa75lN3iQ>
    <xmx:Fi6jY5HPYoWyzNuAr2dS-s6O60WVqzQJYFtEkFXeyNSCPmV4TdDXpw>
    <xmx:Fi6jYw9DISq7xXWEi643FQ2D1XJzVwHw90QXqtFFy9K--GIyhtzI9g>
    <xmx:Fy6jY_bvKkf-5zy3XFrG9erUk0tBDlDysj7ukwr7p67JTNBBhH2DYQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Dec 2022 11:02:30 -0500 (EST)
Date:   Wed, 21 Dec 2022 08:02:28 -0800
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
Message-ID: <Y6MuFH2ZMY7mV06q@Boquns-Mac-mini.local>
References: <20221221004957.GA29021@lothringen>
 <0B1950D8-9319-4F25-B14B-4ED949A57BE0@joelfernandes.org>
 <20221221112629.GA29427@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221221112629.GA29427@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 12:26:29PM +0100, Frederic Weisbecker wrote:
> On Tue, Dec 20, 2022 at 09:41:17PM -0500, Joel Fernandes wrote:
> > 
> > 
> > > On Dec 20, 2022, at 7:50 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > > 
> > > ﻿On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
> > >> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > >> Agreed about (1).
> > >> 
> > >>> _ In (2), E pairs with the address-dependency between idx and lock_count.
> > >> 
> > >> But that is not the only reason. If that was the only reason for (2),
> > >> then there is an smp_mb() just before the next-scan post-flip before
> > >> the lock counts are read.
> > > 
> > > The post-flip barrier makes sure the new idx is visible on the next READER's
> > > turn, but it doesn't protect against the fact that "READ idx then WRITE lock[idx]"
> > > may appear unordered from the update side POV if there is no barrier between the
> > > scan and the flip.
> > > 
> > > If you remove the smp_mb() from the litmus test I sent, things explode.
> > 
> > Sure I see what you are saying and it’s a valid point as well. However why do you need memory barrier D (labeled such in the kernel code) for that? You already have a memory barrier A before the lock count is read. That will suffice for the ordering pairing with the addr dependency.
> > In other words, if updater sees readers lock counts, then reader would be making those lock count updates on post-flip inactive index, not the one being scanned as you wanted, and you will accomplish that just with the mem barrier A.
> > 
> > So D fixes the above issue you are talking about (lock count update), however that is already fixed by the memory barrier A. But you still need D for the issue I mentioned (unlock counts vs flip).
> > 
> > That’s just my opinion and let’s discuss more because I cannot rule out that I
> > am missing something with this complicated topic ;-)
> 
> I must be missing something. I often do.
> 
> Ok let's put that on litmus:
> 
> ----
> C srcu
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
> 	// FLIP
> 	smp_mb(); // E

In real code there is a control dependency between the READ_ONCE() above
and the WRITE_ONCE() before, i.e. only flip the idx when lock1 ==
unlock1, maybe try with the P0 below? Untested due to not having herd on
this computer ;-)

> 	WRITE_ONCE(*IDX, 1);
> 	smp_mb(); // D
> 	
> 	// SCAN2
> 	unlock0 = READ_ONCE(*UNLOCK0);
> 	smp_mb(); // A
> 	lock0 = READ_ONCE(*LOCK0);
> }
> 
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
		if (unlock1 == lock1) {
			smp_mb(); // E
			WRITE_ONCE(*IDX, 1);
			smp_mb(); // D
			
			// SCAN2
			unlock0 = READ_ONCE(*UNLOCK0);
			smp_mb(); // A
			lock0 = READ_ONCE(*LOCK0);
		}
	}

Regards,
Boqun

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
> }
> 
> exists (0:lock1!=0)
> ---
> 
> This gives:
> 
> Test srcu Allowed
> States 1
> 0:lock1=0;
> No
> Witnesses
> Positive: 0 Negative: 9
> Condition exists (not (0:lock1=0))
> Observation srcu Never 0 9
> Time srcu 0.57
> Hash=855d17de503814d2421602174f307c59
> 
> Now if I comment out the "smp_mb() /* E */" line this gives:
> 
> Test srcu Allowed
> States 3
> 0:lock1=0;
> 0:lock1=1;
> 0:lock1=2;
> Ok
> Witnesses
> Positive: 4 Negative: 9
> Condition exists (not (0:lock1=0))
> Observation srcu Sometimes 4 9
> 
> Thanks
