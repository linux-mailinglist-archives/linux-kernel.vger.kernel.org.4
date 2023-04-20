Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292F76E8E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjDTJrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjDTJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:46:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D619E5BB4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681983943; x=1713519943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hBPUYOyUjqEuWgk+JOgkJqy2sYVP12UxsUyN5z+D8T4=;
  b=lwbuhdOEhAZeauOHps6jCHXwqrb8rg+xETaog0eDCz6sis4hkv7i4pyF
   9kRScb73pWWkl8DVt8I9TvkV6HQccZcpOrjKMoaYZxNrheb1pk4PLob8g
   eHgiiA8ZJili4DaXOLP33r0WbjFE+TEmJSUX3PES4/w3ilkQ9oe+TqwLj
   sjifHWgaA/2NRbHcBrrlBkTTg2ygtnbk8Nkovlo10/BHyjGVG1k9p9rwj
   lMFI9EHTQSX+3uxtT7Gb/NShUFrs5evr6vVf330wvg72fnsoRJlhQ12tX
   Vc3HatXDj1CmLYdpmVQErgI3GdBCuiaLbaRTeuDqAPzRhYPg8WvMUHGAX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347550923"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="347550923"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 02:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="722313491"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="722313491"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2023 02:45:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppQr9-000fhA-01;
        Thu, 20 Apr 2023 09:45:35 +0000
Date:   Thu, 20 Apr 2023 17:44:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCHv2] mm: skip CMA pages when they are not available
Message-ID: <202304201725.pa3nMNWa-lkp@intel.com>
References: <1681979577-11360-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681979577-11360-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhaoyang.huang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/zhaoyang-huang/mm-skip-CMA-pages-when-they-are-not-available/20230420-163443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/1681979577-11360-1-git-send-email-zhaoyang.huang%40unisoc.com
patch subject: [PATCHv2] mm: skip CMA pages when they are not available
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230420/202304201725.pa3nMNWa-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2227e95350088b79da6d6b9e6c95a67474593852
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhaoyang-huang/mm-skip-CMA-pages-when-they-are-not-available/20230420-163443
        git checkout 2227e95350088b79da6d6b9e6c95a67474593852
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304201725.pa3nMNWa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/vmscan.c: In function 'isolate_lru_folios':
>> mm/vmscan.c:2295:22: warning: variable 'page' set but not used [-Wunused-but-set-variable]
    2295 |         struct page *page;
         |                      ^~~~
>> mm/vmscan.c:2294:14: warning: variable 'cma_cap' set but not used [-Wunused-but-set-variable]
    2294 |         bool cma_cap = true;
         |              ^~~~~~~


