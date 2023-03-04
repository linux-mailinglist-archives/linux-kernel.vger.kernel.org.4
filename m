Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789626AA7AD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 03:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCDCqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 21:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCDCqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 21:46:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F827AAC;
        Fri,  3 Mar 2023 18:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677897996; x=1709433996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l/A99rMM5WHL0wv+tSavfNrlLcDVEGZfVCVXimd15eM=;
  b=ed4MVFEkgrEAxdj3JoMr7zQE5ERYuaOFOhWvQc5kKnCb8pg3ElGZH6s9
   6uOWzhghyGytH3bgnThsU4OUArgeAfuuuQo9OeBo285spMdID7Ozz4hQb
   DgzhTxCoj6UmmNuYALILFw1gv4N3pSHDX1zHNzNq4cD3LPeZs065q4f2C
   aTW4Gy1w0c/GjZO5ley6nbpi6w3Bd/qOilj9JSIxQhNRk6wvGhLyMWCE+
   ajWLLfvs3ABzF3GZPp9xhiI0suQMP+MIN909OpFxV4WPhqKScXPcKpRnl
   BTm36NtOKLjUPoO35Et2aMSP/TPXU7Fo6yysSdqcOUW8YBbJFAyGjvla4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="421484483"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="421484483"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 18:46:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="705850369"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="705850369"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2023 18:46:32 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYHup-0001oS-2O;
        Sat, 04 Mar 2023 02:46:31 +0000
Date:   Sat, 4 Mar 2023 10:46:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org, dan.j.williams@intel.com, bwidawsk@kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, linuxarm@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] cxl/pci: Find and register CXL PMU devices
Message-ID: <202303041001.G9OUGQ6l-lkp@intel.com>
References: <20230303175022.10806-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303175022.10806-3-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I love your patch! Yet something to improve:

[auto build test ERROR on cxl/next]
[also build test ERROR on cxl/pending linus/master next-20230303]
[cannot apply to v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230304-015342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20230303175022.10806-3-Jonathan.Cameron%40huawei.com
patch subject: [PATCH 2/4] cxl/pci: Find and register CXL PMU devices
config: alpha-randconfig-r003-20230302 (https://download.01.org/0day-ci/archive/20230304/202303041001.G9OUGQ6l-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0790ed82bb7adf04c834e8c03008b92c1b23945e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230304-015342
        git checkout 0790ed82bb7adf04c834e8c03008b92c1b23945e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303041001.G9OUGQ6l-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/core/regs.c:9:10: fatal error: cpmu.h: No such file or directory
       9 | #include <cpmu.h>
         |          ^~~~~~~~
   compilation terminated.
--
>> drivers/cxl/core/cpmu.c:8:10: fatal error: cpmu.h: No such file or directory
       8 | #include <cpmu.h>
         |          ^~~~~~~~
   compilation terminated.


vim +9 drivers/cxl/core/regs.c

   > 9	#include <cpmu.h>
    10	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
