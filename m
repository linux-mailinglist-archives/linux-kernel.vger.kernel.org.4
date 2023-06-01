Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A080E71F4AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjFAVa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjFAVa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:30:26 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1373C196
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:30:23 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 7eea1b78-00c3-11ee-abf4-005056bdd08f;
        Fri, 02 Jun 2023 00:30:15 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 2 Jun 2023 00:30:14 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v6 5/9] serial: sc16is7xx: fix regression with GPIO
 configuration
Message-ID: <ZHkN5kEa6yqHdDeL@surfacebook>
References: <20230601201844.3739926-1-hugo@hugovil.com>
 <20230601201844.3739926-6-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601201844.3739926-6-hugo@hugovil.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 04:18:40PM -0400, Hugo Villeneuve kirjoitti:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> changed the function of the GPIOs pins to act as modem control
> lines without any possibility of selecting GPIO function.
> 
> As a consequence, applications that depends on GPIO lines configured
> by default as GPIO pins no longer work as expected.
> 
> Also, the change to select modem control lines function was done only
> for channel A of dual UART variants (752/762). This was not documented
> in the log message.
> 
> Allow to specify GPIO or modem control line function in the device
> tree, and for each of the ports (A or B).
> 
> Do so by using the new device-tree property named
> "modem-control-line-ports" (property added in separate patch).
> 
> When registering GPIO chip controller, mask-out GPIO pins declared as
> modem control lines according to this new "modem-control-line-ports"
> DT property.
> 
> Boards that need to have GPIOS configured as modem control lines
> should add that property to their device tree. Here is a list of
> boards using the sc16is7xx driver in their device tree and that may
> need to be modified:
>     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>     mips/boot/dts/ingenic/cu1830-neo.dts
>     mips/boot/dts/ingenic/cu1000-neo.dts

Almost good, a few remarks and if addressed as suggested,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you!

...

> +	if (!s->gpio_valid_mask)

I would use == 0, but it's up to you. Both will work equally.

> +		return 0;

...

> +static int sc16is7xx_setup_mctrl_ports(struct device *dev)

Not sure why int if you always return an unsigned value.
Otherwise return an error code when it's no defined mask
and check it in the caller.

> +{
> +	struct sc16is7xx_port *s = dev_get_drvdata(dev);
> +	int i;
> +	int ret;
> +	int count;
> +	u32 mctrl_port[2];
> +	u8 mctrl_mask = 0;

I would return 0 directly in the first two cases and split an assignment closer
to the first user.

> +	count = device_property_count_u32(dev, "nxp,modem-control-line-ports");
> +	if (count < 0 || count > ARRAY_SIZE(mctrl_port))
> +		return mctrl_mask;

		return 0;

> +	ret = device_property_read_u32_array(dev, "nxp,modem-control-line-ports",
> +					     mctrl_port, count);
> +	if (ret)
> +		return mctrl_mask;

		return 0;


	mctrl_mask = 0;

> +	for (i = 0; i < count; i++) {
> +		/* Use GPIO lines as modem control lines */
> +		if (mctrl_port[i] == 0)
> +			mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
> +		else if (mctrl_port[i] == 1)
> +			mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
> +	}

> +	if (!mctrl_mask)
> +		return mctrl_mask;

Maybe positive one?

	if (mctrl_mask)
		regmap_update_bits(...);

> +	regmap_update_bits(s->regmap,
> +			   SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
> +			   SC16IS7XX_IOCONTROL_MODEM_A_BIT |
> +			   SC16IS7XX_IOCONTROL_MODEM_B_BIT, mctrl_mask);
> +
> +	return mctrl_mask;
> +}

...

>  	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
>  	unsigned int val;
> +	u8 mctrl_mask = 0;

This assignment is redundant, so you simply can define it

>  	u32 uartclk = 0;

	u8 mctrl_mask;

>  	int i, ret;
>  	struct sc16is7xx_port *s;

-- 
With Best Regards,
Andy Shevchenko


