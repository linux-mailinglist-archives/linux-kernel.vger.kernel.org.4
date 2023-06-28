Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4793741928
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjF1UAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjF1UAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:00:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B31FE7;
        Wed, 28 Jun 2023 13:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD54D61464;
        Wed, 28 Jun 2023 20:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7D6C433C8;
        Wed, 28 Jun 2023 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687982404;
        bh=B+RSyNVteRzKXRsWojAaoBAvx3nzmKOepDBCgrWk75Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3DAS+DhjSBSF9kLBE56DRoAnHxqMycCSGE90TM5K/zrbttcJ0PGjGYru+7zttFug
         SiEsAu/eGbGk87tJa6MbuC+4T6HZPPX6H9LsZ3O+JhVTD8jEYeNYdS1/fsm3a1Kc/7
         m4Ov1P0PCeIr7Ml2rVcX1J8bHYjjXYZ6KnwGejaruvL4cghEvDC0/W2KgSdq25y0mU
         VwXE5W2suIGkTVwtlP9WYGagF9KxO/mqmfLMx8OpDoZAJY1X1wjz46lqpXWBKGWubM
         2TWNJSmvbpFWbG4HoimhGCvT6CxwGWTRSqdLIT5NWqnnDlQDWGvmibpuh2Aw2nEpJF
         gAqCqtEDvDT2A==
Date:   Wed, 28 Jun 2023 13:00:02 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] thermal: stats: introduce tz time in trip
Message-ID: <ZJyRQhLURUrIHP1z@uf8f119305bce5e.ant.amazon.com>
References: <20230519032719.2581689-1-evalenti@kernel.org>
 <20230519032719.2581689-6-evalenti@kernel.org>
 <CAJZ5v0hho1B6TiwshT4kYhs+Z4Q6xvnbgf8aoEZop=owkJHqxg@mail.gmail.com>
 <ZJKAYAx5768atJa8@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jVL69QYpUFCMBeZ9eACca4XoeR6Js_qoDd2K5PfU9BwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jVL69QYpUFCMBeZ9eACca4XoeR6Js_qoDd2K5PfU9BwA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 06:40:20PM +0200, Rafael J. Wysocki wrote:
> 
> 
> 
> On Wed, Jun 21, 2023 at 6:45 AM Eduardo Valentin <evalenti@kernel.org> wrote:
> >
> > On Tue, Jun 20, 2023 at 07:27:57PM +0200, Rafael J. Wysocki wrote:
> > >
> > >
> > >
> > > On Fri, May 19, 2023 at 5:27 AM Eduardo Valentin <evalenti@kernel.org> wrote:
> > > >
> > > > From: Eduardo Valentin <eduval@amazon.com>
> > > >
> > > > This patch adds a statistic to report how long
> > > > the thermal zone spent on temperature intervals
> > > > created by each trip point. The first interval
> > > > is the range below the first trip point. All
> > > > subsequent intervals are accounted when temperature
> > > > is above the trip point temperature value.
> > > >
> > > > Samples:
> > > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > > trip-1  0       0
> > >
> > > The above line is confusing.
> > >
> > > > trip0   -10000  35188
> > > > trip1   25000   0
> > >
> > > And the format violates the "one value per attribute" sysfs rule.
> > >
> > > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > > trip-1  0       0
> > > > trip0   -10000  36901
> > > > trip1   25000   0
> > > > $ echo 25001 > /sys//class/thermal/thermal_zone0/emul_temp
> > > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > > trip-1  0       0
> > > > trip0   -10000  47810
> > > > trip1   25000   2259
> > > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > > trip-1  0       0
> > > > trip0   -10000  47810
> > > > trip1   25000   3224
> > > > $ echo 24001 > /sys//class/thermal/thermal_zone0/emul_temp
> > > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > > trip-1  0       0
> > > > trip0   -10000  48960
> > > > trip1   25000   10080
> > > > $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> > > > trip-1  0       0
> > > > trip0   -10000  49844
> > > > trip1   25000   10080
> > > >
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
> > > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
> > > > Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
> > > > Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
> > > > Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> > > > Cc: linux-pm@vger.kernel.org (open list:THERMAL)
> > > > Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> > > > Cc: linux-kernel@vger.kernel.org (open list)
> > > >
> > > > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> > > > ---
> > > >  .../driver-api/thermal/sysfs-api.rst          |  2 +
> > > >  drivers/thermal/thermal_sysfs.c               | 86 +++++++++++++++++++
> > > >  2 files changed, 88 insertions(+)
> > > >
> > > > diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> > > > index ed5e6ba4e0d7..4a2b92a7488c 100644
> > > > --- a/Documentation/driver-api/thermal/sysfs-api.rst
> > > > +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> > > > @@ -359,6 +359,8 @@ Thermal zone device sys I/F, created once it's registered::
> > > >      |---stats/reset_tz_stats:  Writes to this file resets the statistics.
> > > >      |---stats/max_gradient:    The maximum recorded dT/dt in uC/ms.
> > > >      |---stats/min_gradient:    The minimum recorded dT/dt in uC/ms.
> > > > +    |---stats/time_in_trip_ms: Time spent on each temperature interval of
> > > > +                               trip points.
> > >
> > > I would write "in each temperature interval between consecutive trip points".
> >
> > Ok
> >
> > >
> > > Doesn't this assume a specific temperature ordering of trip points?
> > > And so what if they are not ordered?
> >
> > It does. I believe other things will break if they are not ordered.
> 
> But there's no guarantee that they will be ordered, so it looks like
> those other things are already broken.

Correct. (1) there is no guarantee, it works by construction, and (2) current
code does assume ascending order, so yes, if they come unsorted, the core
code will not properly work.

Ensuring the order is likely beyond the original intention of this patch, but
we do need to improve there, for sure.

-- 
All the best,
Eduardo Valentin
