Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669B86B06C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCHMRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCHMRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:17:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38E999D7A;
        Wed,  8 Mar 2023 04:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678277868; x=1709813868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vgbsx8r3QuxIB3RjFJxSxX9wWfwdsEyw2KJep8+k8dw=;
  b=IBppv/DL66oC5r6EAyAPJOlsdiTw0KXW/2ZExZs2+qr83eq4zTHrprkf
   gyh3gQt355+j86zDjnwDTAlMBgJANkPC4zObVHnTnwmw2SEzb4mgIc9Bt
   SrhDIQGMQFQengY+BpTrNYoRwWcgt9CoXjIhQF0OYW42avoo21W8Ysnqh
   XCW8YEs1TQ9W/v+YWV2spjMQ5j/89k+4Ex0GA0ou3iOSkV2hT4gV3yRF4
   ZpNNl62GvbLnEpXo3brOVQfyDJB9Gipyq8NeLEn6uc53Ku3VPdPhnrIEH
   HciMKSlsEUPO2fdFvMN6/r2EkTb7N8lom4cQTw/ZYnARJgeS2N6B7JwaE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="398717354"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="398717354"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 04:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="851063973"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="851063973"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2023 04:17:45 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZsjo-00027f-1Q;
        Wed, 08 Mar 2023 12:17:44 +0000
Date:   Wed, 8 Mar 2023 20:16:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v13 2/2] clk: clk-loongson2: add clock controller driver
 support
Message-ID: <202303082037.QPfBP64A-lkp@intel.com>
References: <20230307115022.12846-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307115022.12846-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yinbo,

I love your patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next linus/master v6.3-rc1 next-20230308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/clk-clk-loongson2-add-clock-controller-driver-support/20230307-195252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230307115022.12846-2-zhuyinbo%40loongson.cn
patch subject: [PATCH v13 2/2] clk: clk-loongson2: add clock controller driver support
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230308/202303082037.QPfBP64A-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/391d6fc63ac65f5456e4755c9dd85232a6296285
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yinbo-Zhu/clk-clk-loongson2-add-clock-controller-driver-support/20230307-195252
        git checkout 391d6fc63ac65f5456e4755c9dd85232a6296285
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303082037.QPfBP64A-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/clk-loongson2.c: In function 'loongson2_calc_pll_rate':
>> drivers/clk/clk-loongson2.c:79:15: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
      79 |         val = readq(loongson2_pll_base + offset);
         |               ^~~~~
         |               readl
   cc1: some warnings being treated as errors


vim +79 drivers/clk/clk-loongson2.c

    73	
    74	static unsigned long loongson2_calc_pll_rate(int offset, unsigned long rate)
    75	{
    76		u64 val;
    77		u32 mult = 1, div = 1;
    78	
  > 79		val = readq(loongson2_pll_base + offset);
    80	
    81		mult = (val >> LOONGSON2_PLL_MULT_SHIFT) &
    82				clk_div_mask(LOONGSON2_PLL_MULT_WIDTH);
    83		div = (val >> LOONGSON2_PLL_DIV_SHIFT) &
    84				clk_div_mask(LOONGSON2_PLL_DIV_WIDTH);
    85	
    86		return div_u64((u64)rate * mult, div);
    87	}
    88	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
