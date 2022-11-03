Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5C617C24
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiKCMHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKCMHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:07:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9457E12770;
        Thu,  3 Nov 2022 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667477260; x=1699013260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2DlODcOsTLW0fyOz2IK+T+MiYhTj9WLOX3p0sgEZ288=;
  b=ey1C2xA31Ixs4KxTdSYo2rTdH6LZPwb6uYFQCkna7z4qKH56nhat6x62
   jBa6GItGsZ5F7DLbxtdHbILbFsc1xFlglE3dv4ck1sDIsusHfP1pAACPB
   2OL0V6WuinzPmgiFa0k0vZSoOKJH0qgy027OXNKLk20kGROAe+d1rkYzi
   1GsXFWa1A45m2OAu/AdBk3i00VGa40UcDa8UvOiLplZnw7n2ZYxn5f53J
   3BmX9BYBI6atmGE2GIWmiaeFCyHqKIKY2sMruAIbJYHoyzhgH2cC0tzDJ
   F3OBW/GHMqUC94/V5gLaJe2Hl7h+QxW9HSJByDMg0nOy6c13AZv0/4R7z
   w==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="185191671"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Nov 2022 05:07:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 3 Nov 2022 05:07:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 3 Nov 2022 05:07:28 -0700
Date:   Thu, 3 Nov 2022 12:07:12 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Evgenii Shatokhin <e.shatokhin@yadro.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <frowand.list@gmail.com>,
        <robh+dt@kernel.org>, <mick@ics.forth.gr>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Valentina.FernandezAlanis@microchip.com>,
        <Daire.McNamara@microchip.com>, <linux@yadro.com>,
        <heinrich.schuchardt@canonical.com>
Subject: Re: RISC-V reserved memory problems
Message-ID: <Y2Ou8OjB8Ag5oViI@wendy>
References: <8e10bf15-9fa9-fe90-1656-35bf3e87e7f8@microchip.com>
 <f8e67f82-103d-156c-deb0-d6d6e2756f5e@microchip.com>
 <daa4b708-2af7-9179-90ee-e3c800d990bc@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <daa4b708-2af7-9179-90ee-e3c800d990bc@yadro.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 02:46:37PM +0300, Evgenii Shatokhin wrote:
