Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0755E6026
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiIVKpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiIVKpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:45:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608229FAAD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663843522; x=1695379522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YdI1++uiLxC2Xj4VEP5Hzyp0zap97SrA0gDwOG9MvDg=;
  b=YxxV8nufMlfY5URE3r0+9Kznci3l4qBI0OxnHnZcGwRXBfL9PJ1QKfsf
   EXWigoEf3UN2gm1UiT/cizfD6/S9tLLWOyUx8rdfM8tI7PbzgHMGSYRkJ
   wikeGVtoCBJ6qihFe5RGskBM6epLr3pTrl0mHq+ekgYmFEATHI88FsdIZ
   8aCvcog6SriqqecTo/Mdq1fORZHgpCoZUAVRUkqo95H9UOO73EkriCbeR
   mTeT4d48HTPB+QrfNWOkxd0FJLPyakMAZIFWj5w7Ok6HAdEUxHksD2Wju
   eN02XfL/XDTFd8GxWAbkbJNW3uE/l7iR59zwGYx4uTMJ9pBXYU0Fu1j28
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="326582740"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="326582740"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 03:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="650473544"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 03:45:20 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obJho-0004c4-0X;
        Thu, 22 Sep 2022 10:45:20 +0000
Date:   Thu, 22 Sep 2022 18:44:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/pci/pci.c:4195 pci_pio_to_address() warn: always true
 condition '(pio >= (0 - 0)) => (0-u32max >= 0)'
Message-ID: <202209221805.jXylfGcI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc164f4fb00a0abebdfff132f8bc7291a28f5401
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   8 weeks ago
config: openrisc-randconfig-m031-20220921 (https://download.01.org/0day-ci/archive/20220922/202209221805.jXylfGcI-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/pci/pci.c:4195 pci_pio_to_address() warn: always true condition '(pio >= (0 - 0)) => (0-u32max >= 0)'

vim +4195 drivers/pci/pci.c

c5076cfe768998 Tomasz Nowicki 2016-05-11  4189  
c5076cfe768998 Tomasz Nowicki 2016-05-11  4190  phys_addr_t pci_pio_to_address(unsigned long pio)
c5076cfe768998 Tomasz Nowicki 2016-05-11  4191  {
c5076cfe768998 Tomasz Nowicki 2016-05-11  4192  	phys_addr_t address = (phys_addr_t)OF_BAD_ADDR;
c5076cfe768998 Tomasz Nowicki 2016-05-11  4193  
c5076cfe768998 Tomasz Nowicki 2016-05-11  4194  #ifdef PCI_IOBASE
5745392e0c2b78 Zhichang Yuan  2018-03-15 @4195  	if (pio >= MMIO_UPPER_LIMIT)
c5076cfe768998 Tomasz Nowicki 2016-05-11  4196  		return address;
c5076cfe768998 Tomasz Nowicki 2016-05-11  4197  
5745392e0c2b78 Zhichang Yuan  2018-03-15  4198  	address = logic_pio_to_hwaddr(pio);
c5076cfe768998 Tomasz Nowicki 2016-05-11  4199  #endif
c5076cfe768998 Tomasz Nowicki 2016-05-11  4200  
c5076cfe768998 Tomasz Nowicki 2016-05-11  4201  	return address;
c5076cfe768998 Tomasz Nowicki 2016-05-11  4202  }
9cc742078c9a90 Jianjun Wang   2021-04-20  4203  EXPORT_SYMBOL_GPL(pci_pio_to_address);
c5076cfe768998 Tomasz Nowicki 2016-05-11  4204  

:::::: The code at line 4195 was first introduced by commit
:::::: 5745392e0c2b78e0d73203281d5c42cbd6993194 PCI: Apply the new generic I/O management on PCI IO hosts

:::::: TO: Zhichang Yuan <yuanzhichang@hisilicon.com>
:::::: CC: Bjorn Helgaas <helgaas@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
