Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8553A6946A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjBMNLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBMNLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:11:06 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F219004;
        Mon, 13 Feb 2023 05:11:05 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id z5so13549430qtn.8;
        Mon, 13 Feb 2023 05:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOjXov1or4GUk5t/1BfIn2Aw9t7YTPkMeOlCti1wBS4=;
        b=IApdMvnNwNmvWBEFqEgvk59/lcc3KqK+I9wcULZv7DLzARLAl4i+xo3gey9qEFMHmz
         0QMRVovo2cdgUwG2G0k7G33SJjY43FXjD8WWSyqxfH/jeL6t7jrvRuIzoN5OU34gaRwb
         X/Gwu0NFORoHylDqMxD/RxzHGNrutR2nOCvEyhh+tRrUhOFlThaCkv+tv0sOeOBV3QwI
         9w6bm4lkER4CR0eeg8UDWBA6FqbXqkl0pFF9jgzgsfXEzaO0uNsmLB9+APd2+Vxf5pAH
         1yGqr9gJT/L1kECA0FgXrSRaNuU7zWfGEHuDSZNMo8MYR6yPm6LA72AKj7AtQjmr/Vdp
         JTCw==
X-Gm-Message-State: AO0yUKVDe8H5GTpMubR0FtP6rap4HWINxky1vViafGzClpMclhx6Irsx
        ivR0yL0EMkzmMnKYFjhxWsJKu2JK1ePEhw==
X-Google-Smtp-Source: AK7set9gGBXGqScJxmM0zjTXzV9AMpVNHaxo68Yj4pV4mRzlqOdC5MZzEw5SYhQtIVGAUkbduQFX3g==
X-Received: by 2002:a05:622a:449:b0:3ab:a047:58ee with SMTP id o9-20020a05622a044900b003aba04758eemr44818570qtx.25.1676293863827;
        Mon, 13 Feb 2023 05:11:03 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id a20-20020ac81094000000b003b9ba2cf068sm9223522qtj.56.2023.02.13.05.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 05:11:03 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-51ba4b1b9feso161837967b3.11;
        Mon, 13 Feb 2023 05:11:03 -0800 (PST)
X-Received: by 2002:a25:8f82:0:b0:86e:1225:b335 with SMTP id
 u2-20020a258f82000000b0086e1225b335mr3102546ybl.455.1676293852226; Mon, 13
 Feb 2023 05:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
 <20230207014207.1678715-10-saravanak@google.com> <CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com>
 <CAGETcx8DaZqS7+47PhX4hQOfSk7AzPcTu=2i+4gAgXr6wyDNgg@mail.gmail.com>
 <CAGETcx_bkuFaLCiPrAWCPQz+w79ccDp6=9e881qmK=vx3hBMyg@mail.gmail.com>
 <CAMuHMdVREiVoGp-jvXKAdPSwjio13VgtPXWppnGOB+gSS9op+g@mail.gmail.com> <CAGETcx_+rhHvaC_HJXGrr5_WAd2+k5f=rWYnkCZ6z5bGX-wj4w@mail.gmail.com>
