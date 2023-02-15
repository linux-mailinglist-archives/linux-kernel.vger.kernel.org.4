Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E496975F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 06:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBOFna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 00:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBOFn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 00:43:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861521CAEA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 21:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676439805; x=1707975805;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SehO2pfMACkfE6etG3eoVFEtRQzAQtbxDiF2gzX8Z6E=;
  b=ARigWWkJD/iW9IAICyirqiV0mtsFrPo6Uv4WWRZrKLHU84i7rtCOrcXA
   XNraVlHciX361LpckA9b6mGAJi+jg9yhBeheNtvYKOToZjfRtNz1ds3px
   neqmjK7Fp6q5iqapQAt1qNquhlazCe0ExgKMQryDkquOK9KXg5OSBgU6c
   lSbxyaESBTIfiaUWfUPSYYHqec6zsL/1aoOzI5mg5xrCtIV8W2CbZ6YV8
   FVUV+U1w0/NgjcMSLj0KI2CEcokAsnPMt98QQu3ReyqRAypsF3gJxTf2M
   O7WFOLinMklrwAqqlZWB2aWzcZaW2I805AKeF4YTGSpFU2BasdGTc7IyE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="310981592"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="310981592"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 21:43:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="619305562"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="619305562"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2023 21:43:22 -0800
Message-ID: <9f516f44-3dc9-6f15-11d0-10bfb1b29b1e@linux.intel.com>
Date:   Wed, 15 Feb 2023 13:34:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iommu: Add dev_iommu->ops_rwsem
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
 <20230213074941.919324-2-baolu.lu@linux.intel.com>
 <Y+pGUOkLVUMFYWOb@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y+pGUOkLVUMFYWOb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 10:16 PM, Jason Gunthorpe wrote:
