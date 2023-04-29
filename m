Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13B16F258A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjD2SDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 14:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD2SDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:03:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E3810F3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 11:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682791392; x=1714327392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I2/qKAWoUmG0az4HA8yWRYJtPm2gJFGA2ICByMsyvtQ=;
  b=eZEwvsMHNDJ+ymCq63N9nJuRXzZStW/koeRwRKyo+v2F8JNpadTlaO/z
   7rraCuk9w/l94GqrR7zGdf5aAWD0ec+TN8FB3nB0N1PVrTJzNdK6KskEP
   YEXJn5WXyEuD3lE+Z0r5CTm3dka514JFLAsFOZgEv0PcnsvMquT1iGXZT
   soVVYD43mha5hAClywGhAqA81Y6pzbXyONBDNf0YIF4JW4N7eJ+VyltbZ
   rbdQ3hZHiiIJxQ3Fv6He4PerCxjuZpcIHIRVSlMT1GSv/1jte7tc1HFO9
   CluPa5EI+oYyzyZbNLW7W0Y/2cGkITzn4J2EwVyZKOPZHZl5uWllnVbvw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="413367572"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="413367572"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 11:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="941533402"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="941533402"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Apr 2023 11:03:10 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psoub-0001Hl-1X;
        Sat, 29 Apr 2023 18:03:09 +0000
Date:   Sun, 30 Apr 2023 02:02:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: arch/arm/common/locomo.c:368: warning: expecting prototype for
 locomo_probe(). Prototype was for __locomo_probe() instead
