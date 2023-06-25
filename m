Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6002273CF6E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjFYIkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 04:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjFYIkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:40:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC0610C0;
        Sun, 25 Jun 2023 01:40:15 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7654e1d83e8so178712385a.1;
        Sun, 25 Jun 2023 01:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687682414; x=1690274414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQinQxvp5MdiOhBT5QzM2xeQ6/LVgVdhwk/Y8pJ2LoI=;
        b=n984TvmX6TnPC3y7cfLRidC4bWfLJl8+7Rh8EBWn3qdlg/nDb5bIGgrOL0sPlEd0kk
         f51NImUKcw4Jbg3xUvOXBU9z0ozvlWndSH2k9V/VVoockK3v139z3/DCAp9r2XgS3n0Q
         yuRlPBrZcvDDf/cjSoybKKSFvB8gQjJtU51RGrYpBcfjNYhNCIX2W3y3Y0HGkESFP++j
         GPp1jf7Iyx86Kf4ecWnBlHj+y0xw5T2XC0sZPcej3skrKSLd6BzwTQ6TGn8P84KUCApW
         5DNBuiyrRaPjrfy+I7o5oRawvGlSHwlvfqwSv4MjObFgSJy+DceOBngx92YDQ3LbzBxi
         vuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687682414; x=1690274414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQinQxvp5MdiOhBT5QzM2xeQ6/LVgVdhwk/Y8pJ2LoI=;
        b=HfMFzi5g//MLZO6FXHrXupRMLr8JEa21nuJR6WyPaEHlX+C35R/3RHgBZ0qirLM8Ug
         9fhAFERnPlQf1kziOHLbMDmVaGBw0F9s/C4jKaDLeVP5FRT6mGSOSqRWi7Kl/yxySWT0
         8EvqCjK2Wg6U0nUFpNMrlk3OJrif9W7rjJAz2RVIMv7rUxSG3LAFEuD6UtrS3Vy9o5O3
         orL7JFxAzwjTQlZVAjxh/BZqkGOn4O0SLViBbz7+ZZSD8rervVdswapSh1G6dwZ7OvgX
         3hVToKjnnHijFewadgcHFu2+HBA/1gJL9Kb/epUOWTT3FW1d7tcb0fZ9UHAJJh+P0Zrb
         vDSA==
X-Gm-Message-State: AC+VfDxHoAM1HZyAzZWIXCsRVy4Z/VxXg/N9Md4KB487zB/LQZ/H5apz
        V2li9WIySZJFjYNWoEcFD+annNdrokM5wuXqobA=
X-Google-Smtp-Source: ACHHUZ4S8pzE7Isl0CeZz8Mnv9xl6KAzMFjHgvcpwU69F60tYeiQydsFvaYDSqS0nYOEqe6eWUIIyMZun7nsBQRGLgg=
X-Received: by 2002:a05:620a:2493:b0:765:65bd:614e with SMTP id
 i19-20020a05620a249300b0076565bd614emr3730304qkn.51.1687682414147; Sun, 25
 Jun 2023 01:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
 <20230619063534.12831-1-di.shen@unisoc.com> <CAJZ5v0i9fyfNYyhAMqr0iYPbUNwrcvL7mxK1rMo+00mNRWKV6w@mail.gmail.com>
 <CAJZ5v0gHBxbU7Q0KYKsSVk+9nzSxot_JxUkcaAXrDxQx5_a7_Q@mail.gmail.com>
 <dbfe2b14-794a-e4d9-caf4-15d69ef86091@arm.com> <CAJZ5v0iOSWDBU0d4QPpsKwAW9N2u1mf-BLdKCtJ_49e8P0ZD7g@mail.gmail.com>
 <62c35d1c-7dcd-7bf2-253e-65cdfd6e92cc@arm.com> <CAJZ5v0iX2WYVjXWecJHVB_w1HAAOLDJvFLTMALGQF3pfv-rKSw@mail.gmail.com>
 <2884a54e-4db0-bf47-3b8a-0deb337208d8@arm.com> <CAJZ5v0i5V8kpaaCsH4wuU83=zXpdJgR2CdCX-Wj=PmJx3OJ2Lg@mail.gmail.com>
 <86da9945-04d5-047a-cb2d-5fb63737839f@arm.com>
