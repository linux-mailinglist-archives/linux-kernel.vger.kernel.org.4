Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AD0695609
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjBNBkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBNBkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:40:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD419F37;
        Mon, 13 Feb 2023 17:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676338851; x=1707874851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2iIYyQn1bP9yipL0bzeLnfAtzKbwRDbVyU0kZb96soc=;
  b=YFRC5dr3iG2uf1KcDb3JfgSWazYk8yRPw1J2j4+w/13nUxMzruil00jB
   2sIBRjmbaJW/AGkhg851eyyyYZknjqPDVTg+TCaiNuAGmt+TrpLmHW/SR
   jZHlcelWQx1mwLeR4iE8oCWx3hQJPKNQ6Kt0Y9MX60kVLAsowO9WgVZjF
   QYMtROeJSA4/mqVmoE/Mp5bd8pS0SC52JMxgGX0WIcJD2qnuU9VX2ZhFz
   G8+DTXEsmYwp/OYfrMUYIZhNN0HqA1Ubx8L8qPmafRs9nqwnSgnms1kBq
   WsszQkf7ElyBX88uQQtUHkZnU+NTYDnC+jiM1FvddsdXV4zx7Dp+NLo7o
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="311410614"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="311410614"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 17:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="792937781"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="792937781"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2023 17:40:48 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRkJM-00087G-0x;
        Tue, 14 Feb 2023 01:40:48 +0000
Date:   Tue, 14 Feb 2023 09:40:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frieder Schrempf <frieder@fris.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 4/6] regulator: Add operation to let drivers select vsel
 register
Message-ID: <202302140905.36f6bYXV-lkp@intel.com>
References: <20230213155833.1644366-5-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213155833.1644366-5-frieder@fris.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-regulator/for-next]
[also build test WARNING on shawnguo/for-next arm/for-next arm/fixes arm64/for-next/core kvmarm/next rockchip/for-next soc/for-next xilinx-xlnx/master linus/master v6.2-rc8 next-20230213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frieder-Schrempf/dt-bindings-regulator-pca9450-Document-new-usage-of-sd-vsel-gpios/20230214-013045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20230213155833.1644366-5-frieder%40fris.de
patch subject: [PATCH 4/6] regulator: Add operation to let drivers select vsel register
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230214/202302140905.36f6bYXV-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b76ab45ee4b60334c27d870b6d744a937ff94636
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frieder-Schrempf/dt-bindings-regulator-pca9450-Document-new-usage-of-sd-vsel-gpios/20230214-013045
        git checkout b76ab45ee4b60334c27d870b6d744a937ff94636
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302140905.36f6bYXV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/regulator/helpers.c:226:14: warning: no previous prototype for 'regulator_get_hwreg_voltage_sel_regmap' [-Wmissing-prototypes]
     226 | unsigned int regulator_get_hwreg_voltage_sel_regmap(struct regulator_dev *rdev)
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/regulator_get_hwreg_voltage_sel_regmap +226 drivers/regulator/helpers.c

   225	
 > 226	unsigned int regulator_get_hwreg_voltage_sel_regmap(struct regulator_dev *rdev)
   227	{
   228		const struct regulator_ops *ops = rdev->desc->ops;
   229	
   230		if (ops->get_reg_voltage_sel)
   231			return ops->get_reg_voltage_sel(rdev);
   232	
   233		return rdev->desc->vsel_reg;
   234	}
   235	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
