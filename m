Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232675B5C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiILOsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiILOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:48:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCC024BC1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66D7A61232
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86172C433C1;
        Mon, 12 Sep 2022 14:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662994091;
        bh=OczXXt2JNIRl+b/y4vpwym4Uymlf17H9nX4/vsmsGvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbDi4c3XgYkTgHBIcWDHwlxRvy/KYwSBhWS232DTLYe0LIrC6ZyCMBcMT5NyMihmK
         pli0Qe3Fj1UzS/MnpDjT4uw8vZOFNzLNEYup/tMi0N/W/jltttzPENWlfbY8IpHQsu
         Oq3bZP4Kbqx2zHtlOuhj8g2/P6KRdO8Psv9QXW+QsDCkSTIAa2Vz+Obur08QWhfQ3o
         GRxaP6hKiFUTKVoCM0hGxAH4vXA0baIfTM7mzXmSjXYbmU/DNw8r7KzS1/mtzXHkmg
         raxAnkwX3VfJI/oLnnX/ddQ8oRjOxXKKh/zOqV662GVB2J68aXQdi//aUxrqBx7mBq
         63cYMr0LlLrzw==
Date:   Mon, 12 Sep 2022 15:48:05 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Ash Logan <ash@heyquark.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "j.ne@posteo.net" <j.ne@posteo.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Fragmented physical memory on powerpc/32
Message-ID: <Yx9GpV1XT8r2a++R@kernel.org>
References: <d84e4d24-f350-80fc-6c31-b7e7f8d429f4@heyquark.com>
 <20220520080454.c3cqodsdbfbkmg56@pali>
 <935b426a-6c64-beb0-907f-8c3f0a089ab7@heyquark.com>
 <20220520123002.rd46p5ty6wumi7cc@pali>
 <20220609222420.ponpoodiqmaqtwht@pali>
 <20220808184034.lskqrk6z3gb5q76r@pali>
 <219cda7b-da4b-7a5a-9809-0878e0fc02ba@csgroup.eu>
 <20220908153511.57ceunyusziqfcav@pali>
 <20220908201701.sd3zqn5hfixmjvhh@pali>
 <9fbc5338-5e10-032a-8f55-e080bd93f74b@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fbc5338-5e10-032a-8f55-e080bd93f74b@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 09:39:20AM +0000, Christophe Leroy wrote:
