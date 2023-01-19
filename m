Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0FA6742EE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjASTg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjASTg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:36:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 617CD58293
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:36:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE8DF13D5;
        Thu, 19 Jan 2023 11:37:06 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FEAC3F67D;
        Thu, 19 Jan 2023 11:36:24 -0800 (PST)
Message-ID: <651bfdea-19ce-1b4b-3ebd-bbd558d8403b@arm.com>
Date:   Thu, 19 Jan 2023 19:36:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/8] iommu: Factor out a "first device in group" helper
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, hch@lst.de,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1673978700.git.robin.murphy@arm.com>
 <592bff75a7fc4d50d5b2435a09dfff19f1072973.1673978700.git.robin.murphy@arm.com>
 <Y8mYlV/ODKZ3EG57@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y8mYlV/ODKZ3EG57@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 7:23 pm, Jason Gunthorpe wrote:
> On Thu, Jan 19, 2023 at 07:18:21PM +0000, Robin Murphy wrote:
>> This pattern for picking the first device out of the group list is
>> repeated a few times now, so it's clearly worth factoring out.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/iommu.c | 22 ++++++++++------------
>>   1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index bc53ffbba4de..5b37766a09e2 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1084,6 +1084,11 @@ void iommu_group_remove_device(struct device *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_group_remove_device);
>>   
>> +static struct device *iommu_group_first_dev(struct iommu_group *group)
>> +{
> 
> Add a
>   lockdep_assert_held(&group->lock);
> 
> ?

Sure, could do. I guess I didn't consider it since 
iommu_group_device_count() and __iommu_group_for_each_dev() don't assert 
it either, but that's not to say they couldn't change too.

>> -	group->blocking_domain =
>> -		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
>> +	group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_BLOCKED);
>>   	if (!group->blocking_domain) {
>>   		/*
>>   		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
>>   		 * create an empty domain instead.
>>   		 */
>> -		group->blocking_domain = __iommu_domain_alloc(
>> -			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
>> +		group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_UNMANAGED);
>>   		if (!group->blocking_domain)
>>   			return -EINVAL;
> 
> These are extra hunks?

The annoyingly-subtle difference between "dev->dev->bus" and "dev->bus" 
is precisely one of the reasons I think hiding the group_device behind a 
helper is worthwhile ;)

Thanks,
Robin.
