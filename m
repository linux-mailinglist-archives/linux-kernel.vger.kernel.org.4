Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3306D0E16
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjC3Sv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjC3SvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:51:25 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1663DCDF9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:51:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p204so24735008ybc.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680202283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivxFGeG33jiIRHOFYGHzp7sYYRx+HbEz4rJaElszpZE=;
        b=FWpGOo7yiQ+djG35siPjrR+RmSYawhEzwlhuxNr5L8HfIr0m/ZWChyZ80erNZtOK4Q
         K0tgYQPySRuVrvi5mG3lHdiUF8z3PuE+ImeL/GZJEPevqcHBTcA0+lwGLSRgjl3LRYjN
         2PUPBnVxAhUn1b/uI+/Ds80sSlpzvCJTRQkU0cOw0lDQUTABegtvejg0i6Gw1Wo3+X9u
         kaG/r3gciJtSReNTt4efG+UxLZWVPD3TYPp37H0UDwK3gLZs742iAI/zqnldYc7oc6Aa
         SDfT0XwXKPSD523Ud0IOFbD1MiAOYLCNUbjM323o907mbrrRoqNovUBlyYmUvxgyKyyy
         Ut2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680202283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivxFGeG33jiIRHOFYGHzp7sYYRx+HbEz4rJaElszpZE=;
        b=7dsY0r9cpLgj4Qfe73wr+YQJpH5BV0zuyfw82pIppha9SvB/mKVFYGBrWFTi5+RXg4
         2Wf5oorw5NNnzbBJBgEUUZ6oAGwKekO1iGEiiFwYB0rGBW+xbMp/rbsa8hKKa8oSOuqN
         IXz6VPX5jRqDiM2Raq28K4IN8C2YnzMPkKLROjMLhRbvsokcIEwNTBYJR1Q6dMFqJrPx
         wwEh7DZyj3uAOIKQI7vKZq26ZKliSYldHE8ELBB+vm3XAX9K6o8s+8fFIkQu3KGexs8u
         BnQxPnmRRCfioIFtIMJfNhYWauEIjIxiSrFeDAeEUjfqBgFOiAaX481cYYAtWC5MtPbJ
         8Tpw==
X-Gm-Message-State: AAQBX9c2nlLR1HyeZRe+flJ1eZzdrhzssr8bXHbhi5VIy/RU9wjxkvEz
        +w+X+hvPJJFXYnQGUm0HZnNA6ZB0aAiwuC90DsGzcQ==
X-Google-Smtp-Source: AKy350Z9zpVqZjYZW/zixPXb/4ILMjGXQ34C+3x49DsHQZKizymdFMmqOBH1Licv4fNUwiWQME99xKjbt6fDNcoxnFc=
X-Received: by 2002:a05:6902:154e:b0:b77:d2db:5f8f with SMTP id
 r14-20020a056902154e00b00b77d2db5f8fmr15800074ybu.12.1680202282907; Thu, 30
 Mar 2023 11:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230330105418.77061-1-cerasuolodomenico@gmail.com> <20230330105418.77061-5-cerasuolodomenico@gmail.com>
