Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3386EECBA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 05:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbjDZDYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 23:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjDZDYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 23:24:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767BEE59
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682479470; x=1714015470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z7UEdgpUYeG2ZJm+QYnoYMk7uf8GFEkkHFKE91sYASA=;
  b=a0hPB/HLaVSritm00ySptFgdyJWgqJB6kbxEV21kIro6WkCO6PT6INE8
   T9lHfDfR/3ctXOGzMUMzv8eCImq/5XOBadqxS6y7JFPa0qAAykfyVbZ/Y
   IDQVgdXGYb9XGd4XIFj9B+mmg1HtoC5+2++5NrgPGfLMCd95rBmXABoOH
   k6sp/JEZgJ/vg6qSKCnOBqydG5SKuRHwVq/0khDJ0jDoDyYEMSBBZeVy2
   1wM5T1AahWmb5UmtogyiEH+FY9xwMC2UHksjyG4DbyqhaDbtce7ci/9zW
   mQYP+FaoDtPFO1bcjow4HQ7G95tGU5MdOSAne3wi7gMQ93m/9E6Z/Ipw0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="349778869"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="349778869"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 20:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="696446907"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="696446907"
Received: from lkp-server01.sh.intel.com (HELO 98ee5a99fc83) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Apr 2023 20:24:27 -0700
Received: from kbuild by 98ee5a99fc83 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prVlb-00002t-0M;
        Wed, 26 Apr 2023 03:24:27 +0000
Date:   Wed, 26 Apr 2023 11:23:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 16/34] maple_tree: Make test code work without debug
 enabled
