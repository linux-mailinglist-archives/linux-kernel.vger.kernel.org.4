Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966A273BD48
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFWQzk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 12:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjFWQzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:55:36 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1C81987;
        Fri, 23 Jun 2023 09:55:33 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-98771dde617so20327166b.1;
        Fri, 23 Jun 2023 09:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687539332; x=1690131332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmO07RL1iSny3Fmm7pVS1P+XYhA6spoyJIxO2RjFo1s=;
        b=QKuQFdb9awYrlEpNV3coFr8iGvGeAiIxlzW/Btuuwz6HhZK8MjES8be8Zaoa2Q5U9z
         bPAynkGEEaDlEc+Bnnrlh4tRc/IDNR8PPZWX6p8X2jmDAaehrhNV7O/WPzAjiJcf1LnG
         SNx2Eko8q5sEbYXUtQ5SAejHeR9g8lNfPHKS0zKpu3MZKYiJVCg6KomBe2RUHfbyl3tf
         YEp1sF0eXlm6baOra1kr6txf/ajzREv5By9/78JpJqGoJsjrmjF7uto5P9QdwbakHynU
         BViFFMzUJCZXhXzHaWAWYJmLkgN0k5fVfNsEuTgDU9UckBXEre1A5z3vhHikINfGAj9A
         zOCw==
X-Gm-Message-State: AC+VfDyqS3yLhY+ftRQ97gLHRlgsPFqrkODFrzNnp6CYXOsAvXhpgtV+
        RDoUcOz2T5VvStkK7USbnM43YvqJFz+fwiV2UiBKpuuh
X-Google-Smtp-Source: ACHHUZ60WvMZHKr40TFgp04IjKH9fLsXcso4zIOFl3OZHK2pnt/uAmAZDNhikNcmIOg0JRiNVS+OZx3HlhfOGo/aOTA=
X-Received: by 2002:a17:906:151:b0:988:3a6d:fb80 with SMTP id
 17-20020a170906015100b009883a6dfb80mr15013400ejh.1.1687539331767; Fri, 23 Jun
 2023 09:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
 <20230619063534.12831-1-di.shen@unisoc.com> <CAJZ5v0i9fyfNYyhAMqr0iYPbUNwrcvL7mxK1rMo+00mNRWKV6w@mail.gmail.com>
 <CAJZ5v0gHBxbU7Q0KYKsSVk+9nzSxot_JxUkcaAXrDxQx5_a7_Q@mail.gmail.com>
 <dbfe2b14-794a-e4d9-caf4-15d69ef86091@arm.com> <CAJZ5v0iOSWDBU0d4QPpsKwAW9N2u1mf-BLdKCtJ_49e8P0ZD7g@mail.gmail.com>
 <62c35d1c-7dcd-7bf2-253e-65cdfd6e92cc@arm.com> <CAJZ5v0iX2WYVjXWecJHVB_w1HAAOLDJvFLTMALGQF3pfv-rKSw@mail.gmail.com>
 <2884a54e-4db0-bf47-3b8a-0deb337208d8@arm.com>
