Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1A72F8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbjFNJNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjFNJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:13:49 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 923B210C2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:13:46 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cxe+rJhIlkAA8FAA--.10753S3;
        Wed, 14 Jun 2023 17:13:45 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxluTHhIlkSm0aAA--.9967S3;
        Wed, 14 Jun 2023 17:13:43 +0800 (CST)
Message-ID: <881445a7-e711-5d68-6c7c-de6b014b586b@loongson.cn>
Date:   Wed, 14 Jun 2023 17:13:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 7/9] drm/etnaviv: Add support for the dma coherent
 device
To:     Sui Jingfeng <15330273260@189.cn>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20230614024745.865129-1-15330273260@189.cn>
 <20230614024745.865129-8-15330273260@189.cn>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <20230614024745.865129-8-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxluTHhIlkSm0aAA--.9967S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw15tw45CF18JryfGF4fCrX_yoWfAF18pF
        s7AFyYyrW0vFWj934xAF1rZFyagw1xWFWFk3srtwn093y5tF1Utr1jkFn8CrZ8Jr1fWr4a
        qr1qyry3AF4UZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4U
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7pnQUU
        UUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/14 10:47, Sui Jingfeng wrote:
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
> need CPU read, for example, uploading shader bin.
>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>   drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 34 +++++++++++++++++++++
>   drivers/gpu/drm/etnaviv/etnaviv_drv.h       |  6 ++++
>   drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 22 ++++++++++---
>   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |  7 ++++-
>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c       |  4 +++
>   include/uapi/drm/etnaviv_drm.h              |  1 +
>   6 files changed, 69 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 0a365e96d371..1c9386e5a1b0 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -5,7 +5,9 @@
>   
>   #include <linux/component.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>
>   #include <linux/module.h>
> +#include <linux/of_address.h>
>   #include <linux/of_platform.h>
>   #include <linux/uaccess.h>
>   
> @@ -24,6 +26,34 @@
>   #include "etnaviv_pci_drv.h"
>   #include "etnaviv_perfmon.h"
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
> +
> +	return coherent;
> +}
> +
>   /*
>    * etnaviv private data construction and destructions:
>    */
> @@ -52,6 +82,10 @@ etnaviv_alloc_private(struct device *dev, struct drm_device *drm)
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> +	priv->dma_coherent = etnaviv_is_dma_coherent(dev);
> +
> +	drm_info(drm, "%s is dma coherent\n", dev_name(dev));
> +

Here, we missing a if (priv->dma_coherent), sorry

```

     if (priv->dma_coherent)

            drm_info(drm, "%s is dma coherent\n", dev_name(dev));

```

>   	return priv;
>   }
>   
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> index 9cd72948cfad..644e5712c050 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -46,6 +46,12 @@ struct etnaviv_drm_private {
>   	struct xarray active_contexts;
>   	u32 next_context_id;
>   
> +	/*
> +	 * If true, the GPU is capable of snooping cpu cache. Here, it
> +	 * also means that cache coherency is enforced by the hardware.
> +	 */
> +	bool dma_coherent;
> +
>   	/* list of GEM objects: */
>   	struct mutex gem_lock;
>   	struct list_head gem_list;
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index b5f73502e3dd..39bdc3774f2d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -343,6 +343,7 @@ void *etnaviv_gem_vmap(struct drm_gem_object *obj)
>   static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
>   {
>   	struct page **pages;
> +	pgprot_t prot;
>   
>   	lockdep_assert_held(&obj->lock);
>   
> @@ -350,8 +351,19 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
>   	if (IS_ERR(pages))
>   		return NULL;
>   
> -	return vmap(pages, obj->base.size >> PAGE_SHIFT,
> -			VM_MAP, pgprot_writecombine(PAGE_KERNEL));
> +	switch (obj->flags) {
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
>   }
>   
>   static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
> @@ -369,6 +381,7 @@ int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
>   {
>   	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>   	struct drm_device *dev = obj->dev;
> +	struct etnaviv_drm_private *priv = dev->dev_private;
>   	bool write = !!(op & ETNA_PREP_WRITE);
>   	int ret;
>   
> @@ -395,7 +408,7 @@ int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
>   			return ret == 0 ? -ETIMEDOUT : ret;
>   	}
>   
> -	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
> +	if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {
>   		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
>   					 etnaviv_op_to_dma_dir(op));
>   		etnaviv_obj->last_cpu_prep_op = op;
> @@ -408,8 +421,9 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
>   {
>   	struct drm_device *dev = obj->dev;
>   	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
> +	struct etnaviv_drm_private *priv = dev->dev_private;
>   
> -	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
> +	if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {
>   		/* fini without a prep is almost certainly a userspace error */
>   		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
>   		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> index 3524b5811682..754126992264 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -112,11 +112,16 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
>   struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>   	struct dma_buf_attachment *attach, struct sg_table *sgt)
>   {
> +	struct etnaviv_drm_private *priv = dev->dev_private;
>   	struct etnaviv_gem_object *etnaviv_obj;
>   	size_t size = PAGE_ALIGN(attach->dmabuf->size);
> +	u32 cache_flags = ETNA_BO_WC;
>   	int ret, npages;
>   
> -	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
> +	if (priv->dma_coherent)
> +		cache_flags = ETNA_BO_CACHED;
> +
> +	ret = etnaviv_gem_new_private(dev, size, cache_flags,
>   				      &etnaviv_gem_prime_ops, &etnaviv_obj);
>   	if (ret < 0)
>   		return ERR_PTR(ret);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index d6a21e97feb1..d99ac675ce8b 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -164,6 +164,10 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
>   		*value = gpu->identity.eco_id;
>   		break;
>   
> +	case ETNAVIV_PARAM_GPU_COHERENT:
> +		*value = priv->dma_coherent;
> +		break;
> +
>   	default:
>   		DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
>   		return -EINVAL;
> diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
> index af024d90453d..76baf45d7158 100644
> --- a/include/uapi/drm/etnaviv_drm.h
> +++ b/include/uapi/drm/etnaviv_drm.h
> @@ -77,6 +77,7 @@ struct drm_etnaviv_timespec {
>   #define ETNAVIV_PARAM_GPU_PRODUCT_ID                0x1c
>   #define ETNAVIV_PARAM_GPU_CUSTOMER_ID               0x1d
>   #define ETNAVIV_PARAM_GPU_ECO_ID                    0x1e
> +#define ETNAVIV_PARAM_GPU_COHERENT                  0x1f
>   
>   #define ETNA_MAX_PIPES 4
>   

-- 
Jingfeng

