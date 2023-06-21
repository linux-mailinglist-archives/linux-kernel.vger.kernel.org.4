Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B10737A75
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFUEvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFUEvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:51:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF858129;
        Tue, 20 Jun 2023 21:51:12 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-763cb62e90fso10510985a.3;
        Tue, 20 Jun 2023 21:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687323072; x=1689915072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcA2fKiE391GsFWu047jREyt6uXq8TYN8c7wi899quU=;
        b=e7+MTZul/07aL2AdewLGC+bR5E5C36zw/s82Do9zyEd/85oBGJHfTfTc3mLow6XfSp
         VnoCGiqlMiBTuGURG1fNtSqmans1i9qRhtHvkVBtCLrRO1p/UVXkXVa4GcuBUJtb3jaY
         6VbY2StjmfFAdDQqrGAR9hI1XbGMx3u6wwkYjwc36sJUA++L09lKDwKIR+heB+Olio/D
         Q6eNqRhbsWjZcZNNj2NtTzcY0mD0J1Oq/C+0WUTOVcZkkOuBy0eqaR1Ra3DTVAAh0B93
         qBDBecjWxJ2kQHg49Zbaj6rXqwHYX0kZo1lnm12jxXekMAN7Z3fgpl9zMSpf6NXvbIa6
         Um+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687323072; x=1689915072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcA2fKiE391GsFWu047jREyt6uXq8TYN8c7wi899quU=;
        b=NBkwq9vIcssV5RHAZrmmpBZDLAAZinVSrLa4kxnynb8KMbl5AU4BeOiMWilQ+Rd/ID
         kxFyvSNdk0kGnWPN/MHYe1FaRLEjIbtLDEW9lYm8V8jcJjZ1ZBERZkgEMVg66Bu7vJm5
         WDPlEcvxfCJnQSdixlIKwFsmXWeqxlKde29T9hxrrDnM6vJudFrkKAv6RxxBiPadGk8n
         NxPySc49zHZDr2A6QPc5cMVMUY6RiR2loyc16ihAlaynKHFZln+LbN1FIaxjwmhuXCZZ
         ls9lGrRFLd3ybuYk/8sCsTAxREInux/ZWnOhUZps0koueOJcSq5mEqColE/PmK2ATWoh
         UfQA==
X-Gm-Message-State: AC+VfDy9iPWZ4C58/cd8nJ51gP8gvDyVlYyioK4atWzYy4c1m96CG2r2
        dYTmCn/uA5f/MRfqsVqpUqoxK1fbexKF3na6dZs=
X-Google-Smtp-Source: ACHHUZ7Pn5KsgcjLIpZxjI+b5rNYI64RQ86XlRQvFqNtZmY5ULydApAecSjRXpvg2sxTXIpIjKKinkbi/ib4x0wgroI=
X-Received: by 2002:a05:620a:398d:b0:75b:23a1:8e6f with SMTP id
 ro13-20020a05620a398d00b0075b23a18e6fmr12695900qkn.64.1687323071838; Tue, 20
 Jun 2023 21:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
 <20230619063534.12831-1-di.shen@unisoc.com> <1a921c36-1959-65e0-aaf7-da2683cdb8c4@arm.com>
In-Reply-To: <1a921c36-1959-65e0-aaf7-da2683cdb8c4@arm.com>
From:   Di Shen <cindygm567@gmail.com>
Date:   Wed, 21 Jun 2023 12:51:00 +0800
Message-ID: <CAHYJL4rKE+2TiYLEYUE3VO7Ws+uPazD0Fd-9EqZ1pGB_eU2Lvw@mail.gmail.com>
Subject: Re: [PATCH V4] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Di Shen <di.shen@unisoc.com>, amitk@kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, zhanglyra@gmail.com,
        orsonzhai@gmail.com, rafael@kernel.org
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

