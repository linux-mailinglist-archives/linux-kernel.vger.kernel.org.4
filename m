Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49291629732
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiKOLUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiKOLUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:20:08 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332F3B23;
        Tue, 15 Nov 2022 03:20:06 -0800 (PST)
Received: from wf0498.dip.tu-dresden.de ([141.76.181.242] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1outyw-0007iM-8s; Tue, 15 Nov 2022 12:19:58 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH 1/7] thermal: rockchip: Simplify getting match data
Date:   Tue, 15 Nov 2022 12:19:57 +0100
Message-ID: <6623921.lOV4Wx5bFT@phil>
In-Reply-To: <20221031175058.175698-2-sebastian.reichel@collabora.com>
References: <20221031175058.175698-1-sebastian.reichel@collabora.com> <20221031175058.175698-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 31. Oktober 2022, 18:50:52 CET schrieb Sebastian Reichel:
> It's possible to directly get the match data in a generic
> way nowadays.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/thermal/rockchip_thermal.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 819e059cde71..0a0f38c29842 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1353,16 +1353,11 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct rockchip_thermal_data *thermal;
> -	const struct of_device_id *match;
>  	struct resource *res;
>  	int irq;
>  	int i;
>  	int error;
>  
> -	match = of_match_node(of_rockchip_thermal_match, np);
> -	if (!match)
> -		return -ENXIO;
> -
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return -EINVAL;
> @@ -1374,7 +1369,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  
>  	thermal->pdev = pdev;
>  
> -	thermal->chip = (const struct rockchip_tsadc_chip *)match->data;
> +	thermal->chip = (const struct rockchip_tsadc_chip *) device_get_match_data(&pdev->dev);

Nit: This can work without the explicit cast and most users
in the kernel also use it that way - makes reading far easier.

Otherwise
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Heiko

>  	if (!thermal->chip)
>  		return -EINVAL;
>  
> 