> + Adding Mike who might help if the problem is around memblock.
> 
> Le 08/09/2022 à 22:17, Pali Rohár a écrit :
> > On Thursday 08 September 2022 17:35:11 Pali Rohár wrote:
> >> On Thursday 08 September 2022 15:25:14 Christophe Leroy wrote:
> >>> Le 08/08/2022 à 20:40, Pali Rohár a écrit :
> >>>> On Friday 10 June 2022 00:24:20 Pali Rohár wrote:
> >>>>> On Friday 20 May 2022 14:30:02 Pali Rohár wrote:
> >>>>>> + linux-mm
> >>>>>>
> >>>>>> Do you know what are requirements for kernel to support non-contiguous
> >>>>>> memory support and what is needed to enable it for 32-bit powerpc?
> >>>>>
> >>>>> Any hints?
> >>>>
> >>>> PING?
> >>>>
> >>>
> >>> The tree following patches landed in powerpc/next branch, so they should
> >>> soon be visible in linux-next too:
> >>>
> >>> fc06755e2562 ("powerpc/32: Drop a stale comment about reservation of
> >>> gigantic pages")
> >>> b0e0d68b1c52 ("powerpc/32: Allow fragmented physical memory")
> >>> 0115953dcebe ("powerpc/32: Remove wii_memory_fixups()")
> >>
> >> Ou, nice! I will try to test it if it allows me to access more than 2GB
> >> of RAM from 4GB DDR3 module with 32-bit addressing mode on P2020 CPU.
> > 
> > Hello! Ok, I have tried it from powerpc/next branch, but seems it does
> > not work. I'm getting just early kernel crash.
> > 
> > [    0.000000] CPU maps initialized for 1 thread per core
> > [    0.000000]  (thread shift is 0)
> > [    0.000000] -----------------------------------------------------
> > [    0.000000] phys_mem_size     = 0xbe500000
> > [    0.000000] dcache_bsize      = 0x20
> > [    0.000000] icache_bsize      = 0x20
> > [    0.000000] cpu_features      = 0x0000000010010108
> > [    0.000000]   possible        = 0x0000000010010108
> > [    0.000000]   always          = 0x0000000010010108
> > [    0.000000] cpu_user_features = 0x84e08000 0x08000000
> > [    0.000000] mmu_features      = 0x00020010
> > [    0.000000] -----------------------------------------------------
> > mpc85xx_rdb_setup_arch()
> > [    0.000000] ioremap() called early from of_iomap+0x48/0x80. Use early_ioremap() instead
> > [    0.000000] MPC85xx RDB board from Freescale Semiconductor
> > [    0.000000] barrier-nospec: using isync; sync as speculation barrier
> > [    0.000000] barrier-nospec: patched 182 locations
> > [    0.000000] Top of RAM: 0xff700000, Total RAM: 0xbe500000
> > [    0.000000] Memory hole size: 1042MB
> > [    0.000000] Zone ranges:
> > [    0.000000]   Normal   [mem 0x0000000000000000-0x000000002fffffff]
> > [    0.000000]   HighMem  [mem 0x0000000030000000-0x00000000ff6fffff]
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
> > [    0.000000]   node   0: [mem 0x00000000c0200000-0x00000000eeffffff]
> > [    0.000000]   node   0: [mem 0x00000000f0000000-0x00000000ff6fffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000ff6fffff]
> > [    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
> > [    0.000000] percpu: Embedded 11 pages/cpu s14196 r8192 d22668 u45056
> > [    0.000000] pcpu-alloc: s14196 r8192 d22668 u45056 alloc=11*4096
> > [    0.000000] pcpu-alloc: [0] 0 [0] 1
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 777792
> > [    0.000000] Kernel command line: root=ubi0:rootfs rootfstype=ubifs ubi.mtd=rootfs,2048 rootflags=chk_data_crc rw console=ttyS0,115200
> > [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
> > [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
> > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> > [    0.000000] Kernel attempted to read user page (7df58) - exploit attempt? (uid: 0)
> > [    0.000000] BUG: Unable to handle kernel data access on read at 0x0007df58
> > [    0.000000] Faulting instruction address: 0xc01c8348
> > [    0.000000] Oops: Kernel access of bad area, sig: 11 [#1]
> > [    0.000000] BE PAGE_SIZE=4K SMP NR_CPUS=2 P2020RDB-PC
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc2-0caacb197b677410bdac81bc34f05235+ #121
> > [    0.000000] NIP:  c01c8348 LR: c01cb2bc CTR: 0000000a
> > [    0.000000] REGS: c10d7e20 TRAP: 0300   Not tainted  (6.0.0-rc2-0caacb197b677410bdac81bc34f05235+)
> > [    0.000000] MSR:  00021000 <CE,ME>  CR: 48044224  XER: 00000000
> > [    0.000000] DEAR: 0007df58 ESR: 00000000
> > [    0.000000] GPR00: c01cb294 c10d7f10 c1045340 00000001 00000004 c112bcc0 00000015 eedf1000
> > [    0.000000] GPR08: 00000003 0007df58 00000000 f0000000 28044228 00000200 00000000 00000000
> > [    0.000000] GPR16: 00000000 00000000 00000000 0275cb7a c0000000 00000001 0000075f 00000000
> > [    0.000000] GPR24: c1031004 00000000 00000000 00000001 c10f0000 eedf1000 00080000 00080000
> > [    0.000000] NIP [c01c8348] free_unref_page_prepare.part.93+0x48/0x60
> > [    0.000000] LR [c01cb2bc] free_unref_page+0x84/0x4b8
> > [    0.000000] Call Trace:
> > [    0.000000] [c10d7f10] [eedf1000] 0xeedf1000 (unreliable)
> > [    0.000000] [c10d7f20] [c01cb294] free_unref_page+0x5c/0x4b8
> > [    0.000000] [c10d7f70] [c1007644] mem_init+0xd0/0x194
> > [    0.000000] [c10d7fa0] [c1000e4c] start_kernel+0x4c0/0x6d0
> > [    0.000000] [c10d7ff0] [c00003e0] set_ivor+0x13c/0x178
> > [    0.000000] Instruction dump:
> > [    0.000000] 552817be 5509103a 7d294214 55293830 7d4a4a14 812a003c 814a0038 5529002a
> > [    0.000000] 7c892050 5484c23a 5489eafa 548406fe <7d2a482e> 7d242430 5484077e 90870010
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000]
> > [    0.000000] Kernel panic - not syncing: Fatal exception
> > [    0.000000] Rebooting in 1 seconds..
> > [    0.000000] System Halted, OK to turn off power
> > 
> > 4GB DDR3 SODIMM module is set via Freescale LBC to the whole 4 GB
> > address range. And on ranges:
> > 0x0000_0000 - 0x7fff_ffff
> > 0xc020_0000 - 0xeeff_ffff
> > 0xf000_0000 - 0xff6f_ffff
> > there is no peripheral device, they are free for DRAM. Between these
> > physical ranges are mapped peripheral devices (PCIe and NOR).
> > 
> > Any idea if I'm doing something wrong or there can be a bug in memory code?
> > 
> > Quite suspicious is that "Initmem setup node 0" prints one range where
> > are also peripherals, not just DRAM. Crash is on address 0xc01c8348
> > which belongs to PCIe.
> > 
> 
> Yes I also find that "Initmem setup node 0" suspicious.
> 
> However the crash address 0xc01c8348 is valid kernel address. That's a 
> virtual address, not a physical address, so that's not PCIe. That's 
> kernel linear mapping, so that's likely physical address 0x001c8348 
> offseted by PAGE_OFFSET which is 0xc0000000.

If I read the dump correctly, 0xc01c8348 is the PC of the instruction that
crashed and the access was to 0x0007df58 which seem to well inside
0x0000_0000 - 0x7fff_ffff range.

And the "Early memory node ranges" look consistent with the memory layout
above.

My guess would be that something went wrong in the linear map setup, but it
won't hurt running with "memblock=debug" added to the kernel command line
to see if there is anything suspicious there.
 
> Do you have a way to reproduce this problem under QEMU ?
> 
> Thanks
> Christophe

-- 
Sincerely yours,
Mike.
