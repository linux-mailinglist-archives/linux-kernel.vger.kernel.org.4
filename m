Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F08681FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjA3XeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjA3XeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:34:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29F4521941
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:34:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA9F91FB;
        Mon, 30 Jan 2023 15:34:43 -0800 (PST)
Received: from [10.57.89.162] (unknown [10.57.89.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8547C3F882;
        Mon, 30 Jan 2023 15:34:00 -0800 (PST)
Message-ID: <5498680f-df9e-287c-03f1-020848ba9b37@arm.com>
Date:   Mon, 30 Jan 2023 23:33:54 +0000
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
 <Y9fyaRGp7Q8E5to2@nvidia.com> <01b0254f-41b0-2cbc-7d47-5507258f35b5@arm.com>
 <Y9gKewvVuVsrB4nI@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y9gKewvVuVsrB4nI@nvidia.com>
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

On 2023-01-30 18:20, Jason Gunthorpe wrote:
> On Mon, Jan 30, 2023 at 06:05:12PM +0000, Robin Murphy wrote:
>>>     * Use a function instead of an array here because the domain-type is a
>>>     * bit-field, so an array would waste memory.
>>> @@ -338,7 +352,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>>>    	dev->iommu->iommu_dev = iommu_dev;
>>>    	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
>>> -	group = iommu_group_get_for_dev(dev);
>>> +	group = iommu_group_get_for_dev(dev, ops);
>>
>> Why? We've literally just assigned dev->iommu->iommu_dev 2 lines above; it
>> is not allowed to have invalid ops. Plus in future they may potentially be a
>> different set of device ops from the ones we initially found to provide
>> ->probe_device - in that case we definitely want group_get_for_dev to use
>> the proper instance ops. This is the only place it is (and should be)
>> called, so I don't see any problem.
> 
> Sure, but IMHO it was clearer to pass the ops down than to obtain it
> again. But maybe this could be tidied in a different way.

I disagree. In what we have now, every operation which calls into a 
driver consistently uses the instance ops (or domain ops), except for 
->probe_device for obvious reasons. Making ->device_group look special 
for no technical reason is less consistent, and as such less clear. It 
would be the only place in the kernel where ops are called from a 
function argument, and to anyone unfamiliar looking at the code and 
wondering why that is, the answer "because Jason thinks it looks better" 
is not going to be obvious at all.

>>>    	if (IS_ERR(group)) {
>>>    		ret = PTR_ERR(group);
>>>    		goto out_release;
>>> @@ -414,7 +428,8 @@ int iommu_probe_device(struct device *dev)
>>>    	mutex_unlock(&group->mutex);
>>>    	iommu_group_put(group);
>>> -	ops = dev_iommu_ops(dev);
>>> +	/* __iommu_probe_device() set the ops */
>>> +	ops = dev_iommu_ops_safe(dev);
>>>    	if (ops->probe_finalize)
>>>    		ops->probe_finalize(dev);
>>> @@ -430,14 +445,13 @@ int iommu_probe_device(struct device *dev)
>>>    void iommu_release_device(struct device *dev)
>>>    {
>>> -	const struct iommu_ops *ops;
>>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>
>> This is just moving an existing check around.
> 
> The point is to have one check. If you need to get the ops and you
> don't know the state of dev then you calll dev_iommu_ops() and check
> for NULL. Simple and consistent.
> 
>>> -     if (!dev->iommu)
>>> +     if (!ops)
>>>                return;
> 
> As you pointed out below this isn't even coded right since iommu can
> be non-NULL.

Oh, indeed that is technically a bug, although it's pretty much 
impossible to hit in practice because there's no real device hotplug on 
DT-based systems using fwspec - "dynamic" buses like PCI SR-IOV or 
fsl-mc aren't going to be discovered at all until the relevant IOMMU 
associated with the main controller device is ready, thus no removable 
child device would ever be in the "half-probed" state. I missed this one 
since I was looking for the dev->iommu->iommu_dev pattern - since it 
looks like this series is headed for a v3 next cycle, I've added this 
site to $SUBJECT locally.

>>> @@ -2620,7 +2626,11 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>>    {
>>>    	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>> -	if (ops->get_resv_regions)
>>> +	/*
>>> +	 * Non-API groups still expose reserved_regions in sysfs, so filter out
>>> +	 * calls that get here that way.
>>> +	 */
>>> +	if (ops && ops->get_resv_regions)
>>
>> This is just moving the existing check from the public interface to
>> pointlessly impose it on the internal call path as well.
> 
> Who cares? We don't need to micro-optimize this stuff. The fact there
> are a few bugs already is proof enough of that.

"a few"? So far there's only one, and it's not even the class of bug 
you're trying to address, because there _is_ an explicit validity check 
already, it just has an oversight in it.

This isn't micro-optimisation, it's consistency: we have validity checks 
close to the entrypoints of public interfaces where they are required. 
On internal paths where they are not required, we do not sometimes have 
checks and sometimes not, leaving people to wonder what the requirements 
actually are - in fact someone went so far as to call such patterns 
"confusing" and "overzealous" back when dev_iommu_ops() was reviewed. It 
was agreed that the lack of a check where ops are retrieved clearly 
documents where they are expected to be valid.

>>>    		ops->get_resv_regions(dev, list);
>>>    }
>>> @@ -2979,6 +2989,11 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>>>    	/* Since group has only one device */
>>>    	grp_dev = list_first_entry(&group->devices, struct group_device, list);
>>>    	dev = grp_dev->dev;
>>> +	if (!dev_iommu_ops(dev)) {
>>> +		/* The group doesn't have an iommu driver attached */
>>> +		mutex_unlock(&group->mutex);
>>> +		return -EINVAL;
>>> +	}
>>
>> Withot any ops, group->default_domain will be NULL so we could never even
>> get here.
> 
> Fair enough, deserves a comment

Great big function specifically for changing the default domain of a 
group... right at the top, literally the second thing it does on entry 
is check that the group and default domain are valid, and return if not. 
If that isn't sufficiently clear, I'm not sure what to say :/

>>>    	get_device(dev);
>>>    	/*
>>> @@ -3301,7 +3316,7 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>>>    	const struct iommu_ops *ops;
>>>    	list_for_each_entry(device, &group->devices, list) {
>>> -		ops = dev_iommu_ops(device->dev);
>>> +		ops = dev_iommu_ops_safe(device->dev);
>>>    		ops->remove_dev_pasid(device->dev, pasid);
>>>    	}
>>>    }
>>> @@ -3413,6 +3428,9 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>>>    	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>>    	struct iommu_domain *domain;
>>> +	if (!ops)
>>> +		return NULL;
>>
>> Anyone who incorrectly calls sva_domain_alloc() directly without having
>> successfully called iommu_dev_enable_feature() first deserves to crash.
> 
> Lets not build assumptions like this into the code please. That
> iommu_dev_enable_feature() thing is on my hitlist too :(

Huh? The whole public API is full of assumptions that callers aren't 
doing nonsensical things. Pass a bogus group or domain pointer to 
iommu_attach_group()? Boom! Pass a bogus domain pointer to iommu_map()? 
Boom! AFAICT the only thing that should be calling 
iommu_sva_domain_alloc() at all at the moment is 
iommu_sva_bind_device(), so it's effectively an internal interface where 
bogus device pointers really shouldn't be expected at all.

Sure, if you change the interface so that random drivers are free to 
allocate SVA domains directly and feed them to iommu_attach_group(), and 
checks are warranted in different places, then add them then.

>> (Incidentally, you've missed enable/disable_feature here.)
> 
> Yes, because they don't call dev_iommu_ops for some reason. It should
> be fixed too.

It is, in the patch you're replying to.

>>> +/* May return NULL if the device has no iommu driver */
>>>    static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>>>    {
>>> -	/*
>>> -	 * Assume that valid ops must be installed if iommu_probe_device()
>>> -	 * has succeeded. The device ops are essentially for internal use
>>> -	 * within the IOMMU subsystem itself, so we should be able to trust
>>> -	 * ourselves not to misuse the helper.
>>> -	 */
>>> +	if (!dev->iommu)
>>> +		return NULL;
>>>    	return dev->iommu->iommu_dev->ops;
>>
>> This is actively broken, since dev->iommu may be non-NULL before
>> dev->iommu->iommu_dev is set (a fwspec will always be set before the
>> instyance is registered, and a device may potentially hang around in that
>> state for evertt if the relevant IOMMU instance never appears).
> 
> Sure, I missed a NULL
> 
>> Sorry, I don't think any of this makes sense :/
> 
> The point is to be more consistent and not just blindly add more
> helpers. If you need ops then ask for the ops. If you aren't sure the
> dev has ops then check ops for NULL. It is pretty simple.

I'm not "blindly" adding more helpers, I'm ratifying clear common 
elements of the code and logic that we already have, to make them that 
much easier to replicate further. And I'm still no less puzzled by this 
thread... adding a new helper to consolidate having one thing in some 
places and another in others so offends your sensibilities that what 
you'd much rather do instead is add a new helper to have one thing in 
some places and another thing in others? There is a logical consistency 
to the current code already, which I assume is sufficiently clear to the 
majority of us because it's what made it through community review and 
what we've all been working on top of for the last year. "If you need 
ops then ask for the ops. If you aren't sure the dev has ops then check 
for valid ops first." Just as simple.

FWIW, personally I find up-front availability checks perfectly intuitive 
and natural, because they can easily be imagined as a real-life interaction:

"Do you have any coffee?"
"No, sorry."

vs.

"Please give me a cup of coffee."
<hands over empty cup>
"Is this coffee?"
"No."

One could possibly even argue that a separate up-front check also 
visibly implies that there are no concurrency or TOCTOU considerations 
expected, which for dev_iommu_ops() there should certainly not be.

Please understand that I'm not going to this length just to be 
objectionable; this is me genuinely being unable to rationalise your 
argument and spending my entire evening on a deep dive into my own 
thought process to lay it out and check for any obvious errors.

Thanks,
Robin.
