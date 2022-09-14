Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B25B8DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiINRIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiINRIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:08:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F284A815;
        Wed, 14 Sep 2022 10:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663175292; x=1694711292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H3Q2dCshLHXiyNfBuzyi9AzD37fPh22mEf4ZIc/U4Oc=;
  b=e39atokjhvmGl5BBN/vdY9VJGPnkpBoib7p0SRw/H+Xs4Cur0VlDjti8
   A2NHhd5VsNTPlzRNXeStipQ+JLdYLqXZwItqM79rU7btwBIEb4QhV5pDx
   ZwLyJ1FsM3tybhDY3amUzPo0YWRfjbDyWaU2FSjDL2tY5svKzeVhtJdGM
   jLnUT06b0/1RQoSZcLaQgR3rN+ErcBmkExXSjKTGpR+R4QIru/xc1RUyH
   u2DRlSAi0QAujjeelqcIu1XU54r7RjYdgcC1jxqSzdC1/ZVxg3+oqypP/
   11fE8vAFdiDumlI5AD0Vn96fSyqaNQjqUkhKjSCrFBhXSyfKjE8UGhMkV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278215623"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278215623"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 10:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="619384021"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 14 Sep 2022 10:08:04 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYVrn-0000Pe-2J;
        Wed, 14 Sep 2022 17:08:03 +0000
