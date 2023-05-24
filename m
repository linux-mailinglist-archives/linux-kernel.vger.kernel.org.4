Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20F170EC96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbjEXEjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjEXEjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:39:22 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CBF119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:39:20 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-338458a9304so30915ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684903160; x=1687495160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyHzAlJKyQhOX0WoUypWyXFcK/7in62UHuFMvkfM+WI=;
        b=7TVKceYPLLcRfoOQPxblGElhRhr6Q4jUuIcKcLkvsLTJGFnRctYIEJCHRCtrsyWqXt
         B2ZMQHB4EBSMhMkkh+tkeWpU3D17fv3QeIsn8WvPsOmcZ55nsJVs84Cm8lrO9feEvHPe
         mImjstxR5TrcwFvps/PVcJF9G+hk3skbqCWU/x2gtFBBXbt8myiIUAtNxja8Uuui1Ef0
         BMRotaPd5vmspexgM2bTn7LTE2bdd/0DZOdkzpP8N47f/Gs0vppXCf0L9BoeicBQn2+D
         kjSQERJ9rBegEJH/MSWtYl+v5o8D+HCL37dDfGVXi1IWiRd9bkKiX+C67d0PA2qeyRZD
         m4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684903160; x=1687495160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyHzAlJKyQhOX0WoUypWyXFcK/7in62UHuFMvkfM+WI=;
        b=kyh+cN5NTY7mXDDK7mPE6J7A7ttsJwWtdAVFUWT2+xoJoYA8Mk1y6Qj45t5WClGJLj
         W4MGNmeMyo4HLvQo6FvFyaGGNxhOLF7K2IsUzRprPBv6vJ9rBjEzhzcvTj0NA0sFZguF
         OIvYRDhNrm7xj7fnwNOSNgL6sFFj4BCq5jP8CmTYiLPepNcXF+10CUYWZa7PcbhVd16k
         kosHE3QbJ2uQPVVpYmpuJcE68/Yaz8p3FjkQF7/42tWG8nEfTI3GdwEL6Lfo9bH1YMPP
         wJJ4ZDiGuqz+jvqT/TK5e4Fi+sTP0G9RWzAO6HfbkqDOa7Y/X1JHzoe+psEF57t/pkW+
         WMvg==
X-Gm-Message-State: AC+VfDwFSCjkqzume3PAqql/W+3l8gckydiN2F0MVOXHmOu1E8OoN0i+
        5/TwmgIf8cCLac/IfWNdhRBca5JEtoQuZcF67jufQOGo8btux0fHrRjk
X-Google-Smtp-Source: ACHHUZ742Bm4JH+VDCttMaFDF7pY2oaja4SyLmLMa1blZtjFi+bOU92x+D9mrqBYredvUP79GxfGuhZEJRvtp6IFpnU=
X-Received: by 2002:a05:6e02:1544:b0:335:f8e9:2791 with SMTP id
 j4-20020a056e02154400b00335f8e92791mr135933ilu.18.1684903160018; Tue, 23 May
 2023 21:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230524040733.66946-1-feng.tang@intel.com>
In-Reply-To: <20230524040733.66946-1-feng.tang@intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 23 May 2023 21:39:07 -0700
Message-ID: <CANDhNCpN8YucULaTJs9YGhWSw7KHO22TdFE171XwV3fw-xM_Yw@mail.gmail.com>
Subject: Re: [PATCH] clocksource: Add a helper fucntion to reduce code duplication
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        paulmck@kernel.org
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

On Tue, May 23, 2023 at 9:08=E2=80=AFPM Feng Tang <feng.tang@intel.com> wro=
te:
>
> Several places use the same pattern of 'clocksource_delta() +
> clocksource_cyc2ns()' for calcualating the time delta in nanoseconds
> from 2 counters read from a clocksource. Add a helper function to
> simplify the code.
>
> signe-off-by: Feng Tang <feng.tang@intel.com>

Thanks for submitting this!

Can you fix your Signed-off-by: line? I would have thought checkpatch
would have caught that for you.

Additional thoughts below.

> ---
>  kernel/time/clocksource.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 91836b727cef..9f9e25cf5b44 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -145,6 +145,18 @@ static inline void clocksource_watchdog_unlock(unsig=
ned long *flags)
>         spin_unlock_irqrestore(&watchdog_lock, *flags);
>  }
>
> +
> +/*
> + * Calculate the delta of 2 counters read from a clocksource, and conver=
t
> + * it to nanoseconds. Intended only for short time interval calculation.
> + */
> +static inline u64 calc_counters_to_delta_ns(u64 new, u64 old, struct clo=
cksource *cs)

Bikeshed nit:  I'd probably do  calc_counters_to_delta_ns(struct
clocksource *cs, u64 new, u64 old) just to match the convention
elsewhere of passing the clocksource first.

Also, I might suggest naming it clocksource_cycle_interval_to_ns() ?
That feels clearer to me as to what it's doing.

