Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B975741569
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjF1Pkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:40:41 -0400
Received: from foss.arm.com ([217.140.110.172]:56108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbjF1Pj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:39:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E92C3C14;
        Wed, 28 Jun 2023 08:40:39 -0700 (PDT)
Received: from [10.57.33.98] (unknown [10.57.33.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 681673F64C;
        Wed, 28 Jun 2023 08:39:54 -0700 (PDT)
Message-ID: <2274ba47-7def-082c-8429-8f2cc18adf9f@arm.com>
Date:   Wed, 28 Jun 2023 16:39:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass with
 a pasid support
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, jgg@nvidia.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, yangyicong@hisilicon.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230627033326.5236-1-nicolinc@nvidia.com>
 <826cbb86-ac7d-c40b-f7e3-51681cda50b8@arm.com>
 <ZJsXLFtH8WkRK41w@Asurada-Nvidia>
 <1b0c9677-4e2a-6767-f8f2-23081e6af3e0@arm.com>
 <ZJt7GhV4IOLvRhhr@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZJt7GhV4IOLvRhhr@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-28 01:13, Nicolin Chen wrote:
> Thanks for the reply.
> 
> On Wed, Jun 28, 2023 at 12:29:52AM +0100, Robin Murphy wrote:
> 
>>>>> Also, add STRTAB_STE_1_SHCFG_NONSHAREABLE of the default configuration
>>>>> to distinguish from STRTAB_STE_1_SHCFG_INCOMING of the bypass one.
>>>>
>>>> Why? The "default configuration" is that the S1 shareability attribute
>>>> is determined by the S1 translation itself, so the incoming value is
>>>> irrelevant.
>>>
>>> That was for a consistency since the driver set the SHCFG field
>>> to 0x0 (STRTAB_STE_1_SHCFG_NONSHAREABLE). I was not quite sure,
>>> in a long run, if leaving an uncleared s1_cfg->shcfg potentially
>>> can result in an unexpected behavior if it's passed in the STE.
>>> Yet, we could be seemingly sure that the !IOMMU_DOMAIN_IDENTITY
>>> means the S1 translation must be enabled and so the SHCFG would
>>> be irrelevant?
>>>
>>> If so, I make make it:
>>>
>>> +     if (smmu_domain->domain.type == IOMMU_DOMAIN_IDENTITY) {
>>> +             cfg->s1dss = STRTAB_STE_1_S1DSS_BYPASS;
>>> +             cfg->shcfg = STRTAB_STE_1_SHCFG_INCOMING;
>>> +     } else {
>>> +             cfg->s1dss = STRTAB_STE_1_S1DSS_SSID0;
>>> +     }
>>
>> What I mean is we don't need a cfg->shcfg field at all - without loss of
>> generality it can simply be hard-coded to 1 when S1 is active, same as
>> for stream bypass.
> 
> OK.
> --------------------------------------------------------------------------------------------------
> @@ -1350,7 +1350,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>                  dst[1] = cpu_to_le64(
> -                        FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
> +                        FIELD_PREP(STRTAB_STE_1_S1DSS, s1_cfg->s1dss) |
> +                        FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING) |
>                           FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> --------------------------------------------------------------------------------------------------
> 
>> The only case where explicitly setting STE.SHCFG=0 makes some sense is
>> for a stage-2-only domain if a device's incoming attribute is stronger
>> than it needs to be, but even then there are multiple levels of
>> IMP-DEFness around whether SHCFG actually does anything anyway.
> 
> I see. Thanks for elaborating.
> 
>>>>> @@ -2198,7 +2206,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>>>>>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>>>         struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>>
>>>>> -     if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>>>>> +     /*
>>>>> +      * A master with a pasid capability might need a CD table, so only set
>>>>> +      * ARM_SMMU_DOMAIN_BYPASS if IOMMU_DOMAIN_IDENTITY and non-pasid master
>>>>> +      */
>>>>> +     if (domain->type == IOMMU_DOMAIN_IDENTITY && !master->ssid_bits) {
>>>>>                 smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
>>>>>                 return 0;
>>>>>         }
>>>>
>>>> This means we'll now go on to allocate a pagetable for an identity
>>>> domain, which doesn't seem ideal :/
>>>
>>> Do you suggest to bypass alloc_io_pgtable_ops()? That would zero
>>> out the TCR fields in the CD. Not sure if it'd work seamlessly,
>>> but I can give it a try.
>>
>> I think if there's a good reason to support this then it's worth
> 
> There is an unignorable perf difference that we see on a real HW.
> So the reason or (I should say) the requirement is pretty strong.
> 
>> supporting properly, i.e. refactor a bit harder to separate the CD table
>> parts which are common to both S1DSS bypass and S1 translation, from the
>> CD/pagetable parts that are only relevant for translation. S1DSS bypass
>> remains the same as Stream bypass in the sense that there is no
>> structure corresponding to the identity domain itself, so not only does
>> it not make sense to have a pagetable, there's also no valid place to
>> put one anyway - touching the CD belonging to SSID 0 is strictly wrong.
> 
> I can try that. Yet, I think the S1DSS bypass case still belongs
> to ARM_SMMU_DOMAIN_S1/arm_smmu_domain_finalise_s1, right?

That's what I'm disagreeing with - although S1DSS behaviour requires S1 
translation to be nominally enabled for the stream as a whole, the 
bypass domain is distinctly *not* an S1 translation domain, and there is 
no S1 context to finalise. I think it's either a generalisation of 
ARM_SMMU_DOMAIN_BYPASS based on s1cdmax, or it's its own new thing.

> I'd try keeping most of the parts intact while adding a pointer
> to a structure holding pagetable stuff, to make it cleaner. Then
> the S1DSS bypass case can be flagged by an empty pointer.

I'd expect that what you need for this is much the same as what Michael 
has already proposed for the PASID-generalisation series. The current 
inside-out notion of S1 domains owning CD tables is what's getting in 
the way of doing the right thing cleanly, in both cases.

Thanks,
Robin.
