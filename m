Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78FB731F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjFORms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjFORmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:42:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED9B2711
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686850965; x=1718386965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4h2LkdjJA/Ksz2W4qrcAM5sBKclK3bSACHuZzufQkO0=;
  b=nvaPhnwIdWrJ52W0bcBMQf2xQZxSLuziXeBYdtwxFWO4Cat1nNOPyBIa
   6flAdswb80a7zCAkFCaTJZ4/lrMudT6z2kjylmpr3YnA2DgWlzr1/pre1
   dxBY7JByaT3rKQnp1J2Y8fVeO/nO6VE1lQpWXUjD+WPqXsnpPyWdGvd6Q
   svzxSYBW3MElhIoWyPG0B76xSasLFmPmY+DkfoA0nLxW4DSCzv+lQ6DS/
   6/dnlBemYBWXcUlPhixbwwP0igeCgehEp9khcs2JWr5FDWYgUlr1Lnzve
   65ILhx26XnSjuXLnxGEJ9zZu9unpyNYpVHTXlAULHfZ+dPpqc7PIhWYXG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348700098"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="348700098"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802499096"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="802499096"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 10:42:42 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9qzZ-0000EJ-2m;
        Thu, 15 Jun 2023 17:42:41 +0000
Date:   Fri, 16 Jun 2023 01:42:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
        rppt@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH] mm: pass nid to reserve_bootmem_region()
Message-ID: <202306160145.juJMr3Bi-lkp@intel.com>
References: <20230615110355.1694461-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615110355.1694461-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yajun,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Yajun-Deng/mm-pass-nid-to-reserve_bootmem_region/20230615-190631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230615110355.1694461-1-yajun.deng%40linux.dev
patch subject: [PATCH] mm: pass nid to reserve_bootmem_region()
config: arm-randconfig-r023-20230614 (https://download.01.org/0day-ci/archive/20230616/202306160145.juJMr3Bi-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch akpm-mm mm-everything
        git checkout akpm-mm/mm-everything
        b4 shazam https://lore.kernel.org/r/20230615110355.1694461-1-yajun.deng@linux.dev
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306160145.juJMr3Bi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/memblock.c:2098:18: error: no member named 'nid' in 'struct memblock_region'
                           nid = region->nid;
                                 ~~~~~~  ^
   1 error generated.


vim +2098 mm/memblock.c

  2080	
  2081	static void __init memmap_init_reserved_pages(void)
  2082	{
  2083		struct memblock_region *region;
  2084		phys_addr_t start, end;
  2085		int nid;
  2086		u64 i;
  2087	
  2088		/* initialize struct pages for the reserved regions */
  2089		__for_each_mem_range(i, &memblock.reserved, NULL, NUMA_NO_NODE,
  2090				     MEMBLOCK_NONE, &start, &end, &nid)
  2091			reserve_bootmem_region(start, end, nid);
  2092	
  2093		/* and also treat struct pages for the NOMAP regions as PageReserved */
  2094		for_each_mem_region(region) {
  2095			if (memblock_is_nomap(region)) {
  2096				start = region->base;
  2097				end = start + region->size;
> 2098				nid = region->nid;
  2099				reserve_bootmem_region(start, end, nid);
  2100			}
  2101		}
  2102	}
  2103	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
