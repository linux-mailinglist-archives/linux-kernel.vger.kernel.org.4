Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE344610668
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiJ0X3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ0X3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:29:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422DA84E66;
        Thu, 27 Oct 2022 16:29:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D354662592;
        Thu, 27 Oct 2022 23:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F51DC43470;
        Thu, 27 Oct 2022 23:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666913354;
        bh=In80h+WJt7FLX3RgZ+Rp51fouTuAk82pTl0sB3fEyck=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NYAizZ2c/lUM5yvC5OJeYs4jM4o7V+d9kak9/XD8je4KQtIU16a1AR75rjSZpQweC
         oauXgrlxji6s5yblmfD5Z7RLfX8hllVLta02toWx1Md3jR60nTBbjrRlxJzacevP9a
         cApcuOQZl6ziCgOJ2N2Vi5dT2lwyS35xPO0zmJlauOLHb18AgpmlTorIe8xKBYFA8f
         6DCdz8YQWVtd7LIQUYjrwxp6tIAEfvJU+YRIvq13lycAjbv/SDuOPDvHEO2aMg81y+
         Bf+OQGRPdMxEg81F3zz2lxjdGwgvsIcgsFa9VCv/q0B8Ma+XdA+ZCnc44kgyVhRlJP
         kEdl03rSwCzBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Thu, 27 Oct 2022 16:29:12 -0700
User-Agent: alot/0.10
Message-Id: <20221027232914.2F51DC43470@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rasmus Villemoes (2022-09-28 05:41:08)
> We have an imx8mp-based board with an external gpio-triggered
> watchdog. Currently, we don't get to handle that in time before it
> resets the board.

How much time does your bootloader give you to pet the watchdog? Why is
the timeout short enough to trigger? Or is deferring probe slowing down
boot so significantly that boot times are bad?

>=20
> The probe of the watchdog device gets deferred because the SOC's GPIO
> controller is not yet ready, and the probe of that in turn gets deferred
> because its clock provider (namely, this driver) is not yet
> ready. Altogether, the watchdog does not get handled until the late
> initcall deferred_probe_initcall has made sure all leftover devices
> have been probed, and that's way too late.
>=20
> Aside from being necessary for our board, this also reduces total boot
> time because fewer device probes get deferred.

This is a game of whack-a-mole. If we decide to move device population
from DT (of_platform_default_populate_init) to device_initcall() level
we may run into a similar problem.

>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> It would probably be reasonable to do the same to the other imx8m* clk
> drivers, but I don't have any such hardware to test on.
>=20
>  drivers/clk/imx/clk-imx8mp.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index e89db568f5a8..9ddd39a664cc 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -734,7 +734,19 @@ static struct platform_driver imx8mp_clk_driver =3D {
>                 .of_match_table =3D imx8mp_clk_of_match,
>         },
>  };
> -module_platform_driver(imx8mp_clk_driver);
> +
> +static int __init imx8mp_clk_init(void)
> +{
> +       return platform_driver_register(&imx8mp_clk_driver);
> +}
> +arch_initcall(imx8mp_clk_init);

Furthermore, there isn't any comment about why this is arch_initcall
level. The next reader of this code can only assume why this was done or
go on a git archaeology dig to figure out that we're registering this
device early for some imx8mp-based board (is it upstream? What board is
it?). Please help people reading the code.
