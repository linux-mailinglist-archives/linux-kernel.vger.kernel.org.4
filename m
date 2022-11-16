Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DB862BD95
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbiKPMVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiKPMVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:21:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE83BC94;
        Wed, 16 Nov 2022 04:18:38 -0800 (PST)
Received: from [192.168.2.228] (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3BBA36602A87;
        Wed, 16 Nov 2022 12:18:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668601116;
        bh=mTiboSp+831cUtpvB29HPDE6adi+m8S+qn1F7FX8nDo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RiT7vESzO/zNl7nY7KcaUMuVpOD97IZLlL4pZ/aXDYwhwxWu9ptkCHZ6uugsI67mP
         JKIgPxl2GMHn8ECaHu55ar/rdm4R5ta4zK5S2fRuZ62jDNP+/p2x2cjJQkRedG85dr
         1rtbisZcZOvWt7pVtPfU+ayK0xxAHKvTeUahLNYpNdud4pd/NxCiQggi767yj+e8J5
         RbLpFuDsxjXzMvaBLK4NrIiSTkjKPdODVyblisSgHgW7VYQkggimPLUvzs/FOv7kcK
         4wMpVmBzXVFZoWmGqS5d8IUtSZox5L8QTLVzWLUaBIUfLbuw3T7lAquKiO31j7KnBF
         J79eHjyqU3XzQ==
Message-ID: <4f92e95f-a0dc-4eac-4c08-0df85de78ae7@collabora.com>
Date:   Wed, 16 Nov 2022 15:18:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3] udmabuf: add vmap and vunmap methods to udmabuf_ops
To:     Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20221115200426.4801-1-lukasz.wiecaszek@gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221115200426.4801-1-lukasz.wiecaszek@gmail.com>
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

On 11/15/22 23:04, Lukasz Wiecaszek wrote:
> The reason behind that patch is associated with videobuf2 subsystem
> (or more genrally with v4l2 framework) and user created
> dma buffers (udmabuf). In some circumstances
> when dealing with V4L2_MEMORY_DMABUF buffers videobuf2 subsystem
> wants to use dma_buf_vmap() method on the attached dma buffer.
> As udmabuf does not have .vmap operation implemented,
> such dma_buf_vmap() natually fails.
> 
> videobuf2_common: __vb2_queue_alloc: allocated 3 buffers, 1 plane(s) each
> videobuf2_common: __prepare_dmabuf: buffer for plane 0 changed
> videobuf2_common: __prepare_dmabuf: failed to map dmabuf for plane 0
> videobuf2_common: __buf_prepare: buffer preparation failed: -14
> 
> The patch itself seems to be strighforward.
> It adds implementation of .vmap and .vunmap methods
> to 'struct dma_buf_ops udmabuf_ops'.
> .vmap method itself uses vm_map_ram() to map pages linearly
> into the kernel virtual address space.
> .vunmap removes mapping created earlier by .vmap.
> All locking and 'vmapping counting' is done in dma_buf.c
> so it seems to be redundant/unnecessary in .vmap/.vunmap.
> 
> Signed-off-by: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> v1: https://lore.kernel.org/linux-media/202211120352.G7WPASoP-lkp@intel.com/T/#t
> v2: https://lore.kernel.org/linux-media/20221114052944.GA7264@thinkpad-p72/T/#t
> 
> v2 -> v3: Added .vunmap to 'struct dma_buf_ops udmabuf_ops'
> v1 -> v2: Patch prepared and tested against 6.1.0-rc2+
> 
>  drivers/dma-buf/udmabuf.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 283816fbd72f..740d6e426ee9 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -13,6 +13,8 @@
>  #include <linux/slab.h>
>  #include <linux/udmabuf.h>
>  #include <linux/hugetlb.h>
> +#include <linux/vmalloc.h>
> +#include <linux/iosys-map.h>
>  
>  static int list_limit = 1024;
>  module_param(list_limit, int, 0644);
> @@ -60,6 +62,30 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
> +{
> +	struct udmabuf *ubuf = buf->priv;
> +	void *vaddr;
> +
> +	dma_resv_assert_held(buf->resv);
> +
> +	vaddr = vm_map_ram(ubuf->pages, ubuf->pagecount, -1);
> +	if (!vaddr)
> +		return -EINVAL;
> +
> +	iosys_map_set_vaddr(map, vaddr);
> +	return 0;
> +}
> +
> +static void vunmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
> +{
> +	struct udmabuf *ubuf = buf->priv;
> +
> +	dma_resv_assert_held(buf->resv);
> +
> +	vm_unmap_ram(map->vaddr, ubuf->pagecount);
> +}
> +
>  static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
>  				     enum dma_data_direction direction)
>  {
> @@ -162,6 +188,8 @@ static const struct dma_buf_ops udmabuf_ops = {
>  	.unmap_dma_buf	   = unmap_udmabuf,
>  	.release	   = release_udmabuf,
>  	.mmap		   = mmap_udmabuf,
> +	.vmap		   = vmap_udmabuf,
> +	.vunmap		   = vunmap_udmabuf,
>  	.begin_cpu_access  = begin_cpu_udmabuf,
>  	.end_cpu_access    = end_cpu_udmabuf,
>  };

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

