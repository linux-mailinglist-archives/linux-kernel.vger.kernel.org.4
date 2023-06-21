Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7A6737EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjFUJPf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 05:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjFUJPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:15:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094551B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:15:15 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qBtvb-00039C-3d; Wed, 21 Jun 2023 11:15:03 +0200
Message-ID: <0daa7182d6600a24988d1c81cf8fe3c0c9487f52.camel@pengutronix.de>
Subject: Re: [PATCH v10 03/11] drm/etnaviv: Add dedicated functions to
 create and destroy platform device
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <18949883232@163.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 21 Jun 2023 11:15:00 +0200
In-Reply-To: <20230620094716.2231414-4-18949883232@163.com>
References: <20230620094716.2231414-1-18949883232@163.com>
         <20230620094716.2231414-4-18949883232@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 20.06.2023 um 17:47 +0800 schrieb Sui Jingfeng:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> Also rename the virtual master platform device as etnaviv_platform_device,
> for better reflection that it is a platform device, not a DRM device.
> 
> Another benefit is that we no longer need to call of_node_put() for three
> different cases, Instead, we only need to call it once.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 56 +++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 31a7f59ccb49..cec005035d0e 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -656,12 +656,44 @@ static struct platform_driver etnaviv_platform_driver = {
>  	},
>  };
>  
> -static struct platform_device *etnaviv_drm;
> +static struct platform_device *etnaviv_platform_device;
>  
> -static int __init etnaviv_init(void)
> +static int etnaviv_create_platform_device(const char *name,
> +					  struct platform_device **ppdev)

As the platform device is a global static variable, there is no need to
push it through the parameters of this function. Just use the global
variable directly in this function.

>  {
>  	struct platform_device *pdev;
>  	int ret;
> +
> +	pdev = platform_device_alloc(name, PLATFORM_DEVID_NONE);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	ret = platform_device_add(pdev);
> +	if (ret) {
> +		platform_device_put(pdev);
> +		return ret;
> +	}
> +
> +	*ppdev = pdev;
> +
> +	return 0;
> +}
> +
> +static void etnaviv_destroy_platform_device(struct platform_device **ppdev)
> +{
> +	struct platform_device *pdev = *ppdev;

Same here, just use the global variable directly.

Regards,
Lucas

> +
> +	if (!pdev)
> +		return;
> +
> +	platform_device_unregister(pdev);
> +
> +	*ppdev = NULL;
> +}
> +
> +static int __init etnaviv_init(void)
> +{
> +	int ret;
>  	struct device_node *np;
>  
>  	etnaviv_validate_init();
> @@ -681,23 +713,13 @@ static int __init etnaviv_init(void)
>  	for_each_compatible_node(np, NULL, "vivante,gc") {
>  		if (!of_device_is_available(np))
>  			continue;
> +		of_node_put(np);
>  
> -		pdev = platform_device_alloc("etnaviv", PLATFORM_DEVID_NONE);
> -		if (!pdev) {
> -			ret = -ENOMEM;
> -			of_node_put(np);
> -			goto unregister_platform_driver;
> -		}
> -
> -		ret = platform_device_add(pdev);
> -		if (ret) {
> -			platform_device_put(pdev);
> -			of_node_put(np);
> +		ret = etnaviv_create_platform_device("etnaviv",
> +						     &etnaviv_platform_device);
> +		if (ret)
>  			goto unregister_platform_driver;
> -		}
>  
> -		etnaviv_drm = pdev;
> -		of_node_put(np);
>  		break;
>  	}
>  
> @@ -713,7 +735,7 @@ module_init(etnaviv_init);
>  
>  static void __exit etnaviv_exit(void)
>  {
> -	platform_device_unregister(etnaviv_drm);
> +	etnaviv_destroy_platform_device(&etnaviv_platform_device);
>  	platform_driver_unregister(&etnaviv_platform_driver);
>  	platform_driver_unregister(&etnaviv_gpu_driver);
>  }

