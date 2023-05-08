Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3AC6FB948
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjEHVUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:20:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC118F;
        Mon,  8 May 2023 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683580816; x=1715116816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZXD+ewt6EPlLmAFkTGfXobVhsHMapRgravjPxFdOVE4=;
  b=a43J2D7mz0ajuhi6OAaU97iordnG5/AXXlAYqyCyZv97YR0h/TWAQR+U
   bUsg8vf/UjgpH0rH6H7p+gisnoCMqIu/U2kaJt4zpgMZi3Og3O/WV3hjS
   SlWG86Aaf5jTf+nGbDi3TGsjnurwsaHJ1JTQpCrbSaZRotmMK5IjAzkcO
   7VZ2SzBLajeizdHOgj/jJjz8l3k+SpklWJI3fTICrU1fZ0IXTAG4mWxAH
   wUXUEUaQ0j+hzB96fUY/A+UkLQomXKYxuHb/31TRD2fovo/5It3QAZJsf
   uvn1JuanRrfAYYrEj3C7TwmrA9/k6BWDkup9yZJzIWmxb+HO5fxg6kDsd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436079617"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="436079617"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:19:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="692727524"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="692727524"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 May 2023 14:19:42 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw8Gk-0001QT-02;
        Mon, 08 May 2023 21:19:42 +0000
Date:   Tue, 9 May 2023 05:19:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lizhe <sensor1010@163.com>, marcan@marcan.st, sven@svenpeter.dev,
        alyssa@rosenzweig.io, linus.walleij@linaro.org,
        neil.armstrong@linaro.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr
Cc:     oe-kbuild-all@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-oxnas@groups.io,
        linux-stm32@st-md-mailman.stormreply.com,
        Lizhe <sensor1010@163.com>
Subject: Re: [PATCH] dirvers/pinctrl.c : using pinctrl_dev->dev to obtain
 struct device * dev
Message-ID: <202305090411.OyJRHVis-lkp@intel.com>
References: <20230508154043.11859-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508154043.11859-1-sensor1010@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lizhe,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next linus/master v6.4-rc1 next-20230508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lizhe/dirvers-pinctrl-c-using-pinctrl_dev-dev-to-obtain-struct-device-dev/20230508-234502
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230508154043.11859-1-sensor1010%40163.com
patch subject: [PATCH] dirvers/pinctrl.c : using pinctrl_dev->dev to obtain struct device * dev
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230509/202305090411.OyJRHVis-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/83751a28d7f5223597b6742300796fb80362dc20
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lizhe/dirvers-pinctrl-c-using-pinctrl_dev-dev-to-obtain-struct-device-dev/20230508-234502
        git checkout 83751a28d7f5223597b6742300796fb80362dc20
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305090411.OyJRHVis-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/pinctrl/pinctrl-stmfx.c:12:
   drivers/pinctrl/pinctrl-stmfx.c: In function 'stmfx_pinctrl_probe':
>> drivers/pinctrl/pinctrl-stmfx.c:714:25: error: 'pctldev' undeclared (first use in this function); did you mean 'pci_dev'?
     714 |                 dev_err(pctldev->dev, "gpio_chip registration failed\n");
         |                         ^~~~~~~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/pinctrl/pinctrl-stmfx.c:714:17: note: in expansion of macro 'dev_err'
     714 |                 dev_err(pctldev->dev, "gpio_chip registration failed\n");
         |                 ^~~~~~~
   drivers/pinctrl/pinctrl-stmfx.c:714:25: note: each undeclared identifier is reported only once for each function it appears in
     714 |                 dev_err(pctldev->dev, "gpio_chip registration failed\n");
         |                         ^~~~~~~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/pinctrl/pinctrl-stmfx.c:714:17: note: in expansion of macro 'dev_err'
     714 |                 dev_err(pctldev->dev, "gpio_chip registration failed\n");
         |                 ^~~~~~~
--
   In file included from include/linux/printk.h:564,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:11,
                    from drivers/pinctrl/pxa/pinctrl-pxa2xx.c:9:
   drivers/pinctrl/pxa/pinctrl-pxa2xx.c: In function 'pxa2xx_pmx_gpio_set_direction':
