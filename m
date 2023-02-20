Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DD069D5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjBTVwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBTVwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:52:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF72E3B6;
        Mon, 20 Feb 2023 13:52:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D62760B94;
        Mon, 20 Feb 2023 21:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A34AC433D2;
        Mon, 20 Feb 2023 21:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676929946;
        bh=HQM19JFqK7JJ+H7Yb1OdfagpUynOFuIQkJ6Jfw1E2HM=;
        h=Date:From:To:Cc:Subject:From;
        b=m4RKeFeWsf5M5qX+e5E8vu7EtXSlagQvmHGFg0+OvdxL1K9TfG7d22LXRPEunzrN5
         BXlIkG7Earvm3tkzMuwEdabFFTLlzbI2gyoYtm3SRO9OYVPIouqlhzxRuseMXve+ts
         4YmJ4qPfk8KcyaJQpmFIIDaNTVYWWtRQ0zx/gZHk=
Date:   Mon, 20 Feb 2023 13:52:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] MM updates for 6.3-rc1
Message-Id: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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


Linus, please merge this cycle's MM updates.

I'm presently seeing one merge conflict in fs/buffer.c.  Stephen's
resolution is described at
https://lkml.kernel.org/r/20230110132519.72181341@canb.auug.org.au.

There are a lot of conflicts in your future, mainly because of the
ongoing folio conversion work.  This will hopefully come to an end
fairly soon.  Forthcoming conflicts which are known about, along with
Stephen's fixes are:

Documentation/admin-guide/cgroup-v1/memory.rst
	https://lkml.kernel.org/r/20230106125915.60c8b547@canb.auug.org.au

drivers/infiniband/hw/hfi1/file_ops.c
	https://lkml.kernel.org/r/20230127162143.1a3bc64b@canb.auug.org.au

drivers/gpu/drm/i810/i810_dma.c
	https://lkml.kernel.org/r/20230127162426.19daa5b1@canb.auug.org.au

drivers/staging/media/deprecated/meye/meye.c
	https://lkml.kernel.org/r/20230127162647.037701db@canb.auug.org.au

drivers/staging/media/deprecated/stkwebcam/stk-webcam.c
	https://lkml.kernel.org/r/20230127162906.77e540fa@canb.auug.org.au

Documentation/admin-guide/mm/numaperf.rst
	https://lkml.kernel.org/r/20230209131258.1d7a28fb@canb.auug.org.au

Documentation/translations/zh_CN/accounting/delay-accounting.rst
	https://lkml.kernel.org/r/20230214133929.7d8ed00f@canb.auug.org.au

include/linux/memcontrol.h
mm/memcontrol.c
	https://lkml.kernel.org/r/20230215135734.4dffcd39@canb.auug.org.au

fs/nfs/write.c
	https://lkml.kernel.org/r/20230216140514.631bcca1@canb.auug.org.au

fs/cifs/file.c
	https://lkml.kernel.org/r/20230220152933.1ab8fa4a@canb.auug.org.au

fs/ext4/inode.c
	https://lkml.kernel.org/r/20230220152938.45f62d5a@canb.auug.org.au


Thanks.


