Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E706A99C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCCOtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjCCOs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:48:58 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA913D919;
        Fri,  3 Mar 2023 06:48:57 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bi17so1968343oib.3;
        Fri, 03 Mar 2023 06:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677854936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=95fD1OMocm4n8bJJC6tFnFtkplpEQySvwjBizvI/Tpo=;
        b=H8QbelVEw4Vh8BarvpWGCoSzGSZZvuUsFbB+c82/q20vffUTswfFY2u+Tl0R3sXrbW
         cFKl8/7P2yLWoKR1UV5jhiJfMbPITDEreXyy3XUd3Bx+EePTrtoW9mrK6wscRkoJ+2aJ
         5fjoNNJzTeh5EoCDXG3GysgWY338xt4aBazpADFEOOpjcX08urE7ZuZGcrmHjRu/uNll
         6wekbPxRCxNR6/RU2Jo+llW1KSCE+U/RMRtNk1Bjv+Ogrl1ILAEF4/5YyQNmzXZeqBGb
         +m066zgXiE7fg+2WBqFBzKeXmpaWIPJHHVW6knXxmSiKugJXUMdzE/fK+fI6SYy+sDv7
         YpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677854936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95fD1OMocm4n8bJJC6tFnFtkplpEQySvwjBizvI/Tpo=;
        b=Bt8kIWxOcjV2/VYhD0cMc21nJQYs8fADk/y3OwQ/dsy1ymjMBh+7Qo9v9YJWTcDmFY
         BxkOzDR3jhjCTZGMyAR5dk0ZlEOUkqs3wWr5PVcXD3Zb5ObNA7nsZchPkTb8KUoiKFA/
         89H05vTHlPhhXWUpd+Qiq1NKDi07Kj0V+zNOW2vxN9MkyCkns5TP6gdzNwsv9jhUNISk
         UcJBQ5Kst/EQtDMZq9rYwYaGb/e8aaXlNKlMwuaSWV8XgEfChaRKFn6wSQwRevzrsEze
         j8Ovn1GFNF97loD2DmOaZkmZBxkvY0zvVtITkf9fJHKiHzWKrmRdnKOlL65uf46eRPdI
         VeJQ==
X-Gm-Message-State: AO0yUKXL0CmDUcZxQqYdk7fYh1wsXXbXd7YN87Z4O4XEynf18vvKLhnR
        zAxSUO0bZ+x99P1LDDw6gO48rwpqedMGq38mZ0U=
X-Google-Smtp-Source: AK7set+3e72I1aKOy6TuglUkJuSkxFy00dwwauEHhVb/G5t4QUiLGNGQh5N5d5lD2/Blvvsq/7AIUvcQeTiZih4TE1k=
X-Received: by 2002:a05:6808:354:b0:384:692c:56c9 with SMTP id
 j20-20020a056808035400b00384692c56c9mr624924oie.3.1677854936419; Fri, 03 Mar
 2023 06:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20230302235356.3148279-1-robdclark@gmail.com> <20230302235356.3148279-16-robdclark@gmail.com>
 <ZAFnqbycMleLmRe9@intel.com> <3bded9d7-9796-4a9b-7c11-aac994d4fdc6@linux.intel.com>
In-Reply-To: <3bded9d7-9796-4a9b-7c11-aac994d4fdc6@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 3 Mar 2023 06:48:43 -0800
Message-ID: <CAF6AEGs6QYTESuwB8E9cTbv9LqQX16tz6-geeu9BCyFos9=sOA@mail.gmail.com>
Subject: Re: [PATCH v9 15/15] drm/i915: Add deadline based boost support
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 1:58 AM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 03/03/2023 03:21, Rodrigo Vivi wrote:
> > On Thu, Mar 02, 2023 at 03:53:37PM -0800, Rob Clark wrote:
> >> From: Rob Clark <robdclark@chromium.org>
> >>
> >
> > missing some wording here...
> >
> >> v2: rebase
> >>
> >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >> ---
> >>   drivers/gpu/drm/i915/i915_request.c | 20 ++++++++++++++++++++
> >>   1 file changed, 20 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
> >> index 7503dcb9043b..44491e7e214c 100644
> >> --- a/drivers/gpu/drm/i915/i915_request.c
> >> +++ b/drivers/gpu/drm/i915/i915_request.c
> >> @@ -97,6 +97,25 @@ static bool i915_fence_enable_signaling(struct dma_fence *fence)
> >>      return i915_request_enable_breadcrumb(to_request(fence));
> >>   }
> >>
> >> +static void i915_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
> >> +{
> >> +    struct i915_request *rq = to_request(fence);
> >> +
> >> +    if (i915_request_completed(rq))
> >> +            return;
> >> +
> >> +    if (i915_request_started(rq))
> >> +            return;
> >
> > why do we skip the boost if already started?
> > don't we want to boost the freq anyway?
>
> I'd wager Rob is just copying the current i915 wait boost logic.

Yup, and probably incorrectly.. Matt reported fewer boosts/sec
compared to your RFC, this could be the bug

> >> +
> >> +    /*
> >> +     * TODO something more clever for deadlines that are in the
> >> +     * future.  I think probably track the nearest deadline in
> >> +     * rq->timeline and set timer to trigger boost accordingly?
> >> +     */
> >
> > I'm afraid it will be very hard to find some heuristics of what's
> > late enough for the boost no?
> > I mean, how early to boost the freq on an upcoming deadline for the
> > timer?
>
> We can off load this patch from Rob and deal with it separately, or
> after the fact?

That is completely my intention, I expect you to replace my i915 patch ;-)

Rough idea when everyone is happy with the core bits is to setup an
immutable branch without the driver specific patches, which could be
merged into drm-next and $driver-next and then each driver team can
add there own driver patches on top

BR,
-R

> It's a half solution without a smarter scheduler too. Like
> https://lore.kernel.org/all/20210208105236.28498-10-chris@chris-wilson.co.uk/,
> or if GuC plans to do something like that at any point.
>
> Or bump the priority too if deadline is looming?
>
> IMO it is not very effective to fiddle with the heuristic on an ad-hoc
> basis. For instance I have a new heuristics which improves the
> problematic OpenCL cases for further 5% (relative to the current
> waitboost improvement from adding missing syncobj waitboost). But I
> can't really test properly for regressions over platforms, stacks,
> workloads.. :(
>
> Regards,
>
> Tvrtko
>
> >
> >> +
> >> +    intel_rps_boost(rq);
> >> +}
> >> +
> >>   static signed long i915_fence_wait(struct dma_fence *fence,
> >>                                 bool interruptible,
> >>                                 signed long timeout)
> >> @@ -182,6 +201,7 @@ const struct dma_fence_ops i915_fence_ops = {
> >>      .signaled = i915_fence_signaled,
> >>      .wait = i915_fence_wait,
> >>      .release = i915_fence_release,
> >> +    .set_deadline = i915_fence_set_deadline,
> >>   };
> >>
> >>   static void irq_execute_cb(struct irq_work *wrk)
> >> --
> >> 2.39.1
> >>
