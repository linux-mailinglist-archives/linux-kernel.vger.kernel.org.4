Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0237167FAC2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 21:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjA1UU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 15:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1UUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 15:20:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9CF241D9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 12:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674937254; x=1706473254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dFBhob8MHmzXu757sCnUaQFuD2W3tXJKuMR8SGgfwVc=;
  b=k1cZ9hnfzJ7q7z2tkQQTeCCRFFrnMfGEPkWVqscKqeJjUyF0MCmEN9ba
   zihI6mFxkYTSzNbVLHwKCbupcNLTO3ftow+DvPa2p2HtMpGNWPJh886sW
   dR/U41YfI70i8EG+59bI7MSFCiPGz7b4qHkitDru5296WaqIOiuHvSksH
   N1qxjOPkCTaikHXxaP6tTu4qOuqRhCe2KqO8O0MZbqXuggBM817qPbNxi
   jhi8hMVCrVewsi+Tz1bwSMMtsPoBA/BPt3Ir74D3tzlq1iI7cVJuScuIb
   lYW+aoNnrerxWOfpAp2T/qOSu9MdcSO+yfZbIJPDm2Sk3kpFRfdsdf0+y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="307672347"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="307672347"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 12:20:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="727051089"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="727051089"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jan 2023 12:20:51 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLrgw-00014a-1L;
        Sat, 28 Jan 2023 20:20:50 +0000
Date:   Sun, 29 Jan 2023 04:19:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "GuoRui.Yu" <GuoRui.Yu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, linux-coco@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev, GuoRui.Yu@linux.alibaba.com,
        robin.murphy@arm.com
Subject: Re: [PATCH 4/4] cc-swiotlb: Allow set swiotlb watermark from cmdline
Message-ID: <202301290417.n1KMDPQt-lkp@intel.com>
References: <20230128083254.86012-5-GuoRui.Yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128083254.86012-5-GuoRui.Yu@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi GuoRui.Yu",

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on joro-iommu/next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.2-rc5 next-20230127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/GuoRui-Yu/swiotlb-Add-a-new-cc-swiotlb-implementation-for-Confidential-VMs/20230128-181154
patch link:    https://lore.kernel.org/r/20230128083254.86012-5-GuoRui.Yu%40linux.alibaba.com
patch subject: [PATCH 4/4] cc-swiotlb: Allow set swiotlb watermark from cmdline
config: nios2-buildonly-randconfig-r002-20230129 (https://download.01.org/0day-ci/archive/20230129/202301290417.n1KMDPQt-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fcbd538c875f5f1086682829671935d7155e4029
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review GuoRui-Yu/swiotlb-Add-a-new-cc-swiotlb-implementation-for-Confidential-VMs/20230128-181154
        git checkout fcbd538c875f5f1086682829671935d7155e4029
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/dma/cc-swiotlb.c: In function 'swiotlb_bounce':
   kernel/dma/cc-swiotlb.c:200:32: warning: variable 'tlb_end' set but not used [-Wunused-but-set-variable]
     200 |         phys_addr_t orig_addr, tlb_end, slot_start, slot_end = tlb_addr ;
         |                                ^~~~~~~
   In file included from kernel/dma/cc-swiotlb.c:13:
   kernel/dma/cc-swiotlb.c: In function 'cc_populate_pages':
>> include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:429:25: note: in definition of macro 'printk_index_wrap'
     429 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:530:9: note: in expansion of macro 'printk'
     530 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:530:16: note: in expansion of macro 'KERN_INFO'
     530 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   kernel/dma/cc-swiotlb.c:411:9: note: in expansion of macro 'pr_info'
     411 |         pr_info("bounce buffer size adjusted to %luMB", size >> 20);
         |         ^~~~~~~
   kernel/dma/cc-swiotlb.c: At top level:
   kernel/dma/cc-swiotlb.c:524:13: warning: no previous prototype for 'swiotlb_hint_cpus' [-Wmissing-prototypes]
     524 | void __init swiotlb_hint_cpus(int cpus) {}
         |             ^~~~~~~~~~~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
