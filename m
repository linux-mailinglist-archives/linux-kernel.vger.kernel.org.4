Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2646ACDE0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCFTTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCFTTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:19:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7CE47437
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:19:29 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so8930003wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1678130368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+9jUMtKAP1NsIxmt9bemROFT6ZGSIHYy5IhxK+eFxM=;
        b=UztCyb+pblWL09z37NNkOpKrqJHbODceCYqnhgfUFFmQdOT/TuRVWCWbfdZ3zpqWOH
         k9OroYRbQbGY9KEJx1ZU0Xgg8V0LPdM3HCMatM2XJ+LQYjzqtDbU0h8RTYBqW1fA9nrZ
         kBj/V02tMGHt91gcJcFn6Ell1+1e7Dk0sRfUdntrzOCyJoPzATQAtkQ1tD2o3AXgS4oy
         j46mwSPu1l/iBc54DAiAK8eEzlJ/WMIaRbqtDaEo9ZRt5K8w9IRHIN7Y0qj9nrtyETII
         rDO+r29gYVyKTuqUdVmv/lc6lK4o7/MddMVClyxRq8qvm0vJQLGmDl4qBSL351bCwMH9
         sQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678130368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+9jUMtKAP1NsIxmt9bemROFT6ZGSIHYy5IhxK+eFxM=;
        b=Hmiaz59gdRKYfB9xKTDbRKmVhciba0vcxikW/Rpa/opKQPivYI6bGVOocE4OyiwYBC
         En/xdiCqQ8D+6jENqNjfO7b3uOQis+nn60gpbH9E3PQ6DTtgsHHTJCOa9Qp9oF9Sopcf
         q3NCzVkLGxJ6fnWfWmXI7H0CHQW/pIsaKWwYKDgHuyPzt/QAZ1iJVuz336+916kXSTzF
         g/9ZgWr/769kv2Br7L3p+Zc2n1eBMQ+LWjvPU8Vd+JWgVv4YUXPgxY1FwUI7ycArmtoN
         uN45G7aZ/WA44upkUtMVoXBBh7ABjlGWOoXmCzNPQamDnTbo5h4JvMMMTqwQZ7SYDtiG
         W+Cw==
X-Gm-Message-State: AO0yUKUGemoGrw4A1O38FflnOKmrbbZlNeA+PTvRFPV52MZ2LcG1aTI/
        IGCNC/KkIGWP8630AmV6ysxYWA==
X-Google-Smtp-Source: AK7set9UcwiG9kb5YSCosLZVO0ZC+9NoblMB7M0gpHqnvvkQ66Xxx2yIWw/GgamAqy5R0BB7Cq9X3w==
X-Received: by 2002:a05:600c:5103:b0:3eb:40de:9838 with SMTP id o3-20020a05600c510300b003eb40de9838mr7619557wms.7.1678130368096;
        Mon, 06 Mar 2023 11:19:28 -0800 (PST)
Received: from airbuntu (host86-168-251-3.range86-168.btcentralplus.com. [86.168.251.3])
        by smtp.gmail.com with ESMTPSA id v38-20020a05600c4da600b003eb68bb61c8sm10471393wmp.3.2023.03.06.11.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 11:19:27 -0800 (PST)
Date:   Mon, 6 Mar 2023 19:19:26 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20230306191926.n5526srkze5fnqag@airbuntu>
References: <20230302163253.541ac3a8@gandalf.local.home>
 <20230302163603.223313ba@gandalf.local.home>
 <20230302165613.2dcc18ca@gandalf.local.home>
 <20230302200136.381468f0@gandalf.local.home>
 <20230303181134.GA1837196@google.com>
 <20230303133702.4d336ee9@gandalf.local.home>
 <CAEXW_YQN=zPtbd6Nr=F-0GqkHQu+ox3eBnzP30=8MxYGYyFv0Q@mail.gmail.com>
 <20230303143822.027ce50b@gandalf.local.home>
 <20230303203645.etfz444pzg4xxi6f@airbuntu>
 <20230304032135.GB2176990@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230304032135.GB2176990@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/23 03:21, Joel Fernandes wrote:
> On Fri, Mar 03, 2023 at 08:36:45PM +0000, Qais Yousef wrote:
> > On 03/03/23 14:38, Steven Rostedt wrote:
> > > On Fri, 3 Mar 2023 14:25:23 -0500
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > 
> > > > On Fri, Mar 3, 2023 at 1:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > >
> > > > > On Fri, 3 Mar 2023 18:11:34 +0000
> > > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >  
> > > > > > In the normal mutex's adaptive spinning, there is no check for if there is a
> > > > > > change in waiter AFAICS (ignoring ww mutex stuff for a second).
> > > > > >
> > > > > > I can see one may want to do that waiter-check, as spinning
> > > > > > indefinitely if the lock owner is on the CPU for too long may result in
> > > > > > excessing power burn. But normal mutex does not seem to do that.
> > > > > >
> > > > > > What  makes the rtmutex spin logic different from normal mutex in this
> > > > > > scenario, so that rtmutex wants to do that but normal ones dont?  
> > > > >
> > > > > Well, the point of the patch is that I don't think they should be different
> > > > > ;-)  
> > > > 
> > > > But there's no "waiter change" thing for mutex_spin_on_owner right.
> > > > 
> > > > Then, should mutex_spin_on_owner() also add a call to
> > > > __mutex_waiter_is_first() ?
> > > 
> > > Ah interesting, I missed the __mutex_waiter_is_first() in the mutex code,
> > > where it looks to do basically the same thing as rt_mutex (but slightly
> > > different). From looking at this, it appears that mutex() has FIFO fair
> > > logic, where the second waiter will sleep.
> > > 
> > > Would be interesting to see why John sees such a huge difference between
> > > normal mutex and rtmutex if they are doing the same thing. One thing is
> > > perhaps the priority logic is causing the issue, where this will not
> > > improve anything.
> > 
> > I think that can be a good suspect. If the waiters are RT tasks the root cause
> > might be starvation issue due to bad priority setup and moving to FIFO just
> > happens to hide it.
> 
> I wonder if mutex should actually prioritize giving the lock to RT tasks
> instead of FIFO, since that's higher priority work. It sounds that's more
> 'fair'. But that's likely to make John's issue worse.

It is the right thing to do IMHO, but I guess the implications are just too
hard to tell to enforce it by default yet. Which is I guess why it's all
protected by PREEMPT_RT still.

(I'm not sure but I assumed that logically PREEMPT_RT would convert all mutex
to rt_mutexes by default)

> 
> > For same priority RT tasks, we should behave as FIFO too AFAICS.
> > 
> > If there are a mix of RT vs CFS; RT will always win of course.
> > 
> > > 
> > > I wonder if we add spinning to normal mutex for the other waiters if that
> > > would improve things or make them worse?
> > 
> > I see a potential risk depending on how long the worst case scenario for this
> > optimistic spinning.
> > 
> > RT tasks can prevent all lower priority RT and CFS from running.
> 
> Agree, I was kind of hoping need_resched() in mutex_spin_on_owner() would
> come to the rescue in such a scenario, but obviously not. Modifications to
> check_preempt_curr_rt() could obviously aid there but...
> 
> > CFS tasks will lose some precious bandwidth from their sched_slice() as this
> > will be accounted for them as RUNNING time even if they were effectively
> > waiting.
> 
> True, but maybe the CFS task is happy to lose some bandwidth and get back to
> CPU quickly, than blocking and not getting any work done. ;-)

It depends on the worst case scenario of spinning. If we can ensure it's
bounded to something small, then yeah I don't see an issue :-)


Cheers

--
Qais Yousef
