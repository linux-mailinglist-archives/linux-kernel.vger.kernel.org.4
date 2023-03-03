Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4716AA0AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjCCUhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCCUhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:37:16 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900362D93
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:36:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p26so2341361wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1677875813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fgszzA4iLkqp2Zj3jvtUEMi0N57rcS/AEl+wcAq2e+Q=;
        b=6PPQLr/F52gpwOpytFiKq4e3HnHWfTo+6lE/XaXfcoiBYpu+2xackAesanwLDdiNYb
         k3nNH8fq+ciAZwt+ScW15K/4PNWoYjeQhEBVqQR1/0U9tGYndtzIkOmknsidfimKzUN3
         tpCbShpXGDuzPcoJ5XrOICV6GMDN5VCZwPX/oUGOo96oRL8/C+6wSynSMA7vrmXIljzU
         hl1hDouceCfBV68bLVre8htsng3YSbFplPBU3ZgJS27UrebU84DUHPSQbPgcUcc1V5UO
         QmwAThpKIoXsRbeJzeJmmiqoVpU3aICrG67juyoPpYH+p9nmfpvxZbg1tlMHJh95FXEE
         20oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgszzA4iLkqp2Zj3jvtUEMi0N57rcS/AEl+wcAq2e+Q=;
        b=zcHbVYvQM1kmWhNgNRWd9tkves+9+FIpfC9iS8iIkwc95VeLTTagnF+bqHAj2itNsR
         5qYmcFnCBqraHpFeEQ0MK94a6DzZuxuTyCHATJtlzKBC8rT//2MDFQNEspDdIzLmmBKe
         vgE1dCPu3sJ0JHpk6h/ePjh1+FWxbS6OkbSREEfHLKN0C3+n8jktNdbAQcXgLePg3MCi
         1K3geKnHMkRTfHg4U7E5K7XJlBRLEy7sRiMlTvab0mELW9HXRpROZ7Z7Dpja7GqGoigf
         AsP0VGTc3+cIWCXCnNZ5TmpuZrtKAmpCEcmjh5LVrBnhBs+MvSgdiizG9e+TBlABYWAb
         Tk/g==
X-Gm-Message-State: AO0yUKW+6UKI6czUU8Q4VwKKdk1o3BI+8GHW1z+Y3XQ5pXY48xoq+SJA
        C0Ipr1ppA65g5Fz8pU2oKbtwRA==
X-Google-Smtp-Source: AK7set/+j/pecXU/MnsEiCtd/7w4Fx2JFrqZG2kc94fTiTXP55VPhYwwVVLlN0hw4j7J9K+T2NnaFQ==
X-Received: by 2002:a1c:2b47:0:b0:3eb:39e7:3604 with SMTP id r68-20020a1c2b47000000b003eb39e73604mr2966610wmr.5.1677875812937;
        Fri, 03 Mar 2023 12:36:52 -0800 (PST)
Received: from airbuntu (host86-168-251-3.range86-168.btcentralplus.com. [86.168.251.3])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d508a000000b002c54241b4fesm3040694wrt.80.2023.03.03.12.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:36:50 -0800 (PST)
Date:   Fri, 3 Mar 2023 20:36:45 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <20230303203645.etfz444pzg4xxi6f@airbuntu>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/23 14:38, Steven Rostedt wrote:
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
> different). From looking at this, it appears that mutex() has FIFO fair
> logic, where the second waiter will sleep.
> 
> Would be interesting to see why John sees such a huge difference between
> normal mutex and rtmutex if they are doing the same thing. One thing is
> perhaps the priority logic is causing the issue, where this will not
> improve anything.

I think that can be a good suspect. If the waiters are RT tasks the root cause
might be starvation issue due to bad priority setup and moving to FIFO just
happens to hide it.

For same priority RT tasks, we should behave as FIFO too AFAICS.

If there are a mix of RT vs CFS; RT will always win of course.

> 
> I wonder if we add spinning to normal mutex for the other waiters if that
> would improve things or make them worse?

I see a potential risk depending on how long the worst case scenario for this
optimistic spinning.

RT tasks can prevent all lower priority RT and CFS from running.

CFS tasks will lose some precious bandwidth from their sched_slice() as this
will be accounted for them as RUNNING time even if they were effectively
waiting.


Cheers

--
Qais Yousef

> 
> > 
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
> > 
> > Correct me if I'm wrong, but I don't think it will go through
> > schedule() after spinning, which is what adds the overhead for John.
> 
> Only if the lock becomes free.
> 
> > 
> > > I don't see why a task should spin
> > > to save a wake up if a wake up has to happen anyway.  
> > 
> > What about regular mutexes, happens there too or no?
> 
> Yes, but in a FIFO order, where in rt_mutex, a second, higher priority task
> can make the first ones sleep. So maybe it's just the priority logic that
> is causing the issues.
> 
> > 
> > > > Either way, I think a comment should go on top of the "if (top_waiter !=
> > > > waiter)" check IMO.  
> > >
> > > What type of comment?  
> > 
> > Comment explaining why "if (top_waiter != waiter)" is essential :-).
> 
> You mean, "Don't spin if the next owner is not on any CPU"?
> 
> -- Steve