Message-ID: <202304300144.OnqQzv1X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89d77f71f493a3663b10fa812d17f472935d24be
commit: 5eb6e280432ddc9b755193552f3a070da8d7455c ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
date:   3 months ago
config: arm-collie_defconfig (https://download.01.org/0day-ci/archive/20230430/202304300144.OnqQzv1X-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5eb6e280432ddc9b755193552f3a070da8d7455c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5eb6e280432ddc9b755193552f3a070da8d7455c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/common/ drivers/pcmcia/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304300144.OnqQzv1X-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm/common/locomo.c:368: warning: Function parameter or member 'me' not described in '__locomo_probe'
   arch/arm/common/locomo.c:368: warning: Function parameter or member 'mem' not described in '__locomo_probe'
   arch/arm/common/locomo.c:368: warning: Function parameter or member 'irq' not described in '__locomo_probe'
>> arch/arm/common/locomo.c:368: warning: expecting prototype for locomo_probe(). Prototype was for __locomo_probe() instead
--
>> drivers/pcmcia/pxa2xx_sharpsl.c:206:5: warning: no previous prototype for function 'pcmcia_collie_init' [-Wmissing-prototypes]
   int pcmcia_collie_init(struct device *dev)
       ^
   drivers/pcmcia/pxa2xx_sharpsl.c:206:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int pcmcia_collie_init(struct device *dev)
   ^
   static 
   1 warning generated.


vim +368 arch/arm/common/locomo.c

b38d950d3aedf9 John Lenz         2005-09-08  352  
4ebf2d00260bac Pavel Machek      2006-03-15  353  
^1da177e4c3f41 Linus Torvalds    2005-04-16  354  /**
^1da177e4c3f41 Linus Torvalds    2005-04-16  355   *	locomo_probe - probe for a single LoCoMo chip.
^1da177e4c3f41 Linus Torvalds    2005-04-16  356   *	@phys_addr: physical address of device.
^1da177e4c3f41 Linus Torvalds    2005-04-16  357   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  358   *	Probe for a LoCoMo chip.  This must be called
^1da177e4c3f41 Linus Torvalds    2005-04-16  359   *	before any other locomo-specific code.
^1da177e4c3f41 Linus Torvalds    2005-04-16  360   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  361   *	Returns:
^1da177e4c3f41 Linus Torvalds    2005-04-16  362   *	%-ENODEV	device not found.
^1da177e4c3f41 Linus Torvalds    2005-04-16  363   *	%-EBUSY		physical address already marked in-use.
^1da177e4c3f41 Linus Torvalds    2005-04-16  364   *	%0		successful.
^1da177e4c3f41 Linus Torvalds    2005-04-16  365   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  366  static int
^1da177e4c3f41 Linus Torvalds    2005-04-16  367  __locomo_probe(struct device *me, struct resource *mem, int irq)
^1da177e4c3f41 Linus Torvalds    2005-04-16 @368  {
ac609d266e4af4 Eric Miao         2010-02-04  369  	struct locomo_platform_data *pdata = me->platform_data;
^1da177e4c3f41 Linus Torvalds    2005-04-16  370  	struct locomo *lchip;
^1da177e4c3f41 Linus Torvalds    2005-04-16  371  	unsigned long r;
^1da177e4c3f41 Linus Torvalds    2005-04-16  372  	int i, ret = -ENODEV;
^1da177e4c3f41 Linus Torvalds    2005-04-16  373  
d2a02b93cf7820 Russell King      2006-03-20  374  	lchip = kzalloc(sizeof(struct locomo), GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  375  	if (!lchip)
^1da177e4c3f41 Linus Torvalds    2005-04-16  376  		return -ENOMEM;
^1da177e4c3f41 Linus Torvalds    2005-04-16  377  
^1da177e4c3f41 Linus Torvalds    2005-04-16  378  	spin_lock_init(&lchip->lock);
^1da177e4c3f41 Linus Torvalds    2005-04-16  379  
^1da177e4c3f41 Linus Torvalds    2005-04-16  380  	lchip->dev = me;
^1da177e4c3f41 Linus Torvalds    2005-04-16  381  	dev_set_drvdata(lchip->dev, lchip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  382  
^1da177e4c3f41 Linus Torvalds    2005-04-16  383  	lchip->phys = mem->start;
^1da177e4c3f41 Linus Torvalds    2005-04-16  384  	lchip->irq = irq;
ac609d266e4af4 Eric Miao         2010-02-04  385  	lchip->irq_base = (pdata) ? pdata->irq_base : NO_IRQ;
^1da177e4c3f41 Linus Torvalds    2005-04-16  386  
^1da177e4c3f41 Linus Torvalds    2005-04-16  387  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  388  	 * Map the whole region.  This also maps the
^1da177e4c3f41 Linus Torvalds    2005-04-16  389  	 * registers for our children.
^1da177e4c3f41 Linus Torvalds    2005-04-16  390  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  391  	lchip->base = ioremap(mem->start, PAGE_SIZE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  392  	if (!lchip->base) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  393  		ret = -ENOMEM;
^1da177e4c3f41 Linus Torvalds    2005-04-16  394  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  395  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  396  
^1da177e4c3f41 Linus Torvalds    2005-04-16  397  	/* locomo initialize */
^1da177e4c3f41 Linus Torvalds    2005-04-16  398  	locomo_writel(0, lchip->base + LOCOMO_ICR);
^1da177e4c3f41 Linus Torvalds    2005-04-16  399  	/* KEYBOARD */
^1da177e4c3f41 Linus Torvalds    2005-04-16  400  	locomo_writel(0, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  401  
^1da177e4c3f41 Linus Torvalds    2005-04-16  402  	/* GPIO */
^1da177e4c3f41 Linus Torvalds    2005-04-16  403  	locomo_writel(0, lchip->base + LOCOMO_GPO);
2a52efb2cecf78 Thomas Kunze      2008-04-29  404  	locomo_writel((LOCOMO_GPIO(1) | LOCOMO_GPIO(2) | LOCOMO_GPIO(13) | LOCOMO_GPIO(14))
^1da177e4c3f41 Linus Torvalds    2005-04-16  405  			, lchip->base + LOCOMO_GPE);
2a52efb2cecf78 Thomas Kunze      2008-04-29  406  	locomo_writel((LOCOMO_GPIO(1) | LOCOMO_GPIO(2) | LOCOMO_GPIO(13) | LOCOMO_GPIO(14))
^1da177e4c3f41 Linus Torvalds    2005-04-16  407  			, lchip->base + LOCOMO_GPD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  408  	locomo_writel(0, lchip->base + LOCOMO_GIE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  409  
e4423781850025 Richard Purdie    2006-06-26  410  	/* Frontlight */
^1da177e4c3f41 Linus Torvalds    2005-04-16  411  	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
^1da177e4c3f41 Linus Torvalds    2005-04-16  412  	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
4ebf2d00260bac Pavel Machek      2006-03-15  413  
^1da177e4c3f41 Linus Torvalds    2005-04-16  414  	/* Longtime timer */
^1da177e4c3f41 Linus Torvalds    2005-04-16  415  	locomo_writel(0, lchip->base + LOCOMO_LTINT);
^1da177e4c3f41 Linus Torvalds    2005-04-16  416  	/* SPI */
1b0d76cb9d5a65 H Hartley Sweeten 2010-03-22  417  	locomo_writel(0, lchip->base + LOCOMO_SPI + LOCOMO_SPIIE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  418  
^1da177e4c3f41 Linus Torvalds    2005-04-16  419  	locomo_writel(6 + 8 + 320 + 30 - 10, lchip->base + LOCOMO_ASD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  420  	r = locomo_readl(lchip->base + LOCOMO_ASD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  421  	r |= 0x8000;
^1da177e4c3f41 Linus Torvalds    2005-04-16  422  	locomo_writel(r, lchip->base + LOCOMO_ASD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  423  
^1da177e4c3f41 Linus Torvalds    2005-04-16  424  	locomo_writel(6 + 8 + 320 + 30 - 10 - 128 + 4, lchip->base + LOCOMO_HSD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  425  	r = locomo_readl(lchip->base + LOCOMO_HSD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  426  	r |= 0x8000;
^1da177e4c3f41 Linus Torvalds    2005-04-16  427  	locomo_writel(r, lchip->base + LOCOMO_HSD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  428  
^1da177e4c3f41 Linus Torvalds    2005-04-16  429  	locomo_writel(128 / 8, lchip->base + LOCOMO_HSC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  430  
^1da177e4c3f41 Linus Torvalds    2005-04-16  431  	/* XON */
^1da177e4c3f41 Linus Torvalds    2005-04-16  432  	locomo_writel(0x80, lchip->base + LOCOMO_TADC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  433  	udelay(1000);
^1da177e4c3f41 Linus Torvalds    2005-04-16  434  	/* CLK9MEN */
^1da177e4c3f41 Linus Torvalds    2005-04-16  435  	r = locomo_readl(lchip->base + LOCOMO_TADC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  436  	r |= 0x10;
^1da177e4c3f41 Linus Torvalds    2005-04-16  437  	locomo_writel(r, lchip->base + LOCOMO_TADC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  438  	udelay(100);
^1da177e4c3f41 Linus Torvalds    2005-04-16  439  
^1da177e4c3f41 Linus Torvalds    2005-04-16  440  	/* init DAC */
^1da177e4c3f41 Linus Torvalds    2005-04-16  441  	r = locomo_readl(lchip->base + LOCOMO_DAC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  442  	r |= LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
^1da177e4c3f41 Linus Torvalds    2005-04-16  443  	locomo_writel(r, lchip->base + LOCOMO_DAC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  444  
^1da177e4c3f41 Linus Torvalds    2005-04-16  445  	r = locomo_readl(lchip->base + LOCOMO_VER);
^1da177e4c3f41 Linus Torvalds    2005-04-16  446  	printk(KERN_INFO "LoCoMo Chip: %lu%lu\n", (r >> 8), (r & 0xff));
^1da177e4c3f41 Linus Torvalds    2005-04-16  447  
^1da177e4c3f41 Linus Torvalds    2005-04-16  448  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  449  	 * The interrupt controller must be initialised before any
^1da177e4c3f41 Linus Torvalds    2005-04-16  450  	 * other device to ensure that the interrupts are available.
^1da177e4c3f41 Linus Torvalds    2005-04-16  451  	 */
ac609d266e4af4 Eric Miao         2010-02-04  452  	if (lchip->irq != NO_IRQ && lchip->irq_base != NO_IRQ)
^1da177e4c3f41 Linus Torvalds    2005-04-16  453  		locomo_setup_irq(lchip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  454  
^1da177e4c3f41 Linus Torvalds    2005-04-16  455  	for (i = 0; i < ARRAY_SIZE(locomo_devices); i++)
^1da177e4c3f41 Linus Torvalds    2005-04-16  456  		locomo_init_one_child(lchip, &locomo_devices[i]);
^1da177e4c3f41 Linus Torvalds    2005-04-16  457  	return 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  458  
^1da177e4c3f41 Linus Torvalds    2005-04-16  459   out:
^1da177e4c3f41 Linus Torvalds    2005-04-16  460  	kfree(lchip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  461  	return ret;
^1da177e4c3f41 Linus Torvalds    2005-04-16  462  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  463  

:::::: The code at line 368 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
