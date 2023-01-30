Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73585680A71
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbjA3KIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbjA3KIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:08:39 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951D030280
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675073317; x=1706609317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mo5yexCA/ZrKtoN97r7pTE+FhCESycsJPmqk4RiCrdM=;
  b=ZXrdZL1jQ3sQjLCl5gHK0p06Q+xhDA0Qf0fsttNXvMezVesDYY1j+3v0
   5ebbVMxi+VHNwN2DxgoUI3wYX10PdvHdMe2iN3mZLE3HsJcWeUI/Z2k/i
   yvbMCHX3JryyymLEZpzNITpK9GnyH7D7lgyJtRA4Ha9VygIJsDwtbAPfs
   M4M5Pr4AbUgzVFclHNpXaEtJtBFjh9zVCfHXP3x1XAJ5wJ7tm/AWVux51
   8pyTU6XCI+F6gOLtwZYDmgDSBZCkYx/jcN8wSzXRQTXkGLIwMhtKRgaH2
   zQs9L4CUSgK+UsP+RG+nYpVqWh8hS0Uz2qwCugFI3jmhDh49BJmwzJDZF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="327538537"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="327538537"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 02:08:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="664037045"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="664037045"
Received: from pjoconno-mobl1.ger.corp.intel.com (HELO [10.213.216.153]) ([10.213.216.153])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 02:08:22 -0800
Message-ID: <5908ac91-bb6c-7ea9-0f2a-88054fe1b24d@linux.intel.com>
Date:   Mon, 30 Jan 2023 10:08:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/i915: Fix potential bit_17 double-free
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        pengfuyuan <pengfuyuan@kylinos.cn>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
References: <20230127200550.3531984-1-robdclark@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230127200550.3531984-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/01/2023 20:05, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> A userspace with multiple threads racing I915_GEM_SET_TILING to set the
> tiling to I915_TILING_NONE could trigger a double free of the bit_17
> bitmask.  (Or conversely leak memory on the transition to tiled.)  Move
> allocation/free'ing of the bitmask within the section protected by the
> obj lock.
> 
> Fixes: e9b73c67390a ("drm/i915: Reduce memory pressure during shrinker by preallocating swizzle pages")

Should be:

Fixes: 2850748ef876 ("drm/i915: Pull i915_vma_pin under the vm->mutex")

Before that commit there as a "BKL" (struct_mutex) aroung the call to 
i915_gem_object_set_tiling. Otherwise fix looks good:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

I'll tweak the fixes tag and merge in a minute, thanks for the fix!

Regards,

Tvrtko

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_tiling.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_tiling.c b/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
> index fd42b89b7162..bc21b1c2350a 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
> @@ -298,36 +298,37 @@ i915_gem_object_set_tiling(struct drm_i915_gem_object *obj,
>   		vma->fence_alignment =
>   			i915_gem_fence_alignment(i915,
>   						 vma->size, tiling, stride);
>   
>   		if (vma->fence)
>   			vma->fence->dirty = true;
>   	}
>   	spin_unlock(&obj->vma.lock);
>   
>   	obj->tiling_and_stride = tiling | stride;
> -	i915_gem_object_unlock(obj);
> -
> -	/* Force the fence to be reacquired for GTT access */
> -	i915_gem_object_release_mmap_gtt(obj);
>   
>   	/* Try to preallocate memory required to save swizzling on put-pages */
>   	if (i915_gem_object_needs_bit17_swizzle(obj)) {
>   		if (!obj->bit_17) {
>   			obj->bit_17 = bitmap_zalloc(obj->base.size >> PAGE_SHIFT,
>   						    GFP_KERNEL);
>   		}
>   	} else {
>   		bitmap_free(obj->bit_17);
>   		obj->bit_17 = NULL;
>   	}
>   
> +	i915_gem_object_unlock(obj);
> +
> +	/* Force the fence to be reacquired for GTT access */
> +	i915_gem_object_release_mmap_gtt(obj);
> +
>   	return 0;
>   }
>   
>   /**
>    * i915_gem_set_tiling_ioctl - IOCTL handler to set tiling mode
>    * @dev: DRM device
>    * @data: data pointer for the ioctl
>    * @file: DRM file for the ioctl call
>    *
>    * Sets the tiling mode of an object, returning the required swizzling of