vim +/page +2295 mm/vmscan.c

  2261	
  2262	/*
  2263	 * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
  2264	 *
  2265	 * lruvec->lru_lock is heavily contended.  Some of the functions that
  2266	 * shrink the lists perform better by taking out a batch of pages
  2267	 * and working on them outside the LRU lock.
  2268	 *
  2269	 * For pagecache intensive workloads, this function is the hottest
  2270	 * spot in the kernel (apart from copy_*_user functions).
  2271	 *
  2272	 * Lru_lock must be held before calling this function.
  2273	 *
  2274	 * @nr_to_scan:	The number of eligible pages to look through on the list.
  2275	 * @lruvec:	The LRU vector to pull pages from.
  2276	 * @dst:	The temp list to put pages on to.
  2277	 * @nr_scanned:	The number of pages that were scanned.
  2278	 * @sc:		The scan_control struct for this reclaim session
  2279	 * @lru:	LRU list id for isolating
  2280	 *
  2281	 * returns how many pages were moved onto *@dst.
  2282	 */
  2283	static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
  2284			struct lruvec *lruvec, struct list_head *dst,
  2285			unsigned long *nr_scanned, struct scan_control *sc,
  2286			enum lru_list lru)
  2287	{
  2288		struct list_head *src = &lruvec->lists[lru];
  2289		unsigned long nr_taken = 0;
  2290		unsigned long nr_zone_taken[MAX_NR_ZONES] = { 0 };
  2291		unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
  2292		unsigned long skipped = 0;
  2293		unsigned long scan, total_scan, nr_pages;
> 2294		bool cma_cap = true;
> 2295		struct page *page;
  2296		LIST_HEAD(folios_skipped);
  2297	
  2298		total_scan = 0;
  2299		scan = 0;
  2300		if ((IS_ENABLED(CONFIG_CMA)) && !current_is_kswapd()
  2301			&& (gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE))
  2302			cma_cap = false;
  2303	
  2304		while (scan < nr_to_scan && !list_empty(src)) {
  2305			struct list_head *move_to = src;
  2306			struct folio *folio;
  2307	
  2308			folio = lru_to_folio(src);
  2309			prefetchw_prev_lru_folio(folio, src, flags);
  2310	
  2311			nr_pages = folio_nr_pages(folio);
  2312			total_scan += nr_pages;
  2313	
  2314			page = &folio->page;
  2315	
  2316			if ((folio_zonenum(folio) > sc->reclaim_idx)
  2317	#ifdef CONFIG_CMA
  2318				|| (get_pageblock_migratetype(page) == MIGRATE_CMA && !cma_cap)
  2319	#endif
  2320			) {
  2321				nr_skipped[folio_zonenum(folio)] += nr_pages;
  2322				move_to = &folios_skipped;
  2323				goto move;
  2324			}
  2325			/*
  2326			 * Do not count skipped folios because that makes the function
  2327			 * return with no isolated folios if the LRU mostly contains
  2328			 * ineligible folios.  This causes the VM to not reclaim any
  2329			 * folios, triggering a premature OOM.
  2330			 * Account all pages in a folio.
  2331			 */
  2332			scan += nr_pages;
  2333	
  2334			if (!folio_test_lru(folio))
  2335				goto move;
  2336			if (!sc->may_unmap && folio_mapped(folio))
  2337				goto move;
  2338	
  2339			/*
  2340			 * Be careful not to clear the lru flag until after we're
  2341			 * sure the folio is not being freed elsewhere -- the
  2342			 * folio release code relies on it.
  2343			 */
  2344			if (unlikely(!folio_try_get(folio)))
  2345				goto move;
  2346	
  2347			if (!folio_test_clear_lru(folio)) {
  2348				/* Another thread is already isolating this folio */
  2349				folio_put(folio);
  2350				goto move;
  2351			}
  2352	
  2353			nr_taken += nr_pages;
  2354			nr_zone_taken[folio_zonenum(folio)] += nr_pages;
  2355			move_to = dst;
  2356	move:
  2357			list_move(&folio->lru, move_to);
  2358		}
  2359	
  2360		/*
  2361		 * Splice any skipped folios to the start of the LRU list. Note that
  2362		 * this disrupts the LRU order when reclaiming for lower zones but
  2363		 * we cannot splice to the tail. If we did then the SWAP_CLUSTER_MAX
  2364		 * scanning would soon rescan the same folios to skip and waste lots
  2365		 * of cpu cycles.
  2366		 */
  2367		if (!list_empty(&folios_skipped)) {
  2368			int zid;
  2369	
  2370			list_splice(&folios_skipped, src);
  2371			for (zid = 0; zid < MAX_NR_ZONES; zid++) {
  2372				if (!nr_skipped[zid])
  2373					continue;
  2374	
  2375				__count_zid_vm_events(PGSCAN_SKIP, zid, nr_skipped[zid]);
  2376				skipped += nr_skipped[zid];
  2377			}
  2378		}
  2379		*nr_scanned = total_scan;
  2380		trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
  2381					    total_scan, skipped, nr_taken,
  2382					    sc->may_unmap ? 0 : ISOLATE_UNMAPPED, lru);
  2383		update_lru_sizes(lruvec, lru, nr_zone_taken);
  2384		return nr_taken;
  2385	}
  2386	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