Date:   Thu, 15 Sep 2022 01:07:22 +0800
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
Subject: Re: [PATCH 18/21] mm/cma: support CMA in Designated Movable Blocks
Message-ID: <202209150009.PoWlLoNu-lkp@intel.com>
References: <20220913195508.3511038-19-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913195508.3511038-19-opendmb@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.0-rc5]
[cannot apply to akpm-mm/mm-everything next-20220914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Doug-Berger/mm-introduce-Designated-Movable-Blocks/20220914-040216
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220915/202209150009.PoWlLoNu-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/635e919c92ca242c4b900bdfc7e21529e76f2f8e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Doug-Berger/mm-introduce-Designated-Movable-Blocks/20220914-040216
        git checkout 635e919c92ca242c4b900bdfc7e21529e76f2f8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/page_alloc.c:9236:5: warning: no previous prototype for function '_alloc_contig_range' [-Wmissing-prototypes]
   int _alloc_contig_range(unsigned long start, unsigned long end,
       ^
   mm/page_alloc.c:9236:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int _alloc_contig_range(unsigned long start, unsigned long end,
   ^
   static 
   1 warning generated.


vim +/_alloc_contig_range +9236 mm/page_alloc.c

  9235	
> 9236	int _alloc_contig_range(unsigned long start, unsigned long end,
  9237				unsigned int migratetype, gfp_t gfp_mask)
  9238	{
  9239		unsigned long outer_start, outer_end;
  9240		int order;
  9241		int ret = 0;
  9242	
  9243		struct compact_control cc = {
  9244			.nr_migratepages = 0,
  9245			.order = -1,
  9246			.zone = page_zone(pfn_to_page(start)),
  9247			.mode = MIGRATE_SYNC,
  9248			.ignore_skip_hint = true,
  9249			.no_set_skip_hint = true,
  9250			.gfp_mask = current_gfp_context(gfp_mask),
  9251			.alloc_contig = true,
  9252		};
  9253		INIT_LIST_HEAD(&cc.migratepages);
  9254	
  9255		/*
  9256		 * What we do here is we mark all pageblocks in range as
  9257		 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
  9258		 * have different sizes, and due to the way page allocator
  9259		 * work, start_isolate_page_range() has special handlings for this.
  9260		 *
  9261		 * Once the pageblocks are marked as MIGRATE_ISOLATE, we
  9262		 * migrate the pages from an unaligned range (ie. pages that
  9263		 * we are interested in). This will put all the pages in
  9264		 * range back to page allocator as MIGRATE_ISOLATE.
  9265		 *
  9266		 * When this is done, we take the pages in range from page
  9267		 * allocator removing them from the buddy system.  This way
  9268		 * page allocator will never consider using them.
  9269		 *
  9270		 * This lets us mark the pageblocks back as
  9271		 * MIGRATE_CMA/MIGRATE_MOVABLE so that free pages in the
  9272		 * aligned range but not in the unaligned, original range are
  9273		 * put back to page allocator so that buddy can use them.
  9274		 */
  9275	
  9276		ret = start_isolate_page_range(start, end, migratetype, 0, gfp_mask);
  9277		if (ret)
  9278			goto done;
  9279	
  9280		drain_all_pages(cc.zone);
  9281	
  9282		/*
  9283		 * In case of -EBUSY, we'd like to know which page causes problem.
  9284		 * So, just fall through. test_pages_isolated() has a tracepoint
  9285		 * which will report the busy page.
  9286		 *
  9287		 * It is possible that busy pages could become available before
  9288		 * the call to test_pages_isolated, and the range will actually be
  9289		 * allocated.  So, if we fall through be sure to clear ret so that
  9290		 * -EBUSY is not accidentally used or returned to caller.
  9291		 */
  9292		ret = __alloc_contig_migrate_range(&cc, start, end);
  9293		if (ret && ret != -EBUSY)
  9294			goto done;
  9295		ret = 0;
  9296		sync_hugetlb_dissolve();
  9297	
  9298		/*
  9299		 * Pages from [start, end) are within a pageblock_nr_pages
  9300		 * aligned blocks that are marked as MIGRATE_ISOLATE.  What's
  9301		 * more, all pages in [start, end) are free in page allocator.
  9302		 * What we are going to do is to allocate all pages from
  9303		 * [start, end) (that is remove them from page allocator).
  9304		 *
  9305		 * The only problem is that pages at the beginning and at the
  9306		 * end of interesting range may be not aligned with pages that
  9307		 * page allocator holds, ie. they can be part of higher order
  9308		 * pages.  Because of this, we reserve the bigger range and
  9309		 * once this is done free the pages we are not interested in.
  9310		 *
  9311		 * We don't have to hold zone->lock here because the pages are
  9312		 * isolated thus they won't get removed from buddy.
  9313		 */
  9314	
  9315		order = 0;
  9316		outer_start = start;
  9317		while (!PageBuddy(pfn_to_page(outer_start))) {
  9318			if (++order >= MAX_ORDER) {
  9319				outer_start = start;
  9320				break;
  9321			}
  9322			outer_start &= ~0UL << order;
  9323		}
  9324	
  9325		if (outer_start != start) {
  9326			order = buddy_order(pfn_to_page(outer_start));
  9327	
  9328			/*
  9329			 * outer_start page could be small order buddy page and
  9330			 * it doesn't include start page. Adjust outer_start
  9331			 * in this case to report failed page properly
  9332			 * on tracepoint in test_pages_isolated()
  9333			 */
  9334			if (outer_start + (1UL << order) <= start)
  9335				outer_start = start;
  9336		}
  9337	
  9338		/* Make sure the range is really isolated. */
  9339		if (test_pages_isolated(outer_start, end, 0)) {
  9340			ret = -EBUSY;
  9341			goto done;
  9342		}
  9343	
  9344		/* Grab isolated pages from freelists. */
  9345		outer_end = isolate_freepages_range(&cc, outer_start, end);
  9346		if (!outer_end) {
  9347			ret = -EBUSY;
  9348			goto done;
  9349		}
  9350	
  9351		/* Free head and tail (if any) */
  9352		if (start != outer_start)
  9353			free_contig_range(outer_start, start - outer_start);
  9354		if (end != outer_end)
  9355			free_contig_range(end, outer_end - end);
  9356	
  9357	done:
  9358		undo_isolate_page_range(start, end, migratetype);
  9359		return ret;
  9360	}
  9361	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
