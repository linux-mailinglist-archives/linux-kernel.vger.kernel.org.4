Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AAB5BF8A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIUIKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIUIKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:10:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD1324F1F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663747813; x=1695283813;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FtupuEEq48sNG6dabCaExeYGA1olK93KQDsye1OyWyU=;
  b=jxPbN0xk8NQl0tnW5mV4qnTaVoC3STsoor6vGjNsyQJNoLTkMEI9Z7mb
   zvqsGrsQB/ZnuiHfCB1C0Pg9bx4Fc3wftcaKtdrW/UG5FUQQHcceCOCod
   BcNISSq6eZATDFKeFEJzjKAIkTNv5IruyIhHB6SH7u/LqmhGyVImui91X
   U20C9EdyFINMYLNwMDk8IC1iEJg6R2y5BQa/TCkt7fbuNYnhSAlzY+8lC
   C97EKXf7yXXzY3cQdC9QkKCK1ZF86EWCUUSM4Ur0N1PFjSfOx0suNgnwP
   3BByWvRLV5GzJkdC8mAAWF42kKWQbEV5XdcE/nVHIS3aqaM3LCUOY36eF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280309880"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="280309880"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 01:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="570436331"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Sep 2022 01:10:11 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oauo6-0003Ov-1k;
        Wed, 21 Sep 2022 08:10:10 +0000
Date:   Wed, 21 Sep 2022 16:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/pci/pci.c:4195 pci_pio_to_address() warn: always true
 condition '(pio >= (0 - 0)) => (0-u32max >= 0)'
Message-ID: <202209211647.5COmF7fM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   60891ec99e141b74544d11e897a245ef06263052
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   8 weeks ago
config: openrisc-randconfig-m041-20220919 (https://download.01.org/0day-ci/archive/20220921/202209211647.5COmF7fM-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/pci/pci.c:4195 pci_pio_to_address() warn: always true condition '(pio >= (0 - 0)) => (0-u32max >= 0)'
drivers/media/pci/cx23885/cx23885-dvb.c:2579 dvb_register() error: we previously assumed 'fe1->dvb.frontend' could be null (see line 1743)

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
