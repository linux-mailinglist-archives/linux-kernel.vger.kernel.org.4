Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53088728648
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbjFHRZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbjFHRZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:25:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CD61FD6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B79AB64FCA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30C7C433EF;
        Thu,  8 Jun 2023 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686245137;
        bh=ZaATAOm8boNxX2ZuQ1VyIMIjUgKnsaHEY03tgyAn5Fw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vKNx49YDI6kEpnIIUbxKde9/CNVTPbqdrWmLKd42Cc4KH+4kNzuz8CAM9bo/LR/nI
         EnV/hZdteDwrbFj0vEwvNq3hG82QfwrgXDbaEWPAWCO2IfbVgN3VEoWtJw989UBu1s
         7c+4tz0UinNSdNCIqpjpyRTAJgHVEiHQxJxeWFg/y2tS00o7g0vL84/eT/uekAR4r4
         wGhZV/L2b+k8rm8JX7NYDuCbtY2Zu4qone3JtPjN2F1NGdkC0ME3KsrJxGtXb24UFp
         RmO/xdXzT2gsqWmfVXQafhXf8KVNR5HZ5hF6nIUBJA5DTQqD6mJH1aPco1vzRuynB8
         Waaan6Ehhr7WQ==
Date:   Thu, 8 Jun 2023 12:25:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 1/8] drm/etnaviv: add a dedicated function to register
 an irq handler
Message-ID: <20230608172535.GA1207045@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607105551.568639-2-15330273260@189.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 06:55:44PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> Because getting IRQ from a device is platform-dependent, PCI devices have
> different methods for getting an IRQ. This patch is a preparation patch to
> extend the driver for the PCI device support.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 34 ++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index de8c9894967c..b9c12d3145a2 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1817,6 +1817,29 @@ static const struct of_device_id etnaviv_gpu_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, etnaviv_gpu_match);
>  
> +static int etnaviv_gpu_register_irq(struct etnaviv_gpu *gpu, int irq)
> +{
> +	struct device *dev = gpu->dev;
> +	int err;
> +
> +	if (irq < 0) {
> +		dev_err(dev, "failed to get irq: %d\n", irq);

Isn't this message redundant because platform_get_irq() already
emitted a message for this case?

> +		return irq;
> +	}
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
> +
> +	return 0;
> +}
> +
>  static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1837,16 +1860,9 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
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
> -- 
> 2.25.1
> 
