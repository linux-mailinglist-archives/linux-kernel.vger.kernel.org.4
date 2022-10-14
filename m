Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE8E5FEC80
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJNKXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 06:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJNKXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 06:23:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBE7A1C7138
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 03:23:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ACD213D5;
        Fri, 14 Oct 2022 03:23:39 -0700 (PDT)
Received: from [10.57.5.134] (unknown [10.57.5.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FF733F67D;
        Fri, 14 Oct 2022 03:23:31 -0700 (PDT)
Message-ID: <71fb875f-5884-cbc6-534f-6ba72167bf6a@arm.com>
Date:   Fri, 14 Oct 2022 11:23:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 5/5] iommu/sun50i: Invalidate iova in map and unmap
 callback
Content-Language: en-GB
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, maxime@cerno.tech,
        joro@8bytes.org, will@kernel.org, wens@csie.org,
        samuel@sholland.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
 <20221013181221.3247429-7-jernej.skrabec@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221013181221.3247429-7-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-13 19:12, Jernej Skrabec wrote:
> Mapped and unmapped iova addresses needs to be invalidated immediately
> or otherwise they might or might not work when used by master or CPU.
> 
> This was discovered when running video decoder conformity test with
> Cedrus. Some videos were now and then decoded incorrectly and generated
> page faults.
> 
> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>   drivers/iommu/sun50i-iommu.c | 51 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index 7c3b2ac552da..21e47ce6946a 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -518,6 +518,53 @@ static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
>   	return page_table;
>   }
>   
> +static void sun50i_iommu_zap_iova(struct sun50i_iommu *iommu, unsigned long iova)
> +{
> +	unsigned long flags;
> +	u32 reg;
> +	int ret;
> +
> +	spin_lock_irqsave(&iommu->iommu_lock, flags);
> +
> +	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 0);
> +
> +	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_REG, iova);
> +	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_MASK_REG, GENMASK(11, 0));
> +	iommu_write(iommu, IOMMU_TLB_IVLD_ENABLE_REG, IOMMU_TLB_IVLD_ENABLE_ENABLE);
> +
> +	ret = readl_poll_timeout_atomic(iommu->base + IOMMU_TLB_IVLD_ENABLE_REG,
> +					reg, !reg, 1, 2000);
> +	if (ret)
> +		dev_warn(iommu->dev, "TLB invalidation timed out!\n");
> +
> +	iommu_write(iommu, IOMMU_AUTO_GATING_REG, IOMMU_AUTO_GATING_ENABLE);
> +
> +	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
> +}
> +
> +static void sun50i_iommu_zap_ptw_cache(struct sun50i_iommu *iommu, unsigned long iova)
> +{
> +	unsigned long flags;
> +	u32 reg;
> +	int ret;
> +
> +	spin_lock_irqsave(&iommu->iommu_lock, flags);
> +
> +	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 0);
> +
> +	iommu_write(iommu, IOMMU_PC_IVLD_ADDR_REG, iova);
> +	iommu_write(iommu, IOMMU_PC_IVLD_ENABLE_REG, IOMMU_PC_IVLD_ENABLE_ENABLE);
> +
> +	ret = readl_poll_timeout_atomic(iommu->base + IOMMU_PC_IVLD_ENABLE_REG,
> +					reg, !reg, 1, 2000);
> +	if (ret)
> +		dev_warn(iommu->dev, "PTW cache invalidation timed out!\n");
> +
> +	iommu_write(iommu, IOMMU_AUTO_GATING_REG, IOMMU_AUTO_GATING_ENABLE);
> +
> +	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
> +}
> +
>   static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
>   			    phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
>   {
> @@ -546,6 +593,8 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
>   
>   	*pte_addr = sun50i_mk_pte(paddr, prot);
>   	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> +	sun50i_iommu_zap_iova(iommu, iova);
> +	sun50i_iommu_zap_ptw_cache(iommu, iova);

Consider hooking up .sync_map if you need that behaviour. I'd guess the 
address/mask combination allows invalidating multiple pages at once, 
which would be a heck of a lot more efficient.

In principle we probably shouldn't need walk cache maintenance for just 
changing leaf entries, so that could perhaps be pushed further down into 
sun50i_dte_get_page_table().

>   out:
>   	return ret;
> @@ -571,6 +620,8 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
>   
>   	memset(pte_addr, 0, sizeof(*pte_addr));
>   	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> +	sun50i_iommu_zap_iova(sun50i_domain->iommu, iova);
> +	sun50i_iommu_zap_ptw_cache(sun50i_domain->iommu, iova);

Hmm, we already have .iotlb_sync hooked up for this, so at best adding 
more maintenance here is simply redundant, but at worst it would be 
papering over some bug in sun50i_iommu_iotlb_sync() - if unmaps really 
aren't working properly then that wants fixing instead. Of course it 
could also be enhanced to use the gather mechanism to perform more 
selective invalidations, but that's another patch in its own right.

Thanks,
Robin.

>   
>   	return SZ_4K;
>   }
