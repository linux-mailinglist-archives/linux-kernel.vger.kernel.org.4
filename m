Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FAF6AF133
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjCGSlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjCGSk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:40:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778D59BE28
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:31:39 -0800 (PST)
Received: from [192.168.2.57] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD6FB6601F13;
        Tue,  7 Mar 2023 18:25:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678213518;
        bh=7xmQlQpWEcyC/vbFYJQ2McbYpsrcK7QnlpUA/KHn1Wk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zrglm6oKYgFbMjueScP15VIhZ1e8VIZcmHTOs1V+uaFq8lqpreoWLJJsP+xhKEn3A
         CRyP+C1qQvEQ6mqj/+l+9azFbvrvfnJyH8+SvKyEUPUf87kLou7kCF3a61h9eJxZN1
         M/l7hHHuD+So2fb0bCK8WSiBRG7Q5Clh38oAL71o+WmUHjuxN2wWO5cxxN5UDxfAwZ
         iW57t6V1ciYldWG38Zc6w9IYwNqSDLtSLDetuB0IOR3YRUXetyjv3RT4WYQlcpLXeO
         6VZCv6oen7Ex10YDM2i750Mo0Ukwh6JXkacuN6qvMsRp2zOWp9N+06UKMgpo/eiwNt
         qYPcpTZfu7Zeg==
Message-ID: <66ddf54c-8396-2eb4-49ae-da479a997219@collabora.com>
Date:   Tue, 7 Mar 2023 21:25:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v12 10/11] drm/virtio: Support memory shrinking
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     intel-gfx@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20230305221011.1404672-1-dmitry.osipenko@collabora.com>
 <20230305221011.1404672-11-dmitry.osipenko@collabora.com>
 <3afbc965-4117-7d45-9a8f-b726c04d1b0c@suse.de>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <3afbc965-4117-7d45-9a8f-b726c04d1b0c@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 13:42, Thomas Zimmermann wrote:
> Hi
> 
> Am 05.03.23 um 23:10 schrieb Dmitry Osipenko:
> [...]
>>         *bo_ptr = bo;
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c
>> b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> index 4c09e313bebc..3f21512ff153 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> @@ -238,20 +238,32 @@ static int virtio_gpu_plane_prepare_fb(struct
>> drm_plane *plane,
>>       struct virtio_gpu_device *vgdev = dev->dev_private;
>>       struct virtio_gpu_framebuffer *vgfb;
>>       struct virtio_gpu_object *bo;
>> +    int err;
>>         if (!new_state->fb)
>>           return 0;
>>         vgfb = to_virtio_gpu_framebuffer(new_state->fb);
>>       bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
>> -    if (!bo || (plane->type == DRM_PLANE_TYPE_PRIMARY &&
>> !bo->guest_blob))
>> +
>> +    if (virtio_gpu_is_shmem(bo)) {
> 
> Not really a problem with this patchset, but having such branches looks
> like a bug in the driver's GEM design. Whatever your GEM object needs or
> does, it should be hidden in the implementation. Why is virtio doing this?

There is another "VRAM" VirtIO-GPU BO type that doesn't implement the
pin/unpin callbacks. Perhaps another option was to add the callbacks.

>> +        err = drm_gem_pin(&bo->base.base);
> 
> As the driver uses GEM SHMEM, please call drm_gem_shmem_object_pin()
> directly and remove patch [09/11]. Same goes for the _unpin call below.
> 
> The problem with generic pinning interfaces is that there's no way of
> specifying where to pin to BO.  The problem is most apparent with TTM,
> where hardware often has multiple locations were buffer can be placed
> (VRAM, GART, system memory). So it's really a detail between the driver
> and the memory manager.
> 
> These generic internal GEM interfaces should only be used by DRM core
> and helpers. Drivers should use their memory manager's interface.

I'll switch to use drm_gem_shmem_object_pin() directly in v13, maybe add
virtio_gpu_gem_pin() helper for that. Thanks!

-- 
Best regards,
Dmitry