In-Reply-To: <CAGETcx_+rhHvaC_HJXGrr5_WAd2+k5f=rWYnkCZ6z5bGX-wj4w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Feb 2023 14:10:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUK92+rNdyEGTgK=Aok1dYjHBRLnxokaz50s+MbNW_noA@mail.gmail.com>
Message-ID: <CAMuHMdUK92+rNdyEGTgK=Aok1dYjHBRLnxokaz50s+MbNW_noA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Wed, Feb 8, 2023 at 9:35 AM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Feb 7, 2023 at 11:57 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Feb 8, 2023 at 8:32 AM Saravana Kannan <saravanak@google.com> wrote:
> > > On Tue, Feb 7, 2023 at 6:08 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > On Tue, Feb 7, 2023 at 12:57 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Tue, Feb 7, 2023 at 2:42 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > The driver core now:
> > > > > > - Has the parent device of a supplier pick up the consumers if the
> > > > > >   supplier never has a device created for it.
> > > > > > - Ignores a supplier if the supplier has no parent device and will never
> > > > > >   be probed by a driver
> > > > > >
> > > > > > And already prevents creating a device link with the consumer as a
> > > > > > supplier of a parent.
> > > > > >
> > > > > > So, we no longer need to find the "compatible" node of the supplier or
> > > > > > do any other checks in of_link_to_phandle(). We simply need to make sure
> > > > > > that the supplier is available in DT.
> > > > > >
> > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > This patch introduces a regression when dynamically loading DT overlays.
> > > > > Unfortunately this happens when using the out-of-tree OF configfs,
> > > > > which is not supported upstream.  Still, there may be (obscure)
> > > > > in-tree users.
> > > > >
> > > > > When loading a DT overlay[1] to enable an SPI controller, and
> > > > > instantiate a connected SPI EEPROM:
> >
> > [...]
> >
> > > > > The SPI controller and the SPI EEPROM are no longer instantiated.
> >
> > > > Sigh... I spent way too long trying to figure out if I caused a memory
> > > > leak. I should have scrolled down further! Doesn't look like that part
> > > > is related to anything I did.
> > > >
> > > > There are some flags set to avoid re-parsing fwnodes multiple times.
> > > > My guess is that the issue you are seeing has to do with how many of
> > > > the in memory structs are reused vs not when an overlay is
> > > > applied/removed and some of these flags might not be getting cleared
> > > > and this is having a bigger impact with this patch (because the fwnode
> > > > links are no longer anchored on "compatible" nodes).
> > > >
> > > > With/without this patch (let's keep the series) can you look at how
> > > > the following things change between each step you do above (add,
> > > > remove, retry):
> > > > 1) List of directories under /sys/class/devlink
> > > > 2) Enable the debug logs inside __fwnode_link_add(),
> > > > __fwnode_link_del(), device_link_add()
> > > >
> > > > My guess is that the final solution would entail clearing
> > > > FWNODE_FLAG_LINKS_ADDED for some fwnodes.
> > >
> > > You replied just as I was about to hit send. So sending this anyway...
> > >
> > > Ok, I took a closer look and I think it's a bit of a mess. The fact
> > > that it even worked for you without this patch is a bit of a
> > > coincidence.
> > >
> > > Let's just take platform devices that are created by
> > > driver/of/platform.c as an example.
> > >
> > > The main problem is that when you add/remove properties to a DT node
> > > of an existing platform device, nothing is really done about it at the
> > > device level. We don't even unbind and rebind the driver so the driver
> > > could make use of the new properties. We don't remove and add back the
> > > device so whoever might use the new property will use it. And if you
> > > are adding a new node, it'll only trigger any platform device level
> > > impact if it's a new node of a "simple-bus" (or similar bus) device.
> > >
> > > Problem 1:
> > > So if you add a new child node to an existing probed device that adds
> > > its children explicitly (as in, the parent is not a "simple-bus" like
> > > device), nothing will happen. The newly added child device node will
> > > get converted into a platform device, not will the parent device
> > > notice it. So in your case of adding msiof0_pins, it's just that when
> > > the consumer gets the pins, the driver doesn't get involved much and
> > > it's the pinctrl framework that reads the DT and figures it out.
> > >
> > > With this patch, the fwnode links point to the actual resource and the
> > > actual parent device inherits them if they don't get converted to a
> > > struct device. But since we are adding this msiof0_pins after the
> > > parent device has probed, the fwnode link isn't inherited by the
> > > parent pinctrl device.
> > >
> > > Problem 2:
> > > So if you add a property to an already bound device, nothing is done
> > > by the driver. In your overlay example, if you move the status="okay"
> > > line to be the first property you change in the msiof0 spi device,
> > > you'll probably see that fw_devlink is no longer the one blocking the
> > > probe. This is because the platform device will get added as soon as
> > > the status flips from disabled to enabled and at that point fw_devlink
> > > will think it has no suppliers and won't do any probe deferring. And
> > > then as the new properties get added nothing will happen at the device
> > > or fw_devlink level. If the msiof0's spi driver fails immediately with
> > > NOT -EPROBE_DEFER when platform device is added because it couldn't
> > > find any pinctrl property, then msiof0 will never probe (unless you
> > > remove and add the driver). If it had failed with -EPROBE_DEFER, then
> > > it might probe again if something else triggers a deferred probe
> > > attempt. Clearly, things working/not working based on the order of
> > > properties in DT is not a good implementation.
> > >
> > > Problem 3:
> > > What if you enable a previously disabled supplier. There's no way to
> > > handle that from a fw_devlink level without re-parsing the entire
> > > device tree because existing devices might be consumers now.
> > >
> > > Anyway, long story short, it's sorta worked due to coincidence and
> > > it's quite messy to get it to work correctly.
> >
> > Several subsystems register notifiers to be informed of the events
> > above. E.g. drivers/spi/spi.c:
> >
> >         if (IS_ENABLED(CONFIG_OF_DYNAMIC))
> >                 WARN_ON(of_reconfig_notifier_register(&spi_of_notifier));
> >         if (IS_ENABLED(CONFIG_ACPI))
> >                 WARN_ON(acpi_reconfig_notifier_register(&spi_acpi_notifier));
> >
> > So my issue might be triggered using ACPI, too.
>
> Yeah, I did notice this before my email. Here's an ugly hack (at end
> of email) to test my theory about Problem 1. I didn't compile test it
> (because I should go to bed now), but you get the idea. Can you give
> this a shot? It should fix your specific case. Basically for all
> overlays (I hope the function is only used for overlays) we assume all
> nodes are NOT devices until they actually get added as a device. Don't
> review the code, it's not meant to be :)
>
> -Saravana
>
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -226,6 +226,7 @@ static void __of_attach_node(struct device_node *np)
>         np->sibling = np->parent->child;
>         np->parent->child = np;
>         of_node_clear_flag(np, OF_DETACHED);
> +       np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
>  }
>
>  /**
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 81c8c227ab6b..7299cd668e51 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -732,6 +732,7 @@ static int of_platform_notify(struct notifier_block *nb,
>                 if (of_node_check_flag(rd->dn, OF_POPULATED))
>                         return NOTIFY_OK;
>
> +               rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>                 /* pdev_parent may be NULL when no bus platform device */
>                 pdev_parent = of_find_device_by_node(rd->dn->parent);
>                 pdev = of_platform_device_create(rd->dn, NULL,
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 15f174f4e056..1de55561b25d 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4436,6 +4436,7 @@ static int of_spi_notify(struct notifier_block
> *nb, unsigned long action,
>                         return NOTIFY_OK;
>                 }
>
> +               rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>                 spi = of_register_spi_device(ctlr, rd->dn);
>                 put_device(&ctlr->dev);

Thanks, these changes fix my SPI EEPROM in a DT overlay.
A similar change should be applied to the i2c bus core (and to other
users of of_reconfig_notifier_register()?).

For reference, the same debug output and /sys/class/devlink
changes with this fix applied can be found below.

Note that there are still a few remaining issues, for which I do not
know the full impact:
  - platform:e6060000.pinctrl--platform:keys link is not recreated
     on overlay remove,
  - There is no change in /sys/class/devlink after an add/remove/add
    cycle.
Shouldn't removing a DT overlay restore  /sys/class/devlink to
the exact same state as before adding the DT overlay?

With extra FWNODE_FLAG_NOT_DEVICE handling:

  - Adding overlay:

        spi@e6e90000 Linked as a fwnode consumer to
interrupt-controller@f1010000
        spi@e6e90000 Linked as a fwnode consumer to clock-controller@e6150000
        spi@e6e90000 Linked as a fwnode consumer to system-controller@e6180000
        spi@e6e90000 Linked as a fwnode consumer to msiof0
        spi@e6e90000 Linked as a fwnode consumer to gpio@e6055000
        platform e6e90000.spi: Linked as a consumer to e6055000.gpio
        spi@e6e90000 Dropping the fwnode link to gpio@e6055000
        platform e6e90000.spi: Linked as a consumer to e6060000.pinctrl
        spi@e6e90000 Dropping the fwnode link to msiof0
        spi@e6e90000 Dropping the fwnode link to system-controller@e6180000
        platform e6e90000.spi: Linked as a consumer to e6150000.clock-controller
        spi@e6e90000 Dropping the fwnode link to clock-controller@e6150000
        platform e6e90000.spi: Linked as a consumer to soc
        spi@e6e90000 Dropping the fwnode link to interrupt-controller@f1010000

        +platform:e6055000.gpio--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6055000.gpio--platform:e6e90000.spi
        +platform:e6060000.pinctrl--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6060000.pinctrl--platform:e6e90000.spi
        +platform:e6150000.clock-controller--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6150000.clock-controller--platform:e6e90000.spi
        +platform:soc--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:soc--platform:e6e90000.spi
        -platform:e6060000.pinctrl--platform:keys ->
../../devices/virtual/devlink/platform:e6060000.pinctrl--platform:keys

        SPI EEPROM works

  - Removing overlay:

        platform keys: Linked as a sync state only consumer to e6055000.gpio

        -platform:e6055000.gpio--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6055000.gpio--platform:e6e90000.spi
        -platform:e6060000.pinctrl--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6060000.pinctrl--platform:e6e90000.spi
        -platform:e6150000.clock-controller--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6150000.clock-controller--platform:e6e90000.spi
        -platform:soc--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:soc--platform:e6e90000.spi

        platform:e6060000.pinctrl--platform:keys link is not recreated?!?!?

  - Adding overlay again:

        No debug output
        No change in sys/class/devlink?!?!?
        SPI EEPROM works

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
