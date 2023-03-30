Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2699F6D0DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjC3SkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjC3Sj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:39:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1755BF770
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:39:39 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id b18so24729316ybp.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680201576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYqMdGaSgSbihvtCBmDcTk0zKx0+0RCfPyPQp6xYi3U=;
        b=WhfAHQPJqeNxyzmlOZcMVptxZbH+PgVtHtH3ResNnpa13mA05VTs+P0hPoi6KSVDIW
         szFWBYmZhQUgflN8BFFv9YVTWIs2KsybsMG8IJIxHCz0iJrthu17AXK1/lf3PKgxioTW
         pHUR4DkSS/sScY1a9CT2WtqL5yed0Fy7Co2QqpBWxGO8c9QWF8THNZEH09OWPyZmxaUP
         xX7FBTa4a+v4yHRy1W6bsWlXPj/uIUhumK/jqImLbD0yC5aHqtIa4DDr35Rj/oA9L4e9
         8Qv5f5acVtBSAEX/QosnTgAD9eEsPqDDbDc4YF710Mwl7IOM2vbkAH6y694tmo0RvaSY
         nRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYqMdGaSgSbihvtCBmDcTk0zKx0+0RCfPyPQp6xYi3U=;
        b=ZznGcnKVFKrIzQKLfZMT4fP6BOaMEtM0KQkWfsDy6FhqgVmr+e3HhsL8tbv67RCHdY
         8D66KlZdJ06M8bOjelzhdJYnTsXnUjdcgiQnAfB5oD0tQrTakxlhY5jnZevBotmmc8TA
         FmfCM2nACKsT8jngURW8UYAEklj6NwCtWQKUzLzI6/noeVkWm2PVVQU8O1F4Qtjo7Xnl
         RodbHXpYSp1OvDwkvLYgAG/KCofZRBrQVq6QLU6KzdKrmYxO3nPj7llOwopbm/9MTxLa
         2fHaHiP6yjU2KwZ6Bia09gaDAIpVv/4Cp7HxUMdP1xC6W3Vl/YxB2Tef3sq9aAf0k1Tx
         gYtg==
X-Gm-Message-State: AAQBX9dNh992uCwWJlxF5GEv+qs+DLJQc2AkywqNhRvJMs5uo9Pk0+QD
        LrJHtmzpA5zGvqi6HNoySKqAng+PwKt/ZN6RK2rbaQ==
X-Google-Smtp-Source: AKy350Z7XkeY1Z5FaiRTBtMIj6ikoLFWRLLfwU2RuOv3WM1UklrkvhmflnYaEhppLtJJtW3Rx3YDD5cI/kClwLuG+vk=
X-Received: by 2002:a05:6902:154e:b0:b77:d2db:5f8f with SMTP id
 r14-20020a056902154e00b00b77d2db5f8fmr15777111ybu.12.1680201575795; Thu, 30
 Mar 2023 11:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230330105418.77061-1-cerasuolodomenico@gmail.com> <20230330105418.77061-2-cerasuolodomenico@gmail.com>
