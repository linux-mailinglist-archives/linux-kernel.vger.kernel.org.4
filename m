Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D8E68E8ED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjBHHbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHHbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:31:18 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8761A976;
        Tue,  7 Feb 2023 23:31:16 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id w3so19826726qts.7;
        Tue, 07 Feb 2023 23:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2bppoHuX82os++/Py2NRHmX1jE3ZJ52UnRWRf0XIy0=;
        b=ewVDqstYLbGPRddG4bzS/68gmKLt3MhMZZP1NLzoqle01VaP+TB4CkqY48xW+JzrJ7
         T28sdFsvHKbDx2RD1LmCcJnWbw9JkvdXZtQjhZtC5H2ILbj6QRiaHckbkhPn8oUI67+8
         /xSOOhg55fAYiJzuwLK18c+t1yrapJjpJIkQsw0HXOx9gcPW6juAD/7EBVAmbfJkiGVM
         kNKUtV+nuw9cMyZzf/KUChAMa9iFLzCGHkuzykz3YYosfvChBQBCjOTYF8dQ6za16dWC
         YwylZ2gG7wJHqM3PLgToAtHg4qlkzijw6J7Aij/M87PwpXlJOPeKp1KAtryZqndC4pjC
         09Wg==
X-Gm-Message-State: AO0yUKV6/tDkF3vT4R04BV8eV8U9DLpVLewOone2IqCmHpYz6OhPdI/g
        RbE/Iy9fqIaryYATLeN0R/grjclM7FgcAg==
X-Google-Smtp-Source: AK7set9hcIzUDkK1G3UaRBC+OshC93bQi4ys9oWbQAyGP8JxA5lLgF7hpUaTvhO+BZFlkrdD+DT5pQ==
X-Received: by 2002:a05:622a:c4:b0:3b0:2fa:8a90 with SMTP id p4-20020a05622a00c400b003b002fa8a90mr12054489qtw.8.1675841475574;
        Tue, 07 Feb 2023 23:31:15 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a12aa00b0071d57a0eb17sm10898243qki.136.2023.02.07.23.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 23:31:15 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id q9so226957ybk.2;
        Tue, 07 Feb 2023 23:31:15 -0800 (PST)
X-Received: by 2002:a0d:ca03:0:b0:506:6b5d:523c with SMTP id
 m3-20020a0dca03000000b005066b5d523cmr523838ywd.283.1675841464452; Tue, 07 Feb
 2023 23:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
 <20230207014207.1678715-10-saravanak@google.com> <CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com>
 <CAGETcx8DaZqS7+47PhX4hQOfSk7AzPcTu=2i+4gAgXr6wyDNgg@mail.gmail.com>
In-Reply-To: <CAGETcx8DaZqS7+47PhX4hQOfSk7AzPcTu=2i+4gAgXr6wyDNgg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Feb 2023 08:30:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXPosaKarsRWZpuGGD7Xam6qngsej+3iJdfWGTBDiWhLA@mail.gmail.com>
Message-ID: <CAMuHMdXPosaKarsRWZpuGGD7Xam6qngsej+3iJdfWGTBDiWhLA@mail.gmail.com>
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

On Wed, Feb 8, 2023 at 3:08 AM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Feb 7, 2023 at 12:57 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Feb 7, 2023 at 2:42 AM Saravana Kannan <saravanak@google.com> wrote:
> > > The driver core now:
> > > - Has the parent device of a supplier pick up the consumers if the
> > >   supplier never has a device created for it.
> > > - Ignores a supplier if the supplier has no parent device and will never
> > >   be probed by a driver
> > >
> > > And already prevents creating a device link with the consumer as a
> > > supplier of a parent.
> > >
> > > So, we no longer need to find the "compatible" node of the supplier or
> > > do any other checks in of_link_to_phandle(). We simply need to make sure
> > > that the supplier is available in DT.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > Thanks for your patch!
> >
> > This patch introduces a regression when dynamically loading DT overlays.
> > Unfortunately this happens when using the out-of-tree OF configfs,
> > which is not supported upstream.  Still, there may be (obscure)
> > in-tree users.
> >
> > When loading a DT overlay[1] to enable an SPI controller, and
> > instantiate a connected SPI EEPROM:
> >
> >     $ overlay add 25lc040
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /keys/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-0
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-names
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/cs-gpios
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /__symbols__/msiof0_pins
> >
> > The SPI controller and the SPI EEPROM are no longer instantiated.
> >
> >     # cat /sys/kernel/debug/devices_deferred
> >     e6e90000.spi    platform: wait for supplier msiof0
> >
> > Let's remove the overlay again:
> >
> >     $ overlay rm 25lc040
> >     input: keys as /devices/platform/keys/input/input1
> >
> > And retry:
> >
> >     $ overlay add 25lc040
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /keys/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-0
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-names
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/cs-gpios
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /__symbols__/msiof0_pins
> >     spi_sh_msiof e6e90000.spi: DMA available
> >     spi_sh_msiof e6e90000.spi: registered master spi0
> >     spi spi0.0: setup mode 0, 8 bits/w, 100000 Hz max --> 0
> >     at25 spi0.0: 512 Byte at25 eeprom, pagesize 16
> >     spi_sh_msiof e6e90000.spi: registered child spi0.0
> >
> > Now it succeeds, and the SPI EEPROM is available, and works.
> >
> > Without this patch, or with this patch reverted after applying the
> > full series:
> >
> >     $ overlay add 25lc040
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /keys/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-0
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-names
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/cs-gpios
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /__symbols__/msiof0_pins
> >     OF: Not linking spi@e6e90000 to interrupt-controller@f1010000 - No
> > struct device
> >     spi_sh_msiof e6e90000.spi: DMA available
> >     spi_sh_msiof e6e90000.spi: registered master spi0
> >     spi spi0.0: setup mode 0, 8 bits/w, 100000 Hz max --> 0
> >     at25 spi0.0: 444 bps (2 bytes in 9 ticks)
> >     at25 spi0.0: 512 Byte at25 eeprom, pagesize 16
> >     spi_sh_msiof e6e90000.spi: registered child spi0.0
> >
> > The SPI EEPROM is available on the first try after boot.
>
> Sigh... I spent way too long trying to figure out if I caused a memory
> leak. I should have scrolled down further! Doesn't look like that part
> is related to anything I did.

Please ignore the memory leak messages.  They are known issues
in the upstream DT overlay code, and not related to your series.

> There are some flags set to avoid re-parsing fwnodes multiple times.
> My guess is that the issue you are seeing has to do with how many of
> the in memory structs are reused vs not when an overlay is
> applied/removed and some of these flags might not be getting cleared
> and this is having a bigger impact with this patch (because the fwnode
> links are no longer anchored on "compatible" nodes).
>
> With/without this patch (let's keep the series) can you look at how
> the following things change between each step you do above (add,
> remove, retry):
> 1) List of directories under /sys/class/devlink
> 2) Enable the debug logs inside __fwnode_link_add(),
> __fwnode_link_del(), device_link_add()

Thanks, I'll give that a try, later...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