In-Reply-To: <2884a54e-4db0-bf47-3b8a-0deb337208d8@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Jun 2023 18:55:20 +0200
Message-ID: <CAJZ5v0i5V8kpaaCsH4wuU83=zXpdJgR2CdCX-Wj=PmJx3OJ2Lg@mail.gmail.com>
Subject: Re: [PATCH V4] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, Di Shen <di.shen@unisoc.com>,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 9:43 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 6/22/23 19:27, Rafael J. Wysocki wrote:
> > On Tue, Jun 20, 2023 at 1:56 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 6/20/23 11:39, Rafael J. Wysocki wrote:
> >>> On Tue, Jun 20, 2023 at 12:19 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>> Hi Rafael,
> >>>>
> >>>>
> >>>> On 6/20/23 11:07, Rafael J. Wysocki wrote:
> >>>>> On Tue, Jun 20, 2023 at 11:46 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> [snip]
>
> >
> > Because this is up to the governor, the core has no clue what to do
> > with the return value from ->reset() and so there should be none.
> >
> > As I said, governors can print whatever diagnostic messages they like
> > in that callback, but returning anything from it to the core is just
> > not useful IMV.
> >
> >> For the rest of the governors - it's up to them what they
> >> report in case non-passive trip is updated...
> >
> > Sure.
> >
> >>>
> >>>> What Di is facing is in the issue under the bucket of
> >>>> 'handle_non_critical_trips()' when the governor just tries to
> >>>> work on stale data - old trip temp.
> >>>
> >>> Well, fair enough, but what about the other governors?  Is this
> >>> problem limited to power_allocator?
> >>
> >> IIUC the core fwk code - non of the governors would be needed
> >> to handle the critical/hot trips. For the rest of the trip types
> >> I would say it's up to the governor. In our IPA case this stale
> >> data is used for power budget estimation - quite fundamental
> >> step. Therefore, the reset and start from scratch would make more
> >> sense.
> >>
> >> I think other governors don't try to 'estimate' such
> >> abstract power headroom based on temperature - so probably
> >> they don't have to even implement the 'reset()' callback
> >> (I don't know their logic that well).
> >
> > So there seems to be a claim that IPA is the only governor needing the
> > ->reset() callback, but I have not seen any solid analysis confirming
> > that.  It very well may be the case, but then the changelog should
> > clearly explain why this is the case IMO.
>
> I agree, the patch header doesn't explain that properly. Here is the
> explanation for this Intelligent Power Allocator (IPA):
>
> The IPA controls temperature using PID mechanism. It's a closed
> feedback loop. That algorithm can 'learn' from the 'observed'
> in the past reaction for it's control decisions and accumulates that
> information in the part called 'error integral'. Those accumulated
> 'error' gaps are the differences between the set target value and the
> actually achieved value. In our case the target value is the target
> temperature which is coming from the trip point. That part is then used
> with the 'I' (of PID) component, so we can compensate for those
> 'learned' mistakes.
> Now, when you change the target temperature value - all your previous
> learned errors won't help you. That's why Intelligent Power Allocator
> should reset previously accumulated history.

Right.

And every other governor using information from the past for control
will have an analogous problem, won't it?

> >
> >>>
> >>>> For the 2nd case IIUC the code, we pass the 'trip.temperature'
> >>>> and should be ready for what you said (modification of that value).
> >>>
> >>> Generally speaking, it needs to be prepared for a simultaneous change
> >>> of multiple trip points (including active), in which case it may not
> >>> be useful to invoke the ->reset() callback for each of them
> >>> individually.
> >>
> >> Although, that looks more cleaner IMO. Resetting one by one in
> >> a temperature order would be easily maintainable, won't be?
> >
> > I wouldn't call it maintainable really.
> >
> > First of all, the trips may not be ordered.  There are no guarantees
> > whatsoever that they will be ordered, so the caller may have to
> > determine the temperature order in the first place.  This would be an
> > extra requirement that currently is not there.
> >
> > Apart from this, I don't see any fundamental difference between the
> > case when trip points are updated via sysfs and when they are updated
> > by the driver.  The governor should reset itself in any of those cases
> > and even if one trip point changes, the temperature order of all of
> > them may change, so the governor reset mechanism should be able to
> > handle the case when multiple trip points are updated at the same
> > time.  While you may argue that this is theoretical, the ACPI spec
> > clearly states that this is allowed to happen, for example.
> >
> > If you want a generic reset callback for governors, that's fine, but
> > make it generic and not specific to a particular use case.
>
> I think we agree here, but probably having slightly different
> implementation in mind. Based on you explanation I think you
> want simply this API:
> void (*reset)(struct thermal_zone_device *tz);
>
> 1. no return value
> 2. no specific trip ID as argument
>
> Do you agree?

Yes, I do.

> IMO such implementation and API would also work for this IPA
> purpose. Would that work for the ACPI use case as well?

It would AFAICS.
