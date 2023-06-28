Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938A274123A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjF1NXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:23:47 -0400
Received: from mga06b.intel.com ([134.134.136.31]:33595 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbjF1NXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687958624; x=1719494624;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3J3i9Mi4rqkYfNoJICSEviM4+dNFFVGyypvGvUrWFTM=;
  b=Da3DROogmM5vmtlrv+WiJGS67QpTPUPXaV2dXjCgRYlxbv3uWYxhKAqJ
   t6DMirKu5P7e6ZLTao6umw12GdSBeNVHf/yrgR5kd6QtJnSlLTo6oocqZ
   NFdfacmC00K4O12qWmuWBKcN36lVT9FFf89GUJEb4LCYIMiz2I0M8NVrg
   W/x7i18MSIR8hYzXsd1R/TCTgPHaTl0v8D7o0GZUQw8OV03NS51ZLpaWz
   M3Yfx4JGDZGj3WeI3j6B2EXVECwjZCtZr7gTKpIbuzzW01aKwgElWfVkU
   tITDL/+b4TlrYphnqbwM1oPiC6vIYIEitMpIo3U8w8sgZDKacXDAXlVo+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="425514492"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="425514492"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 06:23:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="667119698"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="667119698"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2023 06:23:42 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEV93-000DGv-0S;
        Wed, 28 Jun 2023 13:23:41 +0000
Date:   Wed, 28 Jun 2023 21:23:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/pci/pci.c:4195 pci_pio_to_address() warn: always true
 condition '(pio >= (0 - 0)) => (0-u32max >= 0)'
Message-ID: <202306282106.NdF2Rooc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6aeadf7896bff4ca230702daba8788455e6b866e
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   11 months ago
config: openrisc-randconfig-m041-20230628 (https://download.01.org/0day-ci/archive/20230628/202306282106.NdF2Rooc-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230628/202306282106.NdF2Rooc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306282106.NdF2Rooc-lkp@intel.com/

smatch warnings:
drivers/pci/pci.c:4195 pci_pio_to_address() warn: always true condition '(pio >= (0 - 0)) => (0-u32max >= 0)'
drivers/pcmcia/yenta_socket.c:1238 yenta_probe() warn: unsigned 'id->driver_data' is never less than zero.

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
https://github.com/intel/lkp-tests/wiki
