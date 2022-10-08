Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58015F8751
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 22:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJHUVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 16:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJHUVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 16:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CF42F66F;
        Sat,  8 Oct 2022 13:21:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAB3760AE7;
        Sat,  8 Oct 2022 20:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E252EC433D6;
        Sat,  8 Oct 2022 20:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1665260474;
        bh=Yobe3HpE285ufV/Yr1Ot0qrN7dxB6Ne3AMfveB6Ha38=;
        h=Date:From:To:Cc:Subject:From;
        b=Mm8cAZsaGPLu+I5ObQRkYUGkXRKmTfF6zAr+7W0ioNmUj43CcYzPyCCF9rf6v0s6g
         BNm1rWVVq7WRNfAT+gCnyx2rI56bzSU+K86jNVI2X/wcpNVGZSfmo12pG2iMT67/GX
         LRVDiKqg6Qr9FUEiRHlIYyDoHJnr1WReJZw6jUPs=
Date:   Sat, 8 Oct 2022 13:21:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] MM updates for 6.1-rc1
Message-Id: <20221008132113.919b9b894426297de78ac00f@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus, please merge the MM changes for this release window. It's quite a large one.

I'm seeing two conflicts:

fs/exec.c.  Stephen's resolution is here:
https://lkml.kernel.org/r/20220914155533.70c10493@canb.auug.org.au

include/linux/fortify-string.h.  Stephen's resolution is here:
https://lkml.kernel.org/r/20221004204025.7be8a3be@canb.auug.org.au

Thanks.


