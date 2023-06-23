Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769E473BCDE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjFWQlO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 12:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjFWQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:40:48 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022562735;
        Fri, 23 Jun 2023 09:40:33 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-97ea801b0d0so17668766b.1;
        Fri, 23 Jun 2023 09:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538431; x=1690130431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI6u41EPWnXmYM2KqVmefAwYHHL4vqTlKsNGHSEOQT4=;
        b=YQyqAadBGAE0W4Ywx/T7E//VTOUS1re4gAUJSNOQ7GcbtIeDst8Dy3LsayYsV5GtFq
         lSZoMGryQCQ8HVj/GxPoB9sJfbTJhxuk1XUOjolj4w0LYjYiQHpZza1tEOQmBimDDr+u
         Y9VRBoztYU9GUXYqHoaQc7n5NHbs7PPLP3HvHuFM3mWz3srr9N1/xeORrVmK8x4/DXml
         HU7gsQv7NU1dB+0AWwnD7ifMrSrq+Qn3NI1cUS8diwSqallSHyKks0XG/Fuqlf6IJhud
         ifkGJsvAbv5aI36pwKv1wpVA677X7EhfnfxCrihwKNShdoSmnyCvh7VLkXjQzvpmESXy
         nWnw==
X-Gm-Message-State: AC+VfDyZIlbAmrnQyaBpipchwIIlM/WB0VBovp2eNsLIVSS6Dl/GRWDJ
        S5uz0Xq0Fp1UxKp+l/1IbuqtZ/cAe/oMGmSdfg8=
X-Google-Smtp-Source: ACHHUZ6u/PlpkclYSi875jYrROJw7UCvViJ23MJYrpxzmDBFFNBlsc/1K3dgaYxtfHEKbf+L0MwmtOYcfY6BFYA2Sew=
X-Received: by 2002:a17:906:729e:b0:988:c8bb:e3ac with SMTP id
 b30-20020a170906729e00b00988c8bbe3acmr10300946ejl.7.1687538431246; Fri, 23
 Jun 2023 09:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230519032719.2581689-1-evalenti@kernel.org> <20230519032719.2581689-6-evalenti@kernel.org>
 <CAJZ5v0hho1B6TiwshT4kYhs+Z4Q6xvnbgf8aoEZop=owkJHqxg@mail.gmail.com> <ZJKAYAx5768atJa8@uf8f119305bce5e.ant.amazon.com>
In-Reply-To: <ZJKAYAx5768atJa8@uf8f119305bce5e.ant.amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Jun 2023 18:40:20 +0200
Message-ID: <CAJZ5v0jVL69QYpUFCMBeZ9eACca4XoeR6Js_qoDd2K5PfU9BwA@mail.gmail.com>
Subject: Re: [PATCH 5/7] thermal: stats: introduce tz time in trip
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jun 21, 2023 at 6:45 AM Eduardo Valentin <evalenti@kernel.org> wrote:
>
> On Tue, Jun 20, 2023 at 07:27:57PM +0200, Rafael J. Wysocki wrote:
> >
> >
> >
> > On Fri, May 19, 2023 at 5:27 AM Eduardo Valentin <evalenti@kernel.org> wrote:
> > >
> > > From: Eduardo Valentin <eduval@amazon.com>
> > >
> > > This patch adds a statistic to report how long
> > > the thermal zone spent on temperature intervals
> > > created by each trip point. The first interval
> > > is the range below the first trip point. All
> > > subsequent intervals are accounted when temperature
> > > is above the trip point temperature value.
> > >
> > > Samples:
> > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > trip-1  0       0
> >
> > The above line is confusing.
> >
> > > trip0   -10000  35188
> > > trip1   25000   0
> >
> > And the format violates the "one value per attribute" sysfs rule.
> >
> > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > trip-1  0       0
> > > trip0   -10000  36901
> > > trip1   25000   0
> > > $ echo 25001 > /sys//class/thermal/thermal_zone0/emul_temp
> > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > trip-1  0       0
> > > trip0   -10000  47810
> > > trip1   25000   2259
> > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > trip-1  0       0
> > > trip0   -10000  47810
> > > trip1   25000   3224
> > > $ echo 24001 > /sys//class/thermal/thermal_zone0/emul_temp
> > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > trip-1  0       0
> > > trip0   -10000  48960
> > > trip1   25000   10080
> > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > trip-1  0       0
> > > trip0   -10000  49844
> > > trip1   25000   10080
> > >
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
> > > Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
> > > Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
> > > Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> > > Cc: linux-pm@vger.kernel.org (open list:THERMAL)
> > > Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> > > Cc: linux-kernel@vger.kernel.org (open list)
> > >
> > > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> > > ---
> > >  .../driver-api/thermal/sysfs-api.rst          |  2 +
> > >  drivers/thermal/thermal_sysfs.c               | 86 +++++++++++++++++++
> > >  2 files changed, 88 insertions(+)
> > >
> > > diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> > > index ed5e6ba4e0d7..4a2b92a7488c 100644
> > > --- a/Documentation/driver-api/thermal/sysfs-api.rst
> > > +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> > > @@ -359,6 +359,8 @@ Thermal zone device sys I/F, created once it's registered::
> > >      |---stats/reset_tz_stats:  Writes to this file resets the statistics.
> > >      |---stats/max_gradient:    The maximum recorded dT/dt in uC/ms.
> > >      |---stats/min_gradient:    The minimum recorded dT/dt in uC/ms.
> > > +    |---stats/time_in_trip_ms: Time spent on each temperature interval of
> > > +                               trip points.
> >
> > I would write "in each temperature interval between consecutive trip points".
>
> Ok
>
> >
> > Doesn't this assume a specific temperature ordering of trip points?
> > And so what if they are not ordered?
>
> It does. I believe other things will break if they are not ordered.

But there's no guarantee that they will be ordered, so it looks like
those other things are already broken.
