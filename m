Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D328F6472B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiLHPUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLHPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:20:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67124EC33;
        Thu,  8 Dec 2022 07:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 711D461D99;
        Thu,  8 Dec 2022 15:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157C0C433D6;
        Thu,  8 Dec 2022 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512698;
        bh=vq2JZdIXZxuzPq+eKkO04EmYL/odF/HNbaofJ5z9G2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVf0bTIYvtDM0bsdxnvONKoMRSeFoGN6XdiMz27/UrRQKp1iNphnns0UyF4DHDMGS
         xU2iNaFwKFlM5liiIGJB/nfPIS8cM1m0U7e6EwikNZTHnylSkYpxcF1r3ASHtSWLPm
         xVZ+XLXAiI4YJllOoBO4grwI83o7F11URjkICTrbMbKZ1jbNejihF9yNgMXtf1L44i
         AI166+m02CiT2+rX8TEOfPBdSIc4CPI6EbUPt6ayhKnruZH/mY3tX8AN2z/x+W4Woq
         xvjaARq7BxrapWpWqJZpiKaTT2EzJHdKznSGe5mGjQlkiK3WoFdMK0DMssfr8FzuWp
         Hd5uhmqB9l4FA==
Date:   Thu, 8 Dec 2022 15:17:28 +0000
From:   Lee Jones <lee@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] leds: add driver for SPI driven WorldSemi WS2812B
 RGB LEDs
Message-ID: <Y5IACDDFH/yBoxPn@google.com>
References: <20221207040904.582585-1-gch981213@gmail.com>
 <20221207040904.582585-4-gch981213@gmail.com>
 <Y5By0YeGVlS5TlO3@google.com>
 <CAJsYDV+PBvEBWp=2LLbLkiNqQ0qQgWDOyZ4-onMC9_1B0mTfww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJsYDV+PBvEBWp=2LLbLkiNqQ0qQgWDOyZ4-onMC9_1B0mTfww@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2022, Chuanhong Guo wrote:

