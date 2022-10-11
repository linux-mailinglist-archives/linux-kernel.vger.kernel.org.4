Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AD5FBE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJKXcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJKXce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:32:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF67A344F;
        Tue, 11 Oct 2022 16:32:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnBs64hymz4xGj;
        Wed, 12 Oct 2022 10:32:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665531147;
        bh=x+Eov3eRwg7TSgwoiQwZSVfI7w+4NiORozuvJ9NhAlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uHZtas+aMxhpn+qMhzdq2xmL2ejCX5Ke882xadn9fZILU6Sv58f7GLevm5Gq7PEFO
         1qd1sUQjKvK1wGYD+YjAeD9/ktYfTCeFGcz3K2VTzREmuQiyEUtfXo/e3BomqQcJa/
         Vfy4VAafZfaheyBYvEmzwE3VtvdW6Onfhr1v9G4vUsT+Zi522mQwl1FpzfHC8rQWDQ
         MtJZ05E75UOUvd5tuAR9oe5wyqvBMpxW7XEbcj0SfYvmNbYNuMQW3Rc82a29/UUoLN
         RWdUnKfXw13WcZvrylWmX1WEr2cEuwDOTQ61kRhjpZG9oEuF5lQm2u/tgsgV5GRltS
         508KWJwCy8phw==
Date:   Wed, 12 Oct 2022 08:46:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bitmap tree with the random
 tree
Message-ID: <20221012084611.53852c92@canb.auug.org.au>
In-Reply-To: <20221007161411.731900ea@canb.auug.org.au>
References: <20221007161411.731900ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5syZWPfTHPSEH.=wYfNFEbl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5syZWPfTHPSEH.=wYfNFEbl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 7 Oct 2022 16:14:11 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the bitmap tree got a conflict in:
>=20
>   include/linux/nodemask.h
>=20
> between commit:
>=20
>   82f33a32b4d2 ("treewide: use prandom_u32_max() when possible")
>=20
> from the random tree and commit:
>=20
>   97848c10f9f8 ("lib/bitmap: remove bitmap_ord_to_pos")
>=20
> from the bitmap tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc include/linux/nodemask.h
> index 66ee9b4b7925,0c45fb066caa..000000000000
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@@ -508,8 -508,7 +508,7 @@@ static inline int node_random(const nod
>  =20
>   	w =3D nodes_weight(*maskp);
>   	if (w)
> - 		bit =3D bitmap_ord_to_pos(maskp->bits,
> - 			prandom_u32_max(w), MAX_NUMNODES);
>  -		bit =3D find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w);
> ++		bit =3D find_nth_bit(maskp->bits, MAX_NUMNODES, prandom_u32_max(w));
>   	return bit;
>   #else
>   	return 0;

This is now a conflict between the random tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/5syZWPfTHPSEH.=wYfNFEbl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNF5CMACgkQAVBC80lX
0GwEbAf+LQapnjSWPK1HNUTZuyc4u80gSj/Riyi7ppuxfeauIrQ9V3cHywMbVxxK
Tni2exuyTr1LDEHVQmD3+BmbdDIEWS3tNzvABYTb2Mgc/BShY36HmhGmuBbJME3y
gxNPpo1lmwXo2FEEQAzcTlR623B8TwUhvXYsMeGcnoyN1TfNXzSSgjs4RIrKRoYk
8R1Fh8sljfy1mIamPk6IgtYn+rStWzqbxHPYOjSgnyW/xcaxDtP5hBEKGy58Ob0h
vatR2vVssNjUBIivgHWvWfiZ6AEVfZQU5kczpk4ItGd6zOn2V0zDNlJ9hxbHVr02
C2d+b2vF2bHmBQk2fEQB8S+mN82IdA==
=1McD
-----END PGP SIGNATURE-----

--Sig_/5syZWPfTHPSEH.=wYfNFEbl--
