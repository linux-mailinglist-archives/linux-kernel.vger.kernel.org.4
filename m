Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3721E689856
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjBCMMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjBCMM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:12:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A93FE28D26
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:12:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 526014B3;
        Fri,  3 Feb 2023 04:12:59 -0800 (PST)
Received: from [10.57.90.124] (unknown [10.57.90.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 146A93F8D6;
        Fri,  3 Feb 2023 04:12:14 -0800 (PST)
Message-ID: <0f605a38-5ec9-9979-d904-c73bd7fe69a1@arm.com>
Date:   Fri, 3 Feb 2023 12:12:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable PCI ATS in passthrough mode as
 well
Content-Language: en-GB
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, will@kernel.org, joro@8bytes.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
References: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
 <0833e426-d03d-b856-3cb3-8fe97adbb8c1@arm.com>
 <ddbea706-52dc-1505-988a-acc390add3bf@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ddbea706-52dc-1505-988a-acc390add3bf@os.amperecomputing.com>
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

On 2023-02-03 10:44, Ganapatrao Kulkarni wrote:
> 
> 
> On 02-02-2023 06:52 pm, Robin Murphy wrote:
>> On 2023-02-02 12:40, Ganapatrao Kulkarni wrote:
>>> The current smmu-v3 driver does not enable PCI ATS for physical 
>>> functions
>>> of ATS capable End Points when booted in smmu bypass mode
>>> (iommu.passthrough=1). This will not allow virtual functions to enable
>>> ATS(even though EP supports it) while they are attached to a VM using
>>> VFIO driver.
>>>
>>> This patch adds changes to enable ATS support for physical functions
>>> in passthrough/bypass mode as well.
>>>
>>> Also, adding check to avoid disabling of ATS if it is not enabled,
>>> to avoid unnecessary call-traces.
>>>
>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>> ---
>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++++---
>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
>>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index 6d5df91c5c46..5a605cb5ccef 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -2313,11 +2313,16 @@ static void arm_smmu_enable_ats(struct 
>>> arm_smmu_master *master)
>>>   static void arm_smmu_disable_ats(struct arm_smmu_master *master)
>>>   {
>>>       struct arm_smmu_domain *smmu_domain = master->domain;
>>> +    struct pci_dev *pdev;
>>>       if (!master->ats_enabled)
>>>           return;
>>> -    pci_disable_ats(to_pci_dev(master->dev));
>>> +    pdev = to_pci_dev(master->dev);
>>> +
>>> +    if (pdev->ats_enabled)
>>
>> If the master->ats_enabled check above passes when ATS isn't actually 
>> enabled, surely that's a bug?
> 
> IIUC, It means ATS feature is supported (just check for existence of ATS 
> extended capability and smmu capability) and not necessarily enabled.
> Function pci_enable_ats(called by arm_smmu_enable_ats) enables the ATS 
> by setting bit 15 of ATS Control Register (Offset 06h).
> If pci_enable_ats is not successful, it will not set dev->ats_enabled 
> flag. So calling pci_disable_ats later results in call-trace, if 
> dev->ats_enabled is not set.

And like I say, that appears to be a bug, or at least something 
deserving of improvement. If we *know* that enabling ATS failed, leaving 
it hanging in some half-enabled state seems wrong. I know the PCI spec 
says that functions must accept ATS invalidate requests even when ATS is 
disabled, but that still doesn't make it a great idea for the driver to 
spend time and effort sending them when it should know they are 
unnecessarily (especially given the infamous 90-second maximum timeout).

> Function arm_smmu_enable_ats already prints error message if ATS enable 
> is failed.

Printing a message hardly constitutes robust error handling...

Thanks,
Robin.
