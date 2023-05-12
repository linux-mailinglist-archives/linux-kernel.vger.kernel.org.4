Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0887005B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbjELKhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbjELKhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:37:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844981FC7
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683887804; x=1715423804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2opvhMbatw/DcaVcnQ1fua4laihyL3mGTblF3mM3Gdc=;
  b=dpjTu5Dx+tfvJo7LQRjCSvezK1HOiPWtHow9alfZKOh0oeT6ijbQAmIU
   EUoTIQIIRQ4Gm0Wtkl+lBDSU+RtG5dNSa6519pTM2phsRJbJVxZ6nbgwQ
   3RNq5n/XsHn3uNJIBfLuW1numNWEaD4ewDp4coJs/mCC83QM0WTcCD5o/
   fqdFZ+1/uZ1caNVTBDI2lbMYHsLqETLQepWckDj0n+lVCOmFflatxFcJN
   46uO5dXoJeWYLfXztp1ImJu20lhWEMRmZZNI5MA0lFoTiGh+Aje8n7OPN
   XLldzjUNMnPQSWJx4dlOq4eQfampo3EB1uVMgU0Fh1R+4nO32J84xNkKT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="378893453"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378893453"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="874353843"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="874353843"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 May 2023 03:35:45 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxQ7l-0004mn-00;
        Fri, 12 May 2023 10:35:45 +0000
Date:   Fri, 12 May 2023 18:34:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v1 5/5] mm: ptep_deref() conversion
Message-ID: <202305121818.hTDtbbPW-lkp@intel.com>
References: <20230511125848.78621-6-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511125848.78621-6-ryan.roberts@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/mm-damon-must-atomically-clear-young-on-ptes-and-pmds/20230511-215947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230511125848.78621-6-ryan.roberts%40arm.com
patch subject: [PATCH v1 5/5] mm: ptep_deref() conversion
config: m68k-randconfig-r002-20230511 (https://download.01.org/0day-ci/archive/20230512/202305121818.hTDtbbPW-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2d5aca0fcce58b92572fc59bee59a4c5588f2af8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ryan-Roberts/mm-damon-must-atomically-clear-young-on-ptes-and-pmds/20230511-215947
        git checkout 2d5aca0fcce58b92572fc59bee59a4c5588f2af8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305121818.hTDtbbPW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:52:
   include/linux/hugetlb.h: In function 'huge_ptep_clear_flush':
>> include/linux/hugetlb.h:1203:16: error: implicit declaration of function 'ptep_deref' [-Werror=implicit-function-declaration]
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~
>> include/linux/hugetlb.h:1203:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~~~~~~~
   kernel/fork.c: At top level:
   kernel/fork.c:164:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     164 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:991:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     991 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:1086:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
    1086 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from kernel/sysctl.c:45:
   include/linux/hugetlb.h: In function 'huge_ptep_clear_flush':
>> include/linux/hugetlb.h:1203:16: error: implicit declaration of function 'ptep_deref' [-Werror=implicit-function-declaration]
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~
>> include/linux/hugetlb.h:1203:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ptep_deref +1203 include/linux/hugetlb.h

  1199	
  1200	static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
  1201						  unsigned long addr, pte_t *ptep)
  1202	{
> 1203		return ptep_deref(ptep);
  1204	}
  1205	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
