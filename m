Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751287322B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbjFOW0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjFOW0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:26:22 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A69294C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=oL5Sf4DN4C0rGvgQrREbQI0hpi8aVNCMSN5ggBDOLUc=;
        b=lnxJO2f6Jck0dXNFj2fFbElwzO8Ctmsz6O51DPXTestnwVVEmjNJoKfLZHnFTU3TM7C/
        pEJNb+BcQcpCLfhhJoXLn3bF+KodJixl4TTLh6NF6s9gSaGKDaRAlCe3svXsRv/Fi0lQM2
        JJPGD7OfBRyWVvu0VY95GdO9lbVUT3oBQIQc1N7AjHsNrAqPVDfe2GEQJJ5/R3abF4dAeo
        ntbNxJnPmVqwUXBjTJTwBiNp/3/7oRW0QWmOdRMuxzI0Ro5AMxxsRp0eMdlbnPuCihQdB6
        ziHX3knS4rZHHkfocagwZhI08u50HvjZjbamJIeUYuGk+qQtMtUt6MqLrKiBPIcQ==
Received: by filterdrecv-8684c58db7-wf85l with SMTP id filterdrecv-8684c58db7-wf85l-1-648B9008-F
        2023-06-15 22:26:16.509597009 +0000 UTC m=+3106083.316181628
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-1 (SG) with ESMTP
        id -vigL8FLQS-IWjwBkT_I7g
        Thu, 15 Jun 2023 22:26:15.888 +0000 (UTC)
Message-ID: <0feaf393-21ca-f6ff-bc5d-d179d6169a70@kwiboo.se>
Date:   Thu, 15 Jun 2023 22:26:16 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/3] iommu: rockchip: Allocate tables from all
 available memory
Content-Language: en-US
References: <20230615201042.2291867-1-jonas@kwiboo.se>
 <20230615201042.2291867-4-jonas@kwiboo.se>
 <67aab611-29cd-1a80-d0e2-e5b6523b2785@arm.com>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <67aab611-29cd-1a80-d0e2-e5b6523b2785@arm.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h+iTJcMDX1ZiOTUeX?=
 =?us-ascii?Q?t=2FZZWEW6VVq5HLe1V7WSQINPAxweIzBnZavsSKB?=
 =?us-ascii?Q?SlkK37EVJfFh5UHVTGVPeTXUBenBv9SBg0iVmCZ?=
 =?us-ascii?Q?+yx+dhtUtr=2FYXdH97UOrwSOnNNe5friTp9mSbxu?=
 =?us-ascii?Q?MOqOOcV32ZFy=2FGdoo=2FhM8q2bAyxuN=2F87BGbHI3?=
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

On 2023-06-15 23:25, Robin Murphy wrote:
> On 2023-06-15 21:10, Jonas Karlman wrote:
>> Newer Rockchip SoCs, RK356x and RK3588, support more then 4GB of memory.
> 
> Older ones supposedly did too, e.g. commit 79db45be2b8b ("ARM: dts: 
> rockchip: convert rk3288 device tree files to 64 bits"). Are we certain 
> that nobody actually has a system with IOMMUv1 and more than 4GB of RAM?

In IOMMU v1 bit 11:0 read back as 0 from MMU_DTE_ADDR reg, so I expect
that the old limit for v1 is 4GB. I will reword this to focus on IOMMU
v1 vs v2 instead of SoCs in v3.

> 
>> However, the RK IOMMU driver is using the GFP_DMA32 flag to limit
>> allocation of the discovery and page tables into memory below 4GB.
>>
>> Let's remove this limitation now that the discovery table address is
> 
> Nit: s/discovery/directory/g again

Will fix in v3 :-)

Regards,
Jonas

> 
> Thanks,
> Robin.
> 
>> correctly configured for addresses above 4GB.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2:
>> - no change
>>
>>   drivers/iommu/rockchip-iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
>> index 62be9bf42390..46498fc382ee 100644
>> --- a/drivers/iommu/rockchip-iommu.c
>> +++ b/drivers/iommu/rockchip-iommu.c
>> @@ -727,7 +727,7 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
>>   	if (rk_dte_is_pt_valid(dte))
>>   		goto done;
>>   
>> -	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | GFP_DMA32);
>> +	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC);
>>   	if (!page_table)
>>   		return ERR_PTR(-ENOMEM);
>>   
>> @@ -1076,7 +1076,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>>   	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
>>   	 * Allocate one 4 KiB page for each table.
>>   	 */
>> -	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
>> +	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL);
>>   	if (!rk_domain->dt)
>>   		goto err_free_domain;
>>   

