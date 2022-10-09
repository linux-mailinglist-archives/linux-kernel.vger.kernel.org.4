Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2857F5F8EF6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 23:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJIV03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 17:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiJIV0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 17:26:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4446D1D0DE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665350784; x=1696886784;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rtZvhWGH0FxbGNDc9vmxU2IKS9gUIUrWUMy41GcFU7E=;
  b=Ufilf3+YqjCECzCRmIy0JgrUiv1yoeIBdhCXQhdbi+CEn1M1M3X+KeyB
   y6nmfam/b5cWUwIkKcV81xigsXOot7SuoR33qj96BSC59MN50p06mVpDl
   G6AdSJOdwWSg9D2LO8YLe5N6Y5mA+k0dBf6+bTHfWuRjn+BsTPpbj82VN
   5YJtz4i8DuHtLWO7EXqoC7q1uUPff0+RryGuVMbTNGaCuOKKZEtKtMAjR
   HytX4CEVfMikj8u6IgRKRVArO7Rcqnb9/a7uaq6ld/kENEgXX8E40DHfv
   M6U3XzwL9t6DWx5RuZmVTI0f6BSCY+rEzYacrvvGsmkht+QZhHms5L2zf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="301705608"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="scan'208";a="301705608"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 14:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="688567975"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="scan'208";a="688567975"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2022 14:26:22 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ohdoT-0001IW-1K;
        Sun, 09 Oct 2022 21:26:21 +0000
Date:   Mon, 10 Oct 2022 05:26:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:akpm/mm/mm-unstable 63/63] mm/highmem.c:164:7:
 warning: Local variable 'i' shadows outer variable [shadowVariable]
Message-ID: <202210100514.zx4LHq0Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block akpm/mm/mm-unstable
head:   977bde1f5ffd252e0d4c270bc5c9489280686788
commit: 977bde1f5ffd252e0d4c270bc5c9489280686788 [63/63] highmem: fix kmap_to_page() for kmap_local_page() addresses
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 977bde1f5ffd252e0d4c270bc5c9489280686788
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

cppcheck warnings: (new ones prefixed by >>)
>> mm/highmem.c:164:7: warning: Local variable 'i' shadows outer variable [shadowVariable]
     int i = PKMAP_NR(addr);
         ^
   mm/highmem.c:159:6: note: Shadowed declaration
    int i;
        ^
   mm/highmem.c:164:7: note: Shadow variable
     int i = PKMAP_NR(addr);
         ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   mm/highmem.c:759:13: warning: Uninitialized variable: pam->page [uninitvar]
      if (pam->page == page) {
               ^
   mm/highmem.c:796:13: warning: Uninitialized variable: pam->page [uninitvar]
      if (pam->page == page) {
               ^

vim +/i +164 mm/highmem.c

3297e760776af1 Nicolas Pitre   2009-03-04  153  
13f876ba77ebd5 Thomas Gleixner 2020-11-03  154  struct page *__kmap_to_page(void *vaddr)
5a178119b0fbe3 Mel Gorman      2012-07-31  155  {
977bde1f5ffd25 Ira Weiny       2022-10-05  156  	unsigned long base = (unsigned long) vaddr & PAGE_MASK;
977bde1f5ffd25 Ira Weiny       2022-10-05  157  	struct kmap_ctrl *kctrl = &current->kmap_ctrl;
5a178119b0fbe3 Mel Gorman      2012-07-31  158  	unsigned long addr = (unsigned long)vaddr;
977bde1f5ffd25 Ira Weiny       2022-10-05  159  	int i;
5a178119b0fbe3 Mel Gorman      2012-07-31  160  
977bde1f5ffd25 Ira Weiny       2022-10-05  161  	/* kmap() mappings */
977bde1f5ffd25 Ira Weiny       2022-10-05  162  	if (WARN_ON_ONCE(addr >= PKMAP_ADDR(0) &&
977bde1f5ffd25 Ira Weiny       2022-10-05  163  			 addr < PKMAP_ADDR(LAST_PKMAP))) {
4de22c0584fb05 Joonsoo Kim     2012-12-11 @164  		int i = PKMAP_NR(addr);
9727688dbf7ea9 songqiang       2021-05-04  165  
5a178119b0fbe3 Mel Gorman      2012-07-31  166  		return pte_page(pkmap_page_table[i]);
5a178119b0fbe3 Mel Gorman      2012-07-31  167  	}
5a178119b0fbe3 Mel Gorman      2012-07-31  168  
977bde1f5ffd25 Ira Weiny       2022-10-05  169  	/* kmap_local_page() mappings */
977bde1f5ffd25 Ira Weiny       2022-10-05  170  	if (WARN_ON_ONCE(base >= __fix_to_virt(FIX_KMAP_END) &&
977bde1f5ffd25 Ira Weiny       2022-10-05  171  			 base < __fix_to_virt(FIX_KMAP_BEGIN))) {
977bde1f5ffd25 Ira Weiny       2022-10-05  172  		for (i = 0; i < kctrl->idx; i++) {
977bde1f5ffd25 Ira Weiny       2022-10-05  173  			unsigned long base_addr;
977bde1f5ffd25 Ira Weiny       2022-10-05  174  			int idx;
977bde1f5ffd25 Ira Weiny       2022-10-05  175  
977bde1f5ffd25 Ira Weiny       2022-10-05  176  			idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
977bde1f5ffd25 Ira Weiny       2022-10-05  177  			base_addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
977bde1f5ffd25 Ira Weiny       2022-10-05  178  
977bde1f5ffd25 Ira Weiny       2022-10-05  179  			if (base_addr == base)
977bde1f5ffd25 Ira Weiny       2022-10-05  180  				return pte_page(kctrl->pteval[i]);
977bde1f5ffd25 Ira Weiny       2022-10-05  181  		}
977bde1f5ffd25 Ira Weiny       2022-10-05  182  	}
977bde1f5ffd25 Ira Weiny       2022-10-05  183  
259ecb34e2cd73 Linus Walleij   2022-06-30  184  	return virt_to_page(vaddr);
5a178119b0fbe3 Mel Gorman      2012-07-31  185  }
13f876ba77ebd5 Thomas Gleixner 2020-11-03  186  EXPORT_SYMBOL(__kmap_to_page);
5a178119b0fbe3 Mel Gorman      2012-07-31  187  

:::::: The code at line 164 was first introduced by commit
:::::: 4de22c0584fb0566487b2cba5cdfbce346b18402 mm, highmem: use PKMAP_NR() to calculate an index of pkmap

:::::: TO: Joonsoo Kim <js1304@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
