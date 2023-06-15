Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562F373224D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjFOWBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjFOWA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:00:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40052962;
        Thu, 15 Jun 2023 15:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866457; x=1718402457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VixVhVq+fB60ytIjlPKKkNw/tWOkMvypRvdQAxH+drM=;
  b=kyVhkwH4Bk2+hQRV20aoXFVwybAMsof61Y8h/VQ8cMWCl/VcI6wH519K
   dhcMQICQXbsm+wOhkQSXmo1N5sR4ahp9mjSKjvvzPscssNXMxuXVI/xzD
   9a4BUes+tFWUTMDF3x8BAOXizKb/bTwpkglM/DCff59D6djU4DGzyd3Ul
   h2n2H9yWQvWXXhBzjItNWvAstfkDM1/d9mygOmt9pcneD3SKcTsq8gkoV
   ulP3RAUzVQ7Zg4UYVWttkvpX/sqBo+ogtF161QAOBYu2dga6pacMsVoay
   D6q09ccDJpth/lTQPMuBDfRzIZXzk2dMbiJggiy1A7wO42YMCGT6QyEyE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="339391364"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="339391364"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689970719"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689970719"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 15:00:52 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9v1P-0000Qn-1F;
        Thu, 15 Jun 2023 22:00:51 +0000
Date:   Fri, 16 Jun 2023 05:59:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>, peter.chen@kernel.org,
        pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        gregkh@linuxfoundation.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdns3: Put the cdns set active part outside the
 spin lock
Message-ID: <202306160517.DJARQEZU-lkp@intel.com>
References: <20230615110424.4007675-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615110424.4007675-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaolei,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.4-rc6 next-20230615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaolei-Wang/usb-cdns3-Put-the-cdns-set-active-part-outside-the-spin-lock/20230615-190721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230615110424.4007675-1-xiaolei.wang%40windriver.com
patch subject: [PATCH v2] usb: cdns3: Put the cdns set active part outside the spin lock
config: riscv-randconfig-r042-20230615 (https://download.01.org/0day-ci/archive/20230616/202306160517.DJARQEZU-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        git remote add usb https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
        git fetch usb usb-testing
        git checkout usb/usb-testing
        b4 shazam https://lore.kernel.org/r/20230615110424.4007675-1-xiaolei.wang@windriver.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/usb/cdns3/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306160517.DJARQEZU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/usb/cdns3/cdns3-plat.c:16:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/usb/cdns3/cdns3-plat.c:16:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/usb/cdns3/cdns3-plat.c:16:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:743:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     743 |         insb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
     104 | #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/usb/cdns3/cdns3-plat.c:16:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:751:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     751 |         insw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
     105 | #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/usb/cdns3/cdns3-plat.c:16:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:759:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     759 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/usb/cdns3/cdns3-plat.c:16:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:768:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     768 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
     118 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/usb/cdns3/cdns3-plat.c:16:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:777:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     777 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
     119 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/usb/cdns3/cdns3-plat.c:16:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:786:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     786 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/usb/cdns3/cdns3-plat.c:16:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1134:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1134 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/usb/cdns3/cdns3-plat.c:258:18: error: too few arguments to function call, expected 2, have 1
     258 |         cdns_resume(cdns);
         |         ~~~~~~~~~~~     ^
   drivers/usb/cdns3/core.h:132:19: note: 'cdns_resume' declared here
     132 | static inline int cdns_resume(struct cdns *cdns, u8 set_active)
         |                   ^
>> drivers/usb/cdns3/cdns3-plat.c:261:2: error: call to undeclared function 'cdns_set_active'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     261 |         cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
         |         ^
   13 warnings and 2 errors generated.


vim +258 drivers/usb/cdns3/cdns3-plat.c

   229	
   230	static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
   231	{
   232		struct cdns *cdns = dev_get_drvdata(dev);
   233		int ret;
   234		unsigned long flags;
   235	
   236		if (!cdns->in_lpm)
   237			return 0;
   238	
   239		if (cdns_power_is_lost(cdns)) {
   240			phy_exit(cdns->usb2_phy);
   241			ret = phy_init(cdns->usb2_phy);
   242			if (ret)
   243				return ret;
   244	
   245			phy_exit(cdns->usb3_phy);
   246			ret = phy_init(cdns->usb3_phy);
   247			if (ret)
   248				return ret;
   249		}
   250	
   251		ret = set_phy_power_on(cdns);
   252		if (ret)
   253			return ret;
   254	
   255		cdns3_set_platform_suspend(cdns->dev, false, false);
   256	
   257		spin_lock_irqsave(&cdns->lock, flags);
 > 258		cdns_resume(cdns);
   259		cdns->in_lpm = false;
   260		spin_unlock_irqrestore(&cdns->lock, flags);
 > 261		cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
   262		if (cdns->wakeup_pending) {
   263			cdns->wakeup_pending = false;
   264			enable_irq(cdns->wakeup_irq);
   265		}
   266		dev_dbg(cdns->dev, "%s ends\n", __func__);
   267	
   268		return ret;
   269	}
   270	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
