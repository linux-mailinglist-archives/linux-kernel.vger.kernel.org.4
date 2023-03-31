Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD41D6D1411
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCaAah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCaAaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:30:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ECAF75C;
        Thu, 30 Mar 2023 17:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680222628; x=1711758628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=291iR8fs89AY3P1z/Ojn7EHb26WDXguxsSvangQrPS4=;
  b=ZrWcomVeImflRNd7wbezdICfLICWxVjDmc9LItUAoOaLkRlOYeJBYQO4
   JIZvGjWXjty+5HWKcV2hwDKSXadEWYt4bacTotDS/ivTYEnov+/VJJZMi
   JUqvmBz0Ftt7jti7amwBLf+d1PtcltxiArdRna3Rsft7CNEdxwCTbSrRY
   ZPNV8pb4CjAY1+rqd2pHlf4zdRH/X3NKmM70zs5P2KLSqTRnPUNxwJN9n
   xErJ5HcYH1cxHliwLWXZ8O/wp8Z+7BuFa/TNMPkSPsbLMofd1NpUH28EB
   3QbDCWRLrzhi85KmIu5Ymycz/b+56qb/QBTM4zrCH2lmiIXXD7iUezjjB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="329844024"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="329844024"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 17:30:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="715219715"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="715219715"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2023 17:30:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pi2em-000LLc-2j;
        Fri, 31 Mar 2023 00:30:16 +0000
Date:   Fri, 31 Mar 2023 08:29:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v6 11/12] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Message-ID: <202303310829.6uVozWbB-lkp@intel.com>
References: <20230328021912.177301-12-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328021912.177301-12-ychuang570808@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next linus/master]
[cannot apply to pza/reset/next pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Huang/arm64-Kconfig-platforms-Add-config-for-Nuvoton-MA35-platform/20230328-102245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230328021912.177301-12-ychuang570808%40gmail.com
patch subject: [PATCH v6 11/12] tty: serial: Add Nuvoton ma35d1 serial driver support
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230331/202303310829.6uVozWbB-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/380d83a62e873855024ca4c660865c654a62748a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jacky-Huang/arm64-Kconfig-platforms-Add-config-for-Nuvoton-MA35-platform/20230328-102245
        git checkout 380d83a62e873855024ca4c660865c654a62748a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303310829.6uVozWbB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/ma35d1_serial.c:672:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (pdev->dev.of_node) {
               ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/ma35d1_serial.c:679:27: note: uninitialized use occurs here
           up = &ma35d1serial_ports[ret];
                                    ^~~
   drivers/tty/serial/ma35d1_serial.c:672:2: note: remove the 'if' if its condition is always true
           if (pdev->dev.of_node) {
           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/ma35d1_serial.c:668:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
>> drivers/tty/serial/ma35d1_serial.c:730:6: warning: variable 'i' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (dev->dev.of_node)
               ^~~~~~~~~~~~~~~~
   drivers/tty/serial/ma35d1_serial.c:732:6: note: uninitialized use occurs here
           if (i < 0) {
               ^
   drivers/tty/serial/ma35d1_serial.c:730:2: note: remove the 'if' if its condition is always true
           if (dev->dev.of_node)
           ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/ma35d1_serial.c:727:7: note: initialize the variable 'i' to silence this warning
           int i;
                ^
                 = 0
   drivers/tty/serial/ma35d1_serial.c:750:6: warning: variable 'i' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (dev->dev.of_node)
               ^~~~~~~~~~~~~~~~
   drivers/tty/serial/ma35d1_serial.c:752:6: note: uninitialized use occurs here
           if (i < 0) {
               ^
   drivers/tty/serial/ma35d1_serial.c:750:2: note: remove the 'if' if its condition is always true
           if (dev->dev.of_node)
           ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/ma35d1_serial.c:747:7: note: initialize the variable 'i' to silence this warning
           int i;
                ^
                 = 0
   3 warnings generated.


vim +672 drivers/tty/serial/ma35d1_serial.c

   658	
   659	/*
   660	 * Register a set of serial devices attached to a platform device.
   661	 * The list is terminated with a zero flags entry, which means we expect
   662	 * all entries to have at least UPF_BOOT_AUTOCONF set.
   663	 */
   664	static int ma35d1serial_probe(struct platform_device *pdev)
   665	{
   666		struct resource *res_mem;
   667		struct uart_ma35d1_port *up;
   668		int ret;
   669		struct clk *clk;
   670		int err;
   671	
 > 672		if (pdev->dev.of_node) {
   673			ret = of_alias_get_id(pdev->dev.of_node, "serial");
   674			if (ret < 0) {
   675				dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
   676				return ret;
   677			}
   678		}
   679		up = &ma35d1serial_ports[ret];
   680		up->port.line = ret;
   681		res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   682		if (!res_mem)
   683			return -ENODEV;
   684	
   685		up->port.iobase = res_mem->start;
   686		up->port.membase = ioremap(up->port.iobase, UART_REG_SIZE);
   687		up->port.ops = &ma35d1serial_ops;
   688	
   689		spin_lock_init(&up->port.lock);
   690	
   691		clk = of_clk_get(pdev->dev.of_node, 0);
   692		if (IS_ERR(clk)) {
   693			err = PTR_ERR(clk);
   694			dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
   695			return -ENOENT;
   696		}
   697		err = clk_prepare_enable(clk);
   698		if (err)
   699			return -ENOENT;
   700	
   701		if (up->port.line != 0)
   702			up->port.uartclk = clk_get_rate(clk);
   703		up->port.irq = platform_get_irq(pdev, 0);
   704		up->port.dev = &pdev->dev;
   705		up->port.flags = UPF_BOOT_AUTOCONF;
   706		ret = uart_add_one_port(&ma35d1serial_reg, &up->port);
   707		platform_set_drvdata(pdev, up);
   708		return 0;
   709	}
   710	
   711	/*
   712	 * Remove serial ports registered against a platform device.
   713	 */
   714	static int ma35d1serial_remove(struct platform_device *dev)
   715	{
   716		struct uart_port *port = platform_get_drvdata(dev);
   717	
   718		if (port) {
   719			uart_remove_one_port(&ma35d1serial_reg, port);
   720			free_irq(port->irq, port);
   721		}
   722		return 0;
   723	}
   724	
   725	static int ma35d1serial_suspend(struct platform_device *dev, pm_message_t state)
   726	{
   727		int i;
   728		struct uart_ma35d1_port *up;
   729	
 > 730		if (dev->dev.of_node)
   731			i = of_alias_get_id(dev->dev.of_node, "serial");
   732		if (i < 0) {
   733			dev_err(&dev->dev, "failed to get alias/pdev id, errno %d\n", i);
   734			return i;
   735		}
   736		up = &ma35d1serial_ports[i];
   737		if (i == 0) {
   738			up->console_baud_rate = serial_in(up, UART_REG_BAUD);
   739			up->console_line = serial_in(up, UART_REG_LCR);
   740			up->console_int = serial_in(up, UART_REG_IER);
   741		}
   742		return 0;
   743	}
   744	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
