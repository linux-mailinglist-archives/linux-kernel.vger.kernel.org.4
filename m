Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E42E6C66F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCWLna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCWLn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:43:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EE0F746
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679571807; x=1711107807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SAIAzcHaTs+J6WVW75uOcs1trEEUAEboKHVPd93WZcM=;
  b=hxAh7SynJivTZCgSycOHpY6XPWQ2ORgfZ22ALkrQwZ8QpNK7NAze47BE
   w1JFz67ZIikow1BmIbUXGa8WXswLRB3kZHxkuvH0BsAQ6bG9ow4zxa5bu
   l/2Ub6Qejy9jSF+fbbWMbmbGZBR0OD1iAGY4ibEhoaiycjS7Xp4+WLf3Q
   vqZ4vFsrCfkTa1gyR1rQW5BNcTvlWFtCY8gL86b1H5eZ/uTum67fDS/LP
   51wIOg7OI+1NCrBNTsox/MNVE7VzP18kFlsZn9PIBqF+4hJy61myOabzJ
   lbdacIgnU+232da6cRYkG45hFB1gPWZumXJ64J+OQAEtjzHEO2RbfbAvO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="402031172"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="402031172"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 04:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="806222128"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="806222128"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2023 04:43:24 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfJLn-000EIm-1n;
        Thu, 23 Mar 2023 11:43:23 +0000
