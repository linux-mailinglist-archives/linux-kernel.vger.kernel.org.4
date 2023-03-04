Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497AC6AA8B5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCDIX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCDIXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:23:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B2011EBE;
        Sat,  4 Mar 2023 00:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677918231; x=1709454231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=be1rXqOTaA9TmHSy7Fu3SagO+W1K5eB5Fn1fhibjMYE=;
  b=ibmWX0F0/7f6DOIOHaDnOF7eAVfxCvsYOayREiEWCVOkVjLZCAvNCX0o
   ZuYxddqrZrwrpXPLxaQCq+kGe6npfe5S/RSd4rqLvZY5PkgCRHaM/k7Kq
   gss8ojqHYuwkYaRFdde3D88LY1ROSWeEpY8KSSKs9IJbQiP4L+GssjHCP
   LkXSdtHolwcL7tDPadJlXOh2x8erqhhww6C2XIB9FN4dXhBoo+XT+f6Mq
   t/y7ahmkldV9d9jj6WvpreG5fyHhsbqtNwOZvK6ABgu440EARu7dnFhS8
   dzAV74H+jEHGEJF5iak0dISc3RRzJ3j3s+gPIri9kvB6wNfgN6NhW987O
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="336758159"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="336758159"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 00:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="705896951"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="705896951"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Mar 2023 00:23:46 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYNBB-00020e-0n;
        Sat, 04 Mar 2023 08:23:45 +0000
Date:   Sat, 4 Mar 2023 16:22:50 +0800
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
Message-ID: <202303041641.maw8XfoZ-lkp@intel.com>
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
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20230304/202303041641.maw8XfoZ-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303041641.maw8XfoZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/core/regs.c:9:10: fatal error: 'cpmu.h' file not found
   #include <cpmu.h>
            ^~~~~~~~
   1 error generated.
--
>> drivers/cxl/core/cpmu.c:8:10: fatal error: 'cpmu.h' file not found
   #include <cpmu.h>
            ^~~~~~~~
   1 error generated.


vim +9 drivers/cxl/core/regs.c

   > 9	#include <cpmu.h>
    10	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
