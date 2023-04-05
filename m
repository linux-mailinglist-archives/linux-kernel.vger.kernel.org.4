Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BE06D7689
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbjDEILv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbjDEILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:11:32 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DC2149D8;
        Wed,  5 Apr 2023 01:11:14 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id EDD69210DECB;
        Wed,  5 Apr 2023 01:10:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EDD69210DECB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680682261;
        bh=dOEo2EG+hg+F81Lh9lwEURZ0dL7IZCs7WplCBPaibvo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YC8cjMJ20KxMNhpu8rYiufuNP1UOoAx+dj565ZmzCfHdtTygT+Tx/FCmslVgL76R4
         /uTKCk2TSXlGpvDPp/mb36P1ZniAUsgYM5srfr+ZsKiQ0I7Mf7hMuiLZ8uuQ1F6M8q
         bcxqRa5cWCqV/eThGBPjjg96SP7QR9wsD2CVeGH8=
Message-ID: <35f6b321-1668-2b62-cb47-3f3760be2e1d@linux.microsoft.com>
Date:   Wed, 5 Apr 2023 10:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 0/8] Support ACPI PSP on Hyper-V
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
Content-Language: en-US
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <877cutsczn.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2023 8:20 AM, Thomas Gleixner wrote:
> On Sun, Apr 02 2023 at 17:44, Borislav Petkov wrote:
>> On Fri, Mar 24, 2023 at 06:10:09PM +0100, Jeremi Piotrowski wrote:
>>> Since the AMD PSP is a privileged device, there is a desire to not have to trust the
>>> ACPI stack,
>>
>> And yet you do:
>>
>> +	err = acpi_parse_aspt(&res[0], &pdata);
>> +	if (err)
>> +		return err;
>>
>> You don't trust the ACPI stack, and yet you're parsing an ACPI table?!?!
>> You have to make up your mind here.

I gave you background on why Microsoft system designers like to use the ASPT on
*physical hardware* in our datacenters. It is because it allows them to setup a
highly privileged system component through an isolated ACPI table, without
needing to depend on the *rest of the ACPI stack* (other ACPI tables and/or the
ACPI interpreter). The same reason they use IVRS for AMD IOMMU.

I thought it might be good to write this down, as this shows that the ASPT is a
hardware interface that has *some* value. I don't think further discussion on
this point helps us make forward progress.

We're trying to adhere to a specification for a physical device when modeling
that same device in a virtual environment. Yes, this requires parsing an ACPI
table.

>> 
>> Btw, you still haven't answered my question about doing:
>>
>> 	devm_request_irq(dev, 9, ..)
>>
>> where 9 is the default ACPI interrupt.
>>
>> You can have some silly table tell you what to map or you can simply map
>> IRQ 9 and be done with it. In this second case you can *really* not
>> trust ACPI because you know which IRQ it is.
> 

So I originally thought I answered when i said "because we're trying to not
deviate from the hardware specification for the PSP". Interrupt configuration
is part of that specification.

But when I think about what you're suggesting, I can interpret it two ways:

1. Configure the PSP to raise the vector corresponding to ACPI IRQ 9.
This might work and would look similar to the first version I posted.
I'd fetch 'struct irq_cfg' for acpi_sci_irq, write the corresponding
APIC-ID/vector into the PSP, enable PSP interrupt generation and then
probe the "ccp" driver so that it can call "devm_request_irq(9)".
I assume this would also require registering an irq affinity notifier,
much like drivers/iommu/amd/init.c did before commit d1adcfbb520c.

2. Deviate from the hardware specification.
From reading acpi code (not at all an expert on this), that "9" does not
look like a static value to me, so it requires either:
a) passing a GSI number in an ACPI table
b) defining it as being the same interrupt as the SCI, which comes from
   the FADT table.
c) using the GPE mechanism of the ACPI SCI interrupt.

So I'd need to define a third way for the PSP to interrupt the OS, one that
would only be supported on Hyper-V. Work with our hypervisor and/or virtual
firmware teams to make sure that the PSP model supports generating the interrupt
in this way. Work with the Windows team to make Windows support it
(the same virtual hardware model/virtual firmware is used regardless of the OS).

I have no objection to doing "1." if it works. I don't see it as a big win over
using an irq_domain.

I don't think "2." is a reasonable thing to ask. We do regularly make suggestions
to hypervisor/firmware teams on how to make things better supported in Linux
without requiring hacks. But modelling a piece of hardware in a custom way to avoid
following hardware specs is questionable.

I also think that soon, when other people deploy more SEV-SNP hardware in their
datacenters, they will also want to rely on the ASPT for the reasons listed at the
top of the email, so we'll be adding support for it anyway.

Which way do you suggest we go Boris? I'm not attached to the code at all but I am
attached to adhering to hardware specifications. I can try to do "1." or stick with
the irq_domain approach that i posted.

Thanks,
Jeremi
