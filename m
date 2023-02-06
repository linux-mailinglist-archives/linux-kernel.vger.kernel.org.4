Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05AF68C4C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBFR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjBFR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:28:44 -0500
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E859EEE;
        Mon,  6 Feb 2023 09:28:31 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id l12so3530171edb.0;
        Mon, 06 Feb 2023 09:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNUkQ9XxPrxK4otYbqHTBhXXuiskkXfC9w+d3Yp3xfA=;
        b=BzFR+A9tlN8T+c/NgfU4sMSwiBpOrwL0O3jWc3SqUl/zr9GdRIFvrTPaEBYVq9Sf1S
         0m489wbq97qQmpUPs5zifzcngcYU978KfhhPAzi2gV6Tm48Tz1XKH8B0Al6exdfEHfgI
         0IX8WPb1CyZ8r0Dqbpjss05vEeAQGi+U52HAHS50pK7EnSgXhduZqS6AT0m//+DFt8Om
         Gmx/u9NAxWVbO0JKUPVDHdHvP1zPEBcL5CKGknitbjq7KAscrD/w70O/+hOvoDI7yWMu
         80gFvE0P7IAjuhUOwhbS6WYpitmncbV9UjRsfILgnzHZokXOnD+NvmPyu708lShmzEWq
         TZYA==
X-Gm-Message-State: AO0yUKXlQrXY3zsyQOoaDkcOZ+du6Fv7lfX3ygtHZg+rr502Pd3+pgx8
        +jUPgQ+I5NF7zdl639rAX7gnD0ceJjeT7qFfcG4=
X-Google-Smtp-Source: AK7set+VXS2r5wnk5Ptk/58i/WvzHxY8QKg6Qjw7V+e3YmJSnCNhHeIxgeSg1T7/wEA+8wtYKkp8VjbWNCR26qfNITo=
X-Received: by 2002:a50:d654:0:b0:4aa:a0ee:7ed1 with SMTP id
 c20-20020a50d654000000b004aaa0ee7ed1mr89647edj.58.1675704510461; Mon, 06 Feb
 2023 09:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20230203175832.3406504-1-daniel.lezcano@linaro.org> <CAJZ5v0jzLCQt22MhfaAvL8w+RP7Y-YqxUdcgQ2u2Tz9i0CS+2A@mail.gmail.com>
In-Reply-To: <CAJZ5v0jzLCQt22MhfaAvL8w+RP7Y-YqxUdcgQ2u2Tz9i0CS+2A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Feb 2023 18:28:19 +0100
Message-ID: <CAJZ5v0gzaa5KMkULHtp9Vi-VTomOhkf2eP0eufHqz9NMx5crJA@mail.gmail.com>
Subject: Re: [PATCH] thermal: Hunt zero trip points thermal zones usage
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 5:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Feb 3, 2023 at 6:59 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> > Some drivers are declaring a thermal zone without any thermal trip
> > points.
> >
> > On the other side, we are introducing the function
> > thermal_zone_device_register_with_trips() which provides an array of
> > generic thermal trip points. When all the drivers will be converted to
> > the generic trip points, keeping two functions will be useless.
> >
> > Most of the drivers are now using
> > thermal_zone_device_register_with_trips() with the generic trip
> > points. As soon as the remaining drivers are merged, the
> > thermal_zone_device_register_with_trips() will be renamed to
> > thermal_zone_device_register().
>
> So why is this the first time I'm learning about this plan?
>
> > Obviously this renaming can only happen if there are no more user of
> > the thermal_zone_device_register() function.
> >
> > This change uses thermal_zone_device_register_with_trips() with a NULL
> > parameter for the trip point array instead of
> > thermal_zone_device_register().
>
> And later it will be renamed to thermal_zone_device_register() again?
>
> Can we just stop confusing people this way?
>
> What would be wrong with changing both
> thermal_zone_device_register_with_trips() and
> thermal_zone_device_register() together when we are ready?  And why
> can't the both be replaced with something line thermal_zone_register()
> doing all of the necessary things in one go?  Why do we have to make
> confusing and redundant changes?

Or you can define a thermal_register_tripless_zone() wrapper around
thermal_zone_device_register_with_trips() and make the drivers in
question use that, and modify them just once.
