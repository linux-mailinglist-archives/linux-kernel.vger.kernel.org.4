Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEF4635BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiKWLc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbiKWLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:32:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E433E18B02
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:32:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 283101FB;
        Wed, 23 Nov 2022 03:32:59 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 067823F587;
        Wed, 23 Nov 2022 03:32:50 -0800 (PST)
Message-ID: <53678e27-1bbc-a7e8-a1b0-0427fc0e5b62@arm.com>
Date:   Wed, 23 Nov 2022 11:32:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] iommu/vt-d: Add a fix for devices need extra dtlb flush
Content-Language: en-GB
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Luo, Yuzhang" <yuzhang.luo@intel.com>
References: <20221122034529.3311562-1-jacob.jun.pan@linux.intel.com>
 <bc647ceb-b14b-dc5b-ba83-4f8befd188c5@arm.com>
 <BN9PR11MB527620902046A4339EAACD3F8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c085f67d-7874-4a83-a12c-703d1638d940@linux.intel.com>
 <BN9PR11MB527642B1DA920C78742036FD8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BN9PR11MB527642B1DA920C78742036FD8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022-11-23 05:18, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, November 23, 2022 1:04 PM
>>
>> On 2022/11/23 9:02, Tian, Kevin wrote:
>>>> From: Robin Murphy <robin.murphy@arm.com>
>>>> Sent: Wednesday, November 23, 2022 1:49 AM
>>>>
>>>>> +
>>>>> +/* Impacted QAT device IDs ranging from 0x4940 to 0x4943 */
>>>>> +#define BUGGY_QAT_DEVID_MASK 0x494c
>>>>> +static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
>>>>> +{
>>>>> +	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
>>>>> +		return false;
>>>>> +
>>>>> +	if ((pdev->device & 0xfffc) != BUGGY_QAT_DEVID_MASK)
>>>>> +		return false;
>>>>> +
>>>>> +	if (risky_device(pdev))
>>>>> +		return false;
>>>>
>>>> Hmm, I'm not sure that that makes much sense to me - what privilege can
>>>> the device gain from being told to invalidate things twice? Why would we
>>>> want to implicitly *allow* a device to potentially keep using a stale
>>>> translation if for some bizarre reason firmware has marked it as
>>>> external, surely that's worse?
>>
>>   From the perspective of IOMMU, any quirk is only applicable to trusted
>> devices. If the IOMMU driver detects that a quirk is being applied to an
>> untrusted device, it is already buggy or malicious. The IOMMU driver
>> should let the users know by:
>>
>> 	pci_info(pdev,
>> 		 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted
>> PCI link\n",
>> 		 pdev->vendor, pdev->device);
>> 	pci_info(pdev, "Please check with your BIOS/Platform vendor about
>> this\n");
>>
>> and stop applying any quirk.
>>
> 
> A quirk usually relaxes something then you want it only on trusted devices.
> 
> but the quirk in this patch is trying to fix a vulnerability. In concept it's
> weird to skip it on untrusted devices. This iiuc was the part causing confusion
> to Robin.

Right, it's that reasoning in general that seems bogus to me. Clearly 
any quirk that effectively grants additional privileges, like an 
identity mapping quirk, should not be applied to untrusted external 
devices which may be spoofing an affected VID/DID to gain that 
privilege, but not all quirks imply privilege. If, say, a WiFI 
controller needs something innocuous like a DMA alias or address width 
quirk to function correctly, it will still need that regardless of 
whether it's soldered to a motherboard or to a removable expansion card, 
and it would do nobody any good to deny correct functionality based on 
that unnecessary distinction. Yes, I appreciate that in practice many of 
those kind of quirks will be applied in other layers anyway, but I still 
think it's wrong to make a sweeping assumption that all IOMMU-level 
quirks are precious treasure not to be shared with outsiders, rather 
than assess their impact individually. The detriment in this case is 
small (just needless code churn), but even that's still not nothing.

Thanks,
Robin.
