Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E01626354
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiKKU75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKKU74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:59:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7B77BE71;
        Fri, 11 Nov 2022 12:59:55 -0800 (PST)
Received: from [192.168.2.108] (unknown [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CDA66602A68;
        Fri, 11 Nov 2022 20:59:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668200392;
        bh=TrKdFBPru086RSsfc5wIzyFVxFZ3a1YCkJzhICjKkFM=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=kTzmPkaJO6D9W0IEssnpVYn8a0dml3ZRppn1qMWG4J42UsMw0cTQn/a79AsEqsy6X
         QMrYQYyC8OxRUVB5zQFJrKCVAXk0bJ8lzcA/P1uBAGVtFYj/6P3E36H7NotZfUXQlA
         m2J00IbXu60OvZGQx0RMmb7M4IIYhWVFKyaPRVOkHD/eqZ5Wfj3ySQg/WI6Ad+DAef
         nPvkNldq/VIa3A2nmhJSI7PnY0IhPvdxhv49NeWamYwI+4Mfs5X4K69Hy0Kql9cqfk
         7XBjipx8WNWslnDHQMpiUXQCpO0KfknfBszxAN5doYyGy+65O+6Y9l+KzgTo5o0jdg
         3B3qBv+X+50cg==
Message-ID: <b4dd0426-05fc-e33e-66b1-a2131c8c47dc@collabora.com>
Date:   Fri, 11 Nov 2022 23:59:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 0/6] Move dma_buf_mmap_internal() to dynamic locking
 specification
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
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
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
References: <20221110201349.351294-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20221110201349.351294-1-dmitry.osipenko@collabora.com>
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

On 11/10/22 23:13, Dmitry Osipenko wrote:
> Hello,
> 
> Recently, dma-buf got a common locking convention for importers and
> exporters. All the dma-buf functions were moved to the new locking
> convention, apart from the dma_buf_mmap_internal() that was missed out
> by accident. This series moves dma_buf_mmap_internal() to the dynamic
> locking specification and updates drivers that support mmaping of
> dma-bufs to use the debug-assert of the lock.
> 
> Thanks to Daniel Vetter for spotting the missed function!
> 
> Dmitry Osipenko (6):
>   dma-buf: Move dma_buf_mmap_internal() to dynamic locking specification
>   drm: Assert held reservation lock for dma-buf mmapping
>   udmabuf: Assert held reservation lock for dma-buf mmapping
>   dma-buf/heaps: Assert held reservation lock for dma-buf mmapping
>   media: videobuf2: Assert held reservation lock for dma-buf mmapping
>   fastrpc: Assert held reservation lock for dma-buf mmapping
> 
>  drivers/dma-buf/dma-buf.c                             | 7 ++++++-
>  drivers/dma-buf/heaps/cma_heap.c                      | 3 +++
>  drivers/dma-buf/heaps/system_heap.c                   | 3 +++
>  drivers/dma-buf/udmabuf.c                             | 3 +++
>  drivers/gpu/drm/drm_prime.c                           | 2 ++
>  drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c            | 2 ++
>  drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c             | 2 ++
>  drivers/gpu/drm/tegra/gem.c                           | 2 ++
>  drivers/media/common/videobuf2/videobuf2-dma-contig.c | 3 +++
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c     | 3 +++
>  drivers/media/common/videobuf2/videobuf2-vmalloc.c    | 3 +++
>  drivers/misc/fastrpc.c                                | 3 +++
>  12 files changed, 35 insertions(+), 1 deletion(-)
> 

Applied to drm-misc-next

-- 
Best regards,
Dmitry

