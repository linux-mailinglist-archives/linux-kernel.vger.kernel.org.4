Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812FE6AA7C9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 04:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCDDVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 22:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDDVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:21:40 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A522415C9C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:21:38 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id r5so5140355qtp.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677900097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6O4Kra+prgv1fgzQvWNv8BgkAAivs0uLNrP0G1SwuSg=;
        b=agg7ciAErh3byGC8QRrLtmjeH9tPYhdp3nOwtBtsGPQcahu63TEIofq6bkKf0jNdYP
         ZhJ/11rQK+yWLOhZuNgQ+LuXFZyLl7hJG11r0VEaD8GtO82HzfLSEJkjKUT1VUUBioLA
         2EAJCG5xRGDc6om3KqgH8TWCYRU4GC88Xu8vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677900097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6O4Kra+prgv1fgzQvWNv8BgkAAivs0uLNrP0G1SwuSg=;
        b=JFPq3kybiLIOPJqTgnRmonsZKCceam55W5gxftdGxY6aFWR44fvPkS7Jy4axNSJ7cf
         31PdvfMVJM9gZYOX3URDwIwKb2x3tDbpH0D+eaH2Jka1ggkf6To9qetl25C7g/SnUQxF
         uKJOYARvAEh6cXxAzF+zs4p+KkcBSrfrulW2LHILjQP7nwSX0PqzOE+1BwoLjuXfJ7z3
         UUkXQO0vernAf3guY9U0vrmyeqeEfxGCMz59Lo3qUqHOJqr7pBq2gZOlgEQj6fn1WDVm
         GHknfxptH0Pk22sKUI4U1UfE8wWBg0RAWe8FenjP8mCQ9KemBryZoTTH0wsBwXDvBatF
         DyTw==
X-Gm-Message-State: AO0yUKXliqGdwuJsvMrawqlPq9l+wGW/pTJHy9OOST8EuXfFsDFxpA8a
        qnB2Lr5wRcIadD2kFH/0daBKqA==
X-Google-Smtp-Source: AK7set8bZJt9Aeblz/fS8t9J6uHyaDihhwJzktNVqrVnK9DBcXRTanyiXmlaEuGCniIV1ocazb195w==
X-Received: by 2002:a05:622a:38a:b0:3bf:d7f8:4f85 with SMTP id j10-20020a05622a038a00b003bfd7f84f85mr7077387qtx.12.1677900097236;
        Fri, 03 Mar 2023 19:21:37 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id t62-20020ae9df41000000b0073b7f2a0bcbsm2950542qkf.36.2023.03.03.19.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 19:21:36 -0800 (PST)
Date:   Sat, 4 Mar 2023 03:21:35 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230304032135.GB2176990@google.com>
References: <20230302152103.2618f1b7@gandalf.local.home>
 <20230302163253.541ac3a8@gandalf.local.home>
 <20230302163603.223313ba@gandalf.local.home>
 <20230302165613.2dcc18ca@gandalf.local.home>
 <20230302200136.381468f0@gandalf.local.home>
 <20230303181134.GA1837196@google.com>
 <20230303133702.4d336ee9@gandalf.local.home>
 <CAEXW_YQN=zPtbd6Nr=F-0GqkHQu+ox3eBnzP30=8MxYGYyFv0Q@mail.gmail.com>
 <20230303143822.027ce50b@gandalf.local.home>
 <20230303203645.etfz444pzg4xxi6f@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303203645.etfz444pzg4xxi6f@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 08:36:45PM +0000, Qais Yousef wrote:
