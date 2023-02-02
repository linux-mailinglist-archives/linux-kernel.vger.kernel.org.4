Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7846A687A43
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBBKc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjBBKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:32:25 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B4C2CFEE;
        Thu,  2 Feb 2023 02:32:24 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id lu11so4670910ejb.3;
        Thu, 02 Feb 2023 02:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtIBoG2997nZvSndHqxjbfi7aPI8g1kSt4FRgKtHFsQ=;
        b=dVtIe5Cn8Zz1nGDAFaHlJjx+yCBurSj6GYfjgo6KxHOOq6Bx4mrpl8fN3sX/QgriC4
         DrvZfI8vcDFHP70PLwqAX0Ca4C/ZPtlGH3wNAJIDERczOSj4a8VS34FfB6lYpJw5sbot
         OMRgBM0jpag8k5Q1X482LUTKZzZZdVymZHnVXm6lYuiwAp+VvG+NLPc5VS6b1lZujvSq
         btxavfzPq3Op4IwpP2eWz72oKxZgzmcKipyg/FxJgfzdK2YbSffaIkd0nb165E5lPE1w
         4R6QWt+zEZ1X3OWMP04swHtWwU09tGQHp1QdrVwitrDfzkEOO6UeNggOCmIG6w0w4JZM
         im8w==
X-Gm-Message-State: AO0yUKXH/B1326AYTn6NdLk78V1JdgCqxW3QyEtNw1RaMVipX8iS229+
        cZvedE2BOeri7FkFrYHPqCXHNMitOXTypTMEhhWBhdjPJ/A=
X-Google-Smtp-Source: AK7set+XDq94lPr2EjKi0L96lWrCF6RJtBtk3ZP8NRLwfd30EzzzdIZZO8Ba5/Rf1vV7MV8svHUEKI7Qtggk9To/9bc=
X-Received: by 2002:a17:906:6886:b0:877:612e:517e with SMTP id
 n6-20020a170906688600b00877612e517emr1742785ejr.152.1675333942378; Thu, 02
 Feb 2023 02:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <CAJZ5v0icjsLBNkDqm49az=GixfEoLHAtCm7H13uOUv7Hr6yO2Q@mail.gmail.com>
 <621aca19-6a44-9d42-6fde-1835035c28b4@linaro.org> <CAJZ5v0iOYH4WR5WoH=jL6VWKhB4CMeZv5V3U0Q_c_qdCJvvvBw@mail.gmail.com>
 <fedc35c2-1dc9-48af-f03f-fbb8566284fb@linaro.org> <CAJZ5v0h75VH4GQeBStfiAXrFJt1tL=1+nhP9=n_Ok=Txm3e_CA@mail.gmail.com>
 <e7e9704c-df97-2c27-2955-959d847a8bb8@linaro.org>
