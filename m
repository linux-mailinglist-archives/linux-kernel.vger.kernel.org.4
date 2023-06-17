Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C592C7340EF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbjFQMSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 08:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbjFQMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 08:18:02 -0400
Received: from mga18.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A26296A;
        Sat, 17 Jun 2023 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687004239; x=1718540239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mQ87SPnE3Di8X8k0ALKsp3NAdHIXJcUi2J4OGCuvT7M=;
  b=TtZF4nCL03bb8rbZo+hpI3egws7ABZ/if7doogrFS4gy9aD6atxWiqp5
   WP11BK91BdPC1bj6H0SoIHxU8IDFmmLVS89SAqjxyGmnCPyproxHYA94A
   Zlt4SOUdKHejYRh1WS0Y0U+bvM9oPg+etw4sfZXUQxHv0H3Lq8XkTlLLe
   AuwfYRO2YQ2kguJnNToWjf2TOWlu0m9ONmA3ioQv04sXNYEpuEC+ugHtA
   ZE9LvXCevljKfK3s8xNc3/k1cVxXGZn+xDF3pWKrtOKWeDqlUl+aaM8xD
   YJ9kEKRAUPtjbWzTZSjiUKpiN1gLkZUhTTT7dvwQpSqTPiVlC44Td74iO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="344123935"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="344123935"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 05:15:37 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="746738268"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="746738268"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2023 05:15:31 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAUq4-0002jg-1C;
        Sat, 17 Jun 2023 12:15:32 +0000
Date:   Sat, 17 Jun 2023 20:15:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Oltmanns <frank@oltmanns.dev>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Frank Oltmanns <frank@oltmanns.dev>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v4 2/2] clk: fractional-divider: tests: Add test suite
 for edge cases
Message-ID: <202306172036.EevtaVp6-lkp@intel.com>
References: <20230617102919.27564-3-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617102919.27564-3-frank@oltmanns.dev>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.4-rc6 next-20230616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Oltmanns/clk-fractional-divider-Improve-approximation-when-zero-based-and-export/20230617-183118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230617102919.27564-3-frank%40oltmanns.dev
patch subject: [PATCH v4 2/2] clk: fractional-divider: tests: Add test suite for edge cases
config: hexagon-randconfig-r035-20230617 (https://download.01.org/0day-ci/archive/20230617/202306172036.EevtaVp6-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230617/202306172036.EevtaVp6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306172036.EevtaVp6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/clk-fractional-divider_test.c:26:41: warning: variable 'max_m' set but not used [-Wunused-but-set-variable]
      26 |         unsigned long rate, parent_rate, m, n, max_m, max_n;
         |                                                ^
   drivers/clk/clk-fractional-divider_test.c:88:41: warning: variable 'max_m' set but not used [-Wunused-but-set-variable]
      88 |         unsigned long rate, parent_rate, m, n, max_m, max_n;
         |                                                ^
   2 warnings generated.


vim +/max_m +26 drivers/clk/clk-fractional-divider_test.c

    15	
    16	/*
    17	 * Test the maximum denominator case for fd clock without flags.
    18	 *
    19	 * Expect the highest possible denominator to be used in order to get as close as possible to the
    20	 * requested rate.
    21	 */
    22	static void clk_fd_test_approximation_max_denominator(struct kunit *test)
    23	{
    24		struct clk_fractional_divider *fd;
    25		struct clk_hw *hw;
  > 26		unsigned long rate, parent_rate, m, n, max_m, max_n;
    27	
    28		fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
    29		KUNIT_ASSERT_NOT_NULL(test, fd);
    30	
    31		fd->mwidth = 3;
    32		max_m = 7;
    33		fd->nwidth = 3;
    34		max_n = 7;
    35	
    36		hw = &fd->hw;
    37	
    38		rate = 240000000;
    39		parent_rate = (max_n + 1) * rate; /* so that it exceeds the maximum divisor */
    40	
    41		clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
    42		KUNIT_EXPECT_EQ(test, parent_rate, (max_n + 1) * rate); /* parent remains unchanged */
    43		KUNIT_EXPECT_EQ(test, m, 1);
    44		KUNIT_EXPECT_EQ(test, n, max_n);
    45	}
    46	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
