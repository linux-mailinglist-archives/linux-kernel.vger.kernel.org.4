Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0140F6B0A75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjCHOG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjCHOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:06:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A76A6154;
        Wed,  8 Mar 2023 06:03:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F1BE61835;
        Wed,  8 Mar 2023 14:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA44C4339B;
        Wed,  8 Mar 2023 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678284179;
        bh=3hWMzSBp2LshUH8WZVkMXZ1L/iWYq6eMTZ5lUjo/grs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CdmFLfC6hlLq+1GYsbbKXcBliS1OW9OAzBOk9ohJbLILNteUJU9Noq9z+dJYlK4UZ
         r3qRccMzo2ZcVxH+O/cxYIaT+oI0zQWNxOqS+nY7fzTTvAB/8N4y5ipYDRKTkPduvn
         zJkMTpdZ/Ayyy7qS0YlUmFWwABIfzJLsdrsp/fGVODd/NDxI82919GmTb76tvSqQlQ
         jWUs1tHEL4XM88rEqQpZKbh/v07sqOulZ+6Fbm1kK6PQqCJn1n9zsS2DAgNtZmrr8b
         sMSwz8qDuzVIIqMEULZqIjJTr10b7eRgNQy7WiO5Pe5hzk+xAHBCfpKJukiPFjJ9AC
         yehCwZeRtErTw==
Date:   Wed, 8 Mar 2023 14:02:52 +0000
From:   Lee Jones <lee@kernel.org>
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     ChiaEn Wu <chiaen_wu@richtek.com>, corbet@lwn.net, pavel@ucw.cz,
        matthias.bgg@gmail.com, andriy.shevchenko@linux.intel.com,
        jacek.anaszewski@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-doc@vger.kernel.org,
        peterwu.pub@gmail.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com, Alice Chen <alice_chen@richtek.com>
Subject: Re: [PATCH v17 RESEND 1/3] leds: rgb: mt6370: Add MediaTek MT6370
 current sink type LED Indicator support
Message-ID: <20230308140252.GM9667@google.com>
References: <cover.1677150607.git.chiaen_wu@richtek.com>
 <8f139c773de274311c8ca63a47d6b207c30913e2.1677150607.git.chiaen_wu@richtek.com>
 <20230305085533.GC2574592@google.com>
 <20230307022302.GA4930@linuxcarl2.richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307022302.GA4930@linuxcarl2.richtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023, ChiYuan Huang wrote:

> Hi, Lee:
>
> Thanks's for the reviewing.
> To prevent the misunderstanding, reply as below.
> No reply means will do.
>
> On Sun, Mar 05, 2023 at 08:55:33AM +0000, Lee Jones wrote:
> > On Thu, 23 Feb 2023, ChiaEn Wu wrote:
> >
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > The MediaTek MT6370 is a highly-integrated smart power management IC,
> > > which includes a single cell Li-Ion/Li-Polymer switching battery
> > > charger, a USB Type-C & Power Delivery (PD) controller, dual
> > > Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> > > a display bias driver and a general LDO for portable devices.
> > >
> > > Add support for the MediaTek MT6370 Current Sink Type LED Indicator
> > > driver. It can control four channels current-sink RGB LEDs with 3 modes:
> > > constant current, PWM, and breath mode.
> > >
> > > Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > > Co-developed-by: Alice Chen <alice_chen@richtek.com>
> > > Signed-off-by: Alice Chen <alice_chen@richtek.com>
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > > ---
> > > v17
> > > - Update the year of Copyright from 2022 to 2023
> > >
> > > ---
> > >  drivers/leds/rgb/Kconfig           |   13 +
> > >  drivers/leds/rgb/Makefile          |    1 +
> > >  drivers/leds/rgb/leds-mt6370-rgb.c | 1009 ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 1023 insertions(+)
> > >  create mode 100644 drivers/leds/rgb/leds-mt6370-rgb.c

[...]

