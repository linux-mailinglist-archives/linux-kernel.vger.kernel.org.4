Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385BB732F62
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345568AbjFPLET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbjFPLDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:03:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D40D55BE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:58:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D836E1FB;
        Fri, 16 Jun 2023 03:58:59 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F2653F5A1;
        Fri, 16 Jun 2023 03:58:14 -0700 (PDT)
Message-ID: <7c6558bc-36a2-a9fa-dc66-466b3948f61f@arm.com>
Date:   Fri, 16 Jun 2023 11:58:09 +0100
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
 <67aab611-29cd-1a80-d0e2-e5b6523b2785@arm.com>
 <0feaf393-21ca-f6ff-bc5d-d179d6169a70@kwiboo.se>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0feaf393-21ca-f6ff-bc5d-d179d6169a70@kwiboo.se>
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

On 2023-06-15 23:26, Jonas Karlman wrote:
> On 2023-06-15 23:25, Robin Murphy wrote:
>> On 2023-06-15 21:10, Jonas Karlman wrote:
>>> Newer Rockchip SoCs, RK356x and RK3588, support more then 4GB of memory.
>>
>> Older ones supposedly did too, e.g. commit 79db45be2b8b ("ARM: dts:
>> rockchip: convert rk3288 device tree files to 64 bits"). Are we certain
>> that nobody actually has a system with IOMMUv1 and more than 4GB of RAM?
> 
> In IOMMU v1 bit 11:0 read back as 0 from MMU_DTE_ADDR reg, so I expect
> that the old limit for v1 is 4GB.

Right, that was my point, sorry if it was unclear - on at least RK3288, 
the *SoC* apparently supports RAM above 4GB, even if it's only the CPUs 
that can access it. GFP_DMA32 technically *is* correct and appropriate 
for IOMMUv1, so it's only safe to unconditionally remove it if we're 
sure that, on all relevant IOMMUv1 SoCs in practice, no RAM above 4GB 
exists such that ZONE_NORMAL is empty and all allocations come from 
ZONE_DMA32 by default anyway.

(in truth this only matters for 64-bit SoCs, since on 32-bit there is no 
ZONE_DMA32, but any >4GB RAM would already have to be in ZONE_HIGHMEM, 
so safely out of scope)

Thanks,
Robin.

> I will reword this to focus on IOMMU
> v1 vs v2 instead of SoCs in v3.
> 
>>
>>> However, the RK IOMMU driver is using the GFP_DMA32 flag to limit
>>> allocation of the discovery and page tables into memory below 4GB.
>>>
>>> Let's remove this limitation now that the discovery table address is
>>
>> Nit: s/discovery/directory/g again
> 
> Will fix in v3 :-)
> 
> Regards,
> Jonas
> 
>>
>> Thanks,
>> Robin.
>>
>>> correctly configured for addresses above 4GB.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> v2:
>>> - no change
>>>
>>>    drivers/iommu/rockchip-iommu.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
>>> index 62be9bf42390..46498fc382ee 100644
>>> --- a/drivers/iommu/rockchip-iommu.c
>>> +++ b/drivers/iommu/rockchip-iommu.c
>>> @@ -727,7 +727,7 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
>>>    	if (rk_dte_is_pt_valid(dte))
>>>    		goto done;
>>>    
>>> -	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | GFP_DMA32);
>>> +	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC);
>>>    	if (!page_table)
>>>    		return ERR_PTR(-ENOMEM);
>>>    
>>> @@ -1076,7 +1076,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>>>    	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
>>>    	 * Allocate one 4 KiB page for each table.
>>>    	 */
>>> -	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
>>> +	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL);
>>>    	if (!rk_domain->dt)
>>>    		goto err_free_domain;
>>>    
> 
