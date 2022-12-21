Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CE0653224
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiLUOEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLUOEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:04:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089571DDD0;
        Wed, 21 Dec 2022 06:04:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 992D6617DC;
        Wed, 21 Dec 2022 14:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEA5C433AE;
        Wed, 21 Dec 2022 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671631477;
        bh=Q1G1sqvj22YhvFr/1HYPNKfUw78C605vlGHEKeLomQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bf9rOXddhZ+jcISwxYkckrnWKn1Oy/8VK9Hc4lmqKehXYGuzJWgKCs0iwEN8vrYay
         Q/wVscvyk9zdGiu99Ka1dzqLJXcCOBaWw3SZXxwgOTga6nIeRqp1JlBflu7YwRzYut
         jgfPq2xX8cuR11zopbaJGofS5wkmcBQcyubsO7UvOEs6ispxY1d7zq8rPHQ3i9crwp
         5mx70E8JSrlUcLjfKhYew+wiMl/YwrYwyTrb15c5pfxnoQrA9tcBExuj/ipkbGvNdC
         BykxSImYbI0xCbZPY4nx3b2Jh+iJIXfTvV/n3OJfsaOlqvqlWgfY2N6l5GKwJw5Lse
         xheZdEE6UStsg==
Date:   Wed, 21 Dec 2022 15:04:34 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221221140434.GA35332@lothringen>
References: <f4199d1f-306c-681f-8bb9-26d66ecf5121@efficios.com>
 <6BD506EA-77D2-4AC9-87A5-C8781594CF0F@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6BD506EA-77D2-4AC9-87A5-C8781594CF0F@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 11:26:12PM -0500, Joel Fernandes wrote:
> 
> 
> > On Dec 20, 2022, at 10:43 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > ﻿On 2022-12-20 19:58, Frederic Weisbecker wrote:
> >>> On Wed, Dec 21, 2022 at 01:49:57AM +0100, Frederic Weisbecker wrote:
> >>> On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
> >>>> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >>>> Agreed about (1).
> >>>> 
> >>>>> _ In (2), E pairs with the address-dependency between idx and lock_count.
> >>>> 
> >>>> But that is not the only reason. If that was the only reason for (2),
> >>>> then there is an smp_mb() just before the next-scan post-flip before
> >>>> the lock counts are read.
> >>> 
> >>> The post-flip barrier makes sure the new idx is visible on the next READER's
> >>> turn, but it doesn't protect against the fact that "READ idx then WRITE lock[idx]"
> >>> may appear unordered from the update side POV if there is no barrier between the
> >>> scan and the flip.
> >>> 
> >>> If you remove the smp_mb() from the litmus test I sent, things explode.
> >> Or rather, look at it the other way, if there is no barrier between the lock
> >> scan and the index flip (E), then the index flip can appear to be written before the
> >> lock is read. Which means you may start activating the index before you finish
> >> reading it (at least it appears that way from the readers pont of view).
> > 
> > Considering that you can have pre-existing readers from arbitrary index appearing anywhere in the grace period (because a reader can fetch the
> > index and be preempted for an arbitrary amount of time before incrementing the lock count), the grace period algorithm needs to deal with the fact that a newcoming reader can appear in a given index either before or after the flip.
> > 
> > I don't see how flipping the index before or after loading the unlock/lock values would break anything (except for unlikely counter overflow situations as previously discussed).
> 
> If you say unlikely, that means it can happen some times which is bad enough ;-). Maybe you mean impossible. I would not settle for anything less than keeping the memory barrier around if it helps unlikely cases, but only D does help for the theoretical wrapping/overflow issue. E is broken and does not even help the theoretical issue IMO. And both D and E do not affect correctness IMO.

And here is why D is needed:

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
	
	// FLIP
	smp_mb(); // E
	WRITE_ONCE(*IDX, 1);
	smp_mb(); // D
	
	// SCAN 2
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


But then if you comment out "smp_mb() /* D */":

Test D Allowed
States 7
0:unlock0=0; 1:idx=0;
0:unlock0=0; 1:idx=1;
0:unlock0=1; 1:idx=0;
0:unlock0=1; 1:idx=1;
0:unlock0=2; 1:idx=0;
0:unlock0=2; 1:idx=1;
0:unlock0=3; 1:idx=0;
Ok
Witnesses
Positive: 2 Negative: 14
Condition exists (0:unlock0=0 /\ 1:idx=0)
Observation D Sometimes 2 14


Without D I guess things would eventually fix up but that would require an
extra loop in SCAN2.

Thanks.
