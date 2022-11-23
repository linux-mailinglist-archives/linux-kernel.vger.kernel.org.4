Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD96763651D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiKWP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbiKWP6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:58:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58FA9627EA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:58:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D6161FB;
        Wed, 23 Nov 2022 07:58:27 -0800 (PST)
Received: from [10.57.87.10] (unknown [10.57.87.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 262FE3F73B;
        Wed, 23 Nov 2022 07:58:16 -0800 (PST)
Message-ID: <f390d9ec-e8b2-a10d-bd2e-011ec879c615@arm.com>
Date:   Wed, 23 Nov 2022 15:58:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 03/11] drm/gem: Add evict() callback to
 drm_gem_object_funcs
Content-Language: en-GB
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20221123025723.695075-1-dmitry.osipenko@collabora.com>
 <20221123025723.695075-4-dmitry.osipenko@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20221123025723.695075-4-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 02:57, Dmitry Osipenko wrote:
> Add new common evict() callback to drm_gem_object_funcs and corresponding
> drm_gem_object_evict() helper. This is a first step on a way to providing
> common GEM-shrinker API for DRM drivers.
> 
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem.c | 15 +++++++++++++++
>  include/drm/drm_gem.h     | 12 ++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 299bca1390aa..c0510b8080d2 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1458,3 +1458,18 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
>  	return freed;
>  }
>  EXPORT_SYMBOL(drm_gem_lru_scan);
> +
> +/**
> + * drm_gem_object_evict - helper to evict backing pages for a GEM object
> + * @obj: obj in question
> + */
> +bool
> +drm_gem_object_evict(struct drm_gem_object *obj)
> +{
> +	dma_resv_assert_held(obj->resv);
> +
> +	if (obj->funcs->evict)
> +		return obj->funcs->evict(obj);
> +
> +	return false;
> +}

This function needs exporting for the module build to work correctly.

Steve

> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index b46ade812443..add1371453f0 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -172,6 +172,16 @@ struct drm_gem_object_funcs {
>  	 * This is optional but necessary for mmap support.
>  	 */
>  	const struct vm_operations_struct *vm_ops;
> +
> +	/**
> +	 * @evict:
> +	 *
> +	 * Evicts gem object out from memory. Used by the drm_gem_object_evict()
> +	 * helper. Returns true on success, false otherwise.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	bool (*evict)(struct drm_gem_object *obj);
>  };
>  
>  /**
> @@ -480,4 +490,6 @@ unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru,
>  			       unsigned long *remaining,
>  			       bool (*shrink)(struct drm_gem_object *obj));
>  
> +bool drm_gem_object_evict(struct drm_gem_object *obj);
> +
>  #endif /* __DRM_GEM_H__ */

