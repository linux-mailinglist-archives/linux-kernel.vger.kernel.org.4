Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F29728304
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbjFHOto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbjFHOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:49:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648412D53;
        Thu,  8 Jun 2023 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686235779; x=1717771779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dUrdRDInHI5IdT+z31/GWwoL1bHY8ozfictJiZNzPeE=;
  b=cfVPKE9Jr+ePP44oulbyARYb/yofkXGgjK89OPR2olmmi/FPO8nxpXds
   WRoA0n/d/EEKreRTVbj0ZYxAyfo7S7hjW3Le30LR9EJ7rbARfYIZV4/I3
   wekNU6uCdg+mK706H4kY9bCIvfv/ZFKofEMl3n1qDd4A0MCx15UnPX1Az
   Fh+YpNZWVYo1g9BAaOyPWNU2k62vElDPQXJ5aQtG/s1ajxJP3Xx4PwXhz
   J13pvaYA2EN9AaFRGW86rZiPUV3EjMzqLh3HxikRJOfDwiMXHXIMuhRB/
   MFTcccnkhscidOtt/n5CElh7Ylk/RT8ScGZok91Ap6dsn1CA1Sji4eXq3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="360673648"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="360673648"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 07:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713141075"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="713141075"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2023 07:49:20 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7Gwx-0007vw-1J;
        Thu, 08 Jun 2023 14:49:19 +0000
