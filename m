Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6376C2589
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCTXSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCTXSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:18:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2506EA2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:18:10 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h7so7332421ila.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679354289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFQxj7O8QcCZGkowe9VIUY1fIhNVRSOhKodzQJoCCZg=;
        b=JpEFTMqwk2VKxeY0nRXCylZM7yMRQXhlOFtwme2oLJwRRikwe/axZeBwxcXP3agwZo
         N2dGLxuLGA8SworDiaERfICSbonLsVQsaZqYnac860cjDM0tRGxaW9ul9g2gBVBFATSn
         KpIzm3kut8IRbkic0zjIk+ExKcQYlqThOXtEIRsjfYduSv6wNuUTM/z7KlLbfd3NJJX/
         QQSN2GzKCwKPjtZkWBvkIFSHsPZzFXgilv3FFxAbkoOAWR38Oicz5JJIG/FkinpMxbo0
         4ON35pLoI95TE8Q1qEVHl+ztUmszuVPnwR9yqnuozLA0uSEC3ZRwbTMeatlFS5dWFzHp
         TzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679354289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFQxj7O8QcCZGkowe9VIUY1fIhNVRSOhKodzQJoCCZg=;
        b=vNvMHHF7m3XA4rOKm6O9FHD5Fz/GHMaJ7euaJMZil11xhY4RcpUrK6xur9cisGr9qv
         PoNOBXOr6b44gBe+12mpqXTlvK5hmPgDCSKh6HjZFmSwwOS3pUa238ZbVprxkyblrc0s
         1sv44SMysey2Jy8itS9YuC4sVOMB773qny+UNZGZ6TN145wWS6giDVpS31BSnD4e7TlD
         dN8HE8wj0yrMJQy7VmPaR6e4mftKUWucgD68fzyULhTrq9YzArrzfVIan3o46BJhdQjj
         PSbsplDavNUv886QZRLaQp9IGPhdTvSulolrR2fhI91UYRUfMvL/BBKBAdHMojSmLL6h
         35xw==
X-Gm-Message-State: AO0yUKUGBRE1eojw5+0rgBOkp4jLRGp6C0cNapc3VFdYg7VqVg6RZZLe
        /HxKxmu6AFSwRm8O2eB2gTMfdLE094xWsIeOl9IzCDWOgZfwO2MhJ7xTNin8
X-Google-Smtp-Source: AKy350bJ8vyBBm9YCOGhJTtmx9DVrm9Fb34kyUADV5vZZ1YUY+oG4IgdT8cY4UKF0331YEESalREzIdZHCVUKsU0SE0=
X-Received: by 2002:a05:6902:8b:b0:b56:1f24:7e9f with SMTP id
 h11-20020a056902008b00b00b561f247e9fmr121982ybs.12.1679354277707; Mon, 20 Mar
 2023 16:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230309170756.52927-1-cerasuolodomenico@gmail.com> <20230309170756.52927-5-cerasuolodomenico@gmail.com>
In-Reply-To: <20230309170756.52927-5-cerasuolodomenico@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 20 Mar 2023 16:17:46 -0700
Message-ID: <CAJuCfpEF+voHHiFd1vjdPaXRpDj2H6WEgRvevM2dBQqBdrosSg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/psi: allow unprivileged polling of N*2s period
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 9, 2023 at 9:08=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> PSI offers 2 mechanisms to get information about a specific resource
> pressure. One is reading from /proc/pressure/<resource>, which gives
> average pressures aggregated every 2s. The other is creating a pollable
> fd for a specific resource and cgroup.
>
> The trigger creation requires CAP_SYS_RESOURCE, and gives the
> possibility to pick specific time window and threshold, spawing an RT
> thread to aggregate the data.
>
> Systemd would like to provide containers the option to monitor pressure
> on their own cgroup and sub-cgroups. For example, if systemd launches a
> container that itself then launches services, the container should have
> the ability to poll() for pressure in individual services. But neither
> the container nor the services are privileged.
>
> This patch implements a mechanism to allow unprivileged users to create
> pressure triggers. The difference with privileged triggers creation is
> that unprivileged ones must have a time window that's a multiple of 2s.
> This is so that we can avoid unrestricted spawning of rt threads, and
> use instead the same aggregation mechanism done for the averages, which
> runs indipendently of any triggers.

s/indipendently/independently

>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  Documentation/accounting/psi.rst |   4 ++
>  include/linux/psi.h              |   2 +-
>  include/linux/psi_types.h        |   7 +++
>  kernel/cgroup/cgroup.c           |   2 +-
>  kernel/sched/psi.c               | 105 ++++++++++++++++++++-----------
>  5 files changed, 83 insertions(+), 37 deletions(-)
>
> diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/=
psi.rst
> index 5e40b3f437f9..df6062eb3abb 100644
> --- a/Documentation/accounting/psi.rst
> +++ b/Documentation/accounting/psi.rst
> @@ -105,6 +105,10 @@ prevent overly frequent polling. Max limit is chosen=
 as a high enough number
