Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE60A7288E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjFHTou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjFHTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:44:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3EA210C;
        Thu,  8 Jun 2023 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686253485; x=1717789485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VxXoH67dsmpaHt3OmDmsDM54npgIe5Q392w5Z0/YsUI=;
  b=AD3aLi8SpkM8t0j1bpOIB5NShvl3Bs7qNxYo7I9DKoUWxlgU/GhK2klP
   SuHasoX0Jv5K2i+8lF71EGjYBVdsW6060iOUAKIlWNAPTfXuj3FNufIP5
   IQG+F5PWsQKsq0asMCA6Hf+pVvVUVIhOUlH4lSr1dsPVqA5ddYu7jbgnP
   ehaxns8k/NHEjT2WjWqjecffF741nH3sYfHSYMewlfzY9EfthE/es52MR
   7IJkEqafegjPJAjRzyDGUf1jMHxeU+OW2XuFGQ5lFdde8ufPL3E6wyO7a
   wgoFnaXr3Fzj6AHijrm7jRR674B8D5GRL/peabk36v5VK54G0YfsPsW9w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="356288957"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="356288957"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 12:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="822754649"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="822754649"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2023 12:44:42 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7LYo-0008Cq-0a;
        Thu, 08 Jun 2023 19:44:42 +0000
Date:   Fri, 9 Jun 2023 03:43:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Stein <linux@ew.tq-group.com>
Subject: Re: [rfc, rft, PATCH v1 1/1] gpio: aggregator: Introduce delay
 support for individual output pins
