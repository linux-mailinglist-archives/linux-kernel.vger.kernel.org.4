Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54054681833
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbjA3SFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbjA3SFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:05:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DB893B67F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:05:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD70A1FB;
        Mon, 30 Jan 2023 10:06:00 -0800 (PST)
Received: from [10.57.89.162] (unknown [10.57.89.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAA743F71E;
        Mon, 30 Jan 2023 10:05:17 -0800 (PST)
Message-ID: <01b0254f-41b0-2cbc-7d47-5507258f35b5@arm.com>
Date:   Mon, 30 Jan 2023 18:05:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/8] iommu: Factor out some helpers
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com
References: <cover.1674753627.git.robin.murphy@arm.com>
 <959a1e8d598c0a82f94123e017cafb273784f848.1674753627.git.robin.murphy@arm.com>
 <Y9fyaRGp7Q8E5to2@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y9fyaRGp7Q8E5to2@nvidia.com>
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

On 2023-01-30 16:38, Jason Gunthorpe wrote:
> On Thu, Jan 26, 2023 at 06:26:19PM +0000, Robin Murphy wrote:
>> The pattern for picking the first device out of the group list is
>> repeated a few times now, so it's clearly worth factoring out to hide
>> the group_device detail from places that don't need to know. Similarly,
>> the safety check for dev_iommu_ops() at public interfaces starts looking
>> a bit repetitive, and might not be completely obvious at first glance,
>> so let's factor that out for clarity as well, in preparation for more
>> uses of both.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v2: - Add dev_iommu_ops_valid() helper
>>      - Add lockdep assertion [Jason]
>>
>>   drivers/iommu/iommu.c | 39 ++++++++++++++++++++++-----------------
>>   1 file changed, 22 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 77f076030995..440bb3b7bded 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -284,6 +284,12 @@ static void dev_iommu_free(struct device *dev)
>>   	kfree(param);
>>   }
>>   
>> +/* Only needed in public APIs which allow unchecked devices for convenience */
>> +static bool dev_iommu_ops_valid(struct device *dev)
>> +{
>> +	return dev->iommu && dev->iommu->iommu_dev;
>> +}
> 
> I did an audit and more than half the callers need this test, and a
> few places are missing it already.
> 
> We've kind of made a systematic error that assumes being in a group is
> sufficient to prove there are non-NULL ops.
> 
> So I suggest that we make dev_iommu_ops() return NULL in all cases
> where there is no driver and have a new API to get the ops in cases
> where the call chain knows that it is safe, and there are only 5 of
> those cases.
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705bd3..4b04ad50de8d6b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -98,7 +98,8 @@ static int __iommu_group_set_domain(struct iommu_group *group,
>   				    struct iommu_domain *new_domain);
>   static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   					       struct device *dev);
> -static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> +static struct iommu_group *iommu_group_get_for_dev(struct device *dev,
> +						   const struct iommu_ops *ops);
>   static ssize_t iommu_group_store_type(struct iommu_group *group,
>   				      const char *buf, size_t count);
>   
> @@ -130,6 +131,19 @@ static struct bus_type * const iommu_buses[] = {
>   #endif
>   };
>   
> +/*
> + * This may only be called if it is already clear from the calling context that
> + * the device has an ops. Seeing the device is part of an iommu_group is not
> + * enough as VFIO and POWER put devices in iommu_groups and do not attach
> + * drivers. Thus the only places that are safe have either already called
> + * dev_iommu_ops() on their call chain, or were responsible for assigning ops in
> + * the first place.
> + */
> +static inline const struct iommu_ops *dev_iommu_ops_safe(struct device *dev)
> +{
> +	return dev->iommu->iommu_dev->ops;
> +}
> +
>   /*
>    * Use a function instead of an array here because the domain-type is a
>    * bit-field, so an array would waste memory.
> @@ -338,7 +352,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   	dev->iommu->iommu_dev = iommu_dev;
>   	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
>   
> -	group = iommu_group_get_for_dev(dev);
> +	group = iommu_group_get_for_dev(dev, ops);

Why? We've literally just assigned dev->iommu->iommu_dev 2 lines above; 
it is not allowed to have invalid ops. Plus in future they may 
potentially be a different set of device ops from the ones we initially 
found to provide ->probe_device - in that case we definitely want 
group_get_for_dev to use the proper instance ops. This is the only place 
it is (and should be) called, so I don't see any problem.

>   	if (IS_ERR(group)) {
>   		ret = PTR_ERR(group);
>   		goto out_release;
> @@ -414,7 +428,8 @@ int iommu_probe_device(struct device *dev)
>   	mutex_unlock(&group->mutex);
>   	iommu_group_put(group);
>   
> -	ops = dev_iommu_ops(dev);
> +	/* __iommu_probe_device() set the ops */
> +	ops = dev_iommu_ops_safe(dev);
>   	if (ops->probe_finalize)
>   		ops->probe_finalize(dev);
>   
> @@ -430,14 +445,13 @@ int iommu_probe_device(struct device *dev)
>   
>   void iommu_release_device(struct device *dev)
>   {
> -	const struct iommu_ops *ops;
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);

This is just moving an existing check around.

