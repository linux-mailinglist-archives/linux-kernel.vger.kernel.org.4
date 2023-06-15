Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9C73219F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjFOVY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbjFOVYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:24:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F42141FC2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:24:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDE851FB;
        Thu, 15 Jun 2023 14:25:35 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3B773F663;
        Thu, 15 Jun 2023 14:24:49 -0700 (PDT)
Message-ID: <81ea403e-1279-bb01-9b74-51afd6d8532b@arm.com>
Date:   Thu, 15 Jun 2023 22:24:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/3] iommu: rockchip: Fix discovery table address
 encoding
Content-Language: en-GB
To:     Jonas Karlman <jonas@kwiboo.se>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
References: <20230615201042.2291867-1-jonas@kwiboo.se>
 <20230615201042.2291867-2-jonas@kwiboo.se>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230615201042.2291867-2-jonas@kwiboo.se>
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

On 2023-06-15 21:10, Jonas Karlman wrote:
> The address to the discovery table is currently encoded using the
> following bit layout.
> 
>   31:12 - Address bit 31:0
>   11: 4 - Address bit 39:32
> 
> This is also the bit layout used by the vendor kernel.
> 
> However, testing has shown that addresses to the discovery/page tables
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
> Change to use the mk_dtentries ops to encode the discovery table address

Nit: s/discovery/directory/g

> correctly. Also update the bit layout comment for the page address.
> 
> These changes render the dte_addr_phys and dma_addr_dte ops unused
> and will be removed in a following patch.

TBH I'd just squash that into this patch - we don't gain anything from 
leaving dead code in stable kernels, and at worst it just stands to make 
future fixes harder to backport.

> Fixes: 227014b33f62 ("iommu: rockchip: Add internal ops to handle variants")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2:
> - replace currently with correctly in commit message
> 
>   drivers/iommu/rockchip-iommu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 4054030c3237..d46319f77e5c 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -278,8 +278,8 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
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
> @@ -577,7 +577,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
>   	page_offset = rk_iova_page_offset(iova);
>   
>   	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
> -	mmu_dte_addr_phys = rk_ops->dte_addr_phys(mmu_dte_addr);
> +	mmu_dte_addr_phys = rk_ops->pt_address(mmu_dte_addr);
>   
>   	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
>   	dte_addr = phys_to_virt(dte_addr_phys);
> @@ -967,7 +967,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>   
>   	for (i = 0; i < iommu->num_mmu; i++) {
>   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
> -			       rk_ops->dma_addr_dte(rk_domain->dt_dma));
> +			       rk_ops->mk_dtentries(rk_domain->dt_dma));

Hmm, this writes the RK_DTE_PT_VALID bit into the register as well - 
does that really make sense?

Thanks,
Robin.

>   		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
>   		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
>   	}
