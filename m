Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91941686E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjBASrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBASrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:47:53 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD346D5E1;
        Wed,  1 Feb 2023 10:47:52 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id qw12so38270760ejc.2;
        Wed, 01 Feb 2023 10:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGTo7AVtqJdUxiTsX5lFWt8LvESDJX0AXENA9PjWJiE=;
        b=pgSMet6UXIEtHlqZJWQUinO4M/VZ4oMhIG0hyDDILDnzkfuvsmt7BiWoiXrJ7kLLOI
         Rw/LWu0aXqAbZbwQwhnO9Q66KoZMkPUM4rHZCddeuKJRVz+H604Oi37yodYfkl6BrgaQ
         TtH3z5d9DPPr3heBpdcmWW3tVXdMPw0jK4ZNJ/neFs5m6zofWuHADftVAKcvsQGb1HHb
         j14fObQybvnHoUCCBLd9ZO/mtDIEa8WCLxewNNs36s3AZQFF3nD384FxyLY/PU0ZjW1Z
         x6HhGmEX2u8mM7GSs8vmzFdEuHBa1tnqcxB2xpWR+KvaSTL8BVYUI09AKmNFSPggicbh
         t+hA==
X-Gm-Message-State: AO0yUKU1RibYRDS+AaPd8IsQYH1nw+ZA8duC9W5cV1QKuVJ95Whj2d76
        zyH8ggC2qop3Y9FSAJWKGdpmWtFUBuNgv1hbsio1wyoQYYU=
X-Google-Smtp-Source: AK7set8+eNNEsGOsRWEd2xvDUwSGka9bTu+PnKmEq/a3DN558+iZ6gZEFlfKh4u7tcJQ+67eITaW2LDI8ctH55scQx4=
X-Received: by 2002:a17:906:2f88:b0:844:44e0:1c4e with SMTP id
 w8-20020a1709062f8800b0084444e01c4emr1070859eji.291.1675277270877; Wed, 01
 Feb 2023 10:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <CAJZ5v0icjsLBNkDqm49az=GixfEoLHAtCm7H13uOUv7Hr6yO2Q@mail.gmail.com>
 <621aca19-6a44-9d42-6fde-1835035c28b4@linaro.org> <CAJZ5v0iOYH4WR5WoH=jL6VWKhB4CMeZv5V3U0Q_c_qdCJvvvBw@mail.gmail.com>
 <fedc35c2-1dc9-48af-f03f-fbb8566284fb@linaro.org>
In-Reply-To: <fedc35c2-1dc9-48af-f03f-fbb8566284fb@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Feb 2023 19:47:39 +0100
Message-ID: <CAJZ5v0h75VH4GQeBStfiAXrFJt1tL=1+nhP9=n_Ok=Txm3e_CA@mail.gmail.com>
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

On Wed, Feb 1, 2023 at 11:42 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 31/01/2023 20:11, Rafael J. Wysocki wrote:
> > On Tue, Jan 31, 2023 at 5:41 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 26/01/2023 15:15, Rafael J. Wysocki wrote:
> >>> On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> The thermal framework gives the possibility to register the trip
> >>>> points with the thermal zone. When that is done, no get_trip_* ops are
> >>>> needed and they can be removed.
> >>>>
> >>>> Convert ops content logic into generic trip points and register them with the
> >>>> thermal zone.
> >>>>
> >>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>> ---
> >>
> >> [ ... ]
> >>
> >>>> -       aux_entry->tzone = thermal_zone_device_register("quark_dts",
> >>>> -                       QRK_MAX_DTS_TRIPS,
> >>>> -                       wr_mask,
> >>>> -                       aux_entry, &tzone_ops, NULL, 0, polling_delay);
> >>>> +       err = get_trip_temp(QRK_DTS_ID_TP_CRITICAL, &temperature);
> >>>> +       if (err)
> >>>> +               goto err_ret;
> >>>> +
> >>>> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = temperature;
> >>>> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
> >>>> +
> >>>> +       err = get_trip_temp(QRK_DTS_ID_TP_HOT, &temperature);
> >>>> +       if (err)
> >>>> +               goto err_ret;
> >>>
> >>> If I'm not mistaken, this won't even try to register the thermal zone
> >>> if at least one trip cannot be initialized, but previously it was
> >>> registered in that case, but the trips that failed to respond were
> >>> disabled.
> >>>
> >>> This is a change in behavior that would at least need to be documented
> >>> in the changelog, but it isn't.
> >>>
> >>> I'm not sure if it is safe to make even, however.
> >>
> >> Thanks for catching this.
> >>
> >> Two solutions:
> >>
> >> 1. Set the temperature to THERMAL_TEMP_INVALID and change
> >> get_thermal_trip() to return -EINVAL or -ERANGE if the temperature is
> >> THERMAL_TEMP_INVALID
> >>
> >> 2. Register only the valid trip points.
> >>
> >> What would be the preferable way ?
> >
> > I think that the trip points that are registered currently need to
> > still be registered after the change.
> >
> > Does registering a trip point with the temperature set to
> > THERMAL_TEMP_INVALID cause it to be effectively disabled?
>
> The initial behavior before the changes is:
>
> The function thermal_zone_device_register() will go through all the trip
> points and call thermal_zone_get_trip(), resulting in a call to
> ops->get_trip_temp(). If the call fails, the trip point is tagged as
> disabled and will stay in this state forever, so discarded in the trip
> point crossed detection.
>
> That does not report an error and the trip point is showed in sysfs but
> in a inconsistent state as it is actually disabled. Reading the trip
> point will return an error or not, but it is in any case disabled in the
> thermal framework. The userspace does not have the information about the
> trip point being disabled, so showing it up regardless its state is
> pointless and prone to confusion for the userspace.
>
> IMO, it would be more sane to register the trip points which are
> actually valid, so invalid trip points are not showed up and does
> prevent extra complexity in the thermal core to handle them.

Except when the trip point can be updated to become a valid one later,
for example in response to a system configuration change.  That can
happen to ACPI-provided trip points, for example.

I don't think that this is an issue for this particular driver, but
the core needs to handle that case anyway.

Moreover, there is the case when trip points only become relevant when
their temperatures are set via ops->set_trip_temp() and they are
THERMAL_TEMP_INVALID initially, which needs to be handled by the core
either.

When the driver has no way to update trip point temperatures, either
through a firmware notification or via ops->set_trip_temp(), then I
agree that registering them is not very useful if their temperatures
cannot be determined.
