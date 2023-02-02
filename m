Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3D68734A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBBCRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 21:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBBCRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:17:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903D15CAD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 18:17:47 -0800 (PST)
Received: from [192.168.2.198] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 59E336602EE8;
        Thu,  2 Feb 2023 02:17:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675304265;
        bh=u2VOGXrYrJLSo5KyE3gwg3zJHgrNCIKTovrWYc5XWlo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YkTgbionSYM6aVZNZJyaXaiRgKpySN811iqnkNKCPFng4XhpW6Dh/TcsdE/gCZuy6
         6H8gF5ixIBckNLqrp7c/mtgtJEuq5nTo1Aro3wk51zNIZHgAJfdBj4wKIPWIvBeazN
         z+QoLVGbR+fHSMVU9dtnh+GVpmxp0X0YaH0WpLwTLf+4CbQjnDEAwLlIopJGks6gKa
         VNXO8bcJqyetqLQLY5Yqsu3jHrgjuLv1mvPh58JqqqBYYAvx0NcNi6LbC4s8zIRVBV
         pHk2Scr+S6rzhP+Ss0kC1BFO4kbaFWbku7eZXLZyOoXi6JekKo5VQBkEVvIJByzmf+
         4uAMsURh1tbUA==
Message-ID: <08560b81-5f97-bd6f-3af0-68cba6bc0bd8@collabora.com>
Date:   Thu, 2 Feb 2023 05:17:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/virtio: exbuf->fence_fd unmodified on interrupted
 wait
To:     Rob Clark <robdclark@chromium.org>
Cc:     Ryan Neph <ryanneph@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yiwei Zhang <zzyiwei@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
References: <20230126225815.1518839-1-ryanneph@chromium.org>
 <dee14d1b-fc28-e867-b425-ab11c31d799d@collabora.com>
 <CAJs_Fx4w-a0t9ekHvV55Ys6dYuTsKMa=az9E3UZcsej5AYNdGQ@mail.gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAJs_Fx4w-a0t9ekHvV55Ys6dYuTsKMa=az9E3UZcsej5AYNdGQ@mail.gmail.com>
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

On 2/1/23 18:48, Rob Clark wrote:
> On Wed, Feb 1, 2023 at 5:28 AM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> On 1/27/23 01:58, Ryan Neph wrote:
>>> An interrupted dma_fence_wait() becomes an -ERESTARTSYS returned
>>> to userspace ioctl(DRM_IOCTL_VIRTGPU_EXECBUFFER) calls, prompting to
>>> retry the ioctl(), but the passed exbuf->fence_fd has been reset to -1,
>>> making the retry attempt fail at sync_file_get_fence().
>>>
>>> The uapi for DRM_IOCTL_VIRTGPU_EXECBUFFER is changed to retain the
>>> passed value for exbuf->fence_fd when returning ERESTARTSYS or EINTR.
>>>
>>> Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
>>> Signed-off-by: Ryan Neph <ryanneph@chromium.org>
>>> ---
>>>
>>>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 9 ++++++---
>>>  include/uapi/drm/virtgpu_drm.h         | 3 +++
>>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>> index 9f4a90493aea..ffce4e2a409a 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>> @@ -132,6 +132,8 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>>>       uint64_t fence_ctx;
>>>       uint32_t ring_idx;
>>>
>>> +     exbuf->fence_fd = -1;
>>> +
>>>       fence_ctx = vgdev->fence_drv.context;
>>>       ring_idx = 0;
>>>
>>> @@ -152,8 +154,6 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>>>               ring_idx = exbuf->ring_idx;
>>>       }
>>>
>>> -     exbuf->fence_fd = -1;
>>
>> Is there any userspace relying on this -1 behaviour? Wouldn't be better
>> to remove this offending assignment?
> 
> Looking at current mesa, removing the assignment should be ok (and
> more consistent with other drivers).  But I can't say if this was
> always true, or that there aren't other non-mesa users, so I can see
> the argument for the more conservative uabi change that this patch
> went with.

Realistically, Mesa is the only user of this IOCTL. In general, in a
such case of doubt, I'll do the UABI change and then wait for complains.
If there is a complaint, then the change is reverted. Also will be good
to know about existence of other users :)

Given that -1 already wasn't consistently set for all error code paths,
it's tempting to see it removed.

The code change of this patch is trivial, hence should fine to keep the
-1 if you prefer that, but the patch won't apply cleanly to the stable
kernels because of the "exbuf->fence_fd = -1" movement. If stable
maintainers won't put effort into rebasing the patch, then better to do
the removal and live with a cleaner driver code, IMO.

-- 
Best regards,
Dmitry