Date:   Thu, 23 Mar 2023 19:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/sparc/mm/tsb.c:405:39: error: left shift count is negative
Message-ID: <202303231905.iHyozZ4Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zi,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fff5a5e7f528b2ed2c335991399a766c2cf01103
commit: 0192445cb2f7ed1cd7a95a0fc8c7645480baba25 arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
date:   6 months ago
config: sparc64-randconfig-r014-20230322 (https://download.01.org/0day-ci/archive/20230323/202303231905.iHyozZ4Z-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0192445cb2f7ed1cd7a95a0fc8c7645480baba25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0192445cb2f7ed1cd7a95a0fc8c7645480baba25
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash arch/sparc/mm/ drivers/gpu/drm/ mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303231905.iHyozZ4Z-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:7,
                    from include/linux/slab.h:15,
                    from arch/sparc/mm/tsb.c:9:
   include/linux/mmzone.h:636:33: error: size of array 'free_area' is negative
     636 |         struct free_area        free_area[MAX_ORDER];
         |                                 ^~~~~~~~~
   arch/sparc/mm/tsb.c: In function 'tsb_grow':
>> arch/sparc/mm/tsb.c:405:39: error: left shift count is negative [-Werror=shift-count-negative]
     405 |         if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
         |                                       ^~
   arch/sparc/mm/tsb.c:406:43: error: left shift count is negative [-Werror=shift-count-negative]
     406 |                 max_tsb_size = (PAGE_SIZE << MAX_ORDER);
         |                                           ^~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from mm/shuffle.c:4:
   include/linux/mmzone.h:636:33: error: size of array 'free_area' is negative
     636 |         struct free_area        free_area[MAX_ORDER];
         |                                 ^~~~~~~~~
   In file included from arch/sparc/include/asm/bug.h:6,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6:
   mm/internal.h: In function 'mem_map_offset':
   include/linux/mmzone.h:32:31: warning: left shift count is negative [-Wshift-count-negative]
      32 | #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
         |                               ^~
   include/linux/compiler.h:33:55: note: in definition of macro '__branch_check__'
      33 |                         ______r = __builtin_expect(!!(x), expect);      \
         |                                                       ^
   mm/internal.h:649:13: note: in expansion of macro 'unlikely'
     649 |         if (unlikely(offset >= MAX_ORDER_NR_PAGES))
         |             ^~~~~~~~
   mm/internal.h:649:32: note: in expansion of macro 'MAX_ORDER_NR_PAGES'
     649 |         if (unlikely(offset >= MAX_ORDER_NR_PAGES))
         |                                ^~~~~~~~~~~~~~~~~~
   include/linux/mmzone.h:32:31: warning: left shift count is negative [-Wshift-count-negative]
      32 | #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
         |                               ^~
   include/linux/compiler.h:35:54: note: in definition of macro '__branch_check__'
      35 |                                              expect, is_constant);      \
         |                                                      ^~~~~~~~~~~
   mm/internal.h:649:13: note: in expansion of macro 'unlikely'
     649 |         if (unlikely(offset >= MAX_ORDER_NR_PAGES))
         |             ^~~~~~~~
   mm/internal.h:649:32: note: in expansion of macro 'MAX_ORDER_NR_PAGES'
     649 |         if (unlikely(offset >= MAX_ORDER_NR_PAGES))
         |                                ^~~~~~~~~~~~~~~~~~
   mm/internal.h: In function 'mem_map_next':
   include/linux/mmzone.h:32:31: warning: left shift count is negative [-Wshift-count-negative]
      32 | #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
         |                               ^~
   include/linux/compiler.h:33:55: note: in definition of macro '__branch_check__'
      33 |                         ______r = __builtin_expect(!!(x), expect);      \
         |                                                       ^
   mm/internal.h:661:13: note: in expansion of macro 'unlikely'
     661 |         if (unlikely((offset & (MAX_ORDER_NR_PAGES - 1)) == 0)) {
         |             ^~~~~~~~
   mm/internal.h:661:33: note: in expansion of macro 'MAX_ORDER_NR_PAGES'
     661 |         if (unlikely((offset & (MAX_ORDER_NR_PAGES - 1)) == 0)) {
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/mmzone.h:32:31: warning: left shift count is negative [-Wshift-count-negative]
      32 | #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
         |                               ^~
   include/linux/compiler.h:35:54: note: in definition of macro '__branch_check__'
      35 |                                              expect, is_constant);      \
         |                                                      ^~~~~~~~~~~
   mm/internal.h:661:13: note: in expansion of macro 'unlikely'
     661 |         if (unlikely((offset & (MAX_ORDER_NR_PAGES - 1)) == 0)) {
         |             ^~~~~~~~
   mm/internal.h:661:33: note: in expansion of macro 'MAX_ORDER_NR_PAGES'
     661 |         if (unlikely((offset & (MAX_ORDER_NR_PAGES - 1)) == 0)) {
         |                                 ^~~~~~~~~~~~~~~~~~
   mm/shuffle.c: In function '__shuffle_zone':
>> mm/shuffle.c:87:35: warning: left shift count is negative [-Wshift-count-negative]
      87 |         const int order_pages = 1 << order;
         |                                 ~~^~~~~~~~
--
   In file included from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/gpu/drm/drm_gem_vram_helper.c:4:
   include/linux/mmzone.h:636:33: error: size of array 'free_area' is negative
     636 |         struct free_area        free_area[MAX_ORDER];
         |                                 ^~~~~~~~~
   In file included from include/drm/ttm/ttm_device.h:31,
                    from include/drm/ttm/ttm_bo_driver.h:40,
                    from include/drm/drm_gem_ttm_helper.h:11,
                    from drivers/gpu/drm/drm_gem_vram_helper.c:13:
>> include/drm/ttm/ttm_pool.h:75:38: error: size of array 'orders' is negative
      75 |                 struct ttm_pool_type orders[MAX_ORDER];
         |                                      ^~~~~~
--
   In file included from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/gpu/drm/ttm/ttm_pool.c:34:
   include/linux/mmzone.h:636:33: error: size of array 'free_area' is negative
     636 |         struct free_area        free_area[MAX_ORDER];
         |                                 ^~~~~~~~~
   In file included from drivers/gpu/drm/ttm/ttm_pool.c:43:
>> include/drm/ttm/ttm_pool.h:75:38: error: size of array 'orders' is negative
      75 |                 struct ttm_pool_type orders[MAX_ORDER];
         |                                      ^~~~~~
>> drivers/gpu/drm/ttm/ttm_pool.c:67:29: error: size of array 'global_write_combined' is negative
      67 | static struct ttm_pool_type global_write_combined[MAX_ORDER];
         |                             ^~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/ttm/ttm_pool.c:68:29: error: size of array 'global_uncached' is negative
      68 | static struct ttm_pool_type global_uncached[MAX_ORDER];
         |                             ^~~~~~~~~~~~~~~
>> drivers/gpu/drm/ttm/ttm_pool.c:70:29: error: size of array 'global_dma32_write_combined' is negative
      70 | static struct ttm_pool_type global_dma32_write_combined[MAX_ORDER];
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/ttm/ttm_pool.c:71:29: error: size of array 'global_dma32_uncached' is negative
      71 | static struct ttm_pool_type global_dma32_uncached[MAX_ORDER];
         |                             ^~~~~~~~~~~~~~~~~~~~~


vim +405 arch/sparc/mm/tsb.c

0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  379  
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  380  /* When the RSS of an address space exceeds tsb_rss_limit for a TSB,
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  381   * do_sparc64_fault() invokes this routine to try and grow it.
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  382   *
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  383   * When we reach the maximum TSB size supported, we stick ~0UL into
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  384   * tsb_rss_limit for that TSB so the grow checks in do_sparc64_fault()
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  385   * will not trigger any longer.
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  386   *
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  387   * The TSB can be anywhere from 8K to 1MB in size, in increasing powers
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  388   * of two.  The TSB must be aligned to it's size, so f.e. a 512K TSB
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  389   * must be 512K aligned.  It also must be physically contiguous, so we
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  390   * cannot use vmalloc().
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  391   *
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  392   * The idea here is to grow the TSB when the RSS of the process approaches
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  393   * the number of entries that the current TSB can hold at once.  Currently,
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  394   * we trigger when the RSS hits 3/4 of the TSB capacity.
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  395   */
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  396  void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  397  {
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  398  	unsigned long max_tsb_size = 1 * 1024 * 1024;
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  399  	unsigned long new_size, old_size, flags;
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  400  	struct tsb *old_tsb, *new_tsb;
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  401  	unsigned long new_cache_index, old_cache_index;
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  402  	unsigned long new_rss_limit;
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  403  	gfp_t gfp_flags;
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  404  
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31 @405  	if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  406  		max_tsb_size = (PAGE_SIZE << MAX_ORDER);
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  407  
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  408  	new_cache_index = 0;
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  409  	for (new_size = 8192; new_size < max_tsb_size; new_size <<= 1UL) {
0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  410  		new_rss_limit = tsb_size_to_rss_limit(new_size);
0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  411  		if (new_rss_limit > rss)
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  412  			break;
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  413  		new_cache_index++;
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  414  	}
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  415  
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  416  	if (new_size == max_tsb_size)
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  417  		new_rss_limit = ~0UL;
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  418  
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  419  retry_tsb_alloc:
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  420  	gfp_flags = GFP_KERNEL;
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  421  	if (new_size > (PAGE_SIZE * 2))
a55ee1ff751f88 arch/sparc/mm/tsb.c   David S. Miller 2013-02-19  422  		gfp_flags |= __GFP_NOWARN | __GFP_NORETRY;
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  423  
1f261ef53ba066 arch/sparc64/mm/tsb.c David S. Miller 2008-03-19  424  	new_tsb = kmem_cache_alloc_node(tsb_caches[new_cache_index],
1f261ef53ba066 arch/sparc64/mm/tsb.c David S. Miller 2008-03-19  425  					gfp_flags, numa_node_id());
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  426  	if (unlikely(!new_tsb)) {
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  427  		/* Not being able to fork due to a high-order TSB
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  428  		 * allocation failure is very bad behavior.  Just back
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  429  		 * down to a 0-order allocation and force no TSB
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  430  		 * growing for this address space.
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  431  		 */
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  432  		if (mm->context.tsb_block[tsb_index].tsb == NULL &&
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  433  		    new_cache_index > 0) {
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  434  			new_cache_index = 0;
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  435  			new_size = 8192;
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  436  			new_rss_limit = ~0UL;
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  437  			goto retry_tsb_alloc;
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  438  		}
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  439  
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  440  		/* If we failed on a TSB grow, we are under serious
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  441  		 * memory pressure so don't try to grow any more.
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  442  		 */
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  443  		if (mm->context.tsb_block[tsb_index].tsb != NULL)
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  444  			mm->context.tsb_block[tsb_index].tsb_rss_limit = ~0UL;
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  445  		return;
b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  446  	}
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  447  
8b234274418d6d arch/sparc64/mm/tsb.c David S. Miller 2006-02-17  448  	/* Mark all tags as invalid.  */
bb8646d8340fa7 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  449  	tsb_init(new_tsb, new_size);
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  450  
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  451  	/* Ok, we are about to commit the changes.  If we are
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  452  	 * growing an existing TSB the locking is very tricky,
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  453  	 * so WATCH OUT!
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  454  	 *
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  455  	 * We have to hold mm->context.lock while committing to the
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  456  	 * new TSB, this synchronizes us with processors in
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  457  	 * flush_tsb_user() and switch_mm() for this address space.
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  458  	 *
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  459  	 * But even with that lock held, processors run asynchronously
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  460  	 * accessing the old TSB via TLB miss handling.  This is OK
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  461  	 * because those actions are just propagating state from the
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  462  	 * Linux page tables into the TSB, page table mappings are not
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  463  	 * being changed.  If a real fault occurs, the processor will
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  464  	 * synchronize with us when it hits flush_tsb_user(), this is
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  465  	 * also true for the case where vmscan is modifying the page
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  466  	 * tables.  The only thing we need to be careful with is to
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  467  	 * skip any locked TSB entries during copy_tsb().
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  468  	 *
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  469  	 * When we finish committing to the new TSB, we have to drop
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  470  	 * the lock and ask all other cpus running this address space
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  471  	 * to run tsb_context_switch() to see the new TSB table.
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  472  	 */
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  473  	spin_lock_irqsave(&mm->context.lock, flags);
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  474  
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  475  	old_tsb = mm->context.tsb_block[tsb_index].tsb;
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  476  	old_cache_index =
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  477  		(mm->context.tsb_block[tsb_index].tsb_reg_val & 0x7UL);
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  478  	old_size = (mm->context.tsb_block[tsb_index].tsb_nentries *
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  479  		    sizeof(struct tsb));
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  480  
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  481  
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  482  	/* Handle multiple threads trying to grow the TSB at the same time.
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  483  	 * One will get in here first, and bump the size and the RSS limit.
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  484  	 * The others will get in here next and hit this check.
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  485  	 */
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  486  	if (unlikely(old_tsb &&
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  487  		     (rss < mm->context.tsb_block[tsb_index].tsb_rss_limit))) {
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  488  		spin_unlock_irqrestore(&mm->context.lock, flags);
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  489  
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  490  		kmem_cache_free(tsb_caches[new_cache_index], new_tsb);
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  491  		return;
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  492  	}
8b234274418d6d arch/sparc64/mm/tsb.c David S. Miller 2006-02-17  493  
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  494  	mm->context.tsb_block[tsb_index].tsb_rss_limit = new_rss_limit;
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  495  
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  496  	if (old_tsb) {
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  497  		extern void copy_tsb(unsigned long old_tsb_base,
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  498  				     unsigned long old_tsb_size,
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  499  				     unsigned long new_tsb_base,
654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  500  				     unsigned long new_tsb_size,
654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  501  				     unsigned long page_size_shift);
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  502  		unsigned long old_tsb_base = (unsigned long) old_tsb;
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  503  		unsigned long new_tsb_base = (unsigned long) new_tsb;
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  504  
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  505  		if (tlb_type == cheetah_plus || tlb_type == hypervisor) {
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  506  			old_tsb_base = __pa(old_tsb_base);
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  507  			new_tsb_base = __pa(new_tsb_base);
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  508  		}
654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  509  		copy_tsb(old_tsb_base, old_size, new_tsb_base, new_size,
654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  510  			tsb_index == MM_TSB_BASE ?
654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  511  			PAGE_SHIFT : REAL_HPAGE_SHIFT);
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  512  	}
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  513  
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  514  	mm->context.tsb_block[tsb_index].tsb = new_tsb;
dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  515  	setup_tsb_params(mm, tsb_index, new_size);
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  516  
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  517  	spin_unlock_irqrestore(&mm->context.lock, flags);
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  518  
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  519  	/* If old_tsb is NULL, we're being invoked for the first time
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  520  	 * from init_new_context().
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  521  	 */
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  522  	if (old_tsb) {
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  523  		/* Reload it on the local cpu.  */
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  524  		tsb_context_switch(mm);
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  525  
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  526  		/* Now force other processors to do the same.  */
a3cf5e6b6f2548 arch/sparc64/mm/tsb.c David S. Miller 2008-08-03  527  		preempt_disable();
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  528  		smp_tsb_sync(mm);
a3cf5e6b6f2548 arch/sparc64/mm/tsb.c David S. Miller 2008-08-03  529  		preempt_enable();
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  530  
7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  531  		/* Now it is safe to free the old tsb.  */
9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  532  		kmem_cache_free(tsb_caches[old_cache_index], old_tsb);
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  533  	}
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  534  }
bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  535  

:::::: The code at line 405 was first introduced by commit
:::::: bd40791e1d289d807b8580abe1f117e9c62894e4 [SPARC64]: Dynamically grow TSB in response to RSS growth.

:::::: TO: David S. Miller <davem@davemloft.net>
:::::: CC: David S. Miller <davem@sunset.davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
