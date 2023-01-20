Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED5674FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjATI5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjATI5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:57:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F6A367C5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:57:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC76D228C7;
        Fri, 20 Jan 2023 08:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674205025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vf+9QXYLPJFKQAebMwH94HpP9CqaExp96hDaRf0LikI=;
        b=ap7yzgie765OI2Bjiskk0swmdw8q/Ou6CT5XVIRkSLlVe5E+RT0kuCHyv/2AIoIYIEnLB5
        Z9p2hGnzGzzEXqut/Md5QNH6oIk/Zt/OlGvoNT0oLI/FDz8CFTSaEpCPpQwGnvJZwLRiSx
        42nNzYO/6O3hOaN3vqGTPTTv9nCU1vY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D637913251;
        Fri, 20 Jan 2023 08:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4Z1MNGFXymOZIAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 20 Jan 2023 08:57:05 +0000
Date:   Fri, 20 Jan 2023 09:57:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <Y8pXYebD300t2uqU@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-40-surenb@google.com>
 <Y8bFdB47JT/luMld@dhcp22.suse.cz>
 <CAJuCfpHVYW5aBVmT0vwn+j=m=Jo2KhSTzgVtxSEusUZJdzetUA@mail.gmail.com>
 <Y8fApgKJaTs9nrPO@dhcp22.suse.cz>
 <CAJuCfpERMyQc96Z5Qn9RFK0UD7fNugZE4DujFs4xqFWM8T6EqA@mail.gmail.com>
 <20230118183447.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAJuCfpHZuKq45FL1gs+=rx5s2AOaZ9TPC1bdAWjYzfkrOABTOw@mail.gmail.com>
 <Y8k8/vPGXBvyHLJE@dhcp22.suse.cz>
 <20230119191707.GW2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119191707.GW2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-01-23 11:17:07, Paul E. McKenney wrote:
> On Thu, Jan 19, 2023 at 01:52:14PM +0100, Michal Hocko wrote:
> > On Wed 18-01-23 11:01:08, Suren Baghdasaryan wrote:
> > > On Wed, Jan 18, 2023 at 10:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > [...]
> > > > There are a couple of possibilities here.
> > > >
> > > > First, if I am remembering correctly, the time between the call_rcu()
> > > > and invocation of the corresponding callback was taking multiple seconds,
> > > > but that was because the kernel was built with CONFIG_LAZY_RCU=y in
> > > > order to save power by batching RCU work over multiple call_rcu()
> > > > invocations.  If this is causing a problem for a given call site, the
> > > > shiny new call_rcu_hurry() can be used instead.  Doing this gets back
> > > > to the old-school non-laziness, but can of course consume more power.
> > > 
> > > That would not be the case because CONFIG_LAZY_RCU was not an option
> > > at the time I was profiling this issue.
> > > Laxy RCU would be a great option to replace this patch but
> > > unfortunately it's not the default behavior, so I would still have to
> > > implement this batching in case lazy RCU is not enabled.
> > > 
> > > >
> > > > Second, there is a much shorter one-jiffy delay between the call_rcu()
> > > > and the invocation of the corresponding callback in kernels built with
> > > > either CONFIG_NO_HZ_FULL=y (but only on CPUs mentioned in the nohz_full
> > > > or rcu_nocbs kernel boot parameters) or CONFIG_RCU_NOCB_CPU=y (but only
> > > > on CPUs mentioned in the rcu_nocbs kernel boot parameters).  The purpose
> > > > of this delay is to avoid lock contention, and so this delay is incurred
> > > > only on CPUs that are queuing callbacks at a rate exceeding 16K/second.
> > > > This is reduced to a per-jiffy limit, so on a HZ=1000 system, a CPU
> > > > invoking call_rcu() at least 16 times within a given jiffy will incur
> > > > the added delay.  The reason for this delay is the use of a separate
> > > > ->nocb_bypass list.  As Suren says, this bypass list is used to reduce
> > > > lock contention on the main ->cblist.  This is not needed in old-school
> > > > kernels built without either CONFIG_NO_HZ_FULL=y or CONFIG_RCU_NOCB_CPU=y
> > > > (including most datacenter kernels) because in that case the callbacks
> > > > enqueued by call_rcu() are touched only by the corresponding CPU, so
> > > > that there is no need for locks.
> > > 
> > > I believe this is the reason in my profiled case.
> > > 
> > > >
> > > > Third, if you are instead seeing multiple milliseconds of CPU consumed by
> > > > call_rcu() in the common case (for example, without the aid of interrupts,
> > > > NMIs, or SMIs), please do let me know.  That sounds to me like a bug.
> > > 
> > > I don't think I've seen such a case.
> > > Thanks for clarifications, Paul!
> > 
> > Thanks for the explanation Paul. I have to say this has caught me as a
> > surprise. There are just not enough details about the benchmark to
> > understand what is going on but I find it rather surprising that
> > call_rcu can induce a higher overhead than the actual kmem_cache_free
> > which is the callback. My naive understanding has been that call_rcu is
> > really fast way to defer the execution to the RCU safe context to do the
> > final cleanup.
> 
> If I am following along correctly (ha!), then your "induce a higher
> overhead" should be something like "induce a higher to-kfree() latency".

Yes, this is expected.

> Of course, there already is a higher latency-to-kfree via call_rcu()
> than via a direct call to kfree(), and callback-offload CPUs that are
> being flooded with callbacks raise that latency a jiffy or so more in
> order to avoid lock contention.
> 
> If this becomes a problem, the callback-offloading code can be a bit
> smarter about avoiding lock contention, but need to see a real problem
> before I make that change.  But if there is a real problem I will of
> course fix it.

I believe that Suren claims that the call_rcu is really visible in the
exit_mmap case. Time-to-free actual vmas shouldn't really be material
for that path. If that happens much more later on there could be some
side effects by an increased memory consumption but that should be
marginal. How fast exit_mmap really is should only depend on direct
calls from that path.

But I guess we need some specific numbers from Suren to be sure what is
going on here.

Thanks!
-- 
Michal Hocko
SUSE Labs
