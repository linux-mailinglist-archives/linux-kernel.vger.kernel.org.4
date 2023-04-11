Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C86DD711
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDKJlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDKJlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:41:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF06E7C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681206096; x=1712742096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dx9yECk/yV281BoElbhioyEof/Q6kRwA0sSHmXdpbLQ=;
  b=MDs6MlLascVsqrLgFQ+yqRfx8X7Fj/wShYV3CTdcmqkVO7Wigfxidu/j
   e80NBeGoHZvPWJSclt3Ymb+X/SjmmhW5dbSZITk/6iqdkLBa+Jrw2Agor
   kd2kIUI8OkGZQgl4XOhht3VcK1u+ZbaWUtkFmUgWtrwR4UC+DBVwd6Wga
   tS1EpG3WR4Ym7brgb83juoXyKyyhBcLsVnNHfAPxLwqFkUsmPU8ErjZsX
   x7W0yNnL8RbW+yECCkHR47IAcehji18HxaVh/XEoVO6tvPbMLfUG0oeh+
   9k1U6Z9uC5/9wCRw3GIafZRvzGDRbwz2IMUsF9rEOVVwl1vIQfvC9ghpC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="408707945"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="408707945"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 02:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="934651187"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="934651187"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Apr 2023 02:41:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmAUp-000WBN-1p;
        Tue, 11 Apr 2023 09:41:03 +0000
Date:   Tue, 11 Apr 2023 17:40:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     YAN SHI <m202071378@hust.edu.cn>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        YAN SHI <m202071378@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Regulator: stm32-pwr: fix of_iomap leak
Message-ID: <202304111750.o2643eJN-lkp@intel.com>
References: <20230410102501.13246-1-m202071378@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410102501.13246-1-m202071378@hust.edu.cn>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YAN,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-regulator/for-next]
[also build test WARNING on linus/master v6.3-rc6 next-20230411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/YAN-SHI/Regulator-stm32-pwr-fix-of_iomap-leak/20230410-182833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20230410102501.13246-1-m202071378%40hust.edu.cn
patch subject: [PATCH] Regulator: stm32-pwr: fix of_iomap leak
config: i386-buildonly-randconfig-r006-20230410 (https://download.01.org/0day-ci/archive/20230411/202304111750.o2643eJN-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b1d07f5aa3b7411da258693d1860b56fe82b3777
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review YAN-SHI/Regulator-stm32-pwr-fix-of_iomap-leak/20230410-182833
        git checkout b1d07f5aa3b7411da258693d1860b56fe82b3777
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304111750.o2643eJN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/regulator/stm32-pwr.c:132:22: warning: unused variable 'np' [-Wunused-variable]
           struct device_node *np = pdev->dev.of_node;
                               ^
   1 warning generated.


vim +/np +132 drivers/regulator/stm32-pwr.c

6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  129  
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  130  static int stm32_pwr_regulator_probe(struct platform_device *pdev)
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  131  {
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15 @132  	struct device_node *np = pdev->dev.of_node;
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  133  	struct stm32_pwr_reg *priv;
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  134  	void __iomem *base;
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  135  	struct regulator_dev *rdev;
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  136  	struct regulator_config config = { };
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  137  	int i, ret = 0;
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  138  
b1d07f5aa3b741 YAN SHI            2023-04-10  139  	base = devm_platform_ioremap_resource(pdev, 0);
b1d07f5aa3b741 YAN SHI            2023-04-10  140  	if (IS_ERR(base)) {
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  141  		dev_err(&pdev->dev, "Unable to map IO memory\n");
b1d07f5aa3b741 YAN SHI            2023-04-10  142  		return PTR_ERR(base);
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  143  	}
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  144  
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  145  	config.dev = &pdev->dev;
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  146  
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  147  	for (i = 0; i < STM32PWR_REG_NUM_REGS; i++) {
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  148  		priv = devm_kzalloc(&pdev->dev, sizeof(struct stm32_pwr_reg),
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  149  				    GFP_KERNEL);
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  150  		if (!priv)
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  151  			return -ENOMEM;
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  152  		priv->base = base;
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  153  		priv->ready_mask = ready_mask_table[i];
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  154  		config.driver_data = priv;
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  155  
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  156  		rdev = devm_regulator_register(&pdev->dev,
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  157  					       &stm32_pwr_desc[i],
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  158  					       &config);
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  159  		if (IS_ERR(rdev)) {
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  160  			ret = PTR_ERR(rdev);
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  161  			dev_err(&pdev->dev,
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  162  				"Failed to register regulator: %d\n", ret);
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  163  			break;
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  164  		}
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  165  	}
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  166  	return ret;
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  167  }
6cdae8173f6771 Pascal PAILLET-LME 2019-04-15  168  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
