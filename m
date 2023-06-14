Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7246972F7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbjFNIUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243482AbjFNIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:20:00 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A8C1984;
        Wed, 14 Jun 2023 01:19:58 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Qgyyd53xpz9spc;
        Wed, 14 Jun 2023 10:19:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686730793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6pBRIpjaWMJhTlkSGPLNmRsqhfWV6jsW5Wta8ORf2w=;
        b=o6Q6KH0ZcL5FQqEpVZjrd6gYCIs9S9i+rs4AZQQ0TaHpGzbCNf9IPsVbIanvnzhfi2iGP4
        rDfP+MzbTkmrhPME9OrNlzny6DPwKBCA47/N86OfAJ6PApj4SqOEYP2KM9S03sbtB3me2A
        SQBq3LL6dS1LV86s2eH0wsw3V34y67Q/u3DW4UtFIR6LzYO06zi4rXFwCFnC7/uSIVNfPw
        jfFBOHe92QvusOgvQMWu13r+a5+IChEGeOdL/psrhiT/oJ4BS2Pyj6bllvcS8RXsUMgQ7p
        FOMfJg3AskbTHwx5ILltt6xvZtZ1MVd/G0deDvww7ZPfBAuXVksf0H5aHJ44EA==
References: <20230613083626.227476-3-frank@oltmanns.dev>
 <202306132038.nUB6hmCv-lkp@intel.com>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     kernel test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, "A.s. Dong" <aisheng.dong@nxp.com>,
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
In-reply-to: <202306132038.nUB6hmCv-lkp@intel.com>
Date:   Wed, 14 Jun 2023 10:19:37 +0200
Message-ID: <87edmeqwva.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4Qgyyd53xpz9spc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-06-13 at 20:48:21 +0800, kernel test robot <lkp@intel.com> wrote:
> Hi Frank,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on v6.4-rc6]
> [also build test ERROR on linus/master]
> [cannot apply to clk/clk-next next-20230613]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Oltmanns/clk-fractional-divider-Improve-approximation-when-zero-based/20230613-163903
> base:   v6.4-rc6
> patch link:    https://lore.kernel.org/r/20230613083626.227476-3-frank%40oltmanns.dev
> patch subject: [PATCH v2 2/2] clk: tests: Add tests for fractional divisor approximation
> config: csky-randconfig-r011-20230612 (https://download.01.org/0day-ci/archive/20230613/202306132038.nUB6hmCv-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 12.3.0
> reproduce (this is a W=1 build):
>         mkdir -p ~/bin
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout v6.4-rc6
>         b4 shazam https://lore.kernel.org/r/20230613083626.227476-3-frank@oltmanns.dev
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306132038.nUB6hmCv-lkp@intel.com/
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
>>> ERROR: modpost: "clk_fractional_divider_general_approximation" [drivers/clk/clk_test.ko] undefined!

The issue seems to be that clk_fractional_divider_general_approximation
is not exported as a symbol, while the config builds the clk_test as a
module:
CONFIG_CLK_KUNIT_TEST=m

If I'm not mistaken, this means that I can't test
clk_fractional_divider_general_approximation directly. Instead I'd have
to test it using clk_fractional_divider_ops.round_rate.

Can someone more knowlegdable than me please confirm if my understanding
is correct?

Thanks,
  Frank