> -	if (!dev->iommu)
> +	if (!ops)
>   		return;
>   
>   	iommu_device_unlink(dev->iommu->iommu_dev, dev);
>   
> -	ops = dev_iommu_ops(dev);
>   	if (ops->release_device)
>   		ops->release_device(dev);
>   
> @@ -614,13 +628,6 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
>   	list_for_each_entry(device, &group->devices, list) {
>   		struct list_head dev_resv_regions;
>   
> -		/*
> -		 * Non-API groups still expose reserved_regions in sysfs,
> -		 * so filter out calls that get here that way.
> -		 */
> -		if (!device->dev->iommu)
> -			break;
> -
>   		INIT_LIST_HEAD(&dev_resv_regions);
>   		iommu_get_resv_regions(device->dev, &dev_resv_regions);
>   		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
> @@ -1332,7 +1339,8 @@ int iommu_page_response(struct device *dev,
>   	struct iommu_fault_event *evt;
>   	struct iommu_fault_page_request *prm;
>   	struct dev_iommu *param = dev->iommu;
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	/* This API should only be called from an IOMMU driver */
> +	const struct iommu_ops *ops = dev_iommu_ops_safe(dev);
>   	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
>   
>   	if (!ops->page_response)
> @@ -1601,7 +1609,8 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
>   
>   static int iommu_get_def_domain_type(struct device *dev)
>   {
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	/* It is not locked but all callers know there is an ops */
> +	const struct iommu_ops *ops = dev_iommu_ops_safe(dev);
>   
>   	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
>   		return IOMMU_DOMAIN_DMA;
> @@ -1658,9 +1667,9 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
>    * to the returned IOMMU group, which will already include the provided
>    * device.  The reference should be released with iommu_group_put().
>    */
> -static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
> +static struct iommu_group *iommu_group_get_for_dev(struct device *dev,
> +						   const struct iommu_ops *ops)
>   {
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   	struct iommu_group *group;
>   	int ret;
>   
> @@ -1795,7 +1804,8 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
>   
>   static int iommu_group_do_probe_finalize(struct device *dev, void *data)
>   {
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	/* It is unlocked but all callers know there is an ops */
> +	const struct iommu_ops *ops = dev_iommu_ops_safe(dev);
>   
>   	if (ops->probe_finalize)
>   		ops->probe_finalize(dev);
> @@ -1884,13 +1894,9 @@ EXPORT_SYMBOL_GPL(iommu_present);
>    */
>   bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
>   {
> -	const struct iommu_ops *ops;
> -
> -	if (!dev->iommu || !dev->iommu->iommu_dev)
> -		return false;
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   
> -	ops = dev_iommu_ops(dev);
> -	if (!ops->capable)
> +	if (!ops || !ops->capable)
>   		return false;
>   
>   	return ops->capable(dev, cap);
> @@ -2620,7 +2626,11 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   
> -	if (ops->get_resv_regions)
> +	/*
> +	 * Non-API groups still expose reserved_regions in sysfs, so filter out
> +	 * calls that get here that way.
> +	 */
> +	if (ops && ops->get_resv_regions)

This is just moving the existing check from the public interface to 
pointlessly impose it on the internal call path as well.

>   		ops->get_resv_regions(dev, list);
>   }
>   
> @@ -2979,6 +2989,11 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>   	/* Since group has only one device */
>   	grp_dev = list_first_entry(&group->devices, struct group_device, list);
>   	dev = grp_dev->dev;
> +	if (!dev_iommu_ops(dev)) {
> +		/* The group doesn't have an iommu driver attached */
> +		mutex_unlock(&group->mutex);
> +		return -EINVAL;
> +	}

Withot any ops, group->default_domain will be NULL so we could never 
even get here.

>   	get_device(dev);
>   
>   	/*
> @@ -3301,7 +3316,7 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>   	const struct iommu_ops *ops;
>   
>   	list_for_each_entry(device, &group->devices, list) {
> -		ops = dev_iommu_ops(device->dev);
> +		ops = dev_iommu_ops_safe(device->dev);
>   		ops->remove_dev_pasid(device->dev, pasid);
>   	}
>   }
> @@ -3413,6 +3428,9 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   	struct iommu_domain *domain;
>   
> +	if (!ops)
> +		return NULL;

Anyone who incorrectly calls sva_domain_alloc() directly without having 
successfully called iommu_dev_enable_feature() first deserves to crash.

(Incidentally, you've missed enable/disable_feature here.)

> +
>   	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
>   	if (!domain)
>   		return NULL;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 46e1347bfa2286..60e84f8c7c46e9 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -441,14 +441,11 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
>   	};
>   }
>   
> +/* May return NULL if the device has no iommu driver */
>   static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>   {
> -	/*
> -	 * Assume that valid ops must be installed if iommu_probe_device()
> -	 * has succeeded. The device ops are essentially for internal use
> -	 * within the IOMMU subsystem itself, so we should be able to trust
> -	 * ourselves not to misuse the helper.
> -	 */
> +	if (!dev->iommu)
> +		return NULL;
>   	return dev->iommu->iommu_dev->ops;

This is actively broken, since dev->iommu may be non-NULL before 
dev->iommu->iommu_dev is set (a fwspec will always be set before the 
instyance is registered, and a device may potentially hang around in 
that state for evertt if the relevant IOMMU instance never appears).

Sorry, I don't think any of this makes sense :/

Thanks,
Robin.
