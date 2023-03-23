Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736A26C6E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCWQza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCWQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:55:28 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5034CB5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:55:23 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r187so1532534ybr.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679590522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCcNP91Fnw/EiThcAorn/KKGa2bYUg246ttJ7O5GIj0=;
        b=R2PqwFbai6wqBlcr0ZOfnOWKfHYcB0lzjCtYIePZ8mNU/XTS2f3BXC2hRKXb1PCJUP
         xDoQZN9K1S7OQQw6BWIvNQeAdkLR1SzLv6mCc0cjC5LXu/xyZN2WBvQTH2ZVNguFp6WQ
         oUsOkWJyhtMI21kzGjmFBACogomODvQ9i8v7DZpFvanp+Og/6xgRHxP/ddF8bEWn2efZ
         I+U4jikiBRw5VIFaCn5s88Wu5BN+nPVkw6+6mu3dsdXuBdwaobSSA7w1vLkS+WgKG4Vi
         0kOl35hD4DzjJ8AiDlv9EG+bYRoyPiBAOqBYTZrf2vT4RdKwyi9i9m3gS0Ae33uqYFHx
         hRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679590522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCcNP91Fnw/EiThcAorn/KKGa2bYUg246ttJ7O5GIj0=;
        b=hFcYGPMvagIhI5a8x89kxvVyWXhT413bcAU6fRGCRbf4Nd52W8M196+6xGtYQlF8SE
         lSg5tfcAbHnKeY+jKTnOeTQEsCQPYLNXXqAsmfs6Du2InujjsRLs45cbAgBIU0MUH4Co
         KBf5ssNg3cU5nnSVgPgcQTofpTAsFR1vqLzz2bxiX6mhffozZHJ+cHhCUSsaFnggZwF6
         WQq8uXIMBgwnunSf3C2Od92fN3pE9S4yCDcJks1yBMJXWqsdxZRkOzsvtLLIusZ8Nltm
         Yj+iB/5aepJUdag0vIXnrDIGhLf2OsDBK5RERJlzobmf/X//pZ3oPU2erlogklvW3XnZ
         wXUQ==
X-Gm-Message-State: AAQBX9eAGUlaeTodvVrz64TPBUhjQmvuD7XKFDR34h1V4sDHUbbx1G2u
        PQ7Az9tXSG/qwVxCFkxaV+kEB16Blo+y3cdACE/B9w==
X-Google-Smtp-Source: AKy350bTeU9IjIxCF/ie8KQk+N85V4Junp1y8GE52U73WNCoJpeKowl7+T9JxCd58z78RHsuyVnylwAX1Tx/IlYOvWk=
X-Received: by 2002:a05:6902:1021:b0:b77:3f5a:8a53 with SMTP id
 x1-20020a056902102100b00b773f5a8a53mr19421ybt.12.1679590522173; Thu, 23 Mar
 2023 09:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230323103350.40569-1-cerasuolodomenico@gmail.com> <20230323103350.40569-4-cerasuolodomenico@gmail.com>
In-Reply-To: <20230323103350.40569-4-cerasuolodomenico@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 23 Mar 2023 09:55:11 -0700
Message-ID: <CAJuCfpFh0iL0cE8V3dh-HkDx3-20Kyo+ZAt0vnqvOzA33HwnFg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/psi: allow unprivileged polling of N*2s period
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

