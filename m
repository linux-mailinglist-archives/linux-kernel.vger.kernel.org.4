Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5986281F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiKNOHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiKNOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:07:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985B42A958
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3609661162
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B155CC433D6;
        Mon, 14 Nov 2022 14:07:36 +0000 (UTC)
Date:   Mon, 14 Nov 2022 09:08:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
Message-ID: <20221114090818.30b292c7@gandalf.local.home>
In-Reply-To: <87pmdqs5vr.ffs@tglx>
References: <20221110064101.429013735@goodmis.org>
        <20221110064147.343514404@goodmis.org>
        <87cz9qttdb.ffs@tglx>
        <20221113191135.0b61bb51@rorschach.local.home>
        <87pmdqs5vr.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 02:04:56 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, Nov 13 2022 at 19:11, Steven Rostedt wrote:
> > On Sun, 13 Nov 2022 22:52:16 +0100
> > Thomas Gleixner <tglx@linutronix.de> wrote:  
> >> > We are hitting a common bug were a timer is being triggered after it
> >> > is    
> >> 
> >> We are hitting? Talking in pluralis majestatis by now?  
> >
> > Should I say Chromebooks are hitting?  
> 
> That would be at least more comprehensible than 'We', unless you (or
> whoever is 'We') is a synomym for chromeborks.

Sure, I'll update it to start with:

   Out in the field, the main cause of kernel crashes for Chromebooks is in
   the timer code.


> 
> >> > freed. This causes a corruption in the timer link list and crashes the
> >> > kernel. Unfortunately it is not easy to know what timer it was that was    
> >> 
> >> Well, that's not entirely true. debugobjects can tell you exactly what
> >> happens.   
> >
> > Only if you have it enabled when it happens, and it has too much
> > overhead to run in production. The full series changes debug object
> > timers to report an issue if there's a timer not in the shutdown state
> > when it is freed.  
> 
> The series changes 'debug object timers' to report an issue?

The full series does. This isn't the full series, but only the part that
Linus asked for.

https://lore.kernel.org/lkml/20221104054917.915205356@goodmis.org/

> 
> Can you pretty please stop this completely nonsensical blurb? This
> series has absolutely nothing to do with debugobjects at least not to
> my knowledge. If the series expands the magics of debugobjects then
> you fundamentaly failed to explain that.

The full series does, but I was asked by Linus to only give the part that
he could take early. The changes to debugobjects can only be done after we
covert the other users of timers to make sure they are shutdown before
being freed. Otherwise you will get a lot of false positives.

> 
> > This catches potential issues similar to how lockdep can catch
> > potential deadlocks without having to hit the deadlock.  
> 
> By introducing new problems?
> 
> > The current debug object timers only catches it if the race condition
> > is hit.  
> 
> True. But most if not all of the mentioned issues have been reported
> before via debugobject enabled kernels. So what's the actual benefit?

Because we are still hitting bugs in the field and have no idea who the
culprit is. The bugs are triggered by what users are doing (probably
unplugging some USB device or something) and we have not been able to
reproduce it in the lab. The user's activities causes a crash later on
in the timer code. And the crash report shows the backtrace in the timer
code where the timer link list is corrupted. Something that would happen if
the object was freed.

> 
> >> > + * @timer: The timer to be freed
> >> > + *
> >> > + * Shutdown the timer before freeing. This will return when all pending timers
> >> > + * have finished and it is safe to free the timer.    
> >> 
> >>    "_ALL_ pending timers have finished?"
> >> 
> >> This is about exactly _ONE_ timer, i.e. the one which is handed in via
> >> the @timer argument.
> >> 
> >> You want to educate people to do the right thing and then you go and
> >> provide them uncomprehensible documentation garbage. How is that
> >> supposed to work?  
> >
> > I don't know. Other people I showed this to appeared to understand it.
> > But I'm all for updates.  
> 
> Do I really need to explain to you what the diffference between 'all
> pending timers' and the one which is subject of the function call is?
> 
> No, I'm not rewriting this for you and your peers who care obviously as
> much about correctness as you do.

I'm not asking you to rewrite it, I'm fine doing it. My response here was
due to your condescending remarks. That is:

Instead of saying:

    You want to educate people to do the right thing and then you go and
    provide them uncomprehensible documentation garbage. How is that
    supposed to work? 

say:

    You want to educate people to do the right thing, then please be more
    accurate in your terminology. "All pending timers" is confusing
    because this is about _ONE_ timer, i.e. the one which is handed in via
    the @timer argument. Please rewrite the kernel doc to reflect this.

> 
> >> Can you please stop this frenzy and get your act together?  
> >
> > What the hell. I'm just trying to get this in because it's a thorn in
> > our side.  
> 
> It's not a thorn in 'our' (who ever is our) side. It's a fundamental
> problem of circular shutdown dependencies as I explained to you long
> ago.

The thorn is in the Chromebook users, that are having their machines crash
due to something freeing an active timer.

> 
> > Sorry I'm not up to par with your expectations. I'm willing to make
> > changes, but let's leave out the insults. This work is being done on
> > top of my day job.  
> 
> Sure and because of that you are talking about this as a 'thorn on our
> side'. If that's a thorn at (I assume) your employers side, which is
> then related to your day job, then you should have the backing of that
> company to spend company time on it and not inflict half baken changes
> on the kernel which solve nothing.

It may be my employer's, but not my team's issue. It's Guenter's team where
I looked at a bug report that he posted and figured I could help. But I have
other responsibilities that are not going away when I decided to help here.
Thus, I just extended my work week. This is why I came back to it. I
reported this back in April, but then found myself too busy with my current
job to follow through with it. Then recently Guenter reported that the
timer crashes are still the #1 reason for kernel crashes, and I figured I
should then finish this series.

> 
> Coming back to your claim that I'm insulting. Please point me to the
> actual insult I commenced and I'm happy to apologize.

It's more the condescending attitude than a direct insult.

-- Steve
