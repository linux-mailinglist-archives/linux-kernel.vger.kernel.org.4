Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839076AB1F0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 21:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCEUDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 15:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCEUDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 15:03:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580098698;
        Sun,  5 Mar 2023 12:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678046624; x=1709582624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bqRe0Z0O35yKJ6cOgQ/137jnjsMD36jKGggI3zjJCfA=;
  b=I1c44JD35Jo9VxJ1C2PxIst4Iz3NpUC7dZ4uLpgNFNZE7Cxd0ZHfYlFT
   eWfXFY1oxJV6GQznSr8axgcfJpGtYXS2sIvP1I6ps2LE1nzuJMuyUseqF
   Gau3h9vUOtoV+LnGmdrccMNzz46hvlxyj/+fEMxTXUZWt4+0EMrKIeiTL
   N1yQQoOwLOr6zOeYWNpXC++bk38M/rMDZJGie60A9ejeu4uK61CFNTLLa
   u6EpywOkzGPrrJr+pmuqp3VYSDsuY6JbwWOQElfnC0rU+SbcA9YQCdUmJ
   Vm55CCfH4nmC+qYz0MnvE6PYrtQgybIEXwVOcCiWODGxUqvWdztqVwoKk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="363027765"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="363027765"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 12:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="678266022"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="678266022"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 05 Mar 2023 12:03:41 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYua4-000312-2d;
        Sun, 05 Mar 2023 20:03:40 +0000
Date:   Mon, 6 Mar 2023 04:03:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnaud de Turckheim <quarium@gmail.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: Re: [PATCH v3 2/3] gpio: pcie-idio-24: Migrate to the regmap API
Message-ID: <202303060355.RtbgFd25-lkp@intel.com>
References: <278e328cd1689a4e331e7515050c12c29f2a4785.1678034378.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278e328cd1689a4e331e7515050c12c29f2a4785.1678034378.git.william.gray@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 4827aae061337251bb91801b316157a78b845ec7]

