Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7AC7294A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241077AbjFIJTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbjFIJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:18:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926DB4EDD;
        Fri,  9 Jun 2023 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686302017; x=1717838017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iABd7J+Z2Pr+pemZcE68eNmTsZ+3OObupdFPLfMdguU=;
  b=JX2fgAmeDc/HTe+07iWeyn7esRqPiYyVf53/gwZe0eDiFN//RWRlwP8X
   Uk/zG9BJVKc1UmhlHGm889OABDmaJnwkoA5mEGT6xjUIbba2J40uDY4EW
   ZbG6WwXBXH/QXfKq/XLDWPpeOpPCq1Kh2NA27I4YrOd22ee7tpI9azqa0
   KvCp164dfA6/lw5p3HIq3hx2AfCdscj8CasY5j4uHJcvxb6fGNv3XGQ2F
   onODotNzTgX7GBqU6TwmCmQTmEgTSMfWEwy4249y5n5Lqq9GFNyR3Gn81
   T66tZ8ff+8xZqIl6kh/6CYtTZPTrdtKqc5wNzhLEbHilnWZt2SNUZUbRX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342231083"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342231083"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:13:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="1040434681"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="1040434681"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2023 02:13:00 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7YB1-0008so-2C;
        Fri, 09 Jun 2023 09:12:59 +0000
Date:   Fri, 9 Jun 2023 17:12:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com, Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] watchdog/mm: Allow dumping memory info in pretimeout
Message-ID: <202306091716.pcrXYphk-lkp@intel.com>
References: <20230608-pretimeout-oom-v1-1-542cc91062d7@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608-pretimeout-oom-v1-1-542cc91062d7@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9561de3a55bed6bdd44a12820ba81ec416e705a7]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Whitchurch/watchdog-mm-Allow-dumping-memory-info-in-pretimeout/20230609-144807
base:   9561de3a55bed6bdd44a12820ba81ec416e705a7
patch link:    https://lore.kernel.org/r/20230608-pretimeout-oom-v1-1-542cc91062d7%40axis.com
patch subject: [PATCH] watchdog/mm: Allow dumping memory info in pretimeout
config: hexagon-buildonly-randconfig-r001-20230608 (https://download.01.org/0day-ci/archive/20230609/202306091716.pcrXYphk-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9561de3a55bed6bdd44a12820ba81ec416e705a7
        b4 shazam https://lore.kernel.org/r/20230608-pretimeout-oom-v1-1-542cc91062d7@axis.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306091716.pcrXYphk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/oom_kill.c:30:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from mm/oom_kill.c:30:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from mm/oom_kill.c:30:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> mm/oom_kill.c:156:21: warning: no previous prototype for function 'find_trylock_task_mm' [-Wmissing-prototypes]
     156 | struct task_struct *find_trylock_task_mm(struct task_struct *p)
         |                     ^
   mm/oom_kill.c:156:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     156 | struct task_struct *find_trylock_task_mm(struct task_struct *p)
         | ^
         | static 
   7 warnings generated.


vim +/find_trylock_task_mm +156 mm/oom_kill.c

   151	
   152	/*
   153	 * Identical to the above, except that we avoid tasks which we can't lock, to
   154	 * avoid deadlocks when called from an interrupt handler.
   155	 */
 > 156	struct task_struct *find_trylock_task_mm(struct task_struct *p)
   157	{
   158		struct task_struct *t;
   159	
   160		rcu_read_lock();
   161	
   162		for_each_thread(p, t) {
   163			if (!task_trylock(t))
   164				continue;
   165			if (likely(t->mm))
   166				goto found;
   167			task_unlock(t);
   168		}
   169		t = NULL;
   170	found:
   171		rcu_read_unlock();
   172	
   173		return t;
   174	}
   175	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
