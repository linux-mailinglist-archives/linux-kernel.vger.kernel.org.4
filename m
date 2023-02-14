Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB8695EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBNJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjBNJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:20:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E635FC4;
        Tue, 14 Feb 2023 01:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676366410; x=1707902410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=36ankMROoiHIBFJltB6iuBfi/2ZprB2hArXdzmlRtVs=;
  b=ci0lWF4pWpHaSTEXqoaJz4w33IHq0slsHDHW4l5G0NvsdlN/QpVVlyP5
   vnV7bQh1IGUUTdSYSDtfRjTD8KVwBP6XFOlywSbuQdwsphOm0a+e0bEbS
   aOfPIFRgNwHOzkBjahEwKTsbWUHnJ70pJ3bouA0a7xgY8+yiofMyLEbfb
   eM7L8EMA0RXtuMQhB8E18ajlyBHcDiEkwY6MhhL7mVTztxgCdyXfP08uy
   qALNrehiT9jDN71azgdZ0do9Gj93s1CFTuRbOe2CDbuRR50RY2IxbELKw
   Ftd6WCPoHSL8uXBxe7VxKDIoLiMuczIwDdeCBP0abPNzHb8rcOmnfbync
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332431882"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="332431882"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 01:20:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="732825617"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="732825617"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2023 01:20:06 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRrTl-0008MJ-0M;
        Tue, 14 Feb 2023 09:20:01 +0000
Date:   Tue, 14 Feb 2023 17:19:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frieder Schrempf <frieder@fris.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 4/6] regulator: Add operation to let drivers select vsel
 register
Message-ID: <202302141754.N3CvO9lF-lkp@intel.com>
References: <20230213155833.1644366-5-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213155833.1644366-5-frieder@fris.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-regulator/for-next]
[also build test WARNING on shawnguo/for-next arm/for-next arm/fixes arm64/for-next/core kvmarm/next rockchip/for-next soc/for-next xilinx-xlnx/master linus/master v6.2-rc8 next-20230214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frieder-Schrempf/dt-bindings-regulator-pca9450-Document-new-usage-of-sd-vsel-gpios/20230214-013045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20230213155833.1644366-5-frieder%40fris.de
patch subject: [PATCH 4/6] regulator: Add operation to let drivers select vsel register
config: i386-randconfig-a003-20230213 (https://download.01.org/0day-ci/archive/20230214/202302141754.N3CvO9lF-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b76ab45ee4b60334c27d870b6d744a937ff94636
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frieder-Schrempf/dt-bindings-regulator-pca9450-Document-new-usage-of-sd-vsel-gpios/20230214-013045
        git checkout b76ab45ee4b60334c27d870b6d744a937ff94636
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302141754.N3CvO9lF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/regulator/helpers.c:226:14: warning: no previous prototype for function 'regulator_get_hwreg_voltage_sel_regmap' [-Wmissing-prototypes]
   unsigned int regulator_get_hwreg_voltage_sel_regmap(struct regulator_dev *rdev)
                ^
   drivers/regulator/helpers.c:226:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned int regulator_get_hwreg_voltage_sel_regmap(struct regulator_dev *rdev)
   ^
   static 
   1 warning generated.


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
