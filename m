Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0542072116D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 19:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjFCRsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 13:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFCRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 13:48:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9B1198;
        Sat,  3 Jun 2023 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685814529; x=1717350529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GFg7AW6jCtnAXjw+8qg5r6EgwDiKi2rSwpOiz19TbiM=;
  b=lq1GYlZSdlIxB4loju+a7JO7cf5rPi8BtEgkB1y2NEAhm11he4456tkG
   dpDOxgPFK7puEzkla20GWtmbQo1dkteX2prglQ1Ft2xqy6kIZAEpPZFsw
   uCRf84+PQFuyPlWmPg11AwBs7dBMeM9VO2sV4Qiqe+JSsV8bA0Afut7PU
   hnb32OK8tBGInc4Tzh8x/IwSEcDuWAsuXIcXLb6WBFxH40gJFM024WQWT
   dRJz2X10QcEG/OxomWSw3McypMSlzjBzzSLE5PKwbnIkHzeYqSc3DC3JB
   EPePuRTO1e1SMelepUewY/w4EIfAaGEGWUsv3UaTvmimXqFpUNPntj1zz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="353589893"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="353589893"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 10:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="778061812"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="778061812"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jun 2023 10:48:46 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5VMr-0001rV-1p;
        Sat, 03 Jun 2023 17:48:45 +0000
Date:   Sun, 4 Jun 2023 01:47:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, andy.shevchenko@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
        brgl@bgdev.pl, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v2] gpio: sifive: Add missing check for platform_get_irq
Message-ID: <202306040153.RPAlkz3U-lkp@intel.com>
References: <20230602072755.7314-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602072755.7314-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on linus/master v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiasheng-Jiang/gpio-sifive-Add-missing-check-for-platform_get_irq/20230602-152856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230602072755.7314-1-jiasheng%40iscas.ac.cn
patch subject: [PATCH v2] gpio: sifive: Add missing check for platform_get_irq
config: openrisc-randconfig-m041-20230531 (https://download.01.org/0day-ci/archive/20230604/202306040153.RPAlkz3U-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306040153.RPAlkz3U-lkp@intel.com/

smatch warnings:
drivers/gpio/gpio-sifive.c:226 sifive_gpio_probe() warn: unsigned 'chip->irq_number[i]' is never less than zero.

vim +226 drivers/gpio/gpio-sifive.c

   179	
   180	static int sifive_gpio_probe(struct platform_device *pdev)
   181	{
   182		struct device *dev = &pdev->dev;
   183		struct device_node *node = pdev->dev.of_node;
   184		struct device_node *irq_parent;
   185		struct irq_domain *parent;
   186		struct gpio_irq_chip *girq;
   187		struct sifive_gpio *chip;
   188		int ret, ngpio, i;
   189	
   190		chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
   191		if (!chip)
   192			return -ENOMEM;
   193	
   194		chip->base = devm_platform_ioremap_resource(pdev, 0);
   195		if (IS_ERR(chip->base)) {
   196			dev_err(dev, "failed to allocate device memory\n");
   197			return PTR_ERR(chip->base);
   198		}
   199	
   200		chip->regs = devm_regmap_init_mmio(dev, chip->base,
   201						   &sifive_gpio_regmap_config);
   202		if (IS_ERR(chip->regs))
   203			return PTR_ERR(chip->regs);
   204	
   205		ngpio = of_irq_count(node);
   206		if (ngpio > SIFIVE_GPIO_MAX) {
   207			dev_err(dev, "Too many GPIO interrupts (max=%d)\n",
   208				SIFIVE_GPIO_MAX);
   209			return -ENXIO;
   210		}
   211	
   212		irq_parent = of_irq_find_parent(node);
   213		if (!irq_parent) {
   214			dev_err(dev, "no IRQ parent node\n");
   215			return -ENODEV;
   216		}
   217		parent = irq_find_host(irq_parent);
   218		of_node_put(irq_parent);
   219		if (!parent) {
   220			dev_err(dev, "no IRQ parent domain\n");
   221			return -ENODEV;
   222		}
   223	
   224		for (i = 0; i < ngpio; i++) {
   225			chip->irq_number[i] = platform_get_irq(pdev, i);
 > 226			if (chip->irq_number[i] < 0)
   227				return chip->irq_number[i];
   228		}
   229	
   230		ret = bgpio_init(&chip->gc, dev, 4,
   231				 chip->base + SIFIVE_GPIO_INPUT_VAL,
   232				 chip->base + SIFIVE_GPIO_OUTPUT_VAL,
   233				 NULL,
   234				 chip->base + SIFIVE_GPIO_OUTPUT_EN,
   235				 chip->base + SIFIVE_GPIO_INPUT_EN,
   236				 BGPIOF_READ_OUTPUT_REG_SET);
   237		if (ret) {
   238			dev_err(dev, "unable to init generic GPIO\n");
   239			return ret;
   240		}
   241	
   242		/* Disable all GPIO interrupts before enabling parent interrupts */
   243		regmap_write(chip->regs, SIFIVE_GPIO_RISE_IE, 0);
   244		regmap_write(chip->regs, SIFIVE_GPIO_FALL_IE, 0);
   245		regmap_write(chip->regs, SIFIVE_GPIO_HIGH_IE, 0);
   246		regmap_write(chip->regs, SIFIVE_GPIO_LOW_IE, 0);
   247		chip->irq_state = 0;
   248	
   249		chip->gc.base = -1;
   250		chip->gc.ngpio = ngpio;
   251		chip->gc.label = dev_name(dev);
   252		chip->gc.parent = dev;
   253		chip->gc.owner = THIS_MODULE;
   254		girq = &chip->gc.irq;
   255		gpio_irq_chip_set_chip(girq, &sifive_gpio_irqchip);
   256		girq->fwnode = of_node_to_fwnode(node);
   257		girq->parent_domain = parent;
   258		girq->child_to_parent_hwirq = sifive_gpio_child_to_parent_hwirq;
   259		girq->handler = handle_bad_irq;
   260		girq->default_type = IRQ_TYPE_NONE;
   261	
   262		platform_set_drvdata(pdev, chip);
   263		return gpiochip_add_data(&chip->gc, chip);
   264	}
   265	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
