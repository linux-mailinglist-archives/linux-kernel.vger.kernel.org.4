Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847576A2A68
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBYPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:10:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC916AC9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:10:24 -0800 (PST)
Received: from [192.168.2.94] (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 13EAD6602FB5;
        Sat, 25 Feb 2023 15:10:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677337823;
        bh=QWfKCC4Am+Y7TwL7oM0nwr+UpJ9zP/sYC7O0NznU9Eo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iUbLMANC2NH818PnJVYMr9mFDsd+u165MOh0arNHQbcPwNw5fucp08f5VUrxaNQ7H
         kL0I/1KD71lKUSEGrq0v/1evR5jgB3243935Lagaqs4J9xo6NTbOP3Ko5VeWPjImME
         okI2ZiIqjl3n06CUa9KG51ANE+MyoiT0BBhFS0pOCH2UItqoexC/9k566uBD6P3KYH
         T0ASHqjqXMu0gqK09pqGkQs37L9W7XmWO5QZQIrjmkIMX4sx8Hi+Q/9la3OxmQ2+xZ
         dDVTr+aTnN20SInePFGfW0iVDCLl22USfSGOj/hggSXPz5HXNJl+ZQlk+85KDoQypM
         7M1PObQO9XIpA==
Message-ID: <49ce15b2-4f18-77a3-539d-fd9a97126fb8@collabora.com>
Date:   Sat, 25 Feb 2023 18:10:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/virtio: Add option to disable KMS support
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Chia-I Wu <olvaffe@gmail.com>, Ryan Neph <ryanneph@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230224180225.2477641-1-robdclark@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230224180225.2477641-1-robdclark@gmail.com>
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

On 2/24/23 21:02, Rob Clark wrote:
>  obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index ae97b98750b6..9cb7d6dd3da6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -172,7 +172,11 @@ MODULE_AUTHOR("Alon Levy");
>  DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
>  
>  static const struct drm_driver driver = {
> -	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC,
> +	.driver_features =
> +#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)

Could you please replace s/defined/IS_ENABLED/ and also the #ifdefs with
"if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS))" in the code? The ifdefs are
always not nice to have in the code. The IS_ENABLED usage will also make
code compile-tested regardless of the CONFIG_DRM_VIRTIO_GPU_KMS option
state.

Otherwise looks good!

-- 
Best regards,
Dmitry

