Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A776F4F03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjECDI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjECDII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4907B26A0;
        Tue,  2 May 2023 20:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A3562A3A;
        Wed,  3 May 2023 03:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2202AC433EF;
        Wed,  3 May 2023 03:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683083286;
        bh=Dg4NxEX0n42vP7zx2JpmRiiGjwgticb90bYo0bsDAAg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JyUqGkK3evuHh3wfRMC3XEhXFJCvIZHzs+i/JFujoK9UejXkFyj/IDDDVWedowfqo
         ouqZpydsCx6sYxV086SnIbhtI0Il6TGMaywofbJPgnrImffD+78RObMYMP+ai1FaMk
         yvKduRPaq4WEDTSf/uMDEXRHkXGndPf+o9Q2Ru9xljcIObN7fcoCFydMS+dHEQNB6y
         94YagG3mTS68tkoZuHd0KxjpZJw7mLCI8hBETCTD7E2/X9YjlmABO2H9WfQZbvYV8P
         10TOLfB91dNaKAuKmQImY16e3dfJPZyHfU2qpNc366A5MD32f2R8ENP9CEOcjYDmNS
         47u3+pWNEaMMw==
Message-ID: <954b051546fe936db16353fc58a68438.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230421-clk-v3-2-9ff79e7e7fed@outlook.com>
References: <20230421-clk-v3-0-9ff79e7e7fed@outlook.com> <20230421-clk-v3-2-9ff79e7e7fed@outlook.com>
Subject: Re: [PATCH v3 2/2] clk: tests: Add missing test cases for mux determine_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Xiwen <forbidden405@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>,
        forbidden405@outlook.com
Date:   Tue, 02 May 2023 20:08:03 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Xiwen via B4 Relay (2023-04-26 12:34:17)
> diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
> index f9a5c2964c65d..4f7f9a964637a 100644
> --- a/drivers/clk/clk_test.c
> +++ b/drivers/clk/clk_test.c
> @@ -2194,7 +2194,47 @@ static void clk_leaf_mux_set_rate_parent_test_exit=
(struct kunit *test)
>   * parent, the rate request structure returned by __clk_determine_rate
>   * is sane and will be what we expect.
>   */
> -static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *te=
st)

Just leave this one alone and put the other test cases right after it.
Don't rename it and also move it lower down. It makes the diff hard to
read.

> +static void clk_leaf_mux_set_rate_parent_determine_rate_case1(struct kun=
it *test)

Please add a comment above each test case like there is for
clk_leaf_mux_set_rate_parent_determine_rate() that describes what is
being tested.

> +{
> +       struct clk_leaf_mux_ctx *ctx =3D test->priv;
> +       struct clk_hw *hw =3D &ctx->hw;
> +       struct clk *clk =3D clk_hw_get_clk(hw, NULL);
> +       struct clk_rate_request req;
> +       unsigned long rate;
> +       int ret;
> +
> +       rate =3D clk_get_rate(clk);
> +       KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
> +
> +       clk_hw_init_rate_request(hw, &req, 0);
> +
> +       ret =3D __clk_determine_rate(hw, &req);
> +       KUNIT_ASSERT_EQ(test, ret, -EINVAL);
> +
> +       clk_put(clk);
> +}
> +
> +static void clk_leaf_mux_set_rate_parent_determine_rate_case2(struct kun=
it *test)
> +{
> +       struct clk_leaf_mux_ctx *ctx =3D test->priv;
> +       struct clk_hw *hw =3D &ctx->hw;
> +       struct clk *clk =3D clk_hw_get_clk(hw, NULL);
> +       struct clk_rate_request req;
> +       unsigned long rate;
> +       int ret;
> +
> +       rate =3D clk_get_rate(clk);
> +       KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
> +
> +       clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_INIT_RATE);
> +
> +       ret =3D __clk_determine_rate(hw, &req);
> +       KUNIT_ASSERT_EQ(test, ret, -EINVAL);

There should be some KUNIT_EXPECT statement in each test.

