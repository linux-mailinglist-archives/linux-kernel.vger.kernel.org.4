Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB03E67818A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjAWQfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjAWQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:34:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCBB28874
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:34:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m11so337833pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tRrnShx/n2WV80skDnao7xhF7peDKBZlfo3A+0HJ+8=;
        b=Fd0tthzhcOpkSsgJzr7d0TUgy7wlmd6tr+eVBZ5h3Z+ebUeKm25KnNFEj90dWg1Qh4
         SEOJdEWI3mwtLa3vrzx60MKUmGClkeep1wEqKY/7fJiKV/EvmFPQvRoFL5l4IveetbAu
         rakuLZ25VxKU7H+/NNIq7FjNrVcfti2nnj8/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tRrnShx/n2WV80skDnao7xhF7peDKBZlfo3A+0HJ+8=;
        b=PCSOZSXwAcRDjv+iTBg/oSc0LMxD4MctBF+VeiTt48K17pPGECc35z7THadBA1eotl
         R77Gk4w2A/z99WX4/pkcF+qJRLsR1+fov+jnpkBpgmP4sOLy98GDQC/NiHqQDf/tFTqN
         BaWg9BYC3UH12/rOyhv1x26jNix0iQ1wBHuZ/8j+7YNgjSGx4FFo9lGvSPKEzeawtp9j
         4Jf1M5IUtVaag6B9gdihnH7U4+4yO7AZS7ZrFrCgMoxbiMhNMyjdh/Xsc4uWLmCpTBCU
         vJWtGwZB0LWP0twzp3dIFXZVijHFrcNqX95abT3zlQIv+Jk1nwCrzMDTl8fOHswupG+s
         pRSw==
X-Gm-Message-State: AFqh2kqVzQ6Z5yT3VBuQ9G303/HK2clxw6RPQxEcsjCIRbV5N1L7yZoz
        PZMnQUGISHzc3E3L+C4iRGaQgVoH1zwyzHaS
X-Google-Smtp-Source: AMrXdXs03+cZwibGvAcc8PnTmHt77QpyVzMcyewCNGLbdgiZqPydpwSmgv6COME+WfEsoYua2LUXfg==
X-Received: by 2002:a17:90b:2690:b0:227:21f5:8295 with SMTP id pl16-20020a17090b269000b0022721f58295mr25683128pjb.47.1674491693674;
        Mon, 23 Jan 2023 08:34:53 -0800 (PST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com. [209.85.214.179])
        by smtp.gmail.com with ESMTPSA id q61-20020a17090a4fc300b0022bbbba9801sm5329147pjh.37.2023.01.23.08.34.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:34:52 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id jl3so11931626plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:34:52 -0800 (PST)
X-Received: by 2002:a17:90a:1:b0:225:cb85:673d with SMTP id
 1-20020a17090a000100b00225cb85673dmr2499659pja.184.1674491691901; Mon, 23 Jan
 2023 08:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20230121134812.16637-1-mario.limonciello@amd.com>
 <20230121134812.16637-3-mario.limonciello@amd.com> <CAMRc=Meeiix1BuPi81Ad08yePvd7U5S-AVNwU+vYUHv2VcDiEQ@mail.gmail.com>
 <CAHQZ30Dgs=ScuQ2MkNkuHyZNC1wwaBDkMhcvh9dt3oAppTKBbw@mail.gmail.com> <MN0PR12MB61017872AB3769624CE2A49CE2C89@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB61017872AB3769624CE2A49CE2C89@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 23 Jan 2023 09:34:40 -0700
