Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F12173413C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjFQNc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFQNcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:32:55 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388E19A1;
        Sat, 17 Jun 2023 06:32:54 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QjxmL3rQ0z9sks;
        Sat, 17 Jun 2023 15:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1687008770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZoI4Bw3sCCyCXPTMLBEPFCqY8Pv58J03l2/6Q77EHA=;
        b=QZKf+EFTILZO4/YhLIUf7kpElHYaNl+CQynchuZFnmnCaPr44U0e7D9CWo76xCX8YFTRj/
        86v5AC8NrdL2uTOQYjN+9IeH8wAQ3NvWECUS1kPtHdd7EVio0VClDQd0qcwTpRIr5bGQSa
        la0RL4TCuclqXrpuQTwuxbU6BfEnLB6AKFdbCKOvfQB9BWFaZTkeulgdm7+IU/sNzI4OqC
        5/EGA4mVI4GzaBB1/lABi2Ju6ETporuiRiOJ/39n8ZOuRkRTrNtdSpSc005F/aB49eC3W9
        qalHOdOTV7Q/snc8VP5i4AX+IncTgTvTUpXCMAm7hpsonAvbJ3Ymz3sTfXFvYw==
References: <20230617102919.27564-3-frank@oltmanns.dev>
 <202306172036.EevtaVp6-lkp@intel.com>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     kernel test robot <lkp@intel.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, "A.s. Dong" <aisheng.dong@nxp.com>,
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
In-reply-to: <202306172036.EevtaVp6-lkp@intel.com>
Date:   Sat, 17 Jun 2023 15:32:31 +0200
Message-ID: <87legi2p00.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-06-17 at 20:15:20 +0800, kernel test robot <lkp@intel.com> wrote:
> Hi Frank,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on clk/clk-next]
> [also build test WARNING on linus/master v6.4-rc6 next-20230616]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Oltmanns/clk-fractional-divider-Improve-approximation-when-zero-based-and-export/20230617-183118
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> patch link:    https://lore.kernel.org/r/20230617102919.27564-3-frank%40oltmanns.dev
> patch subject: [PATCH v4 2/2] clk: fractional-divider: tests: Add test suite for edge cases
> config: hexagon-randconfig-r035-20230617 (https://download.01.org/0day-ci/archive/20230617/202306172036.EevtaVp6-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230617/202306172036.EevtaVp6-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306172036.EevtaVp6-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/clk/clk-fractional-divider_test.c:26:41: warning: variable 'max_m' set but not used [-Wunused-but-set-variable]
>       26 |         unsigned long rate, parent_rate, m, n, max_m, max_n;
>          |                                                ^
>    drivers/clk/clk-fractional-divider_test.c:88:41: warning: variable 'max_m' set but not used [-Wunused-but-set-variable]
>       88 |         unsigned long rate, parent_rate, m, n, max_m, max_n;
>          |                                                ^
>    2 warnings generated.

Clang compiler warnings are fixed in version 5:
https://lore.kernel.org/all/20230617131041.18313-1-frank@oltmanns.dev/

>
>
> vim +/max_m +26 drivers/clk/clk-fractional-divider_test.c
>
>     15
>     16	/*
>     17	 * Test the maximum denominator case for fd clock without flags.
>     18	 *
>     19	 * Expect the highest possible denominator to be used in order to get as close as possible to the
>     20	 * requested rate.
>     21	 */
>     22	static void clk_fd_test_approximation_max_denominator(struct kunit *test)
>     23	{
>     24		struct clk_fractional_divider *fd;
>     25		struct clk_hw *hw;
>   > 26		unsigned long rate, parent_rate, m, n, max_m, max_n;
>     27
>     28		fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
>     29		KUNIT_ASSERT_NOT_NULL(test, fd);
>     30
>     31		fd->mwidth = 3;
>     32		max_m = 7;
>     33		fd->nwidth = 3;
>     34		max_n = 7;
>     35
>     36		hw = &fd->hw;
>     37
>     38		rate = 240000000;
>     39		parent_rate = (max_n + 1) * rate; /* so that it exceeds the maximum divisor */
>     40
>     41		clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
>     42		KUNIT_EXPECT_EQ(test, parent_rate, (max_n + 1) * rate); /* parent remains unchanged */
>     43		KUNIT_EXPECT_EQ(test, m, 1);
>     44		KUNIT_EXPECT_EQ(test, n, max_n);
>     45	}
>     46
