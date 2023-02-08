Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54668E96A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjBHH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBHH5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:57:16 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2759D1166F;
        Tue,  7 Feb 2023 23:57:10 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id e6so8796303qvp.1;
        Tue, 07 Feb 2023 23:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfN06Fr/21gttqDSQulqZGi0pmIW2PjRSxTzZoYMCB8=;
        b=JUZ7ybifd+yN4v+9noDhs1MVGyYoLfOS27uBfBDm6PNWdXTtnoB0i0JZGW+9socIQ8
         ypReKHZTZb/DzselUezojFMcBJu2EimprAt6vjCNHTxHrqLvR3mgwgrwtl47smUyZ0Oz
         xHDOIm5zW3p/Fm3+4nYuTM6L5O+TXtkzwhbqwwHUd7KRQLfelZgeGEV1ad88Ftibu6aF
         kM+VBI98v0NxQfVLkFFt/Djv55c2lAv2L4TVVZkvw8UhFCHc+mUgABBLQ2obT8SF6rhR
         sNWXEnJVEqbVfUElv6xzqyXBlYRnJtTOeiwQ9bn8N7zyH/7E59tcDg0mLnD5s4/AskPJ
         Vy3w==
X-Gm-Message-State: AO0yUKXQQEQHI3hXqNd9wsA9004aKoAOA/lu+Vtaaq1guDVJL8VLPvMW
        Xdadapjh4TAlyq8kB0SIYk8qh8ytcwWgdg==
X-Google-Smtp-Source: AK7set+4/QrsbC5huPjk0StkVYupCys6U7066g41jPpo/QnWQMJNjaWJ2d974OC2UmLWYhti675Hyg==
X-Received: by 2002:ad4:5aac:0:b0:56c:1ff0:7659 with SMTP id u12-20020ad45aac000000b0056c1ff07659mr1308097qvg.46.1675843029031;
        Tue, 07 Feb 2023 23:57:09 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id b5-20020a05620a126500b00706b09b16fasm11071553qkl.11.2023.02.07.23.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 23:57:08 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id q9so278082ybk.2;
        Tue, 07 Feb 2023 23:57:08 -0800 (PST)
X-Received: by 2002:a0d:f444:0:b0:526:78ad:bb15 with SMTP id
 d65-20020a0df444000000b0052678adbb15mr694356ywf.47.1675843017906; Tue, 07 Feb
 2023 23:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
 <20230207014207.1678715-10-saravanak@google.com> <CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com>
 <CAGETcx8DaZqS7+47PhX4hQOfSk7AzPcTu=2i+4gAgXr6wyDNgg@mail.gmail.com> <CAGETcx_bkuFaLCiPrAWCPQz+w79ccDp6=9e881qmK=vx3hBMyg@mail.gmail.com>
In-Reply-To: <CAGETcx_bkuFaLCiPrAWCPQz+w79ccDp6=9e881qmK=vx3hBMyg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Feb 2023 08:56:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVREiVoGp-jvXKAdPSwjio13VgtPXWppnGOB+gSS9op+g@mail.gmail.com>
Message-ID: <CAMuHMdVREiVoGp-jvXKAdPSwjio13VgtPXWppnGOB+gSS9op+g@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] of: property: Simplify of_link_to_phandle()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
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

Hi Saravana,

On Wed, Feb 8, 2023 at 8:32 AM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Feb 7, 2023 at 6:08 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Tue, Feb 7, 2023 at 12:57 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Feb 7, 2023 at 2:42 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > The driver core now:
> > > > - Has the parent device of a supplier pick up the consumers if the
> > > >   supplier never has a device created for it.
> > > > - Ignores a supplier if the supplier has no parent device and will never
> > > >   be probed by a driver
> > > >
> > > > And already prevents creating a device link with the consumer as a
> > > > supplier of a parent.
> > > >
> > > > So, we no longer need to find the "compatible" node of the supplier or
> > > > do any other checks in of_link_to_phandle(). We simply need to make sure
> > > > that the supplier is available in DT.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >
> > > Thanks for your patch!
> > >
> > > This patch introduces a regression when dynamically loading DT overlays.
> > > Unfortunately this happens when using the out-of-tree OF configfs,
> > > which is not supported upstream.  Still, there may be (obscure)
> > > in-tree users.
> > >
> > > When loading a DT overlay[1] to enable an SPI controller, and
> > > instantiate a connected SPI EEPROM:

