Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B176A48B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjB0R5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB0R5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:57:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DD11CF41
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:57:10 -0800 (PST)
Received: from [192.168.2.206] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D945C6602FC1;
        Mon, 27 Feb 2023 17:57:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677520628;
        bh=NjhP5iSMYLWs3pPcOz+oxCC/RwMTQmIVwAH4A+dSJnY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SMj+t+p1aHOa7rw054TzSAQ8IMUmz5bkEewJktZu2djJOY3V0iy9uiPOvw0SnkGp5
         2bilwLjmUKmjzSpz+Qn0/DVwdb5xjAM2OaV7QHxvznTTQALrZQtEBck72GeS6TJcCn
         4RH8A+YGwSgRkHq0PhsLE2xNYj9g3psBUTURQlbETxB8QO0rKYIZHWM++7rTarsggb
         Iee6G2G0FtsKKOY6Bvfn7UWShAQ3Mo7jNxH3fMcF47DP0xZSFyltSiQ0sAkIJ+LONy
         tQhJbKcD2QyvWX33Kt18IGeXVv12M9qm0DtFQwZY1LdVL+5DlFPxFyw10MHp41zAl7
         A/ck3t2GaztIA==
Message-ID: <44e67d88-fce6-a1c1-79a9-a937e64a32bb@collabora.com>
Date:   Mon, 27 Feb 2023 20:57:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] drm/virtio: Add option to disable KMS support
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Chia-I Wu <olvaffe@gmail.com>, Ryan Neph <ryanneph@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230227173800.2809727-1-robdclark@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230227173800.2809727-1-robdclark@gmail.com>
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

On 2/27/23 20:38, Rob Clark wrote:
...
> +	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS)) {
> +		/* get display info */
> +		virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
> +				num_scanouts, &num_scanouts);
> +		vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
> +					    VIRTIO_GPU_MAX_SCANOUTS);
> +		if (!vgdev->num_scanouts) {
> +			/*
> +			 * Having an EDID but no scanouts is non-sensical,
> +			 * but it is permitted to have no scanouts and no
> +			 * EDID (in which case DRIVER_MODESET and
> +			 * DRIVER_ATOMIC are not advertised)
> +			 */
> +			if (vgdev->has_edid) {
> +				DRM_ERROR("num_scanouts is zero\n");
> +				ret = -EINVAL;
> +				goto err_scanouts;
> +			}
> +			dev->driver_features &= ~(DRIVER_MODESET | DRIVER_ATOMIC);

If it's now configurable by host, why do we need the
CONFIG_DRM_VIRTIO_GPU_KMS?

-- 
Best regards,
Dmitry

