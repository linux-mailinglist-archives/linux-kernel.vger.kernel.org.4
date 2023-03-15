Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FA26BAC95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjCOJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCOJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:50:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F09365455;
        Wed, 15 Mar 2023 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678873787; x=1710409787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QSWH2oZrN6AG+LRQTmSkhiJhJRLWiR4GmeXcU4sJXws=;
  b=nO+X2Yp8Rg0S3XMDuGd/a1hN0K0WucYhnRO7oquelVhg2hghruYAUL4y
   tPXM3U9gkSLS1DvQ+lfett9TMsgp2A2Kz3T2bKP1F+jsTkV5dqP4zawNp
   lX1+hNHifqhrCtll9pypUUxdmL/e9Am1rVvTD+MUSRoIyYtbD4kC6aI79
   JFSEtkAOxDC4YPEj7fDQKOEmbzvCUsax93cSmi02ogh/LzKHprniG8k9Y
   GoNFwqugTHCjZ5JYGiVSLV88fLDlQer4KH64F43QmDBSxXZ/W6HNZjCB8
   SoP0zr1Mpwd2ZcJLu+akvc6jfhUpw5VGh35IJIhdwqQmYCuZzNK758C4p
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="318053410"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="318053410"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 02:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="853553720"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="853553720"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2023 02:49:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcNlN-0007ay-2v;
        Wed, 15 Mar 2023 09:49:41 +0000
Date:   Wed, 15 Mar 2023 17:48:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH 14/15] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Message-ID: <202303151754.XvPyacT7-lkp@intel.com>
References: <20230315072902.9298-15-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315072902.9298-15-ychuang570808@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next tty/tty-testing tty/tty-next tty/tty-linus linus/master v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Huang/arm64-Kconfig-platforms-Add-config-for-Nuvoton-MA35-platform/20230315-153355
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230315072902.9298-15-ychuang570808%40gmail.com
patch subject: [PATCH 14/15] tty: serial: Add Nuvoton ma35d1 serial driver support
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230315/202303151754.XvPyacT7-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/064028d2f2d911398012103aef3ce8666342ddfc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jacky-Huang/arm64-Kconfig-platforms-Add-config-for-Nuvoton-MA35-platform/20230315-153355
        git checkout 064028d2f2d911398012103aef3ce8666342ddfc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303151754.XvPyacT7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/ma35d1_serial.c:672:6: warning: no previous prototype for 'ma35d1serial_suspend_port' [-Wmissing-prototypes]
     672 | void ma35d1serial_suspend_port(int line)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/ma35d1_serial.c:681:6: warning: no previous prototype for 'ma35d1serial_resume_port' [-Wmissing-prototypes]
     681 | void ma35d1serial_resume_port(int line)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/tty/serial/ma35d1_serial.c:670: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    *  Suspend one serial port.
   drivers/tty/serial/ma35d1_serial.c:679: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    *  Resume one serial port.


vim +/ma35d1serial_suspend_port +672 drivers/tty/serial/ma35d1_serial.c

   668	
   669	/**
 > 670	 *  Suspend one serial port.
   671	 */
 > 672	void ma35d1serial_suspend_port(int line)
   673	{
   674		uart_suspend_port(&ma35d1serial_reg, &ma35d1serial_ports[line].port);
   675	}
   676	EXPORT_SYMBOL(ma35d1serial_suspend_port);
   677	
   678	/**
   679	 *  Resume one serial port.
   680	 */
 > 681	void ma35d1serial_resume_port(int line)
   682	{
   683		struct uart_ma35d1_port *up = &ma35d1serial_ports[line];
   684	
   685		uart_resume_port(&ma35d1serial_reg, &up->port);
   686	}
   687	EXPORT_SYMBOL(ma35d1serial_resume_port);
   688	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
