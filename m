Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058B16BD33C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjCPPTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCPPTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:19:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5639DF737
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:19:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25F4A2F4;
        Thu, 16 Mar 2023 08:20:17 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE8493F67D;
        Thu, 16 Mar 2023 08:19:31 -0700 (PDT)
Message-ID: <1d4ff93d-a97e-85bb-4259-9da259bc2ab7@arm.com>
Date:   Thu, 16 Mar 2023 15:19:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
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
 <5cc56149-965a-bb47-f23f-6aa9d0ecce4e@arm.com>
 <ZBJfJUjbAUId68s1@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZBJfJUjbAUId68s1@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 12:13 am, Nicolin Chen wrote:
> On Fri, Mar 10, 2023 at 03:28:56PM +0000, Robin Murphy wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2023-03-10 01:17, Nicolin Chen wrote:
>>> Hi Robin,
>>>
>>> Thanks for the inputs.
>>>
>>> On Thu, Mar 09, 2023 at 01:03:41PM +0000, Robin Murphy wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 2023-03-09 10:53, Nicolin Chen wrote:
>>>>> This is used to forward the host IDR values to the user space, so the
>>>>> hypervisor and the guest VM can learn about the underlying hardware's
>>>>> capabilities.
>>>>>
>>>>> Also, set the driver_type to IOMMU_HW_INFO_TYPE_ARM_SMMUV3 to pass the
>>>>> corresponding type sanity in the core.
>>>>>
>>>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>>>> ---
>>>>>     drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++++++++
>>>>>     drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
>>>>>     include/uapi/linux/iommufd.h                | 14 ++++++++++++
>>>>>     3 files changed, 41 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> index f2425b0f0cd6..c1aac695ae0d 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> @@ -2005,6 +2005,29 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>>>>>         }
>>>>>     }
>>>>>
>>>>> +static void *arm_smmu_hw_info(struct device *dev, u32 *length)
>>>>> +{
>>>>> +     struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>>>>> +     struct iommu_hw_info_smmuv3 *info;
>>>>> +     void *base_idr;
>>>>> +     int i;
>>>>> +
>>>>> +     if (!master || !master->smmu)
>>>>> +             return ERR_PTR(-ENODEV);
>>>>> +
>>>>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>>>>> +     if (!info)
>>>>> +             return ERR_PTR(-ENOMEM);
>>>>> +
>>>>> +     base_idr = master->smmu->base + ARM_SMMU_IDR0;
>>>>> +     for (i = 0; i <= 5; i++)
>>>>> +             info->idr[i] = readl_relaxed(base_idr + 0x4 * i);
>>>>
>>>> You need to take firmware overrides etc. into account here. In
>>>> particular, features like BTM may need to be hidden to work around
>>>> errata either in the system integration or the SMMU itself. It isn't
>>>> reasonable to expect every VMM to be aware of every erratum and
>>>> workaround, and there may even be workarounds where we need to go out of
>>>> our way to prevent guests from trying to use certain features in order
>>>> to maintain correctness at S2.
>>>
>>> We can add a bit of overrides after this for errata, perhaps?
>>>
>>> I have some trouble with finding the errata docs. Would it be
>>> possible for you to direct me to it with a link maybe?
>>
>> The key Arm term is "Software Developer Errata Notice", or just SDEN.
>> Here's the ones for MMU-600 and MMU-700:
>>
>> https://developer.arm.com/documentation/SDEN-946810/latest/
> 
> This page shows "Arm CoreLink MMU-600 System Memory Management
> Unit Software Developer Errata Notice" but the downloaded file
> is "Arm CoreLink CI-700 Coherent Interconnect" errata notice.
> And I don't quite understand what it's about.

Oh, wonderful... I've reported that now, hopefully it gets fixed soon...

>> https://developer.arm.com/documentation/SDEN-1786925/latest/
> 
> Yea, this one I got an "MMU-700 System Memory Management Unit"
> SMMU errata file that I can read and understand.
> 
>> Note that until now it has been extremely fortunate that in pretty much
>> every case Linux either hasn't supported the affected feature at all, or
>> has happened to avoid meeting the conditions. Once we do introduce
>> nesting support that all goes out the window (and I'll have to think
>> more when reviewing new errata in future...)
>>
>> I've been putting off revisiting all the existing errata to figure out
>> what we'd need to do until new nesting patches appeared, so I'll try to
>> get to that soon now. I think in many cases it's likely to be best to
>> just disallowing nesting entirely on affected implementations.
> 
> Do we have already a list of "affected implementations"? Or,
> we would need to make such a list now? In a latter case, can
> these affected implementations be detected from their IRD0-5
> registers, so that we can simply do something in hw_info()?

Somewhere I have a patch that adds all the IIDR stuff needed for this, 
but I never sent it upstream since the erratum itself was an early 
MMU-600 one which in practice doesn't matter. I'll dig that out and 
update it with what I have in mind.

Thanks,
Robin.