Message-ID: <202304261147.XQLxtmwo-lkp@intel.com>
References: <20230425140955.3834476-17-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425140955.3834476-17-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.3 next-20230425]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liam-R-Howlett/maple_tree-Fix-static-analyser-cppcheck-issue/20230425-233958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230425140955.3834476-17-Liam.Howlett%40oracle.com
patch subject: [PATCH 16/34] maple_tree: Make test code work without debug enabled
config: openrisc-randconfig-r015-20230423 (https://download.01.org/0day-ci/archive/20230426/202304261147.XQLxtmwo-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a51199306b9f48db55117d3357e7a19c845c089c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liam-R-Howlett/maple_tree-Fix-static-analyser-cppcheck-issue/20230425-233958
        git checkout a51199306b9f48db55117d3357e7a19c845c089c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304261147.XQLxtmwo-lkp@intel.com/

All errors (new ones prefixed by >>):

   lib/test_maple_tree.c: In function 'check_ranges':
>> lib/test_maple_tree.c:1078:9: error: implicit declaration of function 'mt_validate' [-Werror=implicit-function-declaration]
    1078 |         mt_validate(mt);
         |         ^~~~~~~~~~~
   lib/test_maple_tree.c: In function 'check_dup':
>> lib/test_maple_tree.c:2498:9: error: implicit declaration of function 'mt_cache_shrink' [-Werror=implicit-function-declaration]
    2498 |         mt_cache_shrink();
         |         ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:30,
                    from include/linux/maple_tree.h:11,
                    from lib/test_maple_tree.c:10:
   lib/test_maple_tree.c: In function 'maple_tree_seed':
>> lib/test_maple_tree.c:2985:38: error: 'maple_tree_tests_passed' undeclared (first use in this function)
    2985 |                         atomic_read(&maple_tree_tests_passed),
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:528:9: note: in expansion of macro 'printk'
     528 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   lib/test_maple_tree.c:2984:9: note: in expansion of macro 'pr_info'
    2984 |         pr_info("maple_tree: %u of %u tests passed\n",
         |         ^~~~~~~
   lib/test_maple_tree.c:2985:38: note: each undeclared identifier is reported only once for each function it appears in
    2985 |                         atomic_read(&maple_tree_tests_passed),
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:528:9: note: in expansion of macro 'printk'
     528 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   lib/test_maple_tree.c:2984:9: note: in expansion of macro 'pr_info'
    2984 |         pr_info("maple_tree: %u of %u tests passed\n",
         |         ^~~~~~~
>> lib/test_maple_tree.c:2986:38: error: 'maple_tree_tests_run' undeclared (first use in this function)
    2986 |                         atomic_read(&maple_tree_tests_run));
         |                                      ^~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:528:9: note: in expansion of macro 'printk'
     528 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   lib/test_maple_tree.c:2984:9: note: in expansion of macro 'pr_info'
    2984 |         pr_info("maple_tree: %u of %u tests passed\n",
         |         ^~~~~~~
   cc1: some warnings being treated as errors


vim +/mt_validate +1078 lib/test_maple_tree.c

e15e06a8392321 Liam R. Howlett 2022-09-06   947  
120b116208a087 Liam Howlett    2022-10-28   948  static noinline void check_ranges(struct maple_tree *mt)
e15e06a8392321 Liam R. Howlett 2022-09-06   949  {
120b116208a087 Liam Howlett    2022-10-28   950  	int i, val, val2;
120b116208a087 Liam Howlett    2022-10-28   951  	unsigned long r[] = {
120b116208a087 Liam Howlett    2022-10-28   952  		10, 15,
120b116208a087 Liam Howlett    2022-10-28   953  		20, 25,
120b116208a087 Liam Howlett    2022-10-28   954  		17, 22, /* Overlaps previous range. */
120b116208a087 Liam Howlett    2022-10-28   955  		9, 1000, /* Huge. */
120b116208a087 Liam Howlett    2022-10-28   956  		100, 200,
120b116208a087 Liam Howlett    2022-10-28   957  		45, 168,
120b116208a087 Liam Howlett    2022-10-28   958  		118, 128,
e15e06a8392321 Liam R. Howlett 2022-09-06   959  			};
e15e06a8392321 Liam R. Howlett 2022-09-06   960  
120b116208a087 Liam Howlett    2022-10-28   961  	MT_BUG_ON(mt, !mtree_empty(mt));
120b116208a087 Liam Howlett    2022-10-28   962  	check_insert_range(mt, r[0], r[1], xa_mk_value(r[0]), 0);
120b116208a087 Liam Howlett    2022-10-28   963  	check_insert_range(mt, r[2], r[3], xa_mk_value(r[2]), 0);
120b116208a087 Liam Howlett    2022-10-28   964  	check_insert_range(mt, r[4], r[5], xa_mk_value(r[4]), -EEXIST);
120b116208a087 Liam Howlett    2022-10-28   965  	MT_BUG_ON(mt, !mt_height(mt));
120b116208a087 Liam Howlett    2022-10-28   966  	/* Store */
120b116208a087 Liam Howlett    2022-10-28   967  	check_store_range(mt, r[4], r[5], xa_mk_value(r[4]), 0);
120b116208a087 Liam Howlett    2022-10-28   968  	check_store_range(mt, r[6], r[7], xa_mk_value(r[6]), 0);
120b116208a087 Liam Howlett    2022-10-28   969  	check_store_range(mt, r[8], r[9], xa_mk_value(r[8]), 0);
120b116208a087 Liam Howlett    2022-10-28   970  	MT_BUG_ON(mt, !mt_height(mt));
120b116208a087 Liam Howlett    2022-10-28   971  	mtree_destroy(mt);
120b116208a087 Liam Howlett    2022-10-28   972  	MT_BUG_ON(mt, mt_height(mt));
e15e06a8392321 Liam R. Howlett 2022-09-06   973  
120b116208a087 Liam Howlett    2022-10-28   974  	check_seq(mt, 50, false);
120b116208a087 Liam Howlett    2022-10-28   975  	mt_set_non_kernel(4);
120b116208a087 Liam Howlett    2022-10-28   976  	check_store_range(mt, 5, 47,  xa_mk_value(47), 0);
120b116208a087 Liam Howlett    2022-10-28   977  	MT_BUG_ON(mt, !mt_height(mt));
120b116208a087 Liam Howlett    2022-10-28   978  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06   979  
120b116208a087 Liam Howlett    2022-10-28   980  	/* Create tree of 1-100 */
120b116208a087 Liam Howlett    2022-10-28   981  	check_seq(mt, 100, false);
120b116208a087 Liam Howlett    2022-10-28   982  	/* Store 45-168 */
120b116208a087 Liam Howlett    2022-10-28   983  	mt_set_non_kernel(10);
120b116208a087 Liam Howlett    2022-10-28   984  	check_store_range(mt, r[10], r[11], xa_mk_value(r[10]), 0);
120b116208a087 Liam Howlett    2022-10-28   985  	MT_BUG_ON(mt, !mt_height(mt));
120b116208a087 Liam Howlett    2022-10-28   986  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06   987  
120b116208a087 Liam Howlett    2022-10-28   988  	/* Create tree of 1-200 */
120b116208a087 Liam Howlett    2022-10-28   989  	check_seq(mt, 200, false);
120b116208a087 Liam Howlett    2022-10-28   990  	/* Store 45-168 */
120b116208a087 Liam Howlett    2022-10-28   991  	check_store_range(mt, r[10], r[11], xa_mk_value(r[10]), 0);
120b116208a087 Liam Howlett    2022-10-28   992  	MT_BUG_ON(mt, !mt_height(mt));
120b116208a087 Liam Howlett    2022-10-28   993  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06   994  
120b116208a087 Liam Howlett    2022-10-28   995  	check_seq(mt, 30, false);
120b116208a087 Liam Howlett    2022-10-28   996  	check_store_range(mt, 6, 18, xa_mk_value(6), 0);
120b116208a087 Liam Howlett    2022-10-28   997  	MT_BUG_ON(mt, !mt_height(mt));
120b116208a087 Liam Howlett    2022-10-28   998  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06   999  
120b116208a087 Liam Howlett    2022-10-28  1000  	/* Overwrite across multiple levels. */
120b116208a087 Liam Howlett    2022-10-28  1001  	/* Create tree of 1-400 */
120b116208a087 Liam Howlett    2022-10-28  1002  	check_seq(mt, 400, false);
120b116208a087 Liam Howlett    2022-10-28  1003  	mt_set_non_kernel(50);
120b116208a087 Liam Howlett    2022-10-28  1004  	/* Store 118-128 */
120b116208a087 Liam Howlett    2022-10-28  1005  	check_store_range(mt, r[12], r[13], xa_mk_value(r[12]), 0);
120b116208a087 Liam Howlett    2022-10-28  1006  	mt_set_non_kernel(50);
120b116208a087 Liam Howlett    2022-10-28  1007  	mtree_test_erase(mt, 140);
120b116208a087 Liam Howlett    2022-10-28  1008  	mtree_test_erase(mt, 141);
120b116208a087 Liam Howlett    2022-10-28  1009  	mtree_test_erase(mt, 142);
120b116208a087 Liam Howlett    2022-10-28  1010  	mtree_test_erase(mt, 143);
120b116208a087 Liam Howlett    2022-10-28  1011  	mtree_test_erase(mt, 130);
120b116208a087 Liam Howlett    2022-10-28  1012  	mtree_test_erase(mt, 131);
120b116208a087 Liam Howlett    2022-10-28  1013  	mtree_test_erase(mt, 132);
120b116208a087 Liam Howlett    2022-10-28  1014  	mtree_test_erase(mt, 133);
120b116208a087 Liam Howlett    2022-10-28  1015  	mtree_test_erase(mt, 134);
120b116208a087 Liam Howlett    2022-10-28  1016  	mtree_test_erase(mt, 135);
120b116208a087 Liam Howlett    2022-10-28  1017  	check_load(mt, r[12], xa_mk_value(r[12]));
120b116208a087 Liam Howlett    2022-10-28  1018  	check_load(mt, r[13], xa_mk_value(r[12]));
120b116208a087 Liam Howlett    2022-10-28  1019  	check_load(mt, r[13] - 1, xa_mk_value(r[12]));
120b116208a087 Liam Howlett    2022-10-28  1020  	check_load(mt, r[13] + 1, xa_mk_value(r[13] + 1));
120b116208a087 Liam Howlett    2022-10-28  1021  	check_load(mt, 135, NULL);
120b116208a087 Liam Howlett    2022-10-28  1022  	check_load(mt, 140, NULL);
120b116208a087 Liam Howlett    2022-10-28  1023  	mt_set_non_kernel(0);
120b116208a087 Liam Howlett    2022-10-28  1024  	MT_BUG_ON(mt, !mt_height(mt));
120b116208a087 Liam Howlett    2022-10-28  1025  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06  1026  
e15e06a8392321 Liam R. Howlett 2022-09-06  1027  
e15e06a8392321 Liam R. Howlett 2022-09-06  1028  
120b116208a087 Liam Howlett    2022-10-28  1029  	/* Overwrite multiple levels at the end of the tree (slot 7) */
120b116208a087 Liam Howlett    2022-10-28  1030  	mt_set_non_kernel(50);
120b116208a087 Liam Howlett    2022-10-28  1031  	check_seq(mt, 400, false);
120b116208a087 Liam Howlett    2022-10-28  1032  	check_store_range(mt, 353, 361, xa_mk_value(353), 0);
120b116208a087 Liam Howlett    2022-10-28  1033  	check_store_range(mt, 347, 352, xa_mk_value(347), 0);
e15e06a8392321 Liam R. Howlett 2022-09-06  1034  
120b116208a087 Liam Howlett    2022-10-28  1035  	check_load(mt, 346, xa_mk_value(346));
120b116208a087 Liam Howlett    2022-10-28  1036  	for (i = 347; i <= 352; i++)
120b116208a087 Liam Howlett    2022-10-28  1037  		check_load(mt, i, xa_mk_value(347));
120b116208a087 Liam Howlett    2022-10-28  1038  	for (i = 353; i <= 361; i++)
120b116208a087 Liam Howlett    2022-10-28  1039  		check_load(mt, i, xa_mk_value(353));
120b116208a087 Liam Howlett    2022-10-28  1040  	check_load(mt, 362, xa_mk_value(362));
120b116208a087 Liam Howlett    2022-10-28  1041  	mt_set_non_kernel(0);
120b116208a087 Liam Howlett    2022-10-28  1042  	MT_BUG_ON(mt, !mt_height(mt));
120b116208a087 Liam Howlett    2022-10-28  1043  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06  1044  
120b116208a087 Liam Howlett    2022-10-28  1045  	mt_set_non_kernel(50);
120b116208a087 Liam Howlett    2022-10-28  1046  	check_seq(mt, 400, false);
120b116208a087 Liam Howlett    2022-10-28  1047  	check_store_range(mt, 352, 364, NULL, 0);
120b116208a087 Liam Howlett    2022-10-28  1048  	check_store_range(mt, 351, 363, xa_mk_value(352), 0);
120b116208a087 Liam Howlett    2022-10-28  1049  	check_load(mt, 350, xa_mk_value(350));
120b116208a087 Liam Howlett    2022-10-28  1050  	check_load(mt, 351, xa_mk_value(352));
120b116208a087 Liam Howlett    2022-10-28  1051  	for (i = 352; i <= 363; i++)
120b116208a087 Liam Howlett    2022-10-28  1052  		check_load(mt, i, xa_mk_value(352));
120b116208a087 Liam Howlett    2022-10-28  1053  	check_load(mt, 364, NULL);
120b116208a087 Liam Howlett    2022-10-28  1054  	check_load(mt, 365, xa_mk_value(365));
e15e06a8392321 Liam R. Howlett 2022-09-06  1055  	mt_set_non_kernel(0);
120b116208a087 Liam Howlett    2022-10-28  1056  	MT_BUG_ON(mt, !mt_height(mt));
e15e06a8392321 Liam R. Howlett 2022-09-06  1057  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06  1058  
120b116208a087 Liam Howlett    2022-10-28  1059  	mt_set_non_kernel(5);
120b116208a087 Liam Howlett    2022-10-28  1060  	check_seq(mt, 400, false);
120b116208a087 Liam Howlett    2022-10-28  1061  	check_store_range(mt, 352, 364, NULL, 0);
120b116208a087 Liam Howlett    2022-10-28  1062  	check_store_range(mt, 351, 364, xa_mk_value(352), 0);
120b116208a087 Liam Howlett    2022-10-28  1063  	check_load(mt, 350, xa_mk_value(350));
120b116208a087 Liam Howlett    2022-10-28  1064  	check_load(mt, 351, xa_mk_value(352));
120b116208a087 Liam Howlett    2022-10-28  1065  	for (i = 352; i <= 364; i++)
120b116208a087 Liam Howlett    2022-10-28  1066  		check_load(mt, i, xa_mk_value(352));
120b116208a087 Liam Howlett    2022-10-28  1067  	check_load(mt, 365, xa_mk_value(365));
120b116208a087 Liam Howlett    2022-10-28  1068  	mt_set_non_kernel(0);
120b116208a087 Liam Howlett    2022-10-28  1069  	MT_BUG_ON(mt, !mt_height(mt));
e15e06a8392321 Liam R. Howlett 2022-09-06  1070  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06  1071  
120b116208a087 Liam Howlett    2022-10-28  1072  
120b116208a087 Liam Howlett    2022-10-28  1073  	mt_set_non_kernel(50);
120b116208a087 Liam Howlett    2022-10-28  1074  	check_seq(mt, 400, false);
120b116208a087 Liam Howlett    2022-10-28  1075  	check_store_range(mt, 362, 367, xa_mk_value(362), 0);
120b116208a087 Liam Howlett    2022-10-28  1076  	check_store_range(mt, 353, 361, xa_mk_value(353), 0);
e15e06a8392321 Liam R. Howlett 2022-09-06  1077  	mt_set_non_kernel(0);
120b116208a087 Liam Howlett    2022-10-28 @1078  	mt_validate(mt);
120b116208a087 Liam Howlett    2022-10-28  1079  	MT_BUG_ON(mt, !mt_height(mt));
e15e06a8392321 Liam R. Howlett 2022-09-06  1080  	mtree_destroy(mt);
120b116208a087 Liam Howlett    2022-10-28  1081  	/*
120b116208a087 Liam Howlett    2022-10-28  1082  	 * Interesting cases:
120b116208a087 Liam Howlett    2022-10-28  1083  	 * 1. Overwrite the end of a node and end in the first entry of the next
120b116208a087 Liam Howlett    2022-10-28  1084  	 * node.
120b116208a087 Liam Howlett    2022-10-28  1085  	 * 2. Split a single range
120b116208a087 Liam Howlett    2022-10-28  1086  	 * 3. Overwrite the start of a range
120b116208a087 Liam Howlett    2022-10-28  1087  	 * 4. Overwrite the end of a range
120b116208a087 Liam Howlett    2022-10-28  1088  	 * 5. Overwrite the entire range
120b116208a087 Liam Howlett    2022-10-28  1089  	 * 6. Overwrite a range that causes multiple parent nodes to be
120b116208a087 Liam Howlett    2022-10-28  1090  	 * combined
120b116208a087 Liam Howlett    2022-10-28  1091  	 * 7. Overwrite a range that causes multiple parent nodes and part of
120b116208a087 Liam Howlett    2022-10-28  1092  	 * root to be combined
120b116208a087 Liam Howlett    2022-10-28  1093  	 * 8. Overwrite the whole tree
120b116208a087 Liam Howlett    2022-10-28  1094  	 * 9. Try to overwrite the zero entry of an alloc tree.
120b116208a087 Liam Howlett    2022-10-28  1095  	 * 10. Write a range larger than a nodes current pivot
120b116208a087 Liam Howlett    2022-10-28  1096  	 */
e15e06a8392321 Liam R. Howlett 2022-09-06  1097  
120b116208a087 Liam Howlett    2022-10-28  1098  	mt_set_non_kernel(50);
120b116208a087 Liam Howlett    2022-10-28  1099  	for (i = 0; i <= 500; i++) {
120b116208a087 Liam Howlett    2022-10-28  1100  		val = i*5;
120b116208a087 Liam Howlett    2022-10-28  1101  		val2 = (i+1)*5;
120b116208a087 Liam Howlett    2022-10-28  1102  		check_store_range(mt, val, val2, xa_mk_value(val), 0);
e15e06a8392321 Liam R. Howlett 2022-09-06  1103  	}
120b116208a087 Liam Howlett    2022-10-28  1104  	check_store_range(mt, 2400, 2400, xa_mk_value(2400), 0);
120b116208a087 Liam Howlett    2022-10-28  1105  	check_store_range(mt, 2411, 2411, xa_mk_value(2411), 0);
120b116208a087 Liam Howlett    2022-10-28  1106  	check_store_range(mt, 2412, 2412, xa_mk_value(2412), 0);
120b116208a087 Liam Howlett    2022-10-28  1107  	check_store_range(mt, 2396, 2400, xa_mk_value(4052020), 0);
120b116208a087 Liam Howlett    2022-10-28  1108  	check_store_range(mt, 2402, 2402, xa_mk_value(2402), 0);
e15e06a8392321 Liam R. Howlett 2022-09-06  1109  	mtree_destroy(mt);
120b116208a087 Liam Howlett    2022-10-28  1110  	mt_set_non_kernel(0);
e15e06a8392321 Liam R. Howlett 2022-09-06  1111  
120b116208a087 Liam Howlett    2022-10-28  1112  	mt_set_non_kernel(50);
120b116208a087 Liam Howlett    2022-10-28  1113  	for (i = 0; i <= 500; i++) {
120b116208a087 Liam Howlett    2022-10-28  1114  		val = i*5;
120b116208a087 Liam Howlett    2022-10-28  1115  		val2 = (i+1)*5;
120b116208a087 Liam Howlett    2022-10-28  1116  		check_store_range(mt, val, val2, xa_mk_value(val), 0);
120b116208a087 Liam Howlett    2022-10-28  1117  	}
120b116208a087 Liam Howlett    2022-10-28  1118  	check_store_range(mt, 2422, 2422, xa_mk_value(2422), 0);
120b116208a087 Liam Howlett    2022-10-28  1119  	check_store_range(mt, 2424, 2424, xa_mk_value(2424), 0);
120b116208a087 Liam Howlett    2022-10-28  1120  	check_store_range(mt, 2425, 2425, xa_mk_value(2), 0);
120b116208a087 Liam Howlett    2022-10-28  1121  	check_store_range(mt, 2460, 2470, NULL, 0);
120b116208a087 Liam Howlett    2022-10-28  1122  	check_store_range(mt, 2435, 2460, xa_mk_value(2435), 0);
120b116208a087 Liam Howlett    2022-10-28  1123  	check_store_range(mt, 2461, 2470, xa_mk_value(2461), 0);
e15e06a8392321 Liam R. Howlett 2022-09-06  1124  	mt_set_non_kernel(0);
120b116208a087 Liam Howlett    2022-10-28  1125  	MT_BUG_ON(mt, !mt_height(mt));
e15e06a8392321 Liam R. Howlett 2022-09-06  1126  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06  1127  
120b116208a087 Liam Howlett    2022-10-28  1128  	/* Test rebalance gaps */
e15e06a8392321 Liam R. Howlett 2022-09-06  1129  	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
120b116208a087 Liam Howlett    2022-10-28  1130  	mt_set_non_kernel(50);
120b116208a087 Liam Howlett    2022-10-28  1131  	for (i = 0; i <= 50; i++) {
120b116208a087 Liam Howlett    2022-10-28  1132  		val = i*10;
120b116208a087 Liam Howlett    2022-10-28  1133  		val2 = (i+1)*10;
120b116208a087 Liam Howlett    2022-10-28  1134  		check_store_range(mt, val, val2, xa_mk_value(val), 0);
120b116208a087 Liam Howlett    2022-10-28  1135  	}
120b116208a087 Liam Howlett    2022-10-28  1136  	check_store_range(mt, 161, 161, xa_mk_value(161), 0);
120b116208a087 Liam Howlett    2022-10-28  1137  	check_store_range(mt, 162, 162, xa_mk_value(162), 0);
120b116208a087 Liam Howlett    2022-10-28  1138  	check_store_range(mt, 163, 163, xa_mk_value(163), 0);
120b116208a087 Liam Howlett    2022-10-28  1139  	check_store_range(mt, 240, 249, NULL, 0);
120b116208a087 Liam Howlett    2022-10-28  1140  	mtree_erase(mt, 200);
120b116208a087 Liam Howlett    2022-10-28  1141  	mtree_erase(mt, 210);
120b116208a087 Liam Howlett    2022-10-28  1142  	mtree_erase(mt, 220);
120b116208a087 Liam Howlett    2022-10-28  1143  	mtree_erase(mt, 230);
120b116208a087 Liam Howlett    2022-10-28  1144  	mt_set_non_kernel(0);
120b116208a087 Liam Howlett    2022-10-28  1145  	MT_BUG_ON(mt, !mt_height(mt));
e15e06a8392321 Liam R. Howlett 2022-09-06  1146  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06  1147  
e15e06a8392321 Liam R. Howlett 2022-09-06  1148  	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
120b116208a087 Liam Howlett    2022-10-28  1149  	for (i = 0; i <= 500; i++) {
120b116208a087 Liam Howlett    2022-10-28  1150  		val = i*10;
120b116208a087 Liam Howlett    2022-10-28  1151  		val2 = (i+1)*10;
120b116208a087 Liam Howlett    2022-10-28  1152  		check_store_range(mt, val, val2, xa_mk_value(val), 0);
120b116208a087 Liam Howlett    2022-10-28  1153  	}
120b116208a087 Liam Howlett    2022-10-28  1154  	check_store_range(mt, 4600, 4959, xa_mk_value(1), 0);
120b116208a087 Liam Howlett    2022-10-28  1155  	mt_validate(mt);
120b116208a087 Liam Howlett    2022-10-28  1156  	MT_BUG_ON(mt, !mt_height(mt));
e15e06a8392321 Liam R. Howlett 2022-09-06  1157  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06  1158  
e15e06a8392321 Liam R. Howlett 2022-09-06  1159  	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
120b116208a087 Liam Howlett    2022-10-28  1160  	for (i = 0; i <= 500; i++) {
120b116208a087 Liam Howlett    2022-10-28  1161  		val = i*10;
120b116208a087 Liam Howlett    2022-10-28  1162  		val2 = (i+1)*10;
120b116208a087 Liam Howlett    2022-10-28  1163  		check_store_range(mt, val, val2, xa_mk_value(val), 0);
120b116208a087 Liam Howlett    2022-10-28  1164  	}
120b116208a087 Liam Howlett    2022-10-28  1165  	check_store_range(mt, 4811, 4811, xa_mk_value(4811), 0);
120b116208a087 Liam Howlett    2022-10-28  1166  	check_store_range(mt, 4812, 4812, xa_mk_value(4812), 0);
120b116208a087 Liam Howlett    2022-10-28  1167  	check_store_range(mt, 4861, 4861, xa_mk_value(4861), 0);
120b116208a087 Liam Howlett    2022-10-28  1168  	check_store_range(mt, 4862, 4862, xa_mk_value(4862), 0);
120b116208a087 Liam Howlett    2022-10-28  1169  	check_store_range(mt, 4842, 4849, NULL, 0);
120b116208a087 Liam Howlett    2022-10-28  1170  	mt_validate(mt);
120b116208a087 Liam Howlett    2022-10-28  1171  	MT_BUG_ON(mt, !mt_height(mt));
e15e06a8392321 Liam R. Howlett 2022-09-06  1172  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06  1173  
e15e06a8392321 Liam R. Howlett 2022-09-06  1174  	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
120b116208a087 Liam Howlett    2022-10-28  1175  	for (i = 0; i <= 1300; i++) {
120b116208a087 Liam Howlett    2022-10-28  1176  		val = i*10;
120b116208a087 Liam Howlett    2022-10-28  1177  		val2 = (i+1)*10;
120b116208a087 Liam Howlett    2022-10-28  1178  		check_store_range(mt, val, val2, xa_mk_value(val), 0);
120b116208a087 Liam Howlett    2022-10-28  1179  		MT_BUG_ON(mt, mt_height(mt) >= 4);
120b116208a087 Liam Howlett    2022-10-28  1180  	}
120b116208a087 Liam Howlett    2022-10-28  1181  	/*  Cause a 3 child split all the way up the tree. */
120b116208a087 Liam Howlett    2022-10-28  1182  	for (i = 5; i < 215; i += 10)
120b116208a087 Liam Howlett    2022-10-28  1183  		check_store_range(mt, 11450 + i, 11450 + i + 1, NULL, 0);
120b116208a087 Liam Howlett    2022-10-28  1184  	for (i = 5; i < 65; i += 10)
120b116208a087 Liam Howlett    2022-10-28  1185  		check_store_range(mt, 11770 + i, 11770 + i + 1, NULL, 0);
e15e06a8392321 Liam R. Howlett 2022-09-06  1186  
120b116208a087 Liam Howlett    2022-10-28  1187  	MT_BUG_ON(mt, mt_height(mt) >= 4);
120b116208a087 Liam Howlett    2022-10-28  1188  	for (i = 5; i < 45; i += 10)
120b116208a087 Liam Howlett    2022-10-28  1189  		check_store_range(mt, 11700 + i, 11700 + i + 1, NULL, 0);
120b116208a087 Liam Howlett    2022-10-28  1190  	if (!MAPLE_32BIT)
120b116208a087 Liam Howlett    2022-10-28  1191  		MT_BUG_ON(mt, mt_height(mt) < 4);
e15e06a8392321 Liam R. Howlett 2022-09-06  1192  	mtree_destroy(mt);
e15e06a8392321 Liam R. Howlett 2022-09-06  1193  
e15e06a8392321 Liam R. Howlett 2022-09-06  1194  
e15e06a8392321 Liam R. Howlett 2022-09-06  1195  	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
120b116208a087 Liam Howlett    2022-10-28  1196  	for (i = 0; i <= 1200; i++) {
120b116208a087 Liam Howlett    2022-10-28  1197  		val = i*10;
120b116208a087 Liam Howlett    2022-10-28  1198  		val2 = (i+1)*10;
120b116208a087 Liam Howlett    2022-10-28  1199  		check_store_range(mt, val, val2, xa_mk_value(val), 0);
120b116208a087 Liam Howlett    2022-10-28  1200  		MT_BUG_ON(mt, mt_height(mt) >= 4);
e15e06a8392321 Liam R. Howlett 2022-09-06  1201  	}
120b116208a087 Liam Howlett    2022-10-28  1202  	/* Fill parents and leaves before split. */
120b116208a087 Liam Howlett    2022-10-28  1203  	for (i = 5; i < 455; i += 10)
120b116208a087 Liam Howlett    2022-10-28  1204  		check_store_range(mt, 7800 + i, 7800 + i + 1, NULL, 0);
e15e06a8392321 Liam R. Howlett 2022-09-06  1205  
120b116208a087 Liam Howlett    2022-10-28  1206  	for (i = 1; i < 16; i++)
120b116208a087 Liam Howlett    2022-10-28  1207  		check_store_range(mt, 8185 + i, 8185 + i + 1,
120b116208a087 Liam Howlett    2022-10-28  1208  				  xa_mk_value(8185+i), 0);
120b116208a087 Liam Howlett    2022-10-28  1209  	MT_BUG_ON(mt, mt_height(mt) >= 4);
120b116208a087 Liam Howlett    2022-10-28  1210  	/* triple split across multiple levels. */
120b116208a087 Liam Howlett    2022-10-28  1211  	check_store_range(mt, 8184, 8184, xa_mk_value(8184), 0);
120b116208a087 Liam Howlett    2022-10-28  1212  	if (!MAPLE_32BIT)
120b116208a087 Liam Howlett    2022-10-28  1213  		MT_BUG_ON(mt, mt_height(mt) != 4);
e15e06a8392321 Liam R. Howlett 2022-09-06  1214  }
e15e06a8392321 Liam R. Howlett 2022-09-06  1215  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
