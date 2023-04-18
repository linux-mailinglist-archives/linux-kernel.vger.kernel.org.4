Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C02C6E6B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjDRSBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjDRSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:01:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D143A91;
        Tue, 18 Apr 2023 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681840867; x=1713376867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BVE3bggXhz5HchsWGyKoRHydarVcina0WcntcKfl6U4=;
  b=QUMZQoAmvUR5H3ha4ahDr3cvZh9ZMVQcu85QwiC5Rmg5tg9Mka5fECI1
   IsT6t/uV0J6CbjiqNNtUpDDTZ8EtSQIOJquqj7GuNWs9uGxkcJoDH2Z2+
   emR0o5to+8qV/5+76kMpWHDLf6UZNfkDEUwy/xYN6I+P9UC4KY40WuSKP
   bIkD4T2LagFzg6vk+DC7hC6GdXAogb9cTw0yjPZK6aW6MlN99g83xXiHp
   5GcHXDvlPGRLvAGbusvoQTt6rJZz4FFpzYnMbsmqB7gh56/r8uljIdX4/
   j3Dm+mUNiW7tXh6U9+jGC+Rmofr6Xc53gTJT5BfOO+BLc8m3nJ9ke9H+E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="343995532"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="343995532"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 11:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="802616649"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="802616649"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Apr 2023 11:01:00 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1popdT-000dqR-38;
        Tue, 18 Apr 2023 18:00:59 +0000
Date:   Wed, 19 Apr 2023 02:00:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 2/9] hwmon: (gxp_fan_ctrl) Give GPIO access to fan data
Message-ID: <202304190119.scX6TsQH-lkp@intel.com>
References: <20230418152824.110823-3-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418152824.110823-3-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next linus/master v6.3-rc7]
[cannot apply to brgl/gpio/for-next next-20230417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/nick-hawkins-hpe-com/gpio-gxp-Add-HPE-GXP-GPIO/20230418-233513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230418152824.110823-3-nick.hawkins%40hpe.com
patch subject: [PATCH v1 2/9] hwmon: (gxp_fan_ctrl) Give GPIO access to fan data
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230419/202304190119.scX6TsQH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/be3722d7f32fea1ea375090d05cbfdd3dd4e04d3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review nick-hawkins-hpe-com/gpio-gxp-Add-HPE-GXP-GPIO/20230418-233513
        git checkout be3722d7f32fea1ea375090d05cbfdd3dd4e04d3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304190119.scX6TsQH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/gxp-fan-ctrl.c:32:4: warning: no previous prototype for 'get_fans_installed' [-Wmissing-prototypes]
      32 | u8 get_fans_installed(void)
         |    ^~~~~~~~~~~~~~~~~~
>> drivers/hwmon/gxp-fan-ctrl.c:52:4: warning: no previous prototype for 'get_fans_failed' [-Wmissing-prototypes]
      52 | u8 get_fans_failed(void)
         |    ^~~~~~~~~~~~~~~


vim +/get_fans_installed +32 drivers/hwmon/gxp-fan-ctrl.c

    31	
  > 32	u8 get_fans_installed(void)
    33	{
    34		static u8 val;
    35	
    36		val = readb(drvdata->plreg + OFS_FAN_INST);
    37	
    38		return val;
    39	}
    40	EXPORT_SYMBOL(get_fans_installed);
    41	
    42	static long fan_failed(struct device *dev, int fan)
    43	{
    44		struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
    45		u8 val;
    46	
    47		val = readb(drvdata->plreg + OFS_FAN_FAIL);
    48	
    49		return !!(val & BIT(fan));
    50	}
    51	
  > 52	u8 get_fans_failed(void)
    53	{
    54		static u8 val;
    55	
    56		val = readb(drvdata->plreg + OFS_FAN_FAIL);
    57	
    58		return val;
    59	}
    60	EXPORT_SYMBOL(get_fans_failed);
    61	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
