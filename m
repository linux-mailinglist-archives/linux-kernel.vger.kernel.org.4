Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E569413C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBMJcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjBMJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:31:52 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616414C2E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676280615; x=1707816615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9FwOfNFDMQvA9eUplObDU3WspLsuxTJWoEuUtfj/uVw=;
  b=kMRyQdrO0vhN03z8VovSFNxqmU0mnLiGThKFOjD/znh7GvESKWl4X+BO
   6CbQX3PsOW98LbKo1cq7u+kAETaoJ7cIsMyFEiJq4W1wIwaKIT1ouq1Zl
   TfuxihBaSG3r8UI9fLpA4HdXM4FImiyA3BLRm6iGr3rWY6Koz9IsBVyGS
   VHIUcKmQ84TQb25A1Jn/OHCAysMlmxo4a2HSa15If+j/xCwFR9ySsHa2Q
   vgTcaxHsC0ij8nT/OPhhePDidHJOtppP714ps47HurfLF+VULqEFI9V6i
   mJOVdr3+WsM77XBl19ncPud78KCvaqwbnZa8+B1D5KUTiL4hX5fZ0l6ST
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="358258502"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="358258502"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 01:29:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="732433074"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="732433074"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Feb 2023 01:29:13 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRV96-0007eT-10;
        Mon, 13 Feb 2023 09:29:12 +0000
Date:   Mon, 13 Feb 2023 17:28:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "GuoRui.Yu" <GuoRui.Yu@linux.alibaba.com>, hch@lst.de,
        m.szyprowski@samsung.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, GuoRui.Yu@linux.alibaba.com,
        xiaokang.hxk@alibaba-inc.com
Subject: Re: [PATCH] swiotlb: fix the deadlock in swiotlb_do_find_slots
Message-ID: <202302131748.pa5NGbb9-lkp@intel.com>
References: <20230213063604.127526-1-GuoRui.Yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213063604.127526-1-GuoRui.Yu@linux.alibaba.com>
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

[auto build test WARNING on linus/master]
[also build test WARNING on hch-configfs/for-next v6.2-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/GuoRui-Yu/swiotlb-fix-the-deadlock-in-swiotlb_do_find_slots/20230213-143625
patch link:    https://lore.kernel.org/r/20230213063604.127526-1-GuoRui.Yu%40linux.alibaba.com
patch subject: [PATCH] swiotlb: fix the deadlock in swiotlb_do_find_slots
config: x86_64-randconfig-a001-20230213 (https://download.01.org/0day-ci/archive/20230213/202302131748.pa5NGbb9-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d3d8e60e47bb50892fbde7c6fa81562f8ea916a3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review GuoRui-Yu/swiotlb-fix-the-deadlock-in-swiotlb_do_find_slots/20230213-143625
        git checkout d3d8e60e47bb50892fbde7c6fa81562f8ea916a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302131748.pa5NGbb9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/dma/swiotlb.c:668:4: warning: variable 'index_nowrap' is uninitialized when used here [-Wuninitialized]
                           index_nowrap += 1;
                           ^~~~~~~~~~~~
   kernel/dma/swiotlb.c:635:34: note: initialize the variable 'index_nowrap' to silence this warning
           unsigned int index, index_nowrap, wrap, count = 0, i;
                                           ^
                                            = 0
   1 warning generated.


vim +/index_nowrap +668 kernel/dma/swiotlb.c

   617	
   618	/*
   619	 * Find a suitable number of IO TLB entries size that will fit this request and
   620	 * allocate a buffer from that IO TLB pool.
   621	 */
   622	static int swiotlb_do_find_slots(struct device *dev, int area_index,
   623			phys_addr_t orig_addr, size_t alloc_size,
   624			unsigned int alloc_align_mask)
   625	{
   626		struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
   627		struct io_tlb_area *area = mem->areas + area_index;
   628		unsigned long boundary_mask = dma_get_seg_boundary(dev);
   629		dma_addr_t tbl_dma_addr =
   630			phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
   631		unsigned long max_slots = get_max_slots(boundary_mask);
   632		unsigned int iotlb_align_mask =
   633			dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
   634		unsigned int nslots = nr_slots(alloc_size), stride;
   635		unsigned int index, index_nowrap, wrap, count = 0, i;
   636		unsigned int offset = swiotlb_align_offset(dev, orig_addr);
   637		unsigned long flags;
   638		unsigned int slot_base;
   639		unsigned int slot_index;
   640	
   641		BUG_ON(!nslots);
   642		BUG_ON(area_index >= mem->nareas);
   643	
   644		/*
   645		 * For mappings with an alignment requirement don't bother looping to
   646		 * unaligned slots once we found an aligned one.  For allocations of
   647		 * PAGE_SIZE or larger only look for page aligned allocations.
   648		 */
   649		stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
   650		if (alloc_size >= PAGE_SIZE)
   651			stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
   652		stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
   653	
   654		spin_lock_irqsave(&area->lock, flags);
   655		if (unlikely(nslots > mem->area_nslabs - area->used))
   656			goto not_found;
   657	
   658		slot_base = area_index * mem->area_nslabs;
   659		index = wrap = wrap_area_index(mem, ALIGN(area->index, stride));
   660	
   661		do {
   662			slot_index = slot_base + index;
   663	
   664			if (orig_addr &&
   665			    (slot_addr(tbl_dma_addr, slot_index) &
   666			     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
   667				index = wrap_area_index(mem, index + 1);
 > 668				index_nowrap += 1;
   669				continue;
   670			}
   671	
   672			/*
   673			 * If we find a slot that indicates we have 'nslots' number of
   674			 * contiguous buffers, we allocate the buffers from that slot
   675			 * and mark the entries as '0' indicating unavailable.
   676			 */
   677			if (!iommu_is_span_boundary(slot_index, nslots,
   678						    nr_slots(tbl_dma_addr),
   679						    max_slots)) {
   680				if (mem->slots[slot_index].list >= nslots)
   681					goto found;
   682			}
   683			index = wrap_area_index(mem, index + stride);
   684			index_nowrap += stride;
   685		} while (index_nowrap < wrap + mem->area_nslabs);
   686	
   687	not_found:
   688		spin_unlock_irqrestore(&area->lock, flags);
   689		return -1;
   690	
   691	found:
   692		for (i = slot_index; i < slot_index + nslots; i++) {
   693			mem->slots[i].list = 0;
   694			mem->slots[i].alloc_size = alloc_size - (offset +
   695					((i - slot_index) << IO_TLB_SHIFT));
   696		}
   697		for (i = slot_index - 1;
   698		     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
   699		     mem->slots[i].list; i--)
   700			mem->slots[i].list = ++count;
   701	
   702		/*
   703		 * Update the indices to avoid searching in the next round.
   704		 */
   705		if (index + nslots < mem->area_nslabs)
   706			area->index = index + nslots;
   707		else
   708			area->index = 0;
   709		area->used += nslots;
   710		spin_unlock_irqrestore(&area->lock, flags);
   711		return slot_index;
   712	}
   713	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
