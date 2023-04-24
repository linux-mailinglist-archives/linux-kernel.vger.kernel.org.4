Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C506ED850
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjDXXHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDXXHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:07:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA693E6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 16:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682377628; x=1713913628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Kp5hTwPDIWLqjxSDnXZDtxb3NZhqCag3jZVNugCqgo=;
  b=gO+lvt8oRbPDnRO/vJWpoVk6flFbeJSjq3mizBlpqgToNMB8hZl5WWSi
   gfP6crbcSryHbPUZW+QbY8sHcazCBsRa3H40wDRLXBCrzUKblmRUpgnbp
   JAoIaMrK7tSYyU6QPx22haI+jhNCBHtmz0Ba7BGxxsqRah1oIkaBMd2fn
   JgB9VF5MG15GMZba4YwbRG2M75ZMgZ7qqrEfoQT6kE+OwCQxYn5VBcnra
   ovrwszvrEvCcCWnBBQ0ZaNrZFPiCjYcISyeOC2w41sqfVwIo6vbRYuTo7
   ql/pgkjyf+TlQMxue2WMxIEwkEOSoZKKw7AgCNNGFYJLe+TfoyhKd+gdh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="330800955"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="330800955"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 16:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="939515360"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="939515360"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Apr 2023 16:07:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pr5Gx-000iho-0f;
        Mon, 24 Apr 2023 23:07:03 +0000
Date:   Tue, 25 Apr 2023 07:06:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com
Cc:     oe-kbuild-all@lists.linux.dev, heiko@sntech.de,
        kito.cheng@sifive.com, jrtc27@jrtc27.com,
        conor.dooley@microchip.com, matthias.bgg@gmail.com,
        heinrich.schuchardt@canonical.com, greentime.hu@sifive.com,
        nick.knight@sifive.com, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 1/4] RISC-V: create ISA string separately - not as part
 of cpuinfo
Message-ID: <202304250614.g73yVtvv-lkp@intel.com>
References: <20230424194911.264850-2-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424194911.264850-2-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230424]
[also build test WARNING on v6.3]
[cannot apply to soc/for-next linus/master kees/for-next/execve v6.3 v6.3-rc7 v6.3-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Stuebner/RISC-V-create-ISA-string-separately-not-as-part-of-cpuinfo/20230425-035214
base:   next-20230424
patch link:    https://lore.kernel.org/r/20230424194911.264850-2-heiko.stuebner%40vrull.eu
patch subject: [PATCH 1/4] RISC-V: create ISA string separately - not as part of cpuinfo
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20230425/202304250614.g73yVtvv-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8f1a5a16616d673f2c82cdc54ff845fd8b125a21
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Heiko-Stuebner/RISC-V-create-ISA-string-separately-not-as-part-of-cpuinfo/20230425-035214
        git checkout 8f1a5a16616d673f2c82cdc54ff845fd8b125a21
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304250614.g73yVtvv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:254,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/riscv/kernel/cpu.c:6:
   In function 'strnlen',
       inlined from 'strncat' at include/linux/fortify-string.h:404:13,
       inlined from 'riscv_create_isa_string' at arch/riscv/kernel/cpu.c:269:4:
>> include/linux/fortify-string.h:29:33: warning: 'strlen' argument missing terminating nul [-Wstringop-overread]
      29 |                         __ret = __builtin_strlen(__p);          \
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:195:24: note: in expansion of macro '__compiletime_strlen'
     195 |         size_t p_len = __compiletime_strlen(p);
         |                        ^~~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/cpu.c: In function 'riscv_create_isa_string':
   arch/riscv/kernel/cpu.c:245:19: note: referenced argument declared here
     245 | static const char base_riscv_exts[13] = "imafdqcbkjpvh";
         |                   ^~~~~~~~~~~~~~~


vim +/strlen +29 include/linux/fortify-string.h

a28a6e860c6cf2 Francis Laniel 2021-02-25  18  
3009f891bb9f32 Kees Cook      2021-08-02  19  #define __compiletime_strlen(p)					\
3009f891bb9f32 Kees Cook      2021-08-02  20  ({								\
e9a40e1585d792 Kees Cook      2022-10-25  21  	char *__p = (char *)(p);				\
311fb40aa0569a Kees Cook      2022-09-02  22  	size_t __ret = SIZE_MAX;				\
9f7d69c5cd2390 Kees Cook      2022-09-19  23  	size_t __p_size = __member_size(p);			\
311fb40aa0569a Kees Cook      2022-09-02  24  	if (__p_size != SIZE_MAX &&				\
d07c0acb4f41cc Kees Cook      2022-09-02  25  	    __builtin_constant_p(*__p)) {			\
95cadae320be46 Qian Cai       2021-10-25  26  		size_t __p_len = __p_size - 1;			\
95cadae320be46 Qian Cai       2021-10-25  27  		if (__builtin_constant_p(__p[__p_len]) &&	\
95cadae320be46 Qian Cai       2021-10-25  28  		    __p[__p_len] == '\0')			\
95cadae320be46 Qian Cai       2021-10-25 @29  			__ret = __builtin_strlen(__p);		\
3009f891bb9f32 Kees Cook      2021-08-02  30  	}							\
95cadae320be46 Qian Cai       2021-10-25  31  	__ret;							\
3009f891bb9f32 Kees Cook      2021-08-02  32  })
3009f891bb9f32 Kees Cook      2021-08-02  33  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
