Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5F76D0DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjC3SmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjC3SmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:42:18 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4147DB47F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:41:56 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54606036bb3so205702177b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680201715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuDMn6P7Z2xA2wNTODZxRvKct0qb2Oq2fx7bHl56wB4=;
        b=FNpuin+9s4I9hIWYwj68QpSebPmTCTcfmJTXEXesB4qPk3FwXQ4ooJnw2YA2H1uyKT
         3J7solrzwX2OsWuGUV3TmEE/IH5IPtojZazQqpZnQxFkx/AFvQVDbrAOzLDqWc4YkBtp
         GSKNPkV5pRNondPdfgNLxPuaBmEaX96EmOyJNG9BU8IIF3s7vDah4d4g3F/QRKbk5ZFC
         MVXRUStc28+rkrzdeLT3ZeMj8sxXq9KMGcR7ifFp4YRt6FBLgbLrKUQwY1YsGjnpFSEQ
         iUJzPXoa3rs6W1WoLr3lzg2aOXRruc3KdZz1Pv3wU39nEoGhlR+r5kJw/lxBITWbAcdp
         ypXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuDMn6P7Z2xA2wNTODZxRvKct0qb2Oq2fx7bHl56wB4=;
        b=IPZ98x4O25ZazPOnYpJMnA2hbxh8/SD3yfXayOIcxtnSF2TEMS/bqUY5qnvHwLDAPk
         T0Ya6QIbGppUBUbgNzVD8R6+ltCvSv0vx3it3fkzJU7QOxG/ypGW18oHAnaqSarCmMLv
         NQJtt6FK1iE4NYWvnxSZTcblV6RYz7/XxE56kTgMd8P+NHbMM7AJWZk3OoNayvl6fF8j
         KMX+VjJI69wxFzA6nBVeESEFuqzvQHozWmch+8cHF3JbVq8kdGINqt4KdmtvFVBdPewM
         KODRuOTIypXbPtpbFP0NECSbFZNyv7hyO5J1RU+WkJEWOprqahfpWuxl+fV7dpgjKv6t
         bjqg==
X-Gm-Message-State: AAQBX9e9SyFdzgc7w2Ty9GEwWzQnuET7zS9fbqeVGjSK8xu36ZKgaava
        d46aVenYGB5BaFLwzsEUzkMsF5EqSEdUEOh37c7Vyg==
X-Google-Smtp-Source: AKy350YD4593PQOGpM34PzJkgUDm5H/kQuSDCumynzYcPXl+i3oAJIvl0t1AzkoqV6nHbDHVyvDWF/UMDOiZwq3U+zQ=
X-Received: by 2002:a81:4413:0:b0:546:2cae:de0c with SMTP id
 r19-20020a814413000000b005462caede0cmr3467510ywa.1.1680201715274; Thu, 30 Mar
 2023 11:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230330105418.77061-1-cerasuolodomenico@gmail.com> <20230330105418.77061-4-cerasuolodomenico@gmail.com>
In-Reply-To: <20230330105418.77061-4-cerasuolodomenico@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 30 Mar 2023 11:41:44 -0700
Message-ID: <CAJuCfpE6vcnkEu5TYDbLhWjFq5DKuoTf5ka7tT0uXeutjQAkGw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] sched/psi: extract update_triggers side effect
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
> This change moves update_total flag out of update_triggers function,
> currently called only in psi_poll_work.
> In the next patch, update_triggers will be called also in psi_avgs_work,
> but the total update information is specific to psi_poll_work.
> Returning update_total value to the caller let us avoid differentiating
> the implementation of update_triggers for different aggregators.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/sched/psi.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index a3d0b5cf797a..f3df6a8ff493 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -430,11 +430,11 @@ static u64 window_update(struct psi_window *win, u6=
4 now, u64 value)
>         return growth;
>  }
>
> -static u64 update_triggers(struct psi_group *group, u64 now)
> +static u64 update_triggers(struct psi_group *group, u64 now, bool *updat=
e_total)
>  {
>         struct psi_trigger *t;
> -       bool update_total =3D false;
>         u64 *total =3D group->total[PSI_POLL];
> +       *update_total =3D false;
>
>         /*
>          * On subsequent updates, calculate growth deltas and let
> @@ -462,7 +462,7 @@ static u64 update_triggers(struct psi_group *group, u=
64 now)
>                          * been through all of them. Also remember to ext=
end the
>                          * polling time if we see new stall activity.
>                          */
> -                       update_total =3D true;
> +                       *update_total =3D true;
>
>                         /* Calculate growth since last update */
>                         growth =3D window_update(&t->win, now, total[t->s=
tate]);
> @@ -485,10 +485,6 @@ static u64 update_triggers(struct psi_group *group, =
u64 now)
>                 t->pending_event =3D false;
>         }
>
> -       if (update_total)
> -               memcpy(group->rtpoll_total, total,
> -                               sizeof(group->rtpoll_total));
> -
>         return now + group->rtpoll_min_period;
>  }
>
> @@ -622,6 +618,7 @@ static void psi_rtpoll_work(struct psi_group *group)
>  {
>         bool force_reschedule =3D false;
>         u32 changed_states;
> +       bool update_total;
>         u64 now;
>
>         mutex_lock(&group->rtpoll_trigger_lock);
> @@ -686,8 +683,12 @@ static void psi_rtpoll_work(struct psi_group *group)
>                 goto out;
>         }
>
> -       if (now >=3D group->rtpoll_next_update)
> -               group->rtpoll_next_update =3D update_triggers(group, now)=
;
> +       if (now >=3D group->rtpoll_next_update) {
> +               group->rtpoll_next_update =3D update_triggers(group, now,=
 &update_total);
> +               if (update_total)
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
