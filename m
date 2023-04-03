Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DB36D42F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjDCLGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjDCLGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:06:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFD74EDE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680519998; x=1712055998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CqkvZ0UozjqPbCvZ0FQQl+3N0cFqmjk9EOtoxPrpbQs=;
  b=JDzzaTvP27fVuebAtb4oyKOpbe9t9uSeCtCM1egQRWw2Kv0+iJR6EnKd
   YdAJytxGUZ6aF6wXtWyr0VmB6KnN7VgEYx1Ouh7VsIs1G+epJzyrIrUlz
   7+5tD05NzGwNBD7nMCF2wbMLF8Q8ffVz2FGToOHrewah+dDmyFrWk4jKL
   UjYwRgfiHMFLSDoUuxDpuesFJh+p6r4q5lH9NHWU//Ukj3RpNOB/0t3YV
   y1esDUmpFt6boDXeJpHHQIosUfvcQq75SK0XgaMuBCR3ej3FMbxAfSiST
   NrdZvlnF+Hpiu9fjc5FQqhAlc0SIn04R6s51dAHGuIQKxyXEpmTkkrjHy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="428155430"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="428155430"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 04:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="931980969"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="931980969"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Apr 2023 04:06:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjI0g-000ODd-0X;
        Mon, 03 Apr 2023 11:06:02 +0000
Date:   Mon, 3 Apr 2023 19:05:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org, chao@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH v4] f2fs: support FAULT_LOCK type fault injection
Message-ID: <202304031801.hGbHuuBP-lkp@intel.com>
References: <20230403031723.43870-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403031723.43870-1-frank.li@vivo.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

I love your patch! Yet something to improve:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on jaegeuk-f2fs/dev linus/master v6.3-rc5 next-20230331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yangtao-Li/f2fs-support-FAULT_LOCK-type-fault-injection/20230403-111853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20230403031723.43870-1-frank.li%40vivo.com
patch subject: [PATCH v4] f2fs: support FAULT_LOCK type fault injection
config: i386-randconfig-a006-20230403 (https://download.01.org/0day-ci/archive/20230403/202304031801.hGbHuuBP-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7a551520921cdc8921f448714472af3014da4f50
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yangtao-Li/f2fs-support-FAULT_LOCK-type-fault-injection/20230403-111853
        git checkout 7a551520921cdc8921f448714472af3014da4f50
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304031801.hGbHuuBP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/f2fs/dir.c:13:
>> fs/f2fs/f2fs.h:2174:60: error: incompatible pointer types passing 'struct rw_semaphore *' to parameter of type 'struct f2fs_rwsem *' [-Werror,-Wincompatible-pointer-types]
           wait_event(sem->read_waiters, f2fs_down_read_trylock(sbi, &sem->internal_rwsem));
                                                                     ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:343:6: note: expanded from macro 'wait_event'
           if (condition)                                                          \
               ^~~~~~~~~
   fs/f2fs/f2fs.h:2164:25: note: passing argument to parameter 'sem' here
                                           struct f2fs_rwsem *sem)
                                                              ^
>> fs/f2fs/f2fs.h:2174:60: error: incompatible pointer types passing 'struct rw_semaphore *' to parameter of type 'struct f2fs_rwsem *' [-Werror,-Wincompatible-pointer-types]
           wait_event(sem->read_waiters, f2fs_down_read_trylock(sbi, &sem->internal_rwsem));
                                                                     ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:345:24: note: expanded from macro 'wait_event'
           __wait_event(wq_head, condition);                                       \
                                 ^~~~~~~~~
   include/linux/wait.h:325:31: note: expanded from macro '__wait_event'
           (void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 0,     \
                                        ^~~~~~~~~
   include/linux/wait.h:310:7: note: expanded from macro '___wait_event'
                   if (condition)                                                  \
                       ^~~~~~~~~
   fs/f2fs/f2fs.h:2164:25: note: passing argument to parameter 'sem' here
                                           struct f2fs_rwsem *sem)
                                                              ^
   2 errors generated.


vim +2174 fs/f2fs/f2fs.h

  2170	
  2171	static inline void f2fs_down_read(struct f2fs_sb_info *sbi, struct f2fs_rwsem *sem)
  2172	{
  2173	#ifdef CONFIG_F2FS_UNFAIR_RWSEM
> 2174		wait_event(sem->read_waiters, f2fs_down_read_trylock(sbi, &sem->internal_rwsem));
  2175	#else
  2176		down_read(&sem->internal_rwsem);
  2177	#endif
  2178	}
  2179	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
