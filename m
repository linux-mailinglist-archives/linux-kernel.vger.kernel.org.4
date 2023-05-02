Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE286F3C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 05:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjEBDGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 23:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjEBDG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 23:06:27 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F6C3AB3
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 20:06:25 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f0a2f8216fso32861cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 20:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682996785; x=1685588785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdqFMAjqlQvUvc50H/u0uZmgUhJHOGvPzLI8RH3+DdU=;
        b=ncQ3a/JBnU2daB+Lbk7kY9jTbhmW+ye4pjwNEo2AcvtJww94H1DSj/+8jLWzwMU7c6
         Z/sMMaVJRLZl2IYjclI2CYjVcfQkL9cH9FiLqJvuwV6k1I1Lhqcj1kM/VbsJF/JgRr8h
         AEtp2wRSWSmexX9ajogi56GarPYk9LKYR/ByAvF4zfktfd7drfNTzdqDFh2Ou48V9qnj
         B7MZC4yzDREuZ53xaAPVWo8CO0iwNcJ6cVzIQqy1ep4yAk2vt5iqQZZShFwsDOs22/vG
         +9hEgx6gmlyFotoWBDEvT3wO0/A608UZKDFgQJsjKSDdt7RzMdxtwfLpM2zEr6wI0YYC
         AJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682996785; x=1685588785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdqFMAjqlQvUvc50H/u0uZmgUhJHOGvPzLI8RH3+DdU=;
        b=BV65kL4F9/b0r25lDVA3xdr9GPukdzLI0sZ86iMU1KCwknj2C3KCN8nUyrz5FMqMES
         Eb7zlz+l5J3K8furkhzPZnKVojAS/ZzfQFwrh+3zYKQu8djUyygfRltBeKe0xmfuDHo7
         XrijmK8vvR6CF5xP9YmMXcK+zs41OnV2q+Ddgb+ko9xrzh/TjFV6GNISNBnEukw2cyZN
         YRcJLZTi/EBgOXgLe1tsbCgXDBVb3XcFWvVGBlEZP51At/KZIHZuiTo0HUay5S2gFmwI
         3HTN4yR7oIClEiwqv6vfpDiocWjS/23MoXPIFcbbP291rFcjzTe+IM5l/KjxECIc9+pr
         BhhQ==
X-Gm-Message-State: AC+VfDxokzz9FnijuCQdI9ZMoKrhtpGqHPrLv9IW8nrPsjml7WzF4+uq
        wUdjaYKSXVZ0FugOWNewRz1yigAv0I6lxN4T6LIe
X-Google-Smtp-Source: ACHHUZ6xkBXKQzMok6OokiVuAlgdLIOasM5wYm3veUnbXzP4/5vOr8fH7euHBTN3t2SHEXPblrGmKUZeihKberN1ADA=
X-Received: by 2002:a05:622a:1ca:b0:3f1:bb90:c006 with SMTP id
 t10-20020a05622a01ca00b003f1bb90c006mr129548qtw.11.1682996784971; Mon, 01 May
 2023 20:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <fb8d80434b2148e78c0032c6c70a8b4d@huawei.com> <CANDhNCqfBdh8zUd+LseTTQKpmJ27Uid+ZV_+FNckZPNc2Oy3-w@mail.gmail.com>
 <f2b7fdba4ead429bb4dd38a9ccb3735a@huawei.com>
In-Reply-To: <f2b7fdba4ead429bb4dd38a9ccb3735a@huawei.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 1 May 2023 20:06:13 -0700
Message-ID: <CANDhNCoaMPj-aa1VKJoVawBgZWOiZpvZ5cnvVJq4F_d-miTNcA@mail.gmail.com>
Subject: Re: [Question] softlockup in run_timer_softirq
To:     "liujian (CE)" <liujian56@huawei.com>,
        Frank Woo <frankwoo@google.com>,
        Rhine Wu <Rhinewuwu@google.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
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

