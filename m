Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF73689866
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjBCMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjBCMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:20:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1679E9C7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Njyecw2g3UOsXk5RteGYnfdkZ/fIv9rG1pngKNQ1R/o=; b=V8HJpygYN38/8+wHlkGCq6jB+a
        +LdEG2MAwd+RY5Ve+NBpVf9Ldk8TfPH83K2EdkMbgHPFmXULPiacRG1/RP1ZR2GG4ap6UyHeA6DBl
        d/7VhOYb6xbA8N9rqnau58GD87ZXvryyPUjbVxknmvAGxdutW2mri6giwTCs/BZWf4L6xGhayqBzJ
        mw8Y76SpQgv3gVaIKxiwxz8kulLiIr1Gb5z2h69nbZrcqyF9FaBjhcBpbhEVsEOHyJ+/GIPnUycIe
        f5d0r0lZ6mTc4zjJATkh5k7UlPyis0sYkXkN7Qz07/800LqgVaCf9sC4UtDW14QFgXUShdB9aWLnS
        t9J+s0sA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNv2F-005VN5-0p;
        Fri, 03 Feb 2023 12:19:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6703530013F;
        Fri,  3 Feb 2023 13:19:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 444D323F3C80C; Fri,  3 Feb 2023 13:19:53 +0100 (CET)
Date:   Fri, 3 Feb 2023 13:19:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Message-ID: <Y9z76ZLe4On96xIN@hirez.programming.kicks-ass.net>
References: <20230127014137.4906-1-hdanton@sina.com>
 <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
 <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 07:48:35PM +0900, Tetsuo Handa wrote:
> On 2023/02/03 19:22, Tetsuo Handa wrote:
> > Yes, this bug is caused by commit f5d39b020809 ("freezer,sched: Rewrite core freezer
> > logic"), for that commit for unknown reason omits wait_for_completion(&done) call
> > when wait_for_completion_state(&done, state) returned -ERESTARTSYS.
> > 
> > Peter, is it safe to restore wait_for_completion(&done) call?
> > 
> 
> Something like this?
> 
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 850631518665..97230edb1849 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -441,8 +441,8 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>  	if (wait & UMH_KILLABLE)
>  		state |= TASK_KILLABLE;
>  
> -	if (wait & UMH_FREEZABLE)
> -		state |= TASK_FREEZABLE;
> +	//if (wait & UMH_FREEZABLE)
> +	//	state |= TASK_FREEZABLE;
>  
>  	retval = wait_for_completion_state(&done, state);
>  	if (!retval)
> @@ -452,7 +452,9 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>  		/* umh_complete() will see NULL and free sub_info */
>  		if (xchg(&sub_info->complete, NULL))
>  			goto unlock;
> +		/* fallthrough, umh_complete() was already called */
>  	}
> +	wait_for_completion(&done);
>  
>  wait_done:
>  	retval = sub_info->retval;
> 
> How does TASK_FREEZABLE affect here?

It marks those waits that are safe to convert to a frozen state.

> Since call_usermodehelper_exec() is a function for starting and
> waiting for termination of a userspace process (which is subjected to
> freezing), the caller of call_usermodehelper_exec() can't wait for the
> termination of that userspace process if that process was frozen, and
> wait_for_completion()
> blocks forever?

It'll probably make the freeze fail and abort the suspend. We first
freezer userspace (including the helper), then we try and freeze all the
kernel threads. If we can't, we error out and abort -- waking everything
back up.

But now I realize what I missed before, wait_for_completion() it not
interruptible.

I think the right fix is to:

	state &= ~TASK_KILLABLE;
	wait_for_completion_state(&done, state);

Also, put in a comment..