On Tue, Jun 20, 2023 at 6:39=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Di,
>
> I have missed your v4 because it landed below your v3 thread.
>
> On 6/19/23 07:35, Di Shen wrote:
> > When the thermal trip point is changed, the governor should
> > be reset so that the policy algorithm be updated to adapt to the
> > new trip point.
> >
> > This patch adds an ops for thermal the governor structure to reset
>
> s/ops/callback
>
> > the governor. The ops is called when the trip point is changed.
> > For power allocator, the parameters of pid controller and the states
> > of power cooling devices can be reset when the passive trip point
> > is changed.
> >
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> >
> > ---
> > V4:
> > - Compared to V3, handle it in thermal core instead of in governor.
> >
> > - Add an ops to the governor structure, and call it when a trip
> >    point is changed.
> >
> > - Define reset ops for power allocator.
> >
> > V3:
> > - Add fix tag.
> >
> > V2:
> > - Compared to v1, do not revert.
> >
> > - Add a variable(last_switch_on_temp) in power_allocator_params
> >    to record the last switch_on_temp value.
> >
> > - Adds a function to renew the update flag and update the
> >    last_switch_on_temp when thermal trips are writable.
> >
> > V1:
> > - Revert commit 0952177f2a1f.
> > ---
> > ---
> >   drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++++++
> >   drivers/thermal/thermal_trip.c        |  6 ++++++
> >   include/linux/thermal.h               |  1 +
> >   3 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/go=
v_power_allocator.c
> > index 8642f1096b91..41d155adc616 100644
> > --- a/drivers/thermal/gov_power_allocator.c
> > +++ b/drivers/thermal/gov_power_allocator.c
> > @@ -729,10 +729,31 @@ static int power_allocator_throttle(struct therma=
l_zone_device *tz, int trip_id)
> >       return allocate_power(tz, trip.temperature);
> >   }
> >
> > +static int power_allocator_reset(struct thermal_zone_device *tz, int t=
rip_id)
> > +{
> > +     int ret =3D 0;
> > +     struct thermal_trip trip;
> > +     struct power_allocator_params *params =3D tz->governor_data;
> > +
> > +     ret =3D __thermal_zone_get_trip(tz, trip_id, &trip);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Only need reset for passive trips */
> > +     if (trip.type !=3D THERMAL_TRIP_PASSIVE)
> > +             return -EINVAL;
> > +
> > +     reset_pid_controller(params);
> > +     allow_maximum_power(tz, true);
> > +
> > +     return ret;
> > +}
> > +
> >   static struct thermal_governor thermal_gov_power_allocator =3D {
> >       .name           =3D "power_allocator",
> >       .bind_to_tz     =3D power_allocator_bind,
> >       .unbind_from_tz =3D power_allocator_unbind,
> >       .throttle       =3D power_allocator_throttle,
> > +     .reset          =3D power_allocator_reset,
> >   };
> >   THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> > diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_t=
rip.c
> > index 907f3a4d7bc8..52eb768fada8 100644
> > --- a/drivers/thermal/thermal_trip.c
> > +++ b/drivers/thermal/thermal_trip.c
> > @@ -173,6 +173,12 @@ int thermal_zone_set_trip(struct thermal_zone_devi=
ce *tz, int trip_id,
> >       if (tz->trips && (t.temperature !=3D trip->temperature || t.hyste=
resis !=3D trip->hysteresis))
> >               tz->trips[trip_id] =3D *trip;
> >
> > +     if (t.temperature !=3D trip->temperature && tz->governor && tz->g=
overnor->reset) {
> > +             ret =3D tz->governor->reset(tz, trip_id);
> > +             if (ret)
> > +                     pr_warn_once("Failed to reset thermal governor\n"=
);
> > +     }
>
> I agree with Rafael. Maybe change that to debug print, so that can be
> checked during the product testing. We cannot do much if that happens.
>
Right.

> > +
> >       thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
> >                                     trip->temperature, trip->hysteresis=
);
> >
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index 87837094d549..155ce2291fa5 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -204,6 +204,7 @@ struct thermal_governor {
> >       int (*bind_to_tz)(struct thermal_zone_device *tz);
> >       void (*unbind_from_tz)(struct thermal_zone_device *tz);
> >       int (*throttle)(struct thermal_zone_device *tz, int trip);
> > +     int (*reset)(struct thermal_zone_device *tz, int trip);
> >       struct list_head        governor_list;
> >   };
> >
>
> That thermal_governor::reset() callback is what I had im mind while
> giving you the feedback for the v1. Now it's much cleaner what is going
> on and why.
>

Yes, it is necessary to do something for the governor if the trip point
is changed, especially for the governors that their trips are strongly
related to
the policy.

> Apart from some small bits, LGTM. Please adjust the comment in the patch
> header and this debug print and you can add:
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>
> Please send the next version as separate new thread.
>
> Regards,
> Lukasz

Thank you Lukasz !
I couldn't agree with you more about your comments. What you have said is w=
hat
I want to express.

I'd love to send the next version. Thanks again.

Best regards,
Di
