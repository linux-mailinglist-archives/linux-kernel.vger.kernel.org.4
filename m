Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03146FC631
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjEIMXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjEIMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:23:02 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFED30E3;
        Tue,  9 May 2023 05:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=AYH1QKuolKG1wGVYfLQ3HzyHPysucIZ9i7B5eHbQnlI=; b=GYgTSE0z0RdbF8nkmCyHqDEKKJ
        FKT/C7h1hVHwAuc8mpfOGjYKyuOJJ79FirWx9XHv42FNT6GekpSQKBbdgFl7NUcXJcTZF595vD+s5
        82Fhm88UcxDyX4zMGnCl7onuMjFdK3/X9MU+vaNZmB4ij1hz+AtxOtFbHyCIzDp85AeU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pwMMj-00CIYL-8K; Tue, 09 May 2023 14:22:49 +0200
Date:   Tue, 9 May 2023 14:22:49 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Yan Wang <rk.code@outlook.com>
Cc:     hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v1] net: mdiobus: Add a function to deassert reset
Message-ID: <96a1b95e-d05e-40f0-ada9-1956f43010e0@lunn.ch>
References: <KL1PR01MB5448631F2D6F71021602117FE6769@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1PR01MB5448631F2D6F71021602117FE6769@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 06:44:02PM +0800, Yan Wang wrote:
> Every PHY chip has a reset pin.

Hi Yan

Experience has shown that very few PHYs have controllable resets. So i
would not say every.

the state isn't
> sure of the PHY before scanning.
> 
> It is resetting, Scanning phy ID will fail, so
> deassert reset for the chip ,normal operation.

Please look at your white space in both the commit message and the
patch. No space before , but after. Spaces between words etc. More
blank lines are common in code to break up logical sections etc.

"While in resetting, scanning of the PHY ID will fail. So deassert the
reset for the chip to ensure normal operation."

What you are missing is a delay afterwards. Look at the DT binding, it
lists optional properties to control the delay. And if there is no
delay specified, the code which will later take the GPIO inserts a
delay.

> 
> Release the reset pin, because it needs to be
> registered to the created phy device.
> 
> Signed-off-by: Yan Wang <rk.code@outlook.com>
> 
> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
> index 1183ef5e203e..8fdf1293f447 100644
> --- a/drivers/net/mdio/fwnode_mdio.c
> +++ b/drivers/net/mdio/fwnode_mdio.c
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  #include <linux/phy.h>
>  #include <linux/pse-pd/pse.h>
> +#include <linux/of_gpio.h>

These includes appear to be sorted.

>  
>  MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
>  MODULE_LICENSE("GPL");
> @@ -57,6 +58,32 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>  	return register_mii_timestamper(arg.np, arg.args[0]);
>  }
>  
> +static void fwnode_mdiobus_deassert_reset_phy(struct fwnode_handle *fwnode)
> +{
> +	struct device_node *np;
> +	int reset;
> +	int rc;
> +
> +	np = to_of_node(fwnode);
> +	if (!np)
> +		return;
> +	reset = of_get_named_gpio(np, "reset-gpios", 0);
> +	if (gpio_is_valid(reset)) {
> +		rc = gpio_request(reset, NULL);
> +		if (rc < 0) {
> +			pr_err("The currunt state of the reset pin is %s ",
> +				rc == -EBUSY ? "busy" : "error");

Please correctly handle -EPROBE_DEFFER. The GPIO driver might not of
probed yet. The gpio maintainers are also trying to remove the gpio_
API and replace it with gpiod_.

> +		} else {
> +			gpio_direction_output(reset, 0);
> +			usleep_range(1000, 2000);
> +			gpio_direction_output(reset, 1);

This is actually putting it into reset first, and then taking it out
of reset. We want to avoid that. it forces a new auto-neg cycles which
takes a little over 1 second. Phylib will try to avoid forcing an
auto-neg so you get link faster. If the PHY does not need to be
reconfigured it won't be and the result of the auto neg can be used.

	Andrew
