Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ADA69B4A7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBQVXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBQVXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:23:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678CE5FC43;
        Fri, 17 Feb 2023 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676669018; x=1708205018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IPDsSYts/oay4zEx91XugvXxVSbVWEV9RvErzYSgy2U=;
  b=Bw7dbchvPLK7ZHJh/VxdQlDt6n68rnqd0swGj2cOfL+swxVcCQ0tQ7C3
   8LRZraAbQ34YSezzbrzl5lBQ7j+hiNOaopRFxAfv5BEAVTe/0/XmBLKg0
   YCop4hFIpgRRNUlDKmMPy1Olw9xPn+2a3urRjSOHrl0qOmQOzlx1pUat0
   4Qb+bdQJ9SwltqEOhwVrtErt1ijB2RUAKSM2q32yX/z4wNcU6/ySWqsn9
   CWsGoO6da+6bW0JaeoeUGeGveKMqZaY+3E0Gplp1MOgEtj/2KQF/qVKBT
   5KrzuZXZAflDoWDsN/LvObY9vxzJagLu9S2cx2fyvTI6A3kQzzVtLWRRQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="312459571"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="312459571"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="779916947"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="779916947"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Feb 2023 13:23:35 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pT8Cc-000BpZ-11;
        Fri, 17 Feb 2023 21:23:34 +0000
Date:   Sat, 18 Feb 2023 05:22:42 +0800
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
Message-ID: <202302180513.AlOeQWNt-lkp@intel.com>
References: <20230217161038.3130053-1-angelo@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217161038.3130053-1-angelo@amarulasolutions.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230218/202302180513.AlOeQWNt-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0ae16e16da0aa94de0d3ae63166f50a4a6fdef8a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angelo-Compagnucci/misc-servo-pwm-Add-sysfs-entries-to-control-motor-angle/20230218-001254
        git checkout 0ae16e16da0aa94de0d3ae63166f50a4a6fdef8a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302180513.AlOeQWNt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/page.h:8,
                    from arch/sparc/include/asm/sparsemem.h:7,
                    from include/linux/numa.h:25,
                    from include/linux/cpumask.h:16,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/misc/servo-pwm.c:7:
   drivers/misc/servo-pwm.c: In function 'angle_show':
>> arch/sparc/include/asm/page_64.h:9:22: warning: passing argument 2 of 'sysfs_emit' makes pointer from integer without a cast [-Wint-conversion]
       9 | #define PAGE_SIZE    (_AC(1,UL) << PAGE_SHIFT)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                      |
         |                      long unsigned int
   drivers/misc/servo-pwm.c:54:32: note: in expansion of macro 'PAGE_SIZE'
      54 |         return sysfs_emit(buf, PAGE_SIZE, "%u\n", data->angle);
         |                                ^~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/module.h:21:
   include/linux/sysfs.h:357:39: note: expected 'const char *' but argument is of type 'long unsigned int'
     357 | int sysfs_emit(char *buf, const char *fmt, ...);
         |                           ~~~~~~~~~~~~^~~
   drivers/misc/servo-pwm.c: In function 'degrees_show':
>> arch/sparc/include/asm/page_64.h:9:22: warning: passing argument 2 of 'sysfs_emit' makes pointer from integer without a cast [-Wint-conversion]
       9 | #define PAGE_SIZE    (_AC(1,UL) << PAGE_SHIFT)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                      |
         |                      long unsigned int
   drivers/misc/servo-pwm.c:84:32: note: in expansion of macro 'PAGE_SIZE'
      84 |         return sysfs_emit(buf, PAGE_SIZE, "%u\n", data->degrees);
         |                                ^~~~~~~~~
   include/linux/sysfs.h:357:39: note: expected 'const char *' but argument is of type 'long unsigned int'
     357 | int sysfs_emit(char *buf, const char *fmt, ...);
         |                           ~~~~~~~~~~~~^~~


vim +/sysfs_emit +9 arch/sparc/include/asm/page_64.h

f5e706ad886b6a include/asm-sparc/page_64.h Sam Ravnborg 2008-07-17   8  
f5e706ad886b6a include/asm-sparc/page_64.h Sam Ravnborg 2008-07-17  @9  #define PAGE_SIZE    (_AC(1,UL) << PAGE_SHIFT)
f5e706ad886b6a include/asm-sparc/page_64.h Sam Ravnborg 2008-07-17  10  #define PAGE_MASK    (~(PAGE_SIZE-1))
f5e706ad886b6a include/asm-sparc/page_64.h Sam Ravnborg 2008-07-17  11  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