On Thu, Mar 23, 2023 at 3:34=E2=80=AFAM Domenico Cerasuolo
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
> ---
>  Documentation/accounting/psi.rst |   4 ++
>  include/linux/psi.h              |   2 +-
>  include/linux/psi_types.h        |  11 +++-
>  kernel/cgroup/cgroup.c           |   2 +-
>  kernel/sched/psi.c               | 110 ++++++++++++++++++-------------
>  5 files changed, 78 insertions(+), 51 deletions(-)
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
> index 1e0a0d7ace3a..eaee30f54670 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -151,6 +151,14 @@ struct psi_trigger {
>
>         /* Deferred event(s) from previous ratelimit window */
>         bool pending_event;
> +
> +       /* Used to differentiate destruction action*/
> +       enum psi_aggregators aggregator;
> +};
> +
> +struct trigger_info {
> +       struct list_head triggers;
> +       u32 nr_triggers[NR_PSI_STATES - 1];
>  };
>
>  struct psi_group {
> @@ -186,8 +194,7 @@ struct psi_group {
>         struct mutex trigger_lock;
>
>         /* Configured polling triggers */
> -       struct list_head triggers;
> -       u32 nr_triggers[NR_PSI_STATES - 1];
> +       struct trigger_info trig_info[NR_PSI_AGGREGATORS];
>         u32 poll_states;
>         u64 poll_min_period;
>
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
> index 17d71ef07751..f15d92819fe5 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -180,18 +180,20 @@ static void poll_timer_fn(struct timer_list *t);
>  static void group_init(struct psi_group *group)
>  {
>         int cpu;
> +       int i;
>
>         group->enabled =3D true;
>         for_each_possible_cpu(cpu)
>                 seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
>         group->avg_last_update =3D sched_clock();
>         group->avg_next_update =3D group->avg_last_update + psi_period;
> -       INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>         mutex_init(&group->avgs_lock);
>         /* Init trigger-related members */
>         atomic_set(&group->poll_scheduled, 0);
>         mutex_init(&group->trigger_lock);
> -       INIT_LIST_HEAD(&group->triggers);
> +       for (i =3D 0; i < NR_PSI_AGGREGATORS; i++)
> +               INIT_LIST_HEAD(&group->trig_info[i].triggers);
> +       INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>         group->poll_min_period =3D U32_MAX;
>         group->polling_next_update =3D ULLONG_MAX;
>         init_waitqueue_head(&group->poll_wait);
> @@ -430,21 +432,24 @@ static u64 window_update(struct psi_window *win, u6=
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
> +       struct list_head *triggers =3D &group->trig_info[aggregator].trig=
gers;
> +       u64 *aggregator_total =3D aggregator =3D=3D PSI_AVGS ? group->avg=
_total : group->polling_total;
>         *update_total =3D false;
>
>         /*
>          * On subsequent updates, calculate growth deltas and let
>          * watchers know when their specified thresholds are exceeded.
>          */
> -       list_for_each_entry(t, &group->triggers, node) {
> +       list_for_each_entry(t, triggers, node) {
>                 u64 growth;
>                 bool new_stall;
>
> -               new_stall =3D group->polling_total[t->state] !=3D total[t=
->state];
> +               new_stall =3D aggregator_total[t->state] !=3D total[t->st=
ate];
>
>                 /* Check for stall activity or a previous threshold breac=
h */
>                 if (!new_stall && !t->pending_event)
> @@ -545,6 +550,7 @@ static void psi_avgs_work(struct work_struct *work)
>  {
>         struct delayed_work *dwork;
>         struct psi_group *group;
> +       bool update_total;
>         u32 changed_states;
>         u64 now;
>
> @@ -563,8 +569,10 @@ static void psi_avgs_work(struct work_struct *work)
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
> @@ -574,11 +582,11 @@ static void psi_avgs_work(struct work_struct *work)
>         mutex_unlock(&group->avgs_lock);
>  }
>
> -static void init_triggers(struct psi_group *group, u64 now)
> +static void init_poll_triggers(struct psi_group *group, u64 now)
>  {
>         struct psi_trigger *t;
>
> -       list_for_each_entry(t, &group->triggers, node)
> +       list_for_each_entry(t, &group->trig_info[PSI_POLL].triggers, node=
)
>                 window_reset(&t->win, now,
>                                 group->total[PSI_POLL][t->state], 0);
>         memcpy(group->polling_total, group->total[PSI_POLL],
> @@ -667,7 +675,7 @@ static void psi_poll_work(struct psi_group *group)
>         if (changed_states & group->poll_states) {
>                 /* Initialize trigger windows when entering polling mode =
*/
>                 if (now > group->polling_until)
> -                       init_triggers(group, now);
> +                       init_poll_triggers(group, now);
>
>                 /*
>                  * Keep the monitor active for at least the duration of t=
he
> @@ -684,7 +692,7 @@ static void psi_poll_work(struct psi_group *group)
>         }
>
>         if (now >=3D group->polling_next_update) {
> -               group->polling_next_update =3D update_triggers(group, now=
, &update_total);
> +               group->polling_next_update =3D update_triggers(group, now=
, &update_total, PSI_POLL);
>                 if (update_total)
>                         memcpy(group->polling_total, group->total[PSI_POL=
L],
>                                    sizeof(group->polling_total));
> @@ -1254,16 +1262,19 @@ int psi_show(struct seq_file *m, struct psi_group=
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

I missed one detail here. We are moving the cap check from open() to
write(). That might break potential users which open the file from a
process with that cap and then pass that FD to an unprivileged process
to create the trigger by writing to that file. I'm not aware of any
use of such a pattern but it is possible there are such users.
With this change such users would have to delegate trigger creation to
the privileged process too and the received FD would be used only for
polling. IMHO that's a safer pattern because triggers are created by
the privileged process.

> +
>         if (sscanf(buf, "some %u %u", &threshold_us, &window_us) =3D=3D 2=
)
>                 state =3D PSI_IO_SOME + res * 2;
>         else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) =3D=
=3D 2)
> @@ -1283,6 +1294,13 @@ struct psi_trigger *psi_trigger_create(struct psi_=
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
> @@ -1302,10 +1320,11 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group,
>         t->last_event_time =3D 0;
>         init_waitqueue_head(&t->event_wait);
>         t->pending_event =3D false;
> +       t->aggregator =3D privileged ? PSI_POLL : PSI_AVGS;
>
>         mutex_lock(&group->trigger_lock);
>
> -       if (!rcu_access_pointer(group->poll_task)) {
> +       if (privileged && !rcu_access_pointer(group->poll_task)) {
>                 struct task_struct *task;
>
>                 task =3D kthread_create(psi_poll_worker, group, "psimon")=
;
> @@ -1319,12 +1338,14 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group,
>                 rcu_assign_pointer(group->poll_task, task);
>         }
>
> -       list_add(&t->node, &group->triggers);
> -       group->poll_min_period =3D min(group->poll_min_period,
> -               div_u64(t->win.size, UPDATES_PER_WINDOW));
> -       group->nr_triggers[t->state]++;
> -       group->poll_states |=3D (1 << t->state);
> +       list_add(&t->node, &group->trig_info[t->aggregator].triggers);
> +       group->trig_info[t->aggregator].nr_triggers[t->state]++;
>
> +       if (privileged) {
> +               group->poll_min_period =3D min(group->poll_min_period,
> +                       div_u64(t->win.size, UPDATES_PER_WINDOW));
> +               group->poll_states |=3D (1 << t->state);
> +       }
>         mutex_unlock(&group->trigger_lock);
>
>         return t;
> @@ -1357,22 +1378,25 @@ void psi_trigger_destroy(struct psi_trigger *t)
>                 u64 period =3D ULLONG_MAX;
>
>                 list_del(&t->node);
> -               group->nr_triggers[t->state]--;
> -               if (!group->nr_triggers[t->state])
> -                       group->poll_states &=3D ~(1 << t->state);
> -               /* reset min update period for the remaining triggers */
> -               list_for_each_entry(tmp, &group->triggers, node)
> -                       period =3D min(period, div_u64(tmp->win.size,
> -                                       UPDATES_PER_WINDOW));
> -               group->poll_min_period =3D period;
> -               /* Destroy poll_task when the last trigger is destroyed *=
/
> -               if (group->poll_states =3D=3D 0) {
> -                       group->polling_until =3D 0;
> -                       task_to_destroy =3D rcu_dereference_protected(
> -                                       group->poll_task,
> -                                       lockdep_is_held(&group->trigger_l=
ock));
> -                       rcu_assign_pointer(group->poll_task, NULL);
> -                       del_timer(&group->poll_timer);
> +               group->trig_info[t->aggregator].nr_triggers[t->state]--;
> +
> +               if (t->aggregator =3D=3D PSI_POLL) {
> +                       if (!group->trig_info[t->aggregator].nr_triggers[=
t->state])
> +                               group->poll_states &=3D ~(1 << t->state);
> +                       /* reset min update period for the remaining trig=
gers */
> +                       list_for_each_entry(tmp, &group->trig_info[t->agg=
regator].triggers, node)
> +                               period =3D min(period, div_u64(tmp->win.s=
ize,
> +                                               UPDATES_PER_WINDOW));
> +                       group->poll_min_period =3D period;
> +                       /* Destroy poll_task when the last trigger is des=
troyed */
> +                       if (group->poll_states =3D=3D 0) {
> +                               group->polling_until =3D 0;
> +                               task_to_destroy =3D rcu_dereference_prote=
cted(
> +                                               group->poll_task,
> +                                               lockdep_is_held(&group->t=
rigger_lock));
> +                               rcu_assign_pointer(group->poll_task, NULL=
);
> +                               del_timer(&group->poll_timer);
> +                       }

You could minimize the churn here. For (t->aggregator =3D=3D PSI_POLL)
case we are doing some additional stuff, so instead of doing "if
(t->aggregator =3D=3D PSI_POLL) { " and shifting the rest of the code you
could have "if (t->aggregator =3D=3D PSI_AVGS) return;" and keep the
existing indent level.

>                 }
>         }
>
> @@ -1436,27 +1460,19 @@ static int psi_cpu_show(struct seq_file *m, void =
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
> @@ -1490,7 +1506,7 @@ static ssize_t psi_write(struct file *file, const c=
har __user *user_buf,
>                 return -EBUSY;
>         }
>
> -       new =3D psi_trigger_create(&psi_system, buf, res);
> +       new =3D psi_trigger_create(&psi_system, buf, res, file);
>         if (IS_ERR(new)) {
>                 mutex_unlock(&seq->lock);
>                 return PTR_ERR(new);
> @@ -1570,7 +1586,7 @@ static int psi_irq_show(struct seq_file *m, void *v=
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
