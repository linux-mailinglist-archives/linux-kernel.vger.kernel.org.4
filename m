Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E416C62707F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiKMQ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiKMQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:27:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85025FFE;
        Sun, 13 Nov 2022 08:27:28 -0800 (PST)
Received: from [192.168.2.125] (unknown [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E46F660036D;
        Sun, 13 Nov 2022 16:27:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668356847;
        bh=depGYhwkKPmSm4U0mvWNMVYV3VfG81IAL1hmomv9Y0g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gFZK+iuy/tTCaxzkIzB0TWH9EBcISskrDZy5noHC46JFBCkB8r5rIr1p9M9Full0S
         9vJ5IdE+f3O2K/qhP95QoSOohhWeiLXsobZXetARESBFvl5231xj+FVyA10Yx2LBw6
         GCNvRZnvwN32PbFTTDU33gHQlK9VJaPuKhpYRaacjataB6C/Dz/mMDtPeZrr9WJZwU
         7Yi4BOaJNe68nA0bwPaO31AF4tghE8T30uf5fnImRIym3JiJ/E61qkovRtOe94B9+9
         dl/39/9dUzeSxI2rUgqYkHoMo0IlrXXjHwYBykC9mNdIhuNtHwJzzrs1Dsvl8qFUCZ
         1O69e41WwciqQ==
Message-ID: <69cff33f-fd6e-f931-c469-a383d816b956@collabora.com>
Date:   Sun, 13 Nov 2022 19:27:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] udmabuf: add vmap method to udmabuf_ops
To:     Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20221113150511.8878-1-lukasz.wiecaszek@gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221113150511.8878-1-lukasz.wiecaszek@gmail.com>
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

On 11/13/22 18:05, Lukasz Wiecaszek wrote:
> The reason behind that patch is associated with videobuf2 subsystem
> (or more genrally with v4l2 framework) and user created
> dma buffers (udmabuf). In some circumstances
> when dealing with V4L2_MEMORY_DMABUF buffers videobuf2 subsystem
> wants to use dma_buf_vmap() method on the attached dma buffer.
> As udmabuf does not have .vmap operation implemented,
> such dma_buf_vmap() natually fails.
> 
> videobuf2_common: [cap-000000003473b2f1] __vb2_queue_alloc: allocated 3 buffers, 1 plane(s) each
> videobuf2_common: [cap-000000003473b2f1] __prepare_dmabuf: buffer for plane 0 changed
> videobuf2_common: [cap-000000003473b2f1] __prepare_dmabuf: failed to map dmabuf for plane 0
> videobuf2_common: [cap-000000003473b2f1] __buf_prepare: buffer preparation failed: -14
> 
> The patch itself seems to be strighforward.
> It adds implementation of .vmap method to 'struct dma_buf_ops udmabuf_ops'.
> .vmap method itself uses vm_map_ram() to map pages linearly
> into the kernel virtual address space (only if such mapping
> hasn't been created yet).
> 
> Signed-off-by: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> v1: https://lore.kernel.org/linux-media/202211120352.G7WPASoP-lkp@intel.com/T/#t
> 
> v1 -> v2: Patch prepared and tested against 6.1.0-rc2+
> 
>  drivers/dma-buf/udmabuf.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 2bcdb935a3ac..2ca0e3639360 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -12,6 +12,8 @@
>  #include <linux/slab.h>
>  #include <linux/udmabuf.h>
>  #include <linux/hugetlb.h>
> +#include <linux/vmalloc.h>
> +#include <linux/iosys-map.h>
>  
>  static int list_limit = 1024;
>  module_param(list_limit, int, 0644);
> @@ -26,6 +28,7 @@ struct udmabuf {
>  	struct page **pages;
>  	struct sg_table *sg;
>  	struct miscdevice *device;
> +	void *vaddr;
>  };
>  
>  static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
> @@ -57,6 +60,21 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
> +{
> +	struct udmabuf *ubuf = buf->priv;
> +
> +	if (!ubuf->vaddr) {
> +		ubuf->vaddr = vm_map_ram(ubuf->pages, ubuf->pagecount, -1);
> +		if (!ubuf->vaddr)
> +			return -EINVAL;
> +	}
> +
> +	iosys_map_set_vaddr(map, ubuf->vaddr);
> +
> +	return 0;
> +}
> +
>  static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
>  				     enum dma_data_direction direction)
>  {
> @@ -159,6 +177,7 @@ static const struct dma_buf_ops udmabuf_ops = {
>  	.unmap_dma_buf	   = unmap_udmabuf,
>  	.release	   = release_udmabuf,
>  	.mmap		   = mmap_udmabuf,
> +	.vmap		   = vmap_udmabuf,
>  	.begin_cpu_access  = begin_cpu_udmabuf,
>  	.end_cpu_access    = end_cpu_udmabuf,
>  };

Where is vunmap?

-- 
Best regards,
Dmitry

