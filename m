Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D016A363E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 02:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjB0BwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 20:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0BwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 20:52:08 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5416F12BF1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 17:52:07 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id o12so4091836oik.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 17:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec/hy2r/KP9yazz+gE19fIWcuXP7QDeInxQr+2fEHmI=;
        b=UP4FmEaVx8d0JSfrVIkchsp4RyEIZJmzEyVTYyoRw6JmeDsHy46FXl8QmeZ5K9c2hw
         M2DEcWrplhGJZ3ZBofJsTEifmUUouU0OxjGL0bq5UZPXWD4Q/rR5HTMJwaFcfJgkU1R7
         N0B8Rkj8D1PfJphQzU29BETCxbnZ5ErgIImzo+p/Am5m9+islySzaOp3dgsxQg0j2tBq
         B6SP7InSiLpoKnC3qcpREqsQVFX9zvLUIXb+2bONqiPtMSAE0sTk32zGusWI9g/WdLQr
         4NmQlB/PggwQwjYEM4TQPljakXl286aM5yYYiow/pa2MHp5btE1UwPJRfUXFUDIDRAN+
         K2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec/hy2r/KP9yazz+gE19fIWcuXP7QDeInxQr+2fEHmI=;
        b=zEIzfI3JusnlcEO3mjICbKbInPO9ONzVfUwvraIvqwpYZxP2Flu3H0pHlzwPSIOUxF
         Oa052YtrYp8MTnX/qUuScDhhko8zByiC0KCg1Tl7WeYtYDqhG6zm94C8RL9XY8dcns5b
         QxfpBHYZyLJPKIGFrTy9W8nlGQJ8aXfrgR3UeOFOGYLk3g5uo1fp3NdFBjaR2j7ot+lM
         y9j2VyX0OptX2ABTEs6/NTtVGSaVZXvQh95BJnDJq0wV7YiUJ48CRr2JbIpiPnoKlVnl
         Amwr0cDzcovuRqIBhPBOLbEVdFmNV6GF4dCej5JVKlakbRqmTz3BzEb2SvN0G9y+Picx
         q1Sw==
X-Gm-Message-State: AO0yUKWPyXZM1LJwol88a8brYDxq7r6CFOtaoJdzGYJ2o0cUeMFQFOHB
        Lt3b+71DzZfPPYzMMqgfZqJE+2CTsz/4h2EJyms=
X-Google-Smtp-Source: AK7set+2qS+ZlrUf+UXN9GxZvW0DwfszftvbAiv5mERUvRZYkYa49kwlviTLp1VIJTU+ZcCmqpSuKETCZRO7b/jgnW4=
X-Received: by 2002:a54:4781:0:b0:378:573b:ca8d with SMTP id
 o1-20020a544781000000b00378573bca8dmr3591778oic.6.1677462726595; Sun, 26 Feb
 2023 17:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20230222080314.2146-1-xuewen.yan@unisoc.com>
In-Reply-To: <20230222080314.2146-1-xuewen.yan@unisoc.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 27 Feb 2023 09:51:55 +0800
Message-ID: <CAB8ipk-+i98-RyWvYnz+OVyf8d=GR5zE2s7++q9t5-Geo4UFhw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Looking forward to your comments.

Thanks=EF=BC=81

On Wed, Feb 22, 2023 at 4:21 PM Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
> When task call the sched_yield, cfs would set the cfs's skip buddy.
> If there is no other task call the sched_yield syscall, the task would
> always be skiped when there are tasks in rq. As a result, the task's
> vruntime would not be updated for long time, and the cfs's min_vruntime
> is almost not updated.
> When this scenario happens, when the yield task had wait for a long time,
> and other tasks run a long time, once there is other task call the sched_=
yield,
> the cfs's skip_buddy is covered, at this time, the first task can run nor=
mally,
> but the task's vruntime is small, as a result, the task would always run,
> because other task's vruntime is big. This would lead to other tasks can =
not
> run for a long time.
> In order to mitigate this, update the yield_task's vruntime to be cfs's m=
ax vruntime.
> This way, the cfs's min vruntime can be updated as the process running.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff4dbbae3b10..a9ff1921fc07 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -670,7 +670,6 @@ static struct sched_entity *__pick_next_entity(struct=
 sched_entity *se)
>         return __node_2_se(next);
>  }
>
> -#ifdef CONFIG_SCHED_DEBUG
>  struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
>  {
>         struct rb_node *last =3D rb_last(&cfs_rq->tasks_timeline.rb_root)=
;
> @@ -681,6 +680,7 @@ struct sched_entity *__pick_last_entity(struct cfs_rq=
 *cfs_rq)
>         return __node_2_se(last);
>  }
>
> +#ifdef CONFIG_SCHED_DEBUG
>  /**************************************************************
>   * Scheduling class statistics methods:
>   */
> @@ -7751,8 +7751,18 @@ static void set_next_buddy(struct sched_entity *se=
)
>
>  static void set_skip_buddy(struct sched_entity *se)
>  {
> -       for_each_sched_entity(se)
> -               cfs_rq_of(se)->skip =3D se;
> +       for_each_sched_entity(se) {
> +               struct sched_entity *last;
> +               struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> +
> +               last =3D __pick_last_entity(cfs_rq);
> +               if (last) {
> +                       se->vruntime =3D last->vruntime;
> +                       update_min_vruntime(cfs_rq);
> +               }
> +
> +               cfs_rq->skip =3D se;
> +       }
>  }
>
>  /*
> --
> 2.25.1
>
