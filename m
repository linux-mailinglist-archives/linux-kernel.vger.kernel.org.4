Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5889268C57C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBFSN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBFSN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:13:26 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA8F1DB82;
        Mon,  6 Feb 2023 10:13:25 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id dr8so36597555ejc.12;
        Mon, 06 Feb 2023 10:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPvW+hY84W31RFZxq8K7sUuj1kGrFPj+BZirPg1lejw=;
        b=3p8ezpeDLDOSlocQdyxXn1ZGVGa7+JB5LY94gb8QkRZAyd48w9FrYC5HwKIY+WZf0t
         NPYjIq0vT+2Pqs402MTsS1fx92SSIjMAeTYm46MG63pHOyjNuquuS1WTd1ZbsTXa06YB
         d8J32931I53Ty5sLxc/4RB6g9sYo14fPOBQT+CgMn5oYt+Wjy/QRjO3bbFM7hpeQhElz
         hrpTGfV7hqT0X2gEdI8ydOwk0j0NDgYqrJUfoMmjpU71W0g4V6B6C3HQe+jEAlYG1gYa
         HcBRuKcZhGCrC8yqIuoISQmAu8uS8l96clnTcvzCmzp5Wh2bUfUlu/ENQDKaskpSpck9
         4dFg==
X-Gm-Message-State: AO0yUKW05I+9boyRCrn8pccjSXmAAO0cdisxItLBgdQUNXBi2hR2ybEa
        Z5y1lVfaqLzd43qiy4/B1eYGR+HZZ+8v2lA3BEycK54Q
X-Google-Smtp-Source: AK7set9LsDFAOQ9XBXk5DJnzw0dokmM7p83MjCI2Dz5SH8zHMKKclsYBsclws6lFA2RkEWs04WvNt5XMG1cfY/5trP8=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr63880ejb.274.1675707203635; Mon, 06
 Feb 2023 10:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20230203175832.3406504-1-daniel.lezcano@linaro.org>
 <CAJZ5v0jzLCQt22MhfaAvL8w+RP7Y-YqxUdcgQ2u2Tz9i0CS+2A@mail.gmail.com> <474338ff-26af-061e-1166-a1bd906ffe00@linaro.org>
In-Reply-To: <474338ff-26af-061e-1166-a1bd906ffe00@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Feb 2023 19:13:12 +0100
Message-ID: <CAJZ5v0hfeeiBtVrN4e3JQcbTT1Jr1_iTWDUMZ4Yme3hvZeEkjA@mail.gmail.com>
Subject: Re: [PATCH] thermal: Hunt zero trip points thermal zones usage
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Feb 6, 2023 at 7:00 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 06/02/2023 17:08, Rafael J. Wysocki wrote:
> > On Fri, Feb 3, 2023 at 6:59 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> Some drivers are declaring a thermal zone without any thermal trip
> >> points.
> >>
> >> On the other side, we are introducing the function
> >> thermal_zone_device_register_with_trips() which provides an array of
> >> generic thermal trip points. When all the drivers will be converted to
> >> the generic trip points, keeping two functions will be useless.
> >>
> >> Most of the drivers are now using
> >> thermal_zone_device_register_with_trips() with the generic trip
> >> points. As soon as the remaining drivers are merged, the
> >> thermal_zone_device_register_with_trips() will be renamed to
> >> thermal_zone_device_register().
> >
> > So why is this the first time I'm learning about this plan?
>
> Well it is not a plan, it looked purely logical to me that the
> _with_trips variant was added to support the generic trip points in
> addition to the specific trips. As soon as all the drivers are
> converted, there is no need to have these two functions anymore and we
> can fall back to the previous name (or a shorter one).
>
> >> Obviously this renaming can only happen if there are no more user of
> >> the thermal_zone_device_register() function.
> >>
> >> This change uses thermal_zone_device_register_with_trips() with a NULL
> >> parameter for the trip point array instead of
> >> thermal_zone_device_register().
> >
> > And later it will be renamed to thermal_zone_device_register() again?
>
> Yes, that was the idea, unify the name and then use a cocci script to
> rename them all.
>
> > Can we just stop confusing people this way?
> >
> > What would be wrong with changing both
> > thermal_zone_device_register_with_trips() and
> > thermal_zone_device_register() together when we are ready?  And why
> > can't the both be replaced with something line thermal_zone_register()
> > doing all of the necessary things in one go?  Why do we have to make
> > confusing and redundant changes?
>
> For me the result will be the same, if you prefer to wait for all the
> drivers to be converted then it is fine for me.

Yes, please.
