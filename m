Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1DA6C06CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjCTASh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTAS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:18:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A663595;
        Sun, 19 Mar 2023 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679271507; x=1710807507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e3HufBj/e2539/UBn9UWFanSavsSHKjv1uia5sCwpns=;
  b=QJ72GKzoq3lzCRSbB0MQy4YRbUHnaFKakFEldexuWJplKbC2XNHORgBt
   J89pyBmq5EMSQkvUASpZrkqcXlmNw2UfaWn7pp65XsAy0t+hFUjMGv/AT
   NPfov6S174ohp0fKkOloxMORK47RY1hIrod1eg8zhaiirq0Yc1yNqhiKt
   kyqIU6kXblQzORKWmuFUmQUpWIMw0z/c9+brlj7ikR36oKKSPw+5rVRGv
   bEfJZZNTzTsuvHpFIjPaAKNNqv5pqT7+8sR/47EWeFzD0f11ncTsVfvqw
   6EGaJeDLS4j/ZpU8ja2cROUf4UbfqEI66eDj0f8HrZaBs4df8iSule9bT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="340909770"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="340909770"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 17:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="745173878"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="745173878"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Mar 2023 17:18:24 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pe3EG-000AiQ-0m;
        Mon, 20 Mar 2023 00:18:24 +0000
Date:   Mon, 20 Mar 2023 08:18:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: Re: [PATCH v2 1/2] gpio: 104-dio-48e: Implement struct dio48e_gpio
Message-ID: <202303200807.f6XwZEfR-lkp@intel.com>
References: <296c8d808a4a9753ae3aa66d04b746c52df6b8ae.1679259085.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <296c8d808a4a9753ae3aa66d04b746c52df6b8ae.1679259085.git.william.gray@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

I love your patch! Yet something to improve:

[auto build test ERROR on 03810031c91dfe448cd116ee987d5dc4139006f4]

url:    https://github.com/intel-lab-lkp/linux/commits/William-Breathitt-Gray/gpio-104-dio-48e-Implement-struct-dio48e_gpio/20230320-050433
base:   03810031c91dfe448cd116ee987d5dc4139006f4
patch link:    https://lore.kernel.org/r/296c8d808a4a9753ae3aa66d04b746c52df6b8ae.1679259085.git.william.gray%40linaro.org
patch subject: [PATCH v2 1/2] gpio: 104-dio-48e: Implement struct dio48e_gpio
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230320/202303200807.f6XwZEfR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/844453d513d06fbc8fbfe14ecff74b3bc3a92bbb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review William-Breathitt-Gray/gpio-104-dio-48e-Implement-struct-dio48e_gpio/20230320-050433
        git checkout 844453d513d06fbc8fbfe14ecff74b3bc3a92bbb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303200807.f6XwZEfR-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-104-dio-48e.c: In function 'dio48e_handle_mask_sync':
>> drivers/gpio/gpio-104-dio-48e.c:120:30: error: 'map' redeclared as different kind of symbol
     120 |         struct regmap *const map = dio48egpio->map;
         |                              ^~~
   drivers/gpio/gpio-104-dio-48e.c:112:57: note: previous definition of 'map' with type 'struct regmap * const'
     112 | static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
         |                                    ~~~~~~~~~~~~~~~~~~~~~^~~


vim +/map +120 drivers/gpio/gpio-104-dio-48e.c

   111	
   112	static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
   113					   const unsigned int mask_buf_def,
   114					   const unsigned int mask_buf,
   115					   void *const irq_drv_data)
   116	{
   117		struct dio48e_gpio *const dio48egpio = irq_drv_data;
   118		const unsigned int prev_mask = dio48egpio->irq_mask;
   119		int err;
 > 120		struct regmap *const map = dio48egpio->map;
   121		unsigned int val;
   122	
   123		/* exit early if no change since the previous mask */
   124		if (mask_buf == prev_mask)
   125			return 0;
   126	
   127		/* remember the current mask for the next mask sync */
   128		dio48egpio->irq_mask = mask_buf;
   129	
   130		/* if all previously masked, enable interrupts when unmasking */
   131		if (prev_mask == mask_buf_def) {
   132			err = regmap_write(map, DIO48E_CLEAR_INTERRUPT, 0x00);
   133			if (err)
   134				return err;
   135			return regmap_write(map, DIO48E_ENABLE_INTERRUPT, 0x00);
   136		}
   137	
   138		/* if all are currently masked, disable interrupts */
   139		if (mask_buf == mask_buf_def)
   140			return regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
   141	
   142		return 0;
   143	}
   144	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
