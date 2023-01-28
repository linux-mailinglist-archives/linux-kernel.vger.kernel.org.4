Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED21F67F7B5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 13:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjA1MDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 07:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjA1MDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 07:03:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4779096
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674907410; x=1706443410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i0RFEKNFj77Bsg83J8YNF+pxSWojES57fmybMH++WWs=;
  b=icMkUGOQ5WDcDmAi/PZcXW3STMA4jJKQPE/lDy1DvW30Z48iCvSrIKUs
   1kg+pXNLLY8KVlVSuVILm1Ox2vC1Lt8rIOcdnSLa9rCBwDxI67gxvx/E6
   hSEn2jY40BHZKf5nED5TeCBsaBS3PV4iFY6HFxxvRWqlNQusYmBsOmTbs
   lpGIQNtImuCGyhFKOJzVwYDiaeWkbZF69PAvupV9c3ZolLxmUgTM3FnjP
   QnJiNU4ydH4c0BmlOTL28PW8Q90LIExA/La8bN5qqAm+f4rD6sc/RJYot
   NgICLYhQ9ubxF239XiyKFkdPFGb1bStOhM/SrKIA4Bnlpznxnjq7p5j4W
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="354593383"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="354593383"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 04:03:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="656917221"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="656917221"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2023 04:03:28 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLjvb-0000cr-1Y;
        Sat, 28 Jan 2023 12:03:27 +0000
Date:   Sat, 28 Jan 2023 20:03:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "GuoRui.Yu" <GuoRui.Yu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, linux-coco@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev, GuoRui.Yu@linux.alibaba.com,
        robin.murphy@arm.com
Subject: Re: [PATCH 2/4] swiotlb: Add a new cc-swiotlb implementation for
 Confidential VMs
Message-ID: <202301281925.XYfOkJnF-lkp@intel.com>
References: <20230128083254.86012-3-GuoRui.Yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128083254.86012-3-GuoRui.Yu@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230128083254.86012-3-GuoRui.Yu%40linux.alibaba.com
patch subject: [PATCH 2/4] swiotlb: Add a new cc-swiotlb implementation for Confidential VMs
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230128/202301281925.XYfOkJnF-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9345d2c75b5994cec46ad0abf12f01ed91742e81
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review GuoRui-Yu/swiotlb-Add-a-new-cc-swiotlb-implementation-for-Confidential-VMs/20230128-181154
        git checkout 9345d2c75b5994cec46ad0abf12f01ed91742e81
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/dma/cc-swiotlb.c: In function 'swiotlb_bounce':
>> kernel/dma/cc-swiotlb.c:174:32: warning: variable 'tlb_end' set but not used [-Wunused-but-set-variable]
     174 |         phys_addr_t orig_addr, tlb_end, slot_start, slot_end = tlb_addr ;
         |                                ^~~~~~~
   kernel/dma/cc-swiotlb.c: At top level:
>> kernel/dma/cc-swiotlb.c:492:13: warning: no previous prototype for 'swiotlb_hint_cpus' [-Wmissing-prototypes]
     492 | void __init swiotlb_hint_cpus(int cpus) {}
         |             ^~~~~~~~~~~~~~~~~


vim +/tlb_end +174 kernel/dma/cc-swiotlb.c

   167	
   168	/*
   169	 * Bounce: copy the swiotlb buffer from or back to the original dma location
   170	 */
   171	void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
   172				   enum dma_data_direction dir)
   173	{
 > 174		phys_addr_t orig_addr, tlb_end, slot_start, slot_end = tlb_addr ;
   175		struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
   176		struct io_tlb_slot *slot;
   177		unsigned long pfn;
   178		void *backing_addr;
   179		size_t alloc_size;
   180	
   181		slot = xa_find_after(mem->mapping, (unsigned long*)&slot_end, ULONG_MAX, XA_PRESENT);
   182		if (!slot) {
   183			dev_WARN_ONCE(dev, 1, "TLB buffer not found.\n");
   184			return;
   185		}
   186	
   187		orig_addr = slot->orig_addr;
   188		alloc_size = slot->alloc_size;
   189		slot_start = slot_end - slot->orig_size;
   190		tlb_end = tlb_addr + size;
   191	
   192		pfn = PFN_DOWN(orig_addr);
   193		if (PageHighMem(pfn_to_page(pfn))) {
   194			dev_WARN_ONCE(dev, 1, "Unexpected high memory.\n");
   195			return;
   196		}
   197	
   198		if (size > alloc_size) {
   199			dev_WARN_ONCE(dev, 1,
   200				"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu.\n",
   201				alloc_size, size);
   202			size = alloc_size;
   203		}
   204	
   205		backing_addr = slot->va + (tlb_addr - slot_start);
   206	
   207		if (dir == DMA_TO_DEVICE) {
   208			memcpy(backing_addr, phys_to_virt(orig_addr), size);
   209		} else {
   210			memcpy(phys_to_virt(orig_addr), backing_addr, size);
   211		}
   212	}
   213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
