Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512A9700F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbjELTkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjELTkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:40:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D911FE4;
        Fri, 12 May 2023 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683920399; x=1715456399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oYw5r8hR87hJDnq03J6dMbdqVbJIN5U3WktNqH4vWlA=;
  b=i/Un6Rk5jGdHoyRfaVe+cvCzGQfDQ+TfSggQT3pU19uAEQMf1aS19PAt
   GmEV9KI2moY9pDW37yYnjndmD6Hbzo7B0d4nZVd5zsTgqFAn3lQwNb3TX
   NH6atdk6LydjEw1IYthhk5FHvY50rpJvzIG7gKcAvbGsKTev7N7wedUd+
   vzcrKHjcJHZXmZiEG9B5PWLMBt+CIumduddJKq01G9OZEZAMfsVCCBDOg
   ijjUK0PLQ5+NhKu+n0c9Jg6gws0gekgf1rcFnaxyQAcya4O3Oz9bVN1k6
   TseOjxD4G3uKlZ2ecH+wdoLSNPlpKOGNKCbNMPMEkEaxHO+SGLJHZYIwg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="335394073"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="335394073"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 12:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="694351039"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="694351039"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2023 12:39:55 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxYcM-00054W-2Q;
        Fri, 12 May 2023 19:39:54 +0000
Date:   Sat, 13 May 2023 03:39:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 06/10] soc: qcom: Add LLCC support for multi channel
 DDR
Message-ID: <202305130308.9zOC4OZC-lkp@intel.com>
References: <20230512122134.24339-7-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512122134.24339-7-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Komal,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.4-rc1 next-20230512]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Komal-Bajaj/nvmem-qfprom-Add-support-for-secure-reading/20230512-202430
base:   linus/master
patch link:    https://lore.kernel.org/r/20230512122134.24339-7-quic_kbajaj%40quicinc.com
patch subject: [PATCH v3 06/10] soc: qcom: Add LLCC support for multi channel DDR
config: nios2-buildonly-randconfig-r001-20230509 (https://download.01.org/0day-ci/archive/20230513/202305130308.9zOC4OZC-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/52808ee1c4720767ab330b371d356ffbd8fe7235
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Komal-Bajaj/nvmem-qfprom-Add-support-for-secure-reading/20230512-202430
        git checkout 52808ee1c4720767ab330b371d356ffbd8fe7235
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305130308.9zOC4OZC-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/soc/qcom/llcc-qcom.c: In function 'qcom_llcc_get_cfg_index':
>> drivers/soc/qcom/llcc-qcom.c:951:15: error: implicit declaration of function 'nvmem_cell_read_u8'; did you mean 'nvmem_cell_read_u64'? [-Werror=implicit-function-declaration]
     951 |         ret = nvmem_cell_read_u8(&pdev->dev, "multi_chan_ddr", cfg_index);
         |               ^~~~~~~~~~~~~~~~~~
         |               nvmem_cell_read_u64
   cc1: some warnings being treated as errors


vim +951 drivers/soc/qcom/llcc-qcom.c

   946	
   947	static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
   948	{
   949		int ret = 0;
   950	
 > 951		ret = nvmem_cell_read_u8(&pdev->dev, "multi_chan_ddr", cfg_index);
   952		if (ret == -ENOENT) {
   953			*cfg_index = 0;
   954			return 0;
   955		}
   956	
   957		return ret;
   958	}
   959	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
