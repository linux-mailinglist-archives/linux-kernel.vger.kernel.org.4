Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2A64D2FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiLNXIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLNXIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:08:06 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549EE29832
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:08:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id cf42so12987747lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p7tUMOZBnl/a2XDqbEom0yUvQstZqq0nKTRZr5hg2mU=;
        b=bwlr66RuWoNEzvj7we4Fhy+eIGeIUiYZ+v/ow3M70hbFrrCU8Uxian7QyiKXW5MI3K
         MFPFHF6sKyV1z34IaGogEJbhrDV2iTCiKd8tK/lxnCOWznbAEY67JIAJD6PVrCRPND1D
         pBkeRzKBYz38eMh42wkyHceMercfugF7i4SCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7tUMOZBnl/a2XDqbEom0yUvQstZqq0nKTRZr5hg2mU=;
        b=Wh+7LVlH6F5odHVgRKG33/buyqnR3CvXvKbugO2o0j5y8IoVnz8wmGK65f50sLVE0c
         WABt7Z5+LIoUSbXggb2Xi3M969xuDwR3so94iiWjnMoYVOLPYot/Cf7LJMlNCeHb5Vbb
         qMHhI75AlyXXOwhAml90VHRXA261ebKBXxbCZrx3zgL9ocB9FBTLyGXTrVHD7qwr88Tg
         Mdc4fe9BrOLKwP6lU0UMKJXTFsCC8R2AifdWi8YzKAEX4RhWZHAoU3HISGqZ3nEYsSnZ
         M6S4bXxpsAgcBKdF+A4ErTKecZxCQF0RXnw18xOkFLN538kAmmoLyU9aNjRXc9XXS84W
         73hA==
X-Gm-Message-State: ANoB5pm2K7aX5QAARMmg9xNuAQ8/TEXvwl/44U7O3nhqU56tmsrMRnbb
        07ctKHzB7/RY4Di+/Wc9hKGCerYiUjPTKH/1W7tT+g==
X-Google-Smtp-Source: AA0mqf6tpRmVSPZHmVgbmiGdJJTJcME0eAzFLL+MMng6grOgqkT/jVSkt1cky1mDhRHacjB8JrZJRW4LCAAZvYt5VTM=
X-Received: by 2002:a05:6512:3248:b0:4aa:148d:5168 with SMTP id
 c8-20020a056512324800b004aa148d5168mr31281828lfr.561.1671059283481; Wed, 14
 Dec 2022 15:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com> <20221214212455.GA4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221214212455.GA4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 14 Dec 2022 23:07:52 +0000
Message-ID: <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     boqun.feng@gmail.com, frederic@kernel.org, neeraj.iitr10@gmail.com,
        urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 9:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Dec 14, 2022 at 03:51:54PM -0500, Joel Fernandes wrote:
> > Hi Paul,
> >
> > On Wed, Dec 14, 2022 at 2:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > The comment in srcu_readers_active_idx_check() following the smp_mb()
> > > is out of date, hailing from a simpler time when preemption was disabled
> > > across the bulk of __srcu_read_lock().  The fact that preemption was
> > > disabled meant that the number of tasks that had fetched the old index
> > > but not yet incremented counters was limited by the number of CPUs.
[...]
> > > +        * TREE01 rcutorture run reported this size to be no less than
> > > +        * 9408 bytes, allowing up to 4704 levels of nesting, which is
> > > +        * comfortably beyond excessive.  Especially on 64-bit systems,
> > > +        * which are unlikely to be configured with an address space fully
> > > +        * populated with memory, at least not anytime soon.
> > >          */
> >
> > Below is a summary from my point of view. Please correct me if I'm
> > wrong. I was trying to reason that we only need to care about waiting
> > for readers that sample idx *after* srcu_read_lock() issued smp_mb().
> >
> > The case to consider a race between readers and
> > srcu_readers_active_idx_check() IMO is when a reader samples idx,
>
> I would instead say "when a reader has sampled ->srcu_idx, but has not
> yet executed the smp_mb() or incremented ->srcu_lock_count".

If it has not yet executed smp_mb(), then I am missing why this
read-side critical section matters as far as being waited for. If it
is waited for due to a race, great, just a slightly higher delay. If
it is not waited for, then no one should care AFAICS, it is too late
and the next grace period will anyway scan both the idx to track it.

> > issues smp_mb() enters its RSCS. If it does not do smp_mb(), its RSCS
> > need not be waited on as it is not considered to be entered from a
> > global memory PoV.  Assuming it did issue the smp_mb() in
> > srcu_read_lock() and then got preempted (which IMO is the only case to
> > care about the reader for), and say the first scan failed to track
> > down this in-flight RSCS.
>
> Except that this smp_mb() is not externally visible to software.
> Other CPUs have to have seen and access following that smp_mb() for it
> to matter from a software viewpoint.

Sure, that second pairing smp_mb() will be in
srcu_readers_active_idx_check(). I am definitely considering it in
pairs here in the reasoning, and not on its own.

> >                           The first scan can fail to track the RSCS
> > for 2 reasons:
> >
> > #1. The idx being scanned in the first scan is the one that the reader
> > did not sample.
> > #2. The smp_mb() in the first scan's srcu_readers_active_idx_check()
> > happened *before* the smp_mb() post-counter increment in
> > srcu_read_lock().
>
> Again, software cannot see the smp_mb() in and of itself.  What
> matters is the increment of ->srcu_lock_count and the updater's
> scan of this same counter.

Yes, and that scan of the counter happens after a write-side smp_mb() AFAICS.

> #3. The reader still hasn't gotten around to incrementing
> ->srcu_lock_count.

Then it has not executed an smp_mb() on the read-side yet, so it
should not be taken into consideration AFAICS.

> > In case of #2, the first scan was too early and the second scan will
> > not even look at this idx as it gets flipped. So we can safely assume
> > in #2 that this RSCS need not be waited on and was too early. IOW, the
> > grace period started before the RSCS, so tough luck for that RSCS.
>
> And the point of a number of the memory barriers is to ensure that when
> this happens, the critical section is guaranteed to see anything that
> happened before the start of the current grace period.

Sure.

> > So AFAICS, case #1 is the only one that matters for consideration of
> > race. In this case, we will rely on the second scan and assume that we
> > "need to do the right thing" for the case where the srcu_read_lock()'s
> > smp_mb() happened *before* the second scan's smp_mb() and the idx
> > being reader-occupied is supposed to be properly nailed down by the
> > second scan. In this case, the second scan *will* see the lock count
> > increment of all in-flight readers, preempted or otherwise, because of
> > the smp_mb() it issues prior to sampling all the lock counts of the
> > flipped idx.  And upto Nt number of increments can be "caught" by the
> > second scan, before a wrap around fools it into believing the Nt
> > readers don't need any love, quiet to their detriment.
>
> Both #1 and #3 must be handled, right?

This is the part I am not sure, that #3 matters, but I could be
missing something.

> > I also did not get why you care about readers that come and ago (you
> > mentioned the first reader seeing incorrect idx and the second reader
> > seeing the right flipped one, etc). Those readers are irrelevant
> > AFAICS since they came and went, and need not be waited on , right?.
>
> The comment is attempting to show (among other things) that we don't
> need to care about readers that come and go more than twice during that
> critical interval of time during the counter scans.

Why do we need to care about readers that come and go even once? Once
they are gone, they have already done an unlock() and their RSCS is
over, so they need to be considered AFAICS.

Again, sorry if my comments are nonsense, I will try to reason more.
The goal of asking questions is to learn ;-)

Thanks.
