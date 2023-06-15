Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA2731D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241921AbjFOQAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjFOQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:00:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A143E4;
        Thu, 15 Jun 2023 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686844813; x=1718380813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z7lzWNBEGZ8+AKiNaUvSxKimaOLEam6bjdhYJzQtifI=;
  b=ecnqhG5Zp0T+RMCjtOOtyaoHScQ/XtBMNLNcMjHQ/ZmscU7GdDZ6bcgW
   0wnTRjK7Kg6kxxjTsEVgYnhWXGvxYxBWzwxlt7ZiwBIuQDiNEjUNY39w8
   B9zz8YyWJeus8wnH9fYrOLVeLucNPHLuDMOCkqQZTsBnVr4EywpTJpzxA
   gbMComK51EPISMMa9Orj7dyw3T3Qea0LTDww5eSlTbiIYIkilMxJ0hgpV
   JqOuRJcVxIvq1LqKqJXHfj86dP8EK/mZIRiY+1/kj9ZO1En8nukDPavkb
   TBA9pfCRbYnAspvQcMkX8AozZ2DXhF9OV8ghX3ciTidusTICscL9grs2T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343686185"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343686185"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:59:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="886727520"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="886727520"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2023 08:59:37 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9pNo-00007a-31;
        Thu, 15 Jun 2023 15:59:36 +0000
Date:   Thu, 15 Jun 2023 23:59:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>, peter.chen@kernel.org,
        pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdns3: Put the cdns set active part outside the
 spin lock
Message-ID: <202306152319.B8AcWTgh-lkp@intel.com>
References: <20230615110424.4007675-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615110424.4007675-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaolei,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.4-rc6 next-20230615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaolei-Wang/usb-cdns3-Put-the-cdns-set-active-part-outside-the-spin-lock/20230615-190721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230615110424.4007675-1-xiaolei.wang%40windriver.com
patch subject: [PATCH v2] usb: cdns3: Put the cdns set active part outside the spin lock
config: arm64-randconfig-r003-20230615 (https://download.01.org/0day-ci/archive/20230615/202306152319.B8AcWTgh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add usb https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
        git fetch usb usb-testing
        git checkout usb/usb-testing
        b4 shazam https://lore.kernel.org/r/20230615110424.4007675-1-xiaolei.wang@windriver.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/usb/cdns3/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306152319.B8AcWTgh-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/cdns3/cdns3-plat.c: In function 'cdns3_controller_resume':
>> drivers/usb/cdns3/cdns3-plat.c:258:9: error: too few arguments to function 'cdns_resume'
     258 |         cdns_resume(cdns);
         |         ^~~~~~~~~~~
   In file included from drivers/usb/cdns3/cdns3-plat.c:21:
   drivers/usb/cdns3/core.h:132:19: note: declared here
     132 | static inline int cdns_resume(struct cdns *cdns, u8 set_active)
         |                   ^~~~~~~~~~~
>> drivers/usb/cdns3/cdns3-plat.c:261:9: error: implicit declaration of function 'cdns_set_active'; did you mean 'cxl_mem_active'? [-Werror=implicit-function-declaration]
     261 |         cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
         |         ^~~~~~~~~~~~~~~
         |         cxl_mem_active
   cc1: some warnings being treated as errors


vim +/cdns_resume +258 drivers/usb/cdns3/cdns3-plat.c

   229	
   230	static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
   231	{
   232		struct cdns *cdns = dev_get_drvdata(dev);
   233		int ret;
   234		unsigned long flags;
   235	
   236		if (!cdns->in_lpm)
   237			return 0;
   238	
   239		if (cdns_power_is_lost(cdns)) {
   240			phy_exit(cdns->usb2_phy);
   241			ret = phy_init(cdns->usb2_phy);
   242			if (ret)
   243				return ret;
   244	
   245			phy_exit(cdns->usb3_phy);
   246			ret = phy_init(cdns->usb3_phy);
   247			if (ret)
   248				return ret;
   249		}
   250	
   251		ret = set_phy_power_on(cdns);
   252		if (ret)
   253			return ret;
   254	
   255		cdns3_set_platform_suspend(cdns->dev, false, false);
   256	
   257		spin_lock_irqsave(&cdns->lock, flags);
 > 258		cdns_resume(cdns);
   259		cdns->in_lpm = false;
   260		spin_unlock_irqrestore(&cdns->lock, flags);
 > 261		cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
   262		if (cdns->wakeup_pending) {
   263			cdns->wakeup_pending = false;
   264			enable_irq(cdns->wakeup_irq);
   265		}
   266		dev_dbg(cdns->dev, "%s ends\n", __func__);
   267	
   268		return ret;
   269	}
   270	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
