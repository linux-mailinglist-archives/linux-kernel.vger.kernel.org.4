Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459F96FBB50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjEHXNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjEHXNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:13:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8406249FE;
        Mon,  8 May 2023 16:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683587630; x=1715123630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UpsSTff8/0ZXEy+QYlfFYcdPyMTh1FDGgu5tOGHwm04=;
  b=KvguI4bktPpyYQuKGuMO3HJJQ4z5GOEy6n5udFyl6S8YCz//4YKnqrdX
   kThhm+btaG1KFbw9PjukUzBf4RCEEfCzoIVt6T8fAKPDaaHxfzkQV3iKY
   tdpNj1sl9/viNGZsP9AE+HrRvBcEY4YsInuV0VE4Zi01EH+K7lcwi5pOI
   KS4R68Uf3bNsFJ/sYYCyzf7HM+eNouswoRAGlcNwVZYNkrXFycdw4a+3T
   evk2kWHkci2Hh4185evYnDACEH+ohKD0YABHNcO0VelsN1VaP07mshsKH
   8Mh6LsKJkEhmzoTnSDa9RugSDsmHDTUlIRbdkWma3umzJtBdFeZ9Nj/Yh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="351937836"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="351937836"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 16:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="788295124"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="788295124"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 May 2023 16:13:46 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwA37-0001SX-09;
        Mon, 08 May 2023 23:13:45 +0000
Date:   Tue, 9 May 2023 07:13:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v10 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <202305090752.w4XZxmsN-lkp@intel.com>
References: <20230508110339.38699-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508110339.38699-1-tony@atomide.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.4-rc1 next-20230508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Lindgren/serial-core-Start-managing-serial-controllers-to-enable-runtime-PM/20230508-190805
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230508110339.38699-1-tony%40atomide.com
patch subject: [PATCH v10 1/1] serial: core: Start managing serial controllers to enable runtime PM
config: x86_64-randconfig-a001-20230508 (https://download.01.org/0day-ci/archive/20230509/202305090752.w4XZxmsN-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2f298f9dbe3a1d9550e1f15bb1415aeaf9ce4311
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tony-Lindgren/serial-core-Start-managing-serial-controllers-to-enable-runtime-PM/20230508-190805
        git checkout 2f298f9dbe3a1d9550e1f15bb1415aeaf9ce4311
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305090752.w4XZxmsN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/serial_base_bus.c:97:13: warning: variable 'id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           } else if (type == &serial_port_type) {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/serial_base_bus.c:102:77: note: uninitialized use occurs here
           err = dev_set_name(&sbd->dev, "%s.%s.%d", type->name, dev_name(port->dev), id);
                                                                                      ^~
   drivers/tty/serial/serial_base_bus.c:97:9: note: remove the 'if' if its condition is always true
           } else if (type == &serial_port_type) {
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/serial_base_bus.c:83:13: note: initialize the variable 'id' to silence this warning
           int err, id;
                      ^
                       = 0
   1 warning generated.


vim +97 drivers/tty/serial/serial_base_bus.c

    77	
    78	static struct device *serial_base_device_add(struct uart_port *port,
    79						     struct device *parent_dev,
    80						     const struct device_type *type)
    81	{
    82		struct serial_base_device *sbd;
    83		int err, id;
    84	
    85		sbd = kzalloc(sizeof(*sbd), GFP_KERNEL);
    86		if (!sbd)
    87			return NULL;
    88	
    89		device_initialize(&sbd->dev);
    90		sbd->dev.type = type;
    91		sbd->dev.parent = parent_dev;
    92		sbd->dev.bus = &serial_base_bus_type;
    93		sbd->dev.release = &serial_base_release;
    94	
    95		if (type == &serial_ctrl_type) {
    96			id = port->ctrl_id;
  > 97		} else if (type == &serial_port_type) {
    98			id = port->line;
    99			sbd->port = port;
   100		}
   101	
   102		err = dev_set_name(&sbd->dev, "%s.%s.%d", type->name, dev_name(port->dev), id);
   103		if (err)
   104			goto err_free_dev;
   105	
   106		err = device_add(&sbd->dev);
   107		if (err)
   108			goto err_put_device;
   109	
   110		return &sbd->dev;
   111	
   112	err_put_device:
   113		put_device(&sbd->dev);
   114	
   115	err_free_dev:
   116		kfree(sbd);
   117	
   118		return NULL;
   119	}
   120	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
