Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257A26AA8B4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCDIXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:23:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EF611E8A;
        Sat,  4 Mar 2023 00:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677918230; x=1709454230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qdLPi8iwJllL1WkDkxxfoFGQfyZMef9uxeduo00UepA=;
  b=ekuWJkh/xwDYl2WYhpEWBe2AIQ1slCyFdYJHwAUhgHBZqgfNPX9Mm+Ho
   jHllTSOcV7pw2ffiPJwmHgmy4SO06foKKGx+eu2pkqykGfKJWpEGCph8C
   lTN0ywXBAxG1hUo4tiJOBCKJR2J451ZBh5VHEOpN1muxDtVd9Co6d4Mvo
   J0y6i2qPkv7bo42T/Z8kNT88SaJhdC06SbHR8/FT1MMvFu3c5eFbPRtdy
   crZ3WmIK7ZUUzaSWojvdSt6Sa9o7ISTjJ2Aye1VGjRgvUJnKDktDcBkAR
   4tkdXnV9GbqHumO8DgcFHt9aeqWZujPBmxpkopcEMxEdAc6zSS9Hzzehw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="336758166"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="336758166"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 00:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="705896953"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="705896953"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Mar 2023 00:23:46 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYNBB-00020g-0r;
        Sat, 04 Mar 2023 08:23:45 +0000
Date:   Sat, 4 Mar 2023 16:22:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, will@kernel.org, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, linuxarm@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] cxl/pci: Find and register CXL PMU devices
Message-ID: <202303041611.MbSDCPTb-lkp@intel.com>
References: <20230303175022.10806-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303175022.10806-3-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20230304/202303041611.MbSDCPTb-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0790ed82bb7adf04c834e8c03008b92c1b23945e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230304-015342
        git checkout 0790ed82bb7adf04c834e8c03008b92c1b23945e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303041611.MbSDCPTb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/core/port.c:60:20: error: use of undeclared identifier 'cxl_cpmu_type'; did you mean 'cxl_bus_type'?
           if (dev->type == &cxl_cpmu_type)
                             ^~~~~~~~~~~~~
                             cxl_bus_type
   drivers/cxl/cxl.h:732:24: note: 'cxl_bus_type' declared here
   extern struct bus_type cxl_bus_type;
                          ^
   1 error generated.
--
>> drivers/cxl/core/regs.c:9:10: fatal error: 'cpmu.h' file not found
   #include <cpmu.h>
            ^~~~~~~~
   1 error generated.
--
>> drivers/cxl/core/cpmu.c:8:10: fatal error: 'cpmu.h' file not found
   #include <cpmu.h>
            ^~~~~~~~
   1 error generated.


vim +60 drivers/cxl/core/port.c

    40	
    41	static int cxl_device_id(struct device *dev)
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
