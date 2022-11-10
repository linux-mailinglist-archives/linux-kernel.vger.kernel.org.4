Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C857A6242C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKJNCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKJNCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:02:16 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3588725E9;
        Thu, 10 Nov 2022 05:02:12 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id z17so976398qki.11;
        Thu, 10 Nov 2022 05:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsfYp5SezvI3MFiQxEmlFhh5nmWcQ5tJ6YkRjK54Yks=;
        b=J5jMbJ1GbKefOaYWZMpCbsrCxMXfDjPzyB5ZJ/WOnkPpjpqqB+BPbFt/dEQTOtGFem
         2+w7z/IWX//gTzJeE2NaUKljlVOHVoiIbQr1ltE9gO8pw/x9kFP7hW6Lr05AzxPI46BP
         BWdNzDCabRRH87uQwyq8CLUc9cKxpb89VmumwSrxBQlYBTGWne46l8ZY9k93x2jpmNf6
         YFMVNtLej4QeMpL8PPPUvqe35qV5fVzBIgZ3aqViGfz2hoarS/VIhCoFHx0/O/cwLw5P
         L6q6UQjiNhYlP2H3smgfZ+TBj86Q+qSSyRD1SvZ0+LjktLhmYh14brxXJF2jyZCw7XC8
         r/xQ==
X-Gm-Message-State: ACrzQf3EzMGIP/9UcSHBIzx1ZNptf8GsoeSoGQqZJf1ez5MBXyi+sxwH
        zcsr4cLBVKYQfHTUMXAzxf/5jV+e8MMkGrLncfo=
X-Google-Smtp-Source: AMsMyM4OVrGeZTrljL1VI+EAIhcce32gE+BmWfg9mU3oy4JLELw23BWbxtfUa68k/0KZqijNLfojC25ZrabY7qGYoSw=
X-Received: by 2002:a05:620a:1476:b0:6fa:4c67:83ec with SMTP id
 j22-20020a05620a147600b006fa4c6783ecmr35189800qkl.23.1668085321410; Thu, 10
 Nov 2022 05:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20221017130910.2307118-1-linux@roeck-us.net> <20221017130910.2307118-6-linux@roeck-us.net>
 <CAJZ5v0hO9_95uD1qY8aBe094JWsxPrba2wk_PchKHmVqRj0CHw@mail.gmail.com> <20221110002549.GA3550654@roeck-us.net>
In-Reply-To: <20221110002549.GA3550654@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 14:01:49 +0100
Message-ID: <CAJZ5v0je2QSUhU8Knk9UsboGLRpk2sNqE6U4X6eGAe+NUxZt_Q@mail.gmail.com>
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

On Thu, Nov 10, 2022 at 1:25 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Nov 09, 2022 at 08:15:17PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Oct 17, 2022 at 3:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > In thermal_zone_device_set_mode(), the thermal zone mutex is released only
> > > to be reacquired in the subsequent call to thermal_zone_device_update().
> > >
> > > Introduce __thermal_zone_device_update() as locked version of
> >
> > Did you mean "unlocked"?
> >
> No, I did mean "locked", as in "must be called with thermal zone device
> mutex acquired".
>
> locked:
>
> void __thermal_zone_device_update(struct thermal_zone_device *tz,
>                                   enum thermal_notify_event event)
> {
>         ...
> }
>
> unlocked:
>
> void thermal_zone_device_update(struct thermal_zone_device *tz,
>                                 enum thermal_notify_event event)
> {
>         mutex_lock(&tz->lock);
>         if (device_is_registered(&tz->device))
>                 __thermal_zone_device_update(tz, event);
>         mutex_unlock(&tz->lock);
> }

Thanks for the explanation.

> Should I phrase or explain it differently ?

I would rather say "bare" or something like that so it is all clear to
people like me, but it is your call.
