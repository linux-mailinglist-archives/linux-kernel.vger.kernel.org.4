Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E68697AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjBOLYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjBOLYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:24:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 475D727D52
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:24:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B8BC1042;
        Wed, 15 Feb 2023 03:25:25 -0800 (PST)
Received: from [10.57.90.25] (unknown [10.57.90.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 347FE3F703;
        Wed, 15 Feb 2023 03:24:41 -0800 (PST)
Message-ID: <d4f1b33d-dec7-6582-34a1-495bacfcd396@arm.com>
Date:   Wed, 15 Feb 2023 11:24:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/4] iommu: Add dev_iommu->ops_rwsem
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
 <20230213074941.919324-2-baolu.lu@linux.intel.com>
 <Y+pGUOkLVUMFYWOb@nvidia.com>
 <9f516f44-3dc9-6f15-11d0-10bfb1b29b1e@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <9f516f44-3dc9-6f15-11d0-10bfb1b29b1e@linux.intel.com>
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

On 2023-02-15 05:34, Baolu Lu wrote:
> On 2/13/23 10:16 PM, Jason Gunthorpe wrote:
>> On Mon, Feb 13, 2023 at 03:49:38PM +0800, Lu Baolu wrote:
>>
>>> +static int iommu_group_freeze_dev_ops(struct iommu_group *group)
>>> +{
>>> +    struct group_device *device;
>>> +    struct device *dev;
>>> +
>>> +    mutex_lock(&group->mutex);
>>> +    list_for_each_entry(device, &group->devices, list) {
>>> +        dev = device->dev;
>>> +        down_read(&dev->iommu->ops_rwsem);
>>
>> This isn't allowed, you can't obtain locks in a loop like this, it
>> will deadlock.
>>
>> You don't need more locks, we already have the group mutex, the
>> release path should be fixed to use it properly as I was trying to do 
>> here:
>>
>> https://lore.kernel.org/kvm/4-v1-ef00ffecea52+2cb-iommu_group_lifetime_jgg@nvidia.com/
>> https://lore.kernel.org/kvm/YyyTxx0HnA3maxEk@nvidia.com/
>>
>> Then what you'd do in a path like this is:
>>
>>    mutex_lock(&group->mutex);
>>    dev = iommu_group_first_device(group)
>>    if (!dev)
>>       /* Racing with group cleanup */
>>       return -EINVAL;
>>    /* Now dev->ops is valid and must remain valid so long as
>>       group->mutex is held */
>>
>> The only reason this doesn't work already is because of the above
>> stuff about release not holding the group mutex when manipulating the
>> devices in the group. This is simply mis-locked.
>>
>> Robin explained it was done like this because
>> arm_iommu_detach_device() re-enters the iommu core during release_dev,
>> so I suggest fixing that by simply not doing that (see above)
>>
>> Below is the lastest attempt I had tried, I didn't have time to get back
>> to it and we fixed the bug another way. It needs a bit of adjusting to
>> also remove the device from the group after release is called within
>> the same mutex critical region.
> 
> Yes. If we can make remove device from list and device release in the
> same mutex critical region, we don't need any other lock mechanism
> anymore.
> 
> The ipmmu driver supports default domain.

It supports default domains *on arm64*. Nothing on 32-bit ARM uses 
default domains, they won't even exist since iommu-dma is not enabled, 
and either way the ARM DMA ops don't understand groups. I don't see an 
obvious satisfactory solution while the arm_iommu_* APIs still exist, 
but if we need bodges in the interim could we please try to concentrate 
them in ARM-specific code?

Thanks,
Robin.

> When code comes to release
> device, the device driver has already been unbound. The default domain
> should have been attached to the device. Then iommu_detach_device() does
> nothing because what it really does is just attaching default domain.
> 
> How about removing iommu_detach_device() from ipmmu's release path like
> below?
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index bdf1a4e5eae0..0bc29009703e 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -820,7 +820,16 @@ static void ipmmu_probe_finalize(struct device *dev)
> 
>   static void ipmmu_release_device(struct device *dev)
>   {
> -       arm_iommu_detach_device(dev);
> +       struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> +
> +       if (!mapping) {
> +               dev_warn(dev, "Not attached\n");
> +               return;
> +       }
> +
> +       arm_iommu_release_mapping(mapping);
> +       to_dma_iommu_mapping(dev) = NULL;
> +       set_dma_ops(dev, NULL);
>   }
> 
> After fixing this in ipmmu driver, we can safely put removing device and
> release_device in a group->mutex critical region in two steps:
> 
> Step 1: Refactor iommu_group_remove_device() w/o functionality change:
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 05522eace439..17b2e358a6fd 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1065,6 +1065,46 @@ int iommu_group_add_device(struct iommu_group 
> *group, struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_add_device);
> 
> +/*
> + * Remove a device from a group's device list and return the group device
> + * if successful.
> + */
> +static struct group_device *
> +__iommu_group_remove_device(struct iommu_group *group, struct device *dev)
> +{
> +    struct group_device *device;
> +
> +    lockdep_assert_held(&group->mutex);
> +    list_for_each_entry(device, &group->devices, list) {
> +        if (device->dev == dev) {
> +            list_del(&device->list);
> +            return device;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +/*
> + * Release a device from its group and decrements the iommu group 
> reference
> + * count.
> + */
> +static void __iommu_group_release_device(struct iommu_group *group,
> +                     struct group_device *grp_dev)
> +{
> +    struct device *dev = grp_dev->dev;
> +
> +    sysfs_remove_link(group->devices_kobj, grp_dev->name);
> +    sysfs_remove_link(&dev->kobj, "iommu_group");
> +
> +    trace_remove_device_from_group(group->id, dev);
> +
> +    kfree(grp_dev->name);
> +    kfree(grp_dev);
> +    dev->iommu_group = NULL;
> +    kobject_put(group->devices_kobj);
> +}
> +
>   /**
>    * iommu_group_remove_device - remove a device from it's current group
>    * @dev: device to be removed
> @@ -1075,7 +1115,7 @@ EXPORT_SYMBOL_GPL(iommu_group_add_device);
>   void iommu_group_remove_device(struct device *dev)
>   {
>       struct iommu_group *group = dev->iommu_group;
> -    struct group_device *tmp_device, *device = NULL;
> +    struct group_device *device;
> 
>       if (!group)
>           return;
> @@ -1083,27 +1123,11 @@ void iommu_group_remove_device(struct device *dev)
>       dev_info(dev, "Removing from iommu group %d\n", group->id);
> 
>       mutex_lock(&group->mutex);
> -    list_for_each_entry(tmp_device, &group->devices, list) {
> -        if (tmp_device->dev == dev) {
> -            device = tmp_device;
> -            list_del(&device->list);
> -            break;
> -        }
> -    }
> +    device = __iommu_group_remove_device(group, dev);
>       mutex_unlock(&group->mutex);
> 
> -    if (!device)
> -        return;
> -
> -    sysfs_remove_link(group->devices_kobj, device->name);
> -    sysfs_remove_link(&dev->kobj, "iommu_group");
> -
> -    trace_remove_device_from_group(group->id, dev);
> -
> -    kfree(device->name);
> -    kfree(device);
> -    dev->iommu_group = NULL;
> -    kobject_put(group->devices_kobj);
> +    if (device)
> +        __iommu_group_release_device(group, device);
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_remove_device);
> 
> 
> Step 2: Put removing group and release_device in a same critical region:
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 17b2e358a6fd..eeb2907472bc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -101,6 +101,10 @@ static int 
> iommu_create_device_direct_mappings(struct iommu_group *group,
>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>   static ssize_t iommu_group_store_type(struct iommu_group *group,
>                         const char *buf, size_t count);
> +static struct group_device *
> +__iommu_group_remove_device(struct iommu_group *group, struct device 
> *dev);
> +static void __iommu_group_release_device(struct iommu_group *group,
> +                     struct group_device *grp_dev);
> 
>   #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)        \
>   struct iommu_group_attribute iommu_group_attr_##_name =        \
> @@ -466,18 +470,25 @@ int iommu_probe_device(struct device *dev)
> 
>   void iommu_release_device(struct device *dev)
>   {
> +    struct iommu_group *group = dev->iommu_group;
> +    struct group_device *device;
>       const struct iommu_ops *ops;
> 
> -    if (!dev->iommu)
> +    if (!dev->iommu || !group)
>           return;
> 
>       iommu_device_unlink(dev->iommu->iommu_dev, dev);
> 
> +    mutex_lock(&group->mutex);
>       ops = dev_iommu_ops(dev);
>       if (ops->release_device)
>           ops->release_device(dev);
> +    device = __iommu_group_remove_device(group, dev);
> +    mutex_unlock(&group->mutex);
> +
> +    if (device)
> +        __iommu_group_release_device(group, device);
> 
> -    iommu_group_remove_device(dev);
>       module_put(ops->owner);
>       dev_iommu_free(dev);
>   }
> 
> Best regards,
> baolu
