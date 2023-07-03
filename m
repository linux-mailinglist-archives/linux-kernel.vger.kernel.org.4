Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAB746050
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGCQEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGCQET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:04:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A3CE54
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688400257; x=1719936257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kX5puoO1YG91SpdGKxc7/lR05dmWp+5de2zwGoA2J7Q=;
  b=DyBE9qjQfjJX8YxqdXDxBlX2xWRrBWbKNU2WSY5tuxh3csKqci6gMMRm
   B1f+5lGaIe4NGvghL2NyYvvelbZ1z8pNzIeTYfop5K5K0teCldm1j14nL
   aLs3drAj0A4DLNUSJomaChuAoHrM7B3NmmhiJlafNM9lFDQDaZtcRUDmR
   bvB8kY68xqoTxu9eq07GbB2ASZ4kLRzdbm4mYAhH4KO6nkI2hcwwZOV30
   zm0W6ywIXU7MKOknjHHWWLaACykPFltl9SllvwCrsEVy4JPb1Op3bFDD8
   7R9cvN1LaymIhQxLNI63L9nF+JT7PMlIu4Tb31JwOz54kEVWRAjBgaP93
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393658437"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="393658437"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 09:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="965227921"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="965227921"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jul 2023 09:02:14 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGM0D-000HSo-1y;
        Mon, 03 Jul 2023 16:02:13 +0000
