Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800206731EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjASGqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjASGpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:45:49 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D7A113D0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:45:47 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id o15so743292ill.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6sTCLpDfWanX092MW4dJXLzK/mWMkMytgwQHyJONkyc=;
        b=cvu94+9rjQXdGtNgmCZaYwOtoANjZH8PpeSWpzmwiT1IoBzGbjqlkHBBH6xXi3I3Y7
         +UI3PZML8ECCE7/lKg5I094IVxzSKCOQ+s/SE5WYqVQX1jRuwRijP32ihnkkxOsHu+LC
         KB017UT3+43+LXwtcDeADAoePzsJz2S5FEpdxup+fJeyqFbL/rzSqXV65tra9uYjZ/gi
         89kBOEiWubJHTGGLM3g3vWTx5iGWhBQOzu9RORWTTuDHeIcG0M8FV9cYvpdoJTLyYozg
         6MzoKa1SHrtmKzFL5cg+QpD82xuxp2WY+0oSS1H11rItLoIdsIykTYlMn7WO4IVG7hPu
         /obA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sTCLpDfWanX092MW4dJXLzK/mWMkMytgwQHyJONkyc=;
        b=kYDZlBaZ/5beIQHHPkPH9WFwV137KmHIUMsUq4YPt3mRIRpGa3TusewKucwzRvh0ME
         Bqc3L+pNNu3AdPS4PGcoU8+jFG2KAqMipoZwysTpRDCEtQn1ow7YjYBaAMHE7fMYRh08
         8iGTVUK5N+XyAWrt6JVj4eRZLO5JgIlLTzBnF6coFPVPbP5vfnxjJiAGLXKiHgcs1yY3
         cH83i3nHTDl87L95SCxZv85fACdtAB5ReEZjILx4Ho+lylOdx+n4VamwzWaqlxvrgojn
         OMNTGrbvyjWg3R4Gziqhbm0LEKpEh0LB2pSol4Z72AYS1KYX5idPpeBswjhZ1Nxklc+1
         tevQ==
X-Gm-Message-State: AFqh2kqzAt+XltIemlIJICr37oX1O2fE47SNrfmyKbpCQlKKDdv4+Bdz
        n03JWwjegpMd9zfGvEb2w79BwBrm7XIeijepvnU=
X-Google-Smtp-Source: AMrXdXvpfD9wOgyju075DoeCrH/VhdqoRQTfmyqYyXyncsyKhbLMbW/avsfQ0ZtteRktC+m0AwVkHeWueou1BGI7dAs=
X-Received: by 2002:a92:2907:0:b0:30f:a7:1d84 with SMTP id l7-20020a922907000000b0030f00a71d84mr871361ilg.315.1674110747081;
 Wed, 18 Jan 2023 22:45:47 -0800 (PST)
MIME-Version: 1.0
References: <20230110213010.2683185-1-avagin@google.com> <20230110213010.2683185-4-avagin@google.com>
 <Y8UgBnsaGDUJKH5A@hirez.programming.kicks-ass.net>
In-Reply-To: <Y8UgBnsaGDUJKH5A@hirez.programming.kicks-ass.net>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Wed, 18 Jan 2023 22:45:33 -0800
Message-ID: <CANaxB-z9e2n-TTm7BZDCiv-juoPe2sao078G_imJz+aBkLzm4Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched: add a few helpers to wake up tasks on the
 current cpu
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrei Vagin <avagin@google.com>, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 1:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 10, 2023 at 01:30:08PM -0800, Andrei Vagin wrote:
>
> > diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> > index d57a5c1c1cd9..a1931a79c05a 100644
> > --- a/kernel/sched/completion.c
> > +++ b/kernel/sched/completion.c
> > @@ -38,6 +38,18 @@ void complete(struct completion *x)
> >  }
> >  EXPORT_SYMBOL(complete);
> >
> > +void complete_on_current_cpu(struct completion *x)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&x->wait.lock, flags);
> > +
> > +     if (x->done != UINT_MAX)
> > +             x->done++;
> > +     swake_up_locked_on_current_cpu(&x->wait);
> > +     raw_spin_unlock_irqrestore(&x->wait.lock, flags);
> > +}
> > +
> >  /**
> >   * complete_all: - signals all threads waiting on this completion
> >   * @x:  holds the state of this particular completion
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 6478e819eb99..c81866821139 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6874,7 +6874,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
> >  int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
> >                         void *key)
> >  {
> > -     WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
> > +     WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~(WF_SYNC|WF_CURRENT_CPU));
> >       return try_to_wake_up(curr->private, mode, wake_flags);
> >  }
> >  EXPORT_SYMBOL(default_wake_function);
> > diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
> > index 76b9b796e695..9ebe23868942 100644
> > --- a/kernel/sched/swait.c
> > +++ b/kernel/sched/swait.c
> > @@ -31,6 +31,17 @@ void swake_up_locked(struct swait_queue_head *q)
> >  }
> >  EXPORT_SYMBOL(swake_up_locked);
> >
> > +void swake_up_locked_on_current_cpu(struct swait_queue_head *q)
> > +{
> > +     struct swait_queue *curr;
> > +
> > +     if (list_empty(&q->task_list))
> > +             return;
> > +
> > +     curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
> > +     try_to_wake_up(curr->task, TASK_NORMAL, WF_CURRENT_CPU);
> > +     list_del_init(&curr->task_list);
> > +}
> >  /*
> >   * Wake up all waiters. This is an interface which is solely exposed for
> >   * completions and not for general usage.
> > diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> > index 133b74730738..47803a0b8d5d 100644
> > --- a/kernel/sched/wait.c
> > +++ b/kernel/sched/wait.c
> > @@ -161,6 +161,11 @@ int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
> >  }
> >  EXPORT_SYMBOL(__wake_up);
> >
> > +void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
> > +{
> > +     __wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
> > +}
> > +
> >  /*
> >   * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
> >   */
>
> So I hate this patch, it adds a whole ton of duplication and litter for
> no real reason afaict. For instance you could've just added an
> wake_flags argument to swake_up_locked(), there's not *that* many users
> -- unlike complete().
>
> And for complete() instead of fully duplicating the function (always a
> bad idea) you could've made complete_flags() and implemented complete()
> using that, or something.
>
> Anyway, let me go (finally) have a look at Chen's patch, since that
> might render all this moot.

If it is the only concern, it is easy to fix. I think I decided to do it
this way because swake_up_locked is in include/linux/swait.h, but wakeup
flags are in kernel/sched/sched.h. I agree that it is better to avoid
this code duplication.

Regarding Chen's proposed patch, unfortunately, it does not solve our
problem. It works only in narrow conditions. One of the major problems
is that it does nothing if there are idle cores. The advantage of my
changes is that they work predictably, and they provide benefits
regardless of other workloads running on the same host.

Thanks,
Andrei
