Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CF96F0E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbjD0WeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344292AbjD0WeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:34:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ED540DB;
        Thu, 27 Apr 2023 15:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20E8064021;
        Thu, 27 Apr 2023 22:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46056C433EF;
        Thu, 27 Apr 2023 22:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1682634826;
        bh=AxjWWGkzi5fS9HVYf4ghhU3Y7Q7xMgFF6oie+qSkbUw=;
        h=Date:From:To:Cc:Subject:From;
        b=0N1VZZg2LYmGH7AYMpx8oB/9QxC72+BrshNWvzM2CVmLHvJvN0jouxEmJxd1h69mL
         zHnNnuEl9/g9BUrUSScxi1kn2PAMI3DBL0pKnR65QGwn92wDxdYJe8cJ6CwO5cpBcQ
         dku9/iER68LWJrsC5wIjdu3Ximf/ew+dQpXeJN3Y=
Date:   Thu, 27 Apr 2023 15:33:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] MM updates for 6.4-rc1
Message-Id: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this cycles's batch of MM changes.  This is almost
everything - I'll have another 5-10 patches next week.

I'm seeing a few conflicts against your present tree:

arch/arm/configs/oxnas_v6_defconfig: just remove this file

fs/iomap/buffered-io.c: linux-next resolution is at
https://lkml.kernel.org/r/20230413145515.3534108-1-broonie@kernel.org

fs/nfs/file.c:
https://lkml.kernel.org/r/20230413145031.3526017-1-broonie@kernel.org

include/linux/pagemap.h:
https://lkml.kernel.org/r/20230413145239.3529907-1-broonie@kernel.org

include/linux/slab.h: the SLOB changes just go away
https://lkml.kernel.org/r/20230317124408.4f868a50@canb.auug.org.au

mm/mmap.c:
This is new, as a result of the patch from Vlastimil which
you just merged.  I assume the resolution is to replace the new

	vma_pgoff =3D next->vm_pgoff;

with

	vma_pgoff =3D next->vm_pgoff - pglen;

mm/slob.c: simply remove slob.c



Forthcoming merge issues, and their linux-next resolutions are:

tip tree, mm/userfaultfd.c:
https://lkml.kernel.org/r/20230322103331.2ba61f0f@canb.auug.org.au

block tree, lib/iov_iter.c:
https://lkml.kernel.org/r/20230323100204.0917cecf@canb.auug.org.au

sh tree, tools/testing/selftests/mm/Makefile:
https://lkml.kernel.org/r/20230413135815.3254620-1-broonie@kernel.org

drm tree, drivers/gpu/drm/ttm/ttm_pool.c:
https://lkml.kernel.org/r/20230411122432.1d2b3ccb@canb.auug.org.au

drm-misc tree, drivers/gpu/drm/ttm/ttm_pool.c:
https://lkml.kernel.org/r/20230414125913.851920-1-broonie@kernel.org




Forthcoming build issues, and their linux-next resolutions are:

block tree, lib/iov_iter.c:
https://lkml.kernel.org/r/20230324125706.2c6d955d@canb.auug.org.au

tip tree, mm/migrate.c:
https://lkml.kernel.org/r/20230419182136.112974-1-broonie@kernel.org




And there may be a runtime issue when mm-stable is combined with the
ext4 tree.  See
https://lkml.kernel.org/r/20230419120923.3152939-1-willy@infradead.org



And a Kconfig isuue with the riscv tree, described here:
https://lkml.kernel.org/r/CAKXUXMyVeg2kQK_edKHtMD3eADrDK_PKhCSVkMrLDdYgTQQ5=
rg@mail.gmail.com


Thanks.


