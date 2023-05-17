Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A22706554
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjEQKeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjEQKeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:34:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C143440E5;
        Wed, 17 May 2023 03:34:05 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AFF396605877;
        Wed, 17 May 2023 11:34:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684319644;
        bh=CNPDAErWqxe5Rz37F5idUDbn9tn9q19Yz8WhGFdKC/s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Qhrp+52jnkMGIO2iKOvtOSuZFp1FDgQ22+KAjPZK8PLYDp3yHfP3bFvBRiViC/BXE
         mjH21LxpxsGpEPYE4VsqECzWYcHwCRRyjYrQBHcbAl62fdtlairBikh4sT8tjS6LBY
         aHMstjfkISKqAD4+rfrwor0iBZ1jmk4Ivc9dMIgmF2YzGp3qkqL4INwuL5R49vabkW
         QNTw3WMXoHYbyxH4JYg1hLTXySv2eo/zuQuAyCAr4USL34jHr5l20FOJBBZVYARTRI
         VoHCSXfyhubGMRCsNopd+QdKvbXPi6Sg2VSyujk4ehp9yhFEJN1rNEn7YABnwmJoJ1
         RFZL98bf9Ik7A==
Message-ID: <632269cc-db60-d405-d31f-b80a7faf1791@collabora.com>
Date:   Wed, 17 May 2023 12:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/7] iio: adc: rockchip_saradc: Use
 of_device_get_match_data
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
 <20230516230051.14846-4-shreeya.patel@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230516230051.14846-4-shreeya.patel@collabora.com>
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
> Use of_device_get_match_data() to simplify the code.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>   drivers/iio/adc/rockchip_saradc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 05b66eff9a44..05ea823a8f16 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -408,10 +408,10 @@ static void rockchip_saradc_regulator_unreg_notifier(void *data)
>   
>   static int rockchip_saradc_probe(struct platform_device *pdev)
>   {
> +	const struct rockchip_saradc_data *match_data;

s/match_data/data/g maybe?

Regardless of that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>   	struct rockchip_saradc *info = NULL;
>   	struct device_node *np = pdev->dev.of_node;
>   	struct iio_dev *indio_dev = NULL;
> -	const struct of_device_id *match;
>   	int ret;
>   	int irq;
>   
> @@ -425,13 +425,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>   	}
>   	info = iio_priv(indio_dev);
>   
> -	match = of_match_device(rockchip_saradc_match, &pdev->dev);
> -	if (!match) {
> +	match_data = of_device_get_match_data(&pdev->dev);
> +	if (!match_data) {
>   		dev_err(&pdev->dev, "failed to match device\n");
>   		return -ENODEV;
>   	}
>   
> -	info->data = match->data;
> +	info->data = match_data;
>   
>   	/* Sanity check for possible later IP variants with more channels */
>   	if (info->data->num_channels > SARADC_MAX_CHANNELS) {


