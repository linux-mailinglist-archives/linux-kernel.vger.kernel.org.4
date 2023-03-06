Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9578B6ACE47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCFTkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjCFTkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:40:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF8642BF8;
        Mon,  6 Mar 2023 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678131634; x=1709667634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FWoyhIIxfE7mlB+PZ9iwUX0MhoU78leSOGm1xQPZDzA=;
  b=dU1m6rVIkNigpVb39LN26aja0lxMMw1ofNQFF1TBnWf7EDvM7nsmxjHu
   j+wEtjCREHbj3b3csR1crZANoyABigYaml41kMGugVO4N3ikDu8wpIt8J
   3FE36JnPLS7FXzrqCl4VHdMn9+0FpxpGunjtXxagO4vhe+lGjmXedvsjD
   t4YMRWagHd7FipIVtGTYZAw6dfeMwkQ9PcHzrw2NV52R9MkD+fF9KnNBi
   CwaWbEMZkLukRRjMR+jvyTgAhEpontRQcC5HHk97XKNHtBCayWScDdyKy
   EMqFGh43uU3smrWHdoWgxUzVqBeqps7S3Pb4HV/M7vn9qmq9RQ7D4nfBU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363276636"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="363276636"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="676287271"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="676287271"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Mar 2023 11:40:31 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZGhC-0000Zz-2q;
        Mon, 06 Mar 2023 19:40:30 +0000
Date:   Tue, 7 Mar 2023 03:39:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     oe-kbuild-all@lists.linux.dev, patches@opensource.cirrus.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/3] watchdog: wm8350: Simplify using
 devm_watchdog_register_device()
Message-ID: <202303070325.74bkgnG6-lkp@intel.com>
References: <20230306170901.2232323-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306170901.2232323-4-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

I love your patch! Yet something to improve:

[auto build test ERROR on fe15c26ee26efa11741a7b632e9f23b01aca4cc6]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/watchdog-bcm47xx-Simplify-using-devm_watchdog_register_device/20230307-011628
base:   fe15c26ee26efa11741a7b632e9f23b01aca4cc6
patch link:    https://lore.kernel.org/r/20230306170901.2232323-4-u.kleine-koenig%40pengutronix.de
patch subject: [PATCH 3/3] watchdog: wm8350: Simplify using devm_watchdog_register_device()
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230307/202303070325.74bkgnG6-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/94594fa75b3515d5dbff3ec2d1db1cf5627900b1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Uwe-Kleine-K-nig/watchdog-bcm47xx-Simplify-using-devm_watchdog_register_device/20230307-011628
        git checkout 94594fa75b3515d5dbff3ec2d1db1cf5627900b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303070325.74bkgnG6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/watchdog/wm8350_wdt.c: In function 'wm8350_wdt_probe':
>> drivers/watchdog/wm8350_wdt.c:156:46: error: passing argument 1 of 'devm_watchdog_register_device' from incompatible pointer type [-Werror=incompatible-pointer-types]
     156 |         return devm_watchdog_register_device(&wm8350_wdt);
         |                                              ^~~~~~~~~~~
         |                                              |
         |                                              struct watchdog_device *
   In file included from drivers/watchdog/wm8350_wdt.c:15:
   include/linux/watchdog.h:226:50: note: expected 'struct device *' but argument is of type 'struct watchdog_device *'
     226 | int devm_watchdog_register_device(struct device *dev, struct watchdog_device *);
         |                                   ~~~~~~~~~~~~~~~^~~
>> drivers/watchdog/wm8350_wdt.c:156:16: error: too few arguments to function 'devm_watchdog_register_device'
     156 |         return devm_watchdog_register_device(&wm8350_wdt);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/watchdog.h:226:5: note: declared here
     226 | int devm_watchdog_register_device(struct device *dev, struct watchdog_device *);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/watchdog/wm8350_wdt.c:157:1: error: control reaches end of non-void function [-Werror=return-type]
     157 | }
         | ^
   cc1: some warnings being treated as errors


vim +/devm_watchdog_register_device +156 drivers/watchdog/wm8350_wdt.c

   139	
   140	static int wm8350_wdt_probe(struct platform_device *pdev)
   141	{
   142		struct wm8350 *wm8350 = platform_get_drvdata(pdev);
   143	
   144		if (!wm8350) {
   145			pr_err("No driver data supplied\n");
   146			return -ENODEV;
   147		}
   148	
   149		watchdog_set_nowayout(&wm8350_wdt, nowayout);
   150		watchdog_set_drvdata(&wm8350_wdt, wm8350);
   151		wm8350_wdt.parent = &pdev->dev;
   152	
   153		/* Default to 4s timeout */
   154		wm8350_wdt_set_timeout(&wm8350_wdt, 4);
   155	
 > 156		return devm_watchdog_register_device(&wm8350_wdt);
   157	}
   158	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
