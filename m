Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A081E5EE825
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiI1VQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiI1VQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:16:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C5910BB18
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:10:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so12777564plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9t1zC330HUR2z0lQkNzGtWIQnlQT+GzrLYZrL9egK1U=;
        b=JDX3GYUhPjHCWI9lm9NZcjbU+aMhiRXuYEclhJtT4AZ7VuiPWPseLSUDBsDNdO/Xg/
         RTeu3E/XB8AoR2yDZEyCK0Cazj/HOIFifbRDPm9EDijegDsq78fkSCnmQZe4OKRlzXCp
         xCD5SSeVhuf6yuf7sxeUwcIFK0U9QHmM3LN3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9t1zC330HUR2z0lQkNzGtWIQnlQT+GzrLYZrL9egK1U=;
        b=3p+SYXbk6dBt2xVBxkdj/YUaPDc0Ym15IRVjs52Yj/MMavtdMjYlmwF99jvvE516Zt
         0siKOQkal9JsCFHAQMc2A+NUTi0KhyWR5QVU1jrg8nx+L1ACzlrB1/YYFIiUYZ3BM4c6
         Tn6AJbG4EO2P90Hg02RMttjlFTIiBQvuxr2673Z5Buk4rO7+icbzZ5FVdnWH73S8ApAV
         1EZGOICQky9iT2IcSeR48wqoWJBh5roFFqkLzvpUVgXfz+QV7/skCzcalGguoIWBaklO
         85X+qCr3rkSCx6jtymd0NBujj+Ze6VJRZxsSkMBzhLPanojIfriir2k8/pDsnRNzdEMH
         i4wQ==
X-Gm-Message-State: ACrzQf0rTxGk0SJBrq/DOBsvwvakw6Xec8YZQtVFuBumxkN5BFRYqt5L
        pvpUjyKhtgj3nZyYtgk01EInBxfDQS6esg==
X-Google-Smtp-Source: AMsMyM73HZy7mv+dkKj9v8I2sRU1IUGRo24r6nCWu/HAlliLPpzTnR9nswxDX4Q9EJfIPCR/VYXaFw==
X-Received: by 2002:a17:902:d2c5:b0:176:d0b0:bf53 with SMTP id n5-20020a170902d2c500b00176d0b0bf53mr1670099plc.88.1664399454366;
        Wed, 28 Sep 2022 14:10:54 -0700 (PDT)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com. [209.85.216.46])
        by smtp.gmail.com with ESMTPSA id ix21-20020a170902f81500b0016c574aa0fdsm2194539plb.76.2022.09.28.14.10.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 14:10:52 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so3957550pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:10:51 -0700 (PDT)
X-Received: by 2002:a17:902:f68d:b0:178:41dd:12ad with SMTP id
 l13-20020a170902f68d00b0017841dd12admr1645115plg.25.1664399451471; Wed, 28
 Sep 2022 14:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220921155205.1332614-1-rrangel@chromium.org>
 <20220921094736.v5.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid> <CAJZ5v0g57mF-4ZC2ajL5+JE+q9y=fW1G-OXR8tuOk4TYxHPWtQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g57mF-4ZC2ajL5+JE+q9y=fW1G-OXR8tuOk4TYxHPWtQ@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 28 Sep 2022 15:10:40 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BZ5jnTY4DQD5mxpnLcLxn5Oo=izB1+f06JOqXU5VGz_A@mail.gmail.com>
Message-ID: <CAHQZ30BZ5jnTY4DQD5mxpnLcLxn5Oo=izB1+f06JOqXU5VGz_A@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] ACPI: PM: Take wake IRQ into consideration when
 entering suspend-to-idle
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Tim Van Patten <timvp@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 11:00 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 5:52 PM Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > This change adds support for ACPI devices that use ExclusiveAndWake or
> > SharedAndWake in their _CRS GpioInt definition (instead of using _PRW),
> > and also provide power resources. Previously the ACPI subsystem had no
> > idea if the device had a wake capable interrupt armed. This resulted
> > in the ACPI device PM system placing the device into D3Cold, and thus
> > cutting power to the device. With this change we will now query the
> > _S0W method to figure out the appropriate wake capable D-state.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> >
> > Changes in v5:
> > - Go back to using adev->wakeup.flags.valid to keep the diff cleaner
> > - Fix a typo in comment
> >
> >  drivers/acpi/device_pm.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> > index 9dce1245689ca2..3111fc426e04fd 100644
> > --- a/drivers/acpi/device_pm.c
> > +++ b/drivers/acpi/device_pm.c

> > @@ -681,8 +681,23 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
> >                 d_min = ret;
> >                 wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
> >                         && adev->wakeup.sleep_state >= target_state;
Just an FYI, I didn't update the code that handles the target state >
S0. I need to get a
device that has S3 capabilities and the correct firmware to test this.
I figure I can do
that as a different patch when I have time to test with an S3 device.

> > -       } else {
> > -               wakeup = adev->wakeup.flags.valid;
> > +       } else if (adev->wakeup.flags.valid) {
> > +               /* ACPI GPE specified in _PRW. */
> > +               wakeup = true;

>
> I would retain the "else" clause as it was and just add a new "else
> if" one before it.
>
Done

> > +       } else if (device_may_wakeup(dev) && dev->power.wakeirq) {
> > +               /*
> > +                * The ACPI subsystem doesn't manage the wake bit for IRQs
> > +                * defined with ExclusiveAndWake and SharedAndWake. Instead we
> > +                * expect them to be managed via the PM subsystem. Drivers
> > +                * should call dev_pm_set_wake_irq to register an IRQ as a wake
> > +                * source.
> > +                *
> > +                * If a device has a wake IRQ attached we need to check the
> > +                * _S0W method to get the correct wake D-state. Otherwise we
> > +                * end up putting the device into D3Cold which will more than
> > +                * likely disable wake functionality.
> > +                */
> > +               wakeup = true;
> >         }
> >
> >         /*
> > --

I'll send out v6 soon unless anyone else has any comments.
