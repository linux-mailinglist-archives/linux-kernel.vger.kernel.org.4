Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E36FE4EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbjEJUQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJUQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:16:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681342D78;
        Wed, 10 May 2023 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683749811; x=1715285811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=guqjaEs52yzd0jfD4I7W7LOAkjHOHGKuo7Jwzw0kwtU=;
  b=bmXpmoUgrYHsZH5/M1lCsfZls2zUmsv3+3RxkjqtPT/X6v9zx+/llwsL
   qeJAj0FY9xAkW/sONi5kjdcdAHGG1eBxI8n9SNdwZKREJWysYKG1uy0uP
   6RMmyGUbORKIncBsOFDx5aiiKxY1C+NudKQT2C2BJTdTd5yOIxj/+HOFu
   dT4RW4U3bUoEBlTm5OPC5V5cUj/uOIBCtDKJuUaKXSf7E3yJ87LMMI21O
   Wbq2UnLCoKeble8L/8sHTGRUWoAePZ3YM7VvJMmPGPsMHt1ivG1/NpRqq
   x1LnTadcBhgk6bRDf7Cv2EM5/lXQ6NqLO9xTb0J/+FQ5/AbAFiMvmc3gW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="339565302"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="339565302"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 13:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="823658226"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="823658226"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 May 2023 13:16:45 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwqEv-0003YK-09;
        Wed, 10 May 2023 20:16:45 +0000
Date:   Thu, 11 May 2023 04:16:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, beanhuo@micron.com,
        nipun.gupta@amd.com, linus.walleij@linaro.org, mwen@igalia.com,
        bvanassche@acm.org, arnd@arndb.de, ogabbay@kernel.org,
        linux@zary.sk, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, yangyicong@hisilicon.com,
        devicetree@vger.kernel.org,
        Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Subject: Re: [PATCHv4 4/4] wiegand: add Wiegand GPIO bitbanged controller
 driver
Message-ID: <202305110450.jjNwIYfp-lkp@intel.com>
References: <20230510162243.95820-5-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510162243.95820-5-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.4-rc1 next-20230510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230511-002708
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230510162243.95820-5-m.zatovic1%40gmail.com
patch subject: [PATCHv4 4/4] wiegand: add Wiegand GPIO bitbanged controller driver
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230511/202305110450.jjNwIYfp-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3eb47f0de6aecc78d72c144b36ccd97f22d908c5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230511-002708
        git checkout 3eb47f0de6aecc78d72c144b36ccd97f22d908c5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305110450.jjNwIYfp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/wiegand/wiegand-gpio.c:70:6: warning: no previous prototype for 'wiegand_gpio_send_bit' [-Wmissing-prototypes]
      70 | void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio, bool value, bool last)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/wiegand/wiegand-gpio.c:111:5: warning: no previous prototype for 'wiegand_gpio_transfer_message' [-Wmissing-prototypes]
     111 | int wiegand_gpio_transfer_message(struct wiegand_controller *ctlr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/wiegand_gpio_send_bit +70 drivers/wiegand/wiegand-gpio.c

    63	
    64	/*
    65	 * To send a bit of value 1 following the wiegand protocol, one must set
    66	 * the wiegand_data_hi to low for the duration of pulse. Similarly to send
    67	 * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
    68	 * This way the two lines are never low at the same time.
    69	 */
  > 70	void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio, bool value, bool last)
    71	{
    72		u32 sleep_len;
    73		u32 pulse_len = wiegand_gpio->ctlr->pulse_len;
    74		u32 interval_len = wiegand_gpio->ctlr->interval_len;
    75		u32 frame_gap = wiegand_gpio->ctlr->frame_gap;
    76		struct gpio_desc *gpio = value ? wiegand_gpio->data1_gpio : wiegand_gpio->data0_gpio;
    77	
    78		gpiod_set_value_cansleep(gpio, 0);
    79		udelay(pulse_len);
    80		gpiod_set_value_cansleep(gpio, 1);
    81	
    82		if (last)
    83			sleep_len = frame_gap - pulse_len;
    84		else
    85			sleep_len = interval_len - pulse_len;
    86	
    87		if (sleep_len < 10)
    88			udelay(sleep_len);
    89		else if (sleep_len < 100)
    90			usleep_range(sleep_len - UP_TO_100_USEC_DEVIATION,
    91				     sleep_len + UP_TO_100_USEC_DEVIATION);
    92		else
    93			usleep_range(sleep_len - MORE_THAN_100_USEC_DEVIATION,
    94				     sleep_len + MORE_THAN_100_USEC_DEVIATION);
    95	}
    96	
    97	static int wiegand_gpio_write_by_bits(struct wiegand_gpio *wiegand_gpio, u16 bitlen)
    98	{
    99		size_t i;
   100		bool bit_value, is_last_bit;
   101	
   102		for (i = 0; i < bitlen; i++) {
   103			bit_value = test_bit(i, wiegand_gpio->ctlr->data_bitmap);
   104			is_last_bit = (i + 1) == bitlen;
   105			wiegand_gpio_send_bit(wiegand_gpio, bit_value, is_last_bit);
   106		}
   107	
   108		return 0;
   109	}
   110	
 > 111	int wiegand_gpio_transfer_message(struct wiegand_controller *ctlr)
   112	{
   113		struct wiegand_gpio *wiegand_gpio = wiegand_primary_get_devdata(ctlr);
   114		u8 msg_bitlen = ctlr->payload_len;
   115	
   116		wiegand_gpio_write_by_bits(wiegand_gpio, msg_bitlen);
   117	
   118		return 0;
   119	}
   120	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