The following changes since commit 59298997df89e19aad426d4ae0a7e5037074da5a:

  x86/uaccess: avoid check_object_size() in copy_from_user_nmi() (2022-09-26 12:14:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-10-08

for you to fetch changes up to bbff39cc6cbcb86ccfacb2dcafc79912a9f9df69:

  hugetlb: allocate vma lock for all sharable vmas (2022-10-07 14:28:40 -0700)

----------------------------------------------------------------
- Yu Zhao's Multi-Gen LRU patches are here.  They've been under test in
  linux-next for a couple of months without, to my knowledge, any negative
  reports (or any positive ones, come to that).

- Also the Maple Tree from Liam R.  Howlett.  An overlapping range-based
  tree for vmas.  It it apparently slight more efficient in its own right,
  but is mainly targeted at enabling work to reduce mmap_lock contention.

  Liam has identified a number of other tree users in the kernel which
  could be beneficially onverted to mapletrees.

  Yu Zhao has identified a hard-to-hit but "easy to fix" lockdep splat
  (https://lkml.kernel.org/r/CAOUHufZabH85CeUN-MEMgL8gJGzJEWUrkiM58JkTbBhh-jew0Q@mail.gmail.com).
  This has yet to be addressed due to Liam's unfortunately timed
  vacation.  He is now back and we'll get this fixed up.

- Dmitry Vyukov introduces KMSAN: the Kernel Memory Sanitizer.  It uses
  clang-generated instrumentation to detect used-unintialized bugs down to
  the single bit level.

  KMSAN keeps finding bugs.  New ones, as well as the legacy ones.

- Yang Shi adds a userspace mechanism (madvise) to induce a collapse of
  memory into THPs.

- Zach O'Keefe has expanded Yang Shi's madvise(MADV_COLLAPSE) to support
  file/shmem-backed pages.

- userfaultfd updates from Axel Rasmussen

- zsmalloc cleanups from Alexey Romanov

- cleanups from Miaohe Lin: vmscan, hugetlb_cgroup, hugetlb and memory-failure

- Huang Ying adds enhancements to NUMA balancing memory tiering mode's
  page promotion, with a new way of detecting hot pages.

- memcg updates from Shakeel Butt: charging optimizations and reduced
  memory consumption.

- memcg cleanups from Kairui Song.

- memcg fixes and cleanups from Johannes Weiner.

- Vishal Moola provides more folio conversions

- Zhang Yi removed ll_rw_block() :(

- migration enhancements from Peter Xu

- migration error-path bugfixes from Huang Ying

- Aneesh Kumar added ability for a device driver to alter the memory
  tiering promotion paths.  For optimizations by PMEM drivers, DRM
  drivers, etc.

- vma merging improvements from Jakub Matěn.

- NUMA hinting cleanups from David Hildenbrand.

- xu xin added aditional userspace visibility into KSM merging activity.

- THP & KSM code consolidation from Qi Zheng.

- more folio work from Matthew Wilcox.

- KASAN updates from Andrey Konovalov.

- DAMON cleanups from Kaixu Xia.

- DAMON work from SeongJae Park: fixes, cleanups.

- hugetlb sysfs cleanups from Muchun Song.

- Mike Kravetz fixes locking issues in hugetlbfs and in hugetlb core.

----------------------------------------------------------------
Abel Wu (2):
      mm/mempolicy: fix lock contention on mems_allowed
      mm/page_alloc: only search higher order when fallback

Alexander Potapenko (43):
      stackdepot: reserve 5 extra bits in depot_stack_handle_t
      instrumented.h: allow instrumenting both sides of copy_from_user()
      x86: asm: instrument usercopy in get_user() and put_user()
      asm-generic: instrument usercopy in cacheflush.h
      kmsan: add ReST documentation
      kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
      kmsan: mark noinstr as __no_sanitize_memory
      x86: kmsan: pgtable: reduce vmalloc space
      libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
      kmsan: add KMSAN runtime core
      kmsan: disable instrumentation of unsupported common kernel code
      MAINTAINERS: add entry for KMSAN
      mm: kmsan: maintain KMSAN metadata for page operations
      mm: kmsan: call KMSAN hooks from SLUB code
      kmsan: handle task creation and exiting
      init: kmsan: call KMSAN initialization routines
      instrumented.h: add KMSAN support
      kmsan: add iomap support
      input: libps2: mark data received in __ps2_command() as initialized
      dma: kmsan: unpoison DMA mappings
      virtio: kmsan: check/unpoison scatterlist in vring_map_one_sg()
      kmsan: handle memory sent to/from USB
      kmsan: add tests for KMSAN
      kmsan: disable strscpy() optimization under KMSAN
      crypto: kmsan: disable accelerated configs under KMSAN
      kmsan: disable physical page merging in biovec
      block: kmsan: skip bio block merging logic for KMSAN
      kcov: kmsan: unpoison area->list in kcov_remote_area_put()
      security: kmsan: fix interoperability with auto-initialization
      objtool: kmsan: list KMSAN API functions as uaccess-safe
      x86: kmsan: disable instrumentation of unsupported code
      x86: kmsan: skip shadow checks in __switch_to()
      x86: kmsan: handle open-coded assembly in lib/iomem.c
      x86: kmsan: use __msan_ string functions where possible.
      x86: kmsan: sync metadata pages on page fault
      x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on x86, enable it for KASAN/KMSAN
      x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
      x86: kmsan: don't instrument stack walking functions
      entry: kmsan: introduce kmsan_unpoison_entry_regs()
      bpf: kmsan: initialize BPF registers with zeroes
      mm: fs: initialize fsdata passed to write_begin/write_end interface
      x86: kmsan: enable KMSAN builds for x86
      x86: kmsan: handle CPU entry area

Alexey Romanov (5):
      zsmalloc: zs_object_copy: add clarifying comment
      zsmalloc: remove unnecessary size_class NULL check
      zsmalloc: zs_object_copy: replace email link to doc
      zram: don't retry compress incompressible page
      zsmalloc: use correct types in _first_obj_offset functions

Alistair Popple (4):
      mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes
      mm/gup.c: don't pass gup_flags to check_and_migrate_movable_pages()
      mm/gup.c: refactor check_and_migrate_movable_pages()
      mm/migrate_device.c: fix a misleading and outdated comment

Andrew Morton (3):
      Merge branch 'mm-hotfixes-stable' into mm-stable
      mm/page_alloc.c: rename check_free_page() to free_page_is_bad()
      mm/page_alloc.c: document bulkfree_pcp_prepare() return value

Andrey Konovalov (36):
      kasan: check KASAN_NO_FREE_META in __kasan_metadata_size
      kasan: rename kasan_set_*_info to kasan_save_*_info
      kasan: move is_kmalloc check out of save_alloc_info
      kasan: split save_alloc_info implementations
      kasan: drop CONFIG_KASAN_TAGS_IDENTIFY
      kasan: introduce kasan_print_aux_stacks
      kasan: introduce kasan_get_alloc_track
      kasan: introduce kasan_init_object_meta
      kasan: clear metadata functions for tag-based modes
      kasan: move kasan_get_*_meta to generic.c
      kasan: introduce kasan_requires_meta
      kasan: introduce kasan_init_cache_meta
      kasan: drop CONFIG_KASAN_GENERIC check from kasan_init_cache_meta
      kasan: only define kasan_metadata_size for Generic mode
      kasan: only define kasan_never_merge for Generic mode
      kasan: only define metadata offsets for Generic mode
      kasan: only define metadata structs for Generic mode
      kasan: only define kasan_cache_create for Generic mode
      kasan: pass tagged pointers to kasan_save_alloc/free_info
      kasan: move kasan_get_alloc/free_track definitions
      kasan: cosmetic changes in report.c
      kasan: use virt_addr_valid in kasan_addr_to_page/slab
      kasan: use kasan_addr_to_slab in print_address_description
      kasan: make kasan_addr_to_page static
      kasan: simplify print_report
      kasan: introduce complete_report_info
      kasan: fill in cache and object in complete_report_info
      kasan: rework function arguments in report.c
      kasan: introduce kasan_complete_mode_report_info
      kasan: implement stack ring for tag-based modes
      kasan: support kasan.stacktrace for SW_TAGS
      kasan: dynamically allocate stack ring entries
      kasan: better identify bug types for tag-based modes
      kasan: add another use-after-free test
      kasan: move tests to mm/kasan/
      kasan: better invalid/double-free report header

Aneesh Kumar K.V (10):
      mm/demotion: add support for explicit memory tiers
      mm/demotion: move memory demotion related code
      mm/demotion: add hotplug callbacks to handle new numa node onlined
      mm/demotion/dax/kmem: set node's abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE
      mm/demotion: build demotion targets based on explicit memory tiers
      mm/demotion: add pg_data_t member to track node memory tier details
      mm/demotion: drop memtier from memtype
      mm/demotion: update node_is_toptier to work with memory tiers
      lib/nodemask: optimize node_random for nodemask with single NUMA node
      mm/demotion: expose memory tier details via sysfs

Axel Rasmussen (5):
      selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
      userfaultfd: add /dev/userfaultfd for fine grained access control
      userfaultfd: selftests: modify selftest to use /dev/userfaultfd
      userfaultfd: update documentation to describe /dev/userfaultfd
      selftests: vm: add /dev/userfaultfd test cases to run_vmtests.sh

Baolin Wang (3):
      mm/damon: validate if the pmd entry is present before accessing
      mm/damon: replace pmd_huge() with pmd_trans_huge() for THP
      mm: migrate: do not retry 10 times for the subpages of fail-to-migrate THP

Bui Quang Minh (1):
      mm: skip retry when new limit is not below old one in page_counter_set_max

Charan Teja Kalla (3):
      mm/page_ext: remove unused variable in offline_page_ext
      mm/cma_debug: show complete cma name in debugfs directories
      mm: fix use-after free of page_ext after race with memory-offline

Cheng Li (1):
      mm: use nth_page instead of mem_map_offset mem_map_next

Chih-En Lin (1):
      mm/page_table_check: fix typos

Christoph Hellwig (1):
      mm/swap: remove the end_write_func argument to __swap_writepage

Christophe JAILLET (1):
      mm/mremap_pages: save a few cycles in get_dev_pagemap()

David Heidelberg (1):
      mm: remove EXPERIMENTAL flag for zswap

David Hildenbrand (4):
      mm: fix PageAnonExclusive clearing racing with concurrent RCU GUP-fast
      mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()
      mm/gup: use gup_can_follow_protnone() also in GUP-fast
      mm: fixup documentation regarding pte_numa() and PROT_NUMA

Dawei Li (1):
      mm/damon: improve damon_new_region strategy

Dmitry Vyukov (1):
      x86: add missing include to sparsemem.h

Feng Tang (1):
      mm/hugetlb: add dedicated func to get 'allowed' nodemask for current process

Gaosheng Cui (1):
      mm: remove unused inline functions from include/linux/mm_inline.h

Gerald Schaefer (1):
      s390/hugetlb: switch to generic version of follow_huge_pud()

Haiyue Wang (2):
      mm: migration: fix the FOLL_GET failure on following huge page
      mm: fix the handling Non-LRU pages returned by follow_page

Huang Ying (10):
      memory tiering: hot page selection with hint page fault latency
      memory tiering: rate limit NUMA migration throughput
      memory tiering: adjust hot threshold automatically
      migrate: fix syscall move_pages() return value for failure
      migrate_pages(): remove unnecessary list_safe_reset_next()
      migrate_pages(): fix THP failure counting for -ENOMEM
      migrate_pages(): fix failure counting for THP subpages retrying
      migrate_pages(): fix failure counting for THP on -ENOSYS
      migrate_pages(): fix failure counting for THP splitting
      migrate_pages(): fix failure counting for retry

Imran Khan (1):
      kfence: add sysfs interface to disable kfence for selected slabs.

Jagdish Gediya (1):
      mm/demotion: demote pages according to allocation fallback order

Jakub Matěna (2):
      mm: refactor of vma_merge()
      mm: add merging after mremap resize

Jeff Layton (1):
      tmpfs: add support for an i_version counter

Johannes Weiner (4):
      mm: memcontrol: don't allocate cgroup swap arrays when memcg is disabled
      mm: memcontrol: deprecate swapaccounting=0 mode
      mm: memcontrol: use do_memsw_account() in a few more places
      mm: memcontrol: drop dead CONFIG_MEMCG_SWAP config symbol

Kairui Song (3):
      mm/util: reduce stack usage of folio_mapcount
      mm: memcontrol: use memcg_kmem_enabled in count_objcg_event
      mm: memcontrol: make cgroup_memory_noswap a static key

Kaixu Xia (15):
      mm/damon/core: simplify the parameter passing for region split operation
      mm/damon: simplify the parameter passing for 'check_accesses'
      mm/damon/vaddr: remove comparison between mm and last_mm when checking region accesses
      mm/damon: get the hotness from damon_hot_score() in damon_pageout_score()
      mm/damon/sysfs: simplify the judgement whether kdamonds are busy
      mm/damon/core: iterate the regions list from current point in damon_set_regions()
      mm/damon/vaddr: add a comment for 'default' case in damon_va_apply_scheme()
      mm/damon/sysfs: use the wrapper directly to check if the kdamond is running
      mm/damon: simplify the parameter passing for 'prepare_access_checks'
      mm/damon/sysfs: simplify the variable 'pid' assignment operation
      mm/damon/core: simplify the kdamond stop mechanism by removing 'done'
      mm/damon: use 'struct damon_target *' instead of 'void *' in target_valid()
      mm/damon: return void from damon_set_schemes()
      mm/damon: rename damon_pageout_score() to damon_cold_score()
      mm/damon: deduplicate damon_{reclaim,lru_sort}_apply_parameters()

Kassey Li (1):
      mm/page_owner.c: add llseek for page_owner

Ke Sun (1):
      mm/filemap: make folio_put_wait_locked static

Kefeng Wang (12):
      mm: memory-failure: cleanup try_to_split_thp_page()
      mm/util.c: add warning if __vm_enough_memory fails
      mm: kill find_min_pfn_with_active_regions()
      mm: memory-failure: kill soft_offline_free_page()
      mm: memory-failure: kill __soft_offline_page()
      mm: kill is_memblock_offlined()
      mm: fix null-ptr-deref in kswapd_is_running()
      mm: remove BUG_ON() in __isolate_free_page()
      mm: reuse pageblock_start/end_pfn() macro
      mm: add pageblock_align() macro
      mm: add pageblock_aligned() macro
      memblock tests: add new pageblock related macro

Kenneth Lee (1):
      mm/damon/dbgfs: use kmalloc for allocating only one element

Li Zhe (1):
      page_ext: introduce boot parameter 'early_page_ext'

Li kunyu (1):
      page_alloc: remove inactive initialization

Li zeming (1):
      mm/hugetlb.c: remove unnecessary initialization of local `err'

Liam Howlett (1):
      mm/mlock: drop dead code in count_mm_mlocked_page_nr()

Liam R. Howlett (45):
      Maple Tree: add new data structure
      radix tree test suite: add pr_err define
      radix tree test suite: add kmem_cache_set_non_kernel()
      radix tree test suite: add allocation counts and size to kmem_cache
      radix tree test suite: add support for slab bulk APIs
      radix tree test suite: add lockdep_is_held to header
      lib/test_maple_tree: add testing for maple tree
      mm: start tracking VMAs with maple tree
      mm/mmap: use the maple tree in find_vma() instead of the rbtree.
      mm/mmap: use the maple tree for find_vma_prev() instead of the rbtree
      mm/mmap: use maple tree for unmapped_area{_topdown}
      kernel/fork: use maple tree for dup_mmap() during forking
      damon: convert __damon_va_three_regions to use the VMA iterator
      mm: remove rb tree.
      mmap: change zeroing of maple tree in __vma_adjust()
      xen: use vma_lookup() in privcmd_ioctl_mmap()
      mm: optimize find_exact_vma() to use vma_lookup()
      mm/khugepaged: optimize collapse_pte_mapped_thp() by using vma_lookup()
      mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()
      mm: use maple tree operations for find_vma_intersection()
      mm/mmap: use advanced maple tree API for mmap_region()
      mm: remove vmacache
      mm: convert vma_lookup() to use mtree_load()
      mm/mmap: move mmap_region() below do_munmap()
      mm/mmap: reorganize munmap to use maple states
      mm/mmap: change do_brk_munmap() to use do_mas_align_munmap()
      arm64: Change elfcore for_each_mte_vma() to use VMA iterator
      fs/proc/base: use the vma iterators in place of linked list
      userfaultfd: use maple tree iterator to iterate VMAs
      ipc/shm: use VMA iterator instead of linked list
      bpf: remove VMA linked list
      mm/gup: use maple tree navigation instead of linked list
      mm/madvise: use vma_find() instead of vma linked list
      mm/memcontrol: stop using mm->highest_vm_end
      mm/mempolicy: use vma iterator & maple state instead of vma linked list
      mm/mprotect: use maple tree navigation instead of VMA linked list
      mm/mremap: use vma_find_intersection() instead of vma linked list
      mm/msync: use vma_find() instead of vma linked list
      mm/oom_kill: use vma iterators instead of vma linked list
      mm/swapfile: use vma iterator instead of vma linked list
      riscv: use vma iterator for vdso
      mm/vmscan: use vma iterator instead of vm_next
      mm: remove the vma linked list
      mm/mmap: drop range_has_overlap() function
      mm/mmap.c: pass in mapping to __vma_link_file()

Liu Shixin (8):
      mm/thp: simplify has_transparent_hugepage by using IS_BUILTIN
      mm/thp: remove redundant CONFIG_TRANSPARENT_HUGEPAGE
      mm/kmemleak: make create_object return void
      mm/shuffle: convert module_param_call to module_param_cb
      mm: kfence: convert to DEFINE_SEQ_ATTRIBUTE
      mm/huge_memory: prevent THP_ZERO_PAGE_ALLOC increased twice
      mm/memcontrol: use kstrtobool for swapaccount param parsing
      mm: hugetlb: fix UAF in hugetlb_handle_userfault

Matthew Wilcox (1):
      mm/vmalloc.c: support HIGHMEM pages in vmap_pages_range_noflush()

Matthew Wilcox (Oracle) (82):
      mm: add VMA iterator
      mmap: use the VMA iterator in count_vma_pages_range()
      proc: remove VMA rbtree use from nommu
      arm64: remove mmap linked list from vdso
      parisc: remove mmap linked list from cache handling
      powerpc: remove mmap linked list walks
      s390: remove vma linked list walks
      x86: remove vma linked list walks
      xtensa: remove vma linked list walks
      cxl: remove vma linked list walk
      optee: remove vma linked list walk
      um: remove vma linked list walk
      coredump: remove vma linked list walk
      exec: use VMA iterator instead of linked list
      fs/proc/task_mmu: stop using linked list and highest_vm_end
      acct: use VMA iterator instead of linked list
      perf: use VMA iterator
      sched: use maple tree iterator to walk VMAs
      fork: use VMA iterator
      mm/khugepaged: stop using vma linked list
      mm/ksm: use vma iterators instead of vma linked list
      mm/mlock: use vma iterator and maple state instead of vma linked list
      mm/pagewalk: use vma_find() instead of vma linked list
      i915: use the VMA iterator
      nommu: remove uses of VMA linked list
      mm/vmscan: fix a lot of comments
      mm: add the first tail page to struct folio
      mm: reimplement folio_order() and folio_nr_pages()
      mm: add split_folio()
      mm: add folio_add_lru_vma()
      shmem: convert shmem_writepage() to use a folio throughout
      shmem: convert shmem_delete_from_page_cache() to take a folio
      shmem: convert shmem_replace_page() to use folios throughout
      mm/swapfile: remove page_swapcount()
      mm/swapfile: convert try_to_free_swap() to folio_free_swap()
      mm/swap: convert __read_swap_cache_async() to use a folio
      mm/swap: convert add_to_swap_cache() to take a folio
      mm/swap: convert put_swap_page() to put_swap_folio()
      mm: convert do_swap_page() to use a folio
      mm: convert do_swap_page()'s swapcache variable to a folio
      memcg: convert mem_cgroup_swapin_charge_page() to mem_cgroup_swapin_charge_folio()
      shmem: convert shmem_mfill_atomic_pte() to use a folio
      shmem: convert shmem_replace_page() to shmem_replace_folio()
      swap: add swap_cache_get_folio()
      shmem: eliminate struct page from shmem_swapin_folio()
      shmem: convert shmem_getpage_gfp() to shmem_get_folio_gfp()
      shmem: convert shmem_fault() to use shmem_get_folio_gfp()
      shmem: convert shmem_read_mapping_page_gfp() to use shmem_get_folio_gfp()
      shmem: add shmem_get_folio()
      shmem: convert shmem_get_partial_folio() to use shmem_get_folio()
      shmem: convert shmem_write_begin() to use shmem_get_folio()
      shmem: convert shmem_file_read_iter() to use shmem_get_folio()
      shmem: convert shmem_fallocate() to use a folio
      shmem: convert shmem_symlink() to use a folio
      shmem: convert shmem_get_link() to use a folio
      khugepaged: call shmem_get_folio()
      userfaultfd: convert mcontinue_atomic_pte() to use a folio
      shmem: remove shmem_getpage()
      swapfile: convert try_to_unuse() to use a folio
      swapfile: convert __try_to_reclaim_swap() to use a folio
      swapfile: convert unuse_pte_range() to use a folio
      mm: convert do_swap_page() to use swap_cache_get_folio()
      mm: remove lookup_swap_cache()
      swap_state: convert free_swap_cache() to use a folio
      swap: convert swap_writepage() to use a folio
      mm: convert do_wp_page() to use a folio
      huge_memory: convert do_huge_pmd_wp_page() to use a folio
      madvise: convert madvise_free_pte_range() to use a folio
      uprobes: use folios more widely in __replace_page()
      ksm: use a folio in replace_page()
      mm: convert do_swap_page() to use folio_free_swap()
      memcg: convert mem_cgroup_swap_full() to take a folio
      mm: remove try_to_free_swap()
      rmap: convert page_move_anon_rmap() to use a folio
      migrate: convert __unmap_and_move() to use folios
      migrate: convert unmap_and_move_huge_page() to use folios
      huge_memory: convert split_huge_page_to_list() to use a folio
      huge_memory: convert unmap_page() to unmap_folio()
      mm: convert page_get_anon_vma() to folio_get_anon_vma()
      rmap: remove page_unlock_anon_vma_read()
      uprobes: use new_folio in __replace_page()
      mm: convert lock_page_or_retry() to folio_lock_or_retry()

Matthias Goergens (1):
      hugetlb_encode.h: fix undefined behaviour (34 << 26)

Miaohe Lin (50):
      hugetlb_cgroup: remove unneeded nr_pages > 0 check
      hugetlb_cgroup: hugetlbfs: use helper macro SZ_1{K,M,G}
      hugetlb_cgroup: remove unneeded return value
      hugetlb_cgroup: use helper macro NUMA_NO_NODE
      hugetlb_cgroup: use helper for_each_hstate and hstate_index
      mm/hugetlb: fix incorrect update of max_huge_pages
      mm/hugetlb: fix WARN_ON(!kobj) in sysfs_create_group()
      mm/hugetlb: fix missing call to restore_reserve_on_error()
      mm: hugetlb_vmemmap: add missing smp_wmb() before set_pte_at()
      mm/hugetlb: fix sysfs group leak in hugetlb_unregister_node()
      mm/hugetlb: make detecting shared pte more reliable
      mm, hwpoison: fix page refcnt leaking in try_memory_failure_hugetlb()
      mm, hwpoison: fix page refcnt leaking in unpoison_memory()
      mm, hwpoison: fix extra put_page() in soft_offline_page()
      mm, hwpoison: fix possible use-after-free in mf_dax_kill_procs()
      mm, hwpoison: kill procs if unmap fails
      mm, hwpoison: avoid trying to unpoison reserved page
      hugetlb: make hugetlb_cma_check() static
      hugetlb: Use helper macro SZ_1K
      hugetlb: use LIST_HEAD() to define a list head
      hugetlb: use sizeof() to get the array size
      hugetlb: use helper {huge_pte|pmd}_lock()
      hugetlb: pass NULL to kobj_to_hstate() if nid is unused
      hugetlb: kill hugetlbfs_pagecache_page()
      hugetlb: add comment for subtle SetHPageVmemmapOptimized()
      hugetlb: remove meaningless BUG_ON(huge_pte_none())
      hugetlb: make hugetlb depends on SYSFS or SYSCTL
      mm, hwpoison: use ClearPageHWPoison() in memory_failure()
      mm, hwpoison: use __PageMovable() to detect non-lru movable pages
      mm, hwpoison: use num_poisoned_pages_sub() to decrease num_poisoned_pages
      mm, hwpoison: avoid unneeded page_mapped_in_vma() overhead in collect_procs_anon()
      mm, hwpoison: check PageTable() explicitly in hwpoison_user_mappings()
      mm, hwpoison: cleanup some obsolete comments
      writeback: remove unused macro DIRTY_FULL_SCOPE
      mm/page_alloc: ensure kswapd doesn't accidentally go to sleep
      mm/page_alloc: make zone_pcp_update() static
      mm: remove obsolete macro NR_PCP_ORDER_MASK and NR_PCP_ORDER_WIDTH
      mm/page_alloc: remove obsolete comment in zone_statistics()
      mm/page_alloc: add __init annotations to init_mem_debugging_and_hardening()
      mm/page_alloc: fix freeing static percpu memory
      mm: remove obsolete pgdat_is_empty()
      mm/page_alloc: add missing is_migrate_isolate() check in set_page_guard()
      mm/page_alloc: use local variable zone_idx directly
      mm, memory_hotplug: remove obsolete generic_free_nodedata()
      mm/page_alloc: make boot_nodestats static
      mm/page_alloc: use helper macro SZ_1{K,M}
      mm/page_alloc: init local variable buddy_pfn
      mm/page_alloc: use costly_order in WARN_ON_ONCE_GFP()
      mm/page_alloc: remove obsolete gfpflags_normal_context()
      mm/page_alloc: fix obsolete comment in deferred_pfn_valid()

Michal Hocko (1):
      mm: reduce noise in show_mem for lowmem allocations

Mika Penttilä (1):
      mm/hmm/test: use char dev with struct device to get device node

Mike Kravetz (13):
      hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
      hugetlbfs: revert use i_mmap_rwsem for more pmd sharing synchronization
      hugetlb: rename remove_huge_page to hugetlb_delete_from_page_cache
      hugetlb: create remove_inode_single_folio to remove single file folio
      hugetlb: rename vma_shareable() and refactor code
      hugetlb: add vma based lock for pmd sharing
      hugetlb: create hugetlb_unmap_file_folio to unmap single file folio
      hugetlb: use new vma_lock for pmd sharing synchronization
      hugetlb: clean up code checking for fault/truncation races
      hugetlb: freeze allocated pages before creating hugetlb pages
      hugetlb: fix vma lock handling during split vma and range unmapping
      hugetlb: take hugetlb vma_lock when clearing vma_lock->vma pointer
      hugetlb: allocate vma lock for all sharable vmas

Muchun Song (3):
      mm: hugetlb_vmemmap: simplify reset_struct_pages()
      mm: hugetlb: simplify per-node sysfs creation and removal
      mm: hugetlb: eliminate memory-less nodes handling

Peter Collingbourne (1):
      mm: add more BUILD_BUG_ONs to gfp_migratetype()

Peter Xu (7):
      mm/x86: use SWP_TYPE_BITS in 3-level swap macros
      mm/swap: comment all the ifdef in swapops.h
      mm/swap: add swp_offset_pfn() to fetch PFN from swap entry
      mm/thp: carry over dirty bit when thp splits on pmd
      mm: remember young/dirty bit for page migrations
      mm/swap: cache maximum swapfile size when init swap
      mm/swap: cache swap migration A/D bits support

Qi Zheng (8):
      mm: thp: remove redundant pgtable check in set_huge_zero_page()
      mm: introduce common struct mm_slot
      mm: thp: convert to use common struct mm_slot
      ksm: remove redundant declarations in ksm.h
      ksm: add the ksm prefix to the names of the ksm private structures
      ksm: convert ksm_mm_slot.mm_list to ksm_mm_slot.mm_node
      ksm: convert ksm_mm_slot.link to ksm_mm_slot.hash
      ksm: convert to use common struct mm_slot

Ran Xiaokai (1):
      mm/page_alloc: update comments for rmqueue()

Rik van Riel (1):
      mm: align larger anonymous mappings on THP boundaries

Rolf Eike Beer (2):
      mm: pagewalk: fix documentation of PTE hole handling
      mm: pagewalk: add api documentation for walk_page_range_novma()

SeongJae Park (29):
      selftest/damon: add a test for duplicate context dirs creation
      mm/damon/core: avoid holes in newly set monitoring target ranges
      mm/damon/core-test: test damon_set_regions
      Docs/admin-guide/mm/damon: rename the title of the document
      mm/damon/Kconfig: notify debugfs deprecation plan
      Docs/admin-guide/mm/damon/start: mention the dependency as sysfs instead of debugfs
      Docs/admin-guide/mm/damon/usage: note DAMON debugfs interface deprecation plan
      mm/damon/paddr: make supported DAMOS actions of paddr clear
      mm/damon/paddr: deduplicate damon_pa_{mark_accessed,deactivate_pages}()
      mm/damon/core: copy struct-to-struct instead of field-to-field in damon_new_scheme()
      mm/damon/core: factor out 'damos_quota' private fileds initialization
      mm/damon/core: use a dedicated struct for monitoring attributes
      mm/damon/core: reduce parameters for damon_set_attrs()
      mm/damon/reclaim: use 'struct damon_attrs' for storing parameters for it
      mm/damon/lru_sort: use 'struct damon_attrs' for storing parameters for it
      mm/damon: implement a monitoring attributes module parameters generator macro
      mm/damon/lru_sort: use monitoring attributes parameters generaotr macro
      mm/damon/reclaim: use monitoring attributes parameters generator macro
      mm/damon/modules-common: implement a watermarks module parameters generator macro
      mm/damon/lru_sort: use watermarks parameters generator macro
      mm/damon/reclaim: use watermarks parameters generator macro
      mm/damon/modules-common: implement a stats parameters generator macro
      mm/damon/reclaim: use stat parameters generator
      mm/damon/lru_sort: use stat generator
      mm/damon/modules-common: implement a damos quota params generator
      mm/damon/modules-common: implement damos time quota params generator
      mm/damon/reclaim: use the quota params generator macro
      mm/damon/lru_sort: use quotas param generator
      mm/damon/lru_sort: deduplicate hot/cold schemes generators

Sergey Senozhatsky (3):
      drivers/block/zram/zram_drv.c: do not keep dangling zcomp pointer after zram reset
      zram: do not waste zram_table_entry flags bits
      zram: keep comments within 80-columns limit

Shakeel Butt (7):
      mm: page_counter: remove unneeded atomic ops for low/min
      mm: page_counter: rearrange struct page_counter fields
      memcg: increase MEMCG_CHARGE_BATCH to 64
      mm: deduplicate cacheline padding code
      memcg: extract memcg_vmstats from struct mem_cgroup
      memcg: rearrange code
      memcg: reduce size of memcg vmstats structures

Shaoqin Huang (1):
      mm/filemap.c: convert page_endio() to use a folio

Song Liu (1):
      mm/vmalloc: extend find_vmap_lowest_match_check with extra arguments

Suren Baghdasaryan (2):
      mm: drop oom code from exit_mmap
      mm: delete unused MMF_OOM_VICTIM flag

Tarun Sahu (2):
      Kselftests: remove support of libhugetlbfs from kselftests
      selftest: vm: remove deleted local_config.* from .gitignore

Vishal Moola (Oracle) (8):
      filemap: add filemap_get_folios_contig()
      btrfs: convert __process_pages_contig() to use filemap_get_folios_contig()
      btrfs: convert end_compressed_writeback() to use filemap_get_folios()
      btrfs: convert process_page_range() to use filemap_get_folios_contig()
      nilfs2: convert nilfs_find_uncommited_extent() to use filemap_get_folios_contig()
      ramfs: convert ramfs_nommu_get_unmapped_area() to use filemap_get_folios_contig()
      filemap: remove find_get_pages_contig()
      filemap: convert filemap_range_has_writeback() to use folios

XU pengfei (1):
      mm/hugetlb: remove unnecessary 'NULL' values from pointer

Xin Hao (8):
      mm/damon: simplify damon_ctx check in damon_sysfs_before_terminate
      mm/damon: remove duplicate get_monitoring_region() definitions
      mm/damon/sysfs: change few functions execute order
      mm/damon: simplify scheme create in damon_lru_sort_apply_parameters
      mm/damon/sysfs: avoid call damon_target_has_pid() repeatedly
      mm/damon: simplify scheme create in lru_sort.c
      mm/damon/sysfs: return 'err' value when call kstrtoul() failed
      mm/hugetlb: add available_huge_pages() func

Xiu Jianfeng (4):
      mm/hwpoison: add __init/__exit annotations to module init/exit funcs
      mm/rodata_test: use PAGE_ALIGNED() helper
      mm/secretmem: add __init annotation to secretmem_init()
      mm/secretmem: remove reduntant return value

Yajun Deng (1):
      mm/damon: introduce struct damos_access_pattern

Yang Shi (3):
      mm: khugepaged: don't carry huge page to the next loop for !CONFIG_NUMA
      mm: memcg: export workingset refault stats for cgroup v1
      mm: MADV_COLLAPSE: refetch vm_end after reacquiring mmap_lock

Yang Yang (5):
      mm/vmscan: define macros for refaults in struct lruvec
      mm/vmscan: make the annotations of refaults code at the right place
      filemap: make the accounting of thrashing more consistent
      delayacct: support re-entrance detection of thrashing accounting
      mm/page_io: count submission time as thrashing delay for delayacct

Yang Yingliang (2):
      mm/damon/reclaim: change damon_reclaim_wmarks to static
      mm/damon/lru_sort: change damon_lru_sort_wmarks to static

Yin Fengwei (1):
      mm: release private data before split THP

Yixuan Cao (1):
      tools/vm/page_owner_sort: fix -f option

Yu Zhao (16):
      mm: x86, arm64: add arch_has_hw_pte_young()
      mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
      mm/vmscan.c: refactor shrink_node()
      Revert "include/linux/mm_inline.h: fold __update_lru_size() into its sole caller"
      mm: multi-gen LRU: groundwork
      mm: multi-gen LRU: minimal implementation
      mm: multi-gen LRU: exploit locality in rmap
      mm: multi-gen LRU: support page table walks
      mm: multi-gen LRU: optimize multiple memcgs
      mm: multi-gen LRU: kill switch
      mm: multi-gen LRU: thrashing prevention
      mm: multi-gen LRU: debugfs interface
      mm: multi-gen LRU: admin guide
      mm: multi-gen LRU: design doc
      mm/mglru: don't sync disk for each aging cycle
      mglru: mm/vmscan.c: fix imprecise comments

Zach O'Keefe (27):
      mm/khugepaged: add struct collapse_control
      mm/khugepaged: dedup and simplify hugepage alloc and charging
      mm/khugepaged: propagate enum scan_result codes back to callers
      mm/khugepaged: add flag to predicate khugepaged-only behavior
      mm/thp: add flag to enforce sysfs THP in hugepage_vma_check()
      mm/khugepaged: record SCAN_PMD_MAPPED when scan_pmd() finds hugepage
      mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse
      mm/khugepaged: rename prefix of shared collapse functions
      mm/madvise: add MADV_COLLAPSE to process_madvise()
      selftests/vm: modularize collapse selftests
      selftests/vm: dedup hugepage allocation logic
      selftests/vm: add MADV_COLLAPSE collapse context to selftests
      selftests/vm: add selftest to verify recollapse of THPs
      selftests/vm: add selftest to verify multi THP collapse
      mm/khugepaged: check compound_order() in collapse_pte_mapped_thp()
      mm/madvise: MADV_COLLAPSE return EAGAIN when page cannot be isolated
      selftests/vm: retry on EAGAIN for MADV_COLLAPSE selftest
      mm/shmem: add flag to enforce shmem THP in hugepage_vma_check()
      mm/khugepaged: attempt to map file/shmem-backed pte-mapped THPs by pmds
      mm/madvise: add file and shmem support to MADV_COLLAPSE
      mm/khugepaged: add tracepoint to hpage_collapse_scan_file()
      selftests/vm: dedup THP helpers
      selftests/vm: modularize thp collapse memory operations
      selftests/vm: add thp collapse file and tmpfs testing
      selftests/vm: add thp collapse shmem testing
      selftests/vm: add file/shmem MADV_COLLAPSE selftest for cleared pmd
      selftests/vm: add selftest for MADV_COLLAPSE of uffd-minor memory

Zhang Yi (14):
      fs/buffer: remove __breadahead_gfp()
      fs/buffer: add some new buffer read helpers
      fs/buffer: replace ll_rw_block()
      gfs2: replace ll_rw_block()
      isofs: replace ll_rw_block()
      jbd2: replace ll_rw_block()
      ntfs3: replace ll_rw_block()
      ocfs2: replace ll_rw_block()
      reiserfs: replace ll_rw_block()
      udf: replace ll_rw_block()
      ufs: replace ll_rw_block()
      fs/buffer: remove ll_rw_block() helper
      ext2: replace bh_submit_read() helper with bh_read()
      fs/buffer: remove bh_submit_read() helper

Zhenhua Huang (1):
      mm/page_owner.c: remove redundant drain_all_pages

Zi Yan (1):
      arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER

xu xin (2):
      ksm: count allocated ksm rmap_items for each process
      ksm: add profit monitoring documentation

xupanda (1):
      mm: memcontrol: fix a typo in comment

ye xingchen (1):
      mm: backing-dev: Remove the unneeded result variable

ze zuo (1):
      mm/mempolicy: use PAGE_ALIGN instead of open-coding it

zezuo (1):
      mm/page_alloc.c: delete a redundant parameter of rmqueue_pcplist

 .../ABI/testing/sysfs-kernel-mm-memory-tiers       |    25 +
 Documentation/accounting/delay-accounting.rst      |     2 +-
 Documentation/admin-guide/cgroup-v1/memory.rst     |     4 +-
 Documentation/admin-guide/kernel-parameters.txt    |    14 +-
 Documentation/admin-guide/mm/cma_debugfs.rst       |    10 +-
 Documentation/admin-guide/mm/damon/index.rst       |     6 +-
 Documentation/admin-guide/mm/damon/start.rst       |    13 +-
 Documentation/admin-guide/mm/damon/usage.rst       |     5 +
 Documentation/admin-guide/mm/index.rst             |     1 +
 Documentation/admin-guide/mm/ksm.rst               |    36 +
 Documentation/admin-guide/mm/multigen_lru.rst      |   162 +
 Documentation/admin-guide/mm/transhuge.rst         |    16 +-
 Documentation/admin-guide/mm/userfaultfd.rst       |    41 +-
 Documentation/admin-guide/sysctl/kernel.rst        |    11 +
 Documentation/admin-guide/sysctl/vm.rst            |     3 +
 Documentation/core-api/index.rst                   |     1 +
 Documentation/core-api/maple_tree.rst              |   217 +
 Documentation/core-api/mm-api.rst                  |     3 -
 Documentation/dev-tools/index.rst                  |     1 +
 Documentation/dev-tools/kasan.rst                  |    17 +-
 Documentation/dev-tools/kmsan.rst                  |   427 +
 Documentation/mm/index.rst                         |     1 +
 Documentation/mm/ksm.rst                           |     2 +-
 Documentation/mm/multigen_lru.rst                  |   159 +
 Documentation/mm/page_owner.rst                    |     5 +
 MAINTAINERS                                        |    27 +-
 Makefile                                           |     1 +
 arch/Kconfig                                       |     8 +
 arch/alpha/include/uapi/asm/mman.h                 |     2 +
 arch/arc/Kconfig                                   |     2 +-
 arch/arm/Kconfig                                   |     2 +-
 arch/arm/configs/imx_v6_v7_defconfig               |     2 +-
 arch/arm/configs/milbeaut_m10v_defconfig           |     2 +-
 arch/arm/configs/oxnas_v6_defconfig                |     2 +-
 arch/arm/configs/pxa_defconfig                     |     2 +-
 arch/arm/configs/sama7_defconfig                   |     2 +-
 arch/arm/configs/sp7021_defconfig                  |     2 +-
 arch/arm64/Kconfig                                 |     2 +-
 arch/arm64/include/asm/pgtable.h                   |    15 +-
 arch/arm64/kernel/elfcore.c                        |    16 +-
 arch/arm64/kernel/vdso.c                           |     3 +-
 arch/arm64/mm/hugetlbpage.c                        |     2 +-
 arch/csky/Kconfig                                  |     2 +-
 arch/ia64/Kconfig                                  |     2 +-
 arch/ia64/include/asm/sparsemem.h                  |     6 +-
 arch/loongarch/Kconfig                             |     2 +-
 arch/m68k/Kconfig.cpu                              |     2 +-
 arch/mips/Kconfig                                  |     2 +-
 arch/mips/configs/db1xxx_defconfig                 |     1 -
 arch/mips/configs/generic_defconfig                |     1 -
 arch/mips/include/uapi/asm/mman.h                  |     2 +
 arch/nios2/Kconfig                                 |     2 +-
 arch/parisc/include/uapi/asm/mman.h                |     2 +
 arch/parisc/kernel/cache.c                         |     9 +-
 arch/powerpc/Kconfig                               |     2 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig       |     2 +-
 arch/powerpc/configs/fsl-emb-nonhw.config          |     2 +-
 arch/powerpc/configs/powernv_defconfig             |     1 -
 arch/powerpc/configs/pseries_defconfig             |     1 -
 arch/powerpc/kernel/vdso.c                         |     6 +-
 arch/powerpc/mm/book3s32/tlb.c                     |    11 +-
 arch/powerpc/mm/book3s64/subpage_prot.c            |    13 +-
 arch/riscv/kernel/vdso.c                           |     3 +-
 arch/s390/kernel/vdso.c                            |     3 +-
 arch/s390/lib/uaccess.c                            |     3 +-
 arch/s390/mm/gmap.c                                |     6 +-
 arch/s390/mm/hugetlbpage.c                         |    10 -
 arch/sh/configs/ecovec24_defconfig                 |     2 +-
 arch/sh/configs/sdk7786_defconfig                  |     1 -
 arch/sh/configs/urquell_defconfig                  |     1 -
 arch/sh/mm/Kconfig                                 |     2 +-
 arch/sparc/Kconfig                                 |     2 +-
 arch/um/kernel/tlb.c                               |    14 +-
 arch/x86/Kconfig                                   |    10 +-
 arch/x86/boot/Makefile                             |     1 +
 arch/x86/boot/compressed/Makefile                  |     1 +
 arch/x86/entry/vdso/Makefile                       |     3 +
 arch/x86/entry/vdso/vma.c                          |     9 +-
 arch/x86/include/asm/checksum.h                    |    16 +-
 arch/x86/include/asm/kmsan.h                       |    87 +
 arch/x86/include/asm/page_64.h                     |     7 +
 arch/x86/include/asm/pgtable-3level.h              |     8 +-
 arch/x86/include/asm/pgtable.h                     |     9 +-
 arch/x86/include/asm/pgtable_64_types.h            |    47 +-
 arch/x86/include/asm/sparsemem.h                   |     2 +
 arch/x86/include/asm/string_64.h                   |    23 +-
 arch/x86/include/asm/uaccess.h                     |    22 +-
 arch/x86/kernel/Makefile                           |     2 +
 arch/x86/kernel/cpu/Makefile                       |     1 +
 arch/x86/kernel/dumpstack.c                        |     6 +
 arch/x86/kernel/process_64.c                       |     1 +
 arch/x86/kernel/tboot.c                            |     2 +-
 arch/x86/kernel/unwind_frame.c                     |    11 +
 arch/x86/lib/Makefile                              |     2 +
 arch/x86/lib/iomem.c                               |     5 +
 arch/x86/mm/Makefile                               |     5 +
 arch/x86/mm/fault.c                                |    23 +-
 arch/x86/mm/init.c                                 |     2 +-
 arch/x86/mm/init_64.c                              |     2 +-
 arch/x86/mm/ioremap.c                              |     3 +
 arch/x86/mm/kmsan_shadow.c                         |    20 +
 arch/x86/mm/pgtable.c                              |     5 +-
 arch/x86/realmode/rm/Makefile                      |     1 +
 arch/xtensa/Kconfig                                |     2 +-
 arch/xtensa/include/uapi/asm/mman.h                |     2 +
 arch/xtensa/kernel/syscall.c                       |    18 +-
 block/bio.c                                        |     2 +
 block/blk.h                                        |     7 +
 crypto/Kconfig                                     |    30 +
 drivers/base/memory.c                              |     6 -
 drivers/base/node.c                                |   141 +-
 drivers/block/zram/zram_drv.c                      |    38 +-
 drivers/block/zram/zram_drv.h                      |    15 +-
 drivers/dax/kmem.c                                 |    42 +-
 drivers/firmware/efi/efi.c                         |     2 +-
 drivers/firmware/efi/libstub/Makefile              |     1 +
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |    14 +-
 drivers/input/serio/libps2.c                       |     5 +-
 drivers/misc/cxl/fault.c                           |    45 +-
 drivers/net/Kconfig                                |     1 +
 drivers/nvdimm/nd.h                                |     2 +-
 drivers/nvdimm/pfn_devs.c                          |     2 +-
 drivers/tee/optee/call.c                           |    18 +-
 drivers/usb/core/urb.c                             |     2 +
 drivers/virtio/virtio_ring.c                       |    10 +-
 drivers/xen/privcmd.c                              |     2 +-
 fs/Kconfig                                         |     1 +
 fs/btrfs/compression.c                             |    31 +-
 fs/btrfs/extent_io.c                               |    33 +-
 fs/btrfs/subpage.c                                 |     2 +-
 fs/btrfs/tests/extent-io-tests.c                   |    32 +-
 fs/buffer.c                                        |   158 +-
 fs/coredump.c                                      |    34 +-
 fs/exec.c                                          |    14 +-
 fs/ext2/balloc.c                                   |     7 +-
 fs/fuse/dev.c                                      |     3 +-
 fs/gfs2/meta_io.c                                  |     7 +-
 fs/gfs2/quota.c                                    |     8 +-
 fs/hugetlbfs/inode.c                               |   300 +-
 fs/isofs/compress.c                                |     2 +-
 fs/jbd2/journal.c                                  |    15 +-
 fs/jbd2/recovery.c                                 |    16 +-
 fs/namei.c                                         |     2 +-
 fs/nilfs2/page.c                                   |    45 +-
 fs/ntfs3/inode.c                                   |     7 +-
 fs/ocfs2/aops.c                                    |     2 +-
 fs/ocfs2/super.c                                   |     4 +-
 fs/posix_acl.c                                     |     3 +
 fs/proc/base.c                                     |    20 +-
 fs/proc/internal.h                                 |     2 +-
 fs/proc/task_mmu.c                                 |    96 +-
 fs/proc/task_nommu.c                               |    45 +-
 fs/ramfs/file-nommu.c                              |    50 +-
 fs/reiserfs/journal.c                              |    11 +-
 fs/reiserfs/stree.c                                |     4 +-
 fs/reiserfs/super.c                                |     4 +-
 fs/udf/dir.c                                       |     2 +-
 fs/udf/directory.c                                 |     2 +-
 fs/udf/inode.c                                     |     8 +-
 fs/ufs/balloc.c                                    |    12 +-
 fs/userfaultfd.c                                   |   133 +-
 include/asm-generic/cacheflush.h                   |    14 +-
 include/linux/buffer_head.h                        |    48 +-
 include/linux/cache.h                              |    13 +
 include/linux/cgroup.h                             |    15 +-
 include/linux/compiler-clang.h                     |    23 +
 include/linux/compiler-gcc.h                       |     6 +
 include/linux/compiler_types.h                     |     3 +-
 include/linux/damon.h                              |    86 +-
 include/linux/delayacct.h                          |    16 +-
 include/linux/fortify-string.h                     |     2 +
 include/linux/gfp.h                                |    26 +-
 include/linux/highmem.h                            |     3 +
 include/linux/huge_mm.h                            |    28 +-
 include/linux/hugetlb.h                            |    63 +-
 include/linux/hugetlb_cgroup.h                     |    19 +-
 include/linux/instrumented.h                       |    59 +-
 include/linux/kasan.h                              |    55 +-
 include/linux/khugepaged.h                         |    13 +-
 include/linux/kmsan-checks.h                       |    83 +
 include/linux/kmsan.h                              |   330 +
 include/linux/kmsan_types.h                        |    35 +
 include/linux/ksm.h                                |     3 -
 include/linux/maple_tree.h                         |   685 +
 include/linux/memcontrol.h                         |    99 +-
 include/linux/memory-tiers.h                       |   102 +
 include/linux/memory_hotplug.h                     |    30 +-
 include/linux/mempolicy.h                          |    13 +-
 include/linux/migrate.h                            |    15 -
 include/linux/mm.h                                 |   161 +-
 include/linux/mm_inline.h                          |   242 +-
 include/linux/mm_types.h                           |   178 +-
 include/linux/mm_types_task.h                      |    12 -
 include/linux/mmzone.h                             |   281 +-
 include/linux/node.h                               |    29 +-
 include/linux/nodemask.h                           |    16 +-
 include/linux/oom.h                                |    11 -
 include/linux/page-flags-layout.h                  |    16 +-
 include/linux/page-flags.h                         |     4 +-
 include/linux/page_counter.h                       |    26 +-
 include/linux/page_ext.h                           |    24 +-
 include/linux/page_idle.h                          |    34 +-
 include/linux/pageblock-flags.h                    |     4 +
 include/linux/pagemap.h                            |    14 +-
 include/linux/pagewalk.h                           |    10 +-
 include/linux/pgtable.h                            |    26 +-
 include/linux/rmap.h                               |    73 +-
 include/linux/sched.h                              |    14 +-
 include/linux/sched/coredump.h                     |     7 +-
 include/linux/sched/sysctl.h                       |     1 +
 include/linux/shmem_fs.h                           |    16 +-
 include/linux/slab.h                               |     8 +-
 include/linux/stackdepot.h                         |     8 +
 include/linux/swap.h                               |    41 +-
 include/linux/swap_cgroup.h                        |     4 +-
 include/linux/swapfile.h                           |     7 +-
 include/linux/swapops.h                            |   150 +-
 include/linux/uaccess.h                            |    19 +-
 include/linux/userfaultfd_k.h                      |     7 +-
 include/linux/vm_event_item.h                      |     4 -
 include/linux/vmacache.h                           |    28 -
 include/linux/vmstat.h                             |     6 -
 include/linux/writeback.h                          |     8 -
 include/trace/events/huge_memory.h                 |    37 +
 include/trace/events/maple_tree.h                  |   123 +
 include/trace/events/mmap.h                        |    73 +
 include/uapi/asm-generic/hugetlb_encode.h          |    26 +-
 include/uapi/asm-generic/mman-common.h             |     2 +
 include/uapi/linux/userfaultfd.h                   |     4 +
 init/Kconfig                                       |     5 -
 init/main.c                                        |    11 +-
 ipc/shm.c                                          |    21 +-
 kernel/Makefile                                    |     1 +
 kernel/acct.c                                      |    11 +-
 kernel/bounds.c                                    |     7 +
 kernel/bpf/core.c                                  |     2 +-
 kernel/bpf/task_iter.c                             |    10 +-
 kernel/cgroup/cgroup-internal.h                    |     1 -
 kernel/debug/debug_core.c                          |    12 -
 kernel/delayacct.c                                 |    13 +-
 kernel/dma/mapping.c                               |    10 +-
 kernel/entry/common.c                              |     5 +
 kernel/events/core.c                               |     3 +-
 kernel/events/uprobes.c                            |    39 +-
 kernel/exit.c                                      |     3 +
 kernel/fork.c                                      |    79 +-
 kernel/kcov.c                                      |     7 +
 kernel/locking/Makefile                            |     3 +-
 kernel/sched/core.c                                |    15 +
 kernel/sched/debug.c                               |     1 +
 kernel/sched/fair.c                                |   175 +-
 kernel/sched/sched.h                               |     1 +
 kernel/sysctl.c                                    |     8 +
 lib/Kconfig.debug                                  |    18 +-
 lib/Kconfig.kasan                                  |     8 -
 lib/Kconfig.kmsan                                  |    62 +
 lib/Makefile                                       |    10 +-
 lib/iomap.c                                        |    44 +
 lib/iov_iter.c                                     |     9 +-
 lib/maple_tree.c                                   |  7130 ++++
 lib/show_mem.c                                     |     4 +-
 lib/stackdepot.c                                   |    29 +-
 lib/string.c                                       |     8 +
 lib/test_hmm.c                                     |    13 +-
 lib/test_maple_tree.c                              | 38307 +++++++++++++++++++
 lib/usercopy.c                                     |     3 +-
 mm/Kconfig                                         |    34 +-
 mm/Makefile                                        |     8 +-
 mm/backing-dev.c                                   |     6 +-
 mm/cma_debug.c                                     |     5 +-
 mm/compaction.c                                    |    24 +-
 mm/damon/Kconfig                                   |     3 +
 mm/damon/core-test.h                               |    29 +-
 mm/damon/core.c                                    |   281 +-
 mm/damon/dbgfs.c                                   |    52 +-
 mm/damon/lru_sort.c                                |   380 +-
 mm/damon/modules-common.h                          |    46 +
 mm/damon/ops-common.c                              |    50 +-
 mm/damon/ops-common.h                              |     2 +-
 mm/damon/paddr.c                                   |    43 +-
 mm/damon/reclaim.c                                 |   289 +-
 mm/damon/sysfs.c                                   |   143 +-
 mm/damon/vaddr-test.h                              |    36 +-
 mm/damon/vaddr.c                                   |   102 +-
 mm/debug.c                                         |    14 +-
 mm/filemap.c                                       |   124 +-
 mm/folio-compat.c                                  |     6 +
 mm/gup.c                                           |   248 +-
 mm/hmm.c                                           |     2 +-
 mm/huge_memory.c                                   |   205 +-
 mm/hugetlb.c                                       |   792 +-
 mm/hugetlb_cgroup.c                                |    27 +-
 mm/hugetlb_vmemmap.c                               |    10 +-
 mm/hwpoison-inject.c                               |     4 +-
 mm/init-mm.c                                       |     4 +-
 mm/internal.h                                      |    48 +-
 mm/kasan/Makefile                                  |     8 +
 mm/kasan/common.c                                  |   177 +-
 mm/kasan/generic.c                                 |   154 +-
 mm/kasan/hw_tags.c                                 |    39 +-
 mm/kasan/kasan.h                                   |   171 +-
 lib/test_kasan.c => mm/kasan/kasan_test.c          |    26 +-
 .../kasan/kasan_test_module.c                      |     2 +-
 mm/kasan/report.c                                  |   138 +-
 mm/kasan/report_generic.c                          |    46 +-
 mm/kasan/report_tags.c                             |   123 +-
 mm/kasan/sw_tags.c                                 |     5 +-
 mm/kasan/tags.c                                    |   143 +-
 mm/kfence/core.c                                   |    22 +-
 mm/khugepaged.c                                    |  1168 +-
 mm/kmemleak.c                                      |    21 +-
 mm/kmsan/Makefile                                  |    28 +
 mm/kmsan/core.c                                    |   450 +
 mm/kmsan/hooks.c                                   |   384 +
 mm/kmsan/init.c                                    |   235 +
 mm/kmsan/instrumentation.c                         |   307 +
 mm/kmsan/kmsan.h                                   |   209 +
 mm/kmsan/kmsan_test.c                              |   581 +
 mm/kmsan/report.c                                  |   219 +
 mm/kmsan/shadow.c                                  |   298 +
 mm/ksm.c                                           |   375 +-
 mm/madvise.c                                       |    60 +-
 mm/memblock.c                                      |     6 +-
 mm/memcontrol.c                                    |   281 +-
 mm/memory-failure.c                                |   126 +-
 mm/memory-tiers.c                                  |   732 +
 mm/memory.c                                        |   274 +-
 mm/memory_hotplug.c                                |    11 +-
 mm/mempolicy.c                                     |    66 +-
 mm/memremap.c                                      |     2 +-
 mm/migrate.c                                       |   651 +-
 mm/migrate_device.c                                |    19 +-
 mm/mlock.c                                         |    37 +-
 mm/mm_init.c                                       |     6 +-
 mm/mm_slot.h                                       |    55 +
 mm/mmap.c                                          |  2259 +-
 mm/mmzone.c                                        |     2 +
 mm/mprotect.c                                      |    17 +-
 mm/mremap.c                                        |    41 +-
 mm/msync.c                                         |     2 +-
 mm/nommu.c                                         |   260 +-
 mm/oom_kill.c                                      |    11 +-
 mm/page_alloc.c                                    |   196 +-
 mm/page_counter.c                                  |    15 +-
 mm/page_ext.c                                      |   117 +-
 mm/page_io.c                                       |    43 +-
 mm/page_isolation.c                                |    17 +-
 mm/page_owner.c                                    |   103 +-
 mm/page_table_check.c                              |    14 +-
 mm/page_vma_mapped.c                               |     6 +-
 mm/pagewalk.c                                      |    12 +-
 mm/rmap.c                                          |   184 +-
 mm/rodata_test.c                                   |     8 +-
 mm/secretmem.c                                     |     8 +-
 mm/shmem.c                                         |   429 +-
 mm/shuffle.c                                       |    21 +-
 mm/slab.h                                          |     1 +
 mm/slub.c                                          |    43 +
 mm/swap.c                                          |    73 +-
 mm/swap.h                                          |    18 +-
 mm/swap_cgroup.c                                   |     6 +
 mm/swap_slots.c                                    |     2 +-
 mm/swap_state.c                                    |   111 +-
 mm/swapfile.c                                      |   178 +-
 mm/truncate.c                                      |     2 +-
 mm/userfaultfd.c                                   |    28 +-
 mm/util.c                                          |    36 +-
 mm/vmacache.c                                      |   117 -
 mm/vmalloc.c                                       |    35 +-
 mm/vmscan.c                                        |  3556 +-
 mm/vmstat.c                                        |     9 +-
 mm/workingset.c                                    |   110 +-
 mm/zsmalloc.c                                      |    22 +-
 mm/zswap.c                                         |     2 +-
 scripts/Makefile.kmsan                             |     8 +
 scripts/Makefile.lib                               |     9 +
 security/Kconfig.hardening                         |     4 +
 tools/include/asm-generic/hugetlb_encode.h         |    26 +-
 tools/include/linux/slab.h                         |     4 +
 tools/include/uapi/asm-generic/mman-common.h       |     2 +
 tools/objtool/check.c                              |    20 +
 tools/testing/memblock/linux/mmzone.h              |     2 +
 tools/testing/radix-tree/.gitignore                |     2 +
 tools/testing/radix-tree/Makefile                  |     9 +-
 tools/testing/radix-tree/generated/autoconf.h      |     1 +
 tools/testing/radix-tree/linux.c                   |   160 +-
 tools/testing/radix-tree/linux/kernel.h            |     1 +
 tools/testing/radix-tree/linux/lockdep.h           |     2 +
 tools/testing/radix-tree/linux/maple_tree.h        |     7 +
 tools/testing/radix-tree/maple.c                   |    59 +
 tools/testing/radix-tree/trace/events/maple_tree.h |     5 +
 tools/testing/selftests/cgroup/config              |     1 -
 tools/testing/selftests/damon/Makefile             |     1 +
 .../damon/debugfs_duplicate_context_creation.sh    |    27 +
 tools/testing/selftests/vm/.gitignore              |     1 -
 tools/testing/selftests/vm/Makefile                |    23 +-
 tools/testing/selftests/vm/check_config.sh         |    31 -
 tools/testing/selftests/vm/hmm-tests.c             |   108 +-
 tools/testing/selftests/vm/khugepaged.c            |  1195 +-
 tools/testing/selftests/vm/mremap_test.c           |    49 +-
 tools/testing/selftests/vm/run_vmtests.sh          |    15 +-
 tools/testing/selftests/vm/soft-dirty.c            |     2 +-
 tools/testing/selftests/vm/split_huge_page_test.c  |    12 +-
 tools/testing/selftests/vm/test_hmm.sh             |    10 -
 tools/testing/selftests/vm/userfaultfd.c           |   247 +-
 tools/testing/selftests/vm/vm_util.c               |    36 +-
 tools/testing/selftests/vm/vm_util.h               |     5 +-
 tools/vm/page_owner_sort.c                         |     7 +-
 408 files changed, 65821 insertions(+), 8035 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
 create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst
 create mode 100644 Documentation/core-api/maple_tree.rst
 create mode 100644 Documentation/dev-tools/kmsan.rst
 create mode 100644 Documentation/mm/multigen_lru.rst
 create mode 100644 arch/x86/include/asm/kmsan.h
 create mode 100644 arch/x86/mm/kmsan_shadow.c
 create mode 100644 include/linux/kmsan-checks.h
 create mode 100644 include/linux/kmsan.h
 create mode 100644 include/linux/kmsan_types.h
 create mode 100644 include/linux/maple_tree.h
 create mode 100644 include/linux/memory-tiers.h
 delete mode 100644 include/linux/vmacache.h
 create mode 100644 include/trace/events/maple_tree.h
 create mode 100644 lib/Kconfig.kmsan
 create mode 100644 lib/maple_tree.c
 create mode 100644 lib/test_maple_tree.c
 create mode 100644 mm/damon/modules-common.h
 rename lib/test_kasan.c => mm/kasan/kasan_test.c (98%)
 rename lib/test_kasan_module.c => mm/kasan/kasan_test_module.c (99%)
 create mode 100644 mm/kmsan/Makefile
 create mode 100644 mm/kmsan/core.c
 create mode 100644 mm/kmsan/hooks.c
 create mode 100644 mm/kmsan/init.c
 create mode 100644 mm/kmsan/instrumentation.c
 create mode 100644 mm/kmsan/kmsan.h
 create mode 100644 mm/kmsan/kmsan_test.c
 create mode 100644 mm/kmsan/report.c
 create mode 100644 mm/kmsan/shadow.c
 create mode 100644 mm/memory-tiers.c
 create mode 100644 mm/mm_slot.h
 delete mode 100644 mm/vmacache.c
 create mode 100644 scripts/Makefile.kmsan
 create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
 create mode 100644 tools/testing/radix-tree/maple.c
 create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h
 create mode 100644 tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
 delete mode 100644 tools/testing/selftests/vm/check_config.sh