>> drivers/pinctrl/pxa/pinctrl-pxa2xx.c:94:24: error: invalid use of undefined type 'struct pinctrl_dev'
      94 |         dev_dbg(pctldev->dev, "set_direction(pin=%d): dir=%d\n",
         |                        ^~
   include/linux/dynamic_debug.h:222:29: note: in definition of macro '__dynamic_func_call_cls'
     222 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '_dynamic_func_call_cls'
     248 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:271:9: note: in expansion of macro '_dynamic_func_call'
     271 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/pinctrl/pxa/pinctrl-pxa2xx.c:94:9: note: in expansion of macro 'dev_dbg'
      94 |         dev_dbg(pctldev->dev, "set_direction(pin=%d): dir=%d\n",
         |         ^~~~~~~
   drivers/pinctrl/pxa/pinctrl-pxa2xx.c: In function 'pxa2xx_pmx_set_mux':
   drivers/pinctrl/pxa/pinctrl-pxa2xx.c:159:24: error: invalid use of undefined type 'struct pinctrl_dev'
     159 |         dev_dbg(pctldev->dev, "set_mux(pin=%d): af=%d dir=%d\n",
         |                        ^~
   include/linux/dynamic_debug.h:222:29: note: in definition of macro '__dynamic_func_call_cls'
     222 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '_dynamic_func_call_cls'
     248 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:271:9: note: in expansion of macro '_dynamic_func_call'
     271 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/pinctrl/pxa/pinctrl-pxa2xx.c:159:9: note: in expansion of macro 'dev_dbg'
     159 |         dev_dbg(pctldev->dev, "set_mux(pin=%d): af=%d dir=%d\n",
         |         ^~~~~~~


vim +714 drivers/pinctrl/pinctrl-stmfx.c

   638	
   639	static int stmfx_pinctrl_probe(struct platform_device *pdev)
   640	{
   641		struct stmfx *stmfx = dev_get_drvdata(pdev->dev.parent);
   642		struct device_node *np = pdev->dev.of_node;
   643		struct stmfx_pinctrl *pctl;
   644		struct gpio_irq_chip *girq;
   645		int irq, ret;
   646	
   647		pctl = devm_kzalloc(stmfx->dev, sizeof(*pctl), GFP_KERNEL);
   648		if (!pctl)
   649			return -ENOMEM;
   650	
   651		platform_set_drvdata(pdev, pctl);
   652	
   653		pctl->dev = &pdev->dev;
   654		pctl->stmfx = stmfx;
   655	
   656		if (!of_property_present(np, "gpio-ranges")) {
   657			dev_err(pctl->dev, "missing required gpio-ranges property\n");
   658			return -EINVAL;
   659		}
   660	
   661		irq = platform_get_irq(pdev, 0);
   662		if (irq <= 0)
   663			return -ENXIO;
   664	
   665		mutex_init(&pctl->lock);
   666	
   667		/* Register pin controller */
   668		pctl->pctl_desc.name = "stmfx-pinctrl";
   669		pctl->pctl_desc.pctlops = &stmfx_pinctrl_ops;
   670		pctl->pctl_desc.confops = &stmfx_pinconf_ops;
   671		pctl->pctl_desc.pins = stmfx_pins;
   672		pctl->pctl_desc.npins = ARRAY_SIZE(stmfx_pins);
   673		pctl->pctl_desc.owner = THIS_MODULE;
   674		pctl->pctl_desc.link_consumers = true;
   675	
   676		ret = devm_pinctrl_register_and_init(pctl->dev, &pctl->pctl_desc,
   677						     pctl, &pctl->pctl_dev);
   678		if (ret) {
   679			dev_err(pctl->dev, "pinctrl registration failed\n");
   680			return ret;
   681		}
   682	
   683		ret = pinctrl_enable(pctl->pctl_dev);
   684		if (ret) {
   685			dev_err(pctl->dev, "pinctrl enable failed\n");
   686			return ret;
   687		}
   688	
   689		/* Register gpio controller */
   690		pctl->gpio_chip.label = "stmfx-gpio";
   691		pctl->gpio_chip.parent = pctl->dev;
   692		pctl->gpio_chip.get_direction = stmfx_gpio_get_direction;
   693		pctl->gpio_chip.direction_input = stmfx_gpio_direction_input;
   694		pctl->gpio_chip.direction_output = stmfx_gpio_direction_output;
   695		pctl->gpio_chip.get = stmfx_gpio_get;
   696		pctl->gpio_chip.set = stmfx_gpio_set;
   697		pctl->gpio_chip.set_config = gpiochip_generic_config;
   698		pctl->gpio_chip.base = -1;
   699		pctl->gpio_chip.ngpio = pctl->pctl_desc.npins;
   700		pctl->gpio_chip.can_sleep = true;
   701	
   702		girq = &pctl->gpio_chip.irq;
   703		gpio_irq_chip_set_chip(girq, &stmfx_pinctrl_irq_chip);
   704		/* This will let us handle the parent IRQ in the driver */
   705		girq->parent_handler = NULL;
   706		girq->num_parents = 0;
   707		girq->parents = NULL;
   708		girq->default_type = IRQ_TYPE_NONE;
   709		girq->handler = handle_bad_irq;
   710		girq->threaded = true;
   711	
   712		ret = devm_gpiochip_add_data(pctl->dev, &pctl->gpio_chip, pctl);
   713		if (ret) {
 > 714			dev_err(pctldev->dev, "gpio_chip registration failed\n");
   715			return ret;
   716		}
   717	
   718		ret = stmfx_pinctrl_gpio_function_enable(pctl);
   719		if (ret)
   720			return ret;
   721	
   722		ret = devm_request_threaded_irq(pctl->dev, irq, NULL,
   723						stmfx_pinctrl_irq_thread_fn,
   724						IRQF_ONESHOT,
   725						dev_name(pctl->dev), pctl);
   726		if (ret) {
   727			dev_err(pctldev->dev, "cannot request irq%d\n", irq);
   728			return ret;
   729		}
   730	
   731		dev_info(pctldev->dev,
   732			 "%ld GPIOs available\n", hweight_long(pctl->gpio_valid_mask));
   733	
   734		return 0;
   735	}
   736	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
