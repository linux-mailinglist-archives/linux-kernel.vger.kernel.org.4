Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822CC6260E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiKKSLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiKKSKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:10:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBF063BAD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:10:42 -0800 (PST)
Received: from [192.168.2.108] (unknown [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F13536602A42;
        Fri, 11 Nov 2022 18:10:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668190240;
        bh=hCCpAhbEUa8/LLXwnIV87nxTTDpc6b/4kcIs4Wr2NCA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FMWR7sfUtjAPriAKjr5fzNysq0wiHmmdmIJbK3fI+sciVImumGHugv0Aaj2x3DJBU
         evQQjtszZXUsKNMzvEcLxwAO7GtC/wGHv8m8uYLvO5EmTBg8JaDBUyZUNwphTpAEFL
         T4QqFCVvovGqX72hrk0u9x11/mxsrsRniaQApO4YCFGIvuHuxhjpLzdDrdaXjAajdR
         ogV8C5gmBLTjUU+tifs8lvulhSCdPzJXxyjhkZ38Yxynf/DSPi4anaOFEvGwPLFrD3
         QE/yaB+MkOvPPu9MbFnmH33u2SLrnZL+PtwCP+MDf5mjFSEaYbkCJ5j0eLxuVhlgqw
         cvebJ1wgapHmg==
Message-ID: <9add69a6-9e81-9e5a-b039-fe869c2f3179@collabora.com>
Date:   Fri, 11 Nov 2022 21:10:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] drm/virtio: Fix memory leak in virtio_gpu_object_create()
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, airlied@redhat.com,
        kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20221109091905.55451-1-xiujianfeng@huawei.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221109091905.55451-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

