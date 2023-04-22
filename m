Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354E56EB643
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 02:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjDVALv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 20:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjDVALr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 20:11:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927582717
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122303; x=1713658303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+id0SKURZQTqnIN1PkOKngvU/Tc+6miOnK4qEArTJ9E=;
  b=LQtCYk8uTr8/HUhr+9IDrFMPx/9MQJVBoXvGNyRGtJoxVWfkfRhSbgEh
   /lMpgAN0IRA1/2mBvSRVfzpW31vh/nEec4PaOWSZTXLKv9lNtB5tJ3gZs
   x2eHWAoSyLKgFqRI82amziSay1YNQ/9alN73bn0TL3e713sxPEdP+vIlE
   R4umaPLXPXCXOVudQNTAbknfPPe1bBro61M6NPxYY4bR96jsFBCaS7dEF
   ZHTKlptzI9o6UiMQRaBTell4cRX5+2CIj+IkOWRGT5KO3ozwWv35AlSwb
   rwNuk1X+b3EpRV4noodZCLd3ciJ/2euQbHAWQqs2ZcPoyNSsKWYgqEucP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348020632"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348020632"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="642689892"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="642689892"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2023 17:11:28 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pq0qd-000gwm-2i;
        Sat, 22 Apr 2023 00:11:27 +0000
Date:   Sat, 22 Apr 2023 08:11:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v4 2/3] mm, page_owner: Add page_owner_stacks file to
 print out only stacks and their counte
