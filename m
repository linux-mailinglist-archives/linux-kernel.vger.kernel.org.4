Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCAF6273BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiKNALl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKNALk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:11:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC9FDEDC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:11:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC81660DE3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A8CC433C1;
        Mon, 14 Nov 2022 00:11:37 +0000 (UTC)
Date:   Sun, 13 Nov 2022 19:11:35 -0500
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
Message-ID: <20221113191135.0b61bb51@rorschach.local.home>
In-Reply-To: <87cz9qttdb.ffs@tglx>
References: <20221110064101.429013735@goodmis.org>
        <20221110064147.343514404@goodmis.org>
        <87cz9qttdb.ffs@tglx>
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

On Sun, 13 Nov 2022 22:52:16 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, Nov 10 2022 at 01:41, Steven Rostedt wrote:
> 
> $Subject: -ENOPARSE
> 
>  timers: Provide timer_shutdown_sync()
> 
> and then have some reasonable explanation in the change log?
> 
> > We are hitting a common bug were a timer is being triggered after it
> > is  
> 
> We are hitting? Talking in pluralis majestatis by now?

Should I say Chromebooks are hitting?

> 
> > freed. This causes a corruption in the timer link list and crashes the
> > kernel. Unfortunately it is not easy to know what timer it was that was  
> 
> Well, that's not entirely true. debugobjects can tell you exactly what
> happens. 

Only if you have it enabled when it happens, and it has too much
overhead to run in production. The full series changes debug object
timers to report an issue if there's a timer not in the shutdown state
when it is freed. This catches potential issues similar to how lockdep
can catch potential deadlocks without having to hit the deadlock.

The current debug object timers only catches it if the race condition
is hit.

> 
> > freed. Looking at the code, it appears that there are several cases that
> > del_timer() is used when del_timer_sync() should have been.
> > diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> > index 717fcb9fb14a..111a3550b3f2 100644
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -1017,7 +1017,8 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
> >  	unsigned int idx = UINT_MAX;
> >  	int ret = 0;
> >  
> > -	BUG_ON(!timer->function);
> > +	if (WARN_ON_ONCE(!timer->function))
> > +		return -EINVAL;  
> 
> Can you please make these BUG -> WARN conversions a separate patch?

OK.

> 
> > +/**
> > + * timer_shutdown_sync - called before freeing the timer  
> 
> 1) The sentence after the dash starts with an upper case letter as all
>    sentences do.
> 
> 2) "called before freeing the timer" tells us what?
> 
>    See below.
> 
> > + * @timer: The timer to be freed
> > + *
> > + * Shutdown the timer before freeing. This will return when all pending timers
> > + * have finished and it is safe to free the timer.  
> 
>    "_ALL_ pending timers have finished?"
> 
> This is about exactly _ONE_ timer, i.e. the one which is handed in via
> the @timer argument.
> 
> You want to educate people to do the right thing and then you go and
> provide them uncomprehensible documentation garbage. How is that
> supposed to work?

I don't know. Other people I showed this to appeared to understand it.
But I'm all for updates.

> 
> Can you please stop this frenzy and get your act together?

What the hell. I'm just trying to get this in because it's a thorn in
our side. Sorry I'm not up to par with your expectations. I'm willing
to make changes, but let's leave out the insults. This work is being
done on top of my day job.

> 
> > + *
> > + * Note, after calling this, if the timer is added back to the queue
> > + * it will fail to be added and a WARNING will be triggered.  
> 
> There is surely a way to express this so that the average driver writer
> who does not have the background of you working on this understands this
> "note".
> 
> > + *
> > + * Returns if it deactivated a pending timer or not.  
> 
> Please look up the kernel-doc syntax for documenting return values.
> 

Will do.

-- Steve