Date:   Tue, 4 Jul 2023 00:01:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
Message-ID: <202307032330.TguyNttt-lkp@intel.com>
References: <20230703135330.1865927-5-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703135330.1865927-5-ryan.roberts@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v6.4]
[cannot apply to akpm-mm/mm-everything linus/master next-20230703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/mm-Non-pmd-mappable-large-folios-for-folio_add_new_anon_rmap/20230703-215627
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230703135330.1865927-5-ryan.roberts%40arm.com
patch subject: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20230703/202307032330.TguyNttt-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230703/202307032330.TguyNttt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307032330.TguyNttt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> mm/memory.c:4271:2: error: call to undeclared function 'set_ptes'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    4271 |         set_ptes(vma->vm_mm, addr, vmf->pte, entry, pgcount);
         |         ^
   mm/memory.c:4271:2: note: did you mean 'set_pte'?
   arch/um/include/asm/pgtable.h:232:20: note: 'set_pte' declared here
     232 | static inline void set_pte(pte_t *pteptr, pte_t pteval)
         |                    ^
>> mm/memory.c:4274:2: error: call to undeclared function 'update_mmu_cache_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    4274 |         update_mmu_cache_range(vma, addr, vmf->pte, pgcount);
         |         ^
   12 warnings and 2 errors generated.


vim +/set_ptes +4271 mm/memory.c

  4135	
  4136	/*
  4137	 * We enter with non-exclusive mmap_lock (to exclude vma changes,
  4138	 * but allow concurrent faults), and pte mapped but not yet locked.
  4139	 * We return with mmap_lock still held, but pte unmapped and unlocked.
  4140	 */
  4141	static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
  4142	{
  4143		bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
  4144		struct vm_area_struct *vma = vmf->vma;
  4145		struct folio *folio;
  4146		vm_fault_t ret = 0;
  4147		pte_t entry;
  4148		int order;
  4149		int pgcount;
  4150		unsigned long addr;
  4151	
  4152		/* File mapping without ->vm_ops ? */
  4153		if (vma->vm_flags & VM_SHARED)
  4154			return VM_FAULT_SIGBUS;
  4155	
  4156		/*
  4157		 * Use pte_alloc() instead of pte_alloc_map().  We can't run
  4158		 * pte_offset_map() on pmds where a huge pmd might be created
  4159		 * from a different thread.
  4160		 *
  4161		 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
  4162		 * parallel threads are excluded by other means.
  4163		 *
  4164		 * Here we only have mmap_read_lock(mm).
  4165		 */
  4166		if (pte_alloc(vma->vm_mm, vmf->pmd))
  4167			return VM_FAULT_OOM;
  4168	
  4169		/* See comment in handle_pte_fault() */
  4170		if (unlikely(pmd_trans_unstable(vmf->pmd)))
  4171			return 0;
  4172	
  4173		/* Use the zero-page for reads */
  4174		if (!(vmf->flags & FAULT_FLAG_WRITE) &&
  4175				!mm_forbids_zeropage(vma->vm_mm)) {
  4176			entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->address),
  4177							vma->vm_page_prot));
  4178			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
  4179					vmf->address, &vmf->ptl);
  4180			if (vmf_pte_changed(vmf)) {
  4181				update_mmu_tlb(vma, vmf->address, vmf->pte);
  4182				goto unlock;
  4183			}
  4184			ret = check_stable_address_space(vma->vm_mm);
  4185			if (ret)
  4186				goto unlock;
  4187			/* Deliver the page fault to userland, check inside PT lock */
  4188			if (userfaultfd_missing(vma)) {
  4189				pte_unmap_unlock(vmf->pte, vmf->ptl);
  4190				return handle_userfault(vmf, VM_UFFD_MISSING);
  4191			}
  4192			if (uffd_wp)
  4193				entry = pte_mkuffd_wp(entry);
  4194			set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
  4195	
  4196			/* No need to invalidate - it was non-present before */
  4197			update_mmu_cache(vma, vmf->address, vmf->pte);
  4198			goto unlock;
  4199		}
  4200	
  4201		/*
  4202		 * If allocating a large folio, determine the biggest suitable order for
  4203		 * the VMA (e.g. it must not exceed the VMA's bounds, it must not
  4204		 * overlap with any populated PTEs, etc). We are not under the ptl here
  4205		 * so we will need to re-check that we are not overlapping any populated
  4206		 * PTEs once we have the lock.
  4207		 */
  4208		order = uffd_wp ? 0 : max_anon_folio_order(vma);
  4209		if (order > 0) {
  4210			vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
  4211			order = calc_anon_folio_order_alloc(vmf, order);
  4212			pte_unmap(vmf->pte);
  4213		}
  4214	
  4215		/* Allocate our own private folio. */
  4216		if (unlikely(anon_vma_prepare(vma)))
  4217			goto oom;
  4218		folio = alloc_anon_folio(vma, vmf->address, order);
  4219		if (!folio && order > 0) {
  4220			order = 0;
  4221			folio = alloc_anon_folio(vma, vmf->address, order);
  4222		}
  4223		if (!folio)
  4224			goto oom;
  4225	
  4226		pgcount = 1 << order;
  4227		addr = ALIGN_DOWN(vmf->address, pgcount << PAGE_SHIFT);
  4228	
  4229		if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
  4230			goto oom_free_page;
  4231		folio_throttle_swaprate(folio, GFP_KERNEL);
  4232	
  4233		/*
  4234		 * The memory barrier inside __folio_mark_uptodate makes sure that
  4235		 * preceding stores to the folio contents become visible before
  4236		 * the set_ptes() write.
  4237		 */
  4238		__folio_mark_uptodate(folio);
  4239	
  4240		entry = mk_pte(&folio->page, vma->vm_page_prot);
  4241		entry = pte_sw_mkyoung(entry);
  4242		if (vma->vm_flags & VM_WRITE)
  4243			entry = pte_mkwrite(pte_mkdirty(entry));
  4244	
  4245		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
  4246		if (vmf_pte_changed(vmf)) {
  4247			update_mmu_tlb(vma, vmf->address, vmf->pte);
  4248			goto release;
  4249		} else if (order > 0 && check_ptes_none(vmf->pte, pgcount) != pgcount) {
  4250			goto release;
  4251		}
  4252	
  4253		ret = check_stable_address_space(vma->vm_mm);
  4254		if (ret)
  4255			goto release;
  4256	
  4257		/* Deliver the page fault to userland, check inside PT lock */
  4258		if (userfaultfd_missing(vma)) {
  4259			pte_unmap_unlock(vmf->pte, vmf->ptl);
  4260			folio_put(folio);
  4261			return handle_userfault(vmf, VM_UFFD_MISSING);
  4262		}
  4263	
  4264		folio_ref_add(folio, pgcount - 1);
  4265		add_mm_counter(vma->vm_mm, MM_ANONPAGES, pgcount);
  4266		folio_add_new_anon_rmap(folio, vma, addr);
  4267		folio_add_lru_vma(folio, vma);
  4268	
  4269		if (uffd_wp)
  4270			entry = pte_mkuffd_wp(entry);
> 4271		set_ptes(vma->vm_mm, addr, vmf->pte, entry, pgcount);
  4272	
  4273		/* No need to invalidate - it was non-present before */
> 4274		update_mmu_cache_range(vma, addr, vmf->pte, pgcount);
  4275	unlock:
  4276		pte_unmap_unlock(vmf->pte, vmf->ptl);
  4277		return ret;
  4278	release:
  4279		folio_put(folio);
  4280		goto unlock;
  4281	oom_free_page:
  4282		folio_put(folio);
  4283	oom:
  4284		return VM_FAULT_OOM;
  4285	}
  4286	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
