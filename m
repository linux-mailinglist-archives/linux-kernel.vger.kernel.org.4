Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941BB5F5D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJEXFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJEXFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:05:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5A580482;
        Wed,  5 Oct 2022 16:05:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MjVY03zjzz4x1V;
        Thu,  6 Oct 2022 10:05:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665011142;
        bh=A0V5pjXxCzniBJ5+600GSJRFvqnZVvgBuAkokXMKh0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S/E18Dtowg3qgUS0/+smZMnJBZNFO1vQoNGji47aC8ysGFliaJtWpIkd7W3SI9/UI
         ga1dZivrbP6hxToMi92xebSF97WjYLsqERAGL1eGmnHXCsBb0YcsrdifLSg64tSJIJ
         VBvfdArlhFhnDcDGopG3l3kWWNYsiMXETYT6MFOKxHu7S8FcLDP9kckDm5QbvoyNKz
         Jn0PXcEnDYoH/VQpq4FnnS27sVPaRiv7U3M7CI7jmBjgMnXyD3TGmCOYmX+qBCl5zE
         wj96GFqSrsAhDWInLWblS+Cxv8JGHhfTRwCmMCohd52LGGBi1VWN20Abixyw/6a59S
         NZMVr8vuynQMg==
Date:   Thu, 6 Oct 2022 10:05:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Alex Helms <alexander.helms.jy@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the i2c tree
Message-ID: <20221006100537.4d788d1c@canb.auug.org.au>
In-Reply-To: <20221004112059.5677a13e@canb.auug.org.au>
References: <20221004112059.5677a13e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7l.EgzzU/ar/B.qBL9zV9BV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7l.EgzzU/ar/B.qBL9zV9BV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Oct 2022 11:20:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> After merging the i2c tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> drivers/clk/clk-versaclock7.c:1304:19: error: initialization of 'void (*)=
(struct i2c_client *)' from incompatible pointer type 'int (*)(struct i2c_c=
lient *)' [-Werror=3Dincompatible-pointer-types]
>  1304 |         .remove =3D vc7_remove,
>       |                   ^~~~~~~~~~
> drivers/clk/clk-versaclock7.c:1304:19: note: (near initialization for 'vc=
7_i2c_driver.remove')
>=20
> Caused by commit
>=20
>   48c5e98fedd9 ("clk: Renesas versaclock7 ccf device driver")
>=20
> from the clk tree interacting with commit
>=20
>   ed5c2f5fd10d ("i2c: Make remove callback return void")
>=20
> from the i2c tree.
>=20
> I have applied the following merge fix patch.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 4 Oct 2022 11:13:45 +1100
> Subject: [PATCH] clk: fix up for "i2c: Make remove callback return void"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/clk/clk-versaclock7.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/clk-versaclock7.c b/drivers/clk/clk-versaclock7.c
> index 050807cf971f..8e4f86e852aa 100644
> --- a/drivers/clk/clk-versaclock7.c
> +++ b/drivers/clk/clk-versaclock7.c
> @@ -1235,14 +1235,12 @@ static int vc7_probe(struct i2c_client *client)
>  	return ret;
>  }
> =20
> -static int vc7_remove(struct i2c_client *client)
> +static void vc7_remove(struct i2c_client *client)
>  {
>  	struct vc7_driver_data *vc7 =3D i2c_get_clientdata(client);
> =20
>  	of_clk_del_provider(client->dev.of_node);
>  	clk_unregister_fixed_rate(vc7->clk_apll.clk);
> -
> -	return 0;
>  }
> =20
>  static bool vc7_volatile_reg(struct device *dev, unsigned int reg)
> --=20
> 2.35.1

I have applied this patch to the merge of the clk tree today (since
Linus has merged the i2c tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/7l.EgzzU/ar/B.qBL9zV9BV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM+DcEACgkQAVBC80lX
0Gxvbgf/SCH5CJGi0C2IYUI8yNCzeMoAimRYHb4UjR0UB+pB6ACLfgoAfWXHhuXW
7J7WxTUzzGt+4d3DRDGic87Cx6fnK+KxlF1rVurT7882IC7r6HgiWYt1msvVjluQ
f2MXWLuV3kfaK8FlOOnO87rcW6O/SMb8Y7f0TAODWdp2n5nAnkI/MOmMpdow51ov
fumu8IPPxBsKIfxrdoCxqLRKX5Y144YP/zbeNqF8bSrDrr98SjhUwbGhvcUaxdVc
NaH0Me/DKKcN27BTLQVh3NXkS/fAsMjcW2tVyjBFEAHMv6OuEv2B1A8Mz/lOXHcB
oMEIos47NHD2k8XoyMisXWPBvBGB0w==
=9BoB
-----END PGP SIGNATURE-----

--Sig_/7l.EgzzU/ar/B.qBL9zV9BV--
