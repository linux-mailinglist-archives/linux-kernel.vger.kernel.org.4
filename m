Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B007E672711
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjARSfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjARSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:34:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701FD2B0A7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:34:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1075DB81E9A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991C3C433EF;
        Wed, 18 Jan 2023 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674066887;
        bh=WQ17/uS48eZ8vtlubVHsA2/zGXMyPtsK+cdglVuC3Rk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l7I9EeWkRjSLj1wGudDzwXdc0sESiedA3fjzJiVx+p/XRVSGBaesgKTbYGvFV/H+8
         KP8ri+KTfIfSH8KTYyWNP8/ZtnZyQunMJHF7SvF8GN1aAk/DWoxRCFlAcWvfxYu0RC
         u87DKHHyUfCqMosqAlvct/bnRBhum4/aftEN0bB6UPhSQDj1ya/NAqC3qYBtVkZEkH
         HxW0N5S1ZUwrHHpY+f1tNg0x59vWWpgMQI49JqhKMmZ4pYL2yadwCBF0jyu3XWinLI
         4B2q/swf54li/JxKiY7pxyv0AThLCSGhQi0IKcrPIzdXFPB3XcbujUUqAY25jTqCkX
         /heXQ/ilfGUlw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3CC605C0920; Wed, 18 Jan 2023 10:34:47 -0800 (PST)
Date:   Wed, 18 Jan 2023 10:34:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in
 vm_area_free
Message-ID: <20230118183447.GG2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-40-surenb@google.com>
 <Y8bFdB47JT/luMld@dhcp22.suse.cz>
 <CAJuCfpHVYW5aBVmT0vwn+j=m=Jo2KhSTzgVtxSEusUZJdzetUA@mail.gmail.com>
 <Y8fApgKJaTs9nrPO@dhcp22.suse.cz>
 <CAJuCfpERMyQc96Z5Qn9RFK0UD7fNugZE4DujFs4xqFWM8T6EqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpERMyQc96Z5Qn9RFK0UD7fNugZE4DujFs4xqFWM8T6EqA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:04:39AM -0800, Suren Baghdasaryan wrote:
> On Wed, Jan 18, 2023 at 1:49 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 17-01-23 17:19:46, Suren Baghdasaryan wrote:
> > > On Tue, Jan 17, 2023 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > > > call_rcu() can take a long time when callback offloading is enabled.
> > > > > Its use in the vm_area_free can cause regressions in the exit path when
> > > > > multiple VMAs are being freed.
> > > >
> > > > What kind of regressions.
> > > >
> > > > > To minimize that impact, place VMAs into
> > > > > a list and free them in groups using one call_rcu() call per group.
> > > >
> > > > Please add some data to justify this additional complexity.
> > >
> > > Sorry, should have done that in the first place. A 4.3% regression was
> > > noticed when running execl test from unixbench suite. spawn test also
> > > showed 1.6% regression. Profiling revealed that vma freeing was taking
> > > longer due to call_rcu() which is slow when RCU callback offloading is
> > > enabled.
> >
> > Could you be more specific? vma freeing is async with the RCU so how
> > come this has resulted in a regression? Is there any heavy
> > rcu_synchronize in the exec path? That would be an interesting
> > information.
> 
> No, there is no heavy rcu_synchronize() or any other additional
> synchronous load in the exit path. It's the call_rcu() which can block
> the caller if CONFIG_RCU_NOCB_CPU is enabled and there are lots of
> other call_rcu()'s going on in parallel. Note that call_rcu() calls
> rcu_nocb_try_bypass() if CONFIG_RCU_NOCB_CPU is enabled and profiling
> revealed that this function was taking multiple ms (don't recall the
> actual number, sorry). Paul's explanation implied that this happens
> due to contention on the locks taken in this function. For more
> in-depth details I'll have to ask Paul for help :) This code is quite
> complex and I don't know all the details of RCU implementation.

There are a couple of possibilities here.

First, if I am remembering correctly, the time between the call_rcu()
and invocation of the corresponding callback was taking multiple seconds,
but that was because the kernel was built with CONFIG_LAZY_RCU=y in
order to save power by batching RCU work over multiple call_rcu()
invocations.  If this is causing a problem for a given call site, the
shiny new call_rcu_hurry() can be used instead.  Doing this gets back
to the old-school non-laziness, but can of course consume more power.

Second, there is a much shorter one-jiffy delay between the call_rcu()
and the invocation of the corresponding callback in kernels built with
either CONFIG_NO_HZ_FULL=y (but only on CPUs mentioned in the nohz_full
or rcu_nocbs kernel boot parameters) or CONFIG_RCU_NOCB_CPU=y (but only
on CPUs mentioned in the rcu_nocbs kernel boot parameters).  The purpose
of this delay is to avoid lock contention, and so this delay is incurred
only on CPUs that are queuing callbacks at a rate exceeding 16K/second.
This is reduced to a per-jiffy limit, so on a HZ=1000 system, a CPU
invoking call_rcu() at least 16 times within a given jiffy will incur
the added delay.  The reason for this delay is the use of a separate
->nocb_bypass list.  As Suren says, this bypass list is used to reduce
lock contention on the main ->cblist.  This is not needed in old-school
kernels built without either CONFIG_NO_HZ_FULL=y or CONFIG_RCU_NOCB_CPU=y
(including most datacenter kernels) because in that case the callbacks
enqueued by call_rcu() are touched only by the corresponding CPU, so
that there is no need for locks.

Third, if you are instead seeing multiple milliseconds of CPU consumed by
call_rcu() in the common case (for example, without the aid of interrupts,
NMIs, or SMIs), please do let me know.  That sounds to me like a bug.

Or have I lost track of some other slow case?

							Thanx, Paul
