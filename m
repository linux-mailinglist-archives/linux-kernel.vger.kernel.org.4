Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D16963151E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 17:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKTQQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 11:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKTQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 11:16:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403913EAB
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 08:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EB0860C7B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10410C433C1;
        Sun, 20 Nov 2022 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668960999;
        bh=xexD/v5Ikj6l+7RpJRRz2qX++2lJnq96FKNcBbLX/qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxjyJakpxzPO2Ll29CJzJbeaqKu1/65SC4pvi6bd+OSENQInxMOKL6/ZLKIPvCdYL
         Kw9+TCP5bTYpzSgSJWlRsq6cUWy49BJCPXrVQcokWyv2rON7j0K8nZwyF2zAl16P89
         bqsbThunh1Jv+4FoMkPpVnb9N90Zh0zaXbUodFwdARbzhAZ3ZDYSXsRC4SZzNEKdbq
         h4P8Jk5WQdqGyd8KWU9cWWkMWzkrKE3wGCwR/WuAfDaw9cjfW736fNUnanK+DTNdTL
         nZ0BBDhECE1DOIluNW+A540ozpmct1wIi+fnWugiCyPo1XB1D4KQTgz+j2XF3NEBw6
         wZlcWQ6HAVyyw==
Date:   Sun, 20 Nov 2022 09:16:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
Message-ID: <Y3pS5fdZ3MdLZ00t@dev-arch.thelio-3990X>
References: <20221118053102.500216-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VK0j3asLlQC6tjFs"
Content-Disposition: inline
In-Reply-To: <20221118053102.500216-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VK0j3asLlQC6tjFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anshuman,

