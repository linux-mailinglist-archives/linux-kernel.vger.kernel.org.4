Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC52374BB56
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjGHCRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGHCR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:17:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937C11FE7;
        Fri,  7 Jul 2023 19:17:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-262ff3a4659so1908542a91.0;
        Fri, 07 Jul 2023 19:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688782648; x=1691374648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXGxtWnZxEjmWeImzBLbjmzHOWkOOTwPng2O3XQMmHk=;
        b=BOZCXbL0d8ukbWVRAvqPpROsRcuxIQhor3FlO92kfXPW2NLGczXd08YBObZpsxzuOM
         ayRn+DUzpqM2Avo7NWvb1bMVcgnT1YqUCrmbA4Io4nMKxBhxwUwvE+ncXXLgwogqND9x
         0qiKhu3S2TjKZDJ3ozVSa6xdFo/tgtJ7eN79YFSkTZrNRqeRcjluo6zrb8VnhGSCKWr/
         7lnos74hPFhs58QWh7s7G4zOrS7808CIKYIpeIz2kNTK47SNHB2jQ8CFk/tVRPxFx4aT
         4PoZ8OYG/Db8lkUhYwH5XY6fI3GHk5UPRsfWEF/xHk+dmjgrCBgeg81P5rME2ZJXeuoW
         uG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688782648; x=1691374648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXGxtWnZxEjmWeImzBLbjmzHOWkOOTwPng2O3XQMmHk=;
        b=lEIGcyRsnbEuhQGYbGVcs83X21YFo9+2g2uojdsgUJkZofDflT/OXMf61LBVIZISe/
         kbhQYNJKaz3n3zTKAjOpIj8c/E1+8G8CDqYB7Ct+pExDcernyxV2MPM23MfwdahROJnO
         gVBjLErs9P9jSK31OqAvCORjH4qqU3W7msSwFPjjv5ygV9y3I5HdtUsfNAxaW1KaNtQI
         3Ot2cVegIO/h0I7oZUx9thkJZAkYtqeTJkRmgw6B9A8nddBt+dnV7fABtQD58QYcZr1t
         XaRyw2rD6LLpHLB0gZDSy9WizCB+Cf7AP1FNuj96Gp2TAxVB+f+xJneP2dzxDtd2Vldx
         EUnA==
X-Gm-Message-State: ABy/qLalvO6VlY26FkzDOzG8qpferf0ltNrWlYgTqKCeKtXuYLFRYrgm
        BeXCA7wx4J/kD2wXoWs7UeYyDu84cygNWB2cbBc=
X-Google-Smtp-Source: APBJJlFsIRF3TW3QXD5SryFDmhkns31WHfZjDAKXQ6QSDTuOZ2eaIiGmkGzPAs8eRKFoHe3sei332C1f0l/K1Yl7jCY=
X-Received: by 2002:a17:90a:ac0d:b0:262:ec13:d3a with SMTP id
 o13-20020a17090aac0d00b00262ec130d3amr6995449pjq.28.1688782647980; Fri, 07
 Jul 2023 19:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230704082615.7415-1-qiang.zhang1211@gmail.com>
 <77d16cbb-b28c-4b13-aecb-9ad787559557@paulmck-laptop> <CALm+0cW6DojcxSnzf2mMXhXP-MHJ0aEvSqyh1TbtvBC4bzfsOw@mail.gmail.com>
 <087e3da2-ffd9-4cf4-8893-73f4edc3cfba@paulmck-laptop> <CAEXW_YSfMSQ=z-pEO16_jwZSYt5N+zJHFaDOxDsPNoojm1v4Sg@mail.gmail.com>
 <CAEXW_YR41AbVKncRP32sGEVApdmA2-R-2J0M-faGws38ECtsPw@mail.gmail.com>
