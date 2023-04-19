Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107986E78B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjDSLhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjDSLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:36:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF704486
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681904217; x=1713440217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wzoCYyFdmuuqUoPdK5mRPsP6mLonzJfo2EMhovGHgZc=;
  b=JxysHf7TflN7zOb0Ek8RCz7lDo93/3f0I8Sg9axBn3ie2EQRuyQUAz6F
   Y39dRZBTPSLD10HmxtTDF5Yt+Q962shvtZbi1RqGZqX9Tf+9hqSoY2jJH
   w9ZgnPDu1H1DHTbJshiyOoH2YsDjhgVu5x8fuCHRsKzHN5YxxHAgXeXvX
   xtBS7d+ardf5zGi0JBkqYueqYIW6qYL8nYuM80/FSMWNayNy/CC706JmQ
   fIaW4AkS7f+9Aej65mGpK2/4rB5wVwiqKVLW6JiIGOqgtn7zbxMT01qKJ
   KNvCEVzLRXaMR38iE6/yBO1/eOW72wS9zPM2L63xQCHqtofPzmN+hP7Uw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="334230556"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="334230556"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 04:36:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="760715448"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="760715448"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Apr 2023 04:36:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pp67F-000er6-12;
        Wed, 19 Apr 2023 11:36:49 +0000
Date:   Wed, 19 Apr 2023 19:36:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: skip CMA pages when they are not available
Message-ID: <202304191908.Bqx6phWT-lkp@intel.com>
References: <1681882824-17532-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681882824-17532-1-git-send-email-zhaoyang.huang@unisoc.com>
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

Hi zhaoyang.huang,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/zhaoyang-huang/mm-skip-CMA-pages-when-they-are-not-available/20230419-134421
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/1681882824-17532-1-git-send-email-zhaoyang.huang%40unisoc.com
patch subject: [PATCH] mm: skip CMA pages when they are not available
config: i386-randconfig-a012-20230417 (https://download.01.org/0day-ci/archive/20230419/202304191908.Bqx6phWT-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/346b74f2bf2155cb8be6af66b346157c7681b9c9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhaoyang-huang/mm-skip-CMA-pages-when-they-are-not-available/20230419-134421
        git checkout 346b74f2bf2155cb8be6af66b346157c7681b9c9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304191908.Bqx6phWT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/vmscan.c:2317:40: error: use of undeclared identifier 'MIGRATE_CMA'; did you mean 'MIGRATE_SYNC'?
                           (get_pageblock_migratetype(page) == MIGRATE_CMA && !cma_cap)) {
                                                               ^~~~~~~~~~~
                                                               MIGRATE_SYNC
   include/linux/migrate_mode.h:18:2: note: 'MIGRATE_SYNC' declared here
           MIGRATE_SYNC,
           ^
   1 error generated.


vim +2317 mm/vmscan.c

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
  2294		bool cma_cap = true;
  2295		struct page *page;
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
  2316			if (folio_zonenum(folio) > sc->reclaim_idx ||
> 2317				(get_pageblock_migratetype(page) == MIGRATE_CMA && !cma_cap)) {
  2318				nr_skipped[folio_zonenum(folio)] += nr_pages;
  2319				move_to = &folios_skipped;
  2320				goto move;
  2321			}
  2322	
  2323			/*
  2324			 * Do not count skipped folios because that makes the function
  2325			 * return with no isolated folios if the LRU mostly contains
  2326			 * ineligible folios.  This causes the VM to not reclaim any
  2327			 * folios, triggering a premature OOM.
  2328			 * Account all pages in a folio.
  2329			 */
  2330			scan += nr_pages;
  2331	
  2332			if (!folio_test_lru(folio))
  2333				goto move;
  2334			if (!sc->may_unmap && folio_mapped(folio))
  2335				goto move;
  2336	
  2337			/*
  2338			 * Be careful not to clear the lru flag until after we're
  2339			 * sure the folio is not being freed elsewhere -- the
  2340			 * folio release code relies on it.
  2341			 */
  2342			if (unlikely(!folio_try_get(folio)))
  2343				goto move;
  2344	
  2345			if (!folio_test_clear_lru(folio)) {
  2346				/* Another thread is already isolating this folio */
  2347				folio_put(folio);
  2348				goto move;
  2349			}
  2350	
  2351			nr_taken += nr_pages;
  2352			nr_zone_taken[folio_zonenum(folio)] += nr_pages;
  2353			move_to = dst;
  2354	move:
  2355			list_move(&folio->lru, move_to);
  2356		}
  2357	
  2358		/*
  2359		 * Splice any skipped folios to the start of the LRU list. Note that
  2360		 * this disrupts the LRU order when reclaiming for lower zones but
  2361		 * we cannot splice to the tail. If we did then the SWAP_CLUSTER_MAX
  2362		 * scanning would soon rescan the same folios to skip and waste lots
  2363		 * of cpu cycles.
  2364		 */
  2365		if (!list_empty(&folios_skipped)) {
  2366			int zid;
  2367	
  2368			list_splice(&folios_skipped, src);
  2369			for (zid = 0; zid < MAX_NR_ZONES; zid++) {
  2370				if (!nr_skipped[zid])
  2371					continue;
  2372	
  2373				__count_zid_vm_events(PGSCAN_SKIP, zid, nr_skipped[zid]);
  2374				skipped += nr_skipped[zid];
  2375			}
  2376		}
  2377		*nr_scanned = total_scan;
  2378		trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
  2379					    total_scan, skipped, nr_taken,
  2380					    sc->may_unmap ? 0 : ISOLATE_UNMAPPED, lru);
  2381		update_lru_sizes(lruvec, lru, nr_zone_taken);
  2382		return nr_taken;
  2383	}
  2384	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
