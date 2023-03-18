Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6166BF718
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 01:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCRA6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 20:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRA6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:58:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230D63CE23;
        Fri, 17 Mar 2023 17:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679101111; x=1710637111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kTtpQOSz4D9Z4x23243KvoMRT8zk4k5AM2MlBBfU7E4=;
  b=ZvjpDgjNJDdcW2dbwU7KVPjhwAxVJ53uI/WPfmus/1KkkkIIyLApDsEd
   o7+DXx2VeXiQ0wwTNR7nnoAs7m7FxInsZYfsU9BmMrns+tXkQcr1eRa6o
   nL4O/T5S6Yuc5cR/1nV7qL+oYR/T6qM4KLM6mRj4qTDKk6OnKaqHGULhL
   k0HjHzDuuLct4lym8vpe+ORxHCctbdU4qXy0mvbmfqzZ0EDC9RZvE9vcm
   dOINrUK9KvcX72DJE68Cz+kZicdpHC1X+NKAAlGl3Lbk3PaIJ4BhI5MLY
   0EXbkGtb5CjjDgoM8cxSLTEjAgHIQzyuOfn4KmPpUmh5czUATLE1wLnTg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="403264661"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="403264661"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 17:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="854652652"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="854652652"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2023 17:58:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdKtu-0009h8-0x;
        Sat, 18 Mar 2023 00:58:26 +0000
Date:   Sat, 18 Mar 2023 08:57:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v3] irqchip/gicv3: Workaround for NVIDIA erratum
 T241-FABRIC-4
Message-ID: <202303180807.8bgU13CU-lkp@intel.com>
References: <20230317162636.851085-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317162636.851085-1-sdonthineni@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shanker,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on arm64/for-next/core soc/for-next linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shanker-Donthineni/irqchip-gicv3-Workaround-for-NVIDIA-erratum-T241-FABRIC-4/20230318-003214
patch link:    https://lore.kernel.org/r/20230317162636.851085-1-sdonthineni%40nvidia.com
patch subject: [PATCH v3] irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230318/202303180807.8bgU13CU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/27a88c95568fc0cfe4537989de4d5e28fe4174c9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shanker-Donthineni/irqchip-gicv3-Workaround-for-NVIDIA-erratum-T241-FABRIC-4/20230318-003214
        git checkout 27a88c95568fc0cfe4537989de4d5e28fe4174c9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303180807.8bgU13CU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bits.h:6,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/irqchip/irq-gic-v3.c:9:
   drivers/irqchip/irq-gic-v3.c: In function 'gic_enable_quirk_nvidia_t241':
>> include/linux/compiler_types.h:358:45: error: call to '__compiletime_assert_251' declared with attribute error: FIELD_GET: type of reg too small for mask
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/vdso/bits.h:7:44: note: in definition of macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                            ^~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '__compiletime_assert'
     346 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:358:9: note: in expansion of macro '_compiletime_assert'
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/irqchip/irq-gic-v3.c:1781:35: note: in expansion of macro 'FIELD_GET'
    1781 |                 chip_bmask |= BIT(FIELD_GET(T241_CHIPN_MASK,
         |                                   ^~~~~~~~~


vim +/__compiletime_assert_251 +358 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  354   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  355   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  356   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  357  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @358  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  359  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
