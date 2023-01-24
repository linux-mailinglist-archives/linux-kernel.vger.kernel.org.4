Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF28C679B28
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjAXOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjAXOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:09:38 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4010442BE2;
        Tue, 24 Jan 2023 06:09:37 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id v6so39337906ejg.6;
        Tue, 24 Jan 2023 06:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuwGo0hIh/52SMF4DWz6dlZUJgcsKcP3HAbF3gsq9GA=;
        b=SKC+TyzHJja9IMB+y9iZ449DulrqFPXtCOXhG+wqPhLgjNibhA/QSM8ZGrkRx9eIDQ
         mRgGm18syYijYQJlaO7B44t5DQfalhosErUnitXKjXLPt+HHO1ArryLeIUvdhWcgtGYg
         HYwOYp/s7n8Ti2fU5kaFhjseIVCt+IKnA19BzkBxgjR//NfmbGCIb7Jhk1fokkehC54c
         bC/EMQ8Y4hS2yA6gKzXn6QeQ3eMTValmnvcnUpwHvQIbF65VShYfG360UBiffg2HFVBM
         U+20mb/nAkmLUh9Vgq7aOARaL9DZcAyo39OAmiQ6FJsU7TggyXT8P4L3eDew9jCTc3lX
         o/CA==
X-Gm-Message-State: AFqh2kq+xqeZ9ela13/nTPunWN7dfxyvKFfHFk736CGZnSV8rdn00c8u
        Fw6k7Y81fjj84CdNOPNGyzbcb7o54imm8uE3QDE=
X-Google-Smtp-Source: AMrXdXs73XRSzudtU1nT7XRfZAfp5QZYme9MuK/23pPW9sGtDXcjtaKuljj5dzyufWyDUOHrzxKc+xuhZLexzpX+2+A=
X-Received: by 2002:a17:906:d101:b0:84d:3813:fb8 with SMTP id
 b1-20020a170906d10100b0084d38130fb8mr3822383ejz.384.1674569375747; Tue, 24
 Jan 2023 06:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <20230118181622.33335-3-daniel.lezcano@linaro.org> <CAJZ5v0hCJF-+1SFHyNF-=4FWPLcOqRnc09KeA=rz6BdYTvb=BQ@mail.gmail.com>
 <ff598dd3-91d0-b660-7821-e34177056954@linaro.org> <CAJZ5v0gSG3aaeywiMWZTzWHmz_tVupeB1xyZfXhhXJ3NEV8-Yg@mail.gmail.com>
 <a08e0d60-994a-c11b-2f5d-55c6984df7b4@linaro.org>
In-Reply-To: <a08e0d60-994a-c11b-2f5d-55c6984df7b4@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jan 2023 15:09:24 +0100
Message-ID: <CAJZ5v0gSUrkpAR+9OcWZw2WJ=AWDh2apHwAmd+cKOS1F1cJ4cw@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points for intel_soc_dts_iosf
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 11:28 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 23/01/2023 21:19, Rafael J. Wysocki wrote:
> > On Mon, Jan 23, 2023 at 7:09 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >>
> >> Hi Srinivas,
> >>
> >> On 19/01/2023 21:04, Rafael J. Wysocki wrote:
> >>> On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> From: Daniel Lezcano <daniel.lezcano@kernel.org>
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
> >>>>
> >>>> @@ -320,7 +304,8 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
> >>>>           dts->trip_mask = trip_mask;
> >>>>           dts->trip_count = trip_count;
> >>>>           snprintf(name, sizeof(name), "soc_dts%d", id);
> >>>> -       dts->tzone = thermal_zone_device_register(name,
> >>>> +       dts->tzone = thermal_zone_device_register_with_trips(name,
> >>>> +                                                 dts->trips,
> >>>>                                                     trip_count,
> >>>>                                                     trip_mask,
> >>>>                                                     dts, &tzone_ops,
> >>>> @@ -430,27 +415,28 @@ struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
> >>>>                   notification = false;
> >>>>           else
> >>>>                   notification = true;
> >>>> -       for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
> >>>> -               sensors->soc_dts[i].sensors = sensors;
> >>>> -               ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
> >>>> -                                          notification, trip_count,
> >>>> -                                          read_only_trip_count);
> >>>> -               if (ret)
> >>>> -                       goto err_free;
> >>>> -       }
> >>>
> >>> How is this change related to the rest of the patch?
> >>
> >> We want to register the thermal zone with the trip points.
> >>
> >> thermal_zone_device_register() becomes
> >>
> >> thermal_zone_device_register_with_trips()
> >>
> >> But in the current code, the trip points are updated after the thermal
> >> zones are created (and strictly speaking it is wrong as get_trip_temp
> >> can be invoked before the trip points are updated).
> >>
> >> So the change inverts the initialization where we update the trip points
> >> and then we register the thermal zones.
> >
> > It would be nice to write this in the changelog too.
>
> Srinivasn, are you fine with the changes ?
>
> Rafael, if the patches are ok, shall I resend a new version with the
> changelog updated or can you pick them amending the changelog ?

I can pick them up, but I would like to hear from Srinivas first.
