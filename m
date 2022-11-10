Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0056243FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiKJOOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiKJOO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:14:28 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C1EE09B;
        Thu, 10 Nov 2022 06:14:12 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id p18so1131463qkg.2;
        Thu, 10 Nov 2022 06:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7qG/p4ldGiPOcLmbhYVR0MIEBwjFjPlXUF2ccEEKpw=;
        b=eSEP0r+UFwQ8Fu4Hb1s5V+FH/0bDadxVuzyFljViy1m3hqpAAvMr8j8gVXLhnwwCsN
         8Wr+68ggG98YJXbpLR10KqHihCePmY55s3LYlOw5asdjk+ud6BNWQqNtVE7jVyFlQISd
         Ncs4L9qaVW15lbpReNru21GZXNKMTV+4K2xX6cVj31oDZlk++j0nIWXXChmCdxBhVVxA
         xRcezwo/cfrQC1LSjwUXthCNA3+yd5LUpxioivhaYA1uH0WCtWp8JVdCiAZn7nhqaQns
         7ShlMOqmQK7MQMvG+C9wU/3eSIKeL8Om7bVgWfSjGSGhddyjYBEjfYEdSTpCgyHj3pod
         S5/g==
X-Gm-Message-State: ACrzQf1FBa37doKDh4WA/dSu2JrB6EVav+HzemtcCTr+lUHx+WFW6LOA
        MJvTeZ9W/0TtesE0ZCLadzxNiDrushrEhBt5cHo=
X-Google-Smtp-Source: AMsMyM5g5tJM0GAroLlw36TBLE8deaDTfjYrEiEThhcdDnMM4twx99KFI0weuWwuYxKzsYlNfGCgT6DyzF7EMWXEETs=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr45915831qkl.443.1668089651365; Thu, 10
 Nov 2022 06:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20221017130910.2307118-1-linux@roeck-us.net> <20221017130910.2307118-6-linux@roeck-us.net>
 <CAJZ5v0hO9_95uD1qY8aBe094JWsxPrba2wk_PchKHmVqRj0CHw@mail.gmail.com>
 <20221110002549.GA3550654@roeck-us.net> <CAJZ5v0je2QSUhU8Knk9UsboGLRpk2sNqE6U4X6eGAe+NUxZt_Q@mail.gmail.com>
 <20221110141157.GA2404288@roeck-us.net>
In-Reply-To: <20221110141157.GA2404288@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 15:14:00 +0100
Message-ID: <CAJZ5v0gyX-G+bsYkp01-LbCHU4dAo_W2gYx7df8bGtp9aT5a0w@mail.gmail.com>
Subject: Re: [PATCH 5/9] thermal/core: Introduce locked version of thermal_zone_device_update
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Nov 10, 2022 at 3:12 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Nov 10, 2022 at 02:01:49PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Nov 10, 2022 at 1:25 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Wed, Nov 09, 2022 at 08:15:17PM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Oct 17, 2022 at 3:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > >
> > > > > In thermal_zone_device_set_mode(), the thermal zone mutex is released only
> > > > > to be reacquired in the subsequent call to thermal_zone_device_update().
> > > > >
> > > > > Introduce __thermal_zone_device_update() as locked version of
> > > >
> > > > Did you mean "unlocked"?
> > > >
> > > No, I did mean "locked", as in "must be called with thermal zone device
> > > mutex acquired".
> > >
> > > locked:
> > >
> > > void __thermal_zone_device_update(struct thermal_zone_device *tz,
> > >                                   enum thermal_notify_event event)
> > > {
> > >         ...
> > > }
> > >
> > > unlocked:
> > >
> > > void thermal_zone_device_update(struct thermal_zone_device *tz,
> > >                                 enum thermal_notify_event event)
> > > {
> > >         mutex_lock(&tz->lock);
> > >         if (device_is_registered(&tz->device))
> > >                 __thermal_zone_device_update(tz, event);
> > >         mutex_unlock(&tz->lock);
> > > }
> >
> > Thanks for the explanation.
> >
> > > Should I phrase or explain it differently ?
> >
> > I would rather say "bare" or something like that so it is all clear to
> > people like me, but it is your call.
>
> I updated the commit description to use "must be called with thermal
> device mutex held". I kept 'locked' in the subject; I don't think using
> 'bare' there would add any clarity. Hope that is ok.

It is.
