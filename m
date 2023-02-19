Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D402C69C154
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 17:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjBSQYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 11:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjBSQYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 11:24:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6118B10422;
        Sun, 19 Feb 2023 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676823886; x=1708359886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=feAPOL1N++/UethRnvUXw50DQ6+CpkyqCffcMo7/488=;
  b=aIVy/HaFOB5ZkBPRVj1zYau8AI5xgd5egsPcxoyoXKTI+dPyzzoB6/yy
   tpUBvx/aEC+15r/of44AP+fAM4CYfxbVBTEp1ok7RQrfe9GNvJ+upG/qz
   9xZSAJQ4zAna0qV2tYKqmLy7v+Tkbhe4if27mCzJVQrj1NkdsbAWrzgyl
   /EUU8trRHPaMwxZZTBMOPtDCd2XYDOi4/8lVkLXMHnIYQyUYuZCIoFFWu
   JzWB0nFdRWU7iosohf7yNYap6kBW/k2cNL/pHNc+IWSkN11rROn+If6SM
   hN1hye/qY3fuIdlGqxiSUZYlQ+BIA9aw744UxES6YivzLJ5u1+dM3tiFb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="332266281"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="332266281"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 08:24:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="673122428"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="673122428"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Feb 2023 08:24:39 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTmUQ-000DMT-31;
        Sun, 19 Feb 2023 16:24:38 +0000
Date:   Mon, 20 Feb 2023 00:23:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1 01/17] thermal/core: Add a thermal zone 'devdata'
 accessor
Message-ID: <202302200054.npcAWO2a-lkp@intel.com>
References: <20230219143657.241542-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219143657.241542-2-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on next-20230217]
[cannot apply to groeck-staging/hwmon-next tegra/for-next linus/master v6.2-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-core-Add-a-thermal-zone-devdata-accessor/20230219-224155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230219143657.241542-2-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 01/17] thermal/core: Add a thermal zone 'devdata' accessor
config: sparc64-randconfig-r015-20230219 (https://download.01.org/0day-ci/archive/20230220/202302200054.npcAWO2a-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4ae519499a90b8b0388e5e80c5d85c6dbf292242
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-core-Add-a-thermal-zone-devdata-accessor/20230219-224155
        git checkout 4ae519499a90b8b0388e5e80c5d85c6dbf292242
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/ata/ drivers/hwmon/pmbus/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302200054.npcAWO2a-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/ata/ahci_imx.c: In function 'sata_ahci_read_temperature':
>> drivers/ata/ahci_imx.c:421:45: error: implicit declaration of function 'thermal_zone_device_get_data'; did you mean 'thermal_zone_device_enable'? [-Werror=implicit-function-declaration]
     421 |         return __sata_ahci_read_temperature(thermal_zone_device_get_data(tz), temp);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                             thermal_zone_device_enable
>> drivers/ata/ahci_imx.c:421:45: warning: passing argument 1 of '__sata_ahci_read_temperature' makes pointer from integer without a cast [-Wint-conversion]
     421 |         return __sata_ahci_read_temperature(thermal_zone_device_get_data(tz), temp);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                             |
         |                                             int
   drivers/ata/ahci_imx.c:330:47: note: expected 'void *' but argument is of type 'int'
     330 | static int __sata_ahci_read_temperature(void *dev, int *temp)
         |                                         ~~~~~~^~~
   cc1: some warnings being treated as errors
--
   drivers/hwmon/pmbus/pmbus_core.c: In function 'pmbus_thermal_get_temp':
>> drivers/hwmon/pmbus/pmbus_core.c:1275:44: error: implicit declaration of function 'thermal_zone_device_get_data'; did you mean 'thermal_zone_device_enable'? [-Werror=implicit-function-declaration]
    1275 |         struct pmbus_thermal_data *tdata = thermal_zone_device_get_data(tz);
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                            thermal_zone_device_enable
>> drivers/hwmon/pmbus/pmbus_core.c:1275:44: warning: initialization of 'struct pmbus_thermal_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors


vim +421 drivers/ata/ahci_imx.c

   418	
   419	static int sata_ahci_read_temperature(struct thermal_zone_device *tz, int *temp)
   420	{
 > 421		return __sata_ahci_read_temperature(thermal_zone_device_get_data(tz), temp);
   422	}
   423	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
