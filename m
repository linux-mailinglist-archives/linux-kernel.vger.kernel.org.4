Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4891F6C6E72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCWRMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCWRMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:12:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFAB23C68;
        Thu, 23 Mar 2023 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679591560; x=1711127560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1P6DW8GCu0Rh5J3iAuRbJHRJpgLRrsh0L9ouH/3CJLg=;
  b=PJWMxZqqocQHGP8huFT75Euv5bA4XMHxw65nwifY8M9uaTQW3Kdxi+E1
   Ewa93e6I2g0/Y3wd00dz8yfEjFLHpunf3Xs4/6LASDQupl83iQ3rOF1fz
   5+TlEZDd6nnRWfYryplfXH85Lc0yvVVcngGHSiKmUd6hbllEOkEK+Z+at
   0Xkj2asLekWxiyTe4T6yCx6ZYNLbGb7wTsiK1ef/m5JCOo8OC6GtAtSWG
   nMSijUBIxTJbdvR8O+wwW4urWkEsmRFFvwuTOkUiNKWwBYkery2XVL7if
   4+3X1zaovEejfLd9E2X4liOQy1RmlI401aInKBCGOwG1CpC8chQuwLsgN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341942779"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="341942779"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 10:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="1011906519"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="1011906519"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2023 10:12:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfOUO-000EZ6-09;
        Thu, 23 Mar 2023 17:12:36 +0000
Date:   Fri, 24 Mar 2023 01:11:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chester Lin <clin@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, Chester Lin <clin@suse.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v3 1/6] pinctrl: s32g2: use of_device_get_match_data() to
 get device data
Message-ID: <202303240158.uaLsPb4O-lkp@intel.com>
References: <20230323144833.28562-2-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323144833.28562-2-clin@suse.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chester,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next next-20230323]
[cannot apply to linus/master v6.3-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chester-Lin/pinctrl-s32g2-use-of_device_get_match_data-to-get-device-data/20230323-225141
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230323144833.28562-2-clin%40suse.com
patch subject: [PATCH v3 1/6] pinctrl: s32g2: use of_device_get_match_data() to get device data
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230324/202303240158.uaLsPb4O-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b716f96ba217e92e79b0d888f187ba0f30d705cf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chester-Lin/pinctrl-s32g2-use-of_device_get_match_data-to-get-device-data/20230323-225141
        git checkout b716f96ba217e92e79b0d888f187ba0f30d705cf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pinctrl/nxp/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303240158.uaLsPb4O-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/nxp/pinctrl-s32g2.c: In function 's32g_pinctrl_probe':
>> drivers/pinctrl/nxp/pinctrl-s32g2.c:747:40: warning: passing argument 2 of 's32_pinctrl_probe' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     747 |         return s32_pinctrl_probe(pdev, info);
         |                                        ^~~~
   In file included from drivers/pinctrl/nxp/pinctrl-s32g2.c:18:
   drivers/pinctrl/nxp/pinctrl-s32.h:70:54: note: expected 'struct s32_pinctrl_soc_info *' but argument is of type 'const struct s32_pinctrl_soc_info *'
      70 |                         struct s32_pinctrl_soc_info *info);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~


vim +747 drivers/pinctrl/nxp/pinctrl-s32g2.c

   740	
   741	static int s32g_pinctrl_probe(struct platform_device *pdev)
   742	{
   743		const struct s32_pinctrl_soc_info *info;
   744	
   745		info = of_device_get_match_data(&pdev->dev);
   746	
 > 747		return s32_pinctrl_probe(pdev, info);
   748	}
   749	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
