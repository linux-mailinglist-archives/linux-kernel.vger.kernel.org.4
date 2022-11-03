Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3162617905
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiKCIqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCIqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:46:49 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EB3D104
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 01:46:48 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n191so760683iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iVznVwjNnxmxkHGi35RNXtQvHg4FnNzn0yY5sswcfEQ=;
        b=n8BgjwSbklE3TACcByaFnSkBYihCZBp+TQoUWXKqdp/3WQll+OidmszrdxQBbt4kBm
         9SBrsiNRT45O2auOPOU7XdmVnZSTfs8MYjvt2gQQsoGVdz6zJWs2R1+QeYyTecj5fiek
         Q/hiJK15sFvzBiwk4y6YGHLA+0Usb7446L47908c8vJGBqTVFfG8tl5OhTXpHkllZPca
         8bWJXOJBzS97d2ODew8RQ1l2RC6vQMfuy3XIJ0f0+KDb9u/9lZoTpESXwbYLBHfWKd+n
         /tc+SjRrw8EQF+/+u2El75tCu5oSOXfFog8AMitNe+hKz6UbW10NP5C9LXyiz4wbBx3y
         nQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVznVwjNnxmxkHGi35RNXtQvHg4FnNzn0yY5sswcfEQ=;
        b=HV9d3aErXxHv8p2twl2hf6gLQAgXndJa9xNX2oOn1A7fKj9bfd6uAPhyufXPX4MrWs
         +LZz0zS5jK5+SFJYFagNTjEAS4y6bbx57OFQT9BFuTx3ZjqBjTo/kizBrW5vi5kZlX8+
         6pRxaBBeHyYY3ziYSMO3w7HGR2D+EkbxKxXCiYq/J8QzIY+1HbQxrf8aYK79pwaPwqFS
         ZxgOX7mbtg0sap2P5IYdz1uidV/tWNTnaRkhp3Yq1b67t7PoRnIYVUxmL662ro/yJIfd
         Z4++XRJt4K+dRMMb+AwFvRxSkxRXqw5JSPDkc7flwif9VJoeBnLpaQvuCQcUlsjJmw3m
         e+yg==
X-Gm-Message-State: ACrzQf1uMUGscoTE5qU3iQ/fyw8CX3rrGFHnmuuQeGixEFTBYDax2rjn
        Qdukc5Ms1u+8iLBf4IdCk0HBb6gPm2yVqy41RPtb2A==
X-Google-Smtp-Source: AMsMyM4vdDJc1zgDhdTKbfkt9mj0Jppu1YDS/iPAksMERWVidTDuWO7iNxLuc1sr+W2ZClV4CUfs3xXLlw460I+NTBw=
X-Received: by 2002:a05:6602:2f02:b0:6a4:5b5d:9dbb with SMTP id
 q2-20020a0566022f0200b006a45b5d9dbbmr18342864iow.32.1667465207697; Thu, 03
 Nov 2022 01:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org> <20221101192848.pjns3um7dnrwrk5p@airbuntu>
In-Reply-To: <20221101192848.pjns3um7dnrwrk5p@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 3 Nov 2022 09:46:36 +0100
Message-ID: <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
To:     Qais Yousef <qyousef@layalina.io>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
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

On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 10/28/22 11:34, Vincent Guittot wrote:
> > Task can set its latency priority with sched_setattr(), which is then used
> > to set the latency offset of its sched_enity, but sched group entities
> > still have the default latency offset value.
> >
> > Add a latency.nice field in cpu cgroup controller to set the latency
> > priority of the group similarly to sched_setattr(). The latency priority
> > is then used to set the offset of the sched_entities of the group.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> >  kernel/sched/core.c                     | 52 +++++++++++++++++++++++++
> >  kernel/sched/fair.c                     | 33 ++++++++++++++++
> >  kernel/sched/sched.h                    |  4 ++
> >  4 files changed, 97 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index be4a77baf784..d8ae7e411f9c 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
> >          values similar to the sched_setattr(2). This maximum utilization
> >          value is used to clamp the task specific maximum utilization clamp.
> >
> > +  cpu.latency.nice
> > +     A read-write single value file which exists on non-root
> > +     cgroups.  The default is "0".
> > +
> > +     The nice value is in the range [-20, 19].
> > +
> > +     This interface file allows reading and setting latency using the
> > +     same values used by sched_setattr(2).
>
> I'm still not sure about this [1].

I'm still not sure about what you are trying to say here ...

This is about setting a latency nice prio to a group level.

