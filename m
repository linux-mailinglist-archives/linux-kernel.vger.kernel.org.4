Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9346F32E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjEAP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjEAP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:29:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259A1AA
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:29:21 -0700 (PDT)
Received: from [192.168.2.246] (109-252-144-198.dynamic.spd-mgts.ru [109.252.144.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A39F56602121;
        Mon,  1 May 2023 16:29:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682954960;
        bh=FZyPsnbblvvI0dwFtBHzZu8AEK9Dl+/PqP5r71i3Los=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=dsK9Lfh0mY5Ee/PPbnpDY1hIcenU8+6ZP4SuMHANIuf6zkac2xaVECSWFKSbM0FZK
         cBoepnUBxZ1MkVctRVIjG7eqRXR+N2OyTEYi54ddlmu7JtSvnuvXorrGzax7deaTeN
         YWcyBr0Xj9a2fiZfxO937MrXj0lIahKNpWPR4xK0F5DDcp+mhTXaviXq6Lb3W00ADn
         52+Omf000QaqOO0k0AJJfRM9SkUHA+prX0PhobW6VlMfkMybZu9JSCO0uVflRepxkn
         nf22X8+NQSjEMIe2UIQE+WVYB5KPZcgBJIN0iv89ad/L+DtZTBOeJ8Zso3wstx+jML
         icDue5QwFo1Ng==
Message-ID: <b0970bbc-d759-3b93-cfcd-b8f5a7db0ff0@collabora.com>
Date:   Mon, 1 May 2023 18:29:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 3/3] drm/virtio: Support sync objects
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <20230416115237.798604-4-dmitry.osipenko@collabora.com>
In-Reply-To: <20230416115237.798604-4-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/23 14:52, Dmitry Osipenko wrote:
> Add sync object DRM UAPI support to VirtIO-GPU driver. Sync objects
> support is needed by native context VirtIO-GPU Mesa drivers, it also will
> be used by Venus and Virgl contexts.
> 
> Reviewed-by; Emil Velikov <emil.velikov@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c    |   3 +-
>  drivers/gpu/drm/virtio/virtgpu_submit.c | 219 ++++++++++++++++++++++++
>  include/uapi/drm/virtgpu_drm.h          |  16 +-
>  3 files changed, 236 insertions(+), 2 deletions(-)

Pierre-Eric tested this v6 patchset with the AMDGPU native context. He
has problems his email/ML setup and is unable to reply here. I asked him
to provide his t-b on the Mesa MR [1] and now replicating it here.

[1]
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658#note_1889792

Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

-- 
Best regards,
Dmitry

