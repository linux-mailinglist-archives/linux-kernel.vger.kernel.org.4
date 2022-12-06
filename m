Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129BB644253
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiLFLoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiLFLn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:43:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83B31A059;
        Tue,  6 Dec 2022 03:43:55 -0800 (PST)
Date:   Tue, 6 Dec 2022 12:43:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670327033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dP3T+S+aLmRfAy6FLnk9bCE+dI1DE5HTxIK16+BuHp0=;
        b=KO6aodTSgzOwrYYtTO48XmeW2iNKdfmTYbr1ZTrG2imhbkW8yPwvMjA21vskt6kPpF3M4b
        WUzAbcQDU5IET7jdvNvcSGdV7D2X0Yoa589vcm7OUOsX/avotCPcdALxbaW9FVUrYAi0Z9
        6ADDkNMuvfFzAK1YJ5Au7neac2AZJhIMw86y51QtZhzyV9scd3UJO3E+cn7QaHzQKd+iTf
        FX6nK61LWXVMCUsb/LrqjluyIgW3HteMCVS1lqxTuUHDQ7GTS/gfQxIX2aiaKEoHN+fjET
        TjOCpE7TMTDNNQMGS5Ir4qNCFv8KcWN10J48Dr9paPON7uWivsMMoxUUH6bwVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670327033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dP3T+S+aLmRfAy6FLnk9bCE+dI1DE5HTxIK16+BuHp0=;
        b=NuBk0oK6E6MphaE5QCnN+ImHu3blbgMg/uf4RsDV8/pkJRWFRPfNgS2UAbAW14XMIl+vAG
        PTMeY1t/2E+p6SAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
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
Message-ID: <Y48q9/G2B6aMdJ1w@linutronix.de>
References: <20221202100223.6mevpbl7i6x5udfd@techsingularity.net>
 <Y4nfopZfBxR4lJ6G@linutronix.de>
 <20221202150158.xzgovoy7wuic6vvk@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221202150158.xzgovoy7wuic6vvk@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-02 15:01:58 [+0000], Mel Gorman wrote:
> > Fixes: 700318d1d7b38 ("locking/rtmutex: Use acquire/release semantics")
> > 
> 
> Adding Davidlohr to cc.
> 
> It might have made the problem worse but even then rt_mutex_set_owner was
> just a plain assignment and while I didn't check carefully, at a glance
> try_to_take_rt_mutex didn't look like it guaranteed ACQUIRE semantics.

It looks like it had a strong cmpxchg which was relaxed. But I might be
wrong ;) Either way we need stable tag so that this gets back ported.
The commit in question is since v4.4 and stable trees are maintained
down to 4.9 (but only until JAN so we should hurry ;)).

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

but in general, it should succeed on the first iteration. It can only
fail (and retry) if the owner was able to unlock it first. A second
locker will spin on the wait_lock so.

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
>  }

Sebastian