Message-ID: <202306090344.UJNc4HFx-lkp@intel.com>
References: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linus/master v6.4-rc5 next-20230608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpio-aggregator-Introduce-delay-support-for-individual-output-pins/20230609-002703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230608162130.55015-1-andriy.shevchenko%40linux.intel.com
patch subject: [rfc, rft, PATCH v1 1/1] gpio: aggregator: Introduce delay support for individual output pins
config: hexagon-randconfig-r023-20230608 (https://download.01.org/0day-ci/archive/20230609/202306090344.UJNc4HFx-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add brgl https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
        git fetch brgl gpio/for-next
        git checkout brgl/gpio/for-next
        b4 shazam https://lore.kernel.org/r/20230608162130.55015-1-andriy.shevchenko@linux.intel.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpio/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306090344.UJNc4HFx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpio/gpio-aggregator.c:26:
   In file included from include/linux/gpio/driver.h:6:
   In file included from include/linux/irqchip/chained_irq.h:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/gpio/gpio-aggregator.c:26:
   In file included from include/linux/gpio/driver.h:6:
   In file included from include/linux/irqchip/chained_irq.h:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/gpio/gpio-aggregator.c:26:
   In file included from include/linux/gpio/driver.h:6:
   In file included from include/linux/irqchip/chained_irq.h:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/gpio/gpio-aggregator.c:426:36: error: no member named 'of_gpio_n_cells' in 'struct gpio_chip'
     426 |         if (gpiospec->args_count != chip->of_gpio_n_cells)
         |                                     ~~~~  ^
>> drivers/gpio/gpio-aggregator.c:518:9: error: no member named 'of_xlate' in 'struct gpio_chip'
     518 |                 chip->of_xlate = gpiochip_fwd_delay_of_xlate;
         |                 ~~~~  ^
   drivers/gpio/gpio-aggregator.c:519:9: error: no member named 'of_gpio_n_cells' in 'struct gpio_chip'
     519 |                 chip->of_gpio_n_cells = 3;
         |                 ~~~~  ^
   6 warnings and 3 errors generated.


vim +426 drivers/gpio/gpio-aggregator.c

   417	
   418	static int gpiochip_fwd_delay_of_xlate(struct gpio_chip *chip,
   419					       const struct of_phandle_args *gpiospec,
   420					       u32 *flags)
   421	{
   422		struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
   423		struct gpiochip_fwd_timing *timings;
   424		u32 line;
   425	
 > 426		if (gpiospec->args_count != chip->of_gpio_n_cells)
   427			return -EINVAL;
   428	
   429		line = gpiospec->args[0];
   430		if (line >= chip->ngpio)
   431			return -EINVAL;
   432	
   433		timings = &fwd->delay_timings[line];
   434		timings->ramp_up_us = gpiospec->args[1];
   435		timings->ramp_down_us = gpiospec->args[2];
   436	
   437		return line;
   438	}
   439	
   440	/**
   441	 * gpiochip_fwd_create() - Create a new GPIO forwarder
   442	 * @dev: Parent device pointer
   443	 * @ngpios: Number of GPIOs in the forwarder.
   444	 * @descs: Array containing the GPIO descriptors to forward to.
   445	 *         This array must contain @ngpios entries, and must not be deallocated
   446	 *         before the forwarder has been destroyed again.
   447	 * @delay: True if the pins have an external delay line.
   448	 *
   449	 * This function creates a new gpiochip, which forwards all GPIO operations to
   450	 * the passed GPIO descriptors.
   451	 *
   452	 * Return: An opaque object pointer, or an ERR_PTR()-encoded negative error
   453	 *         code on failure.
   454	 */
   455	static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
   456							unsigned int ngpios,
   457							struct gpio_desc *descs[],
   458							bool delay)
   459	{
   460		const char *label = dev_name(dev);
   461		struct gpiochip_fwd *fwd;
   462		struct gpio_chip *chip;
   463		unsigned int i;
   464		int error;
   465	
   466		fwd = devm_kzalloc(dev, struct_size(fwd, tmp, fwd_tmp_size(ngpios)),
   467				   GFP_KERNEL);
   468		if (!fwd)
   469			return ERR_PTR(-ENOMEM);
   470	
   471		chip = &fwd->chip;
   472	
   473		/*
   474		 * If any of the GPIO lines are sleeping, then the entire forwarder
   475		 * will be sleeping.
   476		 * If any of the chips support .set_config(), then the forwarder will
   477		 * support setting configs.
   478		 */
   479		for (i = 0; i < ngpios; i++) {
   480			struct gpio_chip *parent = gpiod_to_chip(descs[i]);
   481	
   482			dev_dbg(dev, "%u => gpio %d irq %d\n", i,
   483				desc_to_gpio(descs[i]), gpiod_to_irq(descs[i]));
   484	
   485			if (gpiod_cansleep(descs[i]))
   486				chip->can_sleep = true;
   487			if (parent && parent->set_config)
   488				chip->set_config = gpio_fwd_set_config;
   489		}
   490	
   491		chip->label = label;
   492		chip->parent = dev;
   493		chip->owner = THIS_MODULE;
   494		chip->get_direction = gpio_fwd_get_direction;
   495		chip->direction_input = gpio_fwd_direction_input;
   496		chip->direction_output = gpio_fwd_direction_output;
   497		chip->get = gpio_fwd_get;
   498		chip->get_multiple = gpio_fwd_get_multiple_locked;
   499		chip->set = gpio_fwd_set;
   500		chip->set_multiple = gpio_fwd_set_multiple_locked;
   501		chip->to_irq = gpio_fwd_to_irq;
   502		chip->base = -1;
   503		chip->ngpio = ngpios;
   504		fwd->descs = descs;
   505	
   506		if (chip->can_sleep)
   507			mutex_init(&fwd->mlock);
   508		else
   509			spin_lock_init(&fwd->slock);
   510	
   511		if (delay) {
   512			fwd->delay_timings = devm_kcalloc(dev, ngpios,
   513							  sizeof(*fwd->delay_timings),
   514							  GFP_KERNEL);
   515			if (!fwd->delay_timings)
   516				return ERR_PTR(-ENOMEM);
   517	
 > 518			chip->of_xlate = gpiochip_fwd_delay_of_xlate;
   519			chip->of_gpio_n_cells = 3;
   520		}
   521	
   522		error = devm_gpiochip_add_data(dev, chip, fwd);
   523		if (error)
   524			return ERR_PTR(error);
   525	
   526		return fwd;
   527	}
   528	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
