Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C526C7772
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCXFkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjCXFkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:40:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E8E252A8;
        Thu, 23 Mar 2023 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679636405; x=1711172405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lz4E1YV6Yw7Hz3q4Hij1kHmq1J+RPLt8Y3nDI4SGDMQ=;
  b=joKT+3CbvStHIeYNA97yDkf4Vk+AC4b3DdqHyyb1YrNERM/mR1AVDTcx
   PfFasXYy4l44cRbYS8ceZwjqEg86+scYZ/BdgShphgxpSzzEKHwG4XvLw
   E41J+D6mcSPdjGYithoHkl17H2sHszGl5wR7Lt9OHWJMuxRi8eNrm1sq4
   SVlzKZAR1LNmK06uVcSXv3d5y9W0AV3fGyb/mIUqAAXLl6muOCWqEw+I2
   ryfAr0mNt/GmaMUFuEai5ekumPKK5QgMWX82k4BQjReTdQKOb9Wj6/tIk
   rbYe6yfg1ev7gBfS1YM0Um7tByBxeHtyEKKnDPlTvz2HNWBtBefO7yNMm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="367439463"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="367439463"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 22:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="676010886"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="676010886"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2023 22:40:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfa9g-000F1E-2P;
        Fri, 24 Mar 2023 05:40:00 +0000
Date:   Fri, 24 Mar 2023 13:39:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
        rrichter@amd.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v2 5/5] cxl/pci: Add RCH downstream port error logging
Message-ID: <202303241305.7Xdy6342-lkp@intel.com>
References: <20230323213808.398039-6-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323213808.398039-6-terry.bowman@amd.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus efi/next cxl/next linus/master v6.3-rc3 next-20230323]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/cxl-pci-Add-RCH-downstream-port-AER-and-RAS-register-discovery/20230324-054044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230323213808.398039-6-terry.bowman%40amd.com
patch subject: [PATCH v2 5/5] cxl/pci: Add RCH downstream port error logging
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20230324/202303241305.7Xdy6342-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c40ca148e9cff1a1c32cd4c5c9b252bf0cf201b6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Terry-Bowman/cxl-pci-Add-RCH-downstream-port-AER-and-RAS-register-discovery/20230324-054044
        git checkout c40ca148e9cff1a1c32cd4c5c9b252bf0cf201b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303241305.7Xdy6342-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/mem.c:51:31: error: no member named 'rcec' in 'struct pci_dev'
           struct pci_dev *rcec = pdev->rcec;
                                  ~~~~  ^
>> drivers/cxl/mem.c:63:14: error: no member named 'aer_cap' in 'struct pci_dev'
           aer = rcec->aer_cap;
                 ~~~~  ^
   2 errors generated.


vim +51 drivers/cxl/mem.c

    48	
    49	static int rcec_enable_aer_ints(struct pci_dev *pdev)
    50	{
  > 51		struct pci_dev *rcec = pdev->rcec;
    52		int aer, rc;
    53		u32 mask;
    54	
    55		if (!rcec)
    56			return -ENODEV;
    57	
    58		/*
    59		 * Internal errors are masked by default, unmask RCEC's here
    60		 * PCI6.0 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h)
    61		 * PCI6.0 7.8.4.6 Correctable Error Mask Register (Offset 14h)
    62		 */
  > 63		aer = rcec->aer_cap;
    64		rc = pci_read_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, &mask);
    65		if (rc)
    66			return rc;
    67		mask &= ~PCI_ERR_UNC_INTN;
    68		rc = pci_write_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, mask);
    69		if (rc)
    70			return rc;
    71	
    72		rc = pci_read_config_dword(rcec, aer + PCI_ERR_COR_MASK, &mask);
    73		if (rc)
    74			return rc;
    75		mask &= ~PCI_ERR_COR_INTERNAL;
    76		rc = pci_write_config_dword(rcec, aer + PCI_ERR_COR_MASK, mask);
    77	
    78		return rc;
    79	}
    80	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
