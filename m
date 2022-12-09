Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A84648A5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiLIVv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:51:24 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D389A1581B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:51:23 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x28so9034191lfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 13:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9R0XsnfqeHqoIAIfxozR0ZabRMe8wmId4Da2hGWSIsg=;
        b=R3j4WbAQK9nqY1gPToQMNc8ATVS5QEV5HZToNNBjsFoLiB6yd9SudD7p3DkXJRvkUT
         uuhgG/YwWlsadCOYkwAtnf/8vQspdr0SUjRoougW87eYfG8EaNSl6XVBW7Z4SB4qLctu
         dlZzVyuiszE61Yu+74mKq6rn8VWCWdABN37wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9R0XsnfqeHqoIAIfxozR0ZabRMe8wmId4Da2hGWSIsg=;
        b=H2217vqbfo6UMCP9wlYrWSSdQKwWS0mHqD2NvgaKLe6oN4CLt5hlGV9pP6By4F7Y/Y
         W05PF61fwcMjobvdL9TFW+4J6Xjk6GzpLUJSWpZLoalbH49qVS5cF6McICyii8Songbk
         1kqkA0j+z+xkL6EdluhBaE0zE0CRmhSIZpAsq9VrHwVbpoOi65+K3McWwZAyuYpDUbE4
         Xg3UB2k3zVBNi7gTPCu+A53aycgq27J8xanPTaIpf/nGQzCyKFJAl1rRl/WN0ssNhswh
         Gzwpm/7IXmgUaAgK7Vw9ddWwe8TDOGQpGSji8VH9sYpT17dMW1+t7F4uYgQi8d6ad2ME
         K6Kg==
X-Gm-Message-State: ANoB5pn6cMLE6LLwjZMO8Zy4Ave+JUdTtMb9IH3NNfk1fvQ8Xy1iT9hp
        hE1Br7WeFyb+G+6/fNqLUfydJfZEq1q/UU/4qgpbsHjj/Uctba87
X-Google-Smtp-Source: AA0mqf5C84foVZwTU3cAbuyGJeB76Ob84ixpcM5Lxf/zIQOtbVeK+yWxt+TNZQD0EX6bHGLNw/cFzbUy8r2DzGnQV2c=
X-Received: by 2002:ac2:510c:0:b0:4af:d4e:dfa7 with SMTP id
 q12-20020ac2510c000000b004af0d4edfa7mr26332168lfb.582.1670622682112; Fri, 09
 Dec 2022 13:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20221209022305.321149-1-joel@joelfernandes.org>
 <20221209022305.321149-2-joel@joelfernandes.org> <20221209163759.6s7pqf5wdvy32ywn@offworld>
In-Reply-To: <20221209163759.6s7pqf5wdvy32ywn@offworld>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 9 Dec 2022 21:51:10 +0000
Message-ID: <CAEXW_YRyhXvvyiw=TrPLk4UwBThqeUh+aP_pvCiBSr6Mko2zxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] locktorture: Make the rt_boost factor a tunable
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 5:02 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Fri, 09 Dec 2022, Joel Fernandes (Google) wrote:
>
> >The rt boosting in locktorture has a factor variable s currently large enough
> >that boosting only happens once every minute or so. Add a tunable to reduce the
> >factor so that boosting happens more often, to test paths and arrive at failure
> >modes earlier. With this change, I can set the factor to like 50 and have the
> >boosting happens every 10 seconds or so.
> >
> >Tested with boot parameters:
> >locktorture.torture_type=mutex_lock
> >locktorture.onoff_interval=1
> >locktorture.nwriters_stress=8
> >locktorture.stutter=0
> >locktorture.rt_boost=1
> >locktorture.rt_boost_factor=50
> >locktorture.nlocks=3
> >
> >Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Thank you!

> >---
> > kernel/locking/locktorture.c | 12 +++++++-----
> > 1 file changed, 7 insertions(+), 5 deletions(-)
> >
> >diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> >index 8968fd65a90d..b64a528e511c 100644
> >--- a/kernel/locking/locktorture.c
> >+++ b/kernel/locking/locktorture.c
> >@@ -48,6 +48,7 @@ torture_param(int, stat_interval, 60,
> > torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> > torture_param(int, rt_boost, 2,
> >               "Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
> >+torture_param(int, rt_boost_factor, 50, "A factor determining how often rt-boost happens.");
> > torture_param(int, verbose, 1,
> >            "Enable verbose debugging printk()s");
> > torture_param(int, nlocks, 1,
> >@@ -133,12 +134,12 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
> >
> > static void __torture_rt_boost(struct torture_random_state *trsp)
> > {
> >-      const unsigned int factor = 50000; /* yes, quite arbitrary */
> >+      const unsigned int factor = rt_boost_factor;
> >
> >       if (!rt_task(current)) {
> >               /*
> >-               * Boost priority once every ~50k operations. When the
> >-               * task tries to take the lock, the rtmutex it will account
> >+               * Boost priority once every rt_boost_factor operations. When
> >+               * the task tries to take the lock, the rtmutex it will account
>
> Nit: maybe refer to it as 'rt_boost_factor'?

Sorry, I did not follow. Refer to what?

thanks,

 - Joel


>
> >                * for the new priority, and do any corresponding pi-dance.
> >                */
> >               if (trsp && !(torture_random(trsp) %
> >@@ -148,8 +149,9 @@ static void __torture_rt_boost(struct torture_random_state *trsp)
> >                       return;
> >       } else {
> >               /*
> >-               * The task will remain boosted for another ~500k operations,
> >-               * then restored back to its original prio, and so forth.
> >+               * The task will remain boosted for another 10*rt_boost_factor
> >+               * operations, then restored back to its original prio, and so
> >+               * forth.
> >                *
> >                * When @trsp is nil, we want to force-reset the task for
> >                * stopping the kthread.
> >--
> >2.39.0.rc1.256.g54fd8350bd-goog
> >
