Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41B45B43A6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 03:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIJBh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 21:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiIJBh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 21:37:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CA77B7BE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 18:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662773845; x=1694309845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HM4gATmp1s6shVM9+XdfzJPDKTDVkoUU2CxEiQTnkSE=;
  b=nxdo1M6oVXTWuSPSJl5GnCz8jZCeSvU3C21YraoXUgf9ThMwx6sjkmbc
   3M6SRsy05h4AohOTpKXutaJsCGHoJMadPCKJL7Jt6hc1e9fGX925vxo1Q
   5iViBVH2I3kmp7StTAkClNGXjOrmzHebDjeo6TqEKaMkKJzSXQixxJVR1
   0XvL+dgALUzeGJn5czy991TAMfmsujNSxSMukXj6k642a45HUCkGJeN8e
   MX8lrkUzYmLBcv8LcsfNui7FJCvvvzNPAimwofav8VjvhuOfLXbYTtGJj
   vBQ8E30yRNro7cHH+WwBiyttB1gzabbDagRXppryndJ0mBQKHwYFuo/5y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="277996655"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="277996655"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 18:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="860593642"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 09 Sep 2022 18:37:21 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWpQu-0001y3-2j;
        Sat, 10 Sep 2022 01:37:20 +0000
Date:   Sat, 10 Sep 2022 09:37:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiebin Sun <jiebin.sun@intel.com>, akpm@linux-foundation.org,
        vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, manfred@colorfullife.com,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, tim.c.chen@intel.com, feng.tang@intel.com,
        ying.huang@intel.com, tianyou.li@intel.com, wangyang.guo@intel.com,
        jiebin.sun@intel.com
Subject: Re: [PATCH v5 1/2] percpu: Add percpu_counter_add_local and
 percpu_counter_sub_local
Message-ID: <202209100911.HBo9ZqIU-lkp@intel.com>
References: <20220909203636.2652466-2-jiebin.sun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909203636.2652466-2-jiebin.sun@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiebin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.0-rc4 next-20220909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiebin-Sun/percpu-Add-percpu_counter_add_local-and-percpu_counter_sub_local/20220910-053730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220910/202209100911.HBo9ZqIU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/44e7288c01b9b125c7a5f97591ca26ffd90e3385
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jiebin-Sun/percpu-Add-percpu_counter_add_local-and-percpu_counter_sub_local/20220910-053730
        git checkout 44e7288c01b9b125c7a5f97591ca26ffd90e3385
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/sched/user.h:7,
                    from include/linux/cred.h:17,
                    from include/linux/sched/signal.h:10,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/cgroup.h:17,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   include/linux/percpu_counter.h: In function 'percpu_counter_sub_local':
>> include/linux/percpu_counter.h:176:9: error: implicit declaration of function 'percpu_counter_sub'; did you mean 'percpu_counter_set'? [-Werror=implicit-function-declaration]
     176 |         percpu_counter_sub(fbc, amount);
         |         ^~~~~~~~~~~~~~~~~~
         |         percpu_counter_set
   include/linux/percpu_counter.h: At top level:
>> include/linux/percpu_counter.h:229:20: warning: conflicting types for 'percpu_counter_sub'; have 'void(struct percpu_counter *, s64)' {aka 'void(struct percpu_counter *, long long int)'}
     229 | static inline void percpu_counter_sub(struct percpu_counter *fbc, s64 amount)
         |                    ^~~~~~~~~~~~~~~~~~
>> include/linux/percpu_counter.h:229:20: error: static declaration of 'percpu_counter_sub' follows non-static declaration
   include/linux/percpu_counter.h:176:9: note: previous implicit declaration of 'percpu_counter_sub' with type 'void(struct percpu_counter *, s64)' {aka 'void(struct percpu_counter *, long long int)'}
     176 |         percpu_counter_sub(fbc, amount);
         |         ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1206: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +176 include/linux/percpu_counter.h

   171	
   172	/* no smp percpu_counter_sub_local is the same with percpu_counter_sub */
   173	static inline void
   174	percpu_counter_sub_local(struct percpu_counter *fbc, s64 amount)
   175	{
 > 176		percpu_counter_sub(fbc, amount);
   177	}
   178	
   179	static inline void
   180	percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
   181	{
   182		percpu_counter_add(fbc, amount);
   183	}
   184	
   185	static inline s64 percpu_counter_read(struct percpu_counter *fbc)
   186	{
   187		return fbc->count;
   188	}
   189	
   190	/*
   191	 * percpu_counter is intended to track positive numbers. In the UP case the
   192	 * number should never be negative.
   193	 */
   194	static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
   195	{
   196		return fbc->count;
   197	}
   198	
   199	static inline s64 percpu_counter_sum_positive(struct percpu_counter *fbc)
   200	{
   201		return percpu_counter_read_positive(fbc);
   202	}
   203	
   204	static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
   205	{
   206		return percpu_counter_read(fbc);
   207	}
   208	
   209	static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
   210	{
   211		return true;
   212	}
   213	
   214	static inline void percpu_counter_sync(struct percpu_counter *fbc)
   215	{
   216	}
   217	#endif	/* CONFIG_SMP */
   218	
   219	static inline void percpu_counter_inc(struct percpu_counter *fbc)
   220	{
   221		percpu_counter_add(fbc, 1);
   222	}
   223	
   224	static inline void percpu_counter_dec(struct percpu_counter *fbc)
   225	{
   226		percpu_counter_add(fbc, -1);
   227	}
   228	
 > 229	static inline void percpu_counter_sub(struct percpu_counter *fbc, s64 amount)
   230	{
   231		percpu_counter_add(fbc, -amount);
   232	}
   233	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
