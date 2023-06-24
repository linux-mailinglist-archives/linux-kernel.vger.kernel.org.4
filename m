Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7B73C584
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjFXAmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 20:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjFXAlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:41:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889FF295E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 17:41:19 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40079b6fc56so62451cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 17:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687567278; x=1690159278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC965DJt5tAhpKKQcl7Nrr8kkneg4b6xg5gLmb8wBo4=;
        b=pO+JTvBMgLELvqc0ecqM26pJ7akvuy2kG8MoahYSsBc9JRDIFmP3ZBjyAjqmRObYSB
         YgFwVNfpdXRKn48NTf56QNhZksxpwGAg59bLN1DP/lshKdz5pkF166woBADF50JA4eOs
         S6wREMOswpT3G9eyhzKG6wtXfqbCPQo2pThsWW03NJUmG4CXTpZ0lp2uD8mPJj5HZThO
         ywAHCVPiK3rh3UmWCTD0Gztw/oEyZNTACCet9hMA3Lv6r/64rsn2wHnu+OVTvaFChBS3
         rV/KDfI0ft32OQPA2IwhDry5Hc4J4sxPz0nzuJ/8OAKuocfM9jRIWBBq9/Z11aeK3CY/
         KTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687567278; x=1690159278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC965DJt5tAhpKKQcl7Nrr8kkneg4b6xg5gLmb8wBo4=;
        b=UbDW5KHghDEZIzbUAnXlYoBWxtW2T2s0lyNhfFi0yTizrwG4B5YQ5U4TC65ukqJzs7
         AVyk2446SnWscj3I4y4jP7LHHbxMSy+1ht1uerktwi3fDJgfNCUemqiQs4GvuCJc8G2K
         GtlUWPcaPFRyftt/Sp06W/7O53smy8Fdv7ZUpwF7TnAjcTUKEHaEGU4FnpkeANolJ5Nw
         NIo6NTlGyBNHgi8fIKGX6vzKoYvfmRbZtYzJsygczuSE1r3OH0dul3CcDPNZpww6s2Gy
         67sTcO4Qtt3/5T6xrks7qXzXRR1ck58w4CaiLD0kl6BEYsC23u8xFCtGKxVq2it0kW1U
         0vTQ==
X-Gm-Message-State: AC+VfDwdHIArCq95tORvoLBvfSrp94lNgFr4C+FtHBoi7YworFOxnDk2
        DmIRox2y5e8paX24VqENrCImNpR78zbGAbgRRjG4
X-Google-Smtp-Source: ACHHUZ5jX5HtFSRT1UWm9wi7hMf9I6tSh/vqO1X0xMxMe3R87oA+RoftlNiNF+sCJJFsAZS6XtRJ9nBF2jIaTgfGauA=
X-Received: by 2002:ac8:5c4e:0:b0:3fc:7fb0:ad3a with SMTP id
 j14-20020ac85c4e000000b003fc7fb0ad3amr68778qtj.24.1687567278312; Fri, 23 Jun
 2023 17:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com> <20230601055846.2349566-3-jstultz@google.com>
 <509d5ee4-45ec-1279-97da-a308ec7f51aa@arm.com>
In-Reply-To: <509d5ee4-45ec-1279-97da-a308ec7f51aa@arm.com>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 23 Jun 2023 17:41:08 -0700
Message-ID: <CANDhNCr0NiCB-+h3pQtY9SG+Tm1_01eRpJVhhF75u_djFiEcQQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] locking/ww_mutex: Remove wakeups from under mutex::wait_lock
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        "Connor O'Brien" <connoro@google.com>
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

On Fri, Jun 23, 2023 at 5:21=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> Hi John,
>
> On 01/06/2023 07:58, John Stultz wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > In preparation to nest mutex::wait_lock under rq::lock we need to remov=
e
> > wakeups from under it.
>
> [...]
>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Connor O'Brien <connoro@google.com>
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
> > v2:
> > * Move wake_q_init() as suggested by Waiman Long
> > ---
> >  include/linux/ww_mutex.h  |  3 +++
> >  kernel/locking/mutex.c    |  8 ++++++++
> >  kernel/locking/ww_mutex.h | 10 ++++++++--
> >  3 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> > index bb763085479a..9335b2202017 100644
> > --- a/include/linux/ww_mutex.h
> > +++ b/include/linux/ww_mutex.h
> > @@ -19,6 +19,7 @@
> >
> >  #include <linux/mutex.h>
> >  #include <linux/rtmutex.h>
> > +#include <linux/sched/wake_q.h>
> >
> >  #if defined(CONFIG_DEBUG_MUTEXES) || \
> >     (defined(CONFIG_PREEMPT_RT) && defined(CONFIG_DEBUG_RT_MUTEXES))
> > @@ -58,6 +59,7 @@ struct ww_acquire_ctx {
> >       unsigned int acquired;
> >       unsigned short wounded;
> >       unsigned short is_wait_die;
> > +     struct wake_q_head wake_q;
>
> you told me that there is already an issue in this patch even w/o PE
> when running `insmod /lib/modules/test-ww_mutex.ko`.
>
> The issue is related to Connor's version (1):
>
> https://lkml.kernel.org/r/20221003214501.2050087-2-connoro@google.com
>
>   struct ww_acquire_ctx {
>
>           struct wake_q_head wake_q;
>
>
>   __mutex_lock_common()
>
>     if (ww_ctx)
>         ww_ctx_wake(ww_ctx)
>
>           wake_up_q(&ww_ctx->wake_q);
>           wake_q_init(&ww_ctx->wake_q);
>
>
> Juri's version (2):
>
> https://lkml.kernel.org/r/20181009092434.26221-3-juri.lelli@redhat.com
>
>   __mutex_lock_common()
>
>       DEFINE_WAKE_Q(wake_q) <-- !!!
>
>       __ww_mutex_check_waiters(..., wake_q)
>
>         __ww_mutex_die(..., wake_q)
>
>           wake_q_add(wake_q, waiter->task)
>
>       wake_up_q(&wake_q)
>
>
> `insmod /lib/modules/test-ww_mutex.ko` runs fine with (2) but not with
> (1) (both w/o the remaining PE patches).
>
> So to test the PE issues we talked about already which come with `[PATCH
> v4 09/13] sched: Add proxy execution` and CONFIG_PROXY_EXEC=3Dy we need t=
o
> fix (1) or go back to (2).
>
> I haven't found any clues why (2) was changed to (1) so far.

Right. I don't have context for why, but moving the wake_q to the
ww_ctx does seem to break the wake_q assumptions, and results in lost
wakeups.

In my current tree, I've switched back to Juri's older version of the
patch, but adding one fix from Connor's, and with that the patch
doesn't run into this trouble.

That said, I still am catching and debugging problems with later
patches in the series, which has required breaking up the core proxy
change into much finer grained changes so I can debug what's going
wrong.  My v5 patch set will reflect this.

thanks
-john
