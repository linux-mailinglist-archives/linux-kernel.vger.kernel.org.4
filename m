Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E026C7EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjCXNY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjCXNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:24:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB798EB4D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:24:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5A6111FB;
        Fri, 24 Mar 2023 06:25:35 -0700 (PDT)
Received: from [10.1.28.32] (e122027.cambridge.arm.com [10.1.28.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 742EC3F766;
        Fri, 24 Mar 2023 06:24:49 -0700 (PDT)
Message-ID: <859ef16c-bf31-78f2-f3df-cf0ff9493b3c@arm.com>
Date:   Fri, 24 Mar 2023 13:24:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] iommu/rockchip: Add missing set_platform_dma_ops
 callback
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20230324111127.221640-1-steven.price@arm.com>
 <8fda817c-98e7-1988-325d-52d09f3e61a8@linux.intel.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <8fda817c-98e7-1988-325d-52d09f3e61a8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 13:16, Baolu Lu wrote:
> On 2023/3/24 19:11, Steven Price wrote:
>> Similar to exynos, we need a set_platform_dma_ops() callback for proper
>> operation on ARM 32 bit after recent changes in the IOMMU framework
>> (detach ops removal). But also the use of a NULL domain is confusing.
>>
>> Rework the code to have a singleton rk_identity_domain which is assigned
>> to domain when using an identity mapping rather than "detaching". This
>> makes the code easier to reason about.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>> Changes since v1[1]:
>>
>>   * Reworked the code to avoid a NULL domain, instead a singleton
>>     rk_identity_domain is used instead. The 'detach' language is no
>>     longer used.
>>
>> [1]
>> https://lore.kernel.org/r/20230315164152.333251-1-steven.price%40arm.com
>>
>>   drivers/iommu/rockchip-iommu.c | 50 ++++++++++++++++++++++++++--------
>>   1 file changed, 39 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/rockchip-iommu.c
>> b/drivers/iommu/rockchip-iommu.c
>> index f30db22ea5d7..437541004994 100644
>> --- a/drivers/iommu/rockchip-iommu.c
>> +++ b/drivers/iommu/rockchip-iommu.c
>> @@ -124,6 +124,7 @@ struct rk_iommudata {
>>     static struct device *dma_dev;
>>   static const struct rk_iommu_ops *rk_ops;
>> +static struct iommu_domain rk_identity_domain;
>>     static inline void rk_table_flush(struct rk_iommu_domain *dom,
>> dma_addr_t dma,
>>                     unsigned int count)
>> @@ -980,26 +981,27 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>>       return ret;
>>   }
>>   -static void rk_iommu_detach_device(struct iommu_domain *domain,
>> -                   struct device *dev)
>> +static int rk_iommu_identity_attach(struct iommu_domain
>> *identity_domain,
>> +                    struct device *dev)
>>   {
>>       struct rk_iommu *iommu;
>> -    struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
>> +    struct rk_iommu_domain *rk_domain;
>>       unsigned long flags;
>>       int ret;
>>         /* Allow 'virtual devices' (eg drm) to detach from domain */
>>       iommu = rk_iommu_from_dev(dev);
>>       if (!iommu)
>> -        return;
>> +        return -ENODEV;
>> +
>> +    rk_domain = to_rk_domain(iommu->domain);
>>         dev_dbg(dev, "Detaching from iommu domain\n");
>>   -    /* iommu already detached */
>> -    if (iommu->domain != domain)
>> -        return;
>> +    if (iommu->domain == identity_domain)
>> +        return 0;
>>   -    iommu->domain = NULL;
>> +    iommu->domain = identity_domain;
> 
> Where did identity_domain come from? Is it rk_identity_domain?

It's a parameter of the function. In the case of the call in
rk_iommu_attach_device() then, yes, it's rk_identity_domain. But this
function is also the "attach_dev" callback of "rk_identity_ops".

I'll admit this is cargo-culted from Jason's example:

https://lore.kernel.org/linux-iommu/ZBnef7g7GCxogPNz@ziepe.ca/

Steve

> Best regards,
> baolu