X-Gmail-Original-Message-ID: <CAHQZ30DPW6xERd80R=5DFhykvkyOHQfG1=om8CfWNsHeigHu9g@mail.gmail.com>
Message-ID: <CAHQZ30DPW6xERd80R=5DFhykvkyOHQfG1=om8CfWNsHeigHu9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Smythe <ncsmythe@scruboak.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Hasemeyer <markhas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 9:07 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Raul Rangel <rrangel@chromium.org>
> > Sent: Monday, January 23, 2023 09:55
> > To: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg
> > <mika.westerberg@linux.intel.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Linus Walleij
> > <linus.walleij@linaro.org>; Dmitry Torokhov <dmitry.torokhov@gmail.com>;
> > Benjamin Tissoires <benjamin.tissoires@redhat.com>; Wolfram Sang
> > <wsa@kernel.org>; Rafael J. Wysocki <rafael.j.wysocki@intel.com>; Nathan
> > Smythe <ncsmythe@scruboak.org>; linux-gpio@vger.kernel.org; linux-
> > acpi@vger.kernel.org; linux-kernel@vger.kernel.org; Mark Hasemeyer
> > <markhas@chromium.org>
> > Subject: Re: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
> >
> > On Mon, Jan 23, 2023 at 8:03 AM Bartosz Golaszewski <brgl@bgdev.pl>
> > wrote:
> > >
> > > On Sat, Jan 21, 2023 at 2:48 PM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > > >
> > > > commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> > > > adjusted the policy to enable wakeup by default if the ACPI tables
> > > > indicated that a device was wake capable.
> > > >
> > > > It was reported however that this broke suspend on at least two
> > System76
> > > > systems in S3 mode and two Lenovo Gen2a systems, but only with S3.
> > > > When the machines are set to s2idle, wakeup behaves properly.
> > > >
> > > > Configuring the GPIOs for wakeup with S3 doesn't work properly, so only
> > > > set it when the system supports low power idle.
> > > >
> > > > Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> > > > Fixes: b38f2d5d9615c ("i2c: acpi: Use ACPI wake capability bit to set
> > wake_irq")
> > > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2357
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2162013
> > > > Reported-by: Nathan Smythe <ncsmythe@scruboak.org>
> > > > Tested-by: Nathan Smythe <ncsmythe@scruboak.org>
> > > > Suggested-by: Raul Rangel <rrangel@chromium.org>
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > ---
> > > >  drivers/gpio/gpiolib-acpi.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > > > index 9ef0f5641b521..17c53f484280f 100644
> > > > --- a/drivers/gpio/gpiolib-acpi.c
> > > > +++ b/drivers/gpio/gpiolib-acpi.c
> > > > @@ -1104,7 +1104,8 @@ int acpi_dev_gpio_irq_wake_get_by(struct
> > acpi_device *adev, const char *name, in
> > > >                                 dev_dbg(&adev->dev, "IRQ %d already in use\n", irq);
> > > >                         }
> > > >
> > > > -                       if (wake_capable)
> > > > +                       /* avoid suspend issues with GPIOs when systems are using
> > S3 */
> > > > +                       if (wake_capable && acpi_gbl_FADT.flags &
> > ACPI_FADT_LOW_POWER_S0)
> > > >                                 *wake_capable = info.wake_capable;
> > > >
> > > >                         return irq;
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > Applied, thanks!
> > >
> > > Bart
> >
> >
> > We still need to figure out a proper fix for this. If you read my post
> > here: https://gitlab.freedesktop.org/drm/amd/-/issues/2357#note_1732372
> > I think we misinterpreted what the SharedAndWake bit is used for. To
> > me it sounds like it's only valid for HW Reduced ACPI platforms, and
> > S0ix. My changes made it so we call `dev_pm_set_wake_irq` when the
> > Wake bit is set. Does anyone have any additional context on the Wake
> > bit? I think we either need to make `dev_pm_set_wake_irq` (or a
> > variant) only enable the wake on S0i3, or we can teach the ACPI
> > subsystem to manage arming the IRQ's wake bit. Kind of like we already
> > manage the GPE events for the device.
>
> There is an FADT flag for HW reduced (ACPI_FADT_HW_REDUCED).  So
> maybe something on top of my change to look at that too?
>
> IE:
> if (wake_capable && (acpi_gbl_FADT.flags & (ACPI_FADT_LOW_POWER_S0 | ACPI_FADT_HW_REDUCED)

The problem with the ACPI_FADT_LOW_POWER_S0 FADT flag is that it
defines if S0ix is supported. That's not mutually exclusive with S3.
So we really need a runtime check to see which suspend mode we are
entering.
