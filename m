Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DC774FAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGKW3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKW33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:29:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4273C10F1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689114568; x=1720650568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MF0/oGx5uxSt1HWGanh/IFZ/ftm5LhHIhZxGiK2UjMQ=;
  b=ZYaqf0uwFBfzxQjQOhOEdsbSTK6FTe9MwjgqxbrN9zdrSAg8tavCPZXs
   xN4YvtCqEu5U+hRVG+6dBIFT9MHvT8e9DLSYMKNuC3Ff1abERTZp1Q6LK
   za3qwjHIFyDNWDqJJkKAxzSwdb5qMvlhY7JTrPGbVGlhDWmxHLKFSDXOe
   BuYGl68XFWcw1xIug5NhzOWTFiB5SbSfKpaYDrwlHHmK9Qo0mh1t3EEjD
   qrpQc/3gYOlUbSRLFv9qnCcHXEvktbIgnqfzwjC9nK8DylSxZgKYJTVkR
   89isxx19oso95rMI+2QYjjCyRIvUsMuMp4FyOLWWNFDVHEpQnk3Gq/7B3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363615886"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="363615886"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 15:29:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="834883015"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="834883015"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2023 15:29:24 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJLrH-00059p-1b;
        Tue, 11 Jul 2023 22:29:23 +0000
