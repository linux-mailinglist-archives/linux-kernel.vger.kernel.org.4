Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243E46638AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjAJFlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAJFlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:41:42 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 449623C3B7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:41:37 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(16481:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Tue, 10 Jan 2023 13:41:11 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Tue, 10 Jan
 2023 13:41:11 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Tue, 10 Jan 2023 13:41:11 +0800
Date:   Tue, 10 Jan 2023 13:41:11 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     ChiaEn Wu <peterwu.pub@gmail.com>, <pavel@ucw.cz>,
        <lee@kernel.org>, <matthias.bgg@gmail.com>,
        <chiaen_wu@richtek.com>, <linux-leds@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <szunichen@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alice Chen <alice_chen@richtek.com>
Subject: Re: [PATCH v15 RESEND 1/2] leds: rgb: mt6370: Add MediaTek MT6370
 current sink type LED Indicator support
Message-ID: <20230110054111.GA30080@linuxcarl2.richtek.com>
References: <cover.1672728620.git.chiaen_wu@richtek.com>
 <edc096c82d4aa7336e03315a22d2a59d467daf8f.1672728620.git.chiaen_wu@richtek.com>
 <Y7QjXbTvI0N0i2WX@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7QjXbTvI0N0i2WX@smile.fi.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 02:45:17PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 03, 2023 at 03:00:07PM +0800, ChiaEn Wu wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> > 
> > The MediaTek MT6370 is a highly-integrated smart power management IC,
> > which includes a single cell Li-Ion/Li-Polymer switching battery
> > charger, a USB Type-C & Power Delivery (PD) controller, dual
> > Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> > a display bias driver and a general LDO for portable devices.
> > 
> > Add support for the MediaTek MT6370 Current Sink Type LED Indicator
> > driver. It can control four channels current-sink RGB LEDs with 3 modes:
> > constant current, PWM, and breath mode.
> 
> ...
> 
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2022 Richtek Technology Corp.
> > + *
> > + * Authors:
> > + *   ChiYuan Huang <cy_huang@richtek.com>
> > + *   Alice Chen <alice_chen@richtek.com>
> 
> > + *
> 
> Redundant blank line.
> 
> > + */
> 
> ...
> 
> > +#include <asm-generic/unaligned.h>
> 
> asm/unaligned should work, no?
> 
Yes, it works, thanks.
> ...
> 
> > +struct mt6370_pdata {
> > +	const unsigned int *tfreq;
> > +	unsigned int tfreq_len;
> 
> > +	u8 pwm_duty;
> 
> You may save a few bytes by moving this to the end of the structure.
> 
> > +	u16 reg_rgb1_tr;
> > +	s16 reg_rgb_chrind_tr;
> > +};
> 
> ...
> 
> > +struct mt6370_priv {
> > +	/* Per LED access lock */
> > +	struct mutex lock;
> 
> > +	struct device *dev;
> > +	struct regmap *regmap;
> 
> Isn't one can be derived from the other?
>
No, regmap is derived by the parent dev.
But after reviewing its usage, 'dev' can be removed.
For this part, only regmap will be kept to check product info. 
> > +	struct regmap_field *fields[F_MAX_FIELDS];
> > +	const struct reg_field *reg_fields;
> > +	const struct linear_range *ranges;
> > +	struct reg_cfg *reg_cfgs;
> > +	const struct mt6370_pdata *pdata;
> > +	unsigned int leds_count;
> > +	unsigned int leds_active;
> > +	struct mt6370_led leds[];
> > +};
> 
> ...
> 
> > +static int mt6370_isnk_brightness_set(struct led_classdev *lcdev,
> > +				      enum led_brightness level)
> > +{
> > +	struct mt6370_led *led = container_of(lcdev, struct mt6370_led, isink);
> > +	struct mt6370_priv *priv = led->priv;
> > +	unsigned int enable;
> > +	int ret;
> > +
> > +	mutex_lock(&priv->lock);
> > +
> > +	ret = regmap_field_read(priv->fields[F_RGB_EN], &enable);
> > +	if (ret)
> > +		goto out_unlock;
> 
> > +	if (level == 0) {
> > +		enable &= ~MT6370_CHEN_BIT(led->index);
> > +
> > +		ret = mt6370_set_led_mode(priv, led->index,
> > +					  MT6370_LED_REG_MODE);
> > +		if (ret)
> > +			goto out_unlock;
> > +
> > +		ret = regmap_field_write(priv->fields[F_RGB_EN], enable);
> > +	} else {
> > +		enable |= MT6370_CHEN_BIT(led->index);
> > +
> > +		ret = mt6370_set_led_brightness(priv, led->index, level);
> > +		if (ret)
> > +			goto out_unlock;
> > +
> > +		ret = regmap_field_write(priv->fields[F_RGB_EN], enable);
> > +	}
> 
> Hmm... Wouldn't be below the equivalent?
> 
> 	if (level == 0) {
> 		enable &= ~MT6370_CHEN_BIT(led->index);
> 
> 		ret = mt6370_set_led_mode(priv, led->index,
> 					  MT6370_LED_REG_MODE);
> 		if (ret)
> 			goto out_unlock;
> 	} else {
> 		enable |= MT6370_CHEN_BIT(led->index);
> 
> 		ret = mt6370_set_led_brightness(priv, led->index, level);
> 		if (ret)
> 			goto out_unlock;
> 
> 	}
> 
> 	ret = regmap_field_write(priv->fields[F_RGB_EN], enable);
> 
> (Of course even if (ret) goto... is duplicated, but probably better to leave it
>  as is now)
> 
It's equivalent. Thanks.
> > +out_unlock:
> > +	mutex_unlock(&priv->lock);
> > +
> > +	return ret;
> > +}
> 
> ...
> 
> > +		fwnode_for_each_child_node(init_data->fwnode, child) {
> > +			u32 reg, color;
> > +
> > +			ret = fwnode_property_read_u32(child, "reg", &reg);
> > +			if (ret || reg > MT6370_LED_ISNK3 ||
> > +			    priv->leds_active & BIT(reg))
> 
> I don't see where you drop a reference count.
>
Fix in next. 
> > +				return -EINVAL;
> > +
> > +			ret = fwnode_property_read_u32(child, "color", &color);
> > +			if (ret)
> 
> Ditto.
> 
> > +				return dev_err_probe(dev, ret,
> > +						     "LED %d, no color specified\n",
> > +						     led->index);
> > +
> > +			priv->leds_active |= BIT(reg);
> > +			sub_led[num_color].color_index = color;
> > +			sub_led[num_color].channel = reg;
> > +			sub_led[num_color].intensity = 0;
> > +			num_color++;
> > +		}
> 
> ...
> 
> > +	count = device_get_child_node_count(dev);
> > +	if (!count || count > MT6370_MAX_LEDS)
> 
> Is the second really critical? Can it be just a warning and clamping of the
> counter to the upper limit?
> 
I think it's 'must', following by the next, it will dynamically allocate the memory by the count.
But sure, like as you said, also can clamp the counter.
To use the clamping, it means that need more code to check after 'device_for_each_node'.

I think it's better to put the pre-check here to save the release actions if any error.
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "No child node or node count over max LED number %zu\n",
> > +				      count);
> 
> ...
> 
> > +	device_for_each_child_node(dev, child) {
> > +		struct mt6370_led *led = priv->leds + i++;
> > +		struct led_init_data init_data = { .fwnode = child };
> > +		u32 reg, color;
> > +
> > +		ret = fwnode_property_read_u32(child, "reg", &reg);
> > +		if (ret)
> 
> What about reference count?
> 
Fix in next.
> > +			return dev_err_probe(dev, ret, "Failed to parse reg property\n");
> > +
> > +		if (reg >= MT6370_MAX_LEDS)
> 
> Ditto.
> 
> > +			return dev_err_probe(dev, -EINVAL, "Error reg property number\n");
> > +
> > +		ret = fwnode_property_read_u32(child, "color", &color);
> > +		if (ret)
> 
> Ditto.
> 
> > +			return dev_err_probe(dev, ret, "Failed to parse color property\n");
> > +
> > +		if (color == LED_COLOR_ID_RGB || color == LED_COLOR_ID_MULTI)
> > +			reg = MT6370_VIRTUAL_MULTICOLOR;
> > +
> > +		if (priv->leds_active & BIT(reg))
> 
> Ditto.
> 
> > +			return dev_err_probe(dev, -EINVAL, "Duplicate reg property\n");
> > +
> > +		priv->leds_active |= BIT(reg);
> > +
> > +		led->index = reg;
> > +		led->priv = priv;
> > +
> > +		ret = mt6370_init_led_properties(led, &init_data);
> > +		if (ret)
> 
> Ditto.
> 
> > +			return ret;
> > +
> > +		ret = mt6370_led_register(&pdev->dev, led, &init_data);
> > +		if (ret)
> 
> Ditto.
> 
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
