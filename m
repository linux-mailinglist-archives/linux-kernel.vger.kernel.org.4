Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4816E8539
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjDSWt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjDSWtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:49:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46282710
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:49:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a6e5be6224so250915ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681944577; x=1684536577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGNFq9WKvp9RnYp+YVMKqFOBOtDNqLLYG1+UgzsFJ20=;
        b=4oDVAshZ4gegRjWzLg6MpPXz4a0pz+EV7itll8/EUMS27jHWqP21T6DtkBUhcUIeEO
         87IPGDyCS/74WysMNRfe0mWu+yk/B4SkLSTgYRiDmdU+ktP0Qp40dGhBGqYm7dBESz+j
         /8pqHdr6+U2CBE69A8mAJImn9vGY0i2i3lnAJ6Y7lgqdRxW16bSfoIFtXvu7TnkpOHVa
         MuS/+1ALMLIV739zOcyUjZhliPx/GJDP77zIG7aGiGbQL8ibta56puahk4bgH4s7K4jL
         Nm6LYhDA5G52DnA6tlmlOvoxyF0Yy+6i2JDC1UDCpCsvaifyxVH/X5mNj+qQSDI2odM1
         KgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681944577; x=1684536577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGNFq9WKvp9RnYp+YVMKqFOBOtDNqLLYG1+UgzsFJ20=;
        b=Kkz0ROTE9qErVmS2uxiWfuDtvOP0He9mU+xVoo7SaZD4ER5Sfki0zdxQ6oJVOgshfW
         iehipATBogYAtfsCFDBm8KAG/5zd/fbyXJioVxxD0bwvkj01AmMoV+zEhpj1mfC+i/dy
         Rb2ybN7szHgozo4BVBuHvK9GAyi13Qm5CgCon1UrXbtPwDoK5tCIdzijD6w+Pfd4Y+3W
         9XRYnSB1eGDL4hrgp6g971ySu6HhHAiITXKNklmkusc2H7Zm82Tc4t2BsdrADyo6kWo2
         BDECgufGlnwbqp8iJhFoQczpvNKFTGQGoHsjWJG4ANZRC2fmHAN3OiB3QG56rV6cbOUs
         rWWg==
X-Gm-Message-State: AAQBX9eJi06jkfVriHjzDORFKxfgEhKvMVz9duQGr7TrhNt9Ik3BxC3s
        WAnGuntpQKOIrZe6cI4UniE35gDt5ebI42qFnI9UXQ==
X-Google-Smtp-Source: AKy350ZLQk2Z+fwV2VmsllIFmScUU1Qg3N0/V2C+YIg5mUFgFeyBwoDteWtqE3xsFf0CEVyJUM9ON+0SOw0LJORNIDs=
X-Received: by 2002:a17:903:1387:b0:1a6:42f0:e575 with SMTP id
 jx7-20020a170903138700b001a642f0e575mr32135plb.5.1681944577118; Wed, 19 Apr
 2023 15:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230416213406.2966521-1-davidai@google.com> <20230419175414.ycnlaperdkjxgypx@airbuntu>
In-Reply-To: <20230419175414.ycnlaperdkjxgypx@airbuntu>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 19 Apr 2023 15:49:00 -0700
Message-ID: <CAGETcx8tnPgL0ekMKHvAs30NwsEzWZuCoF_BgUyMk7iJPuSGhw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce SCHED_FLAG_RESET_UCLAMP_ON_FORK
 flag
To:     Qais Yousef <qyousef@layalina.io>
Cc:     David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 10:54=E2=80=AFAM Qais Yousef <qyousef@layalina.io> =
wrote:
>
> Hi David!
>
> On 04/16/23 14:34, David Dai wrote:
> > A userspace service may manage uclamp dynamically for individual tasks =
and
> > a child task will unintentionally inherit a pesudo-random uclamp settin=
g.
> > This could result in the child task being stuck with a static uclamp va=
lue
> > that results in poor performance or poor power.
> >
> > Using SCHED_FLAG_RESET_ON_FORK is too coarse for this usecase and will
> > reset other useful scheduler attributes. Adding a
> > SCHED_FLAG_RESET_UCLAMP_ON_FORK will allow userspace to have finer cont=
rol
> > over scheduler attributes of child processes.
>
> Thanks a lot for the patch. This has a been a known limitation for a whil=
e but
> didn't manage to find the time to push anything yet.
>
> ADPF (Android Dynamic Performance Framework) exposes APIs to manage perfo=
rmance
> for a set of pids [1]. Only these tasks belong to the session and any for=
ked
> tasked is expected to have its uclamp values reset. But as you pointed ou=
t, the
> current RESET_ON_FORK resets everything, but we don't want that as these
> attributes don't belong to ADPF to decide whether they should be reset to=
o or
> not. And not resetting them means we can end up with tasks inheriting ran=
dom
> uclamp values unintentionally. We can't tell these tasks not to fork anyt=
hing.
> If the forked tasks are expected to be part of the session, then their pi=
ds
> must be added explicitly.
>
> [1] https://developer.android.com/reference/android/os/PerformanceHintMan=
ager#createHintSession(int%5B%5D,%20long)
>
> >
> > Cc: Qais Yousef <qyousef@google.com>
> > Cc: Quentin Perret <qperret@google.com>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: David Dai <davidai@google.com>
> > ---
> >  include/linux/sched.h            | 3 +++
> >  include/uapi/linux/sched.h       | 4 +++-
> >  kernel/sched/core.c              | 6 +++++-
> >  tools/include/uapi/linux/sched.h | 4 +++-
> >  4 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 63d242164b1a..b1676b9381f9 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -885,6 +885,9 @@ struct task_struct {
> >       unsigned                        sched_reset_on_fork:1;
>
> nit: can't we convert to a flag and re-use?
>
> >       unsigned                        sched_contributes_to_load:1;
> >       unsigned                        sched_migrated:1;
> > +#ifdef CONFIG_UCLAMP_TASK
> > +     unsigned                        sched_reset_uclamp_on_fork:1;
> > +#endif
> >
> >       /* Force alignment to the next boundary: */
> >       unsigned                        :0;
> > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > index 3bac0a8ceab2..7515106e1f1a 100644
> > --- a/include/uapi/linux/sched.h
> > +++ b/include/uapi/linux/sched.h
> > @@ -132,12 +132,14 @@ struct clone_args {
> >  #define SCHED_FLAG_KEEP_PARAMS               0x10
> >  #define SCHED_FLAG_UTIL_CLAMP_MIN    0x20
> >  #define SCHED_FLAG_UTIL_CLAMP_MAX    0x40
> > +#define SCHED_FLAG_RESET_UCLAMP_ON_FORK      0x80
> >
> >  #define SCHED_FLAG_KEEP_ALL  (SCHED_FLAG_KEEP_POLICY | \
> >                                SCHED_FLAG_KEEP_PARAMS)
> >
> >  #define SCHED_FLAG_UTIL_CLAMP        (SCHED_FLAG_UTIL_CLAMP_MIN | \
> > -                              SCHED_FLAG_UTIL_CLAMP_MAX)
> > +                              SCHED_FLAG_UTIL_CLAMP_MAX | \
> > +                              SCHED_FLAG_RESET_UCLAMP_ON_FORK)
>
> I was considering to have something a bit more generic that allows select=
ing
> which attributes to reset.
>
> For example a syscall with SCHED_FLAG_RESET_ON_FORK_SEL combined with
> SCHED_FLAG_UCLAMP_MIN/MAX will only reset those. This should make it exte=
nsible
> if we have other similar use cases in the future. The downside it *might*
> require to be done in a separate syscall to the one that sets these param=
eter.
> But it should be done once.

