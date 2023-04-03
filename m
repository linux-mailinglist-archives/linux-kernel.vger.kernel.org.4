Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF866D41D1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjDCKT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjDCKTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:19:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B2112BF3;
        Mon,  3 Apr 2023 03:19:07 -0700 (PDT)
Received: from [192.168.2.163] (109-252-124-32.nat.spd-mgts.ru [109.252.124.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E3D56601F5E;
        Mon,  3 Apr 2023 11:19:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680517146;
        bh=oUsrnUvVWFNCO2I8SuCXiTW/AVZU2rkXoBafHs5oU3Y=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=lULd60iyGYARm3PqzyHmdn7asLZYd2d8dPWIEjvXyMF07YzyTnsdvZi2dYUGyyKAu
         hmW8XBPJQ6/iNKJHewWO+8Ak6W2rS3OU/OVGVuet7EP1bZyS1GNzWJz8c1D/Ip+QLK
         LN/UrIG7gufbNIC48TTRIRA99cicPtqUQT7ij8l6h/yE2i1Jt468aGCYN6B6ZSPq6V
         NB0nVByIN7hCp3ntdWTkFDGH9uP7rozub9VgUCThwJg6vLpuPNZpnl+83FFlS5pOuL
         5iEzz4yl/t408u97uSNIW7ZmNXhyVTF0D6zS6/I4Rov2Y+ceq8S1Pn9+WjLchRvvIg
         nb8/Tklw6SA6A==
Message-ID: <80cdf100-ef3c-23ae-5adf-bcf97fa85e72@collabora.com>
Date:   Mon, 3 Apr 2023 13:19:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 0/7] Move dma-buf mmap() reservation locking down to
 exporters
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@collabora.com
References: <20230402164826.752842-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20230402164826.752842-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/23 19:48, Dmitry Osipenko wrote:
> This patchset makes dma-buf exporters responisble for taking care of
> the reservation lock. I also included patch that moves drm-shmem to use
> reservation lock, to let CI test the whole set. I'm going to take all
> the patches via the drm-misc tree, please give an ack.
> 
> Previous policy stated that dma-buf core takes the lock around mmap()
> callback. Which meant that both importers and exporters shouldn't touch
> the reservation lock in the mmap() code path. This worked well until
> Intel-CI found a deadlock problem in a case of self-imported dma-buf [1].
> 
> The problem happens when userpace mmaps a self-imported dma-buf, i.e.
> mmaps the dma-buf FD. DRM core treats self-imported dma-bufs as own GEMs
> [2]. There is no way to differentiate a prime GEM from a normal GEM for
> drm-shmem in drm_gem_shmem_mmap(), which resulted in a deadlock problem
> for drm-shmem mmap() code path once it's switched to use reservation lock.
> 
> It was difficult to fix the drm-shmem problem without adjusting dma-buf
> locking policy. In parctice not much changed from importers perspective
> because previosly dma-buf was taking the lock in between of importers
> and exporters. Now this lock is shifted down to exporters.
> 
> [1] https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_114671v2/shard-snb5/igt@prime_vgem@sync@rcs0.html
> [2] https://elixir.bootlin.com/linux/v6.3-rc4/source/drivers/gpu/drm/drm_prime.c#L924
> 
> Dmitry Osipenko (7):
>   Revert "media: videobuf2: Assert held reservation lock for dma-buf
>     mmapping"
>   Revert "dma-buf/heaps: Assert held reservation lock for dma-buf
>     mmapping"
>   Revert "udmabuf: Assert held reservation lock for dma-buf mmapping"
>   Revert "fastrpc: Assert held reservation lock for dma-buf mmapping"
>   Revert "drm: Assert held reservation lock for dma-buf mmapping"
>   dma-buf: Change locking policy for mmap()
>   drm/shmem-helper: Switch to reservation lock
> 
>  drivers/dma-buf/dma-buf.c                     |  17 +-
>  drivers/dma-buf/heaps/cma_heap.c              |   3 -
>  drivers/dma-buf/heaps/system_heap.c           |   3 -
>  drivers/dma-buf/udmabuf.c                     |   2 -
>  drivers/gpu/drm/drm_gem_shmem_helper.c        | 217 ++++++++----------
>  drivers/gpu/drm/drm_prime.c                   |   2 -
>  drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |   2 -
>  drivers/gpu/drm/lima/lima_gem.c               |   8 +-
>  drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c     |   2 -
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |   7 +-
>  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |   6 +-
>  drivers/gpu/drm/panfrost/panfrost_mmu.c       |  19 +-
>  drivers/gpu/drm/tegra/gem.c                   |   2 -
>  .../common/videobuf2/videobuf2-dma-contig.c   |   3 -
>  .../media/common/videobuf2/videobuf2-dma-sg.c |   3 -
>  .../common/videobuf2/videobuf2-vmalloc.c      |   3 -
>  drivers/misc/fastrpc.c                        |   3 -
>  include/drm/drm_gem_shmem_helper.h            |  14 +-
>  18 files changed, 123 insertions(+), 193 deletions(-)
> 

Intel's IGT passed[1] (see Tests section) with the new locking policy,
which failed previously for the "drm/shmem-helper: Switch to reservation
lock" patch.

[1] https://patchwork.freedesktop.org/series/116000/

-- 
Best regards,
Dmitry

