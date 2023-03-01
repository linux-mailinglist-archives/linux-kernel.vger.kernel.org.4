Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA516A66EC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCAEMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCAEMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:12:10 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F51D37F1A;
        Tue, 28 Feb 2023 20:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677643928; x=1709179928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aw1ZX5J93CzeAAr+tKIN+lv6xOoZ1LyTF1oXu5fr9aU=;
  b=kCViCz9bXQh/+ji5Krr5/yIfeabqTn7bMckKOvaxawetpX7BVtJsxkWb
   EaxJL6zHMQGeOyvkpoTsQ10G6t+cm0t9//vXsJ6O6X2PMEjhMqcuS73GC
   1KVvUvcyoU2Z2AWQUuTqj1iPdeNiqlg9sGBmy58rUo/u3Ceo8c9fMw1al
   7jAmydpRIKo5MT8xn30jqXSdLbLGKyE0+18A79OFTzLsm4CHhZOQoXyEK
   pMrwMFBc5L0eiBJPBiNZ5skxunmTI83otZtKYXoD40aj+CEyzh8v7z+G5
   UOxhf8MFXNl+shKopK9MhxM2b+vLsTOPG50tjt5yARAfAfw6WE9tbFJGG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="313986863"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="313986863"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 20:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="674413220"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="674413220"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Feb 2023 20:12:04 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXDoy-0005sU-0j;
        Wed, 01 Mar 2023 04:12:04 +0000
Date:   Wed, 1 Mar 2023 12:11:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, quarium@gmail.com,
        jhentges@accesio.com, jay.dolan@accesio.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: Re: [PATCH 3/3] gpio: pcie-idio-24: Migrate to the regmap API
Message-ID: <202303011146.BnevM8E4-lkp@intel.com>
References: <39f4c4b7083b2a50973e0ac5b4b1db5040fcda53.1677547393.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f4c4b7083b2a50973e0ac5b4b1db5040fcda53.1677547393.git.william.gray@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 4827aae061337251bb91801b316157a78b845ec7]