On Fri, Nov 18, 2022 at 11:01:02AM +0530, Anshuman Khandual wrote:
> __create_pgd_mapping_locked() expects a page allocator used while mapping a
> virtual range. This page allocator function propagates down the call chain,
> while building intermediate levels in the page table. Passed page allocator
> is a necessary ingredient required to build the page table but its presence
> can be asserted just once in the very beginning rather than in all the down
> stream functions. This consolidates BUG_ON(!pgtable_alloc) checks just in a
> single place i.e __create_pgd_mapping_locked().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.1-rc5
> 
>  arch/arm64/mm/mmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 5a19950e7289..97ca82001089 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -207,7 +207,6 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  
>  		if (flags & NO_EXEC_MAPPINGS)
>  			pmdval |= PMD_TABLE_PXN;
> -		BUG_ON(!pgtable_alloc);
>  		pte_phys = pgtable_alloc(PAGE_SHIFT);
>  		__pmd_populate(pmdp, pte_phys, pmdval);
>  		pmd = READ_ONCE(*pmdp);
> @@ -285,7 +284,6 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  
>  		if (flags & NO_EXEC_MAPPINGS)
>  			pudval |= PUD_TABLE_PXN;
> -		BUG_ON(!pgtable_alloc);
>  		pmd_phys = pgtable_alloc(PMD_SHIFT);
>  		__pud_populate(pudp, pmd_phys, pudval);
>  		pud = READ_ONCE(*pudp);
> @@ -324,7 +322,6 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  
>  		if (flags & NO_EXEC_MAPPINGS)
>  			p4dval |= P4D_TABLE_PXN;
> -		BUG_ON(!pgtable_alloc);
>  		pud_phys = pgtable_alloc(PUD_SHIFT);
>  		__p4d_populate(p4dp, pud_phys, p4dval);
>  		p4d = READ_ONCE(*p4dp);
> @@ -383,6 +380,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>  	phys &= PAGE_MASK;
>  	addr = virt & PAGE_MASK;
>  	end = PAGE_ALIGN(virt + size);
> +	BUG_ON(!pgtable_alloc);
>  
>  	do {
>  		next = pgd_addr_end(addr, end);
> -- 
> 2.25.1
> 
> 

I just bisected a boot failure in our QEMU-based continuous integration
setup to this change as commit 9ed2b4616d4e ("arm64/mm: Drop redundant
BUG_ON(!pgtable_alloc)") in the arm64 tree. There is no output so the
panic clearly happens early at boot. If I move back to the previous
commit and add a WARN_ON() like so:

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d386033a074c..9280a92ff920 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -383,6 +383,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 	phys &= PAGE_MASK;
 	addr = virt & PAGE_MASK;
 	end = PAGE_ALIGN(virt + size);
+	WARN_ON(!pgtable_alloc);
 
 	do {
 		next = pgd_addr_end(addr, end);

I do see some stacktraces. I have attached the boot log from QEMU.

If there is any additional information I can provide or patches I can
test, I am more than happy to do so.

Cheers,
Nathan

# bad: [2ed6cab9589d7829fc38237dcca94c776304a8bd] Merge branches 'for-next/acpi', 'for-next/asm-const', 'for-next/cpufeature', 'for-next/dynamic-scs', 'for-next/errata', 'for-next/fpsimd', 'for-next/ftrace', 'for-next/insn', 'for-next/kbuild', 'for-next/kdump', 'for-next/mm', 'for-next/perf', 'for-next/selftests', 'for-next/stacks', 'for-next/trivial', 'for-next/uaccess' and 'for-next/undef-traps' into for-next/core
# good: [f0c4d9fc9cc9462659728d168387191387e903cc] Linux 6.1-rc4
git bisect start '2ed6cab9589d7829fc38237dcca94c776304a8bd' 'v6.1-rc4'
# bad: [5b468dad6e5cf4998bdc05efbc5526c111666027] arm64/mm: Drop unused restore_ttbr1
git bisect bad 5b468dad6e5cf4998bdc05efbc5526c111666027
# good: [657eef0a5420a02c02945ed8c87f2ddcbd255772] arm64: atomics: lse: remove stale dependency on JUMP_LABEL
git bisect good 657eef0a5420a02c02945ed8c87f2ddcbd255772
# bad: [9ed2b4616d4e846ece2a04cb5007ce1d1bd9e3f3] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
git bisect bad 9ed2b4616d4e846ece2a04cb5007ce1d1bd9e3f3
# good: [d8c1d798a2e5091128c391c6dadcc9be334af3f5] arm64: make is_ttbrX_addr() noinstr-safe
git bisect good d8c1d798a2e5091128c391c6dadcc9be334af3f5
# first bad commit: [9ed2b4616d4e846ece2a04cb5007ce1d1bd9e3f3] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)

--VK0j3asLlQC6tjFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot.log"

$ timeout --foreground 30s stdbuf -oL -eL qemu-system-aarch64 -machine virt,gic-version=max -cpu max,pauth-impdef=true -machine virtualization=true -kernel /home/nathan/cbl/worktrees/arm64-boot-failure/arch/arm64/boot/Image.gz -append "console=ttyAMA0 earlycon" -display none -initrd /home/nathan/cbl/github/boot-utils-ro/images/arm64/rootfs.cpio -m 512m -nodefaults -no-reboot -serial mon:stdio
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm64/mm/mmu.c:386 create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc4-00008-gd8c1d798a2e5-dirty #1
[    0.000000] pstate: 400001c5 (nZcv dAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.000000] lr : __create_pgd_mapping+0x6c/0x90
[    0.000000] sp : ffffacf6277f3cd0
[    0.000000] x29: ffffacf6277f3cd0 x28: ffffacf627c28fb8 x27: 0000000000000000
[    0.000000] x26: 0000000000000002 x25: 0000000000000002 x24: 0068000000000703
[    0.000000] x23: fffffbfffdc00000 x22: fffffbfffdc00000 x21: fffffbfffde00000
[    0.000000] x20: ffffacf627c28000 x19: ffffacf627808708 x18: 0000000000000000
[    0.000000] x17: 000000040044ffff x16: 005000f5b5503510 x15: 0000000000000000
[    0.000000] x14: 0000000000000000 x13: 0000000c00000101 x12: ffff80000a322920
[    0.000000] x11: ffffacf625800000 x10: 00000000421ec008 x9 : 00000000000001f7
[    0.000000] x8 : fffffbffb5a00000 x7 : 0000000000000000 x6 : 0000000000000002
[    0.000000] x5 : 0000000000000000 x4 : 0068000000000703 x3 : fffffbfffde00fff
[    0.000000] x2 : fffffbfffdc00000 x1 : 0000000048600000 x0 : 0000000048600000
[    0.000000] Call trace:
[    0.000000]  create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.000000]  __create_pgd_mapping+0x6c/0x90
[    0.000000]  fixmap_remap_fdt+0x78/0x100
[    0.000000]  early_fdt_map+0x58/0x8c
[    0.000000]  __primary_switched+0xa4/0xc4
[    0.000000]  0x411cc440
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.1.0-rc4-00008-gd8c1d798a2e5-dirty (nathan@dev-arch.thelio-3990X) (aarch64-linux-gnu-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP PREEMPT Sun Nov 20 07:19:49 MST 2022
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm64/mm/mmu.c:386 create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.1.0-rc4-00008-gd8c1d798a2e5-dirty #1
[    0.000000] pstate: 400001c9 (nZcv dAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.000000] lr : __create_pgd_mapping+0x6c/0x90
[    0.000000] sp : ffffacf6277f3bf0
[    0.000000] x29: ffffacf6277f3bf0 x28: ffffacf627c28fb8 x27: 0000000000000000
[    0.000000] x26: 0000000000000002 x25: 0000000000000002 x24: 0068000000000703
[    0.000000] x23: fffffbfffdc00000 x22: fffffbfffdc00000 x21: fffffbfffde00000
[    0.000000] x20: ffffacf627c28000 x19: ffffacf627808708 x18: ffffacf626ffc568
[    0.000000] x17: ffffacf626ffc548 x16: ffffacf626ffc528 x15: ffffacf626ffc508
[    0.000000] x14: ffffacf626ffc4e8 x13: ffffacf626ffc4c8 x12: ffffacf626ffc4a8
[    0.000000] x11: ffffacf626ffc488 x10: ffffacf626ffc468 x9 : 00000000000001f7
[    0.000000] x8 : fffffbffb5a00000 x7 : fffffbfffdab8000 x6 : 0000000000000002
[    0.000000] x5 : 0000000000000000 x4 : 0068000000000703 x3 : fffffbfffde00fff
[    0.000000] x2 : fffffbfffdc00000 x1 : 0000000048600000 x0 : 0000000048600000
[    0.000000] Call trace:
[    0.000000]  create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.000000]  __create_pgd_mapping+0x6c/0x90
[    0.000000]  fixmap_remap_fdt+0x78/0x100
[    0.000000]  setup_arch+0xb0/0x598
[    0.000000]  start_kernel+0x88/0x6ac
[    0.000000]  __primary_switched+0xbc/0xc4
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] random: crng init done
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm64/mm/mmu.c:386 create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.1.0-rc4-00008-gd8c1d798a2e5-dirty #1
[    0.000000] pstate: 400001c9 (nZcv dAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.000000] lr : __create_pgd_mapping+0x6c/0x90
[    0.000000] sp : ffffacf6277f3bf0
[    0.000000] x29: ffffacf6277f3bf0 x28: ffffacf627c28fb8 x27: 0000000000000000
[    0.000000] x26: 0000000000000002 x25: 0000000000000002 x24: 0060000000000783
[    0.000000] x23: fffffbfffdc00000 x22: fffffbfffdc00000 x21: fffffbfffde00000
[    0.000000] x20: ffffacf627c28000 x19: ffffacf627808708 x18: 000000002bae83d6
[    0.000000] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000001c00
[    0.000000] x14: 0000000000001000 x13: fffffbfffdc00000 x12: ffffacf6277f3ce4
[    0.000000] x11: 0000000000001bc0 x10: ffffacf6277f3c84 x9 : 00000000000001f7
[    0.000000] x8 : fffffbffb5a00000 x7 : fffffbfffdc00000 x6 : 0000000000000002
[    0.000000] x5 : 0000000000000000 x4 : 0060000000000783 x3 : fffffbfffde00fff
[    0.000000] x2 : fffffbfffdc00000 x1 : 0000000048600000 x0 : 0000000048600000
[    0.000000] Call trace:
[    0.000000]  create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.000000]  __create_pgd_mapping+0x6c/0x90
[    0.000000]  fixmap_remap_fdt+0x78/0x100
[    0.000000]  setup_arch+0x120/0x598
[    0.000000]  start_kernel+0x88/0x6ac
[    0.000000]  __primary_switched+0xbc/0xc4
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Machine model: linux,dummy-virt
[    0.000000] efi: UEFI not found.
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x5fef0a00-0x5fef2fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] cma: Reserved 32 MiB at 0x000000005d600000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 20 pages/cpu s44840 r8192 d28888 u81920
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Address authentication (IMP DEF algorithm)
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Hardware dirty bit management
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 129024
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: console=ttyAMA0 earlycon
[    0.000000] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] Memory: 439088K/524288K available (16128K kernel code, 3706K rwdata, 8856K rodata, 7552K init, 609K bss, 52432K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=1.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 224 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: GICv4 features: 
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000080a0000
[    0.000000] ITS [mem 0x08080000-0x0809ffff]
[    0.000000] ITS@0x0000000008080000: Single VMOVP capable
[    0.000000] ITS@0x0000000008080000: allocated 8192 Devices @42830000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x0000000008080000: allocated 8192 Interrupt Collections @42840000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x0000000008080000: allocated 8192 Virtual CPUs @42850000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000042860000
[    0.000000] ITS: Allocated DevID ffff as GICv4 proxy device (2 slots)
[    0.000000] ITS: Enabling GICv4 support
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000042870000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 62.50MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
[    0.000066] sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096ns
[    0.013044] Console: colour dummy device 80x25
[    0.018251] Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=250000)
[    0.018963] pid_max: default: 32768 minimum: 301
[    0.019933] LSM: Security Framework initializing
[    0.023092] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.023274] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.049816] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.054883] cblist_init_generic: Setting adjustable number of callback queues.
[    0.055172] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.055600] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.056958] rcu: Hierarchical SRCU implementation.
[    0.057077] rcu: 	Max phase no-delay instances is 1000.
[    0.061143] Platform MSI: its@8080000 domain created
[    0.061641] PCI/MSI: /intc@8000000/its@8080000 domain created
[    0.062252] fsl-mc MSI: its@8080000 domain created
[    0.065264] EFI services will not be available.
[    0.065970] smp: Bringing up secondary CPUs ...
[    0.066130] smp: Brought up 1 node, 1 CPU
[    0.066224] SMP: Total of 1 processors activated.
[    0.066471] CPU features: detected: Branch Target Identification
[    0.066616] CPU features: detected: 32-bit EL0 Support
[    0.066721] CPU features: detected: 32-bit EL1 Support
[    0.066815] CPU features: detected: ARMv8.4 Translation Table Level
[    0.066950] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.067129] CPU features: detected: Common not Private translations
[    0.067241] CPU features: detected: CRC32 instructions
[    0.067334] CPU features: detected: E0PD
[    0.067449] CPU features: detected: Generic authentication (IMP DEF algorithm)
[    0.067908] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.068023] CPU features: detected: LSE atomic instructions
[    0.068123] CPU features: detected: Privileged Access Never
[    0.068222] CPU features: detected: RAS Extension Support
[    0.068319] CPU features: detected: Random Number Generator
[    0.068418] CPU features: detected: Speculation barrier (SB)
[    0.068518] CPU features: detected: Stage-2 Force Write-Back
[    0.068619] CPU features: detected: TLB range maintenance instructions
[    0.068760] CPU features: detected: Scalable Matrix Extension
[    0.068863] CPU features: detected: FA64
[    0.068936] CPU features: detected: Speculative Store Bypassing Safe (SSBS)
[    0.069055] CPU features: detected: Scalable Vector Extension
[    0.076940] SVE: maximum available vector length 256 bytes per vector
[    0.079575] SVE: default vector length 64 bytes per vector
[    0.081070] SME: minimum available vector length 16 bytes per vector
[    0.081200] SME: maximum available vector length 256 bytes per vector
[    0.081318] SME: default vector length 32 bytes per vector
[    0.081632] CPU: All CPU(s) started at EL2
[    0.081736] alternatives: applying system-wide alternatives
[    0.099081] ------------[ cut here ]------------
[    0.099322] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/mmu.c:386 create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.100202] Modules linked in:
[    0.100797] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.1.0-rc4-00008-gd8c1d798a2e5-dirty #1
[    0.101096] Hardware name: linux,dummy-virt (DT)
[    0.101305] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.101560] pc : create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.101674] lr : update_mapping_prot+0x7c/0x130
[    0.101777] sp : ffff80000800bca0
[    0.101854] x29: ffff80000800bca0 x28: ffffacf627081000 x27: 0000000000000000
[    0.102107] x26: 0000000000000000 x25: 0000000000000002 x24: ffffacf627081000
[    0.102259] x23: ffff000000210000 x22: 0060000000000783 x21: ffff000001a90000
[    0.102409] x20: ffffacf627808708 x19: ffff000000210000 x18: 0000000000000006
[    0.102573] x17: 687469726f676c61 x16: 2046454420504d49 x15: ffff80000800b930
[    0.102727] x14: 00000000000002da x13: 00000000000002da x12: 0000000000000000
[    0.102884] x11: 000000000000000f x10: 26dd6ca7b86b0997 x9 : 0000000000000000
[    0.103053] x8 : ffff000040000000 x7 : ffff00001fed0cc0 x6 : 0000000000000002
[    0.103205] x5 : 0000000000000000 x4 : 0060000000000783 x3 : ffff000001a90fff
[    0.103356] x2 : ffff000000210000 x1 : 0000000040210000 x0 : 0000000040210000
[    0.103581] Call trace:
[    0.103720]  create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.103909]  update_mapping_prot+0x7c/0x130
[    0.104015]  mark_linear_text_alias_ro+0x64/0x70
[    0.104114]  smp_cpus_done+0xac/0xb8
[    0.104202]  smp_init+0x7c/0x8c
[    0.104272]  kernel_init_freeable+0x138/0x284
[    0.104363]  kernel_init+0x24/0x12c
[    0.104442]  ret_from_fork+0x10/0x20
[    0.104598] ---[ end trace 0000000000000000 ]---
[    0.130808] devtmpfs: initialized
[    0.145964] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.146545] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.151391] pinctrl core: initialized pinctrl subsystem
[    0.160991] DMI not present or invalid.
[    0.168534] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.177634] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
[    0.178242] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.178581] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.178917] audit: initializing netlink subsys (disabled)
[    0.184508] thermal_sys: Registered thermal governor 'step_wise'
[    0.184551] thermal_sys: Registered thermal governor 'power_allocator'
[    0.185258] audit: type=2000 audit(0.148:1): state=initialized audit_enabled=0 res=1
[    0.185783] cpuidle: using governor menu
[    0.186878] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.187340] ASID allocator initialised with 65536 entries
[    0.191980] Serial: AMBA PL011 UART driver
[    0.234735] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 14, base_baud = 0) is a PL011 rev1
[    0.235990] printk: console [ttyAMA0] enabled
[    0.235990] printk: console [ttyAMA0] enabled
[    0.236353] printk: bootconsole [pl11] disabled
[    0.236353] printk: bootconsole [pl11] disabled
[    0.246854] KASLR enabled
[    0.271822] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.271976] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.272118] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.272242] HugeTLB: 508 KiB vmemmap can be freed for a 32.0 MiB page
[    0.272362] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.272484] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.272604] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.272727] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.280140] ACPI: Interpreter disabled.
[    0.287090] iommu: Default domain type: Translated 
[    0.287220] iommu: DMA domain TLB invalidation policy: strict mode 
[    0.288576] SCSI subsystem initialized
[    0.290245] usbcore: registered new interface driver usbfs
[    0.290531] usbcore: registered new interface driver hub
[    0.290749] usbcore: registered new device driver usb
[    0.293227] pps_core: LinuxPPS API ver. 1 registered
[    0.293339] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.293565] PTP clock support registered
[    0.294018] EDAC MC: Ver: 3.0.0
[    0.298899] FPGA manager framework
[    0.299514] Advanced Linux Sound Architecture Driver Initialized.
[    0.308095] vgaarb: loaded
[    0.311074] clocksource: Switched to clocksource arch_sys_counter
[    0.312019] VFS: Disk quotas dquot_6.6.0
[    0.312239] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.314563] pnp: PnP ACPI: disabled
[    0.329415] NET: Registered PF_INET protocol family
[    0.330771] IP idents hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.334374] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.334789] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.335034] TCP established hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.335305] TCP bind hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.335576] TCP: Hash tables configured (established 4096 bind 4096)
[    0.336550] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.336821] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.337715] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.339883] RPC: Registered named UNIX socket transport module.
[    0.340035] RPC: Registered udp transport module.
[    0.340131] RPC: Registered tcp transport module.
[    0.340234] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.340427] PCI: CLS 0 bytes, default 64
[    0.343473] Unpacking initramfs...
[    0.350541] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available
[    0.355556] kvm [1]: IPA Size Limit: 48 bits
[    0.356110] kvm [1]: GICv4 support disabled
[    0.356216] kvm [1]: GICv3: no GICV resource entry
[    0.356389] kvm [1]: disabling GICv2 emulation
[    0.356560] kvm [1]: GIC system register CPU interface enabled
[    0.356826] kvm [1]: vgic interrupt IRQ9
[    0.357395] kvm [1]: VHE mode initialized successfully
[    0.365095] Initialise system trusted keyrings
[    0.366317] workingset: timestamp_bits=42 max_order=17 bucket_order=0
[    0.399468] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.404064] NFS: Registering the id_resolver key type
[    0.404386] Key type id_resolver registered
[    0.404497] Key type id_legacy registered
[    0.404893] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.405078] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    0.407034] 9p: Installing v9fs 9p2000 file system support
[    0.442984] Freeing initrd memory: 4228K
[    0.445538] Key type asymmetric registered
[    0.445666] Asymmetric key parser 'x509' registered
[    0.445981] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.446209] io scheduler mq-deadline registered
[    0.446351] io scheduler kyber registered
[    0.475872] pl061_gpio 9030000.pl061: PL061 GPIO chip registered
[    0.481586] pci-host-generic 4010000000.pcie: host bridge /pcie@10000000 ranges:
[    0.482294] pci-host-generic 4010000000.pcie:       IO 0x003eff0000..0x003effffff -> 0x0000000000
[    0.482904] pci-host-generic 4010000000.pcie:      MEM 0x0010000000..0x003efeffff -> 0x0010000000
[    0.483121] pci-host-generic 4010000000.pcie:      MEM 0x8000000000..0xffffffffff -> 0x8000000000
[    0.483654] pci-host-generic 4010000000.pcie: Memory resource size exceeds max for 32 bits
[    0.484199] pci-host-generic 4010000000.pcie: ECAM at [mem 0x4010000000-0x401fffffff] for [bus 00-ff]
[    0.485376] pci-host-generic 4010000000.pcie: PCI host bridge to bus 0000:00
[    0.485688] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.485846] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.485994] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
[    0.486126] pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff]
[    0.487397] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
[    0.496520] EINJ: ACPI disabled.
[    0.545687] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.551677] SuperH (H)SCI(F) driver initialized
[    0.552935] msm_serial: driver initialized
[    0.556913] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.569640] loop: module loaded
[    0.571862] megasas: 07.719.03.00-rc1
[    0.576961] physmap-flash 0.flash: physmap platform flash device: [mem 0x00000000-0x03ffffff]
[    0.578102] 0.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000000 Chip ID 0x000000
[    0.578609] Intel/Sharp Extended Query Table at 0x0031
[    0.579279] Using buffer write method
[    0.579785] physmap-flash 0.flash: physmap platform flash device: [mem 0x04000000-0x07ffffff]
[    0.580233] 0.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000000 Chip ID 0x000000
[    0.580441] Intel/Sharp Extended Query Table at 0x0031
[    0.580800] Using buffer write method
[    0.580958] Concatenating MTD devices:
[    0.581051] (0): "0.flash"
[    0.581116] (1): "0.flash"
[    0.581179] into device "0.flash"
[    0.645325] tun: Universal TUN/TAP device driver, 1.6
[    0.647720] thunder_xcv, ver 1.0
[    0.647895] thunder_bgx, ver 1.0
[    0.648056] nicpf, ver 1.0
[    0.650930] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    0.651080] hns3: Copyright (c) 2017 Huawei Corporation.
[    0.651395] hclge is initializing
[    0.651564] e1000: Intel(R) PRO/1000 Network Driver
[    0.651665] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.651873] e1000e: Intel(R) PRO/1000 Network Driver
[    0.651974] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.652173] igb: Intel(R) Gigabit Ethernet Network Driver
[    0.652282] igb: Copyright (c) 2007-2014 Intel Corporation.
[    0.652457] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    0.652580] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    0.653392] sky2: driver version 1.30
[    0.655936] VFIO - User Level meta-driver version: 0.3
[    0.663600] usbcore: registered new interface driver usb-storage
[    0.671271] rtc-pl031 9010000.pl031: registered as rtc0
[    0.671896] rtc-pl031 9010000.pl031: setting system clock to 2022-11-20T16:07:46 UTC (1668960466)
[    0.673797] i2c_dev: i2c /dev entries driver
[    0.687743] sdhci: Secure Digital Host Controller Interface driver
[    0.687873] sdhci: Copyright(c) Pierre Ossman
[    0.689521] Synopsys Designware Multimedia Card Interface Driver
[    0.691712] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.696002] ledtrig-cpu: registered to indicate activity on CPUs
[    0.700743] usbcore: registered new interface driver usbhid
[    0.700869] usbhid: USB HID core driver
[    0.715202] NET: Registered PF_PACKET protocol family
[    0.716138] 9pnet: Installing 9P2000 support
[    0.716408] Key type dns_resolver registered
[    0.717272] registered taskstats version 1
[    0.717553] Loading compiled-in X.509 certificates
[    0.734047] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    0.741365] ALSA device list:
[    0.741486]   No soundcards found.
[    0.743704] uart-pl011 9000000.pl011: no DMA platform data
[    0.791231] Freeing unused kernel memory: 7552K
[    0.791686] ------------[ cut here ]------------
[    0.791795] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/mmu.c:386 create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.791982] Modules linked in:
[    0.792061] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.1.0-rc4-00008-gd8c1d798a2e5-dirty #1
[    0.792252] Hardware name: linux,dummy-virt (DT)
[    0.792344] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.792478] pc : create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.792579] lr : update_mapping_prot+0x7c/0x130
[    0.792673] sp : ffff80000800bd30
[    0.792739] x29: ffff80000800bd30 x28: ffffacf627081ac8 x27: 0000000000000000
[    0.792895] x26: 0000000000000000 x25: 0000000000000002 x24: ffffacf627081000
[    0.793047] x23: ffffacf6267d0000 x22: 0060000000000783 x21: ffffacf627090000
[    0.793200] x20: ffffacf627808708 x19: ffffacf6267d0000 x18: 0000000000000006
[    0.793352] x17: 00000000eef7d358 x16: ffff00001fef0b00 x15: ffff80000800b950
[    0.793504] x14: 0000000000000000 x13: ffffacf627813248 x12: 0000000000000480
[    0.793664] x11: 0000000000000180 x10: ffffacf62786b248 x9 : 0000000000000159
[    0.793816] x8 : ffffacf667600000 x7 : ffffacf62786b248 x6 : 0000000000000002
[    0.793966] x5 : 0000000000000000 x4 : 0060000000000783 x3 : ffffacf627090fff
[    0.794117] x2 : ffffacf6267d0000 x1 : 00000000411d0000 x0 : 00000000411d0000
[    0.794268] Call trace:
[    0.794323]  create_kpti_ng_temp_pgd+0x598/0x6b0
[    0.794421]  update_mapping_prot+0x7c/0x130
[    0.794511]  mark_rodata_ro+0x54/0x60
[    0.794592]  kernel_init+0x4c/0x12c
[    0.794671]  ret_from_fork+0x10/0x20
[    0.794752] ---[ end trace 0000000000000000 ]---
[    0.795261] Run /init as init process
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving random seed: OK
Starting network: OK
Linux version 6.1.0-rc4-00008-gd8c1d798a2e5-dirty (nathan@dev-arch.thelio-3990X) (aarch64-linux-gnu-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP PREEMPT Sun Nov 20 07:19:49 MST 2022
Stopping network: OK
Saving random seed: OK
Stopping klogd: OK
Stopping syslogd: OK
umount: devtmpfs busy - remounted read-only
umount: can't unmount /: Invalid argument
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system poweroff
[    3.403671] kvm: exiting hardware virtualization
[    3.406563] Flash device refused suspend due to active operation (state 20)
[    3.407119] Flash device refused suspend due to active operation (state 20)
[    3.408038] reboot: Power down

--VK0j3asLlQC6tjFs--
