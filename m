Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5F3673678
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjASLO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjASLOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:14:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A42B7494D;
        Thu, 19 Jan 2023 03:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674126831; x=1705662831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O9Ppel+iepCFWa6otaPpGVfa9DVKCGM/plTA65MWvdg=;
  b=fr+UZ78W0BxpRGn55hsZauF9EisInUU9bGVB+z/LVmV/yWy0SNXT+UqB
   F42ce4VWf+2uHWG494QoISJuTE8P3fgfXH72fqbSLUIJXfjl3bLFjK5Xl
   YoDLe3MsS+4jwd1muENb8KMydJu7lQLsRaG9L9OmQ+XSejT0hyDP9HLJa
   BFoI8f5Io/eOCcjh5l0lCtzbbe/cnRzRtBr5S3vGM/ZBDZdTq69XSWnI/
   OrjLZOH+AnK1eK16reS5OCy0fGEe7OnHZHE1wvQGRMF+9wNQFl0nWD1vL
   8edcTfAmhg3baZ9/NTCnh1X6/xa5gGXalVGFGITVhgE1UV9cf11d2vPT8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="326518923"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="326518923"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 03:13:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="768183528"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="768183528"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2023 03:13:47 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pISrb-0001P2-00;
        Thu, 19 Jan 2023 11:13:47 +0000
Date:   Thu, 19 Jan 2023 19:13:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: Re: [PATCH 2/2] clk: loongson1: Refactor to add devicetree support
Message-ID: <202301191914.Rs7JrOPY-lkp@intel.com>
References: <20230113110738.1505973-3-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113110738.1505973-3-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keguang,

I love your patch! Yet something to improve:

[auto build test ERROR on 1b929c02afd37871d5afb9d498426f83432e71c2]

url:    https://github.com/intel-lab-lkp/linux/commits/Keguang-Zhang/dt-bindings-clock-Add-binding-for-Loongson-1-clock-driver/20230113-192017
base:   1b929c02afd37871d5afb9d498426f83432e71c2
patch link:    https://lore.kernel.org/r/20230113110738.1505973-3-keguang.zhang%40gmail.com
patch subject: [PATCH 2/2] clk: loongson1: Refactor to add devicetree support
config: mips-loongson1b_defconfig (https://download.01.org/0day-ci/archive/20230119/202301191914.Rs7JrOPY-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b753dca857d9c85e25ba410fe013b78c7c73ca40
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Keguang-Zhang/dt-bindings-clock-Add-binding-for-Loongson-1-clock-driver/20230113-192017
        git checkout b753dca857d9c85e25ba410fe013b78c7c73ca40
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/clk/clk-loongson1.c:115:23: warning: no previous prototype for 'ls1x_clk_hw_register_pll' [-Wmissing-prototypes]
     115 | struct clk_hw *__init ls1x_clk_hw_register_pll(struct device *dev,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-loongson1.c: In function 'ls1x_divider_set_rate':
>> drivers/clk/clk-loongson1.c:186:13: warning: the comparison will always evaluate as 'true' for the address of 'lock' will never be NULL [-Waddress]
     186 |         if (&divider->lock)
         |             ^
   drivers/clk/clk-loongson1.c:28:20: note: 'lock' declared here
      28 |         spinlock_t lock;        /* protect access to DIV registers */
         |                    ^~~~
   drivers/clk/clk-loongson1.c:212:13: warning: the comparison will always evaluate as 'true' for the address of 'lock' will never be NULL [-Waddress]
     212 |         if (&divider->lock)
         |             ^
   drivers/clk/clk-loongson1.c:28:20: note: 'lock' declared here
      28 |         spinlock_t lock;        /* protect access to DIV registers */
         |                    ^~~~
   drivers/clk/clk-loongson1.c: At top level:
>> drivers/clk/clk-loongson1.c:226:23: warning: no previous prototype for 'ls1x_clk_hw_register_divider' [-Wmissing-prototypes]
     226 | struct clk_hw *__init ls1x_clk_hw_register_divider(struct device *dev,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-loongson1.c:310:34: warning: 'ls1x_divider_match' defined but not used [-Wunused-const-variable=]
     310 | static const struct of_device_id ls1x_divider_match[] __initconst = {
         |                                  ^~~~~~~~~~~~~~~~~~
   drivers/clk/clk-loongson1.c:275:34: warning: 'ls1x_pll_match' defined but not used [-Wunused-const-variable=]
     275 | static const struct of_device_id ls1x_pll_match[] __initconst = {
         |                                  ^~~~~~~~~~~~~~
--
   mipsel-linux-ld: arch/mips/loongson32/common/time.o: in function `plat_time_init':
>> time.c:(.init.text+0x8): undefined reference to `ls1x_clk_init'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
