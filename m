Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5352A673901
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjASMyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjASMwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:52:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A57B15563
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:52:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 144CD5CDCC;
        Thu, 19 Jan 2023 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674132735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjnBtS+tWF2y+b/Ndk23xVEsnNoyBzklntYtG4WzfME=;
        b=uHFXZnGwRsIQkOAXvNc5r12Q8Zjx2e1IZnmxixDECtV/in4b7NwxXomeAGlDi6OtCDRXDa
        dtvKDLvhExTrXALBacIHpSO15pgEQvgikygHOliJ8ytuR2BXMAU/cs4QzXNA9SPokcCXHP
        iYzdodWW/Wcksac0HQ4vT5akJUfYwkQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD37F139ED;
        Thu, 19 Jan 2023 12:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v22dNf48yWPMbAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 19 Jan 2023 12:52:14 +0000
Date:   Thu, 19 Jan 2023 13:52:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     paulmck@kernel.org, akpm@linux-foundation.org,
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
Message-ID: <Y8k8/vPGXBvyHLJE@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-40-surenb@google.com>
 <Y8bFdB47JT/luMld@dhcp22.suse.cz>
 <CAJuCfpHVYW5aBVmT0vwn+j=m=Jo2KhSTzgVtxSEusUZJdzetUA@mail.gmail.com>
 <Y8fApgKJaTs9nrPO@dhcp22.suse.cz>
 <CAJuCfpERMyQc96Z5Qn9RFK0UD7fNugZE4DujFs4xqFWM8T6EqA@mail.gmail.com>
 <20230118183447.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAJuCfpHZuKq45FL1gs+=rx5s2AOaZ9TPC1bdAWjYzfkrOABTOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHZuKq45FL1gs+=rx5s2AOaZ9TPC1bdAWjYzfkrOABTOw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-01-23 11:01:08, Suren Baghdasaryan wrote:
> On Wed, Jan 18, 2023 at 10:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > There are a couple of possibilities here.
> >
> > First, if I am remembering correctly, the time between the call_rcu()
> > and invocation of the corresponding callback was taking multiple seconds,
> > but that was because the kernel was built with CONFIG_LAZY_RCU=y in
> > order to save power by batching RCU work over multiple call_rcu()
> > invocations.  If this is causing a problem for a given call site, the
> > shiny new call_rcu_hurry() can be used instead.  Doing this gets back
> > to the old-school non-laziness, but can of course consume more power.
> 
> That would not be the case because CONFIG_LAZY_RCU was not an option
> at the time I was profiling this issue.
> Laxy RCU would be a great option to replace this patch but
> unfortunately it's not the default behavior, so I would still have to
> implement this batching in case lazy RCU is not enabled.
> 
> >
> > Second, there is a much shorter one-jiffy delay between the call_rcu()
> > and the invocation of the corresponding callback in kernels built with
> > either CONFIG_NO_HZ_FULL=y (but only on CPUs mentioned in the nohz_full
> > or rcu_nocbs kernel boot parameters) or CONFIG_RCU_NOCB_CPU=y (but only
> > on CPUs mentioned in the rcu_nocbs kernel boot parameters).  The purpose
> > of this delay is to avoid lock contention, and so this delay is incurred
> > only on CPUs that are queuing callbacks at a rate exceeding 16K/second.
> > This is reduced to a per-jiffy limit, so on a HZ=1000 system, a CPU
> > invoking call_rcu() at least 16 times within a given jiffy will incur
> > the added delay.  The reason for this delay is the use of a separate
> > ->nocb_bypass list.  As Suren says, this bypass list is used to reduce
> > lock contention on the main ->cblist.  This is not needed in old-school
> > kernels built without either CONFIG_NO_HZ_FULL=y or CONFIG_RCU_NOCB_CPU=y
> > (including most datacenter kernels) because in that case the callbacks
> > enqueued by call_rcu() are touched only by the corresponding CPU, so
> > that there is no need for locks.
> 
> I believe this is the reason in my profiled case.
> 
> >
> > Third, if you are instead seeing multiple milliseconds of CPU consumed by
> > call_rcu() in the common case (for example, without the aid of interrupts,
> > NMIs, or SMIs), please do let me know.  That sounds to me like a bug.
> 
> I don't think I've seen such a case.
> Thanks for clarifications, Paul!

Thanks for the explanation Paul. I have to say this has caught me as a
surprise. There are just not enough details about the benchmark to
understand what is going on but I find it rather surprising that
call_rcu can induce a higher overhead than the actual kmem_cache_free
which is the callback. My naive understanding has been that call_rcu is
really fast way to defer the execution to the RCU safe context to do the
final cleanup.
-- 
Michal Hocko
SUSE Labs
