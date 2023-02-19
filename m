Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2922569BFDA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjBSJr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjBSJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:47:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322A1258C;
        Sun, 19 Feb 2023 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676800042; x=1708336042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Po41OJZzQp1hc4fE+blyk6iThi8FGKEllh22Ry2nYos=;
  b=WWOpXqvYAfWpWkZVo84FkSOiRdKjvV71bhucDjaqSL7+T6TnEzYtJWbi
   911i/xcqMzfU0NKUuSu5qQDGVFDrnthITk4PXdDvPYQRQhjz0RaLUrtJF
   6jrBvpuJRDNGRj/4Yf3BO+/56K9nPq8uHWTGy/lX4yoBHGNkGcJhd35+g
   7ptcZ7HtS3oKS2y55EouPLKnHvUvpDCY9gt8zkrIJzJA0654BMAmq6Sfl
   +E+2Bcuvd93f8p+DZIeu+Lg/H3jou2VumH0VnUMIovJ1StWVdZuaSi1Vy
   CvICxWRYK9/TxkipnjRx6ojaVVy3nSpU3VEB5Sl2sT3J1h5kAPvr7CwF1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="311867291"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="311867291"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 01:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="759872249"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="759872249"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Feb 2023 01:45:34 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTgGD-000DEh-14;
        Sun, 19 Feb 2023 09:45:33 +0000
Date:   Sun, 19 Feb 2023 17:45:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bfoster@redhat.com, willy@infradead.org, arnd@arndb.de,
        linux-api@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v10 2/3] cachestat: implement cachestat syscall
Message-ID: <202302191700.Pg6Yy5Xp-lkp@intel.com>
References: <20230219073318.366189-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219073318.366189-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 1440f576022887004f719883acb094e7e0dd4944]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230219-153500
base:   1440f576022887004f719883acb094e7e0dd4944
patch link:    https://lore.kernel.org/r/20230219073318.366189-3-nphamcs%40gmail.com
patch subject: [PATCH v10 2/3] cachestat: implement cachestat syscall
config: riscv-buildonly-randconfig-r005-20230219 (https://download.01.org/0day-ci/archive/20230219/202302191700.Pg6Yy5Xp-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d691a3b4a696ab20c9c5fe86c624e9e36814523c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230219-153500
        git checkout d691a3b4a696ab20c9c5fe86c624e9e36814523c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302191700.Pg6Yy5Xp-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/filemap.c:4035:6: warning: no previous prototype for 'ksys_cachestat' [-Wmissing-prototypes]
    4035 | long ksys_cachestat(unsigned int fd, size_t len, loff_t off,
         |      ^~~~~~~~~~~~~~
   In file included from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/blk_types.h:11,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from mm/filemap.c:23:
>> include/linux/compat.h:75:25: error: conflicting types for 'compat_sys_cachestat'; have 'long int(unsigned int,  size_t,  u32,  u32,  struct cachestat *, unsigned int)' {aka 'long int(unsigned int,  long unsigned int,  unsigned int,  unsigned int,  struct cachestat *, unsigned int)'}
      75 |         asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))        \
         |                         ^~~~~~~~~~
   include/linux/compat.h:63:9: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
      63 |         COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   mm/filemap.c:4102:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    4102 | COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, size_t, len,
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:820:17: note: previous declaration of 'compat_sys_cachestat' with type 'long int(int,  size_t,  u32,  u32,  struct cachestat *, unsigned int)' {aka 'long int(int,  long unsigned int,  unsigned int,  unsigned int,  struct cachestat *, unsigned int)'}
     820 | asmlinkage long compat_sys_cachestat(int fd, size_t len, compat_arg_u64(off),
         |                 ^~~~~~~~~~~~~~~~~~~~


vim +75 include/linux/compat.h

217f4433fc2fe7 Heiko Carstens    2014-02-26  51  
468366138850f2 Al Viro           2012-11-23  52  #define COMPAT_SYSCALL_DEFINE1(name, ...) \
468366138850f2 Al Viro           2012-11-23  53          COMPAT_SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  54  #define COMPAT_SYSCALL_DEFINE2(name, ...) \
468366138850f2 Al Viro           2012-11-23  55  	COMPAT_SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  56  #define COMPAT_SYSCALL_DEFINE3(name, ...) \
468366138850f2 Al Viro           2012-11-23  57  	COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  58  #define COMPAT_SYSCALL_DEFINE4(name, ...) \
468366138850f2 Al Viro           2012-11-23  59  	COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  60  #define COMPAT_SYSCALL_DEFINE5(name, ...) \
468366138850f2 Al Viro           2012-11-23  61  	COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  62  #define COMPAT_SYSCALL_DEFINE6(name, ...) \
468366138850f2 Al Viro           2012-11-23  63  	COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  64  
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  65  /*
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  66   * The asmlinkage stub is aliased to a function named __se_compat_sys_*() which
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  67   * sign-extends 32-bit ints to longs whenever needed. The actual work is
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  68   * done within __do_compat_sys_*().
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  69   */
7303e30ec1d8fb Dominik Brodowski 2018-04-05  70  #ifndef COMPAT_SYSCALL_DEFINEx
468366138850f2 Al Viro           2012-11-23  71  #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
bee20031772af3 Arnd Bergmann     2018-06-19  72  	__diag_push();								\
bee20031772af3 Arnd Bergmann     2018-06-19  73  	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
bee20031772af3 Arnd Bergmann     2018-06-19  74  		      "Type aliasing is used to sanitize syscall arguments");\
83460ec8dcac14 Andi Kleen        2013-11-12 @75  	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  76  		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
c9a211951c7c79 Howard McLauchlan 2018-03-21  77  	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  78  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  79  	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  80  	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
468366138850f2 Al Viro           2012-11-23  81  	{									\
bee20031772af3 Arnd Bergmann     2018-06-19  82  		long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
bee20031772af3 Arnd Bergmann     2018-06-19  83  		__MAP(x,__SC_TEST,__VA_ARGS__);					\
bee20031772af3 Arnd Bergmann     2018-06-19  84  		return ret;							\
468366138850f2 Al Viro           2012-11-23  85  	}									\
bee20031772af3 Arnd Bergmann     2018-06-19  86  	__diag_pop();								\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  87  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
7303e30ec1d8fb Dominik Brodowski 2018-04-05  88  #endif /* COMPAT_SYSCALL_DEFINEx */
468366138850f2 Al Viro           2012-11-23  89  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