In-Reply-To: <CAEXW_YR41AbVKncRP32sGEVApdmA2-R-2J0M-faGws38ECtsPw@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Sat, 8 Jul 2023 10:17:15 +0800
Message-ID: <CALm+0cUtqWtC9XUszRuz5hLjoKv_ZY-4Oqp1OJ-jpbg1s4vgRQ@mail.gmail.com>
Subject: Re: [PATCH] srcu: Make srcu_might_be_idle() take early return if
 rcu_gp_is_normal() return true
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 1:18=E2=80=AFAM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
>
> On Fri, Jul 7, 2023 at 1:16=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
> >
> > On Fri, Jul 7, 2023 at 12:05=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Fri, Jul 07, 2023 at 06:28:29PM +0800, Z qiang wrote:
> > > > >
> > > > > On Tue, Jul 04, 2023 at 04:26:15PM +0800, Zqiang wrote:
> > > > > > When invoke synchronize_srcu(), in the srcu_might_be_idle(), th=
e current
> > > > > > CPU's sdp->lock will be acquired to check whether there are pen=
ding
> > > > > > callbacks in the sdp->srcu_cblist, if there are no pending call=
backs,
> > > > > > probabilistically probe global state to decide whether to conve=
rt to
> > > > > > synchronize_srcu_expedited() call. however, for the rcupdate.rc=
u_normal=3D1
> > > > > > kernels and after the rcu_set_runtime_mode() is called, invoke =
the
> > > > > > rcu_gp_is_normal() is always return true, this mean that invoke=
 the
> > > > > > synchronize_srcu_expedited() always fall back to synchronize_sr=
cu(),
> > > > > > so there is no need to acquire sdp->lock to check sdp->srcu_cbl=
ist and
> > > > > > probe global state in srcu_might_be_idle().
> > > > > >
> > > > > > This commit therefore make srcu_might_be_idle() return immediat=
ely if the
> > > > > > rcu_gp_is_normal() return true.
> > > > > >
> > > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > > > ---
> > > > > >  kernel/rcu/srcutree.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > index 20d7a238d675..aea49cb60a45 100644
> > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > @@ -1172,6 +1172,8 @@ static bool srcu_might_be_idle(struct src=
u_struct *ssp)
> > > > > >       unsigned long tlast;
> > > > > >
> > > > > >       check_init_srcu_struct(ssp);
> > > > > > +     if (rcu_gp_is_normal())
> > > > > > +             return false;
> > > > >
> > > > > Again, thank you for looking into SRCU!
> > > > >
> > > > > I am not at all enthusiastic about this one.  With this change, t=
he name
> > > > > srcu_might_be_idle() is no longer accurate.  Yes, the name could =
change,
> > > > > but any name would be longer and more confusing.
> > > > >
> > > > > So unless there is a measureable benefit to this one on a product=
ion
> > > > > workload, I cannot justify taking it.
> > > > >
> > > > > Is there a measureable benefit?
> > > >
> > > > Hi, Paul
> > > >
> > > > I only find that for Preempt-RT kernel,  the rcu_normal_after_boot =
is
> > > > set by default:
> > > > static int rcu_normal_after_boot =3D IS_ENABLED(CONFIG_PREEMPT_RT);
> > > > This affects only rcu but also srcu, this make the synchronize_srcu=
() and
> > > > synchronize_srcu_expedited() always fall back to __synchronize_srcu=
(ssp, true),
> > > > this means that call the srcu_might_be_idle() is meaningless.
> > >
> > > I do understand that the current setup favors default kernel builds a=
t
> > > runtime by a few low-cost instructions, and that your change favors,
> > > as you say, kernels built for real-time, kernels built for certain ty=
pes
> > > of HPC workloads, and all kernels during a small time during boot.
> > >
> > > My question is instead whether any of this makes a measureable differ=
ence
> > > at the system level.
> > >
> > > My guess is "no, not even close", but the way to convince me otherwis=
e
> > > would be to actually run the workload and kernels on real hardware an=
d
> > > provide measurements showing a statistically significant difference t=
hat
> > > the workload(s) in question care(s) about.
> > >
> > > So what can you show me?
> > >
> > > And srcu_might_be_idle() is not meaningless in that situation, just
> > > ignored completely.  And that is in fact the nature and purpose of th=
e
> > > C-language || operator.  ;-)
> >
> > I agree with Paul, without any evidence of improvement, optimizing an
> > obvious slow path is a NAK.
>
> Just to clarify, when I meant improvement I meant any kind (ex. better
> for maintenance, better performance numbers etc.). In this case, the
> extra 2 lines does not seem to buy much AFAICS.
>

Agree, optimization does require performance data.

Thanks
Zqiang

>
> Thanks.