In-Reply-To: <e7e9704c-df97-2c27-2955-959d847a8bb8@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 11:32:10 +0100
Message-ID: <CAJZ5v0jHkL6Lit-0Cqg42i-vYRaD+zc4=g2XziCLSUPAeCpEcA@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal/drivers/intel: Use generic trip points for quark_dts
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 8:27 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/02/2023 19:47, Rafael J. Wysocki wrote:
> > On Wed, Feb 1, 2023 at 11:42 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 31/01/2023 20:11, Rafael J. Wysocki wrote:
> >>> On Tue, Jan 31, 2023 at 5:41 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 26/01/2023 15:15, Rafael J. Wysocki wrote:
> >>>>> On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
> >>>>> <daniel.lezcano@linaro.org> wrote:
> >>>>>>
> >>>>>> The thermal framework gives the possibility to register the trip
> >>>>>> points with the thermal zone. When that is done, no get_trip_* ops are
> >>>>>> needed and they can be removed.
> >>>>>>
> >>>>>> Convert ops content logic into generic trip points and register them with the
> >>>>>> thermal zone.
> >>>>>>
> >>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>>>> ---
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>>> -       aux_entry->tzone = thermal_zone_device_register("quark_dts",
> >>>>>> -                       QRK_MAX_DTS_TRIPS,
> >>>>>> -                       wr_mask,
> >>>>>> -                       aux_entry, &tzone_ops, NULL, 0, polling_delay);
> >>>>>> +       err = get_trip_temp(QRK_DTS_ID_TP_CRITICAL, &temperature);
> >>>>>> +       if (err)
> >>>>>> +               goto err_ret;
> >>>>>> +
> >>>>>> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = temperature;
> >>>>>> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
> >>>>>> +
> >>>>>> +       err = get_trip_temp(QRK_DTS_ID_TP_HOT, &temperature);
> >>>>>> +       if (err)
> >>>>>> +               goto err_ret;
> >>>>>
> >>>>> If I'm not mistaken, this won't even try to register the thermal zone
> >>>>> if at least one trip cannot be initialized, but previously it was
> >>>>> registered in that case, but the trips that failed to respond were
> >>>>> disabled.
> >>>>>
> >>>>> This is a change in behavior that would at least need to be documented
> >>>>> in the changelog, but it isn't.
> >>>>>
> >>>>> I'm not sure if it is safe to make even, however.
> >>>>
> >>>> Thanks for catching this.
> >>>>
> >>>> Two solutions:
> >>>>
> >>>> 1. Set the temperature to THERMAL_TEMP_INVALID and change
> >>>> get_thermal_trip() to return -EINVAL or -ERANGE if the temperature is
> >>>> THERMAL_TEMP_INVALID
> >>>>
> >>>> 2. Register only the valid trip points.
> >>>>
> >>>> What would be the preferable way ?
> >>>
> >>> I think that the trip points that are registered currently need to
> >>> still be registered after the change.
> >>>
> >>> Does registering a trip point with the temperature set to
> >>> THERMAL_TEMP_INVALID cause it to be effectively disabled?
> >>
> >> The initial behavior before the changes is:
> >>
> >> The function thermal_zone_device_register() will go through all the trip
> >> points and call thermal_zone_get_trip(), resulting in a call to
> >> ops->get_trip_temp(). If the call fails, the trip point is tagged as
> >> disabled and will stay in this state forever, so discarded in the trip
> >> point crossed detection.
> >>
> >> That does not report an error and the trip point is showed in sysfs but
> >> in a inconsistent state as it is actually disabled. Reading the trip
> >> point will return an error or not, but it is in any case disabled in the
> >> thermal framework. The userspace does not have the information about the
> >> trip point being disabled, so showing it up regardless its state is
> >> pointless and prone to confusion for the userspace.
> >>
> >> IMO, it would be more sane to register the trip points which are
> >> actually valid, so invalid trip points are not showed up and does
> >> prevent extra complexity in the thermal core to handle them.
> >
> > Except when the trip point can be updated to become a valid one later,
> > for example in response to a system configuration change.  That can
> > happen to ACPI-provided trip points, for example.
> >
> > I don't think that this is an issue for this particular driver, but
> > the core needs to handle that case anyway.
>
> Yes, but the point is the core code never handled that case.

True.

What I wanted to say, though, is that the core needs to allow
registering trip points with THERMAL_TEMP_INVALID without disabling
them automatically, so they can be updated and used later.

> If the trip point fails when registering the thermal zone (and this is
> not related to our changes), the trip point is added to the disabled
> trips bitmap and then whatever the action to validate the trip point, it
> remains disabled for the thermal framework. There is no action to enable
> it (except I missed something).
>
> > Moreover, there is the case when trip points only become relevant when
> > their temperatures are set via ops->set_trip_temp() and they are
> > THERMAL_TEMP_INVALID initially, which needs to be handled by the core
> > either.
>
> Ok, then I guess the simplest change is to assign THERMAL_TEMP_INVALID
> in this driver, if get_trip_temp fails at the initialization time.
>
> Later we can add a thermal_zone_device_update_trips() with the needed
> locking and actions related to the update.

Well, there is thermal_zone_device_update() and one of the events it
is supposed to handle is THERMAL_TRIP_CHANGED, so I'm not sure how the
new interface would differ from it?
