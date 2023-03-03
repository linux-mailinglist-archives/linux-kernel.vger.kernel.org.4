Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7401D6AA030
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjCCTig convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Mar 2023 14:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjCCTie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:38:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CE114484
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 11:38:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69A4FB817F6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF9FC433EF;
        Fri,  3 Mar 2023 19:38:25 +0000 (UTC)
Date:   Fri, 3 Mar 2023 14:38:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     John Stultz <jstultz@google.com>,
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
Message-ID: <20230303143822.027ce50b@gandalf.local.home>
In-Reply-To: <CAEXW_YQN=zPtbd6Nr=F-0GqkHQu+ox3eBnzP30=8MxYGYyFv0Q@mail.gmail.com>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230302082414.77613351@gandalf.local.home>
        <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
        <20230302152103.2618f1b7@gandalf.local.home>
        <20230302163253.541ac3a8@gandalf.local.home>
        <20230302163603.223313ba@gandalf.local.home>
        <20230302165613.2dcc18ca@gandalf.local.home>
        <20230302200136.381468f0@gandalf.local.home>
        <20230303181134.GA1837196@google.com>
        <20230303133702.4d336ee9@gandalf.local.home>
        <CAEXW_YQN=zPtbd6Nr=F-0GqkHQu+ox3eBnzP30=8MxYGYyFv0Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 14:25:23 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Fri, Mar 3, 2023 at 1:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri, 3 Mar 2023 18:11:34 +0000
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> >  
> > > In the normal mutex's adaptive spinning, there is no check for if there is a
> > > change in waiter AFAICS (ignoring ww mutex stuff for a second).
> > >
> > > I can see one may want to do that waiter-check, as spinning
> > > indefinitely if the lock owner is on the CPU for too long may result in
> > > excessing power burn. But normal mutex does not seem to do that.
> > >
> > > What  makes the rtmutex spin logic different from normal mutex in this
> > > scenario, so that rtmutex wants to do that but normal ones dont?  
> >
> > Well, the point of the patch is that I don't think they should be different
> > ;-)  
> 
> But there's no "waiter change" thing for mutex_spin_on_owner right.
> 
> Then, should mutex_spin_on_owner() also add a call to
> __mutex_waiter_is_first() ?

Ah interesting, I missed the __mutex_waiter_is_first() in the mutex code,
where it looks to do basically the same thing as rt_mutex (but slightly
different). From looking at this, it appears that mutex() has FIFO fair
logic, where the second waiter will sleep.

Would be interesting to see why John sees such a huge difference between
normal mutex and rtmutex if they are doing the same thing. One thing is
perhaps the priority logic is causing the issue, where this will not
improve anything.

I wonder if we add spinning to normal mutex for the other waiters if that
would improve things or make them worse?

> 
> > > Another thought is, I am wondering if all of them spinning indefinitely might
> > > be Ok for rtmutex as well, since as you mentioned, preemption is enabled. So
> > > adding the if (top_waiter != last_waiter) {...} might be unnecessary? In fact
> > > may be even harmful as you are disabling interrupts in the process.  
> >
> > The last patch only does the interrupt disabling if the top waiter changes.
> > Which in practice is seldom.
> >
> > But, I don't think a non top waiter should spin if the top waiter is not
> > running. The top waiter is the one that will get the lock next. If the
> > owner releases the lock and gives it to the top waiter, then it has to go
> > through the wake up of the top waiter.  
> 
> Correct me if I'm wrong, but I don't think it will go through
> schedule() after spinning, which is what adds the overhead for John.

Only if the lock becomes free.

> 
> > I don't see why a task should spin
> > to save a wake up if a wake up has to happen anyway.  
> 
> What about regular mutexes, happens there too or no?

Yes, but in a FIFO order, where in rt_mutex, a second, higher priority task
can make the first ones sleep. So maybe it's just the priority logic that
is causing the issues.

> 
> > > Either way, I think a comment should go on top of the "if (top_waiter !=
> > > waiter)" check IMO.  
> >
> > What type of comment?  
> 
> Comment explaining why "if (top_waiter != waiter)" is essential :-).

You mean, "Don't spin if the next owner is not on any CPU"?

-- Steve