Message-ID: <202304220715.syaqgRUa-lkp@intel.com>
References: <20230421101415.5734-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421101415.5734-3-osalvador@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc7]
[cannot apply to akpm-mm/mm-everything next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/lib-stackdepot-Add-a-refcount-field-in-stack_record/20230421-181709
base:   linus/master
patch link:    https://lore.kernel.org/r/20230421101415.5734-3-osalvador%40suse.de
patch subject: [PATCH v4 2/3] mm, page_owner: Add page_owner_stacks file to print out only stacks and their counte
config: powerpc-randconfig-r026-20230421 (https://download.01.org/0day-ci/archive/20230422/202304220715.syaqgRUa-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/6c6dfc43015e1939f433f4371d33418ab4d03411
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Oscar-Salvador/lib-stackdepot-Add-a-refcount-field-in-stack_record/20230421-181709
        git checkout 6c6dfc43015e1939f433f4371d33418ab4d03411
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/ kernel/dma/ lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304220715.syaqgRUa-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from lib/show_mem.c:8:
   In file included from include/linux/mm.h:22:
   In file included from include/linux/page_ext.h:7:
>> include/linux/stackdepot.h:120:26: warning: declaration of 'struct seq_file' will not be visible outside of this function [-Wvisibility]
   void *stack_start(struct seq_file *m, loff_t *ppos);
                            ^
   include/linux/stackdepot.h:121:25: warning: declaration of 'struct seq_file' will not be visible outside of this function [-Wvisibility]
   void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
                           ^
   include/linux/stackdepot.h:122:24: warning: declaration of 'struct seq_file' will not be visible outside of this function [-Wvisibility]
   int stack_print(struct seq_file *m, void *v);
                          ^
   3 warnings generated.
--
   In file included from lib/scatterlist.c:9:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:22:
   In file included from include/linux/page_ext.h:7:
>> include/linux/stackdepot.h:120:26: warning: declaration of 'struct seq_file' will not be visible outside of this function [-Wvisibility]
   void *stack_start(struct seq_file *m, loff_t *ppos);
                            ^
   include/linux/stackdepot.h:121:25: warning: declaration of 'struct seq_file' will not be visible outside of this function [-Wvisibility]
   void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
                           ^
   include/linux/stackdepot.h:122:24: warning: declaration of 'struct seq_file' will not be visible outside of this function [-Wvisibility]
   int stack_print(struct seq_file *m, void *v);
                          ^
   In file included from lib/scatterlist.c:9:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:43:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:214:1: note: expanded from here
   __do_insb
   ^
   arch/powerpc/include/asm/io.h:577:56: note: expanded from macro '__do_insb'
   #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from lib/scatterlist.c:9:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:216:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:578:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from lib/scatterlist.c:9:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:218:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:579:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from lib/scatterlist.c:9:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:220:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:580:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from lib/scatterlist.c:9:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:222:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:581:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from lib/scatterlist.c:9:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:224:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:582:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   9 warnings generated.
--
   In file included from lib/stackdepot.c:20:
   In file included from include/linux/mm.h:22:
   In file included from include/linux/page_ext.h:7:
>> include/linux/stackdepot.h:120:26: warning: declaration of 'struct seq_file' will not be visible outside of this function [-Wvisibility]
   void *stack_start(struct seq_file *m, loff_t *ppos);
                            ^
   include/linux/stackdepot.h:121:25: warning: declaration of 'struct seq_file' will not be visible outside of this function [-Wvisibility]
   void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
                           ^
   include/linux/stackdepot.h:122:24: warning: declaration of 'struct seq_file' will not be visible outside of this function [-Wvisibility]
   int stack_print(struct seq_file *m, void *v);
                          ^
   In file included from lib/stackdepot.c:29:
   In file included from include/linux/memblock.h:13:
   In file included from arch/powerpc/include/asm/dma.h:22:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:43:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:217:1: note: expanded from here
   __do_insb
   ^
   arch/powerpc/include/asm/io.h:577:56: note: expanded from macro '__do_insb'
   #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from lib/stackdepot.c:29:
   In file included from include/linux/memblock.h:13:
   In file included from arch/powerpc/include/asm/dma.h:22:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:219:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:578:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from lib/stackdepot.c:29:
   In file included from include/linux/memblock.h:13:
   In file included from arch/powerpc/include/asm/dma.h:22:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:221:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:579:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from lib/stackdepot.c:29:
   In file included from include/linux/memblock.h:13:
   In file included from arch/powerpc/include/asm/dma.h:22:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:223:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:580:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from lib/stackdepot.c:29:
   In file included from include/linux/memblock.h:13:
   In file included from arch/powerpc/include/asm/dma.h:22:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:225:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:581:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from lib/stackdepot.c:29:
   In file included from include/linux/memblock.h:13:
   In file included from arch/powerpc/include/asm/dma.h:22:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:227:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:582:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> lib/stackdepot.c:505:7: error: conflicting types for 'stack_start'
   void *stack_start(struct seq_file *m, loff_t *ppos)
         ^
   include/linux/stackdepot.h:120:7: note: previous declaration is here
   void *stack_start(struct seq_file *m, loff_t *ppos);
         ^
>> lib/stackdepot.c:523:7: error: conflicting types for 'stack_next'
   void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
         ^
   include/linux/stackdepot.h:121:7: note: previous declaration is here
   void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
         ^
>> lib/stackdepot.c:552:5: error: conflicting types for 'stack_print'
   int stack_print(struct seq_file *m, void *v)
       ^
   include/linux/stackdepot.h:122:5: note: previous declaration is here
   int stack_print(struct seq_file *m, void *v);
       ^
   9 warnings and 3 errors generated.
--
   In file included from arch/powerpc/kernel/align.c:17:
   In file included from include/linux/mm.h:22:
   In file included from include/linux/page_ext.h:7:
>> include/linux/stackdepot.h:120:26: error: declaration of 'struct seq_file' will not be visible outside of this function [-Werror,-Wvisibility]
   void *stack_start(struct seq_file *m, loff_t *ppos);
                            ^
   include/linux/stackdepot.h:121:25: error: declaration of 'struct seq_file' will not be visible outside of this function [-Werror,-Wvisibility]
   void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
                           ^
   include/linux/stackdepot.h:122:24: error: declaration of 'struct seq_file' will not be visible outside of this function [-Werror,-Wvisibility]
   int stack_print(struct seq_file *m, void *v);
                          ^
   In file included from arch/powerpc/kernel/align.c:22:
   In file included from arch/powerpc/include/asm/emulated_ops.h:10:
   In file included from include/linux/perf_event.h:52:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:43:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:220:1: note: expanded from here
   __do_insb
   ^
   arch/powerpc/include/asm/io.h:577:56: note: expanded from macro '__do_insb'
   #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from arch/powerpc/kernel/align.c:22:
   In file included from arch/powerpc/include/asm/emulated_ops.h:10:
   In file included from include/linux/perf_event.h:52:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:45:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:222:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:578:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from arch/powerpc/kernel/align.c:22:
   In file included from arch/powerpc/include/asm/emulated_ops.h:10:
   In file included from include/linux/perf_event.h:52:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:47:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:224:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:579:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from arch/powerpc/kernel/align.c:22:
   In file included from arch/powerpc/include/asm/emulated_ops.h:10:
   In file included from include/linux/perf_event.h:52:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:49:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:226:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:580:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^


vim +/stack_start +505 lib/stackdepot.c

   503	
   504	#ifdef CONFIG_PAGE_OWNER
 > 505	void *stack_start(struct seq_file *m, loff_t *ppos)
   506	{
   507		unsigned long *table = m->private;
   508		struct stack_record **stacks, *stack;
   509	
   510		/* First time */
   511		if (*ppos == 0)
   512			*table = 0;
   513	
   514		if (*ppos == -1UL)
   515			return NULL;
   516	
   517		stacks = &stack_table[*table];
   518		stack = (struct stack_record *)stacks;
   519	
   520		return stack;
   521	}
   522	
 > 523	void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
   524	{
   525		unsigned long *table = m->private;
   526		unsigned long nr_table = *table;
   527		struct stack_record *next = NULL, *stack = v, **stacks;
   528		unsigned long stack_table_entries = stack_hash_mask + 1;
   529	
   530		if (!stack) {
   531	new_table:
   532			/* New table */
   533			nr_table++;
   534			if (nr_table >= stack_table_entries)
   535				goto out;
   536			stacks = &stack_table[nr_table];
   537			stack = (struct stack_record *)stacks;
   538			next = stack;
   539		} else {
   540			next = stack->next;
   541		}
   542	
   543		if (!next)
   544			goto new_table;
   545	
   546	out:
   547		*table = nr_table;
   548		*ppos = (nr_table >= stack_table_entries) ? -1UL : *ppos + 1;
   549		return next;
   550	}
   551	
 > 552	int stack_print(struct seq_file *m, void *v)
   553	{
   554		char *buf;
   555		int ret = 0;
   556		struct stack_record *stack =v;
   557	
   558		if (!stack->size || stack->size < 0 ||
   559		    stack->size > PAGE_SIZE || stack->handle.valid != 1 ||
   560		    refcount_read(&stack->count) < 1)
   561			return 0;
   562	
   563		buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
   564		ret += stack_trace_snprint(buf, PAGE_SIZE, stack->entries, stack->size, 0);
   565		scnprintf(buf + ret, PAGE_SIZE - ret, "stack count: %d\n\n",
   566			  refcount_read(&stack->count));
   567		seq_printf(m, buf);
   568		seq_puts(m, "\n\n");
   569		kfree(buf);
   570	
   571	        return 0;
   572	}
   573	#endif
   574	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
