Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDFD692768
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjBJTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjBJTsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:48:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C3241DA;
        Fri, 10 Feb 2023 11:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676058477; x=1707594477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i+KB61FTKNIuFq1GlPUNiKJj7lmRriDdUCRgpzPS5y8=;
  b=d20Avkp94nNhNTPHhBGGD8BrokCE7J8GtM7oI3Tb88XbZcG8I32X61jP
   NbvhcD0uu60u5q54rsTBUpwflbkePc8Wm2NNVV6gUCXZk3r1Bg+b0g9Jg
   YRITZalxUJRriTrPJgHeJi4BKtlZkdyUtuR7ZezQtd5uvCc6GkzR2Duvo
   6/RlZca78r1Lva1t6iu+mnYzPzWcqQsnKgfRra7huYJ1rRC0VNwWfeyzJ
   0l4pLIa+c8z+guw4Dfn6BzoCFpH75+80fyzLfwtatZep4KsV56N57hrVZ
   Aza5fngd1eh3gMCtot8eSoiq2yp5Sj0bnxK/Dz/RSSKmhPeuLCzjS0asd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="331814922"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="331814922"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 11:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="661502477"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="661502477"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2023 11:43:45 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQZJA-00060z-2E;
        Fri, 10 Feb 2023 19:43:44 +0000
Date:   Sat, 11 Feb 2023 03:43:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/5] pinctrl: at91: use devm_kasprintf() to avoid
 potential leaks (part 2)
