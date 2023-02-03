Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249B8689864
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjBCMUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjBCMUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:20:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F9070D55;
        Fri,  3 Feb 2023 04:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675426803; x=1706962803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Vdo0YGzZ1ka9qHdi9M3e75lauC6FuFXPxqZRrVJUKs=;
  b=lxlFAxqL4OpkS7yh07XIX2henXxHpJQokGUp0RPPtXVYlvzC5mUsjrqP
   QrejBkCH0aNFHl/fkfmeNJGEQ4gMzlrdWe2EWGUGB2OuRsF5HaaOm8/xI
   JjhnVMqbLa4+o0rMypLif+PmHczhpaT4ZHmZ7VntN7/1W8jOShyrwGZD8
   nfcqE8GhuQp62PysxkGdMeGJrDDboj81AWAYjYM2vdRQ8ZqR9//I7e29G
   MRbx9GxO8QbdUooC0uRcsGAjbH5xYJ273R+nE/dlOUrm1leUnkb+OZo5p
   EyeZ98CdYW/q+2YL+5AW2gghoN/+H//+V3mb4tit132zKox1oCi17xTsU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="326432126"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="326432126"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 04:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="615697909"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="615697909"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Feb 2023 04:19:59 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNv2s-0000TJ-1B;
        Fri, 03 Feb 2023 12:19:58 +0000
Date:   Fri, 3 Feb 2023 20:19:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     oe-kbuild-all@lists.linux.dev, Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] clk: samsung: exynos5433: Extract PM support to
 common ARM64 layer
Message-ID: <202302032018.WKygXXHK-lkp@intel.com>
References: <20230203060924.8257-7-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203060924.8257-7-semen.protsenko@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on krzk/for-next]
[also build test ERROR on linus/master v6.2-rc6]
[cannot apply to next-20230203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sam-Protsenko/clk-samsung-Don-t-pass-reg_base-to-samsung_clk_register_pll/20230203-141059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20230203060924.8257-7-semen.protsenko%40linaro.org
patch subject: [PATCH 6/6] clk: samsung: exynos5433: Extract PM support to common ARM64 layer
config: openrisc-randconfig-r003-20230202 (https://download.01.org/0day-ci/archive/20230203/202302032018.WKygXXHK-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7fc08f82f3096e6f1c747f00b9d56c029b0b7a0f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sam-Protsenko/clk-samsung-Don-t-pass-reg_base-to-samsung_clk_register_pll/20230203-141059
        git checkout 7fc08f82f3096e6f1c747f00b9d56c029b0b7a0f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/clk/samsung/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/samsung/clk-exynos-arm64.c: In function 'exynos_arm64_cmu_prepare_pm':
>> drivers/clk/samsung/clk-exynos-arm64.c:136:17: error: implicit declaration of function 'kfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
     136 |                 kfree(data->clk_save);
         |                 ^~~~~
         |                 vfree
   cc1: some warnings being treated as errors


vim +136 drivers/clk/samsung/clk-exynos-arm64.c

   114	
   115	static int __init exynos_arm64_cmu_prepare_pm(struct device *dev,
   116			const struct samsung_cmu_info *cmu)
   117	{
   118		struct exynos_arm64_cmu_data *data = dev_get_drvdata(dev);
   119		int i;
   120	
   121		data->clk_save = samsung_clk_alloc_reg_dump(cmu->clk_regs,
   122							    cmu->nr_clk_regs);
   123		if (!data->clk_save)
   124			return -ENOMEM;
   125	
   126		data->nr_clk_save = cmu->nr_clk_regs;
   127		data->clk_suspend = cmu->suspend_regs;
   128		data->nr_clk_suspend = cmu->nr_suspend_regs;
   129		data->nr_pclks = of_clk_get_parent_count(dev->of_node);
   130		if (!data->nr_pclks)
   131			return 0;
   132	
   133		data->pclks = devm_kcalloc(dev, sizeof(struct clk *), data->nr_pclks,
   134					   GFP_KERNEL);
   135		if (!data->pclks) {
 > 136			kfree(data->clk_save);
   137			return -ENOMEM;
   138		}
   139	
   140		for (i = 0; i < data->nr_pclks; i++) {
   141			struct clk *clk = of_clk_get(dev->of_node, i);
   142	
   143			if (IS_ERR(clk)) {
   144				kfree(data->clk_save);
   145				while (--i >= 0)
   146					clk_put(data->pclks[i]);
   147				return PTR_ERR(clk);
   148			}
   149			data->pclks[i] = clk;
   150		}
   151	
   152		return 0;
   153	}
   154	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
