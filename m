Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53166C235C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCTVG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCTVGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:06:25 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EE115899
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:06:24 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5418d54d77bso246233567b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679346383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKe7+KSQUQAzNlmMzv9Shy9QIzbeQYOv+5OEuVwBivs=;
        b=Lk+hRioaGrZjtn94HT1wPQbi5fP1pDvEhTamUBsUzb8oNloF0//ftOQYvW3jFQG83E
         TRUBf6FxBWDGtjGNPquGXT3acgb9jhs9nGYTKpNcrlMV51qH1nRi/1/savgzH/oR8Ks5
         VQhGNhHgNFiECL7fzWvFo624j5HBiqxhKg4iCIORz3YGkZULyiu0WH4ysCuPXrrEWXBj
         3PB2kv6hJsVhKM0Cyq5Jk8rD3n6TOYPuMDBr+Vr0v5WUdmreC1P6V+AQHQ17qSMCXNH6
         K9LihUqmZSWNkPyRHhRCmpb6Og3PPI5FNDjT/pi5boPtVU085zDWhfz1Xp7xSdPXGtPn
         lQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679346383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKe7+KSQUQAzNlmMzv9Shy9QIzbeQYOv+5OEuVwBivs=;
        b=tY8s3zoll/ange6svhNGkwfQ4q3Cit8aUa54MWTd9ca8sueWOgmhEyVUQTfWXbm7i7
         iVlZUtZ9vdKWdLe35tE/5avowPIsa7T9cH73KNZdyZ78J8KHAW1fqVUaDGvtKOUzoVa8
         /ix2wDpfOsjcIOXeP3oI/QMV0c7tspmL4WorbnN2cXQuMqyr1DpCkiBzfWu1Vl4lLyX0
         yYjKwC0AJrOsCtaz1dcqPoAfEpNSUmr6ycBi1kVz6nlaQu6vw4wfeiLtzMpf607v5OLq
         baZESkKwDC+5VfziJRwjXXhIVC2ZaB8ansuJhltNlxZyjvizaQzp/ApnrMmQQgW3aNj3
         F21Q==
X-Gm-Message-State: AO0yUKWEkfU6Toh6ltx5nuAXMsX+6Vj93TwJBh90lbena1iSZME3Urhy
        yo8AR+2bnugvZX89m1UhzVYTQ2ls57rkKqDJ/q/pig==
X-Google-Smtp-Source: AK7set8mC33XeinW2XZaxcyProJsH+iPCBw839uQgmtx5WIXoAYCqyZqznzS1uFaChWVTv9EKRoKIzZtPJkYQUdeGcI=
X-Received: by 2002:a81:4517:0:b0:536:38b4:f50 with SMTP id
 s23-20020a814517000000b0053638b40f50mr10963785ywa.1.1679346383149; Mon, 20
 Mar 2023 14:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230309170756.52927-1-cerasuolodomenico@gmail.com> <20230309170756.52927-2-cerasuolodomenico@gmail.com>
In-Reply-To: <20230309170756.52927-2-cerasuolodomenico@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 20 Mar 2023 14:06:11 -0700
Message-ID: <CAJuCfpGJBYSahyDGpPTJoMOSN-U4mXvpgoGnj8k2UV0WGyB_pg@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/psi: rearrange polling code in preparation
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
> Move a few functions up in the file to avoid forward declaration needed
> in the patch implementing unprivileged PSI triggers.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

LGTM. Will Ack when we finalize the rest of the patchset.

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
