Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3480B6D085F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjC3Ocf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjC3Oce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:32:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B39AD187
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:32:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9203B12FC;
        Thu, 30 Mar 2023 07:33:16 -0700 (PDT)
Received: from [10.1.35.23] (e122027.cambridge.arm.com [10.1.35.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB1073F663;
        Thu, 30 Mar 2023 07:32:30 -0700 (PDT)
Message-ID: <864ef90a-c235-1e72-7941-6766541bb199@arm.com>
Date:   Thu, 30 Mar 2023 15:32:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] iommu/rockchip: Add missing set_platform_dma_ops
 callback
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@ziepe.ca>, John Keeping <john@metanate.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20230324111127.221640-1-steven.price@arm.com>
 <ZCGpmHUWyZVaeIIx@donbot> <ZCG1v9hRybc/951e@ziepe.ca>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <ZCG1v9hRybc/951e@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 16:26, Jason Gunthorpe wrote:
> On Mon, Mar 27, 2023 at 03:35:04PM +0100, John Keeping wrote:
>> On Fri, Mar 24, 2023 at 11:11:27AM +0000, Steven Price wrote:
>>> Similar to exynos, we need a set_platform_dma_ops() callback for proper
>>> operation on ARM 32 bit after recent changes in the IOMMU framework
>>> (detach ops removal). But also the use of a NULL domain is confusing.
>>>
>>> Rework the code to have a singleton rk_identity_domain which is assigned
>>> to domain when using an identity mapping rather than "detaching". This
>>> makes the code easier to reason about.
>>>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>> Changes since v1[1]:
>>>
>>>  * Reworked the code to avoid a NULL domain, instead a singleton
>>>    rk_identity_domain is used instead. The 'detach' language is no
>>>    longer used.
>>>
>>> [1] https://lore.kernel.org/r/20230315164152.333251-1-steven.price%40arm.com
>>>
>>>  drivers/iommu/rockchip-iommu.c | 50 ++++++++++++++++++++++++++--------
>>>  1 file changed, 39 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
>>> index f30db22ea5d7..437541004994 100644
>>> --- a/drivers/iommu/rockchip-iommu.c
>>> +++ b/drivers/iommu/rockchip-iommu.c
>> [snip]
>>> +static struct iommu_domain rk_identity_domain = {
>>> +	.type = IOMMU_DOMAIN_IDENTITY,
>>> +	.ops = &rk_identity_ops,
>>> +};
>>> +
>>> +#ifdef CONFIG_ARM
>>
>> Is this #ifdef needed?  I can't see anything ARM-specific about this
>> function or .set_platform_dma_ops.
> 
> set_platform_dma_ops is never called on ARM64.

I have to admit this was somewhat cargo-culted from the exynos-iommu
change. This is only needed for Arm, but I'm not sure if there's any
real harm including it for other arches.

>> Not shown in the patch are the pm_runtime hooks.  Do they need to
>> change like this?
> 
> Most likely yes

Good spot - I'll send a v3 with this fixed.

Thanks,

Steve