>  after which monitors are most likely not needed and psi averages can be =
used
>  instead.
>
> +Unprivileged users can also create monitors, with the only limitation th=
at the
> +window size must be a multiple of 2s, in order to prevent excessive reso=
urce
> +usage.
> +
>  When activated, psi monitor stays active for at least the duration of on=
e
>  tracking window to avoid repeated activations/deactivations when system =
is
>  bouncing in and out of the stall state.
> diff --git a/include/linux/psi.h b/include/linux/psi.h
> index b029a847def1..ab26200c2803 100644
> --- a/include/linux/psi.h
> +++ b/include/linux/psi.h
> @@ -24,7 +24,7 @@ void psi_memstall_leave(unsigned long *flags);
>
>  int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res r=
es);
>  struct psi_trigger *psi_trigger_create(struct psi_group *group,
> -                       char *buf, enum psi_res res);
> +                       char *buf, enum psi_res res, struct file *file);
>  void psi_trigger_destroy(struct psi_trigger *t);
>
>  __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index 1819afa8b198..e439f411c23b 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -151,6 +151,9 @@ struct psi_trigger {
>
>         /* Deferred event(s) from previous ratelimit window */
>         bool pending_event;
> +
> +       /* Used to differentiate destruction action*/
> +       enum psi_aggregators aggregator;
>  };
>
>  struct psi_group {
> @@ -171,6 +174,10 @@ struct psi_group {
>         /* Aggregator work control */
>         struct delayed_work avgs_work;
>
> +       /* Unprivileged triggers against N*PSI_FREQ windows */
> +       struct list_head triggers;
> +       u32 nr_triggers[NR_PSI_STATES - 1];
> +
>         /* Total stall times and sampled pressure averages */
>         u64 total[NR_PSI_AGGREGATORS][NR_PSI_STATES - 1];
>         unsigned long avg[NR_PSI_STATES - 1][3];
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 935e8121b21e..dead36969bba 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3761,7 +3761,7 @@ static ssize_t pressure_write(struct kernfs_open_fi=
le *of, char *buf,
>         }
>
>         psi =3D cgroup_psi(cgrp);
> -       new =3D psi_trigger_create(psi, buf, res);
> +       new =3D psi_trigger_create(psi, buf, res, of->file);
>         if (IS_ERR(new)) {
>                 cgroup_put(cgrp);
>                 return PTR_ERR(new);
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 476941c1cbea..fde91aa4e55f 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -186,9 +186,9 @@ static void group_init(struct psi_group *group)
>                 seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
>         group->avg_last_update =3D sched_clock();
>         group->avg_next_update =3D group->avg_last_update + psi_period;
> -       INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>         mutex_init(&group->avgs_lock);
> -       /* Init trigger-related members */
> +
> +       /* Init rtpoll trigger-related members */
>         atomic_set(&group->rtpoll_scheduled, 0);
>         mutex_init(&group->rtpoll_trigger_lock);
>         INIT_LIST_HEAD(&group->rtpoll_triggers);
> @@ -197,6 +197,11 @@ static void group_init(struct psi_group *group)
>         init_waitqueue_head(&group->rtpoll_wait);
>         timer_setup(&group->rtpoll_timer, poll_timer_fn, 0);
>         rcu_assign_pointer(group->rtpoll_task, NULL);
> +
> +       /* Init avg trigger-related members */
> +       INIT_LIST_HEAD(&group->triggers);
> +       memset(group->nr_triggers, 0, sizeof(group->nr_triggers));
> +       INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>  }
>
>  void __init psi_init(void)
> @@ -430,20 +435,23 @@ static u64 window_update(struct psi_window *win, u6=
4 now, u64 value)
>         return growth;
>  }
>
> -static u64 update_triggers(struct psi_group *group, u64 now)
> +static u64 update_triggers(struct psi_group *group, u64 now, enum psi_ag=
gregators aggregator)
>  {
>         struct psi_trigger *t;
> -       u64 *total =3D group->total[PSI_POLL];
> +       u64 *total =3D group->total[aggregator];
> +       struct list_head *triggers =3D aggregator =3D=3D PSI_AVGS ? &grou=
p->triggers
> +                       : &group->rtpoll_triggers;
> +       u64 *aggregator_total =3D aggregator =3D=3D PSI_AVGS ? group->avg=
_total : group->rtpoll_total;

I think if you follow my suggestion in patch#2 you can do:

struct trigger_info* tinfo =3D group->trig_info[aggregator];

and use that instead of the above if/else conditions.


>
>         /*
>          * On subsequent updates, calculate growth deltas and let
>          * watchers know when their specified thresholds are exceeded.
>          */
> -       list_for_each_entry(t, &group->rtpoll_triggers, node) {
> +       list_for_each_entry(t, triggers, node) {
>                 u64 growth;
>                 bool new_stall;
>
> -               new_stall =3D group->rtpoll_total[t->state] !=3D total[t-=
>state];
> +               new_stall =3D aggregator_total[t->state] !=3D total[t->st=
ate];
>
>                 /* Check for stall activity or a previous threshold breac=
h */
>                 if (!new_stall && !t->pending_event)
> @@ -553,8 +561,10 @@ static void psi_avgs_work(struct work_struct *work)
>          * Once restarted, we'll catch up the running averages in one
>          * go - see calc_avgs() and missed_periods.
>          */
> -       if (now >=3D group->avg_next_update)
> +       if (now >=3D group->avg_next_update) {
> +               update_triggers(group, now, PSI_AVGS);
>                 group->avg_next_update =3D update_averages(group, now);
> +       }
>
>         if (changed_states & PSI_STATE_RESCHEDULE) {
>                 schedule_delayed_work(dwork, nsecs_to_jiffies(
> @@ -571,9 +581,17 @@ static void init_triggers(struct psi_group *group, u=
64 now)
>         list_for_each_entry(t, &group->rtpoll_triggers, node)
>                 window_reset(&t->win, now,
>                                 group->total[PSI_POLL][t->state], 0);
> +
> +       list_for_each_entry(t, &group->triggers, node)
> +               window_reset(&t->win, now,
> +                               group->total[PSI_AVGS][t->state], 0);
> +
>         memcpy(group->rtpoll_total, group->total[PSI_POLL],
>                    sizeof(group->rtpoll_total));
>         group->rtpoll_next_update =3D now + group->rtpoll_min_period;
> +
> +       memcpy(group->avg_total, group->total[PSI_AVGS],
> +                  sizeof(group->avg_total));
>  }
>
>  /* Schedule polling if it's not already scheduled or forced. */
> @@ -673,7 +691,7 @@ static void psi_rtpoll_work(struct psi_group *group)
>         }
>
>         if (now >=3D group->rtpoll_next_update) {
> -               group->rtpoll_next_update =3D update_triggers(group, now)=
;
> +               group->rtpoll_next_update =3D update_triggers(group, now,=
 PSI_POLL);
>                 if (changed_states & group->rtpoll_states)
>                         memcpy(group->rtpoll_total, group->total[PSI_POLL=
],
>                                    sizeof(group->rtpoll_total));
> @@ -1243,16 +1261,19 @@ int psi_show(struct seq_file *m, struct psi_group=
 *group, enum psi_res res)
>  }
>
>  struct psi_trigger *psi_trigger_create(struct psi_group *group,
> -                       char *buf, enum psi_res res)
> +                       char *buf, enum psi_res res, struct file *file)
>  {
>         struct psi_trigger *t;
>         enum psi_states state;
>         u32 threshold_us;
> +       bool privileged;
>         u32 window_us;
>
>         if (static_branch_likely(&psi_disabled))
>                 return ERR_PTR(-EOPNOTSUPP);
>
> +       privileged =3D cap_raised(file->f_cred->cap_effective, CAP_SYS_RE=
SOURCE);
> +
>         if (sscanf(buf, "some %u %u", &threshold_us, &window_us) =3D=3D 2=
)
>                 state =3D PSI_IO_SOME + res * 2;
>         else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) =3D=
=3D 2)
> @@ -1272,6 +1293,13 @@ struct psi_trigger *psi_trigger_create(struct psi_=
group *group,
>                 window_us > WINDOW_MAX_US)
>                 return ERR_PTR(-EINVAL);
>
> +       /*
> +        * Unprivileged users can only use 2s windows so that averages ag=
gregation
> +        * work is used, and no RT threads need to be spawned.
> +        */
> +       if (!privileged && window_us % 2000000)
> +               return ERR_PTR(-EINVAL);
> +
>         /* Check threshold */
>         if (threshold_us =3D=3D 0 || threshold_us > window_us)
>                 return ERR_PTR(-EINVAL);
> @@ -1291,10 +1319,11 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group,
>         t->last_event_time =3D 0;
>         init_waitqueue_head(&t->event_wait);
>         t->pending_event =3D false;
> +       t->aggregator =3D privileged ? PSI_POLL : PSI_AVGS;
>
>         mutex_lock(&group->rtpoll_trigger_lock);
>
> -       if (!rcu_access_pointer(group->rtpoll_task)) {
> +       if (privileged && !rcu_access_pointer(group->rtpoll_task)) {
>                 struct task_struct *task;
>
>                 task =3D kthread_create(psi_rtpoll_worker, group, "psimon=
");
> @@ -1308,11 +1337,16 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group,
>                 rcu_assign_pointer(group->rtpoll_task, task);
>         }
>
> -       list_add(&t->node, &group->rtpoll_triggers);
> -       group->rtpoll_min_period =3D min(group->rtpoll_min_period,
> -               div_u64(t->win.size, UPDATES_PER_WINDOW));
> -       group->rtpoll_nr_triggers[t->state]++;
> -       group->rtpoll_states |=3D (1 << t->state);
> +       if (privileged) {
> +               list_add(&t->node, &group->rtpoll_triggers);
> +               group->rtpoll_min_period =3D min(group->rtpoll_min_period=
,
> +                       div_u64(t->win.size, UPDATES_PER_WINDOW));
> +               group->rtpoll_nr_triggers[t->state]++;
> +               group->rtpoll_states |=3D (1 << t->state);
> +       } else {
> +               list_add(&t->node, &group->triggers);
> +               group->nr_triggers[t->state]++;
> +       }
>
>         mutex_unlock(&group->rtpoll_trigger_lock);
>
> @@ -1346,22 +1380,26 @@ void psi_trigger_destroy(struct psi_trigger *t)
>                 u64 period =3D ULLONG_MAX;
>
>                 list_del(&t->node);
> -               group->rtpoll_nr_triggers[t->state]--;
> -               if (!group->rtpoll_nr_triggers[t->state])
> -                       group->rtpoll_states &=3D ~(1 << t->state);
> -               /* reset min update period for the remaining triggers */
> -               list_for_each_entry(tmp, &group->rtpoll_triggers, node)
> -                       period =3D min(period, div_u64(tmp->win.size,
> -                                       UPDATES_PER_WINDOW));
> -               group->rtpoll_min_period =3D period;
> -               /* Destroy rtpoll_task when the last trigger is destroyed=
 */
> -               if (group->rtpoll_states =3D=3D 0) {
> -                       group->rtpoll_until =3D 0;
> -                       task_to_destroy =3D rcu_dereference_protected(
> -                                       group->rtpoll_task,
> -                                       lockdep_is_held(&group->rtpoll_tr=
igger_lock));
> -                       rcu_assign_pointer(group->rtpoll_task, NULL);
> -                       del_timer(&group->rtpoll_timer);
> +               if (t->aggregator =3D=3D PSI_AVGS) {
> +                       group->nr_triggers[t->state]--;
> +               } else {
> +                       group->rtpoll_nr_triggers[t->state]--;

Same here. This can be:

group->trig_info[t->aggregator].nr_triggers[t->state]--;
if (t->aggregator =3D=3D PSI_AVGS)
    return;
// original code for PSI_POLL triggers

> +                       if (!group->rtpoll_nr_triggers[t->state])
> +                               group->rtpoll_states &=3D ~(1 << t->state=
);
> +                       /* reset min update period for the remaining trig=
gers */
> +                       list_for_each_entry(tmp, &group->rtpoll_triggers,=
 node)
> +                               period =3D min(period, div_u64(tmp->win.s=
ize,
> +                                               UPDATES_PER_WINDOW));
> +                       group->rtpoll_min_period =3D period;
> +                       /* Destroy rtpoll_task when the last trigger is d=
estroyed */
> +                       if (group->rtpoll_states =3D=3D 0) {
> +                               group->rtpoll_until =3D 0;
> +                               task_to_destroy =3D rcu_dereference_prote=
cted(
> +                                               group->rtpoll_task,
> +                                               lockdep_is_held(&group->r=
tpoll_trigger_lock));
> +                               rcu_assign_pointer(group->rtpoll_task, NU=
LL);
> +                               del_timer(&group->rtpoll_timer);
> +                       }
>                 }
>         }
>
> @@ -1428,9 +1466,6 @@ static int psi_cpu_show(struct seq_file *m, void *v=
)
>
>  static int psi_open(struct file *file, int (*psi_show)(struct seq_file *=
, void *))
>  {
> -       if (file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
> -               return -EPERM;
> -
>         return single_open(file, psi_show, NULL);
>  }

Here you can eliminate psi_open() completely and use single_open() directly=
.

>
> @@ -1480,7 +1515,7 @@ static ssize_t psi_write(struct file *file, const c=
har __user *user_buf,
>                 return -EBUSY;
>         }
>
> -       new =3D psi_trigger_create(&psi_system, buf, res);
> +       new =3D psi_trigger_create(&psi_system, buf, res, file);
>         if (IS_ERR(new)) {
>                 mutex_unlock(&seq->lock);
>                 return PTR_ERR(new);
> --
> 2.34.1
>
