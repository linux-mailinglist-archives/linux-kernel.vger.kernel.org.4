Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38056711A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjEYXBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjEYXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:01:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7570194;
        Thu, 25 May 2023 16:01:28 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E675166032BE;
        Fri, 26 May 2023 00:01:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685055687;
        bh=4Mji/tVJEhy+99y3+UaKpEsXd7MFjzEF3KJK23IqH+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LHnBw0KSuRmKkHfn3/DJzQgi12/tpWjyDflZfhOKKDqW4NYpYxKK21V08eJnOKiWn
         e0g5AnapXrVDEIES/nTWZBsZ9BI0bHcZQiJhNa62rOBCKCuo59d4kHTj9oVu1cwIE7
         BwDJMi9Nwat4GG0l8Ruew000sxjy9Unyp2K3F3UGD9hwjQ7uU1vnhl9SODlO/06hXg
         sWVssv8OEhuvI6j65fLC31ram1m+SYHtRuc1MRx9ED5zQ4v1ehaYanXjX5OwOjY6QG
         D/DBm5HXgcajHnBbnicXUjiT+f7ud0Bm3pL39Tl1VrKYLWn8JmsDYuwyafT03hRtaJ
         e3AB95Qk5wHhg==
Received: by mercury (Postfix, from userid 1000)
        id B43181060A3F; Fri, 26 May 2023 01:01:24 +0200 (CEST)
Date:   Fri, 26 May 2023 01:01:24 +0200
From:   'Sebastian Reichel' <sebastian.reichel@collabora.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v1 2/2] clk: divider: Properly handle rates exceeding
 UINT_MAX
Message-ID: <20230525230124.zj5frkpynnnfecw6@mercury.elektranox.org>
References: <20230519190522.194729-1-sebastian.reichel@collabora.com>
 <20230519190522.194729-3-sebastian.reichel@collabora.com>
 <1b74d2ea2c3a458694c4c74f2381fcab@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kza6lpa52hxd2e5z"
Content-Disposition: inline
In-Reply-To: <1b74d2ea2c3a458694c4c74f2381fcab@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kza6lpa52hxd2e5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 22, 2023 at 08:18:53AM +0000, David Laight wrote:
> From: Sebastian Reichel
> > Sent: 19 May 2023 20:05
> >=20
> > Requesting rates exceeding UINT_MAX (so roughly 4.3 GHz) results
> > in very small rate being chosen instead of very high ones, since
> > DIV_ROUND_UP_ULL takes a 32 bit integer as second argument.
> >=20
> > Correct this by using DIV64_U64_ROUND_UP instead, which takes proper
> > 64 bit values for dividend and divisor.
>=20
> This doesn't look right on 32-bit architectures.
> While you really don't want to be doing full 64bit divides
> there is also the problem that any input values over 4.3Ghz
> have already been masked.
> In the values can be over 4.3GHz then the function arguments
> need to be 64bit - not long.

The common clock framework uses 'unsigned long' for clock rates
everywhere, so it's limited to ~4.3 GHz on 32-bit. I guess it does
not really matter - at least I don't expect new 32-bit platforms
with such high clock rates. Considering Intel and AMD already reach
5 GHz boost rates nowadays this is definetly not true for 64-bit.

The current function does (u64 / u32), so it's wrong on 32-bit
(rate can never be bigger than u32, so the u64 is useless) and
also wrong on 64-bit architectures (second argument may be bigger
than u32).

I will prepare a v2 using DIV_ROUND_UP(), which should improve the
performance on 32-bit and fix the bug on 64-bit architectures.

-- Sebastian

> 	David
>=20
> > Note, that this is usually not an issue. ULONG_MAX sets the lower
> > 32 bits and thus effectively requests UINT_MAX. On most platforms
> > that is good enough. To trigger a real bug one of the following
> > conditions must be met:
> >=20
> >  * A parent clock with more than 8.5 GHz is available
> >  * Instead of ULONG_MAX a specific frequency like 4.3 GHz is
> >    requested. That would end up becoming 5 MHz instead :)
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/clk/clk-divider.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index a2c2b5203b0a..dddaaf0f9d25 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -220,7 +220,7 @@ static int _div_round_up(const struct clk_div_table=
 *table,
> >  			 unsigned long parent_rate, unsigned long rate,
> >  			 unsigned long flags)
> >  {
> > -	int div =3D DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> > +	int div =3D DIV64_U64_ROUND_UP(parent_rate, rate);
> >=20
> >  	if (flags & CLK_DIVIDER_POWER_OF_TWO)
> >  		div =3D __roundup_pow_of_two(div);
> > @@ -237,7 +237,7 @@ static int _div_round_closest(const struct clk_div_=
table *table,
> >  	int up, down;
> >  	unsigned long up_rate, down_rate;
> >=20
> > -	up =3D DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> > +	up =3D DIV64_U64_ROUND_UP(parent_rate, rate);
> >  	down =3D parent_rate / rate;
> >=20
> >  	if (flags & CLK_DIVIDER_POWER_OF_TWO) {
> > @@ -473,7 +473,7 @@ int divider_get_val(unsigned long rate, unsigned lo=
ng parent_rate,
> >  {
> >  	unsigned int div, value;
> >=20
> > -	div =3D DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> > +	div =3D DIV64_U64_ROUND_UP(parent_rate, rate);
> >=20
> >  	if (!_is_valid_div(table, div, flags))
> >  		return -EINVAL;
> > --
> > 2.39.2
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>=20

--kza6lpa52hxd2e5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRv6LoACgkQ2O7X88g7
+pqBZxAAo2Mt27gtCMiHbEGUAHvFcYxWyZPbVO4t2h8B6fg1RcAIM+4sUTZlIxlC
XvMFFpCgcO2r3F/0zSPZK70i1/vGtOKFSyxJjR20V9koOwTfG808wuO5gIccFxVL
6FMJiGYQNXMT/+ByYfoEt39PQmpv9PsEuoL89eVuOjim9CUh/9qJiuQhMPOlDyiz
isxsFusZ4yqA+67bIvyPEBnsRTabntSUtNjAuc8TjCAHtF/YuBSaxipG1bnwj7jM
lR6oiImd9TNTLcoPoSYoz4iEAT+MmZ40U95DOcJVGx4DoFtLZMwzBbdiRErjqEBq
XGRVZJWHTRyCQyeb69xn0lbpIDo1aWqb2jsJmtgUW52AqvIzN96pHkEhTZi+iBn9
yKUvwnmMlZo7acsL/NmCG4IZq/Orqe0f+llPYUg6DSFb79ibUkrwDLyuDDbE73hV
LE2TcHJChv5DBlB4gvFH6xHV8zYomlYFvTgh4milqsZNN31CmpIG8CdmzNP/1kV2
LwjTW9gfG3YrYR2B1oad8n36HR7bEYf6zEPB1NqJjrUm1eydDFAkumsEms+v4CRF
3G1gc3r8yRCEhitslqBv9WapU7vQHColzCvMD2z7Cl3YqrqrExpyuiQSPMcRM3yi
PjtdcCudTwuE+sJylbYupDc8YnoLZStMbOJUY1WgVOaVrFrtRfU=
=nRAl
-----END PGP SIGNATURE-----

--kza6lpa52hxd2e5z--
