Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF7D5EF303
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiI2KGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiI2KGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:06:44 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45FB142E3B;
        Thu, 29 Sep 2022 03:06:42 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id g2so517148qkk.1;
        Thu, 29 Sep 2022 03:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0kCa6jTfE848WGHyQOi/qrbS8sATrhTFphLUVNaFX8Q=;
        b=dTBNP5KKwzaESHxlZTXaKrEibySV9KBWmhcUP//s3H7c3+sfNGJSUOw5xP8W5lvz7x
         NpQ+qEHFeiVsYlqG1yiwBwSuW2OwLY9AGwcmbFfKbPEA0VSIJtyCv+rWdo7oRltPbqCK
         Jyn039kJOaBNxw2BxKsqS7yX456/1o8ZH5WpDFGA16iwYxYpRalSv7lfUF4k7mCcNiLC
         ooUE1yKLNtlS6P2QoaolxfAib7hHN81CM9JHqi7uEhxTxE2gOjFCL+Hq+YGDXNNlG57Z
         Ovesjsnq03bsTGQWdgDUtVsw8B4/VX6WAAhuG/2GKU6bcUVaLBULl4snCkAe/9neoTwa
         uNNA==
X-Gm-Message-State: ACrzQf19y+rW/EH2Frj8e4aQq00Fv0njy2HuAUXhi7PAlG5F1vQqLqOT
        2qisxNCtx6fJ5gwwHnVDD33hddpEwh7fBNMaZ38=
X-Google-Smtp-Source: AMsMyM4t+VHeXvfc0oxR5u5rgQbzvQXJbf+Qmt3ftRYCv7lZgD9+ONOm3P8z3DYu0LifaO4xhboMJzl7GEXLC4lSijk=
X-Received: by 2002:a05:620a:2988:b0:6ce:cc3f:73b9 with SMTP id
 r8-20020a05620a298800b006cecc3f73b9mr1503211qkp.9.1664446001328; Thu, 29 Sep
 2022 03:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220921155205.1332614-1-rrangel@chromium.org>
 <20220921094736.v5.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid>
 <CAJZ5v0g57mF-4ZC2ajL5+JE+q9y=fW1G-OXR8tuOk4TYxHPWtQ@mail.gmail.com> <CAHQZ30BZ5jnTY4DQD5mxpnLcLxn5Oo=izB1+f06JOqXU5VGz_A@mail.gmail.com>
In-Reply-To: <CAHQZ30BZ5jnTY4DQD5mxpnLcLxn5Oo=izB1+f06JOqXU5VGz_A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Sep 2022 12:06:29 +0200
Message-ID: <CAJZ5v0gwU81_QX9JJSRyEVY9NABGxczYpp1w6OrOVGrJ8Xdmcg@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] ACPI: PM: Take wake IRQ into consideration when
 entering suspend-to-idle
To:     Raul Rangel <rrangel@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:10 PM Raul Rangel <rrangel@chromium.org> wrote:
>
> On Sat, Sep 24, 2022 at 11:00 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Sep 21, 2022 at 5:52 PM Raul E Rangel <rrangel@chromium.org> wrote:
> > >
> > > This change adds support for ACPI devices that use ExclusiveAndWake or
> > > SharedAndWake in their _CRS GpioInt definition (instead of using _PRW),
> > > and also provide power resources. Previously the ACPI subsystem had no
> > > idea if the device had a wake capable interrupt armed. This resulted
> > > in the ACPI device PM system placing the device into D3Cold, and thus
> > > cutting power to the device. With this change we will now query the
> > > _S0W method to figure out the appropriate wake capable D-state.
> > >
> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > > ---
> > >
> > > Changes in v5:
> > > - Go back to using adev->wakeup.flags.valid to keep the diff cleaner
> > > - Fix a typo in comment
> > >
> > >  drivers/acpi/device_pm.c | 19 +++++++++++++++++--
> > >  1 file changed, 17 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> > > index 9dce1245689ca2..3111fc426e04fd 100644
> > > --- a/drivers/acpi/device_pm.c
> > > +++ b/drivers/acpi/device_pm.c
>
> > > @@ -681,8 +681,23 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
> > >                 d_min = ret;
> > >                 wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
> > >                         && adev->wakeup.sleep_state >= target_state;
> Just an FYI, I didn't update the code that handles the target state >
> S0. I need to get a
> device that has S3 capabilities and the correct firmware to test this.
> I figure I can do
> that as a different patch when I have time to test with an S3 device.

That's fine.

> > > -       } else {
> > > -               wakeup = adev->wakeup.flags.valid;
> > > +       } else if (adev->wakeup.flags.valid) {
> > > +               /* ACPI GPE specified in _PRW. */
> > > +               wakeup = true;
>
> >
> > I would retain the "else" clause as it was and just add a new "else
> > if" one before it.
> >
> Done

Thanks!

> > > +       } else if (device_may_wakeup(dev) && dev->power.wakeirq) {
> > > +               /*
> > > +                * The ACPI subsystem doesn't manage the wake bit for IRQs
> > > +                * defined with ExclusiveAndWake and SharedAndWake. Instead we
> > > +                * expect them to be managed via the PM subsystem. Drivers
> > > +                * should call dev_pm_set_wake_irq to register an IRQ as a wake
> > > +                * source.
> > > +                *
> > > +                * If a device has a wake IRQ attached we need to check the
> > > +                * _S0W method to get the correct wake D-state. Otherwise we
> > > +                * end up putting the device into D3Cold which will more than
> > > +                * likely disable wake functionality.
> > > +                */
> > > +               wakeup = true;
> > >         }
> > >
> > >         /*
> > > --
>
> I'll send out v6 soon unless anyone else has any comments.
