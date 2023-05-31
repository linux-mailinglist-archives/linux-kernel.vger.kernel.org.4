Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58863718776
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEaQeh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 12:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjEaQec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:34:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218FD1A7
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:34:00 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1q4Oll-0007Z0-9S; Wed, 31 May 2023 18:33:53 +0200
Message-ID: <35c15c0912b4a9372b9c2194a46b518ce515ce3d.camel@pengutronix.de>
Subject: Re: [PATCH v6 6/6] drm/etnaviv: allow usperspace create cached
 coherent bo
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Date:   Wed, 31 May 2023 18:33:50 +0200
In-Reply-To: <20230530160643.2344551-7-suijingfeng@loongson.cn>
References: <20230530160643.2344551-1-suijingfeng@loongson.cn>
         <20230530160643.2344551-7-suijingfeng@loongson.cn>
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

Hi Sui Jingfeng,

Am Mittwoch, dem 31.05.2023 um 00:06 +0800 schrieb Sui Jingfeng:
> cached system RAM is coherent on loongson CPUs, and the GPU and DC allways
> snoop the CPU's cache. write-combine caching property is not suitiable for
> us.
> 
As previously mentioned in the Mesa MR, I don't think this is the right
approach.

ETNA_BO_CACHED already looks coherent to userspace, as all accesses are
bracketed via the ETNAVIV_GEM_CPU_PREP and ETNAVIV_GEM_CPU_FINI ioctls,
which will do the necessary cache maintenance on platforms where device
coherence isn't enforced by the hardware, so there is no need for a
separate ETNA_BO_CACHED_COHERENT.

Instead we just need a new ETNAVIV_PARAM to inform userspace about
hardware cache coherence being available for a specific GPU core, in
which case the userspace driver should switch to preferring
ETNA_BO_CACHED over ETNA_BO_WC.

Regards,
Lucas

> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c       |  2 +-
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 22 +++++++++++++++++++--
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |  9 ++++++++-
>  include/uapi/drm/etnaviv_drm.h              | 11 ++++++-----
>  4 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 052f745cecc0..2816c654c023 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -274,7 +274,7 @@ static int etnaviv_ioctl_gem_new(struct drm_device *dev, void *data,
>  	struct drm_etnaviv_gem_new *args = data;
>  
>  	if (args->flags & ~(ETNA_BO_CACHED | ETNA_BO_WC | ETNA_BO_UNCACHED |
> -			    ETNA_BO_FORCE_MMU))
> +			    ETNA_BO_CACHED_COHERENT | ETNA_BO_FORCE_MMU))
>  		return -EINVAL;
>  
>  	return etnaviv_gem_new_handle(dev, file, args->size,
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index b5f73502e3dd..d8b559bd33d3 100644
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
> @@ -350,8 +351,20 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
>  	if (IS_ERR(pages))
>  		return NULL;
>  
> -	return vmap(pages, obj->base.size >> PAGE_SHIFT,
> -			VM_MAP, pgprot_writecombine(PAGE_KERNEL));
> +	switch (obj->flags) {
> +	case ETNA_BO_CACHED_COHERENT:
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
>  }
>  
>  static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
> @@ -545,6 +558,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
>  static int etnaviv_gem_new_impl(struct drm_device *dev, u32 size, u32 flags,
>  	const struct etnaviv_gem_ops *ops, struct drm_gem_object **obj)
>  {
> +	struct etnaviv_drm_private *priv = dev->dev_private;
>  	struct etnaviv_gem_object *etnaviv_obj;
>  	unsigned sz = sizeof(*etnaviv_obj);
>  	bool valid = true;
> @@ -555,6 +569,10 @@ static int etnaviv_gem_new_impl(struct drm_device *dev, u32 size, u32 flags,
>  	case ETNA_BO_CACHED:
>  	case ETNA_BO_WC:
>  		break;
> +	case ETNA_BO_CACHED_COHERENT:
> +		if (priv->has_cached_coherent)
> +			break;
> +		fallthrough;
>  	default:
>  		valid = false;
>  	}
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> index 3524b5811682..671d91d8f1c6 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -112,11 +112,18 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
>  struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>  	struct dma_buf_attachment *attach, struct sg_table *sgt)
>  {
> +	struct etnaviv_drm_private *priv = dev->dev_private;
>  	struct etnaviv_gem_object *etnaviv_obj;
>  	size_t size = PAGE_ALIGN(attach->dmabuf->size);
> +	u32 cache_flags;
>  	int ret, npages;
>  
> -	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
> +	if (priv->has_cached_coherent)
> +		cache_flags = ETNA_BO_CACHED_COHERENT;
> +	else
> +		cache_flags = ETNA_BO_WC;
> +
> +	ret = etnaviv_gem_new_private(dev, size, cache_flags,
>  				      &etnaviv_gem_prime_ops, &etnaviv_obj);
>  	if (ret < 0)
>  		return ERR_PTR(ret);
> diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
> index af024d90453d..474b0db286de 100644
> --- a/include/uapi/drm/etnaviv_drm.h
> +++ b/include/uapi/drm/etnaviv_drm.h
> @@ -90,13 +90,14 @@ struct drm_etnaviv_param {
>   * GEM buffers:
>   */
>  
> -#define ETNA_BO_CACHE_MASK   0x000f0000
> +#define ETNA_BO_CACHE_MASK              0x000f0000
>  /* cache modes */
> -#define ETNA_BO_CACHED       0x00010000
> -#define ETNA_BO_WC           0x00020000
> -#define ETNA_BO_UNCACHED     0x00040000
> +#define ETNA_BO_CACHED                  0x00010000
> +#define ETNA_BO_WC                      0x00020000
> +#define ETNA_BO_UNCACHED                0x00040000
> +#define ETNA_BO_CACHED_COHERENT         0x00080000
>  /* map flags */
> -#define ETNA_BO_FORCE_MMU    0x00100000
> +#define ETNA_BO_FORCE_MMU               0x00100000
>  
>  struct drm_etnaviv_gem_new {
>  	__u64 size;           /* in */

