Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6966A3644
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 02:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjB0B51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 20:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjB0B5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 20:57:25 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5B6126C6;
        Sun, 26 Feb 2023 17:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677463043; x=1708999043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oXN9Efov7ltz2ez30CCK5KZv8Cvd5tH27ee1t/EGyw0=;
  b=NBVcCC6nJHrnYReJQNaiL5bY1vHaEZtZM8yOOceOoVDMicB+WzP+/4lW
   0Rh3k0QB1V8BDHwN75DdFkGyrS2CFsUghoVzDYMqJfcHKoK+ra79TSzz/
   fgUESTLbqsAjJJ+p5RPKI2sW6wilFRT2r0vFdQw93gS5CkTxe5YOVJSNF
   NhCbof4jQYjAzgG5SpIQ8UZqwZh/U11Zv38hBjx7EBt8oi660EjvL1nqP
   dcm9Wk1KZ2Y0Xo+dJxdBks8ytC1M/BIH0J2vabcCSFne1UM43uvze/eaX
   Nkd1UtOdNuFEJGjWq9Nfz/LXHRYJGwLoAzNzIUtpp3aWTBfCJCECPQDi2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="317560865"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="317560865"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 17:57:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="919111061"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="919111061"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Feb 2023 17:57:15 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWSlP-00040Z-0f;
        Mon, 27 Feb 2023 01:57:15 +0000
Date:   Mon, 27 Feb 2023 09:57:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 02/20] thermal/core: Use the thermal zone 'devdata'
 accessor in thermal located drivers
Message-ID: <202302270923.6ETtTcpX-lkp@intel.com>
References: <20230226225406.979703-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226225406.979703-3-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on groeck-staging/hwmon-next]
[cannot apply to v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-core-Add-a-thermal-zone-devdata-accessor/20230227-065829
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230226225406.979703-3-daniel.lezcano%40linaro.org
patch subject: [PATCH v3 02/20] thermal/core: Use the thermal zone 'devdata' accessor in thermal located drivers
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230227/202302270923.6ETtTcpX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c12531f9e11ce889a1c6adaa17dfbaa04a5d74a5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-core-Add-a-thermal-zone-devdata-accessor/20230227-065829
        git checkout c12531f9e11ce889a1c6adaa17dfbaa04a5d74a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302270923.6ETtTcpX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/db8500_thermal.c: In function 'db8500_thermal_get_temp':
   drivers/thermal/db8500_thermal.c:63:42: error: implicit declaration of function 'therma_zone_device_priv'; did you mean 'thermal_zone_device_priv'? [-Werror=implicit-function-declaration]
      63 |         struct db8500_thermal_zone *th = therma_zone_device_priv(tz);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~
         |                                          thermal_zone_device_priv
>> drivers/thermal/db8500_thermal.c:63:42: warning: initialization of 'struct db8500_thermal_zone *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors


vim +63 drivers/thermal/db8500_thermal.c

    59	
    60	/* Callback to get current temperature */
    61	static int db8500_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
    62	{
  > 63		struct db8500_thermal_zone *th = therma_zone_device_priv(tz);
    64	
    65		/*
    66		 * TODO: There is no PRCMU interface to get temperature data currently,
    67		 * so a pseudo temperature is returned , it works for thermal framework
    68		 * and this will be fixed when the PRCMU interface is available.
    69		 */
    70		*temp = th->interpolated_temp;
    71	
    72		return 0;
    73	}
    74	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
