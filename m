Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25E972D58A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbjFMAKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbjFMAKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592D171D;
        Mon, 12 Jun 2023 17:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4B662E7C;
        Tue, 13 Jun 2023 00:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8D3C4339C;
        Tue, 13 Jun 2023 00:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686615037;
        bh=RkC7m+ef9MDtn7UWLvgRnRzmN0nJLRntkzJFcqy2vXw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FHxvRGIAxDoNvq/SN8C376t3jj5M5YeyBEnSBQEIePf8IYJ5O3iPXFYKxeH3zr9uc
         vTvrrwDc0P5Jpc+b4Xv4zRkSpfTlrT+fbRC3LRXKDJzxsS1YENK+dX5daB77WpijZG
         FriHbVFFPh2O1BFpdttS4cZaz+rsWidUolh1MUDZs9E9nhZo0EqzeetlNjKFiU7doB
         giVt0aYz3nY/pMQDBoxDlE6VjeykIwC26tsmtls+VY83CfjXl2YF+lf1z6vJfea96t
         l4/IAGDiGi1PPK1KMKROVYpk2Ss3p1x72lqDwT6iGL/JlrKRz99ZG4KudliXDOmNJZ
         WdTQNIRPk+4sg==
Message-ID: <2f3328c4be9db6feef2cc662ede70f92.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230526171057.66876-2-sebastian.reichel@collabora.com>
References: <20230526171057.66876-1-sebastian.reichel@collabora.com> <20230526171057.66876-2-sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 1/2] clk: composite: Fix handling of high clock rates
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, stable@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
To:     Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Jun 2023 17:10:35 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sebastian Reichel (2023-05-26 10:10:56)
> ULONG_MAX is used by a few drivers to figure out the highest available
> clock rate via clk_round_rate(clk, ULONG_MAX). Since abs() takes a
> signed value as input, the current logic effectively calculates with
> ULONG_MAX =3D -1, which results in the worst parent clock being chosen
> instead of the best one.
>=20
> For example on Rockchip RK3588 the eMMC driver tries to figure out
> the highest available clock rate. There are three parent clocks
> available resulting in the following rate diffs with the existing
> logic:
>=20
> GPLL:   abs(18446744073709551615 - 1188000000) =3D 1188000001
> CPLL:   abs(18446744073709551615 - 1500000000) =3D 1500000001
> XIN24M: abs(18446744073709551615 -   24000000) =3D   24000001

I had to read the abs() macro to understand this and also look at the
types for 'req->rate' and 'tmp_req.rate' (both are unsigned long) to
understand what's going on. I'm not sure I'd say that abs() takes the
input as a signed value. Instead, it converts the input to a signed type
to figure out if it should negate the value or not. The problem is the
subtraction result is larger than can fit in a signed long long on a
64-bit machine, so we can't use the macro at all if the type is unsigned
long and the sign bit is set.

>=20
> As a result the clock framework will promote a maximum supported
> clock rate of 24 MHz, even though 1.5GHz are possible. With the
> updated logic any casting between signed and unsigned is avoided
> and the numbers look like this instead:
>=20
> GPLL:   18446744073709551615 - 1188000000 =3D 18446744072521551615
> CPLL:   18446744073709551615 - 1500000000 =3D 18446744072209551615
> XIN24M: 18446744073709551615 -   24000000 =3D 18446744073685551615
>=20
> As a result the parent with the highest acceptable rate is chosen
> instead of the parent clock with the lowest one.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 49502408007b ("mmc: sdhci-of-dwcmshc: properly determine max clock=
 on Rockchip")
> Tested-by: Christopher Obbard <chris.obbard@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/clk/clk-composite.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index edfa94641bbf..66759fe28fad 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -119,7 +119,10 @@ static int clk_composite_determine_rate(struct clk_h=
w *hw,
>                         if (ret)
>                                 continue;
> =20
> -                       rate_diff =3D abs(req->rate - tmp_req.rate);
> +                       if (req->rate >=3D tmp_req.rate)
> +                               rate_diff =3D req->rate - tmp_req.rate;
> +                       else
> +                               rate_diff =3D tmp_req.rate - req->rate;

This problem is widespread

 $ git grep abs\(.*- -- drivers/clk/ | wc -l
 52

so we may have a bigger problem here. Maybe some sort of coccinelle
script or smatch checker can be written to look for abs() usage with an
unsigned long type or a subtraction expression. This may also be worse
after converting drivers to clk_hw_forward_rate_request() and
clk_hw_init_rate_request() because those set the rate to ULONG_MAX.
+Maxime for that as an FYI.

Maybe we need an abs_diff() macro instead, that checks the type and on
CONFIG_64BIT uses a conditional like above, but if it is a smaller type
then it just uses abs() on the expression because it knows the
difference will fit in the signed type conversion. I see that such a
macro exists in some drm driver, so maybe it can be promoted to
linux/math.h and then every grep hit above can use this macro instead.
Care to take that on?

Either way, I've applied this to clk-fixes as it is a regression. I'm
just worried that this problem is more extensive.
