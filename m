Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07A622C59
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKIN0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKIN0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:26:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 589DF2D3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:26:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01E181FB;
        Wed,  9 Nov 2022 05:26:57 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F1C03F73D;
        Wed,  9 Nov 2022 05:26:49 -0800 (PST)
Message-ID: <362bac0f-3dc1-b5e8-2bb7-c8e0f546eaa0@arm.com>
Date:   Wed, 9 Nov 2022 13:26:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC] iommu/vt-d: set default value of INTEL_IOMMU_FLOPPY_WA to n
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     konrad.wilk@oracle.com, harshit.m.mogalapalli@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Darren Kenny <darren.kenny@oracle.com>
References: <20221108125855.2984751-1-harshit.m.mogalapalli@oracle.com>
 <dc463b3e-2875-8aac-aca1-edacb90e5650@linux.intel.com>
 <76cbad17-ab5e-3dd9-cf94-df2b26748167@oracle.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <76cbad17-ab5e-3dd9-cf94-df2b26748167@oracle.com>
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

On 09/11/2022 12:16 pm, Harshit Mogalapalli wrote:
> 
> 
> On 09/11/22 12:35 pm, Baolu Lu wrote:
>> On 2022/11/8 20:58, Harshit Mogalapalli wrote:
>>> It is likely that modern intel motherboard will not ship with a
>>> floppy connection anymore, so let us disable it by default, as it
>>> gets turned on when we do a make defconfig.
>>>
>>> Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>> ---
>>>   drivers/iommu/intel/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>>> index b7dff5092fd2..c783ae85ca9b 100644
>>> --- a/drivers/iommu/intel/Kconfig
>>> +++ b/drivers/iommu/intel/Kconfig
>>> @@ -76,7 +76,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>>         option is removed in the 2.6.32 kernel.
>>>   config INTEL_IOMMU_FLOPPY_WA
>>> -    def_bool y
>>> +    def_bool n
>>>       depends on X86
>>>       help
>>>         Floppy disk drivers are known to bypass DMA API calls
>>
>> Nobody selects or depends on this. How about removing this bool? Only
>> less than 10 lines of code are impacted and are not in any performance
>> path.
>>
>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>> index b7dff5092fd2..5e077d1c5f5d 100644
>> --- a/drivers/iommu/intel/Kconfig
>> +++ b/drivers/iommu/intel/Kconfig
>> @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>         to use physical addresses for DMA, at least until this
>>         option is removed in the 2.6.32 kernel.
>>
>> -config INTEL_IOMMU_FLOPPY_WA
>> -    def_bool y
>> -    depends on X86
>> -    help
>> -      Floppy disk drivers are known to bypass DMA API calls
>> -      thereby failing to work when IOMMU is enabled. This
>> -      workaround will setup a 1:1 mapping for the first
>> -      16MiB to make floppy (an ISA device) work.
>> -
>>   config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>>       bool "Enable Intel IOMMU scalable mode by default"
>>       default y
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 48cdcd0a5cf3..22801850f339 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4567,7 +4567,6 @@ static void intel_iommu_get_resv_regions(struct 
>> device *device,
>>       }
>>       rcu_read_unlock();
>>
>> -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>>       if (dev_is_pci(device)) {
>>           struct pci_dev *pdev = to_pci_dev(device);
>>
>> @@ -4579,7 +4578,6 @@ static void intel_iommu_get_resv_regions(struct 
>> device *device,
>>                   list_add_tail(&reg->list, head);
>>           }
>>       }
>> -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
>>
>>       reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>>                         IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
>>
> 
> Hi Baolu,
> 
> I have a question:
> Shouldn't we remove the code between ifdef-endif statements?

No, machines with floppy drives may be uncommon, but almost certainly 
some are still in use and being updated with new kernels, so we should 
continue to support them.

Do you have any practical issues with the ISA reserved region being 
present, or is the only motivation here to save a few bytes of code when 
it won't be needed? In the latter case, making it "def_bool BLK_DEV_FD" 
might be sensible.

(For the original patch, note that "def_bool n" is always a bit 
redundant since plain "bool" implicitly defaults to "n" anyway)

Thanks,
Robin.

> I mean something like this:
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index b7dff5092fd2..5e077d1c5f5d 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>            to use physical addresses for DMA, at least until this
>            option is removed in the 2.6.32 kernel.
> 
> -config INTEL_IOMMU_FLOPPY_WA
> -       def_bool y
> -       depends on X86
> -       help
> -         Floppy disk drivers are known to bypass DMA API calls
> -         thereby failing to work when IOMMU is enabled. This
> -         workaround will setup a 1:1 mapping for the first
> -         16MiB to make floppy (an ISA device) work.
> -
>   config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>          bool "Enable Intel IOMMU scalable mode by default"
>          default y
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 48cdcd0a5cf3..2c416ad3204e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4567,20 +4567,6 @@ static void intel_iommu_get_resv_regions(struct 
> device *device,
>          }
>          rcu_read_unlock();
> 
> -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
> -       if (dev_is_pci(device)) {
> -               struct pci_dev *pdev = to_pci_dev(device);
> -
> -               if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
> -                       reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
> -                                       IOMMU_RESV_DIRECT_RELAXABLE,
> -                                       GFP_KERNEL);
> -                       if (reg)
> -                               list_add_tail(&reg->list, head);
> -               }
> -       }
> -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
> -
>          reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>                                        IOAPIC_RANGE_END - 
> IOAPIC_RANGE_START + 1,
>                                        0, IOMMU_RESV_MSI, GFP_KERNEL);
> 
> This code is introduced in Commit d850c2ee5fe2 ("iommu/vt-d: Expose ISA 
> direct mapping region via iommu_get_resv_regions")
> 
> If others don't have an objection I can send a patch with the above diff.
> 
> Note: I am unsure about the code internals.
> 
> Thanks,
> Harshit
> 
> 
>> Best regards,
>> baolu
