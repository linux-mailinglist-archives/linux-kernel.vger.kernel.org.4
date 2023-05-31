Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8527C718907
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjEaSHx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEaSHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:07:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61FB128
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:07:50 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1q4QEc-0002pT-KH; Wed, 31 May 2023 20:07:46 +0200
Message-ID: <85565974d45b5553035aeabe8a98a667718482d5.camel@pengutronix.de>
Subject: Re: [PATCH v6 2/6] drm/etnaviv: add a dedicated function to get
 various clocks
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Date:   Wed, 31 May 2023 20:07:43 +0200
In-Reply-To: <20230530160643.2344551-3-suijingfeng@loongson.cn>
References: <20230530160643.2344551-1-suijingfeng@loongson.cn>
         <20230530160643.2344551-3-suijingfeng@loongson.cn>
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

Am Mittwoch, dem 31.05.2023 um 00:06 +0800 schrieb Sui Jingfeng:
> Because it is also platform-dependent, there are environments where don't
> have CLK subsystem support, for example, discreted PCI gpu. So don't rage
> quit if there is no CLK subsystem.
> 
> For the GPU in LS7a1000 and LS2k2000, the working frequency of the GPU is
> tuned by configuring the PLL register directly.
> 
Is this PLL under control of system firmware and invisible to Linux?

> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 62 ++++++++++++++++++---------
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  1 +
>  2 files changed, 42 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 636d3f39ddcb..4937580551a5 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1565,10 +1565,45 @@ static irqreturn_t irq_handler(int irq, void *data)
>  	return ret;
>  }
>  
> +static int etnaviv_gpu_clk_get(struct etnaviv_gpu *gpu)
> +{
> +	struct device *dev = gpu->dev;
> +
> +	if (gpu->no_clk)
> +		return 0;
> +
> +	gpu->clk_reg = devm_clk_get_optional(dev, "reg");
> +	DBG("clk_reg: %p", gpu->clk_reg);
> +	if (IS_ERR(gpu->clk_reg))
> +		return PTR_ERR(gpu->clk_reg);
> +
> +	gpu->clk_bus = devm_clk_get_optional(dev, "bus");
> +	DBG("clk_bus: %p", gpu->clk_bus);
> +	if (IS_ERR(gpu->clk_bus))
> +		return PTR_ERR(gpu->clk_bus);
> +
> +	gpu->clk_core = devm_clk_get(dev, "core");
> +	DBG("clk_core: %p", gpu->clk_core);
> +	if (IS_ERR(gpu->clk_core))
> +		return PTR_ERR(gpu->clk_core);
> +	gpu->base_rate_core = clk_get_rate(gpu->clk_core);
> +
> +	gpu->clk_shader = devm_clk_get_optional(dev, "shader");
> +	DBG("clk_shader: %p", gpu->clk_shader);
> +	if (IS_ERR(gpu->clk_shader))
> +		return PTR_ERR(gpu->clk_shader);
> +	gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
> +
> +	return 0;
> +}
> +
>  static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
>  {
>  	int ret;
>  
> +	if (gpu->no_clk)
> +		return 0;
> +
I don't see why this would be needed? If your platform doesn't provide
CONFIG_HAVE_CLK all those functions should be successful no-ops, so
there is no need to special case this in the driver.

Or does your platform in fact provide a clk subsystem, just the GPU
clocks are managed by it?

Also all those functions are fine with being called on a NULL clk, so
shouldn't it be enough to simply avoid calling etnaviv_gpu_clk_get() in
the PCI device case?

Regards,
Lucas

>  	ret = clk_prepare_enable(gpu->clk_reg);
>  	if (ret)
>  		return ret;
> @@ -1599,6 +1634,9 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
>  
>  static int etnaviv_gpu_clk_disable(struct etnaviv_gpu *gpu)
>  {
> +	if (gpu->no_clk)
> +		return 0;
> +
>  	clk_disable_unprepare(gpu->clk_shader);
>  	clk_disable_unprepare(gpu->clk_core);
>  	clk_disable_unprepare(gpu->clk_bus);
> @@ -1865,27 +1903,9 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>  		return err;
>  
>  	/* Get Clocks: */
> -	gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");
> -	DBG("clk_reg: %p", gpu->clk_reg);
> -	if (IS_ERR(gpu->clk_reg))
> -		return PTR_ERR(gpu->clk_reg);
> -
> -	gpu->clk_bus = devm_clk_get_optional(&pdev->dev, "bus");
> -	DBG("clk_bus: %p", gpu->clk_bus);
> -	if (IS_ERR(gpu->clk_bus))
> -		return PTR_ERR(gpu->clk_bus);
> -
> -	gpu->clk_core = devm_clk_get(&pdev->dev, "core");
> -	DBG("clk_core: %p", gpu->clk_core);
> -	if (IS_ERR(gpu->clk_core))
> -		return PTR_ERR(gpu->clk_core);
> -	gpu->base_rate_core = clk_get_rate(gpu->clk_core);
> -
> -	gpu->clk_shader = devm_clk_get_optional(&pdev->dev, "shader");
> -	DBG("clk_shader: %p", gpu->clk_shader);
> -	if (IS_ERR(gpu->clk_shader))
> -		return PTR_ERR(gpu->clk_shader);
> -	gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
> +	err = etnaviv_gpu_clk_get(gpu);
> +	if (err)
> +		return err;
>  
>  	/* TODO: figure out max mapped size */
>  	dev_set_drvdata(dev, gpu);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> index 98c6f9c320fc..6da5209a7d64 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -148,6 +148,7 @@ struct etnaviv_gpu {
>  	struct clk *clk_reg;
>  	struct clk *clk_core;
>  	struct clk *clk_shader;
> +	bool no_clk;
>  
>  	unsigned int freq_scale;
>  	unsigned long base_rate_core;

