Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944B66866D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjBAN22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjBAN20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:28:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9BA3E098
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:28:24 -0800 (PST)
Received: from [192.168.2.186] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A78B56602EC6;
        Wed,  1 Feb 2023 13:28:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675258102;
        bh=6c2RKTiReCGr7vzW6sHVvwtiojFqrg5A+45PxhcJOc4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YkgtvGRK8uTcE47F4QIAprCHvJul4yImNt4IwGc+foJi5iSEDzHB7M/Xd2F+RPw+i
         2bHazY3j8uGjFQbIL3RBVHfBiXCsl9EO5k56lhDz2E8Qr9mXyN4ufYGi5aVF9qj7wk
         56S2jLJxGCp4pifjrBhOTVmpr4/BAj7nsp9tDkX+pSuaSAbLwnbKtN9aWhyd2XSQWl
         dA7d09XJkadPX9U+IZsZwobp2DqmYb8PuxiQZBMhwp3LnI/fbOKogJ59njJcnLDHuh
         3itcz/91xHM1P627OTM49rEjW0MS4LH5ooFtHwFPZ9rP1mybZ1DVfFUqBIltH8gM65
         9bG0/sAtI9jag==
Message-ID: <dee14d1b-fc28-e867-b425-ab11c31d799d@collabora.com>
Date:   Wed, 1 Feb 2023 16:28:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/virtio: exbuf->fence_fd unmodified on interrupted
 wait
Content-Language: en-US
To:     Ryan Neph <ryanneph@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Yiwei Zhang <zzyiwei@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
References: <20230126225815.1518839-1-ryanneph@chromium.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230126225815.1518839-1-ryanneph@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 01:58, Ryan Neph wrote:
> An interrupted dma_fence_wait() becomes an -ERESTARTSYS returned
> to userspace ioctl(DRM_IOCTL_VIRTGPU_EXECBUFFER) calls, prompting to
> retry the ioctl(), but the passed exbuf->fence_fd has been reset to -1,
> making the retry attempt fail at sync_file_get_fence().
> 
> The uapi for DRM_IOCTL_VIRTGPU_EXECBUFFER is changed to retain the
> passed value for exbuf->fence_fd when returning ERESTARTSYS or EINTR.
> 
> Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
> Signed-off-by: Ryan Neph <ryanneph@chromium.org>
> ---
> 
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 9 ++++++---
>  include/uapi/drm/virtgpu_drm.h         | 3 +++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 9f4a90493aea..ffce4e2a409a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -132,6 +132,8 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  	uint64_t fence_ctx;
>  	uint32_t ring_idx;
>  
> +	exbuf->fence_fd = -1;
> +
>  	fence_ctx = vgdev->fence_drv.context;
>  	ring_idx = 0;
>  
> @@ -152,8 +154,6 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  		ring_idx = exbuf->ring_idx;
>  	}
>  
> -	exbuf->fence_fd = -1;

Is there any userspace relying on this -1 behaviour? Wouldn't be better
to remove this offending assignment?

-- 
Best regards,
Dmitry

