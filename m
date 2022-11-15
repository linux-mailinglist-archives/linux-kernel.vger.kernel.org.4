Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB34F629268
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiKOH0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKOH0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:26:18 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA2D140A4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:26:16 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q21so10052173iod.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cJTZTXp7og1KH8z2IIKHyt+zJnB2R2JNN6SCGE02uYA=;
        b=QhWTisUX6RYqf4tKnHwC71ICZ8NhNKTSld8Oqb8YI9AeOj/lkmbf/efLn10q1EQJr4
         ntelzkh+UUYW2E7mYCwD0J0rW9+N/ao3qk/nPelX0abhnpgftiukJt2RGHBO0V1+b/KB
         g0U0vbEtvp50ZPJP+6KcV8f43LjIciSF4Csx7UMFg655X3VKB8OzrIv9V2b2TdVssnzi
         VSSSedKhenOdfejBfipET9Bsr5Xuz/DYMoevDgrnQg859OKsdsWYJp7RArbtBU1LuhPd
         k7otZM1UBSBRGIgMe8yLIlmwODo8Z4dmqltW2+nyHRAK82p0DObocyttYHQ+kpJNTGS6
         j8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJTZTXp7og1KH8z2IIKHyt+zJnB2R2JNN6SCGE02uYA=;
        b=6cuHqChAemPzw339YkC3DmF00ISCo9BwMclAWlE4NOBDRQxAqL/Qjjw6UxsL8Av0n4
         2k2/ylKcL5nAITdxRSN4XaRZiBCUn+8pnjer11HCSXROINgRKs7SJYTh4vCe0aIAPLmp
         x9BrokNjzN/bYaap/AUkHBSj7kCXEfO1i18ZCClb3F1WyYcFEZK4Hex7i1KKyfaKPsyb
         BFL7tnPXmyKPCgf19y7uibjZqt8ZdL8gKSTzmdwBgPHB10sr1C4LM9GfdPXbk9/mv649
         n6xvtKsT2JFVuKnSK44layOGZEIRvFIj0x6+BLXnyJI6HIEqXQYuaDPy1edO7Lnfbzvs
         qmAw==
X-Gm-Message-State: ANoB5ploc/pjK6WDJ9zekGFyDNEq3cxw4iN2KMBVLz5HDCk5JQQy4AJ8
        pu6qU2D0fQbhZEVzRvp97FPKMMqbgk0tgjABV1VuQQ==
X-Google-Smtp-Source: AA0mqf4y4hDGcSKE+EOhPI6PzQmz73Ni6PycLyGcm2CJJrcwIkh9GHmAJQyU7ziJsLft56JaFg6g8eKASghoYhcjSU0=
X-Received: by 2002:a6b:6401:0:b0:6bc:a758:9546 with SMTP id
 t1-20020a6b6401000000b006bca7589546mr7022642iog.78.1668497176241; Mon, 14 Nov
 2022 23:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-2-vincent.guittot@linaro.org> <32f4a76d-103e-510f-de70-ba9dfe2356ce@arm.com>
In-Reply-To: <32f4a76d-103e-510f-de70-ba9dfe2356ce@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Nov 2022 08:26:05 +0100
Message-ID: <CAKfTPtC5f7jfz+=rLQp_gjaEqGQ=9B-4aX-4urZP6CPVEf1LwA@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] sched/fair: fix unfairness at wakeup
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 at 20:13, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 10/11/2022 18:50, Vincent Guittot wrote:
> > At wake up, the vruntime of a task is updated to not be more older than
> > a sched_latency period behind the min_vruntime. This prevents long sleeping
> > task to get unlimited credit at wakeup.
> > Such waking task should preempt current one to use its CPU bandwidth but
> > wakeup_gran() can be larger than sched_latency, filter out the
> > wakeup preemption and as a results steals some CPU bandwidth to
> > the waking task.
> >
> > Make sure that a task, which vruntime has been capped, will preempt current
> > task and use its CPU bandwidth even if wakeup_gran() is in the same range
> > as sched_latency.
>
> Looks like that gran can be nuch higher than sched_latency for extreme
> cases?

It's not that extreme, all tasks with nice prio 5 and above will face
the problem

>
> >
> > If the waking task failed to preempt current it could to wait up to
> > sysctl_sched_min_granularity before preempting it during next tick.
> >
> > Strictly speaking, we should use cfs->min_vruntime instead of
> > curr->vruntime but it doesn't worth the additional overhead and complexity
> > as the vruntime of current should be close to min_vruntime if not equal.
>
> ^^^ Does this related to the `if (vdiff > gran) return 1` condition in
> wakeup_preempt_entity()?

yes

>
> [...]
>
> > @@ -7187,6 +7171,18 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
> >               return -1;
> >
> >       gran = wakeup_gran(se);
> > +
> > +     /*
> > +      * At wake up, the vruntime of a task is capped to not be older than
> > +      * a sched_latency period compared to min_vruntime. This prevents long
> > +      * sleeping task to get unlimited credit at wakeup. Such waking up task
> > +      * has to preempt current in order to not lose its share of CPU
> > +      * bandwidth but wakeup_gran() can become higher than scheduling period
> > +      * for low priority task. Make sure that long sleeping task will get a
>
> low priority task or taskgroup with low cpu.shares, right?

yes

>
> 6 CPUs
>
> sysctl_sched
>   .sysctl_sched_latency              : 18.000000
>   .sysctl_sched_min_granularity      : 2.250000
>   .sysctl_sched_idle_min_granularity : 0.750000
>   .sysctl_sched_wakeup_granularity   : 3.000000
>   ...
>
> p1 & p2 affine to CPUX
>
>      '/'
>      /\
>    p1  p2
>
> p1 & p2 nice=0        - vdiff=9ms gran=3ms lat_max=6.75ms
> p1 & p2 nice=4        - vdiff=9ms gran=7.26ms lat_max=6.75ms

p1 & p2 nice = 5        - vdiff=9ms gran=9.17ms lat_max=6.75ms

> p1 & p2 nice=19       - vdiff=9ms gran=204.79ms lat_max=6.75ms
>
>
>      '/'
>      /\
>     A  B
>    /    \
>   p1    p2
>
> A & B cpu.shares=1024 - vdiff=9ms gran=3ms lat_max=6.75ms
> A & B cpu.shares=448  - vdiff=9ms gran=6.86ms lat_max=6.75ms
> A & B cpu.shares=2    - vdiff=9ms gran=1536ms lat_max=6.75ms
>
> > +      * chance to preempt current.
> > +      */
> > +     gran = min_t(s64, gran, get_latency_max());
> > +
>
> [...]
>
> > @@ -2448,6 +2448,34 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
> >  extern unsigned int sysctl_numa_balancing_scan_size;
> >  #endif
> >
> > +static inline unsigned long  get_sched_latency(bool idle)
>                               ^^
> 2 white-spaces

ok

>
> [...]
>
> > +
> > +static inline unsigned long  get_latency_max(void)
>                               ^^

ok

>
> [...]
