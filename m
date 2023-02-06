Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF83168C476
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBFRU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjBFRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:20:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D423527492
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:20:51 -0800 (PST)
Received: from [192.168.2.90] (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 65EE06602D99;
        Mon,  6 Feb 2023 17:20:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675704050;
        bh=bUXajhXwEiwkWVZseXMgMhjWWpNFCinbZK0tN5zlI0E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iRouOPwVTFFBPGErZ39RidCmc2XoyCy49AsxdNFCe6RbwIGG2UxxLMQk3REXIahwH
         LJvcWihdRomC45IeuSnGCh7MSnuP5kEp3qBIdsqrr6h+W7i0Q9rKPtDRG/V6dj69RY
         v5GCuZfJGHpuz8sr3nL/Yd3zfrgWk6FmVNjwtDh9cC5dDfc23hgilbiHNr7ws/2QZE
         RUl8EBnePY8mWeJDk83b214EM0hoDsoIegCTdPIHshCmbU47+3Zq2IwoxxWnLSZbDx
         nqDZ0SlgnzBoL400Ss9Ou7meywSX61Swi1TLbPTjEVOvaFrrSziN/VULMknESzG3W6
         MrQVHF6WY0jTg==
Message-ID: <c06c005d-41a8-5403-818b-f66264fe8c0b@collabora.com>
Date:   Mon, 6 Feb 2023 20:20:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] drm/virtio: exbuf->fence_fd unmodified on interrupted
 wait
To:     Ryan Neph <ryanneph@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Yiwei Zhang <zzyiwei@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20230203233345.2477767-1-ryanneph@chromium.org>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230203233345.2477767-1-ryanneph@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/23 02:33, Ryan Neph wrote:
> An interrupted dma_fence_wait() becomes an -ERESTARTSYS returned
> to userspace ioctl(DRM_IOCTL_VIRTGPU_EXECBUFFER) calls, prompting to
> retry the ioctl(), but the passed exbuf->fence_fd has been reset to -1,
> making the retry attempt fail at sync_file_get_fence().
> 
> The uapi for DRM_IOCTL_VIRTGPU_EXECBUFFER is changed to retain the
> passed value for exbuf->fence_fd when returning anything besides a
> successful result from the ioctl.
> 
> Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
> Signed-off-by: Ryan Neph <ryanneph@chromium.org>
> Reviewed-by: Rob Clark <robdclark@gmail.com>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> ---
> 
> Changes in v2:
> - No longer modifies exbuf->fence_fd unless DRM_IOCTL_VIRTGPU_EXECBUFFER
>   succeeds.
> - Added r-b tags (Rob/Dmitry) from v1.

Thanks! Applied to misc-fixes

-- 
Best regards,
Dmitry