The following changes since commit 1301f9313484f9eeb09904988b2aabd398492797:

  Pull mm-hotfixes-stable dependencies into mm-stable. (2023-01-18 17:03:20=
 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023=
-02-20-13-37

for you to fetch changes up to f9366f4c2a29d14f5992b195e268240c2deb116e:

  include/linux/migrate.h: remove unneeded externs (2023-02-20 12:46:18 -08=
00)

----------------------------------------------------------------
- Daniel Verkamp has contributed a memfd series ("mm/memfd: add
  F_SEAL_EXEC") which permits the setting of the memfd execute bit at
  memfd creation time, with the option of sealing the state of the X bit.

- Peter Xu adds a patch series ("mm/hugetlb: Make huge_pte_offset()
  thread-safe for pmd unshare") which addresses a rare race condition
  related to PMD unsharing.

- Several folioification patch serieses from Matthew Wilcox, Vishal
  Moola, Sidhartha Kumar and Lorenzo Stoakes

- Johannes Weiner has a series ("mm: push down lock_page_memcg()") which
  does perform some memcg maintenance and cleanup work.

- SeongJae Park has added DAMOS filtering to DAMON, with the series
  "mm/damon/core: implement damos filter".  These filters provide users
  with finer-grained control over DAMOS's actions.  SeongJae has also done
  some DAMON cleanup work.

- Kairui Song adds a series ("Clean up and fixes for swap").

- Vernon Yang contributed the series "Clean up and refinement for maple
  tree".

- Yu Zhao has contributed the "mm: multi-gen LRU: memcg LRU" series.  It
  adds to MGLRU an LRU of memcgs, to improve the scalability of global
  reclaim.

- David Hildenbrand has added some userfaultfd cleanup work in the
  series "mm: uffd-wp + change_protection() cleanups".

- Christoph Hellwig has removed the generic_writepages() library
  function in the series "remove generic_writepages".

- Baolin Wang has performed some maintenance on the compaction code in
  his series "Some small improvements for compaction".

- Sidhartha Kumar is doing some maintenance work on struct page in his
  series "Get rid of tail page fields".

- David Hildenbrand contributed some cleanup, bugfixing and
  generalization of pte management and of pte debugging in his series "mm:
  support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all architectures with swap
  PTEs".

- Mel Gorman and Neil Brown have removed the __GFP_ATOMIC allocation
  flag in the series "Discard __GFP_ATOMIC".

- Sergey Senozhatsky has improved zsmalloc's memory utilization with his
  series "zsmalloc: make zspage chain size configurable".

- Joey Gouly has added prctl() support for prohibiting the creation of
  writeable+executable mappings.  The previous BPF-based approach had
  shortcomings.  See "mm: In-kernel support for memory-deny-write-execute
  (MDWE)".

- Waiman Long did some kmemleak cleanup and bugfixing in the series
  "mm/kmemleak: Simplify kmemleak_cond_resched() & fix UAF".

- T.J.  Alumbaugh has contributed some MGLRU cleanup work in his series
  "mm: multi-gen LRU: improve".

- Jiaqi Yan has provided some enhancements to our memory error
  statistics reporting, mainly by presenting the statistics on a per-node
  basis.  See the series "Introduce per NUMA node memory error
  statistics".

- Mel Gorman has a second and hopefully final shot at fixing a CPU-hog
  regression in compaction via his series "Fix excessive CPU usage during
  compaction".

- Christoph Hellwig does some vmalloc maintenance work in the series
  "cleanup vfree and vunmap".

- Christoph Hellwig has removed block_device_operations.rw_page() in ths
  series "remove ->rw_page".

- We get some maple_tree improvements and cleanups in Liam Howlett's
  series "VMA tree type safety and remove __vma_adjust()".

- Suren Baghdasaryan has done some work on the maintainability of our
  vm_flags handling in the series "introduce vm_flags modifier functions".

- Some pagemap cleanup and generalization work in Mike Rapoport's series
  "mm, arch: add generic implementation of pfn_valid() for FLATMEM" and
  "fixups for generic implementation of pfn_valid()"

- Baoquan He has done some work to make /proc/vmallocinfo and
  /proc/kcore better represent the real state of things in his series
  "mm/vmalloc.c: allow vread() to read out vm_map_ram areas".

- Jason Gunthorpe rationalized the GUP system's interface to the rest of
  the kernel in the series "Simplify the external interface for GUP".

- SeongJae Park wishes to migrate people from DAMON's debugfs interface
  over to its sysfs interface.  To support this, we'll temporarily be
  printing warnings when people use the debugfs interface.  See the series
  "mm/damon: deprecate DAMON debugfs interface".

- Andrey Konovalov provided the accurately named "lib/stackdepot: fixes
  and clean-ups" series.

- Huang Ying has provided a dramatic reduction in migration's TLB flush
  IPI rates with the series "migrate_pages(): batch TLB flushing".

- Arnd Bergmann has some objtool fixups in "objtool warning fixes".

----------------------------------------------------------------
Alexander Mikhalitsyn (1):
      mailmap: add entry for Alexander Mikhalitsyn

Alexander Pantyukhin (1):
      tools:cgroup:memcg_shrinker remove redundant import

Alexander Potapenko (2):
      Revert "x86: kmsan: sync metadata pages on page fault"
      kmsan: silence -Wmissing-prototypes warnings

Alistair Popple (1):
      mm/mmu_notifier: remove unused mmu_notifier_range_update_to_read_only=
 export

Andrew Morton (4):
      Sync mm-stable with mm-hotfixes-stable to pick up dependent patches
      revert "squashfs: harden sanity check in squashfs_read_xattr_id_table"
      Merge branch 'mm-hotfixes-stable' into mm-stable
      include/linux/migrate.h: remove unneeded externs

Andrey Konovalov (20):
      kasan: allow sampling page_alloc allocations for HW_TAGS
      kasan: reset page tags properly with sampling
      lib/stackdepot: put functions in logical order
      lib/stackdepot: use pr_fmt to define message format
      lib/stackdepot, mm: rename stack_depot_want_early_init
      lib/stackdepot: rename stack_depot_disable
      lib/stackdepot: annotate init and early init functions
      lib/stackdepot: lower the indentation in stack_depot_init
      lib/stackdepot: reorder and annotate global variables
      lib/stackdepot: rename hash table constants and variables
      lib/stackdepot: rename slab to pool
      lib/stackdepot: rename handle and pool constants
      lib/stackdepot: rename init_stack_pool
      lib/stacktrace: drop impossible WARN_ON for depot_init_pool
      lib/stackdepot: annotate depot_init_pool and depot_alloc_stack
      lib/stackdepot: rename next_pool_inited to next_pool_required
      lib/stacktrace, kasan, kmsan: rework extra_bits interface
      lib/stackdepot: annotate racy pool_index accesses
      lib/stackdepot: various comments clean-ups
      lib/stackdepot: move documentation comments to stackdepot.h

Anshuman Khandual (1):
      mm/page_alloc: use deferred_pages_enabled() wherever applicable

Arnd Bergmann (5):
      mm: extend max struct page size for kmsan
      maple_tree: reduce stack usage with gcc-9 and earlier
      kasan: mark addr_has_metadata __always_inline
      kmsan: disable ftrace in kmsan core code
      objtool: add UACCESS exceptions for __tsan_volatile_read/write

Baolin Wang (9):
      mm: compaction: remove redundant VM_BUG_ON() in compact_zone()
      mm: compaction: move list validation into compact_zone()
      mm: compaction: count the migration scanned pages events for proactiv=
e compaction
      mm: compaction: add missing kcompactd wakeup trace event
      mm: compaction: avoid fragmentation score calculation for empty zones
      mm: change to return bool for folio_isolate_lru()
      mm: change to return bool for isolate_lru_page()
      mm: hugetlb: change to return bool for isolate_hugetlb()
      mm: change to return bool for isolate_movable_page()

Baoquan He (7):
      mm/vmalloc.c: add used_map into vmap_block to track space of vmap_blo=
ck
      mm/vmalloc.c: add flags to mark vm_map_ram area
      mm/vmalloc.c: allow vread() to read out vm_map_ram areas
      mm/vmalloc: explicitly identify vm_map_ram area when shown in /proc/v=
mcoreinfo
      mm/vmalloc: skip the uninitilized vmalloc areas
      powerpc: mm: add VM_IOREMAP flag to the vmalloc area
      sh: mm: set VM_IOREMAP flag to the vmalloc area

Bj=F6rn T=F6pel (1):
      selftests: vm: enable cross-compilation

Christoph Hellwig (23):
      fs: remove an outdated comment on mpage_writepages
      ntfs3: stop using generic_writepages
      ntfs3: remove ->writepage
      jbd2,ocfs2: move jbd2_journal_submit_inode_data_buffers to ocfs2
      ocfs2: use filemap_fdatawrite_wbc instead of generic_writepages
      mm: remove generic_writepages
      mm: reject vmap with VM_FLUSH_RESET_PERMS
      mm: remove __vfree
      mm: remove __vfree_deferred
      mm: move vmalloc_init and free_work down in vmalloc.c
      mm: call vfree instead of __vunmap from delayed_vfree_work
      mm: move __remove_vm_area out of va_remove_mappings
      mm: use remove_vm_area in __vunmap
      mm: move debug checks from __vunmap to remove_vm_area
      mm: split __vunmap
      mm: refactor va_remove_mappings
      mpage: stop using bdev_{read,write}_page
      mm: remove the swap_readpage return value
      mm: factor out a swap_readpage_bdev helper
      mm: use an on-stack bio for synchronous swapin
      mm: remove the __swap_writepage return value
      mm: factor out a swap_writepage_bdev helper
      block: remove ->rw_page

Christophe Leroy (1):
      kasan: fix Oops due to missing calls to kasan_arch_is_ready()

Colin Ian King (1):
      mm/secretmem: remove redundant initiialization of pointer file

Daniel Verkamp (2):
      mm/memfd: add F_SEAL_EXEC
      selftests/memfd: add tests for F_SEAL_EXEC

David Hildenbrand (34):
      mm/userfaultfd: rely on vma->vm_page_prot in uffd_wp_range()
      mm/mprotect: drop pgprot_t parameter from change_protection()
      selftests/vm: cow: add COW tests for collapsing of PTE-mapped anon THP
      mm/nommu: factor out check for NOMMU shared mappings into is_nommu_sh=
ared_mapping()
      mm/nommu: don't use VM_MAYSHARE for MAP_PRIVATE mappings
      drivers/misc/open-dice: don't touch VM_MAYSHARE
      selftests/mm: define MADV_PAGEOUT to fix compilation issues
      mm/debug_vm_pgtable: more pte_swp_exclusive() sanity checks
      alpha/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      arc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      arm/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      csky/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      hexagon/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      ia64/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      loongarch/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      m68k/mm: remove dummy __swp definitions for nommu
      m68k/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      mips/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      nios2/mm: refactor swap PTE layout
      nios2/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      openrisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      parisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      powerpc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
      powerpc/nohash/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      riscv/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      sh/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit
      sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 64bit
      um/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      x86/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also on 32bit
      xtensa/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      mm: remove __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      arm/mm: fix swp type masking in __swp_entry()

David Howells (1):
      mm: move FOLL_* defs to mm_types.h

David Stevens (1):
      mm: fix khugepaged with shmem_enabled=3Dadvise

Deming Wang (1):
      Documentation: mm: use `s/higmem/highmem/` fix typo for highmem

Eugen Hristev (1):
      .mailmap: update e-mail address for Eugen Hristev

Fabio M. De Francesco (3):
      mm: remove an ambiguous sentence from kmap_local_folio() kdocs
      mm: fix spelling mistake in highmem.h
      mm/highmem: add notes about conversions from kmap{,_atomic}()

Fedor Pchelkin (1):
      squashfs: harden sanity check in squashfs_read_xattr_id_table

Feng Tang (2):
      mm/slab: add is_kmalloc_cache() helper function
      mm/kasan: simplify and refine kasan_cache code

Frank van der Linden (1):
      mm/debug: use valid physical memory for pmd/pud tests

Greg Kroah-Hartman (1):
      mm: remove PageMovable export

Hao Sun (1):
      mm: new primitive kvmemdup()

Herton R. Krzesinski (1):
      tools/mm: allow users to provide additional cflags/ldflags

Huaisheng Ye (1):
      mm/damon/core: skip apply schemes if empty

Huang Ying (9):
      migrate_pages: organize stats with struct migrate_pages_stats
      migrate_pages: separate hugetlb folios migration
      migrate_pages: restrict number of pages to migrate in batch
      migrate_pages: split unmap_and_move() to _unmap() and _move()
      migrate_pages: batch _unmap and _move
      migrate_pages: move migrate_folio_unmap()
      migrate_pages: share more code between _unmap and _move
      migrate_pages: batch flushing TLB
      migrate_pages: move THP/hugetlb migration support check to simplify c=
ode

Hyeonggon Yoo (1):
      mm/page_owner: record single timestamp value for high order allocatio=
ns

Hyunmin Lee (1):
      mm/vmalloc: replace BUG_ON with a simple if statement

Isaac J. Manjarres (2):
      Revert "mm: kmemleak: alloc gray object for reserved region with dire=
ct map"
      of: reserved_mem: Have kmemleak ignore dynamically allocated reserved=
 mem

Jakub Wilk (1):
      mm: fix typo in __vm_enough_memory warning

James Morse (1):
      ia64: fix build error due to switch case label appearing next to decl=
aration

Jan Kara (1):
      fs: don't allocate blocks beyond EOF from __mpage_writepage

Jann Horn (1):
      mm/khugepaged: fix ->anon_vma race

Jason Gunthorpe (13):
      mm/gup: have internal functions get the mmap_read_lock()
      mm/gup: remove obsolete FOLL_LONGTERM comment
      mm/gup: don't call __gup_longterm_locked() if FOLL_LONGTERM cannot be=
 set
      mm/gup: move try_grab_page() to mm/internal.h
      mm/gup: simplify the external interface functions and consolidate inv=
ariants
      mm/gup: add an assertion that the mmap lock is locked
      mm/gup: remove locked being NULL from faultin_vma_page_range()
      mm/gup: add FOLL_UNLOCKABLE
      mm/gup: make locked never NULL in the internal GUP functions
      mm/gup: remove pin_user_pages_fast_only()
      mm/gup: make get_user_pages_fast_only() return the common return value
      mm/gup: move gup_must_unshare() to mm/internal.h
      mm/gup: move private gup FOLL_ flags to internal.h

Jeff Xie (1):
      scripts/gdb: fix 'lx-current' for x86

Jeff Xu (3):
      mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
      mm/memfd: add write seals when apply SEAL_EXEC to executable memfd
      selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC

JeongHyeon Lee (1):
      zram: fix typos in comments

Jianlin Lv (1):
      tools/vm/page_owner_sort: free memory before exit

Jiaqi Yan (3):
      mm: memory-failure: add memory failure stats to sysfs
      mm: memory-failure: bump memory failure stats to pglist_data
      mm: memory-failure: document memory failure stats

Joey Gouly (1):
      mm: implement memory-deny-write-execute as a prctl

Johannes Weiner (4):
      mm: memcontrol: skip moving non-present pages that are mapped elsewhe=
re
      mm: rmap: remove lock_page_memcg()
      mm: memcontrol: deprecate charge moving
      workingset: fix confusion around eviction vs refault container

Jongwoo Han (1):
      mm/gup.c: fix typo in comments

Kairui Song (4):
      swapfile: get rid of volatile and avoid redundant read
      swap: avoid a redundant pte map if ra window is 1
      swap: fold swap_ra_clamp_pfn into swap_ra_info
      swap: avoid holding swap reference in swap_cache_get_folio

Kees Cook (1):
      kselftest: vm: add tests for memory-deny-write-execute

Kefeng Wang (13):
      mm: huge_memory: convert madvise_free_huge_pmd to use a folio
      mm: swap: convert mark_page_lazyfree() to folio_mark_lazyfree()
      mm: huge_memory: convert split_huge_pages_all() to use a folio
      mm: page_idle: convert page idle to use a folio
      mm/damon: introduce damon_get_folio()
      mm/damon: convert damon_ptep/pmdp_mkold() to use a folio
      mm/damon/paddr: convert damon_pa_*() to use a folio
      mm/damon/vaddr: convert damon_young_pmd_entry() to use a folio
      mm/damon: remove unneeded damon_get_page()
      mm/damon/vaddr: convert hugetlb related functions to use a folio
      mm: memcg: fix NULL pointer in mem_cgroup_track_foreign_dirty_slowpat=
h()
      mm: madvise: use vm_normal_folio() in madvise_free_pte_range()
      mm: hwpoison: support recovery from ksm_might_need_to_copy()

Kele Huang (1):
      mm: fix comment of page table counter

Kuan-Ying Lee (2):
      mm/gup: add folio to list when folio_isolate_lru() succeed
      kasan: infer allocation size by scanning metadata

Levi Yun (1):
      mm/cma: fix potential memory loss on cma_declare_contiguous_nid

Li Lingfeng (1):
      lib: parser: optimize match_NUMBER apis to use local array

Li Zhijian (1):
      mm/memremap.c: fix outdated comment in devm_memremap_pages

Liam Howlett (2):
      maple_tree: remove GFP_ZERO from kmem_cache_alloc() and kmem_cache_al=
loc_bulk()
      maple_tree: fix mas_empty_area_rev() lower bound validation

Liam R. Howlett (50):
      maple_tree: add mas_init() function
      maple_tree: fix potential rcu issue
      maple_tree: reduce user error potential
      test_maple_tree: test modifications while iterating
      maple_tree: fix handle of invalidated state in mas_wr_store_setup()
      maple_tree: fix mas_prev() and mas_find() state handling
      mm: expand vma iterator interface
      mm/mmap: convert brk to use vma iterator
      kernel/fork: convert forking to using the vmi iterator
      mmap: convert vma_link() vma iterator
      mm/mmap: remove preallocation from do_mas_align_munmap()
      mmap: change do_mas_munmap and do_mas_aligned_munmap() to use vma ite=
rator
      mmap: convert vma_expand() to use vma iterator
      mm: add temporary vma iterator versions of vma_merge(), split_vma(), =
and __split_vma()
      ipc/shm: use the vma iterator for munmap calls
      ipc/shm: introduce new do_vma_munmap() to munmap
      userfaultfd: use vma iterator
      mm: change mprotect_fixup to vma iterator
      mlock: convert mlock to vma iterator
      coredump: convert to vma iterator
      mempolicy: convert to vma iterator
      task_mmu: convert to vma iterator
      sched: convert to vma iterator
      madvise: use vmi iterator for __split_vma() and vma_merge()
      mmap: pass through vmi iterator to __split_vma()
      mmap: use vmi version of vma_merge()
      mm/mremap: use vmi version of vma_merge()
      nommu: convert nommu to using the vma iterator
      nommu: pass through vma iterator to shrink_vma()
      mm: switch vma_merge(), split_vma(), and __split_vma to vma iterator
      mm/damon/vaddr-test.h: stop using vma_mas_store() for maple tree store
      mmap: convert __vma_adjust() to use vma iterator
      mm: pass through vma iterator to __vma_adjust()
      madvise: use split_vma() instead of __split_vma()
      mm: remove unnecessary write to vma iterator in __vma_adjust()
      mm: pass vma iterator through to __vma_adjust()
      mm: add vma iterator to vma_adjust() arguments
      mmap: clean up mmap_region() unrolling
      mm: change munmap splitting order and move_vma()
      mm/mmap: move anon_vma setting in __vma_adjust()
      mm/mmap: refactor locking out of __vma_adjust()
      mm/mmap: use vma_prepare() and vma_complete() in vma_expand()
      mm/mmap: introduce init_vma_prep() and init_multi_vma_prep()
      mm: don't use __vma_adjust() in __split_vma()
      mm/mremap: convert vma_adjust() to vma_expand()
      mm/mmap: don't use __vma_adjust() in shift_arg_pages()
      mm/mmap: introduce dup_vma_anon() helper
      mm/mmap: convert do_brk_flags() to use vma_prepare() and vma_complete=
()
      mm/mmap: remove __vma_adjust()
      vma_merge: set vma iterator to correct position.

Longlong Xia (2):
      mm/swapfile: add cond_resched() in get_swap_pages()
      mm/swapfile: remove pr_debug in get_swap_pages()

Lorenzo Stoakes (7):
      mm: vmalloc: correct use of __GFP_NOWARN mask in __vmalloc_area_node()
      selftest/vm: add mremap expand merge offset test
      mm: pagevec: add folio_batch_reinit()
      mm: mlock: use folios and a folio batch internally
      m68k/mm/motorola: specify pmd_page() type
      mm: mlock: update the interface to use folios
      Documentation/mm: update references to __m[un]lock_page() to *_folio()

Matthew Wilcox (1):
      mm: memcg: add folio_memcg_check()

Matthew Wilcox (Oracle) (63):
      buffer: add b_folio as an alias of b_page
      buffer: replace obvious uses of b_page with b_folio
      buffer: use b_folio in touch_buffer()
      buffer: use b_folio in end_buffer_async_read()
      buffer: use b_folio in end_buffer_async_write()
      page_io: remove buffer_head include
      buffer: use b_folio in mark_buffer_dirty()
      gfs2: replace obvious uses of b_page with b_folio
      jbd2: replace obvious uses of b_page with b_folio
      nilfs2: replace obvious uses of b_page with b_folio
      reiserfs: replace obvious uses of b_page with b_folio
      mpage: use b_folio in do_mpage_readpage()
      highmem: round down the address passed to kunmap_flush_on_unmap()
      mm: remove folio_pincount_ptr() and head_compound_pincount()
      mm: convert head_subpages_mapcount() into folio_nr_pages_mapped()
      doc: clarify refcount section by referring to folios & pages
      mm: convert total_compound_mapcount() to folio_total_mapcount()
      mm: convert page_remove_rmap() to use a folio internally
      mm: convert page_add_anon_rmap() to use a folio internally
      mm: convert page_add_file_rmap() to use a folio internally
      mm: add folio_add_new_anon_rmap()
      page_alloc: use folio fields directly
      mm: use a folio in hugepage_add_anon_rmap() and hugepage_add_new_anon=
_rmap()
      mm: use entire_mapcount in __page_dup_rmap()
      mm/debug: remove call to head_compound_mapcount()
      hugetlb: remove uses of folio_mapcount_ptr
      mm: convert page_mapcount() to use folio_entire_mapcount()
      mm: remove head_compound_mapcount() and _ptr functions
      mm: reimplement compound_order()
      mm: reimplement compound_nr()
      mm: convert set_compound_page_dtor() and set_compound_order() to foli=
os
      mm: convert is_transparent_hugepage() to use a folio
      mm: convert destroy_large_folio() to use folio_dtor
      hugetlb: remove uses of compound_dtor and compound_nr
      mm: remove 'First tail page' members from struct page
      doc: correct struct folio kernel-doc
      mm: move page->deferred_list to folio->_deferred_list
      mm/huge_memory: remove page_deferred_list()
      mm/huge_memory: convert get_deferred_split_queue() to take a folio
      mm: convert deferred_split_huge_page() to deferred_split_folio()
      shmem: convert shmem_write_end() to use a folio
      mm: add vma_alloc_zeroed_movable_folio()
      mm: convert do_anonymous_page() to use a folio
      mm: convert wp_page_copy() to use folios
      mm: use a folio in copy_pte_range()
      mm: use a folio in copy_present_pte()
      mm/fs: convert inode_attach_wb() to take a folio
      mm: convert mem_cgroup_css_from_page() to mem_cgroup_css_from_folio()
      mm: remove page_evictable()
      mm: remove mlock_vma_page()
      mm: remove munlock_vma_page()
      mm: clean up mlock_page / munlock_page references in comments
      rmap: add folio parameter to __page_set_anon_rmap()
      filemap: convert filemap_map_pmd() to take a folio
      filemap: convert filemap_range_has_page() to use a folio
      readahead: convert readahead_expand() to use a folio
      mm: add memcpy_from_file_folio()
      fs: convert writepage_t callback to pass a folio
      mpage: convert __mpage_writepage() to use a folio more fully
      mm: fix memcpy_from_file_folio() integer underflow
      filemap: add mapping_read_folio_gfp()
      shmem: add shmem_read_folio() and shmem_read_folio_gfp()
      shmem: fix W=3D1 build warnings with CONFIG_SHMEM=3Dn

Mel Gorman (9):
      mm/page_alloc: rename ALLOC_HIGH to ALLOC_MIN_RESERVE
      mm/page_alloc: treat RT tasks similar to __GFP_HIGH
      mm/page_alloc: explicitly record high-order atomic allocations in all=
oc_flags
      mm/page_alloc: explicitly define what alloc flags deplete min reserves
      mm/page_alloc: explicitly define how __GFP_HIGH non-blocking allocati=
ons accesses reserves
      mm, compaction: rename compact_control->rescan to finish_pageblock
      mm, compaction: check if a page has been captured before draining PCP=
 pages
      mm, compaction: finish scanning the current pageblock if requested
      mm, compaction: finish pageblocks on complete migration failure

Michal Hocko (2):
      mm/mempolicy: do not duplicate policy if it is not applicable for set=
_mempolicy_home_node
      Revert "mm: add nodes=3D arg to memory.reclaim"

Mike Kravetz (5):
      hugetlb: update vma flag check for hugetlb vma lock
      hugetlb: initialize variable to avoid compiler warning
      mm: remove zap_page_range and create zap_vma_pages
      mm: hugetlb: proc: check for hugetlb shared PMD in /proc/PID/smaps
      migrate: hugetlb: check for hugetlb shared PMD in node migration

Mike Rapoport (1):
      mm/sparse: fix "unused function 'pgdat_to_phys'" warning

Mike Rapoport (IBM) (7):
      mm/page_alloc: invert logic for early page initialisation checks
      arm: include asm-generic/memory_model.h from page.h rather than memor=
y.h
      m68k: use asm-generic/memory_model.h for both MMU and !MMU
      mips: drop definition of pfn_valid() for DISCONTIGMEM
      mm, arch: add generic implementation of pfn_valid() for FLATMEM
      m68k/nommu: add missing definition of ARCH_PFN_OFFSET
      sh: initialize max_mapnr

NeilBrown (1):
      mm: discard __GFP_ATOMIC

Nhat Pham (1):
      zsmalloc: fix a race with deferred_handles storing

Pasha Tatashin (2):
      mm/page_ext: do not allocate space for page_ext->flags if not needed
      mm/page_ext: init page_ext early if there are no deferred struct pages

Pengfei Xu (1):
      selftests/filesystems: grant executable permission to run_fat_tests.sh

Peter Xu (14):
      mm/uffd: always wr-protect pte in pte|pmd_mkuffd_wp()
      mm/hugetlb: let vma_offset_start() to return start
      mm/hugetlb: don't wait for migration entry during follow page
      mm/hugetlb: document huge_pte_offset usage
      mm/hugetlb: move swap entry handling into vma lock when faulted
      mm/hugetlb: make userfaultfd_huge_must_wait() safe to pmd unshare
      mm/hugetlb: make hugetlb_follow_page_mask() safe to pmd unshare
      mm/hugetlb: make follow_hugetlb_page() safe to pmd unshare
      mm/hugetlb: make walk_hugetlb_range() safe to pmd unshare
      mm/hugetlb: introduce hugetlb_walk()
      mm/mprotect: use long for page accountings and retval
      mm/uffd: detect pgtable allocation failures
      selftests/vm: remove __USE_GNU in hugetlb-madvise.c
      mm/uffd: fix comment in handling pte markers

Phillip Lougher (1):
      Squashfs: fix handling and sanity checking of xattr_ids count

Qi Zheng (2):
      mm: shrinkers: fix deadlock in shrinker debugfs
      mm: page_alloc: call panic() when memoryless node allocation fails

Qinglin Pan (1):
      lib/test_vmalloc.c: add parameter use_huge for fix_size_alloc_test

Randy Dunlap (1):
      freevxfs: Kconfig: fix spelling

Roman Gushchin (1):
      mm: memcontrol: rename memcg_kmem_enabled()

SeongJae Park (38):
      mm/damon/core: implement damos filter
      mm/damon/paddr: support DAMOS filters
      mm/damon/reclaim: add a parameter called skip_anon for avoiding anony=
mous pages reclamation
      Docs/admin-guide/damon/reclaim: document 'skip_anon' parameter
      mm/damon/sysfs-schemes: implement filters directory
      mm/damon/sysfs-schemes: implement filter directory
      mm/damon/sysfs-schemes: connect filter directory and filters directory
      mm/damon/sysfs-schemes: implement scheme filters
      selftests/damon/sysfs: test filters directory
      Docs/admin-guide/mm/damon/usage: document DAMOS filters of sysfs
      Docs/ABI/damon: document scheme filters files
      mm/page_reporting: replace rcu_access_pointer() with rcu_dereference_=
protected()
      MAINTAINERS: add types to akpm/mm git trees entries
      MAINTAINERS/MEMORY MANAGEMENT: add tools/vm/ as managed files
      tools/vm: rename tools/vm to tools/mm
      selftests/vm: rename selftests/vm to selftests/mm
      Docs/admin-guide/mm/numaperf: increase depth of subsections
      mm/damon/vaddr: rename 'damon_young_walk_private->page_sz' to 'folio_=
sz'
      mm/damon/vaddr: support folio of neither HPAGE_PMD_SIZE nor PAGE_SIZE
      mm/damon/vaddr: record appropriate folio size when the access is not =
found
      mm/damon/paddr: rename 'damon_pa_access_chk_result->page_sz' to 'foli=
o_sz'
      mm/damon/paddr: remove folio_sz field from damon_pa_access_chk_result
      mm/damon/paddr: remove damon_pa_access_chk_result struct
      mm/damon/core: update kernel-doc comments for DAMOS action supports o=
f each DAMON operations set
      mm/damon/core: update kernel-doc comments for DAMOS filters supports =
of each DAMON operations set
      Docs/mm/damon/index: mention DAMOS on the intro
      Docs/admin-guide/mm/damon/usage: update DAMOS actions/filters support=
s of each DAMON operations set
      Docs/mm/damon: add a maintainer-profile for DAMON
      MAINTAINERS/DAMON: link maintainer profile, git trees, and website
      selftests/damon/sysfs: hide expected write failures
      selftests/damon/debugfs_rm_non_contexts: hide expected write error me=
ssages
      mm/damon: update comments in damon.h for damon_attrs
      mm/damon/core: update monitoring results for new monitoring attributes
      mm/damon/core-test: add a test for damon_update_monitoring_results()
      Docs/admin-guide/mm/damon/usage: add DAMON debugfs interface deprecat=
ion notice
      mm/damon/Kconfig: add DAMON debugfs interface deprecation notice
      mm/damon/dbgfs: print DAMON debugfs interface deprecation message
      mm/memory_hotplug: cleanup return value handing in do_migrate_range()

Sergey Senozhatsky (5):
      zram: correctly handle all next_arg() cases
      zsmalloc: rework zspage chain size selection
      zsmalloc: skip chain size calculation for pow_of_2 classes
      zsmalloc: make zspage chain size configurable
      zsmalloc: set default zspage chain size to 8

Seth Jenkins (1):
      aio: fix mremap after fork null-deref

Shiyang Ruan (1):
      fsdax: dax_unshare_iter() should return a valid length

Sidhartha Kumar (28):
      mm: move folio_set_compound_order() to mm/internal.h
      mm: introduce folio_is_pfmemalloc
      mm: remove the hugetlb field from struct page
      mm/memory-failure: convert __get_huge_page_for_hwpoison() to folios
      mm/memory-failure: convert try_memory_failure_hugetlb() to folios
      mm/memory-failure: convert hugetlb_clear_page_hwpoison to folios
      mm/memory-failure: convert free_raw_hwp_pages() to folios
      mm/memory-failure: convert raw_hwp_list_head() to folios
      mm/memory-failure: convert __free_raw_hwp_pages() to folios
      mm/memory-failure: convert hugetlb_set_page_hwpoison() to folios
      mm/memory-failure: convert unpoison_memory() to folios
      mm/hugetlb: convert get_hwpoison_huge_page() to folios
      mm/hugetlb: convert isolate_hugetlb to folios
      mm/hugetlb: convert __update_and_free_page() to folios
      mm/hugetlb: convert dequeue_hugetlb_page functions to folios
      mm/hugetlb: convert alloc_surplus_huge_page() to folios
      mm/hugetlb: increase use of folios in alloc_huge_page()
      mm/hugetlb: convert alloc_migrate_huge_page to folios
      mm/hugetlb: convert restore_reserve_on_error() to folios
      mm/hugetlb: convert demote_free_huge_page to folios
      mm/hugetlb: convert hugetlb_install_page to folios
      mm/hugetlb: convert hugetlbfs_pagecache_present() to folios
      mm/hugetlb: convert putback_active_hugepage to take in a folio
      mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()
      mm/hugetlb: convert restore_reserve_on_error to take in a folio
      mm/hugetlb: convert hugetlb_add_to_page_cache to take in a folio
      mm/hugetlb: convert hugetlb_wp() to take in a folio
      Documentation/mm: update hugetlbfs documentation to mention alloc_hug=
etlb_folio

Suren Baghdasaryan (8):
      kernel/fork: convert vma assignment to a memcpy
      mm: introduce vma->vm_flags wrapper functions
      mm: replace VM_LOCKED_CLEAR_MASK with VM_LOCKED_MASK
      mm: replace vma->vm_flags direct modifications with modifier calls
      mm: replace vma->vm_flags indirect modification in ksm_madvise
      mm: introduce __vm_flags_mod and use it in untrack_pfn
      mm: export dump_mm()
      mm: introduce vm_flags_reset_once to replace WRITE_ONCE vm_flags upda=
tes

T.J. Alumbaugh (7):
      mm: multi-gen LRU: section for working set protection
      mm: multi-gen LRU: section for rmap/PT walk feedback
      mm: multi-gen LRU: section for Bloom filters
      mm: multi-gen LRU: section for memcg LRU
      mm: multi-gen LRU: improve lru_gen_exit_memcg()
      mm: multi-gen LRU: improve walk_pmd_range()
      mm: multi-gen LRU: simplify lru_gen_look_around()

Thomas Wei=DFschuh (1):
      mm/damon/sysfs: make kobj_type structures constant

Tom Saeger (1):
      sh: define RUNTIME_DISCARD_EXIT

Tong Tiangen (1):
      memory tier: release the new_memtier in find_create_memory_tier()

Uladzislau Rezki (Sony) (2):
      mm: vmalloc: avoid calling __find_vmap_area() twice in __vunmap()
      mm: vmalloc: replace BUG_ON() by WARN_ON_ONCE()

Vernon Yang (11):
      maple_tree: remove extra space and blank line
      maple_tree: remove extra return statement
      maple_tree: use mt_node_max() instead of direct operations mt_max[]
      maple_tree: use macro MA_ROOT_PARENT instead of number
      maple_tree: remove the redundant code
      maple_tree: refine ma_state init from mas_start()
      maple_tree: refine mab_calc_split function
      maple_tree: remove the parameter entry of mas_preallocate
      mm/mmap: fix typo in comment
      maple_tree: fix comment of mte_destroy_walk
      mm/mmap: fix comment of unmapped_area{_topdown}

Vishal Moola (Oracle) (41):
      mm/memory: add vm_normal_folio()
      madvise: convert madvise_cold_or_pageout_pte_range() to use folios
      mm/damon: convert damon_pa_mark_accessed_or_deactivate() to use folios
      mm/swap: convert deactivate_page() to folio_deactivate()
      ext4: convert mext_page_double_lock() to mext_folio_double_lock()
      mm/khugepaged: introduce release_pte_folio() to replace release_pte_p=
age()
      mm/khugepaged: convert release_pte_pages() to use folios
      pagemap: add filemap_grab_folio()
      filemap: add filemap_get_folios_tag()
      filemap: convert __filemap_fdatawait_range() to use filemap_get_folio=
s_tag()
      page-writeback: convert write_cache_pages() to use filemap_get_folios=
_tag()
      afs: convert afs_writepages_region() to use filemap_get_folios_tag()
      btrfs: convert btree_write_cache_pages() to use filemap_get_folio_tag=
()
      btrfs: convert extent_write_cache_pages() to use filemap_get_folios_t=
ag()
      ceph: convert ceph_writepages_start() to use filemap_get_folios_tag()
      cifs: convert wdata_alloc_and_fillpages() to use filemap_get_folios_t=
ag()
      ext4: convert mpage_prepare_extent_to_map() to use filemap_get_folios=
_tag()
      f2fs: convert f2fs_fsync_node_pages() to use filemap_get_folios_tag()
      f2fs: convert f2fs_flush_inline_data() to use filemap_get_folios_tag()
      f2fs: convert f2fs_sync_node_pages() to use filemap_get_folios_tag()
      f2fs: convert f2fs_write_cache_pages() to use filemap_get_folios_tag()
      f2fs: convert last_fsync_dnode() to use filemap_get_folios_tag()
      f2fs: convert f2fs_sync_meta_pages() to use filemap_get_folios_tag()
      gfs2: convert gfs2_write_cache_jdata() to use filemap_get_folios_tag()
      nilfs2: convert nilfs_lookup_dirty_data_buffers() to use filemap_get_=
folios_tag()
      nilfs2: convert nilfs_lookup_dirty_node_buffers() to use filemap_get_=
folios_tag()
      nilfs2: convert nilfs_btree_lookup_dirty_buffers() to use filemap_get=
_folios_tag()
      nilfs2: convert nilfs_copy_dirty_pages() to use filemap_get_folios_ta=
g()
      nilfs2: convert nilfs_clear_dirty_pages() to use filemap_get_folios_t=
ag()
      filemap: remove find_get_pages_range_tag()
      mm/khugepaged: fix invalid page access in release_pte_pages()
      mm: add folio_estimated_sharers()
      mm/mempolicy: convert queue_pages_pmd() to queue_folios_pmd()
      mm/mempolicy: convert queue_pages_pte_range() to queue_folios_pte_ran=
ge()
      mm/mempolicy: convert queue_pages_hugetlb() to queue_folios_hugetlb()
      mm/mempolicy: convert queue_pages_required() to queue_folio_required()
      mm/mempolicy: convert migrate_page_add() to migrate_folio_add()
      mm: add folio_get_nontail_page()
      mm/migrate: add folio_movable_ops()
      mm/migrate: convert isolate_movable_page() to use folios
      mm/migrate: convert putback_movable_pages() to use folios

Vlastimil Babka (1):
      mm, mremap: fix mremap() expanding for vma's with vm_ops->close()

Waiman Long (2):
      mm/kmemleak: simplify kmemleak_cond_resched() usage
      mm/kmemleak: fix UAF bug in kmemleak_scan()

Wei Yang (1):
      maple_tree: should get pivots boundary by type

Wenchao Hao (1):
      cma: tracing: print alloc result in trace_cma_alloc_finish

Xu Panda (2):
      selftests/vm: ksm_functional_tests: fix a typo in comment
      mm/damon/sysfs-schemes: use strscpy() to instead of strncpy()

Yafang Shao (1):
      mm: percpu: fix incorrect size in pcpu_obj_full_size()

Yajun Deng (1):
      mm/page_alloc: reduce fallbacks to (MIGRATE_PCPTYPES - 1)

Yang Yang (1):
      swap_state: update shadow_nodes for anonymous page

Yin Fengwei (1):
      mm/thp: check and bail out if page in deferred queue already

Yu Zhao (12):
      mm: multi-gen LRU: rename lru_gen_struct to lru_gen_folio
      mm: multi-gen LRU: rename lrugen->lists[] to lrugen->folios[]
      mm: multi-gen LRU: remove eviction fairness safeguard
      mm: multi-gen LRU: remove aging fairness safeguard
      mm: multi-gen LRU: shuffle should_run_aging()
      mm: multi-gen LRU: per-node lru_gen_folio lists
      mm: multi-gen LRU: clarify scan_control flags
      mm: multi-gen LRU: simplify arch_has_hw_pte_young() check
      mm: add vma_has_recency()
      mm: support POSIX_FADV_NOREUSE
      mm: multi-gen LRU: fix crash during cgroup migration
      mm: multi-gen LRU: avoid futile retries

Zach O'Keefe (1):
      mm/MADV_COLLAPSE: catch !none !huge !bad pmd lookups

Zhaoyang Huang (2):
      mm: use stack_depot_early_init for kmemleak
      mm: move KMEMLEAK's Kconfig items from lib to mm

ye xingchen (1):
      Kconfig.debug: fix the help description in SCHED_DEBUG

 .mailmap                                           |    3 +
 Documentation/ABI/stable/sysfs-devices-node        |   39 +
 Documentation/ABI/testing/sysfs-kernel-mm-damon    |   29 +
 Documentation/admin-guide/cgroup-v1/memory.rst     |   13 +-
 Documentation/admin-guide/cgroup-v2.rst            |   15 +-
 Documentation/admin-guide/mm/damon/reclaim.rst     |    9 +
 Documentation/admin-guide/mm/damon/usage.rst       |  105 +-
 Documentation/admin-guide/mm/hugetlbpage.rst       |    6 +-
 .../admin-guide/mm/idle_page_tracking.rst          |    2 +-
 Documentation/admin-guide/mm/numaperf.rst          |    8 +-
 Documentation/admin-guide/mm/pagemap.rst           |    4 +-
 Documentation/core-api/pin_user_pages.rst          |   31 +-
 Documentation/dev-tools/kasan.rst                  |   17 +
 Documentation/mm/balance.rst                       |    2 +-
 Documentation/mm/damon/index.rst                   |   22 +-
 Documentation/mm/damon/maintainer-profile.rst      |   62 ++
 Documentation/mm/highmem.rst                       |   43 +-
 Documentation/mm/hugetlbfs_reserv.rst              |   21 +-
 Documentation/mm/multigen_lru.rst                  |   86 +-
 Documentation/mm/page_owner.rst                    |    2 +-
 Documentation/mm/slub.rst                          |    2 +-
 Documentation/mm/transhuge.rst                     |   24 +-
 Documentation/mm/unevictable-lru.rst               |  151 +--
 Documentation/mm/zsmalloc.rst                      |  168 +++
 .../translations/zh_CN/mm/hugetlbfs_reserv.rst     |   14 +-
 Documentation/translations/zh_CN/mm/page_owner.rst |    2 +-
 MAINTAINERS                                        |   14 +-
 arch/alpha/include/asm/page.h                      |    9 +-
 arch/alpha/include/asm/pgtable.h                   |   40 +-
 arch/arc/include/asm/page.h                        |    1 -
 arch/arc/include/asm/pgtable-bits-arcv2.h          |   26 +-
 arch/arm/include/asm/memory.h                      |    2 -
 arch/arm/include/asm/page.h                        |    2 +
 arch/arm/include/asm/pgtable-2level.h              |    3 +
 arch/arm/include/asm/pgtable-3level.h              |    3 +
 arch/arm/include/asm/pgtable.h                     |   34 +-
 arch/arm/kernel/process.c                          |    2 +-
 arch/arm64/include/asm/page.h                      |    4 +-
 arch/arm64/include/asm/pgtable.h                   |    1 -
 arch/arm64/kernel/vdso.c                           |    6 +-
 arch/arm64/mm/fault.c                              |    4 +-
 arch/csky/abiv1/inc/abi/pgtable-bits.h             |   13 +-
 arch/csky/abiv2/inc/abi/pgtable-bits.h             |   19 +-
 arch/csky/include/asm/page.h                       |    1 -
 arch/csky/include/asm/pgtable.h                    |   17 +
 arch/hexagon/include/asm/page.h                    |    1 -
 arch/hexagon/include/asm/pgtable.h                 |   36 +-
 arch/ia64/include/asm/page.h                       |   18 +-
 arch/ia64/include/asm/pgtable.h                    |   31 +-
 arch/ia64/kernel/sys_ia64.c                        |    7 +-
 arch/ia64/mm/init.c                                |    8 +-
 arch/loongarch/include/asm/page.h                  |   13 -
 arch/loongarch/include/asm/pgtable-bits.h          |    4 +
 arch/loongarch/include/asm/pgtable.h               |   38 +-
 arch/loongarch/include/asm/tlb.h                   |    2 +-
 arch/m68k/include/asm/mcf_pgtable.h                |   35 +-
 arch/m68k/include/asm/motorola_pgtable.h           |   39 +-
 arch/m68k/include/asm/page.h                       |    6 +-
 arch/m68k/include/asm/page_mm.h                    |    1 -
 arch/m68k/include/asm/page_no.h                    |   11 +-
 arch/m68k/include/asm/pgtable_no.h                 |    6 -
 arch/m68k/include/asm/sun3_pgtable.h               |   38 +-
 arch/microblaze/include/asm/page.h                 |    1 -
 arch/microblaze/include/asm/pgtable.h              |   44 +-
 arch/mips/include/asm/page.h                       |   28 -
 arch/mips/include/asm/pgtable-32.h                 |   88 +-
 arch/mips/include/asm/pgtable-64.h                 |   23 +-
 arch/mips/include/asm/pgtable.h                    |   35 +
 arch/nios2/include/asm/page.h                      |    9 -
 arch/nios2/include/asm/pgtable-bits.h              |    3 +
 arch/nios2/include/asm/pgtable.h                   |   37 +-
 arch/openrisc/include/asm/page.h                   |    2 -
 arch/openrisc/include/asm/pgtable.h                |   40 +-
 arch/parisc/include/asm/page.h                     |    4 -
 arch/parisc/include/asm/pgtable.h                  |   40 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |   37 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |    1 -
 arch/powerpc/include/asm/nohash/32/pgtable.h       |   22 +-
 arch/powerpc/include/asm/nohash/32/pte-40x.h       |    6 +-
 arch/powerpc/include/asm/nohash/32/pte-44x.h       |   18 +-
 arch/powerpc/include/asm/nohash/32/pte-85xx.h      |    4 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h       |   24 +-
 arch/powerpc/include/asm/nohash/pgtable.h          |   15 +
 arch/powerpc/include/asm/nohash/pte-e500.h         |    1 -
 arch/powerpc/include/asm/page.h                    |    9 -
 arch/powerpc/kernel/pci_64.c                       |    2 +-
 arch/powerpc/kernel/vdso.c                         |    4 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c                 |    6 +-
 arch/powerpc/kvm/book3s_xive_native.c              |    2 +-
 arch/powerpc/mm/book3s64/subpage_prot.c            |    2 +-
 arch/powerpc/platforms/book3s/vas-api.c            |    4 +-
 arch/powerpc/platforms/cell/spufs/file.c           |   14 +-
 arch/powerpc/platforms/pseries/vas.c               |    3 +-
 arch/riscv/include/asm/page.h                      |    5 -
 arch/riscv/include/asm/pgtable-bits.h              |    3 +
 arch/riscv/include/asm/pgtable.h                   |   28 +-
 arch/riscv/kernel/vdso.c                           |    6 +-
 arch/s390/include/asm/page.h                       |    5 +-
 arch/s390/include/asm/pgtable.h                    |    1 -
 arch/s390/kernel/vdso.c                            |    4 +-
 arch/s390/mm/gmap.c                                |   11 +-
 arch/sh/include/asm/page.h                         |    3 -
 arch/sh/include/asm/pgtable_32.h                   |   53 +-
 arch/sh/kernel/cpu/sh4/sq.c                        |    2 +-
 arch/sh/kernel/vmlinux.lds.S                       |    1 +
 arch/sh/mm/init.c                                  |    1 +
 arch/sparc/include/asm/page_32.h                   |    1 -
 arch/sparc/include/asm/pgtable_32.h                |   26 +-
 arch/sparc/include/asm/pgtable_64.h                |   37 +-
 arch/sparc/include/asm/pgtsrmmu.h                  |   14 +-
 arch/um/include/asm/page.h                         |    1 -
 arch/um/include/asm/pgtable.h                      |   36 +-
 arch/x86/entry/vdso/vma.c                          |    4 +-
 arch/x86/entry/vsyscall/vsyscall_64.c              |    2 +-
 arch/x86/include/asm/page.h                        |    5 +-
 arch/x86/include/asm/page_32.h                     |    4 -
 arch/x86/include/asm/page_64.h                     |    4 -
 arch/x86/include/asm/pgtable-2level.h              |   26 +-
 arch/x86/include/asm/pgtable-3level.h              |   26 +-
 arch/x86/include/asm/pgtable.h                     |   27 +-
 arch/x86/kernel/cpu/sgx/driver.c                   |    2 +-
 arch/x86/kernel/cpu/sgx/virt.c                     |    2 +-
 arch/x86/mm/fault.c                                |   23 +-
 arch/x86/mm/pat/memtype.c                          |   14 +-
 arch/x86/um/mem_32.c                               |    2 +-
 arch/xtensa/include/asm/page.h                     |    4 +-
 arch/xtensa/include/asm/pgtable.h                  |   31 +-
 block/bdev.c                                       |   78 --
 drivers/acpi/pfr_telemetry.c                       |    2 +-
 drivers/android/binder.c                           |    3 +-
 drivers/android/binder_alloc.c                     |    2 +-
 drivers/base/node.c                                |    3 +
 drivers/block/brd.c                                |   15 +-
 drivers/block/zram/zram_drv.c                      |   69 +-
 drivers/char/mem.c                                 |    2 +-
 drivers/char/mspec.c                               |    2 +-
 drivers/crypto/hisilicon/qm.c                      |    2 +-
 drivers/dax/device.c                               |    2 +-
 drivers/dma/idxd/cdev.c                            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    4 +-
 drivers/gpu/drm/drm_gem.c                          |    2 +-
 drivers/gpu/drm/drm_gem_dma_helper.c               |    3 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |    2 +-
 drivers/gpu/drm/drm_vm.c                           |    8 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |    4 +-
 drivers/gpu/drm/gma500/framebuffer.c               |    2 +-
 drivers/gpu/drm/i810/i810_dma.c                    |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |    4 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |    2 +-
 drivers/gpu/drm/msm/msm_gem.c                      |    2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |    3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |    3 +-
 drivers/gpu/drm/tegra/gem.c                        |    5 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    3 +-
 drivers/gpu/drm/virtio/virtgpu_vram.c              |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c           |    2 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c            |    3 +-
 drivers/hsi/clients/cmt_speech.c                   |    2 +-
 drivers/hwtracing/intel_th/msu.c                   |    2 +-
 drivers/hwtracing/stm/core.c                       |    2 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |    4 +-
 drivers/infiniband/hw/mlx5/main.c                  |    4 +-
 drivers/infiniband/hw/qib/qib_file_ops.c           |   13 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |    2 +-
 drivers/iommu/tegra-smmu.c                         |    4 +-
 .../media/common/videobuf2/videobuf2-dma-contig.c  |    2 +-
 drivers/media/common/videobuf2/videobuf2-vmalloc.c |    2 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c      |    2 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c          |    4 +-
 drivers/media/v4l2-core/videobuf-vmalloc.c         |    2 +-
 drivers/misc/cxl/context.c                         |    2 +-
 drivers/misc/habanalabs/common/memory.c            |    2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |    4 +-
 drivers/misc/habanalabs/gaudi2/gaudi2.c            |    8 +-
 drivers/misc/habanalabs/goya/goya.c                |    4 +-
 drivers/misc/ocxl/context.c                        |    4 +-
 drivers/misc/ocxl/sysfs.c                          |    2 +-
 drivers/misc/open-dice.c                           |   18 +-
 drivers/misc/sgi-gru/grufile.c                     |    4 +-
 drivers/misc/uacce/uacce.c                         |    2 +-
 drivers/nvdimm/btt.c                               |   16 +-
 drivers/nvdimm/pmem.c                              |   24 +-
 drivers/of/fdt.c                                   |    6 +-
 drivers/of/of_reserved_mem.c                       |    3 +-
 drivers/sbus/char/oradax.c                         |    2 +-
 drivers/scsi/cxlflash/ocxl_hw.c                    |    2 +-
 drivers/scsi/sg.c                                  |    2 +-
 drivers/staging/media/atomisp/pci/hmm/hmm_bo.c     |    2 +-
 drivers/staging/media/deprecated/meye/meye.c       |    4 +-
 .../media/deprecated/stkwebcam/stk-webcam.c        |    2 +-
 drivers/target/target_core_user.c                  |    2 +-
 drivers/uio/uio.c                                  |    2 +-
 drivers/usb/core/devio.c                           |    3 +-
 drivers/usb/mon/mon_bin.c                          |    3 +-
 drivers/vdpa/vdpa_user/iova_domain.c               |    2 +-
 drivers/vfio/pci/vfio_pci_core.c                   |    2 +-
 drivers/vhost/vdpa.c                               |    2 +-
 drivers/video/fbdev/68328fb.c                      |    2 +-
 drivers/video/fbdev/core/fb_defio.c                |    4 +-
 drivers/xen/gntalloc.c                             |    2 +-
 drivers/xen/gntdev.c                               |    4 +-
 drivers/xen/privcmd-buf.c                          |    2 +-
 drivers/xen/privcmd.c                              |    4 +-
 fs/afs/write.c                                     |  116 ++-
 fs/aio.c                                           |    6 +-
 fs/btrfs/extent_io.c                               |   57 +-
 fs/buffer.c                                        |   54 +-
 fs/ceph/addr.c                                     |   58 +-
 fs/cifs/file.c                                     |   40 +-
 fs/coredump.c                                      |    8 +-
 fs/cramfs/inode.c                                  |    4 +-
 fs/dax.c                                           |    5 +-
 fs/erofs/data.c                                    |    2 +-
 fs/exec.c                                          |   20 +-
 fs/ext4/file.c                                     |    2 +-
 fs/ext4/inode.c                                    |   69 +-
 fs/ext4/move_extent.c                              |   46 +-
 fs/ext4/super.c                                    |    6 +-
 fs/f2fs/checkpoint.c                               |   49 +-
 fs/f2fs/data.c                                     |   84 +-
 fs/f2fs/node.c                                     |   72 +-
 fs/freevxfs/Kconfig                                |    2 +-
 fs/fs-writeback.c                                  |   10 +-
 fs/fuse/dax.c                                      |    2 +-
 fs/fuse/file.c                                     |   18 +-
 fs/gfs2/aops.c                                     |   64 +-
 fs/gfs2/glops.c                                    |    2 +-
 fs/gfs2/log.c                                      |    2 +-
 fs/gfs2/meta_io.c                                  |    2 +-
 fs/hugetlbfs/inode.c                               |   72 +-
 fs/iomap/buffered-io.c                             |    5 +-
 fs/jbd2/commit.c                                   |   33 +-
 fs/jbd2/journal.c                                  |    3 +-
 fs/mpage.c                                         |   73 +-
 fs/nfs/write.c                                     |    7 +-
 fs/nilfs2/btnode.c                                 |    2 +-
 fs/nilfs2/btree.c                                  |   16 +-
 fs/nilfs2/gcinode.c                                |    2 +-
 fs/nilfs2/mdt.c                                    |    4 +-
 fs/nilfs2/page.c                                   |   59 +-
 fs/nilfs2/segment.c                                |   46 +-
 fs/ntfs3/inode.c                                   |   33 +-
 fs/ocfs2/journal.c                                 |   16 +-
 fs/orangefs/file.c                                 |    3 +-
 fs/orangefs/inode.c                                |   23 +-
 fs/proc/task_mmu.c                                 |   35 +-
 fs/proc/task_nommu.c                               |    2 +-
 fs/proc/vmcore.c                                   |    3 +-
 fs/ramfs/file-nommu.c                              |    2 +-
 fs/reiserfs/journal.c                              |    4 +-
 fs/reiserfs/tail_conversion.c                      |    2 +-
 fs/romfs/mmap-nommu.c                              |    2 +-
 fs/squashfs/squashfs_fs.h                          |    2 +-
 fs/squashfs/squashfs_fs_sb.h                       |    2 +-
 fs/squashfs/xattr.h                                |    4 +-
 fs/squashfs/xattr_id.c                             |    2 +-
 fs/userfaultfd.c                                   |  115 +-
 fs/xfs/xfs_file.c                                  |    2 +-
 include/asm-generic/hugetlb.h                      |   16 +-
 include/asm-generic/memory_model.h                 |   12 +
 include/asm-generic/page.h                         |    2 -
 include/linux/blkdev.h                             |   12 +-
 include/linux/buffer_head.h                        |    5 +-
 include/linux/damon.h                              |   68 +-
 include/linux/fs.h                                 |    2 +
 include/linux/gfp_types.h                          |   12 +-
 include/linux/highmem-internal.h                   |    4 +-
 include/linux/highmem.h                            |   72 +-
 include/linux/huge_mm.h                            |   13 +-
 include/linux/hugetlb.h                            |  122 ++-
 include/linux/hugetlb_cgroup.h                     |    8 +-
 include/linux/jbd2.h                               |    2 -
 include/linux/kasan.h                              |   36 +-
 include/linux/maple_tree.h                         |   19 +-
 include/linux/memcontrol.h                         |   71 +-
 include/linux/migrate.h                            |   30 +-
 include/linux/mm.h                                 |  554 +++++-----
 include/linux/mm_inline.h                          |   19 +-
 include/linux/mm_types.h                           |  186 ++--
 include/linux/mman.h                               |   34 +
 include/linux/mmu_notifier.h                       |   13 +-
 include/linux/mmzone.h                             |  150 ++-
 include/linux/page-flags.h                         |    1 +
 include/linux/page_ext.h                           |   20 +
 include/linux/pagemap.h                            |   34 +-
 include/linux/pagevec.h                            |   13 +-
 include/linux/pagewalk.h                           |   11 +-
 include/linux/pgtable.h                            |   34 +-
 include/linux/pid_namespace.h                      |   19 +
 include/linux/rmap.h                               |   13 +-
 include/linux/sched/coredump.h                     |    6 +-
 include/linux/shmem_fs.h                           |   18 +-
 include/linux/shrinker.h                           |    5 +-
 include/linux/slab_def.h                           |    2 +-
 include/linux/slub_def.h                           |    2 +-
 include/linux/stackdepot.h                         |  152 ++-
 include/linux/string.h                             |    1 +
 include/linux/swap.h                               |    7 +-
 include/linux/swapops.h                            |    6 +-
 include/linux/userfaultfd_k.h                      |    2 +-
 include/linux/vmalloc.h                            |    1 +
 include/linux/writeback.h                          |   16 +-
 include/linux/xarray.h                             |    3 +-
 include/trace/events/cma.h                         |   32 +-
 include/trace/events/mmflags.h                     |    1 -
 include/uapi/linux/fcntl.h                         |    1 +
 include/uapi/linux/memfd.h                         |    4 +
 include/uapi/linux/prctl.h                         |    6 +
 init/main.c                                        |    6 +-
 io_uring/io_uring.c                                |    2 +-
 ipc/shm.c                                          |    8 +-
 kernel/bpf/ringbuf.c                               |    4 +-
 kernel/bpf/syscall.c                               |    4 +-
 kernel/crash_core.c                                |    4 +-
 kernel/events/core.c                               |    2 +-
 kernel/events/uprobes.c                            |    5 +-
 kernel/fork.c                                      |   23 +-
 kernel/kcov.c                                      |    2 +-
 kernel/pid_namespace.c                             |    5 +
 kernel/pid_sysctl.h                                |   60 ++
 kernel/relay.c                                     |    2 +-
 kernel/sched/fair.c                                |   14 +-
 kernel/sys.c                                       |   33 +
 lib/Kconfig.debug                                  |   72 +-
 lib/maple_tree.c                                   |  174 ++--
 lib/parser.c                                       |   39 +-
 lib/stackdepot.c                                   |  654 ++++++------
 lib/test_maple_tree.c                              |  161 +++
 lib/test_printf.c                                  |    8 +-
 lib/test_vmalloc.c                                 |    8 +-
 mm/Kconfig                                         |   21 +-
 mm/Kconfig.debug                                   |   74 +-
 mm/cma.c                                           |   26 +-
 mm/compaction.c                                    |  101 +-
 mm/damon/Kconfig                                   |    7 +-
 mm/damon/core-test.h                               |   30 +
 mm/damon/core.c                                    |  113 +-
 mm/damon/dbgfs.c                                   |   19 +
 mm/damon/ops-common.c                              |   38 +-
 mm/damon/ops-common.h                              |    2 +-
 mm/damon/paddr.c                                   |  163 +--
 mm/damon/reclaim.c                                 |   19 +
 mm/damon/sysfs-common.c                            |    2 +-
 mm/damon/sysfs-common.h                            |    4 +-
 mm/damon/sysfs-schemes.c                           |  391 ++++++-
 mm/damon/sysfs.c                                   |   22 +-
 mm/damon/vaddr-test.h                              |   20 +-
 mm/damon/vaddr.c                                   |   68 +-
 mm/debug.c                                         |    9 +-
 mm/debug_vm_pgtable.c                              |  129 ++-
 mm/fadvise.c                                       |    5 +-
 mm/filemap.c                                       |  138 +--
 mm/folio-compat.c                                  |   15 +-
 mm/gup.c                                           |  382 ++++---
 mm/hmm.c                                           |   15 +-
 mm/huge_memory.c                                   |  176 ++--
 mm/hugetlb.c                                       |  664 ++++++------
 mm/hugetlb_cgroup.c                                |    8 +-
 mm/internal.h                                      |  276 ++++-
 mm/kasan/common.c                                  |   23 +-
 mm/kasan/generic.c                                 |   11 +-
 mm/kasan/hw_tags.c                                 |   60 ++
 mm/kasan/kasan.h                                   |   33 +-
 mm/kasan/report.c                                  |   41 +-
 mm/kasan/report_generic.c                          |   32 +-
 mm/kasan/report_hw_tags.c                          |   35 +-
 mm/kasan/report_sw_tags.c                          |   26 +
 mm/kasan/report_tags.c                             |    2 +-
 mm/kasan/shadow.c                                  |   12 +
 mm/kasan/sw_tags.c                                 |    6 +-
 mm/khugepaged.c                                    |   69 +-
 mm/kmemleak.c                                      |   88 +-
 mm/kmsan/Makefile                                  |    8 +-
 mm/kmsan/core.c                                    |   10 +-
 mm/kmsan/instrumentation.c                         |   23 +
 mm/ksm.c                                           |   12 +-
 mm/madvise.c                                       |  123 ++-
 mm/mapping_dirty_helpers.c                         |    2 +-
 mm/memcontrol.c                                    |  165 ++-
 mm/memfd.c                                         |   56 +-
 mm/memory-failure.c                                |  223 ++--
 mm/memory-tiers.c                                  |    4 +-
 mm/memory.c                                        |  254 +++--
 mm/memory_hotplug.c                                |   16 +-
 mm/mempolicy.c                                     |  189 ++--
 mm/memremap.c                                      |    6 +-
 mm/migrate.c                                       |  934 ++++++++++++-----
 mm/migrate_device.c                                |    6 +-
 mm/mlock.c                                         |  351 ++++---
 mm/mmap.c                                          | 1090 ++++++++++------=
---
 mm/mmu_notifier.c                                  |   10 -
 mm/mprotect.c                                      |  161 +--
 mm/mremap.c                                        |   72 +-
 mm/nommu.c                                         |  197 ++--
 mm/oom_kill.c                                      |    2 +-
 mm/page-writeback.c                                |  107 +-
 mm/page_alloc.c                                    |  233 +++--
 mm/page_ext.c                                      |   16 +-
 mm/page_idle.c                                     |   47 +-
 mm/page_io.c                                       |  183 ++--
 mm/page_owner.c                                    |    6 +-
 mm/page_reporting.c                                |    6 +-
 mm/page_table_check.c                              |    1 +
 mm/page_vma_mapped.c                               |    9 +-
 mm/pagewalk.c                                      |    6 +-
 mm/percpu-internal.h                               |    6 +-
 mm/percpu.c                                        |    2 +-
 mm/readahead.c                                     |   39 +-
 mm/rmap.c                                          |  325 +++---
 mm/secretmem.c                                     |    4 +-
 mm/shmem.c                                         |  105 +-
 mm/shrinker_debug.c                                |   13 +-
 mm/slab.c                                          |    2 +-
 mm/slab.h                                          |   18 +-
 mm/slab_common.c                                   |    1 -
 mm/slub.c                                          |    6 +-
 mm/sparse.c                                        |    2 +-
 mm/swap.c                                          |   50 +-
 mm/swap.h                                          |   10 +-
 mm/swap_state.c                                    |   65 +-
 mm/swapfile.c                                      |   32 +-
 mm/userfaultfd.c                                   |   49 +-
 mm/util.c                                          |   26 +-
 mm/vmalloc.c                                       |  461 +++++----
 mm/vmscan.c                                        | 1094 +++++++++++++---=
----
 mm/workingset.c                                    |   28 +-
 mm/z3fold.c                                        |    2 -
 mm/zsmalloc.c                                      |  311 ++++--
 net/ipv4/tcp.c                                     |   11 +-
 scripts/gdb/linux/cpus.py                          |    2 +-
 security/apparmor/policy_unpack.c                  |   11 +-
 security/selinux/selinuxfs.c                       |    6 +-
 sound/core/oss/pcm_oss.c                           |    2 +-
 sound/core/pcm_native.c                            |    9 +-
 sound/soc/pxa/mmp-sspa.c                           |    2 +-
 sound/usb/usx2y/us122l.c                           |    4 +-
 sound/usb/usx2y/usX2Yhwdep.c                       |    2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c                    |    2 +-
 tools/cgroup/memcg_shrinker.py                     |    3 +-
 tools/{vm =3D> mm}/.gitignore                        |    0
 tools/{vm =3D> mm}/Makefile                          |    4 +-
 tools/{vm =3D> mm}/page-types.c                      |    0
 tools/{vm =3D> mm}/page_owner_sort.c                 |   65 +-
 tools/{vm =3D> mm}/slabinfo-gnuplot.sh               |    0
 tools/{vm =3D> mm}/slabinfo.c                        |    0
 tools/objtool/check.c                              |    2 +
 tools/perf/builtin-kmem.c                          |    1 -
 tools/testing/radix-tree/maple.c                   |   50 +-
 tools/testing/selftests/Makefile                   |    2 +-
 .../selftests/damon/debugfs_rm_non_contexts.sh     |    2 +-
 tools/testing/selftests/damon/sysfs.sh             |   31 +-
 .../selftests/filesystems/fat/run_fat_tests.sh     |    0
 tools/testing/selftests/kselftest_deps.sh          |    6 +-
 tools/testing/selftests/memfd/fuse_test.c          |    1 +
 tools/testing/selftests/memfd/memfd_test.c         |  341 +++++-
 tools/testing/selftests/{vm =3D> mm}/.gitignore      |    0
 tools/testing/selftests/{vm =3D> mm}/Makefile        |    9 +-
 .../{vm =3D> mm}/charge_reserved_hugetlb.sh          |    0
 tools/testing/selftests/{vm =3D> mm}/check_config.sh |    0
 .../testing/selftests/{vm =3D> mm}/compaction_test.c |    0
 tools/testing/selftests/{vm =3D> mm}/config          |    0
 tools/testing/selftests/{vm =3D> mm}/cow.c           |  231 +++++
 tools/testing/selftests/{vm =3D> mm}/gup_test.c      |    0
 tools/testing/selftests/{vm =3D> mm}/hmm-tests.c     |    0
 tools/testing/selftests/{vm =3D> mm}/hugepage-mmap.c |    0
 .../testing/selftests/{vm =3D> mm}/hugepage-mremap.c |    0
 tools/testing/selftests/{vm =3D> mm}/hugepage-shm.c  |    0
 .../selftests/{vm =3D> mm}/hugepage-vmemmap.c        |    0
 .../testing/selftests/{vm =3D> mm}/hugetlb-madvise.c |    1 -
 .../{vm =3D> mm}/hugetlb_reparenting_test.sh         |    0
 tools/testing/selftests/{vm =3D> mm}/khugepaged.c    |    0
 .../selftests/{vm =3D> mm}/ksm_functional_tests.c    |    2 +-
 tools/testing/selftests/{vm =3D> mm}/ksm_tests.c     |    0
 tools/testing/selftests/{vm =3D> mm}/madv_populate.c |    0
 .../selftests/{vm =3D> mm}/map_fixed_noreplace.c     |    0
 tools/testing/selftests/{vm =3D> mm}/map_hugetlb.c   |    0
 tools/testing/selftests/{vm =3D> mm}/map_populate.c  |    0
 tools/testing/selftests/mm/mdwe_test.c             |  197 ++++
 tools/testing/selftests/{vm =3D> mm}/memfd_secret.c  |    0
 tools/testing/selftests/{vm =3D> mm}/migration.c     |    0
 .../selftests/{vm =3D> mm}/mlock-random-test.c       |    0
 tools/testing/selftests/{vm =3D> mm}/mlock2-tests.c  |    0
 tools/testing/selftests/{vm =3D> mm}/mlock2.h        |    0
 tools/testing/selftests/{vm =3D> mm}/mrelease_test.c |    0
 .../selftests/{vm =3D> mm}/mremap_dontunmap.c        |    0
 tools/testing/selftests/{vm =3D> mm}/mremap_test.c   |  119 ++-
 .../testing/selftests/{vm =3D> mm}/on-fault-limit.c  |    0
 tools/testing/selftests/{vm =3D> mm}/pkey-helpers.h  |    0
 tools/testing/selftests/{vm =3D> mm}/pkey-powerpc.h  |    0
 tools/testing/selftests/{vm =3D> mm}/pkey-x86.h      |    0
 .../testing/selftests/{vm =3D> mm}/protection_keys.c |    0
 tools/testing/selftests/{vm =3D> mm}/run_vmtests.sh  |    0
 tools/testing/selftests/{vm =3D> mm}/settings        |    0
 tools/testing/selftests/{vm =3D> mm}/soft-dirty.c    |    0
 .../selftests/{vm =3D> mm}/split_huge_page_test.c    |    0
 tools/testing/selftests/{vm =3D> mm}/test_hmm.sh     |    0
 tools/testing/selftests/{vm =3D> mm}/test_vmalloc.sh |    0
 tools/testing/selftests/{vm =3D> mm}/thuge-gen.c     |    0
 .../selftests/{vm =3D> mm}/transhuge-stress.c        |    0
 tools/testing/selftests/{vm =3D> mm}/userfaultfd.c   |    0
 tools/testing/selftests/{vm =3D> mm}/util.h          |    0
 .../testing/selftests/{vm =3D> mm}/va_128TBswitch.c  |    0
 .../testing/selftests/{vm =3D> mm}/va_128TBswitch.sh |    0
 .../selftests/{vm =3D> mm}/virtual_address_range.c   |    0
 tools/testing/selftests/{vm =3D> mm}/vm_util.c       |    0
 tools/testing/selftests/{vm =3D> mm}/vm_util.h       |    0
 .../selftests/{vm =3D> mm}/write_hugetlb_memory.sh   |    0
 .../selftests/{vm =3D> mm}/write_to_hugetlbfs.c      |    0
 514 files changed, 11969 insertions(+), 7004 deletions(-)
 create mode 100644 Documentation/mm/damon/maintainer-profile.rst
 create mode 100644 kernel/pid_sysctl.h
 rename tools/{vm =3D> mm}/.gitignore (100%)
 rename tools/{vm =3D> mm}/Makefile (90%)
 rename tools/{vm =3D> mm}/page-types.c (100%)
 rename tools/{vm =3D> mm}/page_owner_sort.c (95%)
 rename tools/{vm =3D> mm}/slabinfo-gnuplot.sh (100%)
 rename tools/{vm =3D> mm}/slabinfo.c (100%)
 mode change 100644 =3D> 100755 tools/testing/selftests/filesystems/fat/run=
_fat_tests.sh
 rename tools/testing/selftests/{vm =3D> mm}/.gitignore (100%)
 rename tools/testing/selftests/{vm =3D> mm}/Makefile (96%)
 rename tools/testing/selftests/{vm =3D> mm}/charge_reserved_hugetlb.sh (10=
0%)
 rename tools/testing/selftests/{vm =3D> mm}/check_config.sh (100%)
 rename tools/testing/selftests/{vm =3D> mm}/compaction_test.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/config (100%)
 rename tools/testing/selftests/{vm =3D> mm}/cow.c (86%)
 rename tools/testing/selftests/{vm =3D> mm}/gup_test.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/hmm-tests.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/hugepage-mmap.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/hugepage-mremap.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/hugepage-shm.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/hugepage-vmemmap.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/hugetlb-madvise.c (99%)
 rename tools/testing/selftests/{vm =3D> mm}/hugetlb_reparenting_test.sh (1=
00%)
 rename tools/testing/selftests/{vm =3D> mm}/khugepaged.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/ksm_functional_tests.c (99%)
 rename tools/testing/selftests/{vm =3D> mm}/ksm_tests.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/madv_populate.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/map_fixed_noreplace.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/map_hugetlb.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/map_populate.c (100%)
 create mode 100644 tools/testing/selftests/mm/mdwe_test.c
 rename tools/testing/selftests/{vm =3D> mm}/memfd_secret.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/migration.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/mlock-random-test.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/mlock2-tests.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/mlock2.h (100%)
 rename tools/testing/selftests/{vm =3D> mm}/mrelease_test.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/mremap_dontunmap.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/mremap_test.c (84%)
 rename tools/testing/selftests/{vm =3D> mm}/on-fault-limit.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/pkey-helpers.h (100%)
 rename tools/testing/selftests/{vm =3D> mm}/pkey-powerpc.h (100%)
 rename tools/testing/selftests/{vm =3D> mm}/pkey-x86.h (100%)
 rename tools/testing/selftests/{vm =3D> mm}/protection_keys.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/run_vmtests.sh (100%)
 mode change 100755 =3D> 100644
 rename tools/testing/selftests/{vm =3D> mm}/settings (100%)
 rename tools/testing/selftests/{vm =3D> mm}/soft-dirty.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/split_huge_page_test.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/test_hmm.sh (100%)
 mode change 100755 =3D> 100644
 rename tools/testing/selftests/{vm =3D> mm}/test_vmalloc.sh (100%)
 mode change 100755 =3D> 100644
 rename tools/testing/selftests/{vm =3D> mm}/thuge-gen.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/transhuge-stress.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/userfaultfd.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/util.h (100%)
 rename tools/testing/selftests/{vm =3D> mm}/va_128TBswitch.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/va_128TBswitch.sh (100%)
 mode change 100755 =3D> 100644
 rename tools/testing/selftests/{vm =3D> mm}/virtual_address_range.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/vm_util.c (100%)
 rename tools/testing/selftests/{vm =3D> mm}/vm_util.h (100%)
 rename tools/testing/selftests/{vm =3D> mm}/write_hugetlb_memory.sh (100%)
 rename tools/testing/selftests/{vm =3D> mm}/write_to_hugetlbfs.c (100%)

