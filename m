Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FE469BBA3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 20:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBRTtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 14:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBRTtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 14:49:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89224125AC
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 11:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676749757; x=1708285757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VZoj3w27akZkuy8A2s3vrWcLmKogMDU6oJ6BavY8C08=;
  b=QyB7x1v6nhqBiMBDRFziAVZsgosPLKYc7kF3q810QLh8dtA7CZbLmFb4
   zxcbpdF1fZ/kJOnrb+W1QITWIG33ohY0CT3v28qd7bJujKHUmEhmSH3Zw
   Pfk9yhoVZWQEouv1E9AcZwjHjImRi6J429HdHiyF5PuEi2gv/rMxLqF2T
   YkggKx7B2xZqtz2SOBZwBuW3B/OPCD+s6QlLH5KL5UMet/hlSoKOLJn6l
   5CB3FtGrqgV4BQ6x5ha19OaXaAqcBflEwbMutn5Ya6o/+b+xGvjGk6CZn
   1369WHSRKrdY+Fj9caU5daETAz7hkBfcEeM11BpZ12eW3095R1+QU2KQF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="333559510"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="333559510"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 11:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="759773003"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="759773003"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2023 11:49:11 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTTCp-000CgP-08;
        Sat, 18 Feb 2023 19:49:11 +0000
