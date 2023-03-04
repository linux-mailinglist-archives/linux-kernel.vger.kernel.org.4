Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB47F6AA7BB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 04:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCDDBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 22:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDDBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:01:33 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D2B1A492
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:01:32 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id ne1so3053746qvb.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677898891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rAI8Lg5JH5l04xRHiJUzwIPZxaG0a3cR4D2d2cgQY0Q=;
        b=ugezLGVklazr2CVkP4evw+Df//GBCmhtSImXEZ0px4xFnubozp/9OtgUKZ0iTxAF/b
         5BwKnw5XLj0x4rFp5LXjcbxa0va0pncSEKEM5cpCEN2vUxgWz01tNXQnaZXK3XwDPxVV
         kFUeGTNvIEtVKj8cNA9/wp/GHBhYgHB3yGRrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677898891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAI8Lg5JH5l04xRHiJUzwIPZxaG0a3cR4D2d2cgQY0Q=;
        b=v7v8lwCNf39zebKbFQXXgfdyfVg0/zc2mFn/83+PHHcFlKFnvTYFVU4PylIzvyRY1Q
         lzHATkjOApkx1aNgTOQXgfuOWcne8yBrCE1G36cLdY7MT41bfv9JF3AFkP1H+cUHG6wE
         KYsJsXrYH75LCUM1nUWDqlKNcVdUTL5j93q7F5l2uEKyUl7mePHHmBqnqxQg41vO0Oda
         lMdrYUq6pARl+JTR/krg0mUqURTOxV5YQ2FTpRWhpggLUoKTdyyIC5Z6A0s9xtEE4wb1
         pQ7EFm2G0JszqRhR60qeblLhku4YLFVj43nGE230QEp9/t2drhPtfycF0jEmm+5O3JeH
         pkTg==
X-Gm-Message-State: AO0yUKV0BQMubS7YubJM65NgvrHf0L+vK6Ys03qaK8U/+XzP51bGNmNG
        xZaV+ulrigSAG92YkPbLao9zOg==
X-Google-Smtp-Source: AK7set9DLZZpP/ki3SOF/QtbkxmXlW29hmrrREg+AJ+gxQtj6maXbifu8ieJdMuVE8ig2hkgIdG+oA==
X-Received: by 2002:a05:6214:2a88:b0:56e:b91f:aec4 with SMTP id jr8-20020a0562142a8800b0056eb91faec4mr6771273qvb.11.1677898891318;
        Fri, 03 Mar 2023 19:01:31 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id do53-20020a05620a2b3500b00741b312c899sm2951416qkb.6.2023.03.03.19.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 19:01:30 -0800 (PST)
Date:   Sat, 4 Mar 2023 03:01:30 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20230304030130.GA2176990@google.com>
References: <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
 <20230302152103.2618f1b7@gandalf.local.home>
 <20230302163253.541ac3a8@gandalf.local.home>
 <20230302163603.223313ba@gandalf.local.home>
 <20230302165613.2dcc18ca@gandalf.local.home>
 <20230302200136.381468f0@gandalf.local.home>
 <20230303181134.GA1837196@google.com>
 <20230303133702.4d336ee9@gandalf.local.home>
 <CAEXW_YQN=zPtbd6Nr=F-0GqkHQu+ox3eBnzP30=8MxYGYyFv0Q@mail.gmail.com>
 <20230303143822.027ce50b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303143822.027ce50b@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Steve,

On Fri, Mar 03, 2023 at 02:38:22PM -0500, Steven Rostedt wrote:
> On Fri, 3 Mar 2023 14:25:23 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Fri, Mar 3, 2023 at 1:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Fri, 3 Mar 2023 18:11:34 +0000
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > >  
> > > > In the normal mutex's adaptive spinning, there is no check for if there is a
> > > > change in waiter AFAICS (ignoring ww mutex stuff for a second).
> > > >
> > > > I can see one may want to do that waiter-check, as spinning
> > > > indefinitely if the lock owner is on the CPU for too long may result in
> > > > excessing power burn. But normal mutex does not seem to do that.
> > > >
> > > > What  makes the rtmutex spin logic different from normal mutex in this
> > > > scenario, so that rtmutex wants to do that but normal ones dont?  
> > >
> > > Well, the point of the patch is that I don't think they should be different
> > > ;-)  
> > 
> > But there's no "waiter change" thing for mutex_spin_on_owner right.
> > 
> > Then, should mutex_spin_on_owner() also add a call to
> > __mutex_waiter_is_first() ?
> 
> Ah interesting, I missed the __mutex_waiter_is_first() in the mutex code,
> where it looks to do basically the same thing as rt_mutex (but slightly
> different).

True, I concur!

> From looking at this, it appears that mutex() has FIFO fair
> logic, where the second waiter will sleep.
> 
> Would be interesting to see why John sees such a huge difference between
> normal mutex and rtmutex if they are doing the same thing. One thing is
> perhaps the priority logic is causing the issue, where this will not
> improve anything.


> I wonder if we add spinning to normal mutex for the other waiters if that
> would improve things or make them worse?

Yeah it could improve things (or make them worse ;-). In that approach, I
guess those other waiters will not be spinning for too long once the first
waiter gets the lock, as mutex_spin_on_owner() it will break out of the spin:

while (__mutex_owner(lock) == owner) {
  ...
}

But yeah it sounds like a plausible idea.

> > > > Another thought is, I am wondering if all of them spinning indefinitely might
> > > > be Ok for rtmutex as well, since as you mentioned, preemption is enabled. So
> > > > adding the if (top_waiter != last_waiter) {...} might be unnecessary? In fact
> > > > may be even harmful as you are disabling interrupts in the process.  
> > >
> > > The last patch only does the interrupt disabling if the top waiter changes.
> > > Which in practice is seldom.
> > >
> > > But, I don't think a non top waiter should spin if the top waiter is not
> > > running. The top waiter is the one that will get the lock next. If the
> > > owner releases the lock and gives it to the top waiter, then it has to go
> > > through the wake up of the top waiter.

Ah ok. I see what you're doing now!

I guess that check will help whenever the top-waiter keeps changing. In that
case you want only the latest top-waiter as the spinner, all while the lock
owner is not changing.

> > Correct me if I'm wrong, but I don't think it will go through
> > schedule() after spinning, which is what adds the overhead for John.
> 
> Only if the lock becomes free.

Ah yeah, true!

> > > I don't see why a task should spin
> > > to save a wake up if a wake up has to happen anyway.  
> > 
> > What about regular mutexes, happens there too or no?
> 
> Yes, but in a FIFO order, where in rt_mutex, a second, higher priority task
> can make the first ones sleep. So maybe it's just the priority logic that
> is causing the issues.

True! So in the FIFO thing, there's no way a high prio task can get ahead in
line of the first waiter, makes sense.

> > > > Either way, I think a comment should go on top of the "if (top_waiter !=
> > > > waiter)" check IMO.  
> > >
> > > What type of comment?  
> > 
> > Comment explaining why "if (top_waiter != waiter)" is essential :-).
> 

Maybe "/* Only the top waiter needs to spin. If we are no longer the
top-waiter, no point in spinning, as we do not get the lock next anyway. */"

?

thanks,

 - Joel

