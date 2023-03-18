Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237936BF81E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 06:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCRFqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 01:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCRFqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 01:46:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DBF4E5D3;
        Fri, 17 Mar 2023 22:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679118397; x=1710654397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XwBj/9hfmpagIdGRdqZJjnfQeY4udKL5fw//ppbl99Q=;
  b=nNtEEeg7ihrityF+2dHDLh0r79oIXGeELFDs7OPMnurVWyKdcyeK2Fek
   Awhs4K6YygjX9MlqZYxkERZ/Gm0B+cEHNRY7aq4OeO4KfVz+tqt5M3mg3
   0eFVzgOY8uV87XSaxSkVFRgInOTNr+52V3+LVjvGJGkXNgTWHwh8NJnt1
   cXgE+1im+LA+h6hurivDD47+e3hp2C6VTNMpjl7TAk4c+/bc11XPiwnT9
   46TcIIFm3+KstovY07dR1f99JJ8g9KwYC+niVnCwEak5qGTVVQED43pSA
   f7I+/eSe2TWAbPzovvYQCA+Y/QLTN4DdtRl6jbiWyVVDcE9R7bw4h41Fi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="424685487"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="424685487"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 22:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="790989675"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="790989675"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Mar 2023 22:46:35 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdPOk-0009pm-1D;
        Sat, 18 Mar 2023 05:46:34 +0000
Date:   Sat, 18 Mar 2023 13:46:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: Re: [PATCH v3 3/4] clk: loongson1: Re-implement the clock driver
Message-ID: <202303181358.BXLJVMkh-lkp@intel.com>
References: <20230316104707.236034-4-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316104707.236034-4-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keguang,

I love your patch! Yet something to improve:

[auto build test ERROR on 6f173737e1b5670c200329677e821cce1d3d755e]

url:    https://github.com/intel-lab-lkp/linux/commits/Keguang-Zhang/dt-bindings-clock-Add-Loongson-1-clock/20230316-185026
base:   6f173737e1b5670c200329677e821cce1d3d755e
patch link:    https://lore.kernel.org/r/20230316104707.236034-4-keguang.zhang%40gmail.com
patch subject: [PATCH v3 3/4] clk: loongson1: Re-implement the clock driver
config: mips-loongson1c_defconfig (https://download.01.org/0day-ci/archive/20230318/202303181358.BXLJVMkh-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/de00eab744ddc82edb1853048dd5d50aa8220115
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Keguang-Zhang/dt-bindings-clock-Add-Loongson-1-clock/20230316-185026
        git checkout de00eab744ddc82edb1853048dd5d50aa8220115
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303181358.BXLJVMkh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/clk-loongson1.c:300:15: error: expected parameter declarator
   MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
                 ^
>> drivers/clk/clk-loongson1.c:300:15: error: expected ')'
   drivers/clk/clk-loongson1.c:300:14: note: to match this '('
   MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
                ^
>> drivers/clk/clk-loongson1.c:300:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
   ^
   int
>> drivers/clk/clk-loongson1.c:300:14: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
                ^
                                                          void
   drivers/clk/clk-loongson1.c:301:20: error: expected parameter declarator
   MODULE_DESCRIPTION("Loongson1 clock driver");
                      ^
   drivers/clk/clk-loongson1.c:301:20: error: expected ')'
   drivers/clk/clk-loongson1.c:301:19: note: to match this '('
   MODULE_DESCRIPTION("Loongson1 clock driver");
                     ^
   drivers/clk/clk-loongson1.c:301:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   MODULE_DESCRIPTION("Loongson1 clock driver");
   ^
   int
   drivers/clk/clk-loongson1.c:301:19: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   MODULE_DESCRIPTION("Loongson1 clock driver");
                     ^
                                              void
   8 errors generated.


vim +300 drivers/clk/clk-loongson1.c

   299	
 > 300	MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
