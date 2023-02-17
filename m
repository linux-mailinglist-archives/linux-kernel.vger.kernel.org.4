Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3DD69B46E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBQVMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQVMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:12:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B45DE35;
        Fri, 17 Feb 2023 13:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676668358; x=1708204358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vVOC50k+elFfOk8KDTPGK7o6CIxERD5MbuPu66bNn5A=;
  b=RkqCGWw5wpW8RlQ48Pvf2qtJkFlq4bBcuPe6Uij9MKlGOdpXIffObcX3
   Sb0RnFA41kt/TeZmjDaCn5Ad1DAGppNSEELzncNS/rLrrWEvmYijIUalx
   sG/BuCEjR16PzcKkUQMPgNiwPUYNJxoKbKfTH+juZJC9qW4TvV9ZjZnTk
   l56swbo7UIXW/NOgAgM8wwjRtu2Ehq+NevqCGsHlXoZgTgaWx6GoRUqGc
   3UylA+Ilg1mBCfSXUSmoxAnU2SkLEz/ebt/wtQu+0KbRkxn+/1Rud4JYc
   x9vYCeSCU1jXFSVQmVmAvZEC6CMiSUyhrG4teKi/kGvfnMy8DWRgLZQ9Y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="311719403"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="311719403"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="739382937"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="739382937"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Feb 2023 13:12:35 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pT81y-000BpH-0j;
        Fri, 17 Feb 2023 21:12:34 +0000
Date:   Sat, 18 Feb 2023 05:12:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Angelo Compagnucci <angelo@amarulasolutions.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] misc: servo-pwm: driver for controlling servo
 motors via PWM
Message-ID: <202302180429.NvI1mwuf-lkp@intel.com>
References: <20230217161038.3130053-1-angelo@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217161038.3130053-1-angelo@amarulasolutions.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-linus]
[also build test WARNING on linus/master v6.2-rc8]
[cannot apply to char-misc/char-misc-testing char-misc/char-misc-next next-20230217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Angelo-Compagnucci/misc-servo-pwm-Add-sysfs-entries-to-control-motor-angle/20230218-001254
patch link:    https://lore.kernel.org/r/20230217161038.3130053-1-angelo%40amarulasolutions.com
patch subject: [PATCH v3 1/3] misc: servo-pwm: driver for controlling servo motors via PWM
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230218/202302180429.NvI1mwuf-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0ae16e16da0aa94de0d3ae63166f50a4a6fdef8a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angelo-Compagnucci/misc-servo-pwm-Add-sysfs-entries-to-control-motor-angle/20230218-001254
        git checkout 0ae16e16da0aa94de0d3ae63166f50a4a6fdef8a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302180429.NvI1mwuf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/mm_types_task.h:16,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/misc/servo-pwm.c:7:
   drivers/misc/servo-pwm.c: In function 'angle_show':
>> arch/loongarch/include/asm/page.h:23:25: warning: passing argument 2 of 'sysfs_emit' makes pointer from integer without a cast [-Wint-conversion]
      23 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         long unsigned int
   drivers/misc/servo-pwm.c:54:32: note: in expansion of macro 'PAGE_SIZE'
      54 |         return sysfs_emit(buf, PAGE_SIZE, "%u\n", data->angle);
         |                                ^~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/module.h:21:
   include/linux/sysfs.h:357:39: note: expected 'const char *' but argument is of type 'long unsigned int'
     357 | int sysfs_emit(char *buf, const char *fmt, ...);
         |                           ~~~~~~~~~~~~^~~
   drivers/misc/servo-pwm.c: In function 'degrees_show':
>> arch/loongarch/include/asm/page.h:23:25: warning: passing argument 2 of 'sysfs_emit' makes pointer from integer without a cast [-Wint-conversion]
      23 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         long unsigned int
   drivers/misc/servo-pwm.c:84:32: note: in expansion of macro 'PAGE_SIZE'
      84 |         return sysfs_emit(buf, PAGE_SIZE, "%u\n", data->degrees);
         |                                ^~~~~~~~~
   include/linux/sysfs.h:357:39: note: expected 'const char *' but argument is of type 'long unsigned int'
     357 | int sysfs_emit(char *buf, const char *fmt, ...);
         |                           ~~~~~~~~~~~~^~~


vim +/sysfs_emit +23 arch/loongarch/include/asm/page.h

09cfefb7fa70c3 Huacai Chen 2022-05-31  10  
09cfefb7fa70c3 Huacai Chen 2022-05-31  11  /*
09cfefb7fa70c3 Huacai Chen 2022-05-31  12   * PAGE_SHIFT determines the page size
09cfefb7fa70c3 Huacai Chen 2022-05-31  13   */
09cfefb7fa70c3 Huacai Chen 2022-05-31  14  #ifdef CONFIG_PAGE_SIZE_4KB
09cfefb7fa70c3 Huacai Chen 2022-05-31  15  #define PAGE_SHIFT	12
09cfefb7fa70c3 Huacai Chen 2022-05-31  16  #endif
09cfefb7fa70c3 Huacai Chen 2022-05-31  17  #ifdef CONFIG_PAGE_SIZE_16KB
09cfefb7fa70c3 Huacai Chen 2022-05-31  18  #define PAGE_SHIFT	14
09cfefb7fa70c3 Huacai Chen 2022-05-31  19  #endif
09cfefb7fa70c3 Huacai Chen 2022-05-31  20  #ifdef CONFIG_PAGE_SIZE_64KB
09cfefb7fa70c3 Huacai Chen 2022-05-31  21  #define PAGE_SHIFT	16
09cfefb7fa70c3 Huacai Chen 2022-05-31  22  #endif
09cfefb7fa70c3 Huacai Chen 2022-05-31 @23  #define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
09cfefb7fa70c3 Huacai Chen 2022-05-31  24  #define PAGE_MASK	(~(PAGE_SIZE - 1))
09cfefb7fa70c3 Huacai Chen 2022-05-31  25  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
