Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A96A5BA586
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiIPDlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIPDkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:40:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D66718373;
        Thu, 15 Sep 2022 20:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663299640; x=1694835640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=60tFD3xEg408EPUHr8Aocf/iXMj9QRA0pthK3+fTnDs=;
  b=VUNJ+j2pGKKsdSi8bJrozRZWdER5rO6sZbMMc2+3aoIgu3jqzFtwI6g7
   +F+I5Vae8/e7jfCt2cby5W0qBLhdnAN/HXzCkT5TcbKIVVpFoAKpEJcbr
   e5EZrO/KHsxD1AW1kNgVExlbnK3QRrLVDZmMieCJQo/xHrTKh6O69hCnM
   KTn6fJhG7L2y2vrdiy1RHSyyGazHbc6DLvspP6BPqBACZyBGKEVcUgT3t
   cvqxUZUYH5dyii+w7MbHoyZnqCn8Ne1fF3V1IxorJ9iqIBK38+JnKgcPY
   nU2VLOqfz/MddYctdZt9tHrLT1IapuPjM8yJmdIgOizfiUmt1MScUhcYt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="278631642"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="278631642"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:40:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="862601342"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 15 Sep 2022 20:40:33 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZ2DQ-0001P3-2r;
        Fri, 16 Sep 2022 03:40:32 +0000
Date:   Fri, 16 Sep 2022 11:40:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/21] mm/page_isolation: protect cma from
 isolate_single_pageblock
