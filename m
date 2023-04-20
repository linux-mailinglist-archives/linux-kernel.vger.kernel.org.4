Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE76E997D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjDTQ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDTQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:26:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8BAD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:26:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a652700c36so336235ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682007959; x=1684599959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1Pt9G4egxD3sVrIu1vY7iT92Ett5HNSp3isjYWIpwA=;
        b=XUTdDXHDQmRGYMXN0BDev7dHlrZDyY+mgmI/21t/1rlXkMAoHov3RBvnYy8GQKh3lO
         AY6UZHloBtua9vvX7iPjNe2NfVn38BKd57FfHE9LUodq8EcbJXs1IrcuClA/xWw+LF2o
         TbDJQUx0/5c2Xnd4mTvaJZGXjejYVzPIe/ANuLw0HMYJlS2cWTOLH34ZLxWcO3Bi1VvI
         X8hF+MfazhlO2ZFj9FfNhpVBfxezTJvzBHLzxYMhppfyhrZMiomvUUHW1U6ovczyhjdI
         v9H23wgl+d3NT6/LxCYOkJ/R+4XkOyCkP/AvB560EJzla+pZy+ENQlaBa7hE9KcE3LP4
         XvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682007959; x=1684599959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1Pt9G4egxD3sVrIu1vY7iT92Ett5HNSp3isjYWIpwA=;
        b=eacMbhExYbEz+FVUzlFkjmOxeAlqPIVJf3Jr4D95LNOQGUTn9S57OI1LxDMQLuiCRh
         XuwTlXQvwEV9ecrv0jE2jR2KpNEJ/u8E3orBsslM0gp7DRLhMkkS0W51vfjCy3CkV8p5
         fWYV2WmBJ8jpr0TV3riGLdEw825jhD1/xACrFsi/aFsHzdct+dgGFdYXQmC9mk03QlgJ
         71K13TPOZBtTunXsApbO5rlL/eECZJTgY+WSxZUsLF/gfz8Dsb5aCkE/p8w+rwXaKASa
         vxntViIsiZW/D0/H6vQ1Go2HzaJrL+wVijEtnbGxC+Y3hXJh9rD0N04mSWpAtBVW9WF0
         4TMw==
X-Gm-Message-State: AAQBX9d5nlbyuJ9rvp4cirim/9ZLOJ2C+ja/NaJAayQyn+yuCdPrGug4
        qghWRB9YQZbpatvWUlZiklRQInYApk4BVuRiIjElxQ==
X-Google-Smtp-Source: AKy350bNN8/GbVj7ej1XNf7s+EOCfix2W91x/wh9/dFZlNoWHPXqhTDyDrvu9mBH/4NqJlfQE2SKv5sJpSoCW3bmmxE=
X-Received: by 2002:a17:903:4d0:b0:199:3909:eaee with SMTP id
 jm16-20020a17090304d000b001993909eaeemr340262plb.6.1682007959375; Thu, 20 Apr
 2023 09:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230416213406.2966521-1-davidai@google.com> <d83950c4-7458-aeea-f341-327c163704a8@arm.com>
 <CABN1KC+_HDi_i2zzpZVbqiUP5-QB9YrE5wzLqr==_wOemaCXzA@mail.gmail.com>
 <bf8f21be-7249-fc27-9704-211d0f5a12b1@arm.com> <CAKfTPtAgkyE1xntn-4u9o8DFhH9iGq54c-QXYr0cE+zvoPx9Gw@mail.gmail.com>
In-Reply-To: <CAKfTPtAgkyE1xntn-4u9o8DFhH9iGq54c-QXYr0cE+zvoPx9Gw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 20 Apr 2023 09:25:23 -0700
Message-ID: <CAGETcx-suryHeB3wpaTSZBiw6+VwA7pe=GnrbtizSVj+C9Smtg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce SCHED_FLAG_RESET_UCLAMP_ON_FORK
 flag
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 6:44=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 20 Apr 2023 at 11:37, Dietmar Eggemann <dietmar.eggemann@arm.com>=
 wrote:
> >
> > On 20/04/2023 03:11, David Dai wrote:
> > > On Tue, Apr 18, 2023 at 10:18=E2=80=AFPM Dietmar Eggemann
> > > <dietmar.eggemann@arm.com> wrote:
> > >>
> > >
> > > Hi Dietmar, thanks for your time,
> > >
> > >> On 16/04/2023 23:34, David Dai wrote:
> > >>> A userspace service may manage uclamp dynamically for individual ta=
sks and
> > >>> a child task will unintentionally inherit a pesudo-random uclamp se=
tting.
> > >>> This could result in the child task being stuck with a static uclam=
p value
> > >>
> > >> Could you explain this with a little bit more detail? Why isn't the
> > >> child task also managed by the userspace service?
> > >
> > > See Qais=E2=80=99 reply that contains more detail on how it=E2=80=99s=
 being used in
> > > Android. In general, if a dynamic userspace service will adjust uclam=
p
> > > on the fly for a given task, but has no knowledge or control over if
> > > or when a task forks. Depending on the timing of the fork, a child
> > > task may inherit a very large or a small uclamp_min or uclamp_max
> > > value. The intent of this patch is to provide more flexibility to the
> > > uclamp APIs such that child tasks do not get stuck with a poor uclamp
> > > value when spawned while retaining other sched attributes. When
> > > RESET_ON_FORK is set on the parent task, it will reset uclamp values
> > > for the child but also reset other sched attributes as well.
> >
> > OK, in this case, why not just change behavior and always reset the
> > uclamp values at fork?
> >
> > Do we anticipate a use-case in which uclamp inheritance would be requir=
ed?
> >
> > Let's not over-complicate the sched_[sg]etattr() unnecessarily.
>
> I was about to ask the same question and I'm aligned with Dietmar.
> Use RESET_ON_FORK and set all attributes

That's racy though. If we have an external service (that's only
responsible for setting uclamp) setting all the attributes, the forked
thread could also be trying to set some of the attributes. Also, how
is this external service going to keep track of all the threads being
forked and set the right attributes for all of them?

If it's not considered a UAPI breakage, I'd rather we never inherit uclamp.

-Saravana

>
> >
> > [...]
> >
> > >> Does this issue happen with uclamp mainline or only with Android's
> > >> slightly different version (max- vs. sum aggregation)?
> > >
> > > I=E2=80=99m using the version of uclamp that=E2=80=99s in Linus=E2=80=
=99 tree. How uclamp is
> > > aggregated is unrelated to the problem I=E2=80=99m trying to solve wi=
th this
> > > patch. Which is to extend the uclamp APIs to have finer control for
> > > the uclamp inheritance of child tasks.
> >
> > OK, I see.
