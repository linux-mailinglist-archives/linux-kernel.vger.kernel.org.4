Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A868B6B4B56
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjCJPmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjCJPmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:42:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A9F212DDC2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:29:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2F611FB;
        Fri, 10 Mar 2023 07:29:46 -0800 (PST)
Received: from [10.57.90.67] (unknown [10.57.90.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559233F71A;
        Fri, 10 Mar 2023 07:29:01 -0800 (PST)
Message-ID: <5cc56149-965a-bb47-f23f-6aa9d0ecce4e@arm.com>
Date:   Fri, 10 Mar 2023 15:28:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 04/14] iommu/arm-smmu-v3: Add arm_smmu_hw_info
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     jgg@nvidia.com, will@kernel.org, eric.auger@redhat.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <494e36cbb77d49e11427b308868dbc1b0e19fe18.1678348754.git.nicolinc@nvidia.com>
 <bfa43614-c052-4bed-b87e-691141f41909@arm.com>
 <ZAqFFolbw5xoJDfb@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZAqFFolbw5xoJDfb@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-10 01:17, Nicolin Chen wrote:
> Hi Robin,
> 
> Thanks for the inputs.
> 
> On Thu, Mar 09, 2023 at 01:03:41PM +0000, Robin Murphy wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2023-03-09 10:53, Nicolin Chen wrote:
>>> This is used to forward the host IDR values to the user space, so the
>>> hypervisor and the guest VM can learn about the underlying hardware's
>>> capabilities.
>>>
>>> Also, set the driver_type to IOMMU_HW_INFO_TYPE_ARM_SMMUV3 to pass the
>>> corresponding type sanity in the core.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++++++++
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
>>>    include/uapi/linux/iommufd.h                | 14 ++++++++++++
>>>    3 files changed, 41 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index f2425b0f0cd6..c1aac695ae0d 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -2005,6 +2005,29 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>>>        }
>>>    }
>>>
>>> +static void *arm_smmu_hw_info(struct device *dev, u32 *length)
>>> +{
>>> +     struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>>> +     struct iommu_hw_info_smmuv3 *info;
>>> +     void *base_idr;
>>> +     int i;
>>> +
>>> +     if (!master || !master->smmu)
>>> +             return ERR_PTR(-ENODEV);
>>> +
>>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>>> +     if (!info)
>>> +             return ERR_PTR(-ENOMEM);
>>> +
>>> +     base_idr = master->smmu->base + ARM_SMMU_IDR0;
>>> +     for (i = 0; i <= 5; i++)
>>> +             info->idr[i] = readl_relaxed(base_idr + 0x4 * i);
>>
>> You need to take firmware overrides etc. into account here. In
>> particular, features like BTM may need to be hidden to work around
>> errata either in the system integration or the SMMU itself. It isn't
>> reasonable to expect every VMM to be aware of every erratum and
>> workaround, and there may even be workarounds where we need to go out of
>> our way to prevent guests from trying to use certain features in order
>> to maintain correctness at S2.
> 
> We can add a bit of overrides after this for errata, perhaps?
> 
> I have some trouble with finding the errata docs. Would it be
> possible for you to direct me to it with a link maybe?

The key Arm term is "Software Developer Errata Notice", or just SDEN. 
Here's the ones for MMU-600 and MMU-700:

https://developer.arm.com/documentation/SDEN-946810/latest/
https://developer.arm.com/documentation/SDEN-1786925/latest/

Note that until now it has been extremely fortunate that in pretty much 
every case Linux either hasn't supported the affected feature at all, or 
has happened to avoid meeting the conditions. Once we do introduce 
nesting support that all goes out the window (and I'll have to think 
more when reviewing new errata in future...)

I've been putting off revisiting all the existing errata to figure out 
what we'd need to do until new nesting patches appeared, so I'll try to 
get to that soon now. I think in many cases it's likely to be best to 
just disallowing nesting entirely on affected implementations.

Thanks,
Robin.

>> In general this should probably follow the same principle as KVM, where
>> we only expose sanitised feature registers representing the
>> functionality the host understands. Code written today is almost
>> guaranteed to be running on hardware released in 2030, at least *somewhere*.
> 
> Yes.
> 
> Thanks
> Nicolin
