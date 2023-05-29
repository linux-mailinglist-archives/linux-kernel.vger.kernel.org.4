Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6494D7151F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjE2WiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE2WiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:38:22 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B746CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 15:38:20 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 81458e19-fe71-11ed-b972-005056bdfda7;
        Tue, 30 May 2023 01:38:17 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 30 May 2023 01:38:17 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v4 7/9] serial: sc16is7xx: fix regression with GPIO
 configuration
Message-ID: <ZHUpWQafRPHW1RJQ@surfacebook>
References: <20230529140711.896830-1-hugo@hugovil.com>
 <20230529140711.896830-8-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529140711.896830-8-hugo@hugovil.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 29, 2023 at 10:07:09AM -0400, Hugo Villeneuve kirjoitti:
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

...

> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")

Don't forget to refer to the dependency patches form this series.
(I forgot how it should be done, IIRC the documentation about stable kernel
patches can shed a light on this.)


...

> +	switch (mctrl_mask) {
> +	case 0:
> +		s->gpio_valid_mask = 0xFF;

GENMASK()

> +		break;
> +	case SC16IS7XX_IOCONTROL_MODEM_A_BIT:
> +		s->gpio_valid_mask = 0x0F;

GENMASK()

> +		break;
> +	case SC16IS7XX_IOCONTROL_MODEM_B_BIT:
> +		s->gpio_valid_mask = 0xF0;

GENMASK()

> +		break;
> +	default:
> +		break;
> +	}

...

> +		of_property_for_each_u32(dev->of_node, "nxp,modem-control-line-ports",
> +					 prop, p, u) {
> +			if (u >= devtype->nr_uart)
> +				continue;
> +
> +			/* Use GPIO lines as modem control lines */
> +			if (u == 0)
> +				mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
> +			else if (u == 1)
> +				mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
> +		}

Can we use device properties, please?

If you think about backporting to the earlier kernels (w/o properties in use in
this driver), perhaps an additional followup for that?

-- 
With Best Regards,
Andy Shevchenko


