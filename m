Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5B6AAD0A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 23:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCDW4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 17:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCDW4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 17:56:12 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B69CDBC0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 14:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677970571; x=1709506571;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yGOeu57Run92DBgeExuwVxif9x2vjXc76l3Vnl8JTSg=;
  b=aeWQmnxcs8nh94ZPuQ/8o4lim9zM+FxQ+W/V7Vwl75KU6vkFWiE5qtij
   ikjEavyGhjzOJVBBuOaxltIc1Zvp6EIVWKcZ72hLHYt3KMnhdGVyWoWXn
   n3xF/VXJ+ZwU03bBvE9i9ZyHbV69/TSFvacA7UrLV1AhvJ9LFtwUOTslC
   4U1n8q9xv44k53LO72kdnOm1xboqdBgh8zD5wlVE+ChuZdU+SxXOynddb
   UXZ+IfrXtte/mzmwy4CGmpXzvMCGm60tU4/YxziIClJDgb/Qdkfp3xyy3
   VZ07HuJOfA5uGMvKWyBwqts9Zr718oQ9cH42IfbzPjdyNrWLMx8Jhtun2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="323623231"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="323623231"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 14:56:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="625729470"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="625729470"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Mar 2023 14:56:08 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYanQ-0002PI-0a;
        Sat, 04 Mar 2023 22:56:08 +0000
Date:   Sun, 5 Mar 2023 06:56:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: drivers/clocksource/timer-clint.c:82:24: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202303050655.acu5xXOh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aurelien,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c29214bc89169f735657f614bde7c0fad74bd1b5
commit: 6df2a016c0c8a3d0933ef33dd192ea6606b115e3 riscv: fix build with binutils 2.38
date:   1 year, 1 month ago
config: riscv-randconfig-s033-20230305 (https://download.01.org/0day-ci/archive/20230305/202303050655.acu5xXOh-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6df2a016c0c8a3d0933ef33dd192ea6606b115e3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6df2a016c0c8a3d0933ef33dd192ea6606b115e3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303050655.acu5xXOh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/clocksource/timer-clint.c:82:24: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/clocksource/timer-clint.c:82:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/clocksource/timer-clint.c:82:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/clocksource/timer-clint.c:82:24: sparse:     got unsigned int [usertype] *
   drivers/clocksource/timer-clint.c:80:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/clocksource/timer-clint.c:80:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/clocksource/timer-clint.c:80:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/clocksource/timer-clint.c:80:22: sparse:     got unsigned int [usertype] *
   drivers/clocksource/timer-clint.c:237:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void * @@     got struct clock_event_device [noderef] __percpu * @@
   drivers/clocksource/timer-clint.c:237:36: sparse:     expected void *
   drivers/clocksource/timer-clint.c:237:36: sparse:     got struct clock_event_device [noderef] __percpu *

vim +/__iomem +82 drivers/clocksource/timer-clint.c

2ac6795fcc085e Anup Patel 2020-08-17  68  
2ac6795fcc085e Anup Patel 2020-08-17  69  #ifdef CONFIG_64BIT
2ac6795fcc085e Anup Patel 2020-08-17  70  static u64 notrace clint_get_cycles64(void)
2ac6795fcc085e Anup Patel 2020-08-17  71  {
2ac6795fcc085e Anup Patel 2020-08-17  72  	return clint_get_cycles();
2ac6795fcc085e Anup Patel 2020-08-17  73  }
2ac6795fcc085e Anup Patel 2020-08-17  74  #else /* CONFIG_64BIT */
2ac6795fcc085e Anup Patel 2020-08-17  75  static u64 notrace clint_get_cycles64(void)
2ac6795fcc085e Anup Patel 2020-08-17  76  {
2ac6795fcc085e Anup Patel 2020-08-17  77  	u32 hi, lo;
2ac6795fcc085e Anup Patel 2020-08-17  78  
2ac6795fcc085e Anup Patel 2020-08-17  79  	do {
2ac6795fcc085e Anup Patel 2020-08-17  80  		hi = clint_get_cycles_hi();
2ac6795fcc085e Anup Patel 2020-08-17  81  		lo = clint_get_cycles();
2ac6795fcc085e Anup Patel 2020-08-17 @82  	} while (hi != clint_get_cycles_hi());
2ac6795fcc085e Anup Patel 2020-08-17  83  
2ac6795fcc085e Anup Patel 2020-08-17  84  	return ((u64)hi << 32) | lo;
2ac6795fcc085e Anup Patel 2020-08-17  85  }
2ac6795fcc085e Anup Patel 2020-08-17  86  #endif /* CONFIG_64BIT */
2ac6795fcc085e Anup Patel 2020-08-17  87  

:::::: The code at line 82 was first introduced by commit
:::::: 2ac6795fcc085e8d03649f1bbd0d70aaff612cad clocksource/drivers: Add CLINT timer driver

:::::: TO: Anup Patel <anup.patel@wdc.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
