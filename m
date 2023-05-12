Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DCF700602
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbjELKvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240880AbjELKvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:51:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB10599
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:50:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46C2EFEC;
        Fri, 12 May 2023 03:51:17 -0700 (PDT)
Received: from [10.57.73.22] (unknown [10.57.73.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03A323F67D;
        Fri, 12 May 2023 03:50:30 -0700 (PDT)
Message-ID: <f02402c2-3777-78e8-7fc7-99ce05a425c5@arm.com>
Date:   Fri, 12 May 2023 11:50:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v1 5/5] mm: ptep_deref() conversion
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev
References: <20230511132113.80196-6-ryan.roberts@arm.com>
 <202305120142.yXsNEo6H-lkp@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <202305120142.yXsNEo6H-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 18:37, kernel test robot wrote:
> Hi Ryan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on sj/damon/next drm-intel/for-linux-next-fixes char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus tip/perf/core kvm/queue linus/master v6.4-rc1 next-20230511]
> [cannot apply to drm-intel/for-linux-next awilliam-vfio/next awilliam-vfio/for-linus xen-tip/linux-next acme/perf/core kvm/linux-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/mm-vmalloc-must-set-pte-via-arch-code/20230511-213826
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230511132113.80196-6-ryan.roberts%40arm.com
> patch subject: [RESEND PATCH v1 5/5] mm: ptep_deref() conversion
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230512/202305120142.yXsNEo6H-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/6cb99aca1b207cdf4f320eec14447bdc654b51df
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Ryan-Roberts/mm-vmalloc-must-set-pte-via-arch-code/20230511-213826
>         git checkout 6cb99aca1b207cdf4f320eec14447bdc654b51df
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash fs/

FYI This doesn't work on Ubuntu 20.04 or Debian Bullseye due to libc being too
old. So I used an Ubuntu 22.04 VM (x86_64), but with that was getting internal
compiler errors while compiling. Despite that, was able to repro and fix the error.

> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305120142.yXsNEo6H-lkp@intel.com/

Will do - thanks!

> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/migrate.h:8,
>                     from fs/nfs/write.c:17:
>    include/linux/hugetlb.h: In function 'huge_ptep_clear_flush':
>>> include/linux/hugetlb.h:1203:16: error: implicit declaration of function 'ptep_deref' [-Werror=implicit-function-declaration]
>     1203 |         return ptep_deref(ptep);
>          |                ^~~~~~~~~~
>>> include/linux/hugetlb.h:1203:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
>     1203 |         return ptep_deref(ptep);
>          |                ^~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> --
>    In file included from fs/proc/meminfo.c:6:
>    include/linux/hugetlb.h: In function 'huge_ptep_clear_flush':
>>> include/linux/hugetlb.h:1203:16: error: implicit declaration of function 'ptep_deref' [-Werror=implicit-function-declaration]
>     1203 |         return ptep_deref(ptep);
>          |                ^~~~~~~~~~
>>> include/linux/hugetlb.h:1203:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
>     1203 |         return ptep_deref(ptep);
>          |                ^~~~~~~~~~~~~~~~
>    fs/proc/meminfo.c: At top level:
>    fs/proc/meminfo.c:23:28: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
>       23 | void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
>          |                            ^~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +/ptep_deref +1203 include/linux/hugetlb.h
> 
>   1199	
>   1200	static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>   1201						  unsigned long addr, pte_t *ptep)
>   1202	{
>> 1203		return ptep_deref(ptep);
>   1204	}
>   1205	
> 

Root cause is due to this being MMU=n build, where the ptep helpers (including
ptep_deref()) are not defined. A huge_ptep_clear_flush() default is still
defined for linking reasons, which derefrences the ptep, so changing that to the
new helper blows up in this config.

Fixed with:

 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
+#ifdef CONFIG_MMU
	return ptep_deref(ptep);
+#else
+	return *ptep;
+#endif
 }

Will include with v2.

Thanks,
Ryan

