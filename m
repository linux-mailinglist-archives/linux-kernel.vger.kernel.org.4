Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD126B4F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjCJRyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCJRyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:54:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E70E11FFAE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:53:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D1AA4B3;
        Fri, 10 Mar 2023 09:54:37 -0800 (PST)
Received: from [10.57.90.67] (unknown [10.57.90.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A67E73F5A1;
        Fri, 10 Mar 2023 09:53:51 -0800 (PST)
Message-ID: <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
Date:   Fri, 10 Mar 2023 17:53:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     jgg@nvidia.com, will@kernel.org, eric.auger@redhat.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAqpOQ+DDvEfq0Dg@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZAqpOQ+DDvEfq0Dg@Asurada-Nvidia>
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

On 2023-03-10 03:51, Nicolin Chen wrote:
> On Thu, Mar 09, 2023 at 02:49:14PM +0000, Robin Murphy wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2023-03-09 10:53, Nicolin Chen wrote:
>>> Add arm_smmu_cache_invalidate_user() function for user space to invalidate
>>> TLB entries and Context Descriptors, since either an IO page table entrie
>>> or a Context Descriptor in the user space is still cached by the hardware.
>>>
>>> The input user_data is defined in "struct iommu_hwpt_invalidate_arm_smmuv3"
>>> that contains the essential data for corresponding invalidation commands.
>>>
>>> Co-developed-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 56 +++++++++++++++++++++
>>>    1 file changed, 56 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index ac63185ae268..7d73eab5e7f4 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -2880,9 +2880,65 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>>>        arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
>>>    }
>>>
>>> +static void arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
>>> +                                        void *user_data)
>>> +{
>>> +     struct iommu_hwpt_invalidate_arm_smmuv3 *inv_info = user_data;
>>> +     struct arm_smmu_cmdq_ent cmd = { .opcode = inv_info->opcode };
>>> +     struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>> +     struct arm_smmu_device *smmu = smmu_domain->smmu;
>>> +     size_t granule_size = inv_info->granule_size;
>>> +     unsigned long iova = 0;
>>> +     size_t size = 0;
>>> +     int ssid = 0;
>>> +
>>> +     if (!smmu || !smmu_domain->s2 || domain->type != IOMMU_DOMAIN_NESTED)
>>> +             return;
>>> +
>>> +     switch (inv_info->opcode) {
>>> +     case CMDQ_OP_CFGI_CD:
>>> +     case CMDQ_OP_CFGI_CD_ALL:
>>> +             return arm_smmu_sync_cd(smmu_domain, inv_info->ssid, true);
>>
>> Since we let the guest choose its own S1Fmt (and S1CDMax, yet not
>> S1DSS?), how can we assume leaf = true here?
> 
> The s1dss is forwarded in the user_data structure too. So, the
> driver should have set that too down to a nested STE. Will add
> this missing pathway.
> 
> And you are right that the guest OS can use a 2-level table, so
> we should set leaf = false to cover all cases, I think.
> 
>>> +     case CMDQ_OP_TLBI_NH_VA:
>>> +             cmd.tlbi.asid = inv_info->asid;
>>> +             fallthrough;
>>> +     case CMDQ_OP_TLBI_NH_VAA:
>>> +             if (!granule_size || !(granule_size & smmu->pgsize_bitmap) ||
>>
>> Non-range invalidations with TG=0 are perfectly legal, and should not be
>> ignored.
> 
> I assume that you are talking about the pgsize_bitmap check.
> 
> QEMU embeds a !tg case into the granule_size [1]. So it might
> not be straightforward to cover that case. Let me see how to
> untangle different cases and handle them accordingly.

Oh, double-checking patch #2, that might be me misunderstanding the 
interface. I hadn't realised that the UAPI was apparently modelled on 
arm_smmu_tlb_inv_range_asid() rather than actual SMMU commands :)

I really think UAPI should reflect the hardware and encode TG and TTL 
directly. Especially since there's technically a flaw in the current 
driver where we assume TTL in cases where it isn't actually known, thus 
may potentially fail to invalidate level 2 block entries when removing a 
level 1 table, since io-pgtable passes the level 3 granule in that case. 
When range invalidation came along, the distinction between "all leaves 
are definitely at the last level" and "use last-level granularity to 
make sure everything at at any level is hit" started to matter, but the 
interface never caught up. It hasn't seemed desperately urgent to fix 
(who does 1GB+ unmaps outside of VFIO teardown anyway?), but we must 
definitely not bake the same mistake into user ABI.

Of course, there might then be cases where we need to transform 
non-range commands into range commands for the sake of workarounds, but 
that's our own problem to deal with.

> [1] https://patchew.org/QEMU/20200824094811.15439-1-peter.maydell@linaro.org/20200824094811.15439-9-peter.maydell@linaro.org/
> 
>>> +                 granule_size & ~(1ULL << __ffs(granule_size)))
>>
>> If that's intended to mean is_power_of_2(), please just use is_power_of_2().
>>
>>> +                     return;
>>> +
>>> +             iova = inv_info->range.start;
>>> +             size = inv_info->range.last - inv_info->range.start + 1;
>>
>> If the design here is that user_data is so deeply driver-specific and
>> special to the point that it can't possibly be passed as a type-checked
>> union of the known and publicly-visible UAPI types that it is, wouldn't
>> it make sense to just encode the whole thing in the expected format and
>> not have to make these kinds of niggling little conversions at both ends?
> 
> Hmm, that makes sense to me.
> 
> I just tracked back the history of Eric's previous work. There
> was a mismatch between guest and host that RIL isn't supported
> by the hardware. Now, guest can have whatever information it'd
> need from the host to send supported instructions.
> 
>>> +             if (!size)
>>> +                     return;
>>> +
>>> +             cmd.tlbi.vmid = smmu_domain->s2->s2_cfg.vmid;
>>> +             cmd.tlbi.leaf = inv_info->flags & IOMMU_SMMUV3_CMDQ_TLBI_VA_LEAF;
>>> +             __arm_smmu_tlb_inv_range(&cmd, iova, size, granule_size, smmu_domain);
>>> +             break;
>>> +     case CMDQ_OP_TLBI_NH_ASID:
>>> +             cmd.tlbi.asid = inv_info->asid;
>>> +             fallthrough;
>>> +     case CMDQ_OP_TLBI_NH_ALL:
>>> +             cmd.tlbi.vmid = smmu_domain->s2->s2_cfg.vmid;
>>> +             arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>>> +             break;
>>> +     case CMDQ_OP_ATC_INV:
>>> +             ssid = inv_info->ssid;
>>> +             iova = inv_info->range.start;
>>> +             size = inv_info->range.last - inv_info->range.start + 1;
>>> +             break;
>>
>> Can we do any better than multiplying every single ATC_INV command, even
>> for random bogus StreamIDs, into multiple commands across every physical
>> device? In fact, I'm not entirely confident this isn't problematic, if
>> the guest wishes to send invalidations for one device specifically while
>> it's put some other device into a state where sending it a command would
>> do something bad. At the very least, it's liable to be confusing if the
>> guest sends a command for one StreamID but gets an error back for a
>> different one.
> 
> We'd need here an sid translation from the guest value to the
> host value to specify a device, so as not to multiply the cmd
> with the device list, if I understand it correctly?

I guess it depends on whether IOMMUFD is aware of the vSID->device 
relationships that the VMM is using. If so, then it should be OK for the 
VMM to pass through the vSID directly, and we can translate and 
sanity-check it internally. Otherwise, the interface might have to 
require the VMM to translate vSID->RID and pass the corresponding host 
RID, which we can then map back to a SID (userspace cannot do the full 
vSID->SID by itself, and even if it could that would probably be more 
awkward to validate).

>> And if we expect ATS, what about PRI? Per patch #4 you're currently
>> offering that to the guest as well.
> 
> Oh, I should have probably blocked PRI. The PRI and the fault
> injection will be followed after the basic 2-stage translation
> patches. And I don't have a supporting hardware to test PRI.
> 
>>
>>> +     default:
>>> +             return;
>>
>> What about NSNH_ALL? That still needs to invalidate all the S1 context
>> that the guest *thinks* it's invalidating.
> 
> NSNH_ALL is translated to NH_ALL at the guest level. But maybe
> it should have been done here instead.

Yes. It seems the worst of both worlds to have an interface which takes 
raw opcodes rather than an enum of supported commands, but still 
requires userspace to know which opcodes are supported and which ones 
don't work as expected even though they are entirely reasonable to use 
in the context of the stage-1-only SMMU being emulated.

Thanks,
Robin.
