Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD560D6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiJYWLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJYWLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:11:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3B5AC49A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:11:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y16so12947172wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RNCoefe+qYOkgIFECreMnlENprXnyYA+k4FnIKFdtJQ=;
        b=cIPzWYm2cZfiPhg+EogCTp8ePIa326DpDnxKVPt1BaVK4BTcARTBPOuYApMe0q0B0I
         giZktJbH0aEmyb60eSON8XWKfbggPsafY3Jfue1qpV3ItnCyi5YccZOZAtSQHeKF4WKr
         eQZFoSc+Ol6rPCG7YCEvgQvSJfh7BNktxMDRfK5Ddp2bERuDv7me6zhqTqUH1l4uwi5t
         wJDPYFHnS/BCtx7unRgfjKjlGHzIIh0dS76ZvJDkUNWN/1BbgSXXFc4F7mxL4dmn8zJ5
         lcGF2zw3jnI0cROQTCTzQOZ67ld2tLjUEyyhH9dVnjIYnYBZ3PD3bUVul4WolJP6WMeG
         K9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNCoefe+qYOkgIFECreMnlENprXnyYA+k4FnIKFdtJQ=;
        b=NuBdcM3ob6fPTKx3BS0wnKXFOESj+CrZ6HDPPDuU9jDEKC1/AD+oC21B6ApWUvD0It
         4oXlKrhfSIA2st897Xkban2RgSh8eINXQ55JY5ai5ekX4oet+65ZkcQwgKODyo/FK/TP
         hzVFewcGSdUBq5WesT9rpPbALm6Zh7Z8HIXdqBQsKmrdXGr500FSpDkPxaC8xUVmoZ9g
         Lk1W9KIHL7ztglNOliOucbTG9rSrFxzrBPFti1d2Towr7iKesQrs9wXfXul5JqpYpTUO
         33LDSH/XXDod5xiyL6tNoo4KY4dIl50AyK4fAAiPICx2f1vcOkHKPugJSJwyz+vGWRcN
         00CA==
X-Gm-Message-State: ACrzQf17SjXAFhbVRy+KE+kQqojt9KMS2WJLFeY75CVCQbpku125270t
        kef2F+oO+6BxMcVdFWpzPjvC0g==
X-Google-Smtp-Source: AMsMyM5/CuVsnbrZe2SbWoJ7Wp5x+bibYw7wi24owzhDSQ+4I+6PPB/YU+3Qjc+0km58wc3X7tpJ9w==
X-Received: by 2002:a5d:4008:0:b0:235:a4c4:97c2 with SMTP id n8-20020a5d4008000000b00235a4c497c2mr21184306wrp.295.1666735862110;
        Tue, 25 Oct 2022 15:11:02 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b003b4a699ce8esm212006wms.6.2022.10.25.15.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:11:01 -0700 (PDT)
Date:   Tue, 25 Oct 2022 23:10:59 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Connor O'Brien <connoro@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, youssefesmat@google.com
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <20221025221059.2drigl2gcx5sm4ji@airbuntu>
References: <20221024223324.2jgwrmnqxpgw2m67@airbuntu>
 <7BBED338-D158-401B-8A6B-FDBD9FC03973@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7BBED338-D158-401B-8A6B-FDBD9FC03973@joelfernandes.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 07:19, Joel Fernandes wrote:
> 
> 
> > On Oct 24, 2022, at 6:33 PM, Qais Yousef <qyousef@layalina.io> wrote:
> > 
> > ﻿On 10/17/22 09:26, Peter Zijlstra wrote:
> > 
> >> Additionally, the highest priotiy waiter will get the lock next.
> > 
> > True for RT. But for CFS, priority is share and there will be no guarantee
> > the 'highest priority' task will run as soon as the lock is released to
> > grab it, no?
> 
> But the mutex lock owner should have done a wake_up in the mutex unlock path,

I admit I'm a bit speculating in terms of how mutexes/futexes will behave.

I thought we could still end up with a situation where all (or some) waiters
could wake up and race to hold the lock. Which now thinking about it is bad
news for RT on SMP systems since lower priority tasks on other CPUs could get
the lock before higher priority ones on another CPU. So maybe this situation
can never happen..

> which is arranged in FIFO order, if I am not mistaken. Subsequently the
> scheduler will at least get a chance to see if the thing that is waiting for
> the lock is of higher priority, at the next preemption point.

Right. If it's always ticketed, then we guarantee the order of who holds the
lock first. But the order of which the lock is held/requested/locked is not the
same as priority. And I am not sure if all variations of locks/configs will
exhibit the same behavior TBH.

Again I haven't looked closely at the patches/code, but I only seen the notion
of priority in rt_mutex; probably something similar was done in the PE patches.

__waiter_prio() in rt_mutex.c returns DEFAULT_PRIO for !rt_prio(). So it seems
for me for CFS the prio will not influence the top_waiter and they will be just
queued at the bottom in-order. For rt_mutex that is; which apparently is
obsolete from PE perspective.

I probably have speculated based on that rt_mutex behavior. Apologies if
I jumped guns.

> If it did not get to run, I don’t think that’s an issue — it was not highest
> priority as far as the scheduler is concerned. No?

For CFS priority === share; but maybe you refer to some implementation detail
I missed here. IOW, for CFS highest priority is the most starved task, which is
influenced by nice, but doesn't guarantee who gets to run next?

> Steve was teaching me some of this code recently, he could chime in :)

Would be good for the rest of us to get enlightened too :-)

> 
> > For example I can envisage:
> > 
> >    +--------+----------------+--------+-------- |  p0    |       p1
> >    |   p0   |   p1 +--------+----------------+--------+--------
> >    ^  ^                 ^      ^ ^ |  |                 |      | | |  |                 |      | Fails
> >    to hold the lock holds lock        releases lock | and proxy execs for
> >    p0 again |                        | |                        | tries to
> >    hold lock         holds lock again proxy execs for p0
> > 
> > The notion of priority in CFS as it stands doesn't help in providing any
> > guarantees in who will be able to hold the lock next. I haven't looked at
> > the patches closely, so this might be handled already. I think the
> > situation will be worse if there're more tasks contending for the lock.
> > Priority will influences the chances, but the end result who holds the lock
> > next is effectively random, AFAICT.
> 
> The wake up during unlock is FIFO order of waiters though. So that’s
> deterministic.

Deterministic in respecting the order the lock was held. But not deterministic
in terms of the priority of the tasks in that order. IOW, that order is based
on time rather than priority.

Say we have 4 CFS tasks, 3 are priority 0 and one is priority -19. If the
3 tasks @prio_0 try to hold the lock before the one @prio_-19; then the FIFO
order means the higher priority one will be the last to get the lock. And the
other tasks - depending how long they hold the lock for - could cause the
@prio_-19 task to run as a proxy for multiple slices first. Which is the
potential problem I was trying to highlight. The @prio_-19 task will not
appear to have been starved for multiple slices since it runs; but as
a proxy.

Again, maybe there's a devilish detail in the patches that addresses that and
it's not really a problem.

> 
> > I had a conversation once with an app developer who came from iOS world and
> > they were confused why their higher priority task is not preempting the
> > lower priority one when they ported it to Android.
> > 
> > I wonder sometimes if we need to introduce a true notion of priority for
> > CFS.  I don't see why an app developer who would like to create 3 tasks and
> > give them strict priority order relative to each others can't do that. At
> > the moment they have little option in controlling execution order.
> 
> I want to talk more about this with you, I am actually working on something
> similar. Let’s talk ;)

Oh. Yes, let us talk! :-)


Cheers

--
Qais Yousef
