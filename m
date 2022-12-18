Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C89F6505AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 00:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiLRX1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 18:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiLRX1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 18:27:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03516BCB1;
        Sun, 18 Dec 2022 15:26:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88C4A60DC8;
        Sun, 18 Dec 2022 23:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61F7C433D2;
        Sun, 18 Dec 2022 23:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671405988;
        bh=GOPn15tzOWu6zqqp3vN622lksR7KtVhJjXZ4MTRHMgw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VGa2GRbTA5caepsdx6BNih1LsTbc3BQTIkw9RgFl5eeRo1zl7AyNabhUDXQygXds7
         MWdslBHJLL/D6QyJEMCYZZxehQMmkOAcG1S8qC1rDu1ZiIeD+dBIpQrwi6lRM9JNkG
         eF2le3gvHlzKX6Ah6XvsixrrqmqTjOBnQv3aZcwtkKEXfPghlErFKBYP5K12oNX/hV
         Lf6cY+JsgB+ZnpKT2Jp15J2CSmZsdTU5Y5/HWrsnM6mvRoOHmFUEKbwbiTPTWYzszd
         z6FbkD7Vx2iBOegbnPtuF/U5zoMcrqAeTw7CQDzDv6eAxQnG53R7JXovCXROkSj+Pf
         7RSTHamozAiHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 87F8F5C0EBF; Sun, 18 Dec 2022 15:26:28 -0800 (PST)
Date:   Sun, 18 Dec 2022 15:26:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221218232628.GT4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com>
 <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 04:30:33PM -0500, Joel Fernandes wrote:
> Hi Mathieu,
> 
> On Sun, Dec 18, 2022 at 3:56 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
> > > Hello, I believe the pre-flip memory barrier is not required. The only reason I
> > > can say to remove it, other than the possibility that it is unnecessary, is to
> > > not have extra code that does not help. However, since we are issuing a fully
> > > memory-barrier after the flip, I cannot say that it hurts to do it anyway.
> > >
> > > For this reason, please consider these patches as "informational", than a
> > > "please merge". :-) Though, feel free to consider merging if you agree!
> > >
> > > All SRCU scenarios pass with these, with 6 hours of testing.
> >
> > Hi Joel,
> >
> > Please have a look at the comments in my side-rcu implementation [1, 2].
> > It is similar to what SRCU does (per-cpu counter based grace period
> > tracking), but implemented for userspace. The comments explain why this
> > works without the memory barrier you identify as useless in SRCU.
> >
> > Following my implementation of side-rcu, I reviewed the SRCU comments
> > and identified that the barrier "/* E */" appears to be useless. I even
> > discussed this privately with Paul E. McKenney.
> >
> > My implementation and comments go further though, and skip the period
> > "flip" entirely if the first pass observes that all readers (in both
> > periods) are quiescent.
> 
> Actually in SRCU, the first pass scans only 1 index, then does the
> flip, and the second pass scans the second index. Without doing a
> flip, an index cannot be scanned for forward progress reasons because
> it is still "active". So I am curious how you can skip flip and still
> scan both indexes? I will dig more into your implementation to learn more.
> 
> > The most relevant comment in side-rcu is:
> >
> >   * The grace period completes when it observes that there are no active
> >   * readers within each of the periods.
> >   *
> >   * The active_readers state is initially true for each period, until the
> >   * grace period observes that no readers are present for each given
> >   * period, at which point the active_readers state becomes false.
> >
> > So I agree with the clarifications you propose here, but I think we can
> > improve the grace period implementation further by clarifying the SRCU
> > grace period model.
> 
> Thanks a lot, I am curious how you do the "detection of no new
> readers" part without globally doing some kind of synchronization. I
> will dig more into your implementation to learn more.

It is very good to see the interest in SRCU internals!

Just out of an abundance of caution, I restate the requirements from
the synchronize_srcu() header comment:

 * There are memory-ordering constraints implied by synchronize_srcu().
 * On systems with more than one CPU, when synchronize_srcu() returns,
 * each CPU is guaranteed to have executed a full memory barrier since
 * the end of its last corresponding SRCU read-side critical section
 * whose beginning preceded the call to synchronize_srcu().  In addition,
 * each CPU having an SRCU read-side critical section that extends beyond
 * the return from synchronize_srcu() is guaranteed to have executed a
 * full memory barrier after the beginning of synchronize_srcu() and before
 * the beginning of that SRCU read-side critical section.  Note that these
 * guarantees include CPUs that are offline, idle, or executing in user mode,
 * as well as CPUs that are executing in the kernel.
 *
 * Furthermore, if CPU A invoked synchronize_srcu(), which returned
 * to its caller on CPU B, then both CPU A and CPU B are guaranteed
 * to have executed a full memory barrier during the execution of
 * synchronize_srcu().  This guarantee applies even if CPU A and CPU B
 * are the same CPU, but again only if the system has more than one CPU.
 *
 * Of course, these memory-ordering guarantees apply only when
 * synchronize_srcu(), srcu_read_lock(), and srcu_read_unlock() are
 * passed the same srcu_struct structure.

And from the __call_srcu() header comment:

 * Note that all CPUs must agree that the grace period extended beyond
 * all pre-existing SRCU read-side critical section.  On systems with
 * more than one CPU, this means that when "func()" is invoked, each CPU
 * is guaranteed to have executed a full memory barrier since the end of
 * its last corresponding SRCU read-side critical section whose beginning
 * preceded the call to call_srcu().  It also means that each CPU executing
 * an SRCU read-side critical section that continues beyond the start of
 * "func()" must have executed a memory barrier after the call_srcu()
 * but before the beginning of that SRCU read-side critical section.
 * Note that these guarantees include CPUs that are offline, idle, or
 * executing in user mode, as well as CPUs that are executing in the kernel.
 *
 * Furthermore, if CPU A invoked call_srcu() and CPU B invoked the
 * resulting SRCU callback function "func()", then both CPU A and CPU
 * B are guaranteed to execute a full memory barrier during the time
 * interval between the call to call_srcu() and the invocation of "func()".
 * This guarantee applies even if CPU A and CPU B are the same CPU (but
 * again only if the system has more than one CPU).
 *
 * Of course, these guarantees apply only for invocations of call_srcu(),
 * srcu_read_lock(), and srcu_read_unlock() that are all passed the same
 * srcu_struct structure.

							Thanx, Paul
