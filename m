Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA562B11A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiKPCKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiKPCKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:10:24 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A9D31DDD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:10:22 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so9641142oti.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1vQRmL6xrabMaTtvG80s+x/OnyTul5p+4VRYabeP/d0=;
        b=ia2GvAaDCbcUd1VQQgz/7Bk9z/XZ/JHY7NtGPmuq4qEBrdrDo9QR6/6nHT7j+7wSsE
         8ndvd1+x0/Hm5LrQ/wEATZme76DDnRSvnBwQnBBKVcXEyKEfp0aORFGvsSdDqj5eCXAV
         s7RMv0Q8y5PCgVTFARZusGkHQV3PovpHR5+Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vQRmL6xrabMaTtvG80s+x/OnyTul5p+4VRYabeP/d0=;
        b=ntiY7jYZ228VyW+6hSqn10XUw3qgS5GkP6cWfjUV1aM6Z9j2HTC1lEfxb9Y/cn5ACg
         0BAtyIu523LelaYzlcNHwTwQBUF4EZgtqZ61jHpOgWpPtXG1VebcEhDD4sCueuoc2QJo
         hcwTS5uOa2ECUgfdGFOaPf37iozV4HlwYHuW3KkJjMTkG3g/M6KYxzgcaW4aEo2IpdFj
         bULOOP1iA3HuF14JALuueZ6vsm0oZd4qHTb3+xhUiPEhcKVgXQPOCqcTBht48aO27OoK
         8587Ma2ifKBZaqKltCKFWEhv8pO4xnPY1d0WvGmLc5BysKENMzSUO01y6AtO1NFqeX2I
         7aug==
X-Gm-Message-State: ANoB5pn2JTKO1dnrDnGgf1DmKDsNCO6TsyyttC0Ocs7ypKN5WFdW8Lu2
        RiOOqK2FH2leXN4mmBlfeW03JLtqUhBntmoT00QbAw==
X-Google-Smtp-Source: AA0mqf6L2nQ5jc2hHpbabisEzFELrw4UbctuzcrHHYsU+30Jc18CibI8JqeNnXvLSZXCRoTsExyRaSSrLvqJgHoBSBc=
X-Received: by 2002:a9d:188:0:b0:66d:3e45:8e5a with SMTP id
 e8-20020a9d0188000000b0066d3e458e5amr9963372ote.177.1668564621931; Tue, 15
 Nov 2022 18:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-2-vincent.guittot@linaro.org> <Y3Gwr2p5BcofuZ8e@google.com>
 <CAKfTPtD2A3QaMON_jkhaobY0Wy+LpnAnfhtuaozK_OkmSvuf8Q@mail.gmail.com>
In-Reply-To: <CAKfTPtD2A3QaMON_jkhaobY0Wy+LpnAnfhtuaozK_OkmSvuf8Q@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 16 Nov 2022 02:10:11 +0000
Message-ID: <CAEXW_YTaG_TzY9r7Q297R1C7S4FzOopzQA-xRKU_JFKOVRA6hA@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] sched/fair: fix unfairness at wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, riel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Mon, Nov 14, 2022 at 11:05 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
[...]
> >
> > On Thu, Nov 10, 2022 at 06:50:01PM +0100, Vincent Guittot wrote:
> > > At wake up, the vruntime of a task is updated to not be more older than
> > > a sched_latency period behind the min_vruntime. This prevents long sleeping
> > > task to get unlimited credit at wakeup.
> > > Such waking task should preempt current one to use its CPU bandwidth but
> > > wakeup_gran() can be larger than sched_latency, filter out the
> > > wakeup preemption and as a results steals some CPU bandwidth to
> > > the waking task.
> >
> > Just a thought: one can argue that this also hurts the running task because
> > wakeup_gran() is expected to not preempt the running task for a certain
> > minimum amount of time right?
>
> No because you should not make wakeup_gran() higher than sched_latency.
>
> >
> > So for example, if I set sysctl_sched_wakeup_granularity to a high value, I
> > expect the current task to not be preempted for that long, even if the
> > sched_latency cap in place_entity() makes the delta smaller than
> > wakeup_gran(). The place_entity() in current code is used to cap the sleep
> > credit, it does not really talk about preemption.
>
> But one should never set such nonsense values.

