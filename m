Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3456AA0AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjCCUgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjCCUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:36:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EC46151F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:36:16 -0800 (PST)
Received: from [192.168.2.210] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 62BBE6602FB0;
        Fri,  3 Mar 2023 20:36:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677875774;
        bh=15/tXolhdND9XIfdhz6183l53lBlVVuHaxxsdm2MQ1Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZJNsEKRtAaKv3nwz3IfZe8MPnXYQwjDk8WvFbPrHiXcJRO0NYitdoTxxfbe36uRR2
         MCzru9LspKSJDjvSvP6+h04MGvlk9dGEENK6WIxHrxI4NiZXo3tKdFnE48Qj/rob+F
         MdJDWo47wvA48oW7Jso0bjeHeFZ9Sy2Z5LHBnsF/QZtHFnjuJB2oZhfDIj/TuwNMfO
         gYB3vS4hNEjBaVPbeAI0+9hXmp4JnVOIiRSEqaHITTWfGxuZ7vc2JtwYoVhy+PtJtX
         j//qbQncKnJxjvKQQtA6iTDMhE/7LZZP/4n0wdbfe35Tz8AYyES3piDyn/ABgHinWy
         VOztUL9w1NpQA==
Message-ID: <8bb4cf0f-dbb5-095d-edc6-47e1ff9dd6c8@collabora.com>
Date:   Fri, 3 Mar 2023 23:36:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6] drm/virtio: Add option to disable KMS support
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     Chia-I Wu <olvaffe@gmail.com>, Ryan Neph <ryanneph@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230302233506.3146290-1-robdclark@gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230302233506.3146290-1-robdclark@gmail.com>
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

On 3/3/23 02:35, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add a build option to disable modesetting support.  This is useful in
> cases where the guest only needs to use the GPU in a headless mode, or
> (such as in the CrOS usage) window surfaces are proxied to a host
> compositor.
> 
> As the modesetting ioctls are a big surface area for potential security
> bugs to be found (it's happened in the past, we should assume it will
> again in the future), it makes sense to have a build option to disable
> those ioctls in cases where they serve no legitimate purpose.
> 
> v2: Use more if (IS_ENABLED(...))
> v3: Also permit the host to advertise no scanouts
> v4: Spiff out commit msg
> v5: Make num_scanouts==0 and DRM_VIRTIO_GPU_KMS=n behave the same
> v6: Drop conditionally building virtgpu_display.c and early-out of
>     it's init/fini fxns instead
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Applied to misc-next

-- 
Best regards,
Dmitry

