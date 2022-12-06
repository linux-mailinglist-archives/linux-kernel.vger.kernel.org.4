Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104BE643A61
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiLFAmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiLFAle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:41:34 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D32E2D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ATfntEczgiDIz1NDR8g2Hsjkm0/EyiJMOTZLTQtWJWg=; b=snYz7qIe6fDQfVdAt/V32OhLKp
        9iYax2sUhBchWYv8rmbPO/zIM+fKSCYkut7xVShWYvuG4x1+yMJm9jkngjm1V/E+GLs3U0lvHkDCQ
        NxA4tN07eCTd0QCdZNtljFyurPfL+FndvCAufaYgbyUqldYilV+e15bVIdLijamOPQor/CIegVyEG
        z4bdTFO13L2ZLGtpsEV3LHKhnLp0ZH91XI6XJqMYThPg+esxm285GNaJR/si96r9ACHzDd0n6AMJn
        wa4HjYe+QL2M5/fChv+bRGCDO0kx6YVHldWHfy+mnuD/mJFdzax3nas8lKng12k01W7ALYS9eLuqA
        UcnTNMAg==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p2M1W-00FpWu-3X; Tue, 06 Dec 2022 01:41:26 +0100
Message-ID: <66a7178e-5af2-2aab-dc3f-3c1a4ef991dd@igalia.com>
Date:   Mon, 5 Dec 2022 21:41:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] drm/v3d: replace obj lookup steps with
 drm_gem_objects_lookup
Content-Language: en-US
To:     Melissa Wen <mwen@igalia.com>, emma@anholt.net, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel-dev@igalia.com
References: <20221205135538.3545051-1-mwen@igalia.com>
 <20221205135538.3545051-3-mwen@igalia.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221205135538.3545051-3-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 10:55, Melissa Wen wrote:
> As v3d_lookup_bos() performs the same steps as drm_gem_objects_lookup(),
> replace the explicit code in v3d to simply use the DRM function.
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra Canal

> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 49 +++--------------------------------
>  1 file changed, 3 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 31a37572c11d..6e152ef26358 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -299,10 +299,6 @@ v3d_lookup_bos(struct drm_device *dev,
>  	       u64 bo_handles,
>  	       u32 bo_count)
>  {
> -	u32 *handles;
> -	int ret = 0;
> -	int i;
> -
>  	job->bo_count = bo_count;
>  
>  	if (!job->bo_count) {
> @@ -313,48 +309,9 @@ v3d_lookup_bos(struct drm_device *dev,
>  		return -EINVAL;
>  	}
>  
> -	job->bo = kvmalloc_array(job->bo_count,
> -				 sizeof(struct drm_gem_dma_object *),
> -				 GFP_KERNEL | __GFP_ZERO);
> -	if (!job->bo) {
> -		DRM_DEBUG("Failed to allocate validated BO pointers\n");
> -		return -ENOMEM;
> -	}
> -
> -	handles = kvmalloc_array(job->bo_count, sizeof(u32), GFP_KERNEL);
> -	if (!handles) {
> -		ret = -ENOMEM;
> -		DRM_DEBUG("Failed to allocate incoming GEM handles\n");
> -		goto fail;
> -	}
> -
> -	if (copy_from_user(handles,
> -			   (void __user *)(uintptr_t)bo_handles,
> -			   job->bo_count * sizeof(u32))) {
> -		ret = -EFAULT;
> -		DRM_DEBUG("Failed to copy in GEM handles\n");
> -		goto fail;
> -	}
> -
> -	spin_lock(&file_priv->table_lock);
> -	for (i = 0; i < job->bo_count; i++) {
> -		struct drm_gem_object *bo = idr_find(&file_priv->object_idr,
> -						     handles[i]);
> -		if (!bo) {
> -			DRM_DEBUG("Failed to look up GEM BO %d: %d\n",
> -				  i, handles[i]);
> -			ret = -ENOENT;
> -			spin_unlock(&file_priv->table_lock);
> -			goto fail;
> -		}
> -		drm_gem_object_get(bo);
> -		job->bo[i] = bo;
> -	}
> -	spin_unlock(&file_priv->table_lock);
> -
> -fail:
> -	kvfree(handles);
> -	return ret;
> +	return drm_gem_objects_lookup(file_priv,
> +				      (void __user *)(uintptr_t)bo_handles,
> +				      job->bo_count, &job->bo);
>  }
>  
>  static void
