Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A03464BF53
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiLMW0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiLMW0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:26:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226FBC28;
        Tue, 13 Dec 2022 14:26:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9664F61756;
        Tue, 13 Dec 2022 22:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE5EC433D2;
        Tue, 13 Dec 2022 22:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670970375;
        bh=zl2BxjmsIzFdF/dncetgdY+7xbmAG1rHNW4IoNyAynQ=;
        h=Date:From:To:Cc:Subject:From;
        b=RcQPT+ZbrcsfwRgPfogIkcugkRmDg6AAKnyJYbnHnSg15BN7e968J32z7MfdBE1N5
         IebN9s2SVsIudlhGQPJNH5g+x2nC6vpSpooL3OdAf/SETSaE5ZR1tuDkspZnD8aGMw
         L9ablghZrpBAjDB+hynlZVnTcvtH111yQlGcI5Sg=
Date:   Tue, 13 Dec 2022 14:26:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] MM updates for 6.2-rc1
Message-Id: <20221213142614.525a9240506119abc3cef6b6@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge the MM updates for this release cycle.

I'm seeing two minor conflicts here:

- a clash with the block tree in mm/hugetlb.c.  Stephen resolved it
  thusly:
  https://lkml.kernel.org/r/20221110172246.32792d6a@canb.auug.org.au

- also drivers/media/common/videobuf2/frame_vector.c, Stephen's fix
  is at
  https://lkml.kernel.org/r/20221207130140.7c014015@canb.auug.org.au


Thanks.