> +
> +       clk_put(clk);
> +}
> +
> +static void clk_leaf_mux_set_rate_parent_determine_rate_case3(struct kun=
it *test)
>  {
>         struct clk_leaf_mux_ctx *ctx =3D test->priv;
>         struct clk_hw *hw =3D &ctx->hw;
> @@ -2218,8 +2258,95 @@ static void clk_leaf_mux_set_rate_parent_determine=
_rate(struct kunit *test)
>         clk_put(clk);
>  }
> =20
> +static void clk_leaf_mux_set_rate_parent_determine_rate_case4(struct kun=
it *test)
> +{
> +       struct clk_leaf_mux_ctx *ctx =3D test->priv;
> +       struct clk_hw *hw =3D &ctx->hw;
> +       struct clk *clk =3D clk_hw_get_clk(hw, NULL);
> +       struct clk_rate_request req;
> +       unsigned long rate;
> +       int ret;
> +
> +       rate =3D clk_get_rate(clk);
> +       KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
> +
> +       clk_hw_init_rate_request(hw, &req, (DUMMY_CLOCK_RATE_1 + DUMMY_CL=
OCK_RATE_2) / 2);
> +
> +       ret =3D __clk_determine_rate(hw, &req);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_1);
> +       KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_1);
> +       KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
> +
> +       clk_put(clk);
> +}
> +
> +static void clk_leaf_mux_set_rate_parent_determine_rate_case5(struct kun=
it *test)
> +{
> +       struct clk_leaf_mux_ctx *ctx =3D test->priv;
> +       struct clk_hw *hw =3D &ctx->hw;
> +       struct clk *clk =3D clk_hw_get_clk(hw, NULL);
> +       struct clk_rate_request req;
> +       unsigned long rate;
> +       int ret;
> +
> +       rate =3D clk_get_rate(clk);
> +       KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
> +
> +       clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_RATE_2 + 100000);
> +
> +       ret =3D __clk_determine_rate(hw, &req);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_2);
> +       KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_2);
> +       KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
> +
> +       clk_put(clk);
> +}
> +
> +static void clk_leaf_mux_set_rate_parent_determine_rate_case6(struct kun=
it *test)
> +{
> +       struct clk_leaf_mux_ctx *ctx =3D test->priv;
> +       struct clk_hw *hw =3D &ctx->hw;
> +       struct clk *clk =3D clk_hw_get_clk(hw, NULL);
> +       struct clk_rate_request req;
> +       unsigned long rate;
> +       int ret;
> +
> +       rate =3D clk_get_rate(clk);
> +       KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
> +
> +       clk_hw_init_rate_request(hw, &req, ULONG_MAX);
> +
> +       ret =3D __clk_determine_rate(hw, &req);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_2);
> +       KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_2);
> +       KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
> +
> +       clk_put(clk);
> +}
> +
> +/* We test 6 cases here:
> + * 1. The requested rate is 0;
> + * 2. The requested rate is not 0 but lower than any rate that parents c=
ould offer;
> + * 3. The requested rate is exactly one of the parents' clock rate;
> + * 4. The requested rate is between the lowest clock rate and the highes=
t clock rate that the parents could offer;
> + * 5. The requested rate is larger than all rates that parents could off=
er;
> + * 6. The requested rate is ULONG_MAX.
> + *
> + * Hopefully they covered all cases.
> + */

Please remove this comment and name the cases better.

>  static struct kunit_case clk_leaf_mux_set_rate_parent_test_cases[] =3D {
> -       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate),
> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case1),

Maybe call it clk_leaf_mux_determine_rate_request_zero?

> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case2),

clk_leaf_mux_determine_rate_lower_than_parents_fails

> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case3),

clk_leaf_mux_determine_rate_exactly_parent1

> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case4),

I'm not sure I understand what is being tested in this case. Are we
testing that __clk_determine_rate() with a rate between parent0 and
parent1 picks parent1?

> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case5),

clk_leaf_mux_determine_rate_larger_than_parents

> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case6),

clk_leaf_mux_determine_rate_ULONG_MAX_picks_parent1
