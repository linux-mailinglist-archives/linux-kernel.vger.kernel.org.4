Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E766C7A64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjCXIyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjCXIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:54:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED6B19C79;
        Fri, 24 Mar 2023 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679648051; x=1711184051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j5CbuxsW9YhmDTT/LOuuIKZ5pDvmHmeXkVuCe8TyAu8=;
  b=Jn9K6mf4UDgAy5KCMh12B1wCA/LGW/IjeaIeoMTPWrDcvx7AYWArFrcI
   u/DpZlTea97pGFtE2D4nYBLpB8gBtntx1/w+aFLYnKUq/Kb/kTlNrkWZx
   vf8N/3nUlxp1xNofvAcL2UyOWcTWM9+lqFQnOz0P1GTB9rbNqsy5Twz/w
   OGhuu/3K0TbGyOkU9dm12LdMNt4+Fe84KUHzsb7+jgGHnbxyj1seFCemw
   kNlrQcdiEx9rW0N5Rc27i1uhQvdDYgUJ63LY6LxkEJUo5B3yWOIO3Ff+z
   zizV9RuzMN/jnH9KXAk/s/86nByrmdbSuGSqEfzqnrhdrOo5mb91vpD7N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="328146195"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="328146195"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 01:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="806580721"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="806580721"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2023 01:54:07 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfdBW-000F94-2u;
        Fri, 24 Mar 2023 08:54:06 +0000
Date:   Fri, 24 Mar 2023 16:53:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
        rrichter@amd.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v2 1/5] cxl/pci: Add RCH downstream port AER and RAS
 register discovery
Message-ID: <202303241632.HTxJ0yfj-lkp@intel.com>
References: <20230323213808.398039-2-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323213808.398039-2-terry.bowman@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Terry,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus efi/next cxl/next cxl/pending linus/master v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/cxl-pci-Add-RCH-downstream-port-AER-and-RAS-register-discovery/20230324-054044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230323213808.398039-2-terry.bowman%40amd.com
patch subject: [PATCH v2 1/5] cxl/pci: Add RCH downstream port AER and RAS register discovery
config: parisc-randconfig-s043-20230322 (https://download.01.org/0day-ci/archive/20230324/202303241632.HTxJ0yfj-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/7cbc5c7357504af79c820ad7d0e9369b4a580a65
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Terry-Bowman/cxl-pci-Add-RCH-downstream-port-AER-and-RAS-register-discovery/20230324-054044
        git checkout 7cbc5c7357504af79c820ad7d0e9369b4a580a65
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303241632.HTxJ0yfj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/cxl/core/regs.c:340:24: sparse: sparse: Using plain integer as NULL pointer
   drivers/cxl/core/regs.c:345:24: sparse: sparse: Using plain integer as NULL pointer

vim +340 drivers/cxl/core/regs.c

   338	
   339		if (!request_mem_region(map->resource, map->max_size, name))
 > 340			return 0;
   341	
   342		map->base = ioremap(map->resource, map->max_size);
   343		if (!map->base) {
   344			release_mem_region(map->resource, map->max_size);
   345			return 0;
   346		}
   347	
   348		return map->base;
   349	}
   350	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
