Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA27321A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbjFOVZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjFOVZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:25:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44CAB213F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:25:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 457C31FB;
        Thu, 15 Jun 2023 14:26:10 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CC173F663;
        Thu, 15 Jun 2023 14:25:24 -0700 (PDT)
Message-ID: <67aab611-29cd-1a80-d0e2-e5b6523b2785@arm.com>
Date:   Thu, 15 Jun 2023 22:25:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] iommu: rockchip: Allocate tables from all
 available memory
Content-Language: en-GB
To:     Jonas Karlman <jonas@kwiboo.se>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230615201042.2291867-1-jonas@kwiboo.se>
 <20230615201042.2291867-4-jonas@kwiboo.se>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230615201042.2291867-4-jonas@kwiboo.se>
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
> Newer Rockchip SoCs, RK356x and RK3588, support more then 4GB of memory.

Older ones supposedly did too, e.g. commit 79db45be2b8b ("ARM: dts: 
rockchip: convert rk3288 device tree files to 64 bits"). Are we certain 
that nobody actually has a system with IOMMUv1 and more than 4GB of RAM?

> However, the RK IOMMU driver is using the GFP_DMA32 flag to limit
> allocation of the discovery and page tables into memory below 4GB.
> 
> Let's remove this limitation now that the discovery table address is

Nit: s/discovery/directory/g again

Thanks,
Robin.

> correctly configured for addresses above 4GB.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2:
> - no change
> 
>   drivers/iommu/rockchip-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 62be9bf42390..46498fc382ee 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -727,7 +727,7 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
>   	if (rk_dte_is_pt_valid(dte))
>   		goto done;
>   
> -	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | GFP_DMA32);
> +	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC);
>   	if (!page_table)
>   		return ERR_PTR(-ENOMEM);
>   
> @@ -1076,7 +1076,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>   	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
>   	 * Allocate one 4 KiB page for each table.
>   	 */
> -	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
> +	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL);
>   	if (!rk_domain->dt)
>   		goto err_free_domain;
>   
