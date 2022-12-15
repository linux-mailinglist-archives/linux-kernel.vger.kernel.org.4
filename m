Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2986B64D50A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLOBeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLOBeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:34:17 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A334327DE0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:34:16 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b13so13381012lfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Er1pEjV+uaK8BRevaOi4z4uIV6tE8I79LqisqOjFPTY=;
        b=BBBqIDwEe7Bqz0ogeF+G9eKa2qN26dq7Ae1mieiiiytowZsqCFto4Eap/972ksXF0j
         +J1VwZOuqSVKrDFOQ8qnEKpUwIOenAmMeH+DnJGvnbmNaSRG18sIBQoDVOjAppJ8I+aO
         e6ZRq7kXtHsIaIjo1t7U6pVhYMq6HlnGdbnnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Er1pEjV+uaK8BRevaOi4z4uIV6tE8I79LqisqOjFPTY=;
        b=ld/nBLhymYDMEOg8yiIt5KmGpmQp5y20t/WmtBInmHvGgS0vnsNfS504lGXOaYoNFa
         Q+JcF0lb7nGe4kn78QEX2YJJHawUTeRiDkuVAClsX1Kxq+yEt87ebNBwo6S5AxWhPsNx
         2yTgY0aEpk4D+B0MQ+U2Olng7Opg3ipiP8TGylJHrRmFmjBSzdUrmm591ZqpU8F7J3Ws
         qTq62d3PXL8KLp71v2xY6IfRpaEOPffGiVGhw1lPuo4T66s/gmu+W5GIRPKho1VUsNnL
         uJemora9KQ5G40gNCQn6CeGh8wvBx7E03Mr7GDwivpn0cC6Bd1rtZCAy0wuptBKe9hM3
         NJug==
X-Gm-Message-State: ANoB5pm515QDuY8qo8aPI5sEn//pSGeJeAYiOVRq+OypOEv0GKLDeWnD
        p6/wbk8iVuh3V2aFGLaVyL1NF/B77CmBHghXuQSclw==
X-Google-Smtp-Source: AA0mqf7gee9ULH4cue90x8/W99Q03JW+IQ+9vT0N1rrc76ztMjut+j9rsiFnj86huB3ZbgRrIdB8njnTsY+gbCK+QAw=
X-Received: by 2002:ac2:4347:0:b0:4a4:782a:42ac with SMTP id
 o7-20020ac24347000000b004a4782a42acmr31014227lfl.468.1671068054966; Wed, 14
 Dec 2022 17:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com>
 <20221214212455.GA4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
 <CAEXW_YRvSrD40WJ+8GicWB5NN8QyLLoUzRS9j8Tc9CMvojKO0g@mail.gmail.com>
 <CAEXW_YQx78ge_U7asX4YHcsi1EDZSRo_wGN_DJmWnXcAYjHWgQ@mail.gmail.com> <20221215000433.GD4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221215000433.GD4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 14 Dec 2022 20:34:03 -0500
Message-ID: <CAEXW_YQsJCcK7+fMaXQ9rLWt05+s9NrKT=uGrUaSe9HzfbM5sg@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     boqun.feng@gmail.com, frederic@kernel.org, neeraj.iitr10@gmail.com,
        urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 7:04 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Dec 14, 2022 at 11:14:48PM +0000, Joel Fernandes wrote:
> > On Wed, Dec 14, 2022 at 11:10 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Wed, Dec 14, 2022 at 11:07 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Wed, Dec 14, 2022 at 9:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > I also did not get why you care about readers that come and ago (you
> > > > > > mentioned the first reader seeing incorrect idx and the second reader
> > > > > > seeing the right flipped one, etc). Those readers are irrelevant
> > > > > > AFAICS since they came and went, and need not be waited on , right?.
> > > > >
> > > > > The comment is attempting to show (among other things) that we don't
> > > > > need to care about readers that come and go more than twice during that
> > > > > critical interval of time during the counter scans.
> > > >
> > > > Why do we need to care about readers that come and go even once? Once
> > > > they are gone, they have already done an unlock() and their RSCS is
> > > > over, so they need to be considered AFAICS.
> > > >
> > >
> > > Aargh, I meant: "so they need to be considered AFAICS".
> >
> > Trying again: "so they need not be considered AFAICS".
>
> Give or take counter wrap, which can make it appear that still-present
> readers have finished.

Ah you mean those flood of readers affect the counter wrapping and not
that those readers have to be waited on or anything, they just happen
to have a side-effect on *existing readers* which need to be waited
on.

Thanks a lot for this explanation, this part I agree. Readers that
sampled the idx before the flip happened, and then did their
lock+unlock counter increments both after the flip, and after the
second unlock counter scan (second scan), can mess up the lock
counters such that the second scan found lock==unlock, even though it
is not to be due to pre-existing readers. But as you pointed out,
there have to be a substantially large number of these to cause the
equality check to match. This might be another reason why it is
important to scan the unlocks first, because the locks are what have
to cause the wrap around of the lock counter. Instead if you counted
locks first, then the unlocks would have to do the catching up to the
locks which are much fewer than a full wrap around.

I still don't see why this affects only the first reader. There could
be more than 1 reader that needs to be waited on (the readers that
started before the grace period started). Say there are 5 of them.
When the grace period starts, the interfering readers (2^32 of them or
so) could have sampled the old idx before the flip, and then do
lock+unlock (on that old pre-flip() idx) in quick succession after the
smp_mb() in the second srcu_readers_active_idx_check(). That causes
those 5 poor readers to not be waited on. Granted, any new readers
after this thundering herd should see the new idx and will not be
affected, thanks to the memory barriers.

Still confused, but hey I'll take it little at a time ;-) Also thanks
for the suggestions for litmus tests.

Cheers,

 - Joel

> > Anyway, my 1 year old son is sick so signing off for now. Thanks.
>
> Ouch!  I hope he recovers quickly and completely!!!
>
>                                                         Thanx, Paul
