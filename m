Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37166B2476
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCIMpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjCIMpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:45:18 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4965DCA2;
        Thu,  9 Mar 2023 04:45:12 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 8AF89240006;
        Thu,  9 Mar 2023 12:45:06 +0000 (UTC)
Message-ID: <8abfb680-e1dd-8d1f-dd10-0a8bf086f5c3@ghiti.fr>
Date:   Thu, 9 Mar 2023 13:45:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: RISC-V reserved memory problems
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Conor Dooley <conor@kernel.org>
Cc:     Conor.Dooley@microchip.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, frowand.list@gmail.com,
        robh+dt@kernel.org, mick@ics.forth.gr, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, Valentina.FernandezAlanis@microchip.com,
        Daire.McNamara@microchip.com
References: <8e10bf15-9fa9-fe90-1656-35bf3e87e7f8@microchip.com>
 <f8e67f82-103d-156c-deb0-d6d6e2756f5e@microchip.com> <Y9wytv5KSt1ca+td@spud>
 <ZAchb/DfbIh+qaE4@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZAchb/DfbIh+qaE4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/7/23 12:35, Mike Rapoport wrote:
> Hi Conor,
>
> Sorry for the delay, somehow this slipped between the cracks.
>
> On Thu, Feb 02, 2023 at 10:01:26PM +0000, Conor Dooley wrote:
>> Hullo Palmer, Mike & whoever else may read this,
>>
>> Just reviving this thread from a little while ago as I have been in the
>> area again recently...
> TBH, I didn't really dig deep into the issues, but the thought I had was
> what if DT was mapped via fixmap until the setup_vm_final() and then it
> would be possible to call DT methods early.
>
> Could be I'm shooting in the dark :)


I think I understand the issue now, it's because In riscv, we establish 
2 different virtual mappings and we map the device tree at 2 different 
virtual addresses, which is the problem.

So to me, the solution is:

- to revert your previous fix, that is calling 
early_init_fdt_scan_reserved_mem() before any call to memblock_alloc() 
(which could result in an allocation in the area you want to reserve)

- to map the device tree at the same virtual address, because 
early_init_fdt_scan_reserved_mem() initializes reserved_mem with the dtb 
mapping established in setup_vm() and uses reserved_mem with the new 
mapping from setup_vm_final (which is what Mike proposes, we should use 
the fixmap region to have the same virtual addresses)

Hope that makes sense: I'll come up with something this afternoon for 
you to test!

Sorry for the first completely wrong email,

Thanks,

Alex


