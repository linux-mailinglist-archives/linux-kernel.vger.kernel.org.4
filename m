Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6F57368D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjFTKIL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 06:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFTKID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:08:03 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D19CF1;
        Tue, 20 Jun 2023 03:08:02 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b07762d292so13101911fa.0;
        Tue, 20 Jun 2023 03:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687255677; x=1689847677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjQW/g2eOU+G17oTPsY0Hzgvd7Db2fUoFqshufHaJLQ=;
        b=eeYsEVYyWgENbPkq49/6zGTWJ3Zb0O+7fMziZ+Uo55bDXW7raMZCc9/P4Jj2xRWozt
         AdQgPMrKVwhGNOaJe81FY052UZbiOxWlPOLgU8NPdknD+h+VUyzkNz+QYJvXaHEZyNvF
         tMCuMELiLgTrXwQx+63YHSZYG+5u59CBlLHRVnx6f4muFqyqRDCJXifp91jnB5VhiM9G
         WWQYUj/mjOye3+3LFwu8U48CJCpnZbIx0mhzkwSLKavkRABSwIYj1vXaNnuVlTyorjuG
         4V3GveW0u+ErwZOwGvff4s0I71xVCex0VMPQTq2NlSIaSBn6FT4TxJSdWvlYGZdo7Q3Z
         Br1A==
X-Gm-Message-State: AC+VfDzaUIiECOFxBOzmwykuwrMRTUTqEeT1T25yA1CgfGZ1GU7o4G4x
        WCGgg2kCaRKdyF3zMOZzk0naFR3CuJEGE87rmuTEmig7
X-Google-Smtp-Source: ACHHUZ7+PX2lfVFQu5uuFEynUofLwonm4NNkQBWCP1Y/sWG6aIm3eX2gXyO7tieUbo5Aoc0QCA59W0I9RiJNo7gpmCU=
X-Received: by 2002:a2e:8e2f:0:b0:2b4:60c0:1ac9 with SMTP id
 r15-20020a2e8e2f000000b002b460c01ac9mr4548586ljk.2.1687255676656; Tue, 20 Jun
 2023 03:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
 <20230619063534.12831-1-di.shen@unisoc.com> <CAJZ5v0i9fyfNYyhAMqr0iYPbUNwrcvL7mxK1rMo+00mNRWKV6w@mail.gmail.com>
In-Reply-To: <CAJZ5v0i9fyfNYyhAMqr0iYPbUNwrcvL7mxK1rMo+00mNRWKV6w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 12:07:39 +0200
Message-ID: <CAJZ5v0gHBxbU7Q0KYKsSVk+9nzSxot_JxUkcaAXrDxQx5_a7_Q@mail.gmail.com>
Subject: Re: [PATCH V4] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     Di Shen <di.shen@unisoc.com>
Cc:     lukasz.luba@arm.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 11:46 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jun 19, 2023 at 8:36 AM Di Shen <di.shen@unisoc.com> wrote:
> >
> > When the thermal trip point is changed, the governor should
> > be reset so that the policy algorithm be updated to adapt to the
> > new trip point.
> >
> > This patch adds an ops for thermal the governor structure to reset
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
> >   point is changed.
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
> >   to record the last switch_on_temp value.
> >
> > - Adds a function to renew the update flag and update the
> >   last_switch_on_temp when thermal trips are writable.
> >
> > V1:
> > - Revert commit 0952177f2a1f.
> > ---
> > ---
> >  drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++++++
> >  drivers/thermal/thermal_trip.c        |  6 ++++++
> >  include/linux/thermal.h               |  1 +
> >  3 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> > index 8642f1096b91..41d155adc616 100644
> > --- a/drivers/thermal/gov_power_allocator.c
> > +++ b/drivers/thermal/gov_power_allocator.c
> > @@ -729,10 +729,31 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
> >         return allocate_power(tz, trip.temperature);
> >  }
> >
> > +static int power_allocator_reset(struct thermal_zone_device *tz, int trip_id)
> > +{
> > +       int ret = 0;
> > +       struct thermal_trip trip;
> > +       struct power_allocator_params *params = tz->governor_data;
> > +
> > +       ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Only need reset for passive trips */
> > +       if (trip.type != THERMAL_TRIP_PASSIVE)
> > +               return -EINVAL;
> > +
> > +       reset_pid_controller(params);
> > +       allow_maximum_power(tz, true);
> > +
> > +       return ret;
> > +}
> > +
> >  static struct thermal_governor thermal_gov_power_allocator = {
> >         .name           = "power_allocator",
> >         .bind_to_tz     = power_allocator_bind,
> >         .unbind_from_tz = power_allocator_unbind,
> >         .throttle       = power_allocator_throttle,
> > +       .reset          = power_allocator_reset,
> >  };
> >  THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> > diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> > index 907f3a4d7bc8..52eb768fada8 100644
> > --- a/drivers/thermal/thermal_trip.c
> > +++ b/drivers/thermal/thermal_trip.c
> > @@ -173,6 +173,12 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> >         if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
> >                 tz->trips[trip_id] = *trip;
> >
> > +       if (t.temperature != trip->temperature && tz->governor && tz->governor->reset) {
> > +               ret = tz->governor->reset(tz, trip_id);
> > +               if (ret)
> > +                       pr_warn_once("Failed to reset thermal governor\n");
>
> I'm not really sure if it is useful to print this message here.
>
> First off, the governors may print more precise diagnostic messages if
> they care.
>
> Second, what is the sysadmin supposed to do in response to this message?

In addition to the above, trip point temperatures may be updated in
other places too, for instance in response to notifications from
platform firmware and IMV this new callback should be also used in
those cases.  However, in those cases multiple trip points may change
at a time and the critical/hot trip point temperatures may be updated
too AFAICS.
