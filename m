Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB6A622F2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiKIPk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKIPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:40:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9A8B76
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:40:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6840922A51;
        Wed,  9 Nov 2022 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668008424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IS9CwGmoJ6awqUc5oUOQTSbVQOn/Z7RFfCo8xjB3Z4M=;
        b=qafBLHC6z4w+DuXGKb9QWHkLC3sV8c2CFzlOEQpG5L0KY8J7puWE8tTfRW7URfuneWh4/E
        z+W1FWVio2H24BkZM1REdJFLh4aLZ/rly14Fq9pkcC3pEv0qZ29Ax3uKurdD9ef+Io6YAq
        VTAMTjOaFXMpVDsPjVdCV2iDgCDY8l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668008424;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IS9CwGmoJ6awqUc5oUOQTSbVQOn/Z7RFfCo8xjB3Z4M=;
        b=feP57GQes9uj1rmnKoU3STzp1mIv9nE17OImsoDr9WXIz+BidtJPxz3EdUY/WEwuPKEt+X
        nCavZ9dFpxjdK2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A7591331F;
        Wed,  9 Nov 2022 15:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P2QXFujJa2OeVAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Nov 2022 15:40:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DFC57A0704; Wed,  9 Nov 2022 16:40:23 +0100 (CET)
Date:   Wed, 9 Nov 2022 16:40:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <20221109154023.cx2d4y3e7zqnuo35@quack3>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
 <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
 <20221109125756.GA24388@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109125756.GA24388@willie-the-truck>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-11-22 12:57:57, Will Deacon wrote:
> On Mon, Nov 07, 2022 at 11:49:01AM -0500, Waiman Long wrote:
> > On 11/7/22 10:10, Sebastian Andrzej Siewior wrote:
> > > + locking, arm64
> > > 
> > > On 2022-11-07 14:56:36 [+0100], Jan Kara wrote:
> > > > > spinlock_t and raw_spinlock_t differ slightly in terms of locking.
> > > > > rt_spin_lock() has the fast path via try_cmpxchg_acquire(). If you
> > > > > enable CONFIG_DEBUG_RT_MUTEXES then you would force the slow path which
> > > > > always acquires the rt_mutex_base::wait_lock (which is a raw_spinlock_t)
> > > > > while the actual lock is modified via cmpxchg.
> > > > So I've tried enabling CONFIG_DEBUG_RT_MUTEXES and indeed the corruption
> > > > stops happening as well. So do you suspect some bug in the CPU itself?
> > > If it is only enabling CONFIG_DEBUG_RT_MUTEXES (and not whole lockdep)
> > > then it looks very suspicious.
> > > CONFIG_DEBUG_RT_MUTEXES enables a few additional checks but the main
> > > part is that rt_mutex_cmpxchg_acquire() + rt_mutex_cmpxchg_release()
> > > always fail (and so the slowpath under a raw_spinlock_t is done).
> > > 
> > > So if it is really the fast path (rt_mutex_cmpxchg_acquire()) then it
> > > somehow smells like the CPU is misbehaving.
> > > 
> > > Could someone from the locking/arm64 department check if the locking in
> > > RT-mutex (rtlock_lock()) is correct?
> > > 
> > > rtmutex locking uses try_cmpxchg_acquire(, ptr, ptr) for the fastpath
> > > (and try_cmpxchg_release(, ptr, ptr) for unlock).
> > > Now looking at it again, I don't see much difference compared to what
> > > queued_spin_trylock() does except the latter always operates on 32bit
> > > value instead a pointer.
> > 
> > Both the fast path of queued spinlock and rt_spin_lock are using
> > try_cmpxchg_acquire(), the only difference I saw is the size of the data to
> > be cmpxchg'ed. qspinlock uses 32-bit integer whereas rt_spin_lock uses
> > 64-bit pointer. So I believe it is more on how the arm64 does cmpxchg. I
> > believe there are two different ways of doing it depending on whether LSE
> > atomics is available in the platform. So exactly what arm64 system is being
> > used here and what hardware capability does it have?
> 
> I'd be more inclined to be suspicious of the slowpath tbh, as we need to
> make sure that we have acquire semantics on all paths where the lock can
> be taken. Looking at the rtmutex code, this really isn't obvious to me --
> for example, try_to_take_rt_mutex() appears to be able to return via the
> 'takeit' label without acquire semantics and it looks like we might be
> relying on the caller's subsequent _unlock_ of the wait_lock for ordering,
> but that will give us release semantics which aren't correct.
> 
> As a quick hack, can you try chucking a barrier into rt_mutex_set_owner()?

Bingo! This patch fixes the crashes for me.

								Honza

> --->8
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 7779ee8abc2a..dd6a66c90f53 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -98,6 +98,7 @@ rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
>                 val |= RT_MUTEX_HAS_WAITERS;
>  
>         WRITE_ONCE(lock->owner, (struct task_struct *)val);
> +       smp_mb();
>  }
>  
>  static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
