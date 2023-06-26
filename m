Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857BA73E3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjFZPup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFZPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D9AB;
        Mon, 26 Jun 2023 08:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03F1760E97;
        Mon, 26 Jun 2023 15:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1452AC433C0;
        Mon, 26 Jun 2023 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1687794638;
        bh=r1K/1x4JVjYcFtZM/UisF0g4N95xwe3dMccnelrEjzM=;
        h=Date:From:To:Cc:Subject:From;
        b=I7XFtK6rELSnTYg1piuPN/X6/hb0StexOshpB+Ecmx3hpCoNSwm7RwPnhR/ZDU02c
         RJcundMOKZnHWy9AqvpNrZ3m6Y2Y9r45X9dfNhG9GbLcnbBzcwQQnjNYS74UhAn98H
         lUekrG6SA1jhzSgnIE+8jBj6Bu6vklcj/k08zch0=
Date:   Mon, 26 Jun 2023 08:50:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] MM updates for 6.5-rc1
Message-Id: <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge the MM updates for the 6.5-rc cycle.

Known merge issues and their linux-next resolutions are:

merge conflict in mm/migrate.c, vs -tip tree:
https://lkml.kernel.org/r/20230622131609.3fdf314d@canb.auug.org.au

build issue in include/linux/init.h, vs -tip:
https://lkml.kernel.org/r/20230620145357.12d6b23f@canb.auug.org.au

merge conflict in mm/slab_common.c vs slab tree:
https://lkml.kernel.org/r/20230619140330.28437ac3@canb.auug.org.au

merge conflict in mm/gup.c, vs block tree:
https://lkml.kernel.org/r/20230616115856.3ce7682c@canb.auug.org.au

merge conflict in include/linux/mm.h, vs block tree:
https://lkml.kernel.org/r/20230616115058.57892241@canb.auug.org.au

merge conflict in fs/f2fs/file.c, vs f2fs tree:
https://lkml.kernel.org/r/20230616102524.73bb5efb@canb.auug.org.au

merge conflict in fs/btrfs/file.c, vs btrfs tree:
https://lkml.kernel.org/r/20230605090803.43597523@canb.auug.org.au

merge conflict in mm/gup.c, vs -tip tree:
https://lkml.kernel.org/r/20230504132148.182960-1-broonie@finisterre.sirena.org.uk

Thanks.