> Hi,
> 
> On 16.08.2022 23:41, Conor.Dooley@microchip.com wrote:
> > Hey all,
> > We've run into a bit of a problem with reserved memory on PolarFire, or
> > more accurately a pair of problems that seem to have opposite fixes.
> > 
> > The first of these problems is triggered when trying to implement a
> > remoteproc driver. To get the reserved memory buffer, remoteproc
> > does an of_reserved_mem_lookup(), something like:
> > 
> > 	np = of_parse_phandle(pdev->of_node, "memory-region", 0);
> > 	if (!np)
> > 		return -EINVAL;
> > 
> > 	rmem = of_reserved_mem_lookup(np);
> > 	if (!rmem)
> > 		return -EINVAL;
> > 
> > of_reserved_mem_lookup() then uses reserved_mem[i].name to try and find
> > a match - but this was triggering kernel panics for us. We did some
> > debugging and found that the name string's pointer was pointing to an
> > address in the 0x4000_0000 range. The minimum reproduction for this
> > crash is attached - it hacks in some print_reserved_mem()s into
> > setup_vm_final() around a tlb flush so you can see the before/after.
> > (You'll need a reserved memory node in your dts to replicate)
> > 
> > The output is like so, with the same crash as in the remoteproc driver:
> > 
> > [    0.000000] Linux version 6.0.0-rc1-00001-g0d9d6953d834 (conor@wendy) (riscv64-unknown-linux-gnu-gcc (g5964b5cd727) 11.1.0, GNU ld (GNU Binutils) 2.37) #1 SMP Tue Aug 16 13:42:09 IST 2022
> > [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> > [    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit
> > [    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020100000 (options '115200n8')
> > [    0.000000] printk: bootconsole [ns16550a0] enabled
> > [    0.000000] printk: debug: skip boot console de-registration.
> > [    0.000000] efi: UEFI not found.
> > [    0.000000] before flush
> > [    0.000000] OF: reserved mem: debug name is fabricbuf@ae000000
> > [    0.000000] after flush
> > [    0.000000] Unable to handle kernel paging request at virtual address 00000000401c31ac
> > [    0.000000] Oops [#1]
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc1-00001-g0d9d6953d834 #1
> > [    0.000000] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
> > [    0.000000] epc : string+0x4a/0xea
> > [    0.000000]  ra : vsnprintf+0x1e4/0x336
> > [    0.000000] epc : ffffffff80335ea0 ra : ffffffff80338936 sp : ffffffff81203be0
> > [    0.000000]  gp : ffffffff812e0a98 tp : ffffffff8120de40 t0 : 0000000000000000
> > [    0.000000]  t1 : ffffffff81203e28 t2 : 7265736572203a46 s0 : ffffffff81203c20
> > [    0.000000]  s1 : ffffffff81203e28 a0 : ffffffff81203d22 a1 : 0000000000000000
> > [    0.000000]  a2 : ffffffff81203d08 a3 : 0000000081203d21 a4 : ffffffffffffffff
> > [    0.000000]  a5 : 00000000401c31ac a6 : ffff0a00ffffff04 a7 : ffffffffffffffff
> > [    0.000000]  s2 : ffffffff81203d08 s3 : ffffffff81203d00 s4 : 0000000000000008
> > [    0.000000]  s5 : ffffffff000000ff s6 : 0000000000ffffff s7 : 00000000ffffff00
> > [    0.000000]  s8 : ffffffff80d9821a s9 : ffffffff81203d22 s10: 0000000000000002
> > [    0.000000]  s11: ffffffff80d9821c t3 : ffffffff812f3617 t4 : ffffffff812f3617
> > [    0.000000]  t5 : ffffffff812f3618 t6 : ffffffff81203d08
> > [    0.000000] status: 0000000200000100 badaddr: 00000000401c31ac cause: 000000000000000d
> > [    0.000000] [<ffffffff80338936>] vsnprintf+0x1e4/0x336
> > [    0.000000] [<ffffffff80055ae2>] vprintk_store+0xf6/0x344
> > [    0.000000] [<ffffffff80055d86>] vprintk_emit+0x56/0x192
> > [    0.000000] [<ffffffff80055ed8>] vprintk_default+0x16/0x1e
> > [    0.000000] [<ffffffff800563d2>] vprintk+0x72/0x80
> > [    0.000000] [<ffffffff806813b2>] _printk+0x36/0x50
> > [    0.000000] [<ffffffff8068af48>] print_reserved_mem+0x1c/0x24
> > [    0.000000] [<ffffffff808057ec>] paging_init+0x528/0x5bc
> > [    0.000000] [<ffffffff808031ae>] setup_arch+0xd0/0x592
> > [    0.000000] [<ffffffff8080070e>] start_kernel+0x82/0x73c
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> > [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> > 
> > We traced this back to early_init_fdt_scan_reserved_mem() in
> > setup_bootmem() - moving it later back up the boot sequence to
> > after the dt has been remapped etc has fixed the problem for us.
> > 
> > The least movement to get it working is attached, and also pushed
> > here: git.kernel.org/conor/c/1735589baefc
> 
> Any updates on this?

"Yes". I /briefly/ chatted with Palmer about this at Plumbers. (see
below). Funny timing from you replying though, I'm planning on spending
the next days/week/weeks trying to sort this whole thing out - it's come
to a head for us.

> I have encountered the same issue with invalid reserved_mem[i].name pointers
> recently, while working on a remoteproc driver for our RISC-V-based SoC.
> 
> I can confirm that "riscv: fix reserved memory setup"
> (git.kernel.org/conor/c/1735589baefc) fixes the issue in our kernel based on
> 5.15.x.

Aye, we're on 5.15 for our vendor tree too so that's where we found the
problem initally.

> Your patch does not seem to have any adverse side-effects either, so:

This patch itself, from what we can see, doesn't have any adverse
side-effects. The other issue that I pointed out in this mail with
reserved memory allocations requires an opposite fix, so there's
something else going on that needs digging into. When I spoke with
Palmer, I said I'd spend the time looking at it but just have not got
around to doing it until now.
I think it may make some sense to try and merge this patch as it at least
makes things better and unblocks people wanting to upstream remoteproc
drivers etc.
And then when I (eventually?) come up with something better maybe it can
build on that.

I'll resend this patch as standalone early next week unless I've somehow
made a breakthrough between now and then.

> Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>

Thanks!

> If there are newer versions or variants of the fix, I'll be glad to test
> them too.

This patch is currently the most recent work I have done, but hopefully
that's going to change.

> By the way, I wonder why arm and aarch64 do not seem to be affected by the
> issue. As far as I can see, these architectures also populate reserved_mem[]
> before switching to the final memory mapping during kernel init. I have not
> dug deep into that though.

Aye, that's at least where I will be starting to do comparisons..

> > The second problem is a bit more complicated to explain - but we
> > found the solution conflicted with the remoteproc fix as we had
> > to move early_init_fdt_scan_reserved_mem() _earlier_ in the boot
> > process to solve this one.
> > 
> > We want to have a node in our devicetree that contains some memory
> > that is non-cached & marked as reserved-memory. Maybe we have just
> > missed something, but from what we've seen:
> > - the really early setup looks at the dtb, picks the highest bit
> >     of memory and puts the dtb etc there so it can start using it
> > - early_init_fdt_scan_reserved_mem() is then called, which figures
> >     out if memory is reserved or not.
> > 
> > Unfortunately, the highest bit of memory is the non-cached bit so
> > everything falls over, but we can avoid this by moving the call to
> > early_init_fdt_scan_reserved_mem() above the dtb memblock alloc that
> > takes place right before it in setup_bootmem().
> > 
> > Obviously, both of these changes are moving the function call in
> > opposite directions and we can only really do one of them. We are not
> > sure if what we are doing with the non-cached reserved-memory section
> > is just not permitted & cannot work - or if this is something that
> > was overlooked for RISC-V specifically and works for other archs.
> > 
> > It does seem like the first issue is a real bug, and I am happy to
> > submit the patch for that whenever - but having two problems with
> > opposite fixes seemed as if there was something else lurking that we
> > just don't have enough understanding to detect.
> > 
> > Any help would be great!

