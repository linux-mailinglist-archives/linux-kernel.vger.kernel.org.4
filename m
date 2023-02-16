Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57E7698975
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBPAtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBPAtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:49:09 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252AE29E07
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 16:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676508549; x=1708044549;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=abVxdTrQXyJIRwvmXFMJIhwBu4SaHWDquF+Ed+Z40fE=;
  b=D7g0r4qV3VPfKFQg05nG/pfwYo22Ncbp8B+BA7XlRyuzE3JAtBa63GEQ
   jmC5GvlkrrUdKNfT5ux2VKUM7AkQEIYImTtoy/VN8lfS3PfmsdgV0shiH
   T2xTKxpIkHK/GCJPcke4w4carzw3XeNBxgmpktK5Z3eqmDDF+vzv0LZVw
   If9xZB6toIULqYTNGYF2HBC7sH7Ow1ZGLUy/Af5pGzUy4YBtAxw3jfEnT
   Bomk6ovLybjuMn37SovhVNrp5jx1vZHA5ZHJK0PxDycrpklxIUoMv4xur
   QipDbsB4J9MBE+w9BL6oiBubnKNfZTxdEGLmtpgrAmpKFe204lNivF8PP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="311950481"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="311950481"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 16:49:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="843934984"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="843934984"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2023 16:49:06 -0800
Message-ID: <ba0fab4b-61dc-a5de-cc0e-70a6e6f66f51@linux.intel.com>
Date:   Thu, 16 Feb 2023 08:40:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iommu: Add dev_iommu->ops_rwsem
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
 <20230213074941.919324-2-baolu.lu@linux.intel.com>
 <Y+pGUOkLVUMFYWOb@nvidia.com>
 <9f516f44-3dc9-6f15-11d0-10bfb1b29b1e@linux.intel.com>
 <d4f1b33d-dec7-6582-34a1-495bacfcd396@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d4f1b33d-dec7-6582-34a1-495bacfcd396@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 7:24 PM, Robin Murphy wrote:
> On 2023-02-15 05:34, Baolu Lu wrote:
>> On 2/13/23 10:16 PM, Jason Gunthorpe wrote:
>>> On Mon, Feb 13, 2023 at 03:49:38PM +0800, Lu Baolu wrote:
>>>
>>>> +static int iommu_group_freeze_dev_ops(struct iommu_group *group)
>>>> +{
>>>> +    struct group_device *device;
>>>> +    struct device *dev;
>>>> +
>>>> +    mutex_lock(&group->mutex);
>>>> +    list_for_each_entry(device, &group->devices, list) {
>>>> +        dev = device->dev;
>>>> +        down_read(&dev->iommu->ops_rwsem);
>>>
>>> This isn't allowed, you can't obtain locks in a loop like this, it
>>> will deadlock.
>>>
>>> You don't need more locks, we already have the group mutex, the
>>> release path should be fixed to use it properly as I was trying to do 
>>> here:
>>>
>>> https://lore.kernel.org/kvm/4-v1-ef00ffecea52+2cb-iommu_group_lifetime_jgg@nvidia.com/
>>> https://lore.kernel.org/kvm/YyyTxx0HnA3maxEk@nvidia.com/
>>>
>>> Then what you'd do in a path like this is:
>>>
>>>    mutex_lock(&group->mutex);
>>>    dev = iommu_group_first_device(group)
>>>    if (!dev)
>>>       /* Racing with group cleanup */
>>>       return -EINVAL;
>>>    /* Now dev->ops is valid and must remain valid so long as
>>>       group->mutex is held */
>>>
>>> The only reason this doesn't work already is because of the above
>>> stuff about release not holding the group mutex when manipulating the
>>> devices in the group. This is simply mis-locked.
>>>
>>> Robin explained it was done like this because
>>> arm_iommu_detach_device() re-enters the iommu core during release_dev,
>>> so I suggest fixing that by simply not doing that (see above)
>>>
>>> Below is the lastest attempt I had tried, I didn't have time to get back
>>> to it and we fixed the bug another way. It needs a bit of adjusting to
>>> also remove the device from the group after release is called within
>>> the same mutex critical region.
>>
>> Yes. If we can make remove device from list and device release in the
>> same mutex critical region, we don't need any other lock mechanism
>> anymore.
>>
>> The ipmmu driver supports default domain.
> 
> It supports default domains *on arm64*. Nothing on 32-bit ARM uses 
> default domains, they won't even exist since iommu-dma is not enabled, 
> and either way the ARM DMA ops don't understand groups. I don't see an 
> obvious satisfactory solution while the arm_iommu_* APIs still exist, 
> but if we need bodges in the interim could we please try to concentrate 
> them in ARM-specific code?

Yes, sure. Thanks for the guide.

Best regards,
baolu
