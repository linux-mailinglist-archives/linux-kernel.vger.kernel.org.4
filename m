Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F268A9C3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 13:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjBDMVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 07:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 07:21:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123712695;
        Sat,  4 Feb 2023 04:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675513308; x=1707049308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J6/WHPwLYf2NNiKUv4H1tve+SuwKBjAJdENF3a4dPDI=;
  b=IiE52I0WFznCUtfr1seTwMHU9AsBym0iAb4LFJEHy4Nthrs0TxqHDc0A
   cJFkGIMw0/MA0LbU+ac51JtmBYk3iK4lyJDI9i3PnDgQouWs1SwXL7VvY
   Xpt/ErxB0vYDemzXg78EzJaOQXEZZebl7fFvuStm+o9HX0V75RpZwYNNm
   WiYF94rL0HNa8NQ4xm8z7+61SMca2aWLyNyWxsIoo/QeUjEOomlrNwYpg
   sgHdWSBg5UqbMNEHZREWKz5nazyXEnhTo0kj/LM0ewqPKvj/vXvAfZDve
   ys1jLgryl4/nzK02z65QcB6HQDcTqHKZmeddfB5+/x40xbI9sxDJ2Ltyl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="330230550"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="330230550"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 04:21:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="839890077"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="839890077"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2023 04:21:44 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOHY7-0001Ic-1C;
        Sat, 04 Feb 2023 12:21:43 +0000
Date:   Sat, 4 Feb 2023 20:21:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] clk: qcom: branch: Clean up branch enable
 registers
Message-ID: <202302042015.l7uhyaz9-lkp@intel.com>
References: <20230201183626.351211-5-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201183626.351211-5-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

I love your patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v6.2-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/clk-qcom-branch-Add-helper-functions-for-setting-SLEEP-WAKE-bits/20230202-033712
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230201183626.351211-5-konrad.dybcio%40linaro.org
patch subject: [PATCH v5 04/10] clk: qcom: branch: Clean up branch enable registers
config: arm-randconfig-r013-20230204 (https://download.01.org/0day-ci/archive/20230204/202302042015.l7uhyaz9-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/07999d2b9b99df1dc626354c217da075c5c565cb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Konrad-Dybcio/clk-qcom-branch-Add-helper-functions-for-setting-SLEEP-WAKE-bits/20230202-033712
        git checkout 07999d2b9b99df1dc626354c217da075c5c565cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/clk/qcom/clk-branch.c:14:
   drivers/clk/qcom/clk-branch.h:74:7: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                              FIELD_PREP(CBCR_WAKEUP, val));
                              ^
   drivers/clk/qcom/clk-branch.h:80:7: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                              FIELD_PREP(CBCR_SLEEP, val));
                              ^
>> drivers/clk/qcom/clk-branch.c:55:4: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           FIELD_GET(CBCR_NOC_FSM_STATUS, val) == FSM_STATUS_ON;
                           ^
   3 errors generated.


vim +/FIELD_GET +55 drivers/clk/qcom/clk-branch.c

    41	
    42	static bool clk_branch2_check_halt(const struct clk_branch *br, bool enabling)
    43	{
    44		u32 val;
    45		u32 mask;
    46	
    47		mask = CBCR_NOC_FSM_STATUS;
    48		mask |= CBCR_CLK_OFF;
    49	
    50		regmap_read(br->clkr.regmap, br->halt_reg, &val);
    51	
    52		if (enabling) {
    53			val &= mask;
    54			return (val & CBCR_CLK_OFF) == 0 ||
  > 55				FIELD_GET(CBCR_NOC_FSM_STATUS, val) == FSM_STATUS_ON;
    56		} else {
    57			return val & CBCR_CLK_OFF;
    58		}
    59	}
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
