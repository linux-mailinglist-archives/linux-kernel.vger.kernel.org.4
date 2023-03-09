Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F3F6B2431
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCIMbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCIMbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:31:35 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1710ED0F6;
        Thu,  9 Mar 2023 04:31:30 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 6B9791C0005;
        Thu,  9 Mar 2023 12:31:25 +0000 (UTC)
Message-ID: <8ed31c81-e6fd-a293-8418-5d0d863c7735@ghiti.fr>
Date:   Thu, 9 Mar 2023 13:31:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: RISC-V reserved memory problems
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Conor.Dooley@microchip.com, linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, robh+dt@kernel.org, mick@ics.forth.gr,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Valentina.FernandezAlanis@microchip.com,
        Daire.McNamara@microchip.com
References: <8e10bf15-9fa9-fe90-1656-35bf3e87e7f8@microchip.com>
 <f8e67f82-103d-156c-deb0-d6d6e2756f5e@microchip.com>
 <fadac048-c648-6493-3f1c-1877692180c8@ghiti.fr>
In-Reply-To: <fadac048-c648-6493-3f1c-1877692180c8@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/23 11:30, Alexandre Ghiti wrote:
> Hi Conor,
>
> On 8/16/22 22:41, Conor.Dooley@microchip.com wrote:
>> Hey all,
>> We've run into a bit of a problem with reserved memory on PolarFire, or
>> more accurately a pair of problems that seem to have opposite fixes.
>>
>> The first of these problems is triggered when trying to implement a
>> remoteproc driver. To get the reserved memory buffer, remoteproc
>> does an of_reserved_mem_lookup(), something like:
>>
>>     np = of_parse_phandle(pdev->of_node, "memory-region", 0);
>>     if (!np)
>>         return -EINVAL;
>>
>>     rmem = of_reserved_mem_lookup(np);
>>     if (!rmem)
>>         return -EINVAL;
>>
>> of_reserved_mem_lookup() then uses reserved_mem[i].name to try and find
>> a match - but this was triggering kernel panics for us. We did some
>> debugging and found that the name string's pointer was pointing to an
>> address in the 0x4000_0000 range. The minimum reproduction for this
>
>
> 0x4000_0000 corresponds to DTB_EARLY_BASE_VA: this is the address that 
> is used to map the dtb before we can access it using the linear mapping.
>
>
>> crash is attached - it hacks in some print_reserved_mem()s into
>> setup_vm_final() around a tlb flush so you can see the before/after.
>> (You'll need a reserved memory node in your dts to replicate)
>>
>> The output is like so, with the same crash as in the remoteproc driver:
>>
>> [    0.000000] Linux version 6.0.0-rc1-00001-g0d9d6953d834 
>> (conor@wendy) (riscv64-unknown-linux-gnu-gcc (g5964b5cd727) 11.1.0, 
>> GNU ld (GNU Binutils) 2.37) #1 SMP Tue Aug 16 13:42:09 IST 2022
>> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
>> [    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit
>> [    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020100000 
>> (options '115200n8')
>> [    0.000000] printk: bootconsole [ns16550a0] enabled
>> [    0.000000] printk: debug: skip boot console de-registration.
>> [    0.000000] efi: UEFI not found.
>> [    0.000000] before flush
>> [    0.000000] OF: reserved mem: debug name is fabricbuf@ae000000
>> [    0.000000] after flush
>> [    0.000000] Unable to handle kernel paging request at virtual 
>> address 00000000401c31ac
>
>
> You take the trap here because the mapping for the dtb does not exist 
> in swapper_pg_dir, but you don't need this mapping anymore as you can 
> access the device tree through the linear mapping now.


You can forget everything below, I was completely wrong. I'll follow up 
on Mike's answer.


>
> I would say that: you build your kernel with CONFIG_BUILTIN_DTB and 
> then you don't call early_init_dt_verify which resets 
> initial_boot_params to the linear mapping address (it was initially 
> set to 0x4000_0000 in parse_dtb). If that's the case, does the 
> following fix your issue?
>
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 376d2827e736..2b09f0bd8432 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -276,6 +276,7 @@ void __init setup_arch(char **cmdline_p)
>         efi_init();
>         paging_init();
>  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
> +       initial_boot_params = __va(XIP_FIXUP(dtb_early_pa));
>         unflatten_and_copy_device_tree();
>  #else
>         if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
>
>
>> [    0.000000] Oops [#1]
>> [    0.000000] Modules linked in:
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 
>> 6.0.0-rc1-00001-g0d9d6953d834 #1
>> [    0.000000] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
>> [    0.000000] epc : string+0x4a/0xea
>> [    0.000000]  ra : vsnprintf+0x1e4/0x336
>> [    0.000000] epc : ffffffff80335ea0 ra : ffffffff80338936 sp : 
>> ffffffff81203be0
>> [    0.000000]  gp : ffffffff812e0a98 tp : ffffffff8120de40 t0 : 
>> 0000000000000000
>> [    0.000000]  t1 : ffffffff81203e28 t2 : 7265736572203a46 s0 : 
>> ffffffff81203c20
>> [    0.000000]  s1 : ffffffff81203e28 a0 : ffffffff81203d22 a1 : 
>> 0000000000000000
>> [    0.000000]  a2 : ffffffff81203d08 a3 : 0000000081203d21 a4 : 
>> ffffffffffffffff
>> [    0.000000]  a5 : 00000000401c31ac a6 : ffff0a00ffffff04 a7 : 
>> ffffffffffffffff
>> [    0.000000]  s2 : ffffffff81203d08 s3 : ffffffff81203d00 s4 : 
>> 0000000000000008
>> [    0.000000]  s5 : ffffffff000000ff s6 : 0000000000ffffff s7 : 
>> 00000000ffffff00
>> [    0.000000]  s8 : ffffffff80d9821a s9 : ffffffff81203d22 s10: 
>> 0000000000000002
>> [    0.000000]  s11: ffffffff80d9821c t3 : ffffffff812f3617 t4 : 
>> ffffffff812f3617
>> [    0.000000]  t5 : ffffffff812f3618 t6 : ffffffff81203d08
>> [    0.000000] status: 0000000200000100 badaddr: 00000000401c31ac 
>> cause: 000000000000000d
>> [    0.000000] [<ffffffff80338936>] vsnprintf+0x1e4/0x336
>> [    0.000000] [<ffffffff80055ae2>] vprintk_store+0xf6/0x344
>> [    0.000000] [<ffffffff80055d86>] vprintk_emit+0x56/0x192
>> [    0.000000] [<ffffffff80055ed8>] vprintk_default+0x16/0x1e
>> [    0.000000] [<ffffffff800563d2>] vprintk+0x72/0x80
>> [    0.000000] [<ffffffff806813b2>] _printk+0x36/0x50
>> [    0.000000] [<ffffffff8068af48>] print_reserved_mem+0x1c/0x24
>> [    0.000000] [<ffffffff808057ec>] paging_init+0x528/0x5bc
>> [    0.000000] [<ffffffff808031ae>] setup_arch+0xd0/0x592
>> [    0.000000] [<ffffffff8080070e>] start_kernel+0x82/0x73c
>> [    0.000000] ---[ end trace 0000000000000000 ]---
>> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle 
>> task!
>> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill 
>> the idle task! ]---
>>
>> We traced this back to early_init_fdt_scan_reserved_mem() in
>> setup_bootmem() - moving it later back up the boot sequence to
>> after the dt has been remapped etc has fixed the problem for us.
>>
>> The least movement to get it working is attached, and also pushed
>> here: git.kernel.org/conor/c/1735589baefc
>>
>> The second problem is a bit more complicated to explain - but we
>> found the solution conflicted with the remoteproc fix as we had
>> to move early_init_fdt_scan_reserved_mem() _earlier_ in the boot
>> process to solve this one.
>>
>> We want to have a node in our devicetree that contains some memory
>> that is non-cached & marked as reserved-memory. Maybe we have just
>> missed something, but from what we've seen:
>> - the really early setup looks at the dtb, picks the highest bit
>>     of memory and puts the dtb etc there so it can start using it
>> - early_init_fdt_scan_reserved_mem() is then called, which figures
>>     out if memory is reserved or not.
>>
>> Unfortunately, the highest bit of memory is the non-cached bit so
>> everything falls over, but we can avoid this by moving the call to
>> early_init_fdt_scan_reserved_mem() above the dtb memblock alloc that
>> takes place right before it in setup_bootmem().
>
>
> And then I suppose the allocations you are mentioning happen in 
> unflatten_XXX, so parsing the device tree for reserved memory nodes 
> before this should do the trick. Does the following fix your second 
> issue?
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2b09f0bd8432..94b3d049fe9d 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -277,14 +277,15 @@ void __init setup_arch(char **cmdline_p)
>         paging_init();
>  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
>         initial_boot_params = __va(XIP_FIXUP(dtb_early_pa));
> +       early_init_fdt_scan_reserved_mem();
>         unflatten_and_copy_device_tree();
>  #else
> -       if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> +       if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa)))) {
> +               early_init_fdt_scan_reserved_mem();
>                 unflatten_device_tree();
> -       else
> +       } else
>                 pr_err("No DTB found in kernel mappings\n");
>  #endif
> -       early_init_fdt_scan_reserved_mem();
>         misc_mem_init();
>
>         init_resources();
>
>
>
>>
>> Obviously, both of these changes are moving the function call in
>> opposite directions and we can only really do one of them. We are not
>> sure if what we are doing with the non-cached reserved-memory section
>> is just not permitted & cannot work - or if this is something that
>> was overlooked for RISC-V specifically and works for other archs.
>>
>> It does seem like the first issue is a real bug, and I am happy to
>> submit the patch for that whenever - but having two problems with
>> opposite fixes seemed as if there was something else lurking that we
>> just don't have enough understanding to detect.
>>
>> Any help would be great!
>>
>> Thanks,
>> Conor.
>>
>
> Even if that does not fix your issue, the first patch is necessary as 
> it fixes initial_boot_params.
>
>
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
