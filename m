Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3898067A3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjAXUd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAXUdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:33:55 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA11BFA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:33:53 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id b1so15189395ybn.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DngxDzOqd5iZTbA1Ft94FNQ9sK4bK2cIoSkRG8LUmCk=;
        b=btRsAR68Fwm1UJAA7++KT0wkLA3BTp8hC8IrJVugQsDQO1wEy5eAnIzhUg7T9U6pA5
         BIlm3U8wBbSW3PuteXUrr6GC2RfslcDiCqKWjeOUNLl2N6X6abc0v3ltuC19p6gigzUm
         AXftV57WxiC+GEZ2jxPzIMX/D54XZmBEr5W0rb/BNVZKQgFo/eYhLvQv8W9BxZIx0Jvv
         +ng4U+05k+1zF1QwWmZPOCblwx3bUD1gz4YguLjWxS2AzXpOTzDs0vNEHj3lBbatw7Vu
         nsni2J/jCC91Y2T4vthg3dkFwLlG9hu1FXv1D6lbaSUh0u8jmh224htbZGD1WNi7OEuY
         1KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DngxDzOqd5iZTbA1Ft94FNQ9sK4bK2cIoSkRG8LUmCk=;
        b=l2VZ7CFdofjr0AwEXnVbn6h+BLD91pO2VKHPndDPA6X365pX+4/ZodpD8+IzweBOfb
         F1kgryuWdPnjmU2EIpYh3MsxRNPnGwd/fBIsB/7tVqpQEqIUkd8PKyCp9fgI48/Ouo7b
         zCZivpZZT3tb3ZyzYhCvFzrH5PvOqesHoCzhfgki7F+XPM0MPbsznko1Sark63bfO9xm
         Fph+2AgTPrjm9yWHLdlyaX3sGS/qCyUfLQOS1Oh6vMkxecaHenrcOX3ZwrHyRB3gqhYj
         feHfsrLYW9XGQ8rrNLffjUAKiIVp8KEdzvDI5yyp57tsYtfVkxuRym0w0XauvL1CXK8x
         CJWw==
X-Gm-Message-State: AFqh2kreMTPki3uAzNTQS5kRvKxK3ggqjhh+LinfnRdq7hnts513ieGc
        qnkHen6BLuP+vVFDbbzgrkIfLuz69muECJuZc8Mo
X-Google-Smtp-Source: AMrXdXtGX6w6jF3OAhp70U4LifNDrg+emcKHezRWA2k0usTuFoIr0RxuWlTs4qh1YxzOLwOd507U92WbPJkOoHSrX1Q=
X-Received: by 2002:a25:1882:0:b0:807:4bf9:f4ec with SMTP id
 124-20020a251882000000b008074bf9f4ecmr1229222yby.313.1674592432967; Tue, 24
 Jan 2023 12:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-2-kan.liang@linux.intel.com> <CANDhNCpWwxXM8DD9h4zOW+bygshkOg9TWO9Z7wJO_B7bDtgEHw@mail.gmail.com>
 <9c17d6be-e532-84e1-4d35-77b9bd3051dc@linux.intel.com> <CANDhNCp_0Os+e0A0LZ7yKw16mWai9MAPMPYL0p1NkcVxifh88w@mail.gmail.com>
 <1fb59dfa-1ab9-51ad-98c6-89431aa56918@linux.intel.com>
