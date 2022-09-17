Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C181E5BB646
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIQE0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIQEZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:25:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3FF88DF6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663388757; x=1694924757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=25a6fRcULjjWqr0R/xmih1kXVQMbg8zdD5dsLzog9IY=;
  b=Lsop2czROGptOm+ucDDARUG1D+mofysb5xDI0mZCci6g0gL2SRWYK93f
   UqBD9r5CsL1N1IR4wFYuilyRzPtVrR6XXvp1aD9Gi/oWvc440GtWJNFuw
   GK1m3Imfvdho8VfD7Z5TnMWkLV5xLXWq+DGVLb9hamlj9nFfrBMGdNghS
   v1d8mJxyajIGPsRi9eFrtKKxF2mpnYmBlZGPCtk+bJsKqiyie0W5OyJnF
   k5DGO47MSrWV8cur09nCmGkvBKhf9E23ab/FIIbdRL3LtYpXu5Qg6A5ac
   K6PE0GhXF1moyfNFC7PLxF7Q8VFxuBtgVdYSDvbZGAWzP9vJegBXAAkNp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299944985"
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="299944985"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 21:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="648496070"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Sep 2022 21:25:55 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZPOs-0002To-1z;
        Sat, 17 Sep 2022 04:25:54 +0000
Date:   Sat, 17 Sep 2022 12:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhong <floridsleeves@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, akpm@linux-foundation.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: Re: [PATCH v1] mm/vmscan: check the return value of migrate_pages()
Message-ID: <202209171222.QsovW80r-lkp@intel.com>
References: <20220917021257.3840548-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917021257.3840548-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc5]
[cannot apply to akpm-mm/mm-everything next-20220916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhong/mm-vmscan-check-the-return-value-of-migrate_pages/20220917-101433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a335366bad1364a07f49df9da1fdfa6d411a5f39
config: arc-randconfig-r043-20220916 (https://download.01.org/0day-ci/archive/20220917/202209171222.QsovW80r-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0ea516d584bd904c43954e312ac42fced822dcf7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Zhong/mm-vmscan-check-the-return-value-of-migrate_pages/20220917-101433
        git checkout 0ea516d584bd904c43954e312ac42fced822dcf7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/vmscan.c: In function 'demote_page_list':
>> mm/vmscan.c:1564:40: error: 'pagelist' undeclared (first use in this function)
    1564 |                 putback_movable_pages(&pagelist);
         |                                        ^~~~~~~~
   mm/vmscan.c:1564:40: note: each undeclared identifier is reported only once for each function it appears in


vim +/pagelist +1564 mm/vmscan.c

  1539	
  1540	/*
  1541	 * Take pages on @demote_list and attempt to demote them to
  1542	 * another node.  Pages which are not demoted are left on
  1543	 * @demote_pages.
  1544	 */
  1545	static unsigned int demote_page_list(struct list_head *demote_pages,
  1546					     struct pglist_data *pgdat)
  1547	{
  1548		int target_nid = next_demotion_node(pgdat->node_id);
  1549		unsigned int nr_succeeded;
  1550		int ret;
  1551	
  1552		if (list_empty(demote_pages))
  1553			return 0;
  1554	
  1555		if (target_nid == NUMA_NO_NODE)
  1556			return 0;
  1557	
  1558		/* Demotion ignores all cpuset and mempolicy settings */
  1559		ret = migrate_pages(demote_pages, alloc_demote_page, NULL,
  1560				    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
  1561				    &nr_succeeded);
  1562	
  1563		if (ret)
> 1564			putback_movable_pages(&pagelist);
  1565	
  1566		if (current_is_kswapd())
  1567			__count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
  1568		else
  1569			__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
  1570	
  1571		return nr_succeeded;
  1572	}
  1573	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
