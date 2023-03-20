Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403476C2550
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCTXBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCTXBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:01:00 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03E9193D5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:00:58 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536af432ee5so251786477b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679353258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vspmQc3JDpsi+UTHxEZIu3eH7ZE8AqrnMjkOoGXoeD8=;
        b=CxTVfnU0Fvu8KqXA0gYr9Fwgp4S0NFyt58jK8Glp806aMat0X3sHnQUrz7lo/H5iUH
         57Rk9b/qj9qvyGUGZnqgOjhmJ73vAjRaihJ2gxiKYJplNNZQYx1mx4OKXqkHgf4EQxXV
         WQbRuk4yAeIHM4v+m7P04aalG13/pd15SzuGqwFSzo3AaIfLpxXlxx01tkOudVOS3YB6
         yKbga7EigI2ynqbh7qlisDDcBZdV1qlV1xmBgwZBP9xjXnh8gfWWadPLlhD8fQF1t16k
         3sncA7Zpx+Kr63JylZzd5fSo9YfOGuPsUj9M/pGzNgK9XgebZCHCZ5USj8LQ5H0OzyOw
         UaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vspmQc3JDpsi+UTHxEZIu3eH7ZE8AqrnMjkOoGXoeD8=;
        b=cB5Rs5jy73U4Ckh7MPdejGPx11EmcGvl07kwQ+ZRX9SKBQ7rNhozSpXVNCvrXuzW3J
         ALFSIETl3PqCK1VIgHYh52HbXNh0m8Sv+LUevRBxb7JH7YcUkhQwK+Jd5fcRJapHxJtS
         vT0Clp/nUHmiCZIc8w4OmICekXgzCDqmIEcBElOYFNtbq32vjYegqBQkSWiYAFitZslW
         XgyHRn+pN2fjvo7l5CeHMeBNw08+NX/MKaOCGton/pcM1yuaNNM+dRFhtxKdtsenE0Qn
         FrsIDl3boqg0TQ+GGgQWaTB/c4BHNeK3jaVZ/g+SR9yOk2jmzVWqqRtpIUnS4OKVrsQn
         57lQ==
X-Gm-Message-State: AO0yUKWBLwz1GZhoezLOEq/U2eMLJ1jtW76tU+rTC/3fI5dcrVCimLly
        JbYcbkeV1VcHNPz7GczK0uoljXmO362T6qQ98YIFZw==
X-Google-Smtp-Source: AK7set93KNjCrR7yh8Yn/FAOZ63fe9YnG03KkGBEDRWJq8mBAwo31qgl9tS3X6UasPkhS+23FD4KzwqiwQCGX2RB0xQ=
X-Received: by 2002:a05:690c:731:b0:544:8405:e1f9 with SMTP id
 bt17-20020a05690c073100b005448405e1f9mr10760518ywb.1.1679353257953; Mon, 20
 Mar 2023 16:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230309170756.52927-1-cerasuolodomenico@gmail.com> <20230309170756.52927-4-cerasuolodomenico@gmail.com>
In-Reply-To: <20230309170756.52927-4-cerasuolodomenico@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 20 Mar 2023 16:00:46 -0700
Message-ID: <CAJuCfpE18RYymcpzKZDapQg35ew5BiUPepnbS7cj+z6H5--Huw@mail.gmail.com>
Subject: Re: [PATCH 3/4] sched/psi: extract update_triggers side effect
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
> The update of rtpoll_total inside update_triggers can be moved out of
> the function since changed_states has the same information as the
> update_total flag used in the function. Besides the simplification of
> the function, with the next patch it would become an unwanted side
> effect needed only for PSI_POLL.

(changed_states & group->rtpoll_states) and update_total flag are not
really equivalent. update_total flag depends on the difference between
group->polling_total[state] and group->total[PSI_POLL][state] while
changed_states depends on the difference between groupc->times and
groupc->times_prev. groupc->times_prev is updated every time
collect_percpu_times() is called and there are 3 places where that
happens: from psi_avgs_work(), from psi_poll_work() and from
psi_show(). group->polling_total[state] is updated only from
psi_poll_work(). Therefore the deltas between these values might not
always be in-sync.

