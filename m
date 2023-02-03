Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4868A5DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjBCWNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjBCWNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:13:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76019AFA6B;
        Fri,  3 Feb 2023 14:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675462310; x=1706998310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hom4GIrptmIDrAk4aCCEtfreqZz3x5TgaqoTyzZJ1JI=;
  b=Bknz3Cf5dNuOasImKSxazIvjajaaL+IYUI/aAy1Vz7Zl5JL+7WSRsUCj
   VX2DON8hgaqDip9XMUvo4FbsAgLoRQu0uPvnRFaxX6CLEPbgFV4cLRmEI
   sprkUEbn9feZklCDcSGflRniACrlqkZw2K3fBbPWphZn4pZcNvtjlzzzS
   6EneTMAZXrKCZdBLwzZvi8Eqww46SmNtQaHadW7fCsRPqETY7uA7OuWnw
   aKLx7XMbidhc9juo4tuMWxTlvBmCwFhDHFltUdDR3Gr2kxBYOx9ikTInO
   +Y1IYtArBpTgbVtNRbEU6X69EPNnWc/Jd9jijBtHy69Hx9ypKPmD6QPzk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="308510001"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="308510001"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 14:11:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="643402336"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="643402336"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2023 14:11:19 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pO4H8-0000nX-1S;
        Fri, 03 Feb 2023 22:11:18 +0000
Date:   Sat, 4 Feb 2023 06:10:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bfoster@redhat.com, willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v9 2/3] cachestat: implement cachestat syscall
Message-ID: <202302040606.Q2Z9z4KL-lkp@intel.com>
References: <20230203190413.2559707-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203190413.2559707-3-nphamcs@gmail.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230204-030455
base:   1440f576022887004f719883acb094e7e0dd4944
patch link:    https://lore.kernel.org/r/20230203190413.2559707-3-nphamcs%40gmail.com
patch subject: [PATCH v9 2/3] cachestat: implement cachestat syscall
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20230204/202302040606.Q2Z9z4KL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/49a57ed71ac2c005231660c85c3f30c4b47d8b7b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230204-030455
        git checkout 49a57ed71ac2c005231660c85c3f30c4b47d8b7b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/filemap.c:4035:6: warning: no previous prototype for 'ksys_cachestat' [-Wmissing-prototypes]
    4035 | long ksys_cachestat(unsigned int fd, loff_t off, size_t len,
         |      ^~~~~~~~~~~~~~
   In file included from mm/filemap.c:25:
>> include/linux/syscalls.h:243:25: error: conflicting types for 'sys_cachestat'; have 'long int(unsigned int,  loff_t,  size_t,  struct cachestat *, unsigned int)' {aka 'long int(unsigned int,  long long int,  unsigned int,  struct cachestat *, unsigned int)'}
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     222 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   mm/filemap.c:4095:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    4095 | SYSCALL_DEFINE5(cachestat, unsigned int, fd, loff_t, off, size_t, len,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:1060:17: note: previous declaration of 'sys_cachestat' with type 'long int(unsigned int,  long unsigned int,  long unsigned int,  size_t,  struct cachestat *, unsigned int)' {aka 'long int(unsigned int,  long unsigned int,  long unsigned int,  unsigned int,  struct cachestat *, unsigned int)'}
    1060 | asmlinkage long sys_cachestat(unsigned int fd, unsigned long off_low,
         |                 ^~~~~~~~~~~~~


vim +243 include/linux/syscalls.h

1bd21c6c21e848 Dominik Brodowski   2018-04-05  232  
e145242ea0df6b Dominik Brodowski   2018-04-09  233  /*
e145242ea0df6b Dominik Brodowski   2018-04-09  234   * The asmlinkage stub is aliased to a function named __se_sys_*() which
e145242ea0df6b Dominik Brodowski   2018-04-09  235   * sign-extends 32-bit ints to longs whenever needed. The actual work is
e145242ea0df6b Dominik Brodowski   2018-04-09  236   * done within __do_sys_*().
e145242ea0df6b Dominik Brodowski   2018-04-09  237   */
1bd21c6c21e848 Dominik Brodowski   2018-04-05  238  #ifndef __SYSCALL_DEFINEx
bed1ffca022cc8 Frederic Weisbecker 2009-03-13  239  #define __SYSCALL_DEFINEx(x, name, ...)					\
bee20031772af3 Arnd Bergmann       2018-06-19  240  	__diag_push();							\
bee20031772af3 Arnd Bergmann       2018-06-19  241  	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
bee20031772af3 Arnd Bergmann       2018-06-19  242  		      "Type aliasing is used to sanitize syscall arguments");\
83460ec8dcac14 Andi Kleen          2013-11-12 @243  	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
e145242ea0df6b Dominik Brodowski   2018-04-09  244  		__attribute__((alias(__stringify(__se_sys##name))));	\
c9a211951c7c79 Howard McLauchlan   2018-03-21  245  	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
e145242ea0df6b Dominik Brodowski   2018-04-09  246  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
e145242ea0df6b Dominik Brodowski   2018-04-09  247  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
e145242ea0df6b Dominik Brodowski   2018-04-09  248  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
1a94bc34768e46 Heiko Carstens      2009-01-14  249  	{								\
e145242ea0df6b Dominik Brodowski   2018-04-09  250  		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
07fe6e00f6cca6 Al Viro             2013-01-21  251  		__MAP(x,__SC_TEST,__VA_ARGS__);				\
2cf0966683430b Al Viro             2013-01-21  252  		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
2cf0966683430b Al Viro             2013-01-21  253  		return ret;						\
1a94bc34768e46 Heiko Carstens      2009-01-14  254  	}								\
bee20031772af3 Arnd Bergmann       2018-06-19  255  	__diag_pop();							\
e145242ea0df6b Dominik Brodowski   2018-04-09  256  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
1bd21c6c21e848 Dominik Brodowski   2018-04-05  257  #endif /* __SYSCALL_DEFINEx */
1a94bc34768e46 Heiko Carstens      2009-01-14  258  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
