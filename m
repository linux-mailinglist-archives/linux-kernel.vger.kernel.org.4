Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62EF6D0CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjC3RZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjC3RY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:24:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47822D55
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:24:55 -0700 (PDT)
Received: from arch-x395 (unknown [IPv6:2a00:5f00:102:0:38b0:2479:c2d8:9a86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: evelikov)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA6496602F6A;
        Thu, 30 Mar 2023 18:24:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680197093;
        bh=V8BWybAwlz2UVgTWThMD8IWctSismFf3F23v7AiQ7Ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q107qfRF1on+Eipk/3DuvirmZThiwpH+3IVOEAft8sbtOHUjYuANiNHY+0+5Hj+Mt
         Uejj3YHHXEWDvPML9DSMi4RqIK4+nur0Z4QGKoKbulXVPbIXqt657u3WQ2jMf7zV5S
         WrXclYSM1ed1NdoGz+BAQ1ytIh9YiyWfPAbV1YwJiaO5TcNn90xHqKYyaEvZ4x73Jw
         MROUO/U6k307BeIToBQ1n7+/Rg3JkBm6mTq7+xYbsdFOFHB3HIJwi68QHeVPInch8U
         RQA3F+kWHBvUOjx08iX6akyTQ8qG2DGe7JtmLFY0yzAoNdh+j27JSQZ0FGNrdXCRBd
         +PRQ7feG6QPmA==
Date:   Thu, 30 Mar 2023 18:24:50 +0100
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Marek =?utf-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 2/2] drm/virtio: Support sync objects
Message-ID: <ZCXF4q81wPcczkqx@arch-x395>
References: <20230323230755.1094832-1-dmitry.osipenko@collabora.com>
 <20230323230755.1094832-3-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323230755.1094832-3-dmitry.osipenko@collabora.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Have you considered creating a few DRM helpers for this functionality?

AFAICT this is the third driver which supports syncobj timelines and
looking at one of the implementations ... it is not great. Note that
this suggestion is _not_ a blocker.

On 2023/03/24, Dmitry Osipenko wrote:
> Add sync object DRM UAPI support to VirtIO-GPU driver. It's required
> for enabling a full-featured Vulkan fencing by Venus and native context
> VirtIO-GPU Mesa drivers.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---

> +static int
> +virtio_gpu_parse_deps(struct virtio_gpu_submit *submit)
> +{
> +	struct drm_virtgpu_execbuffer *exbuf = submit->exbuf;
> +	struct drm_virtgpu_execbuffer_syncobj syncobj_desc;
> +	size_t syncobj_stride = exbuf->syncobj_stride;
> +	struct drm_syncobj **syncobjs;
> +	int ret = 0, i;
> +
> +	if (!submit->num_in_syncobjs)
> +		return 0;
> +
> +	syncobjs = kvcalloc(submit->num_in_syncobjs, sizeof(*syncobjs),
> +			    GFP_KERNEL);

Please add an inline note about the decision behind the allocators used,
both here and in the parse_post_deps below. IIRC there was some nice
discussion between you and Rob in earlier revisions.


> +	if (!syncobjs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < submit->num_in_syncobjs; i++) {
> +		uint64_t address = exbuf->in_syncobjs + i * syncobj_stride;
> +		struct dma_fence *fence;
> +
> +		if (copy_from_user(&syncobj_desc,
> +				   u64_to_user_ptr(address),
> +				   min(syncobj_stride, sizeof(syncobj_desc)))) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		if (syncobj_desc.flags & ~VIRTGPU_EXECBUF_SYNCOBJ_FLAGS) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		ret = drm_syncobj_find_fence(submit->file, syncobj_desc.handle,
> +					     syncobj_desc.point, 0, &fence);
> +		if (ret)
> +			break;
> +

> +		ret = virtio_gpu_dma_fence_wait(submit, fence);
> +
> +		dma_fence_put(fence);
> +		if (ret)
> +			break;

If going the DRM helpers route:

The above two are effectively the only variance across vendors - a
simple function point as arg should suffice. Might want to use internal
flags, but that's also trivial.

> +	submit->in_syncobjs = syncobjs;
> +
> +	return ret;
> +}
> +
> +static void virtio_gpu_reset_syncobjs(struct drm_syncobj **syncobjs,
> +				      uint32_t nr_syncobjs)
> +{
> +	uint32_t i;
> +
> +	for (i = 0; i < nr_syncobjs; i++) {
> +		if (syncobjs[i])
> +			drm_syncobj_replace_fence(syncobjs[i], NULL);

Side note: the drm_syncobj_put() called immediately after also calls
replace/reset fence internally. Although reading from the docs, I'm not
sure if relying on that is a wise move.

Just thought I'd point it out.


>  
> +	ret = virtio_gpu_parse_deps(&submit);
> +	if (ret)
> +		goto cleanup;
> +
> +	ret = virtio_gpu_parse_post_deps(&submit);
> +	if (ret)
> +		goto cleanup;
> +

I think we should zero num_(in|out)_syncobjs when the respective parse
fails. Otherwise we get one "cleanup" within the parse function itself
and a second during the cleanup_submit. Haven't looked at it too closely
but I suspect that will trigger an UAF or two.

>  	ret = virtio_gpu_install_out_fence_fd(&submit);
>  	if (ret)
>  		goto cleanup;
> @@ -294,6 +512,7 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  		goto cleanup;
>  
>  	virtio_gpu_submit(&submit);
> +	virtio_gpu_process_post_deps(&submit);

Any particular reason why the virtio_gpu_reset_syncobjs is deferred to
virtio_gpu_cleanup_submit(). Having it just above the process_post_deps
(similar to msm) allows the reader to get closure about the in syncobjs.

This is just personal preference, so don't read too much into it.

HTH
Emil
