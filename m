Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F90564E1B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLOTW7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Dec 2022 14:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOTWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:22:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367E83E0B1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:22:53 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1p5tog-0006Zv-ER; Thu, 15 Dec 2022 20:22:50 +0100
Message-ID: <8092f2cb083f9b9a189dbdf6f27ee874955af7db.camel@pengutronix.de>
Subject: Re: [PATCH v2 12/26] drm: etnaviv: Remove #ifdef guards for PM
 related functions
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Date:   Thu, 15 Dec 2022 20:22:48 +0100
In-Reply-To: <20221129191733.137897-13-paul@crapouillou.net>
References: <20221129191733.137897-1-paul@crapouillou.net>
         <20221129191733.137897-13-paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 29.11.2022 um 19:17 +0000 schrieb Paul Cercueil:
> Use the RUNTIME_PM_OPS() and pm_ptr() macros to handle the
> .runtime_suspend/.runtime_resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_PM is disabled, without having
> to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Some #ifdef CONFIG_PM guards were protecting simple statements, and were
> also converted to "if (IS_ENABLED(CONFIG_PM))".
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Thanks, applied to my etnaviv/next branch.

Regards,
Lucas

> ---
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Russell King <linux+etnaviv@armlinux.org.uk>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: etnaviv@lists.freedesktop.org
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 30 +++++++++++----------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 51320eeebfcf..310382812029 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1629,7 +1629,6 @@ static int etnaviv_gpu_hw_suspend(struct etnaviv_gpu *gpu)
>  	return etnaviv_gpu_clk_disable(gpu);
>  }
>  
> -#ifdef CONFIG_PM
>  static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu)
>  {
>  	int ret;
> @@ -1645,7 +1644,6 @@ static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu)
>  
>  	return 0;
>  }
> -#endif
>  
>  static int
>  etnaviv_gpu_cooling_get_max_state(struct thermal_cooling_device *cdev,
> @@ -1713,11 +1711,10 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
>  	if (ret)
>  		goto out_workqueue;
>  
> -#ifdef CONFIG_PM
> -	ret = pm_runtime_get_sync(gpu->dev);
> -#else
> -	ret = etnaviv_gpu_clk_enable(gpu);
> -#endif
> +	if (IS_ENABLED(CONFIG_PM))
> +		ret = pm_runtime_get_sync(gpu->dev);
> +	else
> +		ret = etnaviv_gpu_clk_enable(gpu);
>  	if (ret < 0)
>  		goto out_sched;
>  
> @@ -1761,12 +1758,12 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
>  
>  	etnaviv_sched_fini(gpu);
>  
> -#ifdef CONFIG_PM
> -	pm_runtime_get_sync(gpu->dev);
> -	pm_runtime_put_sync_suspend(gpu->dev);
> -#else
> -	etnaviv_gpu_hw_suspend(gpu);
> -#endif
> +	if (IS_ENABLED(CONFIG_PM)) {
> +		pm_runtime_get_sync(gpu->dev);
> +		pm_runtime_put_sync_suspend(gpu->dev);
> +	} else {
> +		etnaviv_gpu_hw_suspend(gpu);
> +	}
>  
>  	if (gpu->mmu_context)
>  		etnaviv_iommu_context_put(gpu->mmu_context);
> @@ -1880,7 +1877,6 @@ static int etnaviv_gpu_platform_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
>  static int etnaviv_gpu_rpm_suspend(struct device *dev)
>  {
>  	struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
> @@ -1923,18 +1919,16 @@ static int etnaviv_gpu_rpm_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct dev_pm_ops etnaviv_gpu_pm_ops = {
> -	SET_RUNTIME_PM_OPS(etnaviv_gpu_rpm_suspend, etnaviv_gpu_rpm_resume,
> -			   NULL)
> +	RUNTIME_PM_OPS(etnaviv_gpu_rpm_suspend, etnaviv_gpu_rpm_resume, NULL)
>  };
>  
>  struct platform_driver etnaviv_gpu_driver = {
>  	.driver = {
>  		.name = "etnaviv-gpu",
>  		.owner = THIS_MODULE,
> -		.pm = &etnaviv_gpu_pm_ops,
> +		.pm = pm_ptr(&etnaviv_gpu_pm_ops),
>  		.of_match_table = etnaviv_gpu_match,
>  	},
>  	.probe = etnaviv_gpu_platform_probe,

