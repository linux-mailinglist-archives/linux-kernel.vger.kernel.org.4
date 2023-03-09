Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8617C6B1E9C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCIIua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCIIuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:50:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627158A39A;
        Thu,  9 Mar 2023 00:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678351820; x=1709887820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hzJZZecRtLBuUUUYuZrjjCAOTv/teU3J5+ZEbs+0u74=;
  b=abuvcZzHFEh3tPX20o+eHtwYZMrYd2XeyTfJfL17K7nHwE42erlZTJKr
   Gz6+NIUf7vpzuLAH4n1Nbwy5vwxFpiGto44HUSwdaTrNOipsHDrZkR8d9
   VhWXO8NIoUyCnpAoEUxqtKcMHSd5Nm7mdKyY8dW8Wm51zVcvlmUaFodFT
   PkdH/SDs04Ps99WDnqNcMvPayVpULPC8WMk9A4aQDvRy9WMPTW7kRXSRw
   p6cKi7hLcNikDc23NMeRbZE4Oxp4Rol5M6rnbty+4lEZwPDYsWYIwuD3x
   C5GJvLM1Nxs04JH4ojtfAO9mLUYySIvtK8VTSPO9YIX5zcM/uQeAm6wm8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="320220093"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="320220093"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:50:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="627283830"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="627283830"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2023 00:50:17 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paBya-0002om-2Y;
        Thu, 09 Mar 2023 08:50:16 +0000
Date:   Thu, 9 Mar 2023 16:49:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Davis <afd@ti.com>, Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 3/6] gpio: sch311x: Use devm_gpiochip_add_data() to
 simplify remove path
Message-ID: <202303091640.6XjHNouG-lkp@intel.com>
References: <20230307193346.8718-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307193346.8718-3-afd@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linus/master v6.3-rc1 next-20230309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/gpio-twl4030-Use-devm_gpiochip_add_data-to-simplify-remove-path/20230308-034717
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230307193346.8718-3-afd%40ti.com
patch subject: [PATCH v2 3/6] gpio: sch311x: Use devm_gpiochip_add_data() to simplify remove path
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20230309/202303091640.6XjHNouG-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fcfc10c6817ac3ea88ced58cce2ae8568b0f2030
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrew-Davis/gpio-twl4030-Use-devm_gpiochip_add_data-to-simplify-remove-path/20230308-034717
        git checkout fcfc10c6817ac3ea88ced58cce2ae8568b0f2030
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303091640.6XjHNouG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpio/gpio-sch311x.c:322:13: error: use of undeclared identifier 'sch311x_gpio_remove'
           .remove         = sch311x_gpio_remove,
                             ^
   1 error generated.


vim +/sch311x_gpio_remove +322 drivers/gpio/gpio-sch311x.c

12262bef8f4614 Bruno Randolf 2013-12-04  318  
12262bef8f4614 Bruno Randolf 2013-12-04  319  static struct platform_driver sch311x_gpio_driver = {
12262bef8f4614 Bruno Randolf 2013-12-04  320  	.driver.name	= DRV_NAME,
12262bef8f4614 Bruno Randolf 2013-12-04  321  	.probe		= sch311x_gpio_probe,
12262bef8f4614 Bruno Randolf 2013-12-04 @322  	.remove		= sch311x_gpio_remove,
12262bef8f4614 Bruno Randolf 2013-12-04  323  };
12262bef8f4614 Bruno Randolf 2013-12-04  324  
12262bef8f4614 Bruno Randolf 2013-12-04  325  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
