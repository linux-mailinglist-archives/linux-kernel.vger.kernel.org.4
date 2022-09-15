Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01AB5BA279
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 23:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIOVz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 17:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIOVzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 17:55:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64054883DC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663278950; x=1694814950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PsazF88m8J9KxJRqmIFocp56MNGhfFqNtrzAxZb3oDw=;
  b=GIg9p+ymG+iiLgkHtxN+vPxlBDhAgNRTeP518KueC0/v+8vHZqPxp4dc
   JSlXge4waNP45/fVtCbkkW64VXee4vcirXuJv0g2QzaW+v8B1NYEmPhEW
   invTCH5rOkH/+8Chhsf5DT6fUQpopO5I3I7FQsVIotYFU7ID3f1KCrd8V
   o0pjDWdhjMSIxlCUG6gMmcijeXCv3gR8e+jeV9vGRx0DTFu78O22k3/Wp
   WE8zn0StUh/2RAyKjdlQg8WO1iUVTaPWzvUKkh500qzc3ZxrgKCFh7M3Q
   dK/CRBDJujQyjHXulw6+e8GneDuCeEuaSfhJZr3Znh+ezXbgIiOcv/SAb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="362813370"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="362813370"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 14:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="759812092"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2022 14:55:47 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYwpn-00013y-0J;
        Thu, 15 Sep 2022 21:55:47 +0000
