Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD5735993
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjFSOcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFSOcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:32:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBC81F1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:32:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60E2912FC;
        Mon, 19 Jun 2023 07:33:32 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58EC53F59C;
        Mon, 19 Jun 2023 07:32:47 -0700 (PDT)
Message-ID: <bbfd874e-4a07-5be5-dde3-2b44763eaa0a@arm.com>
Date:   Mon, 19 Jun 2023 15:32:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] iommu: rockchip: Fix directory table address
 encoding
Content-Language: en-GB
To:     Jonas Karlman <jonas@kwiboo.se>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
References: <20230617182540.3091374-1-jonas@kwiboo.se>
 <20230617182540.3091374-2-jonas@kwiboo.se>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230617182540.3091374-2-jonas@kwiboo.se>
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

On 17/06/2023 7:25 pm, Jonas Karlman wrote:
> The physical address to the directory table is currently encoded using
> the following bit layout for IOMMU v2.
> 
>   31:12 - Address bit 31:0
>   11: 4 - Address bit 39:32
> 
> This is also the bit layout used by the vendor kernel.
> 
> However, testing has shown that addresses to the directory/page tables
> and memory pages are all encoded using the same bit layout.
> 
> IOMMU v1:
>   31:12 - Address bit 31:0
> 
> IOMMU v2:
>   31:12 - Address bit 31:0
>   11: 8 - Address bit 35:32
>    7: 4 - Address bit 39:36
> 
> Change to use the mk_dtentries ops to encode the directory table address
> correctly. The value written to DTE_ADDR may include the valid bit set,
> a bit that is ignored and DTE_ADDR reg read it back as 0.
> 
> This also update the bit layout comment for the page address and the
> number of nybbles that are read back for DTE_ADDR comment.
> 
> These changes render the dte_addr_phys and dma_addr_dte ops unused and
> is removed.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 227014b33f62 ("iommu: rockchip: Add internal ops to handle variants")
> Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
> Fixes: c987b65a574f ("iommu/rockchip: Fix physical address decoding")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v3:
> - squash removal of unused ops into this patch
> - update commit message
> 
> v2:
> - replace currently with correctly in commit message
> 
>   drivers/iommu/rockchip-iommu.c | 43 ++++------------------------------
>   1 file changed, 5 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 4054030c3237..ae42959bc490 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -98,8 +98,6 @@ struct rk_iommu_ops {
>   	phys_addr_t (*pt_address)(u32 dte);
>   	u32 (*mk_dtentries)(dma_addr_t pt_dma);
>   	u32 (*mk_ptentries)(phys_addr_t page, int prot);
> -	phys_addr_t (*dte_addr_phys)(u32 addr);
> -	u32 (*dma_addr_dte)(dma_addr_t dt_dma);
>   	u64 dma_bit_mask;
>   };
>   
> @@ -278,8 +276,8 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
>   /*
>    * In v2:
>    * 31:12 - Page address bit 31:0
> - *  11:9 - Page address bit 34:32
> - *   8:4 - Page address bit 39:35
> + * 11: 8 - Page address bit 35:32
> + *  7: 4 - Page address bit 39:36
>    *     3 - Security
>    *     2 - Writable
>    *     1 - Readable
> @@ -506,7 +504,7 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
>   
>   	/*
>   	 * Check if register DTE_ADDR is working by writing DTE_ADDR_DUMMY
> -	 * and verifying that upper 5 nybbles are read back.
> +	 * and verifying that upper 5 (v1) or 7 (v2) nybbles are read back.
>   	 */
>   	for (i = 0; i < iommu->num_mmu; i++) {
>   		dte_addr = rk_ops->pt_address(DTE_ADDR_DUMMY);
> @@ -531,33 +529,6 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
>   	return 0;
>   }
>   
> -static inline phys_addr_t rk_dte_addr_phys(u32 addr)
> -{
> -	return (phys_addr_t)addr;
> -}
> -
> -static inline u32 rk_dma_addr_dte(dma_addr_t dt_dma)
> -{
> -	return dt_dma;
> -}
> -
> -#define DT_HI_MASK GENMASK_ULL(39, 32)
> -#define DTE_BASE_HI_MASK GENMASK(11, 4)
> -#define DT_SHIFT   28
> -
> -static inline phys_addr_t rk_dte_addr_phys_v2(u32 addr)
> -{
> -	u64 addr64 = addr;
> -	return (phys_addr_t)(addr64 & RK_DTE_PT_ADDRESS_MASK) |
> -	       ((addr64 & DTE_BASE_HI_MASK) << DT_SHIFT);
> -}
> -
> -static inline u32 rk_dma_addr_dte_v2(dma_addr_t dt_dma)
> -{
> -	return (dt_dma & RK_DTE_PT_ADDRESS_MASK) |
> -	       ((dt_dma & DT_HI_MASK) >> DT_SHIFT);
> -}
> -
>   static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
>   {
>   	void __iomem *base = iommu->bases[index];
> @@ -577,7 +548,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
>   	page_offset = rk_iova_page_offset(iova);
>   
>   	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
> -	mmu_dte_addr_phys = rk_ops->dte_addr_phys(mmu_dte_addr);
> +	mmu_dte_addr_phys = rk_ops->pt_address(mmu_dte_addr);
>   
>   	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
>   	dte_addr = phys_to_virt(dte_addr_phys);
> @@ -967,7 +938,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>   
>   	for (i = 0; i < iommu->num_mmu; i++) {
>   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
> -			       rk_ops->dma_addr_dte(rk_domain->dt_dma));
> +			       rk_ops->mk_dtentries(rk_domain->dt_dma));
>   		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
>   		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
>   	}
> @@ -1405,8 +1376,6 @@ static struct rk_iommu_ops iommu_data_ops_v1 = {
>   	.pt_address = &rk_dte_pt_address,
>   	.mk_dtentries = &rk_mk_dte,
>   	.mk_ptentries = &rk_mk_pte,
> -	.dte_addr_phys = &rk_dte_addr_phys,
> -	.dma_addr_dte = &rk_dma_addr_dte,
>   	.dma_bit_mask = DMA_BIT_MASK(32),
>   };
>   
> @@ -1414,8 +1383,6 @@ static struct rk_iommu_ops iommu_data_ops_v2 = {
>   	.pt_address = &rk_dte_pt_address_v2,
>   	.mk_dtentries = &rk_mk_dte_v2,
>   	.mk_ptentries = &rk_mk_pte_v2,
> -	.dte_addr_phys = &rk_dte_addr_phys_v2,
> -	.dma_addr_dte = &rk_dma_addr_dte_v2,
>   	.dma_bit_mask = DMA_BIT_MASK(40),
>   };
>   
