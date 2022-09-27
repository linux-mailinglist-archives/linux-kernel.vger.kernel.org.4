Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629365EC0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiI0LKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiI0LKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:10:15 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CA24A108;
        Tue, 27 Sep 2022 04:08:13 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id u8so360280qvv.9;
        Tue, 27 Sep 2022 04:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fgbzzrwFzK76UVC6zcQ2bGACHn1NP4bULsk7xBLan/Y=;
        b=vc4ed+jWn8eOevOuzN+23Mvcg0x7mAfdyYBfWd3mFm7DpXhnSKixUejupYX6JHJYtA
         AMGWjMuq3L/r1vYosYf9N7oe0UQGflDD3WaLuhNN+UFQJ9NN4aX6VmUSijmiLOH3BtMf
         umux+Xrj/PGV7CW8P+co/jwDUayAVWAvWycXPrLZwnvz1n5Ij78eeIk4o8vcoxNlBUsH
         xAMhpx1ZZqOyhJJhFhJK9PsajrLAF+eyDX9eL64gMJ4da7osjKFLnm/gfVnAwWfPhMci
         otpteNkwZg4spMeTD7JiQrNqMI5HsScOBo1iqVfCSsNeHZXTfGHytlILX8GVq5hP5JQe
         1OIA==
X-Gm-Message-State: ACrzQf0C6mG+I/f7vkjNIntJnYCfr3SSHdUWEF4LyAzdLUHA8qIJ5cfU
        fwdONQbvE2c0mKHlOHs/BBUVu0ErxRJESGudbLI=
X-Google-Smtp-Source: AMsMyM74WiwyLlZRApInfeO9G29yEy52/pGbpi9H0bOJY9lJcLwpzA/sHZeblwlE6Tii2JTb/XkoWwTPNLwFRiPtuP8=
X-Received: by 2002:a0c:da14:0:b0:4aa:aad9:e450 with SMTP id
 x20-20020a0cda14000000b004aaaad9e450mr21087440qvj.130.1664276892157; Tue, 27
 Sep 2022 04:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
 <20220926140604.4173723-6-daniel.lezcano@linaro.org> <CAJZ5v0ibt6nj6+E3onu4Ri74gX84VBob-hOWQPZiusGKb_Apjw@mail.gmail.com>
 <657008be-34e3-e2de-a9bd-41d2dc804e51@linaro.org>
In-Reply-To: <657008be-34e3-e2de-a9bd-41d2dc804e51@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Sep 2022 13:08:00 +0200
Message-ID: <CAJZ5v0hiofXuEHqX1sMXdyTqaDu85viL69neJo=QvDa47aHaFg@mail.gmail.com>
Subject: Re: [PATCH v5 05/30] thermal/core/governors: Use thermal_zone_get_trip()
 instead of ops functions
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 12:15 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 26/09/2022 21:34, Rafael J. Wysocki wrote:
> > On Mon, Sep 26, 2022 at 4:06 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> The governors are using the ops->get_trip_* functions, Replace these
> >> calls with thermal_zone_get_trip().
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> >> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com> # IPA
> >> ---
> >>   drivers/thermal/gov_bang_bang.c       | 29 ++++++++-------
> >>   drivers/thermal/gov_fair_share.c      | 18 ++++------
> >>   drivers/thermal/gov_power_allocator.c | 51 ++++++++++++---------------
> >>   drivers/thermal/gov_step_wise.c       | 22 ++++++------
> >>   4 files changed, 53 insertions(+), 67 deletions(-)
> >>
> >> diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
> >> index a08bbe33be96..f5b85e5ea707 100644
> >> --- a/drivers/thermal/gov_bang_bang.c
> >> +++ b/drivers/thermal/gov_bang_bang.c
> >> @@ -13,26 +13,25 @@
> >>
> >>   #include "thermal_core.h"
> >>
> >> -static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
> >> +static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
> >>   {
> >> -       int trip_temp, trip_hyst;
> >> +       struct thermal_trip trip;
> >>          struct thermal_instance *instance;
> >> +       int ret;
> >>
> >> -       tz->ops->get_trip_temp(tz, trip, &trip_temp);
> >> -
> >> -       if (!tz->ops->get_trip_hyst) {
> >> -               pr_warn_once("Undefined get_trip_hyst for thermal zone %s - "
> >> -                               "running with default hysteresis zero\n", tz->type);
> >> -               trip_hyst = 0;
> >> -       } else
> >> -               tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
> >> +       ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> >> +       if (ret)
> >> +               pr_warn_once("Failed to retrieve trip point %d\n", trip_id);
> >
> > Does it even make sense to continue beyond this point if ret is nonzero?
>
> No, I think we can bail out from here
>
> > All of the contents of trip can be garbage then AFAICS.
> >
> >> +
> >> +       if (!trip.hysteresis)
> >> +               pr_warn_once("Zero hysteresis value for thermal zone %s\n", tz->type);
> >
> > Why do you want to warn about this?  Haven't we declared already that
> > zero hysteresis is valid and normal?
>
> Apparently the bang-bang governor is expecting a hysteresis value as the
> check is expecting:
>
>  >> -       if (!tz->ops->get_trip_hyst) {
>  >> -               pr_warn_once("Undefined get_trip_hyst for thermal
> zone %s - "
>  >> -                               "running with default hysteresis
> zero\n", tz->type);
>  >> -               trip_hyst = 0;
>
> It is just to keep a warning as before.

The new message will be different, though.

I think it should be per-tz and the "info" level should be sufficient,
and because thermal_zone_device is based on struct device,
dev_info_once(&tz->dev, ...) should work.
