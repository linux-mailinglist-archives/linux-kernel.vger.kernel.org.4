Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41475706576
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjEQKkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjEQKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:40:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E93D55A6;
        Wed, 17 May 2023 03:40:42 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 214C1660563D;
        Wed, 17 May 2023 11:40:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684320041;
        bh=yjvnp4Vt6ChNqCAMpDPQmMO345ddeKIOJ8C7wndocbM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UBpb9LpjM5tLTlnK7p+f3bqtwfaL1jTko3W05/rXbUYLZb6cKNTNT9NhNOqNVQ/EX
         hF1okH8H5XQ3Sbl0P6LNQGqWj5sO4axnLC83N5ZbIX3YlF3fCLjJQNeEcPiKpkxwwS
         5+SkTrCvsk0y1N+hwHUT9Y5vONPtYkz2ktpxtSB4qx8Nuv1gliQFTfkIZrgNPMnHop
         RSrRf1Ml4KMUriGFIbcgG4+3zkaZFFD2HZi0lT9OsTJciL1cAW5i0ZmXMsptUNAVjn
         jLvEEOOZMIS1VocvoqVSvVUJ2bQJLeV29awz6if8VZd3oCXsp7S5iZCIBQYVlHOUoN
         YoNVbT4pz30hw==
Message-ID: <d1955b9e-c719-9c7c-b1fd-f11fa97e44af@collabora.com>
Date:   Wed, 17 May 2023 12:40:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5/7] iio: adc: rockchip_saradc: Use dev_err_probe
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
References: <20230516230051.14846-1-shreeya.patel@collabora.com>
 <20230516230051.14846-6-shreeya.patel@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230516230051.14846-6-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/23 01:00, Shreeya Patel ha scritto:
> Use dev_err_probe instead of dev_err in probe function,
> which simplifies code a little bit and prints the error
> code.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>   drivers/iio/adc/rockchip_saradc.c | 45 ++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 5e1e8575bc76..a52021fd477d 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c

..snip..

> @@ -494,23 +492,20 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>   	 * This may become user-configurable in the future.
>   	 */
>   	ret = clk_set_rate(info->clk, info->data->clk_rate);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to set adc clk rate, %d\n", ret);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to set adc clk rate\n");
>   
>   	ret = regulator_enable(info->vref);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to enable vref regulator\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to enable vref regulator\n");
> +
>   	ret = devm_add_action_or_reset(&pdev->dev,
>   				       rockchip_saradc_regulator_disable, info);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to register devm action, %d\n",
> -			ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to register devm action\n");

It's not your fault - and it's about a pre-existing issue, but there's that:
you're returning an error if devm_add_action_or_reset() fails (which is highly
unlikely), but you're leaving the regulator enabled!

As for how to proceed here, I would suggest to fix this issue in a separated
commit (before the dev_err_probe() conversion); it'd look like...

	if (ret) {
		regulator_disable(info->vref);
		dev_err( .... blurb );
		return ret;
	}

and after the conversion it'd look like...

	if (ret) {
		regulator_disable(info->vref);
		return dev_err_probe( ... blurb );
	}

Cheers,
Angelo

>   
>   	ret = regulator_get_voltage(info->vref);
>   	if (ret < 0)