On Wed, Feb 15, 2023 at 12:34=E2=80=AFAM liujian (CE) <liujian56@huawei.com=
> wrote:
> > On Fri, Feb 10, 2023 at 1:51 AM liujian (CE) <liujian56@huawei.com> wro=
te:
> > >
> > > During the syz test, we encountered many problems with various timer
> > > handler functions softlockup.
> > >
> > > We analyze __run_timers() and find the following problem.
> > >
> > > In the while loop of __run_timers(), because there are too many timer=
s
> > > or improper timer handler functions, if the processing time of the
> > > expired timers is always greater than the time wheel's next_expiry,
> > > the function will loop infinitely.
> > >
> > > The following extreme test case can be used to reproduce the problem.
> > > An extreme test case[1] is constructed to reproduce the problem.
> >
> > Thanks for reporting and sending out this data:
> >
> > First, any chance you might submit this as a in-kernel-stress test?
> > Maybe utilizing the kernel/torture.c framework?
> >
> Okay,   I'll learn this framework and do this thing.
> > (Though the test may need to occasionally take a break so the system ca=
n
> > eventually catch up)
> >
> > > Is this a problem or an unreasonable use?
> > >
> > > Can we limit the running time of __run_timers() [2]?
> > >
> > > Does anyone have a good idea to solve this problem?
> >
> > So your patch reminds me of Peter's softirq_needs_break() logic:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=
=3Dco
> > re/softirq
> >
> > Maybe it could extend that series for the timer softirq as well?
> >
> Thank you. Yes.
> Base on the patchset and the extended patch for timer [1], the soft locku=
p problem does not occur.
>
> By the way, I see this is a very old patchset?  Will this patchset push t=
he main line? @John @Peter
>
>
>  [1]
> Author: Liu Jian <liujian56@huawei.com>
> Date:   Tue Feb 14 09:53:46 2023 +0800
>
>     softirq, timer: Use softirq_needs_break()
>
>     In the while loop of __run_timers(), because there are too many timer=
s or
>     improper timer handler functions, if the processing time of the expir=
ed
>     timers is always greater than the time wheel's next_expiry, the funct=
ion
>     will loop infinitely.
>
>     To prevent this, use the timeout/break logic provided by SoftIRQs.If =
the
>     running time exceeds the limit, break the loop and an additional
>     TIMER_SOFTIRQ is triggered.
>
>     Signed-off-by: Liu Jian <liujian56@huawei.com>
>
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 63a8ce7177dd..70744a469a39 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1992,7 +1992,7 @@ void timer_clear_idle(void)
>   * __run_timers - run all expired timers (if any) on this CPU.
>   * @base: the timer vector to be processed.
>   */
> -static inline void __run_timers(struct timer_base *base)
> +static inline void __run_timers(struct timer_base *base, struct softirq_=
action *h)
>  {
>         struct hlist_head heads[LVL_DEPTH];
>         int levels;
> @@ -2020,6 +2020,12 @@ static inline void __run_timers(struct timer_base =
*base)
>
>                 while (levels--)
>                         expire_timers(base, heads + levels);
> +
> +               if (softirq_needs_break(h)) {
> +                       if (time_after_eq(jiffies, base->next_expiry))
> +                               __raise_softirq_irqoff(TIMER_SOFTIRQ);
> +                       break;
> +               }
>         }
>         raw_spin_unlock_irq(&base->lock);
>         timer_base_unlock_expiry(base);
> @@ -2032,9 +2038,9 @@ static __latent_entropy void run_timer_softirq(stru=
ct softirq_action *h)
>  {
>         struct timer_base *base =3D this_cpu_ptr(&timer_bases[BASE_STD]);
>
> -       __run_timers(base);
> +       __run_timers(base, h);
>         if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
> -               __run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
> +               __run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]), h);
>  }
>
>  /*

So I wanted to revive this old thread, as Frank Woo mentioned his team
has seen a similar issue as well.

Liujian: I'm curious if you've made any further progress with your
adapted patch ontop of PeterZ's softirq_needs_break patch series?

Might it be worth re-submitting the whole series for consideration upstream=
?

thanks
-john
