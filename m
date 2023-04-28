Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB676F1A54
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjD1ORI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjD1ORF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:17:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBFA6191
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682691398; x=1714227398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pcj+cSdQdRCCbV5iccXjACQN9M1g+OCjIGDd19j+Ffk=;
  b=U+IH2iR/KpwHNvoLg09U84GScl+IgYbWjUz6d11+9zTHCmDHHdgQAI7b
   /yrQPg9yeuopglSpAudcrB/6ETgDYrfof9KverZq1gHUK30sZclSBdScd
   jv3HAgpr4GrWFuoEpbZNDwAT0nvAtwUVsoVSERi26d4LHHGVfPpMKByJi
   8Jtt7OMpi8NxoFaIQGj6evGim+LuQ/DpqwoRQ9cQTkBl3IJMUCjssYyU7
   WkknYZvZWkgwVpnePGeddBCXyeuyXl5CnIl/4qpVhmqRP+yJ2MMiVZCI3
   R9o8zAFzdTORW/Cx+TaJ/H1gKWzc8kIa2x3aBRAp4m2zs9xAdbJ2hfWWC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="327381911"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="327381911"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 07:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="694814597"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="694814597"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2023 07:16:35 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psOtm-0000Ue-2V;
        Fri, 28 Apr 2023 14:16:34 +0000
Date:   Fri, 28 Apr 2023 22:16:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: optimization on page allocation when CMA enabled
Message-ID: <202304282118.os2SZpZS-lkp@intel.com>
References: <1682679641-13652-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682679641-13652-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhaoyang.huang,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/zhaoyang-huang/mm-optimization-on-page-allocation-when-CMA-enabled/20230428-190140
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/1682679641-13652-1-git-send-email-zhaoyang.huang%40unisoc.com
patch subject: [PATCH] mm: optimization on page allocation when CMA enabled
config: alpha-randconfig-r014-20230428 (https://download.01.org/0day-ci/archive/20230428/202304282118.os2SZpZS-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dbda57eee661a0c9b47f23720bcc9741495d00a5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhaoyang-huang/mm-optimization-on-page-allocation-when-CMA-enabled/20230428-190140
        git checkout dbda57eee661a0c9b47f23720bcc9741495d00a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304282118.os2SZpZS-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/page_alloc.c: In function '__rmqueue':
>> mm/page_alloc.c:2328:42: error: implicit declaration of function '__if_use_cma_first' [-Werror=implicit-function-declaration]
    2328 |                         bool cma_first = __if_use_cma_first(zone, order, alloc_flags);
         |                                          ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/__if_use_cma_first +2328 mm/page_alloc.c

  2277	
  2278	#ifdef CONFIG_CMA
  2279	static bool __if_use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
  2280	{
  2281		unsigned long cma_proportion = 0;
  2282		unsigned long cma_free_proportion = 0;
  2283		unsigned long watermark = 0;
  2284		unsigned long wm_fact[ALLOC_WMARK_MASK] = {1, 1, 2};
  2285		long count = 0;
  2286		bool cma_first = false;
  2287	
  2288		watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
  2289		/*check if GFP_MOVABLE pass previous watermark check via the help of CMA*/
  2290		if (!zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA)))
  2291		{
  2292			alloc_flags &= ALLOC_WMARK_MASK;
  2293			/* WMARK_LOW failed lead to using cma first, this helps U&R stay
  2294			 * around low when being drained by GFP_MOVABLE
  2295			 */
  2296			if (alloc_flags <= ALLOC_WMARK_LOW)
  2297				cma_first = true;
  2298			/*check proportion for WMARK_HIGH*/
  2299			else {
  2300				count = atomic_long_read(&zone->managed_pages);
  2301				cma_proportion = zone->cma_pages * 100 / count;
  2302				cma_free_proportion = zone_page_state(zone, NR_FREE_CMA_PAGES) * 100
  2303					/  zone_page_state(zone, NR_FREE_PAGES);
  2304				cma_first = (cma_free_proportion >= wm_fact[alloc_flags] * cma_proportion
  2305						|| cma_free_proportion >= 50);
  2306			}
  2307		}
  2308		return cma_first;
  2309	}
  2310	#endif
  2311	/*
  2312	 * Do the hard work of removing an element from the buddy allocator.
  2313	 * Call me with the zone->lock already held.
  2314	 */
  2315	static __always_inline struct page *
  2316	__rmqueue(struct zone *zone, unsigned int order, int migratetype,
  2317							unsigned int alloc_flags)
  2318	{
  2319		struct page *page;
  2320	
  2321		if (IS_ENABLED(CONFIG_CMA)) {
  2322			/*
  2323			 * Balance movable allocations between regular and CMA areas by
  2324			 * allocating from CMA when over half of the zone's free memory
  2325			 * is in the CMA area.
  2326			 */
  2327			if (migratetype == MIGRATE_MOVABLE) {
> 2328				bool cma_first = __if_use_cma_first(zone, order, alloc_flags);
  2329				page = cma_first ? __rmqueue_cma_fallback(zone, order) : NULL;
  2330				if (page)
  2331					return page;
  2332			}
  2333		}
  2334	retry:
  2335		page = __rmqueue_smallest(zone, order, migratetype);
  2336		if (unlikely(!page)) {
  2337			if (alloc_flags & ALLOC_CMA)
  2338				page = __rmqueue_cma_fallback(zone, order);
  2339	
  2340			if (!page && __rmqueue_fallback(zone, order, migratetype,
  2341									alloc_flags))
  2342				goto retry;
  2343		}
  2344		return page;
  2345	}
  2346	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
