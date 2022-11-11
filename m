Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C911962512C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiKKCwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiKKCvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:51:53 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A1D4D5FB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:50:47 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id a27so2090722qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7/uPLWONB3lHJlrNVd2zxOfGpwQbq25ntkT77/YGDPA=;
        b=hINR+06nMZzkBFh1tHXwshIb2SIXPooUIurmPeY3zE3X7Iaeu2rjwJWdxUJf5QBJSy
         a/0BSDCvkiT5larzYrZYfXWwB1WyAcofbNQwuwsFJOv2iX9m+j9o4CJhF2pz9/G+TPy+
         zxpxNpe6tB8j8p9maSb+zCyDHOe3elm4pNBO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/uPLWONB3lHJlrNVd2zxOfGpwQbq25ntkT77/YGDPA=;
        b=W2GediPKdD84jbcVZAeFdaTHkYDZc8LrSMTdZKUFohyQsE9lViYLzDWW67nwRfQrV+
         FgbNr6IiRu7wO4D5Yj6xf7yrez+z0EIqpNlKUivSEeffvVyAs1mrnsHAsPVgnWqs6LZU
         UF9Gw+duIYLNSx92szWdT6D8shPb6hNobJXnF/s6EGQUgi9iJ2+0hSAUDGIxIKYXf+jW
         Zsa+GbnjH+FGme6cpar6INR2szMSITSYZ0UK7lm26tp2nzxdDARmkN25kivPqRE7Y32x
         DwBeEOfxaIsIlrK9EchU7X9N2BB/7tIBr2hIYH3mIE0zu75X/2kmdbVq46RmyHQtJ3Az
         8LDw==
X-Gm-Message-State: ACrzQf3TG/P1+ZUQVHVEAD9Igj9YqLsHvBBDx1ffLIABMDtR8lWyNhDe
        6TrCfVcNJXgzF7TgwgauRvm5Wca8P6XVfXftr9TH+Q==
X-Google-Smtp-Source: AMsMyM7Nt4Medm0Kogdsm1fKDD7rfCmUC6k69Z4WBAe1oDfLkSutDrIUOkJQOfpBqubLPaD795CNE2+S0wRgmZyLKak=
X-Received: by 2002:a05:622a:8a:b0:3a4:f45a:ac1a with SMTP id
 o10-20020a05622a008a00b003a4f45aac1amr2815797qtw.352.1668135046771; Thu, 10
 Nov 2022 18:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20221110101241.10576-1-subhajit.ghosh@vixtechnology.com>
 <CAJCx=g=qRd+WaCLOHwnEjg1Myg4Ng=PK0sxcGgEG9VT+VpondA@mail.gmail.com> <b6ac2692-3152-dfc4-5388-7986042970f0@vixtechnology.com>
In-Reply-To: <b6ac2692-3152-dfc4-5388-7986042970f0@vixtechnology.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 11 Nov 2022 10:50:35 +0800
Message-ID: <CAJCx=g=WaGiBFYJTTjNgzrnW3We0qpuMvyy9iFAVDC8Mkbscsg@mail.gmail.com>
Subject: Re: [PATCH] iio: light: apds9960: Fix iio_event_spec structures
To:     Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 10:45 PM Subhajit Ghosh
<subhajit.ghosh@vixtechnology.com> wrote:
>
>
> >>                 .type = IIO_EV_TYPE_THRESH,
> >>                 .dir = IIO_EV_DIR_RISING,
> >> -               .mask_separate = BIT(IIO_EV_INFO_VALUE) |
> >> -                       BIT(IIO_EV_INFO_ENABLE),
> >> +               .mask_separate = BIT(IIO_EV_INFO_VALUE),
> >
> > Probably more concise to use the following, and you won't need to add
> > an additional item to the structs.
> >
> >    .mask_separate = BIT(IIO_EV_INFO_VALUE),
> >    .mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> >
>
> Above is the first thing I tried.
>
> Current implementation:
>
> root@stm32mp1:~# ls -1 /sys/bus/iio/devices/iio:device0/events/
> in_intensity_clear_thresh_falling_en
> in_intensity_clear_thresh_falling_value
> in_intensity_clear_thresh_rising_en
> in_intensity_clear_thresh_rising_value
>
> in_proximity_thresh_falling_en
> in_proximity_thresh_falling_value
> in_proximity_thresh_rising_en
> in_proximity_thresh_rising_value
>
>
> First method (Which you are suggesting):
> .mask_separate = BIT(IIO_EV_INFO_VALUE),
> .mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
>
> root@stm32mp1:~# ls -1 /sys/bus/iio/devices/iio:device0/events/
> in_intensity_clear_thresh_falling_value
> in_intensity_clear_thresh_rising_value
> in_intensity_thresh_falling_en
> in_intensity_thresh_rising_en
>
> The above says all channels with with the type IIO_INTENSITY has
> the same enable but we require this particular channel (in_intensity_clear)
> regardless of direction to have the same enable.
> Using mask_shared_by_dir and mask_shared_by_all does not provide the logical
> attribute name.
>
>
> This patch provides the below:
>
> root@stm32mp1:~# ls -1 /sys/bus/iio/devices/iio:device0/events/
> in_intensity_clear_thresh_either_en
> in_intensity_clear_thresh_falling_value
> in_intensity_clear_thresh_rising_value
>
> in_proximity_thresh_either_en
> in_proximity_thresh_falling_value
> in_proximity_thresh_rising_value
>
> Verified using iio_event_monitor:
>
> root@stm32mp1:~# ./iio_event_monitor /dev/iio:device0
> Event: time: 1647143384807582753, type: proximity, channel: 0, evtype: thresh, direction: either
>

Hmm maybe Jonathan will have some feedback on this (and if it is okay
to break the ABI interface). Been awhile since I've touched
this driver and a little rusty on iio events.  But I am guessing your
method makes sense since the event(s) has direction and a type, and
can't just have one of the .mask_shared_by_dir and mask_shared_by_type.

In any case:

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>


- Matt

>
> Regards
> Subhajit Ghosh
>
> --
> This email is confidential. If you have received this email in error please
> notify us immediately by return email and delete this email and any
> attachments. Vix accepts no liability for any damage caused by this email
> or any attachments due to viruses, interference, interception, corruption
> or unauthorised access.