> > > +static int mt6370_gen_breath_pattern(struct mt6370_priv *priv,
> > > +				     struct led_pattern *pattern, u32 len,
> > > +				     u8 *pattern_val, u32 val_len)
> > > +{
> > > +	enum mt6370_led_ranges sel_range;
> > > +	struct led_pattern *curr;
> > > +	unsigned int sel;
> > > +	u32 val = 0;
> > > +	int i;
> > > +
> > > +	if (len < P_MAX_PATTERNS && val_len < P_MAX_PATTERNS / 2)
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * Pattern list
> > > +	 * tr1:	 byte 0, b'[7: 4]
> >
> > Perhaps this is standard formatting and I'm just not aware of it, but
> > the space is throwing me and making me think twice.  Does this mean bits
> > 7 through 4, so b'11110000?
> >
> Yes. like as you said. Sorry for the redudant space make you confused.
> I'm not sure whether it's a standard formating or not.
> Sometimes, in datasheet, we'll use this format to represent the bitfield for functions.
> Your format is also good for it.
> And which one is preferable?

Since neither of us are sure, just take the space out for now please.

> > > +	 * tr2:	 byte 0, b'[3: 0]
> > > +	 * tf1:	 byte 1, b'[7: 4]
> > > +	 * tf2:	 byte 1, b'[3: 0]
> > > +	 * ton:	 byte 2, b'[7: 4]
> > > +	 * toff: byte 2, b'[3: 0]
> > > +	 */
> > > +	for (i = 0; i < P_MAX_PATTERNS; i++) {
> > > +		curr = pattern + i;
> > > +
> > > +		sel_range = i == P_LED_TOFF ? R_LED_TOFF : R_LED_TRFON;
> > > +
> > > +		linear_range_get_selector_within(priv->ranges + sel_range,
> > > +						 curr->delta_t, &sel);
> > > +
> > > +		if (i % 2) {
> > > +			val |= sel;
> > > +		} else {
> > > +			val <<= 8;
> > > +			val |= sel << 4;
> > > +		}
> > > +	}

[...]

> > > +static int mt6370_led_register(struct device *dev, struct mt6370_led *led,
> > > +			       struct led_init_data *init_data)
> > > +{
> > > +	struct mt6370_priv *priv = led->priv;
> > > +	int ret;
> > > +
> > > +	if (led->index == MT6370_VIRTUAL_MULTICOLOR) {
> >
> > This too could be split into separate functions to tidy things up a
> > little.
> >
> Like as below?
>
> if (led->index == MT6370_VIRTUAL_MULTICOLOR)
>    return mt6370_multicolor_led_register(....)
>
> if (led->index == MT6370_LED_ISNK4) {
>     .....
> }
>
> ret = mt6370_init_isnk_default_state(...)

Yes, that kind of thing.

> Since the multilor case directly return from the sub-function, else can be removed.

> > > +		ret = mt6370_mc_brightness_set(&led->mc.led_cdev, 0);
> > > +		if (ret)
> > > +			return dev_err_probe(dev, ret, "Couldn't set multicolor brightness\n");
> > > +
> > > +		ret = devm_led_classdev_multicolor_register_ext(dev, &led->mc,
> > > +								init_data);
> > > +		if (ret)
> > > +			return dev_err_probe(dev, ret, "Couldn't register multicolor\n");
> > > +	} else {
> > > +		if (led->index == MT6370_LED_ISNK4) {
> > > +			ret = regmap_field_write(priv->fields[F_CHGIND_EN], 1);
> > > +			if (ret)
> > > +				return dev_err_probe(dev, ret, "Failed to set CHRIND to SW\n");
> > > +		}
> > > +
> > > +		ret = mt6370_isnk_init_default_state(led);
> > > +		if (ret)
> > > +			return dev_err_probe(dev, ret, "Failed to init %d isnk state\n",
> > > +					     led->index);
> > > +
> > > +		ret = devm_led_classdev_register_ext(dev, &led->isink,
> > > +						     init_data);
> > > +		if (ret)
> > > +			return dev_err_probe(dev, ret, "Couldn't register isink %d\n", led->index);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int mt6370_check_vendor_info(struct mt6370_priv *priv)
> > > +{
> > > +	unsigned int devinfo, vid;
> > > +	int ret;
> > > +
> > > +	ret = regmap_read(priv->regmap, MT6370_REG_DEV_INFO, &devinfo);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	vid = FIELD_GET(MT6370_VENID_MASK, devinfo);
> > > +	if (vid == 0x9 || vid == 0xb) {
> >
> > Are there nice human readable associates of these (vendor?) IDS?
> >
> For clearly understanding, I'll define these two as 'MT6372_VENDOR_ID' and 'MT6372C_VENDOR_ID'.

Much better, thank you.

--
Lee Jones [李琼斯]