> On Mon, Feb 13, 2023 at 03:49:38PM +0800, Lu Baolu wrote:
> 
>> +static int iommu_group_freeze_dev_ops(struct iommu_group *group)
>> +{
>> +	struct group_device *device;
>> +	struct device *dev;
>> +
>> +	mutex_lock(&group->mutex);
>> +	list_for_each_entry(device, &group->devices, list) {
>> +		dev = device->dev;
>> +		down_read(&dev->iommu->ops_rwsem);
> 
> This isn't allowed, you can't obtain locks in a loop like this, it
> will deadlock.
> 
> You don't need more locks, we already have the group mutex, the
> release path should be fixed to use it properly as I was trying to do here:
> 
> https://lore.kernel.org/kvm/4-v1-ef00ffecea52+2cb-iommu_group_lifetime_jgg@nvidia.com/
> https://lore.kernel.org/kvm/YyyTxx0HnA3maxEk@nvidia.com/
> 
> Then what you'd do in a path like this is:
> 
>    mutex_lock(&group->mutex);
>    dev = iommu_group_first_device(group)
>    if (!dev)
>       /* Racing with group cleanup */
>       return -EINVAL;
>    
>    /* Now dev->ops is valid and must remain valid so long as
>       group->mutex is held */
>     
> 
> The only reason this doesn't work already is because of the above
> stuff about release not holding the group mutex when manipulating the
> devices in the group. This is simply mis-locked.
> 
> Robin explained it was done like this because
> arm_iommu_detach_device() re-enters the iommu core during release_dev,
> so I suggest fixing that by simply not doing that (see above)
> 
> Below is the lastest attempt I had tried, I didn't have time to get back
> to it and we fixed the bug another way. It needs a bit of adjusting to
> also remove the device from the group after release is called within
> the same mutex critical region.

Yes. If we can make remove device from list and device release in the
same mutex critical region, we don't need any other lock mechanism
anymore.

The ipmmu driver supports default domain. When code comes to release
device, the device driver has already been unbound. The default domain
should have been attached to the device. Then iommu_detach_device() does
nothing because what it really does is just attaching default domain.

How about removing iommu_detach_device() from ipmmu's release path like
below?

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index bdf1a4e5eae0..0bc29009703e 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -820,7 +820,16 @@ static void ipmmu_probe_finalize(struct device *dev)

  static void ipmmu_release_device(struct device *dev)
  {
-       arm_iommu_detach_device(dev);
+       struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+
+       if (!mapping) {
+               dev_warn(dev, "Not attached\n");
+               return;
+       }
+
+       arm_iommu_release_mapping(mapping);
+       to_dma_iommu_mapping(dev) = NULL;
+       set_dma_ops(dev, NULL);
  }

After fixing this in ipmmu driver, we can safely put removing device and
release_device in a group->mutex critical region in two steps:

Step 1: Refactor iommu_group_remove_device() w/o functionality change:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 05522eace439..17b2e358a6fd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1065,6 +1065,46 @@ int iommu_group_add_device(struct iommu_group 
*group, struct device *dev)
  }
  EXPORT_SYMBOL_GPL(iommu_group_add_device);

+/*
+ * Remove a device from a group's device list and return the group device
+ * if successful.
+ */
+static struct group_device *
+__iommu_group_remove_device(struct iommu_group *group, struct device *dev)
+{
+	struct group_device *device;
+
+	lockdep_assert_held(&group->mutex);
+	list_for_each_entry(device, &group->devices, list) {
+		if (device->dev == dev) {
+			list_del(&device->list);
+			return device;
+		}
+	}
+
+	return NULL;
+}
+
+/*
+ * Release a device from its group and decrements the iommu group reference
+ * count.
+ */
+static void __iommu_group_release_device(struct iommu_group *group,
+					 struct group_device *grp_dev)
+{
+	struct device *dev = grp_dev->dev;
+
+	sysfs_remove_link(group->devices_kobj, grp_dev->name);
+	sysfs_remove_link(&dev->kobj, "iommu_group");
+
+	trace_remove_device_from_group(group->id, dev);
+
+	kfree(grp_dev->name);
+	kfree(grp_dev);
+	dev->iommu_group = NULL;
+	kobject_put(group->devices_kobj);
+}
+
  /**
   * iommu_group_remove_device - remove a device from it's current group
   * @dev: device to be removed
@@ -1075,7 +1115,7 @@ EXPORT_SYMBOL_GPL(iommu_group_add_device);
  void iommu_group_remove_device(struct device *dev)
  {
  	struct iommu_group *group = dev->iommu_group;
-	struct group_device *tmp_device, *device = NULL;
+	struct group_device *device;

  	if (!group)
  		return;
@@ -1083,27 +1123,11 @@ void iommu_group_remove_device(struct device *dev)
  	dev_info(dev, "Removing from iommu group %d\n", group->id);

  	mutex_lock(&group->mutex);
-	list_for_each_entry(tmp_device, &group->devices, list) {
-		if (tmp_device->dev == dev) {
-			device = tmp_device;
-			list_del(&device->list);
-			break;
-		}
-	}
+	device = __iommu_group_remove_device(group, dev);
  	mutex_unlock(&group->mutex);

-	if (!device)
-		return;
-
-	sysfs_remove_link(group->devices_kobj, device->name);
-	sysfs_remove_link(&dev->kobj, "iommu_group");
-
-	trace_remove_device_from_group(group->id, dev);
-
-	kfree(device->name);
-	kfree(device);
-	dev->iommu_group = NULL;
-	kobject_put(group->devices_kobj);
+	if (device)
+		__iommu_group_release_device(group, device);
  }
  EXPORT_SYMBOL_GPL(iommu_group_remove_device);


Step 2: Put removing group and release_device in a same critical region:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 17b2e358a6fd..eeb2907472bc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -101,6 +101,10 @@ static int 
iommu_create_device_direct_mappings(struct iommu_group *group,
  static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
  static ssize_t iommu_group_store_type(struct iommu_group *group,
  				      const char *buf, size_t count);
+static struct group_device *
+__iommu_group_remove_device(struct iommu_group *group, struct device *dev);
+static void __iommu_group_release_device(struct iommu_group *group,
+					 struct group_device *grp_dev);

  #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
  struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -466,18 +470,25 @@ int iommu_probe_device(struct device *dev)

  void iommu_release_device(struct device *dev)
  {
+	struct iommu_group *group = dev->iommu_group;
+	struct group_device *device;
  	const struct iommu_ops *ops;

-	if (!dev->iommu)
+	if (!dev->iommu || !group)
  		return;

  	iommu_device_unlink(dev->iommu->iommu_dev, dev);

+	mutex_lock(&group->mutex);
  	ops = dev_iommu_ops(dev);
  	if (ops->release_device)
  		ops->release_device(dev);
+	device = __iommu_group_remove_device(group, dev);
+	mutex_unlock(&group->mutex);
+
+	if (device)
+		__iommu_group_release_device(group, device);

-	iommu_group_remove_device(dev);
  	module_put(ops->owner);
  	dev_iommu_free(dev);
  }

Best regards,
baolu
