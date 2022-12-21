Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651EE653085
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiLUL7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLUL73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:59:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0831EEC2;
        Wed, 21 Dec 2022 03:59:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 170866177C;
        Wed, 21 Dec 2022 11:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8FAC433D2;
        Wed, 21 Dec 2022 11:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671623967;
        bh=RhUtI+yfvlUrG20LX+fSJIl/g8QjDb7Vy3ku58UrgAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPC6FOHm0AWuiwsRBaLYSWvGzuj1QG2/0cO92VBXGZZ3ZdynaOgONE28rigpEQigf
         1tB/8X6p5lKP7Ob5fQO0QEfm8bCGhbxtVXQHaxX/oMS4JOMO0DjbQlVI6L3FQ7y0R3
         /NuBw6/Gft5/5h4ykkku4KZ61mdYn/OJ3WYVKBpBOYKi1zJJCcRktSkPZT9ekRZUaI
         kaxdyNiIWGGmO10s8g69GjWawqOukwgA1jL7pHRe9NvZr+s025q0WxsUIwRKqtcseQ
         vAR5kcWvdwebWWyO3k+5kgWrOEthhaF9b98FVb8av2JDaAPJHZx1eAw06yOYaVeZPH
         BJzFeX/nIngIg==
Date:   Wed, 21 Dec 2022 12:59:24 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221221115924.GA34934@lothringen>
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
 <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
 <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
 <20221220225756.GB26563@lothringen>
 <c085be21-b45f-4186-6f41-5082771c79ca@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c085be21-b45f-4186-6f41-5082771c79ca@efficios.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoyers wrote:
> On 2022-12-20 17:57, Frederic Weisbecker wrote:
> > On Tue, Dec 20, 2022 at 02:01:30PM -0500, Mathieu Desnoyers wrote:
> > > On 2022-12-20 13:29, Joel Fernandes wrote:
> > > > 
> > > 
> > > > I do want to finish my memory barrier studies of SRCU over the holidays since I have been deep in the hole with that already. Back to the post flip memory barrier here since I think now even that might not be needed…
> > > 
> > > I strongly suspect the memory barrier after flip is useless for the same
> > > reasons I mentioned explaining why the barrier before the flip is useless.
> > > 
> > > However, we need to double-check that we have memory barriers at the
> > > beginning and end of synchronize_srcu, and between load of "unlock" counters
> > > and load of "lock" counters.
> > > 
> > > Where is the barrier at the beginning of synchronize_srcu ?
> > 
> > rcu_seq_snap() ?
> 
> The memory barrier in rcu_seq_snap is not at the very beginning of synchronize_srcu.
> 
> For example we have:
> 
> unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
> {
>         // Any prior manipulation of SRCU-protected data must happen
>         // before the load from ->srcu_gp_seq.
>         smp_mb();
>         return rcu_seq_snap(&ssp->srcu_gp_seq);
> 
> which happens to have an explicit barrier before issuing rcu_seq_snap().

SRCU (or even RCU) polling is special in that it may rely on a concurrent updater
to start the grace period, hence why you need two more barriers here (the second
is in poll_state_synchronize_srcu()) so that:

* If the polling updater started polling (calling get_state_synchronize_srcu())
  before the traditional updater started the grace period, the latter must
  propagate the changes from the polling updater to all CPUs.

* If the polling updater started polling (calling get_state_synchronize_srcu())
  after the traditional updater started the grace period, it must wait for a
  subsequent grace period (rcu_seq_snap() will return that subsequent sequence).

* If the polling updater checks (and thereby finishes) polling (calling poll_state_synchronize_srcu())
  after the traditional updater completes the grace period, the polling updater sees
  the propagated barrier.

* If the polling updater checks polling (calling poll_state_synchronize_srcu())
  before the traditional updater completes the grace period, keep polling.

> So my question still stands: where is the memory barrier at the beginning of
> synchronize_srcu ?

I still think rcu_seq_snap() is what you're looking for.

> 
> The memory ordering constraint I am concerned about here is:
> 
>  * [...] In addition,
>  * each CPU having an SRCU read-side critical section that extends beyond
>  * the return from synchronize_srcu() is guaranteed to have executed a
>  * full memory barrier after the beginning of synchronize_srcu() and before
>  * the beginning of that SRCU read-side critical section. [...]
> 
> So if we have a SRCU read-side critical section that begins after the beginning
> of synchronize_srcu, but before its first memory barrier, it would miss the
> guarantee that the full memory barrier is issued before the beginning of that
> SRCU read-side critical section. IOW, that memory barrier needs to be at the
> very beginning of the grace period.

I'm confused, what's wrong with this ?

UPDATER                  READER
-------                  ------
STORE X = 1              STORE srcu_read_lock++
// rcu_seq_snap()        smp_mb()
smp_mb()                 READ X
// scans
READ srcu_read_lock
