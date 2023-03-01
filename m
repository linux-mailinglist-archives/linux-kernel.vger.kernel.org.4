Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C96A71E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCARPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCARPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:15:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19A9D3B208
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:15:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9066B2F4;
        Wed,  1 Mar 2023 09:16:23 -0800 (PST)
Received: from [10.57.78.237] (unknown [10.57.78.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AD103F587;
        Wed,  1 Mar 2023 09:15:39 -0800 (PST)
Message-ID: <0f162421-479e-6ab3-bbaf-0090b1a2472c@arm.com>
Date:   Wed, 1 Mar 2023 17:15:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
 <Y/3yNaQD5Pkvf61k@nvidia.com>
 <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
 <Y/9bWMoAYF10ynO3@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y/9bWMoAYF10ynO3@nvidia.com>
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

On 2023-03-01 14:04, Jason Gunthorpe wrote:
> On Wed, Mar 01, 2023 at 12:22:23PM +0800, Baolu Lu wrote:
>> On 2/28/23 8:23 PM, Jason Gunthorpe wrote:
>>> On Tue, Feb 28, 2023 at 10:33:41AM +0800, Lu Baolu wrote:
>>>> In normal processing of PCIe ATS requests, the IOMMU performs address
>>>> translation and returns the device a physical memory address which
>>>> will be stored in that device's IOTLB. The device may subsequently
>>>> issue Translated DMA request containing physical memory address. The
>>>> IOMMU only checks that the device was allowed to issue such requests
>>>> and does not attempt to validate the physical address.
>>>>
>>>> The Intel IOMMU implementation only allows PCIe ATS on several SOC-
>>>> integrated devices which are opt-in’ed through the ACPI tables to
>>>> prevent any compromised device from accessing arbitrary physical
>>>> memory.
>>>>
>>>> Add a kernel option intel_iommu=relax_ats to allow users to have an
>>>> opt-in to allow turning on ATS at as wish, especially for CSP-owned
>>>> vertical devices. In any case, risky devices are not allowed to use
>>>> ATS.
>>> Why is this an intel specific option?
>>
>> I only see similar situation on ARM SMMUv3 platforms. The device ATS is
>> only allowed when the ATS bit is set in RC node of the ACPI/IORT table.
> 
> It should be common, all iommus using ATS need this logic.

The IORT flags are not this kind of policy, they are a necessary 
description of the hardware. The mix-and-match nature of licensable IP 
means that just because an SMMU supports the ATS-relevant features 
defined by the SMMU architecture, that doesn't say that whatever PCIe IP 
the customer has chosen to pair it with also supports ATS. Even when 
both ends nominally support it, it's still possible to integrate them 
together in ways where ATS wouldn't be functional.

In general, if a feature is marked as unsupported in IORT, the only way 
to "relax" that would be if you have a silicon fab handy. If any system 
vendor *was* to misuse IORT to impose arbitrary and unwelcome usage 
policy on their customers, then those customers should demand a firmware 
update (or at least use their own patched IORT, which is pretty trivial 
with the kernel's existing ACPI table override mechanism).

Thanks,
Robin.

>>> all it does is effectively
>>> disable untrusted?
>>
>> It's irrelevant to untrusted devices.
>>
>> Untrusted devices, with pci_dev->untrusted set, means device connects to
>> the system through some kind of untrusted external port, e.g.
>> thunderbolt ports. For those devices, ATS shouldn't be enabled for those
>> devices.
> 
> Yes
>   
>> Here we are talking about soc-integrated devices vs. discrete PCI
>> devices (connected to the system through internal PCI slot). The problem
>> is that the DMAR ACPI table only defines ATS attribute for Soc-
>> integrated devices, which causes ATS (and its ancillary features) on the
>> discrete PCI devices not to work.
> 
> So, IMHO, it is a bug to set what Linux calls as untrusted for
> discrete slots. We also definately don't want internal slots forced to
> non-identity mode either, for example.
> 
> This should be addressed at the PCI layer. Untrusted should always
> mean that the iommu layer should fully secure the device. It means
> identity translation should be blocked, it means the HW should reject
> translated requests, and ATS thus is not supported.
> 
> Every single iommu driver should implement this consistently across
> the whole subsystem.
> 
> If you don't want devices to be secured then that is a PCI/bios layer
> problem to get the correct data into the untrusted flag.
> 
> Not an iommu problem to ignore the flag.
> 
> Jason