Date:   Sun, 19 Feb 2023 03:49:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Subject: Re: [PATCH v2 14/46] hugetlb: split PTE markers when doing HGM walks
Message-ID: <202302190304.YdPwtMZS-lkp@intel.com>
References: <20230218002819.1486479-15-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218002819.1486479-15-jthoughton@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20230217]
[cannot apply to kvm/queue shuah-kselftest/next shuah-kselftest/fixes arnd-asm-generic/master linus/master kvm/linux-next v6.2-rc8 v6.2-rc7 v6.2-rc6 v6.2-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Houghton/hugetlb-don-t-set-PageUptodate-for-UFFDIO_CONTINUE/20230218-083216
patch link:    https://lore.kernel.org/r/20230218002819.1486479-15-jthoughton%40google.com
patch subject: [PATCH v2 14/46] hugetlb: split PTE markers when doing HGM walks
config: powerpc-randconfig-r001-20230217 (https://download.01.org/0day-ci/archive/20230219/202302190304.YdPwtMZS-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/55c33d65b06ad109b87a418540fe98f7365185d4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review James-Houghton/hugetlb-don-t-set-PageUptodate-for-UFFDIO_CONTINUE/20230218-083216
        git checkout 55c33d65b06ad109b87a418540fe98f7365185d4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302190304.YdPwtMZS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:104:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:579:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/hugetlb.c:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:106:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:580:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/hugetlb.c:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:108:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:581:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/hugetlb.c:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:110:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:582:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   mm/hugetlb.c:653:8: error: call to undeclared function '__pte_alloc_one'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           new = __pte_alloc_one(mm, GFP_PGTABLE_USER);
                 ^
   mm/hugetlb.c:653:8: note: did you mean 'pte_alloc_one'?
   arch/powerpc/include/asm/pgalloc.h:30:25: note: 'pte_alloc_one' declared here
   static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
                           ^
   mm/hugetlb.c:653:28: error: use of undeclared identifier 'GFP_PGTABLE_USER'
           new = __pte_alloc_one(mm, GFP_PGTABLE_USER);
                                     ^
   mm/hugetlb.c:660:25: error: incompatible pointer types passing 'pgtable_t' (aka 'unsigned long *') to parameter of type 'struct page *' [-Werror,-Wincompatible-pointer-types]
                   pgtable_pte_page_dtor(new);
                                         ^~~
   include/linux/mm.h:2661:55: note: passing argument to parameter 'page' here
   static inline void pgtable_pte_page_dtor(struct page *page)
                                                         ^
   mm/hugetlb.c:661:3: error: incompatible pointer types passing 'pgtable_t' (aka 'unsigned long *') to parameter of type 'struct page *' [-Werror,-Wincompatible-pointer-types]
                   __free_page(new);
                   ^~~~~~~~~~~~~~~~
   include/linux/gfp.h:319:40: note: expanded from macro '__free_page'
   #define __free_page(page) __free_pages((page), 0)
                                          ^~~~~~
   include/linux/gfp.h:302:39: note: passing argument to parameter 'page' here
   extern void __free_pages(struct page *page, unsigned int order);
                                         ^
>> mm/hugetlb.c:666:44: error: incompatible pointer types passing 'pgtable_t' (aka 'unsigned long *') to parameter of type 'const struct page *' [-Werror,-Wincompatible-pointer-types]
                   hugetlb_install_markers_pte(page_address(new), marker);
                                                            ^~~
   include/linux/mm.h:2001:39: note: passing argument to parameter 'page' here
   void *page_address(const struct page *page);
                                         ^
   6 warnings and 5 errors generated.


vim +666 mm/hugetlb.c

   606	
   607	/*
   608	 * hugetlb_alloc_pte -- Allocate a PTE beneath a pmd_none PMD-level hpte.
   609	 *
   610	 * See the comment above hugetlb_alloc_pmd.
   611	 */
   612	pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
   613			unsigned long addr)
   614	{
   615		spinlock_t *ptl = hugetlb_pte_lockptr(hpte);
   616		pgtable_t new;
   617		pmd_t *pmdp;
   618		pmd_t pmd;
   619		bool is_marker;
   620		pte_marker marker;
   621	
   622		if (hpte->level != HUGETLB_LEVEL_PMD)
   623			return ERR_PTR(-EINVAL);
   624	
   625		pmdp = (pmd_t *)hpte->ptep;
   626	retry:
   627		is_marker = false;
   628		pmd = READ_ONCE(*pmdp);
   629		if (likely(pmd_present(pmd)))
   630			return unlikely(pmd_leaf(pmd))
   631				? ERR_PTR(-EEXIST)
   632				: pte_offset_kernel(pmdp, addr);
   633		else if (!pmd_none(pmd)) {
   634			/*
   635			 * Not present and not none means that a swap entry lives here.
   636			 * If it's a PTE marker, we can deal with it. If it's another
   637			 * swap entry, we don't attempt to split it.
   638			 */
   639			is_marker = is_pte_marker(__pte(pmd_val(pmd)));
   640			if (!is_marker)
   641				return ERR_PTR(-EEXIST);
   642	
   643			marker = pte_marker_get(pte_to_swp_entry(__pte(pmd_val(pmd))));
   644		}
   645	
   646		/*
   647		 * With CONFIG_HIGHPTE, calling `pte_alloc_one` directly may result
   648		 * in page tables being allocated in high memory, needing a kmap to
   649		 * access. Instead, we call __pte_alloc_one directly with
   650		 * GFP_PGTABLE_USER to prevent these PTEs being allocated in high
   651		 * memory.
   652		 */
   653		new = __pte_alloc_one(mm, GFP_PGTABLE_USER);
   654		if (!new)
   655			return ERR_PTR(-ENOMEM);
   656	
   657		spin_lock(ptl);
   658		if (!pmd_same(pmd, *pmdp)) {
   659			spin_unlock(ptl);
   660			pgtable_pte_page_dtor(new);
   661			__free_page(new);
   662			goto retry;
   663		}
   664	
   665		if (is_marker)
 > 666			hugetlb_install_markers_pte(page_address(new), marker);
   667	
   668		mm_inc_nr_ptes(mm);
   669		smp_wmb(); /* See comment in pmd_install() */
   670		pmd_populate(mm, pmdp, new);
   671		spin_unlock(ptl);
   672		return pte_offset_kernel(pmdp, addr);
   673	}
   674	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