Date:   Fri, 16 Sep 2022 05:54:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xin Hao <xhao@linux.alibaba.com>, sj@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: Re: [PATCH V1 2/2] mm/damon/core: remove duplicate check about THP
Message-ID: <202209160528.6z2rUbjZ-lkp@intel.com>
References: <20220915142237.92529-2-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915142237.92529-2-xhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Hao/mm-damon-sysfs-avoid-call-damon_target_has_pid-repeatedly/20220915-230635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: hexagon-randconfig-r002-20220915 (https://download.01.org/0day-ci/archive/20220916/202209160528.6z2rUbjZ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7902790b04d0eb74686b55218e8ead191ba5c003
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xin-Hao/mm-damon-sysfs-avoid-call-damon_target_has_pid-repeatedly/20220915-230635
        git checkout 7902790b04d0eb74686b55218e8ead191ba5c003
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash mm/damon/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/damon/vaddr.c:451:7: error: call to undeclared function 'pmd_young'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   if (pmd_young(*pmd) || !page_is_idle(page) ||
                       ^
   mm/damon/vaddr.c:451:7: note: did you mean 'pte_young'?
   arch/hexagon/include/asm/pgtable.h:273:19: note: 'pte_young' declared here
   static inline int pte_young(pte_t pte)
                     ^
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PROC_CHILDREN
   Depends on [n]: PROC_FS [=n]
   Selected by [y]:
   - CHECKPOINT_RESTORE [=y]


vim +/pmd_young +451 mm/damon/vaddr.c

3f49584b262cf8f SeongJae Park 2021-09-07  428  
3f49584b262cf8f SeongJae Park 2021-09-07  429  static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
3f49584b262cf8f SeongJae Park 2021-09-07  430  		unsigned long next, struct mm_walk *walk)
3f49584b262cf8f SeongJae Park 2021-09-07  431  {
3f49584b262cf8f SeongJae Park 2021-09-07  432  	pte_t *pte;
3f49584b262cf8f SeongJae Park 2021-09-07  433  	spinlock_t *ptl;
3f49584b262cf8f SeongJae Park 2021-09-07  434  	struct page *page;
3f49584b262cf8f SeongJae Park 2021-09-07  435  	struct damon_young_walk_private *priv = walk->private;
3f49584b262cf8f SeongJae Park 2021-09-07  436  
72c33ef4c02e32e Baolin Wang   2022-08-18  437  	if (pmd_trans_huge(*pmd)) {
3f49584b262cf8f SeongJae Park 2021-09-07  438  		ptl = pmd_lock(walk->mm, pmd);
c8b9aff419303e4 Baolin Wang   2022-08-18  439  		if (!pmd_present(*pmd)) {
c8b9aff419303e4 Baolin Wang   2022-08-18  440  			spin_unlock(ptl);
c8b9aff419303e4 Baolin Wang   2022-08-18  441  			return 0;
c8b9aff419303e4 Baolin Wang   2022-08-18  442  		}
c8b9aff419303e4 Baolin Wang   2022-08-18  443  
72c33ef4c02e32e Baolin Wang   2022-08-18  444  		if (!pmd_trans_huge(*pmd)) {
3f49584b262cf8f SeongJae Park 2021-09-07  445  			spin_unlock(ptl);
3f49584b262cf8f SeongJae Park 2021-09-07  446  			goto regular_page;
3f49584b262cf8f SeongJae Park 2021-09-07  447  		}
3f49584b262cf8f SeongJae Park 2021-09-07  448  		page = damon_get_page(pmd_pfn(*pmd));
3f49584b262cf8f SeongJae Park 2021-09-07  449  		if (!page)
3f49584b262cf8f SeongJae Park 2021-09-07  450  			goto huge_out;
3f49584b262cf8f SeongJae Park 2021-09-07 @451  		if (pmd_young(*pmd) || !page_is_idle(page) ||
3f49584b262cf8f SeongJae Park 2021-09-07  452  					mmu_notifier_test_young(walk->mm,
3f49584b262cf8f SeongJae Park 2021-09-07  453  						addr)) {
02e34fff195d3a5 Kefeng Wang   2022-05-17  454  			*priv->page_sz = HPAGE_PMD_SIZE;
3f49584b262cf8f SeongJae Park 2021-09-07  455  			priv->young = true;
3f49584b262cf8f SeongJae Park 2021-09-07  456  		}
3f49584b262cf8f SeongJae Park 2021-09-07  457  		put_page(page);
3f49584b262cf8f SeongJae Park 2021-09-07  458  huge_out:
3f49584b262cf8f SeongJae Park 2021-09-07  459  		spin_unlock(ptl);
3f49584b262cf8f SeongJae Park 2021-09-07  460  		return 0;
3f49584b262cf8f SeongJae Park 2021-09-07  461  	}
3f49584b262cf8f SeongJae Park 2021-09-07  462  
3f49584b262cf8f SeongJae Park 2021-09-07  463  regular_page:
3f49584b262cf8f SeongJae Park 2021-09-07  464  
3f49584b262cf8f SeongJae Park 2021-09-07  465  	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
3f49584b262cf8f SeongJae Park 2021-09-07  466  		return -EINVAL;
3f49584b262cf8f SeongJae Park 2021-09-07  467  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
3f49584b262cf8f SeongJae Park 2021-09-07  468  	if (!pte_present(*pte))
3f49584b262cf8f SeongJae Park 2021-09-07  469  		goto out;
3f49584b262cf8f SeongJae Park 2021-09-07  470  	page = damon_get_page(pte_pfn(*pte));
3f49584b262cf8f SeongJae Park 2021-09-07  471  	if (!page)
3f49584b262cf8f SeongJae Park 2021-09-07  472  		goto out;
3f49584b262cf8f SeongJae Park 2021-09-07  473  	if (pte_young(*pte) || !page_is_idle(page) ||
3f49584b262cf8f SeongJae Park 2021-09-07  474  			mmu_notifier_test_young(walk->mm, addr)) {
3f49584b262cf8f SeongJae Park 2021-09-07  475  		*priv->page_sz = PAGE_SIZE;
3f49584b262cf8f SeongJae Park 2021-09-07  476  		priv->young = true;
3f49584b262cf8f SeongJae Park 2021-09-07  477  	}
3f49584b262cf8f SeongJae Park 2021-09-07  478  	put_page(page);
3f49584b262cf8f SeongJae Park 2021-09-07  479  out:
3f49584b262cf8f SeongJae Park 2021-09-07  480  	pte_unmap_unlock(pte, ptl);
3f49584b262cf8f SeongJae Park 2021-09-07  481  	return 0;
3f49584b262cf8f SeongJae Park 2021-09-07  482  }
3f49584b262cf8f SeongJae Park 2021-09-07  483  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
