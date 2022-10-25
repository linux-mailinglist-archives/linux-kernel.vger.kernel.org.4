Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3591960CBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiJYM1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiJYM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:27:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D52182C55
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:27:37 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1onJ1h-0000nv-H5; Tue, 25 Oct 2022 14:27:25 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1onJ1f-0004Nz-U4; Tue, 25 Oct 2022 14:27:23 +0200
Date:   Tue, 25 Oct 2022 14:27:23 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, Anson.Huang@nxp.com, festevam@gmail.com,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-imx@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        shawnguo@kernel.org, linux@roeck-us.net
Subject: Re: [PATCH v2 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
Message-ID: <20221025122723.yl5vax7y33ueo2p5@pengutronix.de>
References: <20221025072533.2980154-1-andrej.picej@norik.com>
 <20221025072533.2980154-2-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025072533.2980154-2-andrej.picej@norik.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-25, Andrej Picej wrote:
> Putting device into the "Suspend-To-Idle" mode causes watchdog to
> trigger and reset the board after set watchdog timeout period elapses.
> 
> Introduce new device-tree property "fsl,suspend-in-wait" which suspends
> watchdog in WAIT mode. This is done by setting WDW bit in WCR
> (Watchdog Control Register) Watchdog operation is restored after exiting
> WAIT mode as expected. WAIT mode coresponds with Linux's
> "Suspend-To-Idle".
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes in v2:
>  - validate the property with compatible string, as this functionality
>    is not supported by all devices.
> ---
>  drivers/watchdog/imx2_wdt.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index d0c5d47ddede..dd9866c6f1e5 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -35,6 +35,7 @@
>  
>  #define IMX2_WDT_WCR		0x00		/* Control Register */
>  #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
> +#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable for WAIT */
>  #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset WDOG_B */
>  #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset Signal */
>  #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable */
> @@ -67,6 +68,27 @@ struct imx2_wdt_device {
>  	bool ext_reset;
>  	bool clk_is_on;
>  	bool no_ping;
> +	bool sleep_wait;
> +};
> +
> +static const char * const wdw_boards[] __initconst = {
> +	"fsl,imx25-wdt",
> +	"fsl,imx35-wdt",
> +	"fsl,imx50-wdt",
> +	"fsl,imx51-wdt",
> +	"fsl,imx53-wdt",
> +	"fsl,imx6q-wdt",
> +	"fsl,imx6sl-wdt",
> +	"fsl,imx6sll-wdt",
> +	"fsl,imx6sx-wdt",
> +	"fsl,imx6ul-wdt",
> +	"fsl,imx7d-wdt",
> +	"fsl,imx8mm-wdt",
> +	"fsl,imx8mn-wdt",
> +	"fsl,imx8mp-wdt",
> +	"fsl,imx8mq-wdt",
> +	"fsl,vf610-wdt",
> +	NULL
>  };

For such things we have the data pointer within the struct of_device_id.

>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -129,6 +151,9 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
>  
>  	/* Suspend timer in low power mode, write once-only */
>  	val |= IMX2_WDT_WCR_WDZST;
> +	/* Suspend timer in low power WAIT mode, write once-only */
> +	if (wdev->sleep_wait)
> +		val |= IMX2_WDT_WCR_WDW;
>  	/* Strip the old watchdog Time-Out value */
>  	val &= ~IMX2_WDT_WCR_WT;
>  	/* Generate internal chip-level reset if WDOG times out */
> @@ -313,6 +338,18 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>  
>  	wdev->ext_reset = of_property_read_bool(dev->of_node,
>  						"fsl,ext-reset-output");
> +
> +	if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait"))

Why do we need this special property? If the device has problems when
"freeze" is used as suspend mode and this is fixed by this special bit
then we should enable it if the device supports it.

Regards,
  Marco


> +		if (of_device_compatible_match(dev->of_node, wdw_boards))
> +			wdev->sleep_wait = 1;
> +		else {
> +			dev_warn(dev, "Warning: Suspending watchdog during " \
> +				"WAIT mode is not supported for this device.\n");
> +			wdev->sleep_wait = 0;
> +		}
> +	else
> +		wdev->sleep_wait = 0;
> +
>  	/*
>  	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
>  	 * during suspend.
> -- 
> 2.25.1
> 
> 
> 