Date:   Thu, 8 Jun 2023 22:48:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrej Picej <andrej.picej@norik.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@phytec.de
Subject: Re: [PATCH] rtc: rv3028: Improve trickle charger logic
Message-ID: <202306082225.gJGvLhg6-lkp@intel.com>
References: <20230608090446.2899646-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608090446.2899646-1-andrej.picej@norik.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on linus/master v6.4-rc5 next-20230608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrej-Picej/rtc-rv3028-Improve-trickle-charger-logic/20230608-190234
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20230608090446.2899646-1-andrej.picej%40norik.com
patch subject: [PATCH] rtc: rv3028: Improve trickle charger logic
config: x86_64-randconfig-x062-20230608 (https://download.01.org/0day-ci/archive/20230608/202306082225.gJGvLhg6-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add abelloni https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
        git fetch abelloni rtc-next
        git checkout abelloni/rtc-next
        b4 shazam https://lore.kernel.org/r/20230608090446.2899646-1-andrej.picej@norik.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/rtc/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306082225.gJGvLhg6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/rtc/rtc-rv3028.c:959:7: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/rtc/rtc-rv3028.c:968:17: note: uninitialized use occurs here
           if (val_old != val) {
                          ^~~
   drivers/rtc/rtc-rv3028.c:959:3: note: remove the 'if' if its condition is always true
                   if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/rtc/rtc-rv3028.c:863:18: note: initialize the variable 'val' to silence this warning
           int val_old, val;
                           ^
                            = 0
   1 warning generated.


vim +959 drivers/rtc/rtc-rv3028.c

e6e7376cfd7b3f Alexandre Belloni   2019-02-13  857  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  858  static int rv3028_probe(struct i2c_client *client)
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  859  {
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  860  	struct rv3028_data *rv3028;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  861  	int ret, status;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  862  	u32 ohms;
7982492c6d02c7 Andrej Picej        2023-06-08  863  	int val_old, val;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  864  	struct nvmem_config nvmem_cfg = {
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  865  		.name = "rv3028_nvram",
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  866  		.word_size = 1,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  867  		.stride = 1,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  868  		.size = 2,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  869  		.type = NVMEM_TYPE_BATTERY_BACKED,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  870  		.reg_read = rv3028_nvram_read,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  871  		.reg_write = rv3028_nvram_write,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  872  	};
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  873  	struct nvmem_config eeprom_cfg = {
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  874  		.name = "rv3028_eeprom",
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  875  		.word_size = 1,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  876  		.stride = 1,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  877  		.size = 43,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  878  		.type = NVMEM_TYPE_EEPROM,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  879  		.reg_read = rv3028_eeprom_read,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  880  		.reg_write = rv3028_eeprom_write,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  881  	};
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  882  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  883  	rv3028 = devm_kzalloc(&client->dev, sizeof(struct rv3028_data),
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  884  			      GFP_KERNEL);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  885  	if (!rv3028)
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  886  		return -ENOMEM;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  887  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  888  	rv3028->regmap = devm_regmap_init_i2c(client, &regmap_config);
c3b29bf6f166f6 Chuhong Yuan        2020-05-28  889  	if (IS_ERR(rv3028->regmap))
c3b29bf6f166f6 Chuhong Yuan        2020-05-28  890  		return PTR_ERR(rv3028->regmap);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  891  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  892  	i2c_set_clientdata(client, rv3028);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  893  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  894  	ret = regmap_read(rv3028->regmap, RV3028_STATUS, &status);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  895  	if (ret < 0)
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  896  		return ret;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  897  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  898  	if (status & RV3028_STATUS_AF)
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  899  		dev_warn(&client->dev, "An alarm may have been missed.\n");
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  900  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  901  	rv3028->rtc = devm_rtc_allocate_device(&client->dev);
44c638ce4ec6fb Alexandre Belloni   2019-08-19  902  	if (IS_ERR(rv3028->rtc))
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  903  		return PTR_ERR(rv3028->rtc);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  904  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  905  	if (client->irq > 0) {
16b26f6027588b Wadim Egorov        2022-12-08  906  		unsigned long flags;
16b26f6027588b Wadim Egorov        2022-12-08  907  
16b26f6027588b Wadim Egorov        2022-12-08  908  		/*
16b26f6027588b Wadim Egorov        2022-12-08  909  		 * If flags = 0, devm_request_threaded_irq() will use IRQ flags
16b26f6027588b Wadim Egorov        2022-12-08  910  		 * obtained from device tree.
16b26f6027588b Wadim Egorov        2022-12-08  911  		 */
16b26f6027588b Wadim Egorov        2022-12-08  912  		if (dev_fwnode(&client->dev))
16b26f6027588b Wadim Egorov        2022-12-08  913  			flags = 0;
16b26f6027588b Wadim Egorov        2022-12-08  914  		else
16b26f6027588b Wadim Egorov        2022-12-08  915  			flags = IRQF_TRIGGER_LOW;
16b26f6027588b Wadim Egorov        2022-12-08  916  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  917  		ret = devm_request_threaded_irq(&client->dev, client->irq,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  918  						NULL, rv3028_handle_irq,
16b26f6027588b Wadim Egorov        2022-12-08  919  						flags | IRQF_ONESHOT,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  920  						"rv3028", rv3028);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  921  		if (ret) {
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  922  			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  923  			client->irq = 0;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  924  		}
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  925  	}
0f7695691be617 Alexandre Belloni   2021-01-11  926  	if (!client->irq)
0f7695691be617 Alexandre Belloni   2021-01-11  927  		clear_bit(RTC_FEATURE_ALARM, rv3028->rtc->features);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  928  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  929  	ret = regmap_update_bits(rv3028->regmap, RV3028_CTRL1,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  930  				 RV3028_CTRL1_WADA, RV3028_CTRL1_WADA);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  931  	if (ret)
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  932  		return ret;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  933  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  934  	/* setup timestamping */
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  935  	ret = regmap_update_bits(rv3028->regmap, RV3028_CTRL2,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  936  				 RV3028_CTRL2_EIE | RV3028_CTRL2_TSE,
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  937  				 RV3028_CTRL2_EIE | RV3028_CTRL2_TSE);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  938  	if (ret)
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  939  		return ret;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  940  
7982492c6d02c7 Andrej Picej        2023-06-08  941  	ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);
7982492c6d02c7 Andrej Picej        2023-06-08  942  	if (ret < 0)
7982492c6d02c7 Andrej Picej        2023-06-08  943  		return ret;
7982492c6d02c7 Andrej Picej        2023-06-08  944  
7982492c6d02c7 Andrej Picej        2023-06-08  945  	/* mask out only trickle charger bits */
7982492c6d02c7 Andrej Picej        2023-06-08  946  	val_old = val_old & (RV3028_BACKUP_TCE | RV3028_BACKUP_TCR_MASK);
7982492c6d02c7 Andrej Picej        2023-06-08  947  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  948  	/* setup trickle charger */
7982492c6d02c7 Andrej Picej        2023-06-08  949  	if (device_property_read_u32(&client->dev, "trickle-resistor-ohms", &ohms)) {
7982492c6d02c7 Andrej Picej        2023-06-08  950  		/* disable the trickle charger */
7982492c6d02c7 Andrej Picej        2023-06-08  951  		val = 0;
7982492c6d02c7 Andrej Picej        2023-06-08  952  	} else {
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  953  		int i;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  954  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  955  		for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  956  			if (ohms == rv3028_trickle_resistors[i])
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  957  				break;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  958  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13 @959  		if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
7982492c6d02c7 Andrej Picej        2023-06-08  960  			/* enable the trickle charger and setup its resistor accordingly */
7982492c6d02c7 Andrej Picej        2023-06-08  961  			val = RV3028_BACKUP_TCE | i;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  962  		} else {
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  963  			dev_warn(&client->dev, "invalid trickle resistor value\n");
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  964  		}
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  965  	}
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  966  
7982492c6d02c7 Andrej Picej        2023-06-08  967  	/* only update EEPROM if changes are necessary */
7982492c6d02c7 Andrej Picej        2023-06-08  968  	if (val_old != val) {
7982492c6d02c7 Andrej Picej        2023-06-08  969  		ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_TCE |
7982492c6d02c7 Andrej Picej        2023-06-08  970  					RV3028_BACKUP_TCR_MASK, val);
7982492c6d02c7 Andrej Picej        2023-06-08  971  		if (ret)
7982492c6d02c7 Andrej Picej        2023-06-08  972  			return ret;
7982492c6d02c7 Andrej Picej        2023-06-08  973  	}
7982492c6d02c7 Andrej Picej        2023-06-08  974  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  975  	ret = rtc_add_group(rv3028->rtc, &rv3028_attr_group);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  976  	if (ret)
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  977  		return ret;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  978  
018d959ba7ffca Alexandre Belloni   2021-10-18  979  	set_bit(RTC_FEATURE_BACKUP_SWITCH_MODE, rv3028->rtc->features);
018d959ba7ffca Alexandre Belloni   2021-10-18  980  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  981  	rv3028->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  982  	rv3028->rtc->range_max = RTC_TIMESTAMP_END_2099;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  983  	rv3028->rtc->ops = &rv3028_rtc_ops;
fdcfd854333be5 Bartosz Golaszewski 2020-11-09  984  	ret = devm_rtc_register_device(rv3028->rtc);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  985  	if (ret)
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  986  		return ret;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  987  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  988  	nvmem_cfg.priv = rv3028->regmap;
3a905c2d9544a4 Bartosz Golaszewski 2020-11-09  989  	devm_rtc_nvmem_register(rv3028->rtc, &nvmem_cfg);
de0ad60e79e1ce Alexandre Belloni   2020-10-09  990  	eeprom_cfg.priv = rv3028;
3a905c2d9544a4 Bartosz Golaszewski 2020-11-09  991  	devm_rtc_nvmem_register(rv3028->rtc, &eeprom_cfg);
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  992  
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  993  	rv3028->rtc->max_user_freq = 1;
e6e7376cfd7b3f Alexandre Belloni   2019-02-13  994  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
