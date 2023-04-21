Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814756EB22F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjDUTSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDUTSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:18:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F71BC3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:18:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682104689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swnu0givVhZgdAlS4m3xSf1Hambxbj5ky2a6KwMVkiE=;
        b=3gMiwoMV+DSI75YpktkmPkRQj+C9gBKllwxbaUUnAMW0HQoiS21qIMmgl4mlhmhzg/+31a
        hKrWtNFQUlOCxTT7xK/8QZXQdjQt2XCqwf9iO+cIza/AfT/s2LzFa1rhH/Mi92Um6YvkDe
        D+vBqPY9fFg2e5T1li8xGyzQFlv08idzTaAHlEVadXijU0n+MW6oHTZmEMsTIcPOEw0+q9
        I/BRAliLDoxv+f+E8nysCj+Yk0SoOVOmLt0SC47qVQTFmWYVtxdU/UyGXfrmFsqEWHvSus
        z0XXZj/DDAZ6n7M1cKlDnDfAqN5OLdvoXKW6PcnnXXbeOv6a0J3h04uEXQG/Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682104689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swnu0givVhZgdAlS4m3xSf1Hambxbj5ky2a6KwMVkiE=;
        b=LqKRd2ilg8fxesj0lQv123tZIHReiPHWm0E4zXr5+MvobRIXia7AO3PD9HCEtLZoUineUX
        uBVCIz/hvAs4rxBw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Crystal Wood <swood@redhat.com>, John Keeping <john@metanate.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking/rtmutex: Flush the plug before entering the
 slowpath.
In-Reply-To: <20230322162719.wYG1N0hh@linutronix.de>
References: <20230322162719.wYG1N0hh@linutronix.de>
Date:   Fri, 21 Apr 2023 21:18:08 +0200
Message-ID: <87sfct11u7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22 2023 at 17:27, Sebastian Andrzej Siewior wrote:
>> This still leaves the problem vs. io_wq_worker_sleeping() and it's
>> running() counterpart after schedule().
>
> io_wq_worker_sleeping() has a kfree() so it probably should be moved,
> too.
> io_wq_worker_running() is a OR and INC and is fine.

Why is io_wq_worker_sleeping() not cured in the same way? Just because
it did not yet result in a splat?

Why not just expose sched_submit_work()?

> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -143,6 +143,14 @@ static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
>  	if (rwbase_read_trylock(rwb))
>  		return 0;
>  
> +	if (state != TASK_RTLOCK_WAIT) {

Bah. That code has explicit rwbase_foo() helpers which are filled in by
rwsem and rwlock. Making this conditional on state is creative at best.

> +		/*
> +		 * If we are going to sleep and we have plugged IO queued,
> +		 * make sure to submit it to avoid deadlocks.
> +		 */
> +		blk_flush_plug(current->plug, true);
> +	}
> +
>  	return __rwbase_read_lock(rwb, state);
>  }
>  
> diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
> index d1473c624105c..472e3622abf09 100644
> --- a/kernel/locking/ww_rt_mutex.c
> +++ b/kernel/locking/ww_rt_mutex.c
> @@ -67,6 +67,11 @@ __ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx,
>  			ww_mutex_set_context_fastpath(lock, ww_ctx);
>  		return 0;
>  	}
> +	/*
> +	 * If we are going to sleep and we have plugged IO queued, make sure to
> +	 * submit it to avoid deadlocks.
> +	 */
> +	blk_flush_plug(current->plug, true);
>  
>  	ret = rt_mutex_slowlock(&rtm->rtmutex, ww_ctx, state);

This hunk can be avoided by moving the submit work invocation to
rt_mutex_slowlock().

Thanks,

        tglx