The following changes since commit ef832747a82dfbc22a3702219cc716f449b24e4a:

  nilfs2: initialize unused bytes in segment summary blocks (2023-04-18 14:=
22:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023=
-04-27-15-30

for you to fetch changes up to 4d4b6d66db63ceed399f1fb1a4b24081d2590eb1:

  mm,unmap: avoid flushing TLB in batch if PTE is inaccessible (2023-04-27 =
13:42:16 -0700)

----------------------------------------------------------------
- Nick Piggin's "shoot lazy tlbs" series, to improve the peformance of
  switching from a user process to a kernel thread.

- More folio conversions from Kefeng Wang, Zhang Peng and Pankaj Raghav.

- zsmalloc performance improvements from Sergey Senozhatsky.

- Yue Zhao has found and fixed some data race issues around the
  alteration of memcg userspace tunables.

- VFS rationalizations from Christoph Hellwig:

  - removal of most of the callers of write_one_page().

  - make __filemap_get_folio()'s return value more useful

- Luis Chamberlain has changed tmpfs so it no longer requires swap
  backing.  Use `mount -o noswap'.

- Qi Zheng has made the slab shrinkers operate locklessly, providing
  some scalability benefits.

- Keith Busch has improved dmapool's performance, making part of its
  operations O(1) rather than O(n).

- Peter Xu adds the UFFD_FEATURE_WP_UNPOPULATED feature to userfaultd,
  permitting userspace to wr-protect anon memory unpopulated ptes.

- Kirill Shutemov has changed MAX_ORDER's meaning to be inclusive rather
  than exclusive, and has fixed a bunch of errors which were caused by its
  unintuitive meaning.

- Axel Rasmussen give userfaultfd the UFFDIO_CONTINUE_MODE_WP feature,
  which causes minor faults to install a write-protected pte.

- Vlastimil Babka has done some maintenance work on vma_merge():
  cleanups to the kernel code and improvements to our userspace test
  harness.

- Cleanups to do_fault_around() by Lorenzo Stoakes.

- Mike Rapoport has moved a lot of initialization code out of various
  mm/ files and into mm/mm_init.c.

- Lorenzo Stoakes removd vmf_insert_mixed_prot(), which was added for
  DRM, but DRM doesn't use it any more.

- Lorenzo has also coverted read_kcore() and vread() to use iterators
  and has thereby removed the use of bounce buffers in some cases.

- Lorenzo has also contributed further cleanups of vma_merge().

- Chaitanya Prakash provides some fixes to the mmap selftesting code.

- Matthew Wilcox changes xfs and afs so they no longer take sleeping
  locks in ->map_page(), a step towards RCUification of pagefaults.

- Suren Baghdasaryan has improved mmap_lock scalability by switching to
  per-VMA locking.

- Frederic Weisbecker has reworked the percpu cache draining so that it
  no longer causes latency glitches on cpu isolated workloads.

- Mike Rapoport cleans up and corrects the ARCH_FORCE_MAX_ORDER Kconfig
  logic.

- Liu Shixin has changed zswap's initialization so we no longer waste a
  chunk of memory if zswap is not being used.

- Yosry Ahmed has improved the performance of memcg statistics flushing.

- David Stevens has fixed several issues involving khugepaged,
  userfaultfd and shmem.

- Christoph Hellwig has provided some cleanup work to zram's IO-related
  code paths.

- David Hildenbrand has fixed up some issues in the selftest code's
  testing of our pte state changing.

- Pankaj Raghav has made page_endio() unneeded and has removed it.

- Peter Xu contributed some rationalizations of the userfaultfd
  selftests.

- Yosry Ahmed has fixed an issue around memcg's page recalim accounting.

- Chaitanya Prakash has fixed some arm-related issues in the
  selftests/mm code.

- Longlong Xia has improved the way in which KSM handles hwpoisoned
  pages.

- Peter Xu fixes a few issues with uffd-wp at fork() time.

- Stefan Roesch has changed KSM so that it may now be used on a
  per-process and per-cgroup basis.

----------------------------------------------------------------
Alexander Halbuer (1):
      mm: reduce lock contention of pcp buffer refill

Alexander Potapenko (8):
      x86: kmsan: don't rename memintrinsics in uninstrumented files
      kmsan: another take at fixing memcpy tests
      x86: kmsan: use C versions of memset16/memset32/memset64
      kmsan: add memsetXX tests
      lib/stackdepot: kmsan: mark API outputs as initialized
      kmsan: add test_stackdepot_roundtrip
      mm: kmsan: apply __must_check to non-void functions
      mm: apply __must_check to vmap_pages_range_noflush()

Andrew Morton (2):
      sync mm-stable with mm-hotfixes-stable to pick up depended-upon upstr=
eam changes
      sync mm-stable with mm-hotfixes-stable to pick up depended-upon upstr=
eam changes

Andrey Konovalov (4):
      kasan: drop empty tagging-related defines
      kasan, arm64: rename tagging-related routines
      kasan, arm64: add arch_suppress_tag_checks_start/stop
      kasan: suppress recursive reports for HW_TAGS

Aneesh Kumar K.V (2):
      mm/vmemmap/devdax: fix kernel crash when probing devdax devices
      mm/hugetlb_vmemmap: rename ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP

Anshuman Khandual (2):
      mm/migrate: drop pte_mkhuge() in remove_migration_pte()
      mm/debug_vm_pgtable: replace pte_mkhuge() with arch_make_huge_pte()

Arnd Bergmann (2):
      mm: make arch_has_descending_max_zone_pfns() static
      kasan: remove hwasan-kernel-mem-intrinsic-prefix=3D1 for clang-14

Axel Rasmussen (4):
      mm: userfaultfd: rename functions for clarity + consistency
      mm: userfaultfd: don't pass around both mm and vma
      mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
      mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to install WP PTEs

Baolin Wang (2):
      mm: compaction: consider the number of scanning compound pages in iso=
late fail path
      mm: compaction: fix the possible deadlock when isolating hugetlb pages

Chaitanya S Prakash (8):
      selftests/mm: change MAP_CHUNK_SIZE
      selftests/mm: change NR_CHUNKS_HIGH for aarch64
      selftests/mm: set overcommit_policy as OVERCOMMIT_ALWAYS
      selftests/mm: add support for arm64 platform on va switch
      selftests/mm: rename va_128TBswitch to va_high_addr_switch
      selftests/mm: add platform independent in code comments
      selftests/mm: configure nr_hugepages for arm64
      selftests/mm: run hugetlb testcases of va switch

Christian Brauner (1):
      shmem: restrict noswap option to initial user namespace

Christoph Hellwig (26):
      ufs: don't flush page immediately for DIRSYNC directories
      ocfs2: don't use write_one_page in ocfs2_duplicate_clusters_by_page
      mm,jfs: move write_one_page/folio_write_one to jfs
      mm: don't look at xarray value entries in split_huge_pages_in_file
      mm: make mapping_get_entry available outside of filemap.c
      mm: use filemap_get_entry in filemap_get_incore_folio
      shmem: open code the page cache lookup in shmem_get_folio_gfp
      mm: remove FGP_ENTRY
      mm: return an ERR_PTR from __filemap_get_folio
      zram: always compile read_from_bdev_sync
      zram: remove valid_io_request
      zram: make zram_bio_discard more self-contained
      zram: simplify bvec iteration in __zram_make_request
      zram: move discard handling to zram_submit_bio
      zram: return early on error in zram_bvec_rw
      zram: refactor highlevel read and write handling
      zram: don't use highmem for the bounce buffer in zram_bvec_{read,writ=
e}
      zram: rename __zram_bvec_read to zram_read_page
      zram: directly call zram_read_page in writeback_store
      zram: refactor zram_bdev_read
      zram: don't pass a bvec to __zram_bvec_write
      zram: refactor zram_bdev_write
      zram: pass a page to read_from_bdev
      zram: don't return errors from read_from_bdev_async
      zram: fix synchronous reads
      zram: return errors from read_from_bdev_sync

Danilo Krummrich (1):
      maple_tree: export symbol mas_preallocate()

David Hildenbrand (9):
      m68k/mm: use correct bit number in _PAGE_SWP_EXCLUSIVE comment
      mm/userfaultfd: don't consider uffd-wp bit of writable migration entr=
ies
      selftests/mm: reuse read_pmd_pagesize() in COW selftest
      selftests/mm: mkdirty: test behavior of (pte|pmd)_mkdirty on VMAs wit=
hout write permissions
      sparc/mm: don't unconditionally set HW writable bit when setting PTE =
dirty on 64bit
      mm/migrate: revert "mm/migrate: fix wrongly apply write bit after mkd=
irty on sparc64"
      mm/huge_memory: revert "Partly revert "mm/thp: carry over dirty bit w=
hen thp splits on pmd""
      mm/huge_memory: conditionally call maybe_mkwrite() and drop pte_wrpro=
tect() in __split_huge_pmd_locked()
      mm: don't check VMA write permissions if the PTE/PMD indicates write =
permissions

David Stevens (4):
      mm/khugepaged: drain lru after swapping in shmem
      mm/khugepaged: refactor collapse_file control flow
      mm/khugepaged: skip shmem with userfaultfd
      mm/khugepaged: maintain page cache uptodate flag

Florian Schmidt (1):
      memcg v1: provide read access to memory.pressure_level

Frederic Weisbecker (1):
      sched/isolation: add cpu_is_isolated() API

Gerald Schaefer (1):
      mm: add PTE pointer parameter to flush_tlb_fix_spurious_fault()

Haifeng Xu (1):
      mm/vmscan: simplify shrink_node()

Hao Ge (1):
      kmemleak-test: fix kmemleak_test.c build logic

Heiko Carstens (1):
      s390/mm: try VMA lock-based page fault handling first

Huang Ying (2):
      migrate_pages_batch: fix statistics for longterm pin retry
      mm,unmap: avoid flushing TLB in batch if PTE is inaccessible

Hugh Dickins (3):
      shmem: shmem_get_partial_folio use filemap_get_entry
      hugetlb: pte_alloc_huge() to replace huge pte_alloc_map()
      mm/khugepaged: fix conflicting mods to collapse_file()

Hyeonggon Yoo (3):
      mmflags.h: use less error prone method to define pageflag_names
      mm, printk: introduce new format %pGt for page_type
      mm/debug: use %pGt to display page_type in dump_page()

Ivan Orlov (2):
      selftests: cgroup: add 'malloc' failures checks in test_memcontrol
      mm: khugepaged: fix kernel BUG in hpage_collapse_scan_file()

Jaewon Kim (1):
      dma-buf: system_heap: avoid reclaim for order 4

Jeff Xu (1):
      selftests/memfd: fix test_sysctl

Jiaqi Yan (3):
      mm/khugepaged: recover from poisoned anonymous memory
      mm/hwpoison: introduce copy_mc_highpage
      mm/khugepaged: recover from poisoned file-backed memory

Jingyu Wang (1):
      mm/gup.c: fix typo in comments

John Keeping (1):
      mm: shrinkers: fix debugfs file permissions

Josh Triplett (1):
      prctl: add PR_GET_AUXV to copy auxv to userspace

Kalesh Singh (1):
      mm: Multi-gen LRU: remove wait_event_killable()

Kefeng Wang (9):
      mm: huge_memory: convert __do_huge_pmd_anonymous_page() to use a folio
      mm: memory: use folio_throttle_swaprate() in do_swap_page()
      mm: memory: use folio_throttle_swaprate() in page_copy_prealloc()
      mm: memory: use folio_throttle_swaprate() in wp_page_copy()
      mm: memory: use folio_throttle_swaprate() in do_anonymous_page()
      mm: memory: use folio_throttle_swaprate() in do_cow_fault()
      mm: swap: remove unneeded cgroup_throttle_swaprate()
      mm: memory-failure: directly use IS_ENABLED(CONFIG_HWPOISON_INJECT)
      mm: correct arg in reclaim_pages()/reclaim_clean_pages_from_list()

Keith Busch (8):
      dmapool: add alloc/free performance test
      dmapool: move debug code to own functions
      dmapool: rearrange page alloc failure handling
      dmapool: consolidate page initialization
      dmapool: simplify freeing
      dmapool: don't memset on free twice
      dmapool: link blocks across pages
      dmapool: create/destroy cleanup

Kirill A. Shutemov (12):
      sparc/mm: fix MAX_ORDER usage in tsb_grow()
      um: fix MAX_ORDER usage in linux_main()
      floppy: fix MAX_ORDER usage
      drm/i915: fix MAX_ORDER usage in i915_gem_object_get_pages_internal()
      genwqe: fix MAX_ORDER usage
      perf/core: fix MAX_ORDER usage in rb_alloc_aux_page()
      mm/page_reporting: fix MAX_ORDER usage in page_reporting_register()
      mm/slub: fix MAX_ORDER usage in calculate_order()
      iommu: fix MAX_ORDER usage in __iommu_dma_alloc_pages()
      mm, treewide: redefine MAX_ORDER sanely
      mm/page_alloc: make deferred page init free pages in MAX_ORDER blocks
      mm: avoid passing 0 to __ffs()

Kirill Tkhai (1):
      mm: vmscan: add shrinker_srcu_generation

Laurent Dufour (1):
      powerc/mm: try VMA lock-based page fault handling first

Li zeming (1):
      sparse: remove unnecessary 0 values from rc

Linus Torvalds (1):
      mm: move 'mmap_min_addr' logic from callers into vm_unmapped_area()

Liu Shixin (4):
      mm/zswap: remove zswap_entry_cache_{create,destroy} helper function
      mm/zswap: replace zswap_init_{started/failed} with zswap_init_state
      mm/zswap: delay the initialization of zswap
      mm: hwpoison: support recovery from HugePage copy-on-write faults

Longlong Xia (2):
      mm: memory-failure: refactor add_to_kill()
      mm: ksm: support hwpoison for ksm page

Lorenzo Stoakes (15):
      mm: prefer xxx_page() alloc/free functions for order-0 pages
      mm: refactor do_fault_around()
      mm: prefer fault_around_pages to fault_around_bytes
      MAINTAINERS: add Lorenzo as vmalloc reviewer
      mm: remove unused vmf_insert_mixed_prot()
      mm: remove vmf_insert_pfn_xxx_prot() for huge page-table entries
      drm/ttm: remove comment referencing now-removed vmf_insert_mixed_prot=
()
      fs/proc/kcore: avoid bounce buffer for ktext data
      fs/proc/kcore: convert read_kcore() to read_kcore_iter()
      iov_iter: add copy_page_to_iter_nofault()
      mm: vmalloc: convert vread() to vread_iter()
      mm/mmap/vma_merge: further improve prev/next VMA naming
      mm/mmap/vma_merge: fold curr, next assignment logic
      mm/mmap/vma_merge: explicitly assign res, vma, extend invariants
      mm/mmap/vma_merge: init cleanup, be explicit about the non-mergeable =
case

Luca Vizzarro (1):
      memfd: pass argument of memfd_fcntl as int

Luis Chamberlain (6):
      shmem: remove check for folio lock on writepage()
      shmem: set shmem_writepage() variables early
      shmem: move reclaim check early on writepages()
      shmem: skip page split if we're not reclaiming
      shmem: update documentation
      shmem: add support to ignore swap

Ma Wupeng (1):
      x86/mm/pat: clear VM_PAT if copy_p4d_range failed

Matthew Wilcox (Oracle) (4):
      xfs: remove xfs_filemap_map_pages() wrapper
      afs: split afs_pagecache_valid() out of afs_validate()
      mm: hold the RCU read lock over calls to ->map_pages
      hugetlb: remove PageHeadHuge()

Mel Gorman (1):
      sched/numa: apply the scan delay to every new vma

Michal Hocko (1):
      memcg: do not drain charge pcp caches on remote isolated cpus

Michel Lespinasse (1):
      mm: rcu safe VMA freeing

Mike Rapoport (IBM) (32):
      loongarch: drop ranges for definition of ARCH_FORCE_MAX_ORDER
      mips: drop ranges for definition of ARCH_FORCE_MAX_ORDER
      mm: move get_page_from_free_area() to mm/page_alloc.c
      mips: fix comment about pgtable_init()
      mm/page_alloc: add helper for checking if check_pages_enabled
      mm: move most of core MM initialization to mm/mm_init.c
      mm: handle hashdist initialization in mm/mm_init.c
      mm/page_alloc: rename page_alloc_init() to page_alloc_init_cpuhp()
      init: fold build_all_zonelists() and page_alloc_init_cpuhp() to mm_in=
it()
      init,mm: move mm_init() to mm/mm_init.c and rename it to mm_core_init=
()
      mm: call {ptlock,pgtable}_cache_init() directly from mm_core_init()
      mm: move init_mem_debugging_and_hardening() to mm/mm_init.c
      init,mm: fold late call to page_ext_init() to page_alloc_init_late()
      mm: move mem_init_print_info() to mm_init.c
      mm: move kmem_cache_init() declaration to mm/slab.h
      mm: move vmalloc_init() declaration to mm/internal.h
      MAINTAINERS: extend memblock entry to include MM initialization
      arm: reword ARCH_FORCE_MAX_ORDER prompt and help text
      arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
      arm64: reword ARCH_FORCE_MAX_ORDER prompt and help text
      csky: drop ARCH_FORCE_MAX_ORDER
      ia64: don't allow users to override ARCH_FORCE_MAX_ORDER
      m68k: reword ARCH_FORCE_MAX_ORDER prompt and help text
      nios2: reword ARCH_FORCE_MAX_ORDER prompt and help text
      nios2: drop ranges for definition of ARCH_FORCE_MAX_ORDER
      powerpc: reword ARCH_FORCE_MAX_ORDER prompt and help text
      powerpc: drop ranges for definition of ARCH_FORCE_MAX_ORDER
      sh: reword ARCH_FORCE_MAX_ORDER prompt and help text
      sh: drop ranges for definition of ARCH_FORCE_MAX_ORDER
      sparc: reword ARCH_FORCE_MAX_ORDER prompt and help text
      xtensa: reword ARCH_FORCE_MAX_ORDER prompt and help text
      mm: move free_area_empty() to mm/internal.h

Muchun Song (1):
      mm: hugetlb_vmemmap: simplify hugetlb_vmemmap_init() a bit

Muhammad Usama Anjum (1):
      mm/userfaultfd: support WP on multiple VMAs

Nicholas Piggin (5):
      kthread: simplify kthread_use_mm refcounting
      lazy tlb: introduce lazy tlb mm refcount helper functions
      lazy tlb: allow lazy tlb mm refcounting to be configurable
      lazy tlb: shoot lazies, non-refcounting lazy tlb mm reference handlin=
g scheme
      powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN

Pankaj Raghav (7):
      orangefs: use folios in orangefs_readahead
      mpage: split submit_bio and bio end_io handler for reads and writes
      mpage: use folios in bio end_io handler
      fs/buffer: add folio_set_bh helper
      buffer: add folio_alloc_buffers() helper
      fs/buffer: add folio_create_empty_buffers helper
      fs/buffer: convert create_page_buffers to folio_create_buffers

Pavankumar Kondeti (1):
      printk: export console trace point for kcsan/kasan/kfence/kmsan

Peng Zhang (5):
      mm: kfence: improve the performance of __kfence_alloc() and __kfence_=
free()
      maple_tree: simplify mas_wr_node_walk()
      maple_tree: use correct variable type in sizeof
      maple_tree: add a test case to check maple_alloc
      maple_tree: fix allocation in mas_sparse_area()

Peter Collingbourne (2):
      kasan: call clear_page with a match-all tag instead of changing page =
tag
      kasan: remove PG_skip_kasan_poison flag

Peter Xu (41):
      mm/khugepaged: alloc_charge_hpage() take care of mem charge errors
      mm/khugepaged: cleanup memcg uncharge for failure path
      mm/thp: rename TRANSPARENT_HUGEPAGE_NEVER_DAX to _UNSUPPORTED
      mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
      selftests/mm: smoke test UFFD_FEATURE_WP_UNPOPULATED
      selftests/mm: update .gitignore with two missing tests
      selftests/mm: dump a summary in run_vmtests.sh
      selftests/mm: merge util.h into vm_util.h
      selftests/mm: use TEST_GEN_PROGS where proper
      selftests/mm: link vm_util.c always
      selftests/mm: merge default_huge_page_size() into one
      selftests/mm: use PM_* macros in vm_utils.h
      selftests/mm: reuse pagemap_get_entry() in vm_util.h
      selftests/mm: test UFFDIO_ZEROPAGE only when !hugetlb
      selftests/mm: drop test_uffdio_zeropage_eexist
      selftests/mm: create uffd-common.[ch]
      selftests/mm: split uffd tests into uffd-stress and uffd-unit-tests
      selftests/mm: uffd_[un]register()
      selftests/mm: uffd_open_{dev|sys}()
      selftests/mm: UFFDIO_API test
      selftests/mm: drop global mem_fd in uffd tests
      selftests/mm: drop global hpage_size in uffd tests
      selftests/mm: rename uffd_stats to uffd_args
      selftests/mm: let uffd_handle_page_fault() take wp parameter
      selftests/mm: allow allocate_area() to fail properly
      selftests/mm: add framework for uffd-unit-test
      selftests/mm: move uffd pagemap test to unit test
      selftests/mm: move uffd minor test to unit test
      selftests/mm: move uffd sig/events tests into uffd unit tests
      selftests/mm: move zeropage test into uffd unit tests
      selftests/mm: workaround no way to detect uffd-minor + wp
      selftests/mm: allow uffd test to skip properly with no privilege
      selftests/mm: drop sys/dev test in uffd-stress test
      selftests/mm: add shmem-private test to uffd-stress
      selftests/mm: add uffdio register ioctls test
      mm/hugetlb: fix uffd-wp during fork()
      mm/hugetlb: fix uffd-wp bit lost when unsharing happens
      selftests/mm: add a few options for uffd-unit-test
      selftests/mm: extend and rename uffd pagemap test
      selftests/mm: rename COW_EXTRA_LIBS to IOURING_EXTRA_LIBS
      selftests/mm: add tests for RO pinning vs fork()

Qi Zheng (8):
      mm: vmscan: add a map_nr_max field to shrinker_info
      mm: vmscan: make global slab shrink lockless
      mm: vmscan: make memcg slab shrink lockless
      mm: shrinkers: make count and scan in shrinker debugfs lockless
      mm: vmscan: hold write lock to reparent shrinker nr_deferred
      mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers()
      mm: shrinkers: convert shrinker_rwsem to mutex
      mm: mlock: use folios_put() in mlock_folio_batch()

Raghavendra K T (3):
      sched/numa: enhance vma scanning logic
      sched/numa: implement access PID reset logic
      sched/numa: use hash_32 to mix up PIDs accessing VMA

Sebastian Andrzej Siewior (1):
      io-mapping: don't disable preempt on RT in io_mapping_map_atomic_wc().

Sergey Senozhatsky (6):
      zsmalloc: remove insert_zspage() ->inuse optimization
      zsmalloc: fine-grained inuse ratio based fullness grouping
      zsmalloc: rework compaction algorithm
      zsmalloc: show per fullness group class stats
      zsmalloc: reset compaction source zspage pointer after putback_zspage=
()
      zsmalloc: allow only one active pool compaction context

Stefan Roesch (4):
      mm: add tracepoints to ksm
      mm: add new api to enable ksm per process
      mm: add new KSM process and sysfs knobs
      selftests/mm: add new selftests for KSM

Steven Price (1):
      smaps: fix defined but not used smaps_shmem_walk_ops

Suren Baghdasaryan (24):
      mm: introduce CONFIG_PER_VMA_LOCK
      mm: move mmap_lock assert function definitions
      mm: add per-VMA lock and helper functions to control it
      mm: mark VMA as being written when changing vm_flags
      mm/mmap: move vma_prepare before vma_adjust_trans_huge
      mm/khugepaged: write-lock VMA while collapsing a huge page
      mm/mmap: write-lock VMAs in vma_prepare before modifying them
      mm/mremap: write-lock VMA while remapping it to a new address range
      mm: write-lock VMAs before removing them from VMA tree
      mm: conditionally write-lock VMA in free_pgtables
      kernel/fork: assert no VMA readers during its destruction
      mm/mmap: prevent pagefault handler from racing with mmu_notifier regi=
stration
      mm: introduce vma detached flag
      mm: introduce lock_vma_under_rcu to be used from arch-specific code
      mm: fall back to mmap_lock if vma->anon_vma is not yet set
      mm: add FAULT_FLAG_VMA_LOCK flag
      mm: prevent do_swap_page from handling page faults under VMA lock
      mm: prevent userfaults to be handled under per-vma lock
      mm: introduce per-VMA lock statistics
      x86/mm: try VMA lock-based page fault handling first
      arm64/mm: try VMA lock-based page fault handling first
      mm/mmap: free vm_area_struct without call_rcu in exit_mmap
      mm: separate vma->lock from vm_area_struct
      mm: do not increment pgfault stats when page fault handler retries

T.J. Alumbaugh (2):
      mm: multi-gen LRU: clean up sysfs code
      mm: multi-gen LRU: improve design doc

Taejoon Song (1):
      mm/zswap: try to avoid worst-case scenario on same element pages

Thomas Wei=DFschuh (2):
      mm: cma: make kobj_type structure constant
      mm/damon/sysfs: make more kobj_type structures constant

Tom Rix (1):
      mm: backing-dev: set variables dev_attr_min,max_bytes storage-class-s=
pecifier to static

Tomas Krcka (1):
      mm: be less noisy during memory hotplug

Tomas Mudrunka (1):
      mm/memtest: add results of early memtest to /proc/meminfo

Tony Battersby (4):
      dmapool: remove checks for dev =3D=3D NULL
      dmapool: use sysfs_emit() instead of scnprintf()
      dmapool: cleanup integer types
      dmapool: speedup DMAPOOL_DEBUG with init_on_alloc

Uladzislau Rezki (Sony) (3):
      mm: vmalloc: remove a global vmap_blocks xarray
      lib/test_vmalloc.c: add vm_map_ram()/vm_unmap_ram() test case
      mm: vmalloc: rename addr_to_vb_xarray() function

Uros Bizjak (1):
      mm/rmap: use atomic_try_cmpxchg in set_tlb_ubc_flush_pending

Vincenzo Frascino (1):
      arm64: mte: rename TCO routines

Vlastimil Babka (12):
      mm, page_alloc: reduce page alloc/free sanity checks
      mm/mmap/vma_merge: use only primary pointers for preparing merge
      mm/mmap/vma_merge: use the proper vma pointer in case 3
      mm/mmap/vma_merge: use the proper vma pointers in cases 1 and 6
      mm/mmap/vma_merge: use the proper vma pointer in case 4
      mm/mmap/vma_merge: initialize mid and next in natural order
      mm/mmap/vma_merge: set mid to NULL if not applicable
      mm/mmap/vma_merge: rename adj_next to adj_start
      mm/mmap/vma_merge: convert mergeability checks to return bool
      mm/mmap: start distinguishing if vma can be removed in mergeability t=
est
      mm/mremap: simplify vma expansion again
      mm, page_alloc: use check_pages_enabled static key to check tail pages

Wenchao Hao (1):
      trace: cma: remove unnecessary event class cma_alloc_class

Yajun Deng (1):
      lib/show_mem.c: use for_each_populated_zone() simplify code

Yang Yang (1):
      mm: workingset: update description of the source file

Yosry Ahmed (12):
      cgroup: rename cgroup_rstat_flush_"irqsafe" to "atomic"
      memcg: rename mem_cgroup_flush_stats_"delayed" to "ratelimited"
      memcg: do not flush stats in irq context
      memcg: replace stats_flush_lock with an atomic
      memcg: sleep during flushing stats in safe contexts
      workingset: memcg: sleep when flushing stats in workingset_refault()
      vmscan: memcg: sleep when flushing stats during reclaim
      memcg: do not modify rstat tree for zero updates
      memcg: page_cgroup_ino() get memcg from the page's folio
      mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
      mm: vmscan: move set_task_reclaim_state() near flush_reclaim_state()
      mm: vmscan: refactor updating current->reclaim_state

Yue Zhao (4):
      mm, memcg: Prevent memory.oom.group load/store tearing
      mm, memcg: Prevent memory.swappiness load/store tearing
      mm, memcg: Prevent memory.oom_control load/store tearing
      mm, memcg: Prevent memory.soft_limit_in_bytes load/store tearing

ZhangPeng (8):
      mm/madvise: use vma_lookup() instead of find_vma()
      userfaultfd: convert mfill_atomic_pte_copy() to use a folio
      userfaultfd: use kmap_local_page() in copy_huge_page_from_user()
      userfaultfd: convert copy_huge_page_from_user() to copy_folio_from_us=
er()
      userfaultfd: convert mfill_atomic_hugetlb() to use a folio
      mm: convert copy_user_huge_page() to copy_user_large_folio()
      userfaultfd: convert mfill_atomic() to use a folio
      userfaultfd: use helper function range_in_vma()

Zhen Lei (1):
      kmsan: fix a stale comment in kmsan_save_stack_with_flags()

Zi Yan (1):
      selftests/mm: fix split huge page tests

Zqiang (1):
      kasan: fix lockdep report invalid wait context

 Documentation/ABI/testing/sysfs-kernel-mm-ksm      |    8 +
 Documentation/admin-guide/kdump/vmcoreinfo.rst     |    6 +-
 Documentation/admin-guide/kernel-parameters.txt    |    2 +-
 Documentation/admin-guide/mm/ksm.rst               |    5 +-
 Documentation/admin-guide/mm/userfaultfd.rst       |   25 +
 Documentation/core-api/printk-formats.rst          |   16 +-
 Documentation/filesystems/locking.rst              |    4 +-
 Documentation/filesystems/proc.rst                 |    8 +
 Documentation/filesystems/tmpfs.rst                |   66 +-
 Documentation/mm/active_mm.rst                     |    6 +
 Documentation/mm/arch_pgtable_helpers.rst          |    2 +-
 Documentation/mm/multigen_lru.rst                  |   44 +-
 Documentation/mm/unevictable-lru.rst               |    2 +
 MAINTAINERS                                        |    5 +-
 arch/Kconfig                                       |   32 +
 arch/arc/Kconfig                                   |    4 +-
 arch/arc/mm/init.c                                 |    5 -
 arch/arm/Kconfig                                   |   27 +-
 arch/arm/configs/imx_v6_v7_defconfig               |    2 +-
 arch/arm/configs/milbeaut_m10v_defconfig           |    2 +-
 arch/arm/configs/oxnas_v6_defconfig                |    2 +-
 arch/arm/configs/pxa_defconfig                     |    2 +-
 arch/arm/configs/sama7_defconfig                   |    2 +-
 arch/arm/configs/sp7021_defconfig                  |    2 +-
 arch/arm/mach-rpc/ecard.c                          |    2 +-
 arch/arm64/Kconfig                                 |   52 +-
 arch/arm64/include/asm/memory.h                    |    8 +-
 arch/arm64/include/asm/mte-kasan.h                 |   81 +
 arch/arm64/include/asm/mte.h                       |   12 -
 arch/arm64/include/asm/pgtable.h                   |    2 +-
 arch/arm64/include/asm/sparsemem.h                 |    2 +-
 arch/arm64/include/asm/uaccess.h                   |   66 +-
 arch/arm64/include/asm/word-at-a-time.h            |    4 +-
 arch/arm64/kvm/hyp/include/nvhe/gfp.h              |    2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c               |   10 +-
 arch/arm64/mm/fault.c                              |   36 +
 arch/csky/Kconfig                                  |    4 -
 arch/ia64/Kconfig                                  |    7 +-
 arch/ia64/include/asm/sparsemem.h                  |    4 +-
 arch/ia64/mm/hugetlbpage.c                         |    2 +-
 arch/loongarch/Kconfig                             |   14 +-
 arch/m68k/Kconfig.cpu                              |   19 +-
 arch/m68k/include/asm/mcf_pgtable.h                |    2 +-
 arch/mips/Kconfig                                  |   15 +-
 arch/mips/include/asm/fixmap.h                     |    2 +-
 arch/mips/include/asm/pgtable.h                    |    3 +-
 arch/nios2/Kconfig                                 |   22 +-
 arch/powerpc/Kconfig                               |   38 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig       |    2 +-
 arch/powerpc/configs/fsl-emb-nonhw.config          |    2 +-
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |    3 +-
 arch/powerpc/kernel/smp.c                          |    2 +-
 arch/powerpc/mm/book3s64/iommu_api.c               |    2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c               |    4 +-
 arch/powerpc/mm/fault.c                            |   37 +
 arch/powerpc/mm/hugetlbpage.c                      |    2 +-
 arch/powerpc/platforms/powernv/Kconfig             |    1 +
 arch/powerpc/platforms/powernv/pci-ioda.c          |    2 +-
 arch/powerpc/platforms/pseries/Kconfig             |    1 +
 arch/s390/Kconfig                                  |    3 +-
 arch/s390/include/asm/pgtable.h                    |   12 +-
 arch/s390/mm/fault.c                               |   24 +
 arch/s390/mm/gmap.c                                |    7 +
 arch/s390/mm/hugetlbpage.c                         |    2 +-
 arch/s390/mm/mmap.c                                |    2 +-
 arch/sh/configs/ecovec24_defconfig                 |    2 +-
 arch/sh/mm/Kconfig                                 |   30 +-
 arch/sparc/Kconfig                                 |   21 +-
 arch/sparc/include/asm/pgtable_64.h                |  116 +-
 arch/sparc/kernel/pci_sun4v.c                      |    2 +-
 arch/sparc/kernel/traps_64.c                       |    2 +-
 arch/sparc/mm/tsb.c                                |    4 +-
 arch/x86/Kconfig                                   |    3 +-
 arch/x86/include/asm/pgtable.h                     |    2 +-
 arch/x86/include/asm/string_64.h                   |   23 +-
 arch/x86/mm/fault.c                                |   36 +
 arch/x86/mm/pat/memtype.c                          |   12 +-
 arch/xtensa/Kconfig                                |   23 +-
 drivers/base/regmap/regmap-debugfs.c               |    8 +-
 drivers/block/floppy.c                             |    2 +-
 drivers/block/zram/zram_drv.c                      |  382 +--
 drivers/block/zram/zram_drv.h                      |    1 -
 drivers/crypto/ccp/sev-dev.c                       |    2 +-
 drivers/crypto/hisilicon/sgl.c                     |    6 +-
 drivers/dma-buf/heaps/system_heap.c                |    5 +-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |    2 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    2 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |   22 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |    2 +-
 drivers/iommu/dma-iommu.c                          |    4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |    4 +-
 drivers/md/dm-bufio.c                              |    2 +-
 drivers/md/dm-cache-metadata.c                     |    2 +-
 drivers/md/dm-thin-metadata.c                      |    2 +-
 drivers/misc/genwqe/card_utils.c                   |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |    2 +-
 drivers/net/ethernet/ibm/ibmvnic.h                 |    2 +-
 drivers/video/fbdev/hyperv_fb.c                    |    4 +-
 drivers/video/fbdev/vermilion/vermilion.c          |    2 +-
 drivers/virtio/virtio_balloon.c                    |    2 +-
 drivers/virtio/virtio_mem.c                        |   12 +-
 fs/Kconfig                                         |    9 +-
 fs/afs/dir.c                                       |   10 +-
 fs/afs/dir_edit.c                                  |    2 +-
 fs/afs/file.c                                      |   14 +-
 fs/afs/inode.c                                     |   27 +-
 fs/afs/internal.h                                  |    1 +
 fs/afs/write.c                                     |    4 +-
 fs/buffer.c                                        |   89 +-
 fs/exec.c                                          |    2 +-
 fs/ext4/inode.c                                    |    2 +-
 fs/ext4/move_extent.c                              |    8 +-
 fs/hugetlbfs/inode.c                               |    4 +-
 fs/inode.c                                         |    3 +-
 fs/iomap/buffered-io.c                             |   11 +-
 fs/jfs/jfs_metapage.c                              |   39 +-
 fs/mpage.c                                         |   66 +-
 fs/netfs/buffered_read.c                           |    4 +-
 fs/nfs/file.c                                      |    4 +-
 fs/nilfs2/page.c                                   |    6 +-
 fs/ocfs2/refcounttree.c                            |    9 +-
 fs/orangefs/inode.c                                |    9 +-
 fs/proc/base.c                                     |    3 +
 fs/proc/kcore.c                                    |   85 +-
 fs/proc/meminfo.c                                  |   13 +
 fs/proc/task_mmu.c                                 |    3 +-
 fs/ramfs/file-nommu.c                              |    2 +-
 fs/super.c                                         |    2 +-
 fs/ufs/dir.c                                       |   29 +-
 fs/userfaultfd.c                                   |   45 +-
 fs/xfs/xfs_buf.c                                   |    3 +-
 fs/xfs/xfs_file.c                                  |   17 +-
 include/asm-generic/pgalloc.h                      |    4 +-
 include/drm/ttm/ttm_pool.h                         |    2 +-
 include/linux/buffer_head.h                        |    6 +
 include/linux/cgroup.h                             |    2 +-
 include/linux/gfp.h                                |    7 +-
 include/linux/gfp_types.h                          |   30 +-
 include/linux/highmem.h                            |   62 +-
 include/linux/huge_mm.h                            |   41 +-
 include/linux/hugetlb.h                            |   46 +-
 include/linux/io-mapping.h                         |   20 +-
 include/linux/kmsan.h                              |   43 +-
 include/linux/ksm.h                                |   37 +-
 include/linux/memblock.h                           |    2 +
 include/linux/memcontrol.h                         |   10 +-
 include/linux/memfd.h                              |    4 +-
 include/linux/mm.h                                 |  206 +-
 include/linux/mm_inline.h                          |    6 +
 include/linux/mm_types.h                           |   46 +-
 include/linux/mmap_lock.h                          |   37 +-
 include/linux/mmzone.h                             |   34 +-
 include/linux/page-flags.h                         |   23 +-
 include/linux/page_ext.h                           |    2 -
 include/linux/pageblock-flags.h                    |    4 +-
 include/linux/pagemap.h                            |   21 +-
 include/linux/pgtable.h                            |    9 +-
 include/linux/sched/coredump.h                     |    1 +
 include/linux/sched/isolation.h                    |   12 +
 include/linux/sched/mm.h                           |   28 +
 include/linux/shmem_fs.h                           |   19 +-
 include/linux/slab.h                               |    7 +-
 include/linux/swap.h                               |   38 +-
 include/linux/uio.h                                |    2 +
 include/linux/userfaultfd_k.h                      |   92 +-
 include/linux/vm_event_item.h                      |    6 +
 include/linux/vmalloc.h                            |    7 +-
 include/linux/vmstat.h                             |    6 +
 include/trace/events/cma.h                         |   58 +-
 include/trace/events/huge_memory.h                 |    5 +-
 include/trace/events/ksm.h                         |  251 ++
 include/trace/events/mmflags.h                     |   94 +-
 include/uapi/linux/prctl.h                         |    4 +
 include/uapi/linux/userfaultfd.h                   |   17 +-
 init/main.c                                        |   74 +-
 kernel/cgroup/rstat.c                              |    4 +-
 kernel/cpu.c                                       |    2 +-
 kernel/crash_core.c                                |    2 +-
 kernel/dma/pool.c                                  |    6 +-
 kernel/events/ring_buffer.c                        |    2 +-
 kernel/exit.c                                      |    2 +-
 kernel/fork.c                                      |  163 +-
 kernel/kcsan/kcsan_test.c                          |   20 +-
 kernel/kthread.c                                   |   22 +-
 kernel/printk/printk.c                             |    2 +
 kernel/sched/core.c                                |   15 +-
 kernel/sched/fair.c                                |   57 +
 kernel/sys.c                                       |   42 +
 lib/Kconfig.debug                                  |   10 +
 lib/iov_iter.c                                     |   48 +
 lib/maple_tree.c                                   |   78 +-
 lib/show_mem.c                                     |   19 +-
 lib/stackdepot.c                                   |   12 +
 lib/test_printf.c                                  |   26 +
 lib/test_vmalloc.c                                 |   37 +
 lib/vsprintf.c                                     |   21 +
 mm/Kconfig                                         |   37 +-
 mm/Kconfig.debug                                   |   14 +-
 mm/Makefile                                        |    1 +
 mm/backing-dev.c                                   |    4 +-
 mm/cma.c                                           |    1 +
 mm/cma_sysfs.c                                     |    2 +-
 mm/compaction.c                                    |   20 +-
 mm/damon/sysfs-schemes.c                           |    4 +-
 mm/debug.c                                         |    7 +
 mm/debug_vm_pgtable.c                              |   10 +-
 mm/dmapool_test.c                                  |  147 +
 mm/filemap.c                                       |   27 +-
 mm/folio-compat.c                                  |    4 +-
 mm/gup.c                                           |    2 +-
 mm/huge_memory.c                                   |   85 +-
 mm/hugetlb.c                                       |  136 +-
 mm/hugetlb_vmemmap.c                               |   18 +-
 mm/init-mm.c                                       |    3 +
 mm/internal.h                                      |   73 +-
 mm/kasan/hw_tags.c                                 |   14 +-
 mm/kasan/kasan.h                                   |   38 +-
 mm/kasan/kasan_test.c                              |   24 +-
 mm/kasan/quarantine.c                              |   34 +-
 mm/kasan/report.c                                  |   59 +-
 mm/kfence/core.c                                   |   70 +-
 mm/kfence/kfence.h                                 |   10 +-
 mm/kfence/kfence_test.c                            |   22 +-
 mm/kfence/report.c                                 |    2 +-
 mm/khugepaged.c                                    |  437 ++-
 mm/kmsan/core.c                                    |    2 +-
 mm/kmsan/init.c                                    |    6 +-
 mm/kmsan/kmsan_test.c                              |  119 +-
 mm/ksm.c                                           |  191 +-
 mm/madvise.c                                       |   14 +-
 mm/memblock.c                                      |   11 +-
 mm/memcontrol.c                                    |  127 +-
 mm/memfd.c                                         |    6 +-
 mm/memory-failure.c                                |   65 +-
 mm/memory.c                                        |  427 ++-
 mm/memory_hotplug.c                                |   15 +-
 mm/memtest.c                                       |    6 +
 mm/migrate.c                                       |   11 +-
 mm/mincore.c                                       |    2 +-
 mm/mlock.c                                         |    2 +-
 mm/mm_init.c                                       | 2550 ++++++++++++++++
 mm/mmap.c                                          |  292 +-
 mm/mmu_gather.c                                    |    2 +-
 mm/mprotect.c                                      |   53 +-
 mm/mremap.c                                        |   23 +-
 mm/nommu.c                                         |   10 +-
 mm/page-writeback.c                                |   40 -
 mm/page_alloc.c                                    | 3160 ++--------------=
----
 mm/page_isolation.c                                |   12 +-
 mm/page_owner.c                                    |    6 +-
 mm/page_reporting.c                                |    4 +-
 mm/pgtable-generic.c                               |    2 +-
 mm/rmap.c                                          |   50 +-
 mm/shmem.c                                         |  137 +-
 mm/shrinker_debug.c                                |   43 +-
 mm/shuffle.h                                       |    2 +-
 mm/slab.c                                          |    5 +-
 mm/slab.h                                          |    1 +
 mm/slob.c                                          |    6 +-
 mm/slub.c                                          |    9 +-
 mm/sparse-vmemmap.c                                |    3 +-
 mm/sparse.c                                        |    2 +-
 mm/swap_state.c                                    |   19 +-
 mm/swapfile.c                                      |   10 +-
 mm/truncate.c                                      |   15 +-
 mm/userfaultfd.c                                   |  287 +-
 mm/vmalloc.c                                       |  310 +-
 mm/vmscan.c                                        |  383 +--
 mm/vmstat.c                                        |   20 +-
 mm/workingset.c                                    |   28 +-
 mm/zsmalloc.c                                      |  370 +--
 mm/zswap.c                                         |  138 +-
 net/smc/smc_ib.c                                   |    2 +-
 samples/Kconfig                                    |    7 +
 samples/Makefile                                   |    2 +-
 samples/kmemleak/Makefile                          |    2 +-
 scripts/Makefile.kasan                             |    2 +
 security/integrity/ima/ima_crypto.c                |    2 +-
 tools/include/uapi/linux/prctl.h                   |    2 +
 tools/testing/memblock/linux/mmzone.h              |    6 +-
 tools/testing/radix-tree/maple.c                   |   24 +
 tools/testing/selftests/cgroup/test_memcontrol.c   |   15 +
 tools/testing/selftests/memfd/memfd_test.c         |   14 +-
 tools/testing/selftests/mm/.gitignore              |    5 +-
 tools/testing/selftests/mm/Makefile                |   92 +-
 tools/testing/selftests/mm/check_config.sh         |    4 +-
 tools/testing/selftests/mm/cow.c                   |   33 +-
 tools/testing/selftests/mm/gup_test.c              |    5 +-
 tools/testing/selftests/mm/hugepage-mremap.c       |    9 +-
 tools/testing/selftests/mm/hugetlb-madvise.c       |   25 +-
 tools/testing/selftests/mm/khugepaged.c            |    4 +
 tools/testing/selftests/mm/ksm_functional_tests.c  |   97 +-
 tools/testing/selftests/mm/ksm_tests.c             |  174 +-
 tools/testing/selftests/mm/mkdirty.c               |  379 +++
 tools/testing/selftests/mm/mrelease_test.c         |   11 +-
 tools/testing/selftests/mm/run_vmtests.sh          |   46 +-
 tools/testing/selftests/mm/soft-dirty.c            |    3 +
 tools/testing/selftests/mm/split_huge_page_test.c  |   10 +-
 tools/testing/selftests/mm/thuge-gen.c             |   19 +-
 tools/testing/selftests/mm/transhuge-stress.c      |   12 +-
 tools/testing/selftests/mm/uffd-common.c           |  618 ++++
 tools/testing/selftests/mm/uffd-common.h           |  117 +
 tools/testing/selftests/mm/uffd-stress.c           |  481 +++
 tools/testing/selftests/mm/uffd-unit-tests.c       | 1228 ++++++++
 tools/testing/selftests/mm/userfaultfd.c           | 1858 ------------
 tools/testing/selftests/mm/util.h                  |   69 -
 .../mm/{va_128TBswitch.c =3D> va_high_addr_switch.c} |   41 +-
 .../{va_128TBswitch.sh =3D> va_high_addr_switch.sh}  |    6 +-
 tools/testing/selftests/mm/virtual_address_range.c |   24 +-
 tools/testing/selftests/mm/vm_util.c               |  180 +-
 tools/testing/selftests/mm/vm_util.h               |   50 +
 311 files changed, 11825 insertions(+), 8240 deletions(-)
 create mode 100644 include/trace/events/ksm.h
 create mode 100644 mm/dmapool_test.c
 create mode 100644 tools/testing/selftests/mm/mkdirty.c
 create mode 100644 tools/testing/selftests/mm/uffd-common.c
 create mode 100644 tools/testing/selftests/mm/uffd-common.h
 create mode 100644 tools/testing/selftests/mm/uffd-stress.c
 create mode 100644 tools/testing/selftests/mm/uffd-unit-tests.c
 delete mode 100644 tools/testing/selftests/mm/userfaultfd.c
 delete mode 100644 tools/testing/selftests/mm/util.h
 rename tools/testing/selftests/mm/{va_128TBswitch.c =3D> va_high_addr_swit=
ch.c} (86%)
 rename tools/testing/selftests/mm/{va_128TBswitch.sh =3D> va_high_addr_swi=
tch.sh} (89%)

