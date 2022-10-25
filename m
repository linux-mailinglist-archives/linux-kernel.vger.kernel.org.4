Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB53E60C88C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiJYJkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiJYJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:40:17 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6853015DB38;
        Tue, 25 Oct 2022 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666690712; x=1698226712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L0u7IH4H7p5aHjMzlVqiIOdoNle0VoIxzK5Llxq/Tpw=;
  b=H969q8C6rgDLrEr04y1akKB1zriNoAACSNYX1yv2cUXNfQGLAOKz9qxA
   1UufuK7WB32PG8VbzEibWRlZrRwGmuQslHLuiXph4vv4LKNN+56F8ReDR
   HEYxV/hgwuAl7c0u4qIsTYK+jFgc2+BnwokpgkYaFfEkL9fq7rlGDCB9/
   Yv7VpNfHUQHaukpMI0n2pPzt8Br1YgBxDVxcnBfUGVynUE0NPMwC1chkj
   ZFZ5CKWjDey7WoB+VexwJl88c23YZb+1SJCcOnjFSEhZt5WZy/NXKcIZt
   6W9S8fnzm3RuG7UtyCcus93wEq5/IceXvrckoMrXqyyFRlu0r1eqj+uVM
   g==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661810400"; 
   d="scan'208";a="26955978"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 25 Oct 2022 11:38:30 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 25 Oct 2022 11:38:30 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 25 Oct 2022 11:38:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666690710; x=1698226710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L0u7IH4H7p5aHjMzlVqiIOdoNle0VoIxzK5Llxq/Tpw=;
  b=OxRj9mLVvZGxpkpR4t7hFtUDOQURY5wc2kIuvhEfktccAJi2unBDs5iC
   nfUhL2UudszmCTBgQmHCaOkMApIVneGZX5vWf/GLW0ZbT9DLhtJf6EDS2
   qtHmlxQJM2Bv+fvWPU/ZH1lXjydNMtDAAnO6yDGybt7OX4DkcgFpwHT+c
   TqZmt6nL3BZ2EobahjZTTECA/VJREGYQvlMyh7evJxrTVFVeeZW7VGs82
   vbXDJLsoCUFYLxwqWXVRNe9VcpgcQJjOiAUOzesAg8MbkxzhWCEXOwxcY
   8djDwAvCQytX2y3RIbCLwG/tjhkEnOu4jw9Mc57/O/ulRZofAYPEitVvO
   A==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661810400"; 
   d="scan'208";a="26955977"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Oct 2022 11:38:30 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 402A1280056;
        Tue, 25 Oct 2022 11:38:30 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
Date:   Tue, 25 Oct 2022 11:38:26 +0200
Message-ID: <13126397.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20221025072533.2980154-2-andrej.picej@norik.com>
References: <20221025072533.2980154-1-andrej.picej@norik.com> <20221025072533.2980154-2-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 25. Oktober 2022, 09:25:31 CEST schrieb Andrej Picej:
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
>  #define IMX2_WDT_WCR		0x00		/* Control 
Register */
>  #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> 
Watchdog Timeout Field */
> +#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable 
for WAIT */
>  #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset 
WDOG_B */
>  #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset 
Signal */
>  #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable 
*/
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

So the models listed in Documentation/devicetree/bindings/watchdog/fsl-imx-
wdt.yaml not supporting this feature are
* fsl,imx21-wdt
* fsl,imx27-wdt
* fsl,imx31-wdt
* fsl,ls1012a-wdt
* fsl,ls1043a-wdt
?

But all models are listed as compatible to fsl,imx21-wdt. So there is 
something wrong here. IMHO this sounds like the compatible list has to be 
split and updated. Depending on that this feature can be detected. Maintaining 
another list seems error prone to me.

Best regards,
Alexander

>  static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -129,6 +151,9 @@ static inline void imx2_wdt_setup(struct watchdog_device
> *wdog)
> 
>  	/* Suspend timer in low power mode, write once-only */
>  	val |= IMX2_WDT_WCR_WDZST;
> +	/* Suspend timer in low power WAIT mode, write once-only */
> +	if (wdev->sleep_wait)
> +		val |= IMX2_WDT_WCR_WDW;
>  	/* Strip the old watchdog Time-Out value */
>  	val &= ~IMX2_WDT_WCR_WT;
>  	/* Generate internal chip-level reset if WDOG times out */
> @@ -313,6 +338,18 @@ static int __init imx2_wdt_probe(struct platform_device
> *pdev)
> 
>  	wdev->ext_reset = of_property_read_bool(dev->of_node,
>  						"fsl,ext-
reset-output");
> +
> +	if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait"))
> +		if (of_device_compatible_match(dev->of_node, 
wdw_boards))
> +			wdev->sleep_wait = 1;
> +		else {
> +			dev_warn(dev, "Warning: Suspending watchdog 
during " \
> +				"WAIT mode is not supported for 
this device.\n");
> +			wdev->sleep_wait = 0;
> +		}
> +	else
> +		wdev->sleep_wait = 0;
> +
>  	/*
>  	 * The i.MX7D doesn't support low power mode, so we need to ping 
the
> watchdog * during suspend.