The following changes since commit 4a7ba45b1a435e7097ca0f79a847d0949d0eb088:

  memcg: fix possible use-after-free in memcg_write_event_control() (2022-1=
2-09 18:41:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022=
-12-13

for you to fetch changes up to c45bc55a99957b20e4e0333bcd42e12d1833a7f5:

  mm/hugetlb: set head flag before setting compound_order in __prep_compoun=
d_gigantic_folio (2022-12-12 16:47:11 -0800)

----------------------------------------------------------------
MM patches for 6.2-rc1.

- More userfaultfs work from Peter Xu.

- Several convert-to-folios series from Sidhartha Kumar and Huang Ying.

- Some filemap cleanups from Vishal Moola.

- David Hildenbrand added the ability to selftest anon memory COW handling.

- Some cpuset simplifications from Liu Shixin.

- Addition of vmalloc tracing support by Uladzislau Rezki.

- Some pagecache folioifications and simplifications from Matthew Wilcox.

- A pagemap cleanup from Kefeng Wang: we have VM_ACCESS_FLAGS, so use it.

- Miguel Ojeda contributed some cleanups for our use of the
  __no_sanitize_thread__ gcc keyword.  This series shold have been in the
  non-MM tree, my bad.

- Naoya Horiguchi improved the interaction between memory poisoning and
  memory section removal for huge pages.

- DAMON cleanups and tuneups from SeongJae Park

- Tony Luck fixed the handling of COW faults against poisoned pages.

- Peter Xu utilized the PTE marker code for handling swapin errors.

- Hugh Dickins reworked compound page mapcount handling, simplifying it
  and making it more efficient.

- Removal of the autonuma savedwrite infrastructure from Nadav Amit and
  David Hildenbrand.

- zram support for multiple compression streams from Sergey Senozhatsky.

- David Hildenbrand reworked the GUP code's R/O long-term pinning so
  that drivers no longer need to use the FOLL_FORCE workaround which
  didn't work very well anyway.

- Mel Gorman altered the page allocator so that local IRQs can remnain
  enabled during per-cpu page allocations.

- Vishal Moola removed the try_to_release_page() wrapper.

- Stefan Roesch added some per-BDI sysfs tunables which are used to
  prevent network block devices from dirtying excessive amounts of
  pagecache.

- David Hildenbrand did some cleanup and repair work on KSM COW
  breaking.

- Nhat Pham and Johannes Weiner have implemented writeback in zswap's
  zsmalloc backend.

- Brian Foster has fixed a longstanding corner-case oddity in
  file[map]_write_and_wait_range().

- sparse-vmemmap changes for MIPS, LoongArch and NIOS2 from Feiyang
  Chen.

- Shiyang Ruan has done some work on fsdax, to make its reflink mode
  work better under xfstests.  Better, but still not perfect.

- Christoph Hellwig has removed the .writepage() method from several
  filesystems.  They only need .writepages().

- Yosry Ahmed wrote a series which fixes the memcg reclaim target
  beancounting.

- David Hildenbrand has fixed some of our MM selftests for 32-bit
  machines.

- Many singleton patches, as usual.

----------------------------------------------------------------
Alexander Gordeev (1):
      mm: mmu_gather: do not expose delayed_rmap flag

Alexander Potapenko (4):
      Revert "kmsan: unpoison @tlb in arch_tlb_gather_mmu()"
      lockdep: allow instrumenting lockdep.c with KMSAN
      kmsan: allow using __msan_instrument_asm_store() inside runtime
      kmsan: fix memcpy tests

Alexey Romanov (1):
      zram: add size class equals check into recompression

Alistair Popple (1):
      mm/mmap: properly unaccount memory on mas_preallocate() failure

Andrew Morton (2):
      Merge branch 'mm-hotfixes-stable' into mm-stable
      Merge branch 'mm-hotfixes-stable' into mm-stable

Andrey Konovalov (4):
      kasan: switch kunit tests to console tracepoints
      kasan: migrate kasan_rcu_uaf test to kunit
      kasan: migrate workqueue_uaf test to kunit
      kasan: fail non-kasan KUnit tests on KASAN reports

Anshuman Khandual (3):
      documentation/mm: update pmd_present() in arch_pgtable_helpers.rst
      mm/thp: rename pmd_to_page() as pmd_pgtable_page()
      s390/mm: use pmd_pgtable_page() helper in __gmap_segment_gaddr()

Baolin Wang (2):
      mm: migrate: try again if THP split is failed due to page refcnt
      Revert "mm: migration: fix the FOLL_GET failure on following huge pag=
e"

Brian Foster (2):
      filemap: skip write and wait if end offset precedes start
      mm/fadvise: use LLONG_MAX instead of -1 for eof

Christoph Hellwig (7):
      extfat: remove ->writepage
      fat: remove ->writepage
      hfs: remove ->writepage
      hfsplus: remove ->writepage
      hpfs: remove ->writepage
      jfs: remove ->writepage
      omfs: remove ->writepage

Christophe JAILLET (2):
      mm/damon: use kstrtobool() instead of strtobool()
      mm: use kstrtobool() instead of strtobool()

David Hildenbrand (46):
      selftests/vm: anon_cow: test COW handling of anonymous memory
      selftests/vm: factor out pagemap_is_populated() into vm_util
      selftests/vm: anon_cow: THP tests
      selftests/vm: anon_cow: hugetlb tests
      selftests/vm: anon_cow: add liburing test cases
      mm/gup_test: start/stop/read functionality for PIN LONGTERM test
      selftests/vm: anon_cow: add R/O longterm tests via gup_test
      mm/mprotect: minor can_change_pte_writable() cleanups
      mm/huge_memory: try avoiding write faults when changing PMD protection
      mm/mprotect: factor out check whether manual PTE write upgrades are r=
equired
      mm/autonuma: use can_change_(pte|pmd)_writable() to replace savedwrite
      mm: remove unused savedwrite infrastructure
      selftests/vm: anon_cow: add mprotect() optimization tests
      selftests/vm: anon_cow: prepare for non-anonymous COW tests
      selftests/vm: cow: basic COW tests for non-anonymous pages
      selftests/vm: cow: R/O long-term pinning reliability tests for non-an=
on pages
      mm: add early FAULT_FLAG_UNSHARE consistency checks
      mm: add early FAULT_FLAG_WRITE consistency checks
      mm: rework handling in do_wp_page() based on private vs. shared mappi=
ngs
      mm: don't call vm_ops->huge_fault() in wp_huge_pmd()/wp_huge_pud() fo=
r private mappings
      mm: extend FAULT_FLAG_UNSHARE support to anything in a COW mapping
      mm/gup: reliable R/O long-term pinning in COW mappings
      RDMA/umem: remove FOLL_FORCE usage
      RDMA/usnic: remove FOLL_FORCE usage
      RDMA/siw: remove FOLL_FORCE usage
      media: videobuf-dma-sg: remove FOLL_FORCE usage
      drm/etnaviv: remove FOLL_FORCE usage
      media: pci/ivtv: remove FOLL_FORCE usage
      mm/frame-vector: remove FOLL_FORCE usage
      drm/exynos: remove FOLL_FORCE usage
      RDMA/hw/qib/qib_user_pages: remove FOLL_FORCE usage
      habanalabs: remove FOLL_FORCE usage
      mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb mappings
      selftests/vm: add KSM unmerge tests
      mm/pagewalk: don't trigger test_walk() in walk_page_vma()
      selftests/vm: add test to measure MADV_UNMERGEABLE performance
      mm/ksm: simplify break_ksm() to not rely on VM_FAULT_WRITE
      mm: remove VM_FAULT_WRITE
      mm/ksm: fix KSM COW breaking with userfaultfd-wp via FAULT_FLAG_UNSHA=
RE
      mm/pagewalk: add walk_page_range_vma()
      mm/ksm: convert break_ksm() to use walk_page_range_vma()
      mm/gup: remove FOLL_MIGRATION
      mm/gup_test: fix PIN_LONGTERM_TEST_READ with highmem
      selftests/vm: madv_populate: fix missing MADV_POPULATE_(READ|WRITE) d=
efinitions
      selftests/vm: cow: fix compile warning on 32bit
      selftests/vm: ksm_functional_tests: fixes for 32bit

Deming Wang (2):
      mm/mincore.c: use vma_lookup() instead of find_vma()
      zsmalloc: replace IS_ERR() with IS_ERR_VALUE()

Deyan Wang (1):
      mm/page_alloc: update comments in __free_pages_ok()

Feiyang Chen (4):
      MIPS&LoongArch&NIOS2: adjust prototypes of p?d_init()
      LoongArch: add sparse memory vmemmap support
      mm/sparse-vmemmap: generalise vmemmap_populate_hugepages()
      LoongArch: enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP

Gautam Menghani (1):
      mm/khugepaged: add tracepoint to collapse_file()

Hawkins Jiawei (1):
      hugetlbfs: fix null-ptr-deref in hugetlbfs_parse_param()

Huang Ying (2):
      migrate: convert unmap_and_move() to use folios
      migrate: convert migrate_pages() to use folios

Hugh Dickins (9):
      mm,hugetlb: use folio fields in second tail page
      mm,thp,rmap: simplify compound page mapcount handling
      mm,thp,rmap: lock_compound_mapcounts() on THP mapcounts
      mm,thp,rmap: handle the normal !PageCompound case first
      mm,thp,rmap: subpages_mapcount of PTE-mapped subpages
      mm,thp,rmap: subpages_mapcount COMPOUND_MAPPED if PMD-mapped
      mm,thp,rmap: clean up the end of __split_huge_pmd_locked()
      mm: memcg: fix swapcached stat accounting
      mm,thp,rmap: fix races between updates of subpages_mapcount

Jan Kara (1):
      mm: make drop_caches keep reclaiming on all nodes

Jason A. Donenfeld (1):
      mm: do not show fs mm pc for VM_LOCKONFAULT pages

Jason Gunthorpe (1):
      mm/gup: remove the restriction on locked with FOLL_LONGTERM

Jian Wen (1):
      docs: admin-guide: cgroup-v1: update description of inactive_file

Joao Martins (1):
      mm/hugetlb_vmemmap: remap head page to newly allocated page

Joel Savitz (1):
      selftests/vm: enable running select groups of tests

Johannes Weiner (4):
      mm: vmscan: make rotations a secondary factor in balancing anon vs fi=
le
      mm: vmscan: split khugepaged stats from direct reclaim stats
      zswap: fix writeback lock ordering for zsmalloc
      zpool: clean out dead code

Kairui Song (1):
      swap: add a limit for readahead page-cluster value

Kamalesh Babulal (1):
      mm: memcontrol: use mem_cgroup_is_root() helper

Kees Cook (1):
      mempool: do not use ksize() for poisoning

Kefeng Wang (11):
      mm: rmap: rename page_not_mapped() to folio_not_mapped()
      mm: remove kern_addr_valid() completely
      nios2: remove unused INIT_MMAP
      x86/sgx: use VM_ACCESS_FLAGS
      mm: mprotect: use VM_ACCESS_FLAGS
      mm: debug_vm_pgtable: use VM_ACCESS_FLAGS
      amdgpu: use VM_ACCESS_FLAGS
      mm: memory-failure: make put_ref_page() more useful
      mm: memory-failure: avoid pfn_valid() twice in soft_offline_page()
      mm: memory-failure: make action_result() return int
      mm: add cond_resched() in swapin_walk_pmd_entry()

Li zeming (1):
      hugetlbfs: inode: remove unnecessary (void*) conversions

Liam Howlett (1):
      maple_tree: mte_set_full() and mte_clear_full() clang-analyzer clean =
up

Linus Torvalds (5):
      mm: introduce 'encoded' page pointers with embedded extra bits
      mm: teach release_pages() to take an array of encoded page pointers t=
oo
      mm: mmu_gather: prepare to gather encoded page pointers with flags
      mm: delay page_remove_rmap() until after the TLB has been flushed
      mm: mmu_gather: allow more than one batch of delayed rmaps

Liu Shixin (8):
      cgroup/cpuset: use hotplug_memory_notifier() directly
      fs/proc/kcore.c: use hotplug_memory_notifier() directly
      mm/slub.c: use hotplug_memory_notifier() directly
      mm/mmap: use hotplug_memory_notifier() directly
      mm/mm_init.c: use hotplug_memory_notifier() directly
      ACPI: HMAT: use hotplug_memory_notifier() directly
      memory: remove unused register_hotmemory_notifier()
      memory: move hotplug memory notifier priority to same file for easy s=
orting

Lukas Bulwahn (2):
      mm/shmem: remove unneeded assignments in shmem_get_folio_gfp()
      mm: Kconfig: make config SECRETMEM visible with EXPERT

Ma Wupeng (2):
      mm/rmap: fix comment in anon_vma_clone()
      mm/memory-failure.c: cleanup in unpoison_memory

Matthew Wilcox (Oracle) (4):
      mm/huge_memory: convert split_huge_pages_in_file() to use a folio
      mm/swap: convert find_get_incore_page to use folios
      mm: convert find_get_incore_page() to filemap_get_incore_folio()
      mm: remove FGP_HEAD

Mel Gorman (3):
      mm/page_alloc: always remove pages from temporary list
      mm/page_alloc: leave IRQs enabled for per-cpu page allocations
      mm/page_alloc: simplify locking during free_unref_page_list

Miaoqian Lin (1):
      mm/demotion: fix NULL vs IS_ERR checking in memory_tier_init

Miguel Ojeda (5):
      compiler-gcc: be consistent with underscores use for `no_sanitize`
      compiler-gcc: remove attribute support check for `__no_sanitize_addre=
ss__`
      compiler-gcc: remove attribute support check for `__no_sanitize_threa=
d__`
      compiler-gcc: remove attribute support check for `__no_sanitize_undef=
ined__`
      compiler-gcc: document minimum version for `__no_sanitize_coverage__`

Mike Kravetz (3):
      hugetlb: simplify hugetlb handling in follow_page_mask
      selftests/vm: update hugetlb madvise
      hugetlb: remove duplicate mmu notifications

Mina Almasry (2):
      mm: disable top-tier fallback to reclaim on proactive reclaim
      mm: add nodes=3D arg to memory.reclaim

Muchun Song (1):
      mm: hugetlb_vmemmap: remove redundant list_del()

NARIBAYASHI Akira (1):
      mm, compaction: fix fast_isolate_around() to stay within boundaries

Nadav Amit (1):
      mm/mprotect: allow clean exclusive anon pages to be writable

Naoya Horiguchi (4):
      mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwp=
oisoned hugepage
      mm/hwpoison: move definitions of num_poisoned_pages_* to memory-failu=
re.c
      mm/hwpoison: pass pfn to num_poisoned_pages_*()
      mm/hwpoison: introduce per-memory_block hwpoison counter

Nhat Pham (4):
      zsmalloc: consolidate zs_pool's migrate_lock and size_class's locks
      zsmalloc: add a LRU to zs_pool to keep track of zspages in LRU order
      zsmalloc: add zpool_ops field to zs_pool to store evict handlers
      zsmalloc: implement writeback mechanism for zsmalloc

Pasha Tatashin (1):
      mm: anonymous shared memory naming

Pavankumar Kondeti (2):
      mm/kfence: remove hung_task cruft
      mm/madvise: fix madvise_pageout for private file mappings

Peter Xu (11):
      selftests/vm: use memfd for uffd hugetlb tests
      selftests/vm: use memfd for hugetlb-madvise test
      selftests/vm: use memfd for hugepage-mremap test
      selftests/vm: drop mnt point for hugetlb in run_vmtests.sh
      mm/hugetlb: unify clearing of RestoreReserve for private pages
      Revert "mm/uffd: fix warning without PTE_MARKER_UFFD_WP compiled in"
      mm: always compile in pte markers
      mm: use pte markers for swap errors
      mm/uffd: sanity check write bit for uffd-wp protected ptes
      selftests/vm: use memfd for hugepage-mmap test
      mm/thp: re-apply mkdirty for small pages after split

Randy Dunlap (1):
      maple_tree: allow TEST_MAPLE_TREE only when DEBUG_KERNEL is set

Rolf Eike Beer (1):
      mm: fix typo in struct vm_operations_struct comments

Rong Tao (2):
      tools/vm/page_owner: ignore page_owner_sort binary
      selftests/damon: fix unnecessary compilation warnings

SeongJae Park (28):
      mm/damon/core: split out DAMOS-charged region skip logic into a new f=
unction
      mm/damon/core: split damos application logic into a new function
      mm/damon/core: split out scheme stat update logic into a new function
      mm/damon/core: split out scheme quota adjustment logic into a new fun=
ction
      mm/damon/sysfs: use damon_addr_range for region's start and end values
      mm/damon/sysfs: remove parameters of damon_sysfs_region_alloc()
      mm/damon/sysfs: move sysfs_lock to common module
      mm/damon/sysfs: move unsigned long range directory to common module
      mm/damon/sysfs: split out kdamond-independent schemes stats update lo=
gic into a new function
      mm/damon/sysfs: split out schemes directory implementation to separat=
e file
      mm/damon/modules: deduplicate init steps for DAMON context setup
      mm/damon/{reclaim,lru_sort}: remove unnecessarily included headers
      mm/damon/reclaim: enable and disable synchronously
      selftests/damon: add tests for DAMON_RECLAIM's enabled parameter
      mm/damon/lru_sort: enable and disable synchronously
      selftests/damon: add tests for DAMON_LRU_SORT's enabled parameter
      Docs/admin-guide/mm/damon/usage: describe the rules of sysfs region d=
irectories
      Docs/admin-guide/mm/damon/usage: fix wrong usage example of init_regi=
ons file
      mm/damon/core: add a callback for scheme target regions check
      mm/damon/sysfs-schemes: implement schemes/tried_regions directory
      mm/damon/sysfs-schemes: implement scheme region directory
      mm/damon/sysfs: implement DAMOS tried regions update command
      mm/damon/sysfs-schemes: implement DAMOS-tried regions clear command
      tools/selftets/damon/sysfs: test tried_regions directory existence
      Docs/admin-guide/mm/damon/usage: document schemes/<s>/tried_regions s=
ysfs directory
      Docs/ABI/damon: document 'schemes/<s>/tried_regions' sysfs directory
      selftests/damon: test non-context inputs to rm_contexts file
      selftests/damon: test removed scheme sysfs dir access bug

Sergey Senozhatsky (15):
      zram: preparation for multi-zcomp support
      zram: add recompression algorithm sysfs knob
      zram: factor out WB and non-WB zram read functions
      zram: introduce recompress sysfs knob
      zram: add recompress flag to read_block_state()
      zram: clarify writeback_store() comment
      zram: use IS_ERR_VALUE() to check for zs_malloc() errors
      zram: remove redundant checks from zram_recompress()
      zram: add algo parameter support to zram_recompress()
      documentation: add zram recompression documentation
      zram: add incompressible writeback
      zram: add incompressible flag to read_block_state()
      Docs/ABI/zram: document zram recompress sysfs knobs
      zram: remove unused stats fields
      zswap: do not allocate from atomic pool

Shakeel Butt (2):
      mm: convert mm's rss stats into percpu_counter
      percpu_counter: add percpu_counter_sum_all interface

Shiyang Ruan (8):
      fsdax: introduce page->share for fsdax in reflink mode
      fsdax: invalidate pages when CoW
      fsdax: zero the edges if source is HOLE or UNWRITTEN
      fsdax,xfs: set the shared flag when file extent is shared
      fsdax: dedupe: iter two files at the same time
      xfs: use dax ops for zero and truncate in fsdax mode
      fsdax,xfs: port unshare to fsdax
      xfs: remove restrictions for fsdax and reflink

Sidhartha Kumar (25):
      mm/hugetlb: add folio support to hugetlb specific flag macros
      mm: add private field of first tail to struct page and struct folio
      mm/hugetlb: add hugetlb_folio_subpool() helpers
      hugetlbfs: convert hugetlb_delete_from_page_cache() to use folios
      mm/hugetlb: add folio_hstate()
      mm/hugetlb_cgroup: convert __set_hugetlb_cgroup() to folios
      mm/hugetlb_cgroup: convert hugetlb_cgroup_from_page() to folios
      mm/hugetlb_cgroup: convert set_hugetlb_cgroup*() to folios
      mm/hugetlb_cgroup: convert hugetlb_cgroup_migrate to folios
      mm/hugetlb: convert isolate_or_dissolve_huge_page to folios
      mm/hugetlb: convert free_huge_page to folios
      mm/hugetlb_cgroup: convert hugetlb_cgroup_uncharge_page() to folios
      mm/hugeltb_cgroup: convert hugetlb_cgroup_commit_charge*() to folios
      mm/hugetlb: convert move_hugetlb_state() to folios
      mm: add folio dtor and order setter functions
      mm/hugetlb: convert destroy_compound_gigantic_page() to folios
      mm/hugetlb: convert dissolve_free_huge_page() to folios
      mm/hugetlb: convert remove_hugetlb_page() to folios
      mm/hugetlb: convert update_and_free_page() to folios
      mm/hugetlb: convert add_hugetlb_page() to folios and add hugetlb_cma_=
folio()
      mm/hugetlb: convert enqueue_huge_page() to folios
      mm/hugetlb: convert free_gigantic_page() to folios
      mm/hugetlb: convert hugetlb prep functions to folios
      mm/hugetlb: change hugetlb allocation functions to return a folio
      mm/hugetlb: set head flag before setting compound_order in __prep_com=
pound_gigantic_folio

Stefan Roesch (20):
      mm: add bdi_set_strict_limit() function
      mm: add knob /sys/class/bdi/<bdi>/strict_limit
      mm: document /sys/class/bdi/<bdi>/strict_limit knob
      mm: use part per 1000000 for bdi ratios
      mm: add bdi_get_max_bytes() function
      mm: split off __bdi_set_max_ratio() function
      mm: add bdi_set_max_bytes() function
      mm: add knob /sys/class/bdi/<bdi>/max_bytes
      mm: document /sys/class/bdi/<bdi>/max_bytes knob
      mm: add bdi_get_min_bytes() function
      mm: split off __bdi_set_min_ratio() function
      mm: add bdi_set_min_bytes() function
      mm: add /sys/class/bdi/<bdi>/min_bytes knob
      mm: document /sys/class/bdi/<bdi>/min_bytes knob
      mm: add bdi_set_max_ratio_no_scale() function
      mm: add /sys/class/bdi/<bdi>/max_ratio_fine knob
      mm: document /sys/class/bdi/<bdi>/max_ratio_fine knob
      mm: add bdi_set_min_ratio_no_scale() function
      mm: add /sys/class/bdi/<bdi>/min_ratio_fine knob
      mm: document /sys/class/bdi/<bdi>/min_ratio_fine knob

T.J. Mercier (1):
      mm: shrinkers: add missing includes for undeclared types

Thomas Wei=DFschuh (1):
      tmpfs: ensure O_LARGEFILE with generic_file_open()

Tony Luck (2):
      mm, hwpoison: try to recover from copy-on write faults
      mm, hwpoison: when copy-on-write hits poison, take page offline

Uladzislau Rezki (Sony) (7):
      mm: vmalloc: add alloc_vmap_area trace event
      mm: vmalloc: add purge_vmap_area_lazy trace event
      mm: vmalloc: add free_vmap_area_noflush trace event
      mm: vmalloc: use trace_alloc_vmap_area event
      mm: vmalloc: use trace_purge_vmap_area_lazy event
      mm: vmalloc: use trace_free_vmap_area_noflush event
      vmalloc: add reviewers for vmalloc code

Uros Bizjak (1):
      zram: use try_cmpxchg in update_used_max

Vishal Moola (Oracle) (11):
      filemap: find_lock_entries() now updates start offset
      filemap: find_get_entries() now updates start offset
      ext4: convert move_extent_per_page() to use folios
      khugepage: replace try_to_release_page() with filemap_release_folio()
      memory-failure: convert truncate_error_page() to use folio
      folio-compat: remove try_to_release_page()
      filemap: convert replace_page_cache_page() to replace_page_cache_foli=
o()
      fuse: convert fuse_try_move_page() to use folios
      userfaultfd: replace lru_cache functions with folio_add functions
      khugepage: replace lru_cache_add() with folio_add_lru()
      folio-compat: remove lru_cache_add()

Wang Yong (1):
      mm: fix typo in struct pglist_data code comment

Xu Panda (1):
      mm: vmscan: use sysfs_emit() to instead of scnprintf()

Yang Li (1):
      mm/migrate.c: stop using 0 as NULL pointer

Yixuan Cao (1):
      mm/kmemleak.c: fix a comment

Yosry Ahmed (3):
      mm: memcg: fix stale protection of reclaim target memcg
      selftests: cgroup: refactor proactive reclaim code to reclaim_until()
      selftests: cgroup: make sure reclaim target memcg is unprotected

Yu Zhao (1):
      mm: multi-gen LRU: remove NULL checks on NODE_DATA()

zhang songyi (1):
      include/linux/pgtable.h: : remove redundant pte variable

 Documentation/ABI/testing/sysfs-block-zram         |   14 +
 Documentation/ABI/testing/sysfs-class-bdi          |   68 +
 Documentation/ABI/testing/sysfs-kernel-mm-damon    |   32 +
 Documentation/admin-guide/blockdev/zram.rst        |  100 +-
 Documentation/admin-guide/cgroup-v1/memory.rst     |    3 +-
 Documentation/admin-guide/cgroup-v2.rst            |   21 +-
 Documentation/admin-guide/mm/damon/usage.rst       |   59 +-
 Documentation/filesystems/proc.rst                 |    8 +-
 Documentation/mm/arch_pgtable_helpers.rst          |    2 +-
 Documentation/mm/transhuge.rst                     |   34 +-
 MAINTAINERS                                        |   12 +-
 arch/alpha/include/asm/pgtable.h                   |    2 -
 arch/arc/include/asm/pgtable-bits-arcv2.h          |    2 -
 arch/arm/include/asm/pgtable-nommu.h               |    2 -
 arch/arm/include/asm/pgtable.h                     |    4 -
 arch/arm64/include/asm/pgtable.h                   |    2 -
 arch/arm64/mm/mmu.c                                |  102 +-
 arch/arm64/mm/pageattr.c                           |    3 +-
 arch/csky/include/asm/pgtable.h                    |    3 -
 arch/hexagon/include/asm/page.h                    |    7 -
 arch/ia64/include/asm/pgtable.h                    |   16 -
 arch/ia64/mm/hugetlbpage.c                         |   15 -
 arch/loongarch/Kconfig                             |    2 +
 arch/loongarch/include/asm/pgalloc.h               |   13 +-
 arch/loongarch/include/asm/pgtable.h               |   17 +-
 arch/loongarch/include/asm/sparsemem.h             |    8 +
 arch/loongarch/kernel/numa.c                       |    4 +-
 arch/loongarch/mm/init.c                           |   45 +-
 arch/loongarch/mm/pgtable.c                        |   23 +-
 arch/m68k/include/asm/pgtable_mm.h                 |    2 -
 arch/m68k/include/asm/pgtable_no.h                 |    1 -
 arch/microblaze/include/asm/pgtable.h              |    3 -
 arch/mips/include/asm/pgalloc.h                    |   10 +-
 arch/mips/include/asm/pgtable-64.h                 |    8 +-
 arch/mips/include/asm/pgtable.h                    |    2 -
 arch/mips/kvm/mmu.c                                |    3 +-
 arch/mips/mm/pgtable-32.c                          |    9 +-
 arch/mips/mm/pgtable-64.c                          |   18 +-
 arch/mips/mm/pgtable.c                             |    2 +-
 arch/nios2/include/asm/pgalloc.h                   |    5 -
 arch/nios2/include/asm/pgtable.h                   |    2 -
 arch/nios2/include/asm/processor.h                 |    3 -
 arch/openrisc/include/asm/pgtable.h                |    2 -
 arch/parisc/include/asm/pgtable.h                  |   15 -
 arch/parisc/kernel/pdt.c                           |    5 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   80 +-
 arch/powerpc/include/asm/pgtable.h                 |    7 -
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |    2 +-
 arch/powerpc/mm/hugetlbpage.c                      |   37 -
 arch/riscv/include/asm/pgtable.h                   |    2 -
 arch/s390/include/asm/pgtable.h                    |    2 -
 arch/s390/include/asm/tlb.h                        |   11 +-
 arch/s390/mm/gmap.c                                |    5 +-
 arch/sh/include/asm/pgtable.h                      |    2 -
 arch/sparc/include/asm/pgtable_32.h                |    6 -
 arch/sparc/mm/init_32.c                            |    3 +-
 arch/sparc/mm/init_64.c                            |    1 -
 arch/um/include/asm/pgtable.h                      |    2 -
 arch/x86/include/asm/pgtable.h                     |   18 +-
 arch/x86/include/asm/pgtable_32.h                  |    9 -
 arch/x86/include/asm/pgtable_64.h                  |    1 -
 arch/x86/kernel/cpu/sgx/encl.c                     |    4 +-
 arch/x86/mm/init_64.c                              |  133 +-
 arch/xtensa/include/asm/pgtable.h                  |    2 -
 drivers/acpi/numa/hmat.c                           |    7 +-
 drivers/base/memory.c                              |   38 +
 drivers/block/zram/Kconfig                         |    9 +
 drivers/block/zram/zcomp.c                         |    6 +-
 drivers/block/zram/zcomp.h                         |    2 +-
 drivers/block/zram/zram_drv.c                      |  619 ++++++--
 drivers/block/zram/zram_drv.h                      |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |    8 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |    2 +-
 drivers/infiniband/core/umem.c                     |    8 +-
 drivers/infiniband/hw/qib/qib_user_pages.c         |    2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |    9 +-
 drivers/infiniband/sw/siw/siw_mem.c                |    9 +-
 drivers/media/common/videobuf2/frame_vector.c      |    2 +-
 drivers/media/pci/ivtv/ivtv-udma.c                 |    2 +-
 drivers/media/pci/ivtv/ivtv-yuv.c                  |    5 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c          |   14 +-
 drivers/misc/habanalabs/common/memory.c            |    3 +-
 fs/dax.c                                           |  221 ++-
 fs/exfat/inode.c                                   |    9 +-
 fs/ext4/move_extent.c                              |   52 +-
 fs/fat/inode.c                                     |    9 +-
 fs/fuse/dev.c                                      |   55 +-
 fs/hfs/inode.c                                     |    2 +-
 fs/hfsplus/inode.c                                 |    2 +-
 fs/hpfs/file.c                                     |    9 +-
 fs/hugetlbfs/inode.c                               |   28 +-
 fs/jfs/inode.c                                     |    7 +-
 fs/omfs/file.c                                     |    7 +-
 fs/proc/kcore.c                                    |   33 +-
 fs/proc/task_mmu.c                                 |   16 +-
 fs/xfs/xfs_ioctl.c                                 |    4 -
 fs/xfs/xfs_iomap.c                                 |    6 +-
 fs/xfs/xfs_iops.c                                  |    4 -
 fs/xfs/xfs_reflink.c                               |    8 +-
 include/asm-generic/tlb.h                          |   38 +-
 include/linux/backing-dev.h                        |   10 +
 include/linux/compiler-gcc.h                       |   21 +-
 include/linux/damon.h                              |    5 +
 include/linux/dax.h                                |    2 +
 include/linux/highmem.h                            |   26 +
 include/linux/hugetlb.h                            |  143 +-
 include/linux/hugetlb_cgroup.h                     |   86 +-
 include/linux/khugepaged.h                         |    6 +
 include/linux/memcontrol.h                         |   31 +-
 include/linux/memory-tiers.h                       |    1 -
 include/linux/memory.h                             |   18 +-
 include/linux/mm.h                                 |  276 +++-
 include/linux/mm_types.h                           |  162 ++-
 include/linux/mm_types_task.h                      |   13 -
 include/linux/mmzone.h                             |    2 +-
 include/linux/page-flags.h                         |   23 +-
 include/linux/pagemap.h                            |    9 +-
 include/linux/pagewalk.h                           |    5 +
 include/linux/percpu_counter.h                     |    7 +-
 include/linux/pgtable.h                            |   28 +-
 include/linux/sched.h                              |    3 -
 include/linux/shrinker.h                           |    3 +
 include/linux/swap.h                               |   27 +-
 include/linux/swapops.h                            |   73 +-
 include/linux/vm_event_item.h                      |    3 +
 include/linux/zsmalloc.h                           |    2 +
 include/trace/events/huge_memory.h                 |   38 +
 include/trace/events/kmem.h                        |    8 +-
 include/trace/events/vmalloc.h                     |  123 ++
 kernel/cgroup/cpuset.c                             |    7 +-
 kernel/fork.c                                      |   21 +-
 kernel/locking/Makefile                            |    1 -
 kernel/sysctl.c                                    |    1 +
 lib/Kconfig.debug                                  |    1 +
 lib/Kconfig.kasan                                  |    2 +-
 lib/maple_tree.c                                   |   13 +-
 lib/percpu_counter.c                               |   29 +-
 mm/Kconfig                                         |   17 +-
 mm/backing-dev.c                                   |  133 +-
 mm/compaction.c                                    |   18 +-
 mm/damon/Makefile                                  |    6 +-
 mm/damon/core.c                                    |  266 ++--
 mm/damon/lru_sort.c                                |   71 +-
 mm/damon/modules-common.c                          |   42 +
 mm/damon/modules-common.h                          |    3 +
 mm/damon/reclaim.c                                 |   73 +-
 mm/damon/sysfs-common.c                            |  107 ++
 mm/damon/sysfs-common.h                            |   56 +
 mm/damon/sysfs-schemes.c                           | 1338 +++++++++++++++++
 mm/damon/sysfs.c                                   | 1273 ++--------------
 mm/debug.c                                         |    5 +-
 mm/debug_vm_pgtable.c                              |   40 +-
 mm/fadvise.c                                       |    2 +-
 mm/filemap.c                                       |   89 +-
 mm/folio-compat.c                                  |   25 +-
 mm/gup.c                                           |  255 +---
 mm/gup_test.c                                      |  145 ++
 mm/gup_test.h                                      |   12 +
 mm/huge_memory.c                                   |  157 +-
 mm/hugetlb.c                                       |  747 +++++-----
 mm/hugetlb_cgroup.c                                |   63 +-
 mm/hugetlb_vmemmap.c                               |   45 +-
 mm/internal.h                                      |   12 +-
 mm/kasan/kasan.h                                   |   20 +-
 mm/kasan/kasan_test.c                              |  152 +-
 mm/kasan/kasan_test_module.c                       |   60 -
 mm/kasan/report.c                                  |   64 +-
 mm/kasan/shadow.c                                  |    2 +-
 mm/kfence/core.c                                   |   12 +-
 mm/khugepaged.c                                    |   57 +-
 mm/kmemleak.c                                      |    2 +-
 mm/kmsan/instrumentation.c                         |    8 +-
 mm/kmsan/kmsan_test.c                              |    3 +
 mm/ksm.c                                           |   89 +-
 mm/madvise.c                                       |   61 +-
 mm/memcontrol.c                                    |  113 +-
 mm/memory-failure.c                                |  172 ++-
 mm/memory-tiers.c                                  |    4 +-
 mm/memory.c                                        |  260 ++--
 mm/mempool.c                                       |   18 +-
 mm/migrate.c                                       |  285 ++--
 mm/mincore.c                                       |   14 +-
 mm/mm_init.c                                       |    8 +-
 mm/mmap.c                                          |   12 +-
 mm/mmu_gather.c                                    |   58 +-
 mm/mprotect.c                                      |   55 +-
 mm/page-writeback.c                                |  130 +-
 mm/page_alloc.c                                    |  167 +--
 mm/page_ext.c                                      |    2 +-
 mm/page_table_check.c                              |    3 +-
 mm/pagewalk.c                                      |   27 +-
 mm/rmap.c                                          |  332 +++--
 mm/shmem.c                                         |   54 +-
 mm/slub.c                                          |    7 +-
 mm/sparse-vmemmap.c                                |   73 +
 mm/sparse.c                                        |    2 -
 mm/swap.c                                          |   41 +-
 mm/swap.h                                          |    8 +-
 mm/swap_state.c                                    |   39 +-
 mm/swapfile.c                                      |    2 +-
 mm/truncate.c                                      |   32 +-
 mm/usercopy.c                                      |    3 +-
 mm/userfaultfd.c                                   |    6 +-
 mm/util.c                                          |   79 -
 mm/vmalloc.c                                       |   20 +-
 mm/vmscan.c                                        |  125 +-
 mm/vmstat.c                                        |    3 +
 mm/workingset.c                                    |    7 +-
 mm/z3fold.c                                        |   36 +-
 mm/zbud.c                                          |   32 +-
 mm/zpool.c                                         |   17 +-
 mm/zsmalloc.c                                      |  365 ++++-
 mm/zswap.c                                         |   39 +-
 tools/testing/selftests/cgroup/test_memcontrol.c   |   91 +-
 tools/testing/selftests/damon/Makefile             |    4 +-
 .../selftests/damon/debugfs_rm_non_contexts.sh     |   19 +
 .../selftests/damon/huge_count_read_write.c        |    9 +
 tools/testing/selftests/damon/lru_sort.sh          |   41 +
 tools/testing/selftests/damon/reclaim.sh           |   42 +
 tools/testing/selftests/damon/sysfs.sh             |    7 +
 .../damon/sysfs_update_removed_scheme_dir.sh       |   58 +
 tools/testing/selftests/vm/.gitignore              |    1 +
 tools/testing/selftests/vm/Makefile                |   27 +-
 tools/testing/selftests/vm/check_config.sh         |   31 +
 tools/testing/selftests/vm/cow.c                   | 1536 ++++++++++++++++=
++++
 tools/testing/selftests/vm/hugepage-mmap.c         |   10 +-
 tools/testing/selftests/vm/hugepage-mremap.c       |   21 +-
 tools/testing/selftests/vm/hugetlb-madvise.c       |   19 +-
 tools/testing/selftests/vm/ksm_functional_tests.c  |  279 ++++
 tools/testing/selftests/vm/ksm_tests.c             |   76 +-
 tools/testing/selftests/vm/madv_populate.c         |   15 +-
 tools/testing/selftests/vm/run_vmtests.sh          |  220 ++-
 tools/testing/selftests/vm/userfaultfd.c           |   62 +-
 tools/testing/selftests/vm/vm_util.c               |   25 +
 tools/testing/selftests/vm/vm_util.h               |    3 +
 tools/vm/.gitignore                                |    1 +
 237 files changed, 9281 insertions(+), 5046 deletions(-)
 create mode 100644 include/trace/events/vmalloc.h
 create mode 100644 mm/damon/modules-common.c
 create mode 100644 mm/damon/sysfs-common.c
 create mode 100644 mm/damon/sysfs-common.h
 create mode 100644 mm/damon/sysfs-schemes.c
 create mode 100644 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
 create mode 100644 tools/testing/selftests/damon/lru_sort.sh
 create mode 100644 tools/testing/selftests/damon/reclaim.sh
 create mode 100644 tools/testing/selftests/damon/sysfs_update_removed_sche=
me_dir.sh
 create mode 100644 tools/testing/selftests/vm/check_config.sh
 create mode 100644 tools/testing/selftests/vm/cow.c
 create mode 100644 tools/testing/selftests/vm/ksm_functional_tests.c