Message-ID: <202209161112.0TpDtDXi-lkp@intel.com>
References: <20220913195508.3511038-2-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913195508.3511038-2-opendmb@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.0-rc5]
[cannot apply to akpm-mm/mm-everything next-20220915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Doug-Berger/mm-introduce-Designated-Movable-Blocks/20220914-040216
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220916/202209161112.0TpDtDXi-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/10d000298e8a6b50a40ccc90d0d638105255f6e2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Doug-Berger/mm-introduce-Designated-Movable-Blocks/20220914-040216
        git checkout 10d000298e8a6b50a40ccc90d0d638105255f6e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/page_isolation.c:309:6: warning: unused variable 'ret' [-Wunused-variable]
           int ret;
               ^
   1 warning generated.


vim +/ret +309 mm/page_isolation.c

a5d76b54a3f3a4 KAMEZAWA Hiroyuki 2007-10-16  281  
b2c9e2fbba3253 Zi Yan            2022-05-12  282  /**
b2c9e2fbba3253 Zi Yan            2022-05-12  283   * isolate_single_pageblock() -- tries to isolate a pageblock that might be
b2c9e2fbba3253 Zi Yan            2022-05-12  284   * within a free or in-use page.
b2c9e2fbba3253 Zi Yan            2022-05-12  285   * @boundary_pfn:		pageblock-aligned pfn that a page might cross
88ee134320b831 Zi Yan            2022-05-24  286   * @flags:			isolation flags
b2c9e2fbba3253 Zi Yan            2022-05-12  287   * @gfp_flags:			GFP flags used for migrating pages
b2c9e2fbba3253 Zi Yan            2022-05-12  288   * @isolate_before:	isolate the pageblock before the boundary_pfn
b2c9e2fbba3253 Zi Yan            2022-05-12  289   *
b2c9e2fbba3253 Zi Yan            2022-05-12  290   * Free and in-use pages can be as big as MAX_ORDER-1 and contain more than one
b2c9e2fbba3253 Zi Yan            2022-05-12  291   * pageblock. When not all pageblocks within a page are isolated at the same
b2c9e2fbba3253 Zi Yan            2022-05-12  292   * time, free page accounting can go wrong. For example, in the case of
b2c9e2fbba3253 Zi Yan            2022-05-12  293   * MAX_ORDER-1 = pageblock_order + 1, a MAX_ORDER-1 page has two pagelbocks.
b2c9e2fbba3253 Zi Yan            2022-05-12  294   * [         MAX_ORDER-1         ]
b2c9e2fbba3253 Zi Yan            2022-05-12  295   * [  pageblock0  |  pageblock1  ]
b2c9e2fbba3253 Zi Yan            2022-05-12  296   * When either pageblock is isolated, if it is a free page, the page is not
b2c9e2fbba3253 Zi Yan            2022-05-12  297   * split into separate migratetype lists, which is supposed to; if it is an
b2c9e2fbba3253 Zi Yan            2022-05-12  298   * in-use page and freed later, __free_one_page() does not split the free page
b2c9e2fbba3253 Zi Yan            2022-05-12  299   * either. The function handles this by splitting the free page or migrating
b2c9e2fbba3253 Zi Yan            2022-05-12  300   * the in-use page then splitting the free page.
b2c9e2fbba3253 Zi Yan            2022-05-12  301   */
88ee134320b831 Zi Yan            2022-05-24  302  static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
10d000298e8a6b Doug Berger       2022-09-13  303  			gfp_t gfp_flags, bool isolate_before)
b2c9e2fbba3253 Zi Yan            2022-05-12  304  {
b2c9e2fbba3253 Zi Yan            2022-05-12  305  	unsigned long start_pfn;
b2c9e2fbba3253 Zi Yan            2022-05-12  306  	unsigned long isolate_pageblock;
b2c9e2fbba3253 Zi Yan            2022-05-12  307  	unsigned long pfn;
b2c9e2fbba3253 Zi Yan            2022-05-12  308  	struct zone *zone;
88ee134320b831 Zi Yan            2022-05-24 @309  	int ret;
b2c9e2fbba3253 Zi Yan            2022-05-12  310  
b2c9e2fbba3253 Zi Yan            2022-05-12  311  	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));
b2c9e2fbba3253 Zi Yan            2022-05-12  312  
b2c9e2fbba3253 Zi Yan            2022-05-12  313  	if (isolate_before)
b2c9e2fbba3253 Zi Yan            2022-05-12  314  		isolate_pageblock = boundary_pfn - pageblock_nr_pages;
b2c9e2fbba3253 Zi Yan            2022-05-12  315  	else
b2c9e2fbba3253 Zi Yan            2022-05-12  316  		isolate_pageblock = boundary_pfn;
b2c9e2fbba3253 Zi Yan            2022-05-12  317  
b2c9e2fbba3253 Zi Yan            2022-05-12  318  	/*
b2c9e2fbba3253 Zi Yan            2022-05-12  319  	 * scan at the beginning of MAX_ORDER_NR_PAGES aligned range to avoid
b2c9e2fbba3253 Zi Yan            2022-05-12  320  	 * only isolating a subset of pageblocks from a bigger than pageblock
b2c9e2fbba3253 Zi Yan            2022-05-12  321  	 * free or in-use page. Also make sure all to-be-isolated pageblocks
b2c9e2fbba3253 Zi Yan            2022-05-12  322  	 * are within the same zone.
b2c9e2fbba3253 Zi Yan            2022-05-12  323  	 */
b2c9e2fbba3253 Zi Yan            2022-05-12  324  	zone  = page_zone(pfn_to_page(isolate_pageblock));
b2c9e2fbba3253 Zi Yan            2022-05-12  325  	start_pfn  = max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),
b2c9e2fbba3253 Zi Yan            2022-05-12  326  				      zone->zone_start_pfn);
b2c9e2fbba3253 Zi Yan            2022-05-12  327  
b2c9e2fbba3253 Zi Yan            2022-05-12  328  	/*
b2c9e2fbba3253 Zi Yan            2022-05-12  329  	 * Bail out early when the to-be-isolated pageblock does not form
b2c9e2fbba3253 Zi Yan            2022-05-12  330  	 * a free or in-use page across boundary_pfn:
b2c9e2fbba3253 Zi Yan            2022-05-12  331  	 *
b2c9e2fbba3253 Zi Yan            2022-05-12  332  	 * 1. isolate before boundary_pfn: the page after is not online
b2c9e2fbba3253 Zi Yan            2022-05-12  333  	 * 2. isolate after boundary_pfn: the page before is not online
b2c9e2fbba3253 Zi Yan            2022-05-12  334  	 *
b2c9e2fbba3253 Zi Yan            2022-05-12  335  	 * This also ensures correctness. Without it, when isolate after
b2c9e2fbba3253 Zi Yan            2022-05-12  336  	 * boundary_pfn and [start_pfn, boundary_pfn) are not online,
b2c9e2fbba3253 Zi Yan            2022-05-12  337  	 * __first_valid_page() will return unexpected NULL in the for loop
b2c9e2fbba3253 Zi Yan            2022-05-12  338  	 * below.
b2c9e2fbba3253 Zi Yan            2022-05-12  339  	 */
b2c9e2fbba3253 Zi Yan            2022-05-12  340  	if (isolate_before) {
b2c9e2fbba3253 Zi Yan            2022-05-12  341  		if (!pfn_to_online_page(boundary_pfn))
b2c9e2fbba3253 Zi Yan            2022-05-12  342  			return 0;
b2c9e2fbba3253 Zi Yan            2022-05-12  343  	} else {
b2c9e2fbba3253 Zi Yan            2022-05-12  344  		if (!pfn_to_online_page(boundary_pfn - 1))
b2c9e2fbba3253 Zi Yan            2022-05-12  345  			return 0;
b2c9e2fbba3253 Zi Yan            2022-05-12  346  	}
b2c9e2fbba3253 Zi Yan            2022-05-12  347  
b2c9e2fbba3253 Zi Yan            2022-05-12  348  	for (pfn = start_pfn; pfn < boundary_pfn;) {
b2c9e2fbba3253 Zi Yan            2022-05-12  349  		struct page *page = __first_valid_page(pfn, boundary_pfn - pfn);
b2c9e2fbba3253 Zi Yan            2022-05-12  350  
b2c9e2fbba3253 Zi Yan            2022-05-12  351  		VM_BUG_ON(!page);
b2c9e2fbba3253 Zi Yan            2022-05-12  352  		pfn = page_to_pfn(page);
b2c9e2fbba3253 Zi Yan            2022-05-12  353  		/*
b2c9e2fbba3253 Zi Yan            2022-05-12  354  		 * start_pfn is MAX_ORDER_NR_PAGES aligned, if there is any
b2c9e2fbba3253 Zi Yan            2022-05-12  355  		 * free pages in [start_pfn, boundary_pfn), its head page will
b2c9e2fbba3253 Zi Yan            2022-05-12  356  		 * always be in the range.
b2c9e2fbba3253 Zi Yan            2022-05-12  357  		 */
b2c9e2fbba3253 Zi Yan            2022-05-12  358  		if (PageBuddy(page)) {
b2c9e2fbba3253 Zi Yan            2022-05-12  359  			int order = buddy_order(page);
b2c9e2fbba3253 Zi Yan            2022-05-12  360  
86d28b0709279c Zi Yan            2022-05-26  361  			if (pfn + (1UL << order) > boundary_pfn) {
86d28b0709279c Zi Yan            2022-05-26  362  				/* free page changed before split, check it again */
86d28b0709279c Zi Yan            2022-05-26  363  				if (split_free_page(page, order, boundary_pfn - pfn))
86d28b0709279c Zi Yan            2022-05-26  364  					continue;
86d28b0709279c Zi Yan            2022-05-26  365  			}
86d28b0709279c Zi Yan            2022-05-26  366  
86d28b0709279c Zi Yan            2022-05-26  367  			pfn += 1UL << order;
b2c9e2fbba3253 Zi Yan            2022-05-12  368  			continue;
b2c9e2fbba3253 Zi Yan            2022-05-12  369  		}
b2c9e2fbba3253 Zi Yan            2022-05-12  370  		/*
b2c9e2fbba3253 Zi Yan            2022-05-12  371  		 * migrate compound pages then let the free page handling code
b2c9e2fbba3253 Zi Yan            2022-05-12  372  		 * above do the rest. If migration is not possible, just fail.
b2c9e2fbba3253 Zi Yan            2022-05-12  373  		 */
b2c9e2fbba3253 Zi Yan            2022-05-12  374  		if (PageCompound(page)) {
b2c9e2fbba3253 Zi Yan            2022-05-12  375  			struct page *head = compound_head(page);
b2c9e2fbba3253 Zi Yan            2022-05-12  376  			unsigned long head_pfn = page_to_pfn(head);
547be963c99f1e Zi Yan            2022-05-30  377  			unsigned long nr_pages = compound_nr(head);
b2c9e2fbba3253 Zi Yan            2022-05-12  378  
88ee134320b831 Zi Yan            2022-05-24  379  			if (head_pfn + nr_pages <= boundary_pfn) {
b2c9e2fbba3253 Zi Yan            2022-05-12  380  				pfn = head_pfn + nr_pages;
b2c9e2fbba3253 Zi Yan            2022-05-12  381  				continue;
b2c9e2fbba3253 Zi Yan            2022-05-12  382  			}
b2c9e2fbba3253 Zi Yan            2022-05-12  383  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
b2c9e2fbba3253 Zi Yan            2022-05-12  384  			/*
b2c9e2fbba3253 Zi Yan            2022-05-12  385  			 * hugetlb, lru compound (THP), and movable compound pages
b2c9e2fbba3253 Zi Yan            2022-05-12  386  			 * can be migrated. Otherwise, fail the isolation.
b2c9e2fbba3253 Zi Yan            2022-05-12  387  			 */
b2c9e2fbba3253 Zi Yan            2022-05-12  388  			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
b2c9e2fbba3253 Zi Yan            2022-05-12  389  				int order;
b2c9e2fbba3253 Zi Yan            2022-05-12  390  				unsigned long outer_pfn;
88ee134320b831 Zi Yan            2022-05-24  391  				int page_mt = get_pageblock_migratetype(page);
88ee134320b831 Zi Yan            2022-05-24  392  				bool isolate_page = !is_migrate_isolate_page(page);
b2c9e2fbba3253 Zi Yan            2022-05-12  393  				struct compact_control cc = {
b2c9e2fbba3253 Zi Yan            2022-05-12  394  					.nr_migratepages = 0,
b2c9e2fbba3253 Zi Yan            2022-05-12  395  					.order = -1,
b2c9e2fbba3253 Zi Yan            2022-05-12  396  					.zone = page_zone(pfn_to_page(head_pfn)),
b2c9e2fbba3253 Zi Yan            2022-05-12  397  					.mode = MIGRATE_SYNC,
b2c9e2fbba3253 Zi Yan            2022-05-12  398  					.ignore_skip_hint = true,
b2c9e2fbba3253 Zi Yan            2022-05-12  399  					.no_set_skip_hint = true,
b2c9e2fbba3253 Zi Yan            2022-05-12  400  					.gfp_mask = gfp_flags,
b2c9e2fbba3253 Zi Yan            2022-05-12  401  					.alloc_contig = true,
b2c9e2fbba3253 Zi Yan            2022-05-12  402  				};
b2c9e2fbba3253 Zi Yan            2022-05-12  403  				INIT_LIST_HEAD(&cc.migratepages);
b2c9e2fbba3253 Zi Yan            2022-05-12  404  
88ee134320b831 Zi Yan            2022-05-24  405  				/*
88ee134320b831 Zi Yan            2022-05-24  406  				 * XXX: mark the page as MIGRATE_ISOLATE so that
88ee134320b831 Zi Yan            2022-05-24  407  				 * no one else can grab the freed page after migration.
88ee134320b831 Zi Yan            2022-05-24  408  				 * Ideally, the page should be freed as two separate
88ee134320b831 Zi Yan            2022-05-24  409  				 * pages to be added into separate migratetype free
88ee134320b831 Zi Yan            2022-05-24  410  				 * lists.
88ee134320b831 Zi Yan            2022-05-24  411  				 */
88ee134320b831 Zi Yan            2022-05-24  412  				if (isolate_page) {
88ee134320b831 Zi Yan            2022-05-24  413  					ret = set_migratetype_isolate(page, page_mt,
88ee134320b831 Zi Yan            2022-05-24  414  						flags, head_pfn, head_pfn + nr_pages);
88ee134320b831 Zi Yan            2022-05-24  415  					if (ret)
10d000298e8a6b Doug Berger       2022-09-13  416  						return ret;
88ee134320b831 Zi Yan            2022-05-24  417  				}
88ee134320b831 Zi Yan            2022-05-24  418  
b2c9e2fbba3253 Zi Yan            2022-05-12  419  				ret = __alloc_contig_migrate_range(&cc, head_pfn,
b2c9e2fbba3253 Zi Yan            2022-05-12  420  							head_pfn + nr_pages);
b2c9e2fbba3253 Zi Yan            2022-05-12  421  
88ee134320b831 Zi Yan            2022-05-24  422  				/*
88ee134320b831 Zi Yan            2022-05-24  423  				 * restore the page's migratetype so that it can
88ee134320b831 Zi Yan            2022-05-24  424  				 * be split into separate migratetype free lists
88ee134320b831 Zi Yan            2022-05-24  425  				 * later.
88ee134320b831 Zi Yan            2022-05-24  426  				 */
88ee134320b831 Zi Yan            2022-05-24  427  				if (isolate_page)
88ee134320b831 Zi Yan            2022-05-24  428  					unset_migratetype_isolate(page, page_mt);
88ee134320b831 Zi Yan            2022-05-24  429  
b2c9e2fbba3253 Zi Yan            2022-05-12  430  				if (ret)
10d000298e8a6b Doug Berger       2022-09-13  431  					return -EBUSY;
b2c9e2fbba3253 Zi Yan            2022-05-12  432  				/*
b2c9e2fbba3253 Zi Yan            2022-05-12  433  				 * reset pfn to the head of the free page, so
b2c9e2fbba3253 Zi Yan            2022-05-12  434  				 * that the free page handling code above can split
b2c9e2fbba3253 Zi Yan            2022-05-12  435  				 * the free page to the right migratetype list.
b2c9e2fbba3253 Zi Yan            2022-05-12  436  				 *
b2c9e2fbba3253 Zi Yan            2022-05-12  437  				 * head_pfn is not used here as a hugetlb page order
b2c9e2fbba3253 Zi Yan            2022-05-12  438  				 * can be bigger than MAX_ORDER-1, but after it is
b2c9e2fbba3253 Zi Yan            2022-05-12  439  				 * freed, the free page order is not. Use pfn within
b2c9e2fbba3253 Zi Yan            2022-05-12  440  				 * the range to find the head of the free page.
b2c9e2fbba3253 Zi Yan            2022-05-12  441  				 */
b2c9e2fbba3253 Zi Yan            2022-05-12  442  				order = 0;
b2c9e2fbba3253 Zi Yan            2022-05-12  443  				outer_pfn = pfn;
b2c9e2fbba3253 Zi Yan            2022-05-12  444  				while (!PageBuddy(pfn_to_page(outer_pfn))) {
88ee134320b831 Zi Yan            2022-05-24  445  					/* stop if we cannot find the free page */
88ee134320b831 Zi Yan            2022-05-24  446  					if (++order >= MAX_ORDER)
10d000298e8a6b Doug Berger       2022-09-13  447  						return -EBUSY;
b2c9e2fbba3253 Zi Yan            2022-05-12  448  					outer_pfn &= ~0UL << order;
b2c9e2fbba3253 Zi Yan            2022-05-12  449  				}
b2c9e2fbba3253 Zi Yan            2022-05-12  450  				pfn = outer_pfn;
b2c9e2fbba3253 Zi Yan            2022-05-12  451  				continue;
b2c9e2fbba3253 Zi Yan            2022-05-12  452  			} else
b2c9e2fbba3253 Zi Yan            2022-05-12  453  #endif
10d000298e8a6b Doug Berger       2022-09-13  454  				return -EBUSY;
b2c9e2fbba3253 Zi Yan            2022-05-12  455  		}
b2c9e2fbba3253 Zi Yan            2022-05-12  456  
b2c9e2fbba3253 Zi Yan            2022-05-12  457  		pfn++;
b2c9e2fbba3253 Zi Yan            2022-05-12  458  	}
b2c9e2fbba3253 Zi Yan            2022-05-12  459  	return 0;
b2c9e2fbba3253 Zi Yan            2022-05-12  460  }
b2c9e2fbba3253 Zi Yan            2022-05-12  461  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
