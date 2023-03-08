Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934E46B01BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCHIlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCHIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:41:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85156570BE;
        Wed,  8 Mar 2023 00:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678264842; x=1709800842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uI574dYMWHoRIV9dkSEKRQgGOP12iLKca4LFvFOKB2Y=;
  b=PP3ay2fc7j9WRhJb6PosoGE+Fgp7STtyDF+aCf4kpmzumczxYWO1bWdN
   UoWlxJRviRJgZb7Syf5mGgjasIA7sGL5m8BUKQQz9iGC7eclxCyWCFewr
   yEi4LtF9Rr9tz4G71Zy+FFrAjVgyTZ/9alqL6molDwArMb39WT1hVewkX
   +0nbHzmejS8/NOphIRxa/ERREdjKaPZJwbOWqy3ni9QMi/V86kU/5oqd9
   230KqeupuPKslwUvE3fyyPyiFsTTj97zlJ2iVr6h1k7lpzx42CQvDjvOl
   wAg9OS1E9vKZK6K48UuSnGfizgihxut6LjrXFx0THb0eVVticN/TjV+RS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422369805"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="422369805"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 00:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="1006249533"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="1006249533"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2023 00:40:40 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZpLj-0001zS-2O;
        Wed, 08 Mar 2023 08:40:39 +0000
Date:   Wed, 8 Mar 2023 16:39:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Davis <afd@ti.com>, Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 3/6] gpio: sch311x: Use devm_gpiochip_add_data() to
 simplify remove path
Message-ID: <202303081607.a3gt8vdz-lkp@intel.com>
References: <20230307193346.8718-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307193346.8718-3-afd@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linus/master v6.3-rc1 next-20230308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/gpio-twl4030-Use-devm_gpiochip_add_data-to-simplify-remove-path/20230308-034717
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230307193346.8718-3-afd%40ti.com
patch subject: [PATCH v2 3/6] gpio: sch311x: Use devm_gpiochip_add_data() to simplify remove path
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230308/202303081607.a3gt8vdz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/fcfc10c6817ac3ea88ced58cce2ae8568b0f2030
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrew-Davis/gpio-twl4030-Use-devm_gpiochip_add_data-to-simplify-remove-path/20230308-034717
        git checkout fcfc10c6817ac3ea88ced58cce2ae8568b0f2030
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303081607.a3gt8vdz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpio/gpio-sch311x.c:322:27: error: 'sch311x_gpio_remove' undeclared here (not in a function); did you mean 'sch311x_gpio_probe'?
     322 |         .remove         = sch311x_gpio_remove,
         |                           ^~~~~~~~~~~~~~~~~~~
         |                           sch311x_gpio_probe


vim +322 drivers/gpio/gpio-sch311x.c

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