>   
>> On Tue, Aug 16, 2022 at 08:41:05PM +0000, Conor.Dooley@microchip.com wrote:
>>> Hey all,
>>> We've run into a bit of a problem with reserved memory on PolarFire, or
>>> more accurately a pair of problems that seem to have opposite fixes.
>>>
>>> The first of these problems is triggered when trying to implement a
>>> remoteproc driver. To get the reserved memory buffer, remoteproc
>>> does an of_reserved_mem_lookup(), something like:
>>>
>>> 	np = of_parse_phandle(pdev->of_node, "memory-region", 0);
>>> 	if (!np)
>>> 		return -EINVAL;
>>>
>>> 	rmem = of_reserved_mem_lookup(np);
>>> 	if (!rmem)
>>> 		return -EINVAL;
>>>
>>> of_reserved_mem_lookup() then uses reserved_mem[i].name to try and find
>>> a match - but this was triggering kernel panics for us. We did some
>>> debugging and found that the name string's pointer was pointing to an
>>> address in the 0x4000_0000 range. The minimum reproduction for this
>>> crash is attached - it hacks in some print_reserved_mem()s into
>>> setup_vm_final() around a tlb flush so you can see the before/after.
>>> (You'll need a reserved memory node in your dts to replicate)
>>>
>>> The output is like so, with the same crash as in the remoteproc driver:
>>>
>>> [    0.000000] Linux version 6.0.0-rc1-00001-g0d9d6953d834 (conor@wendy) (riscv64-unknown-linux-gnu-gcc (g5964b5cd727) 11.1.0, GNU ld (GNU Binutils) 2.37) #1 SMP Tue Aug 16 13:42:09 IST 2022
>> [...]
>>
>>> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>>>
>>> We traced this back to early_init_fdt_scan_reserved_mem() in
>>> setup_bootmem() - moving it later back up the boot sequence to
>>> after the dt has been remapped etc has fixed the problem for us.
>>>
>>> The least movement to get it working is attached, and also pushed
>>> here: git.kernel.org/conor/c/1735589baefc
>> This one is fixed now, as of commit 50e63dd8ed92 ("riscv: fix reserved
>> memory setup").
>>
>>> The second problem is a bit more complicated to explain - but we
>>> found the solution conflicted with the remoteproc fix as we had
>>> to move early_init_fdt_scan_reserved_mem() _earlier_ in the boot
>>> process to solve this one.
>>>
>>> We want to have a node in our devicetree that contains some memory
>>> that is non-cached & marked as reserved-memory. Maybe we have just
>>> missed something, but from what we've seen:
>>> - the really early setup looks at the dtb, picks the highest bit
>>>     of memory and puts the dtb etc there so it can start using it
>>> - early_init_fdt_scan_reserved_mem() is then called, which figures
>>>     out if memory is reserved or not.
>>>
>>> Unfortunately, the highest bit of memory is the non-cached bit so
>>> everything falls over, but we can avoid this by moving the call to
>>> early_init_fdt_scan_reserved_mem() above the dtb memblock alloc that
>>> takes place right before it in setup_bootmem().
>>>
>>> Obviously, both of these changes are moving the function call in
>>> opposite directions and we can only really do one of them. We are not
>>> sure if what we are doing with the non-cached reserved-memory section
>>> is just not permitted & cannot work - or if this is something that
>>> was overlooked for RISC-V specifically and works for other archs.
>> We ended up working around this one by making sure that U-Boot loaded
>> the dtb to somewhere that would be inside the kernel's memory map, thus
>> avoiding the remapping in the first place.
>>
>> We did run into another problem recently though, and 50e63dd8ed92 is
>> kinda at fault for it.
>> This particular issue was encountered with a devicetree where the
>> top-most memory region was entirely reserved & was not observed prior
>> to my fix for the first issue.
>>
>> On RISC-V, the boot sequence is something like:
>> 	setup_bootmem();
>> 	setup_vm_final();
>> 	unflatten_device_tree();
>> 	early_init_fdt_scan_reserved_mem();
>>
>> Whereas, before my patch it used to be (give-or-take):
>> 	setup_bootmem();
>> 	early_init_fdt_scan_reserved_mem();
>> 	setup_vm_final();
>> 	unflatten_device_tree();
>>
>> The difference being that we used to have scanned the reserved memory
>> regions before calling setup_vm_final() & therefore know which regions
>> we cannot use. As a reminder, calling early_init_fdt_scan_reserved_mem()
>> before we've got the dt in a proper virtual memory address will cause
>> the kernel to panic if it tries to read a reserved memory node's label.
>>
>> As we are now calling setup_vm_final() *before* we know what the
>> reserved memory regions are & as RISC-V allocates memblocks from the top
>> down, the allocations in setup_vm_final() will be done in the highest
>> memory region.
>> When early_init_fdt_scan_reserved_mem() then tries to reserve the
>> entirety of that top-most memory region, the reservation fails as part
>> of this region has already been allocated.
>> In the scenario where I found this bug, that top-most region is non-
>> cached memory & the kernel ends up panicking.
>> The memblock debug code made this pretty easy to spot, otherwise I'd
>> probably have spent more than just a few hours trying to figure out why
>> it was panicking!
>>
>> My "this needs to be fixed today" solution for this problem was calling
>> memblock_set_bottom_up(true) in setup_bootmem() & that's what we are
>> going to carry downstream for now.
>>
>> I haven't tested it (yet) but I suspect that it would also fix our
>> problem of the dtb being remapped into a non-cached region of memory
>> that we would later go on to reserve too. Non-cached being an issue
>> mainly due to the panicking, but failing to reserve (and using!) memory
>> regions that are meant to be reserved is very far from ideal even when
>> they are memory that the kernel can actually use.
>>
>> I have no idea if that is an acceptable solution for upstream though, so
>> I guess this is me putting out feelers as to whether this is something I
>> should send a patch to do *OR* if this is another sign of the issues
>> that you (Mike, Palmer) mentioned in the past.
>> If it isn't an acceptable solution, I'm not really too sure how to
>> proceed!
>>
>> Cheers,
>> Conor.
>>
>
>
