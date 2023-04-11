Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2F6DDF14
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjDKPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjDKPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:10:51 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 564D14495;
        Tue, 11 Apr 2023 08:10:33 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id A332A21779A6;
        Tue, 11 Apr 2023 08:10:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A332A21779A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681225832;
        bh=ycSrEC7pWGdXdxu/mHL3bp2nfLVB5gxF2Cjrm5Myx3A=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=LNfMFQ7JFl3NwcSGGn8t6uSoHrq/WrIVsz0bJ5FAnWhVdYE8wju+R0MoQK+Nyfa1u
         tuTIRQcFhXFlcQxTDzzqi5sHA0iJO5MjXLV1MqWV3pKFPic/kP6pdlCHFMbY5RHwpc
         UljOU3pac8RsS7LNCNQrkTaTMlSPiVXGBm6VZoes=
Message-ID: <fc6a807a-1bbe-d56d-caa9-ec0687ef6cff@linux.microsoft.com>
Date:   Tue, 11 Apr 2023 17:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 0/8] Support ACPI PSP on Hyper-V
Content-Language: en-US
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230322154655.GDZBsi75f6LnQStxSp@fat_crate.local>
 <1d25221c-eaab-0f97-83aa-8b4fbe3a53ed@linux.microsoft.com>
 <20230322181541.GEZBtFzRAMcH9BAzUe@fat_crate.local>
 <ecf005b1-ddb9-da4c-4526-28df4806426c@linux.microsoft.com>
 <20230323152342.GFZBxu/m3u6aFUDY/7@fat_crate.local>
 <105d019c-2249-5dfd-e032-95944ea6dc8c@linux.microsoft.com>
 <20230323163450.GGZBx/qpnclFnMaf7e@fat_crate.local>
 <c8458bfa-0985-f6a5-52a3-ef96c7669fe6@linux.microsoft.com>
 <20230402154425.GCZCmi2eiKYO2yYhNs@fat_crate.local> <877cutsczn.ffs@tglx>
 <8d39a9a1-4b7b-08fe-7b09-2ff0a419468f@linux.microsoft.com>
