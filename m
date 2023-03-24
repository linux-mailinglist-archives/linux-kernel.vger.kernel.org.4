Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE03A6C8735
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjCXVE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXVEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:04:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EFC166C1;
        Fri, 24 Mar 2023 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679691863; x=1711227863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lrh8mfNbujVclko7AoZ5oMBIAjQ3E9uh/4Jho+AveiE=;
  b=ktB3mKp7GHM8FtDdQEmQBqqE5DG+C8c/RWSAulIKI7UiErMPOwjhyYJU
   xlhE5wtGtWZonikpGzWLwU4zCmcyWQTqLan4TiYpXXDY2ZGOJQnTa5pb/
   IkgwaRpXpg4kX/QUpelD1DDftXNkTgVclmXHQxaE6q1ZPiIvmF3c7F0Uh
   /Q3kfR+MvJrpESs4/wBayVFg6hAQR7PuRuyOWKbgPfH0vg7qG2RM6Wsch
   5jHVc3VuA12gETTAQVgemaC76Icd/oYL7yWOrBnGfU5uUPg+w1CuaVkFN
   hBelcL1YV4fTyab0YFiaSQQlJlv+orGAli/+5EgdKpXfbX3GSDbkEjtRR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="338608054"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="338608054"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 14:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="793584347"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="793584347"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Mar 2023 14:01:33 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfoXU-000Fee-2t;
        Fri, 24 Mar 2023 21:01:32 +0000
Date:   Sat, 25 Mar 2023 05:01:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        linux-cxl@vger.kernel.org, peterz@infradead.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org, dan.j.williams@intel.com, linuxarm@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 3/5] cxl/pci: Find and register CXL PMU devices
Message-ID: <202303250419.FANh4fIC-lkp@intel.com>
References: <20230324171313.18448-4-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324171313.18448-4-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I love your patch! Yet something to improve:

[auto build test ERROR on acme/perf/core]
[also build test ERROR on tip/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
patch link:    https://lore.kernel.org/r/20230324171313.18448-4-Jonathan.Cameron%40huawei.com
patch subject: [PATCH v2 3/5] cxl/pci: Find and register CXL PMU devices
config: arm-randconfig-r023-20230322 (https://download.01.org/0day-ci/archive/20230325/202303250419.FANh4fIC-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/ab99ab31e5c4aa9f68425f3505f22a790d64bfe9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
        git checkout ab99ab31e5c4aa9f68425f3505f22a790d64bfe9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303250419.FANh4fIC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/core/port.c:60:20: error: use of undeclared identifier 'cxl_cpmu_type'; did you mean 'cxl_bus_type'?
           if (dev->type == &cxl_cpmu_type)
                             ^~~~~~~~~~~~~
                             cxl_bus_type
   drivers/cxl/cxl.h:732:24: note: 'cxl_bus_type' declared here
   extern struct bus_type cxl_bus_type;
                          ^
   1 error generated.


vim +60 drivers/cxl/core/port.c

    40	
    41	static int cxl_device_id(const struct device *dev)
    42	{
    43		if (dev->type == &cxl_nvdimm_bridge_type)
    44			return CXL_DEVICE_NVDIMM_BRIDGE;
    45		if (dev->type == &cxl_nvdimm_type)
    46			return CXL_DEVICE_NVDIMM;
    47		if (dev->type == CXL_PMEM_REGION_TYPE())
    48			return CXL_DEVICE_PMEM_REGION;
    49		if (dev->type == CXL_DAX_REGION_TYPE())
    50			return CXL_DEVICE_DAX_REGION;
    51		if (is_cxl_port(dev)) {
    52			if (is_cxl_root(to_cxl_port(dev)))
    53				return CXL_DEVICE_ROOT;
    54			return CXL_DEVICE_PORT;
    55		}
    56		if (is_cxl_memdev(dev))
    57			return CXL_DEVICE_MEMORY_EXPANDER;
    58		if (dev->type == CXL_REGION_TYPE())
    59			return CXL_DEVICE_REGION;
  > 60		if (dev->type == &cxl_cpmu_type)
    61			return CXL_DEVICE_CPMU;
    62		return 0;
    63	}
    64	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
