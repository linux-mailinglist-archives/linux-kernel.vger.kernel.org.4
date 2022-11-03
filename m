Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3392C618022
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiKCOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiKCOwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:52:46 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E90219018
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:52:16 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oqbZd-0006qR-Fy; Thu, 03 Nov 2022 15:52:05 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Simon Xue <xxm@rock-chips.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH] iommu/rockchip: fix permission bits in page table entries v2
Date:   Thu, 03 Nov 2022 15:52:04 +0100
Message-ID: <4780234.31r3eYUQgx@diego>
In-Reply-To: <20221102063553.2464161-1-michael.riesch@wolfvision.net>
References: <20221102063553.2464161-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 2. November 2022, 07:35:53 CET schrieb Michael Riesch:
> As pointed out in the corresponding downstream fix [0], the permission bits
> of the page table entries are compatible between v1 and v2 of the IOMMU.
> This is in contrast to the current mainline code that incorrectly assumes
> that the read and write permission bits are switched. Fix the permission
> bits by reusing the v1 bit defines.
> 
> [0] https://github.com/rockchip-linux/kernel/commit/e3bc123a2260145e34b57454da3db0edd117eb8e
> 
> Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/iommu/rockchip-iommu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index a3fc59b814ab..a68eadd64f38 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -280,19 +280,17 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
>   *  11:9 - Page address bit 34:32
>   *   8:4 - Page address bit 39:35
>   *     3 - Security
> - *     2 - Readable
> - *     1 - Writable
> + *     2 - Writable
> + *     1 - Readable
>   *     0 - 1 if Page @ Page address is valid
>   */
> -#define RK_PTE_PAGE_READABLE_V2      BIT(2)
> -#define RK_PTE_PAGE_WRITABLE_V2      BIT(1)
>  
>  static u32 rk_mk_pte_v2(phys_addr_t page, int prot)
>  {
>  	u32 flags = 0;
>  
> -	flags |= (prot & IOMMU_READ) ? RK_PTE_PAGE_READABLE_V2 : 0;
> -	flags |= (prot & IOMMU_WRITE) ? RK_PTE_PAGE_WRITABLE_V2 : 0;
> +	flags |= (prot & IOMMU_READ) ? RK_PTE_PAGE_READABLE : 0;
> +	flags |= (prot & IOMMU_WRITE) ? RK_PTE_PAGE_WRITABLE : 0;
>  
>  	return rk_mk_dte_v2(page) | flags;
>  }
> 