In addition to the downside you mentioned, I'm not a huge fan of this
suggestion since the meaning of the SCHED_FLAG_RESET_ON_FORK_SEL flag
changes based on what other flags or attrs are set. I'd rather we have
explicit flags.

SCHED_FLAG_RESET_ON_FORK_SEL makes it harder to maintain the userspace
code/makes it easy to accidentally introduce bugs. For example, a
syscall could be setting UCLAMP_MIN and RESET_ON_FORK_SEL. Someone
else might come and change the call to also set a nice value but not
remember to split it up into two calls. Whereas with an explicit flag
like David's proposal, we won't hit such an issue.

Also, we'll need to have separate flags internally to track what needs
to be reset on fork vs not. So we really aren't saving anything by
adding RESET_ON_FORK_SEL.

At least, that's my 2 cents.

-Saravana

> Maybe there's a better interface, but I think it makes sense to do it in =
a way
> that we won't have to do this again. Would be good to hear from maintaine=
rs
> first before you take my word for it ;-)
>
>
> Cheers
>
> --
> Qais Yousef
>
> >
> >  #define SCHED_FLAG_ALL       (SCHED_FLAG_RESET_ON_FORK       | \
> >                        SCHED_FLAG_RECLAIM             | \
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0d18c3969f90..f2d5f7911855 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1943,6 +1943,10 @@ static void __setscheduler_uclamp(struct task_st=
ruct *p,
> >               uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
> >                             attr->sched_util_max, true);
> >       }
> > +
> > +     p->sched_reset_uclamp_on_fork =3D !!(attr->sched_flags &
> > +                                  SCHED_FLAG_RESET_UCLAMP_ON_FORK);
> > +
> >  }
> >
> >  static void uclamp_fork(struct task_struct *p)
> > @@ -1956,7 +1960,7 @@ static void uclamp_fork(struct task_struct *p)
> >       for_each_clamp_id(clamp_id)
> >               p->uclamp[clamp_id].active =3D false;
> >
> > -     if (likely(!p->sched_reset_on_fork))
> > +     if (likely(!p->sched_reset_on_fork && !p->sched_reset_uclamp_on_f=
ork))
> >               return;
> >
> >       for_each_clamp_id(clamp_id) {
> > diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linu=
x/sched.h
> > index 3bac0a8ceab2..d52c59a2e0d0 100644
> > --- a/tools/include/uapi/linux/sched.h
> > +++ b/tools/include/uapi/linux/sched.h
> > @@ -132,12 +132,14 @@ struct clone_args {
> >  #define SCHED_FLAG_KEEP_PARAMS               0x10
> >  #define SCHED_FLAG_UTIL_CLAMP_MIN    0x20
> >  #define SCHED_FLAG_UTIL_CLAMP_MAX    0x40
> > +#define SCHED_FLAG_RESET_UCLAMP_ON_FORK 0x80
> >
> >  #define SCHED_FLAG_KEEP_ALL  (SCHED_FLAG_KEEP_POLICY | \
> >                                SCHED_FLAG_KEEP_PARAMS)
> >
> >  #define SCHED_FLAG_UTIL_CLAMP        (SCHED_FLAG_UTIL_CLAMP_MIN | \
> > -                              SCHED_FLAG_UTIL_CLAMP_MAX)
> > +                              SCHED_FLAG_UTIL_CLAMP_MAX | \
> > +                              SCHED_FLAG_RESET_UCLAMP_ON_FORK)
> >
> >  #define SCHED_FLAG_ALL       (SCHED_FLAG_RESET_ON_FORK       | \
> >                        SCHED_FLAG_RECLAIM             | \
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >
