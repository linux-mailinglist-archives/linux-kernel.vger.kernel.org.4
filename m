Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C386E728665
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjFHRcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjFHRcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012B2115
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C81B64FCC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82203C433D2;
        Thu,  8 Jun 2023 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686245564;
        bh=9pSHIKmpleefHxtGguaaooqKIkgzxLhqomz+9DI+SdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B4p4zzAL+tFEVx0n54Y5PAT+tyazEj9bP16Ck71X9kbDLAim/wHHwT9/8sKlHqZRv
         4kc2feFR284iUQVMZsQh+MuYOkJzapetY0ZDfg+ZLh6FOWBfCzj6zm3f6EaNxoKeNW
         XU+/KJGJwNu0RVNpjR2eXk815M6etlYXLyK66e5JsSU3XO+j86a/OQkDbVcFSMueCI
         1fdQc/vlOzhqNkHP2AtJx+uvmkE1UJ2S5B1zFEsTyRnl0PccI+OGCm8zi3EElk/fl8
         qh/uISCNyY6oDi9BSfPk7ZcjOWC11degePdEO5/sPRXv8COv3h8+9syaQJwcByjmI8
         qldhWlyTCrdFQ==
Date:   Thu, 8 Jun 2023 12:32:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 6/8] drm/etnaviv: add driver support for the PCI
 devices
Message-ID: <20230608173243.GA1207429@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607105551.568639-7-15330273260@189.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 06:55:49PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> This patch adds PCI driver support on top of what we already have. Take
> the GC1000 in LS7A1000/LS2K1000 as the first instance of the PCI device
> driver. There is only one GPU core for the GC1000 in the LS7A1000 and
> LS2K1000. Therefore, component frameworks can be avoided.

> +#ifdef CONFIG_DRM_ETNAVIV_PCI_DRIVER
> +#include "etnaviv_pci_drv.h"
> +#endif

With trivial stubs for etnaviv_register_pci_driver() and
etnaviv_unregister_pci_driver(), I think you could get rid of all
these #ifdefs.

> +void etnaviv_drm_unbind(struct device *dev, bool component)
>  {
>  	struct etnaviv_drm_private *priv = etna_private_ptr;
>  	struct drm_device *drm = priv->drm;
> @@ -746,6 +750,12 @@ static int __init etnaviv_init(void)
>  	if (ret != 0)
>  		goto unregister_gpu_driver;
>  
> +#ifdef CONFIG_DRM_ETNAVIV_PCI_DRIVER
> +	ret = etnaviv_register_pci_driver();
> +	if (ret != 0)
> +		goto unregister_platform_driver;
> +#endif
> +
>  	/*
>  	 * If the DT contains at least one available GPU device, instantiate
>  	 * the DRM platform device.
> @@ -763,7 +773,7 @@ static int __init etnaviv_init(void)
>  		break;
>  	}
>  
> -	return 0;
> +	return ret;
>  
>  unregister_platform_driver:
>  	platform_driver_unregister(&etnaviv_platform_driver);
> @@ -778,6 +788,10 @@ static void __exit etnaviv_exit(void)
>  	etnaviv_destroy_platform_device(&etnaviv_platform_device);
>  	platform_driver_unregister(&etnaviv_platform_driver);
>  	platform_driver_unregister(&etnaviv_gpu_driver);
> +
> +#ifdef CONFIG_DRM_ETNAVIV_PCI_DRIVER
> +	etnaviv_unregister_pci_driver();
> +#endif

> +static const struct pci_device_id etnaviv_pci_id_lists[] = {
> +	{PCI_VENDOR_ID_LOONGSON, 0x7a15, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> +	{PCI_VENDOR_ID_LOONGSON, 0x7a05, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},

PCI_VDEVICE()

Bjorn
