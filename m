Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7AA697A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjBOLJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBOLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:09:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C41A21F5EB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:09:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FCBB1042;
        Wed, 15 Feb 2023 03:10:13 -0800 (PST)
Received: from [10.57.90.25] (unknown [10.57.90.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAC213F703;
        Wed, 15 Feb 2023 03:09:28 -0800 (PST)
Message-ID: <f4559966-c99e-47d2-a5ab-d248c7ed8e52@arm.com>
Date:   Wed, 15 Feb 2023 11:09:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/4] iommu: Use group ownership to avoid driver attachment
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
 <20230213074941.919324-3-baolu.lu@linux.intel.com>
 <Y+pG9kWzR2c5I9FU@nvidia.com>
 <b7f501b0-42c4-5402-7bb1-b4681b6e624c@linux.intel.com>
 <BN9PR11MB52768BD174CE9F4AE40C12078CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4ac228af-fb74-2d89-b8d7-462186170e12@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4ac228af-fb74-2d89-b8d7-462186170e12@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-15 07:28, Baolu Lu wrote:
> On 2023/2/15 14:56, Tian, Kevin wrote:
>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>> Sent: Wednesday, February 15, 2023 1:51 PM
>>>
>>> On 2/13/23 10:19 PM, Jason Gunthorpe wrote:
>>>> On Mon, Feb 13, 2023 at 03:49:39PM +0800, Lu Baolu wrote:
>>>>> @@ -2992,6 +2987,14 @@ static ssize_t iommu_group_store_type(struct
>>> iommu_group *group,
>>>>>        else
>>>>>            return -EINVAL;
>>>>>
>>>>> +    if (req_type != IOMMU_DOMAIN_DMA_FQ ||
>>>>> +        group->default_domain->type != IOMMU_DOMAIN_DMA) {
>>>>> +        ret = iommu_group_claim_dma_owner(group, (void *)buf);
>>>>> +        if (ret)
>>>>> +            return ret;
>>>>> +        group_owner_claimed = true;
>>>>> +    }
>>>> I don't get it, this should be done unconditionally. If we couldn't
>>>> take ownership then we simply can't progress.
>>> The existing code allows the user to switch the default domain from
>>> strict to lazy invalidation mode. The default domain is not changed,
>>> hence it should be seamless and transparent to the device driver.
>> Is there real usage relying on this transition for a bound device?
>>
>> In concept strict->lazy transition implies relaxed DMA security. It's 
>> hard
>> to think of a motivation of doing so while the device might be doing
>> in-fly DMAs.
>>
>> Presumably such perf/security tradeoff should be planned way before
>> binding device/driver together.
>>
>> btw if strict->lazy is allowed why lazy->strict is prohibited?
>>
> 
> We all know, strict vs. lazy is a tradeoff between performance and
> security.
> 
> strict -> lazy: driver works in secure mode. This transition trades off
> security for better performance.
> 
> lazy->strict: The driver is already working in non-safety mode. This
> transition only results in worse performance. It makes no sense. If user
> want to put the driver in a secure mode, they need to unbind the driver,
> reset the device and do the lazy->strict transition.
> 
> Robin might have better insights.

Yes, this was added for a definite use-case in ChromeOS, where 
strict->lazy needs to support being done "live" since the device in 
question is the storage controller for the already-mounted root 
filesystem. Your reasoning seems to match what I summarised in the 
original commit message :)

Thanks,
Robin.
