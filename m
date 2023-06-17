Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4655573409B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjFQLzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 07:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjFQLzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 07:55:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DAF196;
        Sat, 17 Jun 2023 04:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687002937; x=1718538937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G+HfwYIcm+n32dQlKCCmezW1oWNyiT7XDmX66Zx/zos=;
  b=FN8Faj1NzxnPiXShCJ4UXCM9Q/iLObRfLWEUQoMQPMuVbWPeK3jMfEww
   llO2sapz/JKLjYsIRivPHuK5naKeabXw+GkyPE7KYETak0s4ajCJqWlqy
   djEx2d2ey3GvQFTW7tOQNkuRtXehC7zBX9TR1iePdIrecEiF2s2YYMdCs
   QHRQ4ffHAazNztwuiZlFpO0IpLFf/7tq3WkAHkzM3kIRfNiQzepxA2zCx
   rX/fMpsK47K8XRhepPjY4BjQ9vJ7ZzLLDb+GhttEHSxZq9ABx1mqhqH3N
   5Vd2+JhxJwtssdknSVTS4Y7a7mo4GyVuTz1/xtTJi86EOLh9LN+eV1IxS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="358255221"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="358255221"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 04:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="690546088"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="690546088"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Jun 2023 04:55:32 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAUWi-0002jQ-0S;
        Sat, 17 Jun 2023 11:55:32 +0000
Date:   Sat, 17 Jun 2023 19:54:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Oltmanns <frank@oltmanns.dev>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Frank Oltmanns <frank@oltmanns.dev>,
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
Message-ID: <202306171912.PqJBpGMg-lkp@intel.com>
References: <20230617102919.27564-3-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617102919.27564-3-frank@oltmanns.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
config: arm-randconfig-r046-20230617 (https://download.01.org/0day-ci/archive/20230617/202306171912.PqJBpGMg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230617/202306171912.PqJBpGMg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306171912.PqJBpGMg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/clk-fractional-divider_test.c: In function 'clk_fd_test_approximation_max_denominator':
>> drivers/clk/clk-fractional-divider_test.c:26:48: warning: variable 'max_m' set but not used [-Wunused-but-set-variable]
      26 |         unsigned long rate, parent_rate, m, n, max_m, max_n;
         |                                                ^~~~~
   drivers/clk/clk-fractional-divider_test.c: In function 'clk_fd_test_approximation_max_denominator_zero_based':
   drivers/clk/clk-fractional-divider_test.c:88:48: warning: variable 'max_m' set but not used [-Wunused-but-set-variable]
      88 |         unsigned long rate, parent_rate, m, n, max_m, max_n;
         |                                                ^~~~~


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
