Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063DA6BF97B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 11:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCRKZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 06:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 06:25:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230EE17CFF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679135145; x=1710671145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k/a9KYhXQNuIxFL6TrcT9LhlRJ4YY/wA8BeatkOgj/I=;
  b=UPrQsFCmlfJWHXTDwKnxWhSA2DsSgsysUCTimCYkZ8ZnW90cUAVvZelr
   UXojWRuABLX9sjHPaKOwXApHjaXZ3QeEsLhW91j9bnLdNCauRvWzV2RrV
   dgYKtNmfm7BDjbdHreyVCSMScZXOeL56LkpWmMKJYLgIz8cvlf52O1vQS
   F7w0CH4NStvDmC3y8thmUJO4r5JdWfhUKWz8kXeu2CWkTOHT+PkGEF7xx
   wCcy9woBeY1scKb8GydwTj3d6tUFWC4koG1likKSA5L1xSe3tuDuBwIcz
   31eFnojF/Vcgz6MCD4V4r7tsgAo1Fpk3dUgUUPORpSUwEN5gOZC6IMfGE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="403295465"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="403295465"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 03:25:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="926440545"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="926440545"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Mar 2023 03:25:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdTkr-000A0I-0x;
        Sat, 18 Mar 2023 10:25:41 +0000
Date:   Sat, 18 Mar 2023 18:24:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zheng Wang <zyytlz.wz@163.com>, arnd@arndb.de
Cc:     oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: Re: [PATCH RESEND] misc: ti-st: st_kim: Fix use after free bug in
 kim_remove due to race condition
Message-ID: <202303181850.RI6iAAhO-lkp@intel.com>
References: <20230318081743.797531-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318081743.797531-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus soc/for-next v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zheng-Wang/misc-ti-st-st_kim-Fix-use-after-free-bug-in-kim_remove-due-to-race-condition/20230318-161853
patch link:    https://lore.kernel.org/r/20230318081743.797531-1-zyytlz.wz%40163.com
patch subject: [PATCH RESEND] misc: ti-st: st_kim: Fix use after free bug in kim_remove due to race condition
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230318/202303181850.RI6iAAhO-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ecbe190b970112b4b10e2a1766da933168ae5fdd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zheng-Wang/misc-ti-st-st_kim-Fix-use-after-free-bug-in-kim_remove-due-to-race-condition/20230318-161853
        git checkout ecbe190b970112b4b10e2a1766da933168ae5fdd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303181850.RI6iAAhO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/misc/ti-st/st_kim.c: In function 'kim_remove':
>> drivers/misc/ti-st/st_kim.c:788:27: warning: 'kim_gdata' is used uninitialized [-Wuninitialized]
     788 |         struct st_data_s *st_gdata = kim_gdata->core_data;
         |                           ^~~~~~~~
   drivers/misc/ti-st/st_kim.c:787:34: note: 'kim_gdata' was declared here
     787 |         struct kim_data_s       *kim_gdata;
         |                                  ^~~~~~~~~


vim +/kim_gdata +788 drivers/misc/ti-st/st_kim.c

   782	
   783	static int kim_remove(struct platform_device *pdev)
   784	{
   785		/* free the GPIOs requested */
   786		struct ti_st_plat_data	*pdata = pdev->dev.platform_data;
   787		struct kim_data_s	*kim_gdata;
 > 788		struct st_data_s *st_gdata = kim_gdata->core_data;
   789	
   790		kim_gdata = platform_get_drvdata(pdev);
   791	
   792		cancel_work_sync(&st_gdata->work_write_wakeup);
   793	
   794		/*
   795		 * Free the Bluetooth/FM/GPIO
   796		 * nShutdown gpio from the system
   797		 */
   798		gpio_free(pdata->nshutdown_gpio);
   799		pr_info("nshutdown GPIO Freed");
   800	
   801		debugfs_remove_recursive(kim_debugfs_dir);
   802		sysfs_remove_group(&pdev->dev.kobj, &uim_attr_grp);
   803		pr_info("sysfs entries removed");
   804	
   805		kim_gdata->kim_pdev = NULL;
   806		st_core_exit(st_gdata);
   807	
   808		kfree(kim_gdata);
   809		kim_gdata = NULL;
   810		return 0;
   811	}
   812	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
