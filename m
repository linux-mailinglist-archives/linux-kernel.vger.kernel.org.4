Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CF66FF8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbjEKRir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbjEKRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:38:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A13F3A90
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683826723; x=1715362723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h1UYVgea54dYa799BBbGISzq4gL2FTA4p+QIZ9Ceb70=;
  b=ZT00hTLm8nM/DZkI6DGNVm2HZSOK353wSc9VgTLcQunm1Q8/ByBHPZBi
   EpPAvvi4PTzrrT9DlEMVMMlR0/LwsYVPG2PfpI29slLqYeAq6pE6/balw
   AX2AVgSnJnYWT0T2aYVPEepRpjH1M8E9r/8RHy9wFLwrzrXjr3W7bNA6n
   3xYDLx/ZrJbjGmlOzO3p4+BDCJNV5Uh6IxHuH9P+DQQoU1tEXFAVQ6Nll
   8my4o/XVvhl97wt5bIXTPWG68+zkXXfugQQW92CCHe2+zh0kLlUgyy2BW
   1FpqJksVfl+JF5Ij6uM4WvhifkqCLnfRqAyfdJX9woRmCFMfFde++vX8h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="349416910"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="349416910"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="789472567"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="789472567"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 May 2023 10:38:40 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxAFU-0004A3-0s;
        Thu, 11 May 2023 17:38:40 +0000
Date:   Fri, 12 May 2023 01:37:52 +0800
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
Subject: Re: [RESEND PATCH v1 5/5] mm: ptep_deref() conversion
Message-ID: <202305120142.yXsNEo6H-lkp@intel.com>
References: <20230511132113.80196-6-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511132113.80196-6-ryan.roberts@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on sj/damon/next drm-intel/for-linux-next-fixes char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus tip/perf/core kvm/queue linus/master v6.4-rc1 next-20230511]
[cannot apply to drm-intel/for-linux-next awilliam-vfio/next awilliam-vfio/for-linus xen-tip/linux-next acme/perf/core kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/mm-vmalloc-must-set-pte-via-arch-code/20230511-213826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230511132113.80196-6-ryan.roberts%40arm.com
patch subject: [RESEND PATCH v1 5/5] mm: ptep_deref() conversion
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230512/202305120142.yXsNEo6H-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6cb99aca1b207cdf4f320eec14447bdc654b51df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ryan-Roberts/mm-vmalloc-must-set-pte-via-arch-code/20230511-213826
        git checkout 6cb99aca1b207cdf4f320eec14447bdc654b51df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305120142.yXsNEo6H-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/migrate.h:8,
                    from fs/nfs/write.c:17:
   include/linux/hugetlb.h: In function 'huge_ptep_clear_flush':
>> include/linux/hugetlb.h:1203:16: error: implicit declaration of function 'ptep_deref' [-Werror=implicit-function-declaration]
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~
>> include/linux/hugetlb.h:1203:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from fs/proc/meminfo.c:6:
   include/linux/hugetlb.h: In function 'huge_ptep_clear_flush':
>> include/linux/hugetlb.h:1203:16: error: implicit declaration of function 'ptep_deref' [-Werror=implicit-function-declaration]
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~
>> include/linux/hugetlb.h:1203:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~~~~~~~
   fs/proc/meminfo.c: At top level:
   fs/proc/meminfo.c:23:28: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      23 | void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
         |                            ^~~~~~~~~~~~~~~~~~~
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
