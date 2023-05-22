Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829D870CCBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjEVVo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjEVVoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:44:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FB7A7;
        Mon, 22 May 2023 14:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684791864; x=1716327864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jb6hsR47EajT5Yqj0ILeLdl16rMJne9Ye39lbGAi5ss=;
  b=JFkOX7mK7GJM+Um5l4Y1DkX5XnILp364XJMMOx/O8rWxXEptdblwfr1H
   DWvdOvhUNApoUqLVe8azoa8bup3Ps3QC0rclTNlXJtgSIzVoeMtVVa72R
   pxL3yxig3WjBZpQxu5pVR0TGKPWVUJRMyrRs0lX1lRU7dVTo5urwkOule
   tSnO958PY2tmjtAFaX+HfCnSYXoqsDJii40jmS6fYOAUnOM3k07V/73v4
   XnhP3JmTgU2jAvOnYVWuATRj51sMIHAFUbl5SdIJE4A4+vOn2trsmuxvT
   zZAQ176rATVDDXH5mqKMT1cy+z3VcJvl1fXyxFpGEBLQmXXlyBnDTLjiC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="355400899"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="355400899"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 14:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="950264147"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="950264147"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 May 2023 14:44:21 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1DKG-000DDF-1Z;
        Mon, 22 May 2023 21:44:20 +0000
Date:   Tue, 23 May 2023 05:44:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, kernel@sberdevices.ru,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: Re: [PATCH v1] leds: trigger: pattern: add support for hrtimer
Message-ID: <202305230549.ekneaQ89-lkp@intel.com>
References: <20230522190412.374474-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522190412.374474-1-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-leds/for-leds-next]
[also build test WARNING on wireless-next/main wireless/main linus/master v6.4-rc3 next-20230522]
[cannot apply to pavel-leds/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Kurbanov/leds-trigger-pattern-add-support-for-hrtimer/20230523-030630
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20230522190412.374474-1-mmkurbanov%40sberdevices.ru
patch subject: [PATCH v1] leds: trigger: pattern: add support for hrtimer
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230523/202305230549.ekneaQ89-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/084f274c07fd243e864f73ab80a9eda5e940f024
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Kurbanov/leds-trigger-pattern-add-support-for-hrtimer/20230523-030630
        git checkout 084f274c07fd243e864f73ab80a9eda5e940f024
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305230549.ekneaQ89-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/leds/trigger/ledtrig-pattern.c: In function 'pattern_init':
>> drivers/leds/trigger/ledtrig-pattern.c:454:74: warning: implicit conversion from 'enum <anonymous>' to 'enum pattern_type' [-Wenum-conversion]
     454 |         err = pattern_trig_store_patterns(led_cdev, NULL, pattern, size, false);
         |                                                                          ^~~~~


vim +454 drivers/leds/trigger/ledtrig-pattern.c

5fd752b6b3a223 Baolin Wang         2018-10-11  438  
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  439  static void pattern_init(struct led_classdev *led_cdev)
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  440  {
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  441  	unsigned int size = 0;
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  442  	u32 *pattern;
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  443  	int err;
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  444  
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  445  	pattern = led_get_default_pattern(led_cdev, &size);
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  446  	if (!pattern)
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  447  		return;
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  448  
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  449  	if (size % 2) {
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  450  		dev_warn(led_cdev->dev, "Expected pattern of tuples\n");
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  451  		goto out;
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  452  	}
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  453  
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09 @454  	err = pattern_trig_store_patterns(led_cdev, NULL, pattern, size, false);
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  455  	if (err < 0)
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  456  		dev_warn(led_cdev->dev,
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  457  			 "Pattern initialization failed with error %d\n", err);
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  458  
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  459  out:
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  460  	kfree(pattern);
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  461  }
aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  462  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
