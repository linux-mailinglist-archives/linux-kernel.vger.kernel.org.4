Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1584737E69
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjFUJIV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 05:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjFUJII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:08:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978531B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:08:07 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qBtoi-0002P0-7d; Wed, 21 Jun 2023 11:07:56 +0200
Message-ID: <77f62814f98dd2728a1e4747f0db6b2a3cfa2c11.camel@pengutronix.de>
Subject: Re: [PATCH v10 01/11] drm/etnaviv: Add a dedicated function to
 register an irq handler
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
Date:   Wed, 21 Jun 2023 11:07:51 +0200
In-Reply-To: <20230620094716.2231414-2-18949883232@163.com>
References: <20230620094716.2231414-1-18949883232@163.com>
         <20230620094716.2231414-2-18949883232@163.com>
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
> Because getting IRQ from a device is platform-dependent, PCI devices have
> different methods for getting an IRQ. This patch is a preparation to extend
> this driver for supporting the PCI devices.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 32 +++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index de8c9894967c..a03e81337d8f 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1817,6 +1817,27 @@ static const struct of_device_id etnaviv_gpu_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, etnaviv_gpu_match);
>  
> +static int etnaviv_gpu_register_irq(struct etnaviv_gpu *gpu, int irq)
> +{
> +	struct device *dev = gpu->dev;
> +	int err;
> +
> +	if (irq < 0)
> +		return irq;
> +
> +	err = devm_request_irq(dev, irq, irq_handler, 0, dev_name(dev), gpu);
> +	if (err) {
> +		dev_err(dev, "failed to request irq %u: %d\n", irq, err);
> +		return err;
> +	}
> +
> +	gpu->irq = irq;
> +
> +	dev_info(dev, "irq(%d) handler registered\n", irq);

There is no reason to put this into the kernel log. It's no different
than other resources to the driver and we don't log each one of those
either.

In fact I don't see any reason for this change in the first place.
Effectively you are moving a single function call into a new function,
which doesn't seem like an improvement.

Regards,
Lucas

> +
> +	return 0;
> +}
> +
>  static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1837,16 +1858,9 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>  		return PTR_ERR(gpu->mmio);
>  
>  	/* Get Interrupt: */
> -	gpu->irq = platform_get_irq(pdev, 0);
> -	if (gpu->irq < 0)
> -		return gpu->irq;
> -
> -	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
> -			       dev_name(gpu->dev), gpu);
> -	if (err) {
> -		dev_err(dev, "failed to request IRQ%u: %d\n", gpu->irq, err);
> +	err = etnaviv_gpu_register_irq(gpu, platform_get_irq(pdev, 0));
> +	if (err)
>  		return err;
> -	}
>  
>  	/* Get Clocks: */
>  	gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");

