Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3A65B4535
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiIJIQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 04:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIJIQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 04:16:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F996B4AD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662797811; x=1694333811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gq6KFwaxOMjOmP9Vt8dpmGtDhoR0BXE+B8RO7Lff1+M=;
  b=UjtnyX5o7X/204lFY1YtDv5B/3Lx5rqYqOtsAomMS6z3MuV4p5xeX6r3
   mdkCMVERyPsFP9QZqDZNeHJgstfQNZGo54/5GZDSrtKXn2KPRw6fJc6Os
   E7ENnIVDwmypxVyiCDhO1vU3cV2xfV2tlf8vZmzbDTtH6PyMElIU+iMDt
   WyfyUp8coC9es+k2Ws8G3Y9xWG+bTj2SvhexghFrbv0gkuoTQnuzJNY43
   U550jkjCby9ktO3QM0wPd4hU/LLnH1A2zYINZ3wvtuRCPFrI0DJwZIchm
   73vRupAZqkgqr7akVh4Vqf4nEeLsZlyAPyWKGc8AcM5w3d2Bt5nlO5eJ+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298423584"
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="298423584"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 01:16:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="704653004"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Sep 2022 01:16:46 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWvfS-0002It-15;
        Sat, 10 Sep 2022 08:16:46 +0000
Date:   Sat, 10 Sep 2022 16:15:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiebin Sun <jiebin.sun@intel.com>, akpm@linux-foundation.org,
        vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, manfred@colorfullife.com,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com
Subject: Re: [PATCH v5 1/2] percpu: Add percpu_counter_add_local and
 percpu_counter_sub_local
Message-ID: <202209101659.DitbHM0V-lkp@intel.com>
References: <20220909203636.2652466-2-jiebin.sun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909203636.2652466-2-jiebin.sun@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220910/202209101659.DitbHM0V-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/44e7288c01b9b125c7a5f97591ca26ffd90e3385
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jiebin-Sun/percpu-Add-percpu_counter_add_local-and-percpu_counter_sub_local/20220910-053730
        git checkout 44e7288c01b9b125c7a5f97591ca26ffd90e3385
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:10:
   In file included from include/linux/cred.h:17:
   In file included from include/linux/sched/user.h:7:
>> include/linux/percpu_counter.h:176:2: error: implicit declaration of function 'percpu_counter_sub' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           percpu_counter_sub(fbc, amount);
           ^
   include/linux/percpu_counter.h:176:2: note: did you mean 'percpu_counter_set'?
   include/linux/percpu_counter.h:136:20: note: 'percpu_counter_set' declared here
   static inline void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
                      ^
   include/linux/percpu_counter.h:229:20: error: static declaration of 'percpu_counter_sub' follows non-static declaration
   static inline void percpu_counter_sub(struct percpu_counter *fbc, s64 amount)
                      ^
   include/linux/percpu_counter.h:176:2: note: previous implicit declaration is here
           percpu_counter_sub(fbc, amount);
           ^
   2 errors generated.
   make[2]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1206: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/percpu_counter_sub +176 include/linux/percpu_counter.h

   171	
   172	/* no smp percpu_counter_sub_local is the same with percpu_counter_sub */
   173	static inline void
   174	percpu_counter_sub_local(struct percpu_counter *fbc, s64 amount)
   175	{
 > 176		percpu_counter_sub(fbc, amount);
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
