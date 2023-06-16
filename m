Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9D2732687
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbjFPFOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbjFPFON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:14:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2246294A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686892452; x=1718428452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=60Y/MOa0g44t0xXrYYRIs1cTjW37vMSmEyo23JHUw0c=;
  b=UtVsqJIkfaqyR3YkrTQVo/wrAcang6qm5bOfA1xpoed0kqm5rY3a408a
   5+TNZbkDO5DtT5h0JK5sqfZw+T0Fih6DCM/Pbciqg7c8woMQP8EFNpeGW
   ur9UEx2wECuapKrVa3rkOSaLa+EjfKX6DTcX4fyfVhVGjQBPLoTtGvo0S
   qytiLq8okqQBWTx/NMymzsGM0LplV/dgL+eI7Sr4tRAEI4uzS9fjcSLyR
   3r3kBnr6oHgmIQxDDLg7zfT/kMAyFxqXp+k1VWbCdSGuQJCZ0g/gSSGiZ
   Br/BsMTMWcpHb7Dy57Zedc2xANntmUcmH/ZT51+mR1qM6/znPUiAqzt8z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445500529"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="445500529"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 22:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825587165"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="825587165"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 22:14:09 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qA1mi-0000po-1k;
        Fri, 16 Jun 2023 05:14:08 +0000
Date:   Fri, 16 Jun 2023 13:13:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com, ZhangPeng <zhangpeng362@huawei.com>
Subject: Re: [PATCH] mm/memcg: remove return value of mem_cgroup_scan_tasks()
Message-ID: <202306161306.9YKbncNT-lkp@intel.com>
References: <20230616021955.872413-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616021955.872413-1-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Zhang/mm-memcg-remove-return-value-of-mem_cgroup_scan_tasks/20230616-102145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230616021955.872413-1-zhangpeng362%40huawei.com
patch subject: [PATCH] mm/memcg: remove return value of mem_cgroup_scan_tasks()
config: x86_64-randconfig-r005-20230616 (https://download.01.org/0day-ci/archive/20230616/202306161306.9YKbncNT-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch akpm-mm mm-everything
        git checkout akpm-mm/mm-everything
        b4 shazam https://lore.kernel.org/r/20230616021955.872413-1-zhangpeng362@huawei.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306161306.9YKbncNT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
>> include/linux/memcontrol.h:1370:2: error: void function 'mem_cgroup_scan_tasks' should not return a value [-Wreturn-type]
           return 0;
           ^      ~
   1 error generated.
   make[2]: *** [scripts/Makefile.build:114: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=3878817758
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:1287: prepare0] Error 2 shuffle=3878817758
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2 shuffle=3878817758
   make: Target 'prepare' not remade because of errors.


vim +/mem_cgroup_scan_tasks +1370 include/linux/memcontrol.h

5660048ccac873 Johannes Weiner  2012-01-12  1366  
5044a2e0ddbf82 ZhangPeng        2023-06-16  1367  static inline void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
7c5f64f84483bd Vladimir Davydov 2016-10-07  1368  		int (*fn)(struct task_struct *, void *), void *arg)
7c5f64f84483bd Vladimir Davydov 2016-10-07  1369  {
7c5f64f84483bd Vladimir Davydov 2016-10-07 @1370  	return 0;
7c5f64f84483bd Vladimir Davydov 2016-10-07  1371  }
7c5f64f84483bd Vladimir Davydov 2016-10-07  1372  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
