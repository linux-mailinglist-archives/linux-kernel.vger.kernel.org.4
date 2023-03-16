Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56B76BD7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCPSDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjCPSDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:03:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90277A54F5;
        Thu, 16 Mar 2023 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678989788; x=1710525788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t3Z0AZq8QfGR1uNwW45+qvzjp/J3+V0/B7NRGW+sJ0k=;
  b=XqILQmeN9ZCsWG935H8hjkDF6TEsMdfVHxpwbAlfO4Qu4MHdSOw7uTr8
   RKWfOJZbrpZvRE4R1BhjBHFTlW0y6C7AyHJGFuos6DU4gd69R3pvF3iVG
   6QApTshDiGcwccNRTqswviPJ+d+WHZdQD+C83fm+kVuHOGLcM8kiUAaQ2
   TcQuCLoiKuKTc/UhxVdtL1/qae3FAV47NG8UtQ4BlUzgKLEpNd6Jr6lfF
   CA3oG8LEIljIwom37npPDNiQS/R2h26/ZeSqBKhHFPOKXrvRKfPuMH7id
   f/dxEhFdsO02ztdrDREzSYinzm4OckjhSWpbJmZzQUQ+OYj2VOM7HhEsl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="321927616"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321927616"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 11:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="925851460"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="925851460"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2023 11:02:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcrvx-0008fe-17;
        Thu, 16 Mar 2023 18:02:37 +0000
Date:   Fri, 17 Mar 2023 02:02:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] thermal/drivers/mediatek/lvts_thermal: Register
 thermal zones as hwmon sensors
Message-ID: <202303170104.d4JG4Rmo-lkp@intel.com>
References: <20230315034449.2604197-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315034449.2604197-1-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v6.3-rc2 next-20230316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/thermal-drivers-mediatek-lvts_thermal-Register-thermal-zones-as-hwmon-sensors/20230315-114601
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230315034449.2604197-1-wenst%40chromium.org
patch subject: [PATCH RESEND] thermal/drivers/mediatek/lvts_thermal: Register thermal zones as hwmon sensors
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20230317/202303170104.d4JG4Rmo-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1f9bbeb9645230bb309c589d8bea6bf066628b44
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chen-Yu-Tsai/thermal-drivers-mediatek-lvts_thermal-Register-thermal-zones-as-hwmon-sensors/20230315-114601
        git checkout 1f9bbeb9645230bb309c589d8bea6bf066628b44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/misc/ drivers/net/mdio/ drivers/pci/controller/ drivers/rtc/ drivers/thermal/mediatek/ drivers/tty/serial/ drivers/usb/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303170104.d4JG4Rmo-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/mediatek/lvts_thermal.c: In function 'lvts_ctrl_start':
>> drivers/thermal/mediatek/lvts_thermal.c:997:55: error: 'chip' undeclared (first use in this function)
     997 |                 if (devm_thermal_add_hwmon_sysfs(dev, chip->tz_dev))
         |                                                       ^~~~
   drivers/thermal/mediatek/lvts_thermal.c:997:55: note: each undeclared identifier is reported only once for each function it appears in


vim +/chip +997 drivers/thermal/mediatek/lvts_thermal.c

   971	
   972	static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
   973	{
   974		struct lvts_sensor *lvts_sensors = lvts_ctrl->sensors;
   975		struct thermal_zone_device *tz;
   976		u32 sensor_map = 0;
   977		int i;
   978	
   979		for (i = 0; i < lvts_ctrl->num_lvts_sensor; i++) {
   980	
   981			int dt_id = lvts_sensors[i].dt_id;
   982	
   983			tz = devm_thermal_of_zone_register(dev, dt_id, &lvts_sensors[i],
   984							   &lvts_ops);
   985			if (IS_ERR(tz)) {
   986				/*
   987				 * This thermal zone is not described in the
   988				 * device tree. It is not an error from the
   989				 * thermal OF code POV, we just continue.
   990				 */
   991				if (PTR_ERR(tz) == -ENODEV)
   992					continue;
   993	
   994				return PTR_ERR(tz);
   995			}
   996	
 > 997			if (devm_thermal_add_hwmon_sysfs(dev, chip->tz_dev))
   998				dev_warn(dev, "zone %d: Failed to add hwmon sysfs attributes\n", dt_id);
   999	
  1000			/*
  1001			 * The thermal zone pointer will be needed in the
  1002			 * interrupt handler, we store it in the sensor
  1003			 * structure. The thermal domain structure will be
  1004			 * passed to the interrupt handler private data as the
  1005			 * interrupt is shared for all the controller
  1006			 * belonging to the thermal domain.
  1007			 */
  1008			lvts_sensors[i].tz = tz;
  1009	
  1010			/*
  1011			 * This sensor was correctly associated with a thermal
  1012			 * zone, let's set the corresponding bit in the sensor
  1013			 * map, so we can enable the temperature monitoring in
  1014			 * the hardware thermal controller.
  1015			 */
  1016			sensor_map |= BIT(i);
  1017		}
  1018	
  1019		/*
  1020		 * Bits:
  1021		 *      9: Single point access flow
  1022		 *    0-3: Enable sensing point 0-3
  1023		 *
  1024		 * The initialization of the thermal zones give us
  1025		 * which sensor point to enable. If any thermal zone
  1026		 * was not described in the device tree, it won't be
  1027		 * enabled here in the sensor map.
  1028		 */
  1029		writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
  1030	
  1031		return 0;
  1032	}
  1033	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