Message-ID: <202302110336.1P7vM7AU-lkp@intel.com>
References: <20230210145656.71838-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210145656.71838-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next next-20230210]
[cannot apply to clk/clk-next soc/for-next linus/master v6.2-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-at91-use-devm_kasprintf-to-avoid-potential-leaks-part-2/20230210-225817
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230210145656.71838-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/5] pinctrl: at91: use devm_kasprintf() to avoid potential leaks (part 2)
config: arm-randconfig-r046-20230210 (https://download.01.org/0day-ci/archive/20230211/202302110336.1P7vM7AU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0562771ccfa099db4361c2e5958ca1685f498cdf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/pinctrl-at91-use-devm_kasprintf-to-avoid-potential-leaks-part-2/20230210-225817
        git checkout 0562771ccfa099db4361c2e5958ca1685f498cdf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pinctrl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302110336.1P7vM7AU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-at91.c: In function 'at91_pinctrl_probe':
   drivers/pinctrl/pinctrl-at91.c:1402:22: error: 'names' undeclared (first use in this function)
    1402 |                 if (!names)
         |                      ^~~~~
   drivers/pinctrl/pinctrl-at91.c:1402:22: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pinctrl/pinctrl-at91.c: In function 'at91_gpio_probe':
>> drivers/pinctrl/pinctrl-at91.c:1889:28: warning: passing argument 1 of 'strreplace' makes pointer from integer without a cast [-Wint-conversion]
    1889 |                 strreplace('-', alias_idx + 'A');
         |                            ^~~
         |                            |
         |                            int
   In file included from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/notifier.h:14,
                    from include/linux/clk.h:14,
                    from drivers/pinctrl/pinctrl-at91.c:8:
   include/linux/string.h:172:24: note: expected 'char *' but argument is of type 'int'
     172 | char *strreplace(char *s, char old, char new);
         |                  ~~~~~~^
   drivers/pinctrl/pinctrl-at91.c:1889:17: error: too few arguments to function 'strreplace'
    1889 |                 strreplace('-', alias_idx + 'A');
         |                 ^~~~~~~~~~
   include/linux/string.h:172:7: note: declared here
     172 | char *strreplace(char *s, char old, char new);
         |       ^~~~~~~~~~


vim +/strreplace +1889 drivers/pinctrl/pinctrl-at91.c

  1809	
  1810	static int at91_gpio_probe(struct platform_device *pdev)
  1811	{
  1812		struct device *dev = &pdev->dev;
  1813		struct device_node *np = dev->of_node;
  1814		struct at91_gpio_chip *at91_chip = NULL;
  1815		struct gpio_chip *chip;
  1816		struct pinctrl_gpio_range *range;
  1817		int ret = 0;
  1818		int irq, i;
  1819		int alias_idx = of_alias_get_id(np, "gpio");
  1820		uint32_t ngpio;
  1821		char **names;
  1822	
  1823		BUG_ON(alias_idx >= ARRAY_SIZE(gpio_chips));
  1824		if (gpio_chips[alias_idx]) {
  1825			ret = -EBUSY;
  1826			goto err;
  1827		}
  1828	
  1829		irq = platform_get_irq(pdev, 0);
  1830		if (irq < 0) {
  1831			ret = irq;
  1832			goto err;
  1833		}
  1834	
  1835		at91_chip = devm_kzalloc(&pdev->dev, sizeof(*at91_chip), GFP_KERNEL);
  1836		if (!at91_chip) {
  1837			ret = -ENOMEM;
  1838			goto err;
  1839		}
  1840	
  1841		at91_chip->regbase = devm_platform_ioremap_resource(pdev, 0);
  1842		if (IS_ERR(at91_chip->regbase)) {
  1843			ret = PTR_ERR(at91_chip->regbase);
  1844			goto err;
  1845		}
  1846	
  1847		at91_chip->ops = (const struct at91_pinctrl_mux_ops *)
  1848			of_match_device(at91_gpio_of_match, &pdev->dev)->data;
  1849		at91_chip->pioc_virq = irq;
  1850		at91_chip->pioc_idx = alias_idx;
  1851	
  1852		at91_chip->clock = devm_clk_get(&pdev->dev, NULL);
  1853		if (IS_ERR(at91_chip->clock)) {
  1854			dev_err(&pdev->dev, "failed to get clock, ignoring.\n");
  1855			ret = PTR_ERR(at91_chip->clock);
  1856			goto err;
  1857		}
  1858	
  1859		ret = clk_prepare_enable(at91_chip->clock);
  1860		if (ret) {
  1861			dev_err(&pdev->dev, "failed to prepare and enable clock, ignoring.\n");
  1862			goto clk_enable_err;
  1863		}
  1864	
  1865		at91_chip->chip = at91_gpio_template;
  1866		at91_chip->id = alias_idx;
  1867	
  1868		chip = &at91_chip->chip;
  1869		chip->label = dev_name(&pdev->dev);
  1870		chip->parent = &pdev->dev;
  1871		chip->owner = THIS_MODULE;
  1872		chip->base = alias_idx * MAX_NB_GPIO_PER_BANK;
  1873	
  1874		if (!of_property_read_u32(np, "#gpio-lines", &ngpio)) {
  1875			if (ngpio >= MAX_NB_GPIO_PER_BANK)
  1876				pr_err("at91_gpio.%d, gpio-nb >= %d failback to %d\n",
  1877				       alias_idx, MAX_NB_GPIO_PER_BANK, MAX_NB_GPIO_PER_BANK);
  1878			else
  1879				chip->ngpio = ngpio;
  1880		}
  1881	
  1882		names = devm_kasprintf_strarray(dev, "pio", chip->ngpio);
  1883		if (!names) {
  1884			ret = -ENOMEM;
  1885			goto clk_enable_err;
  1886		}
  1887	
  1888		for (i = 0; i < chip->ngpio; i++)
> 1889			strreplace('-', alias_idx + 'A');
  1890	
  1891		chip->names = (const char *const *)names;
  1892	
  1893		range = &at91_chip->range;
  1894		range->name = chip->label;
  1895		range->id = alias_idx;
  1896		range->pin_base = range->base = range->id * MAX_NB_GPIO_PER_BANK;
  1897	
  1898		range->npins = chip->ngpio;
  1899		range->gc = chip;
  1900	
  1901		ret = at91_gpio_of_irq_setup(pdev, at91_chip);
  1902		if (ret)
  1903			goto gpiochip_add_err;
  1904	
  1905		ret = gpiochip_add_data(chip, at91_chip);
  1906		if (ret)
  1907			goto gpiochip_add_err;
  1908	
  1909		gpio_chips[alias_idx] = at91_chip;
  1910		platform_set_drvdata(pdev, at91_chip);
  1911		gpio_banks = max(gpio_banks, alias_idx + 1);
  1912	
  1913		dev_info(&pdev->dev, "at address %p\n", at91_chip->regbase);
  1914	
  1915		return 0;
  1916	
  1917	gpiochip_add_err:
  1918	clk_enable_err:
  1919		clk_disable_unprepare(at91_chip->clock);
  1920	err:
  1921		dev_err(&pdev->dev, "Failure %i for GPIO %i\n", ret, alias_idx);
  1922	
  1923		return ret;
  1924	}
  1925	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
