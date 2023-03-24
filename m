Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4286C77EC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCXGbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXGbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:31:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5495919F35;
        Thu, 23 Mar 2023 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679639468; x=1711175468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FnjPTKkVqnmJHe9Df3TslawVFi1kARulsCY/YIxS3lw=;
  b=asglqgkLyANGTo+S/URhK2B5gMQgh7DJtU8xha7gfViNVo+CAb8QbYJr
   XsG/kRxEorL3tVyBglSXjiI2h0XdYvHsE+8lBbx7VXKe8/cJypdRXfasE
   gUUi/Dbclhj2s8Go1DiDe9PxXbpAznpK4A6SeV69WDwGulRqT1TSm6M3E
   9iUphTUpIEJuUcxUtgWiF99S5c8pt1McwgBhm7gvh7Jg1wBriTTjeoS94
   2OGzNKCZY9pedIIektSNORLx5nNYbcsrdYi/0hsG4CU3DLI/L2bL4uLPG
   mbvv1I+3a1UUCiKviWcwQEtKxaPJ0tp/2Hi+8mDSgluUQhLonwLzZACoI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341272827"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="341272827"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 23:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="771756023"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="771756023"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Mar 2023 23:31:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfax4-000F2u-0o;
        Fri, 24 Mar 2023 06:31:02 +0000
Date:   Fri, 24 Mar 2023 14:30:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
        rrichter@amd.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v2 5/5] cxl/pci: Add RCH downstream port error logging
Message-ID: <202303241458.BV292BDH-lkp@intel.com>
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
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20230324/202303241458.BV292BDH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c40ca148e9cff1a1c32cd4c5c9b252bf0cf201b6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Terry-Bowman/cxl-pci-Add-RCH-downstream-port-AER-and-RAS-register-discovery/20230324-054044
        git checkout c40ca148e9cff1a1c32cd4c5c9b252bf0cf201b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303241458.BV292BDH-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cxl/mem.c: In function 'rcec_enable_aer_ints':
>> drivers/cxl/mem.c:51:36: error: 'struct pci_dev' has no member named 'rcec'
      51 |         struct pci_dev *rcec = pdev->rcec;
         |                                    ^~
>> drivers/cxl/mem.c:63:21: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'ats_cap'?
      63 |         aer = rcec->aer_cap;
         |                     ^~~~~~~
         |                     ats_cap


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
