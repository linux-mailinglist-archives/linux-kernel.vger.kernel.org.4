Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B166D389A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjDBOzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDBOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:55:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2F86A7A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:54:59 -0700 (PDT)
Received: from [192.168.2.163] (unknown [109.252.124.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB315660212B;
        Sun,  2 Apr 2023 15:54:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680447298;
        bh=PNLOiQz44h5E3O/8HvWEl9u5VjS2kdzOQ4M+EXBh5n8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZXuhqZ86reOnfGEy0Mty0wUnDCXbuvIExjuJWhxCTp6O6dpKOekf4Ys9c521ZJHzb
         wOE4By0iKXj4WRnG7ljmeeQ8uqi5nxCFkr257nGfWhRVFgpdbXLWUWZofPsPgzBGkw
         UcZkBe/XbI5h+xawmM5/OOBreHZKS1aKGLqHqwPVje8tY00XFpqJ+52NQeDZ5z4Rtg
         qBxrXvzYV0s3vvoAsG5I2Yv+96x5x9h++ykPlw3Advot/f2PpXzOA9yFQFRxJ6Awkb
         Bw+ujXOzOhDaaAnFTDoKGod51q/nnfaH4/EFFAoDEikDVUDL17oJm/ToX8Y92z+tN4
         msCE9jc+hKyaQ==
Message-ID: <90c71a10-9791-1cd5-b7af-badac24bf5c2@collabora.com>
Date:   Sun, 2 Apr 2023 17:54:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v13 01/10] drm/shmem-helper: Switch to reservation lock
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>
References: <20230314022659.1816246-1-dmitry.osipenko@collabora.com>
 <20230314022659.1816246-2-dmitry.osipenko@collabora.com>
 <6b5644cf-6229-f99b-d429-a45d724493ee@collabora.com>
 <20c88807-8513-a816-aed9-5cd67eb5c1ed@collabora.com>
 <2631edac-a57e-638d-226c-08ea3d9b6b8d@gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <2631edac-a57e-638d-226c-08ea3d9b6b8d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/23 12:19, Christian König wrote:
> Am 25.03.23 um 15:58 schrieb Dmitry Osipenko:
>> On 3/15/23 16:46, Dmitry Osipenko wrote:
>>> On 3/14/23 05:26, Dmitry Osipenko wrote:
>>>> @@ -633,7 +605,10 @@ int drm_gem_shmem_mmap(struct
>>>> drm_gem_shmem_object *shmem, struct vm_area_struct
>>>>           return ret;
>>>>       }
>>>>   +    dma_resv_lock(shmem->base.resv, NULL);
>>>>       ret = drm_gem_shmem_get_pages(shmem);
>>>> +    dma_resv_unlock(shmem->base.resv);
>>> Intel CI reported locking problem [1] here. It actually was also
>>> reported for v12, but I missed that report because of the other noisy
>>> reports.
>>>
>>> [1]
>>> https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_114671v2/shard-snb5/igt@prime_vgem@sync@rcs0.html
>>>
>>> The test does the following:
>>>
>>> 1. creates vgem
>>> 2. export it do dmabuf
>>> 3. mmaps dmabuf
>>>
>>> There is an obvious deadlock there. The DRM code assumes that mmap() is
>>> unlocked, while for dma-buf it's locked. I'll see how to fix it for v14.
>>>
>> Christian, there is a deadlock problem in drm_gem_shmem_mmap() once we
>> move drm-shmem to use resv lock. The current dma-buf locking policy
>> claims that importer holds the lock for mmap(), but DRM code assumes
>> that obj->mmap() handles the locking itself and then the same
>> obj->mmap() code path is used by both dma-buf DRM and a usual DRM object
>> paths. Hence importer -> dma_buf_mmap_internal()[takes the lock] ->
>> exporter -> drm_gem_shmem_mmap()[takes the lock] deadlocks.
>>
>> I was looking at how to fix it and to me the best option is to change
>> the dma-buf locking policy, making exporter responsible for handling the
>> resv lock. Changing DRM code mmap lockings might be possible too [moving
>> locking to drm_gem_mmap_obj()], but will be very messy and doesn't feel
>> intuitive.
>>
>> Want to get yours thoughts on this before sending out the dma-buf mmap()
>> policy-change patch. Does the new mmap() locking policy sound good to
>> you? Thanks!
> 
> 
> IIRC we tried that before and ran into problems.
> 
> dma_buf_mmap() needs to swap the backing file of the VMA and for this
> calls fput() on the old file.
> 
> This fput() in turn could (in theory) grab the resv lock as well and
> there isn't anything we could do about that.
> 
> Just information from the back of my memory, probably best if you double
> check that.

Thanks, Christian! The fput() code path will be unlocked with updated
locking policy, like it was before. The new locking policy looks goods
on my side, don't see anything that needs locking protection from the
importer side for mmap().

I'll send the patches, letting intel-ci test them. Will be also easier
to discuss it there with the code.

-- 
Best regards,
Dmitry

