Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFF867CD94
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjAZOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjAZOVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:21:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93112D1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:21:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17B554B3;
        Thu, 26 Jan 2023 06:22:20 -0800 (PST)
Received: from [10.57.89.209] (unknown [10.57.89.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F25A3F5A1;
        Thu, 26 Jan 2023 06:21:36 -0800 (PST)
Message-ID: <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com>
Date:   Thu, 26 Jan 2023 14:21:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     hch@lst.de, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1673978700.git.robin.murphy@arm.com>
 <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-26 13:13, Baolu Lu wrote:
> On 2023/1/20 3:18, Robin Murphy wrote:
>> Much as I'd like to remove iommu_present(), the final remaining users
>> are proving stubbornly difficult to clean up, so kick that can down
>> the road and just rework it to preserve the current behaviour without
>> depending on bus ops.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/iommu.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index b189ed345057..a77d58e1b976 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1871,9 +1871,24 @@ int bus_iommu_probe(struct bus_type *bus)
>>       return ret;
>>   }
>> +static int __iommu_present(struct device *dev, void *unused)
>> +{
>> +    return device_iommu_mapped(dev);
>> +}
> 
> /**
>   * device_iommu_mapped - Returns true when the device DMA is translated
>   *                       by an IOMMU
>   * @dev: Device to perform the check on
>   */
> static inline bool device_iommu_mapped(struct device *dev)
> {
>          return (dev->iommu_group != NULL);
> }
> 
> Perhaps device_iommu_mapped() should be improved. In some cases, the
> device has an iommu_group filled is not enough to indicate that the
> device has IOMMU hardware for DMA translation.
> 
> For example, VFIO could allocate an iommu_group and add a device into
> the iommu_group even there's no IOMMU hardware in
> vfio_noiommu_group_alloc().
> 
> Basically iommu_group_add_device() doesn't check the presence of an
> IOMMU.

/**
  * iommu_group_add_device [...]
  *
  * This function is called by an iommu driver [...]
  */

The "check" is inherent in the fact that it's been called at all. VFIO 
noiommu *is* an IOMMU driver in the sense that it provides a bare 
minimum of IOMMU API functionality (i.e. creating groups), sufficient to 
support (careful) usage by VFIO drivers. There would not seem to be a 
legitimate reason for some *other* driver to be specifically querying a 
device while it is already bound to a VFIO driver (and thus may have a 
noiommu group).

In terms of this patch, I'm confident that nobody is using VFIO noiommu 
on old Tegra SoCs; I'm even more confident that they wouldn't be doing 
it with platform devices; and I'm supremely confident that they're not 
loading the GPU drivers while already in the middle of using noiommu 
vfio_platform. Basically "not using VFIO noiommu" is one of the inherent 
platform-specific assumptions. If anyone else now ignores the first 
sentence of the documentation and tries to use iommu_present() somewhere 
that assumption might not hold, returning a meaningless wrong answer is 
the documented behaviour :)

Cheers,
Robin.

> 
>> +
>> +/**
>> + * iommu_present() - make platform-specific assumptions about an IOMMU
>> + * @bus: bus to check
>> + *
>> + * Do not use this function. You want device_iommu_mapped() instead.
>> + *
>> + * Return: true if some IOMMU is present for some device on the given 
>> bus. In
>> + * general it may not be the only IOMMU, and it may not be for the 
>> device you
>> + * are ultimately interested in.
>> + */
>>   bool iommu_present(struct bus_type *bus)
>>   {
>> -    return bus->iommu_ops != NULL;
>> +    return bus_for_each_dev(bus, NULL, NULL, __iommu_present) > 0;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_present);
> 
> -- 
> Best regards,
> baolu