In-Reply-To: <8d39a9a1-4b7b-08fe-7b09-2ff0a419468f@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/2023 9:56 AM, Jeremi Piotrowski wrote:
> On 4/3/2023 8:20 AM, Thomas Gleixner wrote:
>> On Sun, Apr 02 2023 at 17:44, Borislav Petkov wrote:
>>> On Fri, Mar 24, 2023 at 06:10:09PM +0100, Jeremi Piotrowski wrote:
>>>> Since the AMD PSP is a privileged device, there is a desire to not have to trust the
>>>> ACPI stack,
>>>
>>> And yet you do:
>>>
>>> +	err = acpi_parse_aspt(&res[0], &pdata);
>>> +	if (err)
>>> +		return err;
>>>
>>> You don't trust the ACPI stack, and yet you're parsing an ACPI table?!?!
>>> You have to make up your mind here.
>>>
>>> Btw, you still haven't answered my question about doing:
>>>
>>> 	devm_request_irq(dev, 9, ..)
>>>
>>> where 9 is the default ACPI interrupt.
>>>
>>> You can have some silly table tell you what to map or you can simply map
>>> IRQ 9 and be done with it. In this second case you can *really* not
>>> trust ACPI because you know which IRQ it is
> 
> Will respond to this mail directly.
> 
>>
>> The real problem here is that the information provided about the overall
>> design and requirements is close to zero. All we heard so far is hand
>> waving about not trusting PCI and ACPI.
> 
> That's not a fair characterization Thomas, but I will turn the other cheek.
> 
>>
>> Jeremi, can you please describe exactly what the design and constraints
>> are in understandable and coherent sentences?
>>
> 
> Here goes, I will keep it as simple as I can.
> 
> The goal of these patches is to operate all the hardware interfaces required
> to run AMD SEV-SNP VMs, but in the context of a Linux VM running on top of
> Hyper-V. This Linux VM is called the SNP-host VM. All the patches I submit 
> target the SNP-host VM kernel, which uses KVM to bring up SEV-SNP VMs. To get
> SEV-SNP working you need to combine this work with AMD's KVM SEV-SNP patches.
> I posted two patch sets: one that extends AMD's patches, and one that is
> independent of them (this one here) that could be merged sooner.
> 
> Here are the design constraints:
> 1. the interfaces exposed to the SNP-host VM to operate SEV-SNP match real
>    hardware interface specifications defined by AMD. This is because we are
>    emulating/virtualizing a hardware feature, and not some made up virtual
>    thing.
> 
> 2. the SNP-host VM may run either Windows(Hyper-V) or Linux, so the SEV-SNP
>    interfaces need to be supported by both.
> 
> 3. Hyper-V Generation 2 VMs do not have a PCI bus. The SNP-host VM must be a
>    Hyper-V Gen 2 VM.
> 
> One of the components needed to operate SEV-SNP is the Platform Security
> Processor (PSP), aka AMD Secure Processor (ASP). The PSP is the root-of-trust on
> AMD systems. The PSP is specified as being discoverable either on the PCI bus,
> or through the presence of an ACPI table with the "ASPT" (AMD Secure Processor
> Table) signature.
> 
> Here goes the design:
> Constraint 1 means that only the two specified ways of discovering and
> configuring a PSP inside the SNP-host VM were in the running: PCI or ASPT.
> Constraint 3 means that the PCI version of the PSP is not a viable option.
> Additionally, the ASPT is used on AMD hardware in Microsoft datacenters, which
> means it is supported in Hyper-V (constraint 2). The outcome is that the
> SNP-host VM sees an ASPT.
> 
> The ASPT provides the following information: memory range of PSP registers and
> offsets of individual PSP registers inside that memory range. There are 7
> registers:
> - 6 are related to the "command submission" portion of the PSP; the ccp module
>   knows how to operate those.
> - the last one, "ACPI CmdResp" register, is used to configure the PSP interrupt
>   to the OS.
> 
> The PSP interrupt configuration through the "ACPI CmdResp" register takes the
> following information:
> - APIC ID
> - interrupt vector
> - destination mode (physical/logical)
> - message type (fixed/lowest priority)
> 
> So to hook this up with the Linux device model I wrote patches that do the
> following:
> Detect the ASPT table, extract information and register a "psp" platform_device
> for the "ccp" module to bind to.
> Create an irq_domain and encapsulate dealing with the PSP interrupt register
> there, so that the "ccp" module has an irq number that it passes to
> request_irq().
> 
> There is an "if (hypervisor == Hyper-V)" check before the ASPT table detection.
> Here is the reasoning behind that:
> According to AMD specifications the *same* PSP may be discoverable both through
> ASPT and on the PCI bus. In that case, if the ASPT is to be used the OS is supposed
> to disable the "PCI interface" through the "ACPI CmdResp" register, which will
> result in no PCI-MSI interrupts, BAR writes ignored, BAR reads return all 0xF's.
> I can't verify whether that would work correctly, so in the interest of not
> breaking other users, the ASPT handling is hidden behind the hypervisor check.
> There is nothing Hyper-V specific about any of this code, it supports a hardware
> interface present in server grade hardware and would work on physical hardware if
> when (not if) someone removes the condition.
> 
> That's all there is to it.
> 
> All the other information I gave is background information that I hoped would
> help better understand the setting. The most relevant piece of information is the
> one that I came across last. You asked "what makes this PSP device special". The PSP
> is the root-of-trust on the system, it controls memory encryption keys, it can
> encrypt/decrypt individual memory pages. SEV-SNP ties together a lot of system components
> and requires enabling support for it in the AMD IOMMU too, which is presumably why
> the PSP gets the same special treatment (as the AMD IOMMU). The ASPT and AMD PSP interrupt
> configuration through the "ACPI CmdResp" register is based on a similar design of the AMD IOMMU.
> The AMD IOMMU is:
> - discovered through the presence of the IVRS ACPI table
> - the MMIO address of the IOMMU is parsed out of the IVRS table
> - if x2APIC support is enabled, the IOMMU interrupts are delivered based on
>   programming APIC-ID+vector+destination mode into an interrupt control register
>   in IOMMU MMIO space. This causes any PCI-MSI configuration present for the
>   IOMMU to   be ignored.
> - Linux supports and uses that interrupt delivery mechanism. It is implemented
>   as an irq_domain.
> 
> Do you think it makes sense to include parts of the above description in cover letter
> commit message?
> 
> Thanks,
> Jeremi

Hi Thomas,

Have you had a chance to review this?

Thanks,
Jeremi

