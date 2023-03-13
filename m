Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1350B6B786F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCMNHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCMNHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:07:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D58C6A1C3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:07:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64AD91FB;
        Mon, 13 Mar 2023 06:08:31 -0700 (PDT)
Received: from [10.57.91.139] (unknown [10.57.91.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB5C43F64C;
        Mon, 13 Mar 2023 06:07:45 -0700 (PDT)
Message-ID: <ab762cc6-5adf-2515-d9d2-d21d916eb6ad@arm.com>
Date:   Mon, 13 Mar 2023 13:07:42 +0000
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
 <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
 <ZAx2K08L5TIm6r3y@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZAx2K08L5TIm6r3y@Asurada-Nvidia>
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

On 2023-03-11 12:38, Nicolin Chen wrote:
> On Fri, Mar 10, 2023 at 05:53:46PM +0000, Robin Murphy wrote:
> 
>>>>> +     case CMDQ_OP_TLBI_NH_VA:
>>>>> +             cmd.tlbi.asid = inv_info->asid;
>>>>> +             fallthrough;
>>>>> +     case CMDQ_OP_TLBI_NH_VAA:
>>>>> +             if (!granule_size || !(granule_size & smmu->pgsize_bitmap) ||
>>>>
>>>> Non-range invalidations with TG=0 are perfectly legal, and should not be
>>>> ignored.
>>>
>>> I assume that you are talking about the pgsize_bitmap check.
>>>
>>> QEMU embeds a !tg case into the granule_size [1]. So it might
>>> not be straightforward to cover that case. Let me see how to
>>> untangle different cases and handle them accordingly.
>>
>> Oh, double-checking patch #2, that might be me misunderstanding the
>> interface. I hadn't realised that the UAPI was apparently modelled on
>> arm_smmu_tlb_inv_range_asid() rather than actual SMMU commands :)
> 
> Yea. In fact, most of the invalidation info in QEMU was packed
> for the previously defined general cache invalidation structure,
> and the range invalidation part is still not quite independent.
> 
>> I really think UAPI should reflect the hardware and encode TG and TTL
>> directly. Especially since there's technically a flaw in the current
>> driver where we assume TTL in cases where it isn't actually known, thus
>> may potentially fail to invalidate level 2 block entries when removing a
>> level 1 table, since io-pgtable passes the level 3 granule in that case.
> 
> Do you mean something like hw_info forwarding pgsize_bitmap/tg
> to the guest? Or the other direction?

I mean if the interface wants to support range invalidations in a way 
which works correctly, then it should ideally carry both the TG and TTL 
fields from the guest command straight through to the host. If not, then 
at the very least the host must always assume TTL=0, because it cannot 
correctly infer otherwise once the guest command's original intent has 
been lost.

>> When range invalidation came along, the distinction between "all leaves
>> are definitely at the last level" and "use last-level granularity to
>> make sure everything at at any level is hit" started to matter, but the
>> interface never caught up. It hasn't seemed desperately urgent to fix
>> (who does 1GB+ unmaps outside of VFIO teardown anyway?), but we must
>> definitely not bake the same mistake into user ABI.
>>
>> Of course, there might then be cases where we need to transform
>> non-range commands into range commands for the sake of workarounds, but
>> that's our own problem to deal with.
> 
> Noted it down.
> 
>>>> What about NSNH_ALL? That still needs to invalidate all the S1 context
>>>> that the guest *thinks* it's invalidating.
>>>
>>> NSNH_ALL is translated to NH_ALL at the guest level. But maybe
>>> it should have been done here instead.
>>
>> Yes. It seems the worst of both worlds to have an interface which takes
>> raw opcodes rather than an enum of supported commands, but still
>> requires userspace to know which opcodes are supported and which ones
>> don't work as expected even though they are entirely reasonable to use
>> in the context of the stage-1-only SMMU being emulated.
> 
> Maybe a list of supported TLBI commands via the hw_info uAPI?

I don't think it's all that difficult to implicitly support all commands 
that are valid for a stage-1-only SMMU, it just needs the right 
interface design to be capable of encoding them all completely and 
unambiguously. Coming back to the previous point about the address 
encoding, I think that means basing it more directly on the actual 
SMMUv3 commands, rather than on io-pgtable's abstraction of invalidation 
with SMMUv3 opcodes bolted on.

Thanks,
Robin.