In-Reply-To: <1fb59dfa-1ab9-51ad-98c6-89431aa56918@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 24 Jan 2023 12:33:41 -0800
Message-ID: <CANDhNCodq8iyRY-md-nRkAPYS5p3iTCgDqZXvWAA108TctQASg@mail.gmail.com>
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time to monotonic
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 12:13 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> On 2023-01-24 1:43 p.m., John Stultz wrote:
> > On Tue, Jan 24, 2023 at 7:09 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >> On 2023-01-24 2:01 a.m., John Stultz wrote:
> >>> On Mon, Jan 23, 2023 at 10:27 AM <kan.liang@linux.intel.com> wrote:
> >>>> +               /*
> >>>> +                * Check whether the given timestamp is on the current
> >>>> +                * timekeeping interval.
> >>>> +                */
> >>>> +               now = tk_clock_read(tkr);
> >>>> +               interval_start = tkr->cycle_last;
> >>>> +               if (!cycle_between(interval_start, cycles, now))
> >>>> +                       return -EOPNOTSUPP;
> >>>
> >>> So. I've not fully thought this out, but it seems like it would be
> >>> quite likely that you'd run into the case where the cycle_last value
> >>> is updated and your earlier TSC timestamp isn't valid for the current
> >>> interval. The get_device_system_crosststamp() logic has a big chunk of
> >>> complex code to try to handle this case by interpolating the cycle
> >>> value back in time. How well does just failing in this case work out?
> >>>
> >>
> >> For the case, perf fallback to the time captured in the NMI handler, via
> >> ktime_get_mono_fast_ns().
> >
> > This feels like *very* subtle behavior. Maybe I'm misunderstanding,
> > but the goal seems to be to have more accurate timestamps on the hw
> > events, and using the captured tsc timestamp avoids the measuring
> > latency reading the time again. But if every timekeeping update
> > interval (~tick) you transparently get a delayed value due to the
> > fallback, it makes it hard to understand which timestamps are better
> > or worse. The latency between two reads may be real or it may be just
> > bad luck. This doesn't intuitively seem like a great benefit over more
> > consistent latency of just using the ktime_get_mono_fast()
> > timestamping.
>
> Your understand is correct. We want a more accurate timestamp for the
> analysis work.
>
> As my understanding, the timekeeping update should not be very often. If

"Often" depends on your your timescale.

> I read the code correctly, it should happen only when adjusting NTP or
> suspending/resuming. If so, I think the drawback should not impact the
> normal analysis work. I will call out the drwabacks in the comments
> where the function is used.

So the adjustments are done at tick time depending on the current NTP
"error" (basically what the kernel tracks as the delta from its sense
of what NTP has told us).

Not just at the time when ntp makes an adjustment.

So the window for it to happen is every timekeeping update (which is ~HZ).


> >> The TSC in PEBS is captured by HW when the sample was generated. There
> >> should be a small delta compared with the time captured in the NMI
> >> handler. But I think the delta should be acceptable as a backup solution
> >> for the most analysis cases. Also, I don't think the case (the
> >> cycle_last value is updated during the monitoring) should occur very
> >> often either. So I drop the history support to simplify the function.
> >
> > So the reads and this function are *always* used in NMI context?   Has
> > this been stressed with things like SMIs to see how it does if
> > interrupted in those cases?
>
> Yes, it's *always* and only used in NMI context.

Thanks, that is helpful to clarify.

> > My worry is that (as I bored everyone earlier), the
> > ktime_get_*_fast_ns() interfaces already have some sharp edges and
> > need a fair amount of thought as to when they should be used. This is
> > sort of compounding that adding an interface that has further special
> > cases where it can fail, making it difficult to fully understand and
> > easier to accidentally misuse.
> >
> > My other concern is that interfaces always get stretched and used
> > beyond anything they were initially planned for (see the
> > ktime_get_*fast_ns() interfaces here as an example! :), and in this
> > case the logic seems to have lots of implicit dependencies on the
> > facts of your specific use case, so it seems a bit fragile should
> > folks on other architectures with other constraints try to use it.
> >
> > So I just want to push a bit to think how you might be able to
> > extend/generalize the existing get_system_crosststamp for your
> > purposes, or alternatively find a way to simplify the logic's behavior
> > so its less tied to specific constraints ("this works most of the time
> > from NMI, but otherwise no promises").  Or at least some better
> > documentation around the code, its uses and its constraints? ( "NMI
> > safe" is not the same as "Only safe to use from NMI" :)
>
> Since our usage is fixed (only in NMI), I prefer the latter. I think
> extending/generalizing the existing function only makes the function
> extremely complex and low efficient. The new function should have the
> same constraints as the existing ktime_get_mono_fast_ns(). Since perf
> can live with the ktime_get_mono_fast_ns(), there should be no problem
> with the new function for the constraints. I will add more comments to
> clarify the usage and constraints to avoid the abuse of the new function.

I agree the existing function is complex, so adding more complexity
isn't ideal, but potentially breaking it up or reworking it might be
better. Having two similar but different implementations is also a
complexity. So I just want to make sure this is well considered.  But
clearer documentation as a first step will help.

Thanks
-john
