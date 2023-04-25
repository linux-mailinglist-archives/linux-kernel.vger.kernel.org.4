Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF76EDDC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjDYIOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjDYIOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:14:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9588CAF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682410470; x=1713946470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QRKM2nX+qqnZ2KExa0u7TxfdfApuq1qeuoMBBF7bFYk=;
  b=VUJ+O1oG4ylJ0b92jKUQm8PwKS9O3fV1HImd9ES9rNa2AHQ1XHKVRv8x
   CVUWLy30TUSR++MckYNUNUDc4HZldYjhPdNaDtPHrWp700LG4W2hDQSTm
   jGOSoDnBD9XN9znOkpU6zcPErNs9o8VgELxtEwab2PmtH1XVjCPlanJ99
   B7SdKCAxbmCP/nGioiD3fpzrjsv3GFf+lmH/HTCfSLH0yR+syEijFjMZa
   JE8RW0sgf7pgW6DZdGwmOXQJxqV5VlLgFjMdRymwI+4vxK/gV4zqEqXhj
   Yy4I/RkdcK6UvdA3NV1CJT6I7SBdILx8xEH+vh5by7N5Gf+HRrRq7EeWJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="345449812"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="345449812"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 01:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="804983790"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="804983790"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Apr 2023 01:14:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prDoe-000jBq-3B;
        Tue, 25 Apr 2023 08:14:24 +0000
Date:   Tue, 25 Apr 2023 16:13:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        heiko@sntech.de, kito.cheng@sifive.com, jrtc27@jrtc27.com,
        conor.dooley@microchip.com, matthias.bgg@gmail.com,
        heinrich.schuchardt@canonical.com, greentime.hu@sifive.com,
        nick.knight@sifive.com, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 3/4] RISC-V: export the ISA string of the running machine
 in the aux vector
Message-ID: <202304251544.rajXe0ut-lkp@intel.com>
References: <20230424194911.264850-4-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424194911.264850-4-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230424]
[also build test WARNING on v6.3]
[cannot apply to soc/for-next linus/master kees/for-next/execve v6.3 v6.3-rc7 v6.3-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Stuebner/RISC-V-create-ISA-string-separately-not-as-part-of-cpuinfo/20230425-035214
base:   next-20230424
patch link:    https://lore.kernel.org/r/20230424194911.264850-4-heiko.stuebner%40vrull.eu
patch subject: [PATCH 3/4] RISC-V: export the ISA string of the running machine in the aux vector
config: riscv-randconfig-r042-20230423 (https://download.01.org/0day-ci/archive/20230425/202304251544.rajXe0ut-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/3f82c51fa0f92c257313a0291c7a36cbdfdc5bb1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Heiko-Stuebner/RISC-V-create-ISA-string-separately-not-as-part-of-cpuinfo/20230425-035214
        git checkout 3f82c51fa0f92c257313a0291c7a36cbdfdc5bb1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304251544.rajXe0ut-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/cpu.c:122:14: warning: function 'riscv_create_isa_string' has internal linkage but is not defined [-Wundefined-internal]
   static char *riscv_create_isa_string(void);
                ^
   arch/riscv/kernel/cpu.c:140:12: note: used here
           isa_str = riscv_create_isa_string();
                     ^
   1 warning generated.


vim +/riscv_create_isa_string +122 arch/riscv/kernel/cpu.c

   120	
   121	const char *riscv_base_platform = NULL;
 > 122	static char *riscv_create_isa_string(void);
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
