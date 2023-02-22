Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED4069EF01
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 07:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjBVG4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 01:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBVG4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 01:56:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8267D1F4A7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 22:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677048990; x=1708584990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=82jIRTqG/oCoc9diigbGRAEiGCekgnVu2ioPgEIZrMQ=;
  b=JOf2RMIDgekrnl0I4Y9CFqp2KSuiLC54EsXTzyQGEIZIW7KjtZVtSpqX
   phBZA5/UVsftafs0afqnoUhRgfnnwpl0o54T31WucpxpETE6ZldXsMIbL
   DsyhJXhQOG5stphm4ZiVLOuSqiXcS2c86mdfFL1eBQieRumvwzVayvEeS
   m5z9r0vGFnbLh/0ia40SH7W9RJVBtNb544d40/8SukRHFzVDUVgaN0gHT
   /Z6j0k6TElbGD2tD3d/3H0mdvP4ox/bif2PIEvUc6VzokrK/Uw4o1PQp5
   msYtX5qMvVGVwYAPs0Z+n3pQHfnI7Dq9H3brv+mQImwuh0ulV8SOdU0Y/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="331519484"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="331519484"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 22:56:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="735771026"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="735771026"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2023 22:56:00 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUj2l-00005h-2b;
        Wed, 22 Feb 2023 06:55:59 +0000
Date:   Wed, 22 Feb 2023 14:55:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Green <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>, slewis@rivosinc.com,
        vineetg@rivosinc.com, Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 7/7] RISC-V: Add hwprobe vDSO function and data
Message-ID: <202302221419.SOkwfXfm-lkp@intel.com>
References: <20230221190858.3159617-8-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221190858.3159617-8-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes robh/for-next soc/for-next linus/master v6.2]
[cannot apply to next-20230222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230222-031210
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20230221190858.3159617-8-evan%40rivosinc.com
patch subject: [PATCH v3 7/7] RISC-V: Add hwprobe vDSO function and data
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20230222/202302221419.SOkwfXfm-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3f47f3f920ffcb37a461d04a1ee0e245451c869e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230222-031210
        git checkout 3f47f3f920ffcb37a461d04a1ee0e245451c869e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302221419.SOkwfXfm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/vdso/datapage.h:137,
                    from arch/riscv/kernel/vdso/hwprobe.c:7:
   arch/riscv/include/asm/vdso/gettimeofday.h: In function 'gettimeofday_fallback':
>> arch/riscv/include/asm/vdso/gettimeofday.h:21:38: error: '__NR_gettimeofday' undeclared (first use in this function)
      21 |         register long nr asm("a7") = __NR_gettimeofday;
         |                                      ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/vdso/gettimeofday.h:21:38: note: each undeclared identifier is reported only once for each function it appears in
   arch/riscv/include/asm/vdso/gettimeofday.h: In function 'clock_gettime_fallback':
>> arch/riscv/include/asm/vdso/gettimeofday.h:37:38: error: '__NR_clock_gettime' undeclared (first use in this function)
      37 |         register long nr asm("a7") = __NR_clock_gettime;
         |                                      ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/vdso/gettimeofday.h: In function 'clock_getres_fallback':
>> arch/riscv/include/asm/vdso/gettimeofday.h:53:38: error: '__NR_clock_getres' undeclared (first use in this function)
      53 |         register long nr asm("a7") = __NR_clock_getres;
         |                                      ^~~~~~~~~~~~~~~~~
   arch/riscv/kernel/vdso/hwprobe.c: At top level:
   arch/riscv/kernel/vdso/hwprobe.c:14:5: warning: no previous prototype for '__vdso_riscv_hwprobe' [-Wmissing-prototypes]
      14 | int __vdso_riscv_hwprobe(struct riscv_hwprobe *pairs, long pair_count,
         |     ^~~~~~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:252: arch/riscv/kernel/vdso/hwprobe.o] Error 1
   make[2]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
   make[1]: *** [arch/riscv/Makefile:126: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:242: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/__NR_gettimeofday +21 arch/riscv/include/asm/vdso/gettimeofday.h

ad5d1122b82fbd6 Vincent Chen 2020-06-09  13  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  14  static __always_inline
ad5d1122b82fbd6 Vincent Chen 2020-06-09  15  int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
ad5d1122b82fbd6 Vincent Chen 2020-06-09  16  			  struct timezone *_tz)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  17  {
ad5d1122b82fbd6 Vincent Chen 2020-06-09  18  	register struct __kernel_old_timeval *tv asm("a0") = _tv;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  19  	register struct timezone *tz asm("a1") = _tz;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  20  	register long ret asm("a0");
ad5d1122b82fbd6 Vincent Chen 2020-06-09 @21  	register long nr asm("a7") = __NR_gettimeofday;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  22  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  23  	asm volatile ("ecall\n"
ad5d1122b82fbd6 Vincent Chen 2020-06-09  24  		      : "=r" (ret)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  25  		      : "r"(tv), "r"(tz), "r"(nr)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  26  		      : "memory");
ad5d1122b82fbd6 Vincent Chen 2020-06-09  27  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  28  	return ret;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  29  }
ad5d1122b82fbd6 Vincent Chen 2020-06-09  30  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  31  static __always_inline
ad5d1122b82fbd6 Vincent Chen 2020-06-09  32  long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  33  {
ad5d1122b82fbd6 Vincent Chen 2020-06-09  34  	register clockid_t clkid asm("a0") = _clkid;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  35  	register struct __kernel_timespec *ts asm("a1") = _ts;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  36  	register long ret asm("a0");
ad5d1122b82fbd6 Vincent Chen 2020-06-09 @37  	register long nr asm("a7") = __NR_clock_gettime;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  38  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  39  	asm volatile ("ecall\n"
ad5d1122b82fbd6 Vincent Chen 2020-06-09  40  		      : "=r" (ret)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  41  		      : "r"(clkid), "r"(ts), "r"(nr)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  42  		      : "memory");
ad5d1122b82fbd6 Vincent Chen 2020-06-09  43  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  44  	return ret;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  45  }
ad5d1122b82fbd6 Vincent Chen 2020-06-09  46  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  47  static __always_inline
ad5d1122b82fbd6 Vincent Chen 2020-06-09  48  int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  49  {
ad5d1122b82fbd6 Vincent Chen 2020-06-09  50  	register clockid_t clkid asm("a0") = _clkid;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  51  	register struct __kernel_timespec *ts asm("a1") = _ts;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  52  	register long ret asm("a0");
ad5d1122b82fbd6 Vincent Chen 2020-06-09 @53  	register long nr asm("a7") = __NR_clock_getres;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  54  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  55  	asm volatile ("ecall\n"
ad5d1122b82fbd6 Vincent Chen 2020-06-09  56  		      : "=r" (ret)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  57  		      : "r"(clkid), "r"(ts), "r"(nr)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  58  		      : "memory");
ad5d1122b82fbd6 Vincent Chen 2020-06-09  59  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  60  	return ret;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  61  }
ad5d1122b82fbd6 Vincent Chen 2020-06-09  62  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
