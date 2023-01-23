Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE485678785
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjAWUTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjAWUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:19:43 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBA43645B;
        Mon, 23 Jan 2023 12:19:14 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id mp20so33607339ejc.7;
        Mon, 23 Jan 2023 12:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGWO82JB5pZ9/e6jbyHojpqojnwmsmToG0Iiy6lCVW8=;
        b=uFWjsDMNsb6Sz2LVpCWU1aa4EX997bPfw5A/bYpjiqOxLcV8+3TWHTRVh+caMHB0XC
         1YuIn4KY7oQJU7RU5X+XIp78E3O9l4ZOQwr2fjFU+8WjEBfVybR9HacG8wtvVWXCgoVM
         Cu+pxgkkd2eVVpjUTS8msXYl0k5yxcq6k4kajJKxo/SJE1aWOi7VK6UPp4OZoPqeMA7D
         JG+ImDv4X78TkkG2bCG/1m1mNI9qfWFVFt1eSfV6Ec6hIUxjf/sVWTCKiBIIpsXkrcgH
         YrkxA6D3OWPW71RQZeEX+3OsenZl9WXBBTyidg8nQ2gfEdpK8kL+fXU8ofmn6zh2dC9l
         lEmw==
X-Gm-Message-State: AFqh2koUM+n6x1R82xVFS6W2F1KG9kQaZHMXw4nvr1/62iJKZf2Gxpna
        9a5lgPR6kJ9PLytqHMSeEFHRV3/8wJXo1tVLyGaiJi5N
X-Google-Smtp-Source: AMrXdXuJCxlFc5ReaVcmwk9Lm64RoTSpXLMxq0bTalY5Mu4Gc7BoSO8Vhh73GRo+ReAI3y8oJ82986b8H+eZnh6C1xk=
X-Received: by 2002:a17:906:92c8:b0:877:8b1c:fd7c with SMTP id
 d8-20020a17090692c800b008778b1cfd7cmr2059126ejx.67.1674505153258; Mon, 23 Jan
 2023 12:19:13 -0800 (PST)
MIME-Version: 1.0
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <20230118181622.33335-3-daniel.lezcano@linaro.org> <CAJZ5v0hCJF-+1SFHyNF-=4FWPLcOqRnc09KeA=rz6BdYTvb=BQ@mail.gmail.com>
 <ff598dd3-91d0-b660-7821-e34177056954@linaro.org>
In-Reply-To: <ff598dd3-91d0-b660-7821-e34177056954@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Jan 2023 21:19:02 +0100
Message-ID: <CAJZ5v0gSG3aaeywiMWZTzWHmz_tVupeB1xyZfXhhXJ3NEV8-Yg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 7:09 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Srinivas,
>
> On 19/01/2023 21:04, Rafael J. Wysocki wrote:
> > On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> From: Daniel Lezcano <daniel.lezcano@kernel.org>
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
> >>
> >> @@ -320,7 +304,8 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
> >>          dts->trip_mask = trip_mask;
> >>          dts->trip_count = trip_count;
> >>          snprintf(name, sizeof(name), "soc_dts%d", id);
> >> -       dts->tzone = thermal_zone_device_register(name,
> >> +       dts->tzone = thermal_zone_device_register_with_trips(name,
> >> +                                                 dts->trips,
> >>                                                    trip_count,
> >>                                                    trip_mask,
> >>                                                    dts, &tzone_ops,
> >> @@ -430,27 +415,28 @@ struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
> >>                  notification = false;
> >>          else
> >>                  notification = true;
> >> -       for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
> >> -               sensors->soc_dts[i].sensors = sensors;
> >> -               ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
> >> -                                          notification, trip_count,
> >> -                                          read_only_trip_count);
> >> -               if (ret)
> >> -                       goto err_free;
> >> -       }
> >
> > How is this change related to the rest of the patch?
>
> We want to register the thermal zone with the trip points.
>
> thermal_zone_device_register() becomes
>
> thermal_zone_device_register_with_trips()
>
> But in the current code, the trip points are updated after the thermal
> zones are created (and strictly speaking it is wrong as get_trip_temp
> can be invoked before the trip points are updated).
>
> So the change inverts the initialization where we update the trip points
> and then we register the thermal zones.

It would be nice to write this in the changelog too.

> >>
> >>          for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
> >>                  ret = update_trip_temp(&sensors->soc_dts[i], 0, 0,
> >>                                         THERMAL_TRIP_PASSIVE);
> >>                  if (ret)
> >> -                       goto err_remove_zone;
> >> +                       goto err_free;
> >>
> >>                  ret = update_trip_temp(&sensors->soc_dts[i], 1, 0,
> >>                                         THERMAL_TRIP_PASSIVE);
> >>                  if (ret)
> >> -                       goto err_remove_zone;
> >> +                       goto err_free;
> >>          }
> >>
> >> +       for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
> >> +               sensors->soc_dts[i].sensors = sensors;
> >> +               ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
> >> +                                          notification, trip_count,
> >> +                                          read_only_trip_count);
> >> +               if (ret)
> >> +                       goto err_remove_zone;
> >> +       }
> >> +
>
> --
