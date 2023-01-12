Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04155667D54
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbjALSDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbjALSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:02:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520853E870
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:26:01 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1pG1Kr-0000MD-Uv; Thu, 12 Jan 2023 18:25:54 +0100
Message-ID: <c7c34f0c-5403-c85d-f092-09b0ca5ae9d2@pengutronix.de>
Date:   Thu, 12 Jan 2023 18:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] usb: phy: generic: make vcc regulator optional
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20221012132754.292151-1-s.hauer@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20221012132754.292151-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.22 15:27, Sascha Hauer wrote:
> phy-generic uses the existance of the property "vcc-supply" to see if a
> regulator is optional or not. Use devm_regulator_get_optional() instead
> which exists for this purpose. Using devm_regulator_get_optional()
> avoids "supply vcc not found, using dummy regulator" messages.

Gentle ping.

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/usb/phy/phy-generic.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
> index 34b9f81401871..92d3e067067c6 100644
> --- a/drivers/usb/phy/phy-generic.c
> +++ b/drivers/usb/phy/phy-generic.c
> @@ -209,7 +209,7 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
>  	int err = 0;
>  
>  	u32 clk_rate = 0;
> -	bool needs_vcc = false, needs_clk = false;
> +	bool needs_clk = false;
>  
>  	if (dev->of_node) {
>  		struct device_node *node = dev->of_node;
> @@ -217,7 +217,6 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
>  		if (of_property_read_u32(node, "clock-frequency", &clk_rate))
>  			clk_rate = 0;
>  
> -		needs_vcc = of_property_read_bool(node, "vcc-supply");
>  		needs_clk = of_property_read_bool(node, "clocks");
>  	}
>  	nop->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
> @@ -260,13 +259,10 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
>  		}
>  	}
>  
> -	nop->vcc = devm_regulator_get(dev, "vcc");
> -	if (IS_ERR(nop->vcc)) {
> -		dev_dbg(dev, "Error getting vcc regulator: %ld\n",
> -					PTR_ERR(nop->vcc));
> -		if (needs_vcc)
> -			return -EPROBE_DEFER;
> -	}
> +	nop->vcc = devm_regulator_get_optional(dev, "vcc");
> +	if (IS_ERR(nop->vcc) && PTR_ERR(nop->vcc) != -ENODEV)
> +		return dev_err_probe(dev, PTR_ERR(nop->vcc),
> +				     "could not get vcc regulator\n");
>  
>  	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
>  	if (PTR_ERR(nop->vbus_draw) == -ENODEV)

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

