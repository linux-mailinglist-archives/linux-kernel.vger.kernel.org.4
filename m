Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D040701E38
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjENQPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 12:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 12:15:28 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 May 2023 09:15:27 PDT
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D6A1987;
        Sun, 14 May 2023 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1684078537; bh=emwtm2+T0ixxGnTO9lMZNovFz6S2OTSijLi6bHHdVhw=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=IguaaEPsYv0I5RXH1b11Grde6GJaoos0WnyFmOXx5wLN1TDlxBwHN+BwjOZsgvW9G
         PVAi+WTL6+Ds6OwXM/LZzTPDRpws6o/IEg5nm5QJdVFeIi0wVmk03ruLjoO15TcA3w
         D/qEpSsqJBV2BCFPEUaKXwk6PW7D/Y2s6zL/7MSs=
Date:   Sun, 14 May 2023 17:35:37 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] thermal/drivers/sun8i: Fix some error handling paths in
 sun8i_ths_probe()
Message-ID: <yd37pz2nbs2i5m4a5avonj4w7ili4kx7d7w7fgbiss7z26jnfy@rwytm26i6v7h>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Vasily Khoruzhick <anarsoul@gmail.com>, 
        Yangtao Li <tiny.windzz@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
        Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>, 
        Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
        Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org, 
        kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
        linux-sunxi@lists.linux.dev
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <26f9e3bb3fcd0c12ea24a44c75b7960da993b68b.1684077651.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f9e3bb3fcd0c12ea24a44c75b7960da993b68b.1684077651.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christophe,

On Sun, May 14, 2023 at 05:21:35PM +0200, Christophe JAILLET wrote:
> 
> Should an error occur after calling sun8i_ths_resource_init() in the probe
> function, some resources need to be released, as already done in the
> .remove() function.
> 
> Switch to the devm_clk_get_enabled() helper and add a new devm_action to
> turn sun8i_ths_resource_init() into a fully managed function.
> 
> This fixes the issue and removes some LoC at the same time.
> 
> Fixes: dccc5c3b6f30 ("thermal/drivers/sun8i: Add thermal driver for H6/H5/H3/A64/A83T/R40")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This changes the order of the release functions, but should be fine.
> ---
>  drivers/thermal/sun8i_thermal.c | 43 +++++++++------------------------
>  1 file changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 793ddce72132..8f4c29bc85aa 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -319,6 +319,11 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
>  	return ret;
>  }
>  
> +static void sun8i_ths_reset_control_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
>  static int sun8i_ths_resource_init(struct ths_device *tmdev)
>  {
>  	struct device *dev = tmdev->dev;
> @@ -339,13 +344,13 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
>  		if (IS_ERR(tmdev->reset))
>  			return PTR_ERR(tmdev->reset);
>  
> -		tmdev->bus_clk = devm_clk_get(&pdev->dev, "bus");
> +		tmdev->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
>  		if (IS_ERR(tmdev->bus_clk))
>  			return PTR_ERR(tmdev->bus_clk);
>  	}
>  
>  	if (tmdev->chip->has_mod_clk) {
> -		tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
> +		tmdev->mod_clk = devm_clk_get_enabled(&pdev->dev, "mod");

This changes the recommeded order of reset release/clock enable steps, eg. A64
manual says:

	3.3.6.4. Gating and reset

	Make sure that the reset signal has been released before the release of
	module clock gating;

kind regards,
	o.

>  		if (IS_ERR(tmdev->mod_clk))
>  			return PTR_ERR(tmdev->mod_clk);
>  	}
> @@ -354,32 +359,20 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = clk_prepare_enable(tmdev->bus_clk);
> +	ret = devm_add_action_or_reset(dev, sun8i_ths_reset_control_assert,
> +				       tmdev->reset);
>  	if (ret)
> -		goto assert_reset;
> +		return ret;
>  
>  	ret = clk_set_rate(tmdev->mod_clk, 24000000);
>  	if (ret)
> -		goto bus_disable;
> -
> -	ret = clk_prepare_enable(tmdev->mod_clk);
> -	if (ret)
> -		goto bus_disable;
> +		return ret;
>  
>  	ret = sun8i_ths_calibrate(tmdev);
>  	if (ret)
> -		goto mod_disable;
> +		return ret;
>  
>  	return 0;
> -
> -mod_disable:
> -	clk_disable_unprepare(tmdev->mod_clk);
> -bus_disable:
> -	clk_disable_unprepare(tmdev->bus_clk);
> -assert_reset:
> -	reset_control_assert(tmdev->reset);
> -
> -	return ret;
>  }
>  
>  static int sun8i_h3_thermal_init(struct ths_device *tmdev)
> @@ -530,17 +523,6 @@ static int sun8i_ths_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int sun8i_ths_remove(struct platform_device *pdev)
> -{
> -	struct ths_device *tmdev = platform_get_drvdata(pdev);
> -
> -	clk_disable_unprepare(tmdev->mod_clk);
> -	clk_disable_unprepare(tmdev->bus_clk);
> -	reset_control_assert(tmdev->reset);
> -
> -	return 0;
> -}
> -
>  static const struct ths_thermal_chip sun8i_a83t_ths = {
>  	.sensor_num = 3,
>  	.scale = 705,
> @@ -642,7 +624,6 @@ MODULE_DEVICE_TABLE(of, of_ths_match);
>  
>  static struct platform_driver ths_driver = {
>  	.probe = sun8i_ths_probe,
> -	.remove = sun8i_ths_remove,
>  	.driver = {
>  		.name = "sun8i-thermal",
>  		.of_match_table = of_ths_match,
> -- 
> 2.34.1
> 
