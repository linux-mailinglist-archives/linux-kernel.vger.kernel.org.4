Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7457970A63E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 09:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjETH5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 03:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjETH5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 03:57:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9565E40;
        Sat, 20 May 2023 00:57:43 -0700 (PDT)
Received: from [IPv6:2a00:23c7:6883:e501:5580:8bf2:4bf2:e6a4] (unknown [IPv6:2a00:23c7:6883:e501:5580:8bf2:4bf2:e6a4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4DAB96605974;
        Sat, 20 May 2023 08:57:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684569462;
        bh=BI2J02PLbopbt5XA9JjbBhRrBn4bnsbA8yL+gwb0Vco=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=osrwvOkmzE9BarrlvSF6+uz+lBKMKO6j7cIhvvNLMusR2QEAh6KFXi03ZqEOHYzb+
         ygDDpXf7NU30qCIPCSdzkJRu0ZyQ/maGsoI+JnymBDOP36lmjIsdvw4cj4XRCJVttE
         t34260u+aT5lJpHn99Ei9UM5ICgigg5eLhLIXH7gaYmdUZrm1aI2AZltviBuIrb/YT
         xKJk9+frvP1LOtJlPBxPXucMAzIqQuV3ZM2IroVl7JFH+3MW++qE1wqSYAciiiupn+
         5m8plpqINvHkA9zPS9G1n30o0R12sfwRdP9cId7asbUfd/X6ZXNRp9zNy5LpTDPVwk
         jIFKADJMuDUhA==
Message-ID: <f4f5d85d24519367ec5e80a5d97f936a806dfcbb.camel@collabora.com>
Subject: Re: [PATCH v1 2/2] clk: divider: Properly handle rates exceeding
 UINT_MAX
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com
Date:   Sat, 20 May 2023 08:57:38 +0100
In-Reply-To: <20230519190522.194729-3-sebastian.reichel@collabora.com>
References: <20230519190522.194729-1-sebastian.reichel@collabora.com>
         <20230519190522.194729-3-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, 2023-05-19 at 21:05 +0200, Sebastian Reichel wrote:
> Requesting rates exceeding UINT_MAX (so roughly 4.3 GHz) results
> in very small rate being chosen instead of very high ones, since
> DIV_ROUND_UP_ULL takes a 32 bit integer as second argument.
>=20
> Correct this by using DIV64_U64_ROUND_UP instead, which takes proper
> 64 bit values for dividend and divisor.
>=20
> Note, that this is usually not an issue. ULONG_MAX sets the lower
> 32 bits and thus effectively requests UINT_MAX. On most platforms
> that is good enough. To trigger a real bug one of the following
> conditions must be met:
>=20
> =C2=A0* A parent clock with more than 8.5 GHz is available
> =C2=A0* Instead of ULONG_MAX a specific frequency like 4.3 GHz is
> =C2=A0=C2=A0 requested. That would end up becoming 5 MHz instead :)
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

This patch series fixes the error on Rockchip RK3588 on ROCK 5 Model B.

Tested-by: Christopher Obbard <chris.obbard@collabora.com>

> ---
> =C2=A0drivers/clk/clk-divider.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index a2c2b5203b0a..dddaaf0f9d25 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -220,7 +220,7 @@ static int _div_round_up(const struct clk_div_table *=
table,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 un=
signed long parent_rate, unsigned long rate,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 un=
signed long flags)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int div =3D DIV_ROUND_UP_ULL((=
u64)parent_rate, rate);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int div =3D DIV64_U64_ROUND_UP=
(parent_rate, rate);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & CLK_DIVIDER_P=
OWER_OF_TWO)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0div =3D __roundup_pow_of_two(div);
> @@ -237,7 +237,7 @@ static int _div_round_closest(const struct clk_div_ta=
ble *table,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int up, down;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long up_rate, do=
wn_rate;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0up =3D DIV_ROUND_UP_ULL((u64)p=
arent_rate, rate);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0up =3D DIV64_U64_ROUND_UP(pare=
nt_rate, rate);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0down =3D parent_rate / ra=
te;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & CLK_DIVIDER_P=
OWER_OF_TWO) {
> @@ -473,7 +473,7 @@ int divider_get_val(unsigned long rate, unsigned long=
 parent_rate,
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int div, value;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0div =3D DIV_ROUND_UP_ULL((u64)=
parent_rate, rate);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0div =3D DIV64_U64_ROUND_UP(par=
ent_rate, rate);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!_is_valid_div(table,=
 div, flags))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> --=20
> 2.39.2
>=20
>=20
