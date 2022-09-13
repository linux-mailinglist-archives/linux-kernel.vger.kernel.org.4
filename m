Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3654C5B69EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiIMIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiIMIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:54:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C4C578B4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:54:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z25so18993669lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7lRCXb3a6WmUpEh3zs0uWMm1tjdYcQA5tCTGxYDGUB0=;
        b=sYzCvHCjIw8U+d5BnGTNcIPkYj7C5qsJ09OyPs0s62VKm0kYhLVSmGiE/UmSxJM8eM
         y+E2wFiuvkcehqr3+UtB1ynjmwAm+XVKUZvElN4uhfBZ8K7iU+NYmaCtVVYH7gplDTKt
         X63n3kUV9EkkzrawWuD00UbCU6anboJ02KcG8JDVR9Xe/rvMWQEMiAx/E9Q5jzSUXoxc
         CkX0VeYGHkYypVlndJykBWdUxEopSwncyKI0XhYVYZDUJTHUuQhoLwsmEBraYr6rby2b
         n4lp/FE9AmNByh4VhsklNRjOkDA6ULf3WjiMGlZ+/nXlsOt8zU9TgMxYrBVBEjkUqvHe
         Svpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7lRCXb3a6WmUpEh3zs0uWMm1tjdYcQA5tCTGxYDGUB0=;
        b=5h3Sm+/qeEjHP6Q3CumnjfKlaHK9dg6M+uDbUGSL4bJlElYLAUmrentMG+x2gv0MT5
         gFjn1aGDOMGiKWg0sxpLryFHv3TA7cULWBC/FH9y3FP/BU+gxkfYc1aKvSQCDStzcU0P
         YLqXvU2gfeyzudTcmFpDynVKwmChNzGbAfj2ZnUt3F8t9piAj9YGzd6YtayfL+vD2DLX
         HI/7mEpY/KS4e3jVkic+8ZFLnd+c0Cf6CNQNh7qfv6V7Ddt+xeUBNh5gCZYfw9XV5wtK
         Iv+PxLHCnVjJVj/widrV5TpC2aI93randbxcHbv/63qSlFdSZuQ7CJ586XVgvr8786zY
         BXfw==
X-Gm-Message-State: ACgBeo3yABalNQHdarpnDaLzsWHGVdIJHnVl9HAUdd/X3WJp+ldjNlVA
        3RIydJMR/5zDtWw5bITKiojpuBJvBZuKNIKYewuMGw==
X-Google-Smtp-Source: AA6agR6pDGNcz+UOEksS5d8E5NMp4tuRJCPPibMYOpiTkKcnLs3VdzzOhgMH303duakdX6SnMy8tO54eR8tDZy2aSYs=
X-Received: by 2002:a05:6512:3f0f:b0:498:fad9:db0d with SMTP id
 y15-20020a0565123f0f00b00498fad9db0dmr6251966lfa.46.1663059256103; Tue, 13
 Sep 2022 01:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-2-vincent.guittot@linaro.org> <b85e608f-7293-9588-5e85-36b62f1fdbeb@arm.com>
In-Reply-To: <b85e608f-7293-9588-5e85-36b62f1fdbeb@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 13 Sep 2022 10:54:03 +0200
Message-ID: <CAKfTPtCo-JPuDQ973FrQrjpK8wG-3TSJ9Z+=Loj6Zr-mjtuz1A@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: make sure to try to detach at least one
 movable task
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sept 2022 at 10:44, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 25/08/2022 14:27, Vincent Guittot wrote:
>
> s/sched/fair: make/sched/fair: Make
>
> > During load balance, we try at most env->loop_max time to move a task.
> > But it can happen that the loop_max LRU tasks (ie tail of
> > the cfs_tasks list) can't be moved to dst_cpu because of affinity.
> > In this case, loop in the list until we found at least one.
> >
> > The maximum of detached tasks remained the same as before.
>
> Not sure how this relates to the patch? Isn't this given by the
> `env->imbalance <= 0` check at the end of detach_tasks()?

The number of detached tasks can't be higher than  loop_max in
detached_tasks() and it remains the same with this patch as we will
continue to loop only if we didn't find task that can move to the cpu

>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index da388657d5ac..02b7b808e186 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8052,8 +8052,12 @@ static int detach_tasks(struct lb_env *env)
> >               p = list_last_entry(tasks, struct task_struct, se.group_node);
> >
> >               env->loop++;
> > -             /* We've more or less seen every task there is, call it quits */
> > -             if (env->loop > env->loop_max)
> > +             /*
> > +              * We've more or less seen every task there is, call it quits
>
> I never understood this `more or less`. Either we have seen all tasks or
> not?
>
> > +              * unless we haven't found any movable task yet.
> > +              */
> > +             if (env->loop > env->loop_max &&
> > +                 !(env->flags & LBF_ALL_PINNED))
> >                       break;
> >
> >               /* take a breather every nr_migrate tasks */
> > @@ -10182,7 +10186,9 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >
> >               if (env.flags & LBF_NEED_BREAK) {
> >                       env.flags &= ~LBF_NEED_BREAK;
> > -                     goto more_balance;
> > +                     /* Stop if we tried all running tasks */
>
> Would say s/running/runnable but I see that we do use running/runnable
> interchangeably.
>
> > +                     if (env.loop < busiest->nr_running)
> > +                             goto more_balance;
> >               }
> >
> >               /*
>
> IMHO, there will be some interaction with the `All tasks on this
> runqueue were pinned by CPU affinity` check at the end of load_balance()?
