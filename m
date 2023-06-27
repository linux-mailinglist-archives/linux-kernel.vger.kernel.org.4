Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787A87406D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjF0XaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjF0XaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:30:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89B891BE3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:30:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D18672F4;
        Tue, 27 Jun 2023 16:30:45 -0700 (PDT)
Received: from [10.57.35.190] (unknown [10.57.35.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD7EE3F64C;
        Tue, 27 Jun 2023 16:29:59 -0700 (PDT)
Message-ID: <1b0c9677-4e2a-6767-f8f2-23081e6af3e0@arm.com>
Date:   Wed, 28 Jun 2023 00:29:52 +0100
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZJsXLFtH8WkRK41w@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-27 18:06, Nicolin Chen wrote:
> Hi Robin,
> 
> On Tue, Jun 27, 2023 at 10:00:18AM +0100, Robin Murphy wrote:
>> On 2023-06-27 04:33, Nicolin Chen wrote:
>>> When an iommu_domain is set to IOMMU_DOMAIN_IDENTITY, the driver would
>>> skip the allocation of a CD table and set the CONFIG field of the STE
>>> to STRTAB_STE_0_CFG_BYPASS. This works well for devices that only have
>>> one substream, i.e. PASID disabled.
>>>
>>> However, there could be a use case, for a pasid capable device, that
>>> allows bypassing the translation at the default substream while still
>>> enabling the pasid feature, which means the driver should not skip the
>>> allocation of a CD table nor simply bypass the CONFIG field. Instead,
>>> the S1DSS field should be set to STRTAB_STE_1_S1DSS_BYPASS and the
>>> SHCFG field should be set to STRTAB_STE_1_SHCFG_INCOMING.
>>>
>>> Add s1dss and shcfg in struct arm_smmu_s1_cfg, to allow configurations
>>> in the finalise() to support that use case. Then, set them accordingly
>>> depending on the iommu_domain->type and the master->ssid_bits.
>>>
>>> Also, add STRTAB_STE_1_SHCFG_NONSHAREABLE of the default configuration
>>> to distinguish from STRTAB_STE_1_SHCFG_INCOMING of the bypass one.
>>
>> Why? The "default configuration" is that the S1 shareability attribute
>> is determined by the S1 translation itself, so the incoming value is
>> irrelevant.
> 
> That was for a consistency since the driver set the SHCFG field
> to 0x0 (STRTAB_STE_1_SHCFG_NONSHAREABLE). I was not quite sure,
> in a long run, if leaving an uncleared s1_cfg->shcfg potentially
> can result in an unexpected behavior if it's passed in the STE.
> Yet, we could be seemingly sure that the !IOMMU_DOMAIN_IDENTITY
> means the S1 translation must be enabled and so the SHCFG would
> be irrelevant?
> 
> If so, I make make it:
> 
> +	if (smmu_domain->domain.type == IOMMU_DOMAIN_IDENTITY) {
> +		cfg->s1dss = STRTAB_STE_1_S1DSS_BYPASS;
> +		cfg->shcfg = STRTAB_STE_1_SHCFG_INCOMING;
> +	} else {
> +		cfg->s1dss = STRTAB_STE_1_S1DSS_SSID0;
> +	}

What I mean is we don't need a cfg->shcfg field at all - without loss of 
generality it can simply be hard-coded to 1 when S1 is active, same as 
for stream bypass.

The only case where explicitly setting STE.SHCFG=0 makes some sense is 
for a stage-2-only domain if a device's incoming attribute is stronger 
than it needs to be, but even then there are multiple levels of 
IMP-DEFness around whether SHCFG actually does anything anyway.

>>> @@ -2198,7 +2206,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>>>        struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>        struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>
>>> -     if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>>> +     /*
>>> +      * A master with a pasid capability might need a CD table, so only set
>>> +      * ARM_SMMU_DOMAIN_BYPASS if IOMMU_DOMAIN_IDENTITY and non-pasid master
>>> +      */
>>> +     if (domain->type == IOMMU_DOMAIN_IDENTITY && !master->ssid_bits) {
>>>                smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
>>>                return 0;
>>>        }
>>
>> This means we'll now go on to allocate a pagetable for an identity
>> domain, which doesn't seem ideal :/
> 
> Do you suggest to bypass alloc_io_pgtable_ops()? That would zero
> out the TCR fields in the CD. Not sure if it'd work seamlessly,
> but I can give it a try.

I think if there's a good reason to support this then it's worth 
supporting properly, i.e. refactor a bit harder to separate the CD table 
parts which are common to both S1DSS bypass and S1 translation, from the 
CD/pagetable parts that are only relevant for translation. S1DSS bypass 
remains the same as Stream bypass in the sense that there is no 
structure corresponding to the identity domain itself, so not only does 
it not make sense to have a pagetable, there's also no valid place to 
put one anyway - touching the CD belonging to SSID 0 is strictly wrong.

Thanks,
Robin.
