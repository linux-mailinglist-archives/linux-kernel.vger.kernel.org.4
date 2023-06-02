Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08E271F8DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjFBDUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjFBDUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:20:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F394136;
        Thu,  1 Jun 2023 20:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685676007; x=1717212007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tp1pRxIXNV5sIRotnZf5vbQ/Cdchz8UTj+wy3MPNfDo=;
  b=BMRsMwjj9g/yEPFh94H8/V2vjEaTsOTz6QuKQrfBHJEFdcFyfQW+o0CB
   El1KF1LclYsUBEENA9jhjrvbfi0QNfmBZ2RdMMeud044+q1uOjE2IUxk/
   m0yvhMHGmpuXYApll7qOYRoW7wInAjWpvfDqttF7EBQnT3dN2Fic/ei9F
   OHJ+WS+nWV4FFeHLZJ9WdkrqKF4AMPxqLxAH9L6vsTHwfzB1A3fNFfEXW
   sn/xxvCJvOmKAdqP2RRh62qfWp5SWJtQ3HJ5Tur45cnCEiwq+62Uw5NTU
   lDTdN5hRsicZlXMb/kV8oPd1qGCaYvKn0XRanDBDHHxs7Z0uD0GFZTTnr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="442128806"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="442128806"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 20:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881886189"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="881886189"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2023 20:20:03 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4vKd-000013-03;
        Fri, 02 Jun 2023 03:20:03 +0000
Date:   Fri, 2 Jun 2023 11:19:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Rafael Wysocki <rafael@kernel.org>, hdegoede@redhat.com,
        linus.walleij@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 3/4] pinctrl: amd: Use pm_pr_dbg to show debugging
 messages
Message-ID: <202306021143.5D8Xmq0r-lkp@intel.com>
References: <20230601232923.1248-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601232923.1248-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7736c431466abb54a2679dc257f739fddfa84295]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-x86-Add-pm_debug_messages-for-LPS0-_DSM-state-tracking/20230602-073044
base:   7736c431466abb54a2679dc257f739fddfa84295
patch link:    https://lore.kernel.org/r/20230601232923.1248-3-mario.limonciello%40amd.com
patch subject: [PATCH v3 3/4] pinctrl: amd: Use pm_pr_dbg to show debugging messages
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230602/202306021143.5D8Xmq0r-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/61f4d28eda8f5bf19179080626ec4f1276c1cbae
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/ACPI-x86-Add-pm_debug_messages-for-LPS0-_DSM-state-tracking/20230602-073044
        git checkout 61f4d28eda8f5bf19179080626ec4f1276c1cbae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/pinctrl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306021143.5D8Xmq0r-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-amd.c: In function 'do_amd_gpio_irq_handler':
>> drivers/pinctrl/pinctrl-amd.c:639:28: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
     639 |                         if (regval & PIN_IRQ_PENDING)
         |                            ^


vim +/else +639 drivers/pinctrl/pinctrl-amd.c

