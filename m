Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A105E72D682
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbjFMAl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbjFMAly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE8A18C;
        Mon, 12 Jun 2023 17:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3164763040;
        Tue, 13 Jun 2023 00:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F3DC433EF;
        Tue, 13 Jun 2023 00:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686616912;
        bh=IGOhvvrK7l3Oz69XA9xF5ZiPQc6f/G4f6BMPJ4mch2s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GJudkHabtLu6OFRUL5JzRLU5TWjoivWYWB8ECu77Ar9yWUhnEw2ye1EoNkFVEeicO
         ecQa7AFs9l/mvV5w8VtQ2RsXmZbbYKyfRgxHxdnISHlWv/AyM+jPrDurIUkAyDbOEy
         Ltijmd/mpNwWktEjJaYBgQlmc2CXytH0JLhD/ft5m3ggMOUQw3rx1rfa+79KWvzEUi
         LRwQ6DHdD7/ox6UX4wCR6nYbAEABvoMMoAT1lbFbB5UpWaYdTgtDbI0Sfr/EWgFosZ
         TPyeOohOtAGFaoVGBtlkdeo45b/jQms2SPVpWKurIOSRtL051kegjtTiGE/jCGdGNz
         2tiXloXcKZ2aA==
Message-ID: <5e9e776db6628d02d7081292b81ab102.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230526171057.66876-3-sebastian.reichel@collabora.com>
References: <20230526171057.66876-1-sebastian.reichel@collabora.com> <20230526171057.66876-3-sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 2/2] clk: divider: Fix divisions
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
To:     Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Jun 2023 17:41:50 -0700
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

Quoting Sebastian Reichel (2023-05-26 10:10:57)
> The clock framework handles clock rates as "unsigned long", so u32 on
> 32-bit architectures and u64 on 64-bit architectures.
>=20
> The current code pointlessly casts the dividend to u64 on 32-bit
> architectures and thus pointlessly reducing the performance.

It looks like that was done to make the DIV_ROUND_UP() macro not
overflow the dividend on 32-bit machines (from 9556f9dad8f5):

  DIV_ROUND_UP(3000000000, 1500000000) =3D (3.0G + 1.5G - 1) / 1.5G
                                       =3D OVERFLOW / 1.5G

but I agree, the u64 cast is not necessary if DIV_ROUND_UP_ULL() is
used as that macro casts the dividend to unsigned long long anyway.

>=20
> On the other hand on 64-bit architectures the divisor is masked and only
> the lower 32-bit are used. Thus requesting a frequency >=3D 4.3GHz results
> in incorrect values. For example requesting 4300000000 (4.3 GHz) will
> effectively request ca. 5 MHz.

Nice catch. But I'm concerned that the case above is broken by changing
to DIV_ROUND_UP(). As this code is generic, I fear we'll have to change
this code that divides rates to use DIV64_U64_ROUND_UP() because we
don't know how large the rate is (i.e. it could be larger than 32-bits
on a 64-bit machine).

> Requesting clk_round_rate(clk, ULONG_MAX)
> is a bit of a special case, since that still returns correct values as
> long as the parent clock is below 8.5 GHz.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/clk/clk-divider.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index a2c2b5203b0a..c38e8aa60e54 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -220,7 +220,7 @@ static int _div_round_up(const struct clk_div_table *=
table,
>                          unsigned long parent_rate, unsigned long rate,
>                          unsigned long flags)
>  {
> -       int div =3D DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +       int div =3D DIV_ROUND_UP(parent_rate, rate);
> =20
>         if (flags & CLK_DIVIDER_POWER_OF_TWO)
>                 div =3D __roundup_pow_of_two(div);
> @@ -237,7 +237,7 @@ static int _div_round_closest(const struct clk_div_ta=
ble *table,
>         int up, down;
>         unsigned long up_rate, down_rate;
> =20
> -       up =3D DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +       up =3D DIV_ROUND_UP(parent_rate, rate);
>         down =3D parent_rate / rate;
> =20
>         if (flags & CLK_DIVIDER_POWER_OF_TWO) {
> @@ -473,7 +473,7 @@ int divider_get_val(unsigned long rate, unsigned long=
 parent_rate,
>  {
>         unsigned int div, value;
> =20
> -       div =3D DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +       div =3D DIV_ROUND_UP(parent_rate, rate);
> =20
>         if (!_is_valid_div(table, div, flags))
>                 return -EINVAL;

This is undoing parts of commit 9556f9dad8f5 ("clk: divider: handle
integer overflow when dividing large clock rates"). Please pair this
patch with extensive kunit tests in a new test suite clk-divider_test.c
file. I don't know if UML supports changing sizeof(long), but that would
be a cool feature to tease out these sorts of issues. I suppose we'll
just have to run the kunit tests on various architectures to cover the
possibilities.
