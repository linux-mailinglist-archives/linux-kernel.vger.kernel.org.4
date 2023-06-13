Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718F072DD00
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbjFMItg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbjFMIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:49:30 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBA9F1;
        Tue, 13 Jun 2023 01:49:27 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QgMg82g5cz9sdK;
        Tue, 13 Jun 2023 10:49:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686646164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKOsikHuaIxLmnX7LMFU7lxyfkWIITufUYLJEhwma08=;
        b=Tg0prYrFLmm3TK1RL2DIhXYXPzA4ERHcq6g/Qv2oJ9RXJ2jCrCHxQ6/l+Qj+AybFvdKTfj
        g1ku6Q9T4pExxcTpo/xUnNyjeNsxMfadlxigEiqdgLLUIK2d7FVDXqW2HhclLuGZzzTtmg
        /j/CCKMlE+T+Gk3oPa1Vn/yEqSotGkeI7CTog/PPYrhMaerAEyZnSdWzwpFgTHTZEKLQ9J
        FEzNuAgRcsBddjDAKxnec9F2Pd1mKGLU86CFysrlVrTe9kChjXMKk0dcQ+j6kfQmRuq10e
        ve+utR9jq6Oz6orV3YSMI+nhRSoWlX4kxqp8qcc84KxdyXpIamPbal1vD7ElDQ==
References: <20230613083626.227476-1-frank@oltmanns.dev>
 <20230613083626.227476-3-frank@oltmanns.dev>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
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
In-reply-to: <20230613083626.227476-3-frank@oltmanns.dev>
Date:   Tue, 13 Jun 2023 10:49:20 +0200
Message-ID: <871qif21db.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4QgMg82g5cz9sdK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2023-06-13 at 10:36:26 +0200, Frank Oltmanns <frank@oltmanns.dev> wrote:
> In light of the recent discovery that the fractional divisor
> approximation does not utilize the full available range for clocks that
> are flagged CLK_FRAC_DIVIDER_ZERO_BASED, implement tests for the edge
> cases of this clock type.
>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> Link: https://lore.kernel.org/lkml/20230529133433.56215-1-frank@oltmanns.dev
> ---
>  drivers/clk/clk_test.c | 69 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
> index f9a5c2964c65..b247ba841cbd 100644
> --- a/drivers/clk/clk_test.c
> +++ b/drivers/clk/clk_test.c
> @@ -8,6 +8,9 @@
>  /* Needed for clk_hw_get_clk() */
>  #include "clk.h"
>
> +/* Needed for clk_fractional_divider_general_approximation */
> +#include "clk-fractional-divider.h"
> +
>  #include <kunit/test.h>
>
>  #define DUMMY_CLOCK_INIT_RATE	(42 * 1000 * 1000)
> @@ -2394,6 +2397,69 @@ static struct kunit_suite clk_mux_notifier_test_suite = {
>  	.test_cases = clk_mux_notifier_test_cases,
>  };
>
> +
> +/*
> + * Test that clk_fractional_divider_general_approximation will work with the
> + * highest available numerator and denominator.
> + */
> +static void clk_fd_test_round_rate_max_mn(struct kunit *test)
> +{
> +	struct clk_fractional_divider *fd;
> +	struct clk_hw *hw;
> +	unsigned long rate, parent_rate, m, n;
> +
> +	fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, fd);
> +
> +	fd->mwidth = 3;
> +	fd->nwidth = 3;
> +
> +	hw = &fd->hw;
> +
> +	rate = DUMMY_CLOCK_RATE_1;
> +
> +	// Highest denominator, no flags
> +	parent_rate = 10 * DUMMY_CLOCK_RATE_1;
> +	clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
> +	KUNIT_EXPECT_EQ(test, m, 1);
> +	KUNIT_EXPECT_EQ(test, n, 7);
> +
> +	// Highest numerator, no flags
> +	parent_rate = DUMMY_CLOCK_RATE_1 / 10;
> +	clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
> +	KUNIT_EXPECT_EQ(test, m, 7);
> +	KUNIT_EXPECT_EQ(test, n, 1);

The two calls above aim at proving that the change does not break
existing functionality.

> +
> +	// Highest denominator, zero based
> +	parent_rate = 10 * DUMMY_CLOCK_RATE_1;
> +	fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
> +	clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
> +	KUNIT_EXPECT_EQ(test, m, 1);
> +	KUNIT_EXPECT_EQ(test, n, 8);
> +
> +	// Highest numerator, zero based
> +	parent_rate = DUMMY_CLOCK_RATE_1 / 10;
> +	clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
> +	KUNIT_EXPECT_EQ(test, m, 8);
> +	KUNIT_EXPECT_EQ(test, n, 1);
> +}
> +
> +static struct kunit_case clk_fd_test_cases[] = {
> +	KUNIT_CASE(clk_fd_test_round_rate_max_mn),
> +	{}
> +};
> +
> +/*
> + * Test suite for a fractional divider clock.
> + *
> + * These tests exercise the fractional divider API: clk_recalc_rate,
> + * clk_set_rate(), clk_round_rate().
> + */
> +static struct kunit_suite clk_fd_test_suite = {
> +	.name = "clk-fd-test",
> +	.test_cases = clk_fd_test_cases,
> +};

Unfortunately, the style of the tests does not really match with the
style of the existing tests, because those where all aimed at the
framework itself and not at specific functions.

Please let me know, if you require any changes.

Thanks,
  Frank

> +
>  kunit_test_suites(
>  	&clk_leaf_mux_set_rate_parent_test_suite,
>  	&clk_test_suite,
> @@ -2406,6 +2472,7 @@ kunit_test_suites(
>  	&clk_range_maximize_test_suite,
>  	&clk_range_minimize_test_suite,
>  	&clk_single_parent_mux_test_suite,
> -	&clk_uncached_test_suite
> +	&clk_uncached_test_suite,
> +	&clk_fd_test_suite
>  );
>  MODULE_LICENSE("GPL v2");
