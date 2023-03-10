Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6846B32F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCJAz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCJAzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:55:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4229F9ECD;
        Thu,  9 Mar 2023 16:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678409749; x=1709945749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XJDOWmOut4ZXXjw7sNXN4UkiEOpV03u/nwp04SW+1Bc=;
  b=VxENGKlszkbr0YK1BzAuAU7svG3kAu3XrjViF0qcC/qiCDt7ooBqP+DI
   c/7CKNzZPVMx6sLJXXK2dYK+WshyhMai2ai1wAhXrAB66/G3a6uNVwgl9
   AlPL8CCWCOCcJ+WGhKhSLybT5fQSlXkCMjX47sunMKjhZ1XiNorNiieMP
   K6gIBNnQM9AtxpqLIWGm1Ft9n4zv8J5KLjMU231H5yTUKUKjs4JQqZqmL
   bdEXXWZyV1/7h2Xh4urEO8jxYDQN1vfSWKz/rTw7sflSDuaZnioBWnffl
   fs264ZUEEakglvsRJ5r76ofByfYaBibltOo3idX50lGQVbGZla++LIvpF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="324963929"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="324963929"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 16:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="741766393"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="741766393"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2023 16:55:44 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paR2t-0003KN-2t;
        Fri, 10 Mar 2023 00:55:43 +0000
Date:   Fri, 10 Mar 2023 08:55:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <202303100833.lk1UVhcR-lkp@intel.com>
References: <20230309085713.57700-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309085713.57700-1-tony@atomide.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus rafael-pm/linux-next usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.3-rc1 next-20230309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Lindgren/serial-core-Start-managing-serial-controllers-to-enable-runtime-PM/20230309-170149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230309085713.57700-1-tony%40atomide.com
patch subject: [PATCH v6 1/1] serial: core: Start managing serial controllers to enable runtime PM
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230310/202303100833.lk1UVhcR-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/08f76f28e32bcd3c093e4af349b0e1b60328395e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tony-Lindgren/serial-core-Start-managing-serial-controllers-to-enable-runtime-PM/20230309-170149
        git checkout 08f76f28e32bcd3c093e4af349b0e1b60328395e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303100833.lk1UVhcR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/serial_ctrl.c:17:34: warning: unused variable 'serial_ctrl_pm' [-Wunused-const-variable]
   static DEFINE_RUNTIME_DEV_PM_OPS(serial_ctrl_pm, NULL, NULL, NULL);
                                    ^
   1 warning generated.


vim +/serial_ctrl_pm +17 drivers/tty/serial/serial_ctrl.c

    16	
  > 17	static DEFINE_RUNTIME_DEV_PM_OPS(serial_ctrl_pm, NULL, NULL, NULL);
    18	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
