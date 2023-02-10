Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40B46928C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjBJUzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjBJUyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:54:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03C73AB0;
        Fri, 10 Feb 2023 12:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676062490; x=1707598490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b9t/ZkU9iTbcc8XjIPFTXdV+MGIykH0mfx78CLcHzHE=;
  b=j77YsrNdKVVmrzQlXm+mottnTvALo0jNPfXlRKiVm3u/tByb3PPfYblG
   AXLdHDkpJcV35wbZj1epFq5TfPVBDa4fQ/WWa1ta4z0mh/DFswBePQddt
   byK86ysdP65dmQRNpBQfVHiXnhxsOAyVBLpaiKevE4HQuoYU/NJsEZDpr
   5Tnlhe4IqjOTJCklvde12fjJyTXHQ1Y+pA8cYVOyIpUA/VpeJ5uy//BbR
   haNXIT5RfPWqygiwvCT5+Ebq2DQEksMoHdFIwGExDaam9qcXWQDBQIrkF
   yl0UrbMJjvyz3Fk1JC9eYPPMHWJ5U5YCQ++4d7BrnrF2pE8IrT71KU/d+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="416745729"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="416745729"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 12:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="668169360"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="668169360"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2023 12:54:47 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQaPu-00063J-0y;
        Fri, 10 Feb 2023 20:54:46 +0000
Date:   Sat, 11 Feb 2023 04:54:38 +0800
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
Message-ID: <202302110407.TpDeAlpQ-lkp@intel.com>
References: <20230210145656.71838-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210145656.71838-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next next-20230210]
[cannot apply to clk/clk-next soc/for-next linus/master v6.2-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-at91-use-devm_kasprintf-to-avoid-potential-leaks-part-2/20230210-225817
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230210145656.71838-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/5] pinctrl: at91: use devm_kasprintf() to avoid potential leaks (part 2)
config: arm-randconfig-r046-20230210 (https://download.01.org/0day-ci/archive/20230211/202302110407.TpDeAlpQ-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302110407.TpDeAlpQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-at91.c: In function 'at91_pinctrl_probe':
>> drivers/pinctrl/pinctrl-at91.c:1402:22: error: 'names' undeclared (first use in this function)
    1402 |                 if (!names)
         |                      ^~~~~
   drivers/pinctrl/pinctrl-at91.c:1402:22: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pinctrl/pinctrl-at91.c: In function 'at91_gpio_probe':
   drivers/pinctrl/pinctrl-at91.c:1889:28: warning: passing argument 1 of 'strreplace' makes pointer from integer without a cast [-Wint-conversion]
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
>> drivers/pinctrl/pinctrl-at91.c:1889:17: error: too few arguments to function 'strreplace'
    1889 |                 strreplace('-', alias_idx + 'A');
         |                 ^~~~~~~~~~
   include/linux/string.h:172:7: note: declared here
     172 | char *strreplace(char *s, char old, char new);
         |       ^~~~~~~~~~


vim +/names +1402 drivers/pinctrl/pinctrl-at91.c

  1372	
  1373	static int at91_pinctrl_probe(struct platform_device *pdev)
  1374	{
  1375		struct device *dev = &pdev->dev;
  1376		struct at91_pinctrl *info;
  1377		struct pinctrl_pin_desc *pdesc;
  1378		int ret, i, j, k;
  1379	
  1380		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
  1381		if (!info)
  1382			return -ENOMEM;
  1383	
  1384		ret = at91_pinctrl_probe_dt(pdev, info);
  1385		if (ret)
  1386			return ret;
  1387	
  1388		at91_pinctrl_desc.name = dev_name(&pdev->dev);
  1389		at91_pinctrl_desc.npins = gpio_banks * MAX_NB_GPIO_PER_BANK;
  1390		at91_pinctrl_desc.pins = pdesc =
  1391			devm_kcalloc(&pdev->dev,
  1392				     at91_pinctrl_desc.npins, sizeof(*pdesc),
  1393				     GFP_KERNEL);
  1394	
  1395		if (!at91_pinctrl_desc.pins)
  1396			return -ENOMEM;
  1397	
  1398		for (i = 0, k = 0; i < gpio_banks; i++) {
  1399			char **pin_names;
  1400	
  1401			pin_names = devm_kasprintf_strarray(dev, "pio", MAX_NB_GPIO_PER_BANK);
> 1402			if (!names)
  1403				return -ENOMEM;
  1404	
  1405			for (j = 0; j < MAX_NB_GPIO_PER_BANK; j++, k++) {
  1406				char *pin_name = pin_names[j];
  1407	
  1408				strreplace(pin_name, '-', i + 'A');
  1409	
  1410				pdesc->number = k;
  1411				pdesc->name = pin_name;
  1412				pdesc++;
  1413			}
  1414		}
  1415	
  1416		platform_set_drvdata(pdev, info);
  1417		info->pctl = devm_pinctrl_register(&pdev->dev, &at91_pinctrl_desc,
  1418						   info);
  1419	
  1420		if (IS_ERR(info->pctl)) {
  1421			dev_err(&pdev->dev, "could not register AT91 pinctrl driver\n");
  1422			return PTR_ERR(info->pctl);
  1423		}
  1424	
  1425		/* We will handle a range of GPIO pins */
  1426		for (i = 0; i < gpio_banks; i++)
  1427			if (gpio_chips[i])
  1428				pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
  1429	
  1430		dev_info(&pdev->dev, "initialized AT91 pinctrl driver\n");
  1431	
  1432		return 0;
  1433	}
  1434	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