url:    https://github.com/intel-lab-lkp/linux/commits/William-Breathitt-Gray/regmap-Pass-irq_drv_data-as-a-parameter-for-set_type_config/20230306-010313
base:   4827aae061337251bb91801b316157a78b845ec7
patch link:    https://lore.kernel.org/r/278e328cd1689a4e331e7515050c12c29f2a4785.1678034378.git.william.gray%40linaro.org
patch subject: [PATCH v3 2/3] gpio: pcie-idio-24: Migrate to the regmap API
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20230306/202303060355.RtbgFd25-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e60d5c32ff098c33b1e171190079ed3f40180008
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review William-Breathitt-Gray/regmap-Pass-irq_drv_data-as-a-parameter-for-set_type_config/20230306-010313
        git checkout e60d5c32ff098c33b1e171190079ed3f40180008
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303060355.RtbgFd25-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-pcie-idio-24.c:365:2: warning: variable 'idio24gpio' is uninitialized when used here [-Wuninitialized]
           idio24gpio->map = devm_regmap_init_mmio(dev, idio_24_regs,
           ^~~~~~~~~~
   drivers/gpio/gpio-pcie-idio-24.c:333:33: note: initialize the variable 'idio24gpio' to silence this warning
           struct idio_24_gpio *idio24gpio;
                                          ^
                                           = NULL
   1 warning generated.


vim +/idio24gpio +365 drivers/gpio/gpio-pcie-idio-24.c

   329	
   330	static int idio_24_probe(struct pci_dev *pdev, const struct pci_device_id *id)
   331	{
   332		struct device *const dev = &pdev->dev;
   333		struct idio_24_gpio *idio24gpio;
   334		int err;
   335		const size_t pci_plx_bar_index = 1;
   336		const size_t pci_bar_index = 2;
   337		const char *const name = pci_name(pdev);
   338		struct gpio_regmap_config gpio_config = {};
   339		void __iomem *pex8311_intcsr;
   340		void __iomem *idio_24_regs;
   341		struct regmap *pex8311_intcsr_map;
   342		struct regmap_irq_chip *chip;
   343		struct regmap_irq_chip_data *chip_data;
   344	
   345		err = pcim_enable_device(pdev);
   346		if (err) {
   347			dev_err(dev, "Failed to enable PCI device (%d)\n", err);
   348			return err;
   349		}
   350	
   351		err = pcim_iomap_regions(pdev, BIT(pci_plx_bar_index) | BIT(pci_bar_index), name);
   352		if (err) {
   353			dev_err(dev, "Unable to map PCI I/O addresses (%d)\n", err);
   354			return err;
   355		}
   356	
   357		pex8311_intcsr = pcim_iomap_table(pdev)[pci_plx_bar_index] + PLX_PEX8311_PCI_LCS_INTCSR;
   358		idio_24_regs = pcim_iomap_table(pdev)[pci_bar_index];
   359	
   360		pex8311_intcsr_map = devm_regmap_init_mmio(dev, pex8311_intcsr,
   361							   &pex8311_intcsr_regmap_config);
   362		if (IS_ERR(pex8311_intcsr_map))
   363			return dev_err_probe(dev, PTR_ERR(pex8311_intcsr_map),
   364					     "Unable to initialize PEX8311 register map\n");
 > 365		idio24gpio->map = devm_regmap_init_mmio(dev, idio_24_regs,
   366						    &idio_24_regmap_config);
   367		if (IS_ERR(idio24gpio->map))
   368			return dev_err_probe(dev, PTR_ERR(idio24gpio->map),
   369					     "Unable to initialize register map\n");
   370	
   371		idio24gpio = devm_kzalloc(dev, sizeof(*idio24gpio), GFP_KERNEL);
   372		if (!idio24gpio)
   373			return -ENOMEM;
   374	
   375		mutex_init(&idio24gpio->lock);
   376	
   377		/* Initialize all IRQ type configuration to IRQ_TYPE_EDGE_BOTH */
   378		idio24gpio->irq_type = GENMASK(7, 0);
   379	
   380		chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
   381		if (!chip)
   382			return -ENOMEM;
   383	
   384		chip->name = name;
   385		chip->status_base = IDIO_24_COS_STATUS_BASE;
   386		chip->mask_base = IDIO_24_COS_ENABLE;
   387		chip->ack_base = IDIO_24_COS_STATUS_BASE;
   388		chip->num_regs = 4;
   389		chip->irqs = idio_24_regmap_irqs;
   390		chip->num_irqs = ARRAY_SIZE(idio_24_regmap_irqs);
   391		chip->handle_mask_sync = idio_24_handle_mask_sync;
   392		chip->set_type_config = idio_24_set_type_config;
   393		chip->irq_drv_data = idio24gpio;
   394	
   395		/* Software board reset */
   396		err = regmap_write(idio24gpio->map, IDIO_24_SOFT_RESET, 0);
   397		if (err)
   398			return err;
   399		/*
   400		 * enable PLX PEX8311 internal PCI wire interrupt and local interrupt
   401		 * input
   402		 */
   403		err = regmap_update_bits(pex8311_intcsr_map, 0x0, IDIO_24_ENABLE_IRQ,
   404					 IDIO_24_ENABLE_IRQ);
   405		if (err)
   406			return err;
   407	
   408		err = devm_regmap_add_irq_chip(dev, idio24gpio->map, pdev->irq, 0, 0,
   409					       chip, &chip_data);
   410		if (err)
   411			return dev_err_probe(dev, err, "IRQ registration failed\n");
   412	
   413		gpio_config.parent = dev;
   414		gpio_config.regmap = idio24gpio->map;
   415		gpio_config.ngpio = IDIO_24_NGPIO;
   416		gpio_config.names = idio_24_names;
   417		gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(IDIO_24_OUT_BASE);
   418		gpio_config.reg_set_base = GPIO_REGMAP_ADDR(IDIO_24_OUT_BASE);
   419		gpio_config.reg_dir_out_base = GPIO_REGMAP_ADDR(IDIO_24_CONTROL_REG);
   420		gpio_config.ngpio_per_reg = IDIO_24_NGPIO_PER_REG;
   421		gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
   422		gpio_config.reg_mask_xlate = idio_24_reg_mask_xlate;
   423		gpio_config.drvdata = idio24gpio->map;
   424	
   425		return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
   426	}
   427	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
