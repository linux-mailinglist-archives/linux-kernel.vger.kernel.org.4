Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8A464EAC3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiLPLlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiLPLlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:41:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B77011442
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:41:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19081042;
        Fri, 16 Dec 2022 03:41:43 -0800 (PST)
Received: from [10.57.88.234] (unknown [10.57.88.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AF4B3F73B;
        Fri, 16 Dec 2022 03:41:02 -0800 (PST)
Message-ID: <a76cb262-a24f-e113-5680-2025aa143ee6@arm.com>
Date:   Fri, 16 Dec 2022 11:40:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [6.2][regression] after commit
 ffcb754584603adf7039d7972564fbf6febdc542 all sound devices disappeared (due
 BUG at mm/page_alloc.c:3592!)
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        m.szyprowski@samsung.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev
References: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
 <20221216064645.GA24446@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221216064645.GA24446@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-16 06:46, Christoph Hellwig wrote:
> Ok, it seems like the sound noncontig alloc code that I already
> commented on as potentially bogus GFP_GOMP mapping trips this.  I think
> for now the right thing would be to revert the hunk in dma-iommu.c
> (see patch below).  The other thing to try would be to remove both
> uses GFP_COMP in sound/core/memalloc.c, which should have the same
> effect.

Or we explicitly strip the flag in dma_alloc_noncontiguous() (and maybe 
dma_alloc_pages() as well) for consistency with dma_alloc_attrs(). That 
seems like it might be the most robust option.

Robin.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9297b741f5e80e..f798c44e090337 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -744,9 +744,6 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   	/* IOMMU can map any pages, so himem can also be used here */
>   	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>   
> -	/* It makes no sense to muck about with huge pages */
> -	gfp &= ~__GFP_COMP;
> -
>   	while (count) {
>   		struct page *page = NULL;
>   		unsigned int order_size;
> 
