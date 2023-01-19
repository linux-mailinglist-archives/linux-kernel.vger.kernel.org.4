Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF887674293
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjASTSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjASTRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:17:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E99D29D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:17:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36FD461D54
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3F5C433F0;
        Thu, 19 Jan 2023 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674155827;
        bh=eCVbGXT27QnDo1PpAtkdYdCPSqT1Q5ve44Q8Q75yHjw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FCre4bIyUsGr3UbsqKMkAQvOnNpSp+ZWq+NbqqKwwWefnRM01gepbNKLipNzquSuy
         TS1GmlOYCg6zD4+UEVOtBJY+0ZPzqe/LmfVDG1bJ9ZhVV0p32LzzMAiWRBMPn1T1h4
         lAj0M0gK0MPei3TtqZWQkMcaTNS1rzDw3cKDdRJFes7uSpMhuW4+YiOaItA+N+gKAc
         JMMK/ovArgjTbmyUfDHcWXuHF2hwBrtaAlfxcWTYx4Ccah0CVipkCZ8Vylnq9UGQx7
         NSQGdLJX6rKSEaJIAZ+2hMcEPpSmmYmmGZ10dwS+6DGIGltSWvjltMSHYoKUe32kIM
         fDrsAF3VjIYdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0FE685C1A49; Thu, 19 Jan 2023 11:17:07 -0800 (PST)
Date:   Thu, 19 Jan 2023 11:17:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
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
Message-ID: <20230119191707.GW2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-40-surenb@google.com>
 <Y8bFdB47JT/luMld@dhcp22.suse.cz>
 <CAJuCfpHVYW5aBVmT0vwn+j=m=Jo2KhSTzgVtxSEusUZJdzetUA@mail.gmail.com>
 <Y8fApgKJaTs9nrPO@dhcp22.suse.cz>
 <CAJuCfpERMyQc96Z5Qn9RFK0UD7fNugZE4DujFs4xqFWM8T6EqA@mail.gmail.com>
 <20230118183447.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAJuCfpHZuKq45FL1gs+=rx5s2AOaZ9TPC1bdAWjYzfkrOABTOw@mail.gmail.com>
 <Y8k8/vPGXBvyHLJE@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8k8/vPGXBvyHLJE@dhcp22.suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:52:14PM +0100, Michal Hocko wrote:
> On Wed 18-01-23 11:01:08, Suren Baghdasaryan wrote:
> > On Wed, Jan 18, 2023 at 10:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > There are a couple of possibilities here.
> > >
> > > First, if I am remembering correctly, the time between the call_rcu()
> > > and invocation of the corresponding callback was taking multiple seconds,
> > > but that was because the kernel was built with CONFIG_LAZY_RCU=y in
> > > order to save power by batching RCU work over multiple call_rcu()
> > > invocations.  If this is causing a problem for a given call site, the
> > > shiny new call_rcu_hurry() can be used instead.  Doing this gets back
> > > to the old-school non-laziness, but can of course consume more power.
> > 
> > That would not be the case because CONFIG_LAZY_RCU was not an option
> > at the time I was profiling this issue.
> > Laxy RCU would be a great option to replace this patch but
> > unfortunately it's not the default behavior, so I would still have to
> > implement this batching in case lazy RCU is not enabled.
> > 
> > >
> > > Second, there is a much shorter one-jiffy delay between the call_rcu()
> > > and the invocation of the corresponding callback in kernels built with
> > > either CONFIG_NO_HZ_FULL=y (but only on CPUs mentioned in the nohz_full
> > > or rcu_nocbs kernel boot parameters) or CONFIG_RCU_NOCB_CPU=y (but only
> > > on CPUs mentioned in the rcu_nocbs kernel boot parameters).  The purpose
> > > of this delay is to avoid lock contention, and so this delay is incurred
> > > only on CPUs that are queuing callbacks at a rate exceeding 16K/second.
> > > This is reduced to a per-jiffy limit, so on a HZ=1000 system, a CPU
> > > invoking call_rcu() at least 16 times within a given jiffy will incur
> > > the added delay.  The reason for this delay is the use of a separate
> > > ->nocb_bypass list.  As Suren says, this bypass list is used to reduce
> > > lock contention on the main ->cblist.  This is not needed in old-school
> > > kernels built without either CONFIG_NO_HZ_FULL=y or CONFIG_RCU_NOCB_CPU=y
> > > (including most datacenter kernels) because in that case the callbacks
> > > enqueued by call_rcu() are touched only by the corresponding CPU, so
> > > that there is no need for locks.
> > 
> > I believe this is the reason in my profiled case.
> > 
> > >
> > > Third, if you are instead seeing multiple milliseconds of CPU consumed by
> > > call_rcu() in the common case (for example, without the aid of interrupts,
> > > NMIs, or SMIs), please do let me know.  That sounds to me like a bug.
> > 
> > I don't think I've seen such a case.
> > Thanks for clarifications, Paul!
> 
> Thanks for the explanation Paul. I have to say this has caught me as a
> surprise. There are just not enough details about the benchmark to
> understand what is going on but I find it rather surprising that
> call_rcu can induce a higher overhead than the actual kmem_cache_free
> which is the callback. My naive understanding has been that call_rcu is
> really fast way to defer the execution to the RCU safe context to do the
> final cleanup.

If I am following along correctly (ha!), then your "induce a higher
overhead" should be something like "induce a higher to-kfree() latency".

Of course, there already is a higher latency-to-kfree via call_rcu()
than via a direct call to kfree(), and callback-offload CPUs that are
being flooded with callbacks raise that latency a jiffy or so more in
order to avoid lock contention.

If this becomes a problem, the callback-offloading code can be a bit
smarter about avoiding lock contention, but need to see a real problem
before I make that change.  But if there is a real problem I will of
course fix it.

Or did I miss a turn in this discussion?

							Thanx, Paul
