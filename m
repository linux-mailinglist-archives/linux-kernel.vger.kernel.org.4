Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51887321F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjFOVzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjFOVz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:55:29 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA647296F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=pmSNmFv8Qq/2rHp1zEKtJzjGqmBa6T/jN8+FgSZUDls=;
        b=p6CehaPAY1h1iCF05fwKdPovmHB53S/8IxXG0tcYDMWyFkOf5JLAeooCwDkP7SYvxKqq
        LWrrFfGnFNB/obKwzPNQYfwfFOmy8fO9OJ5ZZp5h+npxbUzRJKoK2p4u0xefHqElmQ4WZH
        kunhtv9sOH1ZIligw0EuMryiRJfa2wG5OswWHs1cR+Vy6s/0i7iwGUsFTxR444ucu44iGg
        OizU3T0TNVpM/Z2b8YsLf9AwfARu4FlCNMhfkeFJYDLf9CjWNq5T/ViRHRhc6cSSZRiFRS
        StFScmxsB6hEk2nIuN+0jSMaRW6lFL1sovqweKtwRUPfxy8THF1k+Q3FUvmCRcOQ==
Received: by filterdrecv-8684c58db7-nd6mk with SMTP id filterdrecv-8684c58db7-nd6mk-1-648B88CB-19
        2023-06-15 21:55:23.885959543 +0000 UTC m=+3104213.148175023
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-9 (SG) with ESMTP
        id SyILOUxbSpSZyd76TgqJvw
        Thu, 15 Jun 2023 21:55:23.448 +0000 (UTC)
Message-ID: <76bd851f-ce85-4695-2f6c-797019f50ba6@kwiboo.se>
Date:   Thu, 15 Jun 2023 21:55:24 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/3] iommu: rockchip: Fix discovery table address
 encoding
Content-Language: en-US
References: <20230615201042.2291867-1-jonas@kwiboo.se>
 <20230615201042.2291867-2-jonas@kwiboo.se>
 <81ea403e-1279-bb01-9b74-51afd6d8532b@arm.com>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <81ea403e-1279-bb01-9b74-51afd6d8532b@arm.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h7EUeRq2SPOAxvJSb?=
 =?us-ascii?Q?IwwbxO8yaLTE9GQ552mGiSuOFkpow81qZjI9loa?=
 =?us-ascii?Q?ewxGLE8qaAGjuXJiqPzIky7teT5aRw6d250sBRm?=
 =?us-ascii?Q?v8oLyTeRx2s5BkyMjm+i1A+bxRnKq+UigYfE053?=
 =?us-ascii?Q?16vKOpEyM9khkmrAy4K=2F2B7k+6efrwvj+rCk7=2F?=
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-15 23:24, Robin Murphy wrote:
> On 2023-06-15 21:10, Jonas Karlman wrote:
>> The address to the discovery table is currently encoded using the
>> following bit layout.
>>
>>   31:12 - Address bit 31:0
>>   11: 4 - Address bit 39:32
>>
>> This is also the bit layout used by the vendor kernel.
>>
>> However, testing has shown that addresses to the discovery/page tables
>> and memory pages are all encoded using the same bit layout.
>>
>> IOMMU v1:
>>   31:12 - Address bit 31:0
>>
>> IOMMU v2:
>>   31:12 - Address bit 31:0
>>   11: 8 - Address bit 35:32
>>    7: 4 - Address bit 39:36
>>
>> Change to use the mk_dtentries ops to encode the discovery table address
> 
> Nit: s/discovery/directory/g

Oops, will fix in entire series in a v3 :-)

> 
>> correctly. Also update the bit layout comment for the page address.
>>
>> These changes render the dte_addr_phys and dma_addr_dte ops unused
>> and will be removed in a following patch.
> 
> TBH I'd just squash that into this patch - we don't gain anything from 
> leaving dead code in stable kernels, and at worst it just stands to make 
> future fixes harder to backport.

Make sense, will squash them in v3.

> 
>> Fixes: 227014b33f62 ("iommu: rockchip: Add internal ops to handle variants")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2:
>> - replace currently with correctly in commit message
>>
>>   drivers/iommu/rockchip-iommu.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
>> index 4054030c3237..d46319f77e5c 100644
>> --- a/drivers/iommu/rockchip-iommu.c
>> +++ b/drivers/iommu/rockchip-iommu.c
>> @@ -278,8 +278,8 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
>>   /*
>>    * In v2:
>>    * 31:12 - Page address bit 31:0
>> - *  11:9 - Page address bit 34:32
>> - *   8:4 - Page address bit 39:35
>> + * 11: 8 - Page address bit 35:32
>> + *  7: 4 - Page address bit 39:36
>>    *     3 - Security
>>    *     2 - Writable
>>    *     1 - Readable
>> @@ -577,7 +577,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
>>   	page_offset = rk_iova_page_offset(iova);
>>   
>>   	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
>> -	mmu_dte_addr_phys = rk_ops->dte_addr_phys(mmu_dte_addr);
>> +	mmu_dte_addr_phys = rk_ops->pt_address(mmu_dte_addr);
>>   
>>   	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
>>   	dte_addr = phys_to_virt(dte_addr_phys);
>> @@ -967,7 +967,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>>   
>>   	for (i = 0; i < iommu->num_mmu; i++) {
>>   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>> -			       rk_ops->dma_addr_dte(rk_domain->dt_dma));
>> +			       rk_ops->mk_dtentries(rk_domain->dt_dma));
> 
> Hmm, this writes the RK_DTE_PT_VALID bit into the register as well - 
> does that really make sense?

On v1 bit 11:0 behave as read-only and on v2 bit 3:0 behave read-only.
Writing anything to those bits read back as 0, so was safe to write
RK_DTE_PT_VALID. Should probably mention this in a comment in v3.

Regards,
Jonas

> 
> Thanks,
> Robin.
> 
>>   		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
>>   		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
>>   	}