In-Reply-To: <20230330105418.77061-2-cerasuolodomenico@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 30 Mar 2023 11:39:24 -0700
Message-ID: <CAJuCfpHovRJoqbkVCYMtTviRa=+W9cdGqMUpoQKs535uq-rkww@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] sched/psi: rearrange polling code in preparation
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
> Move a few functions up in the file to avoid forward declaration needed
> in the patch implementing unprivileged PSI triggers.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/sched/psi.c | 196 ++++++++++++++++++++++-----------------------
>  1 file changed, 98 insertions(+), 98 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 02e011cabe91..fe9269f1d2a4 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -384,92 +384,6 @@ static void collect_percpu_times(struct psi_group *g=
roup,
>                 *pchanged_states =3D changed_states;
>  }
>
> -static u64 update_averages(struct psi_group *group, u64 now)
> -{
> -       unsigned long missed_periods =3D 0;
> -       u64 expires, period;
> -       u64 avg_next_update;
> -       int s;
> -
> -       /* avgX=3D */
> -       expires =3D group->avg_next_update;
> -       if (now - expires >=3D psi_period)
> -               missed_periods =3D div_u64(now - expires, psi_period);
> -
> -       /*
> -        * The periodic clock tick can get delayed for various
> -        * reasons, especially on loaded systems. To avoid clock
> -        * drift, we schedule the clock in fixed psi_period intervals.
> -        * But the deltas we sample out of the per-cpu buckets above
> -        * are based on the actual time elapsing between clock ticks.
> -        */
> -       avg_next_update =3D expires + ((1 + missed_periods) * psi_period)=
;
> -       period =3D now - (group->avg_last_update + (missed_periods * psi_=
period));
> -       group->avg_last_update =3D now;
> -
> -       for (s =3D 0; s < NR_PSI_STATES - 1; s++) {
> -               u32 sample;
> -
> -               sample =3D group->total[PSI_AVGS][s] - group->avg_total[s=
];
> -               /*
> -                * Due to the lockless sampling of the time buckets,
> -                * recorded time deltas can slip into the next period,
> -                * which under full pressure can result in samples in
> -                * excess of the period length.
> -                *
> -                * We don't want to report non-sensical pressures in
> -                * excess of 100%, nor do we want to drop such events
> -                * on the floor. Instead we punt any overage into the
> -                * future until pressure subsides. By doing this we
> -                * don't underreport the occurring pressure curve, we
> -                * just report it delayed by one period length.
> -                *
> -                * The error isn't cumulative. As soon as another
> -                * delta slips from a period P to P+1, by definition
> -                * it frees up its time T in P.
> -                */
> -               if (sample > period)
> -                       sample =3D period;
> -               group->avg_total[s] +=3D sample;
> -               calc_avgs(group->avg[s], missed_periods, sample, period);
> -       }
> -
> -       return avg_next_update;
> -}
> -
> -static void psi_avgs_work(struct work_struct *work)
> -{
> -       struct delayed_work *dwork;
> -       struct psi_group *group;
> -       u32 changed_states;
> -       u64 now;
> -
> -       dwork =3D to_delayed_work(work);
> -       group =3D container_of(dwork, struct psi_group, avgs_work);
> -
> -       mutex_lock(&group->avgs_lock);
> -
> -       now =3D sched_clock();
> -
> -       collect_percpu_times(group, PSI_AVGS, &changed_states);
> -       /*
> -        * If there is task activity, periodically fold the per-cpu
> -        * times and feed samples into the running averages. If things
> -        * are idle and there is no data to process, stop the clock.
> -        * Once restarted, we'll catch up the running averages in one
> -        * go - see calc_avgs() and missed_periods.
> -        */
> -       if (now >=3D group->avg_next_update)
> -               group->avg_next_update =3D update_averages(group, now);
> -
> -       if (changed_states & PSI_STATE_RESCHEDULE) {
> -               schedule_delayed_work(dwork, nsecs_to_jiffies(
> -                               group->avg_next_update - now) + 1);
> -       }
> -
> -       mutex_unlock(&group->avgs_lock);
> -}
> -
>  /* Trigger tracking window manipulations */
>  static void window_reset(struct psi_window *win, u64 now, u64 value,
>                          u64 prev_growth)
> @@ -516,18 +430,6 @@ static u64 window_update(struct psi_window *win, u64=
 now, u64 value)
