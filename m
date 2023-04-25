Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0736EE85C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjDYTkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjDYTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:40:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DFB72A9;
        Tue, 25 Apr 2023 12:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FD4A62F1A;
        Tue, 25 Apr 2023 19:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF753C433EF;
        Tue, 25 Apr 2023 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682451607;
        bh=Hczjg8gabHTKMbmIrpK14iKiEOCpcJKvVfwQgwT6PCU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qeCDuXRLWhJm6NtR4wnUTktw/5ddrzmVKxdW5yZKSpok55Sn4yufOiXwnBfIzFAru
         FzRJCIB5JPk0Tpgk2VrkjnZyTixgKIhSABeTIQInDz1uLHJqrOVbq8W2xgI5bow+AH
         DOomaUs2vXv7y0pxd2Wy/11FO3/l/amo6J1c+CQdxIRAilBGzf1glH9Wh6v+eteZ8V
         VWncm6kxAik8P73Uhj+AfEUAnJ0p7+kn1MV7/kj5E4AjkQ4PNnoLGoxHuAPUeiNCpi
         j+/5xOz5Fl0aZqP/VTQEy9OpialdPvdUXFdmnhtyOp6hz3YxP6CMkOtLf0GMSv+f4f
         l3bJrtCzO92jA==
Message-ID: <e21b11a5cde982081d2782d339b7587a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230421-clk-v2-2-74c6cc2214d1@outlook.com>
References: <20230421-clk-v2-0-74c6cc2214d1@outlook.com> <20230421-clk-v2-2-74c6cc2214d1@outlook.com>
Subject: Re: [PATCH v2 2/2] clk: tests: Add missing test case for mux determine_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Xiwen <forbidden405@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>,
        forbidden405@outlook.com
Date:   Tue, 25 Apr 2023 12:40:04 -0700
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

Quoting Yang Xiwen via B4 Relay (2023-04-25 00:46:40)
> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> Add a missing test case for determine_rate implemented by mux. It tests
> the behavior of determine_rate when requesting a rate that none of the
> parents could give.
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/clk/clk_test.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
> index f9a5c2964c65d..9b1c90de90454 100644
> --- a/drivers/clk/clk_test.c
> +++ b/drivers/clk/clk_test.c
> @@ -2215,6 +2215,15 @@ static void clk_leaf_mux_set_rate_parent_determine=
_rate(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_2);
>         KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
> =20
> +       // Test a non-existant rate which none of the parents could give
> +       clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_INIT_RATE);
> +
> +       ret =3D __clk_determine_rate(hw, &req);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_1);
> +       KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_1);
> +       KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);

Please make an entire test case instead of modifying an existing test
case.
