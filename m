Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC446AE675
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjCGQ22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCGQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:28:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38E487B9AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:28:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C30811FB;
        Tue,  7 Mar 2023 08:29:08 -0800 (PST)
Received: from [10.1.29.181] (C02CF1NRLVDN.cambridge.arm.com [10.1.29.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7D613F67D;
        Tue,  7 Mar 2023 08:28:23 -0800 (PST)
Message-ID: <92fc6409-3fbe-f345-1806-02c3ea9ec520@arm.com>
Date:   Tue, 7 Mar 2023 16:28:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 00/60] arm64: Add support for LPA2 at stage1 and WXN
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
Content-Language: en-US
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

Just to say that I plan to work my way through this lot over the next couple of
weeks. I hope you can tolerate comments dribbling in as I go?

I'll also try integrating this with my latest revision for the KVM side of
things and re-run all my tests. I'll report back in due course.

Thanks,
Ryan


On 07/03/2023 14:04, Ard Biesheuvel wrote:
> This is a followup to [0], which was a lot smaller. Thanks to Ryan for
> feedback and review. This series is independent from Ryan's work on
> adding support for LPA2 to KVM - the only potential source of conflict
> should be the patch "arm64: kvm: Limit HYP VA and host S2 range to 48
> bits when LPA2 is in effect", which could simply be dropped in favour of
> the KVM changes to make it support LPA2.
> 
> The first ~15 patches of this series rework how the kernel VA space is
> organized, so that the vmemmap region does not take up more space than
> necessary, and so that most of it can be reclaimed when running a build
> capable of 52-bit virtual addressing on hardware that is not. This is
> needed because the vmemmap region will take up a substantial part of the
> upper VA region that it shares with the kernel, modules and
> vmalloc/vmap mappings once we enable LPA2 with 4k pages.
> 
> The next ~30 patches rework the early init code, reimplementing most of
> the page table and relocation handling in C code. There are several
> reasons why this is beneficial:
> - we generally prefer C code over asm for these things, and the macros
>   that currently exist in head.S for creating the kernel pages tables
>   are a good example why;
> - we no longer need to create the kernel mapping in two passes, which
>   means we can remove the logic that copies parts of the fixmap and the
>   KAsan shadow from one set of page tables to the other; this is
>   especially advantageous for KAsan with LPA2, which needs more
>   elaborate shadow handling across multiple levels, since the KAsan
>   region cannot be placed on exact pgd_t bouundaries in that case;
> - we can read the ID registers and parse command line overrides before
>   creating the page tables, which simplifies the LPA2 case, as flicking
>   the global TCR_EL1.DS bit at a later stage would require elaborate
>   repainting of all page table descriptors, some of which with the MMU
>   disabled;
> - we can use more elaborate logic to create the mappings, which means we
>   can use more precise mappings for code and data sections even when
>   using 2 MiB granularity, and this is a prerequisite for running with
>   WXN.
> 
> As part of the ID map changes, we decouple the ID map size from the
> kernel VA size, and switch to a 48-bit VA map for all configurations.
> 
> The next 18 patches rework the existing LVA support as a CPU feature,
> which simplifies some code and gets rid of the vabits_actual variable.
> Then, LPA2 support is implemented in the same vein. This requires adding
> support for 5 level paging as well, given that LPA2 introduces a new
> paging level '-1' when using 4k pages.
> 
> Combined with the vmemmap changes at the start of the series, the
> resulting LPA2/4k pages configuration will have the exact same VA space
> layout as the ordinary 4k/4 levels configuration, and so LPA2 support
> can reasonably be enabled by default, as the fallback is seamless on
> non-LPA2 hardware.
> 
> In the 16k/LPA2 case, the fallback also reduces the number of paging
> levels, resulting in a 47-bit VA space. This is based on the assumption
> that hybrid LPA2/non-LPA2 16k pages kernels in production use would
> prefer not to take the performance hit of 4 level paging to gain only a
> single additional bit of VA space. (Note that generic Android kernels
> use only 3 levels of paging today.) Bespoke 16k configurations can still
> configure 48-bit virtual addressing as before.
> 
> Finally, the last two patches enable support for running with the WXN
> control enabled. This was previously part of a separate series [1], but
> given that the delta is tiny, it is included here as well.
> 
> [0] https://lore.kernel.org/all/20221124123932.2648991-1-ardb@kernel.org/
> [1] https://lore.kernel.org/all/20221111171201.2088501-1-ardb@kernel.org/
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> Anshuman Khandual (2):
>   arm64/mm: Add FEAT_LPA2 specific TCR_EL1.DS field
>   arm64/mm: Add FEAT_LPA2 specific ID_AA64MMFR0.TGRAN[2]
> 
> Ard Biesheuvel (57):
> 
>   // KASLR / vmemmap reorg
>   arm64: kernel: Disable latent_entropy GCC plugin in early C runtime
>   arm64: mm: Take potential load offset into account when KASLR is off
>   arm64: mm: get rid of kimage_vaddr global variable
>   arm64: mm: Move PCI I/O emulation region above the vmemmap region
>   arm64: mm: Move fixmap region above vmemmap region
>   arm64: ptdump: Allow VMALLOC_END to be defined at boot
>   arm64: ptdump: Discover start of vmemmap region at runtime
>   arm64: vmemmap: Avoid base2 order of struct page size to dimension
>     region
>   arm64: mm: Reclaim unused vmemmap region for vmalloc use
>   arm64: kaslr: Adjust randomization range dynamically
>   arm64: kaslr: drop special case for ThunderX in kaslr_requires_kpti()
>   arm64: kvm: honour 'nokaslr' command line option for the HYP VA space
> 
>   // Reimplement page table creation code in C
>   arm64: kernel: Manage absolute relocations in code built under pi/
>   arm64: kernel: Don't rely on objcopy to make code under pi/ __init
>   arm64: head: move relocation handling to C code
>   arm64: idreg-override: Omit non-NULL checks for override pointer
>   arm64: idreg-override: Prepare for place relative reloc patching
>   arm64: idreg-override: Avoid parameq() and parameqn()
>   arm64: idreg-override: avoid strlen() to check for empty strings
>   arm64: idreg-override: Avoid sprintf() for simple string concatenation
>   arm64: idreg-override: Avoid kstrtou64() to parse a single hex digit
>   arm64: idreg-override: Move to early mini C runtime
>   arm64: kernel: Remove early fdt remap code
>   arm64: head: Clear BSS and the kernel page tables in one go
>   arm64: Move feature overrides into the BSS section
>   arm64: head: Run feature override detection before mapping the kernel
>   arm64: head: move dynamic shadow call stack patching into early C
>     runtime
>   arm64: kaslr: Use feature override instead of parsing the cmdline
>     again
>   arm64: idreg-override: Create a pseudo feature for rodata=off
>   arm64: Add helpers to probe local CPU for PAC/BTI/E0PD support
>   arm64: head: allocate more pages for the kernel mapping
>   arm64: head: move memstart_offset_seed handling to C code
>   arm64: head: Move early kernel mapping routines into C code
>   arm64: mm: Use 48-bit virtual addressing for the permanent ID map
>   arm64: pgtable: Decouple PGDIR size macros from PGD/PUD/PMD levels
>   arm64: kernel: Create initial ID map from C code
>   arm64: mm: avoid fixmap for early swapper_pg_dir updates
>   arm64: mm: omit redundant remap of kernel image
>   arm64: Revert "mm: provide idmap pointer to cpu_replace_ttbr1()"
> 
>   // Implement LPA2 support
>   arm64: mm: Handle LVA support as a CPU feature
>   arm64: mm: Add feature override support for LVA
>   arm64: mm: Wire up TCR.DS bit to PTE shareability fields
>   arm64: mm: Add LPA2 support to phys<->pte conversion routines
>   arm64: mm: Add definitions to support 5 levels of paging
>   arm64: mm: add LPA2 and 5 level paging support to G-to-nG conversion
>   arm64: Enable LPA2 at boot if supported by the system
>   arm64: mm: Add 5 level paging support to fixmap and swapper handling
>   arm64: kasan: Reduce minimum shadow alignment and enable 5 level
>     paging
>   arm64: mm: Add support for folding PUDs at runtime
>   arm64: ptdump: Disregard unaddressable VA space
>   arm64: ptdump: Deal with translation levels folded at runtime
>   arm64: kvm: avoid CONFIG_PGTABLE_LEVELS for runtime levels
>   arm64: kvm: Limit HYP VA and host S2 range to 48 bits when LPA2 is in
>     effect
>   arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs
>   arm64: defconfig: Enable LPA2 support
> 
>   // Allow WXN control to be enabled at boot
>   mm: add arch hook to validate mmap() prot flags
>   arm64: mm: add support for WXN memory translation attribute
> 
> Marc Zyngier (1):
>   arm64: Turn kaslr_feature_override into a generic SW feature override
> 
>  arch/arm64/Kconfig                      |  34 +-
>  arch/arm64/configs/defconfig            |   2 +-
>  arch/arm64/include/asm/assembler.h      |  55 +--
>  arch/arm64/include/asm/cpufeature.h     | 102 +++++
>  arch/arm64/include/asm/fixmap.h         |   1 +
>  arch/arm64/include/asm/kasan.h          |   2 -
>  arch/arm64/include/asm/kernel-pgtable.h | 104 ++---
>  arch/arm64/include/asm/memory.h         |  50 +--
>  arch/arm64/include/asm/mman.h           |  36 ++
>  arch/arm64/include/asm/mmu.h            |  26 +-
>  arch/arm64/include/asm/mmu_context.h    |  49 ++-
>  arch/arm64/include/asm/pgalloc.h        |  53 ++-
>  arch/arm64/include/asm/pgtable-hwdef.h  |  33 +-
>  arch/arm64/include/asm/pgtable-prot.h   |  18 +-
>  arch/arm64/include/asm/pgtable-types.h  |   6 +
>  arch/arm64/include/asm/pgtable.h        | 229 +++++++++-
>  arch/arm64/include/asm/scs.h            |  34 +-
>  arch/arm64/include/asm/setup.h          |   3 -
>  arch/arm64/include/asm/sysreg.h         |   2 +
>  arch/arm64/include/asm/tlb.h            |   3 +-
>  arch/arm64/kernel/Makefile              |   7 +-
>  arch/arm64/kernel/cpu_errata.c          |   2 +-
>  arch/arm64/kernel/cpufeature.c          |  90 ++--
>  arch/arm64/kernel/head.S                | 465 ++------------------
>  arch/arm64/kernel/idreg-override.c      | 322 --------------
>  arch/arm64/kernel/image-vars.h          |  32 ++
>  arch/arm64/kernel/kaslr.c               |   4 +-
>  arch/arm64/kernel/module.c              |   2 +-
>  arch/arm64/kernel/pi/Makefile           |  28 +-
>  arch/arm64/kernel/pi/idreg-override.c   | 396 +++++++++++++++++
>  arch/arm64/kernel/pi/kaslr_early.c      |  78 +---
>  arch/arm64/kernel/pi/map_kernel.c       | 284 ++++++++++++
>  arch/arm64/kernel/pi/map_range.c        | 104 +++++
>  arch/arm64/kernel/{ => pi}/patch-scs.c  |  36 +-
>  arch/arm64/kernel/pi/pi.h               |  30 ++
>  arch/arm64/kernel/pi/relacheck.c        | 130 ++++++
>  arch/arm64/kernel/pi/relocate.c         |  64 +++
>  arch/arm64/kernel/setup.c               |  22 -
>  arch/arm64/kernel/sleep.S               |   3 -
>  arch/arm64/kernel/suspend.c             |   2 +-
>  arch/arm64/kernel/vmlinux.lds.S         |  14 +-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c   |   2 +
>  arch/arm64/kvm/mmu.c                    |  22 +-
>  arch/arm64/kvm/va_layout.c              |  10 +-
>  arch/arm64/mm/init.c                    |   2 +-
>  arch/arm64/mm/kasan_init.c              | 154 +++++--
>  arch/arm64/mm/mmap.c                    |   4 +
>  arch/arm64/mm/mmu.c                     | 268 ++++++-----
>  arch/arm64/mm/pgd.c                     |  17 +-
>  arch/arm64/mm/proc.S                    | 106 ++++-
>  arch/arm64/mm/ptdump.c                  |  43 +-
>  arch/arm64/tools/cpucaps                |   1 +
>  include/linux/mman.h                    |  15 +
>  mm/mmap.c                               |   3 +
>  54 files changed, 2259 insertions(+), 1345 deletions(-)
>  delete mode 100644 arch/arm64/kernel/idreg-override.c
>  create mode 100644 arch/arm64/kernel/pi/idreg-override.c
>  create mode 100644 arch/arm64/kernel/pi/map_kernel.c
>  create mode 100644 arch/arm64/kernel/pi/map_range.c
>  rename arch/arm64/kernel/{ => pi}/patch-scs.c (89%)
>  create mode 100644 arch/arm64/kernel/pi/pi.h
>  create mode 100644 arch/arm64/kernel/pi/relacheck.c
>  create mode 100644 arch/arm64/kernel/pi/relocate.c
> 

