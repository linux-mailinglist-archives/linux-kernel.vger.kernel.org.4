Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C926DFD80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjDLS1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDLS1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:27:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999E25BA5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681324054; x=1712860054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VTdyIpjaATWa7mekoiTWRCLcyz15fwCjJ1LRg3DqtMo=;
  b=HAJCMKZ4TxEsvz40dKMjIudBA7I7DQGjldNVBbiD0Tn6qeRTgoaktPQi
   QeXg8ni6sCs73iqfmpnRmIW+dhmA2z4MJbFrj3lllwqZY9qHt/6NXO/Wc
   Mnx7ipec1uSbCwiM+wU9ND7cmZpJ7zBelT9hYOPrpCj8a7bEvxhZl/yLW
   JHYRDD/RE2TLGbojfNQRWxQqKJlTdYKf/qKSj3/CMBkXPDLu6idDe2Kxw
   hqf2UAWzDRP4iOQKkJ96ShFR5syjv6SKQ9id8tm1HiJ9tR3N+exRiYWGK
   OCbmNTQmRW03iAdQB9sjkJqbIf9S0a8eQZDqfBlw5BdVb7aTOmzndJpfq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="342738375"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="342738375"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="778403203"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="778403203"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2023 11:27:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmfBg-000Xyz-2T;
        Wed, 12 Apr 2023 18:27:20 +0000
Date:   Thu, 13 Apr 2023 02:27:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        urezki@gmail.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        Dipanjan Das <mail.dipanjan.das@gmail.com>
Subject: Re: [PATCH 1/2] mm: kmsan: handle alloc failures in
 kmsan_vmap_pages_range_noflush()
Message-ID: <202304130223.epEIvA1E-lkp@intel.com>
References: <20230412145300.3651840-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412145300.3651840-1-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Potapenko/mm-kmsan-handle-alloc-failures-in-kmsan_ioremap_page_range/20230412-225414
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230412145300.3651840-1-glider%40google.com
patch subject: [PATCH 1/2] mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20230413/202304130223.epEIvA1E-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f8f0837563234abfae564b24278879d42d52a6e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexander-Potapenko/mm-kmsan-handle-alloc-failures-in-kmsan_ioremap_page_range/20230412-225414
        git checkout f8f0837563234abfae564b24278879d42d52a6e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304130223.epEIvA1E-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:22:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:9:
>> include/linux/kmsan.h:291:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
   1 error generated.
   make[2]: *** [scripts/Makefile.build:114: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:1286: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +291 include/linux/kmsan.h

68ef169a1dd20d Alexander Potapenko 2022-09-15  284  
f8f0837563234a Alexander Potapenko 2023-04-12  285  static inline int kmsan_vmap_pages_range_noflush(unsigned long start,
b073d7f8aee4eb Alexander Potapenko 2022-09-15  286  						 unsigned long end,
b073d7f8aee4eb Alexander Potapenko 2022-09-15  287  						 pgprot_t prot,
b073d7f8aee4eb Alexander Potapenko 2022-09-15  288  						 struct page **pages,
b073d7f8aee4eb Alexander Potapenko 2022-09-15  289  						 unsigned int page_shift)
b073d7f8aee4eb Alexander Potapenko 2022-09-15  290  {
b073d7f8aee4eb Alexander Potapenko 2022-09-15 @291  }
b073d7f8aee4eb Alexander Potapenko 2022-09-15  292  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