Consider the following sequence as an example:

psi_poll_work()
...
psi_avgs_work()/psi_show()
  collect_percpu_times() // we detect a change in a monitored state
...
psi_poll_work()
  collect_percpu_times() // this time no change in monitored states
  update_triggers() // group->polling_total[state] !=3D
group->total[PSI_POLL][state]

In the last psi_poll_work() collect_percpu_times() recorded no change
in monitored states, so (changed_states & group->rtpoll_states) =3D=3D 0,
however since the last time psi_poll_work() was called there was
actually a change in monitored states recorded by the first
collect_percpu_times(), therefore (group->polling_total[t->state] !=3D
total[t->state]) and we should update the totals. With your change we
will miss that update.

I think you can easily fix that by introducing update_triggers as an
output parameter in window_update() like this:

static u64 window_update(struct psi_window *win, u64 now, u64 value,
bool *update_triggers) {
    *update_total =3D false;
...
    if (new_stall) {
        *update_total =3D true;
...
}

static void psi_rtpoll_work(struct psi_group *group) {
+       bool update_triggers;
...
-       if (now >=3D group->rtpoll_next_update)
+       if (now >=3D group->rtpoll_next_update) {
                group->rtpoll_next_update =3D update_triggers(group,
now, &update_triggers);
+               if (update_triggers)
+                       memcpy(group->rtpoll_total, group->total[PSI_POLL],
+                                  sizeof(group->rtpoll_total));
+       }
}


>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  kernel/sched/psi.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index a3d0b5cf797a..476941c1cbea 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -433,7 +433,6 @@ static u64 window_update(struct psi_window *win, u64 =
now, u64 value)
>  static u64 update_triggers(struct psi_group *group, u64 now)
>  {
>         struct psi_trigger *t;
> -       bool update_total =3D false;
>         u64 *total =3D group->total[PSI_POLL];
>
>         /*
> @@ -456,14 +455,6 @@ static u64 update_triggers(struct psi_group *group, =
u64 now)
>                  * events without dropping any).
>                  */
>                 if (new_stall) {
> -                       /*
> -                        * Multiple triggers might be looking at the same=
 state,
> -                        * remember to update group->polling_total[] once=
 we've
> -                        * been through all of them. Also remember to ext=
end the
> -                        * polling time if we see new stall activity.
> -                        */
> -                       update_total =3D true;
> -
>                         /* Calculate growth since last update */
>                         growth =3D window_update(&t->win, now, total[t->s=
tate]);
>                         if (!t->pending_event) {
> @@ -484,11 +475,6 @@ static u64 update_triggers(struct psi_group *group, =
u64 now)
>                 /* Reset threshold breach flag once event got generated *=
/
>                 t->pending_event =3D false;
>         }
> -
> -       if (update_total)
> -               memcpy(group->rtpoll_total, total,
> -                               sizeof(group->rtpoll_total));
> -
>         return now + group->rtpoll_min_period;
>  }
>
> @@ -686,8 +672,12 @@ static void psi_rtpoll_work(struct psi_group *group)
>                 goto out;
>         }
>
> -       if (now >=3D group->rtpoll_next_update)
> +       if (now >=3D group->rtpoll_next_update) {
>                 group->rtpoll_next_update =3D update_triggers(group, now)=
;
> +               if (changed_states & group->rtpoll_states)
> +                       memcpy(group->rtpoll_total, group->total[PSI_POLL=
],
> +                                  sizeof(group->rtpoll_total));
> +       }
>
>         psi_schedule_rtpoll_work(group,
>                 nsecs_to_jiffies(group->rtpoll_next_update - now) + 1,
> --
> 2.34.1
>
