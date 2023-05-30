Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05075716D06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjE3TDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjE3TC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629E6F9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA8B760B8D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEA0C433EF;
        Tue, 30 May 2023 19:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685473375;
        bh=kqSuTI2XGCTdxpVxLgnvdx2lAi2xmZWmmkMTJXpgv4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=g1hBOyaZ1E6vGI0X9WG1fjLb5qZGi5nMCTUAx7ik4Sx6kJ0lBrbhN3IQ2bYqQRBdQ
         fA/jqnvGr1PGFGopbCALz/Rp0EWBxCKtMEOT93RL5JVsQJf40GKNW44Crj+zb+OCMZ
         ugiNdAAMmPn/8oz1QvTCDiOdRJKI7rcPnLUfXC3RW/Me7xKfMd0MXa7wNl42PnvCP+
         Po4GZpa9DBjb6GLukZP0IUmvdAL0hI4QDagL+kgSvleeNLZ9BtDVw9sUieWupHJRKl
         e5GWKVgoTJ2egwUdJlEHCvO0kNumOPce4cIyVquIyZRNduKjujNbASNsMHwUncbKdZ
         HvCB8hdNREkCg==
Date:   Tue, 30 May 2023 14:02:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v6 5/6] drm/etnaviv: add driver support for the PCI
 devices
Message-ID: <ZHZIXZPuCkFSMF4H@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530160643.2344551-6-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 12:06:42AM +0800, Sui Jingfeng wrote:
> This patch adds PCI driver support on top of what already have. Take the
> GC1000 in LS7A1000/LS2K1000 as the first instance of the PCI device driver.
> There is only one GPU core for the GC1000 in the LS7A1000 and LS2K1000.
> Therefore, component frameworks can be avoided. Because we want to bind the
> DRM driver service to the PCI driver manually.

> +	 * Loongson Mips and LoongArch CPU(ls3a5000, ls3a4000, ls2k1000la)
> +	 * maintain cache coherency by hardware
> +	 */
> +	if (IS_ENABLED(CONFIG_CPU_LOONGSON64) || IS_ENABLED(CONFIG_LOONGARCH))
> +		priv->has_cached_coherent = true;

This looks like something that should be a runtime check, not a
compile-time check.

If it's possible to build a single kernel image that runs on Loongson
MIPS or LoongArch CPU and, in addition, runs on other platforms, you
cannot assume that all the others maintain this cache coherency.

> +static struct etnaviv_drm_private *etna_private_s;

A static pointer looks wrong because it probably limits you to a
single instance of something.

> @@ -727,6 +756,12 @@ static int __init etnaviv_init(void)
>  	if (ret != 0)
>  		goto unregister_gpu_driver;
>  
> +#ifdef CONFIG_DRM_ETNAVIV_PCI_DRIVER
> +	ret = pci_register_driver(&etnaviv_pci_driver);
> +#endif
> +	if (ret != 0)
> +		goto unregister_platform_driver;

Why is this outside the #ifdef?  If CONFIG_DRM_ETNAVIV_PCI_DRIVER is
not set, you already tested "ret != 0" above and will never take this
goto.

> +static int etnaviv_gpu_plat_drv_init(struct etnaviv_gpu *gpu, bool component)
> +{
> +	struct device *dev = gpu->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int err;
> +
> +	/* Map registers: */
> +	gpu->mmio = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(gpu->mmio))
> +		return PTR_ERR(gpu->mmio);
> +
> +	if (component) {
> +		err = component_add(dev, &gpu_ops);
> +		if (err < 0) {
> +			dev_err(dev, "failed to register component: %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}

All this platform driver rearrangement looks like it should be a
separate patch so adding PCI support only adds PCI-related stuff.

> +++ b/drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/pci.h>
> +
> +#include "etnaviv_drv.h"
> +#include "etnaviv_gpu.h"
> +#include "etnaviv_pci_drv.h"
> +
> +enum etnaviv_pci_gpu_family {
> +	GC1000_IN_LS7A1000 = 0,
> +	GC1000_IN_LS2K1000 = 1,

Seems unused; why is this here?

> +static int etnaviv_pci_probe(struct pci_dev *pdev,
> +			     const struct pci_device_id *ent)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable\n");

Use "dev", no need for "&pdev->dev" since you already looked it up
above.  Also below for dma_set_mask_and_coherent().

> +		return ret;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));

> +static const struct pci_device_id etnaviv_pci_id_lists[] = {
> +	{0x0014, 0x7a15, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GC1000_IN_LS7A1000},
> +	{0x0014, 0x7a05, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GC1000_IN_LS2K1000},
> +	{0, 0, 0, 0, 0, 0, 0}

Should probably use PCI_DEVICE_DATA().  Use PCI_VENDOR_ID_LOONGSON.
Only "{ }" required to terminate.

> +++ b/drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ETNAVIV_PCI_DRV_H__
> +#define __ETNAVIV_PCI_DRV_H__
> +
> +#include <linux/pci.h>

This #include isn't required by this file.

> +#ifdef CONFIG_DRM_ETNAVIV_PCI_DRIVER
> +extern struct pci_driver etnaviv_pci_driver;
> +#endif
> +
> +#endif
