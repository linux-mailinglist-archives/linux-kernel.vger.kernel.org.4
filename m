Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6526A4A10
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjB0Soi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjB0Sog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:44:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3D16A6C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:44:35 -0800 (PST)
Received: from [192.168.2.206] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E69F6602135;
        Mon, 27 Feb 2023 18:44:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677523474;
        bh=tABKF9wTdWSWQ++4KVogjtpRwZoO5LJkPSCzhWoF5ns=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hr7SiW1uYTRiZbtB/kl6JjRQxbFGPavMrU15he2IpXsnWyYWlgmzzXQFOW4Sfxfox
         U6jmhAxpDZ4IwHWdfwilXFHyFPCU/YAgv+6SWrbWXh93LFJfuhtlPCcJRFZBh40aOJ
         QrANhqZrJJUjHmU5GaP9gcM43OVdjTi0VVdQt+9tXN3IXiu0mV0sh6S2VspfINCwmt
         QNSf3LPSaBwjR7Xlr6zn6/MRhd5KTWjNxHZOFdksBE50pdADzi1ySm1ba7I/pyGUlI
         eM4zwF80AYLmg2tHzVfW4Eh7pxH/4mmDndlaI6YdOuG8cmsg38qsBQ0xcdVgmti0Oi
         4jFojkmXqUKxA==
Message-ID: <8499dacf-bd0d-7cee-aa98-a88fdf84de9e@collabora.com>
Date:   Mon, 27 Feb 2023 21:44:30 +0300
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
>  static const struct drm_driver driver = {
> -	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC,
> +	.driver_features =
> +#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)

I'd also replace the `#if defined()` with `#if IS_ENABLED()`, for
consistency.

Maybe won't hurt to expand the commit message a tad, emphasizing the
security aspect and telling about the new num_scanouts=0 behaviour.

I can change it all while applying, if Gerd is okay with this patch.

Othwerise, good to me:

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

