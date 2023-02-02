Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C0D687351
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjBBCYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 21:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBBCYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:24:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD061D75
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 18:24:40 -0800 (PST)
Received: from [192.168.2.198] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A465E6602EDA;
        Thu,  2 Feb 2023 02:24:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675304678;
        bh=O7D57L/MkShqbKOayb5xmFxvMtKT+SAzvwX0Avef/Eg=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=lD0JJntIMIBzhxQKEQ4z0hUzoTcK4C/p946u3F+Ifqwm7134WuLI9wnIbEbKF97ps
         j2a+OV+GOhiiUnlmF0mZe89DyVVQGpTEirfhTqciDJznLC+gFRYsnkykUNds8WJCvo
         0J9/lIqKk+fD1AeXWWh2hkhGyH2kT1iO0OfosfoVEL+z1DqTGGzrgXU8ojiuTDInA1
         uelYh6pgk+WcdrchmjAAIY7bsf5h9W5mPwPQVrYEBfQ8TrsUwsEAucxX793spfquAy
         yX6xYrITvelzvuLI/vxcTFqycRvr8DQOyjlQzkACQ/7YHJDLrK+q1f7MPmiZJJLeHN
         BfLFBkp6t1i+g==
Message-ID: <3d347ccc-5867-4a64-a94c-c6141624571e@collabora.com>
Date:   Thu, 2 Feb 2023 05:24:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/virtio: exbuf->fence_fd unmodified on interrupted
 wait
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
 <08560b81-5f97-bd6f-3af0-68cba6bc0bd8@collabora.com>
In-Reply-To: <08560b81-5f97-bd6f-3af0-68cba6bc0bd8@collabora.com>
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

On 2/2/23 05:17, Dmitry Osipenko wrote:
> On 2/1/23 18:48, Rob Clark wrote:
>> On Wed, Feb 1, 2023 at 5:28 AM Dmitry Osipenko
>> <dmitry.osipenko@collabora.com> wrote:
>>>
>>> On 1/27/23 01:58, Ryan Neph wrote:
>>>> An interrupted dma_fence_wait() becomes an -ERESTARTSYS returned
>>>> to userspace ioctl(DRM_IOCTL_VIRTGPU_EXECBUFFER) calls, prompting to
>>>> retry the ioctl(), but the passed exbuf->fence_fd has been reset to -1,
>>>> making the retry attempt fail at sync_file_get_fence().
>>>>
>>>> The uapi for DRM_IOCTL_VIRTGPU_EXECBUFFER is changed to retain the
>>>> passed value for exbuf->fence_fd when returning ERESTARTSYS or EINTR.
>>>>
>>>> Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
>>>> Signed-off-by: Ryan Neph <ryanneph@chromium.org>
>>>> ---
>>>>
>>>>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 9 ++++++---
>>>>  include/uapi/drm/virtgpu_drm.h         | 3 +++
>>>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>> index 9f4a90493aea..ffce4e2a409a 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>> @@ -132,6 +132,8 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>>>>       uint64_t fence_ctx;
>>>>       uint32_t ring_idx;
>>>>
>>>> +     exbuf->fence_fd = -1;
>>>> +
>>>>       fence_ctx = vgdev->fence_drv.context;
>>>>       ring_idx = 0;
>>>>
>>>> @@ -152,8 +154,6 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>>>>               ring_idx = exbuf->ring_idx;
>>>>       }
>>>>
>>>> -     exbuf->fence_fd = -1;
>>>
>>> Is there any userspace relying on this -1 behaviour? Wouldn't be better
>>> to remove this offending assignment?
>>
>> Looking at current mesa, removing the assignment should be ok (and
>> more consistent with other drivers).  But I can't say if this was
>> always true, or that there aren't other non-mesa users, so I can see
>> the argument for the more conservative uabi change that this patch
>> went with.
> 
> Realistically, Mesa is the only user of this IOCTL. In general, in a
> such case of doubt, I'll do the UABI change and then wait for complains.
> If there is a complaint, then the change is reverted. Also will be good
> to know about existence of other users :)
> 
> Given that -1 already wasn't consistently set for all error code paths,
> it's tempting to see it removed.
> 
> The code change of this patch is trivial, hence should fine to keep the
> -1 if you prefer that, but the patch won't apply cleanly to the stable
> kernels because of the "exbuf->fence_fd = -1" movement. If stable
> maintainers won't put effort into rebasing the patch, then better to do
> the removal and live with a cleaner driver code, IMO.

Although, there will be a merge conflict either way. I'll give the r-b,
still removing -1 feels more attractive to me.

-- 
Best regards,
Dmitry

