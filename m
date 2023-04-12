Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439DC6DFE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDLS5w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Apr 2023 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjDLS5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:57:49 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B6E7280;
        Wed, 12 Apr 2023 11:57:20 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id j17so21716519ejs.5;
        Wed, 12 Apr 2023 11:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325815; x=1683917815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62gwaY7vFs4oo/QchLorKjyrNub9mjhwDQpkTj5sUS0=;
        b=UCzo1bYSPEkym7F4SFRqqLo9F7kBkICU77Fub0xZ4tpFoev9wkV6J+QLzsYjyOkeLt
         GMZSapiLqKYYqL50JSw7D0LzyXgpvzbkm/rHOH/9k9la+nV9y3CWpv8qD4v8LjYK3sYw
         T4uwWJqx9jXb12jlGGsvG22ffpw7suNW682juhQI4+nPMTDguZJlx+Vpl2uEzYLAKwxl
         iR8EaZ6P3W1m4ws958R3WN98ZlXBwqa6vWZfXs7LaZsJ6v2Ot4XSF/tN6A2wvoPGAJTt
         9PdLHpdp5pvYkHdrx7035fByAJXybzYrgIW1+Y/S10275LeqTwQ0wFY1rnW5SqL8EsWr
         DORg==
X-Gm-Message-State: AAQBX9fQYjZM3wJ+lY7IFSMvO/wQpGBGMYVPye3MZEjY/KwQHHMO2jm2
        4OpY4Wd2sKgVgyI4yYILfHo0VexbdeleVxDFIo4=
X-Google-Smtp-Source: AKy350bfHigf5Ig8Sw0xwhsv92J0cQhjUYypZfhsRgJPlh+nVKOHVgX/0TxPHG0uKBBJRePviienoLBDmhAeVH85JCg=
X-Received: by 2002:a17:907:3f16:b0:8b1:3298:c587 with SMTP id
 hq22-20020a1709073f1600b008b13298c587mr22529ejc.2.1681325807375; Wed, 12 Apr
 2023 11:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
 <20230410205305.1649678-3-daniel.lezcano@linaro.org> <CAJZ5v0jysxvCZ2-dXfqfiJfpZGOYwgMwk1kEuiGOQjV3LK4gMw@mail.gmail.com>
 <c2581726-3e02-104c-f2ac-55268470d2c8@linaro.org>
In-Reply-To: <c2581726-3e02-104c-f2ac-55268470d2c8@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Apr 2023 20:56:36 +0200
Message-ID: <CAJZ5v0i65XivddWvP9OSuXePwbeWYsgtOr_GB=BBN_jwsWarjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] thermal/core: Encapsulate tz->device field
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:20 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 11/04/2023 20:19, Rafael J. Wysocki wrote:
> > On Mon, Apr 10, 2023 at 10:53 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> There are still some drivers needing to play with the thermal zone
> >> device internals. That is not the best but until we can figure out if
> >> the information is really needed, let's encapsulate the field used in
> >> the thermal zone device structure, so we can move forward relocating
> >> the thermal zone device structure definition in the thermal framework
> >> private headers.
> >
> > I'm not really sure why this is needed, so please explain.
>
> Some drivers are accessing tz->device, that implies they have the
> knowledge of the thermal_zone_device structure but we want to
> self-encapsulate this structure and reduce the scope of the structure to
> the thermal core only.
>
> The ACPI and the Menlon drivers are the drivers accessing tz->device.
>
> By adding this wrapper, these drivers do no longer need the thermal zone
> device structure definition.

So you want to move the definition of struct thermal_zone_device from
include/linux/thermal.h into a local header in drivers/thermal/ and
make it entirely local to the thermal core IIUC.

Which would be forcing the callers of
thermal_zone_device_register_with_trips() (and friends) to use
pointers to a data type that's not completely defined (from their
perspective), but they would still have access to the trips array
passed to that function.

That doesn't sound particularly consistent and what's the purpose of doing it?

> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>   drivers/thermal/thermal_core.c | 6 ++++++
> >>   include/linux/thermal.h        | 1 +
> >>   2 files changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> >> index c5025aca22ee..842f678c1c3e 100644
> >> --- a/drivers/thermal/thermal_core.c
> >> +++ b/drivers/thermal/thermal_core.c
> >> @@ -1398,6 +1398,12 @@ int thermal_zone_device_id(struct thermal_zone_device *tzd)
> >>   }
> >>   EXPORT_SYMBOL_GPL(thermal_zone_device_id);
> >>
> >> +struct device *thermal_zone_device(struct thermal_zone_device *tzd)
> >> +{
> >> +       return &tzd->device;
> >> +}
> >> +EXPORT_SYMBOL_GPL(thermal_zone_device);
> >> +
> >>   /**
> >>    * thermal_zone_device_unregister - removes the registered thermal zone device
> >>    * @tz: the thermal zone device to remove
> >> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> >> index 82ddb32f9876..87837094d549 100644
> >> --- a/include/linux/thermal.h
> >> +++ b/include/linux/thermal.h
> >> @@ -313,6 +313,7 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
> >>   void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
> >>   const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
> >>   int thermal_zone_device_id(struct thermal_zone_device *tzd);
> >> +struct device *thermal_zone_device(struct thermal_zone_device *tzd);
> >>
> >>   int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
> >>                                       struct thermal_cooling_device *,
> >> --
> >> 2.34.1
> >>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
