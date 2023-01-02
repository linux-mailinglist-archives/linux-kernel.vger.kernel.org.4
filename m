Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F7865B3AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbjABO75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjABO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:59:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C0B7659
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:59:52 -0800 (PST)
Received: from [192.168.2.142] (109-252-113-89.nat.spd-mgts.ru [109.252.113.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3985C660036F;
        Mon,  2 Jan 2023 14:59:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672671590;
        bh=pr7QKqvU3i2MW8VtEHvkS2Xid3lfTdkU/ArV8Cnv7Tg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CgxebuPvia7ztEmuvxa409ukvvV3j/jxgT026sGBSp+chqnhVCB9FVIFIPTmm92Xi
         Q7oGavLGyhS+Sxc3IV4oKT3j1VDvflDmF+3+OR0zLJsXrt6t+yXBSpgaNzm6PH1Jqm
         K74Tn0xCa2uhq/mmaD55g36lx4/GiPJYOyCuaswRO8rsV+qXiiB/RAlZsEPU0HxVzr
         +TeTk3eoD4s6EdJyBsKUovK2Hps64KQEWe2XNPqwrPZCBaCLHs6rtJMDrndAWpWjsS
         os66iGBzALJwdYiMdrnq2pvQcljSTpdhr+mRNxgzw0k66/JH+1QFlzajkKdkn5Lc9G
         BXlsujBUl1DaQ==
Message-ID: <6ca8b461-c481-bb18-699a-f4671bd773f2@collabora.com>
Date:   Mon, 2 Jan 2023 17:59:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/virtio: Fix memory leak in virtio_gpu_object_create()
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, airlied@redhat.com,
        kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20221109091905.55451-1-xiujianfeng@huawei.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221109091905.55451-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 12:19, Xiu Jianfeng wrote:
> The virtio_gpu_object_shmem_init() will alloc memory and save it in
> @ents, so when virtio_gpu_array_alloc() fails, this memory should be
> freed, this patch fixes it.
> 
> Fixes: e7fef0923303 ("drm/virtio: Simplify error handling of virtio_gpu_object_create()")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 8d7728181de0..c7e74cf13022 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -184,7 +184,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  	struct virtio_gpu_object_array *objs = NULL;
>  	struct drm_gem_shmem_object *shmem_obj;
>  	struct virtio_gpu_object *bo;
> -	struct virtio_gpu_mem_entry *ents;
> +	struct virtio_gpu_mem_entry *ents = NULL;
>  	unsigned int nents;
>  	int ret;
>  
> @@ -210,7 +210,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  		ret = -ENOMEM;
>  		objs = virtio_gpu_array_alloc(1);
>  		if (!objs)
> -			goto err_put_id;
> +			goto err_free_entry;
>  		virtio_gpu_array_add_obj(objs, &bo->base.base);
>  
>  		ret = virtio_gpu_array_lock_resv(objs);
> @@ -239,6 +239,8 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  
>  err_put_objs:
>  	virtio_gpu_array_put_free(objs);
> +err_free_entry:
> +	kvfree(ents);
>  err_put_id:
>  	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
>  err_free_gem:

Applied to drm-misc-fixes

-- 
Best regards,
Dmitry

