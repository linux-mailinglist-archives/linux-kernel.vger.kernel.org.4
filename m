Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC3A74B5A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGGRSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGGRSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:18:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89211BD2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:18:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6a16254a4so32961171fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1688750317; x=1691342317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tef/7DROj1/+2cj1W4/SoqylG6PxGH8RMe2utLB2EPg=;
        b=qB5NwHipvZZCVoy4z41d4fC7CFOr3grjt9uwHuq8RUqCM9gPPdjXCk2/aJDZ+qTSiu
         Jtc17vvzilGB/1FYmZc5Yf1EokE8neQNsnIX5Dqu2F1vTaLZwcvf8hWp/ryjvNzhZ25u
         3ZJrV+xHs4rzOgdHHCgxFLqlpQN1LWsMV0YJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688750317; x=1691342317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tef/7DROj1/+2cj1W4/SoqylG6PxGH8RMe2utLB2EPg=;
        b=ioBpzsDIBwQwxv8Q1X9dqi7iStcBz18fVNTHQcFMdJUhiCPxZIK9hxQZfLSnO/uZoZ
         IcWx03pXAWJsf5g3gdAMV5TFS0dcRcPFkECW/ughkn7VBu88eFc7Kea3/eZEZvhXhf5M
         P/6/WAX0lMCTtb4Ze1u9m+KdTsl/yqvhx4F3d96oTXn5D6cesXeiR8ckhe24n/qhLLqg
         vX36hNev+yK7OGtrwcYVxFBuQ35wbyEsrGTagdfNOgomImKgIqwcJhwKom4wlZRoFkHe
         hIQNwd+zIoWP7v7WgOUi1Q4T5FlF5xrjwVTcwXOsBy5sYYOdjTJ+fBGGlft7nL94xeDt
         pHvQ==
X-Gm-Message-State: ABy/qLYNTHW7RuTHVPXxqFBfjrtTuUu/ygFevHI2GRmF/1Cj8aOPvEFU
        M0YLiteCf/Cdne0/f589zpL0/10FWJ96CYQSi2iySdXHW24h1ism
X-Google-Smtp-Source: APBJJlHNi/82uBwyeeV5c5DjfQ5FDKJNwy38rczXsmF+w4wsZYHl+nHAjLYV0CXs9kCIpGFFY+0Q3RxM3L8pQjb0pcQ=
X-Received: by 2002:a05:651c:88:b0:2b5:80c9:1266 with SMTP id
 8-20020a05651c008800b002b580c91266mr4275003ljq.43.1688750316847; Fri, 07 Jul
 2023 10:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230704082615.7415-1-qiang.zhang1211@gmail.com>
 <77d16cbb-b28c-4b13-aecb-9ad787559557@paulmck-laptop> <CALm+0cW6DojcxSnzf2mMXhXP-MHJ0aEvSqyh1TbtvBC4bzfsOw@mail.gmail.com>
 <087e3da2-ffd9-4cf4-8893-73f4edc3cfba@paulmck-laptop> <CAEXW_YSfMSQ=z-pEO16_jwZSYt5N+zJHFaDOxDsPNoojm1v4Sg@mail.gmail.com>
In-Reply-To: <CAEXW_YSfMSQ=z-pEO16_jwZSYt5N+zJHFaDOxDsPNoojm1v4Sg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 7 Jul 2023 13:18:25 -0400
Message-ID: <CAEXW_YR41AbVKncRP32sGEVApdmA2-R-2J0M-faGws38ECtsPw@mail.gmail.com>
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

On Fri, Jul 7, 2023 at 1:16=E2=80=AFPM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
>
> On Fri, Jul 7, 2023 at 12:05=E2=80=AFPM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> >
> > On Fri, Jul 07, 2023 at 06:28:29PM +0800, Z qiang wrote:
> > > >
> > > > On Tue, Jul 04, 2023 at 04:26:15PM +0800, Zqiang wrote:
> > > > > When invoke synchronize_srcu(), in the srcu_might_be_idle(), the =
current
> > > > > CPU's sdp->lock will be acquired to check whether there are pendi=
ng
> > > > > callbacks in the sdp->srcu_cblist, if there are no pending callba=
cks,
> > > > > probabilistically probe global state to decide whether to convert=
 to
> > > > > synchronize_srcu_expedited() call. however, for the rcupdate.rcu_=
normal=3D1
> > > > > kernels and after the rcu_set_runtime_mode() is called, invoke th=
e
> > > > > rcu_gp_is_normal() is always return true, this mean that invoke t=
he
> > > > > synchronize_srcu_expedited() always fall back to synchronize_srcu=
(),
> > > > > so there is no need to acquire sdp->lock to check sdp->srcu_cblis=
t and
> > > > > probe global state in srcu_might_be_idle().
> > > > >
> > > > > This commit therefore make srcu_might_be_idle() return immediatel=
y if the
> > > > > rcu_gp_is_normal() return true.
> > > > >
> > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > > ---
> > > > >  kernel/rcu/srcutree.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > index 20d7a238d675..aea49cb60a45 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -1172,6 +1172,8 @@ static bool srcu_might_be_idle(struct srcu_=
struct *ssp)
> > > > >       unsigned long tlast;
> > > > >
> > > > >       check_init_srcu_struct(ssp);
> > > > > +     if (rcu_gp_is_normal())
> > > > > +             return false;
> > > >
> > > > Again, thank you for looking into SRCU!
> > > >
> > > > I am not at all enthusiastic about this one.  With this change, the=
 name
> > > > srcu_might_be_idle() is no longer accurate.  Yes, the name could ch=
ange,
> > > > but any name would be longer and more confusing.
> > > >
> > > > So unless there is a measureable benefit to this one on a productio=
n
> > > > workload, I cannot justify taking it.
> > > >
> > > > Is there a measureable benefit?
> > >
> > > Hi, Paul
> > >
> > > I only find that for Preempt-RT kernel,  the rcu_normal_after_boot is
> > > set by default:
> > > static int rcu_normal_after_boot =3D IS_ENABLED(CONFIG_PREEMPT_RT);
> > > This affects only rcu but also srcu, this make the synchronize_srcu()=
 and
> > > synchronize_srcu_expedited() always fall back to __synchronize_srcu(s=
sp, true),
> > > this means that call the srcu_might_be_idle() is meaningless.
> >
> > I do understand that the current setup favors default kernel builds at
> > runtime by a few low-cost instructions, and that your change favors,
> > as you say, kernels built for real-time, kernels built for certain type=
s
> > of HPC workloads, and all kernels during a small time during boot.
> >
> > My question is instead whether any of this makes a measureable differen=
ce
> > at the system level.
> >
> > My guess is "no, not even close", but the way to convince me otherwise
> > would be to actually run the workload and kernels on real hardware and
> > provide measurements showing a statistically significant difference tha=
t
> > the workload(s) in question care(s) about.
> >
> > So what can you show me?
> >
> > And srcu_might_be_idle() is not meaningless in that situation, just
> > ignored completely.  And that is in fact the nature and purpose of the
> > C-language || operator.  ;-)
>
> I agree with Paul, without any evidence of improvement, optimizing an
> obvious slow path is a NAK.

Just to clarify, when I meant improvement I meant any kind (ex. better
for maintenance, better performance numbers etc.). In this case, the
extra 2 lines does not seem to buy much AFAICS.

Thanks.
