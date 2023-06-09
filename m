Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C00729D45
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjFIOtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjFIOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:49:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E637C2738
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686322161; x=1717858161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5aT0rjqFbe+Vm7sM5/iX2YZk1lMoLO2VmOKe2HIj6kI=;
  b=H44GuICysKYVt1YrMHHW/myC3rdpGmefshCH4ZL/xj8GJ7qzKWk3jPnA
   Dn7zQ4+w/P0yt2XqWqKEdlluTWiDeZmNijDuyw0u1PCKwhqMRJO0wz6kl
   w7MjFzTOZ5gYI2xriz5dOPRRTMkMMk9K2oeh64j/oQ7qxnd36bd03CYqt
   7cZfun3zAnRo5Nr3mds2Bb89IrgQCR0tll78wZk7Kof2/iKie2FkDzTji
   v9uSOHtdbW8vCUJg2L2A3iXN6BJBy4nhh7OZSLAIjAkzKVh+y1Hm/gR5T
   OSOh/iq3W2NxoioQMadfhzWIBAzqj8K/EfBSNiNSpRaPQJ9xC8S2QLMS1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="337970839"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="337970839"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 07:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="1040503245"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="1040503245"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2023 07:49:19 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7dQU-00096S-1J;
        Fri, 09 Jun 2023 14:49:18 +0000
Date:   Fri, 9 Jun 2023 22:48:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        mgorman@techsingularity.net, vbabka@suse.cz, david@redhat.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: compaction: skip memory hole rapidly when isolating
 migratable pages
Message-ID: <202306092250.cp65gzkn-lkp@intel.com>
References: <8cc668b77c8eb2fa78058b3d81386ebed9c5a9cd.1686294549.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc668b77c8eb2fa78058b3d81386ebed9c5a9cd.1686294549.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-compaction-skip-memory-hole-rapidly-when-isolating-migratable-pages/20230609-174659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/8cc668b77c8eb2fa78058b3d81386ebed9c5a9cd.1686294549.git.baolin.wang%40linux.alibaba.com
patch subject: [PATCH] mm: compaction: skip memory hole rapidly when isolating migratable pages
config: arm-randconfig-r025-20230609 (https://download.01.org/0day-ci/archive/20230609/202306092250.cp65gzkn-lkp@intel.com/config)
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
        b4 shazam https://lore.kernel.org/r/8cc668b77c8eb2fa78058b3d81386ebed9c5a9cd.1686294549.git.baolin.wang@linux.alibaba.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306092250.cp65gzkn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/compaction.c:235:27: error: call to undeclared function 'pfn_to_section_nr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           unsigned long start_nr = pfn_to_section_nr(start_pfn);
                                    ^
>> mm/compaction.c:237:6: error: call to undeclared function 'online_section_nr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (online_section_nr(start_nr))
               ^
>> mm/compaction.c:240:19: error: call to undeclared function 'next_online_section_nr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           next_online_nr = next_online_section_nr(start_nr);
                            ^
>> mm/compaction.c:242:10: error: call to undeclared function 'section_nr_to_pfn'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   return section_nr_to_pfn(next_online_nr);
                          ^
   4 errors generated.


vim +/pfn_to_section_nr +235 mm/compaction.c

   231	
   232	static unsigned long skip_hole_pageblock(unsigned long start_pfn)
   233	{
   234		unsigned long next_online_nr;
 > 235		unsigned long start_nr = pfn_to_section_nr(start_pfn);
   236	
 > 237		if (online_section_nr(start_nr))
   238			return -1UL;
   239	
 > 240		next_online_nr = next_online_section_nr(start_nr);
   241		if (next_online_nr != -1UL)
 > 242			return section_nr_to_pfn(next_online_nr);
   243	
   244		return -1UL;
   245	}
   246	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
