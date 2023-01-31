Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA1D683631
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjAaTLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjAaTLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:11:41 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F259757;
        Tue, 31 Jan 2023 11:11:22 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id mc11so22126758ejb.10;
        Tue, 31 Jan 2023 11:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Tj0B2PQQQxR/rYyVsTlUwChxXn317haBHssuZ5ZKr0=;
        b=iexSjDmiJRhSBfhKq0wQULQGguBxwHBcaJ3vhTYbdz9/4z7/m66dCgTpiEKlSi5QV7
         4XEpTI4X/w8yxUwGZw5PNibTxn48t1cDfvkrw0V0lysbZPYEU9anKtJTKLmkV4T+D6Y+
         m253CvsmTOR3e93PAMEtnDt1IOMmz3g+uinVwYqsZFn/MJSFYDZzDXyRefwHLwPSfUA0
         LkoHAH8Hby3ZybwXhNenlu2u1EC3wBXoaYkxN4xUEvT+XHATvEY/UmkPgVGTezl0VUHr
         KMe5MONzYnRPpD9zWowJuJ5ltNb8m1oMz8lxKha7Ywg9W1zQqg17dsMbm+n9diDIyzwc
         Id9w==
X-Gm-Message-State: AFqh2kpv/KDixrluSiYPNfe7puvDObb3G5121IDT6YKH13YK0gezms3i
        KA1muLWaM2iU9tRkuX2jv6yTfp4SHeAlNlI3gUc=
X-Google-Smtp-Source: AMrXdXtQTTHdk8ueOISoJacuHi8SLaecWPqeHwKjbXofOFyGnO9Zu88BjZOdI0mcRJnvaVkd71hV3i7D/VH5OdBs9ZQ=
X-Received: by 2002:a17:907:c928:b0:85e:4218:c011 with SMTP id
 ui40-20020a170907c92800b0085e4218c011mr8652949ejc.258.1675192276763; Tue, 31
 Jan 2023 11:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <CAJZ5v0icjsLBNkDqm49az=GixfEoLHAtCm7H13uOUv7Hr6yO2Q@mail.gmail.com> <621aca19-6a44-9d42-6fde-1835035c28b4@linaro.org>
In-Reply-To: <621aca19-6a44-9d42-6fde-1835035c28b4@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Jan 2023 20:11:05 +0100
Message-ID: <CAJZ5v0iOYH4WR5WoH=jL6VWKhB4CMeZv5V3U0Q_c_qdCJvvvBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal/drivers/intel: Use generic trip points for quark_dts
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
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

On Tue, Jan 31, 2023 at 5:41 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 26/01/2023 15:15, Rafael J. Wysocki wrote:
> > On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> The thermal framework gives the possibility to register the trip
> >> points with the thermal zone. When that is done, no get_trip_* ops are
> >> needed and they can be removed.
> >>
> >> Convert ops content logic into generic trip points and register them with the
> >> thermal zone.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
>
> [ ... ]
>
> >> -       aux_entry->tzone = thermal_zone_device_register("quark_dts",
> >> -                       QRK_MAX_DTS_TRIPS,
> >> -                       wr_mask,
> >> -                       aux_entry, &tzone_ops, NULL, 0, polling_delay);
> >> +       err = get_trip_temp(QRK_DTS_ID_TP_CRITICAL, &temperature);
> >> +       if (err)
> >> +               goto err_ret;
> >> +
> >> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = temperature;
> >> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
> >> +
> >> +       err = get_trip_temp(QRK_DTS_ID_TP_HOT, &temperature);
> >> +       if (err)
> >> +               goto err_ret;
> >
> > If I'm not mistaken, this won't even try to register the thermal zone
> > if at least one trip cannot be initialized, but previously it was
> > registered in that case, but the trips that failed to respond were
> > disabled.
> >
> > This is a change in behavior that would at least need to be documented
> > in the changelog, but it isn't.
> >
> > I'm not sure if it is safe to make even, however.
>
> Thanks for catching this.
>
> Two solutions:
>
> 1. Set the temperature to THERMAL_TEMP_INVALID and change
> get_thermal_trip() to return -EINVAL or -ERANGE if the temperature is
> THERMAL_TEMP_INVALID
>
> 2. Register only the valid trip points.
>
> What would be the preferable way ?

I think that the trip points that are registered currently need to
still be registered after the change.

Does registering a trip point with the temperature set to
THERMAL_TEMP_INVALID cause it to be effectively disabled?
