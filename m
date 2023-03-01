Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7EC6A7352
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCASTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCASTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:19:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B365161A4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:19:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79B322F4;
        Wed,  1 Mar 2023 10:20:19 -0800 (PST)
Received: from [10.57.78.237] (unknown [10.57.78.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E33E3F587;
        Wed,  1 Mar 2023 10:19:34 -0800 (PST)
Message-ID: <9aec8741-9394-60ad-70c5-f8da773d7da8@arm.com>
Date:   Wed, 1 Mar 2023 18:19:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
 <Y/3yNaQD5Pkvf61k@nvidia.com>
 <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
 <Y/9bWMoAYF10ynO3@nvidia.com> <0f162421-479e-6ab3-bbaf-0090b1a2472c@arm.com>
 <Y/+OobufnmGhg/R7@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y/+OobufnmGhg/R7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-01 17:42, Jason Gunthorpe wrote:
> On Wed, Mar 01, 2023 at 05:15:33PM +0000, Robin Murphy wrote:
>> On 2023-03-01 14:04, Jason Gunthorpe wrote:
>>> On Wed, Mar 01, 2023 at 12:22:23PM +0800, Baolu Lu wrote:
>>>> On 2/28/23 8:23 PM, Jason Gunthorpe wrote:
>>>>> On Tue, Feb 28, 2023 at 10:33:41AM +0800, Lu Baolu wrote:
>>>>>> In normal processing of PCIe ATS requests, the IOMMU performs address
>>>>>> translation and returns the device a physical memory address which
>>>>>> will be stored in that device's IOTLB. The device may subsequently
>>>>>> issue Translated DMA request containing physical memory address. The
>>>>>> IOMMU only checks that the device was allowed to issue such requests
>>>>>> and does not attempt to validate the physical address.
>>>>>>
>>>>>> The Intel IOMMU implementation only allows PCIe ATS on several SOC-
>>>>>> integrated devices which are opt-in’ed through the ACPI tables to
>>>>>> prevent any compromised device from accessing arbitrary physical
>>>>>> memory.
>>>>>>
>>>>>> Add a kernel option intel_iommu=relax_ats to allow users to have an
>>>>>> opt-in to allow turning on ATS at as wish, especially for CSP-owned
>>>>>> vertical devices. In any case, risky devices are not allowed to use
>>>>>> ATS.
>>>>> Why is this an intel specific option?
>>>>
>>>> I only see similar situation on ARM SMMUv3 platforms. The device ATS is
>>>> only allowed when the ATS bit is set in RC node of the ACPI/IORT table.
>>>
>>> It should be common, all iommus using ATS need this logic.
>>
>> The IORT flags are not this kind of policy, they are a necessary description
>> of the hardware. The mix-and-match nature of licensable IP means that just
>> because an SMMU supports the ATS-relevant features defined by the SMMU
>> architecture, that doesn't say that whatever PCIe IP the customer has chosen
>> to pair it with also supports ATS. Even when both ends nominally support it,
>> it's still possible to integrate them together in ways where ATS wouldn't be
>> functional.
>>
>> In general, if a feature is marked as unsupported in IORT, the only way to
>> "relax" that would be if you have a silicon fab handy. If any system vendor
>> *was* to misuse IORT to impose arbitrary and unwelcome usage policy on their
>> customers, then those customers should demand a firmware update (or at least
>> use their own patched IORT, which is pretty trivial with the kernel's
>> existing ACPI table override mechanism).
> 
> This makes sense.
> 
> I think Intel has confused their version of the IORT.
> 
> The ACPI tables read by the iommu driver should be strictly about
> IOMMU HW capability, like Robin describes for ARM.
> 
> Security policy flows through the ExternalFacingPort ACPI via
> pci_acpi_set_external_facing() and triggers pdev->untrusted.
> 
> When an iommu driver sees pdev->untrusted it is supposed to ensure
> that translated TLPs are blocked. Since nothing does this explicitly
> it is presumably happening because ATS being disabled also blocks
> translated TLPs and we check untrusted as part of pci_enable_ats()

At least for SMMU, we seem to be relying on pci_ats_supported() 
including pdev->untrusted in its decision - that will propagate back to 
master->ats_enabled = false inside the driver, which in turn will lead 
to arm_smmu_write_strtab_ent() leaving STE.EATS at the default setting 
which aborts all translation requests and translated transactions.

> If Intel BIOS's have populated the "satcu" to say that ATS is not
> supported by the HW when the HW supports ATS perfectly fine, then get
> the BIOS fixed or patch the ACPI until it is fixed. The BIOS should
> not be saying that the HW does not support ATS when it does, it is a
> simple BIOS bug.
> 
> Alternatively if you have some definitive way to know that the HW
> supports ATS then you should route the satcu information to
> pdev->untrusted and ignore it at the iommu driver level.

 From a quick look at the VT-d spec, it sounds like the ATSR structure 
is intended to be functionally equivalent to IORT's Root Complex "ATS 
Attribute", while the SATC is a slightly specialised version for RCiEPs. 
The spec even says "Software must enable ATS on endpoint devices behind 
a Root Port only if the Root Port is reported as supporting ATS 
transactions". It also seems to be implied that this should be based on 
what Intel themselves have validated, so an option for the user to say 
"sure, ATS works everywhere, I know better" and simply bypass all the 
existing checks doesn't really seem safe to me :/

I'd be inclined to hold the same opinion as for IORT here - if a user 
ever really does need to engage expert mode to safely work around a bad 
BIOS with known-good information, they should already have the tools to 
override the whole DMAR table as they see fit.

Thanks,
Robin.