It is not about the user setting nonsense sysctl value. Even if you do
not change sysctl_sched_wakeup_granularity, wakeup_gran() can be large
due to NICE scaling.
wakeup_gran() scales the sysctl by the ratio of the nice-load of the
se, with the NICE_0_LOAD.

On my system, by default sysctl_sched_wakeup_granularity is 3ms, and
sysctl_sched_latency is 18ms.

However, if you set the task to nice +10, the wakeup_gran() scaling
can easily make the gran exceed sysctl_sched_latency. And also, just
to note (per my experience) sysctl_sched_latency does not really hold
anyway when nice values are not default. IOW, all tasks are not
guaranteed to run within the sched_latency window always.

Again, like I said I don't mind this change (and I think it is OK to
do) but I was just preparing you/us for someone who might say they
don't much like the aggressive preemption.

> > I don't mind this change, but it does change the meaning a bit of
> > sysctl_sched_wakeup_granularity I think.
> >
> > > Make sure that a task, which vruntime has been capped, will preempt current
> > > task and use its CPU bandwidth even if wakeup_gran() is in the same range
> > > as sched_latency.
> >
> > nit: I would prefer we say, instead of "is in the same range", "is greater
> > than". Because it got confusing a bit for me.
>
> I prefer keeping current description because the sentence below gives
> the reason why it's not strictly greater than

Honestly saying "is in the same range" is ambiguous and confusing. I
prefer the commit messages to be clear, but I leave it up to you.

> > Just a few more comments below:
[...]
> > > +
> > > +     /*
> > > +      * At wake up, the vruntime of a task is capped to not be older than
> > > +      * a sched_latency period compared to min_vruntime. This prevents long
> > > +      * sleeping task to get unlimited credit at wakeup. Such waking up task
> > > +      * has to preempt current in order to not lose its share of CPU
> > > +      * bandwidth but wakeup_gran() can become higher than scheduling period
> > > +      * for low priority task. Make sure that long sleeping task will get a
> > > +      * chance to preempt current.
> > > +      */
> > > +     gran = min_t(s64, gran, get_latency_max());
> > > +
> >
> > Can we move this to wakeup_gran(se)? IMO, it belongs there because you are
> > adjusting the wakeup_gran().
>
> I prefer keep current code because patch 8 adds offset in the equation

Ack.

> > >       if (vdiff > gran)
> > >               return 1;
> > >
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index 1fc198be1ffd..14879d429919 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -2432,9 +2432,9 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
> > >  extern const_debug unsigned int sysctl_sched_nr_migrate;
> > >  extern const_debug unsigned int sysctl_sched_migration_cost;
> > >
> > > -#ifdef CONFIG_SCHED_DEBUG
> > >  extern unsigned int sysctl_sched_latency;
> > >  extern unsigned int sysctl_sched_min_granularity;
> > > +#ifdef CONFIG_SCHED_DEBUG
> > >  extern unsigned int sysctl_sched_idle_min_granularity;
> > >  extern unsigned int sysctl_sched_wakeup_granularity;
> > >  extern int sysctl_resched_latency_warn_ms;
> > > @@ -2448,6 +2448,34 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
> > >  extern unsigned int sysctl_numa_balancing_scan_size;
> > >  #endif
> > >
> > > +static inline unsigned long  get_sched_latency(bool idle)
> > > +{
> >
> > IMO, since there are other users of sysctl_sched_latency, it would be better
> > to call this get_max_sleep_credit() or something.
>
> get_sleep_latency()

Ack.

> >
> > > +     unsigned long thresh;
> > > +
> > > +     if (idle)
> > > +             thresh = sysctl_sched_min_granularity;
> > > +     else
> > > +             thresh = sysctl_sched_latency;
> > > +
> > > +     /*
> > > +      * Halve their sleep time's effect, to allow
> > > +      * for a gentler effect of sleepers:
> > > +      */
> > > +     if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > > +             thresh >>= 1;
> > > +
> > > +     return thresh;
> > > +}
> > > +
> > > +static inline unsigned long  get_latency_max(void)
> > > +{
> > > +     unsigned long thresh = get_sched_latency(false);
> > > +
> > > +     thresh -= sysctl_sched_min_granularity;
> >
> > Could you clarify, why are you subtracting sched_min_granularity here? Could
> > you add some comments here to make it clear?
>
> If the waking task failed to preempt current it could to wait up to
> sysctl_sched_min_granularity before preempting it during next tick.

Ok, makes sense, thanks.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

 - Joel