In-Reply-To: <86da9945-04d5-047a-cb2d-5fb63737839f@arm.com>
From:   Di Shen <cindygm567@gmail.com>
Date:   Sun, 25 Jun 2023 16:40:03 +0800
Message-ID: <CAHYJL4qp2C8PFgvwsv_R7hvb52=gQYeR6NMe4+6yMyqgQ56iAg@mail.gmail.com>
Subject: Re: [PATCH V4] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Di Shen <di.shen@unisoc.com>, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 1:54=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 6/23/23 17:55, Rafael J. Wysocki wrote:
> > On Fri, Jun 23, 2023 at 9:43=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> >>
> >>
> >>
>
> [snip]
>
> >>
> >> I agree, the patch header doesn't explain that properly. Here is the
> >> explanation for this Intelligent Power Allocator (IPA):
> >>
> >> The IPA controls temperature using PID mechanism. It's a closed
> >> feedback loop. That algorithm can 'learn' from the 'observed'
> >> in the past reaction for it's control decisions and accumulates that
> >> information in the part called 'error integral'. Those accumulated
> >> 'error' gaps are the differences between the set target value and the
> >> actually achieved value. In our case the target value is the target
> >> temperature which is coming from the trip point. That part is then use=
d
> >> with the 'I' (of PID) component, so we can compensate for those
> >> 'learned' mistakes.
> >> Now, when you change the target temperature value - all your previous
> >> learned errors won't help you. That's why Intelligent Power Allocator
> >> should reset previously accumulated history.
> >
> > Right.
> >
> > And every other governor using information from the past for control
> > will have an analogous problem, won't it?
>
> Not necessarily, but to play safe I would go case-by-case and make
> sure other governors are aligned to this new feature.
>
> E.g. the bang-bang governor operates only on current temperature and
> current trip value + trip hysteresis. The flow graph describes it [1].
> The control (state of the fan: ON or OFF) of that governor could be
> simply adjusted to the new reality -> new trip point temp. That would
> just mean 'toggling' the fan if needed. There are only 2 'target'
> states: 0 or 1 for the fan. You can images a situation when the
> temperature doesn't change, but we manipulate the trip value for that
> governor. The governor would react correctly always in such situation
> w/o a need of a reset IMO.
>
> >
> >>>
> >>>>>
> >>>>>> For the 2nd case IIUC the code, we pass the 'trip.temperature'
> >>>>>> and should be ready for what you said (modification of that value)=
.
> >>>>>
> >>>>> Generally speaking, it needs to be prepared for a simultaneous chan=
ge
> >>>>> of multiple trip points (including active), in which case it may no=
t
> >>>>> be useful to invoke the ->reset() callback for each of them
> >>>>> individually.
> >>>>
> >>>> Although, that looks more cleaner IMO. Resetting one by one in
> >>>> a temperature order would be easily maintainable, won't be?
> >>>
> >>> I wouldn't call it maintainable really.
> >>>
> >>> First of all, the trips may not be ordered.  There are no guarantees
> >>> whatsoever that they will be ordered, so the caller may have to
> >>> determine the temperature order in the first place.  This would be an
> >>> extra requirement that currently is not there.
> >>>
> >>> Apart from this, I don't see any fundamental difference between the
> >>> case when trip points are updated via sysfs and when they are updated
> >>> by the driver.  The governor should reset itself in any of those case=
s
> >>> and even if one trip point changes, the temperature order of all of
> >>> them may change, so the governor reset mechanism should be able to
> >>> handle the case when multiple trip points are updated at the same
> >>> time.  While you may argue that this is theoretical, the ACPI spec
> >>> clearly states that this is allowed to happen, for example.
> >>>
> >>> If you want a generic reset callback for governors, that's fine, but
> >>> make it generic and not specific to a particular use case.
> >>
> >> I think we agree here, but probably having slightly different
> >> implementation in mind. Based on you explanation I think you
> >> want simply this API:
> >> void (*reset)(struct thermal_zone_device *tz);
> >>
> >> 1. no return value
> >> 2. no specific trip ID as argument
> >>
> >> Do you agree?
> >
> > Yes, I do.
>
> OK, thanks.
>
> Di could you implement that 'reset()' API according to this description,
> please?
>
Yes, happy to do that.

> >
> >> IMO such implementation and API would also work for this IPA
> >> purpose. Would that work for the ACPI use case as well?
> >
> > It would AFAICS.
>
> Thanks Rafael for the comments and the progress that we made :)
>
> Regards,
> Lukasz
>
> [1]
> https://elixir.bootlin.com/linux/v6.3/source/drivers/thermal/gov_bang_ban=
g.c#L80

Thanks Lukas and Rafeal for the comments. I will send the next version late=
r.

Best regards,
Di
