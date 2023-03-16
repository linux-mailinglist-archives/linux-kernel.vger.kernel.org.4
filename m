Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670566BCF98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCPMgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCPMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:36:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E83A42E7;
        Thu, 16 Mar 2023 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678970197; x=1710506197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0VNdeGsSmFwWcpyMxSZKKLNkZhIZ+u3xoeNhoZCNaOc=;
  b=OPZst0rBltULR9SsBMKs+/q+9sKjbm1GpyweZs0GtyXdJskO8BRalchH
   ODr3uJcCQO4ffV2vXEfEJBO9Ev49B9lKFVNOCQRC32KlvK78tfobQ/Zk6
   gtxGVQic4s+k4ihSUNKLR1ic1FKeRmHJI2E3XQcKD0xV0yx7ovFVuAgrm
   nvZvHe+IWaI3bh+O4V45YXCn43l+JJydW8pRd367Tzys1wzuAti53uUM7
   ujYfEPuQXyTBH50QAkXHG8cB3dJ8KlE8biebI48llOSJHoVRk9JGN8TBx
   5jMhLbcwTRioAxqW4g1ll6sHx3oD3f20P3+bPjIq348IS5azWticzsaI7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10650"; a="321810657"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321810657"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 05:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10650"; a="925761028"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="925761028"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2023 05:36:30 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcmqL-0008W6-1e;
        Thu, 16 Mar 2023 12:36:29 +0000
Date:   Thu, 16 Mar 2023 20:35:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v7 04/11] LSM: syscalls for current process attributes
Message-ID: <202303162018.FY1iL9wN-lkp@intel.com>
References: <20230315224704.2672-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315224704.2672-5-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes linus/master v6.3-rc2]
[cannot apply to tip/perf/core acme/perf/core next-20230316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230316-074751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20230315224704.2672-5-casey%40schaufler-ca.com
patch subject: [PATCH v7 04/11] LSM: syscalls for current process attributes
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230316/202303162018.FY1iL9wN-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0883a93af669a6fcb80a9cc74737d5285a1c46ae
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230316-074751
        git checkout 0883a93af669a6fcb80a9cc74737d5285a1c46ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303162018.FY1iL9wN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from security/lsm_syscalls.c:15:
>> include/linux/syscalls.h:243:25: error: conflicting types for 'sys_lsm_set_self_attr'; have 'long int(unsigned int,  struct lsm_ctx *, size_t,  u32)' {aka 'long int(unsigned int,  struct lsm_ctx *, unsigned int,  unsigned int)'}
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   security/lsm_syscalls.c:31:1: note: in expansion of macro 'SYSCALL_DEFINE4'
      31 | SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:1064:17: note: previous declaration of 'sys_lsm_set_self_attr' with type 'long int(unsigned int,  struct lsm_ctx *, __u64)' {aka 'long int(unsigned int,  struct lsm_ctx *, long long unsigned int)'}
    1064 | asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
         |                 ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/syscalls.h:243:25: error: conflicting types for 'sys_lsm_get_self_attr'; have 'long int(unsigned int,  struct lsm_ctx *, size_t *, u32)' {aka 'long int(unsigned int,  struct lsm_ctx *, unsigned int *, unsigned int)'}
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   security/lsm_syscalls.c:51:1: note: in expansion of macro 'SYSCALL_DEFINE4'
      51 | SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:1062:17: note: previous declaration of 'sys_lsm_get_self_attr' with type 'long int(unsigned int,  struct lsm_ctx *, size_t *, __u64)' {aka 'long int(unsigned int,  struct lsm_ctx *, unsigned int *, long long unsigned int)'}
    1062 | asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
         |                 ^~~~~~~~~~~~~~~~~~~~~


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
