Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E2460166A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJQSgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJQSgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:36:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78512496E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:36:35 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6036CCCF;
        Mon, 17 Oct 2022 20:36:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1666031793;
        bh=OdSpBt9X0IeCq0MXWJe9ebZ4WkeSe/9DVuTjsg7rLLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYugbuMeCHCfYfNnCdup3OWlcnUl9EbvXJ+mkt9XtCsxBFAFhle2kphNCKMvLngm4
         hlwkyPaW5tHJn6NBS6qvrxYjrHXf7E3LIS3BM5EjURyir9vwHe1gETFyZo23KZxh1D
         AXSlgH3W0PulZlHrY0qfhSaFcv1EoME+d+E90BLM=
Date:   Mon, 17 Oct 2022 21:36:09 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Archit Taneja <architt@codeaurora.org>, kernel@pengutronix.de,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: adv7511: use dev_err_probe in probe function
Message-ID: <Y02gmWSr07qONXih@pendragon.ideasonboard.com>
References: <20221017182810.1981638-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221017182810.1981638-1-a.fatoum@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

Thank you for the patch.

On Mon, Oct 17, 2022 at 08:28:09PM +0200, Ahmad Fatoum wrote:
> adv7511 probe may need to be attempted multiple times before no
> -EPROBE_DEFER is returned. Currently, every such probe results in
> an error message:
> 
> [    4.534229] adv7511 1-003d: failed to find dsi host
> [    4.580288] adv7511 1-003d: failed to find dsi host
> 
> This is misleading, as there is no error and probe deferral is normal
> behavior. Fix this by using dev_err_probe that will suppress
> -EPROBE_DEFER errors. While at it, we touch all dev_err in the probe
> path. This makes the code more concise and included the error code
> everywhere to aid user in debugging.
> 
> Fixes: 1e4d58cd7f88 ("drm/bridge: adv7533: Create a MIPI DSI device")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c |  6 ++----
>  drivers/gpu/drm/bridge/adv7511/adv7533.c     | 18 ++++++------------
>  2 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 1c37779b434a..4148b6d6f151 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1229,10 +1229,8 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>  		return ret;
>  
>  	ret = adv7511_init_regulators(adv7511);
> -	if (ret) {
> -		dev_err(dev, "failed to init regulators\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init regulators\n");
>  
>  	/*
>  	 * The power down GPIO is optional. If present, toggle it from active to
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
> index ef6270806d1d..b32b796c25fb 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
> @@ -148,16 +148,12 @@ int adv7533_attach_dsi(struct adv7511 *adv)
>  						 };
>  
>  	host = of_find_mipi_dsi_host_by_node(adv->host_node);
> -	if (!host) {
> -		dev_err(dev, "failed to find dsi host\n");
> -		return -EPROBE_DEFER;
> -	}
> +	if (!host)
> +		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");

I'd wrap this line:

		return dev_err_probe(dev, -EPROBE_DEFER,
				     "failed to find dsi host\n");

>  
>  	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
> -	if (IS_ERR(dsi)) {
> -		dev_err(dev, "failed to create dsi device\n");
> -		return PTR_ERR(dsi);
> -	}
> +	if (IS_ERR(dsi))
> +		return dev_err_probe(dev, PTR_ERR(dsi), "failed to create dsi device\n");

Same here.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>  	adv->dsi = dsi;
>  
> @@ -167,10 +163,8 @@ int adv7533_attach_dsi(struct adv7511 *adv)
>  			  MIPI_DSI_MODE_NO_EOT_PACKET | MIPI_DSI_MODE_VIDEO_HSE;
>  
>  	ret = devm_mipi_dsi_attach(dev, dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to attach dsi to host\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to attach dsi to host\n");
>  
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart
