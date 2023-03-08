Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2D6B0C44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCHPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCHPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:13:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EAA4EE3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678288379; x=1709824379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+JMzwKqixGLQcKdmkGtbWjoU86nAcEkdXfz2djooKI=;
  b=mgN/2q6feWjz6JPYpvkkbFm1V5vuLOQHdhtWn9HXkQdqL5cK8ZU+mzP/
   T2is/mwwFxagFOIQkjIemXUeHrBM348NBq1s5AAXzd7YJsf9Hoz5Cz5UC
   mCD9AvoC30+rldrJd/AyOvvZt7P2DBPA50ZFPxLk7Dg66w41LhtAa2Cvd
   D1pgxiczwWeHE18Q+aPZx85QS5MyZ7zUglLQn7E4ZW+WWTbeYZ4l+eI6f
   tKt5jjVc2Oct6CQ20/X2tGDT4oBno/N3L1lqd4Ep7GTLqyaro+INzy59L
   Mwq9N3b6Xzbc/813LqyOZNIwVwdwsnG2J6m5S51deYku653Dj1AMCHoiK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="400997205"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="400997205"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="707204795"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="707204795"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Mar 2023 07:12:48 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZvTD-0002Cp-2F;
        Wed, 08 Mar 2023 15:12:47 +0000
Date:   Wed, 8 Mar 2023 23:11:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        kernel@dh-electronics.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] regulator: da9062: Make the use of IRQ optional
Message-ID: <202303082246.GuLdPL0t-lkp@intel.com>
References: <20230307101813.77267-3-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307101813.77267-3-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I love your patch! Perhaps something to improve:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on lee-mfd/for-mfd-fixes soc/for-next broonie-regulator/for-next linus/master v6.3-rc1 next-20230308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Niedermaier/mfd-da9062-Remove-IRQ-requirement/20230307-190334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20230307101813.77267-3-cniedermaier%40dh-electronics.com
patch subject: [PATCH V3 3/3] regulator: da9062: Make the use of IRQ optional
config: i386-randconfig-a013-20230306 (https://download.01.org/0day-ci/archive/20230308/202303082246.GuLdPL0t-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/98b59e5759ae23dcd6d1d04089e513adf11e6376
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christoph-Niedermaier/mfd-da9062-Remove-IRQ-requirement/20230307-190334
        git checkout 98b59e5759ae23dcd6d1d04089e513adf11e6376
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/regulator/da9062-regulator.c:1019:46: warning: variable 'irq' is uninitialized when used here [-Wuninitialized]
           ret = devm_request_threaded_irq(&pdev->dev, irq,
                                                       ^~~
   drivers/regulator/da9062-regulator.c:927:9: note: initialize the variable 'irq' to silence this warning
           int irq, n, ret;
                  ^
                   = 0
   1 warning generated.


vim +/irq +1019 drivers/regulator/da9062-regulator.c

4068e5182ada26 S Twiss               2015-05-19   919  
4068e5182ada26 S Twiss               2015-05-19   920  static int da9062_regulator_probe(struct platform_device *pdev)
4068e5182ada26 S Twiss               2015-05-19   921  {
4068e5182ada26 S Twiss               2015-05-19   922  	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
4068e5182ada26 S Twiss               2015-05-19   923  	struct da9062_regulators *regulators;
4068e5182ada26 S Twiss               2015-05-19   924  	struct da9062_regulator *regl;
4068e5182ada26 S Twiss               2015-05-19   925  	struct regulator_config config = { };
4b7f4958a37e01 Steve Twiss           2017-06-07   926  	const struct da9062_regulator_info *rinfo;
4068e5182ada26 S Twiss               2015-05-19   927  	int irq, n, ret;
4b7f4958a37e01 Steve Twiss           2017-06-07   928  	int max_regulators;
4b7f4958a37e01 Steve Twiss           2017-06-07   929  
4b7f4958a37e01 Steve Twiss           2017-06-07   930  	switch (chip->chip_type) {
4b7f4958a37e01 Steve Twiss           2017-06-07   931  	case COMPAT_TYPE_DA9061:
4b7f4958a37e01 Steve Twiss           2017-06-07   932  		max_regulators = DA9061_MAX_REGULATORS;
4b7f4958a37e01 Steve Twiss           2017-06-07   933  		rinfo = local_da9061_regulator_info;
4b7f4958a37e01 Steve Twiss           2017-06-07   934  		break;
4b7f4958a37e01 Steve Twiss           2017-06-07   935  	case COMPAT_TYPE_DA9062:
4b7f4958a37e01 Steve Twiss           2017-06-07   936  		max_regulators = DA9062_MAX_REGULATORS;
4b7f4958a37e01 Steve Twiss           2017-06-07   937  		rinfo = local_da9062_regulator_info;
4b7f4958a37e01 Steve Twiss           2017-06-07   938  		break;
4b7f4958a37e01 Steve Twiss           2017-06-07   939  	default:
4b7f4958a37e01 Steve Twiss           2017-06-07   940  		dev_err(chip->dev, "Unrecognised chip type\n");
4b7f4958a37e01 Steve Twiss           2017-06-07   941  		return -ENODEV;
4b7f4958a37e01 Steve Twiss           2017-06-07   942  	}
4068e5182ada26 S Twiss               2015-05-19   943  
4068e5182ada26 S Twiss               2015-05-19   944  	/* Allocate memory required by usable regulators */
97b047e72bd6e6 Gustavo A. R. Silva   2019-02-22   945  	regulators = devm_kzalloc(&pdev->dev, struct_size(regulators, regulator,
97b047e72bd6e6 Gustavo A. R. Silva   2019-02-22   946  				  max_regulators), GFP_KERNEL);
4068e5182ada26 S Twiss               2015-05-19   947  	if (!regulators)
4068e5182ada26 S Twiss               2015-05-19   948  		return -ENOMEM;
4068e5182ada26 S Twiss               2015-05-19   949  
4b7f4958a37e01 Steve Twiss           2017-06-07   950  	regulators->n_regulators = max_regulators;
4068e5182ada26 S Twiss               2015-05-19   951  	platform_set_drvdata(pdev, regulators);
4068e5182ada26 S Twiss               2015-05-19   952  
151b03791e4acb Axel Lin              2019-10-07   953  	for (n = 0; n < regulators->n_regulators; n++) {
4068e5182ada26 S Twiss               2015-05-19   954  		/* Initialise regulator structure */
4068e5182ada26 S Twiss               2015-05-19   955  		regl = &regulators->regulator[n];
4068e5182ada26 S Twiss               2015-05-19   956  		regl->hw = chip;
4b7f4958a37e01 Steve Twiss           2017-06-07   957  		regl->info = &rinfo[n];
4068e5182ada26 S Twiss               2015-05-19   958  		regl->desc = regl->info->desc;
4068e5182ada26 S Twiss               2015-05-19   959  		regl->desc.type = REGULATOR_VOLTAGE;
4068e5182ada26 S Twiss               2015-05-19   960  		regl->desc.owner = THIS_MODULE;
4068e5182ada26 S Twiss               2015-05-19   961  
54129d641cac77 Axel Lin              2019-01-26   962  		if (regl->info->mode.reg) {
4068e5182ada26 S Twiss               2015-05-19   963  			regl->mode = devm_regmap_field_alloc(
4068e5182ada26 S Twiss               2015-05-19   964  					&pdev->dev,
4068e5182ada26 S Twiss               2015-05-19   965  					chip->regmap,
4068e5182ada26 S Twiss               2015-05-19   966  					regl->info->mode);
54129d641cac77 Axel Lin              2019-01-26   967  			if (IS_ERR(regl->mode))
54129d641cac77 Axel Lin              2019-01-26   968  				return PTR_ERR(regl->mode);
54129d641cac77 Axel Lin              2019-01-26   969  		}
54129d641cac77 Axel Lin              2019-01-26   970  
54129d641cac77 Axel Lin              2019-01-26   971  		if (regl->info->suspend.reg) {
4068e5182ada26 S Twiss               2015-05-19   972  			regl->suspend = devm_regmap_field_alloc(
4068e5182ada26 S Twiss               2015-05-19   973  					&pdev->dev,
4068e5182ada26 S Twiss               2015-05-19   974  					chip->regmap,
4068e5182ada26 S Twiss               2015-05-19   975  					regl->info->suspend);
54129d641cac77 Axel Lin              2019-01-26   976  			if (IS_ERR(regl->suspend))
54129d641cac77 Axel Lin              2019-01-26   977  				return PTR_ERR(regl->suspend);
54129d641cac77 Axel Lin              2019-01-26   978  		}
54129d641cac77 Axel Lin              2019-01-26   979  
54129d641cac77 Axel Lin              2019-01-26   980  		if (regl->info->sleep.reg) {
4068e5182ada26 S Twiss               2015-05-19   981  			regl->sleep = devm_regmap_field_alloc(
4068e5182ada26 S Twiss               2015-05-19   982  					&pdev->dev,
4068e5182ada26 S Twiss               2015-05-19   983  					chip->regmap,
4068e5182ada26 S Twiss               2015-05-19   984  					regl->info->sleep);
54129d641cac77 Axel Lin              2019-01-26   985  			if (IS_ERR(regl->sleep))
54129d641cac77 Axel Lin              2019-01-26   986  				return PTR_ERR(regl->sleep);
54129d641cac77 Axel Lin              2019-01-26   987  		}
54129d641cac77 Axel Lin              2019-01-26   988  
54129d641cac77 Axel Lin              2019-01-26   989  		if (regl->info->suspend_sleep.reg) {
4068e5182ada26 S Twiss               2015-05-19   990  			regl->suspend_sleep = devm_regmap_field_alloc(
4068e5182ada26 S Twiss               2015-05-19   991  					&pdev->dev,
4068e5182ada26 S Twiss               2015-05-19   992  					chip->regmap,
4068e5182ada26 S Twiss               2015-05-19   993  					regl->info->suspend_sleep);
54129d641cac77 Axel Lin              2019-01-26   994  			if (IS_ERR(regl->suspend_sleep))
54129d641cac77 Axel Lin              2019-01-26   995  				return PTR_ERR(regl->suspend_sleep);
54129d641cac77 Axel Lin              2019-01-26   996  		}
54129d641cac77 Axel Lin              2019-01-26   997  
4068e5182ada26 S Twiss               2015-05-19   998  		/* Register regulator */
4068e5182ada26 S Twiss               2015-05-19   999  		memset(&config, 0, sizeof(config));
4068e5182ada26 S Twiss               2015-05-19  1000  		config.dev = chip->dev;
4068e5182ada26 S Twiss               2015-05-19  1001  		config.driver_data = regl;
4068e5182ada26 S Twiss               2015-05-19  1002  		config.regmap = chip->regmap;
4068e5182ada26 S Twiss               2015-05-19  1003  
4068e5182ada26 S Twiss               2015-05-19  1004  		regl->rdev = devm_regulator_register(&pdev->dev, &regl->desc,
4068e5182ada26 S Twiss               2015-05-19  1005  						     &config);
4068e5182ada26 S Twiss               2015-05-19  1006  		if (IS_ERR(regl->rdev)) {
4068e5182ada26 S Twiss               2015-05-19  1007  			dev_err(&pdev->dev,
4068e5182ada26 S Twiss               2015-05-19  1008  				"Failed to register %s regulator\n",
4068e5182ada26 S Twiss               2015-05-19  1009  				regl->desc.name);
4068e5182ada26 S Twiss               2015-05-19  1010  			return PTR_ERR(regl->rdev);
4068e5182ada26 S Twiss               2015-05-19  1011  		}
4068e5182ada26 S Twiss               2015-05-19  1012  	}
4068e5182ada26 S Twiss               2015-05-19  1013  
4068e5182ada26 S Twiss               2015-05-19  1014  	/* LDOs overcurrent event support */
98b59e5759ae23 Christoph Niedermaier 2023-03-07  1015  	regulators->irq_ldo_lim = platform_get_irq_byname_optional(pdev, "LDO_LIM");
98b59e5759ae23 Christoph Niedermaier 2023-03-07  1016  	if (regulators->irq_ldo_lim < 0)
98b59e5759ae23 Christoph Niedermaier 2023-03-07  1017  		return 0;
4068e5182ada26 S Twiss               2015-05-19  1018  
4068e5182ada26 S Twiss               2015-05-19 @1019  	ret = devm_request_threaded_irq(&pdev->dev, irq,
4068e5182ada26 S Twiss               2015-05-19  1020  					NULL, da9062_ldo_lim_event,
4068e5182ada26 S Twiss               2015-05-19  1021  					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
4068e5182ada26 S Twiss               2015-05-19  1022  					"LDO_LIM", regulators);
4068e5182ada26 S Twiss               2015-05-19  1023  	if (ret) {
4068e5182ada26 S Twiss               2015-05-19  1024  		dev_warn(&pdev->dev,
4068e5182ada26 S Twiss               2015-05-19  1025  			 "Failed to request LDO_LIM IRQ.\n");
4068e5182ada26 S Twiss               2015-05-19  1026  		regulators->irq_ldo_lim = -ENXIO;
4068e5182ada26 S Twiss               2015-05-19  1027  	}
4068e5182ada26 S Twiss               2015-05-19  1028  
4068e5182ada26 S Twiss               2015-05-19  1029  	return 0;
4068e5182ada26 S Twiss               2015-05-19  1030  }
4068e5182ada26 S Twiss               2015-05-19  1031  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