[...]

> > > The SPI controller and the SPI EEPROM are no longer instantiated.

> > Sigh... I spent way too long trying to figure out if I caused a memory
> > leak. I should have scrolled down further! Doesn't look like that part
> > is related to anything I did.
> >
> > There are some flags set to avoid re-parsing fwnodes multiple times.
> > My guess is that the issue you are seeing has to do with how many of
> > the in memory structs are reused vs not when an overlay is
> > applied/removed and some of these flags might not be getting cleared
> > and this is having a bigger impact with this patch (because the fwnode
> > links are no longer anchored on "compatible" nodes).
> >
> > With/without this patch (let's keep the series) can you look at how
> > the following things change between each step you do above (add,
> > remove, retry):
> > 1) List of directories under /sys/class/devlink
> > 2) Enable the debug logs inside __fwnode_link_add(),
> > __fwnode_link_del(), device_link_add()
> >
> > My guess is that the final solution would entail clearing
> > FWNODE_FLAG_LINKS_ADDED for some fwnodes.
>
> You replied just as I was about to hit send. So sending this anyway...
>
> Ok, I took a closer look and I think it's a bit of a mess. The fact
> that it even worked for you without this patch is a bit of a
> coincidence.
>
> Let's just take platform devices that are created by
> driver/of/platform.c as an example.
>
> The main problem is that when you add/remove properties to a DT node
> of an existing platform device, nothing is really done about it at the
> device level. We don't even unbind and rebind the driver so the driver
> could make use of the new properties. We don't remove and add back the
> device so whoever might use the new property will use it. And if you
> are adding a new node, it'll only trigger any platform device level
> impact if it's a new node of a "simple-bus" (or similar bus) device.
>
> Problem 1:
> So if you add a new child node to an existing probed device that adds
> its children explicitly (as in, the parent is not a "simple-bus" like
> device), nothing will happen. The newly added child device node will
> get converted into a platform device, not will the parent device
> notice it. So in your case of adding msiof0_pins, it's just that when
> the consumer gets the pins, the driver doesn't get involved much and
> it's the pinctrl framework that reads the DT and figures it out.
>
> With this patch, the fwnode links point to the actual resource and the
> actual parent device inherits them if they don't get converted to a
> struct device. But since we are adding this msiof0_pins after the
> parent device has probed, the fwnode link isn't inherited by the
> parent pinctrl device.
>
> Problem 2:
> So if you add a property to an already bound device, nothing is done
> by the driver. In your overlay example, if you move the status="okay"
> line to be the first property you change in the msiof0 spi device,
> you'll probably see that fw_devlink is no longer the one blocking the
> probe. This is because the platform device will get added as soon as
> the status flips from disabled to enabled and at that point fw_devlink
> will think it has no suppliers and won't do any probe deferring. And
> then as the new properties get added nothing will happen at the device
> or fw_devlink level. If the msiof0's spi driver fails immediately with
> NOT -EPROBE_DEFER when platform device is added because it couldn't
> find any pinctrl property, then msiof0 will never probe (unless you
> remove and add the driver). If it had failed with -EPROBE_DEFER, then
> it might probe again if something else triggers a deferred probe
> attempt. Clearly, things working/not working based on the order of
> properties in DT is not a good implementation.
>
> Problem 3:
> What if you enable a previously disabled supplier. There's no way to
> handle that from a fw_devlink level without re-parsing the entire
> device tree because existing devices might be consumers now.
>
> Anyway, long story short, it's sorta worked due to coincidence and
> it's quite messy to get it to work correctly.

Several subsystems register notifiers to be informed of the events
above. E.g. drivers/spi/spi.c:

        if (IS_ENABLED(CONFIG_OF_DYNAMIC))
                WARN_ON(of_reconfig_notifier_register(&spi_of_notifier));
        if (IS_ENABLED(CONFIG_ACPI))
                WARN_ON(acpi_reconfig_notifier_register(&spi_acpi_notifier));

So my issue might be triggered using ACPI, too.

> Another way to get this to work is to:
> 1) unload pinctrl driver, unload spi driver.
> 2) apply overlay
> 3) reload pinctrl driver, reload spi driver.
>
> This is assuming unloading those 2 drivers doesn't crash your system.

Unloading the pinctrl driver is not an option.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