Date:   Wed, 12 Jul 2023 06:28:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nico Pache <npache@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, aquini@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH V2] arm64: properly define SOFT_DIRTY functionality
Message-ID: <202307120618.qcxXw9mm-lkp@intel.com>
References: <20230704133633.1918147-1-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704133633.1918147-1-npache@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nico,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm/for-next arm/fixes kvmarm/next soc/for-next linus/master v6.5-rc1 next-20230711]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nico-Pache/arm64-properly-define-SOFT_DIRTY-functionality/20230704-213758
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230704133633.1918147-1-npache%40redhat.com
patch subject: [PATCH V2] arm64: properly define SOFT_DIRTY functionality
config: arm64-randconfig-r001-20230712 (https://download.01.org/0day-ci/archive/20230712/202307120618.qcxXw9mm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230712/202307120618.qcxXw9mm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307120618.qcxXw9mm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/mm_inline.h:10,
                    from fs/proc/task_mmu.c:3:
   include/linux/swapops.h: In function 'pte_swp_clear_flags':
   include/linux/swapops.h:77:23: error: implicit declaration of function 'pte_swp_clear_soft_dirty'; did you mean 'pte_swp_soft_dirty'? [-Werror=implicit-function-declaration]
      77 |                 pte = pte_swp_clear_soft_dirty(pte);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
         |                       pte_swp_soft_dirty
   include/linux/swapops.h:77:23: error: incompatible types when assigning to type 'pte_t' from type 'int'
   include/linux/swapops.h: In function 'pmd_to_swp_entry':
   include/linux/swapops.h:506:13: error: implicit declaration of function 'pmd_swp_soft_dirty'; did you mean 'pte_swp_soft_dirty'? [-Werror=implicit-function-declaration]
     506 |         if (pmd_swp_soft_dirty(pmd))
         |             ^~~~~~~~~~~~~~~~~~
         |             pte_swp_soft_dirty
   include/linux/swapops.h:507:23: error: implicit declaration of function 'pmd_swp_clear_soft_dirty'; did you mean 'pmd_swp_clear_uffd_wp'? [-Werror=implicit-function-declaration]
     507 |                 pmd = pmd_swp_clear_soft_dirty(pmd);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
         |                       pmd_swp_clear_uffd_wp
   include/linux/swapops.h:507:23: error: incompatible types when assigning to type 'pmd_t' from type 'int'
   fs/proc/task_mmu.c: In function 'pagemap_pmd_range':
>> fs/proc/task_mmu.c:1488:29: error: implicit declaration of function 'pmd_soft_dirty'; did you mean 'pte_soft_dirty'? [-Werror=implicit-function-declaration]
    1488 |                         if (pmd_soft_dirty(pmd))
         |                             ^~~~~~~~~~~~~~
         |                             pte_soft_dirty
   cc1: some warnings being treated as errors


vim +1488 fs/proc/task_mmu.c

bcf8039ed45f56 Dave Hansen           2008-06-12  1463  
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1464  static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
2165009bdf63f7 Dave Hansen           2008-06-12  1465  			     struct mm_walk *walk)
85863e475e59af Matt Mackall          2008-02-04  1466  {
f995ece24dfecb Naoya Horiguchi       2015-02-11  1467  	struct vm_area_struct *vma = walk->vma;
2165009bdf63f7 Dave Hansen           2008-06-12  1468  	struct pagemapread *pm = walk->private;
bf929152e9f6c4 Kirill A. Shutemov    2013-11-14  1469  	spinlock_t *ptl;
05fbf357d94152 Konstantin Khlebnikov 2015-02-11  1470  	pte_t *pte, *orig_pte;
85863e475e59af Matt Mackall          2008-02-04  1471  	int err = 0;
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1472  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
24d7275ce27918 Yang Shi              2022-02-11  1473  	bool migration = false;
24d7275ce27918 Yang Shi              2022-02-11  1474  
b6ec57f4b92e9b Kirill A. Shutemov    2016-01-21  1475  	ptl = pmd_trans_huge_lock(pmdp, vma);
b6ec57f4b92e9b Kirill A. Shutemov    2016-01-21  1476  	if (ptl) {
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1477  		u64 flags = 0, frame = 0;
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1478  		pmd_t pmd = *pmdp;
84c3fc4e9c563d Zi Yan                2017-09-08  1479  		struct page *page = NULL;
0f8975ec4db2c8 Pavel Emelyanov       2013-07-03  1480  
b83d7e432399d4 Huang Ying            2017-11-02  1481  		if (vma->vm_flags & VM_SOFTDIRTY)
deb945441b9408 Konstantin Khlebnikov 2015-09-08  1482  			flags |= PM_SOFT_DIRTY;
d9104d1ca96624 Cyrill Gorcunov       2013-09-11  1483  
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1484  		if (pmd_present(pmd)) {
84c3fc4e9c563d Zi Yan                2017-09-08  1485  			page = pmd_page(pmd);
77bb499bb60f4b Konstantin Khlebnikov 2015-09-08  1486  
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1487  			flags |= PM_PRESENT;
b83d7e432399d4 Huang Ying            2017-11-02 @1488  			if (pmd_soft_dirty(pmd))
b83d7e432399d4 Huang Ying            2017-11-02  1489  				flags |= PM_SOFT_DIRTY;
fb8e37f35a2fe1 Peter Xu              2021-06-30  1490  			if (pmd_uffd_wp(pmd))
fb8e37f35a2fe1 Peter Xu              2021-06-30  1491  				flags |= PM_UFFD_WP;
1c90308e7a77af Konstantin Khlebnikov 2015-09-08  1492  			if (pm->show_pfn)
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1493  				frame = pmd_pfn(pmd) +
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1494  					((addr & ~PMD_MASK) >> PAGE_SHIFT);
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1495  		}
84c3fc4e9c563d Zi Yan                2017-09-08  1496  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
84c3fc4e9c563d Zi Yan                2017-09-08  1497  		else if (is_swap_pmd(pmd)) {
84c3fc4e9c563d Zi Yan                2017-09-08  1498  			swp_entry_t entry = pmd_to_swp_entry(pmd);
ab6ecf247a9321 Huang Ying            2018-06-07  1499  			unsigned long offset;
84c3fc4e9c563d Zi Yan                2017-09-08  1500  
ab6ecf247a9321 Huang Ying            2018-06-07  1501  			if (pm->show_pfn) {
0d206b5d2e0d7d Peter Xu              2022-08-11  1502  				if (is_pfn_swap_entry(entry))
0d206b5d2e0d7d Peter Xu              2022-08-11  1503  					offset = swp_offset_pfn(entry);
0d206b5d2e0d7d Peter Xu              2022-08-11  1504  				else
0d206b5d2e0d7d Peter Xu              2022-08-11  1505  					offset = swp_offset(entry);
0d206b5d2e0d7d Peter Xu              2022-08-11  1506  				offset = offset +
ab6ecf247a9321 Huang Ying            2018-06-07  1507  					((addr & ~PMD_MASK) >> PAGE_SHIFT);
84c3fc4e9c563d Zi Yan                2017-09-08  1508  				frame = swp_type(entry) |
88c28f2469151b Huang Ying            2018-04-20  1509  					(offset << MAX_SWAPFILES_SHIFT);
ab6ecf247a9321 Huang Ying            2018-06-07  1510  			}
84c3fc4e9c563d Zi Yan                2017-09-08  1511  			flags |= PM_SWAP;
b83d7e432399d4 Huang Ying            2017-11-02  1512  			if (pmd_swp_soft_dirty(pmd))
b83d7e432399d4 Huang Ying            2017-11-02  1513  				flags |= PM_SOFT_DIRTY;
fb8e37f35a2fe1 Peter Xu              2021-06-30  1514  			if (pmd_swp_uffd_wp(pmd))
fb8e37f35a2fe1 Peter Xu              2021-06-30  1515  				flags |= PM_UFFD_WP;
84c3fc4e9c563d Zi Yan                2017-09-08  1516  			VM_BUG_ON(!is_pmd_migration_entry(pmd));
24d7275ce27918 Yang Shi              2022-02-11  1517  			migration = is_migration_entry(entry);
af5cdaf82238fb Alistair Popple       2021-06-30  1518  			page = pfn_swap_entry_to_page(entry);
84c3fc4e9c563d Zi Yan                2017-09-08  1519  		}
84c3fc4e9c563d Zi Yan                2017-09-08  1520  #endif
84c3fc4e9c563d Zi Yan                2017-09-08  1521  
24d7275ce27918 Yang Shi              2022-02-11  1522  		if (page && !migration && page_mapcount(page) == 1)
84c3fc4e9c563d Zi Yan                2017-09-08  1523  			flags |= PM_MMAP_EXCLUSIVE;
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1524  
5aaabe831eb527 Naoya Horiguchi       2012-03-21  1525  		for (; addr != end; addr += PAGE_SIZE) {
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1526  			pagemap_entry_t pme = make_pme(frame, flags);
5aaabe831eb527 Naoya Horiguchi       2012-03-21  1527  
092b50bacd1cdb Naoya Horiguchi       2012-03-21  1528  			err = add_to_pagemap(addr, &pme, pm);
5aaabe831eb527 Naoya Horiguchi       2012-03-21  1529  			if (err)
5aaabe831eb527 Naoya Horiguchi       2012-03-21  1530  				break;
ab6ecf247a9321 Huang Ying            2018-06-07  1531  			if (pm->show_pfn) {
ab6ecf247a9321 Huang Ying            2018-06-07  1532  				if (flags & PM_PRESENT)
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1533  					frame++;
88c28f2469151b Huang Ying            2018-04-20  1534  				else if (flags & PM_SWAP)
88c28f2469151b Huang Ying            2018-04-20  1535  					frame += (1 << MAX_SWAPFILES_SHIFT);
5aaabe831eb527 Naoya Horiguchi       2012-03-21  1536  			}
ab6ecf247a9321 Huang Ying            2018-06-07  1537  		}
bf929152e9f6c4 Kirill A. Shutemov    2013-11-14  1538  		spin_unlock(ptl);
5aaabe831eb527 Naoya Horiguchi       2012-03-21  1539  		return err;
5aaabe831eb527 Naoya Horiguchi       2012-03-21  1540  	}
5aaabe831eb527 Naoya Horiguchi       2012-03-21  1541  
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1542  	if (pmd_trans_unstable(pmdp))
45f83cefe3a5f0 Andrea Arcangeli      2012-03-28  1543  		return 0;
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1544  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
bcf8039ed45f56 Dave Hansen           2008-06-12  1545  
81d0fa623c5b8d Peter Feiner          2014-10-09  1546  	/*
f995ece24dfecb Naoya Horiguchi       2015-02-11  1547  	 * We can assume that @vma always points to a valid one and @end never
f995ece24dfecb Naoya Horiguchi       2015-02-11  1548  	 * goes beyond vma->vm_end.
81d0fa623c5b8d Peter Feiner          2014-10-09  1549  	 */
356515e7b64c26 Konstantin Khlebnikov 2015-09-08  1550  	orig_pte = pte = pte_offset_map_lock(walk->mm, pmdp, addr, &ptl);
f995ece24dfecb Naoya Horiguchi       2015-02-11  1551  	for (; addr < end; pte++, addr += PAGE_SIZE) {
81d0fa623c5b8d Peter Feiner          2014-10-09  1552  		pagemap_entry_t pme;
05fbf357d94152 Konstantin Khlebnikov 2015-02-11  1553  
deb945441b9408 Konstantin Khlebnikov 2015-09-08  1554  		pme = pte_to_pagemap_entry(pm, vma, addr, *pte);
092b50bacd1cdb Naoya Horiguchi       2012-03-21  1555  		err = add_to_pagemap(addr, &pme, pm);
85863e475e59af Matt Mackall          2008-02-04  1556  		if (err)
05fbf357d94152 Konstantin Khlebnikov 2015-02-11  1557  			break;
85863e475e59af Matt Mackall          2008-02-04  1558  	}
05fbf357d94152 Konstantin Khlebnikov 2015-02-11  1559  	pte_unmap_unlock(orig_pte, ptl);
05fbf357d94152 Konstantin Khlebnikov 2015-02-11  1560  
85863e475e59af Matt Mackall          2008-02-04  1561  	cond_resched();
85863e475e59af Matt Mackall          2008-02-04  1562  
85863e475e59af Matt Mackall          2008-02-04  1563  	return err;
85863e475e59af Matt Mackall          2008-02-04  1564  }
85863e475e59af Matt Mackall          2008-02-04  1565  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
