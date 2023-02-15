Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7FA6974B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBODQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBODQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:16:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF042A16B;
        Tue, 14 Feb 2023 19:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676430994; x=1707966994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qN9JNqvO8efDhHVxxvUM6UWhSYbcjd/gf/y/wf4dMOI=;
  b=Lo6ZzKXc11X/jPt9BUikEsisnJoKMk5v2iMPoYXlpwWYZR0nTKNhECgb
   uFjiqOIseVcfimaR/0kV0BIoS/NagUeIm4cmgBij+oQQHBm0YDxxTs+G0
   +76H2HLvEYCNb87CA/w34aIS1vbsyYK+7lpCLmPm8g3Zm42EyhGG+5Bp8
   TiSTuhPB9SNeq7BzRrooM2ZGJSSJtC+ItPPOKdZQ7z+Y5zeBfwVxi3mzv
   M/VTz4BXh5T29szeTJBjsGunZll/YYq4UBFwL6SVqJLbSDWPZEcY2b3hN
   QnVmI8pyL+tIWjGngxGYZQChys3+i6Kc0jTRoGA028deVVRz2cK4G46HQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358750930"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="358750930"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 19:16:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="662776464"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="662776464"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2023 19:16:30 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pS8HV-0008yf-2C;
        Wed, 15 Feb 2023 03:16:29 +0000
Date:   Wed, 15 Feb 2023 11:16:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yang Shi <shy828301@gmail.com>, mgorman@techsingularity.net,
        agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 3/5] mm: mempool: introduce page bulk allocator
Message-ID: <202302151051.i9q3I0ia-lkp@intel.com>
References: <20230214190221.1156876-4-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214190221.1156876-4-shy828301@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc8 next-20230214]
[cannot apply to device-mapper-dm/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Shi/mm-page_alloc-add-API-for-bulk-allocator-with-callback/20230215-030305
patch link:    https://lore.kernel.org/r/20230214190221.1156876-4-shy828301%40gmail.com
patch subject: [v2 PATCH 3/5] mm: mempool: introduce page bulk allocator
config: loongarch-randconfig-r006-20230212 (https://download.01.org/0day-ci/archive/20230215/202302151051.i9q3I0ia-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ecf5ea78b27092c35d884fad653f53d599d9ddba
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yang-Shi/mm-page_alloc-add-API-for-bulk-allocator-with-callback/20230215-030305
        git checkout ecf5ea78b27092c35d884fad653f53d599d9ddba
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/scsi/snic/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302151051.i9q3I0ia-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/scsi/snic/snic_scsi.c:4:
>> include/linux/mempool.h:18:48: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
      18 |                                         struct page **page_array,
         |                                                ^~~~
   include/linux/mempool.h:71:51: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
      71 |                                            struct page **page_array);
         |                                                   ^~~~
   include/linux/mempool.h:74:59: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
      74 |                                         void (*cb)(struct page *, void *),
         |                                                           ^~~~


vim +18 include/linux/mempool.h

    15	
    16	typedef unsigned int (mempool_alloc_pages_bulk_t)(gfp_t gfp_mask,
    17						unsigned int nr, void *pool_data,
  > 18						struct page **page_array,
    19						void (*cb)(struct page *, void *),
    20						void *data);
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
