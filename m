Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A1568A234
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjBCSrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjBCSrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:47:15 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CEF9D5A4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:47:14 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id j21so4937936oie.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 10:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zGzgsd+21G+envIJlNRx5y9NhgSp6TVSN947NkGcDoU=;
        b=Zys9UuFgbs5lFCJjTVpbZ+9mU4XMeIXJD7J5i83+FTKbduuV0z5gbKI1zNXth8J3Ig
         9OieKh0UeUbYpR5fMMo5857ITLXDQXoVnJGjwWLKt3y+ItiYbqbS8l9E3R1ZZ6v1s4BQ
         ff/KEvQ+xLtaLLYsCi8/34e7BsT10RePYvzGRomTwI5yjyAUsAUezEHnJ+XLddyIms9Z
         BAmwL+/JH3b2TWPdbrH+va8sPyLbW+cqPvYcYJL95tBw9uG8CgKGyacrhAhsfE+bwX2/
         gEMLV3IJBRGGF0nUFXYeLqlLANHgxkRlYZdsme13OQ41K8c96zJfLuv3/KTWidCPPlgo
         dGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGzgsd+21G+envIJlNRx5y9NhgSp6TVSN947NkGcDoU=;
        b=wFOHzR7K2y20jan4t2QG9sC3Qs0EECJQKK2LKWArhBqC/VknYvMi9VTmMFVMrzkdrR
         U22Nhpqfeibo8xtcJa6WrqFmsIwD0HAD3LJXreV2on+oZUL+U1ZxwLZLi8EFK3Ld607N
         jHffROjATJ4aS66xYM9Ps8lsnvXzdgI3UdqrwHv6C7OVuXhHasL1qoH3Yrqon3VSsDHz
         OJFHfILYMn+8BDy4qU+KjJC6hFf36PpRNV0HlojFsrdUHpeTDdAPkjw5dRfOoLlhMWaK
         s4v7/1AxxqUBnBP4NzQk/riKuEsKXCK8/+rbEhGoeOLqWukDWd+NkOS9GffVRBCSQH3v
         k+MQ==
X-Gm-Message-State: AO0yUKWUeg3auMYOgoL4bCDt0+Ur1xvmZer6XqY+JPzzUozjIUiCZ7xR
        QLi71BIu/Swlp5w28ZzdDjZMzxYJ1EHjefkTba2OHA==
X-Google-Smtp-Source: AK7set9mhGy7e3QXRzMk/FLsY/CqOQwSMhuyH7EcoU1Eacrih382m5f/4VfIzl0Tkj2qGxwjD2UR1m6mCmdTNn9aDYg=
X-Received: by 2002:a05:6808:2c6:b0:367:eed:a770 with SMTP id
 a6-20020a05680802c600b003670eeda770mr525327oid.282.1675450033511; Fri, 03 Feb
 2023 10:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20230201012032.2874481-1-xii@google.com> <Y9zZDcIua63WOdG7@hirez.programming.kicks-ass.net>
In-Reply-To: <Y9zZDcIua63WOdG7@hirez.programming.kicks-ass.net>
From:   Xi Wang <xii@google.com>
Date:   Fri, 3 Feb 2023 10:47:01 -0800
Message-ID: <CAOBoifgz0pRCBUqo7+X2BKgSuHmQLB6X0LZ9D2eYvboO5yzybg@mail.gmail.com>
Subject: Re: [PATCH] sched: Consider capacity for certain load balancing decisions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 1:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 31, 2023 at 05:20:32PM -0800, Xi Wang wrote:
> > After load balancing was split into different scenarios, CPU capacity
> > is ignored for the "migrate_task" case, which means a thread can stay
> > on a softirq heavy cpu for an extended amount of time.
> >
> > By comparing nr_running/capacity instead of just nr_running we can add
> > CPU capacity back into "migrate_task" decisions. This benefits
> > workloads running on machines with heavy network traffic. The change
> > is unlikely to cause serious problems for other workloads but maybe
> > some corner cases still need to be considered.
> >
> > Signed-off-by: Xi Wang <xii@google.com>
> > ---
> >  kernel/sched/fair.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0f8736991427..aad14bc04544 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10368,8 +10368,9 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >                       break;
> >
> >               case migrate_task:
> > -                     if (busiest_nr < nr_running) {
> > +                     if (busiest_nr * capacity < nr_running * busiest_capacity) {
> >                               busiest_nr = nr_running;
> > +                             busiest_capacity = capacity;
> >                               busiest = rq;
> >                       }
> >                       break;
>
> I don't think this is correct. The migrate_task case is work-conserving,
> and your change can severely break that I think.
>

I think you meant this kind of scenario:
cpu 0: idle
cpu 1: 2 tasks
cpu 2: 1 task but only has 30% of capacity
Pulling from cpu 2 is good for the task but lowers the overall cpu
throughput.

The problem we have is:
cpu 0: idle
cpu 1: 1 task
cpu 2: 1 task but only has 60% of capacity due to net softirq
The task on cpu 2 stays there and runs slower. (This can also be
considered non work-conserving if we account softirq like a task.)

Maybe the logic can be merged like this: Use capacity but pick from
nr_running > 1 cpus first, then nr_running == 1 cpus if not found.
