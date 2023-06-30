Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A833D743EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjF3PXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjF3PXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:23:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC271B1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688138613; x=1719674613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UIOvp+45fAMvJp9F6poSFVlKnrHN9sHbde/EKpDOLcA=;
  b=Qpfch0OYaI7rySf+Yag6Sme9CUEmhjupLluo83hkHuWpdxUFq06q34y2
   5psG3DiQx5Wt4aGY5OiAcxfn6cuy3gTu/ladpEMzM/rcvDcSOBMhAVtB5
   5dpbao03wRHRzR8f4CKEZX2U90qAUlzS+JI2YRUqyUKSL9SEvLRkra1L6
   vbvFs5FxQEkEaz/7PDGu8uaxuqXnmrGgDqhQRW4DK7nCFHYLNMRyZac8A
   DoWTTub2An18TKLSC6LXk/FHYUdNilmyyS8S7UC04n+WPy4vU52nHf5M4
   DgciXTrT5YP7vCSAmCAtON4WCXr4Oncolu9y8ZbPPxgzXXSogW1MbNDo2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="342002495"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="342002495"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 08:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="711849222"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="711849222"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2023 08:23:31 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFFy7-000F4t-0P;
        Fri, 30 Jun 2023 15:23:31 +0000
Date:   Fri, 30 Jun 2023 23:23:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Hutchings <bwh@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: mm/mmap.c:2039 expand_downwards() warn: unsigned 'address' is never
 less than zero.
Message-ID: <202306302333.ay5rrRON-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e55e5df193d247a38a5e1ac65a5316a0adcc22fa
commit: 8b35ca3e45e35a26a21427f35d4093606e93ad0a arm/mm: Convert to using lock_mm_and_find_vma()
date:   6 days ago
config: i386-randconfig-m021-20230629 (https://download.01.org/0day-ci/archive/20230630/202306302333.ay5rrRON-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306302333.ay5rrRON-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306302333.ay5rrRON-lkp@intel.com/

smatch warnings:
mm/mmap.c:2039 expand_downwards() warn: unsigned 'address' is never less than zero.

vim +/address +2039 mm/mmap.c

  2027	
  2028	/*
  2029	 * vma is the first one with address < vma->vm_start.  Have to extend vma.
  2030	 */
  2031	int expand_downwards(struct vm_area_struct *vma, unsigned long address)
  2032	{
  2033		struct mm_struct *mm = vma->vm_mm;
  2034		MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
  2035		struct vm_area_struct *prev;
  2036		int error = 0;
  2037	
  2038		address &= PAGE_MASK;
> 2039		if (address < mmap_min_addr || address < FIRST_USER_ADDRESS)
  2040			return -EPERM;
  2041	
  2042		/* Enforce stack_guard_gap */
  2043		prev = mas_prev(&mas, 0);
  2044		/* Check that both stack segments have the same anon_vma? */
  2045		if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
  2046				vma_is_accessible(prev)) {
  2047			if (address - prev->vm_end < stack_guard_gap)
  2048				return -ENOMEM;
  2049		}
  2050	
  2051		if (mas_preallocate(&mas, GFP_KERNEL))
  2052			return -ENOMEM;
  2053	
  2054		/* We must make sure the anon_vma is allocated. */
  2055		if (unlikely(anon_vma_prepare(vma))) {
  2056			mas_destroy(&mas);
  2057			return -ENOMEM;
  2058		}
  2059	
  2060		/*
  2061		 * vma->vm_start/vm_end cannot change under us because the caller
  2062		 * is required to hold the mmap_lock in read mode.  We need the
  2063		 * anon_vma lock to serialize against concurrent expand_stacks.
  2064		 */
  2065		anon_vma_lock_write(vma->anon_vma);
  2066	
  2067		/* Somebody else might have raced and expanded it already */
  2068		if (address < vma->vm_start) {
  2069			unsigned long size, grow;
  2070	
  2071			size = vma->vm_end - address;
  2072			grow = (vma->vm_start - address) >> PAGE_SHIFT;
  2073	
  2074			error = -ENOMEM;
  2075			if (grow <= vma->vm_pgoff) {
  2076				error = acct_stack_growth(vma, size, grow);
  2077				if (!error) {
  2078					/*
  2079					 * We only hold a shared mmap_lock lock here, so
  2080					 * we need to protect against concurrent vma
  2081					 * expansions.  anon_vma_lock_write() doesn't
  2082					 * help here, as we don't guarantee that all
  2083					 * growable vmas in a mm share the same root
  2084					 * anon vma.  So, we reuse mm->page_table_lock
  2085					 * to guard against concurrent vma expansions.
  2086					 */
  2087					spin_lock(&mm->page_table_lock);
  2088					if (vma->vm_flags & VM_LOCKED)
  2089						mm->locked_vm += grow;
  2090					vm_stat_account(mm, vma->vm_flags, grow);
  2091					anon_vma_interval_tree_pre_update_vma(vma);
  2092					vma->vm_start = address;
  2093					vma->vm_pgoff -= grow;
  2094					/* Overwrite old entry in mtree. */
  2095					mas_set_range(&mas, address, vma->vm_end - 1);
  2096					mas_store_prealloc(&mas, vma);
  2097					anon_vma_interval_tree_post_update_vma(vma);
  2098					spin_unlock(&mm->page_table_lock);
  2099	
  2100					perf_event_mmap(vma);
  2101				}
  2102			}
  2103		}
  2104		anon_vma_unlock_write(vma->anon_vma);
  2105		khugepaged_enter_vma(vma, vma->vm_flags);
  2106		mas_destroy(&mas);
  2107		return error;
  2108	}
  2109	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
