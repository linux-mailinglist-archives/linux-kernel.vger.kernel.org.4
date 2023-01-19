Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D7674356
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjASUM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjASUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:12:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9AA39373F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:12:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A6FA1515;
        Thu, 19 Jan 2023 12:13:00 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0A9F3F67D;
        Thu, 19 Jan 2023 12:12:17 -0800 (PST)
Message-ID: <7a3dad54-6236-17d0-e859-be316d888a62@arm.com>
Date:   Thu, 19 Jan 2023 20:12:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/8] iommu: Switch __iommu_domain_alloc() to device ops
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, hch@lst.de,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1673978700.git.robin.murphy@arm.com>
 <25ea8128b9228f9893507ad5a764ff25db5961a0.1673978700.git.robin.murphy@arm.com>
 <Y8mZbh56MzXWpbi9@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y8mZbh56MzXWpbi9@nvidia.com>
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

On 19/01/2023 7:26 pm, Jason Gunthorpe wrote:
> On Thu, Jan 19, 2023 at 07:18:22PM +0000, Robin Murphy wrote:
> 
>> -static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>> +static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
>>   						 unsigned type)
>>   {
>> -	const struct iommu_ops *ops = bus ? bus->iommu_ops : NULL;
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>   	struct iommu_domain *domain;
>>   
>> -	if (!ops)
>> -		return NULL;
>> -
>>   	domain = ops->domain_alloc(type);
>>   	if (!domain)
>>   		return NULL;
>> @@ -1970,9 +1968,28 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>   	return domain;
>>   }
>>   
>> +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
>> +{
>> +	struct device **alloc_dev = data;
>> +
>> +	if (!device_iommu_mapped(dev))
>> +		return 0;
> 
> Is 0 the right thing? see below

Yes, the idea here is to always double-check the whole bus.

>> +
>> +	WARN_ONCE(*alloc_dev && dev_iommu_ops(dev) != dev_iommu_ops(*alloc_dev),
>> +		"Multiple IOMMU drivers present, which the public IOMMU API can't fully support yet. This may not work as expected, sorry!\n");
> 
> if (WARN_ONCE(..))
>     return -EINVAL
> 
> So that iommu_domain_alloc fails?

The current behaviour is that if you have multiple different IOMMUs 
present, then only one driver succeeds in registering, effectively at 
random depending on probe order. To get predictable behaviour where 
iommu_domain_alloc() (and indeed the whole IOMMU API) works for a 
specific device, you have to manage your kernel config or modules to 
only load the driver for the correct IOMMU.

After patch #4, we allow all the drivers to register, but the net effect 
on the public API is still the same - it only works successfully for one 
driver, effectively at random - and the same solution - don't load the 
other drivers, or at least load them in an appropriate order relative to 
the client drivers - still applies. On those grounds it seems a fair 
compromise until we can sort iommu_domain_alloc() itself. As far as I'm 
aware there are still no immediate real-world users for this - upstream 
support for Rockchip RK3588 is still in very early days, and a long way 
off being complete enough for users to get interested in trying to play 
with the Arm SMMUs in there (leading to disappointment that VFIO won't 
work since they're non-coherent...)

>> +	*alloc_dev = dev;
>> +	return 0;
>> +}
>> +
>>   struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>>   {
>> -	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
>> +	struct device *dev = NULL;
>> +
>> +	if (bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev))
>> +		return NULL;
> 
> eg shouldn't iommu_domain_alloc() return NULL if any devices are
> !device_iommu_mapped ?

No, that would even break the normal single-driver case, because it's 
always been the case that not all devices on e.g. the platform bus are 
iommu_mapped. That's largely why bus ops are a rubbish abstraction.

Even with multiple drivers, we can still allocate a domain here which 
will work fine with *some* devices, and safely fail to work with others, 
so I don't see that we'd gain much from being unnecessarily restrictive.

Thanks,
Robin.