>
> In some scenarios we'd like to get the effective latency_nice of the task. How
> will the task inherit the cgroup value or be impacted by it?
>
> For example if there are tasks that belong to a latency sensitive cgroup; and
> I'd like to skip some searches in EAS to improve that latency sensitivity - how
> would I extract this info in EAS path given these tasks are using default
> latency_nice value? And if should happen if their latency_nice is set to
> something else other than default?
>
> [1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@wubuntu/

Hmm so you are speaking about something that is not part of the patch.
Let focus on the patchset for now

>
>
> Thanks
>
> --
> Qais Yousef
>
> >
> >
> >  Memory
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index caf54e54a74f..3f42b1f61a7e 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -10890,6 +10890,47 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
> >  {
> >       return sched_group_set_idle(css_tg(css), idle);
> >  }
> > +
> > +static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
> > +                                 struct cftype *cft)
> > +{
> > +     int prio, delta, last_delta = INT_MAX;
> > +     s64 weight;
> > +
> > +     weight = css_tg(css)->latency_offset * NICE_LATENCY_WEIGHT_MAX;
> > +     weight = div_s64(weight, get_sched_latency(false));
> > +
> > +     /* Find the closest nice value to the current weight */
> > +     for (prio = 0; prio < ARRAY_SIZE(sched_latency_to_weight); prio++) {
> > +             delta = abs(sched_latency_to_weight[prio] - weight);
> > +             if (delta >= last_delta)
> > +                     break;
> > +             last_delta = delta;
> > +     }
> > +
> > +     return LATENCY_TO_NICE(prio-1);
> > +}
> > +
> > +static int cpu_latency_nice_write_s64(struct cgroup_subsys_state *css,
> > +                                  struct cftype *cft, s64 nice)
> > +{
> > +     s64 latency_offset;
> > +     long weight;
> > +     int idx;
> > +
> > +     if (nice < MIN_LATENCY_NICE || nice > MAX_LATENCY_NICE)
> > +             return -ERANGE;
> > +
> > +     idx = NICE_TO_LATENCY(nice);
> > +     idx = array_index_nospec(idx, LATENCY_NICE_WIDTH);
> > +     weight = sched_latency_to_weight[idx];
> > +
> > +     latency_offset = weight * get_sched_latency(false);
> > +     latency_offset = div_s64(latency_offset, NICE_LATENCY_WEIGHT_MAX);
> > +
> > +     return sched_group_set_latency(css_tg(css), latency_offset);
> > +}
> > +
> >  #endif
> >
> >  static struct cftype cpu_legacy_files[] = {
> > @@ -10904,6 +10945,11 @@ static struct cftype cpu_legacy_files[] = {
> >               .read_s64 = cpu_idle_read_s64,
> >               .write_s64 = cpu_idle_write_s64,
> >       },
> > +     {
> > +             .name = "latency.nice",
> > +             .read_s64 = cpu_latency_nice_read_s64,
> > +             .write_s64 = cpu_latency_nice_write_s64,
> > +     },
> >  #endif
> >  #ifdef CONFIG_CFS_BANDWIDTH
> >       {
> > @@ -11121,6 +11167,12 @@ static struct cftype cpu_files[] = {
> >               .read_s64 = cpu_idle_read_s64,
> >               .write_s64 = cpu_idle_write_s64,
> >       },
> > +     {
> > +             .name = "latency.nice",
> > +             .flags = CFTYPE_NOT_ON_ROOT,
> > +             .read_s64 = cpu_latency_nice_read_s64,
> > +             .write_s64 = cpu_latency_nice_write_s64,
> > +     },
> >  #endif
> >  #ifdef CONFIG_CFS_BANDWIDTH
> >       {
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 4299d5108dc7..9583936ce30c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11764,6 +11764,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> >               goto err;
> >
> >       tg->shares = NICE_0_LOAD;
> > +     tg->latency_offset = 0;
> >
> >       init_cfs_bandwidth(tg_cfs_bandwidth(tg));
> >
> > @@ -11862,6 +11863,9 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
> >       }
> >
> >       se->my_q = cfs_rq;
> > +
> > +     se->latency_offset = tg->latency_offset;
> > +
> >       /* guarantee group entities always have weight */
> >       update_load_set(&se->load, NICE_0_LOAD);
> >       se->parent = parent;
> > @@ -11992,6 +11996,35 @@ int sched_group_set_idle(struct task_group *tg, long idle)
> >       return 0;
> >  }
> >
> > +int sched_group_set_latency(struct task_group *tg, s64 latency)
> > +{
> > +     int i;
> > +
> > +     if (tg == &root_task_group)
> > +             return -EINVAL;
> > +
> > +     if (abs(latency) > sysctl_sched_latency)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&shares_mutex);
> > +
> > +     if (tg->latency_offset == latency) {
> > +             mutex_unlock(&shares_mutex);
> > +             return 0;
> > +     }
> > +
> > +     tg->latency_offset = latency;
> > +
> > +     for_each_possible_cpu(i) {
> > +             struct sched_entity *se = tg->se[i];
> > +
> > +             WRITE_ONCE(se->latency_offset, latency);
> > +     }
> > +
> > +     mutex_unlock(&shares_mutex);
> > +     return 0;
> > +}
> > +
> >  #else /* CONFIG_FAIR_GROUP_SCHED */
> >
> >  void free_fair_sched_group(struct task_group *tg) { }
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 99f10b4dc230..95d4be4f3af6 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -407,6 +407,8 @@ struct task_group {
> >
> >       /* A positive value indicates that this is a SCHED_IDLE group. */
> >       int                     idle;
> > +     /* latency constraint of the group. */
> > +     int                     latency_offset;
> >
> >  #ifdef       CONFIG_SMP
> >       /*
> > @@ -517,6 +519,8 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
> >
> >  extern int sched_group_set_idle(struct task_group *tg, long idle);
> >
> > +extern int sched_group_set_latency(struct task_group *tg, s64 latency);
> > +
> >  #ifdef CONFIG_SMP
> >  extern void set_task_rq_fair(struct sched_entity *se,
> >                            struct cfs_rq *prev, struct cfs_rq *next);
> > --
> > 2.17.1
> >