In-Reply-To: <20230330105418.77061-5-cerasuolodomenico@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 30 Mar 2023 11:51:11 -0700
Message-ID: <CAJuCfpGuz-5NNmmGY_PHESZF6HTiVU4=ghzjM2uCVyFYJ8L9+A@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] sched/psi: allow unprivileged polling of N*2s period
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 3:54=E2=80=AFAM Domenico Cerasuolo
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
> runs independently of any triggers.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  Documentation/accounting/psi.rst |   4 +
>  include/linux/psi.h              |   2 +-
>  include/linux/psi_types.h        |   7 ++
>  kernel/cgroup/cgroup.c           |   2 +-
>  kernel/sched/psi.c               | 175 +++++++++++++++++++------------
>  5 files changed, 121 insertions(+), 69 deletions(-)
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
> index 1819afa8b198..040c089581c6 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -151,6 +151,9 @@ struct psi_trigger {
>
>         /* Deferred event(s) from previous ratelimit window */
>         bool pending_event;
> +
> +       /* Trigger type - PSI_AVGS for unprivileged, PSI_POLL for RT */
> +       enum psi_aggregators aggregator;
>  };
>
>  struct psi_group {
> @@ -171,6 +174,10 @@ struct psi_group {
>         /* Aggregator work control */
>         struct delayed_work avgs_work;
>
> +       /* Unprivileged triggers against N*PSI_FREQ windows */
> +       struct list_head avg_triggers;
> +       u32 avg_nr_triggers[NR_PSI_STATES - 1];
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
> index f3df6a8ff493..e072f6b31bf3 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -186,9 +186,14 @@ static void group_init(struct psi_group *group)
>                 seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
>         group->avg_last_update =3D sched_clock();
>         group->avg_next_update =3D group->avg_last_update + psi_period;
> -       INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>         mutex_init(&group->avgs_lock);
> -       /* Init trigger-related members */
> +
> +       /* Init avg trigger-related members */
> +       INIT_LIST_HEAD(&group->avg_triggers);
> +       memset(group->avg_nr_triggers, 0, sizeof(group->avg_nr_triggers))=
;
> +       INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
> +
> +       /* Init rtpoll trigger-related members */
>         atomic_set(&group->rtpoll_scheduled, 0);
>         mutex_init(&group->rtpoll_trigger_lock);
>         INIT_LIST_HEAD(&group->rtpoll_triggers);
> @@ -430,21 +435,32 @@ static u64 window_update(struct psi_window *win, u6=
4 now, u64 value)
>         return growth;
>  }
>
> -static u64 update_triggers(struct psi_group *group, u64 now, bool *updat=
e_total)
> +static u64 update_triggers(struct psi_group *group, u64 now, bool *updat=
e_total,
> +                                                  enum psi_aggregators a=
ggregator)
>  {
>         struct psi_trigger *t;
> -       u64 *total =3D group->total[PSI_POLL];
> +       u64 *total =3D group->total[aggregator];
> +       struct list_head *triggers;
> +       u64 *aggregator_total;
>         *update_total =3D false;
>
> +       if (aggregator =3D=3D PSI_AVGS) {
> +               triggers =3D &group->avg_triggers;
> +               aggregator_total =3D group->avg_total;
> +       } else {
> +               triggers =3D &group->rtpoll_triggers;
> +               aggregator_total =3D group->rtpoll_total;
> +       }
> +
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
> @@ -546,6 +562,7 @@ static void psi_avgs_work(struct work_struct *work)
>         struct delayed_work *dwork;
>         struct psi_group *group;
>         u32 changed_states;
> +       bool update_total;
>         u64 now;
>
>         dwork =3D to_delayed_work(work);
> @@ -563,8 +580,10 @@ static void psi_avgs_work(struct work_struct *work)
>          * Once restarted, we'll catch up the running averages in one
>          * go - see calc_avgs() and missed_periods.
>          */
> -       if (now >=3D group->avg_next_update)
> +       if (now >=3D group->avg_next_update) {
> +               update_triggers(group, now, &update_total, PSI_AVGS);
>                 group->avg_next_update =3D update_averages(group, now);
> +       }
>
>         if (changed_states & PSI_STATE_RESCHEDULE) {
>                 schedule_delayed_work(dwork, nsecs_to_jiffies(
> @@ -574,7 +593,7 @@ static void psi_avgs_work(struct work_struct *work)
>         mutex_unlock(&group->avgs_lock);
>  }
>
> -static void init_triggers(struct psi_group *group, u64 now)
> +static void init_rtpoll_triggers(struct psi_group *group, u64 now)
>  {
>         struct psi_trigger *t;
>
> @@ -667,7 +686,7 @@ static void psi_rtpoll_work(struct psi_group *group)
>         if (changed_states & group->rtpoll_states) {
>                 /* Initialize trigger windows when entering polling mode =
*/
>                 if (now > group->rtpoll_until)
> -                       init_triggers(group, now);
> +                       init_rtpoll_triggers(group, now);
>
>                 /*
>                  * Keep the monitor active for at least the duration of t=
he
> @@ -684,7 +703,7 @@ static void psi_rtpoll_work(struct psi_group *group)
>         }
>
>         if (now >=3D group->rtpoll_next_update) {
> -               group->rtpoll_next_update =3D update_triggers(group, now,=
 &update_total);
> +               group->rtpoll_next_update =3D update_triggers(group, now,=
 &update_total, PSI_POLL);
>                 if (update_total)
>                         memcpy(group->rtpoll_total, group->total[PSI_POLL=
],
>                                    sizeof(group->rtpoll_total));
> @@ -1254,16 +1273,23 @@ int psi_show(struct seq_file *m, struct psi_group=
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
> +       /*
> +        * Checking the privilege here on file->f_cred implies that a pri=
vileged user
> +        * could open the file and delegate the write to an unprivileged =
one.
> +        */
> +       privileged =3D cap_raised(file->f_cred->cap_effective, CAP_SYS_RE=
SOURCE);
> +
>         if (sscanf(buf, "some %u %u", &threshold_us, &window_us) =3D=3D 2=
)
>                 state =3D PSI_IO_SOME + res * 2;
>         else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) =3D=
=3D 2)
> @@ -1283,6 +1309,13 @@ struct psi_trigger *psi_trigger_create(struct psi_=
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
> @@ -1302,31 +1335,40 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group,
>         t->last_event_time =3D 0;
>         init_waitqueue_head(&t->event_wait);
>         t->pending_event =3D false;
> +       t->aggregator =3D privileged ? PSI_POLL : PSI_AVGS;
>
> -       mutex_lock(&group->rtpoll_trigger_lock);
> +       if (privileged) {
> +               mutex_lock(&group->rtpoll_trigger_lock);
>
> -       if (!rcu_access_pointer(group->rtpoll_task)) {
> -               struct task_struct *task;
> +               if (!rcu_access_pointer(group->rtpoll_task)) {
> +                       struct task_struct *task;
>
> -               task =3D kthread_create(psi_rtpoll_worker, group, "psimon=
");
> -               if (IS_ERR(task)) {
> -                       kfree(t);
> -                       mutex_unlock(&group->rtpoll_trigger_lock);
> -                       return ERR_CAST(task);
> +                       task =3D kthread_create(psi_rtpoll_worker, group,=
 "psimon");
> +                       if (IS_ERR(task)) {
> +                               kfree(t);
> +                               mutex_unlock(&group->rtpoll_trigger_lock)=
;
> +                               return ERR_CAST(task);
> +                       }
> +                       atomic_set(&group->rtpoll_wakeup, 0);
> +                       wake_up_process(task);
> +                       rcu_assign_pointer(group->rtpoll_task, task);
>                 }
> -               atomic_set(&group->rtpoll_wakeup, 0);
> -               wake_up_process(task);
> -               rcu_assign_pointer(group->rtpoll_task, task);
> -       }
>
> -       list_add(&t->node, &group->rtpoll_triggers);
> -       group->rtpoll_min_period =3D min(group->rtpoll_min_period,
> -               div_u64(t->win.size, UPDATES_PER_WINDOW));
> -       group->rtpoll_nr_triggers[t->state]++;
> -       group->rtpoll_states |=3D (1 << t->state);
> +               list_add(&t->node, &group->rtpoll_triggers);
> +               group->rtpoll_min_period =3D min(group->rtpoll_min_period=
,
> +                       div_u64(t->win.size, UPDATES_PER_WINDOW));
> +               group->rtpoll_nr_triggers[t->state]++;
> +               group->rtpoll_states |=3D (1 << t->state);
>
> -       mutex_unlock(&group->rtpoll_trigger_lock);
> +               mutex_unlock(&group->rtpoll_trigger_lock);
> +       } else {
> +               mutex_lock(&group->avgs_lock);
> +
> +               list_add(&t->node, &group->avg_triggers);
> +               group->avg_nr_triggers[t->state]++;
>
> +               mutex_unlock(&group->avgs_lock);
> +       }
>         return t;
>  }
>
> @@ -1350,34 +1392,41 @@ void psi_trigger_destroy(struct psi_trigger *t)
>          */
>         wake_up_pollfree(&t->event_wait);
>
> -       mutex_lock(&group->rtpoll_trigger_lock);
> -
> -       if (!list_empty(&t->node)) {
> -               struct psi_trigger *tmp;
> -               u64 period =3D ULLONG_MAX;
> -
> -               list_del(&t->node);
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
> +       if (t->aggregator =3D=3D PSI_AVGS) {

Just a nit, in psi_trigger_create() you are handling privileged
trigger case first and then unprivileged case. In
psi_trigger_destroy() the order is opposite. Would be better to have
the same order.
In both cases I would prefer:

if (t->aggregator =3D=3D PSI_AVGS) {
  ...
  goto out;
}
// unprivileged case
...
out:

This would cut down on churn and indents. Not critical from functional
point of view, so

Acked-by: Suren Baghdasaryan <surenb@google.com>


> +               mutex_lock(&group->avgs_lock);
> +               if (!list_empty(&t->node)) {
> +                       list_del(&t->node);
> +                       group->avg_nr_triggers[t->state]--;
>                 }
> +               mutex_unlock(&group->avgs_lock);
> +       } else {
> +               mutex_lock(&group->rtpoll_trigger_lock);
> +               if (!list_empty(&t->node)) {
> +                       struct psi_trigger *tmp;
> +                       u64 period =3D ULLONG_MAX;
> +
> +                       list_del(&t->node);
> +                       group->rtpoll_nr_triggers[t->state]--;
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
> +               }
> +               mutex_unlock(&group->rtpoll_trigger_lock);
>         }
>
> -       mutex_unlock(&group->rtpoll_trigger_lock);
> -
>         /*
>          * Wait for psi_schedule_rtpoll_work RCU to complete its read-sid=
e
>          * critical section before destroying the trigger and optionally =
the
> @@ -1437,27 +1486,19 @@ static int psi_cpu_show(struct seq_file *m, void =
*v)
>         return psi_show(m, &psi_system, PSI_CPU);
>  }
>
> -static int psi_open(struct file *file, int (*psi_show)(struct seq_file *=
, void *))
> -{
> -       if (file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
> -               return -EPERM;
> -
> -       return single_open(file, psi_show, NULL);
> -}
> -
>  static int psi_io_open(struct inode *inode, struct file *file)
>  {
> -       return psi_open(file, psi_io_show);
> +       return single_open(file, psi_io_show, NULL);
>  }
>
>  static int psi_memory_open(struct inode *inode, struct file *file)
>  {
> -       return psi_open(file, psi_memory_show);
> +       return single_open(file, psi_memory_show, NULL);
>  }
>
>  static int psi_cpu_open(struct inode *inode, struct file *file)
>  {
> -       return psi_open(file, psi_cpu_show);
> +       return single_open(file, psi_cpu_show, NULL);
>  }
>
>  static ssize_t psi_write(struct file *file, const char __user *user_buf,
> @@ -1491,7 +1532,7 @@ static ssize_t psi_write(struct file *file, const c=
har __user *user_buf,
>                 return -EBUSY;
>         }
>
> -       new =3D psi_trigger_create(&psi_system, buf, res);
> +       new =3D psi_trigger_create(&psi_system, buf, res, file);
>         if (IS_ERR(new)) {
>                 mutex_unlock(&seq->lock);
>                 return PTR_ERR(new);
> @@ -1571,7 +1612,7 @@ static int psi_irq_show(struct seq_file *m, void *v=
)
>
>  static int psi_irq_open(struct inode *inode, struct file *file)
>  {
> -       return psi_open(file, psi_irq_show);
> +       return single_open(file, psi_irq_show, NULL);
>  }
>
>  static ssize_t psi_irq_write(struct file *file, const char __user *user_=
buf,
> --
> 2.34.1
>
