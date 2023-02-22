Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9823669FCB6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBVUIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBVUIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:08:12 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994CE16309;
        Wed, 22 Feb 2023 12:08:11 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id o12so35649349edb.9;
        Wed, 22 Feb 2023 12:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Mek5reTdHMi6Tu2udxCjs0RdiKaQ5LgBhXm+15yeyc=;
        b=nh6CC+tYtGDrHB7twfBQR/VIlMl9OAp3DHCA2g1QIJeYla26XchhNvDSF4Hh+l+sN1
         bN6wGCwQ9UiOBuicPEdbcF80DBx2XlWt/ddk8CML6tO8sHJali5iksOGKxyX5nHzlhiO
         Y6BKB5tgT3zQXew2Q21k+FWkHfiXUeo3aiPEQIoaX2UX6e4MzDgre5qhsXk+rb4YdSsv
         qseepMT1BXQrzPZqe06grXbOXPnVTtlcszz76+aqtVbUKF/YaNA4VsSeB+lnDFTVl7S6
         cVuwPVYaIulkKHaBCwpstH+OFz3TgS7hm7qeu3GdO4pYaM/F0yrGvjk/SSl5Lv1ATIHs
         MOLg==
X-Gm-Message-State: AO0yUKUFOpkuJ5mq5csFZR6FkGS+GYUvhp6ukLge9u+132zA9FDxVKUX
        BbSfOWEQMMXcZMEMlZFaM8a+sJUlME46DDV2pQ0=
X-Google-Smtp-Source: AK7set+sLfdZ3F/SABGdHs1FAoSFwKllBMQTiJB5SGpyP4TAi44uhcGd5J59jYp8XHSjYiEN3kx1Qe/bao9sFhGEkSM=
X-Received: by 2002:a17:907:7d8d:b0:8ad:d366:54c4 with SMTP id
 oz13-20020a1709077d8d00b008add36654c4mr9847487ejc.4.1677096490124; Wed, 22
 Feb 2023 12:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-17-daniel.lezcano@linaro.org> <CAJZ5v0jfZ2_LyPC9ArnSfHpYgr379HBhk5ODyESoewL_ee1wYw@mail.gmail.com>
 <66a6fdeb-d8e8-0041-769e-84abba7367c8@linaro.org>
In-Reply-To: <66a6fdeb-d8e8-0041-769e-84abba7367c8@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Feb 2023 21:07:58 +0100
Message-ID: <CAJZ5v0g9Me0D3=ev_qQyRu6P7mH=-8OGPtk=oAkZpEM6PDkNpg@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] thermal/traces: Replace the thermal zone
 structure parameter with the field value
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
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

On Wed, Feb 22, 2023 at 9:02 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/02/2023 20:51, Rafael J. Wysocki wrote:
> > On Tue, Feb 21, 2023 at 7:08 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> In the work of the thermal zone device self-encapsulation, let's pass
> >> the field value instead of dereferencing them in the traces which
> >> force us to export publicly the thermal_zone_device structure.
> >>
> >> No fonctionnal change intended.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>   drivers/thermal/gov_fair_share.c              |  2 +-
> >>   drivers/thermal/gov_power_allocator.c         |  4 ++--
> >>   drivers/thermal/gov_step_wise.c               |  2 +-
> >>   drivers/thermal/thermal_core.c                |  5 ++--
> >>   include/trace/events/thermal.h                | 24 +++++++++----------
> >>   .../trace/events/thermal_power_allocator.h    | 12 +++++-----
> >>   6 files changed, 25 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
> >> index aad7d5fe3a14..e6c21abaaa80 100644
> >> --- a/drivers/thermal/gov_fair_share.c
> >> +++ b/drivers/thermal/gov_fair_share.c
> >> @@ -35,7 +35,7 @@ static int get_trip_level(struct thermal_zone_device *tz)
> >>           * point, in which case, trip_point = count - 1
> >>           */
> >>          if (count > 0)
> >> -               trace_thermal_zone_trip(tz, count - 1, trip.type);
> >> +               trace_thermal_zone_trip(tz->type, tz->id, count - 1, trip.type);
> >
> > Haven't you introduced an accessor for tz->id in this series?  Why not
> > use it here?
> >
> > And there can be an analogous accessor for tz->type.
> >
> > If there are accessors like that, they should be used consistently
> > everywhere as applicable IMO.
>
> governors are part of the thermal core code, so they are authorized to
> access the thermal structure internals, that is why they are not passing
> through the accessors.

I'm not talking about "authorization", but about consistency.

If accessors are used consistently, it is sufficient to grep for an
accessor to find all places where the given field is accessed, for
example.
