Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6A64EA09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLPLO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPLOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:14:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FB4FAE4;
        Fri, 16 Dec 2022 03:14:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B866B62064;
        Fri, 16 Dec 2022 11:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C57C433D2;
        Fri, 16 Dec 2022 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671189259;
        bh=F6mkBD3k8By0N8IqHeptAGTd0S0qSxTQIRpDfm7tUwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFoxH/aX7aRHjx01I4fPpwlE6eU4b881eTVzLdGxVQDdwQLm07O59evOP14+CVd6M
         uOpq7FdmUoXbPfrlf9EDYYEVq159dyemBKE2YEsoQgWAVgAG7QiYKNZKbdgWLZsry8
         YVW/bIcVLgahs1CqRZPGbxVJflIDPCrcS1oj7QqICdTjTQa0GrzweBGp4CacWoE33n
         d1ZwmCe8eudse9k7ZJkrp0GjDSqL+F+AnTUj3ryZ7PNxU5blJ+gzbAIMBsbuvxDT95
         8EPBXwZo1VACo2FsHOluulF1Wu1AxUB4SFSO37/FrqRXjxN0Zd6s7BpDtGD8CF3WeO
         mt/Gs+Ovd+ajw==
Date:   Fri, 16 Dec 2022 11:14:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rtmutex: Add acquire semantics for rtmutex lock
 acquisition
Message-ID: <20221216111412.GA8666@willie-the-truck>
References: <20221202100223.6mevpbl7i6x5udfd@techsingularity.net>
 <Y4nfopZfBxR4lJ6G@linutronix.de>
 <20221202150158.xzgovoy7wuic6vvk@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202150158.xzgovoy7wuic6vvk@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 03:01:58PM +0000, Mel Gorman wrote:
> On Fri, Dec 02, 2022 at 12:21:06PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2022-12-02 10:02:23 [+0000], Mel Gorman wrote:
> > > The lock owner is updated with an IRQ-safe raw spinlock held but the
> > > spin_unlock does not provide acquire semantics which are needed when
> > > acquiring a mutex. This patch adds the necessary acquire semantics for a
> > > lock operation when the lock owner is updated. It successfully completed
> > > 10 iterations of the dbench workload while the vanilla kernel fails on
> > > the first iteration.
> > 
> > I *think* it is
> > 
> > Fixes: 700318d1d7b38 ("locking/rtmutex: Use acquire/release semantics")
> > 
> 
> Adding Davidlohr to cc.
> 
> It might have made the problem worse but even then rt_mutex_set_owner was
> just a plain assignment and while I didn't check carefully, at a glance
> try_to_take_rt_mutex didn't look like it guaranteed ACQUIRE semantics.
> 
> > Before that, it did cmpxchg() which should be fine.
> > 
> > Regarding mark_rt_mutex_waiters(). Isn't acquire semantic required in
> > order for the lock-owner not perform the fastpath but go to the slowpath
> > instead?
> > 
> 
> Good spot, it does. While the most straight-forward solution is to use
> cmpxchg_acquire, I think it is overkill because it could incur back-to-back
> ACQUIRE operations in the event of contention. There could be a smp_wmb
> after the cmpxchg_relaxed but that impacts all arches and a non-paired
> smp_wmb is generally frowned upon.
> 
> I'm thinking this on top of the patch should be sufficient even though
> it's a heavier operation than is necesary for ACQUIRE as well as being
> "not typical" according to Documentation/atomic_t.txt. Will, as this
> affects ARM primarily do you have any preference?
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 35212f260148..af0dbe4d5e97 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -238,6 +238,13 @@ static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
>  		owner = *p;
>  	} while (cmpxchg_relaxed(p, owner,
>  				 owner | RT_MUTEX_HAS_WAITERS) != owner);
> +
> +	/*
> +	 * The cmpxchg loop above is relaxed to avoid back-to-back ACQUIRE
> +	 * operations in the event of contention. Ensure the successful
> +	 * cmpxchg is visible.
> +	 */
> +	smp_mb__after_atomic();

Could we use smp_acquire__after_ctrl_dep() instead?

Will
