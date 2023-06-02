Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4904A71F9E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjFBGKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjFBGKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:10:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108AA19A;
        Thu,  1 Jun 2023 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685686224; x=1717222224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8MCDzOZf6ynqWV2m8S12QsjH7rgGxvUKD86pDe2odnI=;
  b=MB/FILjtdC+LvLDhouUHiaZV3nu8PBGISjVTQQ3n4JiOsOVxWabT4Ni8
   KZ6fiRAroLF+Rh/Z4edx6gffdL8HLmBy4KshDeVVeKkeCpxNcPb4dPtPp
   qkWmOaWvcJ0dCRKU02USCi75ZhfKawqaph9YQ1tMyyjRH2u2l20y+4M1a
   98t4Xwa4H4jFnK3SSDfQ1wqJSpwqihX8m+47Kncalo6Lxvl+sTKdunTKN
   Hz1Cw9NIpezoNzyFgdxJ4K6i6iqXsrSzUcT0PXHtwZJcITDvCC24kcjV1
   K13WH6F3EHC5gKGtbtrPC282xaiQxdePDiroZQbOC4itiUSFdq7RX/3Cb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="355799797"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="355799797"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 23:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="772748985"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="772748985"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jun 2023 23:10:14 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4xzJ-00009Z-2I;
        Fri, 02 Jun 2023 06:10:13 +0000
Date:   Fri, 2 Jun 2023 14:09:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Rafael Wysocki <rafael@kernel.org>, hdegoede@redhat.com,
        linus.walleij@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 1/4] include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume
Message-ID: <202306021344.JymS3JYg-lkp@intel.com>
References: <20230601232923.1248-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601232923.1248-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7736c431466abb54a2679dc257f739fddfa84295]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-x86-Add-pm_debug_messages-for-LPS0-_DSM-state-tracking/20230602-073044
base:   7736c431466abb54a2679dc257f739fddfa84295
patch link:    https://lore.kernel.org/r/20230601232923.1248-1-mario.limonciello%40amd.com
patch subject: [PATCH v3 1/4] include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume
config: powerpc-randconfig-r035-20230531 (https://download.01.org/0day-ci/archive/20230602/202306021344.JymS3JYg-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5828d770a5f17c4028520050068fd3cdd13b80a1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/ACPI-x86-Add-pm_debug_messages-for-LPS0-_DSM-state-tracking/20230602-073044
        git checkout 5828d770a5f17c4028520050068fd3cdd13b80a1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/base/power/ kernel/power/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306021344.JymS3JYg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/base/power/wakeup.c: In function 'pm_print_active_wakeup_sources':
>> drivers/base/power/wakeup.c:861:12: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
     861 |         if (!active && last_activity_ws)
         |            ^
--
   kernel/power/hibernate.c: In function 'disk_store':
>> kernel/power/hibernate.c:1158:12: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
    1158 |         if (!error)
         |            ^


vim +/else +861 drivers/base/power/wakeup.c

074037ec79bea7 Rafael J. Wysocki  2010-09-22  841  
bb177fedd348c9 Julius Werner      2013-06-12  842  void pm_print_active_wakeup_sources(void)
a938da0682c248 Todd Poynor        2012-08-12  843  {
a938da0682c248 Todd Poynor        2012-08-12  844  	struct wakeup_source *ws;
ea0212f40c6bc0 Thomas Gleixner    2017-06-25  845  	int srcuidx, active = 0;
a938da0682c248 Todd Poynor        2012-08-12  846  	struct wakeup_source *last_activity_ws = NULL;
a938da0682c248 Todd Poynor        2012-08-12  847  
ea0212f40c6bc0 Thomas Gleixner    2017-06-25  848  	srcuidx = srcu_read_lock(&wakeup_srcu);
2591e7b17c0d3f Madhuparna Bhowmik 2020-03-04  849  	list_for_each_entry_rcu_locked(ws, &wakeup_sources, entry) {
a938da0682c248 Todd Poynor        2012-08-12  850  		if (ws->active) {
74a1dd86d1739e Stephen Boyd       2019-03-25  851  			pm_pr_dbg("active wakeup source: %s\n", ws->name);
a938da0682c248 Todd Poynor        2012-08-12  852  			active = 1;
a938da0682c248 Todd Poynor        2012-08-12  853  		} else if (!active &&
a938da0682c248 Todd Poynor        2012-08-12  854  			   (!last_activity_ws ||
a938da0682c248 Todd Poynor        2012-08-12  855  			    ktime_to_ns(ws->last_time) >
a938da0682c248 Todd Poynor        2012-08-12  856  			    ktime_to_ns(last_activity_ws->last_time))) {
a938da0682c248 Todd Poynor        2012-08-12  857  			last_activity_ws = ws;
a938da0682c248 Todd Poynor        2012-08-12  858  		}
a938da0682c248 Todd Poynor        2012-08-12  859  	}
a938da0682c248 Todd Poynor        2012-08-12  860  
a938da0682c248 Todd Poynor        2012-08-12 @861  	if (!active && last_activity_ws)
74a1dd86d1739e Stephen Boyd       2019-03-25  862  		pm_pr_dbg("last active wakeup source: %s\n",
a938da0682c248 Todd Poynor        2012-08-12  863  			last_activity_ws->name);
ea0212f40c6bc0 Thomas Gleixner    2017-06-25  864  	srcu_read_unlock(&wakeup_srcu, srcuidx);
a938da0682c248 Todd Poynor        2012-08-12  865  }
bb177fedd348c9 Julius Werner      2013-06-12  866  EXPORT_SYMBOL_GPL(pm_print_active_wakeup_sources);
a938da0682c248 Todd Poynor        2012-08-12  867  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
