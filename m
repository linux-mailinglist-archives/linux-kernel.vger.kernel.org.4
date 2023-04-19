Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9D46E71C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjDSDon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDSDoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:44:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BCA4205;
        Tue, 18 Apr 2023 20:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681875873; x=1713411873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4EP/2Cmk9H4XCoBfJIrk4quFOnVhOKLLl6A0ydsMZ54=;
  b=CcVUpJorIz0KqAW9SqUImVys9IxGwlmABWar054LhypHTHiDzXxdUREb
   V3JrIPaxGmPf40Sl6o9Alh12JzPSgZbmSI6JClvMW3dpMBGSOSflrcxqb
   0jZa4usR7Q5tLpDHrjWT4CFjSxPIi5cN1I7oYUUD5Raq5n7lHsRO6jPwb
   rto0REAZ0IKoormM47HRCICjyZX1PsgC9jFk4LCZk5G0szxjzFonfy6wR
   DX8AkB6IqDPvKU5CWLgq/MQpWyefcsXTsacVwSSHZzoJIxkptQIwYOSQL
   yXN3Kw3rqDuFNFL9frsiHjO499b8+ewYoZZfZXgRin5YdRti0LAITjkru
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="408251571"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="408251571"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:44:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="691346028"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="691346028"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2023 20:44:28 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poyk7-000eRb-1Z;
        Wed, 19 Apr 2023 03:44:27 +0000
Date:   Wed, 19 Apr 2023 11:43:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v7 11/12] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Message-ID: <202304191134.r0D17Yjq-lkp@intel.com>
References: <20230412053824.106-12-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412053824.106-12-ychuang570808@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next linus/master pza/reset/next v6.3-rc7]
[cannot apply to pza/imx-drm/next next-20230418]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Huang/arm64-Kconfig-platforms-Add-config-for-Nuvoton-MA35-platform/20230412-134123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230412053824.106-12-ychuang570808%40gmail.com
patch subject: [PATCH v7 11/12] tty: serial: Add Nuvoton ma35d1 serial driver support
config: csky-randconfig-c041-20230419 (https://download.01.org/0day-ci/archive/20230419/202304191134.r0D17Yjq-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7918adf6941fa4fe48d57dffbcc09eee92b88e26
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jacky-Huang/arm64-Kconfig-platforms-Add-config-for-Nuvoton-MA35-platform/20230412-134123
        git checkout 7918adf6941fa4fe48d57dffbcc09eee92b88e26
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304191134.r0D17Yjq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/ma35d1_serial.c:151:64: warning: excess elements in struct initializer
     151 | static struct uart_ma35d1_port ma35d1serial_ports[UART_NR] = { 0 };
         |                                                                ^
   drivers/tty/serial/ma35d1_serial.c:151:64: note: (near initialization for 'ma35d1serial_ports[0].port.lock.<anonymous>.rlock.raw_lock')
   drivers/tty/serial/ma35d1_serial.c:150:28: warning: 'ma35d1serial_uart_nodes' defined but not used [-Wunused-variable]
     150 | static struct device_node *ma35d1serial_uart_nodes[UART_NR];
         |                            ^~~~~~~~~~~~~~~~~~~~~~~


vim +151 drivers/tty/serial/ma35d1_serial.c

   149	
   150	static struct device_node *ma35d1serial_uart_nodes[UART_NR];
 > 151	static struct uart_ma35d1_port ma35d1serial_ports[UART_NR] = { 0 };
   152	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
