Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCECA68E25C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBGU5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGU5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:57:40 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8A611647;
        Tue,  7 Feb 2023 12:57:39 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id g8so18308502qtq.13;
        Tue, 07 Feb 2023 12:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stAVsaUhrI2VyH6NyKcHcY+/3Po2YLTE8rKYRoMV1wU=;
        b=MePtt6+340djBSmSXVbEwH8kcQj2EMJ7pSDDPQEkpqlK3vU+Q0FWFrH3X3f5NXjBlx
         jtt9Y72cVYlqYszdp/249KyuYBr0c+piB1JsfvtFYGzqIHfZQvnqiPv5KXtRH3M6un25
         K1/yAXwcAsjTjLRtQJhiEqEMZXE3xmVFJi0YT9rPqimepZpnGh1nv8anCis2mD6s15Ro
         Ixg+DzOJEBrOR4/mpUZkPPc0DgjIdJRnVJhfcArWThd5fuYWvZnHy3Rh+DV2uOm0lcxL
         X8euQBQrqEP6LjJu82zGlXhe9+3+RnIHLapwjpDVcBhK0pZOsR3muQh0I64DropLmiyH
         fjcg==
X-Gm-Message-State: AO0yUKUrCchewnewM5Ui/Pd/Zii5MBdwkrWeF62x23S2AZTDzM9f29f5
        NMhJoFx2OtKyDnyD92BuBYVXtBJqUN+7Lg==
X-Google-Smtp-Source: AK7set/yK96fHKzvj7tLcWyuEI7gC7UCj2Zz/Z5Ct5CxUemLKhS5GWRug8fn4PlDtilF+GkfFPycXA==
X-Received: by 2002:a05:622a:1489:b0:3ba:110a:bc6e with SMTP id t9-20020a05622a148900b003ba110abc6emr7754473qtx.33.1675803458307;
        Tue, 07 Feb 2023 12:57:38 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id t189-20020a372dc6000000b0072771acaf09sm10220897qkh.126.2023.02.07.12.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 12:57:37 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-52a849206adso65540517b3.4;
        Tue, 07 Feb 2023 12:57:37 -0800 (PST)
X-Received: by 2002:a25:928e:0:b0:8a0:2a4:a96c with SMTP id
 y14-20020a25928e000000b008a002a4a96cmr477401ybl.380.1675803446414; Tue, 07
 Feb 2023 12:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com> <20230207014207.1678715-10-saravanak@google.com>
In-Reply-To: <20230207014207.1678715-10-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Feb 2023 21:57:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com>
Message-ID: <CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com>
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

On Tue, Feb 7, 2023 at 2:42 AM Saravana Kannan <saravanak@google.com> wrote:
> The driver core now:
> - Has the parent device of a supplier pick up the consumers if the
>   supplier never has a device created for it.
> - Ignores a supplier if the supplier has no parent device and will never
>   be probed by a driver
>
> And already prevents creating a device link with the consumer as a
> supplier of a parent.
>
> So, we no longer need to find the "compatible" node of the supplier or
> do any other checks in of_link_to_phandle(). We simply need to make sure
> that the supplier is available in DT.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks for your patch!

This patch introduces a regression when dynamically loading DT overlays.
Unfortunately this happens when using the out-of-tree OF configfs,
which is not supported upstream.  Still, there may be (obscure)
in-tree users.

When loading a DT overlay[1] to enable an SPI controller, and
instantiate a connected SPI EEPROM:

    $ overlay add 25lc040
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /keys/status
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/pinctrl-0
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/pinctrl-names
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/cs-gpios
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/status
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /__symbols__/msiof0_pins

The SPI controller and the SPI EEPROM are no longer instantiated.

    # cat /sys/kernel/debug/devices_deferred
    e6e90000.spi    platform: wait for supplier msiof0

Let's remove the overlay again:

    $ overlay rm 25lc040
    input: keys as /devices/platform/keys/input/input1

And retry:

    $ overlay add 25lc040
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /keys/status
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/pinctrl-0
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/pinctrl-names
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/cs-gpios
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/status
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /__symbols__/msiof0_pins
    spi_sh_msiof e6e90000.spi: DMA available
    spi_sh_msiof e6e90000.spi: registered master spi0
    spi spi0.0: setup mode 0, 8 bits/w, 100000 Hz max --> 0
    at25 spi0.0: 512 Byte at25 eeprom, pagesize 16
    spi_sh_msiof e6e90000.spi: registered child spi0.0

Now it succeeds, and the SPI EEPROM is available, and works.

Without this patch, or with this patch reverted after applying the
full series:

    $ overlay add 25lc040
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /keys/status
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/pinctrl-0
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/pinctrl-names
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/cs-gpios
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /soc/spi@e6e90000/status
    OF: overlay: WARNING: memory leak will occur if overlay removed,
property: /__symbols__/msiof0_pins
    OF: Not linking spi@e6e90000 to interrupt-controller@f1010000 - No
struct device
    spi_sh_msiof e6e90000.spi: DMA available
    spi_sh_msiof e6e90000.spi: registered master spi0
    spi spi0.0: setup mode 0, 8 bits/w, 100000 Hz max --> 0
    at25 spi0.0: 444 bps (2 bytes in 9 ticks)
    at25 spi0.0: 512 Byte at25 eeprom, pagesize 16
    spi_sh_msiof e6e90000.spi: registered child spi0.0

The SPI EEPROM is available on the first try after boot.

All output is with #define DEBUG in drivers/of/property.c, and with
CONFIG_SPI_DEBUG=y.

Note that your patch has no impact on drivers/of/unittest.c, as that
checks only internal DT structures, not actual device instantiation.

Thanks! ;-)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/diff/arch/arm64/boot/dts/renesas/r8a77990-ebisu-cn41-msiof0-25lc040.dtso?h=topic/renesas-overlays&id=86d0cf6fa7f191145380485c22f684873c5cce26

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
