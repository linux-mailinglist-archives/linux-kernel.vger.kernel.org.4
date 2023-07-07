Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887DB74B5A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGGRQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjGGRQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:16:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943AF1FEC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:16:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6ef9ed2fdso34664841fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1688750203; x=1691342203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+3ftUrKkGKWTNUl/ff+NksMj5plBKBFyR+RGdmjZos=;
        b=C9Va5MTTcTbYBoTWRyAjroFbhLGDCi9734g2/O9X2iYuULUit3WlukK/8oa6EG/vJw
         z/NjnGfT0rP9Ym30qjGRlJtYy/nqLNO7pMFpC8E5YovHWxIDS33Ikso5mrvKehmmN07V
         bfp1W9rObG7Ch/OW64rjV/67n4WHmDZiiFxG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688750203; x=1691342203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+3ftUrKkGKWTNUl/ff+NksMj5plBKBFyR+RGdmjZos=;
        b=BJimQaiqiAB8ftHQ9iYOhm/FnBnL09WgtsX2IjLjFxstEwIhZbatnV8IzPshIqwuX9
         ZkHyAiKZtzsQXrfGFc2OCv9dwF4L7fdXF/IgcS5ZfW85P0CBFveVyUIfRsCA1nzMqEB1
         AFIR9GAD8ufkhtzE3oCQN9pn88ds+r2GOcQnR223HLE/7OvoWL/2TkeL0/yfPU0iUPQS
         gshmEXFBmyn3fpzl9fwjei01cnsF5e6WFyOzpzAYNK+rqSWfToOpkg75odU0+0JMxBnz
         DCliDnNfejHtArSMdIgmrKGvANeQ2ZJK+5Jti0yLReOSmHBIVdZ+uxyzy5NHiEdwauRS
         mGhw==
X-Gm-Message-State: ABy/qLYj0cA3t+y5OA/tOPhVEcwP8SuFnEdiBZ0Eqrsq9iZdXha9n/79
        /qP5gdQXK/17JhVBB5n2+oMruwHU5mCIUhNC6rUiBQ==
X-Google-Smtp-Source: APBJJlGuAy0wLSoXaNkgFRdRYIchwP9YRwUB84DL3lJ/iIaXa1QXT3d98xpD9CPLKc9maFWRi64RchlLudBkRQJuJ6Q=
X-Received: by 2002:a2e:9c95:0:b0:2b6:c16a:db06 with SMTP id
 x21-20020a2e9c95000000b002b6c16adb06mr4517649lji.39.1688750202658; Fri, 07
 Jul 2023 10:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230704082615.7415-1-qiang.zhang1211@gmail.com>
 <77d16cbb-b28c-4b13-aecb-9ad787559557@paulmck-laptop> <CALm+0cW6DojcxSnzf2mMXhXP-MHJ0aEvSqyh1TbtvBC4bzfsOw@mail.gmail.com>
 <087e3da2-ffd9-4cf4-8893-73f4edc3cfba@paulmck-laptop>
In-Reply-To: <087e3da2-ffd9-4cf4-8893-73f4edc3cfba@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 7 Jul 2023 13:16:31 -0400
Message-ID: <CAEXW_YSfMSQ=z-pEO16_jwZSYt5N+zJHFaDOxDsPNoojm1v4Sg@mail.gmail.com>
Subject: Re: [PATCH] srcu: Make srcu_might_be_idle() take early return if
 rcu_gp_is_normal() return true
To:     paulmck@kernel.org
Cc:     Z qiang <qiang.zhang1211@gmail.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 12:05=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Jul 07, 2023 at 06:28:29PM +0800, Z qiang wrote:
> > >
> > > On Tue, Jul 04, 2023 at 04:26:15PM +0800, Zqiang wrote:
> > > > When invoke synchronize_srcu(), in the srcu_might_be_idle(), the cu=
rrent
> > > > CPU's sdp->lock will be acquired to check whether there are pending
> > > > callbacks in the sdp->srcu_cblist, if there are no pending callback=
s,
> > > > probabilistically probe global state to decide whether to convert t=
o
> > > > synchronize_srcu_expedited() call. however, for the rcupdate.rcu_no=
rmal=3D1
> > > > kernels and after the rcu_set_runtime_mode() is called, invoke the
> > > > rcu_gp_is_normal() is always return true, this mean that invoke the
> > > > synchronize_srcu_expedited() always fall back to synchronize_srcu()=
,
> > > > so there is no need to acquire sdp->lock to check sdp->srcu_cblist =
and
> > > > probe global state in srcu_might_be_idle().
> > > >
> > > > This commit therefore make srcu_might_be_idle() return immediately =
if the
> > > > rcu_gp_is_normal() return true.
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > ---
> > > >  kernel/rcu/srcutree.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 20d7a238d675..aea49cb60a45 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -1172,6 +1172,8 @@ static bool srcu_might_be_idle(struct srcu_st=
ruct *ssp)
> > > >       unsigned long tlast;
> > > >
> > > >       check_init_srcu_struct(ssp);
> > > > +     if (rcu_gp_is_normal())
> > > > +             return false;
> > >
> > > Again, thank you for looking into SRCU!
> > >
> > > I am not at all enthusiastic about this one.  With this change, the n=
ame
> > > srcu_might_be_idle() is no longer accurate.  Yes, the name could chan=
ge,
> > > but any name would be longer and more confusing.
> > >
> > > So unless there is a measureable benefit to this one on a production
> > > workload, I cannot justify taking it.
> > >
> > > Is there a measureable benefit?
> >
> > Hi, Paul
> >
> > I only find that for Preempt-RT kernel,  the rcu_normal_after_boot is
> > set by default:
> > static int rcu_normal_after_boot =3D IS_ENABLED(CONFIG_PREEMPT_RT);
> > This affects only rcu but also srcu, this make the synchronize_srcu() a=
nd
> > synchronize_srcu_expedited() always fall back to __synchronize_srcu(ssp=
, true),
> > this means that call the srcu_might_be_idle() is meaningless.
>
> I do understand that the current setup favors default kernel builds at
> runtime by a few low-cost instructions, and that your change favors,
> as you say, kernels built for real-time, kernels built for certain types
> of HPC workloads, and all kernels during a small time during boot.
>
> My question is instead whether any of this makes a measureable difference
> at the system level.
>
> My guess is "no, not even close", but the way to convince me otherwise
> would be to actually run the workload and kernels on real hardware and
> provide measurements showing a statistically significant difference that
> the workload(s) in question care(s) about.
>
> So what can you show me?
>
> And srcu_might_be_idle() is not meaningless in that situation, just
> ignored completely.  And that is in fact the nature and purpose of the
> C-language || operator.  ;-)

I agree with Paul, without any evidence of improvement, optimizing an
obvious slow path is a NAK.

thanks,

 - Joel