> Hi!
> 
> On Wed, Dec 7, 2022 at 7:02 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Wed, 07 Dec 2022, Chuanhong Guo wrote:
> >
> > > This patch adds support for driving a chain of WS2812B LED chips
> > > using SPI bus.
> > >
> > > WorldSemi WS2812B is a individually addressable LED chip that
> > > can be chained together and controlled individually using a
> > > single wire. The chip recognize a long pulse as a bit of 1 and
> > > a short pulse as a bit of 0. Host sends a continuous stream
> > > of 24-bits color values, each LED chip takes the first 3 byte
> > > it receives as its color value and passes the leftover bytes to
> > > the next LED on the chain.
> > >
> > > This driver simulates this protocol using SPI bus by sending
> > > a long pulse as 3'b110 and a short pulse as 3'b100. The SPI
> > > frequency needs to be 2.105MHz~2.85MHz for the timing to be
> > > correct and the controller needs to transfer all the bytes
> > > continuously.
> > >
> > > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > > ---
> > > Changes since v1:
> > > rename the driver to drop -spi suffix
> > > add support for default-brightness
> > > use fwnode apis for properties
> > >
> > > Changes since v2:
> > > drop default-brightness and default-intensity
> > >
> > >  drivers/leds/rgb/Kconfig        |  11 ++
> > >  drivers/leds/rgb/Makefile       |   1 +
> > >  drivers/leds/rgb/leds-ws2812b.c | 219 ++++++++++++++++++++++++++++++++
> > >  3 files changed, 231 insertions(+)
> > >  create mode 100644 drivers/leds/rgb/leds-ws2812b.c
> > >
> > > diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> > > index 204cf470beae..5c2081852f01 100644
> > > --- a/drivers/leds/rgb/Kconfig
> > > +++ b/drivers/leds/rgb/Kconfig
> > > @@ -26,4 +26,15 @@ config LEDS_QCOM_LPG
> > >
> > >         If compiled as a module, the module will be named leds-qcom-lpg.
> > >
> > > +config LEDS_WS2812B
> > > +     tristate "SPI driven WS2812B RGB LED support"
> > > +     depends on OF
> > > +     depends on SPI
> > > +     help
> > > +       This option enables support for driving daisy-chained WS2812B RGB
> > > +       LED chips using SPI bus. This driver simulates the single-wire
> > > +       protocol by sending bits over the SPI MOSI pin. For this to work,
> > > +       the SPI frequency should be 2.105MHz~2.85MHz and the controller
> > > +       needs to transfer all the bytes continuously.
> > > +
> > >  endif # LEDS_CLASS_MULTICOLOR
> > > diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
> > > index 0675bc0f6e18..a6f855eaeb14 100644
> > > --- a/drivers/leds/rgb/Makefile
> > > +++ b/drivers/leds/rgb/Makefile
> > > @@ -2,3 +2,4 @@
> > >
> > >  obj-$(CONFIG_LEDS_PWM_MULTICOLOR)    += leds-pwm-multicolor.o
> > >  obj-$(CONFIG_LEDS_QCOM_LPG)          += leds-qcom-lpg.o
> > > +obj-$(CONFIG_LEDS_WS2812B)           += leds-ws2812b.o
> > > diff --git a/drivers/leds/rgb/leds-ws2812b.c b/drivers/leds/rgb/leds-ws2812b.c
> > > new file mode 100644
> > > index 000000000000..68c80beb304c
> > > --- /dev/null
> > > +++ b/drivers/leds/rgb/leds-ws2812b.c
> > > @@ -0,0 +1,219 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * WorldSemi WS2812B individually-addressable LED driver using SPI
> > > + *
> > > + * Copyright 2022 Chuanhong Guo <gch981213@gmail.com>
> > > + *
> > > + * This driver simulates WS2812B protocol using SPI MOSI pin. A one pulse
> > > + * is transferred as 3'b110 and a zero pulse is 3'b100. For this driver to
> > > + * work properly, the SPI frequency should be 2.105MHz~2.85MHz and it needs
> > > + * to transfer all the bytes continuously.
> > > + */
> > > +
> > > +#include <linux/led-class-multicolor.h>
> > > +#include <linux/leds.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/property.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/mutex.h>
> > > +
> > > +#define WS2812B_BYTES_PER_COLOR 3
> > > +#define WS2812B_NUM_COLORS 3
> > > +#define WS2812B_RESET_LEN 18
> > > +
> > > +struct ws2812b_led {
> > > +     struct led_classdev_mc mc_cdev;
> > > +     struct mc_subled subled[WS2812B_NUM_COLORS];
> > > +     struct ws2812b_priv *priv;
> > > +     int reg;
> >
> > Looks like you're leaking the Device Tree nomenclature into the
> > driver.  IIUC, this is not a reg(ister) value at all, but the LED
> > indices.
> 
> You are right. reg is a bit weird here. I'll go with idx instead.

idx is a terrible variable name (like 'data' or 'value').

Please use something better, like cascade (as per the datasheet).

> > How does the datasheet describe / differentiate them?
> 
> The datasheet only describes a single chip instead of
> a chain of them, so there's no specific word for this,
> it says:
> 
> After the pixel power-on reset, the DIN port receive
> data from controller, the first pixel collect initial 24bit
> data then sent to the internal data latch, the other
> data which reshaping by the internal signal reshaping
> amplification circuit sent to the next cascade pixel
> through the DO port.
> 
> Here's the datasheet:
> https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf
> 
> >
> > > +};
> > > +
> > > +struct ws2812b_priv {
> > > +     struct led_classdev ldev;
> > > +     struct spi_device *spi;
> > > +     struct mutex mutex;
> > > +     int num_leds;
> > > +     size_t data_len;
> > > +     u8 *data_buf;
> > > +     struct ws2812b_led leds[];
> > > +};
> > > +
> > > +static void ws2812b_set_byte(u8 *p, u8 val)
> > > +{
> > > +     /*
> > > +      * Every bit of data is represented using 3 bits: 3'b100 for
> > > +      * 0 and 3'b110 for 1.
> > > +      * 1 byte of data takes up 3 bytes in a SPI transfer. The higher
> > > +      * 3 bits, middle 2 bits and lower 3 bits are represented
> > > +      * with the 1st, 2nd and 3rd byte in the SPI transfer.
> > > +      * Here's the lookup table for them.
> >
> > Sometimes a little ASCII representation can help people visualise the
> > data stream / layout.
> >
> > > +      */
> > > +     const u8 h3b[] = { 0x92, 0x93, 0x9a, 0x9b, 0xd2, 0xd3, 0xda, 0xdb };
> > > +     const u8 m2b[] = { 0x49, 0x4d, 0x69, 0x6d };
> > > +     const u8 l3b[] = { 0x24, 0x26, 0x34, 0x36, 0xa4, 0xa6, 0xb4, 0xb6 };
> >
> > It's taken me a couple of minutes to parse this, which leads me to
> > believe it requires more explanation.  The blurb you've written so
> > far is good, please keep going.  What do the values in the lookup
> > table represent?  I see that brightness is passed in (should val be
> > called brightness too?).  Is the returned data the register values to
> > set that brightness, or something else?
> 
> It is used to set brightness, but it's not register values. I'm abusing
> SPI MOSI to send pulses of specific length. See the comments
> below.
> 
> >
> > Please also consider adding these comments to further the clarity:
> >
> > > +     p[0] = h3b[val >> 5];            /* 0-7 */
> > > +     p[1] = m2b[(val >> 3) & 0x3];    /* 0-3 */
> > > +     p[2] = l3b[val & 0x7];           /* 0-7 */
> > > +}
> 
> /**
> * ws2812b_set_byte - convert a byte of data to 3-byte SPI data for pulses
> * @p: pointer to the 3-byte SPI data
> * @val: 1-byte input data to be converted
> *
> * WS2812B receives a stream of bytes from DI, takes the first 3 byte as LED
> * brightness and pases the rest to the next LED through the DO pin.
> * This function assembles a single byte of data to the LED:
> * A bit is represented with a pulse of specific length. A long pulse is a 1
> * and a short pulse is a 0.
> * SPI transfers data continuously, MSB first. We can send 3'b100 to create a
> * 0 pulse and 3'b110 for a 1 pulse. In this way, a byte of data takes up 3
> * bytes in a SPI transfer:
> * 1x0 1x0 1x0 1x0 1x0 1x0 1x0 1x0
> * Let's rearrange it in 8 bits:
> * 1x01x01x 01x01x01 x01x01x0
> * The higher 3 bits, middle 2 bits and lower 3 bits are represented with the
> * 1st, 2nd and 3rd byte in the SPI transfer respectively.
> * There are only 8 combinations for 3 bits and 4 for 2 bits, so we can create
> * a lookup table for the 3 bytes. e.g. For 0x6b -> 2'b01101011:
> * Bit 7-5: 3'b011 -> 10011011 -> 0x9b
> * Bit 4-3: 2'b01 -> 01001101 -> 0x4d
> * Bit 2-0: 3'b011 -> 00110110 -> 0x36
> */