> On 03/03/23 14:38, Steven Rostedt wrote:
> > On Fri, 3 Mar 2023 14:25:23 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > On Fri, Mar 3, 2023 at 1:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Fri, 3 Mar 2023 18:11:34 +0000
> > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >  
> > > > > In the normal mutex's adaptive spinning, there is no check for if there is a
> > > > > change in waiter AFAICS (ignoring ww mutex stuff for a second).
> > > > >
> > > > > I can see one may want to do that waiter-check, as spinning
> > > > > indefinitely if the lock owner is on the CPU for too long may result in
> > > > > excessing power burn. But normal mutex does not seem to do that.
> > > > >
> > > > > What  makes the rtmutex spin logic different from normal mutex in this
> > > > > scenario, so that rtmutex wants to do that but normal ones dont?  
> > > >
> > > > Well, the point of the patch is that I don't think they should be different
> > > > ;-)  
> > > 
> > > But there's no "waiter change" thing for mutex_spin_on_owner right.
> > > 
> > > Then, should mutex_spin_on_owner() also add a call to
> > > __mutex_waiter_is_first() ?
> > 
> > Ah interesting, I missed the __mutex_waiter_is_first() in the mutex code,
> > where it looks to do basically the same thing as rt_mutex (but slightly
> > different). From looking at this, it appears that mutex() has FIFO fair
> > logic, where the second waiter will sleep.
> > 
> > Would be interesting to see why John sees such a huge difference between
> > normal mutex and rtmutex if they are doing the same thing. One thing is
> > perhaps the priority logic is causing the issue, where this will not
> > improve anything.
> 
> I think that can be a good suspect. If the waiters are RT tasks the root cause
> might be starvation issue due to bad priority setup and moving to FIFO just
> happens to hide it.

I wonder if mutex should actually prioritize giving the lock to RT tasks
instead of FIFO, since that's higher priority work. It sounds that's more
'fair'. But that's likely to make John's issue worse.

> For same priority RT tasks, we should behave as FIFO too AFAICS.
> 
> If there are a mix of RT vs CFS; RT will always win of course.
> 
> > 
> > I wonder if we add spinning to normal mutex for the other waiters if that
> > would improve things or make them worse?
> 
> I see a potential risk depending on how long the worst case scenario for this
> optimistic spinning.
> 
> RT tasks can prevent all lower priority RT and CFS from running.

Agree, I was kind of hoping need_resched() in mutex_spin_on_owner() would
come to the rescue in such a scenario, but obviously not. Modifications to
check_preempt_curr_rt() could obviously aid there but...

> CFS tasks will lose some precious bandwidth from their sched_slice() as this
> will be accounted for them as RUNNING time even if they were effectively
> waiting.

True, but maybe the CFS task is happy to lose some bandwidth and get back to
CPU quickly, than blocking and not getting any work done. ;-)

thanks,

 - Joel


> 
> 
> Cheers
> 
> --
> Qais Yousef
> 
> > 
> > > 
> > > > > Another thought is, I am wondering if all of them spinning indefinitely might
> > > > > be Ok for rtmutex as well, since as you mentioned, preemption is enabled. So
> > > > > adding the if (top_waiter != last_waiter) {...} might be unnecessary? In fact
> > > > > may be even harmful as you are disabling interrupts in the process.  
> > > >
> > > > The last patch only does the interrupt disabling if the top waiter changes.
> > > > Which in practice is seldom.
> > > >
> > > > But, I don't think a non top waiter should spin if the top waiter is not
> > > > running. The top waiter is the one that will get the lock next. If the
> > > > owner releases the lock and gives it to the top waiter, then it has to go
> > > > through the wake up of the top waiter.  
> > > 
> > > Correct me if I'm wrong, but I don't think it will go through
> > > schedule() after spinning, which is what adds the overhead for John.
> > 
> > Only if the lock becomes free.
> > 
> > > 
> > > > I don't see why a task should spin
> > > > to save a wake up if a wake up has to happen anyway.  
> > > 
> > > What about regular mutexes, happens there too or no?
> > 
> > Yes, but in a FIFO order, where in rt_mutex, a second, higher priority task
> > can make the first ones sleep. So maybe it's just the priority logic that
> > is causing the issues.
> > 
> > > 
> > > > > Either way, I think a comment should go on top of the "if (top_waiter !=
> > > > > waiter)" check IMO.  
> > > >
> > > > What type of comment?  
> > > 
> > > Comment explaining why "if (top_waiter != waiter)" is essential :-).
> > 
> > You mean, "Don't spin if the next owner is not on any CPU"?
> > 
> > -- Steve
