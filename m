Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9064A730E92
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbjFOFQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFOFQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:16:44 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C5A26A9;
        Wed, 14 Jun 2023 22:16:40 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QhVrf6fvfz9snk;
        Thu, 15 Jun 2023 07:16:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686806194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJ9tbVJW/fCl46tCIc1R0NLFQsIT3IjS2TXsnrWjR/8=;
        b=ZctlEB0s8TfAASUrOzLthi/QgcNN6X6m3/DePewA4K/qpeiCwxEMurtxd0tSzG7do53CJ+
        tSFqFpYo9ePxHfU7Cm51Go+RmaSXANonmXNEg5uxozQhc9VAvbVk43CAUNyT453nvDKSZF
        Qs01o5gzn4NL9jpz0LKKsD98gOXwlhpSD02W2Oh/PhEY/axuCC9C0OPYCgPAIzT668X/im
        Mc6UUmNJJ7vBT362UAyf+Tq8oxIQCYsxz6IYuP3+3kSiG5GxUyO1Mwb3k78Pp/LOE8MU1x
        G34KCkEIct7Er1rvGNIOLfA0qjhSNY8AmJ1x7hxBjlho+nR/k21uxRcPolIqkg==
References: <20230613083626.227476-3-frank@oltmanns.dev>
 <202306132038.nUB6hmCv-lkp@intel.com> <87edmeqwva.fsf@oltmanns.dev>
 <aa23f41c0e313e97122ac384d66e2325.sboyd@kernel.org>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, "A.s. Dong" <aisheng.dong@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 2/2] clk: tests: Add tests for fractional divisor
 approximation
In-reply-to: <aa23f41c0e313e97122ac384d66e2325.sboyd@kernel.org>
Date:   Thu, 15 Jun 2023 07:16:17 +0200
Message-ID: <875y7ps3tq.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2023-06-14 at 13:02:24 -0700, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Frank Oltmanns (2023-06-14 01:19:37)
>> Hi,
>>
>> On 2023-06-13 at 20:48:21 +0800, kernel test robot <lkp@intel.com> wrote:
>> > Hi Frank,
>> >
>> > kernel test robot noticed the following build errors:
>> >
>> > [auto build test ERROR on v6.4-rc6]
>> > [also build test ERROR on linus/master]
>> > [cannot apply to clk/clk-next next-20230613]
>> > [If your patch is applied to the wrong git tree, kindly drop us a note.
>> > And when submitting patch, we suggest to use '--base' as documented in
>> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
>> >
>> > url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Oltmanns/clk-fractional-divider-Improve-approximation-when-zero-based/20230613-163903
>> > base:   v6.4-rc6
>> > patch link:    https://lore.kernel.org/r/20230613083626.227476-3-frank%40oltmanns.dev
>> > patch subject: [PATCH v2 2/2] clk: tests: Add tests for fractional divisor approximation
>> > config: csky-randconfig-r011-20230612 (https://download.01.org/0day-ci/archive/20230613/202306132038.nUB6hmCv-lkp@intel.com/config)
>> > compiler: csky-linux-gcc (GCC) 12.3.0
>> > reproduce (this is a W=1 build):
>> >         mkdir -p ~/bin
>> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>> >         chmod +x ~/bin/make.cross
>> >         git checkout v6.4-rc6
>> >         b4 shazam https://lore.kernel.org/r/20230613083626.227476-3-frank@oltmanns.dev
>> >         # save the config file
>> >         mkdir build_dir && cp config build_dir/.config
>> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky olddefconfig
>> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash
>> >
>> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> > the same patch/commit), kindly add following tags
>> > | Reported-by: kernel test robot <lkp@intel.com>
>> > | Closes: https://lore.kernel.org/oe-kbuild-all/202306132038.nUB6hmCv-lkp@intel.com/
>> >
>> > All errors (new ones prefixed by >>, old ones prefixed by <<):
>> >
>> >>> ERROR: modpost: "clk_fractional_divider_general_approximation" [drivers/clk/clk_test.ko] undefined!
>>
>> The issue seems to be that clk_fractional_divider_general_approximation
>> is not exported as a symbol, while the config builds the clk_test as a
>> module:
>> CONFIG_CLK_KUNIT_TEST=m
>>
>> If I'm not mistaken, this means that I can't test
>> clk_fractional_divider_general_approximation directly. Instead I'd have
>> to test it using clk_fractional_divider_ops.round_rate.
>>
>> Can someone more knowlegdable than me please confirm if my understanding
>> is correct?
>
> Export the symbol.

Ok. I can do that. Please note that I had already submitted a V3 [1],
that went the way of using clk_fractional_divider_ops.round_rate. I
apologize for not waiting for your feedback prior to submission. It
won't happen again.

I liked the approach of calling clk_fd_round_rate directly via the ops,
because it might allow me to test the other ops as well using the same
blueprint. Of course, I will not add test cases, if you don't want it.
(Calling clk_fd_round_rate also had the side effect of teaching me, that
fd clocks expect the fraction to be less than or equal to 1.)

I don't want to waste your time, but if you could maybe have a chance to
look at the approach I took in V3 and tell me if you still want me to
export the symbol instead, that would be really helpful. I'll follow
your preference.

If I don't hear back until the weekend, I will treat your three words
above as your preference and prepare a V4 that goes back to calling
clk_fractional_divider_general_approximation directly.

Thank you,
  Frank

[1]: https://lore.kernel.org/all/20230614185521.477924-3-frank@oltmanns.dev/
