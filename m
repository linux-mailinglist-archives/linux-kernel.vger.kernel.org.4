Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66F65206A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiLTMew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiLTMet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:34:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716039582;
        Tue, 20 Dec 2022 04:34:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5D7861361;
        Tue, 20 Dec 2022 12:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A742AC433D2;
        Tue, 20 Dec 2022 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671539687;
        bh=8eug8XIIHc+WnkDu4WAtT/tZ70RrOELqcMx9toNkkIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVm+y8EYKAVS0OSRdl4ykO0kvWavbrvx3wTzHw8FzJiY8Py8AqxSc4+7YAPEusTCM
         Czhy/9FeOup13C+L8bH20o2tRuF4MA0CJIPEuGd+E+mjkIoA6/BbM0Cn7wIXb470Sq
         VNKsXFJOvughbkBLyKcogieeKULD+sxmLrYMB35L99qwAEyJ6V9goWaeTSJUgGdBJU
         +HBs826mrWw0/vSsVoo/uwjS7JxTJQB+H4mfwCRcE6WWanWpMcA1eFLSFGYzQyhLAh
         jXYnrTwzl/LvdsGZdO3u7IQ2RJz45RyvoWpIIHR7Foof7wMwZraKDnxn46u9PiFBSU
         hT7aHPb5g2C4w==
Date:   Tue, 20 Dec 2022 13:34:43 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221220123443.GA21796@lothringen>
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <CAEXW_YRjAsx0HCnmjvth+yi0COTiynPRvjyT2sf1utMw5bTgiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRjAsx0HCnmjvth+yi0COTiynPRvjyT2sf1utMw5bTgiw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 11:07:17PM -0500, Joel Fernandes wrote:
> On Sun, Dec 18, 2022 at 2:13 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > Hello, I believe the pre-flip memory barrier is not required. The only reason I
> > can say to remove it, other than the possibility that it is unnecessary, is to
> > not have extra code that does not help. However, since we are issuing a fully
> > memory-barrier after the flip, I cannot say that it hurts to do it anyway.
> >
> > For this reason, please consider these patches as "informational", than a
> > "please merge". :-) Though, feel free to consider merging if you agree!
> >
> > All SRCU scenarios pass with these, with 6 hours of testing.
> >
> > thanks,
> >
> >  - Joel
> >
> > Joel Fernandes (Google) (2):
> > srcu: Remove comment about prior read lock counts
> > srcu: Remove memory barrier "E" as it is not required
> 
> And litmus tests confirm that "E" does not really do what the comments
> say, PTAL:
> Test 1:
> C mbe
> (*
>  * Result: sometimes
>  * Does previous scan see old reader's lock count, if a new reader saw
> the new srcu_idx?
>  *)
> 
> {}
> 
> P0(int *lockcount, int *srcu_idx) // updater
> {
>         int r0;
>         r0 = READ_ONCE(*lockcount);
>         smp_mb();       // E
>         WRITE_ONCE(*srcu_idx, 1);
> }
> 
> P1(int *lockcount, int *srcu_idx) // reader
> {
>         int r0;
>         WRITE_ONCE(*lockcount, 1); // previous reader
>         smp_mb();       // B+C
>         r0 = READ_ONCE(*srcu_idx); // new reader
> }
> exists (0:r0=0 /\ 1:r0=1) (* Bad outcome. *)
> 
> Test 2:
> C mbe2
> 
> (*
>  * Result: sometimes
>  * If updater saw reader's lock count, was that reader using the old idx?
>  *)
> 
> {}
> 
> P0(int *lockcount, int *srcu_idx) // updater
> {
>         int r0;
>         r0 = READ_ONCE(*lockcount);
>         smp_mb();       // E
>         WRITE_ONCE(*srcu_idx, 1);
> }
> 
> P1(int *lockcount, int *srcu_idx) // reader
> {
>         int r0;
>         int r1;
>         r1 = READ_ONCE(*srcu_idx); // previous reader
>         WRITE_ONCE(*lockcount, 1); // previous reader
>         smp_mb();       // B+C
>         r0 = READ_ONCE(*srcu_idx); // new reader
> }
> exists (0:r0=1 /\ 1:r1=1) (* Bad outcome. *)

Actually, starring at this some more, there is some form of dependency
on the idx in order to build the address where the reader must write the
lockcount to. Litmus doesn't support arrays but assuming that
&ssp->sda->srcu_lock_count == 0 (note the & in the beginning), it
could be modelized that way (I'm eluding the unlock part to simplify):

---
C w-depend-r

{
	PLOCK=LOCK0;
}

// updater
P0(int *LOCK0, int *LOCK1, int **PLOCK)
{
	int lock1;

	lock1 = READ_ONCE(*LOCK1); // READ from inactive idx
	smp_mb();
	WRITE_ONCE(*PLOCK, LOCK1); // Flip idx
}

// reader
P1(int **PLOCK)
{
	int *plock;

	plock = READ_ONCE(*PLOCK); 	// Read active idx
	WRITE_ONCE(*plock, 1); // Write to active idx
}

exists (0:lock0=1) // never happens
---

* Is it an address dependency? But the LKMM refers to that only in
  terms of LOAD - LOAD ordering.

* Is it a control dependency? But the LKMM refers to that only in
  terms of branch with "if".

So I don't know the name of the pattern but it makes litmus happy.

Thanks.
