Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59216FF1C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbjEKMok convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 08:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbjEKMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:44:33 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B60B4C3F;
        Thu, 11 May 2023 05:44:28 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ba68b965b24so1455223276.2;
        Thu, 11 May 2023 05:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683809067; x=1686401067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0nWnWXv1mK+kIB0lnxvJVZQ7RoySZ21qc81l9PKn/8=;
        b=ApUx6NVuD/z8euWrEo2eCnudjEVIQBZCcdGJHhecBpSGO17n9k891mpTwSS/iw71eM
         NXRfIOiDr88L8giMrbo17Ysmq1rtKX7B4O82uy2eYK7ym45HhwBTa/SzZj48Q1obGD4u
         bTrvKSexAYqx7EL6kKMJt9pEHsuUdQj36OJAmWMkuXnVh14kXkeqlMSdgLht1QH7Im6j
         8UVDsBIUnHsiFW+L+GTGOyGfqAwztpSilf9z5L6fDVTZzJGPoVC5cMVOaDlnxtOhQaCx
         N+GshXDBpvNa64WT35Zh6jLJ6BpoqH1iYS02DTu2ypJpnhbTAox5Z5ujhJG30zQtYG0c
         uN9w==
X-Gm-Message-State: AC+VfDzNErexG8kjQO13EJIKx0e2viuo2DM0wc5vsK0zmRmrXgsfLC61
        aEx65CMI+R+H245NKAirrhggsmNYALzesw==
X-Google-Smtp-Source: ACHHUZ7OxGYFz/ggeyNaL5Q7gWyw8bDEZ/QsD8bmAPwzmf4L14ccYRgFpRhdU2ppZz/Ur6prXc68WA==
X-Received: by 2002:a25:d6d5:0:b0:b95:99be:b8c with SMTP id n204-20020a25d6d5000000b00b9599be0b8cmr17072601ybg.64.1683809066983;
        Thu, 11 May 2023 05:44:26 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 191-20020a2513c8000000b00b8f13ff2a8esm4376507ybt.61.2023.05.11.05.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 05:44:26 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-55a26b46003so129787357b3.1;
        Thu, 11 May 2023 05:44:26 -0700 (PDT)
X-Received: by 2002:a81:4f16:0:b0:54f:ba86:9df with SMTP id
 d22-20020a814f16000000b0054fba8609dfmr21614696ywb.28.1683809066117; Thu, 11
 May 2023 05:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683722688.git.geert+renesas@glider.be> <8db63020d18fc22e137e4a8f0aa15e6b9949a6f6.1683722688.git.geert+renesas@glider.be>
 <CAPDyKFoTJFoDtSdPcXXQN_zi+TCQwr3UjLYu5jMCq_1sCnnG3Q@mail.gmail.com>
In-Reply-To: <CAPDyKFoTJFoDtSdPcXXQN_zi+TCQwr3UjLYu5jMCq_1sCnnG3Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 May 2023 14:44:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV6e84fbbm6m1Rn6f-1xdS10VkHaj5jOB0Sy1uKfacnNw@mail.gmail.com>
Message-ID: <CAMuHMdV6e84fbbm6m1Rn6f-1xdS10VkHaj5jOB0Sy1uKfacnNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iopoll: Do not use timekeeping in read_poll_timeout_atomic()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Thu, May 11, 2023 at 12:27 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 10 May 2023 at 15:23, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > read_poll_timeout_atomic() uses ktime_get() to implement the timeout
> > feature, just like its non-atomic counterpart.  However, there are
> > several issues with this, due to its use in atomic contexts:
> >
> >   1. When called in the s2ram path (as typically done by clock or PM
> >      domain drivers), timekeeping may be suspended, triggering the
> >      WARN_ON(timekeeping_suspended) in ktime_get():
> >
> >         WARNING: CPU: 0 PID: 654 at kernel/time/timekeeping.c:843 ktime_get+0x28/0x78
> >
> >      Calling ktime_get_mono_fast_ns() instead of ktime_get() would get
> >      rid of that warning.  However, that would break timeout handling,
> >      as (at least on systems with an ARM architectured timer), the time
> >      returned by ktime_get_mono_fast_ns() does not advance while
> >      timekeeping is suspended.
> >      Interestingly, (on the same ARM systems) the time returned by
> >      ktime_get() does advance while timekeeping is suspended, despite
> >      the warning.
>
> Interesting, looks like we should spend some time to further
> investigate this behaviour.

Probably, I was a bit surprised by this behavior, too.

> >   2. Depending on the actual clock source, and especially before a
> >      high-resolution clocksource (e.g. the ARM architectured timer)
> >      becomes available, time may not advance in atomic contexts, thus
> >      breaking timeout handling.
> >
> > Fix this by abandoning the idea that one can rely on timekeeping to
> > implement timeout handling in all atomic contexts, and switch from a
> > global time-based to a locally-estimated timeout handling.  In most
> > (all?) cases the timeout condition is exceptional and an error
> > condition, hence any additional delays due to underestimating wall clock
> > time are irrelevant.
>
> I wonder if this isn't an oversimplification of the situation. Don't
> we have timeout-error-conditions that we expected to happen quite
> frequently?

We may have some.  But they definitely do not happen when time
does not advance, or they would have been mitigated long ago
(the loop would never terminate).

> If so, in these cases, we really don't want to continue looping longer
> than actually needed, as then we will remain in the atomic context
> longer than necessary.
>
> I guess some information about how big these additional delays could
> be, would help to understand better. Of course, it's not entirely easy
> to get that data, but did you run some tests to see how this changes?

I did some timings (when timekeeping is available), and the differences
are rather minor.  The delay and timeout parameters are in µs, and
1 µs is already a few orders of magnitude larger than the cycle time
of a contemporary CPU.

Under-estimates are due to the time spent in op() (depends on the
user, typical use is a hardware device register read), udelay()
(architecture/platform-dependent accuracy), and general loop overhead.

> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Alternatively, one could use a mixed approach (use both
> > ktime_get_mono_fast_ns() and a local (under)estimate, and timeout on the
> > earliest occasion), but I think that would complicate things without
> > much gain.
>
> Another option could be to provide two different polling APIs for the
> atomic use-case.
>
> One that keeps using ktime, which is more accurate and generally
> favourable - and another, along the lines of what you propose, that
> should be used by those that can't rely on timekeeping.

At the risk of people picking the wrong one, leading to hard to
find bugs?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