> +{
> +       u64 delta =3D clocksource_delta(new, old, cs->mask);
> +
> +       return clocksource_cyc2ns(delta, cs->mult, cs->shift);
> +}
> +
>  static int clocksource_watchdog_kthread(void *data);
>  static void __clocksource_change_rating(struct clocksource *cs, int rati=
ng);
>
> @@ -223,7 +235,7 @@ enum wd_read_status {
>  static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 =
*csnow, u64 *wdnow)
>  {
>         unsigned int nretries;
> -       u64 wd_end, wd_end2, wd_delta;
> +       u64 wd_end, wd_end2;
>         int64_t wd_delay, wd_seq_delay;
>
>         for (nretries =3D 0; nretries <=3D max_cswd_read_retries; nretrie=
s++) {
> @@ -234,9 +246,7 @@ static enum wd_read_status cs_watchdog_read(struct cl=
ocksource *cs, u64 *csnow,
>                 wd_end2 =3D watchdog->read(watchdog);
>                 local_irq_enable();
>
> -               wd_delta =3D clocksource_delta(wd_end, *wdnow, watchdog->=
mask);
> -               wd_delay =3D clocksource_cyc2ns(wd_delta, watchdog->mult,
> -                                             watchdog->shift);
> +               wd_delay =3D calc_counters_to_delta_ns(wd_end, *wdnow, wa=
tchdog);
>                 if (wd_delay <=3D WATCHDOG_MAX_SKEW) {
>                         if (nretries > 1 || nretries >=3D max_cswd_read_r=
etries) {
>                                 pr_warn("timekeeping watchdog on CPU%d: %=
s retried %d times before success\n",
> @@ -254,8 +264,8 @@ static enum wd_read_status cs_watchdog_read(struct cl=
ocksource *cs, u64 *csnow,
>                  * report system busy, reinit the watchdog and skip the c=
urrent
>                  * watchdog test.
>                  */
> -               wd_delta =3D clocksource_delta(wd_end2, wd_end, watchdog-=
>mask);
> -               wd_seq_delay =3D clocksource_cyc2ns(wd_delta, watchdog->m=
ult, watchdog->shift);
> +
> +               wd_seq_delay =3D calc_counters_to_delta_ns(wd_end2, wd_en=
d, watchdog);
>                 if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
>                         goto skip_test;
>         }
> @@ -366,8 +376,8 @@ void clocksource_verify_percpu(struct clocksource *cs=
)
>                 delta =3D (csnow_end - csnow_mid) & cs->mask;
>                 if (delta < 0)
>                         cpumask_set_cpu(cpu, &cpus_ahead);
> -               delta =3D clocksource_delta(csnow_end, csnow_begin, cs->m=
ask);
> -               cs_nsec =3D clocksource_cyc2ns(delta, cs->mult, cs->shift=
);
> +
> +               cs_nsec =3D calc_counters_to_delta_ns(csnow_end, csnow_be=
gin, cs);
>                 if (cs_nsec > cs_nsec_max)
>                         cs_nsec_max =3D cs_nsec;
>                 if (cs_nsec < cs_nsec_min)
> @@ -398,7 +408,7 @@ static inline void clocksource_reset_watchdog(void)
>
>  static void clocksource_watchdog(struct timer_list *unused)
>  {
> -       u64 csnow, wdnow, cslast, wdlast, delta;
> +       u64 csnow, wdnow, cslast, wdlast;
>         int next_cpu, reset_pending;
>         int64_t wd_nsec, cs_nsec;
>         struct clocksource *cs;
> @@ -456,14 +466,10 @@ static void clocksource_watchdog(struct timer_list =
*unused)
>                         continue;
>                 }
>
> -               delta =3D clocksource_delta(wdnow, cs->wd_last, watchdog-=
>mask);
> -               wd_nsec =3D clocksource_cyc2ns(delta, watchdog->mult,
> -                                            watchdog->shift);
> -
> -               delta =3D clocksource_delta(csnow, cs->cs_last, cs->mask)=
;
> -               cs_nsec =3D clocksource_cyc2ns(delta, cs->mult, cs->shift=
);
>                 wdlast =3D cs->wd_last; /* save these in case we print th=
em */
>                 cslast =3D cs->cs_last;
> +               wd_nsec =3D calc_counters_to_delta_ns(wdnow, wdlast, watc=
hdog);
> +               cs_nsec =3D calc_counters_to_delta_ns(csnow, cslast, cs);

So, I get it takes common lines and combines them, but as it's an
inline function, you're likely not going to change the resulting
binary code, so this is just about readability, correct?

Personally, I find it easier to read code where the primitives are
fairly obvious/explicit, even if it's somewhat repetitive.

So combining these simpler operations means the function names are
less descriptive.  I'm sure future me will likely have to go digging
to find the consolidated logic to remind myself what it is actually
doing (and to double check what side effects it might have - luckily
none!).  For instance, the ordering of the two timestamps isn't always
obvious, whereas I know clocksource_delta() is subtraction so it
should be delta =3D new - old so the ordering is easy to remember.

So I'm not sure this is much of a win for readability in my mind?
But this is all personal taste, so I'll leave it to Thomas and others
to decide on.

I do appreciate you sending this out for consideration!

thanks
-john
