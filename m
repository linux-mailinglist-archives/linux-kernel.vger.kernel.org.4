Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DC86D09BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjC3PdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjC3PdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:33:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1F0E07D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:32:39 -0700 (PDT)
Received: from arch-x395 (unknown [IPv6:2a00:5f00:102:0:38b0:2479:c2d8:9a86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: evelikov)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22E266603182;
        Thu, 30 Mar 2023 16:32:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680190334;
        bh=p9xh2PGZwQUEhazq04vRmfAksY+FnI7rW348g3zN2ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WpafA6xLX8wNLW7t10cXCU1KfzEIcmMuics5cKSh6JH1h8wYUfEMvgoQSQWRLjia0
         eJaYZp59H06LB7g0RxRhK9epvk4tdPdGOh3ih+QXtb9sGa292ImluHraX4ZPkhuS//
         +1cWUhK+nR8TPSUh5JEadRtr4gmbvhW1jDbe1CRyLWgw4YwDQlkvyT4eREvPdustP7
         dD36PeBBkprVDuKPz1H6BZJAbt2TYmXQWbivzUQXDK9b4wegLMufO4Q2qusE2njfnm
         7+y2EyywSKbtgMqdeVDxQcBy9A3eRdZtTpB+/xyGeDrDMSISYjI2puTaDx6Pwg7QS6
         oK6O/t0Nm6A6A==
Date:   Thu, 30 Mar 2023 16:32:11 +0100
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
Subject: Re: [PATCH v4 1/2] drm/virtio: Refactor job submission code path
Message-ID: <ZCWre6oy0vHNyIkW@arch-x395>
References: <20230323230755.1094832-1-dmitry.osipenko@collabora.com>
 <20230323230755.1094832-2-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323230755.1094832-2-dmitry.osipenko@collabora.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dmitry,

On 2023/03/24, Dmitry Osipenko wrote:
> Move virtio_gpu_execbuffer_ioctl() into separate virtgpu_submit.c file
> and refactor the code along the way to ease addition of new features to
> the ioctl.
> 

At a glance, we have a handful of no-op as well as some functional
changes - let's split those up in separate patches.

> Reviewed-by: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---


> +static int virtio_gpu_dma_fence_wait(struct virtio_gpu_submit *submit,
> +				     struct dma_fence *fence)
> +{
> +	struct dma_fence_unwrap itr;
> +	struct dma_fence *f;
> +	int err;
> +
> +	dma_fence_unwrap_for_each(f, &itr, fence) {

The dma_fence_unwrap_for_each() change should be a separate patch,
highlighting why we want it.

> +		err = virtio_gpu_do_fence_wait(submit, f);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +


> +	ret = virtio_gpu_init_submit(&submit, exbuf, dev, file,
> +				     fence_ctx, ring_idx);
> +	if (ret)
> +		goto cleanup;
> +
> +	ret = virtio_gpu_wait_in_fence(&submit);
> +	if (ret)
> +		goto cleanup;
> +

We have reshuffled the order around in_fence waiting, out_fence install,
handles, cmdbuf, drm events, etc. Can we get that split up a bit, with
some comments.

If it were me, I would keep the wait_in_fence early and inline
virtio_gpu_init_submit (the nesting/abstraction seems a bit much). This
means one can omit the virtio_gpu_submit::exbuf all together.


HTH
Emil
