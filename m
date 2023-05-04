Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA856F7035
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjEDQuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjEDQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:50:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188933ABE
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683218992; x=1714754992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6GATw5TbgnRkMMXSPt4srw7Op6gkzeWo7yyggIFj11A=;
  b=OYmsGlMjV7dXNZWC8DWxjWhCe80hcurVaOTwnX8JFPazYhx3/kwbgkmP
   Pu8pO50q4Sg0kgMwbS4sXnxWRemDjFQz2iqpsC4jjfgDGSYrqjODtW2xg
   x2b+0t+nujH9F/0Sr2AsFlj75Hj5sztvSFL3JP2yJ7mYJAzwE0PhnoPMC
   surXZERWM0opxPUuaWhO5Na4DbKnskUlggzx99zcbbuEoIstDUg2j89bh
   BMs/QUDi6CB9yp9prcoPBjQ2vciB/fZiWibQ7u+/owkmo49egV3yA6zpc
   BkikA38al97BIsUvfy9hxXVOPMVzNFMtyRhRL3hlIrbbJjjia5dyPuCUR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="338166010"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="338166010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 09:49:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="841264040"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="841264040"
Received: from lkp-server01.sh.intel.com (HELO 64cf2984a3fe) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2023 09:49:48 -0700
Received: from kbuild by 64cf2984a3fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puc9L-00003S-2N;
        Thu, 04 May 2023 16:49:47 +0000
Date:   Fri, 5 May 2023 00:48:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCHv2] mm: optimization on page allocation when CMA enabled
Message-ID: <202305050012.G279ml2k-lkp@intel.com>
References: <1683194994-3070-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683194994-3070-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhaoyang.huang,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/zhaoyang-huang/mm-optimization-on-page-allocation-when-CMA-enabled/20230504-181335
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/1683194994-3070-1-git-send-email-zhaoyang.huang%40unisoc.com
patch subject: [PATCHv2] mm: optimization on page allocation when CMA enabled
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20230505/202305050012.G279ml2k-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/46cd0a3d98d6b43cd59be9d9e743266fc7f61168
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhaoyang-huang/mm-optimization-on-page-allocation-when-CMA-enabled/20230504-181335
        git checkout 46cd0a3d98d6b43cd59be9d9e743266fc7f61168
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305050012.G279ml2k-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/page_alloc.c: In function '__rmqueue':
>> mm/page_alloc.c:2323:42: error: implicit declaration of function '__if_use_cma_first' [-Werror=implicit-function-declaration]
    2323 |                         bool cma_first = __if_use_cma_first(zone, order, alloc_flags);
         |                                          ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/__if_use_cma_first +2323 mm/page_alloc.c

  2277	
  2278	#ifdef CONFIG_CMA
  2279	static bool __if_use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
  2280	{
  2281		unsigned long cma_proportion = 0;
  2282		unsigned long cma_free_proportion = 0;
  2283		unsigned long watermark = 0;
  2284		long count = 0;
  2285		bool cma_first = false;
  2286	
  2287		watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
  2288		/*check if GFP_MOVABLE pass previous watermark check via the help of CMA*/
  2289		if (!zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA)))
  2290			/* WMARK_LOW failed lead to using cma first, this helps U&R stay
  2291			 * around low when being drained by GFP_MOVABLE
  2292			 */
  2293			cma_first = true;
  2294		else {
  2295			/*check proportion when zone_watermark_ok*/
  2296			count = atomic_long_read(&zone->managed_pages);
  2297			cma_proportion = zone->cma_pages * 100 / count;
  2298			cma_free_proportion = zone_page_state(zone, NR_FREE_CMA_PAGES) * 100
  2299				/  zone_page_state(zone, NR_FREE_PAGES);
  2300			cma_first = (cma_free_proportion >= cma_proportion * 2
  2301					|| cma_free_proportion >= 50);
  2302		}
  2303		return cma_first;
  2304	}
  2305	#endif
  2306	/*
  2307	 * Do the hard work of removing an element from the buddy allocator.
  2308	 * Call me with the zone->lock already held.
  2309	 */
  2310	static __always_inline struct page *
  2311	__rmqueue(struct zone *zone, unsigned int order, int migratetype,
  2312							unsigned int alloc_flags)
  2313	{
  2314		struct page *page;
  2315	
  2316		if (IS_ENABLED(CONFIG_CMA)) {
  2317			/*
  2318			 * Balance movable allocations between regular and CMA areas by
  2319			 * allocating from CMA when over half of the zone's free memory
  2320			 * is in the CMA area.
  2321			 */
  2322			if (migratetype == MIGRATE_MOVABLE) {
> 2323				bool cma_first = __if_use_cma_first(zone, order, alloc_flags);
  2324	
  2325				page = cma_first ? __rmqueue_cma_fallback(zone, order) : NULL;
  2326				if (page)
  2327					return page;
  2328			}
  2329		}
  2330	retry:
  2331		page = __rmqueue_smallest(zone, order, migratetype);
  2332		if (unlikely(!page)) {
  2333			if (alloc_flags & ALLOC_CMA)
  2334				page = __rmqueue_cma_fallback(zone, order);
  2335	
  2336			if (!page && __rmqueue_fallback(zone, order, migratetype,
  2337									alloc_flags))
  2338				goto retry;
  2339		}
  2340		return page;
  2341	}
  2342	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
