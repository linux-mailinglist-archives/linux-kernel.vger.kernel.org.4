Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6593B6A7641
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCAVjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAVjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:39:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1EA1B2E0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:39:39 -0800 (PST)
Received: from [192.168.2.206] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CDE0F6602090;
        Wed,  1 Mar 2023 21:39:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677706778;
        bh=qfDjYlzDwFwVfHyC4wdLJWT5MiWZh5diRa9lzEziWvA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fJtpAP3xqsNFJWkDiHKTcvTxy6ss1AkwYaXx/U2+rveCPUTNTOsRqASOuiTEUTiuB
         JnMXVSwGJq3OKL7NQ3z6S4s+Kqk2SU+ITdkmk546n1HwS2yarktgpk8/kWZhEVvuSP
         yR8qYWCASQNTim6j4QFNi5xIa9yLnQv5I29qfbfVE1Z5ZVrEy7V/yUbCAJpjHoq1Cs
         jX4FjK7oeip19SF2auP6KO5etkyT65LvchwoHdsZ1EzOQ8CSKElQBgeoMq67E1R9eJ
         hTuNSeXHGxPBKrW3TiWWJ5lBrYKlbdEiF3mZH2unhSmt9FNywKUUGXTilMTF6aw9+Y
         Bis9n+Pl6/GAg==
Message-ID: <6eb2cde8-f548-73ba-6091-131c1848690c@collabora.com>
Date:   Thu, 2 Mar 2023 00:39:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5] drm/virtio: Add option to disable KMS support
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Chia-I Wu <olvaffe@gmail.com>, Ryan Neph <ryanneph@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230301185432.3010939-1-robdclark@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230301185432.3010939-1-robdclark@gmail.com>
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

On 3/1/23 21:54, Rob Clark wrote:
>  /* virtgpu_display.c */
> +#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
>  int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
>  void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
> +#else
> +static inline int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
> +{
> +	return 0;
> +}
> +static inline void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
> +{
> +}
> +#endif

In v4 Gerd wanted to keep building the virtgpu_display.o and instead add
the KSM config check to virtio_gpu_modeset_init/fini(). Is there any
reason why you didn't do that?

-- 
Best regards,
Dmitry

