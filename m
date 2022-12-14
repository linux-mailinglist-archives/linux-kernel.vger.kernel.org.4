Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035BC64D159
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLNUhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiLNUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:36:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ABA231EC5;
        Wed, 14 Dec 2022 12:33:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37578FEC;
        Wed, 14 Dec 2022 12:33:58 -0800 (PST)
Received: from [10.57.88.237] (unknown [10.57.88.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A97943F71E;
        Wed, 14 Dec 2022 12:33:15 -0800 (PST)
Message-ID: <3f3112e4-65ff-105d-8cd7-60495ec9054a@arm.com>
Date:   Wed, 14 Dec 2022 20:33:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH] arm64: dts: ls1028a: mark ARM SMMU as DMA coherent
Content-Language: en-GB
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
References: <20221208151514.3840720-1-vladimir.oltean@nxp.com>
 <2a188b8a-ab16-d5d4-ed5f-f8eec236e4ca@arm.com>
 <20221214165356.6tbzmfyoifqt4cwk@skbuf>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221214165356.6tbzmfyoifqt4cwk@skbuf>
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

On 2022-12-14 16:53, Vladimir Oltean wrote:
> Hi Robin,
> 
> On Thu, Dec 08, 2022 at 07:01:16PM +0000, Robin Murphy wrote:
>> It's more just good fortune that it ever worked properly at all.
> 
> Thanks for the response. I don't know much about IOMMUs or the ARM SMMU,
> I'm trying to understand what you've said. I hope you don't mind a few
> foolish questions.
> 
>> We have to make the DT authoritative about coherency because cases exist where
>> the ID register is misconfigured.
> 
> Which ID register? The ARM_SMMU_ID0_CTTW bit in ARM_SMMU_GR0_ID0, as
> read by arm_smmu_device_cfg_probe()?

Yes.

> I tried to find more about this bit (driver suggests it's bit 14), but I'm a bit lost.
> First of all, I don't know where to find the ID0 register for MMU-500.
> I looked at the register summary here and didn't find it:
> https://developer.arm.com/documentation/ddi0517/f/programmers-model/register-summary/global-address-space-0-registers-summary?lang=en
> Then I googled it and found this page, where it just says that at bit 14
> there's indeed something named CTTW (unexplained) which is hardcoded to 0:
> https://developer.arm.com/documentation/ddi0517/e/programmers-model/memory-model/reset-values?lang=en
> I did however download the SMMU v2 arch spec PDF at
> https://developer.arm.com/documentation/ihi0062/latest
> 
> and there, I did find it. But I'm not sure why the MMU-500 says it
> *should* be hardcoded to 0? Is this what you call "misconfigured"?

For some reason, SMMU TRMs seem to have a tradition of describing their 
implementation of architectural registers in weird and unexpected 
places... Anyway that appears to be a documentation bug, since the 
actual SMMU_IDR0.CTTW value should reflect whatever is sampled on the 
cfg_cttw input at reset, per:

https://developer.arm.com/documentation/ddi0517/f/signal-descriptions/miscellaneous-signals/tie-off-signals

> On my hardware (both LS1028A and LS1088A), it reads:
> 
> $ dmesg | grep smmu
> [    4.825109] arm-smmu 5000000.iommu: probing hardware configuration...
> [    4.831625] arm-smmu 5000000.iommu: SMMUv2 with:
> [    4.836293] arm-smmu 5000000.iommu: GR0_ID0: 0x7c013e80
> [    4.841569] arm-smmu 5000000.iommu:  stage 1 translation
> [    4.846931] arm-smmu 5000000.iommu:  stage 2 translation
> [    4.852293] arm-smmu 5000000.iommu:  nested translation
> [    4.857573] arm-smmu 5000000.iommu:  stream matching with 128 register groups
> [    4.864776] arm-smmu 5000000.iommu:  64 context banks (0 stage-2 only)
> [    4.871372] arm-smmu 5000000.iommu:  Supported page sizes: 0x61311000
> [    4.877868] arm-smmu 5000000.iommu:  Stage-1: 48-bit VA -> 48-bit IPA
> [    4.884375] arm-smmu 5000000.iommu:  Stage-2: 48-bit IPA -> 48-bit PA
> [    4.893113] arm-smmu 5000000.iommu:  preserved 0 boot mappings
> 
> On the other hand, in the verbal (no registers) documentation of the
> MMU-500 integration in my SoCs, it does say that "The SMMU supports cache
> coherency for page table walks and DVM transactions for page table cache
> maintenance operations."
> 
> Does looking at the CTTW bit make any sense for MMU-500?

In general, yes. The result above does imply that NXP have inadvertently 
set cfg_cttw wrong. For the avoidance of doubt, here's another MMU-500 
showing SMMU_IDR0.CTTW set:

[    3.014972] arm-smmu arm-smmu.0.auto: probing hardware configuration...
[    3.014974] arm-smmu arm-smmu.0.auto: SMMUv2 with:
[    3.014976] arm-smmu arm-smmu.0.auto:        stage 2 translation
[    3.014977] arm-smmu arm-smmu.0.auto:        coherent table walk
[    3.014979] arm-smmu arm-smmu.0.auto:        stream matching with 128 
register groups
[    3.014981] arm-smmu arm-smmu.0.auto:        128 context banks (128 
stage-2 only)
[    3.014984] arm-smmu arm-smmu.0.auto:        Supported page sizes: 
0x60211000
[    3.014986] arm-smmu arm-smmu.0.auto:        Stage-2: 48-bit IPA -> 
48-bit PA

>> You've been telling Linux that that is the case, and now the message
>> is finally getting through to VFIO. If we weren't also lazy in
>> io-pgtable-arm about what shareability attribute to use for IOMMU_CACHE,
>> you would have actually had the broken VFIO behaviour that that check
>> is now defending against.
> 
> lazy in io-pgtable-arm == ??
> 
> I assume you're talking about something which is (not) done in
> arm_lpae_prot_to_pte()? Could you please clarify, as I didn't understand?

Strictly, a Cacheable mapping for a non-coherent device should probably 
have the Non-Shareable attribute, but since we assume that a 
non-coherent interconnect would ignore the shareability anyway, we don't 
bother, and just always use Inner-Shareable since that's the right value 
for when it *will* matter. Also io-pgtable couldn't make that decision 
itself, since it doesn't know anything about the intended use of the 
mapping other than an input address, and output address, and some 
abstract iommu_prot flags.

> IIUC (and I've been wrong before), the IOMMU_CACHE "prot" flag means
> that memory mapped by the IOMMU for DMA is coherent w.r.t. CPU caches,
> and VFIO specifically needs it because:
> 
> 	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
> 	 * restore cache coherency.
> 
> i.o.w. user space can't execute cache invalidation instructions (DC CIVAC etc),
> which would make cache-coherent DMA transactions the only viable possibility.
> Right?

Yes, userspace is in general not allowed to bypass CPU coherency for 
security reasons, so the only way it's viable for a device to operate 
directly on userspace mappings is if that device can snoop caches as 
well. Of course it's technically a bit different when that "userspace" 
is a virtual machine manager that's then going to hand control of the 
device to a VM that *can* do its own non-coherent cache maintenance, but 
I don't think we can easily make that distinction at the VFIO level.

>> I'd argue that you do want to make the DT change, because it's the truth
>> of the hardware. Even if you did want to keep doing the significant
>> extra work of maintaining non-coherent pagetables (there is a dubious
>> snoop latency vs. TLB miss rate argument), that would be better achieved
>> at the level of the io_pgtable_cfg, not by lying about the entire SMMU.
> 
> I do agree that we could set the dma-coherent property in the SMMU node
> to skip some of the wmb() instructions in the TLB invalidation procedures
> for stage 1/stage 2 translations. I wasn't trying to make any argument
> in favor of manually maintaining the cache coherency with the page tables.

FWIW it's not about the TLB maintenance in the driver, it's io-pgtable's 
cache maintenance on PTE updates, and even more so the synchronisation 
thereof, that gets pretty involved.

> I'm just not exactly clear what does the page table walk of the SMMU TCU
> have to do with the cache coherence of the DMA transactions forwarded/translated
> by the TBUs. I mean, I saw the comment below:
> 
> 	/* Assume that a coherent TCU implies coherent TBUs */
> 
> but I simply don't understand what is it that gives this assumption any
> grounds.

In short, it's based on how people tend to design SoCs in practice; I'm 
yet to come across any system where it doesn't hold.

>> However, since Jason refactored things at the VFIO end too, it looks like
>> this should now be consistently checked for every individual device
>> bound to a VFIO driver, so we might be able to do a bit better, as
>> below.
> 
> hmm, the change in vfio_group_find_or_alloc() between iommu_capable(dev->bus)
> and device_iommu_capable(dev) took place in commit a9cf69d0e7f2 ("Merge
> tag 'vfio-v6.0-rc1' of https://github.com/awilliam/linux-vfio"), says my
> git blame. Pretty strange. I had to use git log --graph to find your
> commit specifically: 3b498b665621 ("vfio: Use device_iommu_capable()").

That's because that line does actually belong to the merge commit, where 
Linus resolved the conflict between my IOMMU patch changing the call and 
Jason's VFIO patch moving the callsite.

>> I'd be rather surprised if anyone ever genuinely built this
>> topology, but it does happen to be the one other combination that's easy
>> to infer with reasonable confidence.
> 
> this topology == ?
> non-coherent SMMU page table walks but cache coherent DMA traffic of
> SMMU upstream device?

Yes.

> Feasible or not, VFIO doesn't have a problem working with that device
> even if the SMMU doesn't do coherent walking of its translation tables,
> no?

As you've quoted from the SoC documentation and demonstrated with this 
patch, this SMMU *is* coherent for both pagetable walks and client 
translation, and that's what matters in terms of VFIO not being 
completely broken. It makes no difference what pagetable walk attributes 
Linux actually uses, the underlying hardware is there to make 
IOMMU_CACHE snoop, which in this one weird corner case means that a 
couple of assumptions based on incorrect information cancel out, and 
something that seemingly shouldn't work, does.

>>
>> Thanks,
>> Robin.
>>
>> ----->8-----
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 30dab1418e3f..a5ad9d6b51cf 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -1320,7 +1320,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>>   	switch (cap) {
>>   	case IOMMU_CAP_CACHE_COHERENCY:
>>   		/* Assume that a coherent TCU implies coherent TBUs */
>> -		return cfg->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
>> +		return cfg->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK ||
>> +			device_get_dma_attr(dev) == DEV_DMA_COHERENT;
> 
> So this works for enetc, thanks. However, do we need to also consider
> handling DEV_DMA_NOT_SUPPORTED, and thus, testing != DEV_DMA_NON_COHERENT
> could be better than == DEV_DMA_COHERENT?

If firmware says the device can't access memory, can we make its memory 
accesses coherent?... Since it's likely to have a pretty bad time with 
VFIO either way, I think we can dodge getting philosophical here :)

> But from your response and the explanation in commit df198b37e72c
> ("iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY better"), I'm not
> clear why we would keep looking at the COHERENT_WALK feature at all?

Because if the SMMU is coherent, then a stage 1 translation with 
IOMMU_CACHE can output cache-snooping attributes even if the device 
can't do so natively.

Of course that isn't necessarily true for stage 2 (without venturing 
into S2CR attribute overrides), so we're still some way off giving an 
accurate answer here, but as the original commit said, the aim was not 
to be right, just less wrong.

I'll try to improve the comment when I spin this tweak into a proper patch.

Thanks,
Robin.

> It seems to my layman eyes that we are artificially coupling 2 concepts
> that have nothing in common, and bad reporting for one of them is
> causing trouble with the other.
> 
>>   	case IOMMU_CAP_NOEXEC:
>>   		return true;
>>   	default:
> 
> Thanks!