ba714a9c1dea85 Thomas Gleixner           2017-05-23  608  
2d54067fcd23aa Mario Limonciello         2021-10-31  609  static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
dbad75dd1f25e0 Ken Xue                   2015-03-10  610  {
ba714a9c1dea85 Thomas Gleixner           2017-05-23  611  	struct amd_gpio *gpio_dev = dev_id;
ba714a9c1dea85 Thomas Gleixner           2017-05-23  612  	struct gpio_chip *gc = &gpio_dev->gc;
ba714a9c1dea85 Thomas Gleixner           2017-05-23  613  	unsigned int i, irqnr;
dbad75dd1f25e0 Ken Xue                   2015-03-10  614  	unsigned long flags;
10ff58aa3c2e2a Ben Dooks (Codethink      2019-10-22  615) 	u32 __iomem *regs;
2d54067fcd23aa Mario Limonciello         2021-10-31  616  	bool ret = false;
10ff58aa3c2e2a Ben Dooks (Codethink      2019-10-22  617) 	u32  regval;
ba714a9c1dea85 Thomas Gleixner           2017-05-23  618  	u64 status, mask;
dbad75dd1f25e0 Ken Xue                   2015-03-10  619  
ba714a9c1dea85 Thomas Gleixner           2017-05-23  620  	/* Read the wake status */
229710fecdd805 Julia Cartwright          2017-03-09  621  	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
ba714a9c1dea85 Thomas Gleixner           2017-05-23  622  	status = readl(gpio_dev->base + WAKE_INT_STATUS_REG1);
ba714a9c1dea85 Thomas Gleixner           2017-05-23  623  	status <<= 32;
ba714a9c1dea85 Thomas Gleixner           2017-05-23  624  	status |= readl(gpio_dev->base + WAKE_INT_STATUS_REG0);
229710fecdd805 Julia Cartwright          2017-03-09  625  	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
dbad75dd1f25e0 Ken Xue                   2015-03-10  626  
ba714a9c1dea85 Thomas Gleixner           2017-05-23  627  	/* Bit 0-45 contain the relevant status bits */
ba714a9c1dea85 Thomas Gleixner           2017-05-23  628  	status &= (1ULL << 46) - 1;
ba714a9c1dea85 Thomas Gleixner           2017-05-23  629  	regs = gpio_dev->base;
ba714a9c1dea85 Thomas Gleixner           2017-05-23  630  	for (mask = 1, irqnr = 0; status; mask <<= 1, regs += 4, irqnr += 4) {
ba714a9c1dea85 Thomas Gleixner           2017-05-23  631  		if (!(status & mask))
ba714a9c1dea85 Thomas Gleixner           2017-05-23  632  			continue;
ba714a9c1dea85 Thomas Gleixner           2017-05-23  633  		status &= ~mask;
ba714a9c1dea85 Thomas Gleixner           2017-05-23  634  
ba714a9c1dea85 Thomas Gleixner           2017-05-23  635  		/* Each status bit covers four pins */
dbad75dd1f25e0 Ken Xue                   2015-03-10  636  		for (i = 0; i < 4; i++) {
ba714a9c1dea85 Thomas Gleixner           2017-05-23  637  			regval = readl(regs + i);
1d66e379731f79 Mario Limonciello         2022-10-13  638  
1d66e379731f79 Mario Limonciello         2022-10-13 @639  			if (regval & PIN_IRQ_PENDING)
61f4d28eda8f5b Mario Limonciello         2023-06-01  640  				pm_pr_dbg("GPIO %d is active: 0x%x",
2d54067fcd23aa Mario Limonciello         2021-10-31  641  					  irqnr + i, regval);
1d66e379731f79 Mario Limonciello         2022-10-13  642  
1d66e379731f79 Mario Limonciello         2022-10-13  643  			/* caused wake on resume context for shared IRQ */
1d66e379731f79 Mario Limonciello         2022-10-13  644  			if (irq < 0 && (regval & BIT(WAKE_STS_OFF)))
2d54067fcd23aa Mario Limonciello         2021-10-31  645  				return true;
2d54067fcd23aa Mario Limonciello         2021-10-31  646  
8bbed1eef001fd Daniel Kurtz              2018-07-16  647  			if (!(regval & PIN_IRQ_PENDING) ||
8bbed1eef001fd Daniel Kurtz              2018-07-16  648  			    !(regval & BIT(INTERRUPT_MASK_OFF)))
ba714a9c1dea85 Thomas Gleixner           2017-05-23  649  				continue;
f460c70125bcb1 Sebastian Andrzej Siewior 2022-09-19  650  			generic_handle_domain_irq_safe(gc->irq.domain, irqnr + i);
6afb10267c1692 Daniel Drake              2017-10-02  651  
6afb10267c1692 Daniel Drake              2017-10-02  652  			/* Clear interrupt.
6afb10267c1692 Daniel Drake              2017-10-02  653  			 * We must read the pin register again, in case the
6afb10267c1692 Daniel Drake              2017-10-02  654  			 * value was changed while executing
a9cb09b7be84a7 Marc Zyngier              2021-05-04  655  			 * generic_handle_domain_irq() above.
d21b8adbd475db Daniel Drake              2019-08-14  656  			 * If we didn't find a mapping for the interrupt,
d21b8adbd475db Daniel Drake              2019-08-14  657  			 * disable it in order to avoid a system hang caused
d21b8adbd475db Daniel Drake              2019-08-14  658  			 * by an interrupt storm.
6afb10267c1692 Daniel Drake              2017-10-02  659  			 */
6afb10267c1692 Daniel Drake              2017-10-02  660  			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
6afb10267c1692 Daniel Drake              2017-10-02  661  			regval = readl(regs + i);
d21b8adbd475db Daniel Drake              2019-08-14  662  			if (irq == 0) {
d21b8adbd475db Daniel Drake              2019-08-14  663  				regval &= ~BIT(INTERRUPT_ENABLE_OFF);
d21b8adbd475db Daniel Drake              2019-08-14  664  				dev_dbg(&gpio_dev->pdev->dev,
d21b8adbd475db Daniel Drake              2019-08-14  665  					"Disabling spurious GPIO IRQ %d\n",
d21b8adbd475db Daniel Drake              2019-08-14  666  					irqnr + i);
d21b8adbd475db Daniel Drake              2019-08-14  667  			}
ba714a9c1dea85 Thomas Gleixner           2017-05-23  668  			writel(regval, regs + i);
6afb10267c1692 Daniel Drake              2017-10-02  669  			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
2d54067fcd23aa Mario Limonciello         2021-10-31  670  			ret = true;
dbad75dd1f25e0 Ken Xue                   2015-03-10  671  		}
dbad75dd1f25e0 Ken Xue                   2015-03-10  672  	}
2d54067fcd23aa Mario Limonciello         2021-10-31  673  	/* did not cause wake on resume context for shared IRQ */
2d54067fcd23aa Mario Limonciello         2021-10-31  674  	if (irq < 0)
2d54067fcd23aa Mario Limonciello         2021-10-31  675  		return false;
dbad75dd1f25e0 Ken Xue                   2015-03-10  676  
ba714a9c1dea85 Thomas Gleixner           2017-05-23  677  	/* Signal EOI to the GPIO unit */
229710fecdd805 Julia Cartwright          2017-03-09  678  	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
ba714a9c1dea85 Thomas Gleixner           2017-05-23  679  	regval = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
ba714a9c1dea85 Thomas Gleixner           2017-05-23  680  	regval |= EOI_MASK;
ba714a9c1dea85 Thomas Gleixner           2017-05-23  681  	writel(regval, gpio_dev->base + WAKE_INT_MASTER_REG);
229710fecdd805 Julia Cartwright          2017-03-09  682  	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
dbad75dd1f25e0 Ken Xue                   2015-03-10  683  
ba714a9c1dea85 Thomas Gleixner           2017-05-23  684  	return ret;
dbad75dd1f25e0 Ken Xue                   2015-03-10  685  }
dbad75dd1f25e0 Ken Xue                   2015-03-10  686  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
