Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765316B26E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCIO2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCIO2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:28:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D8914DE13
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:28:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A492C14;
        Thu,  9 Mar 2023 06:29:01 -0800 (PST)
Received: from [10.57.91.145] (unknown [10.57.91.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53D5E3F5A1;
        Thu,  9 Mar 2023 06:28:16 -0800 (PST)
Message-ID: <20fb0697-fc0d-daab-2517-7bee7415e695@arm.com>
Date:   Thu, 9 Mar 2023 14:28:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 12/14] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
 type of allocations
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org
Cc:     eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <b01b2bad6d0d34908812d964eba118a9cc1e89ab.1678348754.git.nicolinc@nvidia.com>
 <b8660bcf-7b12-fd49-7b5b-58909ac8746d@arm.com>
In-Reply-To: <b8660bcf-7b12-fd49-7b5b-58909ac8746d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-09 13:20, Robin Murphy wrote:
> On 2023-03-09 10:53, Nicolin Chen wrote:
>> Add domain allocation support for IOMMU_DOMAIN_NESTED type. This includes
>> the "finalise" part to log in the user space Stream Table Entry info.
>>
>> Co-developed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 38 +++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 5ff74edfbd68..1f318b5e0921 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2214,6 +2214,19 @@ static int arm_smmu_domain_finalise(struct 
>> iommu_domain *domain,
>>           return 0;
>>       }
>> +    if (domain->type == IOMMU_DOMAIN_NESTED) {
>> +        if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1) ||
>> +            !(smmu->features & ARM_SMMU_FEAT_TRANS_S2)) {
>> +            dev_dbg(smmu->dev, "does not implement two stages\n");
>> +            return -EINVAL;
>> +        }
>> +        smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>> +        smmu_domain->s1_cfg.s1fmt = user_cfg->s1fmt;
>> +        smmu_domain->s1_cfg.s1cdmax = user_cfg->s1cdmax;
>> +        smmu_domain->s1_cfg.cdcfg.cdtab_dma = user_cfg->s1ctxptr;
>> +        return 0;
> 
> How's that going to work? If the caller's asked for something we can't 
> provide, returning something else and hoping it fails later is not 
> sensible, we should just fail right here. It's even more worrying if 
> there's a chance it *won't* fail later, and a guest ends up with 
> "nested" translation giving it full access to host PA space :/

Oops, apologies - in part thanks to the confusing indentation, I managed 
to miss the early return and misread this all being under the if 
condition for nesting not being supported. Sorry for the confusion :(

Thanks,
Robin.

>> +    }
>> +
>>       if (user_cfg_s2 && !(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
>>           return -EINVAL;
>>       if (user_cfg_s2)
>> @@ -2863,6 +2876,11 @@ static void arm_smmu_remove_dev_pasid(struct 
>> device *dev, ioasid_t pasid)
>>       arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
>>   }
>> +static const struct iommu_domain_ops arm_smmu_nested_domain_ops = {
>> +    .attach_dev        = arm_smmu_attach_dev,
>> +    .free            = arm_smmu_domain_free,
>> +};
>> +
>>   static struct iommu_domain *
>>   __arm_smmu_domain_alloc(unsigned type,
>>               struct arm_smmu_domain *s2,
>> @@ -2877,11 +2895,15 @@ __arm_smmu_domain_alloc(unsigned type,
>>           return arm_smmu_sva_domain_alloc();
>>       if (type != IOMMU_DOMAIN_UNMANAGED &&
>> +        type != IOMMU_DOMAIN_NESTED &&
>>           type != IOMMU_DOMAIN_DMA &&
>>           type != IOMMU_DOMAIN_DMA_FQ &&
>>           type != IOMMU_DOMAIN_IDENTITY)
>>           return NULL;
>> +    if (s2 && s2->stage != ARM_SMMU_DOMAIN_S2)
>> +        return NULL;
>> +
>>       /*
>>        * Allocate the domain and initialise some of its data structures.
>>        * We can't really finalise the domain unless a master is given.
>> @@ -2889,10 +2911,14 @@ __arm_smmu_domain_alloc(unsigned type,
>>       smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
>>       if (!smmu_domain)
>>           return NULL;
>> +    smmu_domain->s2 = s2;
>>       domain = &smmu_domain->domain;
>>       domain->type = type;
>> -    domain->ops = arm_smmu_ops.default_domain_ops;
>> +    if (s2)
>> +        domain->ops = &arm_smmu_nested_domain_ops;
>> +    else
>> +        domain->ops = arm_smmu_ops.default_domain_ops;
>>       mutex_init(&smmu_domain->init_mutex);
>>       INIT_LIST_HEAD(&smmu_domain->devices);
>> @@ -2923,8 +2949,16 @@ arm_smmu_domain_alloc_user(struct device *dev, 
>> struct iommu_domain *parent,
>>       const struct iommu_hwpt_arm_smmuv3 *user_cfg = user_data;
>>       struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>>       unsigned type = IOMMU_DOMAIN_UNMANAGED;
>> +    struct arm_smmu_domain *s2 = NULL;
>> +
>> +    if (parent) {
>> +        if (parent->ops != arm_smmu_ops.default_domain_ops)
>> +            return NULL;
>> +        type = IOMMU_DOMAIN_NESTED;
>> +        s2 = to_smmu_domain(parent);
>> +    }
>> -    return __arm_smmu_domain_alloc(type, NULL, master, user_cfg);
>> +    return __arm_smmu_domain_alloc(type, s2, master, user_cfg);
>>   }
>>   static struct iommu_ops arm_smmu_ops = {
> 
