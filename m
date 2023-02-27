Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44286A3B55
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 07:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjB0Goh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 01:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0Gog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 01:44:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A89510AB1;
        Sun, 26 Feb 2023 22:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677480275; x=1709016275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l7fNlOQJTNMVvMxezJZRa8jk93MTm7z8h1o/L1+XyGw=;
  b=D6cWj6ahbhDL4C6f6dII5CfR23hqwZqU2W/ejPj09phJZlboMZEYS4j8
   DPGywoVCQ4727WILjv8rsee6Sp3q1LsCD9xATKSZHFO82mg1Wju+hudZQ
   SdB0GsUzMsiy2hjb3TjKyKv0Ld241AO3JtTWiBI+ChBmvHz72qIcMl6+S
   o6CQCQxFJhI9JahuzCmEnl9RTFCPyAm6bKOIVJ7e6wz54AeOnBwaI8nDT
   FQkRM793RwzolszBM+xeWu1GZS9e7Qn/wgOLPMf1i8GppgVFi8q26bmHw
   5DrpTd7+AZo5qaUtDbyRP3zfFkhx0zfeyXM08oERnqkajDe6XgM2FpcWw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="332514897"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="332514897"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 22:44:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="651085796"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="651085796"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2023 22:44:27 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWXFK-0004A3-0T;
        Mon, 27 Feb 2023 06:44:26 +0000
Date:   Mon, 27 Feb 2023 14:43:45 +0800
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
Message-ID: <202302271421.ZjVUJ4DB-lkp@intel.com>
References: <20230226225406.979703-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226225406.979703-3-daniel.lezcano@linaro.org>
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
[also build test ERROR on groeck-staging/hwmon-next]
[cannot apply to v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-core-Add-a-thermal-zone-devdata-accessor/20230227-065829
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230226225406.979703-3-daniel.lezcano%40linaro.org
patch subject: [PATCH v3 02/20] thermal/core: Use the thermal zone 'devdata' accessor in thermal located drivers
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230227/202302271421.ZjVUJ4DB-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302271421.ZjVUJ4DB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/db8500_thermal.c: In function 'db8500_thermal_get_temp':
>> drivers/thermal/db8500_thermal.c:63:42: error: implicit declaration of function 'therma_zone_device_priv'; did you mean 'thermal_zone_device_priv'? [-Werror=implicit-function-declaration]
      63 |         struct db8500_thermal_zone *th = therma_zone_device_priv(tz);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~
         |                                          thermal_zone_device_priv
   drivers/thermal/db8500_thermal.c:63:42: warning: initialization of 'struct db8500_thermal_zone *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
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
