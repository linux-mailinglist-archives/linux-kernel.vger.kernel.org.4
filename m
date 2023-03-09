Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57986B21EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCIKyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCIKy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:54:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A420467801;
        Thu,  9 Mar 2023 02:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678359264; x=1709895264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=alC5GEn1xgVLK41r3n5/kXue0z23To81HFJv5g+mKmk=;
  b=ADizU7dukpiiXnyMPXlX9MiOxVpjMP8SIETbMrihW7L2mdgqQUZx2Byd
   KxQNyZmlKuw4BlXRmnkuDlGrWsb2yZYB14cNXTd7uXA68LVWw4CMt/isZ
   /DHdL7rzsHEjQoK0fZIoj7zqOFiBoJGzxfEHKwA6P0t3c6IUr2HE1jGdP
   X8KOEbIy9rnyVYGQBHP6ftzmceTh1UmFODv/GSIscdlbZ8Ausk9NAMtcW
   qdI8HJfTSxZUMBElzNLNuj8k4Zj2nJq3QMVuC0I/GQrZqce57oOGz+w5X
   mIpq3cKfjaqLeKsM/lJ3dwcwhVRRHcWOno6GJEdUrzvvaygo3mguoC+E6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="336428304"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="336428304"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 02:54:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="679709610"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="679709610"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2023 02:54:22 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paDuf-0002tf-29;
        Thu, 09 Mar 2023 10:54:21 +0000
Date:   Thu, 9 Mar 2023 18:53:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jani Nikula <jani.nikula@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: constify struct hwmon_chip_info info member harder
Message-ID: <202303091814.jyOAXX4n-lkp@intel.com>
References: <20230309082841.400118-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309082841.400118-1-jani.nikula@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

I love your patch! Yet something to improve:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.3-rc1 next-20230309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jani-Nikula/hwmon-constify-struct-hwmon_chip_info-info-member-harder/20230309-163328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230309082841.400118-1-jani.nikula%40intel.com
patch subject: [PATCH] hwmon: constify struct hwmon_chip_info info member harder
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20230309/202303091814.jyOAXX4n-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1ec9eaf0281f0a40044492700b7cdfe99d35d35e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jani-Nikula/hwmon-constify-struct-hwmon_chip_info-info-member-harder/20230309-163328
        git checkout 1ec9eaf0281f0a40044492700b7cdfe99d35d35e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303091814.jyOAXX4n-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/hwmon.c:177:36: error: initializing 'const struct hwmon_channel_info **' with an expression of type 'const struct hwmon_channel_info *const *const' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           const struct hwmon_channel_info **info = chip->info;
                                             ^      ~~~~~~~~~~
   drivers/hwmon/hwmon.c:256:36: error: initializing 'const struct hwmon_channel_info **' with an expression of type 'const struct hwmon_channel_info *const *const' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           const struct hwmon_channel_info **info = chip->info;
                                             ^      ~~~~~~~~~~
   2 errors generated.


vim +177 drivers/hwmon/hwmon.c

d560168b5d0fb4 Guenter Roeck   2015-08-26  171  
e5181331359d93 Daniel Lezcano  2022-08-05  172  static int hwmon_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  173  {
e5181331359d93 Daniel Lezcano  2022-08-05  174  	struct hwmon_thermal_data *tdata = tz->devdata;
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  175  	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  176  	const struct hwmon_chip_info *chip = hwdev->chip;
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23 @177  	const struct hwmon_channel_info **info = chip->info;
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  178  	unsigned int i;
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  179  	int err;
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  180  
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  181  	if (!chip->ops->write)
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  182  		return 0;
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  183  
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  184  	for (i = 0; info[i] && info[i]->type != hwmon_temp; i++)
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  185  		continue;
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  186  
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  187  	if (!info[i])
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  188  		return 0;
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  189  
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  190  	if (info[i]->config[tdata->index] & HWMON_T_MIN) {
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  191  		err = chip->ops->write(tdata->dev, hwmon_temp,
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  192  				       hwmon_temp_min, tdata->index, low);
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  193  		if (err && err != -EOPNOTSUPP)
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  194  			return err;
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  195  	}
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  196  
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  197  	if (info[i]->config[tdata->index] & HWMON_T_MAX) {
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  198  		err = chip->ops->write(tdata->dev, hwmon_temp,
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  199  				       hwmon_temp_max, tdata->index, high);
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  200  		if (err && err != -EOPNOTSUPP)
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  201  			return err;
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  202  	}
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  203  
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  204  	return 0;
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  205  }
a5f6c0f85a09f4 Dmitry Osipenko 2021-06-23  206  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
