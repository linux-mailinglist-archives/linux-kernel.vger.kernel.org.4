Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E5B6EB246
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjDUTdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjDUTda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:33:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7152689
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682105607; x=1713641607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yHrEfHYdBfmX0sXULWVVwq6T6mEzJwmFiWY/9EbRX9M=;
  b=PgEYMyCrB0cAzXO6DM+p68MSpgGMtMDuMbJhDgJbctMAwP49etD6PKW1
   uZruCGC/0W94zU7/i9VJ+6IHZV+zmw6XwiC4XBW2ru+bcV/mjqMO66NI3
   AUdGuWrFLwYREASUvlKwLkyjrjExY4CvJtF2oTdgz7xmBdQhBN1wfQbLW
   RXgMJCqC2Sf4GGqjh3m2j/P/dVzSbvri2s9oQfHjUDFGI3GycLry5Qlcr
   0+m37jvgR61ayIv0X2frhQR0ybcskScIGCr3zpty5tGKwdGJBkoSVBnS6
   rBnNq1Wiu33pvBFTlXxlTw4Ehkla+XZpjNLpml+RydqCnb/Ao09B5rrgL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="409003693"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="409003693"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 12:33:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="803833372"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="803833372"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2023 12:33:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppwVU-000gkm-24;
        Fri, 21 Apr 2023 19:33:20 +0000
Date:   Sat, 22 Apr 2023 03:32:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v4 3/3] mm,page_owner: Filter out stacks by a threshold
 counter
Message-ID: <202304220331.FdXghWlY-lkp@intel.com>
References: <20230421101415.5734-4-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421101415.5734-4-osalvador@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc7]
[cannot apply to akpm-mm/mm-everything next-20230420]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/lib-stackdepot-Add-a-refcount-field-in-stack_record/20230421-181709
base:   linus/master
patch link:    https://lore.kernel.org/r/20230421101415.5734-4-osalvador%40suse.de
patch subject: [PATCH v4 3/3] mm,page_owner: Filter out stacks by a threshold counter
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20230422/202304220331.FdXghWlY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/716d3f03add56cf9ed9ae5e49d73cf7e0cbfcb19
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Oscar-Salvador/lib-stackdepot-Add-a-refcount-field-in-stack_record/20230421-181709
        git checkout 716d3f03add56cf9ed9ae5e49d73cf7e0cbfcb19
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304220331.FdXghWlY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/debugfs.h:15,
                    from mm/page_owner.c:2:
   mm/page_owner.c: In function 'proc_page_owner_threshold_open':
>> mm/page_owner.c:747:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'long long unsigned int' [-Wformat=]
     747 |                         &page_owner_threshold_set, "%lu");
         |                                                    ^~~~~
   include/linux/fs.h:3066:36: note: in definition of macro 'DEFINE_SIMPLE_ATTRIBUTE_XSIGNED'
    3066 |         __simple_attr_check_format(__fmt, 0ull);                        \
         |                                    ^~~~~
   mm/page_owner.c:746:1: note: in expansion of macro 'DEFINE_SIMPLE_ATTRIBUTE'
     746 | DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
         | ^~~~~~~~~~~~~~~~~~~~~~~
   mm/page_owner.c:747:55: note: format string is defined here
     747 |                         &page_owner_threshold_set, "%lu");
         |                                                     ~~^
         |                                                       |
         |                                                       long unsigned int
         |                                                     %llu


vim +747 mm/page_owner.c

   745	
   746	DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
 > 747				&page_owner_threshold_set, "%lu");
   748	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
