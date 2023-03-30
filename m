Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30116D0C15
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjC3RAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjC3RAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:00:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B6C15F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680195583; x=1711731583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WkQTKAWASNuXdhKV56eONodvd+7f/aUfplFxjsgeiOw=;
  b=CZdVX1tkVFTLPexVeN1IKaSqesr8V3zheLRI2MZhnp/AyN3SI0ziFBv6
   g29NF/bGfk/rIZpkn2BWGYDuy1kRGRKuZHdpC6PI6TxzdwQOdMXKhgwCd
   aUvZx7x+oMxggpewqQl40PxcWK9o4q/8aIr5EeLgGRd/tbYrwOJU5Om+H
   +KiZLZdCXklwYrYPfHpRik1aqxTcDnVBbrGNcT33oAzSbNoENg9nSMqqN
   Io6VvMBtyPA8UBU985Og8huM77OgTwTXhLNKdAskeAvVW3dtQreRgtc9H
   q3PtBmlvOb/ykgtmE56Te2FytJjXKuGtY3GGA/U9oAL8e3kY8Rq6uGYjf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="339952098"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="339952098"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 09:59:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="715078952"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="715078952"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2023 09:59:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phvc5-000L1g-2S;
        Thu, 30 Mar 2023 16:59:01 +0000
Date:   Fri, 31 Mar 2023 00:58:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev, hvaibhav.linux@gmail.com,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH 2/2] staging: greybus: refactor arche_platform_wd_irq()
Message-ID: <202303310037.mGo4pYNd-lkp@intel.com>
References: <96d04a4ff3d4a46293355f5afae3a8ece65f2c5b.1680185025.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d04a4ff3d4a46293355f5afae3a8ece65f2c5b.1680185025.git.kamrankhadijadj@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Khadija,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on staging/staging-next staging/staging-linus linus/master v6.3-rc4 next-20230330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Khadija-Kamran/staging-greybus-add-a-single-exit-path-to-arche_platform_wd_irq/20230330-222140
patch link:    https://lore.kernel.org/r/96d04a4ff3d4a46293355f5afae3a8ece65f2c5b.1680185025.git.kamrankhadijadj%40gmail.com
patch subject: [PATCH 2/2] staging: greybus: refactor arche_platform_wd_irq()
config: microblaze-randconfig-r016-20230329 (https://download.01.org/0day-ci/archive/20230331/202303310037.mGo4pYNd-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fd0907bb290e9a4f8b33d8c56ca14a49e3177de9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Khadija-Kamran/staging-greybus-add-a-single-exit-path-to-arche_platform_wd_irq/20230330-222140
        git checkout fd0907bb290e9a4f8b33d8c56ca14a49e3177de9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/staging/greybus/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303310037.mGo4pYNd-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/staging/greybus/arche-platform.c: In function 'arche_platform_wd_irq':
>> drivers/staging/greybus/arche-platform.c:179:17: error: unknown type name 'got'
     179 |                 got out;
         |                 ^~~
>> drivers/staging/greybus/arche-platform.c:179:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
   drivers/staging/greybus/arche-platform.c:179:21: warning: unused variable 'out' [-Wunused-variable]
     179 |                 got out;
         |                     ^~~
   drivers/staging/greybus/arche-platform.c: At top level:
   drivers/staging/greybus/arche-platform.c:626:34: warning: 'arche_combined_id' defined but not used [-Wunused-const-variable=]
     626 | static const struct of_device_id arche_combined_id[] = {
         |                                  ^~~~~~~~~~~~~~~~~


vim +/got +179 drivers/staging/greybus/arche-platform.c

   152	
   153	static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
   154	{
   155		struct arche_platform_drvdata *arche_pdata = devid;
   156		irqreturn_t rc = IRQ_HANDLED;
   157		unsigned long flags;
   158	
   159		spin_lock_irqsave(&arche_pdata->wake_lock, flags);
   160	
   161		if (!gpiod_get_value(arche_pdata->wake_detect))
   162			goto falling;
   163	
   164		/* wake/detect rising */
   165	
   166		/*
   167		 * If wake/detect line goes high after low, within less than
   168		 * 30msec, then standby boot sequence is initiated, which is not
   169		 * supported/implemented as of now. So ignore it.
   170		 */
   171		if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT)
   172			goto out;
   173	
   174		if (time_before(jiffies,
   175				arche_pdata->wake_detect_start +
   176				msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
   177			arche_platform_set_wake_detect_state(arche_pdata,
   178							     WD_STATE_IDLE);
 > 179			got out;
   180		}
   181	
   182		/* Check we are not in middle of irq thread already */
   183		if (arche_pdata->wake_detect_state !=
   184				WD_STATE_COLDBOOT_START) {
   185			arche_platform_set_wake_detect_state(arche_pdata,
   186							     WD_STATE_COLDBOOT_TRIG);
   187			rc = IRQ_WAKE_THREAD;
   188			goto out;
   189		}
   190	
   191	falling:
   192		/* wake/detect falling */
   193		if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {
   194			arche_pdata->wake_detect_start = jiffies;
   195			/*
   196			 * In the beginning, when wake/detect goes low
   197			 * (first time), we assume it is meant for coldboot
   198			 * and set the flag. If wake/detect line stays low
   199			 * beyond 30msec, then it is coldboot else fallback
   200			 * to standby boot.
   201			 */
   202			arche_platform_set_wake_detect_state(arche_pdata,
   203							     WD_STATE_BOOT_INIT);
   204		}
   205	
   206	out:
   207		spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
   208	
   209		return rc;
   210	}
   211	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
