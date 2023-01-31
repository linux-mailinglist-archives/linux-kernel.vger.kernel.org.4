Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880F4683644
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjAaTSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAaTSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:18:10 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5599911EAC;
        Tue, 31 Jan 2023 11:18:07 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id me3so44675047ejb.7;
        Tue, 31 Jan 2023 11:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgqXjqu7PB4cDpZ4t5aYViWzYUyq/bNQ+W4YAsennk4=;
        b=uU7se3VGBpAAkNx7sZ+NqrPzdyHiDcWBsY71wZJpoZND8nX8VkqsryDDfL6jlQMirS
         1cS294PrCZU7wMPy7d4G8LOTyeCkPliq3SSF27KduRecWT0v+tM3q07LUyAr6rfRnedU
         MoQFirplm+xRIWSSQffkG11GNVpiY16VcOTfh8G/+Xyjz6+zDhJ9f2rM80knwN/gT0Bh
         JIBu2mkiHZWtbwuP0Lo42DCWU7EWSl3pqtvysCJ5gISHb+NI9Ifxsg+PMUUXc/7CH1X1
         aLa8buzkwKaQ7uGM0ya6BVyGNkUBrFJKlUxQFnJ6Up6NTVqFVJFfcG8efFPpMUKBabRy
         jovQ==
X-Gm-Message-State: AO0yUKUf83v7fbsvizJEIrpSvawPVTH7DvDaDI+xiDWjc8VrBw1oLkil
        tCGjGQeymLsQqpBKz/MaizTGKcBcGBd8z8Hm2UU=
X-Google-Smtp-Source: AK7set/8MNl94eWnK+p2gRPKvJNunvkkdqU775q8MznNt3ygHG6M0TswuNUlDSLpgbXu/IiXn0SeDaSBftVXXzqBmgY=
X-Received: by 2002:a17:906:95d7:b0:88a:30dc:5730 with SMTP id
 n23-20020a17090695d700b0088a30dc5730mr2170974ejy.25.1675192685276; Tue, 31
 Jan 2023 11:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <20230118181622.33335-3-daniel.lezcano@linaro.org> <CAJZ5v0jbHR03UyJBMmBBYnSsZmGG0OXqLJvMfXxXKVn4Np4Egw@mail.gmail.com>
 <beb367d8-dad7-87d9-7872-b81a4d3492ae@linaro.org>
In-Reply-To: <beb367d8-dad7-87d9-7872-b81a4d3492ae@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Jan 2023 20:17:54 +0100
Message-ID: <CAJZ5v0hFG1VjzKubWkLYPXeGHN9sMt4SDdC_f-dLseaXpsAOKg@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points for intel_soc_dts_iosf
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
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

On Tue, Jan 31, 2023 at 6:03 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
>
> On 26/01/2023 17:47, Rafael J. Wysocki wrote:
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
> >> @@ -173,8 +166,13 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
> >>          if (status)
> >>                  goto err_restore_te_out;
> >>
> >> -       dts->trip_types[thres_index] = trip_type;
> >> -
> >> +       status = get_trip_temp(sensors, thres_index, &temp);
> >> +       if (status)
> >> +               goto err_restore_te_out;
> >> +
> >> +       dts->trips[thres_index].type = trip_type;
> >> +       dts->trips[thres_index].temperature = temp;
> >
> > This change doesn't look correct to me, because this function takes
> > temp as an argument and it is used to populate the trip with it at
> > least in some cases.
> >
> > Why should temp be overwritten here?
>
> You are correct. This is wrong.
>
> I think we should call get_trip_temp() before calling update_trip_temp()
> instead of passing a zero temperature parameter

update_trip_temp() is sort of a misnomer, because it is used for
initializing a trip point for example in
intel_soc_dts_iosf_add_read_only_critical_trip() and in this
particular case get_trip_temp() need not be called before it.

This driver seems to be in need of a cleanup.
