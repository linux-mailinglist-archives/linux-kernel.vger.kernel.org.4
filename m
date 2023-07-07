Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B974B58B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjGGRJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGRJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:09:24 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8071BE8;
        Fri,  7 Jul 2023 10:09:23 -0700 (PDT)
Received: from dslb-188-097-041-027.188.097.pools.vodafone-ip.de ([188.97.41.27] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1qHoxF-0003F4-Su; Fri, 07 Jul 2023 19:09:13 +0200
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.94.2)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1qHovi-000dvS-4S; Fri, 07 Jul 2023 19:07:38 +0200
Date:   Fri, 7 Jul 2023 19:07:38 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: timeriomem - Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <ZKhGWrNip0p9rx0I@martin-debian-2.paytec.ch>
References: <20230705115242.54285-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705115242.54285-1-frank.li@vivo.com>
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thus wrote Yangtao Li (frank.li@vivo.com):

> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/char/hw_random/timeriomem-rng.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)

> diff --git a/drivers/char/hw_random/timeriomem-rng.c b/drivers/char/hw_random/timeriomem-rng.c
> index 26f322d19a88..3db9d868efb1 100644
> --- a/drivers/char/hw_random/timeriomem-rng.c
> +++ b/drivers/char/hw_random/timeriomem-rng.c
> @@ -113,16 +113,6 @@ static int timeriomem_rng_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}

> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENXIO;
> -
> -	if (res->start % 4 != 0 || resource_size(res) < 4) {
> -		dev_err(&pdev->dev,
> -			"address must be at least four bytes wide and 32-bit aligned\n");
> -		return -EINVAL;
> -	}
> -
>  	/* Allocate memory for the device structure (and zero it) */
>  	priv = devm_kzalloc(&pdev->dev,
>  			sizeof(struct timeriomem_rng_private), GFP_KERNEL);
> @@ -131,6 +121,16 @@ static int timeriomem_rng_probe(struct platform_device *pdev)

>  	platform_set_drvdata(pdev, priv);

> +	priv->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(priv->io_base))
> +		return PTR_ERR(priv->io_base);
> +
> +	if (res->start % 4 != 0 || resource_size(res) < 4) {
> +		dev_err(&pdev->dev,
> +			"address must be at least four bytes wide and 32-bit aligned\n");
> +		return -EINVAL;
> +	}
> +
>  	if (pdev->dev.of_node) {
>  		int i;

> @@ -158,11 +158,6 @@ static int timeriomem_rng_probe(struct platform_device *pdev)
>  	priv->rng_ops.name = dev_name(&pdev->dev);
>  	priv->rng_ops.read = timeriomem_rng_read;

> -	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(priv->io_base)) {
> -		return PTR_ERR(priv->io_base);
> -	}
> -
>  	/* Assume random data is already available. */
>  	priv->present = 1;
>  	complete(&priv->completion);
> -- 
> 2.39.0

Looks ok to me.

Reviewed-by: Martin Kaiser <martin@kaiser.cx>

I was wondering if we really have to check res->start and resource_size(res)
that we read from the device tree. Other drivers don't check these settings
and use devm_platform_ioremap_resource(pdev, 0).

Best regards,
Martin
