Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C792737A65
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjFUEme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFUEma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:42:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF71BE3;
        Tue, 20 Jun 2023 21:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687322524; x=1718858524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Oyatk6UJM7WoUbA4Egxw1w1lf2ZrfcTPtl1VcnDick=;
  b=LzYaxyiWCi9gWah9Oa3T9MyU08DrZQaa1/T72kPAEaKmgFtnRE+nRbz3
   p6+GvAaH9vAs5xaYheP/ktGt0Yt1P6MlI1ZMWsJjDLhB92HzfEzMD7b3t
   EQA6DNF1LTPMNttpRe/WYYgsk7mxD4uqz6ZMfkn4OpzK62TM5MHmrPtTk
   WxCV4kYVgv6xXjhR3yCdgz/HBNgIAi2Io4xWia3CUEYpbB6Am2FtVqdrP
   b7Fng2xADcWDV3LCzQyAky6rVngp0DerZcOU8jsSVAhQzoRgace1lu37s
   VK7YLZ+XCUdijpuIxN5VfZ+P2vydxzI9a8tPjlpvf/PT7PmBYdixH3gdd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349798498"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="349798498"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 21:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="714304953"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="714304953"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Jun 2023 21:41:57 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBpfI-0006Yp-0P;
        Wed, 21 Jun 2023 04:41:56 +0000
Date:   Wed, 21 Jun 2023 12:41:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lucas Tanure <tanure@linux.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 3/6] clk: meson: t7: add peripheral clock controller
Message-ID: <202306211239.HA6GmDhb-lkp@intel.com>
References: <20230615182938.18487-4-tanure@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615182938.18487-4-tanure@linux.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next tty/tty-testing tty/tty-next tty/tty-linus krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next linus/master v6.4-rc7 next-20230620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lucas-Tanure/dt-bindings-arm-amlogic-add-Amlogic-T7-based-Khadas-VIM4-bindings/20230616-023038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230615182938.18487-4-tanure%40linux.com
patch subject: [PATCH 3/6] clk: meson: t7: add peripheral clock controller
config: arm64-randconfig-r001-20230620 (https://download.01.org/0day-ci/archive/20230621/202306211239.HA6GmDhb-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211239.HA6GmDhb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306211239.HA6GmDhb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/meson/t7.c:7084:23: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
                   [CLKID_VID_PLL]                 = &t7_vid_pll.hw,
                                                     ^~~~~~~~~~~~~~
   drivers/clk/meson/t7.c:7082:23: note: previous initialization is here
                   [CLKID_VID_PLL]                 = &t7_vid_pll_div.hw,
                                                     ^~~~~~~~~~~~~~~~~~
   drivers/clk/meson/t7.c:7946:29: warning: variable 'mclk_data' set but not used [-Wunused-but-set-variable]
           struct meson_clk_pll_data *mclk_data;
                                      ^
>> drivers/clk/meson/t7.c:93:29: warning: unused variable 'meson_pll_clk_no_ops' [-Wunused-const-variable]
   static const struct clk_ops meson_pll_clk_no_ops = {};
                               ^
>> drivers/clk/meson/t7.c:689:37: warning: unused variable 't7_a73_dyn_clk_sel' [-Wunused-const-variable]
   static const struct clk_parent_data t7_a73_dyn_clk_sel[] = {
                                       ^
   4 warnings generated.


vim +/meson_pll_clk_no_ops +93 drivers/clk/meson/t7.c

    92	
  > 93	static const struct clk_ops meson_pll_clk_no_ops = {};
    94	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