>         return growth;
>  }
>
> -static void init_triggers(struct psi_group *group, u64 now)
> -{
> -       struct psi_trigger *t;
> -
> -       list_for_each_entry(t, &group->triggers, node)
> -               window_reset(&t->win, now,
> -                               group->total[PSI_POLL][t->state], 0);
> -       memcpy(group->polling_total, group->total[PSI_POLL],
> -                  sizeof(group->polling_total));
> -       group->polling_next_update =3D now + group->poll_min_period;
> -}
> -
>  static u64 update_triggers(struct psi_group *group, u64 now)
>  {
>         struct psi_trigger *t;
> @@ -590,6 +492,104 @@ static u64 update_triggers(struct psi_group *group,=
 u64 now)
>         return now + group->poll_min_period;
>  }
>
> +static u64 update_averages(struct psi_group *group, u64 now)
> +{
> +       unsigned long missed_periods =3D 0;
> +       u64 expires, period;
> +       u64 avg_next_update;
> +       int s;
> +
> +       /* avgX=3D */
> +       expires =3D group->avg_next_update;
> +       if (now - expires >=3D psi_period)
> +               missed_periods =3D div_u64(now - expires, psi_period);
> +
> +       /*
> +        * The periodic clock tick can get delayed for various
> +        * reasons, especially on loaded systems. To avoid clock
> +        * drift, we schedule the clock in fixed psi_period intervals.
> +        * But the deltas we sample out of the per-cpu buckets above
> +        * are based on the actual time elapsing between clock ticks.
> +        */
> +       avg_next_update =3D expires + ((1 + missed_periods) * psi_period)=
;
> +       period =3D now - (group->avg_last_update + (missed_periods * psi_=
period));
> +       group->avg_last_update =3D now;
> +
> +       for (s =3D 0; s < NR_PSI_STATES - 1; s++) {
> +               u32 sample;
> +
> +               sample =3D group->total[PSI_AVGS][s] - group->avg_total[s=
];
> +               /*
> +                * Due to the lockless sampling of the time buckets,
> +                * recorded time deltas can slip into the next period,
> +                * which under full pressure can result in samples in
> +                * excess of the period length.
> +                *
> +                * We don't want to report non-sensical pressures in
> +                * excess of 100%, nor do we want to drop such events
> +                * on the floor. Instead we punt any overage into the
> +                * future until pressure subsides. By doing this we
> +                * don't underreport the occurring pressure curve, we
> +                * just report it delayed by one period length.
> +                *
> +                * The error isn't cumulative. As soon as another
> +                * delta slips from a period P to P+1, by definition
> +                * it frees up its time T in P.
> +                */
> +               if (sample > period)
> +                       sample =3D period;
> +               group->avg_total[s] +=3D sample;
> +               calc_avgs(group->avg[s], missed_periods, sample, period);
> +       }
> +
> +       return avg_next_update;
> +}
> +
> +static void psi_avgs_work(struct work_struct *work)
> +{
> +       struct delayed_work *dwork;
> +       struct psi_group *group;
> +       u32 changed_states;
> +       u64 now;
> +
> +       dwork =3D to_delayed_work(work);
> +       group =3D container_of(dwork, struct psi_group, avgs_work);
> +
> +       mutex_lock(&group->avgs_lock);
> +
> +       now =3D sched_clock();
> +
> +       collect_percpu_times(group, PSI_AVGS, &changed_states);
> +       /*
> +        * If there is task activity, periodically fold the per-cpu
> +        * times and feed samples into the running averages. If things
> +        * are idle and there is no data to process, stop the clock.
> +        * Once restarted, we'll catch up the running averages in one
> +        * go - see calc_avgs() and missed_periods.
> +        */
> +       if (now >=3D group->avg_next_update)
> +               group->avg_next_update =3D update_averages(group, now);
> +
> +       if (changed_states & PSI_STATE_RESCHEDULE) {
> +               schedule_delayed_work(dwork, nsecs_to_jiffies(
> +                               group->avg_next_update - now) + 1);
> +       }
> +
> +       mutex_unlock(&group->avgs_lock);
> +}
> +
> +static void init_triggers(struct psi_group *group, u64 now)
> +{
> +       struct psi_trigger *t;
> +
> +       list_for_each_entry(t, &group->triggers, node)
> +               window_reset(&t->win, now,
> +                               group->total[PSI_POLL][t->state], 0);
> +       memcpy(group->polling_total, group->total[PSI_POLL],
> +                  sizeof(group->polling_total));
> +       group->polling_next_update =3D now + group->poll_min_period;
> +}
> +
>  /* Schedule polling if it's not already scheduled or forced. */
>  static void psi_schedule_poll_work(struct psi_group *group, unsigned lon=
g delay,
>                                    bool force)
> --
> 2.34.1
>
