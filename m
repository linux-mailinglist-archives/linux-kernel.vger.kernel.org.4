Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03A55B905A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiINWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiINWET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:04:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92321647FE;
        Wed, 14 Sep 2022 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663193055; x=1694729055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p3oc3q2U/df+Y6Jf+6GoDWbjGub5SY7+B7D0sWSkZfM=;
  b=PT/0I9fkSfPzCUOBtlvbzOyAZBjla1I4SgSjenYiHeqC6mVKU8P3vO2g
   BKyVYq0I4F9lx3g+mPSu9lmOM+Lm+Zo9HyuYKDt1XsFQjGYHrsbvDf02+
   dNyIUSd6a1AIG2KV0Si0InxpF+H8tJf6Lxrc6q2/pJro1mQMgQ3CEA7ZL
   4nQjwpZbsssQlv/SxUEmuKm/PSNelaab2k6dJcQvRSjk7nzFCt0QMMMSG
   xSoT8P3tMQO7qMZRw6Jc7mjfVco0TNaDgXdxj1pM8Lh7ONY70nd7NfNg5
   9mJVJfxMMzB+Nn1LMaq5hB6CO+iukpUlxbw3QoUj9qjeAonwPWB0j/2xF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278938286"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278938286"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 15:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="720738892"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2022 15:04:09 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYaUK-0000bw-10;
        Wed, 14 Sep 2022 22:04:08 +0000
Date:   Thu, 15 Sep 2022 06:03:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
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
Message-ID: <202209150503.AZYsY64p-lkp@intel.com>
References: <20220913195508.3511038-19-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913195508.3511038-19-opendmb@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.0-rc5]
[cannot apply to akpm-mm/mm-everything next-20220914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Doug-Berger/mm-introduce-Designated-Movable-Blocks/20220914-040216
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220915/202209150503.AZYsY64p-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/635e919c92ca242c4b900bdfc7e21529e76f2f8e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Doug-Berger/mm-introduce-Designated-Movable-Blocks/20220914-040216
        git checkout 635e919c92ca242c4b900bdfc7e21529e76f2f8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/page_alloc.c:9236:5: warning: no previous prototype for '_alloc_contig_range' [-Wmissing-prototypes]
    9236 | int _alloc_contig_range(unsigned long start, unsigned long end,
         |     ^~~~~~~~~~~~~~~~~~~
   mm/page_alloc.c: In function 'alloc_contig_range':
>> mm/page_alloc.c:9390:36: error: 'MIGRATE_CMA' undeclared (first use in this function); did you mean 'MIGRATE_SYNC'?
    9390 |                 if (migratetype == MIGRATE_CMA)
         |                                    ^~~~~~~~~~~
         |                                    MIGRATE_SYNC
   mm/page_alloc.c:9390:36: note: each undeclared identifier is reported only once for each function it appears in


vim +9390 mm/page_alloc.c

  9361	
  9362	/**
  9363	 * alloc_contig_range() -- tries to allocate given range of pages
  9364	 * @start:	start PFN to allocate
  9365	 * @end:	one-past-the-last PFN to allocate
  9366	 * @migratetype:	migratetype of the underlying pageblocks (either
  9367	 *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
  9368	 *			in range must have the same migratetype and it must
  9369	 *			be either of the two.
  9370	 * @gfp_mask:	GFP mask to use during compaction
  9371	 *
  9372	 * The PFN range does not have to be pageblock aligned. The PFN range must
  9373	 * belong to a single zone.
  9374	 *
  9375	 * The first thing this routine does is attempt to MIGRATE_ISOLATE all
  9376	 * pageblocks in the range.  Once isolated, the pageblocks should not
  9377	 * be modified by others.
  9378	 *
  9379	 * Return: zero on success or negative error code.  On success all
  9380	 * pages which PFN is in [start, end) are allocated for the caller and
  9381	 * need to be freed with free_contig_range().
  9382	 */
  9383	int alloc_contig_range(unsigned long start, unsigned long end,
  9384			       unsigned int migratetype, gfp_t gfp_mask)
  9385	{
  9386		switch (dmb_intersects(start, end)) {
  9387		case DMB_DISJOINT:
  9388			break;
  9389		case DMB_INTERSECTS:
> 9390			if (migratetype == MIGRATE_CMA)
  9391				migratetype = MIGRATE_MOVABLE;
  9392			else
  9393				return -EBUSY;
  9394			break;
  9395		default:
  9396			return -EBUSY;
  9397		}
  9398	
  9399		return _alloc_contig_range(start, end, migratetype, gfp_mask);
  9400	}
  9401	EXPORT_SYMBOL(alloc_contig_range);
  9402	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
