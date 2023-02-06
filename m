Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386E568C238
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjBFPvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBFPvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:51:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5DB2CC6B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uxonDpulPxSRYb7sBMKeYlC1AfpPdN2V7tWY/tM7Zhw=; b=GdB/H4WTI5QjTUi8lEhqeSNYHY
        t6IujRjLG1CmJtLJWWyR3gOa7Z7NbusQVMIlJe8fc6rIRbVGD1hue2UEIjQlqi6UEEhfIlgMWGtwE
        pAuYbIwhByHYj5mZtrvux6eLdMoKZ+Ez+O20YRNeY81FOaKmjBElcUEG6GZtwoh/xPI9pwpguL/Bh
        dfV9FCkgq3JPbzgfa3c1NE6sGm63KStx9TLcHWvNY3MBbB0SjCVlnlw90CQRhX8VK+mA1mDrJeDXm
        7GV0XfP4gRpb2O/rSfUZ1tO/aHcGTzIDRepGLcg8c//ftt0CeBQnkKAX6hVzYj4giccJlJQTZ6RvY
        PDMPxoeQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP3m0-0094Q5-Gj; Mon, 06 Feb 2023 15:51:16 +0000
Date:   Mon, 6 Feb 2023 07:51:16 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Schspa Shi <schspa@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Message-ID: <Y+Eh9CFdTwwv+hot@bombadil.infradead.org>
References: <20230127014137.4906-1-hdanton@sina.com>
 <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
 <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
 <Y9z76ZLe4On96xIN@hirez.programming.kicks-ass.net>
 <Y9z+SerR8mlZYo16@hirez.programming.kicks-ass.net>
 <6c47dbcf-2a17-6bb2-719b-841d851c603b@I-love.SAKURA.ne.jp>
 <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
 <caa13441-5f95-b7d6-dd5d-1cf49e709714@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa13441-5f95-b7d6-dd5d-1cf49e709714@I-love.SAKURA.ne.jp>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 09:48:39AM +0900, Tetsuo Handa wrote:
> On 2023/02/03 23:31, Peter Zijlstra wrote:
> > Yes, I meant something like so.
> > 
> > 
> > diff --git a/kernel/umh.c b/kernel/umh.c
> > index 850631518665..0e69e1e4b6fe 100644
> > --- a/kernel/umh.c
> > +++ b/kernel/umh.c
> > @@ -438,21 +438,24 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
> >  	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
> >  		goto unlock;
> >  
> > -	if (wait & UMH_KILLABLE)
> > -		state |= TASK_KILLABLE;
> > -
> > -	if (wait & UMH_FREEZABLE)
> > +	if (wait & UMH_FREEZABLE) {
> >  		state |= TASK_FREEZABLE;
> >  
> > -	retval = wait_for_completion_state(&done, state);
> > -	if (!retval)
> > -		goto wait_done;
> > -
> >  	if (wait & UMH_KILLABLE) {
> > +		retval = wait_for_completion_state(&done, state | TASK_KILLABLE);
> > +		if (!retval)
> > +			goto wait_done;
> > +
> >  		/* umh_complete() will see NULL and free sub_info */
> >  		if (xchg(&sub_info->complete, NULL))
> >  			goto unlock;
> > +
> > +		/*
> > +		 * fallthrough; in case of -ERESTARTSYS now do uninterruptible
> > +		 * wait_for_completion().
> > +		 */
> >  	}
> > +	wait_for_completion_state(&done, state);
> >  
> >  wait_done:
> >  	retval = sub_info->retval;
> 
> Please fold below diff, provided that wait_for_completion_state(TASK_FREEZABLE)
> does not return when the current thread was frozen. (If
> wait_for_completion_state(TASK_FREEZABLE) returns when the current thread was
> frozen, we will fail to execute the
> 
>   retval = sub_info->retval;
> 
> line in order to get the exit code after the current thread is thawed...)
> 
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 0e69e1e4b6fe..a776920ec051 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -431,35 +431,38 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>  	 * This makes it possible to use umh_complete to free
>  	 * the data structure in case of UMH_NO_WAIT.
>  	 */
>  	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &done;
>  	sub_info->wait = wait;
>  
>  	queue_work(system_unbound_wq, &sub_info->work);
>  	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
>  		goto unlock;
>  
> -	if (wait & UMH_FREEZABLE) {
> +	if (wait & UMH_FREEZABLE)
>  		state |= TASK_FREEZABLE;
>  
>  	if (wait & UMH_KILLABLE) {
>  		retval = wait_for_completion_state(&done, state | TASK_KILLABLE);
>  		if (!retval)
>  			goto wait_done;
>  
>  		/* umh_complete() will see NULL and free sub_info */
>  		if (xchg(&sub_info->complete, NULL))
>  			goto unlock;
>  
>  		/*
>  		 * fallthrough; in case of -ERESTARTSYS now do uninterruptible
> -		 * wait_for_completion().
> +		 * wait_for_completion_state(). Since umh_complete() shall call
> +		 * complete() in a moment if xchg() above returned NULL, this
> +		 * uninterruptible wait_for_completion_state() will not block
> +		 * SIGKILL'ed process for so long.
>  		 */
>  	}
>  	wait_for_completion_state(&done, state);

I think this seems to be the same issue that Schspa Shi reported / provided a
fix sugggestion for [0]. This lead me to ask if:

  a) incorrect usage of completion on stack could be generic and;
  b) if we should instead have an API helper for that?

Although he already implemented a suggestion for b) to answer a) we need
some SmPL constructs yet to be written by Schspa. The reason I asked for
b) is that if this is a regular pattern it begs for a) as this sort of
issue could be prevalent in other places. So the status of Schspa's work
was that he was going to work on the SmPL grammar to check how frequent
this incorrect patern could be found.

Please let me know your thoughts as perhaps this issue / discussion
didn't get on Peter's radar as it was rececently discussed with Schspa
despite being on Cc.

[0] https://lore.kernel.org/all/m2pmcoag55.fsf@gmail.com/T/#u

  Luis
