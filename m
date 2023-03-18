Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF776BFC30
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 19:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCRSz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 14:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCRSz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 14:55:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432591F4B6;
        Sat, 18 Mar 2023 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679165756; x=1710701756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UQeD0VGWp/2m7vB76CpmPBDiMvvWfCbuAHZTBTn2+IE=;
  b=m8Xyn2am8K8bmfj81PuSkqLC3lqDqreErCC24F8wKmztQ/OjLQHcQR0O
   4nuogF7aERSd1QudKMg1JvsujLCx3svU+Hy/bDw/xg+DinhS8e9x7LLsF
   G49EwV5Sk4j7Ba43T09Jt0AuN5YC5c5oC4T58TkB33+bSpOJ5HTBQcbjf
   suHbtjKHY+w3rhUy5h4vGqWxGdVzvffI3ImyLuOgojKD+MW3UwzI50W+V
   6T0NdmUbEdxLN9sqslTHrIbWlraQeFafESNb3+4UDhmitU69nkMkuB4yj
   TwCcSpwVH/Vww0NOcYHeQbk+ceKF2fmkFKK76V2kVlnleZXmyhFM1s9qn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="326820077"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="326820077"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 11:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="630627711"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="630627711"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Mar 2023 11:55:53 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdbiZ-000ADq-2P;
        Sat, 18 Mar 2023 18:55:51 +0000
Date:   Sun, 19 Mar 2023 02:55:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Staging: nvec: Change container_of macro to an inline
 function.
Message-ID: <202303190233.v2KJFmIG-lkp@intel.com>
References: <20230318170514.GA49181@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318170514.GA49181@sumitra.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumitra,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumitra-Sharma/Staging-nvec-Change-container_of-macro-to-an-inline-function/20230319-010628
patch link:    https://lore.kernel.org/r/20230318170514.GA49181%40sumitra.com
patch subject: [PATCH] Staging: nvec: Change container_of macro to an inline function.
config: arm64-randconfig-r014-20230319 (https://download.01.org/0day-ci/archive/20230319/202303190233.v2KJFmIG-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/e58807d27f0ba705144bce72751f5cb0a75b9682
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sumitra-Sharma/Staging-nvec-Change-container_of-macro-to-an-inline-function/20230319-010628
        git checkout e58807d27f0ba705144bce72751f5cb0a75b9682
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/staging/nvec/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303190233.v2KJFmIG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/nvec/nvec_paz00.c:19:9: error: incomplete definition of type 'struct nvec_led'
           return container_of(led_cdev, struct nvec_led, cdev);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:20:47: note: expanded from macro 'container_of'
           static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:338:74: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                            ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   drivers/staging/nvec/nvec_paz00.c:17:22: note: forward declaration of 'struct nvec_led'
   static inline struct nvec_led *to_nvec_led(struct led_classdev *led_cdev)
                        ^
>> drivers/staging/nvec/nvec_paz00.c:19:9: error: offsetof of incomplete type 'struct nvec_led'
           return container_of(led_cdev, struct nvec_led, cdev);
                  ^                      ~~~~~~
   include/linux/container_of.h:23:21: note: expanded from macro 'container_of'
           ((type *)(__mptr - offsetof(type, member))); })
                              ^        ~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
   #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
                                   ^                  ~~~~
   drivers/staging/nvec/nvec_paz00.c:17:22: note: forward declaration of 'struct nvec_led'
   static inline struct nvec_led *to_nvec_led(struct led_classdev *led_cdev)
                        ^
>> drivers/staging/nvec/nvec_paz00.c:19:9: error: returning 'void' from a function with incompatible result type 'struct nvec_led *'
           return container_of(led_cdev, struct nvec_led, cdev);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:18:41: note: expanded from macro 'container_of'
   #define container_of(ptr, type, member) ({                              \
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 errors generated.


vim +19 drivers/staging/nvec/nvec_paz00.c

    16	
    17	static inline struct nvec_led *to_nvec_led(struct led_classdev *led_cdev)
    18	{
  > 19		return container_of(led_cdev, struct nvec_led, cdev);
    20	}
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
