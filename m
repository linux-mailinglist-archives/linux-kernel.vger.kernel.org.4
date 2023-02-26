Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2124D6A35AF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 00:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBZXun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 18:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBZXul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:50:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6CE869C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 15:50:39 -0800 (PST)
Received: from [192.168.2.206] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 187D86602DCD;
        Sun, 26 Feb 2023 23:50:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677455438;
        bh=JYRpxATqvkNno1FwoBgptX7gQvro7kbdKaoh02c9VEQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=TqSCfmh49xkDbtgdLhYXyECizYrDVzOlSc4QBhUnSkdoQBHhIiPRhn8+7lHI9/9li
         e8HZpOK/Mo6d2omwCQIfEe5i7lLxY7GKYfFKKTdInzjMwboFn9AXcDn0KGQf64Vf8A
         Uv0b10EbzFkgDzRcxhD08xlEmcbpLo8Lnr5aO/rkyJqqjvkoFRhZ8eht4eo6Nwi0dC
         /IkZJm1mntY20f3yi75AZkKIuYm+OgpIrU7k+uxVssus+JfPaOq4a72cuHFHlA2VAP
         IuV7JW/2gw/aYpwuuv/nYTRBrrJ5S355O2kkcBhW4kpTmr7mezO+JGiV2Eq+8hnz7G
         02drfzM2+WNlw==
Message-ID: <32f2442d-9150-0288-499c-9206084d8732@collabora.com>
Date:   Mon, 27 Feb 2023 02:50:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/virtio: Pass correct device to
 dma_sync_sgtable_for_device()
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20230224153450.526222-1-olekstysh@gmail.com>
 <4cb50dcb-b877-9602-3802-d651eea57b89@collabora.com>
Content-Language: en-US
In-Reply-To: <4cb50dcb-b877-9602-3802-d651eea57b89@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/23 17:55, Dmitry Osipenko wrote:
> On 2/24/23 18:34, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> The "vdev->dev.parent" should be used instead of "vdev->dev" as a device
>> for which to perform the DMA operation in both
>> virtio_gpu_cmd_transfer_to_host_2d(3d).
>>
>> Because the virtio-gpu device "vdev->dev" doesn't really have DMA OPS
>> assigned to it, but parent (virtio-pci or virtio-mmio) device
>> "vdev->dev.parent" has. The more, the sgtable in question the code is
>> trying to sync here was mapped for the parent device (by using its DMA OPS)
>> previously at:
>> virtio_gpu_object_shmem_init()->drm_gem_shmem_get_pages_sgt()->
>> dma_map_sgtable(), so should be synced here for the same parent device.
>>
>> Fixes: b5c9ed70d1a9 ("drm/virtio: Improve DMA API usage for shmem BOs")
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> ---
...
> Indeed, it's only the vgpu drm device that was moved to use the pci
> parent device. On x86 the vdev always has dma-ops, also
> virtio_has_dma_quirk=true for modern Qemu. So I didn't test this code
> path and apparently it's only testable on Xen, which is good to know.
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Applied to misc-fixes

-- 
Best regards,
Dmitry

