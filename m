Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C63742B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjF2RVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjF2RVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:21:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11D573595;
        Thu, 29 Jun 2023 10:21:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08712C14;
        Thu, 29 Jun 2023 10:21:51 -0700 (PDT)
Received: from [10.57.33.98] (unknown [10.57.33.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3C073F64C;
        Thu, 29 Jun 2023 10:21:04 -0700 (PDT)
Message-ID: <94d4b082-7b08-82e0-bb42-6ac36821ea61@arm.com>
Date:   Thu, 29 Jun 2023 18:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/6] dma-mapping: add a dma_alloc_noncontiguous API
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        iommu@lists.linux-foundation.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20210301085236.947011-1-hch@lst.de>
 <20210301085236.947011-4-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20210301085236.947011-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Archaeology ensues...]

On 2021-03-01 08:52, Christoph Hellwig wrote:
[...]
> +static struct sg_table *alloc_single_sgt(struct device *dev, size_t size,
> +		enum dma_data_direction dir, gfp_t gfp)
> +{
> +	struct sg_table *sgt;
> +	struct page *page;
> +
> +	sgt = kmalloc(sizeof(*sgt), gfp);
> +	if (!sgt)
> +		return NULL;
> +	if (sg_alloc_table(sgt, 1, gfp))
> +		goto out_free_sgt;
> +	page = __dma_alloc_pages(dev, size, &sgt->sgl->dma_address, dir, gfp);
> +	if (!page)
> +		goto out_free_table;
> +	sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> +	sg_dma_len(sgt->sgl) = sgt->sgl->length;
> +	return sgt;
> +out_free_table:
> +	sg_free_table(sgt);
> +out_free_sgt:
> +	kfree(sgt);
> +	return NULL;
> +}
> +
> +struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
> +		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	struct sg_table *sgt;
> +
> +	if (WARN_ON_ONCE(attrs & ~DMA_ATTR_ALLOC_SINGLE_PAGES))
> +		return NULL;
> +
> +	if (ops && ops->alloc_noncontiguous)
> +		sgt = ops->alloc_noncontiguous(dev, size, dir, gfp, attrs);
> +	else
> +		sgt = alloc_single_sgt(dev, size, dir, gfp);
> +
> +	if (sgt) {
> +		sgt->nents = 1;
> +		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir);

It turns out this is liable to trip up DMA_API_DEBUG_SG (potentially 
even in the alloc_single_sgt() case), since we've filled in sgt without 
paying attention to the device's segment boundary/size parameters.

Now, it would be entirely possible to make the allocators "properly" 
partition the pages into multiple segments per those constraints, but 
given that there's no actual dma_map_sg() operation involved, and AFAIR 
the intent here is really only to describe a single DMA-contiguous 
buffer as pages, rather than represent a true scatter-gather operation, 
I'm now wondering whether it makes more sense to just make dma-debug a 
bit cleverer instead. Any other opinions?

Thanks,
Robin.

> +	}
> +	return sgt;
> +}
