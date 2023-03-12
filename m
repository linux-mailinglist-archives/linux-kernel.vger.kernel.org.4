Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B436B6316
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 04:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCLDy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 22:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLDy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 22:54:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2B75FEBD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 19:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678593265; x=1710129265;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ACoxk4/PlDtRtWi+8jMhKo8m5Plk+RdEI+p16laYChY=;
  b=Fl6qXV59XzHHEpEpkPucYVVRQG5lB6iQ3iDP9nSO+vhROZWPf8FNBu9D
   TS7+A8IyQ2DjhZFD7/fR9aLXB3PISgs8gurmn5rdxveH75Fgee7HM+JIu
   MvmZQj+zcZ1GTvsEEexN2T8oHgBvHfQ2FM7vakhNXdJpMqpcQVz36IlKq
   zWCeTJuoBWkIoZtFM767JDsg4Vq6TIPyH+/RBctg3RwV4dRw0hV25Cch0
   3oIdnd6/A6bxyjkL6B7Fnvgdav34C9UyO0Sv9d4YDeP3ZLDSbZkkY877K
   qcuUhjmv290NBtT0+cyKCIhEvj5vywOaXgIPENq5A3Tu/CJ+ZAjNao8JO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="399555390"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="399555390"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 19:54:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="671505664"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="671505664"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2023 19:54:22 -0800
Message-ID: <dd70b106-5235-7b39-157c-9952f1068bc0@linux.intel.com>
Date:   Sun, 12 Mar 2023 11:53:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] ARM/dma-mapping: Add arm_iommu_release_device()
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
 <20230306025804.13912-2-baolu.lu@linux.intel.com>
 <7b248ba1-3967-5cd8-82e9-0268c706d320@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7b248ba1-3967-5cd8-82e9-0268c706d320@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 6:04 AM, Robin Murphy wrote:
> On 2023-03-06 02:57, Lu Baolu wrote:
>> It is like arm_iommu_detach_device() except it handles the special case
>> of being called under an iommu driver's release operation. In this case
>> the driver must have already detached the device from any attached
>> domain before calling this function.
>>
>> Replace arm_iommu_detach_device() with arm_iommu_release_device() in the
>> release path of the ipmmu-vmsa driver.
>>
>> The bonus is that it also removes a obstacle of arm_iommu_detach_device()
>> re-entering the iommu core during release_device. With this removed, the
>> iommu core code could be simplified a lot.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   arch/arm/include/asm/dma-iommu.h |  1 +
>>   arch/arm/mm/dma-mapping.c        | 25 +++++++++++++++++++++++++
>>   drivers/iommu/ipmmu-vmsa.c       | 15 +++++++++++++--
>>   3 files changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/dma-iommu.h 
>> b/arch/arm/include/asm/dma-iommu.h
>> index fe9ef6f79e9c..ea7198a17861 100644
>> --- a/arch/arm/include/asm/dma-iommu.h
>> +++ b/arch/arm/include/asm/dma-iommu.h
>> @@ -31,6 +31,7 @@ void arm_iommu_release_mapping(struct 
>> dma_iommu_mapping *mapping);
>>   int arm_iommu_attach_device(struct device *dev,
>>                       struct dma_iommu_mapping *mapping);
>>   void arm_iommu_detach_device(struct device *dev);
>> +void arm_iommu_release_device(struct device *dev);
>>   #endif /* __KERNEL__ */
>>   #endif
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 8bc01071474a..96fa27f4a164 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -1682,6 +1682,31 @@ int arm_iommu_attach_device(struct device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
>> +/**
>> + * arm_iommu_release_device
>> + * @dev: valid struct device pointer
>> + *
>> + * This is like arm_iommu_detach_device() except it handles the special
>> + * case of being called under an iommu driver's release operation. In 
>> this
>> + * case the driver must have already detached the device from any 
>> attached
>> + * domain before calling this function.
>> + */
>> +void arm_iommu_release_device(struct device *dev)
>> +{
>> +    struct dma_iommu_mapping *mapping;
>> +
>> +    mapping = to_dma_iommu_mapping(dev);
>> +    if (!mapping) {
>> +        dev_warn(dev, "Not attached\n");
>> +        return;
>> +    }
>> +
>> +    kref_put(&mapping->kref, release_iommu_mapping);
>> +    to_dma_iommu_mapping(dev) = NULL;
>> +    set_dma_ops(dev, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(arm_iommu_release_device);
>> +
>>   /**
>>    * arm_iommu_detach_device
>>    * @dev: valid struct device pointer
>> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
>> index bdf1a4e5eae0..de9c74cf61a4 100644
>> --- a/drivers/iommu/ipmmu-vmsa.c
>> +++ b/drivers/iommu/ipmmu-vmsa.c
>> @@ -30,7 +30,7 @@
>>   #define arm_iommu_create_mapping(...)    NULL
>>   #define arm_iommu_attach_device(...)    -ENODEV
>>   #define arm_iommu_release_mapping(...)    do {} while (0)
>> -#define arm_iommu_detach_device(...)    do {} while (0)
>> +#define arm_iommu_release_device(...)    do {} while (0)
>>   #endif
>>   #define IPMMU_CTX_MAX        16U
>> @@ -820,7 +820,18 @@ static void ipmmu_probe_finalize(struct device *dev)
>>   static void ipmmu_release_device(struct device *dev)
>>   {
>> -    arm_iommu_detach_device(dev);
>> +    struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>> +    struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < fwspec->num_ids; ++i) {
>> +        unsigned int utlb = fwspec->ids[i];
>> +
>> +        ipmmu_imuctr_write(mmu, utlb, 0);
>> +        mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
>> +    }
>> +
>> +    arm_iommu_release_device(dev);
> 
> Just call the existing arm_iommu_release_mapping(). Look at where the 
> BUS_NOTIFY_REMOVED_DEVICE point is in device_del(); this device is not 
> coming back. Zeroing out pointers and testing for a condition which 
> cannot be true by construction is simply a waste of time and code.

Fair enough. But the driver seems to have done things wrong.

It creates arm mappings in iommu probe path, but release it in the
driver's .remove path (see ipmmu_remove()). So perhaps we should move
calling arm_iommu_release_mapping() from ipmmu_remove() to
ipmmu_release_device()?

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index de9c74cf61a4..057050c28360 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -831,7 +831,7 @@ static void ipmmu_release_device(struct device *dev)
                 mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
         }

-       arm_iommu_release_device(dev);
+       arm_iommu_release_mapping(mmu->mapping);
  }

  static struct iommu_group *ipmmu_find_group(struct device *dev)
@@ -1091,8 +1091,6 @@ static int ipmmu_remove(struct platform_device *pdev)
         iommu_device_sysfs_remove(&mmu->iommu);
         iommu_device_unregister(&mmu->iommu);

-       arm_iommu_release_mapping(mmu->mapping);
-
         ipmmu_device_reset(mmu);

         return 0;

Best regards,
baolu
