Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8840C738222
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjFUKBI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 06:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjFUKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:00:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7381910DB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:00:27 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qBudR-0001Ja-Pf; Wed, 21 Jun 2023 12:00:21 +0200
Message-ID: <8f74f0962c8bab6c832919a5340667c54e1a7ddc.camel@pengutronix.de>
Subject: Re: [PATCH v10 07/11] drm/etnaviv: Add support for the dma coherent
 device
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
Date:   Wed, 21 Jun 2023 12:00:17 +0200
In-Reply-To: <20230620094716.2231414-8-18949883232@163.com>
References: <20230620094716.2231414-1-18949883232@163.com>
         <20230620094716.2231414-8-18949883232@163.com>
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
> Loongson CPUs maintain cache coherency by hardware, which means that the
> data in the CPU cache is identical to the data in main system memory. As
> for the peripheral device, most of Loongson chips chose to define the
> peripherals as DMA coherent by default, device drivers do not need to
> maintain the coherency between a processor and an I/O device manually.
> 
> There are exceptions, for LS2K1000 SoC, part of peripheral device can be
> configured as DMA non-coherent. But there is no released version of such
> firmware exist in the market. Peripherals of older LS2K1000 is also DMA
> non-coherent, but they are nearly outdated. So, those are trivial cases.
> 
> Nevertheless, kernel space still need to do the probe work, because vivante
> GPU IP has been integrated into various platform. Hence, this patch add
> runtime detection code to probe if a specific GPU is DMA coherent, If the
> answer is yes, we are going to utilize such features. On Loongson platform,
> When a buffer is accessed by both the GPU and the CPU, the driver should
> prefer ETNA_BO_CACHED over ETNA_BO_WC.
> 
> This patch also add a new parameter: etnaviv_param_gpu_coherent, which
> allow userspace to know if such a feature is available. Because
> write-combined BO is still preferred in some case, especially where don't
> need CPU read, for example, uploading compiled shader bin.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 35 +++++++++++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h       |  6 ++++
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 22 ++++++++++---
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |  7 ++++-
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c       |  4 +++
>  include/uapi/drm/etnaviv_drm.h              |  1 +
>  6 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 0a365e96d371..d8e788aa16cb 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -5,7 +5,9 @@
>  
>  #include <linux/component.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>
>  #include <linux/module.h>
> +#include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/uaccess.h>
>  
> @@ -24,6 +26,34 @@
>  #include "etnaviv_pci_drv.h"
>  #include "etnaviv_perfmon.h"
>  
> +static struct device_node *etnaviv_of_first_available_node(void)
> +{
> +	struct device_node *core_node;
> +
> +	for_each_compatible_node(core_node, NULL, "vivante,gc") {
> +		if (of_device_is_available(core_node))
> +			return core_node;
> +	}
> +
> +	return NULL;
> +}
> +
> +static bool etnaviv_is_dma_coherent(struct device *dev)
> +{
> +	struct device_node *np;
> +	bool coherent;
> +
> +	np = etnaviv_of_first_available_node();
> +	if (np) {
> +		coherent = of_dma_is_coherent(np);
> +		of_node_put(np);
> +	} else {
> +		coherent = dev_is_dma_coherent(dev);
> +	}

This whole dance shouldn't be needed. We transfer the DMA capabilities
from the first node to the virtual master device in the platform device
case, so dev_is_dma_coherent(dev) should always return the right thing.

> +
> +	return coherent;
> +}
> +
>  /*
>   * etnaviv private data construction and destructions:
>   */
> @@ -52,6 +82,11 @@ etnaviv_alloc_private(struct device *dev, struct drm_device *drm)
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> +	priv->dma_coherent = etnaviv_is_dma_coherent(dev);
> +
> +	if (priv->dma_coherent)
> +		drm_info(drm, "%s is dma coherent\n", dev_name(dev));
> +
>  	return priv;
>  }
>  
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> index 9cd72948cfad..644e5712c050 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -46,6 +46,12 @@ struct etnaviv_drm_private {
>  	struct xarray active_contexts;
>  	u32 next_context_id;
>  
> +	/*
> +	 * If true, the GPU is capable of snooping cpu cache. Here, it
> +	 * also means that cache coherency is enforced by the hardware.
> +	 */
> +	bool dma_coherent;
> +
No need for this, I think. Just use dev_is_dma_coherent() where you
need to know this.

>  	/* list of GEM objects: */
>  	struct mutex gem_lock;
>  	struct list_head gem_list;
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index b5f73502e3dd..39bdc3774f2d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -343,6 +343,7 @@ void *etnaviv_gem_vmap(struct drm_gem_object *obj)
>  static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
>  {
>  	struct page **pages;
> +	pgprot_t prot;
>  
>  	lockdep_assert_held(&obj->lock);
>  
> @@ -350,8 +351,19 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
>  	if (IS_ERR(pages))
>  		return NULL;
>  
> -	return vmap(pages, obj->base.size >> PAGE_SHIFT,
> -			VM_MAP, pgprot_writecombine(PAGE_KERNEL));
> +	switch (obj->flags) {

switch (obj->flags & ETNA_BO_CACHE_MASK)

> +	case ETNA_BO_CACHED:
> +		prot = PAGE_KERNEL;
> +		break;
> +	case ETNA_BO_UNCACHED:
> +		prot = pgprot_noncached(PAGE_KERNEL);
> +		break;
> +	case ETNA_BO_WC:
> +	default:
> +		prot = pgprot_writecombine(PAGE_KERNEL);
> +	}
> +
> +	return vmap(pages, obj->base.size >> PAGE_SHIFT, VM_MAP, prot);

While that change makes sense it should also be in a separate patch, as
it's a valid change on its own, even if for non-coherent devices.

>  }
>  
>  static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
> @@ -369,6 +381,7 @@ int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
>  {
>  	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>  	struct drm_device *dev = obj->dev;
> +	struct etnaviv_drm_private *priv = dev->dev_private;
>  	bool write = !!(op & ETNA_PREP_WRITE);
>  	int ret;
>  
> @@ -395,7 +408,7 @@ int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
>  			return ret == 0 ? -ETIMEDOUT : ret;
>  	}
>  
> -	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
> +	if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {

Why do you need this? Isn't dma_sync_sgtable_for_cpu a no-op on your
platform when the device is coherent?

>  		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
>  					 etnaviv_op_to_dma_dir(op));
>  		etnaviv_obj->last_cpu_prep_op = op;
> @@ -408,8 +421,9 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
>  {
>  	struct drm_device *dev = obj->dev;
>  	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
> +	struct etnaviv_drm_private *priv = dev->dev_private;
>  
> -	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
> +	if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {
>  		/* fini without a prep is almost certainly a userspace error */
>  		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
>  		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> index 3524b5811682..754126992264 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -112,11 +112,16 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
>  struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>  	struct dma_buf_attachment *attach, struct sg_table *sgt)
>  {
> +	struct etnaviv_drm_private *priv = dev->dev_private;
>  	struct etnaviv_gem_object *etnaviv_obj;
>  	size_t size = PAGE_ALIGN(attach->dmabuf->size);
> +	u32 cache_flags = ETNA_BO_WC;
>  	int ret, npages;
>  
> -	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
> +	if (priv->dma_coherent)
> +		cache_flags = ETNA_BO_CACHED;
> +
Drop this change. Instead etnaviv_gem_new_impl() should do the upgrade
from WC to CACHED as necessary by adding something like this:

/*
 * Upgrade WC to CACHED when the device is hardware coherent and the
 * platform doesn't allow mixing cached and writecombined mappings to
 * the same memory area.
 */
if ((flags & ETNA_BO_CACHE_MASK) == ETNA_BO_WC &&
    dev_is_dma_coherent(dev) && !drm_arch_can_wc_memory())
        flags = (flags & ~ETNA_BO_CACHE_MASK) & ETNA_BO_CACHED;

Regards,
Lucas

> +	ret = etnaviv_gem_new_private(dev, size, cache_flags,
>  				      &etnaviv_gem_prime_ops, &etnaviv_obj);
>  	if (ret < 0)
>  		return ERR_PTR(ret);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index d6a21e97feb1..d99ac675ce8b 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -164,6 +164,10 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
>  		*value = gpu->identity.eco_id;
>  		break;
>  
> +	case ETNAVIV_PARAM_GPU_COHERENT:
> +		*value = priv->dma_coherent;
> +		break;
> +
>  	default:
>  		DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
>  		return -EINVAL;
> diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
> index af024d90453d..76baf45d7158 100644
> --- a/include/uapi/drm/etnaviv_drm.h
> +++ b/include/uapi/drm/etnaviv_drm.h
> @@ -77,6 +77,7 @@ struct drm_etnaviv_timespec {
>  #define ETNAVIV_PARAM_GPU_PRODUCT_ID                0x1c
>  #define ETNAVIV_PARAM_GPU_CUSTOMER_ID               0x1d
>  #define ETNAVIV_PARAM_GPU_ECO_ID                    0x1e
> +#define ETNAVIV_PARAM_GPU_COHERENT                  0x1f
>  
>  #define ETNA_MAX_PIPES 4
>  