url:    https://github.com/intel-lab-lkp/linux/commits/William-Breathitt-Gray/regmap-Pass-regmap-and-irq_drv_data-as-parameters-for-set_type_config/20230301-030010
base:   4827aae061337251bb91801b316157a78b845ec7
patch link:    https://lore.kernel.org/r/39f4c4b7083b2a50973e0ac5b4b1db5040fcda53.1677547393.git.william.gray%40linaro.org
patch subject: [PATCH 3/3] gpio: pcie-idio-24: Migrate to the regmap API
config: x86_64-randconfig-a001-20230227 (https://download.01.org/0day-ci/archive/20230301/202303011146.BnevM8E4-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6f59a8e427da386890ca2eaccab41064a250ebea
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review William-Breathitt-Gray/regmap-Pass-regmap-and-irq_drv_data-as-parameters-for-set_type_config/20230301-030010
        git checkout 6f59a8e427da386890ca2eaccab41064a250ebea
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303011146.BnevM8E4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-pcie-idio-24.c:353:7: warning: variable 'irq_type' is uninitialized when used here [-Wuninitialized]
           if (!irq_type)
                ^~~~~~~~
   drivers/gpio/gpio-pcie-idio-24.c:319:23: note: initialize the variable 'irq_type' to silence this warning
           unsigned int irq_type;
                                ^
                                 = 0
   1 warning generated.


vim +/irq_type +353 drivers/gpio/gpio-pcie-idio-24.c

   305	
   306	static int idio_24_probe(struct pci_dev *pdev, const struct pci_device_id *id)
   307	{
   308		struct device *const dev = &pdev->dev;
   309		int err;
   310		const size_t pci_plx_bar_index = 1;
   311		const size_t pci_bar_index = 2;
   312		const char *const name = pci_name(pdev);
   313		struct gpio_regmap_config gpio_config = {};
   314		void __iomem *pex8311_intcsr;
   315		void __iomem *idio_24_regs;
   316		struct regmap *pex8311_intcsr_map;
   317		struct regmap *idio_24_map;
   318		struct regmap_irq_chip *chip;
   319		unsigned int irq_type;
   320		struct regmap_irq_chip_data *chip_data;
   321	
   322		err = pcim_enable_device(pdev);
   323		if (err) {
   324			dev_err(dev, "Failed to enable PCI device (%d)\n", err);
   325			return err;
   326		}
   327	
   328		err = pcim_iomap_regions(pdev, BIT(pci_plx_bar_index) | BIT(pci_bar_index), name);
   329		if (err) {
   330			dev_err(dev, "Unable to map PCI I/O addresses (%d)\n", err);
   331			return err;
   332		}
   333	
   334		pex8311_intcsr = pcim_iomap_table(pdev)[pci_plx_bar_index] + PLX_PEX8311_PCI_LCS_INTCSR;
   335		idio_24_regs = pcim_iomap_table(pdev)[pci_bar_index];
   336	
   337		pex8311_intcsr_map = devm_regmap_init_mmio(dev, pex8311_intcsr,
   338							   &pex8311_intcsr_regmap_config);
   339		if (IS_ERR(pex8311_intcsr_map))
   340			return dev_err_probe(dev, PTR_ERR(pex8311_intcsr_map),
   341					     "Unable to initialize PEX8311 register map\n");
   342		idio_24_map = devm_regmap_init_mmio(dev, idio_24_regs,
   343						    &idio_24_regmap_config);
   344		if (IS_ERR(idio_24_map))
   345			return dev_err_probe(dev, PTR_ERR(idio_24_map),
   346					     "Unable to initialize register map\n");
   347	
   348		chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
   349		if (!chip)
   350			return -ENOMEM;
   351	
   352		chip->irq_drv_data = devm_kzalloc(dev, sizeof(irq_type), GFP_KERNEL);
 > 353		if (!irq_type)
   354			return -ENOMEM;
   355	
   356		chip->name = name;
   357		chip->status_base = IDIO_24_STATUS_BASE;
   358		chip->mask_base = IDIO_24_COS_ENABLE;
   359		chip->ack_base = IDIO_24_ACK_BASE;
   360		chip->num_regs = 4;
   361		chip->irqs = idio_24_regmap_irqs;
   362		chip->num_irqs = ARRAY_SIZE(idio_24_regmap_irqs);
   363		chip->handle_mask_sync = idio_24_handle_mask_sync;
   364		chip->set_type_config = idio_24_set_type_config;
   365	
   366		/* Software board reset */
   367		err = regmap_write(idio_24_map, IDIO_24_SOFT_RESET, 0);
   368		if (err)
   369			return err;
   370		/*
   371		 * enable PLX PEX8311 internal PCI wire interrupt and local interrupt
   372		 * input
   373		 */
   374		err = regmap_update_bits(pex8311_intcsr_map, 0x0, IDIO_24_ENABLE_IRQ,
   375					 IDIO_24_ENABLE_IRQ);
   376		if (err)
   377			return err;
   378	
   379		err = devm_regmap_add_irq_chip(dev, idio_24_map, pdev->irq, 0, 0, chip,
   380					       &chip_data);
   381		if (err)
   382			return dev_err_probe(dev, err, "IRQ registration failed\n");
   383	
   384		gpio_config.parent = dev;
   385		gpio_config.regmap = idio_24_map;
   386		gpio_config.ngpio = IDIO_24_NGPIO;
   387		gpio_config.names = idio_24_names;
   388		gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(IDIO_24_DAT_BASE);
   389		gpio_config.reg_set_base = GPIO_REGMAP_ADDR(IDIO_24_DAT_BASE);
   390		gpio_config.reg_dir_out_base = GPIO_REGMAP_ADDR(IDIO_24_CONTROL_REG);
   391		gpio_config.ngpio_per_reg = IDIO_24_NGPIO_PER_REG;
   392		gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
   393		gpio_config.reg_mask_xlate = idio_24_reg_mask_xlate;
   394	
   395		return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
   396	}
   397	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