The following changes since commit 0518dbe97fe629fea255318841cf3ef1b4532d66:

  selftests/mm: fix cross compilation with LLVM (2023-06-19 13:19:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023-06-24-19-15

for you to fetch changes up to acc72d59c7509540c27c49625cb4b5a8db1f1a84:

  mm/hugetlb: remove hugetlb_set_page_subpool() (2023-06-23 16:59:33 -0700)

----------------------------------------------------------------
- Yosry Ahmed brought back some cgroup v1 stats in OOM logs.

- Yosry has also eliminated cgroup's atomic rstat flushing.

- Nhat Pham adds the new cachestat() syscall.  It provides userspace
  with the ability to query pagecache status - a similar concept to
  mincore() but more powerful and with improved usability.

- Mel Gorman provides more optimizations for compaction, reducing the
  prevalence of page rescanning.

- Lorenzo Stoakes has done some maintanance work on the get_user_pages()
  interface.

- Liam Howlett continues with cleanups and maintenance work to the maple
  tree code.  Peng Zhang also does some work on maple tree.

- Johannes Weiner has done some cleanup work on the compaction code.

- David Hildenbrand has contributed additional selftests for
  get_user_pages().

- Thomas Gleixner has contributed some maintenance and optimization work
  for the vmalloc code.

- Baolin Wang has provided some compaction cleanups,

- SeongJae Park continues maintenance work on the DAMON code.

- Huang Ying has done some maintenance on the swap code's usage of
  device refcounting.

- Christoph Hellwig has some cleanups for the filemap/directio code.

- Ryan Roberts provides two patch series which yield some
  rationalization of the kernel's access to pte entries - use the provided
  APIs rather than open-coding accesses.

- Lorenzo Stoakes has some fixes to the interaction between pagecache
  and directio access to file mappings.

- John Hubbard has a series of fixes to the MM selftesting code.

- ZhangPeng continues the folio conversion campaign.

- Hugh Dickins has been working on the pagetable handling code, mainly
  with a view to reducing the load on the mmap_lock.

- Catalin Marinas has reduced the arm64 kmalloc() minimum alignment from
  128 to 8.

- Domenico Cerasuolo has improved the zswap reclaim mechanism by
  reorganizing the LRU management.

- Matthew Wilcox provides some fixups to make gfs2 work better with the
  buffer_head code.

- Vishal Moola also has done some folio conversion work.

- Matthew Wilcox has removed the remnants of the pagevec code - their
  functionality is migrated over to struct folio_batch.

----------------------------------------------------------------
Ackerley Tng (1):
      fs: hugetlbfs: set vma policy only when needed for allocating folio

Alexey Romanov (1):
      mm/zsmalloc: get rid of PAGE_MASK

Anders Roxell (1):
      selftests: damon: add config file

Andrew Morton (2):
      mm/mlock: rename mlock_future_check() to mlock_future_ok()
      Merge mm-hotfixes-stable into mm-stable to pick up depended-upon changes.

Arnd Bergmann (2):
      kasan: add kasan_tag_mismatch prototype
      kasan: use internal prototypes matching gcc-13 builtins

Baolin Wang (9):
      mm/page_alloc: drop the unnecessary pfn_valid() for start pfn
      mm: compaction: drop the redundant page validation in update_pageblock_skip()
      mm: compaction: change fast_isolate_freepages() to void type
      mm: compaction: skip more fully scanned pageblock
      mm: compaction: only set skip flag if cc->no_set_skip_hint is false
      mm: compaction: add trace event for fast freepages isolation
      mm: compaction: skip fast freepages isolation if enough freepages are isolated
      mm: compaction: skip memory hole rapidly when isolating migratable pages
      mm: page_alloc: use the correct type of list for free pages

Catalin Marinas (18):
      mm/slab: decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
      dma: allow dma_get_cache_alignment() to be overridden by the arch code
      mm/slab: simplify create_kmalloc_cache() args and make it static
      mm/slab: limit kmalloc() minimum alignment to dma_get_cache_alignment()
      drivers/base: use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
      drivers/gpu: use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
      drivers/usb: use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
      drivers/spi: use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
      dm-crypt: use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
      iio: core: use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
      arm64: allow kmalloc() caches aligned to the smaller cache_line_size()
      dma-mapping: force bouncing if the kmalloc() size is not cache-line-aligned
      iommu/dma: force bouncing if the size is not cacheline-aligned
      mm: slab: reduce the kmalloc() minimum alignment if DMA bouncing possible
      arm64: enable ARCH_WANT_KMALLOC_DMA_BOUNCE for arm64
      powerpc: move the ARCH_DMA_MINALIGN definition to asm/cache.h
      microblaze: move the ARCH_{DMA,SLAB}_MINALIGN definitions to asm/cache.h
      sh: move the ARCH_DMA_MINALIGN definition to asm/cache.h

Christoph Hellwig (12):
      backing_dev: remove current->backing_dev_info
      iomap: update ki_pos a little later in iomap_dio_complete
      filemap: update ki_pos in generic_perform_write
      filemap: add a kiocb_write_and_wait helper
      filemap: add a kiocb_invalidate_pages helper
      filemap: add a kiocb_invalidate_post_direct_write helper
      iomap: update ki_pos in iomap_file_buffered_write
      iomap: use kiocb_write_and_wait and kiocb_invalidate_pages
      fs: factor out a direct_write_fallback helper
      fuse: update ki_pos in fuse_perform_write
      fuse: drop redundant arguments to fuse_perform_write
      fuse: use direct_write_fallback

David Hildenbrand (3):
      selftests/mm: factor out detection of hugetlb page sizes into vm_util
      selftests/mm: gup_longterm: new functional test for FOLL_LONGTERM
      selftests/mm: gup_longterm: add liburing tests

Domenico Cerasuolo (9):
      mm: zswap: shrink until can accept
      mm: zswap: add pool shrinking mechanism
      mm: zswap: remove page reclaim logic from zbud
      mm: zswap: remove page reclaim logic from z3fold
      mm: zswap: remove page reclaim logic from zsmalloc
      mm: zswap: remove shrink from zpool interface
      mm: zswap: simplify writeback function
      mm: zswap: remove zswap_header
      mm: zswap: invaldiate entry after writeback

Douglas Anderson (1):
      migrate_pages: avoid blocking for IO in MIGRATE_SYNC_LIGHT

Haifeng Xu (14):
      memcg, oom: remove unnecessary check in mem_cgroup_oom_synchronize()
      memcg, oom: remove explicit wakeup in mem_cgroup_oom_synchronize()
      mm, oom: do not check 0 mask in out_of_memory()
      mm/memcontrol: fix typo in comment
      selftests: cgroup: fix unexpected failure on test_memcg_low
      mm/mm_init.c: introduce reset_memoryless_node_totalpages()
      mm/mm_init.c: do not calculate zone_start_pfn/zone_end_pfn in zone_absent_pages_in_node()
      mm/mm_init.c: remove free_area_init_memoryless_node()
      mm/mm_init.c: move set_pageblock_order() to free_area_init()
      mm/mm_init.c: drop 'nid' parameter from check_for_memory()
      mm/memory_hotplug: remove reset_node_managed_pages() in hotadd_init_pgdat()
      mm/mm_init.c: remove reset_node_present_pages()
      mm/memcontrol: do not tweak node in mem_cgroup_init()
      selftests: cgroup: fix unexpected failure on test_memcg_sock

Huang Ying (6):
      migrate_pages_batch: simplify retrying and failure counting of large folios
      swap: remove get/put_swap_device() in __swap_count()
      swap, __read_swap_cache_async(): enlarge get/put_swap_device protection range
      swap: remove __swp_swapcount()
      swap: remove get/put_swap_device() in __swap_duplicate()
      swap: comments get_swap_device() with usage rule

Hugh Dickins (56):
      arm: allow pte_offset_map[_lock]() to fail
      arm64: allow pte_offset_map() to fail
      arm64/hugetlb: pte_alloc_huge() pte_offset_huge()
      ia64/hugetlb: pte_alloc_huge() pte_offset_huge()
      m68k: allow pte_offset_map[_lock]() to fail
      microblaze: allow pte_offset_map() to fail
      mips: add pte_unmap() to balance pte_offset_map()
      parisc: add pte_unmap() to balance get_ptep()
      parisc: unmap_uncached_pte() use pte_offset_kernel()
      parisc/hugetlb: pte_alloc_huge() pte_offset_huge()
      powerpc: kvmppc_unmap_free_pmd() pte_offset_kernel()
      powerpc: allow pte_offset_map[_lock]() to fail
      powerpc/hugetlb: pte_alloc_huge()
      riscv/hugetlb: pte_alloc_huge() pte_offset_huge()
      s390: allow pte_offset_map_lock() to fail
      s390: gmap use pte_unmap_unlock() not spin_unlock()
      sh/hugetlb: pte_alloc_huge() pte_offset_huge()
      sparc/hugetlb: pte_alloc_huge() pte_offset_huge()
      sparc: allow pte_offset_map() to fail
      sparc: iounit and iommu use pte_offset_kernel()
      x86: allow get_locked_pte() to fail
      x86: sme_populate_pgd() use pte_offset_kernel()
      xtensa: add pte_unmap() to balance pte_offset_map()
      mm: use pmdp_get_lockless() without surplus barrier()
      mm/migrate: remove cruft from migration_entry_wait()s
      mm/pgtable: kmap_local_page() instead of kmap_atomic()
      mm/pgtable: allow pte_offset_map[_lock]() to fail
      mm/filemap: allow pte_offset_map_lock() to fail
      mm/page_vma_mapped: delete bogosity in page_vma_mapped_walk()
      mm/page_vma_mapped: reformat map_pte() with less indentation
      mm/page_vma_mapped: pte_offset_map_nolock() not pte_lockptr()
      mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock() fails
      mm/pagewalk: walk_pte_range() allow for pte_offset_map()
      mm/vmwgfx: simplify pmd & pud mapping dirty helpers
      mm/vmalloc: vmalloc_to_page() use pte_offset_kernel()
      mm/hmm: retry if pte_offset_map() fails
      mm/userfaultfd: retry if pte_offset_map() fails
      mm/userfaultfd: allow pte_offset_map_lock() to fail
      mm/debug_vm_pgtable,page_table_check: warn pte map fails
      mm/various: give up if pte_offset_map[_lock]() fails
      mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()
      mm/mremap: retry if either pte_offset_map_*lock() fails
      mm/madvise: clean up pte_offset_map_lock() scans
      mm/madvise: clean up force_shm_swapin_readahead()
      mm/swapoff: allow pte_offset_map[_lock]() to fail
      mm/mglru: allow pte_offset_map_nolock() to fail
      mm/migrate_device: allow pte_offset_map_lock() to fail
      mm/gup: remove FOLL_SPLIT_PMD use of pmd_trans_unstable()
      mm/huge_memory: split huge pmd under one pte_offset_map()
      mm/khugepaged: allow pte_offset_map[_lock]() to fail
      mm/memory: allow pte_offset_map[_lock]() to fail
      mm/memory: handle_pte_fault() use pte_offset_map_nolock()
      mm/pgtable: delete pmd_trans_unstable() and friends
      mm/swap: swap_vma_readahead() do the pte_offset_map()
      perf/core: allow pte_offset_map() to fail
      mm/swapfile: delete outdated pte_offset_map() comment

Ivan Orlov (1):
      mm: backing-dev: make bdi_class a static const structure

Jan Glauber (1):
      mm: fix shmem THP counters on migration

Jason Gunthorpe (1):
      mm/gup: do not return 0 from pin_user_pages_fast() for bad args

Jim Cromie (1):
      kmemleak-test: drop __init to get better backtrace

Johannes Weiner (8):
      mm: compaction: remove compaction result helpers
      mm: compaction: simplify should_compact_retry()
      mm: compaction: refactor __compaction_suitable()
      mm: compaction: remove unnecessary is_via_compact_memory() checks
      mm: compaction: drop redundant watermark check in compaction_zonelist_suitable()
      mm: compaction: have compaction_suitable() return bool
      mm: compaction: avoid GFP_NOFS ABBA deadlock
      mm: page_isolation: write proper kerneldoc

John Hubbard (11):
      selftests/mm: fix uffd-stress unused function warning
      selftests/mm: fix unused variable warnings in hugetlb-madvise.c, migration.c
      selftests/mm: fix "warning: expression which evaluates to zero..." in mlock2-tests.c
      selftests/mm: fix invocation of tests that are run via shell scripts
      selftests/mm: .gitignore: add mkdirty, va_high_addr_switch
      selftests/mm: fix two -Wformat-security warnings in uffd builds
      selftests/mm: fix a "possibly uninitialized" warning in pkey-x86.h
      selftests/mm: fix build failures due to missing MADV_COLLAPSE
      selftests/mm: move certain uffd*() routines from vm_util.c to uffd-common.c
      Documentation: kselftest: "make headers" is a prerequisite
      selftests: error out if kernel header files are not yet built

Kalesh Singh (1):
      Multi-gen LRU: fix workingset accounting

Kassey Li (1):
      mm/page_owner/cma: show pfn in cma/page_owner with hex format

Kefeng Wang (18):
      mm: memory_failure: move memory_failure_attr_group under MEMORY_FAILURE
      mm: memory-failure: move sysctl register in memory_failure_init()
      mm: page_alloc: move mirrored_kernelcore into mm_init.c
      mm: page_alloc: move init_on_alloc/free() into mm_init.c
      mm: page_alloc: move set_zone_contiguous() into mm_init.c
      mm: page_alloc: collect mem statistic into show_mem.c
      mm: page_alloc: squash page_is_consistent()
      mm: page_alloc: remove alloc_contig_dump_pages() stub
      mm: page_alloc: split out FAIL_PAGE_ALLOC
      mm: page_alloc: split out DEBUG_PAGEALLOC
      mm: page_alloc: move mark_free_page() into snapshot.c
      mm: page_alloc: move pm_* function into power
      mm: vmscan: use gfp_has_io_fs()
      mm: page_alloc: move sysctls into it own fils
      mm: page_alloc: move is_check_pages_enabled() into page_alloc.c
      mm: kill lock|unlock_page_memcg()
      mm: compaction: convert to use a folio in isolate_migratepages_block()
      mm: kill [add|del]_page_to_lru_list()

Keith Busch (1):
      dmapool: create/destroy cleanup

Lars R. Damerow (1):
      mm/memcontrol: export memcg.swap watermark via sysfs for v2 memcg

Liam Ni (1):
      mm/early_ioremap.c: improve the execution efficiency of early_ioremap_setup()

Liam R. Howlett (36):
      maple_tree: fix static analyser cppcheck issue
      maple_tree: clean up mas_parent_enum() and rename to mas_parent_type()
      maple_tree: avoid unnecessary ascending
      maple_tree: clean up mas_dfs_postorder()
      maple_tree: add format option to mt_dump()
      maple_tree: add debug BUG_ON and WARN_ON variants
      maple_tree: convert BUG_ON() to MT_BUG_ON()
      maple_tree: change RCU checks to WARN_ON() instead of BUG_ON()
      maple_tree: convert debug code to use MT_WARN_ON() and MAS_WARN_ON()
      maple_tree: use MAS_BUG_ON() when setting a leaf node as a parent
      maple_tree: use MAS_BUG_ON() in mas_set_height()
      maple_tree: use MAS_BUG_ON() from mas_topiary_range()
      maple_tree: use MAS_WR_BUG_ON() in mas_store_prealloc()
      maple_tree: use MAS_BUG_ON() prior to calling mas_meta_gap()
      maple_tree: return error on mte_pivots() out of range
      maple_tree: make test code work without debug enabled
      mm: update validate_mm() to use vma iterator
      mm: update vma_iter_store() to use MAS_WARN_ON()
      maple_tree: add __init and __exit to test module
      maple_tree: remove unnecessary check from mas_destroy()
      maple_tree: mas_start() reset depth on dead node
      mm/mmap: change do_vmi_align_munmap() for maple tree iterator changes
      maple_tree: try harder to keep active node after mas_next()
      maple_tree: try harder to keep active node with mas_prev()
      maple_tree: revise limit checks in mas_empty_area{_rev}()
      maple_tree: fix testing mas_empty_area()
      maple_tree: introduce mas_next_slot() interface
      maple_tree: add mas_next_range() and mas_find_range() interfaces
      maple_tree: relocate mas_rewalk() and mas_rewalk_if_dead()
      maple_tree: introduce mas_prev_slot() interface
      maple_tree: add mas_prev_range() and mas_find_range_rev interface
      maple_tree: clear up index and last setting in single entry tree
      maple_tree: update testing code for mas_{next,prev,walk}
      mm: add vma_iter_{next,prev}_range() to vma iterator
      mm: avoid rewalk in mmap_region
      userfaultfd: fix regression in userfaultfd_unmap_prep()

Lorenzo Stoakes (11):
      mm/gup: add missing gup_must_unshare() check to gup_huge_pgd()
      mm/gup: remove unused vmas parameter from get_user_pages()
      mm/gup: remove unused vmas parameter from pin_user_pages_remote()
      mm/gup: remove vmas parameter from get_user_pages_remote()
      io_uring: rsrc: delegate VMA file-backed check to GUP
      mm/gup: remove vmas parameter from pin_user_pages()
      mm/gup: remove vmas array from internal GUP functions
      mm/mmap: refactor mlock_future_check()
      mm/mmap: separate writenotify and dirty tracking logic
      mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings
      mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings

Lu Hongfei (1):
      mm/vmalloc: replace the ternary conditional operator with min()

Marcelo Tosatti (2):
      vmstat: allow_direct_reclaim should use zone_page_state_snapshot
      vmstat: skip periodic vmstat update for isolated CPUs

Marco Elver (2):
      kasan: add support for kasan.fault=panic_on_write
      kasan, doc: note kasan.fault=panic_on_write behaviour for async modes

Mathieu Desnoyers (1):
      mm: move mm_count into its own cache line

Matthew Wilcox (Oracle) (28):
      mm: convert migrate_pages() to work on folios
      gfs2: use a folio inside gfs2_jdata_writepage()
      gfs2: pass a folio to __gfs2_jdata_write_folio()
      gfs2: convert gfs2_write_jdata_page() to gfs2_write_jdata_folio()
      buffer: convert __block_write_full_page() to __block_write_full_folio()
      gfs2: support ludicrously large folios in gfs2_trans_add_databufs()
      buffer: make block_write_full_page() handle large folios correctly
      buffer: convert block_page_mkwrite() to use a folio
      buffer: convert __block_commit_write() to take a folio
      buffer: convert page_zero_new_buffers() to folio_zero_new_buffers()
      buffer: convert grow_dev_page() to use a folio
      buffer: convert init_page_buffers() to folio_init_buffers()
      buffer: convert link_dev_buffers to take a folio
      buffer: use a folio in __find_get_block_slow()
      buffer: convert block_truncate_page() to use a folio
      afs: convert pagevec to folio_batch in afs_extend_writeback()
      mm: add __folio_batch_release()
      scatterlist: add sg_set_folio()
      i915: convert shmem_sg_free_table() to use a folio_batch
      drm: convert drm_gem_put_pages() to use a folio_batch
      mm: remove check_move_unevictable_pages()
      pagevec: rename fbatch_count()
      i915: convert i915_gpu_error to use a folio_batch
      net: convert sunrpc from pagevec to folio_batch
      mm: remove struct pagevec
      mm: rename invalidate_mapping_pagevec to mapping_try_invalidate
      mm: remove references to pagevec
      mm: remove unnecessary pagevec includes

Mel Gorman (4):
      mm: compaction: ensure rescanning only happens on partially scanned pageblocks
      mm: compaction: only force pageblock scan completion when skip hints are obeyed
      mm: compaction: update pageblock skip when first migration candidate is not at the start
      Revert "Revert "mm/compaction: fix set skip in fast_find_migrateblock""

Miaohe Lin (8):
      mm: page_alloc: remove unneeded header files
      memcg: use helper macro FLUSH_TIME
      mm: remove obsolete alloc_migrate_target()
      mm: vmscan: mark kswapd_run() and kswapd_stop() __meminit
      memory tier: remove unneeded disable_all_demotion_targets() when !CONFIG_MIGRATION
      mm: compaction: mark kcompactd_run() and kcompactd_stop() __meminit
      memory tier: remove unneeded !IS_ENABLED(CONFIG_MIGRATION) check
      mm: page_alloc: make compound_page_dtors static

Mike Kravetz (2):
      Revert "page cache: fix page_cache_next/prev_miss off by one"
      hugetlb: revert use of page_cache_next_miss()

Mike Rapoport (IBM) (1):
      mm/secretmem: make it on by default

Muhammad Usama Anjum (2):
      selftests: mm: remove wrong kernel header inclusion
      selftests: mm: remove duplicate unneeded defines

Nhat Pham (4):
      workingset: refactor LRU refault to expose refault recency check
      cachestat: implement cachestat syscall
      cachestat: wire up cachestat for other architectures
      selftests: add selftests for cachestat

Nick Desaulniers (1):
      mm/khugepaged: use DEFINE_READ_MOSTLY_HASHTABLE macro

Pankaj Raghav (1):
      filemap: remove page_endio()

Pasha Tatashin (1):
      mm: hugetlb_vmemmap: provide stronger vmemmap allocation guarantees

Peng Zhang (11):
      maple_tree: fix potential out-of-bounds access in mas_wr_end_piv()
      maple_tree: rework mtree_alloc_{range,rrange}()
      maple_tree: drop mas_{rev_}alloc() and mas_fill_gap()
      maple_tree: fix the arguments to __must_hold()
      maple_tree: simplify mas_is_span_wr()
      maple_tree: make the code symmetrical in mas_wr_extend_null()
      maple_tree: add mas_wr_new_end() to calculate new_end accurately
      maple_tree: add comments and some minor cleanups to mas_wr_append()
      maple_tree: rework mas_wr_slot_store() to be cleaner and more efficient.
      maple_tree: simplify and clean up mas_wr_node_store()
      maple_tree: relocate the declaration of mas_empty_area_rev().

Peter Xu (1):
      mm/hugetlb: fix pgtable lock on pmd sharing

Rick Wertenbroek (1):
      mm: memory_hotplug: fix format string in warnings

Roberto Sassu (1):
      shmem: use ramfs_kill_sb() for kill_sb method of ramfs-based tmpfs

Robin Murphy (2):
      scatterlist: add dedicated config for DMA flags
      dma-mapping: name SG DMA flag helpers consistently

Roman Gushchin (2):
      mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()
      mm: memcg: use READ_ONCE()/WRITE_ONCE() to access stock->cached

Ryan Roberts (7):
      mm: vmalloc must set pte via arch code
      mm/damon/ops-common: atomically test and clear young on ptes and pmds
      mm/damon/ops-common: refactor to use {pte|pmd}p_clear_young_notify()
      mm: fix failure to unmap pte on highmem systems
      mm: ptdump should use ptep_get_lockless()
      mm: move ptep_get() and pmdp_get() helpers
      mm: ptep_get() conversion

SeongJae Park (18):
      Docs/mm/damon/faq: remove old questions
      Docs/mm/damon/maintainer-profile: fix typos and grammar errors
      Docs/mm/damon/design: add a section for overall architecture
      Docs/mm/damon/design: update the layout based on the layers
      Docs/mm/damon/design: rewrite configurable layers
      Docs/mm/damon/design: add a section for the relation between Core and Modules layer
      Docs/mm/damon/design: add sections for basic parts of DAMOS
      Docs/mm/damon/design: add sections for advanced features of DAMOS
      Docs/mm/damon/design: add a section for DAMON core API
      Docs/mm/damon/design: add a section for the modules layer
      mm/damon/core-test: add a test for damon_set_attrs()
      Docs/mm/damon/design: document 'age' of region
      Docs/admin-guide/mm/damon/start: update DAMOS example command
      Docs/admin-guide/mm/damon/usage: fix typos in references and commas
      Docs/admin-guide/mm/damon/usage: remove unnecessary sentences about supported address spaces
      Docs/admin-guide/mm/damon/usage: link design document for DAMOS
      Docs/admin-guide/mm/damon/usage: clarify quotas and watermarks sysfs interface
      Docs/admin-guide/mm/damon/usage: update the ways for getting monitoring results

Sergey Senozhatsky (1):
      zram: further limit recompression threshold

Sidhartha Kumar (3):
      mm/hugetlb: remove hugetlb_page_subpool()
      mm: remove set_compound_page_dtor()
      mm/hugetlb: remove hugetlb_set_page_subpool()

T.J. Alumbaugh (4):
      mm: multi-gen LRU: use macro for bitmap
      mm: multi-gen LRU: cleanup lru_gen_soft_reclaim()
      mm: multi-gen LRU: add helpers in page table walks
      mm: multi-gen LRU: cleanup lru_gen_test_recent()

Tarun Sahu (2):
      mm/folio: avoid special handling for order value 0 in folio_set_order
      mm/folio: replace set_compound_order with folio_set_order

Tetsuo Handa (2):
      mm/page_alloc: don't wake kswapd from rmqueue() unless __GFP_KSWAPD_RECLAIM is specified
      kasan,kmsan: remove __GFP_KSWAPD_RECLAIM usage from kasan/kmsan

Thomas Gleixner (6):
      mm/vmalloc: prevent stale TLBs in fully utilized blocks
      mm/vmalloc: avoid iterating over per CPU vmap blocks twice
      mm/vmalloc: prevent flushing dirty space over and over
      mm/vmalloc: check free space in vmap_block lockless
      mm/vmalloc: add missing READ/WRITE_ONCE() annotations
      mm/vmalloc: dont purge usable blocks unnecessarily

Tom Rix (1):
      mm: page_alloc: set sysctl_lowmem_reserve_ratio storage-class-specifier to static

Tu Jinjiang (1):
      mm: shmem: fix UAF bug in shmem_show_options()

Vishal Moola (Oracle) (5):
      mmzone: introduce folio_is_zone_movable()
      mmzone: introduce folio_migratetype()
      mm/gup_test.c: convert verify_dma_pinned() to us folios
      mm/gup.c: reorganize try_get_folio()
      mm: remove is_longterm_pinnable_page() and reimplement folio_is_longterm_pinnable()

Wen Yang (1):
      mm: compaction: optimize compact_memory to comply with the admin-guide

Xin Hao (1):
      mm: khugepaged: avoid pointless allocation for "struct mm_slot"

Yajun Deng (2):
      mm/sparse: remove unused parameters in sparse_remove_section()
      mm: pass nid to reserve_bootmem_region()

Yin Fengwei (1):
      THP: avoid lock when check whether THP is in deferred list

Yosry Ahmed (11):
      memcg: use seq_buf_do_printk() with mem_cgroup_print_oom_meminfo()
      memcg: dump memory.stat during cgroup OOM for v1
      writeback: move wb_over_bg_thresh() call outside lock section
      memcg: flush stats non-atomically in mem_cgroup_wb_stats()
      memcg: calculate root usage from global state
      memcg: remove mem_cgroup_flush_stats_atomic()
      cgroup: remove cgroup_rstat_flush_atomic()
      mm: zswap: support exclusive loads
      mm: zswap: fix double invalidate with exclusive loads
      mm: memcg: rename and document global_reclaim()
      mm/vmscan: fix root proactive reclaim unthrottling unbalanced node

Yu Ma (1):
      percpu-internal/pcpu_chunk: re-layout pcpu_chunk structure to reduce false sharing

Yu Zhao (1):
      mm/mglru: make memcg_lru->lock irq safe

Yuanchu Xie (1):
      mm: pagemap: restrict pagewalk to the requested range

YueHaibing (2):
      kernel: pid_namespace: remove unused set_memfd_noexec_scope()
      mm: remove unused vma_init_lock()

ZhangPeng (4):
      mm/hugetlb: use a folio in copy_hugetlb_page_range()
      mm/hugetlb: use a folio in hugetlb_wp()
      mm/hugetlb: use a folio in hugetlb_fault()
      mm/memcg: remove return value of mem_cgroup_scan_tasks()

Zhaoyang Huang (1):
      mm: skip CMA pages when they are not available

lipeifeng (1):
      mm: nommu: correct the range of mmap_sem_read_lock in task_mem()

 Documentation/admin-guide/cgroup-v1/memory.rst     |    2 +-
 Documentation/admin-guide/cgroup-v2.rst            |    7 +
 Documentation/admin-guide/mm/damon/start.rst       |   10 +-
 Documentation/admin-guide/mm/damon/usage.rst       |  146 +-
 Documentation/dev-tools/kasan.rst                  |    9 +-
 Documentation/dev-tools/kselftest.rst              |    1 +
 Documentation/mm/damon/design.rst                  |  337 +++-
 Documentation/mm/damon/faq.rst                     |   23 -
 Documentation/mm/damon/maintainer-profile.rst      |    4 +-
 Documentation/mm/page_migration.rst                |    7 +-
 Documentation/mm/split_page_table_lock.rst         |   17 +-
 .../translations/zh_CN/mm/page_migration.rst       |    2 +-
 MAINTAINERS                                        |    7 +
 arch/alpha/kernel/syscalls/syscall.tbl             |    1 +
 arch/arm/lib/uaccess_with_memcpy.c                 |    3 +
 arch/arm/mm/fault-armv.c                           |    5 +-
 arch/arm/mm/fault.c                                |    3 +
 arch/arm/tools/syscall.tbl                         |    1 +
 arch/arm64/Kconfig                                 |    1 +
 arch/arm64/include/asm/cache.h                     |    3 +
 arch/arm64/include/asm/unistd.h                    |    2 +-
 arch/arm64/include/asm/unistd32.h                  |    2 +
 arch/arm64/kernel/mte.c                            |   17 +-
 arch/arm64/kernel/traps.c                          |    2 +-
 arch/arm64/mm/fault.c                              |    5 +-
 arch/arm64/mm/hugetlbpage.c                        |   11 +-
 arch/arm64/mm/init.c                               |    7 +-
 arch/ia64/kernel/syscalls/syscall.tbl              |    1 +
 arch/ia64/mm/hugetlbpage.c                         |    4 +-
 arch/m68k/include/asm/mmu_context.h                |    6 +-
 arch/m68k/kernel/sys_m68k.c                        |    2 +
 arch/m68k/kernel/syscalls/syscall.tbl              |    1 +
 arch/m68k/mm/mcfmmu.c                              |   52 +-
 arch/microblaze/include/asm/cache.h                |    5 +
 arch/microblaze/include/asm/page.h                 |    5 -
 arch/microblaze/kernel/signal.c                    |    5 +-
 arch/microblaze/kernel/syscalls/syscall.tbl        |    1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |    1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |    1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |    1 +
 arch/mips/mm/tlb-r4k.c                             |   12 +-
 arch/parisc/kernel/cache.c                         |   26 +-
 arch/parisc/kernel/pci-dma.c                       |    2 +-
 arch/parisc/kernel/syscalls/syscall.tbl            |    1 +
 arch/parisc/mm/hugetlbpage.c                       |    4 +-
 arch/powerpc/include/asm/cache.h                   |    4 +
 arch/powerpc/include/asm/page_32.h                 |    4 -
 arch/powerpc/kernel/syscalls/syscall.tbl           |    1 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |    2 +-
 arch/powerpc/mm/book3s64/hash_tlb.c                |    4 +
 arch/powerpc/mm/book3s64/iommu_api.c               |    2 +-
 arch/powerpc/mm/book3s64/subpage_prot.c            |    2 +
 arch/powerpc/mm/hugetlbpage.c                      |    2 +-
 arch/powerpc/xmon/xmon.c                           |    5 +-
 arch/riscv/mm/hugetlbpage.c                        |    4 +-
 arch/s390/kernel/syscalls/syscall.tbl              |    1 +
 arch/s390/kernel/uv.c                              |    2 +
 arch/s390/kvm/interrupt.c                          |    2 +-
 arch/s390/mm/gmap.c                                |   31 +-
 arch/s390/mm/pgtable.c                             |   12 +-
 arch/sh/include/asm/cache.h                        |    6 +
 arch/sh/include/asm/page.h                         |    6 -
 arch/sh/kernel/syscalls/syscall.tbl                |    1 +
 arch/sh/mm/hugetlbpage.c                           |    4 +-
 arch/sparc/kernel/signal32.c                       |    2 +
 arch/sparc/kernel/syscalls/syscall.tbl             |    1 +
 arch/sparc/mm/fault_64.c                           |    3 +
 arch/sparc/mm/hugetlbpage.c                        |    4 +-
 arch/sparc/mm/io-unit.c                            |    2 +-
 arch/sparc/mm/iommu.c                              |    2 +-
 arch/sparc/mm/tlb.c                                |    2 +
 arch/x86/entry/syscalls/syscall_32.tbl             |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |    1 +
 arch/x86/kernel/cpu/sgx/ioctl.c                    |    2 +-
 arch/x86/kernel/ldt.c                              |    6 +-
 arch/x86/mm/mem_encrypt_identity.c                 |    2 +-
 arch/xtensa/kernel/syscalls/syscall.tbl            |    1 +
 arch/xtensa/mm/tlb.c                               |    5 +-
 block/fops.c                                       |   18 +-
 drivers/base/devres.c                              |    6 +-
 drivers/block/zram/zram_drv.c                      |    2 +-
 drivers/gpu/drm/drm_gem.c                          |   68 +-
 drivers/gpu/drm/drm_managed.c                      |    6 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |   55 +-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |    8 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |   50 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |    2 +-
 drivers/infiniband/hw/qib/qib_user_pages.c         |    2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |    2 +-
 drivers/infiniband/sw/siw/siw_mem.c                |    2 +-
 drivers/iommu/Kconfig                              |    1 +
 drivers/iommu/dma-iommu.c                          |   58 +-
 drivers/iommu/iommu.c                              |    2 +-
 drivers/iommu/iommufd/pages.c                      |    4 +-
 drivers/md/dm-crypt.c                              |    2 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c          |    2 +-
 drivers/misc/sgi-gru/grufault.c                    |    4 +-
 drivers/pci/Kconfig                                |    1 +
 drivers/spi/spidev.c                               |    2 +-
 drivers/usb/core/buffer.c                          |    8 +-
 drivers/vdpa/vdpa_user/vduse_dev.c                 |    2 +-
 drivers/vfio/vfio_iommu_type1.c                    |    9 +-
 drivers/vhost/vdpa.c                               |    2 +-
 drivers/xen/privcmd.c                              |    2 +-
 fs/afs/write.c                                     |   16 +-
 fs/btrfs/file.c                                    |    6 +-
 fs/buffer.c                                        |  259 ++--
 fs/ceph/file.c                                     |    6 -
 fs/direct-io.c                                     |   10 +-
 fs/exec.c                                          |    2 +-
 fs/ext4/file.c                                     |   11 +-
 fs/ext4/inode.c                                    |    4 +-
 fs/f2fs/file.c                                     |    3 -
 fs/fs-writeback.c                                  |   16 +-
 fs/fuse/file.c                                     |   45 +-
 fs/gfs2/aops.c                                     |   69 +-
 fs/gfs2/aops.h                                     |    2 +-
 fs/gfs2/file.c                                     |    6 +-
 fs/hugetlbfs/inode.c                               |   13 +-
 fs/iomap/buffered-io.c                             |    9 +-
 fs/iomap/direct-io.c                               |   88 +-
 fs/libfs.c                                         |   41 +
 fs/nfs/file.c                                      |    6 +-
 fs/ntfs/aops.c                                     |    2 +-
 fs/ntfs/file.c                                     |    2 -
 fs/ntfs3/file.c                                    |    3 -
 fs/proc/task_mmu.c                                 |   77 +-
 fs/proc/task_nommu.c                               |    6 +-
 fs/ramfs/inode.c                                   |    2 +-
 fs/reiserfs/inode.c                                |    9 +-
 fs/userfaultfd.c                                   |   62 +-
 fs/xfs/xfs_file.c                                  |    6 -
 fs/zonefs/file.c                                   |    4 +-
 include/linux/buffer_head.h                        |    4 +-
 include/linux/cache.h                              |    6 +
 include/linux/cgroup.h                             |    1 -
 include/linux/compaction.h                         |  104 +-
 include/linux/dma-map-ops.h                        |   61 +
 include/linux/dma-mapping.h                        |    5 +-
 include/linux/fault-inject.h                       |    9 +
 include/linux/frontswap.h                          |    2 +-
 include/linux/fs.h                                 |    7 +-
 include/linux/gfp.h                                |   15 +-
 include/linux/hugetlb.h                            |   33 +-
 include/linux/iio/iio.h                            |    2 +-
 include/linux/kasan.h                              |    2 +-
 include/linux/maple_tree.h                         |  130 +-
 include/linux/memblock.h                           |    1 -
 include/linux/memcontrol.h                         |   24 +-
 include/linux/memory_hotplug.h                     |    8 +-
 include/linux/migrate.h                            |   20 +-
 include/linux/mm.h                                 |  226 +--
 include/linux/mm_inline.h                          |   14 +-
 include/linux/mm_types.h                           |   23 +-
 include/linux/mmdebug.h                            |   14 +
 include/linux/mmzone.h                             |   51 +-
 include/linux/page-isolation.h                     |   23 +-
 include/linux/pagemap.h                            |    6 +-
 include/linux/pagevec.h                            |   67 +-
 include/linux/pgtable.h                            |  176 +--
 include/linux/ramfs.h                              |    1 +
 include/linux/scatterlist.h                        |   84 +-
 include/linux/sched.h                              |    3 -
 include/linux/slab.h                               |   14 +-
 include/linux/sunrpc/svc.h                         |    2 +-
 include/linux/suspend.h                            |    9 +-
 include/linux/swap.h                               |   29 +-
 include/linux/swapops.h                            |   17 +-
 include/linux/syscalls.h                           |    5 +
 include/linux/userfaultfd_k.h                      |    6 +-
 include/linux/zpool.h                              |   20 +-
 include/trace/events/compaction.h                  |   11 +
 include/trace/events/mmflags.h                     |    4 +-
 include/uapi/asm-generic/unistd.h                  |    5 +-
 include/uapi/linux/mman.h                          |   14 +
 init/Kconfig                                       |   10 +
 io_uring/rsrc.c                                    |   34 +-
 kernel/cgroup/rstat.c                              |   26 +-
 kernel/dma/Kconfig                                 |    7 +
 kernel/dma/direct.c                                |    2 +-
 kernel/dma/direct.h                                |    3 +-
 kernel/events/core.c                               |    4 +
 kernel/events/uprobes.c                            |   15 +-
 kernel/pid_sysctl.h                                |    1 -
 kernel/power/main.c                                |   27 +
 kernel/power/power.h                               |    5 +
 kernel/power/snapshot.c                            |   52 +
 kernel/sys_ni.c                                    |    1 +
 kernel/sysctl.c                                    |   67 -
 kernel/trace/trace_events_user.c                   |    2 +-
 lib/Kconfig.debug                                  |   10 +-
 lib/Makefile                                       |    2 +-
 lib/maple_tree.c                                   | 1626 ++++++++++----------
 lib/show_mem.c                                     |   37 -
 lib/test_maple_tree.c                              |  863 +++++++++--
 mm/Kconfig                                         |   16 +
 mm/Makefile                                        |    4 +-
 mm/backing-dev.c                                   |   17 +-
 mm/cma.c                                           |    4 +-
 mm/compaction.c                                    |  334 ++--
 mm/damon/core-test.h                               |   24 +
 mm/damon/ops-common.c                              |   32 +-
 mm/damon/ops-common.h                              |    4 +-
 mm/damon/paddr.c                                   |    6 +-
 mm/damon/vaddr.c                                   |   26 +-
 mm/debug.c                                         |    9 +
 mm/debug_page_alloc.c                              |   59 +
 mm/debug_vm_pgtable.c                              |    9 +-
 mm/dmapool.c                                       |   10 +-
 mm/early_ioremap.c                                 |    8 +-
 mm/fadvise.c                                       |   17 +-
 mm/fail_page_alloc.c                               |   66 +
 mm/filemap.c                                       |  450 +++---
 mm/frontswap.c                                     |   10 +-
 mm/gup.c                                           |  398 +++--
 mm/gup_test.c                                      |   27 +-
 mm/highmem.c                                       |   12 +-
 mm/hmm.c                                           |    6 +-
 mm/huge_memory.c                                   |   56 +-
 mm/hugetlb.c                                       |  126 +-
 mm/hugetlb_vmemmap.c                               |   17 +-
 mm/internal.h                                      |   87 +-
 mm/kasan/common.c                                  |    2 +-
 mm/kasan/generic.c                                 |   76 +-
 mm/kasan/init.c                                    |    9 +-
 mm/kasan/kasan.h                                   |  159 +-
 mm/kasan/report.c                                  |   44 +-
 mm/kasan/report_generic.c                          |   12 +-
 mm/kasan/report_hw_tags.c                          |    2 +-
 mm/kasan/report_sw_tags.c                          |    2 +-
 mm/kasan/shadow.c                                  |   46 +-
 mm/kasan/sw_tags.c                                 |   20 +-
 mm/kasan/tags.c                                    |    2 +-
 mm/khugepaged.c                                    |  125 +-
 mm/kmsan/core.c                                    |    6 +-
 mm/kmsan/instrumentation.c                         |    2 +-
 mm/ksm.c                                           |   38 +-
 mm/madvise.c                                       |  150 +-
 mm/mapping_dirty_helpers.c                         |   38 +-
 mm/memblock.c                                      |   33 +-
 mm/memcontrol.c                                    |  253 ++-
 mm/memory-failure.c                                |   45 +-
 mm/memory-tiers.c                                  |    3 +-
 mm/memory.c                                        |  341 ++--
 mm/memory_hotplug.c                                |   42 +-
 mm/mempolicy.c                                     |   28 +-
 mm/migrate.c                                       |  382 ++---
 mm/migrate_device.c                                |   46 +-
 mm/mincore.c                                       |   11 +-
 mm/mlock.c                                         |   10 +-
 mm/mm_init.c                                       |  154 +-
 mm/mmap.c                                          |  222 +--
 mm/mprotect.c                                      |   87 +-
 mm/mremap.c                                        |   32 +-
 mm/oom_kill.c                                      |    8 +-
 mm/page-writeback.c                                |    6 +-
 mm/page_alloc.c                                    |  873 ++---------
 mm/page_isolation.c                                |   33 +-
 mm/page_owner.c                                    |    2 +-
 mm/page_table_check.c                              |    6 +-
 mm/page_vma_mapped.c                               |  114 +-
 mm/pagewalk.c                                      |   33 +-
 mm/percpu-internal.h                               |   11 +-
 mm/pgtable-generic.c                               |   58 +-
 mm/process_vm_access.c                             |    2 +-
 mm/ptdump.c                                        |    2 +-
 mm/readahead.c                                     |    1 -
 mm/rmap.c                                          |   36 +-
 mm/secretmem.c                                     |    4 +-
 mm/shmem.c                                         |    7 +-
 mm/show_mem.c                                      |  429 ++++++
 mm/slab.c                                          |    6 +-
 mm/slab.h                                          |    5 +-
 mm/slab_common.c                                   |   41 +-
 mm/sparse-vmemmap.c                                |    8 +-
 mm/sparse.c                                        |   10 +-
 mm/swap.c                                          |   20 +-
 mm/swap_state.c                                    |   87 +-
 mm/swapfile.c                                      |  109 +-
 mm/truncate.c                                      |   27 +-
 mm/userfaultfd.c                                   |   12 +-
 mm/vmalloc.c                                       |  130 +-
 mm/vmscan.c                                        |  197 +--
 mm/vmstat.c                                        |   15 +
 mm/workingset.c                                    |  158 +-
 mm/z3fold.c                                        |  249 +--
 mm/zbud.c                                          |  167 +-
 mm/zpool.c                                         |   48 +-
 mm/zsmalloc.c                                      |  408 +----
 mm/zswap.c                                         |  239 +--
 net/sunrpc/svc.c                                   |   10 +-
 net/xdp/xdp_umem.c                                 |    2 +-
 samples/kmemleak/kmemleak-test.c                   |    2 +-
 security/tomoyo/domain.c                           |    2 +-
 tools/testing/radix-tree/linux/init.h              |    1 +
 tools/testing/radix-tree/maple.c                   |  164 +-
 tools/testing/selftests/Makefile                   |   22 +-
 tools/testing/selftests/cachestat/.gitignore       |    2 +
 tools/testing/selftests/cachestat/Makefile         |    8 +
 tools/testing/selftests/cachestat/test_cachestat.c |  269 ++++
 tools/testing/selftests/cgroup/test_memcontrol.c   |    9 +-
 tools/testing/selftests/damon/config               |    7 +
 tools/testing/selftests/lib.mk                     |   40 +-
 tools/testing/selftests/mm/.gitignore              |    3 +
 tools/testing/selftests/mm/Makefile                |    5 +-
 tools/testing/selftests/mm/cow.c                   |   37 +-
 tools/testing/selftests/mm/gup_longterm.c          |  459 ++++++
 tools/testing/selftests/mm/hugepage-shm.c          |    4 -
 tools/testing/selftests/mm/hugepage-vmemmap.c      |    4 -
 tools/testing/selftests/mm/hugetlb-madvise.c       |    8 +-
 tools/testing/selftests/mm/khugepaged.c            |   11 +-
 tools/testing/selftests/mm/madv_populate.c         |    7 -
 tools/testing/selftests/mm/map_fixed_noreplace.c   |    4 -
 tools/testing/selftests/mm/map_hugetlb.c           |   12 -
 tools/testing/selftests/mm/map_populate.c          |    2 -
 tools/testing/selftests/mm/migration.c             |    5 +-
 tools/testing/selftests/mm/mlock-random-test.c     |    1 +
 tools/testing/selftests/mm/mlock2-tests.c          |    1 -
 tools/testing/selftests/mm/mlock2.h                |    8 -
 tools/testing/selftests/mm/mrelease_test.c         |   10 +-
 tools/testing/selftests/mm/mremap_dontunmap.c      |    4 -
 tools/testing/selftests/mm/on-fault-limit.c        |    4 -
 tools/testing/selftests/mm/pkey-powerpc.h          |    3 -
 tools/testing/selftests/mm/pkey-x86.h              |   20 +-
 tools/testing/selftests/mm/protection_keys.c       |   13 +-
 tools/testing/selftests/mm/run_vmtests.sh          |   10 +-
 tools/testing/selftests/mm/uffd-common.c           |   59 +
 tools/testing/selftests/mm/uffd-common.h           |    5 +
 tools/testing/selftests/mm/uffd-stress.c           |   10 -
 tools/testing/selftests/mm/uffd-unit-tests.c       |   16 +-
 tools/testing/selftests/mm/vm_util.c               |   86 +-
 tools/testing/selftests/mm/vm_util.h               |    5 +-
 virt/kvm/async_pf.c                                |    3 +-
 virt/kvm/kvm_main.c                                |   13 +-
 334 files changed, 8337 insertions(+), 6901 deletions(-)
 delete mode 100644 lib/show_mem.c
 create mode 100644 mm/debug_page_alloc.c
 create mode 100644 mm/fail_page_alloc.c
 create mode 100644 mm/show_mem.c
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c
 create mode 100644 tools/testing/selftests/damon/config
 create mode 100644 tools/testing/selftests/mm/gup_longterm.c

