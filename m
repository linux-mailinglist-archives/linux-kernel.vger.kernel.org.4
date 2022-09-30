Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0425F112B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiI3Rw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiI3RwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:52:23 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E71D7BEC;
        Fri, 30 Sep 2022 10:52:20 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id gb14so3121112qtb.3;
        Fri, 30 Sep 2022 10:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=srhAWoP1hfQpmWT4UvSOCsskpMMteVZBynvXDbyjiPE=;
        b=ozVJ0fsfgSeGfObYfzAQu8xeAWzhoBUEZeFqmsoEpQ1h+J8nWzQDD21+Duflu8eddu
         c1B0voJLg8wiqZGT3YYbWLjpQ5TknqSQN4n8+JV3D6q5b0eoFHkZ8LL+JqSKdgN+atgU
         rAGGWNGYd07lULymM6lAXjH2MebiAQfo+wZp1Ov0f3uSXAE5jxyJBY0709WZ2T7WlFmD
         qjXpPGnW2V6frzOA68vIvV0+5SrAtndfiJQjf0k8OPFATsZgYwGyx7r/ZIVQFgD9pX7c
         M47DlVcuQH9jU9qXPh4M+F+cRw1ojxI4hcB/BFhZVjW2nk+Y2GHzWkZEcPmBo3/Y/DUV
         qO0g==
X-Gm-Message-State: ACrzQf1LuGJgC87xmgX2GqJANoJKz735zmLjTQtD0Ry7Rc+O9LPpY3OU
        BGOusPffDBqENRssa05C1LluL2cm6PZC5nBJm18=
X-Google-Smtp-Source: AMsMyM5BlizoREtCzGa88frYahD8v5oq4r5w/ou3EmC1+R5KCyKY/UcW1G9EJ/EQZ4n/RQvLogPysE8DAxFW2U5gfpQ=
X-Received: by 2002:a05:622a:620a:b0:35c:bf9e:8748 with SMTP id
 hj10-20020a05622a620a00b0035cbf9e8748mr7900292qtb.494.1664560338832; Fri, 30
 Sep 2022 10:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220927154709.5479-1-sumeet.r.pawnikar@intel.com> <YzQngo1g9XrbvpoP@smile.fi.intel.com>
In-Reply-To: <YzQngo1g9XrbvpoP@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Sep 2022 19:52:07 +0200
Message-ID: <CAJZ5v0iU374GLjVsYSqCThjX0+1ZAxGzaHyGaJbYHpdNnknjpw@mail.gmail.com>
Subject: Re: [PATCH] thermal: Increase maximum number of trip points
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        daniel.lezcano@linaro.org
Cc:     srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Sep 28, 2022 at 12:52 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 27, 2022 at 09:17:09PM +0530, Sumeet Pawnikar wrote:
> > On one of the Chrome system, if we define more than 12 trip points,
> > probe for thermal sensor fails with
> > "int3403 thermal: probe of INTC1046:03 failed with error -22"
> > and throws an error as
> > "thermal_sys: Error: Incorrect number of thermal trips".
> >
> > The thermal_zone_device_register() interface needs maximum
> > number of trip points supported in a zone as an argument.
> > This number can't exceed THERMAL_MAX_TRIPS, which is currently
> > set to 12. To address this issue, THERMAL_MAX_TRIPS value
> > has to be increased.
> >
> > This interface also has an argument to specify a mask of trips
> > which are writable. This mask is defined as an int.
> > This mask sets the ceiling for increasing maximum number of
> > supported trips. With the current implementation, maximum number
> > of trips can be supported is 31.
> >
> > Also, THERMAL_MAX_TRIPS macro is used in one place only.
> > So, remove THERMAL_MAX_TRIPS macro and compare num_trips
> > directly with using a macro BITS_PER_TYPE(int)-1.
>
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied as 6.1 material, thanks!

Daniel, please let me know if you have any concerns.

> > Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> > ---
> >  drivers/thermal/thermal_core.c | 15 ++++++++++++++-
> >  include/linux/thermal.h        |  2 --
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index 50d50cec7774..589dd82fe10c 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1212,7 +1212,20 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
> >               return ERR_PTR(-EINVAL);
> >       }
> >
> > -     if (num_trips > THERMAL_MAX_TRIPS || num_trips < 0 || mask >> num_trips) {
> > +     /*
> > +      * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
> > +      * For example, shifting by 32 will result in compiler warning:
> > +      * warning: right shift count >= width of type [-Wshift-count- overflow]
> > +      *
> > +      * Also "mask >> num_trips" will always be true with 32 bit shift.
> > +      * E.g. mask = 0x80000000 for trip id 31 to be RW. Then
> > +      * mask >> 32 = 0x80000000
> > +      * This will result in failure for the below condition.
> > +      *
> > +      * Check will be true when the bit 31 of the mask is set.
> > +      * 32 bit shift will cause overflow of 4 byte integer.
> > +      */
> > +     if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
> >               pr_err("Incorrect number of thermal trips\n");
> >               return ERR_PTR(-EINVAL);
> >       }
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index 1386c713885d..c05f5c78a0f2 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -17,8 +17,6 @@
> >  #include <linux/workqueue.h>
> >  #include <uapi/linux/thermal.h>
> >
> > -#define THERMAL_MAX_TRIPS    12
> > -
> >  /* invalid cooling state */
> >  #define THERMAL_CSTATE_INVALID -1UL
> >
> > --
> > 2.17.1
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
