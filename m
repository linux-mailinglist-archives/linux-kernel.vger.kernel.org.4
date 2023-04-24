Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064306ED4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjDXSw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjDXSwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:52:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EB486A8;
        Mon, 24 Apr 2023 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682362347; x=1713898347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=huei9fm8wqaE4e2eRVEs7QavJaIOdk/zO+CVVXYTZpc=;
  b=koue/2VniW9Bb3qtVP3JQqF2NvZWifKdUVXBUVyxORi0kuyzoehSfOIS
   it1OoHJhp2mdUvR7x8tozGhmpksLlEjfYPgICY9PBc5Gx7jQU4SLpKLS0
   FYjuIiaKGxzJ15kopW7zoTgXNmYAQ33uc3RdRmqrSUewLRNZ9Mt9IXdtp
   cIkfPNQOYWJP6dgbd4T/S6pQoeRu8xXcP5VFYxBqBnZ8Gb6myCpQMsqwS
   qM/f1zKU8RBQGkBISUi6Mee0OzaBCqDgufnIn+nBLQZFCm7tet2wh4EJc
   ZHGxxwmPzYMcMdRGYGjKtEOCYWabLp4C7VMUyAx5l/vSapc5zAsakmEHf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="349339346"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="349339346"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 11:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="782506404"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="782506404"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2023 11:50:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pr1H7-000iau-2q;
        Mon, 24 Apr 2023 18:50:57 +0000
Date:   Tue, 25 Apr 2023 02:50:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Donghun Yoon <donghun.yoon@lge.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci-pci: Only run d3cold avoidance quirk for s2idle
Message-ID: <202304250239.9WShH3NB-lkp@intel.com>
References: <20230424134926.1416-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424134926.1416-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.3 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/xhci-pci-Only-run-d3cold-avoidance-quirk-for-s2idle/20230424-215356
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230424134926.1416-1-mario.limonciello%40amd.com
patch subject: [PATCH] xhci-pci: Only run d3cold avoidance quirk for s2idle
config: i386-randconfig-a003-20230424 (https://download.01.org/0day-ci/archive/20230425/202304250239.9WShH3NB-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8e287659296330d0cb31e4730daacc92d0467e63
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/xhci-pci-Only-run-d3cold-avoidance-quirk-for-s2idle/20230424-215356
        git checkout 8e287659296330d0cb31e4730daacc92d0467e63
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304250239.9WShH3NB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/host/xhci-pci.c:806:7: error: use of undeclared identifier 'pm_suspend_target_state'
               (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
                ^
   1 error generated.


vim +/pm_suspend_target_state +806 drivers/usb/host/xhci-pci.c

   794	
   795	static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
   796	{
   797		struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
   798		struct pci_dev		*pdev = to_pci_dev(hcd->self.controller);
   799		int			ret;
   800	
   801		/*
   802		 * Systems with the TI redriver that loses port status change events
   803		 * need to have the registers polled during D3, so avoid D3cold.
   804		 */
   805		if (xhci->quirks & XHCI_COMP_MODE_QUIRK ||
 > 806		    (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
   807		     xhci->quirks & (XHCI_BROKEN_D3COLD_S2I)))
   808			pci_d3cold_disable(pdev);
   809	
   810		if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
   811			xhci_pme_quirk(hcd);
   812	
   813		if (xhci->quirks & XHCI_SSIC_PORT_UNUSED)
   814			xhci_ssic_port_unused_quirk(hcd, true);
   815	
   816		if (xhci->quirks & XHCI_DISABLE_SPARSE)
   817			xhci_sparse_control_quirk(hcd);
   818	
   819		ret = xhci_suspend(xhci, do_wakeup);
   820	
   821		/* synchronize irq when using MSI-X */
   822		xhci_msix_sync_irqs(xhci);
   823	
   824		if (ret && (xhci->quirks & XHCI_SSIC_PORT_UNUSED))
   825			xhci_ssic_port_unused_quirk(hcd, false);
   826	
   827		return ret;
   828	}
   829	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