This is good, thank you.

Please change the formatting so it's a little nicer to read.

E.g. tab out the examples.

> > > +
> > > +static int ws2812b_set(struct led_classdev *cdev,
> > > +                    enum led_brightness brightness)
> > > +{
> > > +     struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> > > +     struct ws2812b_led *led =
> > > +             container_of(mc_cdev, struct ws2812b_led, mc_cdev);
> > > +     struct ws2812b_priv *priv = led->priv;
> > > +     u8 *buf = priv->data_buf + WS2812B_RESET_LEN +
> > > +               led->reg * WS2812B_NUM_COLORS * WS2812B_BYTES_PER_COLOR;
> >
> > Please add some bracketing.  This also goes for the other places you
> > have complex BODMAS type arithmetic where ordering may cause issues.
> 
> OK.
> 
> > Actually, I'm very comfortable with all of this, mostly unparsable (at
> > least quickly) pointer arithmetic happening in this driver.  We have
> > some very readable / maintainable ways of referencing registers /
> > offsets that does not involve register address hopping.  Would you
> > mind revisiting this please?  Have you considered Regmap for instance?
> 
> I couldn't figure out how regmap could make this simpler. If I create a
> regmap for the entire buffer, it just moves this whole calculation into
> reg_read callback isn't it?

Have a go at putting the logic into a MACRO.

Then you can swap out all of the repeated pointer arithmetic.

> BTW the WS2812B_RESET_LEN is for a continuous 0 of more
> than 50us. This indicates the start of a byte stream.

[...]

> > > +
> > > +     for (i = 0; i < num_leds * WS2812B_NUM_COLORS; i++)
> > > +             ws2812b_set_byte(priv->data_buf + WS2812B_RESET_LEN +
> > > +                                      i * WS2812B_BYTES_PER_COLOR,
> > > +                              0);
> >
> > At which point do you usually line-wrap?
> 
> I just write everything in one line and clang-format it :P

Probably best not to do that.  100-chars is good.

-- 
Lee Jones [李琼斯]
