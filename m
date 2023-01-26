Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978B467CAF7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbjAZMgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbjAZMgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:36:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B376224D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:36:18 -0800 (PST)
Received: from [192.168.2.197] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9434A6602E6E;
        Thu, 26 Jan 2023 12:36:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674736577;
        bh=G23dxVomulEtMefdUSUB7DiwKvHMsAQAGCle357P/iE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=k2FKZbSOFNRYAUSUeJcX3usY4lqrL/0I9Ul1x7jvOBbzkiehYHd5BUtRMAyNS0+Bz
         kCVqgl38xb7R2LQiLvXXkkQu81Cul3Wg7UW7+weJnQD03TNI/6geF/6770kqB9oM2t
         5oUsEtaF9nIqPvPfyAuCfP65IeEYZZ77VYID7Q/9OtLc/tLMCjVcI/xr0iSXx7SefI
         awTegMoW7EHyvdkPPpP4/37nz/emqZgxMZUgLHFPb6vNbPND4YlnYHgkEI4OQkDjjW
         FG5N4odQV1V0nrl2dg6qbkrV9n34ftZe0zRVpkjer273+BgxIvAReMCzg1UT/OMC28
         NCHaZhV7+JqVg==
Message-ID: <98abc458-579b-1461-aece-7e13132c588a@collabora.com>
Date:   Thu, 26 Jan 2023 15:36:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1] drm/shmem-helper: Remove another errant put in error
 path
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Rob Clark <robdclark@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230108211311.3950107-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20230108211311.3950107-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 00:13, Dmitry Osipenko wrote:
> drm_gem_shmem_mmap() doesn't own reference in error code path, resulting
> in the dma-buf shmem GEM object getting prematurely freed leading to a
> later use-after-free.
> 
> Fixes: f49a51bfdc8e ("drm/shme-helpers: Fix dma_buf_mmap forwarding bug")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index f21f47737817..8b20b41497e8 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -624,11 +624,14 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
>  	int ret;
>  
>  	if (obj->import_attach) {
> -		/* Drop the reference drm_gem_mmap_obj() acquired.*/
> -		drm_gem_object_put(obj);
>  		vma->vm_private_data = NULL;
> +		ret = dma_buf_mmap(obj->dma_buf, vma, 0);
> +
> +		/* Drop the reference drm_gem_mmap_obj() acquired.*/
> +		if (!ret)
> +			drm_gem_object_put(obj);
>  
> -		return dma_buf_mmap(obj->dma_buf, vma, 0);
> +		return ret;
>  	}
>  
>  	ret = drm_gem_shmem_get_pages(shmem);

Rob, is this change still looking good to you? r-b? Thanks!

-- 
Best regards,
Dmitry

